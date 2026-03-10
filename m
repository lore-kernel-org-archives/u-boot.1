Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7723CFCC9A2
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 00:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD8A83F75;
	Tue, 10 Mar 2026 01:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bBp7CjZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3BC83FA6; Tue, 10 Mar 2026 01:54:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5726283FA3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1773104090; bh=Wd4ZWMgHk0hPVqFmyqbR9KwLopIeHjGaZEVNZoopS1s=;
 b=bBp7CjZ17OD8UjPPLcLqmbXvx+A6FE3j9Ya7VMWVWvrKXq+FYdnjyLdu7B4aN93CFccqdCPMu
 MOuq2I1fGYvqUKQDcGpKjf9MCuU8hjW9d4+F5wmC7Wpfe860q6p7rbNZmOtZ2EdD23MlvowMw/T
 ymoiPpQ0Mkl2br+GoGUCoikyEhsF9vyiPXP2YmOiTnGE+8GVJDDJV4oqGl0qjtWdztHB+W6xSYu
 h6A/Of93UbKXjBfMirqto0a9bYy/Z/T0LGFdSW25LQMs6fXQpW54nxQS0Tcwz33jou+O8ef5RM8
 ia5Pxm7pfCoi6j0kgMZyy5+nIeBNZSxk6rohvlYySXqg==
X-Forward-Email-ID: 69af6bd573a8189bec327764
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 02/12] rockchip: mkimage: Re-sort the spl_infos list
 alphanumerically
Date: Tue, 10 Mar 2026 00:52:57 +0000
Message-ID: <20260310005326.606079-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310005326.606079-1-jonas@kwiboo.se>
References: <20260310005326.606079-1-jonas@kwiboo.se>
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v3: Collect r-b tag
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
2.53.0

