Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D95FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A6484011;
	Sat, 25 Apr 2026 18:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="fc8ly/CR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BDEC842BF; Sat, 25 Apr 2026 18:33:05 +0200 (CEST)
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp
 [IPv6:2001:cf8:ace:41::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576FF843AF
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jacky.Cao@sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sony.com; s=s1jp; t=1777134735; x=1808670735;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cVboO+fPoSd7ca95hKxNyTN7P+kT/SJI8zKrOIP8mME=;
 b=fc8ly/CRUHv0hxK4r9a1ZGZxwnjkJKMGTv7JqR2qb7Azx6fyHH8FJEVH
 6Ic7RI/GjjPaBKrNA4HKXqNO7fqi0u4drPLFbTgnf+pWsH85Ds8WvT1ZT
 CIPL2pfnGrkDfkTH04fJ5QZj/QrgPUWak+FQglgBPuMVJfyUKkh9ew5ON
 vNWtSBw8+UKxiMtHUF2ny9kuvi6WNypd93xoONSQLiVQhps0n+ZqFH/rd
 TH28NKskH/kr2nDuvDS/E5k1WHGTP5Phq4CEUGZuN2W18i8mDLUAfuU+Z
 2Iai8xYuHIYX0d7Ejp5TAL9KTVKT0a2Tqd8KF0zKbO+9gQSabITU7BqrS g==;
X-CSE-ConnectionGUID: bmdCHUAfRd+29hBiXltmeQ==
X-CSE-MsgGUID: Lv6Hzn3vQxGWoTNXILWZmQ==
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp)
 ([IPv6:2001:cf8:0:6e7::6])
 by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 14:37:41 +0900
X-CSE-ConnectionGUID: g3dGA21MRWC8wACDVFG7qw==
X-CSE-MsgGUID: rOsyLaghSiy0PDccKIcpbg==
X-IronPort-AV: E=Sophos;i="6.23,194,1770562800"; d="scan'208";a="634878588"
Received: from unknown (HELO cscsh-5109201560-dev.ap.sony.com)
 ([43.82.111.224])
 by jpmta-ob1.noc.sony.co.jp with ESMTP; 23 Apr 2026 14:37:40 +0900
From: Jacky Cao <Jacky.Cao@sony.com>
To: u-boot@lists.denx.de
Cc: simon.gaynor@ezurio.com, trini@konsulko.com,
 troy.kisky@boundarydevices.com, Jacky Cao <Jacky.Cao@sony.com>
Subject: [PATCH v1] nitrogen6x: Fix compile error if VIDEO_IPUV3 is disabled
Date: Thu, 23 Apr 2026 13:37:25 +0800
Message-Id: <20260423053725.103866-1-Jacky.Cao@sony.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:12 +0200
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

Following compile error happens for mx6qsabrelite when disable
CONFIG_VIDEO_IPUV3.

board/boundary/nitrogen6x/nitrogen6x.c: In function 'misc_init_r':
board/boundary/nitrogen6x/nitrogen6x.c:912:22: error: 'RGB_BACKLIGHT_GP' undeclared (first use in this function)
  912 |         gpio_request(RGB_BACKLIGHT_GP, "lvds backlight");
      |                      ^~~~~~~~~~~~~~~~
board/boundary/nitrogen6x/nitrogen6x.c:912:22: note: each undeclared identifier is reported only once for each function it appears in
  CC      cmd/bind.o
  CC      drivers/gpio/gpio-uclass.o
  CC      boot/bootmeth_extlinux.o
board/boundary/nitrogen6x/nitrogen6x.c:913:22: error: 'LVDS_BACKLIGHT_GP' undeclared (first use in this function)
  913 |         gpio_request(LVDS_BACKLIGHT_GP, "lvds backlight");
      |                      ^~~~~~~~~~~~~~~~~
  AR      arch/arm/lib/lib.a
make[1]: *** [scripts/Makefile.build:271: board/boundary/nitrogen6x/nitrogen6x.o] Error 1
  CC      boot/bootmeth_pxe.o
make: *** [Makefile:2205: board/boundary/nitrogen6x] Error 2
make: *** Waiting for unfinished jobs....

To fix this, use reported macros included in CONFIG_VIDEO_IPUV3.

Fixes: 1b51e5f4cd2a ("nitrogen6x: reserve used gpios")

Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
---
 board/boundary/nitrogen6x/nitrogen6x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/boundary/nitrogen6x/nitrogen6x.c b/board/boundary/nitrogen6x/nitrogen6x.c
index 1adee9a461f..e45db109f4f 100644
--- a/board/boundary/nitrogen6x/nitrogen6x.c
+++ b/board/boundary/nitrogen6x/nitrogen6x.c
@@ -909,8 +909,10 @@ static const struct boot_mode board_boot_modes[] = {
 
 int misc_init_r(void)
 {
+#if defined(CONFIG_VIDEO_IPUV3)
 	gpio_request(RGB_BACKLIGHT_GP, "lvds backlight");
 	gpio_request(LVDS_BACKLIGHT_GP, "lvds backlight");
+#endif
 	gpio_request(GP_USB_OTG_PWR, "usbotg power");
 	gpio_request(IMX_GPIO_NR(7, 12), "usbh1 hub reset");
 	gpio_request(IMX_GPIO_NR(2, 2), "back");
-- 
2.34.1

