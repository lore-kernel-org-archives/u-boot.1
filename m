Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A437C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00B488A1A;
	Tue, 30 Apr 2024 17:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bx/+lP1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A400B88A31; Tue, 30 Apr 2024 17:31:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF1788A1A
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491071; bh=QnBjbluOpJ8hwod8DuX/tX7S0fJgAKOFWg24FqJv/tM=;
 b=bx/+lP1XQspUsWv5dUchKKCSYabEWUuLAsNbya2Ng0Fj26w5x6xD2sIoTOQxBN6agSd40m/H3
 ws5E4cetH8hxliOrQQ5gOBKZYgXYdXm/4XNyssqzTycqf+RSy4hb9At2Raob83Oq00tF3Ia4iKY
 sZPb093QOtIzIV7XrzIz5EGei/GKzCcYQT02dfJzkGydvuOYAHAv/NRV3ac1b3VvmgdFAw9o5t5
 XLcxwmFImGVNkGRELtZI7CSwrFMumVTp/MLo48yPSrktDuJjlxv/HrwH7TGir4OggiNimqNypyi
 amOjTlBZ8xeZG4gtCt9VtKTFOijFi9rOqPXxBtL2IlGg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 02/18] rockchip: rk3399-puma: Update SPL_PAD_TO Kconfig
 option
Date: Tue, 30 Apr 2024 15:30:09 +0000
Message-ID: <20240430153053.308788-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310ebcd99e42224315b7e0
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

On rk3399-puma the FIT payload is located at sector 0x200 compared
to the more Rockchip common sector 0x4000 offset:

  SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200

Because FIT payload is located at sector 0x200 and IDBlock is located at
sector 64, the combined size of TPL+SPL (idbloader.img) cannot take up
more than 224 KiB:

  (0x200 - 64) x 512 = 0x38000 (224 KiB)

Adjust SPL_PAD_TO to match the used 0x200 sector offset.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch split from DT sync patch

With this change it should be possible to drop the following u-boot.dtsi
override and use the default offset = <CONFIG_SPL_PAD_TO>.

  offset = <((CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR - 64) * 512)>;
---
 configs/puma-rk3399_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 14a7bc8b1e00..ec7d52a6e13e 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -31,7 +31,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x38000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
-- 
2.43.2

