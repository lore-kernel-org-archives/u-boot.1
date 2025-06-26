Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5469CC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 10:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6524B82AA4;
	Thu, 26 Jun 2025 12:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tEoXWTOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F49682B34; Thu, 26 Jun 2025 12:43:55 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0503582977
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 12:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55QAhhVe2392319;
 Thu, 26 Jun 2025 05:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750934623;
 bh=CZZDXdLFdMdqshu/RGrTVWIFHQhbZVMSYGGatrlrwk0=;
 h=From:Date:Subject:To:CC;
 b=tEoXWTOOpy1q0hhEtfFJ3Q4BhDUJyk9E1tKMfC3wNj6b31vGamjiU/yqVH5TTxfon
 q0O5Da/w2wl6wS4fUCBnqKs/xuj1Atjrce8zOuWkc+dLLfgAk0se1Q9FBdFsNb9uwo
 E4V0YdmaXFf8DgyxOqL5lOxD0tzOpJQnmcvbxFME=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55QAhhsj3552443
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 26 Jun 2025 05:43:43 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 05:43:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 05:43:42 -0500
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55QAhdSs865642;
 Thu, 26 Jun 2025 05:43:39 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 26 Jun 2025 16:13:32 +0530
Subject: [PATCH] Makefile: Fix of_list_dirs with EXT_DTB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250626-b4-upstream-fix-icssg-fit-v1-1-95eff1c853a4@ti.com>
X-B4-Tracking: v=1; b=H4sIAFMkXWgC/x2MzQpAUBBGX0WzNsXELV5FFoPBLPx0Byl5d5PdO
 XW+7wGTqGJQJw9EudR0W13yNIF+5nUS1MEdKKMyCxSwK/Dc7YjCC456o/Zmk9OBXeCCqpIGFgb
 f71E8+L+b9n0/+LUcImsAAAA=
X-Change-ID: 20250626-b4-upstream-fix-icssg-fit-b6a42952daea
To: Tom Rini <trini@konsulko.com>
CC: Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>, Bryan
 Brattlof <bb@ti.com>, <u-boot@lists.denx.de>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750934619; l=1532;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=fEScn5Lc3HrNdvkq4akx55Sp8Dy1Ev1Z0jkbIRK6Izg=;
 b=g/ryvD/KoTT7DHyrao1h3vAIod+5Qq5IsTDQ04/FArJ5T3xiPtPJxllgovaO9rQI7KdyMqln3
 Q7PzPREL22hDG4EWX2o7v0SnFreKiwP3pDqd+fH9qXRtDsL1Xn4od37
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

EXT_DTB overrides the of_list_dirs that is passed to binman during
builds. This causes binman to not find the normal DTB paths and instead
it just is able to use the path for EXT_DTB only.

Add the default of_list_dirs that is used for normal binman builds to
EXT_DTB usecase as well.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index e60bbb01a004c7801034a10e7f3fdd04f92f700d..f2a6fbad6d32c3b68292ff19bda4f4fdb686de63 100644
--- a/Makefile
+++ b/Makefile
@@ -1392,17 +1392,17 @@ ifneq ($(EXT_DTB),)
 ext_dtb_list := $(basename $(notdir $(EXT_DTB)))
 default_dt := $(firstword $(ext_dtb_list))
 of_list := "$(ext_dtb_list)"
-of_list_dirs := $(dir $(EXT_DTB))
+of_list_dirs := $(dir $(EXT_DTB)) $(dt_dir)
 else
 of_list := $(CONFIG_OF_LIST)
-ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
-of_list_dirs := $(dt_dir) arch/$(ARCH)/dts
-else
 of_list_dirs := $(dt_dir)
-endif
 default_dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(CONFIG_DEFAULT_DEVICE_TREE))
 endif
 
+ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
+of_list_dirs += arch/$(ARCH)/dts
+endif
+
 binman_dtb := $(shell echo $(CONFIG_BINMAN_DTB))
 ifeq ($(strip $(binman_dtb)),)
 ifeq ($(CONFIG_OF_EMBED),y)

---
base-commit: 40e083353a1610276f12fdbe613bf12004452656
change-id: 20250626-b4-upstream-fix-icssg-fit-b6a42952daea

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

