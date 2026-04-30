Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB64CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 19:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA6A6845E9;
	Thu, 30 Apr 2026 21:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="sqqsABhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53BC880433; Thu, 30 Apr 2026 21:35:44 +0200 (CEST)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6232280086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 21:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hfranco@baylibre.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-57387f8988dso456808e0c.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777577740; x=1778182540;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XVXK6ci0+STkzEXRAy/8Shk/7pZ8t1YVF2PBVctGQiU=;
 b=sqqsABhnp+da0IVv4aKNIqoIC9/05CN10Us8gKrLP6pqroST0G9oRz12c0VnBadeF1
 zExDB0m+0kW/0XSVV4aHPrwhabnIUyLpcBcoLvFFSTdOL+KXkD7AhVjM13/cZhD18MxR
 VySo/DibEhzasW7ucxTsBQ+TB+BDGK87afzNL+oqK6vCSCh89P9T8fxN1O5wOqp9P+gS
 8v+Qsp+Xd7HSPaOJWnrkJcziDuu3zYarS7+U+PEt1CQRwIC4JWpOI3hn+hic1+ItDIpf
 5BkpYQgEKMwUXpKDfC9B/VMRYW8sjqFBmKUrU2R7wBqHG3w7eDEgnxXG82TDRFDjjVZ1
 oozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777577740; x=1778182540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVXK6ci0+STkzEXRAy/8Shk/7pZ8t1YVF2PBVctGQiU=;
 b=WRrzp50FwCMA/JPF6qN/LT4G/DKlQcSxIjxHf8y8Xp38a7o+7e6/XvHqPigjUcddNm
 aMixvFGXQS68ff3Ele+UpCgTVsBkHR7kc9ntWXeYLDmaF9Gij2g5IBjO16SwA5sCWP4/
 5t/I5Y51BCtzHuf/7IOd0vuG0Jjnd/ssSX9yQtQFhbKoiJdz+ET2RazR2mWeExhXtTm4
 GCD7wRtCq23j/SLbpLpIevYH0lgn3u3x8xdakAX2TGqhhypFt4yNnPo83YpCFknn3wWQ
 UCXGdtCECKUBvXwdk+shbW+Xnneo9hDupzXaLvVGXnoFN5xPLeVt1u0kdAp9eK8UNsvw
 TfsA==
X-Gm-Message-State: AOJu0YzHI++NT2fFdXifaezIjd16KMMM/FYRci8jfF1paZIpAhx7EWhK
 emfwyuxfmwqhYMtCog8VGtPdvpQ08tYxGznqeoZh9s52GxS754G6ljDZIxCfTrEpUHKhlgegCSF
 Hru5OkUg=
X-Gm-Gg: AeBDiesbP55H2y4J439Gw83pIwmH5dKK/zceww9EsSz5F9cfc+7PBPD+NEdUDWRQHlz
 RFaiovpgDGqacZ6NOSpYkJd0QdBuRFVFBEO8iajBoAdZl1gzJ+HpRnoG/FACDxluMMTl+wQPr6V
 p3BYxCwZMlg+D1amMCyCi9nbIgdyTbFfoHmEFJTg3mBoUanetuSOhwmAyfGcb5OpXIQiNYcDPBB
 PjJVqbqge6KPmEwwSw92UC7nI0YFBM5tGcN5T5BK1MrTwYeGSCgMlRmmXl8UAoq7OsfnFTlG37r
 q17HE2xBfk/I1ICcbBP07CczD6PHVg+cR8bROenIkD2MTizm26qlPhHyDxhWG8SwQWtjPlxjxo3
 EXJfBsqpZPd9rAJ2u/4Im/q2XcRbq7Hgw0b79PziGoQHSw3rGRLfBeABOYIbWHYWZks/vabjYWv
 64Kb9xrAhh8K+TIPc7qHz2IovZJhNJS2om2Vt0AFdjjaGCcKaXvp6WHjWhT8BbBuhqwmSEBlLBF
 ma5Y9ez902SgY8=
X-Received: by 2002:a05:6122:289b:b0:56f:6d27:cadc with SMTP id
 71dfb90a1353d-573c95a7602mr2479277e0c.7.1777577739877; 
 Thu, 30 Apr 2026 12:35:39 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c5:9534::3545])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5749f7ea016sm102529e0c.1.2026.04.30.12.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:35:39 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
To: u-boot@lists.denx.de
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] riscv: dts: cv18xx: fix spi node name
Date: Thu, 30 Apr 2026 16:35:18 -0300
Message-ID: <20260430193518.66482-1-hfranco@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 21:54:39 +0200
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

Fix warning:
arch/riscv/dts/cv18xx.dtsi:208.26-216.5: Warning (spi_bus_bridge):
/soc/spi-nor@10000000: node name for SPI buses should be 'spi'

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 arch/riscv/dts/cv18xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
index 6fac247e7ac..8530527aa39 100644
--- a/arch/riscv/dts/cv18xx.dtsi
+++ b/arch/riscv/dts/cv18xx.dtsi
@@ -205,7 +205,7 @@
 			status = "disabled";
 		};
 
-		spif: spi-nor@10000000 {
+		spif: spi@10000000 {
 			compatible = "sophgo,cv1800b-spif";
 			reg = <0x10000000 0x10000000>;
 			#address-cells = <1>;
-- 
2.47.3

