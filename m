Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3DAC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ACD488366;
	Tue, 18 Jun 2024 15:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="mV2G2PC7";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/+U6H7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303FE87F5C; Tue, 18 Jun 2024 15:56:41 +0200 (CEST)
Received: from wfout7-smtp.messagingengine.com
 (wfout7-smtp.messagingengine.com [64.147.123.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B9398786C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.west.internal (Postfix) with ESMTP id 570F31C00095;
 Tue, 18 Jun 2024 09:56:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 18 Jun 2024 09:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718718996;
 x=1718805396; bh=gZDfFgSj5RLms5pSeKjfBfqYmfa3lEdypsFVlUPS0gU=; b=
 mV2G2PC7BUjVFHdnAsxwquRDHPcsgBlWtRWsK6WyGRQHtFFfoPJx+3VqXRSQvrvb
 JWuT/t2frTNbN9V/2G05gHHNIhVQK8H77KX5h8Zzb1sN/Jq/aMcKGkQG3KDbY1tr
 boBWYwzNawAXE59iaGlJ3Ef4ujBM6Qi7StvU5SSINYDXEZj0ABDIBh+4rLnBkB/P
 COutJXai8Z0wn8IBho3nb+Xskj5rivL9Ivu6+E25RCls4OkcLEZ3S4PTC50Wnc55
 R9aJDJWhdUSoQe/mARty8Nr2ARNZ/z9rnVGqKBefEGj9yTzZcApB5lgSY39W5C0k
 qCBzYVkw/dWCu8zh5eJysA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718718996; x=
 1718805396; bh=gZDfFgSj5RLms5pSeKjfBfqYmfa3lEdypsFVlUPS0gU=; b=H
 /+U6H7gOkpHMRuF0TGqaUX4vgxOw95NmsSOZ5xmX3lXiTfZOg6vvNZGc53kBFlqG
 F1c4oVJI8gL7RUsq5kJ39NWaRQALIvSt0gfWf87ECXxq/Uft+lx4j7uToCYXfaRz
 oNF5WtfGHREVTcSchbZs6+EPNlmowf5v4ulB/1zoWY9UGmv9sKtEQ5TXM8AaUZWA
 oud3iHFfPNn9O2vVrh1G9srqVlFiDLSM9rUXk0M6CqlquRhrXLyCr1PTGlBm1+Tl
 4UBb5cNon6LHJcwKfp6wZOYi7KIOOm2n06JzatiydNRXtJ6i72p/YHxLc34IIr/D
 aDFJvOZkZ+np7SYiAsPvw==
X-ME-Sender: <xms:FJJxZrqwbym6CCYoLnL-NNH-gOMwkuEkv-_6-aCFibJ58J3TLjcbuA>
 <xme:FJJxZlp3w3wwk9EeGmRyP2hDrsTdqqYHPTI6sihi3XDmP3BA54FSOWeE4L7mfqUmo
 yj2kj2v2FnrhRCJtQI>
X-ME-Received: <xmr:FJJxZoMFzcYj7LF0HUzy3tNfmnZX9G0YaDjSzHuvCNyXib8a3Kvdnbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:FJJxZu525suq7Hhm9OtPyh98b633bBOoLDxwa1seTzLf_opd4h4blg>
 <xmx:FJJxZq47piN1JCKH7Anz36jm6VyqbTKILeQbZvDPAgLnAdQvBK61WA>
 <xmx:FJJxZmhZtPA0EAz9xJ-e-DdFwi2RUmdCbQzy8meLYl6bN7uLIZBNSQ>
 <xmx:FJJxZs4Sm5O8MI6T9Im1cJP9KR0m9-ctLvlB5l4LPCL5y7x_Ypvclw>
 <xmx:FJJxZnu4cuQW_cAX2wfI9iEPzt_Q-dmO_NYxXsHieCJi5hGc-_yyFimT>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:34 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:08 +0100
Subject: [PATCH v3 08/12] dts/upsteam: Add Makefile for xtensa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-8-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=825;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=X8+S49hoUmoExgpbzwzvUE3l9JYXkwkNIzsQk8lYNYw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYzfdOUuVbpevBjkJGuxru2b9V3l1bN+zbpbmqIy7
 0KymMW/jlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjI62eMDBcWqyzdvNj5pNqn
 RYJKggcZsn3dtjMZ9z5VSdry4enZbW8Z/hnduhSg67e1jHP9im8XlLNWrDtnvug0v5XEpUoG5r4
 vkdwA
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
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
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

