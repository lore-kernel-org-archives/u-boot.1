Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A82C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 11:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B898118A;
	Thu, 27 Feb 2025 12:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kp3SC4i/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2DDB81100; Thu, 27 Feb 2025 12:30:00 +0100 (CET)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A621A81120
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 12:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-548409cd2a8so836216e87.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 03:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740655738; x=1741260538; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfIhGzwcbwfUX2ruFb1sj1zOplMv6upghUMD0omyfq0=;
 b=kp3SC4i/MXl2ieuIgXLj9Or1W1dALoNH5yGWR6a79KYBBYLI6f+3gBQoNopOymIUBY
 QOcvGZ15JWc4CE11ProtS7J7ABPod1AjPCYLFfz7PqjBgp1axPKaLPYSshd23ulbJUgB
 NGClnD94mAjvUzIPUi2CPHO9d+ic1GAf+WVctSvMpUQoNB5vz8H5OMQ4ZRQeMrjbcQip
 MJNylP23MhwVJ8ojT5Sv8aSjR3NRCEB4tM0ZYWifMfn+QKpnVhDVmWUBaxkpmoliQqqp
 YNMo1nGxjXHfilfHPWs565mnqfYUSti5L7ly+zZ9EQaoL9rIxa1LDEfTSCqbrQi71bu0
 Sttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740655738; x=1741260538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfIhGzwcbwfUX2ruFb1sj1zOplMv6upghUMD0omyfq0=;
 b=HXFUFM1XvksExBvZpnaD72MOS2pvNoCS7pPcU2CSY+jR5fp4V+Q4nzypNmDyZf52A+
 7v5qYAZeXzNDJskUYJ6Rds7XVaMgCb7ntNPypvIekHjYfVeyC2Cc9bTHq5JTB/Ee8u4z
 F9zoGjoDuN2dcaq+/cX5fD+K2q2f+FHAjGzy7mgm0YieQb+7IQuTa/GGk+KKIVu2HUQS
 wKwb6ewR/lOwZcSG9lQ2YG+jT/AOfJBhnlmi3vL1i96vSATMzXrEFxT3jSpVms4n8QYy
 nXphlDg1NAiPYCDgBy7BUsUKRSOf4WC/GxJjE5bD4t5xJ/fKBojI9MUnh59iY1vakq/o
 JPCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJQfPwPg3XkWpzRY2YrO5bb5Lk/JXUUNGwl78xon4tkMOi/z0QQOT8jW9GQImoVizMwCpJZ9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyBYXiyOzNOwqvsRV4fRi20x46UFHC/yVwjwoyaOK8eH9JtTCVD
 vHfMmc7vry+g2dvKUAKiM6hubmgAjUztjS22y03fQ4MwRH2yZ/tj+gEvIy04vYWltwF/1/Jib7w
 jA5druuMoq7PndXxl/iSwYs8753FMksHX
X-Gm-Gg: ASbGncuMNcigstoQTgtu9SPV/JdJZDOpoupsnDPxO18zZav4mPnhdpS5QA+e9DFCLEY
 YcNfKxEnea6lSN+9kMwLtru7/+o087duduYYyb6b6ehLgM76XYss4xXtsqxJLBNnyRqK0GDrs15
 fOXB25obpp9qBSjASX6EiNbsvav5oLAhf4OZQLXlI=
X-Google-Smtp-Source: AGHT+IFnSY/2HVPpYzxcD/kw5ylhyH1XcduL1Tt7ODiM1hhhT2BRxNf87fX/CsvQd+h4XiQUDv+ROm2IEIrOArraskM=
X-Received: by 2002:a05:6512:104b:b0:545:4cb:b25d with SMTP id
 2adb3069b0e04-548510d655cmr6371296e87.13.1740655737476; Thu, 27 Feb 2025
 03:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
 <20250218120559.451678-20-alice.guo@oss.nxp.com>
In-Reply-To: <20250218120559.451678-20-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 08:28:46 -0300
X-Gm-Features: AQ5f1JptoUH0EGeFodYncKYY2eRfAC-4v6rl1rcYz7_kgX78Ym-9NpgpGFNLFjs
Message-ID: <CAOMZO5BbTpQqqy13bVOgfm5HfQaVk7JUr2jBcqonqDDcThFJhw@mail.gmail.com>
Subject: Re: [PATCH v5 19/20] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: trini@konsulko.com, sbabic@denx.de, uboot-imx@nxp.com, lukma@denx.de, 
 seanga2@gmail.com, sjg@chromium.org, alpernebiyasak@gmail.com, marex@denx.de, 
 u-boot@lists.denx.de, tharvey@gateworks.com
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

Hi Alice,

On Tue, Feb 18, 2025 at 9:11=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:

> +config TARGET_IMX95_19X19_EVK
> +       bool "imx95_19x19_evk"
> +       select IMX95
> +       imply OF_UPSTREAM

The imx8m/imx93-evk boards have been converted to BOOTSTD.

Please convert imx95-evk too for consistency.
