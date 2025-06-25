Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9F7C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 02:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B576482B18;
	Wed, 25 Jun 2025 04:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b7b04qTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4384882977; Wed, 25 Jun 2025 04:19:04 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2846282B18
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 04:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-553b3316160so4651175e87.2
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 19:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750817941; x=1751422741; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUB8suOxkM4jOsBmH2Jr4ep8bAsU1x2kuJa+5V7QQT0=;
 b=b7b04qTFsx5qkleCiaKgnWosedfCWOP16Zv1T3FXu+YaT+xnGzkLFYhtJdp0uC2M0e
 EKSp0wtF0ZPQemrTdTisc+8MWt74k/t4ZncIkfIn0DOEiRk6KMbNthRz1US1sN2QCCkB
 NwNAtFu6tf7iokiHsUqx//b61uGHJvO+chkLGi6ZUS1eIAaED58p/qhmGsOL2MUzlsSa
 goxw8aEfU7zfzK/7lbl7PfLev7czN8AWq8EHvEUiDA5qqJ7ll5q8dY5MEZqSA5sMD6XS
 1K9C07md4v2QcZEbPAxt9CaFF9O31/bPXu83p3CGkan6EEJ21dJI4aCyXKiyC+iZ+Rwx
 mQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750817941; x=1751422741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUB8suOxkM4jOsBmH2Jr4ep8bAsU1x2kuJa+5V7QQT0=;
 b=ivPORe/LExfEZAag9yIEGp+HEXSceeTGQI2Y1oVixc3zcR7k0Dg7GAZ5gCfdyi/K/p
 IZlRkZ1qFoWlxLxXd/MvziyJx6gfx4nK0e/2ASOyFTbJw3sy4AXjptAtk4dMLnxweNT+
 oWc5Nj0/aoQqGxwGCZX3IXYqcr9+8IGKTPgljsXYWEy8dZNt3GPLdFzPjrzJgGYxKkZI
 9DXkaqJz/U6DqhJoPcOcd4a7JZK7Qlu/pujUOl2jt6XDVXA5tsV2uEaE+vS3fkXnFzbk
 AylQqq31pOiwS08dr+Q9+7VVc4EddHMdl7nnTDyysbjqZ39siHO1YjhSh5OGTmUHFVi1
 m3WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7kDXFV45bIEQ6AgrbDcQpolqDd0iLD2X/dSSMWH82E2YOCXRhDTpeP3XEL7xfM6zpgFhZLQY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywd7jYmnH5C0X3180NsMumojCP6E67mLJJhixF9rmX6+JrWYA1A
 EhXqy9pIsJqjwJH2F8XnHu5WxSW3VLy6aNdYXRqjx6vmbwamStdekjwQHPiqB3XvPhSFC0FbtA9
 vu9Ttfx0K9Uyi7Rc9yiZOLjajYFHCHZM=
X-Gm-Gg: ASbGncvZLZWep+jJfTsF4VaL7u1muDy09Hz1icpNBfM8CfCuwoXYXtEvjRE7JFRZJHA
 7kvz045txW76KfM/mD0Pf9WrMDdV0Xhi1adEaSNy7XYIcsthQo4yDeFpJCYYXEMyCICWmCJOIGD
 VKHwCIKQkY4Y+BKBOqwXqrkUuD9H4UlPT+Xi0/hs6L4HzS48rXqAN7jz3WzpPTJuCVxI3u5uV8U
 b4=
X-Google-Smtp-Source: AGHT+IEkKDPRBrroe5HFwmAu+x1d86EZTjn5FHo2vLvrT3rdNeHUmhW/Rf0OPgaEIUikCJh551mlbaD8/UTgOqwKaWk=
X-Received: by 2002:a05:6512:b91:b0:553:adf7:e740 with SMTP id
 2adb3069b0e04-554fdd1d728mr347449e87.28.1750817941036; Tue, 24 Jun 2025
 19:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250624204700.972663-1-lukma@denx.de>
