Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26284E7C6FA
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 23:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA6183CAA;
	Sun,  1 Feb 2026 00:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ST7v8trU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A0F683C91; Sun,  1 Feb 2026 00:39:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26EC83C01
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 00:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=19be=AF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769902750; bh=PP2m3ofEI8YlN1wNkM37kukO+FvO810jteKOMIu+ygI=;
 b=ST7v8trU4unpSR4BSWuZF2VJJMwOV3hAhKk0yiv7YaRr/91XAuXhHvrorYwHx19IxOyPp9oAl
 whA3DO+A6uRct2zpScpfSLJZSEx8BrNImg9n1L6dEKQodcCb3lRqNyokdTtDe0bgWctW7HdOIpF
 eusmHpLseHKXM5fil2lYHjRcJXwpwvmCIZIBA2IT2WynX2cLa+0F7GKLBYbh5HrFa8GE+4X1xyU
 8aidIXrWMu+kozOc5sYmgZ+SspxgZykzSld/NEucn8xUHuigJZExDidLADZgAARUmi0ImfKRRLy
 vR547BMopktC9RjV1+7NOesRx1IoT6v8f9Cs7+UJ9N6w==
X-Forward-Email-ID: 697e9299de426c19931e0515
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 02/12] rockchip: mkimage: Re-sort the spl_infos list
 alphanumerically
Date: Sat, 31 Jan 2026 23:38:13 +0000
Message-ID: <20260131233843.3419737-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131233843.3419737-1-jonas@kwiboo.se>
References: <20260131233843.3419737-1-jonas@kwiboo.se>
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

The first RK35xx SoC was initially appended to the end of the otherwise
alphanumerically sorted spl_infos list, possible because it was using a
new header structure.

Re-sort the spl_infos list to keep it alphanumerically ordered based
on imagename.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 tools/rkcommon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index e7e78ef7e5b7..dbc1c177843a 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -148,12 +148,12 @@ static struct spl_info spl_infos[] = {
 	{ "rk3328", "RK32", 0x8000 - 0x800, false, RK_HEADER_V1 },
 	{ "rk3368", "RK33", 0x8000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3399", "RK33", 0x30000 - 0x2000, false, RK_HEADER_V1 },
-	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
-	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
+	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
+	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
 };
 
 /**
-- 
2.52.0

