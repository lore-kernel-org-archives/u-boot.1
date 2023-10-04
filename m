Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C558EE7B5F3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C7A874E8;
	Wed,  4 Oct 2023 13:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D842874DC; Wed,  4 Oct 2023 13:27:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8A09E8722D
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A37BADA7;
 Wed,  4 Oct 2023 04:28:24 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5BF33F762;
 Wed,  4 Oct 2023 04:27:43 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 2/5] doc: capsule: Add documentation for the capsule dump
 feature
Date: Wed,  4 Oct 2023 16:57:19 +0530
Message-Id: <20231004112722.416877-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004112722.416877-1-sughosh.ganu@linaro.org>
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add documentation to explain the printing of the capsule headers
through the mkeficapsule tool.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 doc/develop/uefi/uefi.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 68f9b332d1..f16580e169 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -385,6 +385,23 @@ capsules. Refer :ref:`etype_efi_capsule` for documentation about the
 efi-capsule binman entry type, which describes all the properties that
 can be specified.
 
+Dumping capsule headers
+***********************
+
+The mkeficapsule tool also provides a command-line option to dump the
+contents of the capsule header. This is a useful functionality when
+trying to understand the structure of a capsule and is also used in
+capsule verification. This feature is used in testing the capsule
+contents in binman's test framework.
+
+To check the contents of the capsule headers, the mkeficapsule command
+can be used.
+
+.. code-block:: console
+
+    $ mkeficapsule --dump-capsule \
+      <capsule_file_name>
+
 Performing the update
 *********************
 
-- 
2.34.1

