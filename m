Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6238CC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60FB88323;
	Mon, 13 May 2024 20:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="PITMrKlA";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="eUY0Q492";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB16687D08; Mon, 13 May 2024 20:13:15 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C28882D5
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 03BF011400B1;
 Mon, 13 May 2024 14:13:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 13 May 2024 14:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715623992;
 x=1715710392; bh=x8LDYv2RenMOlJR07nmGqmXKuo8xzS8MSIcW3Gnujww=; b=
 PITMrKlAjAXoQzvNmMTIQUCjhPfmlEHTaHRkfBGVqkfHhF4lr5cUrd6lPRijYJlr
 V7l/7pGPLM1qABvZB/QPJCHzpALWswxCunrYkmfB/bDiUs5sLNHB0d0PrM7L3NaP
 Ookk1onrRz07grSjZ/pnDQvwMkzgogOU8RkjHZsILXKNyx4XzqEMxNrWWYZohryT
 sr1p6FerSqleY0pwe4Srp2m7bpzS8P5Qmh00AFXip44iNyOevRe8HdAUlLdQlhXw
 ARklPD8WTZ3jb/Z/H3bQpNOCnKva4DGnMd7J+obcw05Q+okqrNKS0s0h6XWti2TC
 ArN73zui4F1vrbVQpC4cJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715623992; x=
 1715710392; bh=x8LDYv2RenMOlJR07nmGqmXKuo8xzS8MSIcW3Gnujww=; b=e
 UY0Q492tNhX3NRPGJd1OrYrrODOBErO7d+ff+4u8iI2xZs8fnYa2pjayssiv5ZqM
 VTI6ofIZnAhe12YUkOZYxh7gAbhePxvV/mlgwULYcrEwtoG76Uz2qvo5GTE2dlqe
 caRqaIwa1ngH8XPZFj31/87bpu48JAiuZfhWuHpVH+AlCSgxP8Aza1FB9L8MsRLA
 yTQsGKXcAJYHaHN98fyEpdvcme538UWPlHvI9H3T6Nz4tPyKhFDdziOUhFIGvjYZ
 ArFz+HuBBoAUGgIhqkXJcUGbkV4/vN1HfO3G4PHVMieOvPjQRAPzqU5ynx0p/gaG
 RfxQ+tXsESLRLFb6yGrGQ==
X-ME-Sender: <xms:OFhCZgC84I5sIIwKfk8ExVHrVv37esZFzd9tvcWs_lmJNQpHYj-fBw>
 <xme:OFhCZigojlZmlrXKcDoap_hfdEFfPp8LYo5R3JphL1tjvfF5IaSjE-cmOOss957Z2
 GlFYdcISxZLEYGo9KM>
X-ME-Received: <xmr:OFhCZjlh2z4qLDl2fqGqrshM4YRoxZaaffJbTxPbuth7uvIg22OcWSM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:OFhCZmwHMTAdvm0UBX6w8Tn7l6zmw1kD8Ndkjqd6JK0SSmxrlTkQlQ>
 <xmx:OFhCZlT1Xk24kwm4RgnkcFcufkCKph_DuivG6PMLg5v-_EX-WQirwg>
 <xmx:OFhCZhaJLsQeqMD7VgN358c05zmNsOIcwwardhNJLf4gHlBHIfayXg>
 <xmx:OFhCZuSz3z2wQQQIUgcaH1H_GL631uwADLmdEYLMWTQU-83bZfrvuw>
 <xmx:OFhCZqKEfZ1xPG1uHQrGnDDIgZCNzdPEhIyifIhxSdgXvtgWoTsDoXHy>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:11 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:13:00 +0100
Subject: [PATCH 03/13] pci: Enable PCI_MAP_SYSTEM_MEMORY when
 ARCH_MAP_SYSMEM is not set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-3-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=845;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=5P0kah0j1rkZJDtXsUvgnBypLjtGpRRBsmtGjzJbCg4=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCOPqbbv4w95NthRNbru5QPVlyb4UBZ6y+JpYLfNLP
 Xn3psh2lLIwiHEwyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwERmLmH4ny885Ux5r7eomN5R
 h1c7M46b/DVolpTrFPVsMZm5K2ZDJiPDGf2wZZp/T752Zlt5zjOBfWHfy4vy16rNeJYLbY2e+Yy
 LFQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-Mailman-Approved-At: Mon, 13 May 2024 20:17:26 +0200
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

For MIPS we are always looking gd->dram in virtual address so
PCI_MAP_SYSTEM_MEMORY should always be enabled.

If in future we ever want to make it physical we have to set
ARCH_MAP_SYSMEM.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/pci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 289d1deb38b6..14f6067fa29b 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -67,6 +67,7 @@ config PCI_CONFIG_HOST_BRIDGE
 config PCI_MAP_SYSTEM_MEMORY
 	bool "Map local system memory from a virtual base address"
 	depends on MIPS
+	default y if !ARCH_MAP_SYSMEM
 	help
 	  Say Y if base address of system memory is being used as a virtual address
 	  instead of a physical address (e.g. on MIPS). The PCI core will then remap

-- 
2.34.1

