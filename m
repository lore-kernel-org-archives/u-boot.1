Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F334C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AFE688867;
	Wed, 22 May 2024 17:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="vC9dJJ3X";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBhN3Hbl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90CE888864; Wed, 22 May 2024 17:35:17 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9643187D43
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id C4AA218000CA;
 Wed, 22 May 2024 11:35:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Wed, 22 May 2024 11:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392113;
 x=1716478513; bh=/SMlxy0ah6f3vxG1KSvwXVBIM+uWG4uUkutFpE5Usyo=; b=
 vC9dJJ3Xu1i5RJeVPhoegV4b/h1UeLy7LrUqWuOsiML76sEB1BtSKO1c752JHSFB
 jgxW4V1Wg3nWaB+Q19ee9Vvwz86+ofEBXyfp1NxtIiz2Aw+FqgvXgqjLQFC7g7AH
 6q2wc1PWWXnizJ3mHWSNyX3C7OSvoTY3aL1D2/FgkFOyKZ3rBJWJvkSovsbdXvsx
 PItGDPreC2vujNndALE9UiJckyxjGSqTHQyq5SRcUlnk2oMtcrX4S/b9okOUnmu9
 3YgDME8ZCCn498De+VbkELbRlb89C6qk7k7sp8Z+3/FIT+NDtgXiGbnqaDVNgf55
 xX9pl6LWHMeAsrfNCdJ+lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392113; x=
 1716478513; bh=/SMlxy0ah6f3vxG1KSvwXVBIM+uWG4uUkutFpE5Usyo=; b=l
 BhN3HblbUdY8CJHXxusejJnFG8BGiQxeCClU9B2a2KxN80VLMYo8+D12GYbj1Fj0
 hBB89baXTM8huG3dcexmLerfoGnd+Czsj1NVaqQq3E2e9OcnKEdXWk45i68I8UU+
 DpI77duzb+ybvwIC8nD+G5iz5zXlbNPTzLAUufdFCAKAhbokRA6pgEqOZXaGy52K
 ojTdZJFDbY4PNmrbHdFvMWhp8qvhUppYe28tqjsywAmzeSeEykx77jrpKGmKGEun
 uUV1Fk4HGTfv5CH2TzuVVvf9Rh+ng3OMJNO6fGoqRO4dLpxQa/jh2KSa4mTCmHl3
 9dJwa4v7OcPwW6b34OtVg==
X-ME-Sender: <xms:sRBOZn-Y10yXonc8tuephogad9SmrY4J0D_GB9kj3CB8RkW4VDtp1w>
 <xme:sRBOZjsk2GmXGEqDYfn8i8LVvrGhFgpZOwEuZDRb_ZvKiOlo8G6eBFCbPtqb0tGIT
 WKLo7nUHcy6Qy6u4Ao>
X-ME-Received: <xmr:sRBOZlDHWMnnoodMHqVr5woJJb_C6wnq6D0llwJn5NwXtxz68uSaJ5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:sRBOZjcpguBbueHL8ADIvDyK3x-tfs4cwy6VvDHLvGRsErGRlIOUCg>
 <xmx:sRBOZsO6anUqZF_SplhaulKl1Mq18bJ8qsK5O5Od_GotCoWixSeuaQ>
 <xmx:sRBOZllT56hvGRxH5mYIWM8HUU4-Y2S_Jkao7NS8TvKfQceBNtZY_Q>
 <xmx:sRBOZmsECjamyS4f1ix73NNe2QNykQ3AGNuWapjL6aEDIgdcpWbjTA>
 <xmx:sRBOZoAb6JasLq6VqwB-LzdjLvx52WNRyw4Kv2wmLSAD4WTtZFvA6ZLV>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:12 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:48 +0100
Subject: [PATCH 05/16] image: Define IH_ARCH_LOONGARCH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-5-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=974;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Cbk/RHQVvZdLxetm00n1vu6tWG7iPrD118gN/Otkl0c=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geWVxziEN7yJ5Ldhr5+zNvn7/aNWDrqiFjc+7F6XL
 b7kfP7MjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIphrDX9ljh7rr+E68nnun
 QOFb819/+XqFvg1/9v2Vi61PvFww1ZXhN+v2sq9hMROyFtyfqVSvlJfPmL9GY2rCzJU3BLfeKsk
 4yAsA
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

Allocate the next value to IH_ARCH_LOONGARCH.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index 073931cd7a3f..8955a095713d 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -96,6 +96,7 @@ static const table_entry_t uimage_arch[] = {
 	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
 	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
 	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
+	{	IH_ARCH_LOONGARCH,	"loongarch",	"LoongArch",	},
 	{	-1,			"",		"",		},
 };
 
diff --git a/include/image.h b/include/image.h
index a2bfc7bb19a3..1dd6dfb82437 100644
--- a/include/image.h
+++ b/include/image.h
@@ -139,6 +139,7 @@ enum {
 	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
 	IH_ARCH_XTENSA,			/* Xtensa	*/
 	IH_ARCH_RISCV,			/* RISC-V */
+	IH_ARCH_LOONGARCH,		/* Loongson LoongArch */
 
 	IH_ARCH_COUNT,
 };

-- 
2.43.0