In-Reply-To: <20250624204700.972663-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 24 Jun 2025 23:18:49 -0300
X-Gm-Features: AX0GCFtsPoC8T_rMocG5ubFo7sx_5Q6Nl8Zy4LWMd5z7mU81_JG1d3Xg6uXm1rw
Message-ID: <CAOMZO5Dfw4PDRR1zBMr_8vgZey-X06RPhoCZkwz=kpFyZDY49w@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: nxp: bk4: Increase size of
 CONFIG_SYS_MALLOC_F_LEN (to 0x1000)
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, 
 albert.aribaud@3adev.fr, u-boot@lists.denx.de
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

On Tue, Jun 24, 2025 at 5:47=E2=80=AFPM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> The commit c69103218ee4 ("i2c: mxc_i2c: add DM_FLAG_PRE_RELOC flag")
> has enabled by default the i2c initialization in the pre-relocation
> phase.
> It turned out that vf610 based BK4 board had too small SYS_MALLOC_F_LEN
> pool size.
>
> After increasing it to 0x1000 the board boots again.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

It seems other Vybrid boards also have the same issue.

What about removing CONFIG_SYS_MALLOC_F_LEN from all the Vybrid boards
so that the default of 0x2000 is used?

diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig
index 2b72ec916327..82ebf704c605 100644
--- a/configs/bk4r1_defconfig
+++ b/configs/bk4r1_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=3Dy
 CONFIG_ARCH_VF610=3Dy
 CONFIG_TEXT_BASE=3D0x3f401000
 CONFIG_SYS_MALLOC_LEN=3D0x402000
-CONFIG_SYS_MALLOC_F_LEN=3D0x800
 CONFIG_NR_DRAM_BANKS=3D1
 CONFIG_ENV_SIZE=3D0x2000
 CONFIG_ENV_OFFSET=3D0x200000
diff --git a/configs/pcm052_defconfig b/configs/pcm052_defconfig
index d0d558ab11ad..81d703ec679d 100644
--- a/configs/pcm052_defconfig
+++ b/configs/pcm052_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=3Dy
 CONFIG_ARCH_VF610=3Dy
 CONFIG_TEXT_BASE=3D0x3f401000
 CONFIG_SYS_MALLOC_LEN=3D0x202000
-CONFIG_SYS_MALLOC_F_LEN=3D0x400
 CONFIG_NR_DRAM_BANKS=3D1
 CONFIG_ENV_SIZE=3D0x2000
 CONFIG_ENV_OFFSET=3D0xA0000
diff --git a/configs/vf610twr_defconfig b/configs/vf610twr_defconfig
index c823cb0a30ee..8129484513dd 100644
--- a/configs/vf610twr_defconfig
+++ b/configs/vf610twr_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=3Dy
 CONFIG_ARCH_VF610=3Dy
 CONFIG_TEXT_BASE=3D0x3f401000
 CONFIG_SYS_MALLOC_LEN=3D0x202000
-CONFIG_SYS_MALLOC_F_LEN=3D0x400
 CONFIG_NR_DRAM_BANKS=3D1
 CONFIG_ENV_SIZE=3D0x2000
 CONFIG_ENV_OFFSET=3D0xC0000
diff --git a/configs/vf610twr_nand_defconfig b/configs/vf610twr_nand_defcon=
fig
index 84e73c0c6657..51365990d0fb 100644
--- a/configs/vf610twr_nand_defconfig
+++ b/configs/vf610twr_nand_defconfig
@@ -4,7 +4,6 @@ CONFIG_SYS_THUMB_BUILD=3Dy
 CONFIG_ARCH_VF610=3Dy
 CONFIG_TEXT_BASE=3D0x3f401000
 CONFIG_SYS_MALLOC_LEN=3D0x0220000
-CONFIG_SYS_MALLOC_F_LEN=3D0x400
 CONFIG_NR_DRAM_BANKS=3D1
 CONFIG_ENV_SIZE=3D0x20000
 CONFIG_ENV_OFFSET=3D0x180000
