Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2D9EE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF570864D7;
	Tue, 22 Aug 2023 19:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3390C864D4; Tue, 22 Aug 2023 19:41:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6C9F9864D3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B142A11FB;
 Tue, 22 Aug 2023 10:41:37 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B4193F762;
 Tue, 22 Aug 2023 10:40:54 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v11 08/15] doc: Add documentation to highlight capsule
 generation related updates
Date: Tue, 22 Aug 2023 23:10:01 +0530
Message-Id: <20230822174008.626239-9-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822174008.626239-1-sughosh.ganu@linaro.org>
References: <20230822174008.626239-1-sughosh.ganu@linaro.org>
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

The EFI capsules can now be generated as part of U-Boot build, through
binman. Highlight these changes in the documentation.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
Changes since V10:
* Add an example binman capsule node which shows how a capsule can be
  generated through binman.

 doc/develop/uefi/uefi.rst | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index a7a41f2fac..f27cabbcce 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -318,6 +318,9 @@ Run the following command
       --guid <image GUID> \
       <capsule_file_name>
 
+Capsule with firmware version
+*****************************
+
 The UEFI specification does not define the firmware versioning mechanism.
 EDK II reference implementation inserts the FMP Payload Header right before
 the payload. It coutains the fw_version and lowest supported version,
@@ -345,6 +348,43 @@ add --fw-version option in mkeficapsule tool.
 If the --fw-version option is not set, FMP Payload Header is not inserted
 and fw_version is set as 0.
 
+Capsule Generation through binman
+*********************************
+
+Support has also been added to generate capsules during U-Boot build
+through binman. This requires the platform's DTB to be populated with
+the capsule entry nodes for binman. The capsules then can be generated
+by specifying the capsule parameters as properties in the capsule
+entry node.
+
+Check the test/py/tests/test_efi_capsule/capsule_gen_binman.dts file
+as reference for how a typical binman node for capsule generation
+looks like. For generating capsules as part of the platform's build, a
+capsule node would then have to be included into the platform's
+devicetree.
+
+A typical binman node for generating a capsule would look like::
+
+	capsule {
+		filename = "u-boot.capsule";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = "09d7cf52-0720-4710-91d1-08469b7fe9c8";
+
+			u-boot {
+			};
+		};
+	};
+
+In the above example, a capsule file named u-boot.capsule will be
+generated with u-boot.bin as it's input payload. The capsule
+generation parameters like image-index and image-guid are being
+specified as properties. Similarly, other properties like the private
+and public key certificate can be specified for generating signed
+capsules. Refer :ref:`etype_efi_capsule` for documentation about the
+efi-capsule binman entry type, which describes all the properties that
+can be specified.
+
 Performing the update
 *********************
 
-- 
2.34.1

