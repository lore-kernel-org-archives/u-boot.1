Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A3DD132B8
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7494F88D3C;
	Mon,  4 Nov 2024 13:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="HBqvNUXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D89A88E96; Mon,  4 Nov 2024 13:23:30 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by phobos.denx.de (Postfix) with ESMTP id 65D7288D14
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 13:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=fcT9v
 N3yEVS9/7ZwyNlZhJEt1hXvmhWkx3Me9mpPiVg=; b=HBqvNUXvx5suAYH74cLsw
 5lCUWy2wbN0YEBFa5772giLybDsaEkapaM1P97NWdzvsOsh4pR/lvAEOV12rn3C/
 3ybO25s94FBoRdBREspeqz0lb+mM8eArhTRXRsxuyVfaQi7ZYrCEdCHgCyFyJ960
 MeZbLDHJ30RUHcALB6t8bo=
Received: from ProDesk.. (unknown [58.22.7.114])
 by gzsmtp3 (Coremail) with SMTP id PigvCgDXoOOtvChneoIYBA--.28161S4;
 Mon, 04 Nov 2024 20:23:15 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de,
	jonas@kwiboo.se,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v6 2/3] rockchip: Make it possible to define per board
 boot_targets
Date: Mon,  4 Nov 2024 20:22:59 +0800
Message-ID: <20241104122307.439776-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104122307.439776-1-andyshrk@163.com>
References: <20241104122307.439776-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgDXoOOtvChneoIYBA--.28161S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrW8tFW7ur4DKw15Gw4xXrb_yoW3urcEka
 4xWw1rZa10qrn3Ww4fZFWrGr1j93W8JF18Z3WfJrW2yFn0vr4aq3s3K3WUXF90g3ZxZas7
 ZayvkayUGr13tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiIJPJUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQuNXmcovEgGqwAAsn
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

Some board may want to have a different boot priority(a laptop
may want to usb has the highest boot priority for third-part
os installation). So let the board can define it's own
boot_targets.

Signed-off-by: Andy Yan <andyshrk@163.com>
---

(no changes since v1)

 include/configs/rockchip-common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/rockchip-common.h b/include/configs/rockchip-common.h
index 9b8ab3cdf20..d5550a46575 100644
--- a/include/configs/rockchip-common.h
+++ b/include/configs/rockchip-common.h
@@ -13,7 +13,9 @@
 
 #ifndef CONFIG_XPL_BUILD
 
+#ifndef BOOT_TARGETS
 #define BOOT_TARGETS	"mmc1 mmc0 nvme scsi usb pxe dhcp spi"
+#endif
 
 #ifdef CONFIG_ARM64
 #define ROOT_UUID "B921B045-1DF0-41C3-AF44-4C6F280D3FAE;\0"
-- 
2.34.1

