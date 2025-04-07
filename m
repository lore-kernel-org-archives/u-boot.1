Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D6CC369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC5B83236;
	Tue,  8 Apr 2025 00:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Z28gOp4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E38A831D4; Tue,  8 Apr 2025 00:49:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE089831B0
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066159; bh=Av5A1eFrPyTuqgk1uQOv2Hcb1CmEEFRNT0+q0soK3Og=;
 b=Z28gOp4iSpXW5tJkoDqjrJxmgnV7peSjhqZrDP1+qQ1zjfO1S3rDbB6i3Pahge0PQ09Uv7TLU
 UsTlCS2WK7cQpHBoiIvCNjyhdm79nGZSiOYVjeSoJ2ARH09b8XfFvbhKWTgH/g/e9pCq5N4Kqpf
 JDqcLTkFH1KCxjxrDCdLVgsEIdtRLwGkMPld98g52+8rJ/AKSizjf5+iwZJMrTki6ovO9LfNAEP
 SgRJg5KYkdDzuOsuFHp5GrePrg3n6oh2UTbLZoQNG4UGAcC3HiXJb3NHnT380ET9q7RGGqiZHfh
 BbTPIFIPFdfPcah+gu+dySGfQqR42lt56nm5xYPCv1dA==
X-Forward-Email-ID: 67f4566b9fd75b9b9651296d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 23/30] rockchip: otp: Add support for RK3528
Date: Mon,  7 Apr 2025 22:46:56 +0000
Message-ID: <20250407224743.2423921-24-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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

Add support for the OTP controller in RK3528. The OTPC is similar to the
OTPC in RK3568 and can use the same ops for reading OTP data.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 drivers/misc/rockchip-otp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/rockchip-otp.c b/drivers/misc/rockchip-otp.c
index 2123c31038fc..b5597de39aca 100644
--- a/drivers/misc/rockchip-otp.c
+++ b/drivers/misc/rockchip-otp.c
@@ -383,6 +383,10 @@ static const struct udevice_id rockchip_otp_ids[] = {
 		.compatible = "rockchip,rk3308-otp",
 		.data = (ulong)&px30_data,
 	},
+	{
+		.compatible = "rockchip,rk3528-otp",
+		.data = (ulong)&rk3568_data,
+	},
 	{
 		.compatible = "rockchip,rk3568-otp",
 		.data = (ulong)&rk3568_data,
-- 
2.49.0

