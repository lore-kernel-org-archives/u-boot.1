Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02E3C27C5F
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49ADA88495;
	Fri,  7 Jun 2024 20:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715848846E; Fri,  7 Jun 2024 20:54:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 773E4884AA
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6677A1480;
 Fri,  7 Jun 2024 11:54:29 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BA2A3F792;
 Fri,  7 Jun 2024 11:54:02 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 10/31] event: add events to notify memory map changes
Date: Sat,  8 Jun 2024 00:22:19 +0530
Message-Id: <20240607185240.1892031-11-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add events which would be used for notifying changes in the respective
modules' memory map. This is to be used for having a synchronous view
of the memory that is currently in use, and that is available for
allocations.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 common/event.c  |  4 ++++
 include/event.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/common/event.c b/common/event.c
index 16c2ba6cc9..067ee9ee4e 100644
--- a/common/event.c
+++ b/common/event.c
@@ -48,6 +48,10 @@ const char *const type_name[] = {
 
 	/* main loop events */
 	"main_loop",
+
+	"lmb_map_update",
+
+	"efi_map_update",
 };
 
 _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
diff --git a/include/event.h b/include/event.h
index fb353ad623..9d8be7a103 100644
--- a/include/event.h
+++ b/include/event.h
@@ -153,6 +153,22 @@ enum event_t {
 	 */
 	EVT_MAIN_LOOP,
 
+	/**
+	 * @EVT_LMB_MAP_UPDATE:
+	 * This event is triggered on an update to the LMB reserved memory
+	 * region. This can be used to notify about any LMB memory allocation
+	 * or freeing of memory having occurred.
+	 */
+	EVT_LMB_MAP_UPDATE,
+
+	/**
+	 * @EVT_EFI_MEM_MAP_UPDATE:
+	 * This event is triggered on an update to the EFI  memory map.
+	 * This can be used to notify about any EFI memory allocation
+	 * or freeing of memory having occurred.
+	 */
+	EVT_EFI_MEM_MAP_UPDATE,
+
 	/**
 	 * @EVT_COUNT:
 	 * This constants holds the maximum event number + 1 and is used when
@@ -203,6 +219,18 @@ union event_data {
 		oftree tree;
 		struct bootm_headers *images;
 	} ft_fixup;
+
+	struct event_lmb_map_update {
+		u64 base;
+		u64 size;
+		u8 op;
+	} lmb_map;
+
+	struct event_efi_mem_map_update {
+		u64 base;
+		u64 size;
+		u8  op;
+	} efi_mem_map;
 };
 
 /**
-- 
2.34.1

