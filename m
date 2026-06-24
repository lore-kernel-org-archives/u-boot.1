Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B65CDB470
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 04:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FA584671;
	Wed, 24 Jun 2026 06:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="O2BlcaQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA80A848DC; Wed, 24 Jun 2026 06:57:27 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD718460E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 06:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782277038; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DeVLmihhUm2kxKyvzlXRCZrR/LtZQO0Q599pSgbinIfhSNOJy8qlSKMcyVJLrDkZWH7jHaOi8m9a8+RCV8pI6mRbBGiockwcN3o3XwatVonF2Moe6K4AP5/Fxy0Yqx2IFm4vyBGO/23WsGhvrPSVIFdkL6QiT8WfDiWfYIxXKc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782277038;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SAZwtRdlq7/PIRsm0jkqUFyPO42bp3ItrpcA+IobeGE=; 
 b=PCwMWBqL1e+QArhb/iQw6xA5KxCg7SkcRDcVN66gJVpGqKOureF4lP16MmnQRFNrRdtHLGiV+e/dp2ZEJGP7ZdbJKbF6lD9cGMyNB7rKi7VMraMiN6mjQ9fRgCVzul+P6FRsBr6hGpPRkLgwZWQXjeg6pOTDZnyHA2XO91js5XA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782277038; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=SAZwtRdlq7/PIRsm0jkqUFyPO42bp3ItrpcA+IobeGE=;
 b=O2BlcaQuDd0M771bpAWVqn4P29aivPGujqfRT5fG8+S9ZCKCEzrWQbRiOpB7wQ2/
 AcHFRzJrpd34VdyVp3sGnlY4DwDL+8UlhOwQJbDYE3nx+a2fSXAl2wfKDMif1SaquXl
 r3NWulk2EKsGuCMlTtNZRUg3uobD7gHaxQhF88ds=
Received: by mx.zohomail.com with SMTPS id 1782277036301181.89180882017126;
 Tue, 23 Jun 2026 21:57:16 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Leo Liang <ycliang840519@gmail.com>,
 Tim Ouyang <tim609@andestech.com>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH] MAINTAINERS: riscv: Add myself as a reviewer
Date: Wed, 24 Jun 2026 04:56:49 +0000
Message-ID: <20260624045648.524454-2-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Add myself to help review patches for RISC-V port.

Signed-off-by: Yao Zi <me@ziyao.cc>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 370bcff56c19..85fedd169a9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1651,6 +1651,7 @@ F:	drivers/mtd/nand/raw/
 RISC-V
 M:	Rick Chen <rick@andestech.com>
 M:	Leo <ycliang@andestech.com>
+R:	Yao Zi <me@ziyao.cc>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-riscv.git
 F:	arch/riscv/
-- 
2.54.0

