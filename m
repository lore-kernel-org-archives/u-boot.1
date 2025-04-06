Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBAAC36010
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83ED682BC7;
	Sun,  6 Apr 2025 02:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TnTbJNZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5AF082B54; Sun,  6 Apr 2025 02:25:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27C782BC8
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743899132; bh=RfBCyuGUK+1U6Hbdz8rdXlTy+E5rEgD6AzUQopVk1oE=;
 b=TnTbJNZ1V0wzJ3p+y7fnPMnsNMolx3uD7s42cm0Z0XNiqcikC4v8ML6iN00sWTc/D57PDn1YH
 zwhRJt98M5SUMyPoGoTAocEVCLxTmBBJ3d1dag3SlFw+brdC0XzsYqhhjMsK+JB2fI6bvIqEYi6
 NcXQro0yhL4D832O9wJERPWuf0fpQ4ALhDK4owgtHk0o32+FJ8H78ORTV+7wRBZ/tjv8jC0rD9b
 CEdfPMFfJja5P4lbK9NtZNdFq1kshKc1ual0aTzIyAyWC6x1Z3vj+lnmeLf5jwGjsn6Yn4AP9Kc
 P7YzUkohxBVIiHKKZ1av9etbr1AAPpH8qISlBhVEBECA==
X-Forward-Email-ID: 67f1c9fbfb2b6fde09d6a007
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 11/11] rockchip: Enable meminfo and rng commands for Generic
 RK3588
Date: Sun,  6 Apr 2025 00:24:32 +0000
Message-ID: <20250406002447.1555596-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406002447.1555596-1-jonas@kwiboo.se>
References: <20250406002447.1555596-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The meminfo and rng commands are helpful for testing, enable them.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/generic-rk3588_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index 51e31dce3a96..2075584cf564 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -22,6 +22,8 @@ CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MISC=y
@@ -29,6 +31,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-- 
2.49.0

