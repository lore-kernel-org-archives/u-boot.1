Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9821AD6ACED
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 11:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2432B83D90;
	Thu, 18 Dec 2025 12:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E64EA83D7A; Thu, 18 Dec 2025 12:44:53 +0100 (CET)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEB783D7A
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dX83Q1m1BzF1p;
 Thu, 18 Dec 2025 12:44:50 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dX83P5H9HzfGF; Thu, 18 Dec 2025 12:44:49 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 18 Dec 2025 12:44:42 +0100
Subject: [PATCH v2 2/3] doc: cmd: bdinfo: specify required dependency for
 some info
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-bdinfo-doc-v2-2-2fb328750026@cherry.de>
References: <20251218-b4-bdinfo-doc-v2-0-2fb328750026@cherry.de>
In-Reply-To: <20251218-b4-bdinfo-doc-v2-0-2fb328750026@cherry.de>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
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

