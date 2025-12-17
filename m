Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E108FD65C7C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F2A83BC8;
	Wed, 17 Dec 2025 17:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3981783BBE; Wed, 17 Dec 2025 17:24:09 +0100 (CET)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC2783BA1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dWfJ546t2zWl8;
 Wed, 17 Dec 2025 17:24:05 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dWfJ50wDRzMNG; Wed, 17 Dec 2025 17:24:05 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 17 Dec 2025 17:23:57 +0100
Subject: [PATCH 2/3] doc: cmd: bdinfo: specify required dependency for some
 info
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-b4-bdinfo-doc-v1-2-83bf7fdb1691@cherry.de>
References: <20251217-b4-bdinfo-doc-v1-0-83bf7fdb1691@cherry.de>
In-Reply-To: <20251217-b4-bdinfo-doc-v1-0-83bf7fdb1691@cherry.de>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The devicetree, current eth and IP addr info are only available when
certain symbols are defined, so let's make the dependencies explicit.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/usage/cmd/bdinfo.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/usage/cmd/bdinfo.rst b/doc/usage/cmd/bdinfo.rst
index a139c9d855c..2a5873a400a 100644
--- a/doc/usage/cmd/bdinfo.rst
+++ b/doc/usage/cmd/bdinfo.rst
@@ -77,9 +77,13 @@ Build
 current eth
     name of the active network device
 
+    Only shown if CONFIG_NET=y or CONFIG_NET_LWIP=y.
+
 IP addr
     network address, value of the environment variable *ipaddr*
 
+    Only shown if CONFIG_NET=y or CONFIG_NET_LWIP=y.
+
 fdt_blob
     address of U-Boot's own device tree, NULL if none
 
@@ -95,6 +99,8 @@ lmb_dump_all
 devicetree
     source of the device-tree
 
+    Only shown if CONFIG_LMB=y and CONFIG_OF_REAL=y.
+
 arch_number
     unique id for the board
 

-- 
2.52.0

