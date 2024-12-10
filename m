Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E17E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 22:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D2B080212;
	Tue, 10 Dec 2024 23:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Ebbpgyym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 184E980202; Tue, 10 Dec 2024 23:24:06 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B7C80219
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 23:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=db8b=TE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1733869439; bh=g2b2RogcrC9qWpftOuB4Y/N6ctLBmgyu98kimW2Wv/E=;
 b=Ebbpgyym0hIL7xFFc2Qddpa+0ef+j2PBcE2XhN5oEa1PrdhQfkXTFJa1zW8W13ZLpvFIfmVwJ
 eliFHrnW330mDnHJyP42I/5BKZUbiwDtcAO8pKy601gFXRg9o2YPNx1p/oALZUOnfeHhbpJA1eI
 OXXNNZm3v3wQXvPT0w9+4erCSA157UtYXJScGR6gWMOogkGMUTUdIKvoCicnPUYY1TZQjrrPUkQ
 B2Q+dmQVhVkP9BKxBlC8j/24cRC0dDg3x5CJiXaxrr+vM8BFxF3E2KAqLtfLSs3SbPWa9ZNzuoJ
 fp7wWbWQooc6G5DncZqypQf5TYuOMBV/bWy5uHGfNu/w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: FUKAUMI Naoki <naoki@radxa.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/2] rockchip: rk3588-generic: Enable support for RK3582
Date: Tue, 10 Dec 2024 22:23:36 +0000
Message-ID: <20241210222341.3537543-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210222341.3537543-1-jonas@kwiboo.se>
References: <20241210222341.3537543-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6758bf7eb234f44256187cc7
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

Add Kconfig option OF_SYSTEM_SETUP=y to support booting boards with a
RK3582 SoC. CPU and GPU cores are failed based on ip-state and policy.

Tested on a ROCK 5C Lite v1.1:

  cpu-code: 35 82
  ip-state: 10 00 00
  fail gpu
  fail cpu cpu@400
  fail cpu cpu@500

and on a Radxa E52C:

  cpu-code: 35 82
  ip-state: 00 04 00
  fail gpu
  fail cpu cpu@600
  fail cpu cpu@700

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/generic-rk3588_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index 51e31dce3a96..903653911f71 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
-- 
2.47.1

