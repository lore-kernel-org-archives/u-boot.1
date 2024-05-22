Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C789EC25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9F68887C;
	Wed, 22 May 2024 19:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="GAshdLtV";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="l8j10ST7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC97D88856; Wed, 22 May 2024 19:08:25 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997AD888CD
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id CC1F5180012A;
 Wed, 22 May 2024 13:08:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Wed, 22 May 2024 13:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716397701;
 x=1716484101; bh=/sDmxfSO7f2toOqe3/zpmVPSWYm1qhR7PdAHJprlCok=; b=
 GAshdLtV9jEkq/f3fvslR2LRIuLWm1L5HDyC9yWwXOGI1hn6i9CX6z9i/GOt9eXQ
 TXwpOL2wRKjXSFP66ETBc57d4AtHl1Mg+n8UOr0V6GWvPPCIFjuJGHLXqXKlfVJr
 qel61J751fwWH95HUVHNoaGKy/Yi09kv+c/jslDb1YR6NlOGGqgRHVgcIWIR2eZz
 QbjmyfKQC+vFGAlYxsJw2o3zCHt8KkVGhudIk2dGH1y7Pr02IrZ3Ov3cHlwwtSY5
 uQ2Zd7CMUYOS/sL2/TbsAaPdv73jM2eimg30HssaBFCubReJeNw5uofD3VT2NJHp
 B8Z5yyzNGbMrm/NoajSu3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716397701; x=
 1716484101; bh=/sDmxfSO7f2toOqe3/zpmVPSWYm1qhR7PdAHJprlCok=; b=l
 8j10ST7TtRHozKZ59CvciYK2cl5potL6OvKpzGFNASKRy1RTthJfibm0o/B+ZdSu
 FO/m89Wwqa1iOer+SUb83kMvWg3hXj2sRxfvDjFXmTKRvN2jS0fHhzOa3m9JdXv+
 K/VQ84lybVsTZsHTe7nkp8TnBdrSDjjXE6/4efN1HD538A/iIc1eMqxzozASEuNG
 QFpprY3eLmB8tPJ+3sloX7m+cPHAEKp5NDiAeKgMiLDv93JCwlK5C5RbsZ/gphuE
 1VTurCO6hV2YUGANNJ9eF2SVUhZOhjGGV7VxiL0nUCnEjNoxPxL8dEZTLNUpGBj4
 FjMtbhhhAJLhv0iX1Ijwg==
X-ME-Sender: <xms:hSZOZlT1YndjKZPRILoUF7Mcwsfey6h6Il704ZjHBMrQWe_80lPJVQ>
 <xme:hSZOZuwI8gaSs_8z28xnEy_Qa3dECohOFSH49srTpyyzyaB6xUTjwA9idjlp67WBY
 Gl2bl_71c6YPKm0rcw>
X-ME-Received: <xmr:hSZOZq0sAkL0w6YUHQLjbcw2_KN35hMKSztRIl2TkwGmJFDfOh0jzfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:hSZOZtDfb4mMNgUzx4dXrNrvEJHMVuMek6-IR-XTQ6rEEQyTyRl4NQ>
 <xmx:hSZOZujvuvdYMy9-BLylR9dRq0ERCsNIqQXX7O54UKS3IFFv8tjJ8w>
 <xmx:hSZOZhoy6UiB8XmCkJN_gT_eNYBXV4VMhRcxF_N6ACVTtTUyWNU6kg>
 <xmx:hSZOZphC47yBVmoEi8K13EhZQO7IknYNciWl313m4z-I-meXYWiDQg>
 <xmx:hSZOZpVXiGsspzZQF98sVPEGntGetWEGOIELwszEoY4ttA0bZwUPgJA4>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:08:20 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 18:08:06 +0100
Subject: [PATCH v2 10/10] doc: New documentation for qemu-xtensa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-qemu-xtensa-v2-10-04bf7e42b10b@flygoat.com>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=NOevvt9WMqm9xcU/3sAgSbYsmhnh8X+Pww0+w0gyylw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tfxl+n+F374TKO+YreDwvfvE1/ioDaKXYpOXOxVb8
 /yokvvZUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABN5dYnhf5qQz/rNBZYax59V
 Nngttb9QYl93Lb5V9FarBsOffYapnxj+2e1YksR4OXCqLM+bC2LMAoff73m886FnfPm3O+fFvbe
 HMAIA
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

Introduce the board and provide instructions on how to get
it work.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 doc/board/emulation/index.rst       |  1 +
 doc/board/emulation/qemu-xtensa.rst | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index d3d6b8f3d86b..98a0b26ad245 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -14,3 +14,4 @@ Emulation
    qemu-ppce500
    qemu-riscv
    qemu-x86
+   qemu-xtensa
diff --git a/doc/board/emulation/qemu-xtensa.rst b/doc/board/emulation/qemu-xtensa.rst
new file mode 100644
index 000000000000..fdab6d7c439d
--- /dev/null
+++ b/doc/board/emulation/qemu-xtensa.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+QEMU Xtensa
+===========
+
+QEMU for Xtensa supports a special 'virt' machine designed for emulation and
+virtualization purposes. This document describes how to run U-Boot under it.
+
+The QEMU virt machine models a generic Xtensa virtual machine with PCI Bus
+and Xtensa ISS simcall semihosting support. It supports many different Xtensa
+CPU configuration. Currently, only dc232b variant is tested against U-Boot.
+
+Building U-Boot
+---------------
+Set the CROSS_COMPILE environment variable as usual, and run:
+
+    make qemu-xtensa-dc232b_defconfig
+    make
+
+Note that Xtensa's toolchain is bounded to CPU configuration, you must use
+the toolchain built for exactly the same CPU configuration as you selected
+in U-Boot.
+
+Running U-Boot
+--------------
+The minimal QEMU command line to get U-Boot up and running is:
+
+    qemu-system-xtensa -nographic -machine virt -cpu dc232b -semihosting -kernel ./u-boot.elf
+
+You many change cpu option to match your U-Boot CPU type configuration.
+semihosting option is mandatory because this is the only way to interact
+with U-Boot in command line.

-- 
2.43.0

