Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF85410AB82C
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 23:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B001583FA3;
	Fri, 27 Mar 2026 00:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TG5IfUje";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B609B80517; Fri, 27 Mar 2026 00:00:21 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BABED83CD3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 00:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-67c2b70124cso872300eaf.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774566017; x=1775170817;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vFfq6dpUvWSyS7ZF3+F1ciYyiVtfABrATp5eZ3QGw1k=;
 b=TG5IfUjerSGr7Lz6B1UVcR9eS9eWbPUnyYoeua43QFj+sJBt4nYq9IJJQ3ZwaZGQMk
 3TACadelNTaJBXpOE0wbX0EB2pYSNRZw+VlXQY2PyvrWtquHiamvEEdmhkmaxgY1mw6x
 2RIfGlws3sFL/BosK5YVE8WcaaK0QQSHQTPQHSFynpi1Wbq1mEyg9XIyN0YIaMmNJ4YN
 2AhzZRZoT9YydrEBVRqBG8gbd+EpPpnDEv+r/N51aLq0ZyPMpY/zR31gKaqy82MBgJ4I
 MPZ1Oh8lYn+Dg0VpPTSlouLJZcbCdNoKQukflW3OMBRcx96qIFNJjHUTEYp+YS+fV1xV
 JY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774566017; x=1775170817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vFfq6dpUvWSyS7ZF3+F1ciYyiVtfABrATp5eZ3QGw1k=;
 b=ZLlxoNzW5atfrncNgrRI2IHWzniLciGWRYukZHokSD960TorkN/GhqLC4l2L3h3K5Z
 V+hEy1mCfO8w3ZeAwOGE3VhvMLQ5Dal+Bm/1mAM3FDff3FIkDAX4kp6KsFOJ6NcTvQTe
 D85zzjouMlU1e3SDlBYpu82+augxbD8dH9oflcIPt1Zm+KxaglSh4kYGGYrwjmQV5T7l
 Xdgly6DxIusIfNy5IiDypodoB2UfuhwKgMigJ4ETX/oW3/3KBzBY6A93mqG1wFqUsKKp
 Gx88HfH24/ozAyM9IfzSdSGYS/tEjtiMySqRD17UYvyGSSega0vwNe+eex2PiNZw2Ven
 +PYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKHkqlGoTfEK6Pmp5kJfCZ46MibY4cMIC/EgSlLyyV927JB/Lp+IXNorM3c+3lj/ukg8YubpA=@lists.denx.de
X-Gm-Message-State: AOJu0YwfcpIBmprdoWC+PgD30Zifhba+Pj26HleugGdRyR+5V2LGP9v3
 hWbPlaSaJUOMZn+TN7TkHYfNRZcxgZHnG2v1xKeFKMuo4yBRwcxekMd4VfuQhwpirKI=
X-Gm-Gg: ATEYQzxO8gFMqCs+QedB3YFB/Asmu9kHWYwOARXsKSX+3H7bf5bbomm7bvOPi+dQQEX
 zyIGfw9ewHQ7/gMsysZf26Uk1My+dJN6S2E8eovYFBwZscUBTTMt1NTgRkiBJ0hSAH1MpNHg4+3
 iAuUTZV1TJtp1Ot/Yds2NIvn9VQ3VwTTUNiRqgaPBgQyerqb8Lnn12B7EfyDZ+Q1MWGM9xdOhcH
 vxCN61fmjayOATNy9biGOV6I36JrINjbFAiZRxvRThn0I12jLrS77A4aX2nhb8thfo4DfhwXAOJ
 L4fVtWttp7dM/Dg3DR0rA2u17qiutwXColz6NcHg43hMNDc3OhC2w/r2MvumPy7hdPm5SVdeZBT
 zk1kxlJY2AJHqLkcg0eqR9kgxWnjccsexBanck4j/JnoJL8juBOH9c+1oVLMkuZFHw2Q4HAwOzp
 BBVZz6wUPFGzv8DPYtLNykOeFkOAWg
X-Received: by 2002:a05:6820:612:b0:67b:b01c:5899 with SMTP id
 006d021491bc7-67e18747f98mr235158eaf.56.1774566016992; 
 Thu, 26 Mar 2026 16:00:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41ccb6b1d25sm2742836fac.16.2026.03.26.16.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:00:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Mar 2026 17:59:23 -0500
Subject: [PATCH 1/6] env: scsi: rename ENV_SCSI_PART_UUID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-env-scsi-hw-part-support-v1-1-55c9dd07a2cb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2341; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=uzSaKAmL+5Q69jxgt6zkNoll5A5fD/2WGtJWjJDSsJI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxbpVq99ChNNpbGJVhEgYhs/Xt/K2vNW7ZI2F7
 X00Km8wjOqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacW6VRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVSYH/3j9SluTjiX4yKY5/IW6bEd8VBVQhYFrwxz0AHD
 xdeyoqeL9PHzXh2PAkqvdyOWXAy2RN7sMwB8JtEnBDQU7UwcRbVM+ElInGXku+6eIaYauptBrJN
 rk95e5uy2Td1IdTQ7AREe8x1UKctZw9sqja2STVEzn1szLbYV5Z/7+nL555XsIB9Y0fQeBU1wbK
 rBgixqT9U2Lk9U8kjp3Mo9csZe/sAYH6eqmgWAtKN+jqq8DRFCxB4qbHfXo3K2A3cExeh8ZfpRC
 U8EIRmxshqe3aYbf9JQbuaF/e5qHuPzA8GOap9fWNE1dNAXDW3jySKXEEU4WTga8yjriVNYy3DV
 ltQQ=
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

Rename SCSI_ENV_PART_UUID to ENV_SCSI_PART_UUID. All other environment-
related config names are of the form ENV_<name>, so this is more
consistent.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/qcom_qcs9100_defconfig | 2 +-
 env/Kconfig                    | 2 +-
 env/scsi.c                     | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 371448b8b1b..082106157bb 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -11,6 +11,6 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
 CONFIG_ENV_IS_IN_SCSI=y
-CONFIG_SCSI_ENV_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
+CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_DEFAULT is not set
 # CONFIG_ENV_IS_NOWHERE is not set
diff --git a/env/Kconfig b/env/Kconfig
index 2feff0b382e..5824f762870 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -762,7 +762,7 @@ config ENV_MMC_USE_DT
 	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
 	  are not used as fallback.
 
-config SCSI_ENV_PART_UUID
+config ENV_SCSI_PART_UUID
 	string "SCSI partition UUID for saving environment"
 	depends on ENV_IS_IN_SCSI
 	help
diff --git a/env/scsi.c b/env/scsi.c
index 207717e17b1..f376f731870 100644
--- a/env/scsi.c
+++ b/env/scsi.c
@@ -35,7 +35,7 @@ static inline struct env_scsi_info *env_scsi_get_part(void)
 {
 	struct env_scsi_info *ep = &env_part;
 
-	if (scsi_get_blk_by_uuid(CONFIG_SCSI_ENV_PART_UUID, &ep->blk, &ep->part))
+	if (scsi_get_blk_by_uuid(CONFIG_ENV_SCSI_PART_UUID, &ep->blk, &ep->part))
 		return NULL;
 
 	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
@@ -83,12 +83,12 @@ static int env_scsi_load(void)
 	int ret;
 
 	if (!ep) {
-		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found", 0);
+		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition not found", 0);
 		return -ENOENT;
 	}
 
 	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
-		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition read failed", 0);
+		env_set_default(CONFIG_ENV_SCSI_PART_UUID " partition read failed", 0);
 		return -EIO;
 	}
 

-- 
2.43.0

