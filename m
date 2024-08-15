Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9377FC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 12:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DAA88A4B;
	Thu, 15 Aug 2024 14:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I58/r2s2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A80688A52; Thu, 15 Aug 2024 14:26:20 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C71A88800
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 14:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-530ad984f2dso150573e87.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723724777; x=1724329577; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGdfcaykFoVxYMHNUrg0KCMM37ZDSQHArdVg66vOkMM=;
 b=I58/r2s2rme3bF3coIjbAX1NpeWUXBwD+J42FlqYUAa1DffWPsC1krQ0/J854dx7BP
 0qd/6Rwzos+mFlcaf6xmGDRRY2OqICvZJxAaRht0OOxG4JYuyj5A0d9JenW9gxbAaqtU
 pXUI28Y/Saaml3LdK3fSIfbux9vdv6Hl22ALwLCJ0/YUOiihicEHNS4aG2HnDb6NLHo3
 0HFuvtrSBUWTq25XG3MyFl1Ox0COziTHP6GzVOpu3nRqoKOqtd4djMdAuHPW6TDxp0QU
 Wk0K4egKCWRXGQ8jFveerLL3PNKddzq4KRndOZwLFendptZa5LHZpq7wk3t5ftIJnq12
 YSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723724777; x=1724329577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGdfcaykFoVxYMHNUrg0KCMM37ZDSQHArdVg66vOkMM=;
 b=DpWvHG1gypOUnZb5LuBlkRqIlIvVedF19xrkviF654aDVzVsNN4J9WFas1sXKkDap1
 iOCOf7VClI15w9FnxYvfUxFkh2560biQ35VjYEMulcmlE3R0SR4akTAntXrO+PF1VygR
 w2k22nUf0/Sw0jyTcmY55C1a87rY0WXfc8y8yLYuxUdu9721ZK3i+Fs0xQH0suZewLn/
 vZB5mMJjO0A5yk7YKi04WBcTGoGvmbkbWfp9v2fokFko9TmSdzeNcd1lI9t+P1wdRUTL
 aY7RuWnLUGbK0RET4vheQ9UJvu2syoC4SlJVH427k9+E4QZb3gVs5rZGFVpDZMXqDKVH
 5EeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb2CSTb1Ay5PxCSOILkDc/FuUnIMtqIi1Iay2/Vx1pAawnSCESkuiowLVb7i/Fi5yyQog3XgFyqSlTOlYwTEO7Ei/Ueg==
X-Gm-Message-State: AOJu0Yz4hgMUPGPFdqK4M1KN4tyc1mKQuLQfQV7ZHQfM0i1PGleWWV4n
 03pzvuf1s2gls7WbQIZBIRQ0+cVgsRLgNzbRJ8zDp7amrZDSHms2f8XVKS8/KZdMKPFzjsL7q7n
 xdaKkX+hTPpWbV75/joEPmW4qi63WVQ==
X-Google-Smtp-Source: AGHT+IGRbQJzMk6TurcXvnS/wsFTP/06/0IdlAMBSG0C9p3EoRbkOWLREY2qse3FIfFmhCotOOADgKJHQV99LtWgtgE=
X-Received: by 2002:a05:6512:1383:b0:52e:ccf4:c5e2 with SMTP id
 2adb3069b0e04-5330a0a1f58mr867092e87.8.1723724777376; Thu, 15 Aug 2024
 05:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240809165332.1898756-1-lukma@denx.de>
In-Reply-To: <20240809165332.1898756-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 15 Aug 2024 09:26:06 -0300
Message-ID: <CAOMZO5CC82be_gd1KwrbkUk7yH2QQNeKb0XZq5+-5hayYKBOLQ@mail.gmail.com>
Subject: Re: [PATCH v4] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
To: Lukasz Majewski <lukma@denx.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Cem Tenruh <c.tenruh@phytec.de>, 
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>
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

On Fri, Aug 9, 2024 at 1:53=E2=80=AFPM Lukasz Majewski <lukma@denx.de> wrot=
e:
>
> This command allows easy update on SD card or eMMC of the flash.bin
> generated (with binman) during u-boot build.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
