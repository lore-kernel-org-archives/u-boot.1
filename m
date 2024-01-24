Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF00C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 07:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC4687BF1;
	Wed, 24 Jan 2024 08:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SeaZv5EA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81BD387BF8; Wed, 24 Jan 2024 08:55:03 +0100 (CET)
Received: from mail-m92239.xmail.ntesmail.com (mail-m92239.xmail.ntesmail.com
 [103.126.92.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0623287BF0
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 08:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=SeaZv5EAW4OA0+KtZEj6zFx2zjf7BEqamiPliYO7wbMq4jKKrI8W0H6PpsKawu9WI/E1c62UZdqRPIBip3YXR5UtSi1iebUIlht1dr66jwfhOLoGBRtGBHRqqJ8FjAqEVHrJVRSO1wTlpKymOCuDXYeMC+Ewm67h6fF8W+wsRm8=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=UOUTi1/L182iFtU8xWoQMBsDdsseteCLe9NTVkGQNT4=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id DDE97400457;
 Wed, 24 Jan 2024 15:54:53 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 2/2] configs: rockchip: rk3036: Fix CONFIG_SPL_STACK define
Date: Wed, 24 Jan 2024 15:54:51 +0800
Message-Id: <20240124075451.818448-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124075451.818448-1-kever.yang@rock-chips.com>
References: <20240124075451.818448-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkhOQlYeQ0hPGR4ZTUJDGkJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8d3a7700cf2eb3kusndde97400457
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6SQw*PTwdUQEwAhJKDSgM
 FzkwCQtVSlVKTEtNS0NJQ0JPTk5OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0NLNwY+
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

The CONFIG_SPL_STACK for rk3036 is removed in below patch, need to add
it back.

Fixes: f113d7d3034 ("Convert CONFIG_SPL_STACK to Kconfig")
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 configs/evb-rk3036_defconfig   | 1 +
 configs/kylin-rk3036_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/evb-rk3036_defconfig b/configs/evb-rk3036_defconfig
index 21c657a441c..df6aaa97a0c 100644
--- a/configs/evb-rk3036_defconfig
+++ b/configs/evb-rk3036_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3036-sdk"
 CONFIG_SPL_TEXT_BASE=0x10081000
 CONFIG_ROCKCHIP_RK3036=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_STACK=0x10081fff
 CONFIG_DEBUG_UART_BASE=0x20068000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x60800800
diff --git a/configs/kylin-rk3036_defconfig b/configs/kylin-rk3036_defconfig
index 8d3f1a7b098..17360c552c7 100644
--- a/configs/kylin-rk3036_defconfig
+++ b/configs/kylin-rk3036_defconfig
@@ -17,6 +17,7 @@ CONFIG_SPL_TEXT_BASE=0x10081000
 CONFIG_ROCKCHIP_RK3036=y
 CONFIG_TARGET_KYLIN_RK3036=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
+CONFIG_SPL_STACK=0x10081fff
 CONFIG_DEBUG_UART_BASE=0x20068000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x60800800
-- 
2.25.1

