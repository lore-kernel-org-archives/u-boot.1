Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC78DC43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 17:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D4084A0E;
	Sat, 27 Jun 2026 19:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jAWZ5a1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4063F841C2; Sat, 27 Jun 2026 16:44:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3CF59842FC
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 16:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01B451F60;
 Sat, 27 Jun 2026 07:44:52 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.95.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A26943F905;
 Sat, 27 Jun 2026 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782571496; bh=DPaYO77GmWfUXJD/Y9BExqflCGi9dc3be56e0rggDMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jAWZ5a1gn4cbcYA461kwTkflJYt384rnuJzjpX/a9sIVTYI1CQkoXJWi6wJy7lGDu
 FEr/Lr9cLxG5BVaRqpRlGS9UkqIDkKgO3VPdjNixiuF5VXwYEOC9rzauCuCWY6k+uX
 Y4jMMBd+Q86QHs8vSWBKy+lId/VX99cQSzHbeCrw=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v3 10/10] doc: bootefi: note two-phase runtime variables
 selftest
Date: Sat, 27 Jun 2026 15:44:21 +0100
Message-Id: <20260627144421.2067410-11-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Jun 2026 19:41:26 +0200
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

The bootefi documentation did not describe how to run the
runtime-variable selftest, so users had no guidance on its reboot
requirements or on which flow applies to their configuration.

Document the runtime-variable selftest flow in bootefi.rst. Describe
the non-volatile path, note the single-run
CONFIG_EFI_RT_VOLATILE_STORE=y case, and show how to select the
runtime-variable selftest with efi_selftest.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 doc/usage/cmd/bootefi.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index 7c5448586b7..0a7800b93ce 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -160,6 +160,37 @@ environment variable to match one of the listed identifiers
 Some of the tests execute the ExitBootServices() UEFI boot service and will not
 return to the command line but require a board reset.
 
+When CONFIG_EFI_RT_VOLATILE_STORE is enabled, the test
+*variables at runtime* completes within one *bootefi selftest* run, so
+it does not depend on preserving state across multiple runs. It still
+executes ExitBootServices(), so a board reset is required afterwards
+before returning to the command line.
+
+::
+
+    => setenv efi_selftest 'variables at runtime'
+    => bootefi selftest
+
+When CONFIG_EFI_RT_VOLATILE_STORE is not enabled, the runtime-variable
+flow is split into *variables at runtime setup* and
+*variables at runtime verify*. Run the setup test once to create the
+runtime-accessible variable in non-volatile storage, reboot, then run
+the verify test to validate, append, and delete that variable.
+Both phases are on-request tests, so they only run when selected by
+``efi_selftest``.
+
+::
+
+    => setenv efi_selftest 'variables at runtime setup'
+    => bootefi selftest
+
+After reboot:
+
+::
+
+    => setenv efi_selftest 'variables at runtime verify'
+    => bootefi selftest
+
 Configuration
 -------------
 
-- 
2.34.1

