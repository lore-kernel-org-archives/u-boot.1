Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603ACC5ACB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 07:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F30A087440;
	Tue, 21 Nov 2023 08:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D3D0870BE; Tue, 21 Nov 2023 08:00:58 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D2AB0867E2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 08:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA828FEC;
 Mon, 20 Nov 2023 23:01:39 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 193043F7CE;
 Mon, 20 Nov 2023 23:00:50 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 2/4] doc: Document capsule generation through a config file
Date: Tue, 21 Nov 2023 12:30:26 +0530
Message-Id: <20231121070028.2614095-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
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

The UEFI capsule can now be generate by specifying the capsule
parameters through a config file. Additionally, the capsules can be
generated as part of u-boot build, through binman. Highlight these
changes in the documentation.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 doc/develop/uefi/uefi.rst | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index fb16ac743a..b9a9ed5491 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -318,6 +318,76 @@ Run the following command
       --guid <image GUID> \
       <capsule_file_name>
 
+Alternatively, the capsules can be generated through a config
+file. When generating the capsules through a config file, the Kconfig
+symbol CONFIG_EFI_CAPSULE_CFG_FILE is to be used for specifying the
+path to the config file.
+
+The config file describes the parameters that are used for generating
+one or more capsules. The parameters for a given capsule file are
+specified within curly braces, in the form of "key:value" pairs. All
+the parameters that are currently supported by the mkeficapsule tool
+can be specified through the config file.
+
+The following are some example payload parameters specified through
+the config file.
+
+.. code-block:: none
+
+	{
+	    image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
+	    hardware-instance: 0
+	    monotonic-count: 1
+	    payload: u-boot.bin
+	    image-index: 1
+	    fw-version: 2
+	    private-key: /path/to/priv/key
+	    pub-key-cert: /path/to/pub/key
+	    capsule: u-boot.capsule
+	}
+	{
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    hardware-instance: 0
+	    payload: u-boot.itb
+	    image-index: 2
+	    fw-version: 7
+	    oemflags: 0x8000
+	    capsule: fit.capsule
+	}
+	{
+	    capsule-type: accept
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    capsule: accept.capsule
+	}
+	{
+	    capsule-type: revert
+	    capsule: revert.capsule
+	}
+
+The following are the keys that specify the capsule parameters
+
+..code-block:: none
+
+    image-guid: Image GUID
+    image-index: Image index value
+    fw-version: Image version
+    private-key: Path to the private key file used for capsule signing
+    pub-key-cert: Path to the public key crt file used for capsule signing
+    payload: Path to the capsule payload file
+    capsule: Path to the output capsule file that is generated
+    hardware-instance: Hardware Instance value
+    monotonic-count: Monotonic count value
+    capsule-type: Specifies capsule type. normal(default), accept or revert
+    oemflags: 16bit Oemflags value to be used(populated in capsule header)
+
+When generating capsules through a config file, the command would look
+like
+
+.. code-block:: console
+
+    $ mkeficapsule --cfg-file </path/to/the/config/file>
+
+
 Capsule with firmware version
 *****************************
 
-- 
2.34.1

