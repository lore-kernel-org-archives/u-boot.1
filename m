Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E8606A32A
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N2FfBLbO;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pVt+WIir
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6841460767;
	Fri, 20 Nov 2026 13:21:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F7B6bRNNLyGB; Fri, 20 Nov 2026 13:21:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B7A4360D8E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180894;
	b=Go0otHQTNfZ/FYFSxmIQ+YRvNdEK9eF168CEYFvl60FvNeG2pQR54WFC2QVX3dV7EqtK
	 IldwxOl3oV3ziLF8nqolo/OlRLCTTbcJ3IPsl5CwFEBW7kSGiHFMkOgL31uFiDSLrdIM2
	 za/IBvgnEGj5ZOa5if1y6xwqdTlbW+wFC9nXjvDjj/Kknq0kPnvKw8GoLQXbadFuNSpkL
	 hsrdWfHk3Mg7vRciB3dsPUdyfIhqi9WBxL8P3Dxt+zVWbAjseukB658ndnLZunWu5elb/
	 5kPD6lBx1lbtTm3CM9NC71RA53VStX3BHASwcFpvDhA9Njg5mb7w737E+G0l3i63/fQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vaHX9mgg3kdZfBT76mAeu36lS3uHR1w0GYr4g4pV1So=;
	b=lTapGbuNTP1PbwgBsRDrYRVM2fcAfY5jVnoJvSwu9dqAnKBYXT+jz1aIjwm2YpfDkyRt
	 lw60Iadvh4euMDBnfrlVp1Et5f20YNfNW6ZDe4Xt59dGfxJwCRgpExF7gQQ7sJ1pQrj7l
	 bTEYjokUNK+REYTm7EnKBtIxTqKMGTt9V0mEwHnORG++kIOIJjlj1PgkdUipyj9NKaYAl
	 0jBGCuSvzNP9J+K5zPgYswztI+5pXHuQL7nENEC4xCyJNUeNES+kW0A5zc9vQbbCHvVFP
	 wZsI1aH0e7CeW+fAvQs9OTWMe8D/Obc1whIpUEvOlKAPi5zFrJwUa6sUyWvkaHA4pSQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180894;
	bh=vaHX9mgg3kdZfBT76mAeu36lS3uHR1w0GYr4g4pV1So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N2FfBLbOeBQwQuRhnwunvfEOTkIJzMprSdHb3TRmWKiCrBv3mem0sFY1EnjvkaQUZ
	 SX7yXJopzSPKBtat15cjMAJlI/R4BG2N83KzhPifTYigxSE1iDZ6A+12iH9aqR9FzH
	 OvxKfPr9PAxodTr+0ELnZIR58ziXuVMEaPmc6zdI6na9f9b1S2i0cF4Cq9025u1zn9
	 w4LvJ9yJ3kssHEFyLynoldYxF5jL4cf2i8g+S1Y0X293CVuWc2EkP3LokKow6EJnft
	 4jIRUUVpU/2hdD/UlBGY4f3CdLC9UzC4XZ1ApPkfijOVQwxzV3z7QDBn2ifcnE7g5r
	 +Z4CoAe0AW48A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7A4360D8E;
	Fri, 20 Nov 2026 13:21:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A744C70B
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 994C98167A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TafoWX6-t8W4 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 11:10:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA024814A0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=pVt+WIir
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA024814A0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:48 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so6704065e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 03:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795173047; x=1795777847;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vaHX9mgg3kdZfBT76mAeu36lS3uHR1w0GYr4g4pV1So=;
 b=pVt+WIirGEjrztYTSVu1dmwxrq5+c6mdcwGfGvrn6nPV2uX3gOdoP1pOERf5eMa+l2
 25FOzSdbnws3m8XthJAXV2zUgL/Y91ZV9gL6TK7IRVJXViAmA3z2DXHLIDQOkXfmJz+S
 lPLVtIssbbHFSj1AOFYeNI9Y4C4L/LZr909AF1KqVDEPCGdk84GnENRceTgvim+jJiN8
 P6i11LG+R418TepJ95KbVHtG7AocVIccSdaYunNXZ2WGfOfxz/5h0zZJ52qV5fFK02hd
 +iF/6fvjG7BtFoO4QGV+OB6L5QZ3Gtf4d+LeRGtmwYgAqYCmcpVlrABm7ewGKznvGKh3
 eKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173047; x=1795777847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vaHX9mgg3kdZfBT76mAeu36lS3uHR1w0GYr4g4pV1So=;
 b=lHs6UyeASRTwWM1NfMJER5iKHG4xNN1zDraD5zXxnukI3AvnICULyXnRo9631Cm91h
 onQe/wcTxw/X9W8n6hlI5tzoV+ghnWZDpUwkDmaFCN53a9+4vcnggKhNc6sxjyBR5j8r
 d0lTmD0Aq4SbKb9j5BgvghX7ZtUlqY6sbcMbJgCA8Pm3xDef3Bzv2+IUvi4OR/CE3YlG
 kTLY09s6jSBBJsHzPNpNXX3rsHynfGeGIUUPZ+e8yDwug0NALcSsb2hZMx7+TyUYAM2b
 8Pwd2vq1L51NDNx9guyR6Tx9Q74Clb2pYurZdOt0l/cFlWH5RzIXcZMkuN46TIUqfbGn
 2bTA==
