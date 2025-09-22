Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6577CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC398349B;
	Mon, 22 Sep 2025 16:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ak6Q4Yvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685D583542; Mon, 22 Sep 2025 16:25:39 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76EAF83443
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5797c8612b4so4334027e87.2
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758551137; x=1759155937; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgV0M5qUtfUB0RAtr95njfBpaQ/yrVNr0hAHsJbZ6io=;
 b=Ak6Q4YvtbmET5SSIe29S9lYjz3zdG95UpyzGaOtRs0iEtw49plBbgPTtsPNyJUeRjZ
 kDQA2zQsj+Lk90wnE1JCMg8NdRrpswyp8s3sebAD20JqPcbkLplfXw7CoR4y2ltUf+5J
 Wx05IWg0OzrVWGjuqLVKHoLbNR1XHyeLO2EdjJDUQnuPONZJFRIJkOjLdpGen490YiNO
 IX5k8ct4VryiJbv/IRxN2BbcEu6rsGBcYg1ZsfLj3GFpF12LH6gdbWRn2Nw5kilBjVzQ
 eTF8c8hGKHf3Mr8Iqb5mkcDEGlOv0R4H1+cFqAVGkAumqpw3xFWtgxdC6KyyZgvKvyru
 HRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758551137; x=1759155937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgV0M5qUtfUB0RAtr95njfBpaQ/yrVNr0hAHsJbZ6io=;
 b=NhtzkVkozeSIa0miubYCumbg2yG1B3PnilMqA79XQ06PNG/I+r7Tp/aCHX+Xhe5Vsh
 ehifEHAqinMogrktIl5eHxMyigo6Mcdy4usjF+sT3Czx1IDGCS05ZA/4eHZ3vIemmzhz
 19zMAjP1evHNX3t5iqwSxzuu2bfAoS6b8QkAAHtAuTPbcGFb0OE+AUgwnywA/CZz5wMC
 bw23PUnY1rdSztRCNFNDCJc1IXYWJ002UR7duMvae8iJw3tbeYOzZCRCn5NnZBakFO87
 df8zzcr6f5ZSGV8SAkFnk9e/R9I6Khc5oN5mhJegUwa02GQ/cS2F9zVUmBca9/FMMu0j
 3zkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGu534NwkicSQ59uiiJRAXMuztbAyeO/aSN+ctPUvc9VulfnGW3MR7ty10AM8SkB5bYvLUyuI=@lists.denx.de
X-Gm-Message-State: AOJu0YyR+SQGxR1SYOroqz43N8C+AXyCJDLS6Y1WgvO14FFXX0Fi6cqn
 WKD4v8M1k5UOwL6aTG5BSLsgc2JlbpJxeXfE0tdm9ywDAmzDDCfrRG9v+LqvTBSyZH3R0aCpqMO
 jThzJro2bRfjaxtKbxxcVsZQ4m78NnkSBcQ==
X-Gm-Gg: ASbGnctdi8EyRxHnAZCkU0iwN12Y/eP20SQGr7B95uetyFAGn02O91AI1d8Wr5tR5He
 r8/j6mDmLW1galy70RPiuXpWHrxPI0vDE5jcHFoGy8Z+ivLelf4b8jCFOTQp5P1SzG6JZBg0m60
 6IEpXISuxk1RcPi8CyKnV/rJrUXXKsCuFJs/mH5iYHLfjWxO929lK3JTxQioXwa5aGvqDnxAsHc
 nKHeEmb2aXQDLd1jlcms5YQpgVthKWuM+aXJo4=
X-Google-Smtp-Source: AGHT+IGAPZTymnWvcbJ+mJ7rkuF1yRILvBuxuaapFCZzOXQ75bNwomRx4ZzqHRTwb+DQyNntCUqtK347r7jVAeBqKOg=
X-Received: by 2002:a05:6512:340c:b0:572:1f0b:5ef3 with SMTP id
 2adb3069b0e04-579e08b39b7mr4712874e87.11.1758551136400; Mon, 22 Sep 2025
 07:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250919075142.1674177-1-primoz.fiser@norik.com>
In-Reply-To: <20250919075142.1674177-1-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 11:25:24 -0300
X-Gm-Features: AS18NWBHzMWvlX31QkLHnWH49skBAI_2l_sjeIQ8fxfJgiISmc0nVRfD-tkzgQY
Message-ID: <CAOMZO5DkaPAkdZxyEq0gQz-d8BR8-feuL0mRL+e50SMrULDtzQ@mail.gmail.com>
Subject: Re: [PATCH] board: phytec: phycore-imx93: Fix i.MX93 voltage modes
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, Sep 19, 2025 at 4:51=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:
>
> Fix support for i.MX93 voltage modes on phyCORE-i.MX93 SoM boards.
>
> First of all, Kconfig option CONFIG_IMX9_LOW_DRIVE_MODE is gone since
> commit c9efcad23741 ("imx93_evk: Remove CONFIG_IMX9_LOW_DRIVE_MODE and
> ld defconfig") and was replaced by runtime detection mechanism. Thus
> lets use is_voltage_mode() instead of Kconfig to detect CPU type and
> select proper voltage mode.
>
> Secondly, 1400MHz ND mode (Nominal Drive) requiring 0.85V BUCK voltage
> was not supported with current power_init_board() PMIC settings. Add
> check also for this CPU type and set BUCK voltage accordingly.
>
> Last but not least, add printf() printouts about PMIC voltage mode to
> the console. This makes it more apparent and verbose about voltage mode
> in use. Also our internal tests depend on this printout to catch issues
> with i.MX93 CPU types and set PMIC voltage modes.
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied to -master, thanks.
