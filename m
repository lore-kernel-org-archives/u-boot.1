Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F9FC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 18:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABEA87A38;
	Mon,  8 Jan 2024 19:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gEszWdVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E78886E82; Mon,  8 Jan 2024 19:24:43 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C3087A36
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 19:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28b93b04446so543298a91.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704738280; x=1705343080; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N45jniLBTbDzl3TmiwFG3vcSoJpuM6mN138Yx7AQu/U=;
 b=gEszWdVA81hsIPWk+W3A8KaQeeyPHVlZIU7w1QjXdz2WPT/TbrPsLNOvD70J8qMhy3
 dpPvUQMtwP3pAmq1IgZjTVOJwb+w4tr1qaThP+kl55svaZ+H4zSOQYhUrVlnLJLkHX4V
 /BaCWfYFdVtmR0jZPL7RFUCrehnbcfPeS3Y8OQk4p5qrcW2zvoG16Q5zFrOGBMqiu1lv
 Nu67m0+TrYQyoh1NmifytROHVTUb2pM+2P7mc9d1B1oweAkdwRbSiNFIXL6pwuPf3mDi
 kpFGNI0cyPYCl3wfC4hapQ5dealMIhGGzcc4lWtLQxMz+za08iNJEuIcR54gr2JlzxjO
 cgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704738280; x=1705343080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N45jniLBTbDzl3TmiwFG3vcSoJpuM6mN138Yx7AQu/U=;
 b=IKsZJ/haunkKzzuNhxYsDF2Owsa6d7kNE3X5sMgYrBdjb8srPEljw9Fy37z8JJQuvu
 cKONEd5SFR5ULLV+0B6pmE6PgBsoRpwTZOup15NAwWMAotM4TPPwAO9kcnuEIXfPLEGX
 JxRt+Nj95w5+eDsAz/iMazqXgqYgaKYryIUcdriLUWaWZFEqXt9ULqPi0EmP74MGe/vn
 oEsaob5BeTmEmi7XOLrnIidNpbQx4sxoE2pI8DfDboWlxc/KKMD5eRpgCdKdLAmo/iyE
 l7AYrKHX8IPnm7wcpo2p+Ln9Bb3gbMYrwZeOZpVDsUN0ZaPcpaDd0CuSFmV4WPfxXtFJ
 cTfA==
X-Gm-Message-State: AOJu0Yz8VWTjBpCPlnDbepxAjmDJJyPH3UgSftJCUeQ4KBDz6+Fwq1sS
 OKMtsNqy4PNlE2E2dHbdHlOfHUxcPf2dP/eChT6TvOvQ
X-Google-Smtp-Source: AGHT+IHjG2fxqNHIda135C1CeSYAP9mW9VBuOZAzZFIehWDxOQKEyubsr40BmWcih2C3zBf3pGf4hpd5EAXpfFOQ0VY=
X-Received: by 2002:a17:90a:4bce:b0:28b:c60:8dd0 with SMTP id
 u14-20020a17090a4bce00b0028b0c608dd0mr5986723pjl.2.1704738279691; Mon, 08 Jan
 2024 10:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20240101210650.87314-1-marex@denx.de>
In-Reply-To: <20240101210650.87314-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 8 Jan 2024 15:24:28 -0300
Message-ID: <CAOMZO5BN-yp89gKGc-2=_0oakBQzw68zBLaQTcCTr-N-xNdjCQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Auto-detect PHY on Data Modul i.MX8M Mini/Plus
 eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>
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

On Mon, Jan 1, 2024 at 6:07=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Implement fdtdec_board_setup() auto-detection of ethernet PHY.
> This uses properties of the hardware and pull resistor placement.
>
> If GPIO1_16 RGMII_MDC is HIGH, then R530 (MX8MM eDM SBC) or
> R390 (MX8MP eDM SBC) is populated. R530 or R390 is populated
> only on boards with AR8031 PHY.
>
> If GPIO1_16 RGMII_MDC is LOW, then the in-SoM pull down is the
> dominant pull resistor. This is the case on boards with BCM54213PE
> PHY.
>
> In case AR8031 PHY is populated, the PHY MDIO address is 0, in
> case BCM54213PE PHY is populated, the PHY MDIO address is 1, the
> fdtdec_board_setup() is used to patch the correct address into
> the U-Boot control DT.
>
> Enable broadcom PHY support to support both PHYs.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
