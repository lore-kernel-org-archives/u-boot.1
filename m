Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2910CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D718498C;
	Mon,  1 Jun 2026 14:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q96w+w83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A85E18485F; Mon,  1 Jun 2026 10:13:02 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8CF8486D
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 563A044677;
 Mon,  1 Jun 2026 08:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3741AC2BD00;
 Mon,  1 Jun 2026 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780301573;
 bh=4IjMp+wdaAjSeXqQqCYKVhEVSMu6rnTOXl4Zo8wWMso=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=q96w+w83eQ8IquuXLXtLoNiOKchTdZEYQ8rxuzGi5ZeA4Ph14k97YAt5hQx1EuQg8
 T/8mplh08to3MpoXTC9FiYUSiu1np3iwCik9+/VcFCK050YRTK2dA9M6Vpl8VG1zEZ
 IOXDtMDun+v+DEQGn5MEL3+bFrBA0QBm9/KXLrQibWidgMX32afCNMXrH1YWFQk5m4
 GE4brJCXKVWqs2Px3EwoHKV9yYITPe/+jlba0Eo1nL2vL65RSyLkRhZMDPO8B6+0Wz
 /flwZcNZi/ufOhTWvVQ8BIwqtzPhw06SmNe4M7AtEC+ULyV1E5oAPV13qVJmtTk61h
 49EzZOQBaK/zA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2D75DCD6E4C;
 Mon,  1 Jun 2026 08:12:53 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 01 Jun 2026 18:12:57 +1000
Subject: [PATCH RESEND 16/16] button: remap phone HOMEPAGE button
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-armv7-v1-16-05a08d87e476@samcday.com>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780301569; l=1243;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=zFKECPQUM7NXvjsAPsLT2XslIs2BY83r61O3tGD/uCE=;
 b=M9ItX/5UZSwvRutBeR32p/VPoxOYEMDcaq5ri5tzw2TR8KMbLOvccUDKqXrr8U29ePmlHWbsS
 DIfOKdOXokQB2z+wITnbfgYNKFDOgEevYHqaGOqgpbYfi62HyEH1U81
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

If I'm being honest, I thought of doing this primarily because I
haven't wired up the PMIC power button on my samsung-expressltexx yet.
But, I think it does make sense to remap the center button on older
Android phones to act as the Enter key anyway.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/button/Kconfig         | 2 +-
 drivers/button/button-uclass.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
index 6cae16fcc8b..8e6bab74cf1 100644
--- a/drivers/button/Kconfig
+++ b/drivers/button/Kconfig
@@ -18,7 +18,7 @@ config BUTTON_REMAP_PHONE_KEYS
 	  are remapped to the following navigation keys:
 	  - Volume up: Up
 	  - Volume down: Down
-	  - Power: Enter
+	  - Home/Power: Enter
 
 config BUTTON_ADC
 	bool "Button adc"
diff --git a/drivers/button/button-uclass.c b/drivers/button/button-uclass.c
index 025917887e8..4e37180fc09 100644
--- a/drivers/button/button-uclass.c
+++ b/drivers/button/button-uclass.c
@@ -45,6 +45,7 @@ static int button_remap_phone_keys(int code)
 		return KEY_UP;
 	case KEY_VOLUMEDOWN:
 		return KEY_DOWN;
+	case KEY_HOMEPAGE:
 	case KEY_POWER:
 		return KEY_ENTER;
 	default:

-- 
2.54.0


