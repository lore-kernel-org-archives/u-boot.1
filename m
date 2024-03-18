Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216F4C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 15:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F79387FE0;
	Mon, 18 Mar 2024 16:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tO/K7PEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C778987FE0; Mon, 18 Mar 2024 16:17:36 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8C787F5E
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4AA9260C54;
 Mon, 18 Mar 2024 15:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59893C433C7;
 Mon, 18 Mar 2024 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710775051;
 bh=VuSwf2Yr/QFYC9SOzpzTepzqb+e668/3bv/HswrbOT8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tO/K7PEdCpG6qd6KMi9G8komDrQrA8oujUmS+HR7Fm6GTcUs82wiCuPXZ0aieYVtd
 e/ciUGhhx+gnlZdmU99F4wYTcG2VLqCcKDDu4XL4QByR0ZjkmnVGrpXAghRhU6S1hl
 KBqltHGjB0hnvW5iiLPK6IGNuRBYesd6iYDOWB9MMCptxS3bsCK4RUtVa1vxNM24p0
 oAzZktFMy1tAW7WXahEv+fpxKSMOTfsJZgG+WKH0L5SANNpiViwNA2a61CYb2xdUPW
 z9OA53c7/3bhefA7JoHNLK5GRrCy2tFIfGPY5dVsOlJ1rG04jWmZ2qid3iqiwSWTYk
 DCwl1ZSrPMJyw==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v1 2/2] riscv: support extension probing using riscv,
 isa-extensions
Date: Mon, 18 Mar 2024 15:16:03 +0000
Message-ID: <20240318151604.865025-4-conor@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318151604.865025-2-conor@kernel.org>
References: <20240318151604.865025-2-conor@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

A new property has been added, with an extensive rationale at [1], that
can be used in place of "riscv,isa" to indicate what extensions are
supported by a given platform that is a list of strings rather than a
single string. There are some differences between the new property,
"riscv,isa-extensions" and the incumbent "riscv,isa" - chief among them
for the sake of parsing being the list of strings, as opposed to a
string. Another advantage is strictly defined meanings for each string
in a dt-binding, rather than deriving meaning from RVI standards. This
will likely to some divergence over time, but U-Boot's current use of
extension detection is very limited - there are just four callsites of
supports_extension() in mainline U-Boot.

These checks are limited to two checks for FPU support and two checks
for "s" and "u". "s" and "u" are not supported by the new property, but
they were also not permitted in "riscv,isa". These checks are only
meaningful (or run) in M-Mode, in which case supports_extension() does
not parse the devicetree anyway.

Add support for the new property in U-Boot, prioritising it, before
falling back to the, now deprecated, "riscv,isa" property if it is not
present.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I moved the kernel devicetrees to use the new properties, I'd do the
same here, but I'd rather just move things to use dt-rebasing instead,
where possible.
---
 arch/riscv/cpu/cpu.c | 56 +++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index 99083e11df..affe70081b 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -38,9 +38,10 @@ static inline bool supports_extension(char ext)
 #if CONFIG_IS_ENABLED(RISCV_MMODE)
 	return csr_read(CSR_MISA) & (1 << (ext - 'a'));
 #elif CONFIG_CPU
+	char sext[2] = {ext};
 	struct udevice *dev;
 	const char *isa;
-	int i;
+	int ret, i;
 
 	uclass_find_first_device(UCLASS_CPU, &dev);
 	if (!dev) {
@@ -48,27 +49,40 @@ static inline bool supports_extension(char ext)
 		return false;
 	}
 
+	ret = dev_read_stringlist_search(dev, "riscv,isa-extensions", sext);
+	if (ret >= 0)
+		return true;
+
+	/*
+	 * Only if the property is not found (ENODATA) is the fallback to
+	 * riscv,isa used, otherwise the extension is not present in this
+	 * CPU.
+	 */
+	if (ret != -ENODATA)
+		return false;
+
 	isa = dev_read_string(dev, "riscv,isa");
-	if (isa) {
-		/*
-		 * skip the first 4 characters (rv32|rv64)
-		 */
-		for (i = 4; i < sizeof(isa); i++) {
-			switch (isa[i]) {
-			case 's':
-			case 'x':
-			case 'z':
-			case '_':
-			case '\0':
-				/*
-				 * Any of these characters mean the single
-				 * letter extensions have all been consumed.
-				 */
-				return false;
-			default:
-				if (isa[i] == ext)
-					return true;
-			}
+	if (!isa)
+		return false;
+
+	/*
+	 * Skip the first 4 characters (rv32|rv64).
+	 */
+	for (i = 4; i < sizeof(isa); i++) {
+		switch (isa[i]) {
+		case 's':
+		case 'x':
+		case 'z':
+		case '_':
+		case '\0':
+			/*
+			 * Any of these characters mean the single
+			 * letter extensions have all been consumed.
+			 */
+			return false;
+		default:
+			if (isa[i] == ext)
+				return true;
 		}
 	}
 
-- 
2.43.0

