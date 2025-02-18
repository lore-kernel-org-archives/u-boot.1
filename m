Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2588C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B70980F60;
	Tue, 18 Feb 2025 06:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=baocheng.su@siemens.com header.b="VsE/1gB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5917807F1; Tue, 18 Feb 2025 03:36:45 +0100 (CET)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6D1380017
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baocheng.su@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202502180236439adb943f93e1dccf29 for <u-boot@lists.denx.de>;
 Tue, 18 Feb 2025 03:36:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=baocheng.su@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ogZHk5WzkUlQZZxOxToXD9yIKUFE5u2A/LsSNcwR4s0=;
 b=VsE/1gB439vr93REUAYcGwTd8FG97aeh9aYOQ9oC0LpRGzRbfphxYU72IJ4uqUZsGTsW/S
 5DJqDj5wmauW9b2rWtV4kcAnX9FokJuCh+kXFAmVn4jsY0bjSfaV3sN0VXYIZdB2RJmd5/se
 G5LfLPXVH5gMpz15hdY9eAX8NWwAnb0a/N32SBrAsldm5r3m8ahRufyeKcTwz63YgQKUmTlK
 gmBw9jqh9QQW+AW6VbTCyeahknq6ihb3u8Tcpd2MX8MAp905suI2sVqcfpjF+MWKuSIRCOtC
 Z75WB+1NN0d6SMtjomrX/l9h02KJhE5GZj/l2kqR/IInL1KqX9YoaFuQ==;
From: Baocheng Su <baocheng.su@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Baocheng Su <baocheng.su@siemens.com>
Subject: [PATCH v4 3/5] sysinfo: Add SYSID_BOARD_RAM_SIZE_MB
Date: Tue, 18 Feb 2025 10:36:12 +0800
Message-Id: <20250218023614.52574-4-baocheng.su@siemens.com>
In-Reply-To: <20250218023614.52574-1-baocheng.su@siemens.com>
References: <20250218023614.52574-1-baocheng.su@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-909155:519-21489:flowmailer
X-Mailman-Approved-At: Tue, 18 Feb 2025 06:35:12 +0100
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

Add a new field SYSID_BOARD_RAM_SIZE_MB to sysinfo structure to store
the size of RAM in MB. dram_init can use this field to get the RAM size
via sysinfo driver.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>

---

(no changes since v3)

Changes in v3:
- New

 include/sysinfo.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sysinfo.h b/include/sysinfo.h
index 2866ac293cbb..e87cf969fcd1 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -153,6 +153,7 @@ enum sysinfo_id {
 	SYSID_BOARD_MODEL,
 	SYSID_BOARD_MANUFACTURER,
 	SYSID_BOARD_MAC_ADDR,
+	SYSID_BOARD_RAM_SIZE_MB,
 	SYSID_PRIOR_STAGE_VERSION,
 	SYSID_PRIOR_STAGE_DATE,
 
-- 
2.39.5

