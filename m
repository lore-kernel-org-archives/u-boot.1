Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0A3C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABB388667;
	Sun, 19 May 2024 22:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="laWOLH3t";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="P3aPpAW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1912288223; Sun, 19 May 2024 22:54:06 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1667A88685
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 4D07C13808CB;
 Sun, 19 May 2024 16:54:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 19 May 2024 16:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716152043;
 x=1716238443; bh=/sDmxfSO7f2toOqe3/zpmVPSWYm1qhR7PdAHJprlCok=; b=
 laWOLH3tMrZML3SczA7Axq+QxocL3hvXv+Dy2dWx4AXUZE8KFbA7D+OMyJMlp/+N
 2EwT4HkcNwa38OR3XVvy7oHP9xwymnykWNXSeMTMs4nZIHSRu4yYXKgW60nFq1BC
 LzDWPnAapCX2Pbjxqae+2Y2ln1V9K/fXpldIzkV7lGOAcvkSgwS3iRq/HuEkv4wu
 vKbKE+V9PmuB3PspxpuFpRU2i01IZXYPYjvLZTZ1NX2H3He5MRmZ3Vm1UNQsejco
 eiaaRMUjcD4Wrx0q0UU6lRiauO+gPKjvFADSj9Hv4XnFqxBfoOZbr2G0jsUMuKdy
 iINKgwb1WtqnT/NafFYs5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716152043; x=
 1716238443; bh=/sDmxfSO7f2toOqe3/zpmVPSWYm1qhR7PdAHJprlCok=; b=P
 3aPpAW+/N9CfNj1vq0xAFqAKu0ZrnX3imTMKtnDHLG5LS3R9/xjGPQWUtB8t9DYq
 46Y05eNg42YM8ufIJk1i3S6KYvRnKm+/5NMVoa7CovKKegxV6YbHzRaRDMQR3IVa
 d1Rs/2s5q+nKFWlOQAbIGabQWkF2YMXB2LnWtjJ6FLFEHul1y6kzb+KmKxEmgasB
 58JpZ9ZPzPs1vlaPbHD9OOhGmCsWqw1OUaIvrGEbby/uWbdHDeiYr751WJjeWXlc
 DwWY9G7CZBDmx6FrIiQDgY68Fi96wYwgoJss2UBlAWRBJgRNao7ZvBm/aGFlltQe
 OUwFRzExIVvI5lQxcsRGw==
X-ME-Sender: <xms:62ZKZmhqGJHja6yM3okpdqSQ2okCfMg_QuT3vNnMajArXK-a8ntCqg>
 <xme:62ZKZnDa1EYTA9jNtJHQRDG0Wb-N-OYXZyqbvqEKbkNtxRgWhxEMx4tsOpZ5vWhje
 EIFvKEXeIIs1WXjkD0>
X-ME-Received: <xmr:62ZKZuH5gdsku45iAzvomDyKVBL2ByCVeIUn2h-egLX7dnbZi625D50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:62ZKZvT2JvswqMURObEC9VJni4bkqxKj12bb5ZAx5jQYnObbpwbrVg>
 <xmx:62ZKZjwiqm6fwItcSsxH2GHkBwpRrpWsSA1b8fhdiMlAN3d5Vg6zWw>
 <xmx:62ZKZt4XaRGJV7-iMG5SpDasx0GGhSpNogIZ9MEr6Zu2C3ssZU2Vkg>
 <xmx:62ZKZgwvdsy2B2fn4IRfCvFrDveRrRJ7AEzOkyhkH-_Kjo4S8yEk7A>
 <xmx:62ZKZqk5lep83E0YqI2jW3PwR2cd_eBclp3Wsqd5zn6oKkchc7jdmvyn>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 16:54:02 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 21:53:57 +0100
Subject: [PATCH 10/10] doc: New documentation for qemu-xtensa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-qemu-xtensa-v1-10-8fff0cb11c19@flygoat.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=NOevvt9WMqm9xcU/3sAgSbYsmhnh8X+Pww0+w0gyylw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjSvtHtNkR5KS10TJ8iozBPr3/K7dS1vpq3+KccqIZlTF
 o5/Uyw6SlkYxLgYZMUUWUIElPo2NF5ccP1B1h+YOaxMIEMYuDgFYCIP7Rj+e5n3p11bXPrl2ocd
 8YJ+KfYHfJZ/DvvM4VnXs+7uSWcXJob/qbENy+u+qwu6aN+5bPT4eaGNZ1Vk4Ze3283mvq2+sl2
 KGQA=
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

