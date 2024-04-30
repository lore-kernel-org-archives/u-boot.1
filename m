Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B452BC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB25889BB;
	Tue, 30 Apr 2024 17:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bmAyqK29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 984A68899F; Tue, 30 Apr 2024 17:31:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A13AE889AE
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491069; bh=UpEO4it0sjm0XrKYcEnOtR54x2vVfIWBuD/TkDzo6eM=;
 b=bmAyqK29ar7G0MjCkb16auzi70FdMVDi0EHODttpA1ZXtPI8BVu5iLZZaO4nwwFQ9XAFIQPky
 5eTB2mmfIXlRYgT922dajcvm3KuOUjAElO1l2dRVWZ2OPFjgZc+cqpMV0D8oIZF6ErhkBYfi2KA
 vEhHmb7LRvBVfXeCeQRk/QDIcjOFgey8JpOTv0JB28tF+ELypD0fUlqLoYu36dVsikVr8LtOGJM
 KNppR1WQLE0QL/GYJkoyDnANiM8ewyQztMRmcLJC3dcOVX6wA/QqhNzK3uDAIfBN7l6m+0j5L12
 UNiSCCt9HT5cGuxVH9ngarjA6Ah7ST3gochl2Ehsm9vw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 01/18] rockchip: rk3399-gru: Fix max SPL size on bob and
 kevin
Date: Tue, 30 Apr 2024 15:30:08 +0000
Message-ID: <20240430153053.308788-2-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66310eb8d99e42224315b7ce
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

Chromebook bob and kevin typically run coreboot as the initial boot
loader, however, U-Boot proper can be used as a secondary boot loader.
It is also possible to run U-Boot SPL and proper bare metal, with SPL
and the U-Boot payload loaded from SPI flash.

Because of this chromebook bob and kevin only use SPL and not TPL+SPL
like other RK3399 boards, this mean that SPL is loaded to and run from
SRAM instead of DRAM.

The U-Boot payload is located at 0x40000 (256 KiB) offset in SPI flash
and because the BROM only read first 2 KiB for each 4 KiB page, the size
of SPL (idbloader.img) is limited to max 128 KiB.

The chosen bss start address further limits the size of SPL to 120 KiB.

  0xff8e0000 (SPL_BSS_START_ADDR) - 0xff8c2000 (SPL_TEXT_BASE) = 0x1e000

Update SPL_MAX_SIZE to reflect the 120 KiB max size limitation.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Update commit message
v2: Collet r-b tag
---
 configs/chromebook_bob_defconfig   | 2 +-
 configs/chromebook_kevin_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 55d44700d6ec..805da11dbf6a 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -35,7 +35,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x1e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_HANDOFF=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 48ee8b9fd258..8744152df61d 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -36,7 +36,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x1e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_HANDOFF=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-- 
2.43.2

