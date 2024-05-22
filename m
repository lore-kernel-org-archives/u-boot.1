Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B95C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6275D888C7;
	Wed, 22 May 2024 19:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="ybADOa48";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bu2Fjn2/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EB5F888BE; Wed, 22 May 2024 19:08:21 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BF2288856
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 7B331180012E;
 Wed, 22 May 2024 13:08:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 22 May 2024 13:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716397697;
 x=1716484097; bh=Zg7bJEx+d1UoPHUOuH1/DFFPWqkCO9H+b5BZBcpnwh4=; b=
 ybADOa4831EZOEwf2/ZP60pl1vnwUvQBnJ5HzvNaF3ZoTF5Q/dJ4d21CEpKsru7W
 VLtF4bdd7XqJxYWrSKeVgGPakM6FaxHpYaCT91itMwYrMnuIRjcip4Kw2SPhEyKS
 fH6PQpacZglxI4Q3bRpjoV1FMY9Xjm6YBLwyxAOVguXct4Q1pXfcglKjPVfGaVgY
 vrEkdBni2AVZAvNyh2DpsmG643AEFZk1ceCebbf0KyCsUglFp5hb2xjJE5urua2L
 AuASh8f9bwDiuYkqytdLrCXEQnehE85jLW7Lv5yfQSOOJsaAMIVXZVCkbDYcKXPF
 H1QSmhleHmvkjtLcnwjXUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716397697; x=
 1716484097; bh=Zg7bJEx+d1UoPHUOuH1/DFFPWqkCO9H+b5BZBcpnwh4=; b=B
 u2Fjn2/u5VOiwtsRoFOXcjqadccI1CvzttjI3EkPpL6wqtdInVGv192crJgfmaJh
 OLu7IsM0X1gFC//JyQGmvsVvrUrDOMV4QOQisSWmYbl085wCmq1HMTr/zsf/2QDl
 Pm3KRWr1CGlpHfYjbdRgBoUG5Rr3MTduKanS3mjBjvUCdh9U+GHXuSHjvZfAfIX3
 MfqIj7dVLbnlQAegYe+UYbyjgv6bXEsSo3vYMtjkBoe67efQGLoFkEChjQgJBonT
 1ZmW0cGKSEuathPk8B3/rqjDKlduZvcwgBA0iSk23WGutcsfyN+SCD/0Fyndv+TA
 56kaAF6oyerkZdOvE4s5A==
X-ME-Sender: <xms:gCZOZvbH9WAmo8Rw_H5TGDa8oP1K0f4FPAtnbRCXXzlE0MC6FxQ-Eg>
 <xme:gCZOZuZDCw2yCnhy0H8wNMAe1_nHYwLLBQD8BRcWinPl3h-k6wsyGtqb6l7QTBLML
 l-bxr-SIfmw0n7-7bQ>
X-ME-Received: <xmr:gCZOZh_lNLB7fmL61C2G5flYEHAC1dOyZyky8BGsUIC5mk2IJwe0Mk0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:gCZOZlrU1us7hgv06gTMx5BBxQsTG5SbNYd1EiSRxlo7GuapRBSaJA>
 <xmx:gCZOZqoKfXj7OAB1eT1aLn2cAks04Rrl5FcvajSLVSkGh2uFDEosuA>
 <xmx:gCZOZrTicGbPKXeQLXiuYA9hKxH2eDLTI1ZY1rKjMMm-e1aDuchBPA>
 <xmx:gCZOZirQS5KwGl6HaRzcX_Eql5g-WkEyPE12fAMVNqgi3yNbHhm17A>
 <xmx:gSZOZrcW3RDYb9ma5oscvF23ajtzf4ZHGiQDSyWy56PKBm0piVRroOux>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:08:15 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 18:08:04 +0100
Subject: [PATCH v2 08/10] dts/upsteam: Add Makefile for xtensa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-qemu-xtensa-v2-8-04bf7e42b10b@flygoat.com>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=779;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=VVfi3U1xpHhyDDclkiUWXowVxJ0n0vKrh0180BDLTAE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tfyQG48+PW9iuXckOPFNVB/jonDr0uLeH5/OC1gqz
 L3732VjRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExE/CzD/2Ib99fx4aktSp8K
 v+gs+hXicXtzhvvnZedl1mpfK613XMTIsKUnyYd/SfflF3WphxfNXlcSylwSkxJW5Mou+jEmcM1
 jVgA=
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

It is required to get it xtensa OF_UPSTREAM work.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 dts/upstream/src/xtensa/Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/dts/upstream/src/xtensa/Makefile b/dts/upstream/src/xtensa/Makefile
new file mode 100644
index 000000000000..2a81acb32bc3
--- /dev/null
+++ b/dts/upstream/src/xtensa/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+include $(srctree)/scripts/Makefile.dts
+
+targets += $(dtb-y)
+
+# Add any required device tree compiler flags here
+DTC_FLAGS += -a 0x8
+
+PHONY += dtbs
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	@:
+
+clean-files := *.dtb *.dtbo */*.dtb */*.dtbo

-- 
2.43.0

