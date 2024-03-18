Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8030CC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 15:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65BA87F70;
	Mon, 18 Mar 2024 16:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CLLX4B2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7E9C87F6F; Mon, 18 Mar 2024 16:17:34 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD027874B1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D156ECE0AC9;
 Mon, 18 Mar 2024 15:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94950C433F1;
 Mon, 18 Mar 2024 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710775049;
 bh=ouPDThnmI2WpQt7MloshleQEspDA6HWjRk8nRDMATWg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CLLX4B2v0Zhaajvl3SKRFlPS2s4CqSnYJ/IH7/nXjS+4FuH4FNAVRndf2nWFpShoD
 yimWkLmSMzI6B92pL7+uq32+IfKjFX5lC1EJjtHrmmkTx/oWiBiEUa17d5h4kvF1ZV
 zhV9ICEwsijG8Avu5vueUIlNtPv4F13Z/7pyhb6eDbMaP0GV7dCGMu1mpbNbIUpTWW
 di7W1j7HGpVCgVnniH7UCyOuRxLzwMC0EuQfmFcygV9H2PhUAFEMVDyCGw/NR4cBUG
 OZV8nrhqav2cnqw6ewClgMNUfpsTF+pYiMAWIVb3vyNaaZkWUiaC05zclakgIxnzvL
 OFPdmdmjUUenQ==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v1 1/2] riscv: don't read riscv,
 isa in the riscv cpu's get_desc()
Date: Mon, 18 Mar 2024 15:16:02 +0000
Message-ID: <20240318151604.865025-3-conor@kernel.org>
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

cpu_get_desc() for the RISC-V CPU currently reads "riscv,isa" to get
the description, but it is no longer a required property and cannot be
assummed to always be present, as the new "riscv,isa-extensions" and
"riscv,isa-base" properties may be present instead.

On RISC-V, cpu_get_desc() has two main uses - firstly providing an
informational name for the CPU for smbios or at boot with
DISPLAY_CPUINFO etc and secondly it forms the basis of ISA extension
detection in supports_extension() as it returns (a portion of) an ISA
string.

cpu_get_desc() returns a string, which aligned with "riscv,isa" but
the new property is a list of strings. Rather than add support for
the list of strings property, which would require creating an isa
string from "riscv,isa-extensions", modify the RISC-V CPU's
implementaion of cpu_get_desc() return the first compatible as the
cpu description instead. This may be fine for the informational cases,
but it would break extension dtection, given supports_extension()
expects cpu_get_desc() to return an ISA string.

Call dev_read_string() directly in supports_extension() to get the
contents of "riscv,isa" so that extension detection remains functional.
As a knock-on affect of this change, extension detection is no longer
broken for long ISA strings. Previously if the ISA string exceeded the
32 element array that supports_extension() passed to cpu_get_desc(),
it would return ENOSPC and no extensions would be detected.
This bug probably had no impact as U-Boot does not currently do anything
meaningful with the results of supports_extension() and most SoCs
supported by U-Boot don't have anywhere near that complex of an ISA
string. The QEMU virt machine's CPUs do however, so extension detection
doesn't work there.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I'm not really sure if I am happy with this patch - people could
definitely have got use out of the cpu info printout of the ISA string
before this patch - they'd have seen something like
CPU:	rv64imafdc
at boot, but now they will see
CPU:	sifive,u74
If it really is desired, cpu_get_desc() could be made to assemble
an isa string out of "riscv,isa-extensions", but I think it's always
gonna be a bit flawed, since that string can run to almost arbitrary
length now - one I saw for a CPU last week was 320 characters long
and these things are only going to grow.
---
 arch/riscv/cpu/cpu.c    | 12 +++++++-----
 drivers/cpu/riscv_cpu.c |  8 ++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index ecfefa1a02..99083e11df 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -39,7 +39,7 @@ static inline bool supports_extension(char ext)
 	return csr_read(CSR_MISA) & (1 << (ext - 'a'));
 #elif CONFIG_CPU
 	struct udevice *dev;
-	char desc[32];
+	const char *isa;
 	int i;
 
 	uclass_find_first_device(UCLASS_CPU, &dev);
@@ -47,12 +47,14 @@ static inline bool supports_extension(char ext)
 		debug("unable to find the RISC-V cpu device\n");
 		return false;
 	}
-	if (!cpu_get_desc(dev, desc, sizeof(desc))) {
+
+	isa = dev_read_string(dev, "riscv,isa");
+	if (isa) {
 		/*
 		 * skip the first 4 characters (rv32|rv64)
 		 */
-		for (i = 4; i < sizeof(desc); i++) {
-			switch (desc[i]) {
+		for (i = 4; i < sizeof(isa); i++) {
+			switch (isa[i]) {
 			case 's':
 			case 'x':
 			case 'z':
@@ -64,7 +66,7 @@ static inline bool supports_extension(char ext)
 				 */
 				return false;
 			default:
-				if (desc[i] == ext)
+				if (isa[i] == ext)
 					return true;
 			}
 		}
diff --git a/drivers/cpu/riscv_cpu.c b/drivers/cpu/riscv_cpu.c
index 5d1026b37d..9b1950efe0 100644
--- a/drivers/cpu/riscv_cpu.c
+++ b/drivers/cpu/riscv_cpu.c
@@ -21,13 +21,13 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static int riscv_cpu_get_desc(const struct udevice *dev, char *buf, int size)
 {
-	const char *isa;
+	const char *cpu;
 
-	isa = dev_read_string(dev, "riscv,isa");
-	if (size < (strlen(isa) + 1))
+	cpu = dev_read_string(dev, "compatible");
+	if (size < (strlen(cpu) + 1))
 		return -ENOSPC;
 
-	strcpy(buf, isa);
+	strcpy(buf, cpu);
 
 	return 0;
 }
-- 
2.43.0

