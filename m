Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543ADCD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD8B87FC2;
	Sun, 31 Mar 2024 22:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QGuatypA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6863B87FA7; Sun, 31 Mar 2024 22:29:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E278646E
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711916977; bh=AEGyc96GQhgj9FRbQvVkNxL2TUkt944QtsCqHkqkKI8=;
 b=QGuatypAFhzH3lJ7iZiWNHH0OfoJqrXrHzbD51lVw6sfu1sKccz4JvPO/anvstl1Rvx3eustD
 dURhCtb2agI+mfQ6jsR7z1tM22M2ONiuPjUkdUftzTOFGeJdCgRnMg4bXEhrGIP+v4VZAw9DbJf
 9Q0sgO1WnCC5PnummjNubWgFtWvKb7iQgqJG7ckoqUiDZJPTodcwsMeO6geKQ2EkFJqGjiShzde
 oB5kZK70z+jl78LnmOz/jDrS1OmxY/8UjgXhz5/3AasWSo1+9MF5hGupe0RJZoH0bDHaM0o7GQy
 tgIkxF1/sl9BrNG+/KLWaT24waJb5mK6O2jT2XtZro1A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 02/31] rockchip: rk3399-ficus: Enable TPL and use common bss
 and stack addr
Date: Sun, 31 Mar 2024 20:28:08 +0000
Message-ID: <20240331202921.262323-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7af8fc6b45ed44f7268
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

The rk3399-ficus board is only using SPL and not TPL+SPL like all other
RK3399 boards, chromebook bob/kevin excluded. It does not seem to be any
technical reason why this board was left using only SPL.

Switch to use TPL+SPL and use common bss and stack addresses to allow
for more options to be enabled in a future patch. Also add the missing
DEFAULT_FDT_FILE option.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/ficus-rk3399_defconfig | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
index 4859042d6b56..3bcd0fd66b91 100644
--- a/configs/ficus-rk3399_defconfig
+++ b/configs/ficus-rk3399_defconfig
@@ -2,32 +2,22 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00200000
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-ficus"
-CONFIG_SPL_TEXT_BASE=0xff8c2000
 CONFIG_ROCKCHIP_RK3399=y
-CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x4000
 CONFIG_TARGET_ROCK960_RK3399=y
-CONFIG_SPL_STACK=0xff8effff
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-ficus.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0xff8e0000
-CONFIG_SPL_BSS_MAX_SIZE=0x10000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-- 
2.43.2

