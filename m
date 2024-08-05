Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D992C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 08:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4EB9888B9;
	Mon,  5 Aug 2024 10:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="F9zmzgKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 833178889C; Mon,  5 Aug 2024 10:44:24 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B09888C2
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 10:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722847453; bh=1Rz95j41M864KE21pZn5jypSDuIOn7xFKPBdLXOe580=;
 b=F9zmzgKOKG4uFJKrjfRNwYck/H3lMTvt7PPsVi9Vt+Ubj4lNxRoWs/prnzSy28xAvWxci8Ttv
 Qt97J3RLGf0I2y9gu7wQMVMAbAPmr+THa8GuFshLWOWqKMksUiVYzLJmH6eqbXmt+k+A7g9h40K
 MNehRh7nEXQWkdsgZYMgdzmRRyr7iVCf8hgqqYBaq+/gIbcqkuS2n8qa/CGzW5UVtgENVSWmGwz
 Y83tE9je3XDUBxtIALBGYuMPpptX+Kyx+tKDQY4TkjBLGLJhZgJc0owV5wCyHmhbX6yjlqZvfPs
 ANTGsu+oU6wGlQE3n74nVx8Et9GdSRCXns1OiKCWTXoQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/4] rockchip: px30: Skip serial pinctrl at pre-reloc phase
Date: Mon,  5 Aug 2024 08:43:44 +0000
Message-ID: <20240805084350.3895788-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805084350.3895788-1-jonas@kwiboo.se>
References: <20240805084350.3895788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66b090daef96678d293a4f07
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

UART pinctrl for serial is typically applied multiple times:
- in TPL for DEBUG_UART in board_debug_uart_init()
- in SPL for DEBUG_UART in board_debug_uart_init()
- in SPL using pinctrl from DT
- in pre-reloc phase using pinctrl from DT
- after relocation using pinctrl from DT

Skip including UART pinctrl for the pre-reloc phase to save time during
boot.

After this a warning may be shown with LOGLEVEL=5 (or higher), it is
safe to ignore this warning as device probe is successful even when
pinctrl cannot be applied:

  ns16550_serial serial@ff160000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/px30-u-boot.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
index 3dc70d4e432b..2a0e85d92a2a 100644
--- a/arch/arm/dts/px30-u-boot.dtsi
+++ b/arch/arm/dts/px30-u-boot.dtsi
@@ -38,7 +38,8 @@
 };
 
 &uart2m0_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
 
 &uart5 {
-- 
2.45.2

