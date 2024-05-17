Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E8DC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 11:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FECC882DA;
	Fri, 17 May 2024 13:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="DvlHhW2z";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ay95BSqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A87BD88375; Fri, 17 May 2024 13:45:30 +0200 (CEST)
Received: from fhigh3-smtp.messagingengine.com
 (fhigh3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D21D0801BA
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 13:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id CE56611400DB;
 Fri, 17 May 2024 07:45:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 17 May 2024 07:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715946326; x=1716032726; bh=sT
 0P5CfO8ggJkO1bJPtg5kwwH6/HxHEw1WNbKMzbuKE=; b=DvlHhW2zdIsGpD6SEc
 VVjN+/wQO25QkgMal30Qhi/7SU8PiP07iou5XGAX/tOks3ZxQc3xZIDxPGULI7VR
 h0M3osY605b/Eq/XjU2/43JlQyJ/fiayA1jTFYlQ/Y33rsUTgloiKKozCdM7uD/A
 x9wTWuXySVAQJGvbI7lE9Bs3S8vBcxBrWi4sFwzMKmcKle/hCepv32owLcWG3G71
 kcVB4XsSZwgPgHACN7AXRwtkO3fPwJqXIesKdbO83KleGHhD5SVbJYcQTYbeLLdI
 SJNxQXi0j634UpzwdYZBy62BPyfTlxr4BS9V7hLOQ7LLlIo5ml9PlTdUAnjRMTBn
 5/zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715946326; x=1716032726; bh=sT0P5CfO8ggJk
 O1bJPtg5kwwH6/HxHEw1WNbKMzbuKE=; b=Ay95BSqThWeukGYSQnrdc0owm4hNr
 gPJOqDCJeZYhRdGilHgLEXorSRXfbFxY0YdrtPEDr021p47jQJW0idSmKZdVb4CU
 TjIXjEigdc3D848AEuFZtGtPQdi8k2bJ7shOqhFQBKbjMSHY/y8+/zNFctjBXlgd
 A1Asd1aUNGjeAkxi9GkSnvbhlRQDlTPwmPmG1w9V8FPUg+FvpfGK6UGQD4eElPGQ
 7Nxe3l8nQc9ehsfbQtrN9pg6A4AAEem/hxCTPsXCRRBucQYgu3YPHHOZpuXdZCjW
 YMg9eLxzjeziX4pyQapP6dobCGVuFAHwGArTniPJF3ivpPew+/J1uVUQA==
X-ME-Sender: <xms:VkNHZkmD7aZMlIhwg5CukL8zE0FuKigZGiAAYDf3eE1GYEfQpwPrpA>
 <xme:VkNHZj2YVhQDOAionLPAJrNlaDgznvij8B9VriWLopmpti5WNGLDMad5m_h7-AZ4d
 w-yOdo1ep3cwev74Ko>
X-ME-Received: <xmr:VkNHZir4QautUtC3UfmXIKxVK1EIt_JiueJPzLSprG6ArX_EJd_1OU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgleeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepffetueegkedtgfejveeuvdfghfegtddvgfehudeghfegheetuedu
 heduveejtefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:VkNHZgnSp6cvtzQPGAToRgSVeRx_AokS4VeNLyMmEtKErO-Pzk3WwQ>
 <xmx:VkNHZi1IuNMcwGXof3wfhl8XFxp5kiVtZBxYsNJ3fncrdTKd_DvvQQ>
 <xmx:VkNHZnvFscb10GaQ15MCgK76A2nlj_dkcQM1GMXKQxgj9IoVXSXTfw>
 <xmx:VkNHZuUoH3u4Y1COvRM7_gavjveQOjuQTt3hytgHI2yKaSHGj_rOPg>
 <xmx:VkNHZlQPdbJRM6BSi75NbP5iyx_7_TYbdXF6mqlfPZgVMYg4mupY_pQX>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 07:45:25 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 12:45:17 +0100
Subject: [PATCH RFC] doc: Document address spaces used by U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-address-spaces-v1-1-93e14c260b73@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAExDR2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0Nz3cSUlKLU4mLd4oLE5NRiXcNk4yTLZGNzyyRDYyWgpoKi1LTMCrC
 B0UpBbs5KsbW1AM2wCFxlAAAA
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4808;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=vwjJs6qO2H9zIImz0mjFG3WXek0F0G1VIaRrLLcSA10=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjR351DuwtfPk1r/FcTMNCvgajhkonsmxnzJue2vLkdMK
 j0btXR5RykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExkUycjQ//kG/4nds69y82+
 RWjDQ+c/yUylhSo3ft/evFh63Y0DvdYM/ysLr+W4SecV7Oa58sbVXksyOGads1JzTfx20etN9o+
 /sAAA
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

This serves as a reference for developers on how to handle
all those address spaces for U-Boot.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Hi all,

I was trying to clear up long standing myth of virtual
address vs physical adddress mapping on MIPS by having
a clear division betweem virt and phys adddress everywhere.

In this process I would like to confirm my understanding
by writing a document and requesting comments from the
community.

Note that there are some sysmem APIs mentioned in the document
are not in U-Boot tree, namely ``sysmem_addr_t`` and sysmem_to_phys
co. I think they can help with annotating address spaces.

Please kindly comment on the design.

Thanks!
---
 doc/develop/address_spaces.rst | 73 ++++++++++++++++++++++++++++++++++++++++++
 doc/develop/index.rst          |  1 +
 2 files changed, 74 insertions(+)

diff --git a/doc/develop/address_spaces.rst b/doc/develop/address_spaces.rst
new file mode 100644
index 000000000000..05c4a1575f27
--- /dev/null
+++ b/doc/develop/address_spaces.rst
@@ -0,0 +1,73 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+Address Spaces
+==============
+
+Introduction
+------------
+
+In U-Boot, we have three address spaces that are used to describe a memory
+address:
+
+    - ``virt``: virtual address space
+    - ``phys``: physical address space
+    - ``sysmem``: system memory address space
+
+On most architectures, we maintain a 1:1:1 mapping between all three address,
+with the exception of MIPS and sandbox.
+
+There are many API misused in existing code base, this document is to clarify
+the usage of these address spaces and APIs. Hopefully it will help to reduce
+the confusion and porting effort.
+
+``virt``
+--------
+
+This is the address space that is directly used by U-Boot to access memory.
+Every pointer in U-Boot must in ``virt`` address space. to get a valid ``virt``
+address from any other address space, you must use relavant mapping functions
+to ensure it's being tracked. It is recomanded to use ``ulong`` or pointer types
+to store ``virt`` address.
+
+``phys``
+--------
+
+This is the address space that is used to describe the physical memory address.
+It's used to describe the physical memory address of a device, or the physical
+memory address of a memory region. Usual places you would see ``phys`` address
+are addresses comes from Device Tree and some memory related APIs. It is
+recommended to use ``fdt_addr_t`` or ``phys_addr_t`` to store ``phys`` address.
+
+Following APIs are availble to handle ``phys`` address:
+
+    - ``map_physmem()``: Create mapping from physical address to virtual address
+    - ``unmap_physmem()``: Remove mapping created by ``map_physmem()``
+    - ``virt_to_phys()``: Find physical address mapping for a virtual address
+    - ``ioremap()``: Create mapping for I/O memory region
+    - ``iounmap()``: Remove mapping created by ``ioremap()``
+
+``sysmem``
+----------
+
+This is the address space that is used by U-Boot internally to describe RAM
+address. It helps to abstract some architecture differences and provide a
+consistent way to managed RAM. Usual places you would see ``sysmem`` address
+are addresses comes from ``gd->bd->bi_dram[]``, addresses comes from ``LMB``
+addresses being used as memory related config optinos, and addresses being
+used as arguments to load commands. It is recommended to use ``sysmem_addr_t``
+to store ``sysmem`` address.
+
+It is further used by sandbox to simulate memory, and by MIPS to handle
+differences between ``virt`` and ``phys`` address spaces.
+
+Following APIs are availble to handle ``sysmem`` address:
+
+    - ``map_sysmem()``: Create mapping from system memory address to virtual address
+    - ``unmap_sysmem()``: Remove mapping created by ``map_sysmem()``
+    - ``map_to_sysmem()``: Find system memory address mapping for a virtual address
+    - ``sysmem_to_phys()``: Find physical address mapping for a system memory address
+    - ``phys_to_sysmem()``: Find system memory address mapping for a physical address
+    - ``nomap_sysmem()``: Pass through an address unchanged (For sandbox tracking)
+    - ``nomap_to_sysmem()``: Pass through an address unchanged
+
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index f82e148b101c..1b8e11cd2f24 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -27,6 +27,7 @@ Implementation
 .. toctree::
    :maxdepth: 1
 
+   address_spaces
    directories
    bloblist
    bootstd

---
base-commit: ad7dce5abd49ef3b5c93da5303e15449c8c162b4
change-id: 20240517-address-spaces-1c3b9c379b13

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

