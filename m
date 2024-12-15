Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749EEE7717F
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 15:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E192C8004F;
	Sun, 15 Dec 2024 16:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h6dUCQnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC1D80050; Sun, 15 Dec 2024 16:38:47 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01ADE80040
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 30413A409EF;
 Sun, 15 Dec 2024 15:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1DECC4CECE;
 Sun, 15 Dec 2024 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734277123;
 bh=39QV41vxrE4hnHgZU0Sy08hdspebMM35UmH+0aRymQE=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=h6dUCQnbvO6TNACYxPlSxIadvRhK4lzr1cxVhO3am7YaQhrAEBcm5xhRACvvZTTpA
 1SQtC2Pn4G5Opqs8PLXO1QNj6s+t71d20gDgJbah9utzITT1YwB1rf6eigr401JrPg
 mVAFLpJmE4SZMYUHPYIbMA5QuxfxD6v/Ub2IB5sT5WVrNOObvPx8nwbELumFHznBd5
 pDe93GRFfT+Ufeyyg4fE8bim0l85hFb4K2frPUmBTGMnDDpItHarnig5kICyzi3RM7
 hPF20d6wXeit6ENjt6ivKN/BFTXpXG11xCBkirgLhDygSYjw/jjHS3rh6BTMFSEjoP
 9ZqXWeAN0WVKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AED53E7716A;
 Sun, 15 Dec 2024 15:38:43 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 15 Dec 2024 16:38:29 +0100
Subject: [PATCH] doc: fit: Format image tree source example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-fdt-fmt-v1-1-81f8b27b6eb3@posteo.net>
X-B4-Tracking: v=1; b=H4sIAPT3XmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Mj3bSUEt203BLdVMNUQ8vkNGMTY7M0JaDqgqLUtMwKsEnRsbW1AA4
 PRY1ZAAAA
X-Change-ID: 20241212-fdt-fmt-e1e19cf3436f
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734277122; l=3156;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=Fe/VvMe3FkkIkQQKWTv32RL7TTOwDYeL00kYy3ByvZY=;
 b=pAkLTkamxuqGOIIGxaxUE/vJlHFfHoNAY8HKxJe/QOHybA2QnrNXhAJ3dlEWakqK8oJTGZTXG
 gS3fjfFnF31BnAiypk2CJZVw3M/UFj7iPmeCoKuo38HyN8yolPDSr7g
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

The example in kernel_fdt.rst is inconsistently indented, making it
difficult to read.

Indent the example with the same standard as the other examples:
Four spaces for the ReST code block and for every nesting level.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 doc/usage/fit/kernel_fdt.rst | 88 ++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/doc/usage/fit/kernel_fdt.rst b/doc/usage/fit/kernel_fdt.rst
index 9cc26fb7831e4bc244c4843645221f9643c0c1ae..3802c8292d6c5f6f30301db314d2740a52558c9d 100644
--- a/doc/usage/fit/kernel_fdt.rst
+++ b/doc/usage/fit/kernel_fdt.rst
@@ -5,50 +5,50 @@ Single kernel and FDT blob
 
 ::
 
-	/dts-v1/;
+    /dts-v1/;
 
-	/ {
-	description = "Simple image with single Linux kernel and FDT blob";
-	#address-cells = <1>;
+    / {
+        description = "Simple image with single Linux kernel and FDT blob";
+        #address-cells = <1>;
 
-	images {
-		kernel {
-		description = "Vanilla Linux kernel";
-		data = /incbin/("./vmlinux.bin.gz");
-		type = "kernel";
-		arch = "ppc";
-		os = "linux";
-		compression = "gzip";
-		load = <00000000>;
-		entry = <00000000>;
-		hash-1 {
-			algo = "crc32";
-		};
-		hash-2 {
-			algo = "sha256";
-		};
-		};
-		fdt-1 {
-		description = "Flattened Device Tree blob";
-		data = /incbin/("./target.dtb");
-		type = "flat_dt";
-		arch = "ppc";
-		compression = "none";
-		hash-1 {
-			algo = "crc32";
-		};
-		hash-2 {
-			algo = "sha256";
-		};
-		};
-	};
+        images {
+            kernel {
+                description = "Vanilla Linux kernel";
+                data = /incbin/("./vmlinux.bin.gz");
+                type = "kernel";
+                arch = "ppc";
+                os = "linux";
+                compression = "gzip";
+                load = <00000000>;
+                entry = <00000000>;
+                hash-1 {
+                    algo = "crc32";
+                };
+                hash-2 {
+                    algo = "sha256";
+                };
+            };
+            fdt-1 {
+                description = "Flattened Device Tree blob";
+                data = /incbin/("./target.dtb");
+                type = "flat_dt";
+                arch = "ppc";
+                compression = "none";
+                hash-1 {
+                    algo = "crc32";
+                };
+                hash-2 {
+                    algo = "sha256";
+                };
+            };
+        };
 
-	configurations {
-		default = "conf-1";
-		conf-1 {
-		description = "Boot Linux kernel with FDT blob";
-		kernel = "kernel";
-		fdt = "fdt-1";
-		};
-	};
-	};
+        configurations {
+            default = "conf-1";
+            conf-1 {
+                description = "Boot Linux kernel with FDT blob";
+                kernel = "kernel";
+                fdt = "fdt-1";
+            };
+        };
+    };

---
base-commit: 8aab7730c1c26192b0e4218fbf2f6009f955cb88
change-id: 20241212-fdt-fmt-e1e19cf3436f

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


