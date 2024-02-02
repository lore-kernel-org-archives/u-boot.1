Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB80CC48295
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 23:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399D487E9D;
	Sat,  3 Feb 2024 00:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BD2fxhFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6159D87E91; Sat,  3 Feb 2024 00:02:00 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862EE87E9E
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 00:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 828F0CE2E9B;
 Fri,  2 Feb 2024 23:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4A70C43390;
 Fri,  2 Feb 2024 23:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706914913;
 bh=5stDBoJ3WyQyhMJuI19y2t06T6UJIisEX4jeeEP8MV4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=BD2fxhFuXZBRK6ljfU5K7AAwZ95sgE3U9tM7dwFptRIt4EvxyMEgfgAXvhufbBVLv
 koyXGemn8b1KegrAZl+OEMVQmIG4ohNYXoqw8aa3KwPfkidUNwmm0CwpBLQWQuXjbB
 C1zg0QrgHgpPZgBSIiKNBqFm0F7gQjhzx20PnH5QModcPABE5CSl1ZOMLXONnI22/p
 Oux/YdD28nlioahPU+DXe2bvFusjMXI7/7jLIlMvqlJbf8j49WcQX/GdbB7IlVDLRN
 xiP+HufYK11cfp0ZuTw2ec2dCf9p98Q5nIR5Nymmi0Mdhhtyfc4lCNXZEYJ9SEOV/h
 jmjKDpXR++Vsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AA99BC4828F;
 Fri,  2 Feb 2024 23:01:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 03 Feb 2024 07:01:54 +0800
Subject: [PATCH 1/3] usb: dwc3: handle return value of clk_get_rate() correctly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-hisi-dwc3-v1-1-448050c7b690@outlook.com>
References: <20240203-hisi-dwc3-v1-0-448050c7b690@outlook.com>
In-Reply-To: <20240203-hisi-dwc3-v1-0-448050c7b690@outlook.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706914914; l=739;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=MtRm6I0TUIFEsPdBRn5YOjmXm923Al8xuyQ3q0v+CA4=;
 b=fNNQ8MqVY8DXKvl+W5Shf+D4GO5Gf+j1JGqJYqV0aELkn2/2MSDpbcv6j8Cam9FBwuqcY8/y3
 Keyvlzwu2BNCArmlTZwwtroczvhJ3pLmwUBmjCvCGRGh93ZNVcWc/am
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

clk_get_rate() return -ve on error, not 0. Fix it by replacing judging
NULL with IS_ERR_VALUE().

Fixes: 6bae0eb5b8bd("usb: dwc3: Calculate REFCLKPER based on reference clock")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4b4fcd8a22..06ff68105e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -137,7 +137,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 
 	if (dwc->ref_clk) {
 		rate = clk_get_rate(dwc->ref_clk);
-		if (!rate)
+		if (IS_ERR_VALUE(rate))
 			return;
 		period = NSEC_PER_SEC / rate;
 	} else {

-- 
2.43.0

