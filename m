Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CE6CC6B38
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 22:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EC6260A97;
	Thu, 15 Oct 2026 22:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s-rgMQ-sHf3g; Thu, 15 Oct 2026 22:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 737B560AC5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792104162;
	b=XqkWxHm7FKHA12vHjblluFi4X5p7PjDVRe5cAUvhxzH1FUa62CBpBlr9b9EP6wqblwmy
	 6U/2ufymq5PSyq8DG2/tKKZ4YBg3ro8tFUM58p2ZCyKJxZY+wYj66NbMVxgLLsjNEeO+M
	 A+yUj3VEer/iO5WfvkaH6OV73Lm4V8DZWDXfXxL00nz8Ll73rW1oB65hnHFw+NOHwOhvX
	 TV+NeC5v9dfNjEU9KFgD8xdACwua2fRxZolCuv86axdE6G9vitKCAR0AWrzvKcqF9r8ZZ
	 oFBC5XnOqlB+3Z1pFnsDQQHVh1JGIsqJayakKtJ3m6uN0NJiA0S8bvs/HaEJCPz2YXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792104162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mhIagEbrphIOVTgkv8IPFSjtzP+FutkGZZAn/aAJ4Mc=;
	b=H5FOtnyLe+RGySPQ4nDo9aECOKnNi2w3AbiaUCRLuXJOMpBtFn/4+2x3bWeZg3IxVljL
	 7YIEEJ++1uieHLAHjhN1YGGy2GMP/67d24tSYtvDIceeNKVpeWzeNGtj2r0CIOKoMOxPy
	 alwaZpF31QSXmdUzP0JlsLVIhNaJ2EpN4NWwrZzMprdlA/Rg/3HJHOXsrTjw9YPxtiPRm
	 1p2sI9bzhMxsE+Q6OufDjM71cLesSY4IcQjQLSRau0EPJ2V4GZ+kN6a4rzXOV+vBF2EGc
	 cA2svvwnECuhYF+N0DODn7ouM5Wb2X4aCyw2OXGkUHmSmDmtSKJ5jgJ/TU5f9dCZQZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=lFPzEE6F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792104162;
	bh=mhIagEbrphIOVTgkv8IPFSjtzP+FutkGZZAn/aAJ4Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1FDhbGJcMgKbc7ysutRJj+Wuijp+gLkOQ4Si8VtV6wSJ+pn3hs0rjfn6D43bx91XK
	 VKMfz9xwXDzUHDKRxUY09+ylKA+yuaDRVdLwG0B0suThLhiXGzUbbbD5/oQgr9B3iO
	 vrHaDDXfOTlNyFZWS5hKkNa0x2FdEuwoImq0wmPnJR6/xPf/dHB3r+cO+i6MHv95Uv
	 GELnjjjesQ8O59+o0pEpovkcbq2Ga9bV/PG/TW+K9MdEABufmASVpXE2wD3aYweTOW
	 WvKbcC3cexHNNVAnzdOrvT4BboZKPAGzgSTy6EQGGGivf/krddelJlCnRed2kDUTFq
	 vJMvp8JGtvwwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 737B560AC5;
	Thu, 15 Oct 2026 22:42:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EFA5B105
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D660860AB7
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arnuZxXcmr9j for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 22:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DD7B60A97
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792104160;
 b=RP/KBmCpWsy2LnPAA+ot9lfpwYzSdMCBuaDF8zSD3z8qpn1t3hc5DvLh66w8xUVRIg3y
 WaZ1d1YGFZlh78xzibsEAE8kGjFLyFXI8nuBS3Q2+HjsIc3juMAdWqi+QRPw8XYDj3rwh
 JHQw9VbOGdu5rYn+rLaYjhgjCLwCr6NgtOnTaV6h+jaiklHkHWIvu9RgtwuOIJq05EYZQ
 FIhI39ddlNFwo6IB0rHP2McYqyyaHe4hNZ6clJtnKNld8DiAnBn7gQJd8PLKWBjMUSY+F
 0u04rkaI+3QLS5D3kJS5xxE4uybG0f5jui+GLi9tbwGCDL65kFEWv7L0GDPqIhgSV+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792104160;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=mhIagEbrphIOVTgkv8IPFSjtzP+FutkGZZAn/aAJ4Mc=;
 b=ouAeJM7Ov3GQfAxvPOLBoo12HPOQQcOYYyM7bdTJI2sMauk+n4yuTXE8ly0MaZuaUHXz
 6EwdTEqC38DNHFXU1nKwPkd1ght3OYxeeUF5ck5s02ySmC+u7GZXVW+0prQO2I4Hq8awM
 7TFlLScsHWfWbFsBT4xlb5U3/djXf/2OhzZwIvPWs6+ss+dvXhVALY+BYTBK4M94bgAc5
 dOKsT8AG061P8uyZSXO1yb1+VOgu2PjGunFqWmckp/nSGKvAjmI5KIsVY14AkcvRYBxzx
 3ei2b+xWOpvI6hNpYFRqrX5GymNJ3nl1qCyrDlJehUz8fA0qJUoCjV/tgGwLW8kEpUg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=lFPzEE6F; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cddb=ig=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=lFPzEE6F
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2DD7B60A97
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1792104157; bh=mhIagEbrphIOVTgkv8IPFSjtzP+FutkGZZAn/aAJ4Mc=;
 b=lFPzEE6FLjkN30uQ7M9+88yMtQY93ANJ97ZDcah0ClDaYsrwN+IqaR4ZSfzIeUz5ac9UO+uyj
 jLbfHKOh+A/K7z8OjGZJ3sjk+Dio1hrA4kxICD6qB7i3EnkN+CQp4kREBhFunTE7Lafuni90KUN
 blm1lhjAQ09LN/BmaVxL03Ycwfm5Vj9XrTkddTr6kallcJUN3PXmC77e7CkEes3ZOrw1GYE/4A5
 JbhUTD44+xOWKrF6Jm3NXms92Rsev2ddNZ2voJgKaADfCuDlqqjh5qsVKpf8ZY/iw8O88Mn1jDU
 KShXgOZ+zB130dN7nXkzBeFlqas1n9lym2wXr6CGFJ5g==
