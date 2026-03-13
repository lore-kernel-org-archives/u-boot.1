Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF774105F7A6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF71842FC;
	Fri, 13 Mar 2026 15:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YSAo215I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F39A284307; Fri, 13 Mar 2026 15:46:20 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC3B8423C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 15:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-67bad873c3eso1388007eaf.3
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773413177; x=1774017977;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U2kFYPOGHA83zIncSHd2Q9ulw3I4nazz/49aqgHJKZs=;
 b=YSAo215IKb2qKs8QQxZK9i77z17hn+00DNW9uUEsYMwFd8baGaI2HtjmzueHPWxhln
 CshnKv3fUOUtNAOycOYIG4WFY8BIBDqCpCKQwKI81jBzLDUUKE+/sSR5F9PmDLSQJ1Ft
 FxaRxTDhGJ3w03YsMDNRlUKqXWE4NwDlJ4W1aT/HsQEmZjC8Kdns4P7JOWps+gLxlO7x
 no4v5eEANflNyfMAeFUQEpGGdFLIH5F6v2ad/Z1yuWWGNXdsMVKg/m/qWl+W78oWD/zo
 kI6v8q97U4poB2eBDw+Nl1CrX3EfXkcueiO9YCODTx4/fERJqTZtLbPjXpFOlBDUXmSh
 E/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773413177; x=1774017977;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2kFYPOGHA83zIncSHd2Q9ulw3I4nazz/49aqgHJKZs=;
 b=gDWFcefSI/vq2d53s2Q58YPPW52m3f3nwV9b2OmG6NoxdIG/l89vo0OzZ2q2qiCMxj
 LyFbv7KYj8prJjdcyrEfj8xnCmJ4AQrPfvhp562XG/m3lAwlevZe3tpUvl6JEVQwwfMO
 gI8GgH6bOwXbMZQ3iS72qdypXsMBrqxaBv8VPJC7J/b5isjVRbaJwTlsH0gJMPqeB/Tl
 stzl5pbSokn3IGMC5PUhTXyT8fwf9cK9eo7E8zn7Sa+/rIcaBVXgVNyHzWuuat16o0dr
 Pv29+QVVeunOMBNLCwjqbNxlSATPrd/4mTTircsmyW23N21y9OCUmESy6LN4qymOMCAN
 AdIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2eq/lFqHD3O39ApQpLqujgLajBng2HEXomA86tMHBPEUOo9v8Jl7jJSxuGwORChWeqVgJrAQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxfdMKTDLqCxWhFLR7i58rmXnbID6hYk+V5615AMzE4X0WWSv6C
 NN+MD2L0Ijc0iOmOzoeGxXiD0sdmYVkmHd3Izt1nmdAkZ1yzAw+1u8eLFKVzd3YAsg8=
X-Gm-Gg: ATEYQzzAbVAxKQFSCV+cdps7hOGGLNd4ZR46NOKT9l48q/Jmcfth9g5VA9OvBEM4otC
 egu+GVbLsx7lwBa4Ws6Gex0+xQef6gmNYRzqbxrKI1DgYPuZiInV33wRoCDbiUxmv4beBUj21fD
 lLHZrgXmE29PU+LeCX3742x4SNMcIAwK8QtTiwPa93zyY56a+0ZWlZNikOJyhRCAQJ9dgc7ZfmO
 f3smd351PAXFCVrf7FMRPBccORP6P6Iz0VNEq1GpQPvZzWSk4g2Y+hG1MlOC671pDi4j48N3avI
 P/2KSxhzSVQsbqw4E/hd/6PGYYyn1+NscnBkhxfmp/eQioQzXmP1JE/qCaqkHx4ctk6qFzpVUVT
 VZkqiFl9VX7de2We5yFw6XcThQ2JdO6+gcz4CWnQ83O/2mTAfyWHAaNv+4JAA+Xo600NQXPcMaF
 GX667JgevkbdRYPi/GRhhKH/0N
X-Received: by 2002:a05:6820:448e:b0:67b:badb:fa7a with SMTP id
 006d021491bc7-67bdaa36e8fmr1695642eaf.35.1773413177108; 
 Fri, 13 Mar 2026 07:46:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:bf:9982:ff59:466])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc91174fbsm4963501eaf.4.2026.03.13.07.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:46:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 13 Mar 2026 09:46:04 -0500
Subject: [PATCH] clk: mediatek: mt7623: fix pericfg priv_auto size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-clk-mtk-fix-priv-auto-size-v1-1-bc649e1b301a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDtgoih4ldJFTEYdtSqZKKXi3
 Y26fPD5Owh5JoEq2cHTxsLzFKFeCdjOTC0hu2jQqS7STGVoxwG/YcCGf7h43tCsYUbhP6HRtXM
 uL8omVxAHi6dY3fP357GsdU82XEc4jhPY+oLRfgAAAA==
X-Change-ID: 20260313-clk-mtk-fix-priv-auto-size-a2bddd467f41
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=6QR8JdLLHGCiO+5S0ERoCTqW3TW/2xYtepzVjfRe5YM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBptCMwMEeU/9ZkI69q3irAnaZFOs3svx13pVq2B
 FG4sevYtpiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabQjMBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AO3AIAJmuHJkBrOtlkPX3gFZVjySlJKbzEdpvlOYsAbN
 WAunnnHqY4VWEpSJbafgZ7UrodZp3+sW8Unff4RpFswVMnVl8u9uUzcjlKiBkHTk08qauM9J5u6
 0nZ2PQv7opVWJhjYnFxYvG+SKHN3Q32isjNf+IivzFuwI3hIQpOZUaa2tzL2HwEUl7YqrNQEYGf
 QUoS7r8RR5mdARRX4vx7GnvCQJTnlNu6wvbSae3o3ndrdVHWAn6N8jBv3YlcGX34mLCoULugJNp
 bsYEzxMIau3jTtCCm62Xwu+D5vAVG7Ror4qZxrlHrjkkyKu+nm1PWJE901fJsJAvg35+89rqld7
 s4lY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change the pericfg priv_auto size to mtk_clk_priv. The driver is
registered using mtk_common_clk_infrasys_init() which expect that
struct.

The old value of struct mtk_cg_priv was larger, so there was no issue
out of bounds access.

Also replace tab with space to be consistent with the surrounding code.

Reported-by: Julien Stephan <jstephan@baylibre.com>
Closes: https://lore.kernel.org/u-boot/CAEHHSvYMiCZ4jAXp6jEhg6AhZ5Dv3_Ak-8H1mT7S2FPD3_X7dw@mail.gmail.com/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 071c4cf8a84..87720a93eff 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1187,7 +1187,7 @@ U_BOOT_DRIVER(mtk_clk_pericfg) = {
 	.id = UCLASS_CLK,
 	.of_match = mt7623_pericfg_compat,
 	.probe = mt7623_pericfg_probe,
-	.priv_auto	= sizeof(struct mtk_cg_priv),
+	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };

---
base-commit: 9f1059bc735ec2a8d78c1f3e4fcab1fa3f428317
change-id: 20260313-clk-mtk-fix-priv-auto-size-a2bddd467f41

Best regards,
--  
David Lechner <dlechner@baylibre.com>

