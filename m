Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70F0CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 06:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49EDC84895;
	Wed, 17 Jun 2026 08:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D9B84704; Wed, 17 Jun 2026 08:21:07 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F40838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 08:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim609@andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 65H6Kl08090245
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 14:20:47 +0800 (+08)
 (envelope-from tim609@andestech.com)
Received: from swlinux01.andestech.com (10.0.15.55) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0;
 Wed, 17 Jun 2026 14:20:47 +0800
From: Tim Ouyang <tim609@andestech.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <ycliang840519@gmail.com>, <seanga2@gmail.com>,
 <me@ziyao.cc>, <oyst.lnx@gmail.com>, Tim Ouyang <tim609@andestech.com>
Subject: [PATCH] MAINTAINERS: update RISC-V maintainers
Date: Wed, 17 Jun 2026 14:19:27 +0800
Message-ID: <20260617061927.1547917-1-tim609@andestech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.55]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 65H6Kl08090245
X-Mailman-Approved-At: Wed, 17 Jun 2026 08:59:32 +0200
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

Rick and Leo are no longer with Andes. Remove Rick from the RISC-V
maintainer list. Leo will continue maintaining RISC-V, but update his
email address. Add myself to the maintainer list as Rick's replacement.

Signed-off-by: Tim Ouyang <tim609@andestech.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..af15800ecf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1641,8 +1641,8 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
 F:	drivers/mtd/nand/raw/
 
 RISC-V
-M:	Rick Chen <rick@andestech.com>
-M:	Leo <ycliang@andestech.com>
+M:	Leo Liang <ycliang840519@gmail.com>
+M:	Tim Ouyang <tim609@andestech.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-riscv.git
 F:	arch/riscv/
-- 
2.43.0

