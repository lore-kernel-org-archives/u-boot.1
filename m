Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56678C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 03:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 722C387090;
	Thu,  9 Nov 2023 04:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFDC8714F; Thu,  9 Nov 2023 04:15:16 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B034E87045
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 04:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3A93F09U065247;
 Thu, 9 Nov 2023 11:15:00 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 9 Nov 2023
 11:14:56 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH] riscv: binman: fix the load field format
Date: Thu, 9 Nov 2023 11:14:48 +0800
Message-ID: <20231109031448.138723-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3A93F09U065247
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

The #address-cells is now equal to 2. The format of the load field for
the Linux kernel doesn't match.

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/dts/binman.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 6b4eb8dc7b..5117d7c8c9 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -50,7 +50,8 @@
 					os = "Linux";
 					arch = "riscv";
 					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
+					load = <U64_TO_U32_H(CONFIG_TEXT_BASE)
+						U64_TO_U32_L(CONFIG_TEXT_BASE)>;
 
 					linux_blob: blob-ext {
 						filename = "Image";
-- 
2.34.1

