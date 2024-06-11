Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6797C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 058F1887F6;
	Tue, 11 Jun 2024 23:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Frmnav7Z";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="qpRTHpia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E2988709; Tue, 11 Jun 2024 23:04:48 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD8C887F6
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.west.internal (Postfix) with ESMTP id 4E1031C000EF;
 Tue, 11 Jun 2024 17:04:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 11 Jun 2024 17:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718139883;
 x=1718226283; bh=ydyE0hHnWq5jlpyj9cSj0DfeWuG0yD/44U9N3Wky33U=; b=
 Frmnav7Zr68TQ93S9W5xJuHMEdU38lhIKpSPecbCkGtn2wcoOLe+FQrtTpfL/tmd
 JbVHjJStTYBgnkEBCTEJZecfTPT01F0pb/OQXQnk1CRtN7EnhHcTMtn6jfxcqE/o
 WNtcMRi78r988114gwjGT0K7MgZiaJDroewz8kiSRXYAVeARPX5Vc7hJH5/8B6bA
 DSPcmPacZ794ycGEYz/zPjwYYq13VNX6MR3I9/Lu/+c0u1VITbUMJa/oIEGIdP2w
 NKhCcZ0GOKRTBmHgUzr9Uo4LyxSrvBFSiyi4ntqJH0cIQtT5bYfljsFdXoe1cLBx
 9iuf6G6lpGg/n2RVrXRjQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139883; x=
 1718226283; bh=ydyE0hHnWq5jlpyj9cSj0DfeWuG0yD/44U9N3Wky33U=; b=q
 pRTHpiarggh/g5iJpTa2VnYKLntYrUUw+PFiku7cPAp+yo6hAF9/o394LpjNuWLv
 JfWImoj4VBt+gE1aQbDJ7E35zDBgcxhM/wVEEmwIJbBRbFW2wWX1wPe2HkK9UqIr
 MD7iJxALR4DjskKkPXD/VjzyKkh6/DZKxawV3ansgpnHa2GNokqy8/jzEjaAdnnf
 dFNXc0YpZzWWYEdmFFsrP1oDO/Yc7CEFtmkCT+MY8zgKCo6wE3XaJy4kK+9GtU+l
 /q3lQyH0UlmOjYfgqhGB3rW230hcBxoRveFjFn6e93VIN5XhgGsMG/3PQXHB4Zz1
 2l14CXsYD8D0lQyBXD8cg==
X-ME-Sender: <xms:67toZi5n2xZyfgJiIv8cSkQxj1oGpv4XFycpsiw-CzwikJmDFCiUdw>
 <xme:67toZr5efCQKTpmpSWpZ6BQ-0FXwePRizyHo2RNqI64fir_0HMojOl0zlWx0bYopY
 PvF-nLiHenAAGmU79A>
X-ME-Received: <xmr:67toZhdjm1jzNMiGoeMxV_D2oyZXwD_IZQRNTLGS96UfzXw-My5E2mk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:67toZvJGR-VLc9TgLc4DWCxW4yHUtTITxjzWvJLjrk_SEn1fDT5AGg>
 <xmx:67toZmJlcij24cfP3DaVvGczbv-YQIf2LP4belIJxFSD7kte3qhEgg>
 <xmx:67toZgzTCfN1bccNf4W24IT0McuI2o391lKvd1s15vfMvMtWoTgQIQ>
 <xmx:67toZqI1ebhrmn1muPiOM2JSnA_lEv_v4fNGx0xwYJZ7JM2layruBA>
 <xmx:67toZl8_VXRbm5PFHZ0TJHgfMd-x-xdHqm7TNYgHzpl8dS5Us66XrqOP>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:42 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 11 Jun 2024 22:04:11 +0100
Subject: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=b8cv+fSXzB/NCGWkycvkaSbWmX/q5RvyS0OSFN2cuEI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3WenO31bacV4QqpnWojswsbXVSWb2DQeTDk4O/7wh
 QQ3pUOqHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCREgWG/zUnxbQrjdVfMcYv
 i5ykxyTDFrye/YmAS/jNq2/K9u/MfcDwV/ZIlVKl1YV3F5auKX7VJjJ/zdbZob9aWnZP+KKmKbn
 /DiMA
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

The default value CYCLIC_MAX_CPU_TIME_US was 1000, which is
a little bit too low for slower hardware and sandbox.

On my MIPS Boston FPGA board with interaptiv CPU, wdt_cyclic
can easily take 3200 us to run.

On azure pipeline sandbox_clang, wdt_cyclic some times goes
beyond 1300 us.

Raise default value to 5000, which is the value already taken
by octeon_nic32. This is still sufficent to maintain system
responsiveness.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 common/Kconfig                 | 2 +-
 configs/octeon_nic23_defconfig | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 5e3070e92539..4bb9f08977aa 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -628,7 +628,7 @@ if CYCLIC
 
 config CYCLIC_MAX_CPU_TIME_US
 	int "Sets the max allowed time for a cyclic function in us"
-	default 1000
+	default 5000
 	help
 	  The max allowed time for a cyclic function in us. If a functions
 	  takes longer than this duration this function will get unregistered
diff --git a/configs/octeon_nic23_defconfig b/configs/octeon_nic23_defconfig
index f7c35536a021..5a8db5a0876b 100644
--- a/configs/octeon_nic23_defconfig
+++ b/configs/octeon_nic23_defconfig
@@ -25,7 +25,6 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
 # CONFIG_SYS_DEVICE_NULLDEV is not set
 CONFIG_CYCLIC=y
-CONFIG_CYCLIC_MAX_CPU_TIME_US=5000
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y

-- 
2.43.0

