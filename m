Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3463C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70C9F883E5;
	Tue, 18 Jun 2024 15:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="oUJymRL3";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="FkPKetLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88CD5883F2; Tue, 18 Jun 2024 15:56:45 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A72A883DA
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id A8DAC18000CC;
 Tue, 18 Jun 2024 09:56:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 18 Jun 2024 09:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718719001;
 x=1718805401; bh=kqId2TZI8XjMmriwHcUQveX4AhQfv6mspgmzmUbnNlg=; b=
 oUJymRL3IrKx/vL9FffoQm+AQhYj/oT2YPJLrsd/+xvB843Th0YwIbZQHMrap+xy
 fVeDSpHUMUPTli3uMkArKP0bdesN5/4mhpvz1ZCUxyi7SYKZgktVx1FxTTNYeaFA
 brJkVDbowRRo1strN3cEDD5jcD66BtjPYHog+S0M8g7vRazF77/8DsMHMpL79Qfy
 Fm2fjW2ozSabj2qlBoH6zu6Rv5WlRbqXGZWvKvqkBldlcuZgugFWIRnBIPvTQ+EQ
 Fq/eKDxPwdZCqFIvFtkv65lMq3bJwzU0HLmh+AEQGaAjg2p+A98UC7p6SqqdqR+1
 aISbMQ0AZV59tvLtv/brMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718719001; x=
 1718805401; bh=kqId2TZI8XjMmriwHcUQveX4AhQfv6mspgmzmUbnNlg=; b=F
 kPKetLuULGmx9Zmkts0ewm4b52cjPlmje3iOfZkbVSYKYi9hTXJPTG/rVT/JnWkN
 gSd7EvNi3cSrM2uqfq6IbgHA9jIN98x9UEjdpjxSnNsThXC2J83etuKrAJbP5tgG
 Cc/GBN2k7KmYAf6kCncTGb27ixneo87mGgrBe12RjSs2T+LDb1s70wEVA4aJ0rKb
 xsjG1WR3Qkm9jGsL/AI4JyUmOXz3z5QibpnPI3gojqIA+9gIRR3ifzpW7B+kVVZa
 CY4vTWvT2yAvHerP+BFTjBUey1TWDyCOj0HTENowzpq3yMrBzRaL8JSAEiLfQc1C
 mlwq5++Ct1ME1ocWIqpLQ==
X-ME-Sender: <xms:GZJxZhrMHoS8xQKn-_oYBj9cfiB80OxIWfvbqEeXESu6gq2hCqFZ9g>
 <xme:GZJxZjpfaugn1_sdzNIVVhqR9pr81d2ctSCCSbAeWdpjAIWKv7fAN-v7AGzUUwJH2
 ZTGqsTVS31UP2Gnwfk>
X-ME-Received: <xmr:GZJxZuP_sJOoFsA58iuCLnxVG238Q9HMOuT7E_x-ch64rmOKiidrQ4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:GZJxZs5RauzGXisluf5O0rACNioRKNDssKbjq_K189z6EP_qFoZ7eA>
 <xmx:GZJxZg6t73icvzbPbKv5HYkQHoifMGfZOPBhAjJqoiAjXV_1DaDZhA>
 <xmx:GZJxZkjfVQE-ZSCxe9szAiUTcQShU9gCklmh6lkGfN44YzlufkmZpQ>
 <xmx:GZJxZi5TKHFmZ-WBYRdn0NZBMZXlpqNJ50MSFVEv9eiZ26sa8Azu8Q>
 <xmx:GZJxZttrn7BuEKw6dWqAW4FpZblUpkL4mRNS-6stiM3V7UyjP8Rxhca4>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:40 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:10 +0100
Subject: [PATCH v3 10/12] doc: New documentation for qemu-xtensa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-10-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2099;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=s5vt7uL7mNfZWfN+8X+iKwKKTow3FxVKOFsorIdZ1xI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYzurw5Jfu/NnvMu0GB32kS/+ZfXzVl2nztSfZ3Wg
 0XzHb7e7ChlYRDjYpAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJcGUzMsy48X7H9ekJXacj
 WIT5HaKEQ7exLGXf5Ps8SHsh65nPi/MYGTqOv+E9zvj7nfmTuPkbezYoRj5wZHARWLqRqWFenhl
 fLwcA
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

Tested-by: Max Filippov <jcmvbkbc@gmail.com>
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
index 000000000000..fff23c1a9b0e
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
+CPU configuration. Currently, only dc233c variant is tested against U-Boot.
+
+Building U-Boot
+---------------
+Set the CROSS_COMPILE environment variable as usual, and run:
+
+    make qemu-xtensa-dc233c_defconfig
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
+    qemu-system-xtensa -nographic -machine virt -cpu dc233c -semihosting -kernel ./u-boot.elf
+
+You many change cpu option to match your U-Boot CPU type configuration.
+semihosting option is mandatory because this is the only way to interact
+with U-Boot in command line.

-- 
2.43.0

