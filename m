Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B41C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 10:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 791718845F;
	Sat, 20 Apr 2024 12:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fE4lnEJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6975588124; Sat, 20 Apr 2024 09:02:19 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF2288113
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 09:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e3c9300c65so26052335ad.0
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713596535; x=1714201335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQAjyn9MtdkPYORc9/TSIhAPVbn3fnH0tGdXxSEkHkg=;
 b=fE4lnEJ0rX4zwgkX++smYqTdRyAjAyeIlC7MfCo0KSdGVdxtcITFuE8h1GobM2bRZv
 u4uIF/INETIJv9mpeajg+pyPojzArkQpxwR3TYBJgUnuYxGNJSmorfhlsCAkMw6De1Zq
 eX/2HFnHODGyAMKPyzKIJ9D+vntjJ1Kgo/hNGiL7CYVr+7bF+tSZgtO8fOtKfp6aXHgi
 3CLaCu6gGEsxp4I0gq82RiWSwp850aqBJ/gkDvhJEqRuKqaElz3+7tiHm8rUUCZiyA0e
 0QJe1TpPk/o4uey2m7ZidZPWL0H8zE6rIuckW0aGyRoR/ccdIqIZlfV1D/47iH24GSLo
 VKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713596535; x=1714201335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQAjyn9MtdkPYORc9/TSIhAPVbn3fnH0tGdXxSEkHkg=;
 b=tNkLSZOxF0+ZThrGm0QMJ/XeBCrjjia0Fg391Kw46VMDP09dkNmfP2fyqMWerzr7TR
 B9QnTzNdoikZIGbNW1y8hbkbhjSYO0fSfazkRevlgwdVg2MMB95wK5lslzYYBgYCR6je
 rHk8wi4z6pSom1KaM7jS9+KyEbeglokuxISgvekqGIbsgS1BJcD49ohciKYmihQh3Qg4
 T2dRVzFBvHbMRrPYfBp3elNgWApMh6nL8zhCuzKYxFqPaTOfsqDvqoBtBKPpNCvO/m2D
 nclmoz/V/7gZVHbM6szODVVjkoKfe1dCtgYLG2tj01tJvqrqWn9sRA/mHFzBjiTH5agA
 xCmw==
X-Gm-Message-State: AOJu0YyUThrBik8yeCT1HJxNCrF3ZG1+vRg8nFuFBL7gUb/dR3TzL/GC
 acNx2CNbbmG48W6z4lUMAEMx9ACJ7TB0j6+7z1LqYQU8CG4CvQO3JbLgo6YK9RQ=
X-Google-Smtp-Source: AGHT+IFXiONYXA6PjUgET9VEgIBbGmi1aSQp/BL08mP4Wcd+7i2saOCJ3UucyBbbFWGQhebKJUSaiQ==
X-Received: by 2002:a17:903:2348:b0:1e2:a2ca:6366 with SMTP id
 c8-20020a170903234800b001e2a2ca6366mr5058556plh.21.1713596534857; 
 Sat, 20 Apr 2024 00:02:14 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a170902778900b001e51b690b7dsm4424137pll.295.2024.04.20.00.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 00:02:14 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] configs: milkv_duo: Add ethernet configs
Date: Sat, 20 Apr 2024 15:00:29 +0800
Message-ID: <20240420070149.8917-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240420070149.8917-1-seashell11234455@gmail.com>
References: <20240420070149.8917-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Apr 2024 12:11:39 +0200
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

Add configs related to ethernet and ethernet boot command for Sophgo Milk-V
Duo board

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---

(no changes since v1)

 configs/milkv_duo_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index e8413d7aa9..f66c4c5358 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -19,14 +19,18 @@ CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="milkv_duo# "
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_PXE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_ETH_DESIGNWARE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
-- 
2.41.0

