Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2829BC5DF71
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 08:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42FD18488F;
	Tue,  2 Jun 2026 10:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hB4BxArv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337A3848A2; Tue,  2 Jun 2026 10:45:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA8B84884
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 10:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 26C9F44077;
 Tue,  2 Jun 2026 08:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00B75C2BCC9;
 Tue,  2 Jun 2026 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780389948;
 bh=BULqzSG835lweGFuvRJE0GdjYzrWXdkq5Mq8kFZNqIU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=hB4BxArverk8BS4pkd2tHvcvaetScaG2B2A8zwrmebzvGls3BiquwRFx4J2S1hwUh
 uHbpWfDZYIA8TMRMZTUgU34L0ZrnOgRz6415hRgb7rexA6g+QU7dM0GHm2Ipxaya98
 TGztI+Szo5hUZpz1FNt7j+oyu9H/0f/KikS4ORJ/zvTs4TfSn2pEZP2FEH7iOHdd5L
 q55R3J7foD4bdGXjKlTZdg/F2Xu75yH8CjR/UVRCVAgzzzSAAWUPA10F5O9ChDbawl
 ByfsrBelS9/d7MAPiv/Dl0yrAvBkCmXvcWkzIqaoWzY/l3pw3kYq75FRjRAWborHsG
 G3jFmiNLlp2uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DE2C7C5DF71;
 Tue,  2 Jun 2026 08:45:47 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Tue, 02 Jun 2026 18:45:46 +1000
Subject: [PATCH 1/2] cmd: fastboot: Add keyed abort option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-fastboot-abort-keyed-v1-1-414aac5a06b8@samcday.com>
References: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
In-Reply-To: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780389946; l=1315;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=nn6vYNeRe+W+GBTC2Gi1LZ4P9G9q9e0DhQ0LMyuLZOo=;
 b=CLBCsPkQJ6dwkd3ubzniPqrNffa5zYvtzrtnsS+ZynF4CRbA6F3LzEaN5w8fggupmx70GYmDR
 QlcCYHld08PCasvNslU89Eglw1McG/OFor0dcXuw4vOHTsmPoq0cFAk
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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

Works the same as CONFIG_CMD_UMS_ABORT_KEYED does: any keypress will
abort fastboot mode (rather than only ctrl-c).

Signed-off-by: Sam Day <me@samcday.com>
---
 cmd/Kconfig    | 6 ++++++
 cmd/fastboot.c | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a19..439409d6f2c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1208,6 +1208,12 @@ config CMD_FASTBOOT
 
 	  See doc/android/fastboot.rst for more information.
 
+config CMD_FASTBOOT_ABORT_KEYED
+	bool "fastboot abort with any key"
+	depends on CMD_FASTBOOT && USB_FUNCTION_FASTBOOT
+	help
+	  Allow interruption of USB fastboot mode with any key pressed.
+
 config CMD_FLASH
 	bool "flinfo, erase, protect"
 	default y
diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index e71f873527b..f3929f88dfa 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -103,8 +103,15 @@ static int do_fastboot_usb(int argc, char *const argv[],
 	while (1) {
 		if (g_dnl_detach())
 			break;
-		if (ctrlc())
+		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
+			if (tstc()) {
+				getchar();
+				puts("\rOperation aborted.\n");
+				break;
+			}
+		} else if (ctrlc()) {
 			break;
+		}
 		schedule();
 		dm_usb_gadget_handle_interrupts(udc);
 	}

-- 
2.54.0


