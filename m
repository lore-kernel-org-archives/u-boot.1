Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DE7E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 12:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB0B89382;
	Mon,  9 Dec 2024 13:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eXRoXawu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B4189207; Mon,  9 Dec 2024 13:23:27 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC24E893F0
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 13:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5401bd6cdb7so1230838e87.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 04:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733747003; x=1734351803; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4C5cjp/hiKUILPxeJOd2W8UmR2mkKTYDCrEgikmfjTA=;
 b=eXRoXawuptmIKXlJjlxL8uq/uauZ4vAJxzigrE3aDONAqm8SDshIRkyqhEXnrm2dIu
 lgGdDLqsEL8InMIVVc15sH4ZzW4qme0HbrzJ/9oEPkvS7lVgpjcKvRJmx9wdFYABTaZ9
 JPKgb9TQ22PWIXF6BF9XfO8LN8+HBPbzH1pXEWf+udHsTGt4H1fLwuc799AVgIfbvg8u
 +pOQmm5EFxow3saPhlizce2tsAFO5I8dlqc0+359+KUX1Ubop8XjcZQnCfunlgKQT2hB
 SGf/DsNzxUxV3nvplb/V6ibtt1bsVjLfHVk7ohcTB0S7gRQ4C5RlzidXhNGd9v3871W6
 aYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747003; x=1734351803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4C5cjp/hiKUILPxeJOd2W8UmR2mkKTYDCrEgikmfjTA=;
 b=cSuhMYQ7TBjsiGSU5eJX//w5+UPuv8RDcpSAsPuLodoVPGPG7F7EpjLNgNL8i6HtuR
 nuXuFV07mYK6FyT+38tzVTc8GwPmQGKG7KKVDJ2gu6KlZgydX5HnQVh1CG0negTaR7H7
 H2O+4ufFZ121wt2FOyBzY5Fe50vQaudICTVtG7R9JjaOwH0X1R6xJzydFIjy65WEIxYf
 1mrVn4B7NyLISrpGQ6DxkDwBOhWSmsw++BvlSYmZYligfb6Qxh5Lp24sY7idB8L2cPa0
 3g/20PwrNtGwBwsnR4Juv+7hNz/VedFqNAMbVFJOrO1/JiFOgWE5EXsBHyjcaktdcahR
 bX3g==
X-Gm-Message-State: AOJu0YyJGtD6mavRvOV8byZYPGnzJ9VqRCodHQ8ikX4YkLZisnIMyupu
 KORgrkP9JPhLj7nK2top8+k9fj12KQSFjUpoV4X5Hq1ACPK8DFzLRtbJA/YE9ehsuncjVBbKXNi
 iz6Pvpxmf32jjQZzq8yN82mUPN2Y=
X-Gm-Gg: ASbGncvtVq2OhwvfghRNbitlgOLKQXz5sz9vamWq6KhItF6GLeyFprlKBt4HbY51nDV
 nvgg1XnEMWqB9JwhlxSTmj8J1DlA/Qr0Wr6SyahpnjWjHmtrE4ii48AhVpFNeLNw=
X-Google-Smtp-Source: AGHT+IG8vmeTyaWE5wvMyXeAWD9GVTQaqqIz0qC1OYJsmN5uFj09IfBuCwRC2Ef0dSY/jpwgXQHocuGL0D4hnulteZc=
X-Received: by 2002:a05:6512:3a96:b0:53f:f71:4d66 with SMTP id
 2adb3069b0e04-53f0f714ddfmr3006022e87.24.1733747002866; Mon, 09 Dec 2024
 04:23:22 -0800 (PST)
MIME-Version: 1.0
References: <20241206230420.54704-1-cniedermaier@dh-electronics.com>
In-Reply-To: <20241206230420.54704-1-cniedermaier@dh-electronics.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 9 Dec 2024 09:23:11 -0300
Message-ID: <CAOMZO5A7bQP9N+V9U+EKA_hTradkeh4Vq=htEbsq2+Dp575DFQ@mail.gmail.com>
Subject: Re: [PATCH V6 0/4] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marek Vasut <marex@denx.de>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
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

On Fri, Dec 6, 2024 at 8:05=E2=80=AFPM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
> that contains an additional write-lockable page called ID page, which
> is populated with a structure containing ethernet MAC addresses, DH
> item number and DH serial number.
>
> This patch series prepare the device tree of the DHCOM i.MX8MP for
> reading the EEPROM ID page. Add the reading of the content and set the
> correspondent environment variable. It also synchronize two serial
> number environment variable via callback functions and fixing recursive
> calling of them.
>
> To ensure that the environment callback functions work, this patch
> series depends on patch [1].
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20241120160135.28262=
-1-cniedermaier@dh-electronics.com/

Applied all to u-boot-imx/next, thanks.
