Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F3DC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41DEE88313;
	Thu, 16 May 2024 13:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="OaBtcMtP";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFtm9ehw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B7188335; Thu, 16 May 2024 13:40:53 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 315AE88287
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 4CD88114017B;
 Thu, 16 May 2024 07:40:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 16 May 2024 07:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859650;
 x=1715946050; bh=WND/9YscFZvVpTApibDVZFAaco/syZYG5zIF2GO5vCM=; b=
 OaBtcMtP0/wt26tzZuRVrUL8ChcFZkO3U9FJRrj57RWvVOheZRj72jGuNc47Hhgc
 7IcU+/cbjt63VlCOYkkWbcNnhrpBNhpFhU1kAjNJK4vo8mV68EDPg519t7XJSVHx
 DxX1xis6RFj+etL3HICdviPHfpf6xrLPjY4rVbuaTGq2dNj2YspzP5nVQa3sy90a
 79u84E9wrXoeHKoOjxmm2HknvqOmZ5oVhVOQXnLthLmP0VmQFT4dKY2dMZiHPwR2
 L36ZNf6UqJnJHJFMHvvuRipyLDTRNSMakNVFDU34mlTmXxf2Rx+ByI6sbBKdp3E4
 gnOynj3ddeXwFBZKQHgzjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859650; x=
 1715946050; bh=WND/9YscFZvVpTApibDVZFAaco/syZYG5zIF2GO5vCM=; b=P
 Ftm9ehw450I7P8qsYToc5XdgNcbOOQAheZffpLlQYlKPzQSk4xvMRrsVvqayQx4s
 g7CV5J3R5w6iZ2h6SESkrbxIzlpxCb4VhY45xcZo8mF4peFhgenzMYqZj64kVMX+
 o/kmQdZ6xDpFtjve4r8eyPcRfnAhsOgz5CoAvMzPwFpAKvOI8OrUghsihqAcDQaD
 IRQ+NWuWmMVQccTlo0sxba7cu8u0h/hDjjCprDVS2TpgqKLYcCgv1lLTrWM0tqSR
 +W47OhJXhmTv0uhcC6zajfSkAZAua5SD11cY+Wnbs2LhAeZoz00uGvItrfVk/9uH
 7PtBpxc+iyLAPBuvoDiSA==
X-ME-Sender: <xms:wvBFZkdbhYZK8av3OCea-hYrP6kAHiqWyKsLxeDf7QJXkNBx-1JXrQ>
 <xme:wvBFZmPDMxb2wisI1Vm68KalbXi9yTKQoNAy-EhPL87I5HyP0-6N6kw68fCuVKBH0
 _da0J2vzt94JhQ5zXI>
X-ME-Received: <xmr:wvBFZlh7OeZBSsyec6OFPtjI2s6AwckVI7w5iGWsOuMiyOMLA3f1efc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wvBFZp8ATvWE1YuU7xELAu8cNiqS9mtrICY1O7UWqe4d8Zu-n67xHg>
 <xmx:wvBFZgvinDfnjJ-urF-yMU_vFJICunefkM1EeM1-fH8H0P3WS7shng>
 <xmx:wvBFZgG97A3EcaSBe_muvVdKOtZXApNuCYdxaTaiz9bXURqW0EatEg>
 <xmx:wvBFZvPwJC1VODsnL4uf1dYvHJoNA9RZAqR9HB-gkJiBw00YymkuEg>
 <xmx:wvBFZhkN_HXNojliFx5vXX7iGXASs04_lVgE4kDBWBHBOnaZX7FGqZY3>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:48 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:26 +0100
Subject: [PATCH v2 06/12] MIPS: Provide dummy acpi_table.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-6-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=666;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=NDYF6acFegfZvokW+QdZBGVBF6Iv48uwDuZ2hky2Qis=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDzsmWTPeVarcHRrfsn2p1xbWrTp/lKcdPMhydPvtF
 3MMPwQt6yhlYRDjYJAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJvOhnZJh23F+kVDX4sNAx
 VbOVob7JSkFJWjVrtYSNb+3Rqd9zNJPhv5cBp/3Z8H0VuRMN3Bidl0/paXKoyWVfX/Sr9G5UgVU
 oOwA=
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

Some drivers need this header.
Provide this dummy header as riscv did.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/acpi_table.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/acpi_table.h b/arch/mips/include/asm/acpi_table.h
new file mode 100644
index 000000000000..b4139d0ba328
--- /dev/null
+++ b/arch/mips/include/asm/acpi_table.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __ASM_ACPI_TABLE_H__
+#define __ASM_ACPI_TABLE_H__
+
+/*
+ * This file is needed by some drivers.
+ */
+
+#endif /* __ASM_ACPI_TABLE_H__ */

-- 
2.34.1

