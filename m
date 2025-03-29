Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB165C3600C
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 15:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642F08198B;
	Sat, 29 Mar 2025 16:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mz3tXNii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEF281ECA; Sat, 29 Mar 2025 16:07:15 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87DC581F95
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 16:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743260831; bh=od1y7kTay5O5A+ow9Y8ryk43jf+28WbhN3Sd/iOx/zk=;
 b=mz3tXNiiZ56hruWtJNL0OFMM0d2ZljWRFPR40X+6xxgBhs1h6eGK5MMt+yUcITQ6awG1uFDqW
 ldKJhAaCMqhG4SKyC40GhO5qgqj1ZCD6IiF+BdBGSCbxGAxxggCyP74L1H21S/qcTAl6yMIUHVk
 I67kBesVUYnd2d2ZPCh1cwMTEP8zCMLDLTnpGWov0oVVDEzb1y02M7712CpunK7PaVSxXMs3ppY
 ym6vJAnd8gXTctFroCd/iGyt/b+oIeJz6QHjRnnMiHmR3XJgKbv0JiAMfftXsjAkh26XFN2tnlh
 GYfoA/b8+EjWItVG8l1BRC+b9m52K83CG2u5vWjXri4w==
X-Forward-Email-ID: 67e80c9b21787eb134711fd4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 10/10] rockchip: Add SPL_PAD_TO Kconfig default value
Date: Sat, 29 Mar 2025 15:06:13 +0000
Message-ID: <20250329150626.2879942-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250329150626.2879942-1-jonas@kwiboo.se>
References: <20250329150626.2879942-1-jonas@kwiboo.se>
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

Add this value as a default value for ARCH_ROCKCHIP.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
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
index 97f542fcc8a5..322fc3cbdced 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -97,6 +97,7 @@ config SPL_MAX_SIZE
 
 config SPL_PAD_TO
 	hex "Offset to which the SPL should be padded before appending the SPL payload"
+	default 0x7f8000 if ARCH_ROCKCHIP
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x11000 if ARCH_MX7 || (ARCH_MX6 && !MX6_OCRAM_256KB)
 	default 0x10000 if ARCH_KEYSTONE
-- 
2.49.0

