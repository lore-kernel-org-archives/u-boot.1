Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A84C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 21:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B8683DEA;
	Thu, 10 Apr 2025 23:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="apDGLT7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C53983DEA; Thu, 10 Apr 2025 23:45:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2536983D92
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 23:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c990=W5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744321533; bh=oOwsZ3qZ43rfYIuwatWDNNm8Z+/n3CSV/AYeVglArmE=;
 b=apDGLT7EG4zuUae4q8DEkVxjKUaK015chto3t+h8dRSajjLVyCPLjn0ip6PKolSJDH8K5KvdT
 rk0/P48l2S6w//F0zg4yyh0YMIwkFelSaQRq0KGWr5Ar9RzErPkI/4mYpxLkmV5hOq2z0vWkF9d
 M8HGDZpTKT/MqHPyHBHKGa1kemXewbQeaxRhmFi21XdfLhFiLKlg6uJ8LOP59/g39KO0zN1BkaH
 s8oypE829emqj4jQtabmmAluoE0+Y0whEDbNKwMPCSLR4yNclRSz9CROo98GILMQG8tjUWlbzWi
 p6F/3ut4lmqc8cj6wUup+jvAhWBoRiGJd8tMBsqYXD3A==
X-Forward-Email-ID: 67f83bf90ebe9f861dbcc382
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v5 5/7] rockchip: Add SPL_PAD_TO Kconfig default value
Date: Thu, 10 Apr 2025 21:44:54 +0000
Message-ID: <20250410214506.3575404-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410214506.3575404-1-jonas@kwiboo.se>
References: <20250410214506.3575404-1-jonas@kwiboo.se>
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

Almost all Rockchip boards use the same Kconfig value for SPL_PAD_TO,
0x7f8000.

u-boot-rockchip.bin is typically written to offset 64S (32KiB) of MMC
media. u-boot.itb (or u-boot.img) is typically expected at offset 16384S
(8MiB) of MMC media (SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x4000).

SPL_PAD_TO is used as the offset for u-boot.itb (or u-boot.img) in the
generated simple-bin binman image, and can be calculated as:

  SPL_PAD_TO = (16384S - 64S) * 512 = 0x7f8000

Add this value as a default value for ARCH_ROCKCHIP.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v5:
- Update commit message
- Collect r-b tags

Changes in v4:
- New patch

This patch does not drop SPL_PAD_TO from existing defconfigs that would
be affected by this change, something that can wait until next "configs:
Resync with savedefconfig".

Following boards does not set a SPL_PAD_TO due to not using SPL:
- elgin-rv1108_defconfig
- evb-rk3128_defconfig
- evb-rv1108_defconfig
- geekbox_defconfig
- sheep-rk3368_defconfig
---
 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c08045f9c8d7..3f8d24e8d0f5 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -96,6 +96,7 @@ config SPL_MAX_SIZE
 
 config SPL_PAD_TO
 	hex "Offset to which the SPL should be padded before appending the SPL payload"
+	default 0x7f8000 if ARCH_ROCKCHIP
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x11000 if ARCH_MX7 || (ARCH_MX6 && !MX6_OCRAM_256KB)
 	default 0x10000 if ARCH_KEYSTONE
-- 
2.49.0

