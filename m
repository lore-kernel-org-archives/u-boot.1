Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB739CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 08:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B34C8848B9;
	Tue,  2 Jun 2026 10:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NMYHwD70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1D3848A2; Tue,  2 Jun 2026 10:45:54 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FF98488B
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 10:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 315B24458E;
 Tue,  2 Jun 2026 08:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A533C2BCC7;
 Tue,  2 Jun 2026 08:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780389948;
 bh=ZrAOpERK1cZ3sk1pAuFgnkff8cVrYoyXu0fpY7k0JLg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=NMYHwD70MszhYC0Yf0kTYuIBVBl42az1rcVncZXkqqDUPgce3huYr4idS6FYK9v8v
 dsRVq/c7okmXL+l5BW6WiV/tIauGjoE1q00Yo5/n4FvQfgV0kSaEiuzHrfVID/zqH2
 yITKO6YeXVNJyUrAz26yzzi5dvaz+YABovMOOKFkm3xswb9VR8/Yo7mRrwasBSHwow
 r6UkEfgxvYuC8KnZ/J/6nFjkVkWzIy4hcq9R4yBhbyXGcdKRmms6Te1eORiOI0uGzV
 Hwa3Adb08OGEc2Q9tJ+4tHscfS3pfsDfSQI3lLmgDynzjM8pvZdG9hFdQR9KqYw7I6
 5rcdiQgm7rtTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id EB22DCD6E4A;
 Tue,  2 Jun 2026 08:45:47 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Tue, 02 Jun 2026 18:45:47 +1000
Subject: [PATCH 2/2] board: qualcomm: phone: enable
 CMD_FASTBOOT_ABORT_KEYED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-fastboot-abort-keyed-v1-2-414aac5a06b8@samcday.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780389946; l=1663;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=IUiHS+xJ+tA2nulvCQsv/z2sshe+2rZKg/R5HJhxRC8=;
 b=swba8dP0cm4VV969e7smt/K37ZkDuIfrmK7q9nv+3jrJEq6AbVd9TmqmhWgb0qJi0RxQ8B9gt
 JMt7/2Z1xhNCJZ2UZPS3JHkPBPwsTzdLr5dQwByTago08b1VdEUp7y2
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

Thus users are able to exit from fastboot by pressing a key.

It's also possible to bail out by running `fastboot continue` from the
host, but it's nice to be consistent with UMS. Also convenient to be
able to bailout during testing if USB isn't working properly.

Signed-off-by: Sam Day <me@samcday.com>
---
 board/qualcomm/qcom-phone.config | 1 +
 board/qualcomm/qcom-phone.env    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone.config
index d24094eefdd..1387aa1dfa2 100644
--- a/board/qualcomm/qcom-phone.config
+++ b/board/qualcomm/qcom-phone.config
@@ -13,6 +13,7 @@ CONFIG_FASTBOOT_BUF_ADDR=0x1A000000
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_USB_FUNCTION_ACM=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
+CONFIG_CMD_FASTBOOT_ABORT_KEYED=y
 
 # Record all console output and let it be dumped via fastboot
 CONFIG_CONSOLE_RECORD=y
diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
index e91ae3ecdfb..566ce3c01ea 100644
--- a/board/qualcomm/qcom-phone.env
+++ b/board/qualcomm/qcom-phone.env
@@ -32,7 +32,7 @@ menucmd=setenv bootcmd run menucmd; bootmenu -1
 bootmenu_0=Boot=bootefi bootmgr; pause
 bootmenu_1=Enable serial console gadget=run serial_gadget
 bootmenu_2=Enable USB mass storage=echo "Press any key to exit UMS mode"; ums 0 scsi 0
-bootmenu_3=Enable fastboot mode=run fastboot
+bootmenu_3=Enable fastboot mode=echo "Press any key to exit fastboot mode"; run fastboot
 # Disabling bootretry means we'll just drop the shell
 bootmenu_4=Drop to shell=setenv bootretry -1
 bootmenu_5=Reset device=reset

-- 
2.54.0


