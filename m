Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E654BC83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 13:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE06831EA;
	Wed, 16 Jul 2025 15:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VPa4iIic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB79783242; Wed, 16 Jul 2025 15:13:49 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0A6A82E37
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 15:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetbo@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id EAFEFA5720B;
 Wed, 16 Jul 2025 13:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D180C4CEF0;
 Wed, 16 Jul 2025 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752671625;
 bh=JA8vnImQDAcY9H7eHE+fDcNV7PkqVmRNE2vpR7bSf1Y=;
 h=From:Date:Subject:To:Cc:From;
 b=VPa4iIic9U6H/nDsqRbR2oexnaOp9lL5dWDaSD9omRV4+xqy7Dgt3usQC8yvnILG+
 E7/VkBdSCjjeN1ho4ew/JBmvXjfS0u/jx+ID1Ugg2KlvccC4VjngxZ9TyNRZAxULcn
 EKDv6SIA7hHXjjymjOdO8f06MzUdeZ/ykBV3wUn3iAUnuAgAvQs8SJbZ95ap+Q4TAt
 qt9b1b3ZJjybiyE0dwe6xvwq983JXz8yPoIo/URCujC/zagV6esghkPEqyg3KpT96+
 jpdkRYLsGGpa8EKhYW4CqrJFH+XQAhbVSDDluL2JoJv5eNAE5SmybiqiNFOY8UxHE8
 pZ9PIbDhC9Nag==
From: Enric Balletbo i Serra <eballetbo@kernel.org>
Date: Wed, 16 Jul 2025 15:12:06 +0200
Subject: [PATCH] docs: Update FIT signature testing instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-fix-signature-test-docs-v1-1-4d2ad5ebcc28@kernel.org>
X-B4-Tracking: v=1; b=H4sIACWld2gC/x2Myw5AMBAAf0X2bBNV9foVcaAWeynplkik/65xn
 GRmXhDyTAJ99oKnm4UPl0DlGdh9chshL4mhLEpTNKrGlR8U3twULk8YSAIuhxXU2lirurWdqw5
 SfXpK6n8exhg/S5ENLGkAAAA=
X-Change-ID: 20250716-fix-signature-test-docs-335cc19f8b49
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, ekovsky@redhat.com, 
 Enric Balletbo i Serra <eballetbo@kernel.org>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Wed, 16 Jul 2025 15:29:17 +0200
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

Update the FIT signature testing instructions to use the pytest suite instead of
the old vboot_test.sh script.

Signed-off-by: Enric Balletbo i Serra <eballetbo@kernel.org>
---
 doc/usage/fit/signature.rst | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index b868dcbf9fdb28e85128d402478e3120dafcca2f..e5b5a8432e9eb1cb8ba727dc26e1e3a46cb41f51 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -433,16 +433,14 @@ CONFIG_LEGACY_IMAGE_FORMAT
 Testing
 -------
 
-An easy way to test signing and verification is to use the test script
-provided in test/vboot/vboot_test.sh. This uses sandbox (a special version
+An easy way to test signing and verification is to use the vboot tests
+provided in the pytest suite. This uses sandbox (a special version
 of U-Boot which runs under Linux) to show the operation of a 'bootm'
 command loading and verifying images.
 
 A sample run is show below::
 
-    $ make O=sandbox sandbox_config
-    $ make O=sandbox
-    $ O=sandbox ./test/vboot/vboot_test.sh
+    $ ./test/py/test.py --bd sandbox --build -k vboot
 
 
 Simple Verified Boot Test

---
base-commit: bcc7bc69b92ab728790aea0d08b2ae5e22d3b09d
change-id: 20250716-fix-signature-test-docs-335cc19f8b49

Best regards,
-- 
Enric Balletbo i Serra <eballetbo@kernel.org>

