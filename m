Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EEEC001DE
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F6E869AB;
	Tue, 15 Aug 2023 18:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FBAB8671F; Tue, 15 Aug 2023 18:27:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 356C586940
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB8371063;
 Tue, 15 Aug 2023 09:27:39 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B66D3F6C4;
 Tue, 15 Aug 2023 09:26:55 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 4/5] doc: capsule: Document the new mechanism to embed ESL
 file into dtb
Date: Tue, 15 Aug 2023 21:56:22 +0530
Message-Id: <20230815162623.1824357-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
References: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
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

Update the document to specify how the EFI Signature List(ESL) file
can be embedded into the platform's dtb as part of the U-Boot build.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since RFC series:
* s/u-boot/U-Boot in the commit message.

 doc/develop/uefi/uefi.rst | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 3ce579d46e..950f4d1a5a 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -539,20 +539,11 @@ and used by the steps highlighted below.
             ...
     }
 
-You can do step-4 manually with
-
-.. code-block:: console
-
-    $ dtc -@ -I dts -O dtb -o signature.dtbo signature.dts
-    $ fdtoverlay -i orig.dtb -o new.dtb -v signature.dtbo
-
-where signature.dts looks like::
-
-    &{/} {
-            signature {
-                    capsule-key = /incbin/("CRT.esl");
-            };
-    };
+You can perform step-4 by defining the Kconfig symbol
+CONFIG_EFI_CAPSULE_ESL_FILE. This symbol defines the path to the esl
+file generated in step-2. Once the symbol has been populated with the
+path to the esl file, the esl file will automatically get embedded
+into the platform's dtb as part of U-Boot build.
 
 Anti-rollback Protection
 ************************
-- 
2.34.1

