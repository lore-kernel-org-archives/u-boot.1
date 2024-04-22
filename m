Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B996C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 14:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC59887F6;
	Mon, 22 Apr 2024 16:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DcBppicm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 584D78842C; Mon, 22 Apr 2024 16:00:54 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E5A883F1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 16:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713794451;
 bh=J4nkwbHMG+34KtsP2+5mix6NE4QHVTXA041NEWiu6oM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DcBppicmOZ0xmiLzcj1tDpysvdLRf1QHGNEFMELbjaAVe6fnx4K9DvNWE1LqpD0Hc
 Fy4TtUhrQmpPOZEhd1t+jqvSXaJYVLzvYFvLbWMHRx/2s0FD5KMbxihyeE9c0cJvB8
 37XvrKovTrH3hmzDyZgM+KPJb3jN7wy2lmSC8tgcnYx6UH2azruz6KcGtkK6897KG7
 lAYRsHxNy/j4a6Bi3SrK3SGg1dk3nS63lENjuOtBq0RvDBJpOGUzo5Gb8ViR2/laW9
 kM8dCD9HIQwpCv0zw9TqDpw8EigJQjB/hTeyRoYNe43bCXCayGZmrS9Tv+q2XDUtSA
 lOIsKgJXJ1fRQ==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5EB9E378212B;
 Mon, 22 Apr 2024 14:00:49 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 2/3] configs/rock5b: Set NET_PREFER_ROM_MAC_ADDR to y
Date: Mon, 22 Apr 2024 09:56:19 -0400
Message-ID: <20240422135927.23582-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135927.23582-1-detlev.casanova@collabora.com>
References: <20240422135927.23582-1-detlev.casanova@collabora.com>
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

---
 configs/rock5b-rk3588_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 58c7c44fb4f..4cd4d369561 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -106,3 +106,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x350b
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
+CONFIG_NET_PREFER_ROM_MAC_ADDR=y
-- 
2.43.2

