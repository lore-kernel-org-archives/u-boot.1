Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A35C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7494A80BAD;
	Mon, 10 Feb 2025 14:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=baocheng.su@siemens.com header.b="ArfSaGHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB2B807D6; Mon, 10 Feb 2025 14:06:38 +0100 (CET)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA5E803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baocheng.su@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202502101306360607a4832c5ca8a972 for <u-boot@lists.denx.de>;
 Mon, 10 Feb 2025 14:06:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=baocheng.su@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=29zlutI5YrJeDFnmNBqFZryYxO8rgK1uni4wE1WUzD4=;
 b=ArfSaGHQTYyKjgg9GYX+x8w5C9PMvTTRT6bb+BOYF6VdKZDeJ5mn97d9LnEnMQ595Zc98H
 ZWv4zsUjRD9S3onkh3yivnuBXFboTS/POODf5/ZX1gq1Xqf/gLuvKB55kaH6A8QLGDmZCc3c
 rg9zWTHphDe5y0+UUkQvlA1m4isFXqRfF3y8yN+yILAS+K/HxDqtkSLqDb7zGqlHvOWFN9ob
 JAoYupKDgpCHyUqc3yAihcWYb4z8Tv9ydVjAJgb7+E3CzZF/+OXKVymeqkGknXsIewTPbMr9
 aV1hcAxKYudgRlLc3xD4Q0OpY0Bn3aBmGGgkeIq/NDlrRrRuCxU6zexA==;
From: Baocheng Su <baocheng.su@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Bryan Brattlof <bb@ti.com>,
 Baocheng Su <baocheng.su@siemens.com>
Subject: [PATCH v3 1/5] smbios: Fill UUID from sysinfo when available
Date: Mon, 10 Feb 2025 21:05:40 +0800
Message-Id: <20250210130544.2781284-2-baocheng.su@siemens.com>
In-Reply-To: <20250210130544.2781284-1-baocheng.su@siemens.com>
References: <20250210130544.2781284-1-baocheng.su@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-909155:519-21489:flowmailer
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:33:36 +0100
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

Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
be first used by the IOT2050 boards.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Baocheng Su <baocheng.su@siemens.com>

---

Changes in v3:
- use sysinfo_get_data to get the SMBios UUID bin
- s/strncpy/memcpy/ for the UUID bin

 include/sysinfo.h | 1 +
 lib/smbios.c      | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/sysinfo.h b/include/sysinfo.h
index ba2ac273e8e2..14e923c6589f 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -57,6 +57,7 @@ enum sysinfo_id {
 	SYSID_SM_SYSTEM_WAKEUP,
 	SYSID_SM_SYSTEM_SKU,
 	SYSID_SM_SYSTEM_FAMILY,
+	SYSID_SM_SYSTEM_UUID,
 
 	/* Baseboard (or Module) Information (Type 2) */
 	SYSID_SM_BASEBOARD_MANUFACTURER,
diff --git a/lib/smbios.c b/lib/smbios.c
index 78cee8c0c264..7c9701a57f9d 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -429,6 +429,8 @@ static int smbios_write_type1(ulong *current, int handle,
 	struct smbios_type1 *t;
 	int len = sizeof(*t);
 	char *serial_str = env_get("serial#");
+	size_t uuid_len;
+	void *uuid;
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
@@ -450,6 +452,10 @@ static int smbios_write_type1(ulong *current, int handle,
 						      SYSID_SM_SYSTEM_SERIAL,
 						      NULL);
 	}
+	if (!sysinfo_get_data(ctx->dev, SYSID_SM_SYSTEM_UUID, &uuid,
+			      &uuid_len) &&
+	    uuid_len == sizeof(t->uuid))
+		memcpy(t->uuid, uuid, sizeof(t->uuid));
 	t->wakeup_type = smbios_get_val_si(ctx, "wakeup-type",
 					   SYSID_SM_SYSTEM_WAKEUP,
 					   SMBIOS_WAKEUP_TYPE_UNKNOWN);
-- 
2.39.5