X-Gm-Message-State: APuU4Z/sr4WXjfQG8lTx/Kq15AfXoUrxkhKFZ4HCzicG65uefLYFs8yN
 kGU4CyDy082P8d2IHdUyH1s0Oa/12KwslyG5lr0sZzzCS+79YGiyhdKh
X-Gm-Gg: AYBFou02Ya3tIo+6KvY1/ULQuv2GLLXfjR2apmQHm5dXCOyWLn8V/Ga3EirqbFczWy8
 J92Dw7MoOb98rwTqbRfkuLA6SdDNzjk4M+GWl0eQV11SXjXIai7KIuxwPVX7TnsXL7KlSYolKJ+
 FXE0QuWPdOmErQin6KmVHwg94jftQfhrQcQDXGupQoYScTbTIE+LVTWyecwauGML0+8hXPb7pxo
 jNLesKYN704rlm5S3W+5eZ+EWvaWM58+28itfWwy79Fc2j7eid9lq/bxoqPQMxrkr+qRvvSClEU
 wSNXvLFN8udAXQ2WbNfBrZXxG8akazLt3v/w5OukLYV1J2ZjSrMMFs08t7XencgEjeMBpbM/vaM
 1guNHEyyixUEothX+449OZpMSoRDhgaQSGtITSU6iOW4CvuSOttjOdIYXIceG7ToSSIyEIvvQMg
 y2hWDeVN9uu4mS3z3UngnbQMcFGJ+R6Mf1lvbbOcmRx8KjQBd+gbOVjfpf3df/2Jg0ojOCmQRwt
 3bcniQb5jyBtbXf/ehuUnM/d3RUqUy9KkDsBc4BesUNPrN9aWIGZKhudHmSPD0Tc4+ecfcqh9Pt
 I19wbX6YMEXcaJJh+6alPr8=
X-Received: by 2002:a05:600c:3547:b0:4a3:5991:718 with SMTP id
 5b1f17b1804b1-4bb88809795mr56747795e9.16.1795173046556; 
 Fri, 20 Nov 2026 03:10:46 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm79108005e9.3.2026.11.20.03.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:10:46 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, francesco.dolcini@toradex.com,
 lukma@nabladev.com, dlechner@baylibre.com, msp@baylibre.com,
 stefan.eichenberger@toradex.com, Max.Merchel@ew.tq-group.com,
 nora.schiffer@ew.tq-group.com, primoz.fiser@norik.com, jbx6244@gmail.com,
 aford173@gmail.com, cniedermaier@dh-electronics.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 2/7] clk: imx: pllv3: wait for the ENET PLL to lock
Date: Fri, 20 Nov 2026 12:10:08 +0100
Message-ID: <20261120111037.110741-3-eichest@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120111037.110741-1-eichest@gmail.com>
References: <20261120111037.110741-1-eichest@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The ENET PLL enable powers the PLL up and returns immediately, so a
consumer can start using the reference clock before the PLL has locked.
The legacy enable_fec_anatop_clock() polled the LOCK bit after powering
up the PLL, and Linux does the same in clk_pllv3_prepare().

Poll the LOCK bit after enabling the ENET PLL, with a 10 ms timeout.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/clk/imx/clk-pllv3.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 85b6a9809e8..8e67442844f 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -14,6 +14,7 @@
 #include <clk.h>
 #include "clk.h"
 #include <linux/err.h>
+#include <linux/iopoll.h>
 
 #define UBOOT_DM_CLK_IMX_PLLV3_GENERIC	"imx_clk_pllv3_generic"
 #define UBOOT_DM_CLK_IMX_PLLV3_SYS	"imx_clk_pllv3_sys"
@@ -31,6 +32,8 @@
 #define BM_PLL_LOCK		(0x1 << 31)
 #define BM_PLL_LOCK_V2		(0x1 << 29)
 
+#define PLL_LOCK_TIMEOUT_US	10000
+
 struct clk_pllv3 {
 	struct clk	clk;
 	void __iomem	*base;
@@ -275,8 +278,22 @@ static ulong clk_pllv3_enet_get_rate(struct clk *clk)
 	return pll->ref_clock;
 }
 
+static int clk_pllv3_enet_enable(struct clk *clk)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(clk);
+	u32 val;
+	int ret;
+
+	ret = clk_pllv3_generic_enable(clk);
+	if (ret)
+		return ret;
+
+	return readl_poll_timeout(pll->base, val, val & pll->lock_bit,
+				  PLL_LOCK_TIMEOUT_US);
+}
+
 static const struct clk_ops clk_pllv3_enet_ops = {
-	.enable	= clk_pllv3_generic_enable,
+	.enable	= clk_pllv3_enet_enable,
 	.disable	= clk_pllv3_generic_disable,
 	.get_rate	= clk_pllv3_enet_get_rate,
 };
-- 
2.56.1

