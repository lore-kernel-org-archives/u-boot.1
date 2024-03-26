Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86676CD11DD
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 11:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C899187D7F;
	Tue, 26 Mar 2024 12:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TJWcA3dp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F3E87FF2; Tue, 26 Mar 2024 12:06:10 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C0E98644E
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 12:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29f8ae4eae5so1071674a91.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 04:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711451167; x=1712055967; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mBMgs3A/r3hHrP65+QTEmQTdm3NUTWUYsu04aCYI+4=;
 b=TJWcA3dpzWEQzl8Td8MDQLeiC+TxooX7+fgNiGu2Hk0oz0xOk/UUIN8GUZNG/rPDaO
 NBnVyYPziJHaAh6KEmINdOwg3TQ9wYPIXFplDoWx+6paLFMWIY4fn/8b1DsHQdsYyZoS
 imzRJvSsJGwpnxRL6yp9Lg9zZkk8Mfh424QnS5wyqI80b8v3s7V+y4WTA8cGRTcXzj+G
 hAkFzabZEwn64Qv9wjeMRtAyt3vDmo99//cRPi+ofoy9nVTPo2AXj2b7cwwwodGKm8BD
 TX1/7Lh56IgslFt44r5Avl1dBzK19caRFEO2aaqVec2TIMLBE2cKSAQ5Aqhqcc333JVk
 3XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711451167; x=1712055967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mBMgs3A/r3hHrP65+QTEmQTdm3NUTWUYsu04aCYI+4=;
 b=nA7ZhLeWjva0k4Q22uX0tA1db7Un4NjaMlUvXkl2eCVKvzhpHGEhK1MDqh0Wyt4bO5
 brrOBiKT9+z2rZOa7sk9hGhtkabjeyijYPAU1Z9rqe2Fii67P+0dwM6siM6uyOLoc1zF
 qUQbdAHPCNfzbrbjZHhTQH9iu7zrB5ZPSUkgHl1PsKFNbpS9FozygDSyYp6v1ESyQxxZ
 xKE1rhjGkNaCzunPG/6+xWDkOXc25k0zbi0x53In0lgCRrNOMVM1ApiL0jp1lJw9i+57
 2jFYzNbiE/JShxGA3tgxqov5CgCnvBUjkRd31MwzI38zB/IuVMxosf5Z1fxV0gDTtPse
 3k+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8anvxjAq0foqL0XapKPPPOOoQEIDzLNMs6UhYwGgpq66hmC6owdXi5jHHHWqxkDdU3JRrXwz4X1TWTB4+D8Z925Fmbw==
X-Gm-Message-State: AOJu0YzvL2AOCsk4putAauzxv++Uzaw257KDzyZ5UtvtWIZovvHDGgep
 yskTDCJuiFTexuuxwNl5Ynd3SwxNVRXffF7pnw8iV80+Mtu612B1rvcb+LlFm4HFufXzMekO7NO
 CWBlg6NwVI4FOd0J+Y95MF+H+KBrNHxN9H6A=
X-Google-Smtp-Source: AGHT+IGX77+h6KfEwH8rvXU/+DVlY7RbL39IKr/cbnwgyTMQZTlN2Pe6FDTSxEh5SH8Kh2k5EcWxKicBaZzGvy/9beE=
X-Received: by 2002:a17:90a:b395:b0:2a0:350a:a7a8 with SMTP id
 e21-20020a17090ab39500b002a0350aa7a8mr8140895pjr.2.1711451166749; Tue, 26 Mar
 2024 04:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240322114315.2720727-1-lukma@denx.de>
 <CAOMZO5Cgjy6huSfX_gpd+UQB-xZN6vKJv-=sLE1QL38jCgUUeg@mail.gmail.com>
 <20240325094812.480d23c8@wsk>
In-Reply-To: <20240325094812.480d23c8@wsk>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Mar 2024 08:05:55 -0300
Message-ID: <CAOMZO5A-hSn9qQ2WkdBLQFPhSb4KxfAw=z9sMyVHKjxBeo8Vzw@mail.gmail.com>
Subject: Re: [PATCH 00/12] arm: xea: Provide support for different XEA board
 HW versions
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de, 
 Anatolij Gustschin <agust@denx.de>,
 Christian Hewitt <christianshewitt@gmail.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, 
 Mathieu Othacehe <othacehe@gnu.org>, Michal Simek <michal.simek@amd.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Lukasz,

On Mon, Mar 25, 2024 at 5:48=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> The case here is that I'm modifying the *-u-boot.dts{i} files only. In

The diff below shows that you are creating imx28-xea-1.dts and imx28-xea-2.=
dts
for U-Boot consumption and renaming the upstream imx28-xea.dts to imx28-xea=
.dts.

create mode 100644 arch/arm/dts/imx28-xea-1.dts
create mode 100644 arch/arm/dts/imx28-xea-2-u-boot.dtsi
create mode 100644 arch/arm/dts/imx28-xea-2.dts
rename arch/arm/dts/{imx28-xea.dts =3D> imx28-xea.dtsi} (100%)

> other words, u-boot will not support features described in Linux DTS.

That's OK and this happens frequently.

For example, upstream devicetree may describes audio codec,
but U-Boot does not support audio playback.

Devicetree should be OS agnostic.

In U-Boot, we want to re-use the upstream Linux devicetree files 'as-is'.

Adding -u-boot.dtsi files is OK though.

Can you convert the imx28-xea board to OF_UPSTREAM available in the
U-Boot next branch?

> Hence, the rename of files (which would be in sync with Linux at some
> point) looks like not related to Linux DTS (as even after re-sync with
> upstream Linux those changes will not be in Linux DTS).

I did not understand this part, do you mean that Linux will also do the
imx28-xea.dts =3D> imx28-xea.dtsi rename and will also have the new
imx28-xea-1.dts and imx28-xea-2.dts?

Regards,

Fabio Estevam
