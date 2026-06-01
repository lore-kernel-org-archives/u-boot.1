Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95775CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B68884979;
	Mon,  1 Jun 2026 14:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fO4qfKyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B55584857; Mon,  1 Jun 2026 10:13:02 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD6B846A3
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 45E1F435F4;
 Mon,  1 Jun 2026 08:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C5CBC2BCF4;
 Mon,  1 Jun 2026 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780301573;
 bh=M5JaKvrhZi6aDC6MOLYUJwmVzRry6Ff/iYRBcYViQBU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=fO4qfKyEBndWNPEQ41r/gfOCLpeP6F6d8NLNQFWWYI1dbJjJpLZ/knOpDsVhLBUhT
 N9aoVpREZj8Ts1oEFWtQZM4Q4x5Xu3PqLGocSVZm2JgIPovAdVmidOGnnSZLofMJmZ
 p+79QzaPTpzoNwkA8lSshFtSVy4OdLzbFOCRkO8ksYOq5JZ00VwK38qEfRQansomNA
 8SUFs0dQ+rzJgGYgh8y5oChdFwLvC0nQxd2JhES5/onCt68x7eWEEBB3IVw68JyrJZ
 oeQLFZ7u2RDoPlg2bMHWapEgoQisWl6uRvZYoOkXMLrrhZyKONRUoSX4y1/EARkWAK
 pAwqWAbwik33Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 12B70CD6E60;
 Mon,  1 Jun 2026 08:12:53 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 01 Jun 2026 18:12:56 +1000
Subject: [PATCH RESEND 15/16] serial: msm: wait for TX empty before reinit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-armv7-v1-15-05a08d87e476@samcday.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780301569; l=940;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=6h2JS7vb3rrgMzpe4XUkpAHDk1EZODZWYc14tqNSuVo=;
 b=XP/ENLw6bNzwF850cp92wJHgfDa/DU5Vfro42lB2S9GD2fwgqcpctpS2aPmp+ONGczJL+q/on
 fDpNoU3MW60C12tRC6pS/t3d1FmUXpLQzvYMpcH7xdbPUN01HqpYafF
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

At least on UARTDM 1.3, I was noticing the early UART debug banner
getting corrupted. It turns out this is because U-Boot was
re-initializing the UARTDM block and writing to it before it had
finished shifting out the FIFO from the previous bootloader. Waiting for
TX_EMPTY in the status register consistently fixes the issue.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/serial/serial_msm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 10948e2aede..db085d68a0d 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -351,6 +351,8 @@ static inline void _debug_uart_init(void)
 	 *   - HMIBSC: GCC_BLSP1_UART1_APPS_CLK
 	 */
 	//apq8016_clk_init_uart(0x1800000, <uart_clk_id>);
+	while (!(readl(init_serial_data.base + UARTDM_SR) & UARTDM_SR_TX_EMPTY))
+		;
 	uart_dm_init(&init_serial_data);
 }
 

-- 
2.54.0


