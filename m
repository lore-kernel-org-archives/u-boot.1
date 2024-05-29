Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563D8C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 13:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9CE884FF;
	Wed, 29 May 2024 15:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="zvnEwvmH";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y7zIvq3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 705B28854B; Wed, 29 May 2024 15:36:49 +0200 (CEST)
Received: from wfout4-smtp.messagingengine.com
 (wfout4-smtp.messagingengine.com [64.147.123.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 813BE8844E
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 15:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.west.internal (Postfix) with ESMTP id DFBD61C00114;
 Wed, 29 May 2024 09:36:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 29 May 2024 09:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1716989801; x=1717076201; bh=4S
 oU/pVCUAedlGy1X80gejayGFRQwefcFPKjtOpl20s=; b=zvnEwvmHthDYBMp4Iu
 zg/CzhBx0c6J7jfpXPoMZ3frLEMC7RZxwQgJkk0ITD8wzNqVcGY0UVTyXB9RXdcf
 aKFb+mokODT+cXYx1knw8idyDGjaYTfGp5l3q3asJmlyCGur/BcM4b231IcM/Sgz
 foFkJfQn0QG8/0sraXiTHAs2+zgF8x/f+atlQfUZ1gBel4kRISB+0igYS3H20MXV
 9SmGi8ijRHAJRhbTp0cIrhdzgvd5LhhIt8KtQyXguwFsnY5crdwsvzWyejIsGTkQ
 Hn6pX+tGP7hAFv2Sy3hOlqF6tVdV+id7EobQY83AC7HfHY5amKVI47+UaYu3q/3L
 K/mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1716989801; x=1717076201; bh=4SoU/pVCUAedl
 Gy1X80gejayGFRQwefcFPKjtOpl20s=; b=Y7zIvq3l1XyaOD+EFxLRZVvYgOSLe
 K7gELMpCKy+uN3Rlmnizm9zuvwObXvRaJS9hLC8pBhNhmOagA7H1yL8UmIY5a5cA
 YzT5H8j4wZYju5VnszRwwY0dQ+fdyOacvPI5RaujHKXOa9ER66H08yMqdNtc2/Gq
 UUzLEMF3AKmLWLUOwx7Z/jwdbgKdr7NmOQZ8AJF5FE2uLRwfLWTP/k5ZOGJP1Yd7
 maRRaRpRrVNJNHXlqbaDe3OLhRnWNxK99RriVbXpCxtAjw4i+vNG9N2lQJdIlhIB
 ueWUMoBkvEeGcjeOOYeVmv8BoE228NzbqXR7HvwTPEDccBqN3b4Z3Z6EQ==
X-ME-Sender: <xms:aS9XZqJhJIQgLYV_Jluh6qXPr33aAKcEwlBTpzQ4TruLxAjTRzTBAw>
 <xme:aS9XZiI6g7hUrr4y-0OVVB2a8DEll8aDTvPGPPAcUxMDmrUo8gTQA6x9obgpO5jX5
 y_TUqes7ShwnCW25Ck>
X-ME-Received: <xmr:aS9XZquk0oATCqsyIACTHrtlDBVFdhGEemRUbk8CFJJGUx_oT8iqFq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgieegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhephfffgeejgfejieeugffgudegvdekffevgeeuteetgeejveeiteei
 vedvffehlefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:aS9XZvYqKXbOWPw7JHSMr7Anz3lKGcazILmSi80S9QQwd36eHzgJng>
 <xmx:aS9XZhYTLHdxoZ11KPFIqszCq5ONWPLfClVlkabmN_LWo8SAzoqdAA>
 <xmx:aS9XZrCAGIRWrzpKfTvkuv78oePs1l8L6VCXO2omnmPikpm-Uh0x_w>
 <xmx:aS9XZnZ86va0KyDKURvLTQb2fN0NcM8-m8UVFNBcHLgb4mTHLaDepA>
 <xmx:aS9XZkyKMECkWEOyC4evARvuOJyx9DUXqI2gB_8IaTG0tbv2seE3j1CY>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 09:36:40 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 29 May 2024 14:36:39 +0100
Subject: [PATCH] doc: Add UEFI supplement document
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-efi-spec-v1-1-0668e4d19683@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAGYvV2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNL3dS0TN3igtRkXYPURDNTc0sLUyNzIyWg8oIioFQF2Kjo2NpaAD1
 KcEZaAAAA
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4700;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=lsCFOcxW4VQ4QhtXUrJO7/m8R+0AF0yBaqVsa354dgs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRw/Qze+ZetrXn/Pr456+NRD+FL+TPbAts/fmRi4Mu1W
 mP9yWlFRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzELIbhf22Nn+axwNSeX+0b
 T319xtrDoq+z1mWR7ucrRhcEP1YdvMnI0L9wpshKG65AwSk3qtt9uDf+U5n6bJ29/Cy3f6vmPFa
 fzQ4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Add UEFI supplement document to define some behaviours
on architectures not covered by the original specification.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Hi all,

This document is in response to discussion at [1]. It is produced
based on my attempt to port U-Boot UEFI to MIPS and Xtensa. I also
plan to try m68k.

Please review

Thanks
[1]: https://lore.kernel.org/u-boot/CAC_iWjLbY6+FaUYQw2Zv5y5byCnXRHxfzvrFf1dMyJX+ANP9VQ@mail.gmail.com/
---
 doc/develop/uefi/index.rst           |  1 +
 doc/develop/uefi/uefi_supplement.rst | 73 ++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
index e26b1fbe05c5..a274fff88754 100644
--- a/doc/develop/uefi/index.rst
+++ b/doc/develop/uefi/index.rst
@@ -11,6 +11,7 @@ can be run an UEFI payload.
    :maxdepth: 2
 
    uefi.rst
+   uefi_supplement.rst
    u-boot_on_efi.rst
    iscsi.rst
    fwu_updates.rst
diff --git a/doc/develop/uefi/uefi_supplement.rst b/doc/develop/uefi/uefi_supplement.rst
new file mode 100644
index 000000000000..cb20cd290912
--- /dev/null
+++ b/doc/develop/uefi/uefi_supplement.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+U-Boot Supplement to UEFI Specifications
+========================================
+
+Motivation
+----------
+
+The UEFI specifications are designed to be platform-independent, enabling the
+implementation of UEFI-like API support across various architectures. However,
+some platform-dependent aspects and constraints remain. This document provides
+a supplement to the UEFI specifications for U-Boot, clarifying these platform
+dependent details for architectures not covered by the original specifications.
+
+Architectural Conventions
+-------------------------
+
+The UEFI specifications cover IA32, X64, ARM, AARCH64, RISC-V, LoongArch, and
+Itanium architectures. This document extends the UEFI specifications to include
+all architectures supported by U-Boot.
+
+The following conventions are used for these architectures:
+
+- For architectures with multiple ABIs, we adhere to the calling conventions
+  used by the Linux kernel for the same architecture.
+
+- Optional CPU registers (floating-point, SIMD) are excluded from calling
+  conventions. However, the UEFI payload should be able to utilize them if
+  available.
+
+- Control is handed over to the UEFI payload at the privilege level used
+  by the Linux kernel for the same architecture.
+
+- Identity mapping (i.e., VA == PA mapping) is preferred for UEFI. However,
+  this may not be possible for some architectures. In such cases, if the
+  processor supports a default linear translation, it should be used.
+
+- Endianness: UEFI specifications enforce little-endian architectures.
+  However, U-Boot supports both little-endian and big-endian architectures.
+  For big-endian architectures, UEFI data structures should be stored in
+  native endianness, with exceptions explicitly specified.
+
+UEFI Images
+-----------
+
+The UEFI specifications define the PE/COFF image format for UEFI applications.
+U-Boot extends this format as follows:
+
+- **PE32+ Machine Type**: UEFI specifications define machine types for supported
+  architectures. For machines not covered by UEFI specifications, we use the
+  machine type defined by the Microsoft PE/COFF specification if possible.
+  Otherwise, we use the ``IMAGE_FILE_MACHINE_UNKNOWN`` (0) machine type.
+  U-Boot should always accept ``IMAGE_FILE_MACHINE_UNKNOWN`` as a valid
+  machine type.
+
+- **Header Endianness**: PE/COFF header data fields are always stored as
+  little-endian, regardless of the target architecture's endianness.
+
+- **DOS Stub**: To accommodate various boot image formats, we relax the requirement
+  for a DOS stub in the UEFI image. U-Boot should accept UEFI images without a DOS
+  stub and MZ signature. However, U-Boot still expects the PE/COFF header at the
+  file offset specified at offset 0x3C.
+
+I/O Device Access
+-----------------
+
+UEFI specifications define the EFI_DEVICE_IO_PROTOCOL and EFI_PCI_IO_PROTOCOL
+for accessing I/O devices. U-Boot extends these specifications as follows:
+
+- All I/O access is performed using the CPU's native endianness.
+  For big-endian architectures, U-Boot should convert data to/from little-endian
+  before/after accessing I/O devices.

---
base-commit: 46ff00bea5dd2dd247d5e2fdadbf5dcf8653cd9a
change-id: 20240529-efi-spec-0ea657985272

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

