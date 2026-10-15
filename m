Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B09CCC6B38
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 22:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13EE660AC5;
	Thu, 15 Oct 2026 22:42:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_jpVApMmA05; Thu, 15 Oct 2026 22:42:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 486E860ACA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792104168;
	b=rd2KhRUby0l6I2VLzEO2/O41ko/E2W7SJOv6mENeBYWUTPzraiWLAU6V3LX15SXa9ySS
	 QUEPHOUtZmuC9aI9xu0O4OArI6/ymCk4VbYTG9Rg/y8qg2Lorajm+Rh3YVKxrdHoyO3mH
	 yoKVx4Ue19JMs+QKjAOOsumWj75TIqDMjzBbOtiVsv7uRfv+Z+R2GcSv4g8YAw/i26/uj
	 Jkgk7FNh6inWgc1YwOu1PclNPcVi/b22nkMyJqbP+n+FY/cgRVEH9CP5KJavK9KcBVQ3s
	 IDMTcPuLqQ5TNjAle8/gBu2kH1ZlcyKNK438ErVY++iRhNLPEHYG0KwAJ36m/zDOHrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792104168;
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
	bh=rg+mGcQksxKhCKuiH4TjIIWZFsGftZ2DBGPChSJTsJA=;
	b=mlCW8d2icCjF37pBHf9RGR8C47HHoy68L7pbVlTsE4QyRJbhrvJlC+f8gCY++xT9fABv
	 zopJMV9WEhKlXg6zYp1cSYUGCH4P+HJo2SIV2aVawlHaNdXTqBRGIFnxEAuFA++0Qmepk
	 k2XDJhXhUaQpt4sb62qEGi8xThwpyPpnVr+glyV4km8c5k1ajpkdxlJte9rpEiQIdE9V2
	 0d926SLhjyUaZPzDGJ+RBMl8PxpuYAyxaGnTQNPFVeveMg1TKGt0UHX5tXG/6DLyrn1HN
	 3c4PLMfaFbs8GSPofjZMUMnJ9OmaQy4W5y4T0rECdzRbKtiZtbD4qy4n9xgF03yYKTw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=RPOu6GaK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792104168;
	bh=rg+mGcQksxKhCKuiH4TjIIWZFsGftZ2DBGPChSJTsJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WfsN9z9sHm0H9S0+ucFzYU6A5IWacuVeVKqUnQRl43/J+/MTvqVhL/c0tFZJmnFXL
	 DDwLTGRcSfSU/WwRcOkW8ad9Iqq2piCyhw8MnRxE73KfA/X/vLFO8/nu2xoYcY5H86
	 QSqy/9pzp6Dgs10bdiQEOvtdeOagPrA6dH2LMPbnQ/EumXH9XOR2is+ODuBcXL3NTz
	 uL9ikZ2mGgykFX0/nY10nTIyUBP5aNQpSGwLsrIONJ20FKl8fmGgKdJ51IXskO5Dmc
	 2lYY8r1dPuY/wUGkRivZCwDEa54qbL9nQF/NEBOw5XWfXN9TGu+AU5AxijzK86mH1d
	 xh8Rmfh8Q9cXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 486E860ACA;
	Thu, 15 Oct 2026 22:42:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A9301E9
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3882F60A97
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CgH02abaC7ec for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 22:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52F7B60AB7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792104162;
 b=fBMrpE90pwSRAjdJK1CSHTNOTvH9iCD7Whd0rkoIrTAkl2ztI3fWoCDPMu2rAxZmGLRd
 VQPLu3w7PkpWRHx5vbSwTzCm1pzZlWGjc8qDMKxCnMo/2LE7WmwpNwiV+w9PMnY8U8hzG
 AJMdqpRKWOQblvLr+Foio9PuKTnTe1A0jcU/cP+ssEnAnpFSaLO5oAqePTrM+ut1rzQAT
 NcQV/ZaxwBwQBY81PizkAukNU6HKh+rQ7X6i80wgN7Bz/E8SeLwRql6fZeOJ/gJq/jcUB
 h3fmi1i4aslkYf71Ir/BGguia31vH50kRLgwNUTk/KrNOGDJQort81CK1is5WJ0enEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792104162;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=rg+mGcQksxKhCKuiH4TjIIWZFsGftZ2DBGPChSJTsJA=;
 b=cbl6TSBNglad8l+IIE70EEi/qMGkV5mERswJ0Nq57XRFABy4bRYe6ac3TFX/my6ypMws
 2fmgbArjSrPK39ZX61RGKAkr2m8RhosHCOADL8d5wZxJ42KU8LrBt1IrNI+rrtEi6MZHB
 JbFXwLvJy2Hy/AHsGuQ54u+m2kQ0qzIvs4M88xqTyc8ij0quarZtINmtkzumacB6GaMbU
 1H9E/ohbqmf5N0huT6RVfEtz4hnb3FWVPF8nbiWOoUQu4Kp8ueiBWtLCQKWjo8L+535R4
 UdUZfAs1Rj5x0WY1zMUhKXPYo2MS1T1MNoepAHq4tCB8wkE6XHo6un/FHNteRk2mtgw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=RPOu6GaK; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cddb=ig=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=RPOu6GaK
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52F7B60AB7
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1792104160; bh=rg+mGcQksxKhCKuiH4TjIIWZFsGftZ2DBGPChSJTsJA=;
 b=RPOu6GaKMdpHcsIvLMGKlHhvcJVaryOLXft1zp/lPhcx0cRresaeTFY9wGG/9fiuBCiXLBfFZ
 8RkTgbXEnc+oY7ZmNQqB7asWrnh1PGz6BvcUaxF1SpSBR5LYTHB6euiox0TyNiMOAeMtPxlVUcz
 ayN71kUh4bGnV5Zouo+mB+mRFqXXay2b8RJOrqAiB6nHcziQZdzmpcKiuXemTSGYe7xAvPmWth7
 TiAr/lzm6dB6aSsBMNJ4emFzM5rphsQ40XtGIBVS5ChUsVPiy/pOjP+Mw0nUVUTEqmxnceQLMEM
 QuYLAfn3Zf0cToHeFDOdcaQpOWo8K+3XFiPQoR2MwY7w==
