Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48B7C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 19:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 434478642A;
	Wed,  3 Jan 2024 20:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UxeTTVNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E63E876FF; Wed,  3 Jan 2024 20:34:14 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02CEF8642A
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 20:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28c5af37d3aso1910554a91.0
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 11:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704310450; x=1704915250; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yJzZ0tPMTKnvL754S6om2jpO8Eu2/OkU2Fye29bAhc=;
 b=UxeTTVNtJZ0/FRxT9kb/8mBc6RHreNReEUMSgR+Igi+9ROuJ98RZtd0KHoaDf4OpkX
 9LtUTC95T74uOQTApbzrBiisJKGP+NtRYW/lVTBBwFk+2I9Qytwtg9LZfkRRyDoJgwaW
 4yfhKbRZXKYZ1+KFR9bs0XqAYcsZLMdfdeok1f4NkJUrX5pwXdCesNkO+12l1gTziqK3
 ji3r6HjJ/yoVRcJCq51f1YCJn8PmCFWjzVbhji2ARfPeupIXxe15gNrPt/nNMth4hmcW
 qGJO6oFD1ZAxfq0iNUsO0ELIPRG7RBt4peGTKLu5kxzu20cf0SNSsURvdsWdj4vhipVM
 ytOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704310450; x=1704915250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yJzZ0tPMTKnvL754S6om2jpO8Eu2/OkU2Fye29bAhc=;
 b=l+XUqQQ2/c36fMzv1sBIkadSRoSY9XWQMqvkgjxBYtHAj9jRWwPtyegYND3SHcbjeM
 zB0Pp7NBfGOMDl9j0zO2AVaKmR/X2yPinmqsoKdCbOvDa+oXIdAjcKWtc35UJ7qJtAZc
 QVXfPcC6nF5CFJ5EWvQ1aHY+9M1dR8Xdd1Zt+Sj7N1qJp6pNCZsW6XQAPaD9LNrcQlcJ
 rAIGd1KdSa9CLHOQjiwGaziTP31EWEcGmezIblYHCzAMBzgWHB/NNjB3QGyo6HDNOXfI
 cADdlH1rTuarypBb7RZ+zzpHhL44mMdQdp+g+AyQCImxkJQ/+DwPWHebX8dm0sl6wg6m
 7q1Q==
X-Gm-Message-State: AOJu0Yy2thFmos/bMkhCJUvT2igNEvf8CVElXpD80KACo4uu4uBO0dr4
 HHYF0xSJXwk/7FLbr/egJk9mqe9OmiUJYWnV3wI=
X-Google-Smtp-Source: AGHT+IFEBEJ5OAph2MwF/MHJUllcU7nmwxl+2r2rQTL0cHphUpZ3BfeCvsD8niSHZY38hkU8orSgQx7AjQCtIZXD0NY=
X-Received: by 2002:a17:90a:e0f:b0:28c:5a9:de71 with SMTP id
 v15-20020a17090a0e0f00b0028c05a9de71mr29037486pje.4.1704310450306; Wed, 03
 Jan 2024 11:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20240101210650.87314-1-marex@denx.de>
In-Reply-To: <20240101210650.87314-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Jan 2024 16:33:58 -0300
Message-ID: <CAOMZO5DrGUzmoxF4gGH-zVdRDLEBfdnJeWyzrA9GeJydL5aYOA@mail.gmail.com>
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

Reviewed-by: Fabio Estevam <festevam@gmail.com>