X-Forward-Email-ID: 6ad156db32553382725eab42
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 2/5] clk: rockchip: rk3568: Always initialize clocks in SPL
Date: Thu, 15 Oct 2026 22:42:16 +0000
Message-ID: <20261015224222.1582607-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015224222.1582607-1-jonas@kwiboo.se>
References: <20261015224222.1582607-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The RK3568 clock driver initializes ACLK_BUS to 150 MHz when probed in
SPL. However, the driver is only probed on demand, so this
initialization is skipped when no SPL consumer requests a clock, e.g.
when booting from RAM/USB.

Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
of boot device") all boot devices where typically probed, with a side
effect that clock driver likely also where probed, prior to the
boot_from_devices() call.

Flag the clock drivers to be probed after bind in SPL to help ensure a
deterministic probe and clock initialization behavior prior to booting
from devices.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- Also add probe-after-bind to the pmucru driver for consistency. The
  PPLL default rate is 24 MHz and is changed to 200 MHz in probe(), this
  also happens in proper so probe() in SPL is strictly not needed.

Changes in v2:
- Update commit message
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3568.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index ce17d42ea0f0..c3973215c37e 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -494,14 +494,19 @@ static int rk3568_pmuclk_ofdata_to_platdata(struct udevice *dev)
 
 static int rk3568_pmuclk_bind(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
-	int ret = 0;
+	int ret;
+
+	/* Ensure clocks are initialized after bind in SPL build */
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	if (!CONFIG_IS_ENABLED(RESET_ROCKCHIP))
+		return 0;
 
 	ret = offsetof(struct rk3568_pmucru, pmu_softrst_con[0]);
 	ret = rockchip_reset_bind(dev, ret, 1);
 	if (ret)
 		debug("Warning: pmucru software reset driver bind failed\n");
-#endif
 
 	return 0;
 }
@@ -2936,6 +2941,10 @@ static int rk3568_clk_bind(struct udevice *dev)
 	struct udevice *sys_child;
 	struct sysreset_reg *priv;
 
+	/* Ensure clocks are initialized after bind in SPL build */
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
 	/* The reset driver does not have a device node, so bind it here */
 	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
 				 &sys_child);
-- 
2.55.0

