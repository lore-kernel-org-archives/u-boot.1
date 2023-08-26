Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE89C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 09:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F30586B19;
	Sat, 26 Aug 2023 11:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463DE86B19; Sat, 26 Aug 2023 11:07:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A8D4086B47
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 11:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68327D75;
 Sat, 26 Aug 2023 02:07:52 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2772D3F740;
 Sat, 26 Aug 2023 02:07:09 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
Date: Sat, 26 Aug 2023 14:36:33 +0530
Message-Id: <20230826090633.239342-6-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826090633.239342-1-sughosh.ganu@linaro.org>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
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

Add a document explaining the need for removal of non-compliant
devicetree nodes and properties. Also describe in brief, the macros
that can be used for this removal.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst

diff --git a/doc/develop/devicetree/dt_non_compliant_purge.rst b/doc/develop/devicetree/dt_non_compliant_purge.rst
new file mode 100644
index 0000000000..c3a8feab5b
--- /dev/null
+++ b/doc/develop/devicetree/dt_non_compliant_purge.rst
@@ -0,0 +1,64 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Removal of non-compliant nodes and properties
+=============================================
+
+The devicetree used in U-Boot might contain nodes and properties which
+are specific only to U-Boot, and are not necessarily being used to
+describe hardware but to pass information to U-Boot. An example of
+such a property would be the public key being passed to U-Boot for
+verification.
+
+This devicetree can then be passed to the OS. Since certain nodes and
+properties are not really describing hardware, and more importantly,
+these are only relevant to U-Boot, bindings for these cannot be
+upstreamed into the devicetree repository. There have been instances
+of attempts being made to upstream such bindings, and these deemed not
+fit for upstreaming. Not having a binding for these nodes and
+properties means that the devicetree fails the schema compliance tests
+[1]. This also means that the platform cannot get certifications like
+SystemReady [2] which, among other things require a devicetree which
+passes the schema compliance tests.
+
+For such nodes and properties, it has been suggested by the devicetree
+maintainers that the right thing to do is to remove them from the
+devicetree before it gets passed on to the OS [3].
+
+Removing nodes/properties
+-------------------------
+
+In U-Boot, this is been done through adding information on such nodes
+and properties in a list. The entire node can be deleted, or a
+specific property under a node can be deleted. The list of such nodes
+and properties is generated at compile time, and the function to purge
+these can be invoked through a EVT_FT_FIXUP event notify call.
+
+For deleting a node, this can be done by declaring a macro::
+
+	DT_NON_COMPLIANT_PURGE(fwu_mdata) = {
+		.node_path      = "/fwu-mdata",
+	};
+
+Similarly, for deleting a property under a node, that can be done by
+specifying the property name::
+
+	DT_NON_COMPLIANT_PURGE(capsule_key) = {
+		.node_path      = "/signature",
+		.prop           = "capsule-key",
+	};
+
+In the first example, the entire node with path /fwu-mdata will be
+removed. In the second example, the property capsule-key
+under /signature node will be removed.
+
+Similarly, a list of nodes and properties can be specified using the
+following macro::
+
+	DT_NON_COMPLIANT_PURGE_LIST(foo) = {
+		{ .node_path = "/some_node", .prop = "some_bar" },
+		{ .node_path = "/some_node" },
+	};
+
+[1] - https://github.com/devicetree-org/dt-schema
+[2] - https://www.arm.com/architecture/system-architectures/systemready-certification-program
+[3] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE7zf26L_GV2oS6cg-5qg@mail.gmail.com/
-- 
2.34.1

