Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E3910AB82A
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 23:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEC8A83DBF;
	Fri, 27 Mar 2026 00:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pld5w/9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2FBE83DBF; Fri, 27 Mar 2026 00:00:32 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97FCB83FC6
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 00:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-41cd9267bbfso674473fac.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774566023; x=1775170823;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wBXZJW+hpG1CXpQxpOWWvqgWDLts20NXX8w8TmDMG1Y=;
 b=Pld5w/9Qj5GB+57BPjSpEglcc64HwUE/DlisUO2cdESGskar3/AkLpjxVTiF8EPat+
 jR5tgwQtMGudxop01vAMmFWoB0zYb5KtY/oDijJKw8OM9g0E3gZNjnin4xw1JOvBZ1/7
 TCcieKP82wsJUCRz/z/dN6+dKz5OGI4orOQKsXuxK0QyT3Z1Lm0Len+KvfbInWA2/0NV
 uLLhJ+2YTPbDKWcIy74abjDtG+eNlLAzDRPALRtM7WSIW9Og69oMxvIu/xiu2c2vKv4g
 OiuTcgCb9KMvW4Ea8baBt7WwQxrebe7zEf5S/9IlrjMuwQJZ1ft7j/OIHQURkIZgwjPN
 PETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774566023; x=1775170823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wBXZJW+hpG1CXpQxpOWWvqgWDLts20NXX8w8TmDMG1Y=;
 b=QR9o0z9/eJJZQoLEioUZ35VdM4/wQMVOZ6qOdldIklMVcQ7MXOGn0SjWNBIfcZ42UG
 oMfPW0YmsgPoczg8sfrsgUaAE4ajAcgyFXeeCfZKcfQ91UfKPPxYJQVlz81GTMOLrvJx
 VazF2oI7Fy6UCqboKE9yUDBUbM/7FjSq+iyp9lOHPuvt2GGED31gT6IQ2h/VQS16ibNV
 9k9+dDpRjEDhiN+gVNOktDR/0UnCjnKoqICgTKyeIpbYz8X3fuwW45JD93O9NBTsH7eC
 /34wUYyspfcBmfvl6+3d+k3Sl0TOR2gCU36sytdbXtYfw/vntF+RSXo/Dfaz7U9dHMmT
 gdzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVSYV6ta8r3IVbuEibLVXzOJwS5sJPoLmux2lFlY2gSMcNrlRolG7/YIzB+YBaI0PalWgf300=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5Qb7vCmD2aYhSOwc77waBOFr3BhpRX0y+rHz4cbmRZmoS+pLy
 8Q1tmuirM4ewvcK6zQ9kZoVYMQsuEi1OuSYr0V1+Yrz/KFdAGN4iHsjN/emLe0Kot88=
X-Gm-Gg: ATEYQzwV0j6b3A1Ye9bpY0rKwc6hOxf8l9T3njpjVcpe5pHwAsZv8OFv1pfbsqMyoXX
 +gF2cieIT5XGN4Yc7efzK92Vvvb8cAUXIdAZFY3Y0lGsoCsl6wEkhHeyeKh+solHEd1VLt8Akes
 6Z/qGnoNZvxPFUuncemf4oP82bhJeT1M5xJb5tpJxj2af59pTjGLWX4u1hHJIvWqzbhIwn/2z/2
 kr24KonOzIxq9e7HXiEWp6Q8qu3pZm/jvykvtDdCKspZBzpgY4rUg0UmRUlatndMVOL2QmYJmzm
 jbbDamiC3mcKz9XUG8N/VVIHhd9m4GhRr6OmZT9yXXtd1lLrTK8pP/M4uXFv7iRfEync4Pomaov
 aWMr5JnOOl727uZeVvUs3fSZrhPTFShTY+l+jA6T/LAuu6SSmfcat0fFac3R8TmoB5e75OYnz+P
 UEi9cXmC5Fu+mGp2Gsr8QUmF5ZvJPC