X-Forward-Email-ID: 6ad156df32553382725eab6a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 3/5] clk: rockchip: rk3588: Always initialize clocks in SPL
Date: Thu, 15 Oct 2026 22:42:17 +0000
Message-ID: <20261015224222.1582607-4-jonas@kwiboo.se>
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

The RK3588 clock driver configures the CPU PLLs and SPLL when probed in
SPL. However, the driver is only probed on demand, so this
configuration is skipped when no SPL consumer requests a clock, e.g.
when booting from RAM/USB.

Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
of boot device") all boot devices where typically probed, with a side
effect that clock driver likely also where probed, prior to the
boot_from_devices() call.

Flag the clock driver to be probed after bind in SPL to help ensure a
deterministic probe and clock configuration behavior prior to booting
from devices.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- Collect t-b tag

Changes in v2:
- Update commit message
- Collect t-b tag
---
 drivers/clk/rockchip/clk_rk3588.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 9e26ca669fc5..fe3fc695c15f 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -2004,6 +2004,10 @@ static int rk3588_clk_bind(struct udevice *dev)
 	struct udevice *sys_child;
 	struct sysreset_reg *priv;
 
+	/* Ensure clocks are initialized after bind in SPL build */
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
 	/* The reset driver does not have a device node, so bind it here */
 	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
 				 &sys_child);
@@ -2133,6 +2137,15 @@ static int rk3588_scru_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int rk3588_scru_clk_bind(struct udevice *dev)
+{
+	/* Ensure clocks are initialized after bind in SPL build */
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
+
 static const struct clk_ops rk3588_scru_clk_ops = {
 	.get_rate = rk3588_scru_clk_get_rate,
 	.set_rate = rk3588_scru_clk_set_rate,
@@ -2142,6 +2155,7 @@ U_BOOT_DRIVER(rockchip_rk3588_scru) = {
 	.name	= "rockchip_rk3588_scru",
 	.id	= UCLASS_CLK,
 	.ops	= &rk3588_scru_clk_ops,
+	.bind	= rk3588_scru_clk_bind,
 	.probe	= rk3588_scru_clk_probe,
 };
 
-- 
2.55.0

