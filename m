Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3063FA3748
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 14:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A0D584258;
	Fri,  2 Jan 2026 15:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=forissier.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=forissier.org header.i=@forissier.org header.b="h3flVOyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CA5E84255; Fri,  2 Jan 2026 15:55:15 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8DE68424E
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 15:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=forissier.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome@forissier.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42b3b0d76fcso6930216f8f.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 06:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=forissier.org; s=google; t=1767365712; x=1767970512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R8hzba2MVleTXDZJYgXBrfeQsE0VfWLtFqOqOij2Kmg=;
 b=h3flVOyR1GdZCQVEdzbOIq8+dQ7KsW4pa5wYn1Zzv5ijltsk8SmnQAiK7VJPw5ZebW
 W4j7EvuJMNwu8L69oolHmCJqyP2AWmzU4GtHb4EYpSkbVZLgFNpOz7ZY03C91S6lKynW
 betOTIGtr7aRSLp8nD2lSgigt9uSe+h9VQ5VEa+WOeUXpxMbtvgrSAAwTiKmo4eNEBOs
 yY4fOOzdd0+G7L9CVSV0MllEWlVIaJgyhPYxXJgMTAmoqlyutrsH9U+Auq4kWv2pzZfK
 nS2eYwghi3SHH0KSaqBknlYv+eI2VVJ0OPIzMVsJ2Uw5U+rLxDAarWigKwbUAoW2yMsF
 4hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767365712; x=1767970512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8hzba2MVleTXDZJYgXBrfeQsE0VfWLtFqOqOij2Kmg=;
 b=NxLzJXS3z4m9IaLU5srQ816tXwOz2CiWIov2HSh6pjMD5LuU8UStJT91JGZcScxgT5
 LJTsZ9hEoAPNlE9NEQ+iZstYsdb18C2edimPqe4OCMaISN0qQACNvMud2SjgIwPEiVmn
 hlHMzPRE86o5C8aqf4FRkzu7b0NR61LWz957HzQchv+WNsrlHUzdxXh60BNFRDqTd1hM
 OQXhLmz2sP3D5mbkxxQ/rga/ga6v3TVZI/M52jPkAOkGPm3X2r4zNTbZoIhc5/BceO4B
 6SHXZuJdN7Bsu+A/TCPrrpeIw1PK196JjNlKv2l8yrKOvv7+pohwL9i8T27ZXgCiDkrX
 vRRQ==
X-Gm-Message-State: AOJu0YwyDn3+Zun//lWmcQMmqPmyrZ9FQ98R5xlIpMZFW6dKwz5beHbg
 aqkZUEY1G1Z6RJaDxa0vkK86jCjDfec1nsU+aG3UdzArEXpl3vVh/tuI7HR90UvvBUDYuWifEwp
 HNOPYzmA=
X-Gm-Gg: AY/fxX4qToCuBk37gFmOVzVocJBnBOXInsMip0z4SL35cMrySlHolVe4Uub3yx702mc
 cSlpg1NRsS5MD2OTCQCaMOenFhCqSF/VERwKPmjHvS0FCW32t6FSQxb7XmmKU9Xlf76TRLE0rDm
 fc2jIFtNyr/3ANMiL7om/m3ISNmriiWo5Gl91neV7vYkqiHZyfgx6g2XBtZE2FdXDNPoj683tgb
 krT34ij+8og2H8fFbtVemDUNMvPD0AUY0GlVLttU4ABuR0BKwASTT/9/tDNzwIhPVpEmRc8alFc
 ivMDUpu9+3aFOTKmuSXJG40ITVTBOaneREHK+5zlYkxxERqxf2hIZQFcAr2dqR2tPv6M90u5s3P
 Ur6greCG7oTmzZaTNaqnpvII45a9/cElNFA0xzwnNsmaPyzI20/VdP7aPDpHpvsbS0S6MPjix4k
 qBXeHZiKRV
X-Google-Smtp-Source: AGHT+IFrbhZoJ1zzTP/Uid7ISrzO08XMq1kfjm3Yv3k0zjmdpAIRgfsGrqJLGcOhNIb5I72EQFihbA==
X-Received: by 2002:a05:6000:186e:b0:432:86e1:bd38 with SMTP id
 ffacd0b85a97d-43286e1be04mr29855828f8f.39.1767365711569; 
 Fri, 02 Jan 2026 06:55:11 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:21b:21ff:febc:b336])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab257asm85794529f8f.38.2026.01.02.06.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 06:55:11 -0800 (PST)
From: Jerome Forissier <jerome@forissier.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome@forissier.org>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>, Chen-Yu Tsai <wens@kernel.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 No generic patch CC mail please <noreply@example.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH] MAINTAINERS: update my email address
Date: Fri,  2 Jan 2026 15:55:00 +0100
Message-ID: <20260102145504.3222666-1-jerome@forissier.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Jan 2026 15:59:35 +0100
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

My linaro.org email isn't valid anymore. Use my personal email instead.

Signed-off-by: Jerome Forissier <jerome@forissier.org>
---

 .mailmap    | 1 +
 MAINTAINERS | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 7b0d730b618a..2fe12e76d0c8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -69,6 +69,7 @@ Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzacher@theobroma-systems.com>
 Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
+Jerome Forissier <jerome@forissier.org> <jerome.forissier@linaro.org>
 John Linn <john.linn@amd.com> <john.linn@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyothee@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyotheeswar.reddy.mutthareddyvari@xilinx.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 27ce73d83f48..4cc34695b525 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1443,7 +1443,7 @@ N:	mmc
 NETWORK
 M:	Joe Hershberger <joe.hershberger@ni.com>
 M:	Ramon Fried <rfried.dev@gmail.com>
-M:	Jerome Forissier <jerome.forissier@linaro.org>
+M:	Jerome Forissier <jerome@forissier.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-net.git
 F:	drivers/net/
@@ -1451,7 +1451,7 @@ F:	include/net.h
 F:	net/
 
 NETWORK (LWIP)
-M:	Jerome Forissier <jerome.forissier@linaro.org>
+M:	Jerome Forissier <jerome@forissier.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-net.git
 F:	cmd/lwip/
@@ -1903,7 +1903,7 @@ F:	drivers/usb/host/xhci*
 F:	include/usb/xhci.h
 
 UTHREAD
-M:	Jerome Forissier <jerome.forissier@linaro.org>
+M:	Jerome Forissier <jerome@forissier.org>
 S:	Maintained
 F:	cmd/spawn.c
 F:	include/uthread.h
-- 
2.48.1

base-commit: 601733e7087286f211634204c60fe86856ddbd78
branch: update-maintainers-jforissier
