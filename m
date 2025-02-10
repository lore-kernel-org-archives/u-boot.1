Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD97C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24BF180C6F;
	Mon, 10 Feb 2025 14:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=baocheng.su@siemens.com header.b="QfAEZWrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF65803B5; Mon, 10 Feb 2025 14:06:47 +0100 (CET)
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32D4805C2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baocheng.su@siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 20250210130645e332e8f4b637369756 for <u-boot@lists.denx.de>;
 Mon, 10 Feb 2025 14:06:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=baocheng.su@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dDmlD8/wjS0vFICWGrVlIE6ipXm8OP0tvbvL9vyJ7Cs=;
 b=QfAEZWrCk3F24ngb1RUrW6YI+5oHaPF/qZVFt2A6u9i2gHm4KFAJq2ZDqxkbIiKDwrDFdk
 QA9lO+kY/qnNL96vqldFaxT8zS5K1H3fir4FHAiCjGKxoB2RH0VSGCR4azSgjXlYyoFHfOxO
 ig5SbIhVxZXtDkh+oQsYEv+ULHqgBewHCURevp9hqjRCF9gTfgRCrYUdAYOygeGj7Ng8cN1N
 +j9YchdwZb8bJnlAO+CPiYhF5QabHHyOf/8ABCXaaQMM+LPeN7DeGuBH4qUBdzSjzOF0A4Qn
 Ms3TaTCtLarS0QCWdVX9plVI2Efts1npNfc+OTd0rlu24aZJqRpKWEzg==;
From: Baocheng Su <baocheng.su@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Bryan Brattlof <bb@ti.com>,
 Baocheng Su <baocheng.su@siemens.com>
Subject: [PATCH v3 3/5] sysinfo: Add SYSID_BOARD_RAM_SIZE_MB
Date: Mon, 10 Feb 2025 21:05:42 +0800
Message-Id: <20250210130544.2781284-4-baocheng.su@siemens.com>
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

Add a new field SYSID_BOARD_RAM_SIZE_MB to sysinfo structure to store
the size of RAM in MB. dram_init can use this field to get the RAM size
via sysinfo driver.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>

---

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

