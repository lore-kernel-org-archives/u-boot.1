Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7EACD13D2
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA1884227;
	Thu, 30 Apr 2026 23:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="hstOEBir";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="pf3F7Eto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C16F841D7; Thu, 30 Apr 2026 23:59:53 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511FB80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 1A5681D000A7;
 Thu, 30 Apr 2026 17:59:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 30 Apr 2026 17:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1777586388; x=1777672788; bh=lX
 oSWMUrepMfbjlTbGQutvwuzUcZJp5kfTy8863dZNc=; b=hstOEBiriFctsovWYe
 FiBpcnqnfQ/JyFvR++O0ZlA+5r4BSP+x8ww/KVozE5dSSN/zMfvXIEvQDmkryQCv
 4SYHshC+ULPwm6tmPo4sfD4z4CWOYPr/TgKZzyf5APWR/9H+DA0wt8mIzlMEOa9+
 ck4YSZxEYKsjBW3T66lbmRPje51EaTEnl+YFta7m5kKDx8DLiwi4Wb4Y/TUXF3x0
 qcSRX0gFYPhSpT1Vuwga9PeMbufRUIxIqOq2YMCg9BvuP0XJWsUtr3gxTdzspnIw
 unfA90m9piyJuYg3UVQoK/dheMaI8cNwN3y6Gjg/OVAAUPLLkJ6MDmeQaAqY8H1Z
 uRMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1777586388; x=1777672788; bh=lXoSWMUrepMfbjlTbGQutvwuzUcZ
 Jp5kfTy8863dZNc=; b=pf3F7EtoMhk1oiJMqPK5ulW3jY+4TP1Jxn2tpx6FRK76
 118Fyw8rziCkB7MoxEJLCr7m+RnWXpV5Lbqx/90XwgBKj3Ndz8sjuvQylELRLRdX
 kg4c063KkA9STN3IJ4qB1of7HB29xyogdtx04HxkHv47ipth7+NL6GPGFIcsXZto
 Qonbhf8Euxiotb/wGsX1kp2IA/K7o60d7Ru9108cqetmgRyKP6Qmxeae3Q91RHVr
 ziT2ViGfCEnGZ4kkLi8855a8HBzSgI3oE5IoDiv57jTsz70Id52lmqok+qvZyk09
 5BQVTyO4AgLRxR54k1NBQ/lp4h0PVC5OPl6Hrx606A==
X-ME-Sender: <xms:09DzaVZK4I37iCd2iK3r69La4uu02iWOe_5WU5ggBXP8lRgW_CoEgg>
 <xme:09DzaVw299fP5JRboTYB3VyFd1dKt4SnbsGBO1BYA6iBO5mp1CsQCiDozNt8eSgzQ
 IFEJSBCf2w8mqFcd16StafNzsaq18gGEpGKGpcRR2NFvS-DkHcy-wQ>
X-ME-Received: <xmr:09DzaQcL6MOykKvZef7oJwak2z1cUlyoT5FP8NMtV4FS5lwrvJZZTad3Wm0ZaNx_PE6AQRebpDEcIsPDC-Y-o-GQfb_xv_Ecf8Mq-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeegiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
 uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefhtdeuud
 eljeffuddvheekuedtfefhtddvieeigeehffelfeevvdfhgeeggefffeenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnh
 gvthdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 pehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehprghtrhhitggvrdgthh
 hothgrrhgusehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepqhhuvghnthhinhdrshgt
 hhhulhiisegthhgvrhhrhidruggvpdhrtghpthhtohepshhtvghfrghnrdhrohgvshgvse
 hmrghilhgsohigrdhorhhgpdhrtghpthhtohepmhgvseiiihihrghordgttgdprhgtphht
 thhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopehtrhhinhhisehkohhnshhulh
 hkohdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdp
 rhgtphhtthhopehphhhilhhiphdrmhholhhlohihsegrnhgrlhhoghdrtghomh
X-ME-Proxy: <xmx:09DzaTJ6YVyeNCx8dLBj02wWhSQ1maI8c831lvFbKZg8np3G8au99A>
 <xmx:09DzaR35DsqHNZOBrlDY5VKpBi3CPrwW8iZizmKovAOg9_WZzA3ejg>
 <xmx:09DzaUbpbfZlOiu5iGiwoOFDMLVN2DK5n0VyP-w4Ur7RZE4Y3KGYTA>
 <xmx:09DzaTjZ3iaVV7o3gtspG2211mI3FtkWnv1jvNeY4WHT0m1FMDU44A>
 <xmx:1NDzad1TWAuMCCiv0PaVoRKzdHEwg6lxc5J-XlupIClS6qtCLrBHh60a>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:59:47 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/2] Apple M1 / silicon MAINTAINERS update
Date: Thu, 30 Apr 2026 23:59:35 +0200
Message-Id: <20260430-maintainers-apple-v1-0-43382ca4d780@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7TjCLxL4SHSzXWigTjQjEvycd5
 jCHmQwJI2GCkWWI+FCiy1dpGwbrbvyGnGx1kEIOou8EPw35u4IxcRPCgbzX2mmrlLDLCrULER2
 9/3OaS/kAYNF+pmMAAAA=
X-Change-ID: 20260430-maintainers-apple-499f9d770dbc
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; i=j@jannau.net; s=yk2025; 
 h=from:subject:message-id;
 bh=9+cek8NAn5qEOgf9A2w1JJRnN+00O9bk80zwXJwsLqY=; 
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPFy7+tFz4P9T55JUb9TFiCTO+PSi2MbhzuF7Av2+q7
 I97CfpdHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACay7z0jw0qTnc07exkfnduX
 tF/mY+rHwrnB+at/HD+19mT18f19t+YwMiw8HqwRFWq7cObnr3v7CrrrmXM9FzUtSOSsP15xwuT
 sZw4A
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

While sending the trivial compatible additions for Apple silicon drivers
I noticed that a couple files were missing from the APPLE M1 SOC SUPPORT
entry.
In addition add myself as reviewer. I'm co-maintainer for arch-apple
support in the Linux kernel and have contributed Apple silicon related
changes to u-boot and plan to continue doing so.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (2):
      MAINTAINERS: Add missing Apple M1 specific files
      MAINTAINERS: Add Janne Grunau as reviewer for Apple M1 SoC support

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)
---
base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
change-id: 20260430-maintainers-apple-499f9d770dbc

Best regards,
-- 
Janne Grunau <j@jannau.net>

