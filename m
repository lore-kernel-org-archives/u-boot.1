Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CFAC4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C3187FB5;
	Sat, 13 Apr 2024 20:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="waaaYVu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874F48801F; Sat, 13 Apr 2024 20:14:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E55687FB5
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032085; bh=8OqRkAlYnPB/qN/LVWsFqnqmkDmFOR7ElQW7jJ1ZPj4=;
 b=waaaYVu1XyXZV2V28/bcNvPyG0U2+ciVPg8rHTkNoZHt+gT4jdvQMvRz9cTId+rXFFoFHPT8l
 o2qbQUKQvEousRabkatvfXs+Aor983oMkOF/pEneIjsPyxUh9vHYAPKcrY+ogn4DMog9pr1O7xw
 lirW7bN/RETmTHkoQhmwDjkCTLujVCXmCcLwRIRhro0+MDEnz/LUkgEkFim14hZ/AwZLbRmuVE7
 KA5fZY9hCQi5c2VqeJKRiHOVN7kPDwuyctVrTQpXpMiYgu2dLLCvyl7SQ/MTQW57DibBL6dDw5f
 hVZ70djR1mjQY7gweRa63wYfTIFYndeJMh6QmctgQWIg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>, Eugen
 Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 03/23] rockchip: rk35xx: Drop USB_GADGET_PRODUCT_NUM
 Kconfig option
Date: Sat, 13 Apr 2024 18:13:37 +0000
Message-ID: <20240413181425.1384357-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661acb956fbb975d49a653eb
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

The commit 8c19275fdb13 ("rockchip: Update the default USB Product ID
value") added default product id for all supported Rockchip SoCs.

Remove USB_GADGET_PRODUCT_NUM options that match default value from
RK35xx boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 configs/pinetab2-rk3566_defconfig   | 1 -
 configs/rock5b-rk3588_defconfig     | 1 -
 configs/turing-rk1-rk3588_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index bc7a77aa52fd..edeb1d89b993 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -99,7 +99,6 @@ CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_PRODUCT_NUM=0x350a
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 58c7c44fb4f7..ac4f1ebb4c13 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -102,7 +102,6 @@ CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_PRODUCT_NUM=0x350b
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 07f7b848529e..e18ced721789 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -109,7 +109,6 @@ CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_PRODUCT_NUM=0x350b
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

