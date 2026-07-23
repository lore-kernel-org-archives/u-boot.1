Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ECAC531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF1A760A5A;
	Thu, 23 Jul 2026 15:04:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FjPVsl6jmFJZ; Thu, 23 Jul 2026 15:04:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EC4D60A43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819093;
	bh=2ozwOLgMJim2ZkjqIfmz+3gCMv2EX55P8DmhlI+uCrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ba9+tF21IsO61+Mk/+L3rrg3IjWEyHtl+8gUazd6Qv5lGIwiL74SQAhq8rkiI+cm5
	 pahTX1ddQ7JtVdR3uRzH6y5YFRBC1KcfvRiBNl1ZFBckKcPVdDzv3d95heIGjyecl1
	 xJLrDYJ2N1KuZW7uOcBYZqkeX2xef+FSRnVc2doo4jZoDGrkZb6zpQCQnAhuxpOD60
	 vJrdNkwQoRqgQo+9mdLMisPSNn0QojAfyXQWl7norddXoP7ZwfNRNX1B9bQTRCZ6iG
	 0vABCjOvzTGiuVyimXOX1rS7AKZVnVfwYS6n+Pe8ofEOH0q+d9am4/SsTbzxpiN0Nx
	 fuPZtfXep++9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EC4D60A43;
	Thu, 23 Jul 2026 15:04:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 372AB788
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28FE580DA8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQird3ZhGntW for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:04:51 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3DFCE80F55
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DFCE80F55
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DFCE80F55
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F29C80287; Thu, 23 Jul 2026 17:04:49 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8658480087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:04:47 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so1352234a12.2
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 08:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784819087; x=1785423887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ozwOLgMJim2ZkjqIfmz+3gCMv2EX55P8DmhlI+uCrs=;
 b=gRPQob4IkmNf6mFw2nKYg+bdGoHM00KQXI3bNUoyMZZhfyacJh/pVxZ4r4ge5nmwsm
 9mVprksYTWESISXZRqgkRD0B3L0hWPBpyz87832o188dQy0hWKwqKPUKFy73ocmWF6S8
 T1fTkx44J5AOVR3ee0GCeeGd8IlllrCJpZtUYbbZG04+8+UpGBEtje40expVH/TZbhRz
 Z30We0Z7bJa2UBRKTF0okR1nA9buI1a3u9PntCV/pKqEE+JeAl0zFp7rzLXTPunWrXlK
 Ft4Iap9/qKDU6/1Awy6gt8SfPcwFrEZiNpnbXQergjsRmCDk4tlnOPLq+WYnqLGTdLRT
 Ffnw==
X-Gm-Message-State: AOJu0YzMjFpton+zGF7Rl3tKzKwGnX99OHcjeccBStifKvJ3akyKJhjF
 erpxljsBh9I8fxihYYFKRDznFeYZS8fWiD1z88QEMJ2tYPoKAC4knLednbKzrRz76Pk=
X-Gm-Gg: AR+sD10KsHLg6kut0ugqSWsafo5XLuJ4hXlvWvzmBTft43CewvBo0xCpohb7AVzIn8T
 UZ5vdTKcsi+vu4ZO+swQW1qc9P68ZpaqzLpF/dvXM7xJh8N8EKaUsMyR11lo2NRHAV7Y37mVEDo
 gdUJX3W7ikxXaYrgyOVHVsvmBFfpFCLBsYXeHZEZW/9KI7dnokoSVd56S2+p0heDb4+SwEt7f9O
 ZcAOvZHIBC5FvpiKOOliNtS3gHdc561EDFEDa6fqyH2Ww1vyQbrHco2axZcr1c7GzqsSTVGzcPM
 wvf4p8u08opxWmLcRMSklYy1eK4tmmsOHb/SxSnGmDtCilHw+bqbiZx4MBpU7a3m3ayFT74zfeo
 sH2JvBUvTrWceMJp6Vp8Fz0+EZB80HswfXogWN8MH4vJDNpJUxuYzmuyh0+qycR9nNMQN0KtEoG
 IDSI+BQg0gvT5KX1iUFR8tIQ==
X-Received: by 2002:a17:907:7b95:b0:c15:d091:3e51 with SMTP id
 a640c23a62f3a-c1c5074aaa3mr180078766b.12.1784819086791; 
 Thu, 23 Jul 2026 08:04:46 -0700 (PDT)
Received: from alchark-surface.localdomain ([193.32.126.214])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32f1127fsm248769566b.55.2026.07.23.08.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 08:04:44 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 23 Jul 2026 19:04:24 +0400
Subject: [PATCH v2 2/5] clk: rockchip: pll: fix rounding of negative k in
 RK3588 frac PLL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-rk3588-fracpll-v2-2-382d113f3a80@flipper.net>
References: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
In-Reply-To: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
To: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500; i=alchark@flipper.net;
 h=from:subject:message-id; bh=4wdjXksWxeDC+x4jByd4AmjxWXpFj9E6FeuPXUkc/6g=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQl6VabcZo+k89inZzo7VukKOqzLeGB83v+5+3e7hf3s
 a2es9K8YyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKnOfsrw3/e79CovhbZLS/0ibJ4F9LiW71y5l9VNSlkuJfaN2n2rIwz/E8x/auZ
 FuDuUadvs+dL9Zdrqo04alqdcV3+N9JjoeEOaEQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784819087; x=1785423887; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ozwOLgMJim2ZkjqIfmz+3gCMv2EX55P8DmhlI+uCrs=;
 b=tUf9uQrBGbH81VbSQl0h+eKPSshQw09PsfnPExYvmG1/vM5epHj1B2EAAqAbSmqTAq
 5YAL3R0zjOA4eqLYPZw2p/vsxBPx8X+fOHGpLW5qKrBklIgJhhLkxYXx2papvELkd+en
 ZMdD+D+jBKsE6ZQ2fbxN5Pmk5HGOaHaZHBsziA48GFM+W/0CUGG0bR9zxT390cbWgvH9
 jCETJFv2hTsEBDLCrK5Ua6mHCl+xzcdtY/vHucZNMaaihkOCCQ4q/jMt/qzA68huWBBg
 VGn2WE7KO+Poo99Gbp7o6EGgtKEF6VG4KDCxYTTF6JdhH3KGXz1u+/hWXqKjo4j8oZJX
 oIhg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=tUf9uQrB
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="tUf9uQrB"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Current code uses magical constants when rounding up the magnitude of
negative fractional PLL component k. This leads to overshooting the
requested rate when the calculated fractional part has less than 0.3 in
its decimal part due to failure to round up the fractional part.

Use a proper rounding up function to avoid overshooting the requested
rate and make the calculation more readable.

Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll calculation")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/clk/rockchip/clk_pll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index d0df3b8fb49d..69d2d182dcb5 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -11,6 +11,7 @@
 #include <asm/arch-rockchip/hardware.h>
 #include <div64.h>
 #include <linux/delay.h>
+#include <linux/math64.h>
 
 static struct rockchip_pll_rate_table rockchip_auto_table;
 
@@ -177,7 +178,10 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
 	k = ffrac * 65536 / fref;
 	if (k > 32767) {
 		ffrac = ((m + 1) * fref) - fvco;
-		k = ((ffrac * 65536 * 10 / fref) + 7) / 10;
+		/*
+		 * Round up to avoid overshooting requested rate for negative k
+		 */
+		k = DIV64_U64_ROUND_UP(ffrac * 65536, fref);
 		if (k > 32767)
 			k = 0;
 		else

-- 
2.54.0

