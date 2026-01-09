Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFE4D232C7
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 00:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE6E8415E;
	Fri,  9 Jan 2026 01:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="m5kIVcEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41BD58415E; Fri,  9 Jan 2026 01:50:43 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9CD84332
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 01:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d19=7O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1767919839; bh=QpDu/0zABDv/U8QwoydTZZ5Abxs3yr6JEWAks7KUd1M=;
 b=m5kIVcEUmP/lhLMe1WUxUzAf+Uqx2IU6rVl7SNB9j296mvNIkvYB005mbShxKcMVxjVoITjjA
 jLHsuBI8GDGWmxQIQ0+ZtkTigYjDZ2Czfj1wI8Rr3Co7obxdFhhZh9sQ7+q7bcUlNY7WpvNMbP8
 QAi/tY9ZCVHl3mM8v5ObfsUYH7zuIEwHARwnw/6UJvBSkoUmsas1LLNIxyO5uDBU0pfSbgstvpp
 xkzrwEXpjxinyeYd6Cx39MI6t/kM2oZ2E+Ke8hMgi1JrABW5QwN7d+ZAr3SnO5t01Fw1pwGxpja
 OUE5unZsEgtaoTaEAyMzY/ig0T1gRM4NBsYsKPh6R8tw==
X-Forward-Email-ID: 696050dbabab7b035309fb8a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 07/10] rockchip: otp: Add support for RK3506
Date: Fri,  9 Jan 2026 00:49:48 +0000
Message-ID: <20260109005008.101506-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109005008.101506-1-jonas@kwiboo.se>
References: <20260109005008.101506-1-jonas@kwiboo.se>
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

Add support for the OTP controller in RK3506. The OTPC is similar to the
OTPC in RK3568 and can use the same ops for reading OTP data.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/misc/rockchip-otp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/rockchip-otp.c b/drivers/misc/rockchip-otp.c
index 46820425a84d..64b6238981b8 100644
--- a/drivers/misc/rockchip-otp.c
+++ b/drivers/misc/rockchip-otp.c
@@ -390,6 +390,10 @@ static const struct udevice_id rockchip_otp_ids[] = {
 		.compatible = "rockchip,rk3308-otp",
 		.data = (ulong)&px30_data,
 	},
+	{
+		.compatible = "rockchip,rk3506-otp",
+		.data = (ulong)&rk3568_data,
+	},
 	{
 		.compatible = "rockchip,rk3528-otp",
 		.data = (ulong)&rk3568_data,
-- 
2.52.0

