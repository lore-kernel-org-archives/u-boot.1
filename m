Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176F2C0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 22:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB1E80FB4;
	Sun, 26 Jan 2025 23:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ApehM5gQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFEF780FB4; Sun, 26 Jan 2025 23:50:04 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A5080F9E
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 23:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ca7d=UT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737931800; bh=RGW3vLyIhjzGOlDD3kKDtIUIp8KnqOzND2CrRgG3ExY=;
 b=ApehM5gQDoTJM5V1FhBzSReRUFUgAzsd0hH7RJBWzBMFLczjx6iyfpyIJ4jiPU2ngC89svxrc
 gzc4ik18CSTmYq9Dno4roAAtTQ9hduQdhWzzW79WA7gPABdXIfq4WlZrtE72H9mpdWmCDEb1D+a
 UNbXloCIvYLjF6Uz0fHWEf8jmxPyTMkAlQnuf/VzkRKIz16Z5SSJt1nO31ZukmRa7zzDavUflT2
 8MAEnDcw2ZoiRPT6DT7JZnC+SCYOSpWLDuipu7ojPvid+qgFtTMW4fMY7LBy8tPslcmbvz9MzWv
 Y7UkoXcHsGYIQnuL3cylosgb29aXcjv3dzE2ipbf/Oqw==
X-Forward-Email-ID: 6796bc144079df9fc6c0d011
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
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/3] rockchip: sdram: Allow the first bank to extend beyond
 4 GiB
Date: Sun, 26 Jan 2025 22:49:40 +0000
Message-ID: <20250126224948.544633-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250126224948.544633-1-jonas@kwiboo.se>
References: <20250126224948.544633-1-jonas@kwiboo.se>
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tag
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

