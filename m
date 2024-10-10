Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994BCCF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0ED89198;
	Thu, 10 Oct 2024 07:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="VOJx3MMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF8F89023; Thu, 10 Oct 2024 07:56:04 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AEC890FA
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20241010055558886590571c778ef2da for <u-boot@lists.denx.de>;
 Thu, 10 Oct 2024 07:55:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eM9CpalP0jNbG0jNQ8Vjec1ox+mg0xKNezQTWCO+VbA=;
 b=VOJx3MMAddN5ur7b9Fk554P2HQfQApE1g9owGEa82r2tUDN5vqTl/nduBQQOjMcdwK/C6o
 1DgUz4PpkO8xrfL9h+UeAEYB/DPcuYyfBAnjy8Pc/dJkG7d1wIdShzeltRcjsMkbe9MmSEN3
 zCyNNX2VjGxcoTLQupCnlriYNrLVeiw04+mLyz+6f+bwL6+uKz5J0Ko3nZmkY4VuP/WLNX6n
 Id0l2Eu6MOn2iZh7BntezmT4zXUgSRYX6Q9OO8UWycf2qTpIGi7OAGrPAzwSakGaZBy3wGoU
 RJRCJigrbNUj1Ll1y5G89mXEcrrC57qVaSqYosr/snTSkGHZQUtTDlSQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 09/11] smbios: Fill UUID from sysinfo when available
Date: Thu, 10 Oct 2024 07:55:53 +0200
Message-ID: <0e787560e70ce487b3cdd753c4f3868940ecec66.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
be first used by the IOT2050 boards.

Based on original patch by Li Hua Qian.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/sysinfo.h | 1 +
 lib/smbios.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/sysinfo.h b/include/sysinfo.h
index 8a77ef44856..1c5008b5f23 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -49,6 +49,7 @@ enum sysinfo_id {
 	SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
 	SYSINFO_ID_SMBIOS_SYSTEM_SKU,
 	SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
+	SYSINFO_ID_SMBIOS_SYSTEM_UUID,
 	SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
 	SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
 	SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
diff --git a/lib/smbios.c b/lib/smbios.c
index 7c24ea129eb..1441fa4cde6 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -387,6 +387,7 @@ static int smbios_write_type1(ulong *current, int handle,
 	struct smbios_type1 *t;
 	int len = sizeof(struct smbios_type1);
 	char *serial_str = env_get("serial#");
+	char uuid[sizeof(t->uuid)];
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, sizeof(struct smbios_type1));
@@ -409,6 +410,9 @@ static int smbios_write_type1(ulong *current, int handle,
 						      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
 						      NULL);
 	}
+	if (!sysinfo_get_str(ctx->dev, SYSINFO_ID_SMBIOS_SYSTEM_UUID,
+			     sizeof(uuid), uuid))
+		strncpy((char *)t->uuid, uuid, sizeof(t->uuid));
 	t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
 	t->sku_number = smbios_add_prop_si(ctx, "sku",
 					   SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);
-- 
2.43.0

