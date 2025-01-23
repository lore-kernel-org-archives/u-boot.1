Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D37C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E801F807A7;
	Thu, 23 Jan 2025 23:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="r20BdZZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F44780137; Thu, 23 Jan 2025 23:49:00 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 695E080243
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737672535; bh=RHhMC6HeHCtaS18om308QQl4G8q0JJW8GlFpZ8j+pvY=;
 b=r20BdZZWM4VXj87ooKMWKzvCTX9/tdlIpUnVK0b+ePUDbAqlzBGOL6O31ulE449H40CvOinOf
 Wof5iRpYyIwK/hqdeEciaNmEk+7+KitI5y+OIbSMAYGmsHNB5UG5uNpt3GqeMonMeqOqasxBaMY
 mp1334rRtAe2arZT2BrqZHfk8u4Uck9mteb0rnY1Fv9+aSQv2ltQ37ZgAUS3ZzDjscfcVBQc8FX
 VnkbaU1UEbBElxC2j+v2tvwnv2WdJ9LHa7CpWyYpjWjeMu1AKzAQ4bd5zNliJwV5khtbnVvN18U
 7Y2j/ia5ty9l+SVw0EZiXAWBMDb6pPeiRVJ5CtPScPHg==
X-Forward-Email-ID: 6792c754f07771e5c89e0113
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
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH 01/13] rockchip: mkimage: Add support for RK3528
Date: Thu, 23 Jan 2025 22:48:13 +0000
Message-ID: <20250123224844.3104592-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123224844.3104592-1-jonas@kwiboo.se>
References: <20250123224844.3104592-1-jonas@kwiboo.se>
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

From: Yifeng Zhao <yifeng.zhao@rock-chips.com>

Add support for generating Rockchip Boot Image for RK3528.

Similar to RK3568, the RK3528 has 64 KiB SRAM and 4 KiB of it is
reserved for BootROM.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 tools/rkcommon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index 3e52236b15a8..f158d1562284 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -134,6 +134,7 @@ static struct spl_info spl_infos[] = {
 	{ "rk3399", "RK33", 0x30000 - 0x2000, false, RK_HEADER_V1 },
 	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
 	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
+	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
 };
-- 
2.48.1

