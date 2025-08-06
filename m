Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5C9C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 11:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEAD5833F9;
	Wed,  6 Aug 2025 13:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D1E83A03; Wed,  6 Aug 2025 13:39:34 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F9283314
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 13:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 576BdIfc097593
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 6 Aug 2025 19:39:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 19:39:18 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <ycliang@andestech.com>
Subject: [PATCH 1/1] doc: spl: fix typo 'TPL' to 'VPL'
Date: Wed, 6 Aug 2025 19:39:12 +0800
Message-ID: <20250806113912.3404244-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 576BdIfc097593
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

Fix typo: change 'TPL' to 'VPL'.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 doc/develop/spl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index aa6d28fa333..7f2eac50806 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -142,7 +142,7 @@ fdtgrep is also used to remove:
 - the properties defined in CONFIG_OF_SPL_REMOVE_PROPS
 - all the pre-relocation properties
   ('bootph-all', 'bootph-pre-ram' (SPL), 'bootph-pre-sram' (TPL) and
-  'bootph-verify' (TPL))
+  'bootph-verify' (VPL))
 
 All the nodes remaining in the SPL devicetree are bound
 (see doc/driver-model/design.rst).
-- 
2.34.1

