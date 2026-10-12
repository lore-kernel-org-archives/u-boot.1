Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB9ECA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8A7580DE3;
	Mon, 12 Oct 2026 15:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iPKgcPyacNnu; Mon, 12 Oct 2026 15:06:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16C3280DC3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817571;
	b=pPWatF1iNTBBEKN3K1VIEzxPcWRqpkuFHWR8y2lTpshGi0Ck2A+Z4X/7I7q3maHB+gp9
	 aVD0USWpFtCPysUnDK5J9LKBTL7m7V/hGJxdQfBytwJm5nR5CIv4KVaF43vjsxBMm0dFP
	 LpvaiAf6i1kuooXRrBbhnfA0uAJkLYY5fMH3Fj7OJM8mCxbPoG9DtCyq//OHx0HOKkUP4
	 Kc23qKMcU9VHq/huB1X56r8E/gfj/LZdfoSS85ihveHC/OXnJKW0m8jdpwlSCIa0PkxVa
	 QjMQaYwo3JS7IFEgArlgVFCQRG8XOzmDRh+dMpaKE+pOL1I+NJLw14uwSunoXPqRmGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817571;
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
	bh=NP7jqHqxe9E+TnyL29NS81gD3fD9eWcZBYVlmkrw4xU=;
	b=NYAQXAleI/yrmGt4uSU8y9KrQXg05WCkqXisVTUCGakh/tJAuiQ1CaJUoqayyFcHNOKm
	 fztl/BY4EBRodSSEhHwvBoa4ce+6c9l+/oio1AKfgoMcIX643W/vBGZd0dau8D0/zyzNq
	 gPLPu65Cgy0txfNRURcXDk3S3vSqyAk+y4M9aayAj0yErPcChxhr/UYkQsbZpPIvphLH4
	 q3JNoWa4yyYy5IPhPq0Upfhqb8tPGkRwLV7fh8Tp71IsJj6SscAcd022nrQnkyECg7G1Q
	 qNvjoj9Xf6I34OYJgQ5PnDVpgvwgI1rdRHkMnK458wrIBdKBMtTrQdqqguxisvxnlHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817571;
	bh=NP7jqHqxe9E+TnyL29NS81gD3fD9eWcZBYVlmkrw4xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=panF/OeKxWSPTgIspUgx6CozKRTzS6mJ9GtalffLYdQyrbO0bmyxORXAq1t0z6PW+
	 C5NPGQSgXYwohIV9vjR6Ky01iQqo7uSYHKD+XZlP99g7EbicPvTG+pZb7l8188KcSb
	 LTlvwKdkJRH+eQn8lskK9Epb1L/azlLiUoDq4OEoQQfWjtqQ/65MbXToExb3QqoiPP
	 GQ9YesUzm2+QNXNaroATBYPazIisZMzCwPE4el+FbCnlI6ICLNnDh3mVuPG/UHh3Gs
	 wPwhylH571/p7dsUuU9aevMuFqcgjac9HVIYkAM5bXYYqEOmV8nZ3YKpoVcFzQkzle
	 DsjOEVPaY0JZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16C3280DC3;
	Mon, 12 Oct 2026 15:06:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 57CD82E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CAA1606A2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYwa4r9D6ar0 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 15:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E7286066D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791817567;
 b=sB2cBsOpREannJjvounXLNV9TQuWtww2k/9nfRHSxQT5HWFAaWnjcEoUXdZpZcaFey9n
 UgTy5nEmtTIgdR+O+6Vpm9SK4/TUFXj2KplNhCQx29QumKd6WxAW0lVBA6+LFrTQJWS18
 +xGfeF9s0Jrhu/7b2qxTOKs0NRLKI1FX4Dzv1ttzOzR+J309se4mV/1OQHEuMPwNa28b6
 uToubbUOBZcujuucNpB6sHqnI4AoaApluPsp/acyBUdbMh4jqAWXcNaI47eqPKFlk+MZe
 +va1ocskwgausHeslJpvBdGyIQO/X8guXcCSLtfJAERyK64xI2mn5UWxn/fEq07VL8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791817567;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=NP7jqHqxe9E+TnyL29NS81gD3fD9eWcZBYVlmkrw4xU=;
 b=IRiQ1ZBDxlcSQ4YrMuJUNIywTBshO08HgiARPTPzTh/m6WKuSA0WXfbCmicBKPVIbrwT
 eXDVFoM2fhzPCsYLksxJiaSbOFwZxNAAZrtnnD9R4OB/5necxH1ee5rYxrqC04JYaeJni
 VhMqlbyBZDFEGdTAe3FIDz13IjDbV1VhS9I5TTtjYx/Ux2pg/3UOtj82hRb/OyGrctmbc
 i3yZZMa02TS8VgW8/aC5h2j3RspHxrh92WKefkkFylSp+hDm1rHjzrAvCwdKXeoSczldK
 NIHJkgnlPvqfE2LFAXTHLrBpAu5oKgVeQbxhYovTkglnRRGdZyUiAXpfOvIEkgEUIGg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b="To/MaDAJ"; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=To/MaDAJ
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E7286066D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791817566; bh=NP7jqHqxe9E+TnyL29NS81gD3fD9eWcZBYVlmkrw4xU=;
 b=To/MaDAJDYsA70e96ju9Yv7aU862Fq6U8KXbc+s4gO/gzjtEkWQKUS/XMlk9Qq9E8tvthhWG1
 IwhVkpOaaiSWkuUHjxbLci1vLfDN/X5l/tA9+b2WRx6Vu7cPCVui9iGMgK0AltM8Nzb6IEdGVS3
 zQgUV9pSJGrRO5D5w7M05KL32RcTq4b8Z4Z+kuRgqKZx0qXVortye3ASvDGw2SzWSipDkLqlUSw
 t1qWumGniMExRZ8ZXLfMXSQUosWqGa893DDJwnVmYSGtdai10iBz40jvRSZYkRzuMzv1lRndEIS
 Rc/l0XauSz12S2DEhyoiKczvZku98WHCRbVAlz/Pe9YA==
X-Forward-Email-ID: 6accf75d8ac7302d53a2c97a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Andy Yan <andy.yan@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 8/8] clk: rockchip: rk3308: Remove unnecessary
 clk_set_defaults() call
Date: Mon, 12 Oct 2026 15:05:38 +0000
Message-ID: <20261012150542.1182209-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012150542.1182209-1-jonas@kwiboo.se>
References: <20261012150542.1182209-1-jonas@kwiboo.se>
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

Commit fd1ba2965244 ("drivers: clk: Fix using assigned-clocks in the
node of the clock it sets up"), first included in v2020.01-rc2, added
a clock-uclass post_probe() hook that applies clock controllers own
assigned clocks.

Remove the redundant clk_set_defaults() call from the RK3308 clock
driver probe() ops.

The clock-uclass post_probe() hook does not treat errors as a hard
failure, so this introduce an acceptable change in behavior.

Fixes: fe9efbca7b99 ("rockchip: clk: Add clk driver for rk3308")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3308.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index 97043b8693c0..605566f71981 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -1162,16 +1162,9 @@ static void rk3308_clk_init(struct udevice *dev)
 
 static int rk3308_clk_probe(struct udevice *dev)
 {
-	int ret;
-
 	rk3308_clk_init(dev);
 
-	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-	ret = clk_set_defaults(dev, CLK_DEFAULTS_POST);
-	if (ret)
-		debug("%s clk_set_defaults failed %d\n", __func__, ret);
-
-	return ret;
+	return 0;
 }
 
 static int rk3308_clk_of_to_plat(struct udevice *dev)
-- 
2.55.0

