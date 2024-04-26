Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F61C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 01:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC89890DA;
	Fri, 26 Apr 2024 03:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SU6lf5ca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5B9890D0; Fri, 26 Apr 2024 03:56:07 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3FAA890DB
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 03:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-de59ec28b08so200449276.3
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 18:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714096564; x=1714701364; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6GrI0kOlYFcWtwvnhy/uZPLV7BEUzM7tI2mF/FzBhwI=;
 b=SU6lf5ca4uQp75ogHsjqkTF1R/C+Egk7YPz/zWdnB+myV1c44s6SanHYfT3uOjnY+T
 3L7dLP5wbXorc1zf49BXKs0JA9cNNympRDj2H+t/3qnuuWoi+8znzqDcB8eLFRqebUHF
 /EoTMumhUcSbMWm0jk1Ua6p/GcghRuRZlrVi6JnKF1tDFBn3rkpAeZY11UfYM/NTcbhg
 rVVSb/WKPXTBcXpqyjrpVY1SXx1e3aOLTpSr3U7EtxSnyfs4/hcI+/Kdhu3WcuvhrX2U
 5UAFy6hh07JEnmDni9mt2K+GZ8BlUNx+NLkQz9z7vqZcLYowPaQ20cYf52NKqLYszvU/
 rHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714096564; x=1714701364;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6GrI0kOlYFcWtwvnhy/uZPLV7BEUzM7tI2mF/FzBhwI=;
 b=PYTC14KkFzFoYFV61b/Mds7pcNfCwsmO0sZuhQw/JHmRYz5gb6II0KK+CrvqbTZ3Ei
 wIh4M+YmycQW8UHpyuVIWU4dV1VXARDeUPmmDMK/NfpqtLrVppvRrm7oOJeEIM08o0b2
 KaeIbj6O6UHiITmbbJlk1N29B0GwJQ/kepMpV4U3PTbVnx/PvdArO+QLqs19WeRkblyA
 QZQmeIuaGtw/pQH3JlOB0FOS9s745vdPa2sURg8DNjbCIxeSLixGVQcXfa4tzRIe2wXB
 92cc7mJtCCZR/TGxDI9zqZfbiI8YqHA76BYsgcNzNLQggMEOveWQUHm+GTbbkj4XwXSv
 DdzQ==
X-Gm-Message-State: AOJu0YyApod6MAT4rpaKGfDDE/bFyfWRoLCeyJ0X506+9oUCjDaH6XLS
 9JeiDwDEWSWLjLZxp47H5rbWyaNsy7fuXEq3Gi7DkK/LypW85MkD2uKId6WZhf8xdsm0hg/CD5w
 VpYL4iSNuOXVdBHxLfKPpQ+W957A=
X-Google-Smtp-Source: AGHT+IEN91tW7amWk47F48/X0lJshV5bUMllUbOjsCauldxzmYsgk3Cmt8JeeJ6ROZdYbWWDdczqVslCxByy2sozVk8=
X-Received: by 2002:a25:3623:0:b0:dcc:438e:cd98 with SMTP id
 d35-20020a253623000000b00dcc438ecd98mr1333807yba.0.1714096564118; Thu, 25 Apr
 2024 18:56:04 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Apr 2024 22:55:52 -0300
Message-ID: <CAOMZO5BeK7QyqEZisSVX=fs9jmq98gjnf_n0FrRJrR92pThrGQ@mail.gmail.com>
Subject: imx8mn: bootcount does not increment
To: Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Adam Ford <aford173@gmail.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

When enabling bootcount on the imx8mm-evk like this:

--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -120,3 +120,5 @@ CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ENV=y

It works as expected, and the "bootcount" environment variable gets
incremented after a reset.

However, if I try the same on an imx8mn_evk, the "bootcount" variable
always stays at 1 and never increments.

Do you happen to have any idea as to why imx8mn behaves differently in
this aspect?

Thanks,

Fabio Estevam
