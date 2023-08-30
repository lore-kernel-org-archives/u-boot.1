Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D3C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C149F8656A;
	Wed, 30 Aug 2023 20:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="gYEbZ1Oi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781FC8643D; Wed, 30 Aug 2023 16:04:25 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295A986526
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RbQyV4554z9sjR;
 Wed, 30 Aug 2023 16:04:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1693404258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aeedeurb4VXerkcYxH6JZf9YgGcD7f3KU4q9KDVpBJ0=;
 b=gYEbZ1OiPqM7XmovCDludJB73wXsvcy71bl5ZQAMHqJ0HMSK/6rrNV9GQcndXGzYIEy6Rl
 uNFi0vjoDn7PCqg6R8HuohCnkXlPAcOSkPVGBLtoN9VxBENGMwaGgfPyG+V35J27HDBNG6
 3pJjclr4n9rf9laFslizyBj+L8Z+dyNd5nxmlgEOzVna9LrmyJBuK9JprkoFcQfT39ygCN
 5c8IZoyapEkPn/FmrE/3dtD55EMso9EpDt5Q2oDcYZtLNi5IeXiiQRK2kCe25cMu2KwnHd
 ZT0GhP+I45183yny4ldmKMR3u/BbPE3NRecFXBbkRn37wORRLtkCZl7CH96ilQ==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 3/5] xilinx: zynqmp: move fdt_addr so we can use devices with
 less memory
Date: Wed, 30 Aug 2023 16:03:32 +0200
Message-ID: <20230830140349.10801-4-lists@steffen.cc>
In-Reply-To: <20230830140349.10801-1-lists@steffen.cc>
References: <20230830140349.10801-1-lists@steffen.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Aug 2023 20:15:48 +0200
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

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

With the current config we'd put the fdt outside of memory.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---

 include/configs/xilinx_zynqmp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
index 74264b7bee..334fe95d66 100644
--- a/include/configs/xilinx_zynqmp.h
+++ b/include/configs/xilinx_zynqmp.h
@@ -50,7 +50,7 @@
 #endif
 
 #define ENV_MEM_LAYOUT_SETTINGS \
-	"fdt_addr_r=0x40000000\0" \
+	"fdt_addr_r=0x28000000\0" \
 	"fdt_size_r=0x400000\0" \
 	"pxefile_addr_r=0x10000000\0" \
 	"kernel_addr_r=0x18000000\0" \
-- 
2.42.0

