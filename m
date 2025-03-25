Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94317C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 12:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DB928192A;
	Tue, 25 Mar 2025 13:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTrzT6hE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01B981B42; Tue, 25 Mar 2025 13:56:52 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB36C80EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 13:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-549644ae382so6962281e87.1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742907410; x=1743512210; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lY146X1+7dfD7Q0ravjmLOL86e98qJYAGJ19M4s9Zno=;
 b=bTrzT6hEjw5KsC0cneWtNKILVVUI89ALpdOQFO41DGD9vgjzFYSKTzevO0uUPLtssG
 SDowsQ+/IF2AnhPRh/CH7vDLOsMqM9y0Iqvg1vQ/QPkvZhyCaOaA5D7/K1/sRaCem7Us
 WlpC0w2cThehqGgR/vCJvTOadP9YInK2xazL8Uh9SyZHGQuPQEK2hl64SdcSIa81mWnU
 V/epa2OdTrYqhAm9nwE/cjYBz/6Eo1AqBWo5veNJxuIAYfTaXIA47ydBuO34GxmZ0gjN
 WXsGHKciAAUyT9l1t32Zg1nsHOoZyO+zwT8Xmax9yAiPBN4jMcORuhYIGLCE0aSdSRiu
 NXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907410; x=1743512210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lY146X1+7dfD7Q0ravjmLOL86e98qJYAGJ19M4s9Zno=;
 b=OD1S1SDgUvwefbXHrE/U80A2U1jKzdhnhEYBZLE/RIVn/ljVNhLuhsdxD5E5W9kIKv
 +eqaBZNz5+LOznGuSz3oVy99Wpa2gf/8cFLqccCYjFDWwupmULxpDz7IoFs53eXQiLMD
 RQ42U6A544DEndiJeJXdSmaxUv8yB4MwW4zf9lxyeAFaBFrS4N0B22c/nZPCnDSBWiRG
 sNc5siBuOK3+2kaXQ2SmRMUjUjph9fLNcROFhhr9u2SS588AMhkerAvDCPrr6prA9GhQ
 HogQIlqHNMgMrTsbY1Di+g2fNekjtP7PTMUHk3qSZjw+qQQcc+3GKQhANzCgW6vyiApF
 hW+g==
X-Gm-Message-State: AOJu0YxOlXb851IJRy6DeRTWeKhcuL5TC/J+z1pjqAw5zeLXw0zTxeuK
 8YEEKmITrv8X18j+xhrMSTkmqBNtHB0Pk+po1583lZVgp6EQltCH4DPYWCRpOW+L3huSJUsGHIb
 50suwXERiCePf3puj6+tfkVg6gac=
X-Gm-Gg: ASbGnctwTNJhQO0huVC/3LRWAD4hImnnDXaqQmeQLGZGUMzqUZf+i2ZZ5o49wWU46I/
 q3J1Qi9LaG9KRx8GJzhBaYdhf25Hu4tS07qyr6vURJheGFSK0KLs87YZ2u6x9utbTBKAVeZs/Rb
 FL6ukY/bmGhvOw2IEydofqGrVGaO6zA241wphA/Rh+QRfzIj4EIklBIyeu
X-Google-Smtp-Source: AGHT+IHKUOR787HeEzNxvi10wi0TTQc/3Xhk4LCuwJOhGRo2y5tar3zeZzfI78piFtGknUlhyLubIolrcqsFx1VNPjA=
X-Received: by 2002:a05:6512:1325:b0:545:cc2:accd with SMTP id
 2adb3069b0e04-54ad648549bmr6292989e87.20.1742907409934; Tue, 25 Mar 2025
 05:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250325025452.950303-1-aford173@gmail.com>
In-Reply-To: <20250325025452.950303-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 25 Mar 2025 09:56:38 -0300
X-Gm-Features: AQ5f1JqNsaATbuUrKGn0D7KL_iTVlXUNpbwQliStpjTZ2t3oMtm_tbj2XPmFNtY
Message-ID: <CAOMZO5Bcg8aryJ02tiAAcpmtMg1PttAvB5bPoST67PrY90oMjw@mail.gmail.com>
Subject: Re: [PATCH V4 0/7] Migrate IMX8, IMX8M and IMX9 to use imx8_cpu
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, marek.vasut@mailbox.org, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Ye Li <ye.li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Mon, Mar 24, 2025 at 11:55=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> The imx8_cpu driver uses the driver model to represent the processor
> cores in the dm tree as well as display the processor type and speed
> on boot.  Currently, the imx8_cpu driver only displays the temperature
> grade of the processor if the processor is IMX9, so in order to display
> that info, the check in imx8_cpu is changed to check for IMX_TMU
> and IMX_TMU is implied for IMX8, IMX8M and IMX9 SoC familes.  If
> users want to fall back to the older method to display the SoC type
> or remove the temperature grade information, they can.  Doing this
> at the SoC family level reduces the number of duplicated config options
> for each board, and was done at the request of the IMX U-Boot custodian.
>
> V4:  Make IMX9 select CPU_IMX instead of imply since it appears to be
>      required for all in the platform.
>      Fixed some whitespace in imx8_cpu around the temperature grade messa=
ge.
>      Re-ordered some items in Kconfig to keep them alphabetical
>      Added more CPU items to the list inside imx8_cpu to match what was d=
one
>      from arch/arm/mach-imx/cpu.c.

Applied to u-boot-imx/next, thanks.
