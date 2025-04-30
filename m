Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A677C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 16:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCDD82C03;
	Wed, 30 Apr 2025 18:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746031583;
	bh=r5E8GImE9BeYgZ0eLGhucLXn19tEbXaDqB7H0btavaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iz6ctdYXq+uJ42xza9A96/6zJCXrCLuKwi1YGhhYbk2c7mrXRI5/CXPAZ2bW/AhPv
	 ZCBG7ApuEFiQ4kIMZmtnWakot1EciNANRDk2n4I5iTwNf0oEyumZRpV9yq9DTDAbio
	 RI38hX3hBy7BoHPSp4P/dImYFpGgSdUxWcBB++eIVm4T9WTAd0owpViCQ+x7yCfr7n
	 tCMrM+5F5ZY1zqstfLb8AcqF4FCIY66EcT6F8FCHUty3F400vi8tieoE/8WMmDFBIU
	 IYHGZlA0xfy9FY3NeigCJuX5Lb5+epTaAELDPx7WNSOLEfucfXmAaV3/+iRlpe2eXS
	 dLrlKxfWiZZ/g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4541782BF2; Wed, 30 Apr 2025 18:46:21 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D0C82BF2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HhaNaOg/"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7AFD610269595; 
 Wed, 30 Apr 2025 18:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1746031578; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=r5E8GImE9BeYgZ0eLGhucLXn19tEbXaDqB7H0btavaI=;
 b=HhaNaOg/ARm9D6mbGRouRXbvqBBQUkAvWLj5KLGhjLtmF+jMcbmxSWc3r8dLZd87g1xzfM
 eYJIM7l5/KHBg8ECo22h/Q9Vpfkd6mwXA+WNAb9m4J1FFM2C/nKb0gAY5yvjAkI6gEVYFF
 viQzwIMsZ/uAe+04WhV4J4zvdoNsXX8sK4VrtYT6OxnJzem2zT2Z/ojgtPKglOQBpIbqp5
 9y2TBziiGRwC+Zd1s9svnDPJjr4LsNNbUs5EwoLLcmhxhEnKf/WBwYC2f9e+HOp8u0ngLR
 rBS+dCugJ576WhwAQzF8Er/lWWNGFihjydONmKS8YeDcL7kfNlF7SJ1B86veJQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] fs: exfat: Inhibit unused exfat_humanize_bytes() and
 exfat_print_info()
Date: Wed, 30 Apr 2025 18:45:52 +0200
Message-ID: <20250430164559.27095-2-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430164559.27095-1-marex@denx.de>
References: <20250430164559.27095-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Make sure unused exfat_humanize_bytes() and exfat_print_info()
functions are not compiled into U-Boot code base. This also removes
CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
in exfat_humanize_bytes() , which is now surely unreachable.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 fs/exfat/exfat.h | 2 ++
 fs/exfat/utils.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/exfat/exfat.h b/fs/exfat/exfat.h
index cce3e3021ca..ca6f22b9d58 100644
--- a/fs/exfat/exfat.h
+++ b/fs/exfat/exfat.h
@@ -210,9 +210,11 @@ uint32_t exfat_vbr_start_checksum(const void* sector, size_t size);
 uint32_t exfat_vbr_add_checksum(const void* sector, size_t size, uint32_t sum);
 le16_t exfat_calc_name_hash(const struct exfat* ef, const le16_t* name,
 		size_t length);
+#ifndef __UBOOT__
 void exfat_humanize_bytes(uint64_t value, struct exfat_human_bytes* hb);
 void exfat_print_info(const struct exfat_super_block* sb,
 		uint32_t free_clusters);
+#endif
 bool exfat_match_option(const char* options, const char* option_name);
 
 int exfat_utf16_to_utf8(char* output, const le16_t* input, size_t outsize,
diff --git a/fs/exfat/utils.c b/fs/exfat/utils.c
index 0d97b65dcab..f99dcba7e3d 100644
--- a/fs/exfat/utils.c
+++ b/fs/exfat/utils.c
@@ -134,6 +134,7 @@ le16_t exfat_calc_name_hash(const struct exfat* ef, const le16_t* name,
 	return cpu_to_le16(hash);
 }
 
+#ifndef __UBOOT__
 void exfat_humanize_bytes(uint64_t value, struct exfat_human_bytes* hb)
 {
 	size_t i;
@@ -178,6 +179,7 @@ void exfat_print_info(const struct exfat_super_block* sb,
 	exfat_humanize_bytes(avail_space, &hb);
 	printf("Available space      %10"PRIu64" %s\n", hb.value, hb.unit);
 }
+#endif
 
 bool exfat_match_option(const char* options, const char* option_name)
 {
-- 
2.47.2

