Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE91C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 060D48883B;
	Tue, 11 Jun 2024 23:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="JKmlJBi4";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="STV2R42B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD9B8883B; Tue, 11 Jun 2024 23:05:08 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E8C8839F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 8D81B1C00091;
 Tue, 11 Jun 2024 17:05:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 11 Jun 2024 17:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139904;
 x=1718226304; bh=L4dnOTQiBmJ2d1JCZXpShUkx2z/XAB8nZ/4+O0smL34=; b=
 JKmlJBi4mKi6lD9tvYah5sWxptzocAZSndaGFkLKJzkxCPzVBg89pVI0B0z73CHI
 +fh7me2Qzfbz0HLBQUVKQ7Q4h9U0i8wLdttwNIzlF/SGkpa0n+M8hSs4F+AGZpIX
 ZrKjXw4WbTvg176SQkhby2A0DWvGFPFWrWfTUjx52WsGuwUG5xe8Vu5RC0C7anFy
 7Le2+PSO6FeS9FHcxGxdxpQSraDChbwitqoMiI7MgaNGLQPzGvnU0gXD0Lm3Nmm5
 4OamQDf6uUrpECnR4FIM3QAg2wQ1EqqCIy6SDHbuofhcan7Bv3ThRCJzuWoS8iyC
 TeVoMI24FjCQqnH03s6RVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139904; x=
 1718226304; bh=L4dnOTQiBmJ2d1JCZXpShUkx2z/XAB8nZ/4+O0smL34=; b=S
 TV2R42BUDREVW9hZXQVCMl77DIa/sPIdadLiHqdIVp4nfKPlTTUFxi+WZyoVLq3T
 Om0Ymw045h1RQ1cI+YKm7dgpKkWRRSFlA5A9rgMKInLu3AFktT1cImyBVMMwA23T
 cjEBgOa0SGO2h9Vqc5faSPJRFFi7FrmsQn8fiCmLXzskH4s4yxpZGNtsHgqHJqBp
 jrT1hhVN7Mqm2Ztivg7AbH21TYcQzRvSW1BgFJ35SRvJtmxIEa+n1pGe3BqqeWlG
 xq5EBpRMyBhpUXNA0CBRHRgOgOjpuOU0pA/bjXL6l+I4tuNL/0fpvmKXKiaZ24DJ
 40duNt+hMGGJs7Cdn6MRw==
X-ME-Sender: <xms:_7toZnq9So5u-Yx35ryy0boUjgV4XPuQxW2IGBgxyBItmBZUfy217Q>
 <xme:_7toZhplfHy51hw14ww9cb6o-zLdlnsW3-jSULhgSJCbDtBdEJ64htrW88WdFhYZt
 Tc8xZ0JriDWrGLG4wE>
X-ME-Received: <xmr:_7toZkPAJHvedSLuHGCbAERVY5iHp9c4jF2ZRRJ8QVYKa_xQGBwHhFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpeefgfefhffgteeugfevfffgheejhfeffeeffefhtdehvedt
 vedtteehteetgfffheenucffohhmrghinhepghhnuhdrohhrghdpghhithhlrggsrdgtoh
 hmpdhtrhhushhtvggufhhirhhmfigrrhgvrdhorhhgpdhgihhthhhusgdrtghomhdptgho
 rhgvsghoohhtrdhorhhgpdhmrggtphhorhhtshdrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
 ghhorghtrdgtohhm
X-ME-Proxy: <xmx:ALxoZq56CRCpsdnY1FymoKdIQY4oKVt-GsV60Vy3qt-MxE_lhIsbqA>
 <xmx:ALxoZm5U7ZB2c5OiRw6G1HOTBgQB4P4jDqKvIu31BZye66O4MqIy6g>
 <xmx:ALxoZihjNqltfrZnxlBiJ9Xy801XiUaylmVo5ieAN8PBXZ7V-IiObA>
 <xmx:ALxoZo65u3QiXB2CbZyt20-_5OUPMarEGMqs92YDtvWgtVnYfbvqPQ>
 <xmx:ALxoZos_4AMbd0eyptDofngxafM2NKbxkmJQo9eN-jEqwOhojRz2P-eK>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:05:02 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:19 +0100
Subject: [PATCH NFC 20/20] CI: Dockerfile: Replace some URL with mirror sites
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-20-51472eb70357@flygoat.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=BxSHuu1FMvFjBV5ooRS8Ft5gjdKc2ceGE+HbvLu0/tw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3efEyxtUFijUzvuw7pt8Rsd5x9vp/FIMGk4vVlhMP
 2DoKDCzo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYyN5Dhr1zJw6DP2juK70zv
 m/zjdJS38xonMXuhxqBwLsWrCYmh1xgZXvR/K7PYYebdw//i+WJm1l3ln1UeXutcZrn80LMZp/T
 OMQIA
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

Somehow when I'm trying to build dockerimage on 11 June 2024 multiple
upstream sites are down.

Arm site is returning 500 error, nasm.us domain expired, ftpmirror.gnu.org
is down worldwide.

I belive those problems are not permanent so made this change NFC.

NOT FOR COMMIT!

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 tools/docker/Dockerfile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 3f1bbfce669e..67d10f11f43f 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -205,7 +205,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	rm -rf /tmp/qemu
 
 # Build fiptool
-RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
+RUN git clone https://github.com/ARM-software/arm-trusted-firmware.git /tmp/tf-a && \
 	cd /tmp/tf-a/ && \
 	git checkout lts-v2.10.4 && \
 	cd tools/fiptool && \
@@ -260,6 +260,8 @@ RUN mkdir /tmp/trace && \
 # Build coreboot
 RUN wget -O - https://coreboot.org/releases/coreboot-24.05.tar.xz | tar -C /tmp -xJ && \
     cd /tmp/coreboot-24.05 && \
+    sed -i 's,https://ftpmirror.gnu.org,https://ftp.gnu.org/gnu,g' ./util/crossgcc/buildgcc && \
+    sed -i 's,NASM_BASE_URL=.*,NASM_BASE_URL="https://distfiles.macports.org/nasm",g' ./util/crossgcc/buildgcc && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
     make -C payloads/coreinfo && \

-- 
2.43.0

