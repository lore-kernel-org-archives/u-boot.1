Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C38CD13D2
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCBA08432A;
	Thu, 30 Apr 2026 23:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="kok77oBT";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="oJtNNTeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 965A480086; Thu, 30 Apr 2026 23:59:58 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B0D843D4
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DEDF17A00E4;
 Thu, 30 Apr 2026 17:59:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 30 Apr 2026 17:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1777586394;
 x=1777672794; bh=afB0Jke/YbB/cQC+hhQEJC+LzpRK2IqMhDmlNm3v6b0=; b=
 kok77oBT1ZHXWn/VhykSgtfAJO3D5Y6JRDcbqkxXmdyTsXIVeYOV6160Rh2dGiCz
 f19bEYBi+108T+j5e4utQGfZiLaxD4gRqd2tAydvTKNWE/seiMsTfMmsL9X3Pf6I
 bfny0vQTPWrsOPPawvGjKfc68iT6bkJqandIwRXQp0ycuCq7Riju/WbtvifVhiHX
 dU06PVymithq+o4ZYaGDRtCgGVTujN9UNR9UQfyDXjwTm5A3q3ArYTKgrzRG6SG2
 Axf5DFyb5FSHODJxB3xOaTe3p0c5Kj5296Hb7VCCacrwWiHjX3zFsKXmFmMiZ0FU
 tG+fRLW7RJXloEGmkIcdAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777586394; x=
 1777672794; bh=afB0Jke/YbB/cQC+hhQEJC+LzpRK2IqMhDmlNm3v6b0=; b=o
 JtNNTeBl09+sZL/CVyKFD7GHiQ9vE6vZdtt68iAIBcq1Z2brqT91hDzbs5VNUCQL
 2uBczhzR3fFsJWPNYPZ4Hgy7sM5u+GGZ1EgzgBZw5bPBoihXY71j1feq/mxD7N5j
 UwXuc9O9eXBcXksEKvskt3Vv8Cx0bV3wJdQKbj/XUyVV5UGdaFaoJTxkH8zGIyWT
 bATncMOt7/TL/s0NPC/kiuk1jXDFiezK26FJnm3JUHpYA0UDssW11QgeAY3zXxhT
 shxvNdvzP7c9ju6Vr9jmB511tgBk9IoWn0slkpR9cPXlQ5JZrFciaIa8POtZU3lt
 LbQynhWhkh+pOvQKxm3DA==
X-ME-Sender: <xms:2tDzae-tMVBGghA3Ln373FkK9xWkD-NIZLlWJV-e5NtZKYcwxr7kTw>
 <xme:2tDzaYEUJjMRfDAgzJKShnZ4iLA7WqAu0oH6l2PtYSUk5ZJgTDUV-h50MyqmY4F8N
 3UuhuAdQHlnCD77kKuRftuu4kpMoysgDJog5XJRWpXI2PoqunPsC8E>
X-ME-Received: <xmr:2tDzacjejZL7a2mtmBeXqK--d1cEbsEhCM1m6zfW3d_w6OxY7LQhSKbLfGEV-NJc-fPjQ2JbKrUkO7zR5mqaTiPX0y9BHGGohMAOHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeegiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcu
 ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefhe
 ehieeludffheetiefhvddtleffuddtleduudeiudetvdefffehkeehgfettdenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
 drnhgvthdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphht
 thhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehprghtrhhitggvrd
 gthhhothgrrhgusehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepqhhuvghnthhinhdr
 shgthhhulhiisegthhgvrhhrhidruggvpdhrtghpthhtohepshhtvghfrghnrdhrohgvsh
 gvsehmrghilhgsohigrdhorhhgpdhrtghpthhtohepmhgvseiiihihrghordgttgdprhgt
 phhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopehtrhhinhhisehkohhnsh
 hulhhkohdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdgu
 vgdprhgtphhtthhopehphhhilhhiphdrmhholhhlohihsegrnhgrlhhoghdrtghomh
X-ME-Proxy: <xmx:2tDzaV8JKOlgpKYEx6O-y5NBV4AzbUPjL0jZh0JBDY7UOkhvgawKTQ>
 <xmx:2tDzaUZduCLBmC_LrEKMb3h_6OtaN-_OIXyMbT7HA9hEzGp-dWIvWg>
 <xmx:2tDzabtkVsp6QNgXY83R1IBcape8-oMb5CQBaahwdj0RfAVNq59lFg>
 <xmx:2tDzaQmIooUDy0opXmWFF_LBTq4Xm08UmHBGsBkx0yRBJXAxBr4obg>
 <xmx:2tDzaTLMi5hWPuaNC0dhkuJK9hHK5XH5CI42xKZodDSP00Lj-JjXP6a2>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:59:53 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 30 Apr 2026 23:59:37 +0200
Subject: [PATCH 2/2] MAINTAINERS: Add Janne Grunau as reviewer for Apple M1
 SoC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-maintainers-apple-v1-2-43382ca4d780@jannau.net>
References: <20260430-maintainers-apple-v1-0-43382ca4d780@jannau.net>
In-Reply-To: <20260430-maintainers-apple-v1-0-43382ca4d780@jannau.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=598; i=j@jannau.net; s=yk2025; 
 h=from:subject:message-id;
 bh=4m7LLxioj/SGkLRR/rCzuuqiP6hk8gVzxN/2iiO+kYU=; 
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPFy4des9a4v1uoss27mWOv/NXnCpaqrlmgtRRm7seT
 0WOTJi1uKOUhUGMi0FWTJElSftlB8PqGsWY2gdhMHNYmUCGMHBxCsBEpmxgZPhtnD1XTKMvXmLy
 hdIet8Wynx9IORXrrl/PsJPtF2//Uz5GhhWV3OxL7C9FfpO8tUzR/Kr4+pQDv7fP2CT3YWqrXuW
 jGj4A
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

I'm one of the co-maintainers of Apple silicon support in the Linux
kernel and have contributed to u-boot's Apple SoC support.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fc41a79dac..5bcc8607901 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -128,6 +128,7 @@ F:	drivers/mmc/snps_dw_mmc.c
 
 APPLE M1 SOC SUPPORT
 M:	Mark Kettenis <kettenis@openbsd.org>
+R:	Janne Grunau <j@jannau.net>
 S:	Maintained
 F:	arch/arm/include/asm/arch-apple/
 F:	arch/arm/mach-apple/

-- 
2.53.0

