Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941B1C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 13:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 544F78723C;
	Mon, 30 Oct 2023 14:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="TBqY1kPD";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mpn5ie+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD31C879FC; Mon, 30 Oct 2023 14:12:55 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B8958706F
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 14:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 2FB043200945;
 Mon, 30 Oct 2023 09:12:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 30 Oct 2023 09:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1698671568; x=1698757968; bh=ks
 37gSaTemFOmfEzetYVIMPdsS3fxq5voyswwol8rvg=; b=TBqY1kPDIHL6Fji6Vk
 vTlo/6115HLfB0iWNw6sJMADy+aR2eaZR0NJngtLTD/HMdj46oq5SuOn8AX5aNXv
 8iFFD0eLK4MFLKM5QlRwt3T4v0k7APSieSeq61kuGIfswDf+hruUmmIirOp3aiYd
 svQgrTBXmUjnU4LNPTLvi5iet6lh6TiRIGD9bJQ71sc+8k5lLR8OAS5wswVIbfQG
 JV0CbIL1wLd1vI3lVG99e8hYL1Bd2KyeLUA2bTC2TQY0zLEmOQsMGtJE+JcDy0pK
 tlYfRp5hp0eW4D8CPy1pnQ/Fi5OojoNU4yHvrRMQeHxa/uhGUGcXXhf26evQdm8z
 Tdrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698671568; x=1698757968; bh=ks37gSaTemFOm
 fEzetYVIMPdsS3fxq5voyswwol8rvg=; b=Mpn5ie+DAecIZKpaXvJQ/xUMFBG9u
 F1Bt3ivAsEINQD9Vj9hftBPXVf/yl6uGj/+RPtYS8FShPJyXhlk++tfKNZrVu1vW
 GpzflI26qpC41eE9JnHOSr2Z8JqMoHhvzP8D4Ee7kcEl5Sa2ZXG5Nc4vad1S96fF
 QzBbzwycutfLNTQzP/kdCKpWswbedU2jVeThUQiibHFAG4NHfRQzIDhw9bauBNV+
 u063/Kp+IIAGuxgBCzgfG9Rcra+eyF6DXoPS0Kl8+pRs3iejZvuwbBxfrF+LjPjY
 YP/rtKnMNBf5/Cm9ImEd562bP8NEkxIAyzk8R6og2SZuHggC3hU8L8LQg==
X-ME-Sender: <xms:z6s_ZXqf0Y4EqzvQLbp2rXi_d9LpbEryz63OFYwNNzIANRj4snSraA>
 <xme:z6s_ZRqf9jxbY7i__mg_2vPYcc8hyORT09J4C5MvvuPDdUpy2twGfy9NiURysBhqR
 0WxnEa86A>
X-ME-Received: <xmr:z6s_ZUNyS7cU2vgEekjm4zf0xCLoUZC5fwWBbE0Ry1hyLF1h8qKa8eYaJ-7bVfWKLWgO4GwKJpZMfewZOrVaVMnr5wUZRtvwPzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddggeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhimhcunfhu
 nhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrhhnpe
 duhfdtveeujeejjeffieevgfdtudegfeffvedugfetteehudevteehtefgieeitdenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmsehfvg
 grthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:z6s_Za5Eb4g4YvML4QAs32yI0VGnsvx_EUyygVyiucMYq5q0vfZ-VQ>
 <xmx:z6s_ZW5WwH9WCPK2CaP_FI2vrQH9tXGEr-QE9Gdjlu28tjS-hBveMQ>
 <xmx:z6s_ZSg92sQLtUj17p6Q3RjCwmH_9gCCBwe42KdYGJdooHFKZ0hPNQ>
 <xmx:0Ks_ZckfjoAjD1iEN4ynf4cym1ox_ZaaMZy2rxtVdpgAhZkXzZht4g>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 09:12:44 -0400 (EDT)
Received: by feathertop.org (sSMTP sendmail emulation);
 Tue, 31 Oct 2023 00:12:41 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tim Lunn <tim@feathertop.org>
Subject: [PATCH] rockchip: dts: fix bootph tags for rv1126
Date: Tue, 31 Oct 2023 00:12:41 +1100
Message-Id: <20231030131241.501472-1-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

RV1126 fails to boot on 2024.01-rc1.

Commit 9e64428 changed the behaviour of bootph-pre-ram, to limit
nodes to spl phase. This caused rv1126 boards to fail to boot
with the current dts.

This patch updates the pmu/grf nodes to bootph-all tags as they are
needed in all phases. This fixes the boot issue on rv1126 boards.

Signed-off-by: Tim Lunn <tim@feathertop.org>
---
 arch/arm/dts/rv1126-u-boot.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rv1126-u-boot.dtsi b/arch/arm/dts/rv1126-u-boot.dtsi
index 5e348278f2..918c307743 100644
--- a/arch/arm/dts/rv1126-u-boot.dtsi
+++ b/arch/arm/dts/rv1126-u-boot.dtsi
@@ -26,15 +26,15 @@
 };
 
 &grf {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pmu {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pmugrf {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &xin24m {
-- 
2.40.1