X-Received: by 2002:a05:6870:c20b:b0:41c:17f:2f7b with SMTP id
 586e51a60fabf-41cec4cc246mr72375fac.10.1774566022828; 
 Thu, 26 Mar 2026 16:00:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41ccb6b1d25sm2742836fac.16.2026.03.26.16.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:00:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Mar 2026 17:59:27 -0500
Subject: [PATCH 5/6] env: scsi: add CONFIG_ENV_SCSI_HW_PARTITION
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-env-scsi-hw-part-support-v1-5-55c9dd07a2cb@baylibre.com>
References: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
In-Reply-To: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xOufSiZDw6JMrlH/VBpKuUYstTl8yODBp8Csymlx4WA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxbpxv8eOzI4cPKMnjXt2GvVHFCYj8P1yRWHRK
 MD0tHRHgfyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacW6cRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ae/MH/3p5nE1rB2I7kVvAwq0xfJSQiE0ZsaUgyResHQe
 Oecs2qCjRRngg11TTijh+hb9TrEoleySmHc1iq2t3K7BhzqpDmOYcAxwH89Qi9gcvDzKzGm0DMf
 RYLwBraeaLnDNdJ0wIqaBU7U69jZ3mhp6O2r1+r4LRXrN76l9fNm9wp782j6iRHM1xy2Oqd3Y7U
 udgJ4DDXp/sggQbHXKyUQQN9bRSWdsh/0wnCRbShyvXy+U0l48BvR3MoQeluzH2kp2CvZrLJo/b
 z46waFTmdVVqUVLuOKreVtWP1NUeS2JDMF/0WtHXl8Ye2W0csTrp+KfYebxwLW050Ei3uRDr5Dg
 DniM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add CONFIG_ENV_SCSI_HW_PARTITION and supporting code to allow loading
the environment directly from a SCSI device without a partition table.
Some platforms store the environment directly on the SCSI device without
a way to look it up by partition UUID.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 env/Kconfig | 11 +++++++++++
 env/scsi.c  | 22 ++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/env/Kconfig b/env/Kconfig
index 5824f762870..ffaf16c581c 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -762,6 +762,17 @@ config ENV_MMC_USE_DT
 	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
 	  are not used as fallback.
 
+config ENV_SCSI_HW_PARTITION
+	string "SCSI hardware partition number"
+	depends on ENV_IS_IN_SCSI
+	default 0
+	help
+	  SCSI hardware partition device number on the platform where the
+	  environment is stored.  Note that this is not related to any software
+	  defined partition table but instead if we are in the user area, which is
+	  partition 0 or the first boot partition, which is 1 or some other defined
+	  partition.
+
 config ENV_SCSI_PART_UUID
 	string "SCSI partition UUID for saving environment"
 	depends on ENV_IS_IN_SCSI
diff --git a/env/scsi.c b/env/scsi.c
index 1787dcca92a..f4986353da5 100644
--- a/env/scsi.c
+++ b/env/scsi.c
@@ -41,8 +41,14 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
 		is_scsi_scanned = true;
 	}
 
-	if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
-		return NULL;
+	if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0') {
+		if (blk_get_device_part_str("scsi", CONFIG_ENV_SCSI_HW_PARTITION,
+					    &ep->blk, &ep->part, true))
+			return NULL;
+	} else {
+		if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
+			return NULL;
+	}
 
 	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
 
@@ -89,12 +95,20 @@ static int env_scsi_load(void)
 	int ret;
 
 	if (!ep) {
-		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
+		if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0')
+			env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " not found", 0);
+		else
+			env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
+
 		return -ENOENT;
 	}
 
 	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
-		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
+		if (CONFIG_ENV_SCSI_PART_UUID[0] == '\0')
+			env_set_default("SCSI partition " CONFIG_ENV_SCSI_HW_PARTITION " read failed", 0);
+		else
+			env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
+
 		return -EIO;
 	}
 

-- 
2.43.0

