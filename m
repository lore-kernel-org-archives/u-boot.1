Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C369FCC9A2
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 00:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D328400F;
	Tue, 10 Mar 2026 01:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="r99pC6pY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2265784011; Tue, 10 Mar 2026 01:55:26 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706DD84010
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1773104121; bh=vWnmVDeK0pvQjc66jiRCE58cYu8/nOZ11hfZkcHe6S0=;
 b=r99pC6pYn3UEl7YqoFyG0xeDxm9RamT9jIpd/ahAv/7M7cei0BNvTKsEMs3f2AbqtElpBH8jf
 9hi9Qb1+bh+acVb28JrhJOBKN/V625Vrm8ENFfSO85lFEaJ1h0CM2VdVydWvKyWWwQSsco279Q+
 I9EMRTvAJpEzm0BTGNEcubtg/+1Q89ZVzvd11GcZAV90BPLXqrg+Pd5WIG0OdYFP5NoOqe8F9fx
 wvf+HZoRwlKI6f/XLApDWpDjCmcSe3S5MZEoSxWCCD9lMeK7HXbiwwfezbiuV2pNC8K5R6cp2h0
 Nn6vp81h9TiZlYu+0QnRoyfSe+/JAZHTh8es+6RYZu6A==
X-Forward-Email-ID: 69af6bf473a8189bec327821
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
Subject: [PATCH v3 09/12] rockchip: otp: Add support for RK3506
Date: Tue, 10 Mar 2026 00:53:04 +0000
Message-ID: <20260310005326.606079-10-jonas@kwiboo.se>
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

Add support for the OTP controller in RK3506. The OTPC is similar to the
OTPC in RK3568 and can use the same ops for reading OTP data.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v3: Collect r-b tag
v2: No change
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
2.53.0

