Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4173EC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 029F8807D9;
	Thu, 23 Jan 2025 23:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="G+zJ7SHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A9D80087; Thu, 23 Jan 2025 23:02:39 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F5480763
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737669755; bh=R0zeTFlxiBHPudia+bTiztw/uIXC0tHTcga7QN8g1Os=;
 b=G+zJ7SHVrdq2KUQSDF8ppPB1JuatK8NjD+TNitJ2e8Ay/fHnrUuSxT68I8XaMGp7sbCRArj1d
 eAB0wsVTlGtv6ZhSPYrxTkw3XpquTAdwpFxYGe2TWpCDsPbjnZL2Osf3hprWz81hXYqkwQ7XWQh
 Gs3DEkQ2C1AgMrgCeLt0EwU6md1nZxasWqjMDp5mqk7vuh4fnFwzioXpmUSleWlSvxNyO0d7ae1
 6yITKN8gKaQw5PoVAlvDRDtPbC+W3t5ewdwPtr2fiEMvb/gj/O9ClOOyBKiSkMXK2xWzd4g752u
 Sxx7ZyPF5M96x4rXpdahqKrLdMdwQL0jN2NAWOITG3vw==
X-Forward-Email-ID: 6792bc76f07771e5c89df4d0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] rockchip: sdram: Allow the first bank to extend beyond 4
 GiB
Date: Thu, 23 Jan 2025 22:02:17 +0000
Message-ID: <20250123220222.3089386-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123220222.3089386-1-jonas@kwiboo.se>
References: <20250123220222.3089386-1-jonas@kwiboo.se>
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

Allow the first bank to extend beyond 4 GiB when the blob of space for
peripheral is located before start of DRAM, e.g. when start of DRAM
is 0x40000000 and continue beyond the 4 GiB mark.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/sdram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 7c21ae8efc44..3d3fc327234f 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -310,6 +310,8 @@ int dram_init_banksize(void)
 	if (ram_top > SZ_4G && top < SZ_4G) {
 		gd->bd->bi_dram[1].start = SZ_4G;
 		gd->bd->bi_dram[1].size = ram_top - gd->bd->bi_dram[1].start;
+	} else if (ram_top > SZ_4G && top == SZ_4G) {
+		gd->bd->bi_dram[0].size = ram_top - gd->bd->bi_dram[0].start;
 	}
 #else
 #ifdef CONFIG_SPL_OPTEE_IMAGE
-- 
2.48.1

