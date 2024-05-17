Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837E6C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1526D8853E;
	Fri, 17 May 2024 20:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="d/3hd1ZV";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMZIcO6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 395F58856D; Fri, 17 May 2024 20:15:07 +0200 (CEST)
Received: from fhigh7-smtp.messagingengine.com
 (fhigh7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E53088563
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id C9E8111400BD;
 Fri, 17 May 2024 14:15:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 17 May 2024 14:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969703;
 x=1716056103; bh=WND/9YscFZvVpTApibDVZFAaco/syZYG5zIF2GO5vCM=; b=
 d/3hd1ZVcaXeJslbNArgBKgFaWA/27NO1CmgitdbxkpanKcXmMVQCKLtc1mmecU1
 SZwunfJSVioK8k7r52QYOu66hRbkLV1onyX1xaDLE5tH3X2FPEGMbLAHpVjo7ldW
 pW591q3Wgaz3qrTk+ylBu9qLz3sPy8dRTXycBCZk5lo5Kh0on7r73wt7vg3UDU1+
 egMTAhyf9SLHbJwrd1PavT9bAUuiicjUEL1o6Ma5bSi98K2v8PyRQ0hlutXj/8of
 XIauAaysxWhAvZrL8beihg6RiJgu2HJj0ge+ZaM9XHafpKH5CWyf9An3ryZCImNK
 knz/WiImvxoG+wfs3NL2qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969703; x=
 1716056103; bh=WND/9YscFZvVpTApibDVZFAaco/syZYG5zIF2GO5vCM=; b=U
 MZIcO6eG3fWj1ZGlydIRFxdB+FxBeHh4tEAzy7RmxNn9Kd2xeYNNQKODrBf5yLkl
 LAdwvlwBr8Aj3FeMD8PSYexuzGxfwAAfqhcgycCdLqL49i07Zz8nfy0Cl/fXJpY0
 xaynZJJCu3+EA6S6aq9V5Fx3hH3/BRM0A/U+9PHyyL2GmG6J2Gi99B5YGpkhAPmP
 fm0KAyRUUMuT36fiYwCz+BCWSSqbIZM+0rlkRJHeoxf3SHwNqI2WTwd59bmW3csh
 6L1Fg3JpeMb3rbBJY8BTMaE8rnmZfukX8eVAz61FseR2ha7Ov4yC9o1eeTnbpKwP
 nocrzGqhgBqZz5VqnrFJQ==
X-ME-Sender: <xms:p55HZjN1QMcPqNjrGIefihmdNAkN1n6tBL7vPdlfzMGWUKNdqjVLZA>
 <xme:p55HZt_Ut0zgwgLkz8mlANqKzb2vEdnnXS3e8KTFNC0UCrQLOLgoL001KnPI99w20
 kd4-81yx6_hOssj0kc>
X-ME-Received: <xmr:p55HZiRVemr32_jcBXuLIC8WThaD3dsCGVaWuB452dsDmUvr0vIgyZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgfedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:p55HZnsEqDi4nKER3lLweSI8g4RL0pd1_WAleny6FvMDTqEU01Is6A>
 <xmx:p55HZrcuOBsBp9yygkyR-f2gYX7sqPAV94OHrRdHjXQpenNMQKToog>
 <xmx:p55HZj3qflTkV4Ln4Y1Ay0O2ZzzPhOSVzc2oxfosIOE861svBu2Opw>
 <xmx:p55HZn8bVkkyzf9cOrjDq7cocfLnOTW89q4ZytX-YmoDyBm7Ov5mSA>
 <xmx:p55HZj0GSLTi3RvG0YhRl0sIDEeC5bjhlqNWFLBNy8xJOWY1Hb_rH1Ag>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:15:02 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:14:54 +0100
Subject: [PATCH v3 06/12] MIPS: Provide dummy acpi_table.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-6-1ea7d23f4a1d@flygoat.com>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
In-Reply-To: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=666;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=NDYF6acFegfZvokW+QdZBGVBF6Iv48uwDuZ2hky2Qis=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebP/XjGuvdqZbrfPbfpKrQmNhT4HhOL0fk9+GcGic
 vfzG8HdHaUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjARVxOG/64/Q0Tdmt6t2Nz0
 J/nH6jdzI89P6pRe1svY7ipU+vuCpifD/6LX/55LrVoz2+3sfTep4uppH2//NqucnnZ5usSrGUd
 vzGMBAA==
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

