Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F21AC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 08:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EABFD888C6;
	Mon,  5 Aug 2024 10:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pMRSIjBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F24888C6; Mon,  5 Aug 2024 10:44:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01194887E8
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 10:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722847448; bh=h1K1BCTAKVwfHPSPF6J/vTZboylpNPEhnsl5PvASwOA=;
 b=pMRSIjBY2EFSSfWSHBX497sJHwlGBA+agG8rwajRsKaTMgUlFgmUvg0tqOymuKIXVZX8RACqn
 vUiW9lvwLQsQkG/vXUvKoBcS7uboANIs32x7teesnpBR2DzpKAGFAlLLaX5UWuba9odL0ic+zwA
 /91q1poDLqjCmsLh2EkDdeOw2+D6N2wVdCucyxnaVtIoQLUhaeGBuiLlOPCLJf9LbKnTIre03G1
 6yjhNVNholE1vip+gNDeXeWdddrXKFfBpKPNvNEivgPHGSzHE7AOl9XEovS2AEBO4AN3oRKCAxU
 lZvMU9Ifd3KHAeVkPS4RyVDcFpZUieVxMTJI65kua7PQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/4] rockchip: rk356x: Skip serial pinctrl at pre-reloc phase
Date: Mon,  5 Aug 2024 08:43:42 +0000
Message-ID: <20240805084350.3895788-3-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66b090d4ef96678d293a4ed4
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
- in external TPL
- in SPL for DEBUG_UART in board_debug_uart_init()
- in SPL using pinctrl from DT
- in pre-reloc phase using pinctrl from DT
- after relocation using pinctrl from DT

Skip including UART pinctrl for the pre-reloc phase to save time during
boot. On a Radxa ZERO 3W this reduce boot time by ~120 ms.

After this a warning may be shown with LOGLEVEL=5 (or higher), it is
safe to ignore this warning as device probe is successful even when
pinctrl cannot be applied:

  ns16550_serial serial@fe660000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk356x-u-boot.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 0a0943b462a9..9e03d2d8eb97 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -163,7 +163,8 @@
 };
 
 &uart2m0_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
 
 &xin24m {
-- 
2.45.2

