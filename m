Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCB0CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 11:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 690DD405D1;
	Mon, 12 Oct 2026 11:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVPU0o9C-Kh6; Mon, 12 Oct 2026 11:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A571C405C8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791803785;
	b=lVwiyxNTERuJHHBncjDiCtblvGOqC6siFXaxfmc3lImTtyPcj9LCRHYN7THmQPPc14pP
	 M+MLuMzZVvRNwjAP/zkkjB6FIyCdlYcbPjdNkPElMspjkPJ20oJgdl9tyAHb8kqv7jYuO
	 jWH6xmESFOnT1S2jtrenUngp89t7YzUO2UTeYjtodOX5cJHKtRxA747p1zcUANTRF7AOY
	 dFneWO/Q31lcaoFnCg9auUyT8ZD6AsPoOHHTNfGCgX8UoKf/kO4zFThPJONNcx4G0b7YF
	 B266qfHCSAVfOF34pt5RawZRLguoWAHMwxBb4g4VYStl4JvoeskkvA0H8Tb3IiV7U7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791803785;
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
	bh=Bjz6nj2Q4rWDIQ8Uej/DU5JN0VSad5GES3YRM3TlDlQ=;
	b=BlkCg3PCqrCFsbTL9tX0wvCVJESCtWnq3eSGu+dnnfKsD70Cwl4Om1SxGOoUG+/Doo7O
	 y35oix1Er8zj3QGEnmKmy1/J2TsrlwPKj3/P16gy9mFstwXueMHg5xnTBwX49Mf/MLvaO
	 o0yhnwBYxjyTS3xa+XQ16AECCS2lWga5HydauSQ7lQMpU/oVcajgBxAJG8z1ru47AeztE
	 wxXusltCd7+lqx1mWoIDn04u9ZPw2zyECJL6N6wb6WLbcvf602hMocU3oiY9+CkwJUDf0
	 FUV9did9qeciuvAN9l/zjbo9DRdyCgTvMDAi2HoVgbiWLLdZe7WZv8HtDxviRgFsWJQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791803785;
	bh=Bjz6nj2Q4rWDIQ8Uej/DU5JN0VSad5GES3YRM3TlDlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aXFrw4/9UDMweTYgI2SrzmKDBNIIaDvuadhPH5/66Z0V9QYjOpTEufyC8Guj3adz2
	 qS9MCYEYQwry2bEUh9Xu5EqakBMjm25Z+z+RS5Y9xcAOgHF4/Z4ovOEOv8jqKLdyad
	 E+M0JI8qLc0z9/gOMpCV21slhMQ7LxxR2WdALdIXhrmnA0RrFnq9ZY/lmpr6dR9CHN
	 81OwbDC8FrCLIGStcQSlSPJ88ETp88V1SIDaOXwMz+osRQ+N2q5VcM7HN4X7CZaS6L
	 yvTyKIbaKOuIFWHkSogNMre1XyifSJ3eydRWK3mO2Fz2w9V91OEc8P3tZNr+9VUHcl
	 znO7AFU0PdAyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A571C405C8;
	Mon, 12 Oct 2026 11:16:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB0159CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCD6580CDC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7sclptPBwCkd for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 11:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2ADB380CEB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791803782;
 b=JTA58KmiN+uASZeplVYDMEIVcFZqBtf6F2hp4tdpBSxX25bG6wPBVQm6861mCJiYeSWw
 ewVRrdPKvZ0cqU4K0ZELRT9iTZb8D8VMolth7MeV/YrddCsxIntoSFb4PXcPuF/D7IvN1
 vojdPqbxg/6EFX1voCEFOXEAwqEpob/8WK58wxsndB1xwwrBqOy6O2II00pvyoHdnd8uJ
 QWWCfJCG0VTuIkEvZ9v6p00PcDHmfQw6bcgICwKxhOP9KuJz5i1PExHjEsat+BUurFaOe
 K4Q0oIzcbly1z/iRIJfaT2a/z4vKFllPJF5cPzpsGyd64Z8jvXvrlS0WdhD8u0JU67A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791803782;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Bjz6nj2Q4rWDIQ8Uej/DU5JN0VSad5GES3YRM3TlDlQ=;
 b=iiPB+55Bgf+bVfw/JEHkBvSHCip69CcxUPoFmEwjD7q/7YNcWp/XGLKkOvrdi4p+pg58
 8yMxMNNhW5eARCrw/IILUprVuSRpd226xhqi5qezj6U/JBVrzpt4JwtO7vUhPHB+OGvSi
 S5JNeKNj35nMm2QXp2+LV51E/Ffg0nhvPEMhqbPMYY13eoT7zMGqHI1qkC7bi0FkqDfTN
 74GUe76H+0v8Xty2K2JVSfjZiiI7Gpo+OwI23WqIqjBSV+n9FEK0CRPwUvA2Cmg3jGdIZ
 8VMcg50p8g0iV3tS83EuQwL5EnwRsLZK1SST0DibHofau5UIb1+3dK3M0SErWvBUYPA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b="0Z2ied//"; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=0Z2ied//
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2ADB380CEB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791803778; bh=Bjz6nj2Q4rWDIQ8Uej/DU5JN0VSad5GES3YRM3TlDlQ=;
 b=0Z2ied//3tf5tL7c4lLePG+/7EXWVVvwg1bo069bYXHp2H1//xonmZxjpHQohV0VSw4MuoAnc
 x20N9HUF1dx5JWX9maIlYknciNtn7/G2PadCeESJHI5dkM0EFLutL2G/PllT6MpvLviu4dElLwr
 Qqg9HahLK1LkMwWznLTrGFLvWndEQn9QSoMsI2Vps7HCAJwY0MzgQtl/vSEi4AqHGSDDypvqnpX
 Z7hdGVpa+9trqmxyHPcmKPhaKgTlZ4awQDZTzH7Hp0/caI+TRVBq7+6mQ0tmU5EwS66Wd6egVdM
 t245vPW/T4Xf/NZxamRjb4zaj4PHIxVlEEjUdElp6vZA==
X-Forward-Email-ID: 6accc17f003f837f7de8eea2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 2/4] clk: rockchip: rk3588: Always initialize clocks in SPL
Date: Mon, 12 Oct 2026 11:15:47 +0000
Message-ID: <20261012111552.1173161-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012111552.1173161-1-jonas@kwiboo.se>
References: <20261012111552.1173161-1-jonas@kwiboo.se>
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
---
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

