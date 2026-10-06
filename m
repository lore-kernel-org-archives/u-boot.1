Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD9DCA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 21:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A5F340812;
	Tue,  6 Oct 2026 21:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AXtXmIQxDfkF; Tue,  6 Oct 2026 21:48:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E387D407CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791323319;
	b=SVvQbhsdRaf9D494XscVYJUcrNFLPpA1EC7IS8Hv5hQOhn+w8ngCRJKU9uE+B/KAFkY5
	 iufrf8tlCshQRAxMRWhK7cl/cdVHbLwIK4XmaULpe6AO4DGxIKd+hyHV29pM013PDtuKm
	 PqMLDhxKTYJ2jKOczdeRm1b5/TG8uTGJGKaqHGVmGmbH6kF3PRrFf1/DnvedtQqmVz5/l
	 xHR6uFIkUnYooiIXAmXRN+bTFY1HY6vhhqguaWJJSZ8SrxUrkBhdFFXVhiYmxA0R6zzBi
	 JgujXWWOOAZ3+J/usRFrqUAHpTBi6UDw9fAyMAcnz4zvm53MD30NkeCTtxWxnCQLzxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791323319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sxgJlQ8qdTo+AptrVDOWV1Dp/z2/cQ1X6bGsERu8qQs=;
	b=EB+Ui7n2VlzQSTD3wLlHIPHXn8mH/0p/LfizmVEcKXgjyLh14Gb9UGcG9IDeCCS7ueJW
	 Jsmwf+A1vJfVWXp0pADm5IhTEjLqolMCxMKjgtZIxoY41nfqUJNGgVI6bUrRU+k09ydyD
	 W2CW4W41+QUFS+aZDWsy27CL6EpzKzGhRvZjvD/SO6OcXXPK2esJShu/v5ZTKOU0C+Lh+
	 CReq6zfyxIGLkkGtUMfuByWDRFv4kAerEpFF1jQDIBHiGS9E+3EsXh/zQeWR6ibXPkbRQ
	 vx1lH6OZVNXtcvWo6Ox3peRUHRhxvSOUnHM/+EYsIjTDjGcpyKDb3ExFE84bMaxj3DA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VdfZmpzl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791323319;
	bh=sxgJlQ8qdTo+AptrVDOWV1Dp/z2/cQ1X6bGsERu8qQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z+r3HVwH6fm9+kFTe1U0PlQBe3wXnk/IZaqjKN90i2oWg9WWdMp7QfM1IW0nHybZM
	 nK3ve0DtiNqfsTLSequTWmBl2/75xUmjXmi+kVLAQxU2njC9NdlxidUkfpze1hasLZ
	 uUkNJNxLATwMYI0UNA1Zzb5R6VY0Z6ztQ34P/xavlTNyzB4B6AHs6giKulZosgPss4
	 NI8/kRyTHCphxnf91E/o2e912Vm/fbbXZSOALb6fDdxmRgaF1XTswC5YTA34dmytQO
	 WnzgUCABX3kvLJRdSqFVRdwPV2saj202wJXhKQUXf/UbF55WDnS4yAcqi3noEH36Ph
	 br+pb3ubyZwBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E387D407CF;
	Tue,  6 Oct 2026 21:48:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0385232F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E973A40719
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zkYo0K9RGD_7 for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 21:37:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 57B004063E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791322659;
 b=oosn+4hbuBzu+J9iXNXAjNlxjUsjiAlAEeWb6EOo0VO6zRI65GOwTmIlBT+oJjSRqjLq
 fDMmYaub5RTFeIPRIcvDm9u5WeBlbrN0RSrLhE2vbRcThS5JbdXmjJmr/7FzpNniFBspX
 oCkAEVHcVRhYLb6/qyGhjvD/SkTJc4wLuEJ8zzLNrfjWHDZSmeYf24Z/4dxEdoPLjnvkD
 vDafjr0kednkTv6QbAjRiWSSQup7ZJPjSaXoa8YKP54XfqutKd3/JflcABhit5ShW2qgU
 rfltN9GrW2JSNU3EDpnGFCM6Py3krqE9qpYxgiEnbvud/3Mn28NpChlRFVpCS3Z3U1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791322659;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=sxgJlQ8qdTo+AptrVDOWV1Dp/z2/cQ1X6bGsERu8qQs=;
 b=LqDholNhHbtjPYe5jQyZnTmax94UEay2d2JGK3up5dfvZfy6n0yL70qw467yobtcINWW
 rIlr92KnODrq0jlY/wz1vLCUrvu8Z6jF8autpWdj4aMB9b5NnxSjRKBxzE25ZJb1NqZx2
 JPrw8U4Y94Qp8eEJD1ykjkhywLzs2JxE23aruQAgwX7yW4WtyyWxAkk7mUTmaA4sGYCcv
 dHrq9R3c14OnIz1FQ2wOn//4zxEogE0Vh/jSY7fcVKoToFFcE/BBFnTd7z7xXaRl+i9yu
 l0ggOqP3/oBOMCw4v+fzeqV14OgJv4O0NVBUlvW1qzrXZFajMhexvJGqmu3JCNuKHSQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VdfZmpzl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VdfZmpzl
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57B004063E
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:38 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-82380b0f55dso591463a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791322657; x=1791927457;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sxgJlQ8qdTo+AptrVDOWV1Dp/z2/cQ1X6bGsERu8qQs=;
 b=VdfZmpzlrxU3aE2zuvfy5NNJ8J2IN2bkUBiAasOoDUtzUEUUag8+V1kOC6JpoZyf7D
 WUCPYjk9Ws9id5apoTJOh+UYiVx2JmWg+9vgZ0BUDr+YKSSpQGPFqsvtc+U7uft+6Z82
 0OXCHOHJYh4/HzQdju2o/ukg4/XOxYTvrmf9paC4Sz1q+dxIpZ4y0t1mWe2ZDUo7mnzd
 299lvPFupZasT2clf9XHuQfb2wcyq5umR3Md5l++SUwT1khr7YBLSug89PBDlnrtTTYJ
 +KeTiVZ8wN8v7mh/nvr83gdxtRF1iHvapo/Pvp6xdR7+M1E2Jk+6rOFN1eTrPdLfSfiF
 BqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791322657; x=1791927457;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sxgJlQ8qdTo+AptrVDOWV1Dp/z2/cQ1X6bGsERu8qQs=;
 b=jS5eq6gfw1XU3IxdThS+sQYk8V1ozHOmVFEgKq7s4VThj74ih6U6oewygLRPfiN+aZ
 uULiZIcfeIcFCKELlXQodjIU6YKEB3dGv1yod8MMjBR/bkL8hXO+JtsDyKdftjtnOtAQ
 m49J4PS3UGobfdbbIx4XQNZLXKDQPgxntODVuQFOz+/Pr9GAMI3Qeqw0jbMthAR4Q1Dy
 lmVzjhLJtIZxfz5r+fqDh8MhUNheYxfmLaZXHub6y3b9tJCBJwf0ROQW/M350p3HAreq
 fCntHPHmPyFdWL0Z6q1a2+j5d5OoPtmtWifGB9Be7PzoY/sXegkzYf+r2KQx+JD2dJa4
 LNyA==
X-Gm-Message-State: AFuF++mGhCwusfLW/B9s2ye436wM8HeMoUZja8pRhwqUMHdx+ENXN6EB
 uAhoF7h3jgIwSv9kQXXTD+NmrhssCpV1djFFWitTVCfA6TtanqyX+HBq3Y4QPV902QKXEwYlvg9
 bdUPh
X-Gm-Gg: AYBFou2kJW/oSomDPGHHqyISAZln14xUOWVZPb7i0myNbTOVGcsuYyEBNYr8iVkTwjR
 /feB8pfQhAUeC+SrtmfOO8AQpvH816VprdpUEW58iiTnogxRnOQTdr+gt7jcBzCi17P5bFlvEtz
 DvkWJv9xtxKneamSu7hxAqq/EJndP2OG3XQpeo/TBM75xzEdUfQ/niXGM2zXdoXIvecBbPFLj/t
 qoqYLlKiXVaPt3zeOC17jFrvAbgJ18SSsOFmUe2z82mSGrZ6o2OuKTqXPUIkzK4sjqQFeHX07QI
 0fa9KDJiJ+aQsUU0vBmKV2Mdutw+kV1vw1tQ7BWNPNLBCiX7KbhQgHee/cfEeNsN35lRE2if80I
 Is8BqbiFwmjWM0BRvCVzkdAk6CB2MCvk85yNGvfQ7Q2rfkLKXHxD8VxaF1+l+/Po2iu8TgZXpPO
 BxvHZlD0yjeTWV1jcQvzcFKJaa6S6+1G6RtwHRXYEU/SDnlsddma/nxaoBdSHmpxErAKdbiFun8
 w==
X-Received: by 2002:a05:6808:13ce:b0:4b9:e5fa:8a1d with SMTP id
 5614622812f47-4fc4718e583mr519444b6e.34.1791322656872; 
 Tue, 06 Oct 2026 14:37:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4fc4953f89fsm389386b6e.12.2026.10.06.14.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:37:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 16:36:18 -0500
Subject: [PATCH 6/8] arm: dts: mediatek: mt8189: add the display blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mtk-genio-720-dsi-v1-6-7fa10e9c4506@baylibre.com>
References: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
In-Reply-To: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6688; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ZwLFzZ84pQhyElRXVoRBGYiAB0umXRb3A/4yjSYMODg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxWn3UBYQ3GwgKIUAB/geb8WWGkzEJ7dU3Rb0X
 OxwfOHvW32JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVp9xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AFOgH/0nHLYJNvk7QtOACyM/rK4EeJQ+CQ1llA5acQth
 BdaZaqhM8nzO+KsMmnAoG9DDDwAHDLQndHJwQ5HNa0nT+kYKg/+Fj2aDI55TBNLhC+Dz5DKMifF
 DlA3d9Z3rtptfmMQL/oGni64uVHfAGUjF4s972K2WKGRYHksl2DGvqOh8mu/YawWEpi63RtCpte
 MgL/mzCYUNGlpXfMpjzyKfQg+ZrKO3lsBZL6a6BKMQYFGfKomDH3S9ZzYiW5B+SnhjqYVjaiZ0X
 pb4zQhpHn9e6f4eR1KuSlaXwzu4IfUeHX4C2yOPxLDvEX9VsmIIkRK/XllAHXCl7Un59e1+DkQf
 A5Sg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Describe the vdosys0 display path: the display mutex, the two overlays
and RDMAs, the DSI controller and its MIPI D-PHY, the two display PWMs
driving panel backlights, the two display SMI larbs with the smi_common
block behind them, and the multimedia IOMMU the larbs hang off.

The nodes follow the in-flight MT8189 device tree, so the overlays and
RDMAs name their M4U port through the iommus property and the larbs
carry mediatek,larb-id, which is how the display components find the
larb to enable. Only the two display larbs are listed in the IOMMU's
mediatek,larbs, since the other eleven belong to blocks U-Boot does not
drive.

The aliases are the ones the DSI driver uses to reach the pipeline
components, matching what mt8366.dtsi already provides.

Everything is disabled here and enabled by the boards that have a panel.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi | 147 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index 656f5488c72..22c1c7761f1 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/memory/mediatek,mt8189-memory-port.h>
 #include <dt-bindings/power/mediatek,mt8189-power.h>
 #include <dt-bindings/reset/ti-syscon.h>
 
@@ -18,6 +19,12 @@
 	#size-cells = <2>;
 
 	aliases {
+		dsi0 = &dsi0;
+		mutex0 = &mutex0;
+		ovl0 = &disp_ovl0_4l;
+		ovl1 = &disp_ovl1_4l;
+		rdma0 = &disp_rdma0;
+		rdma1 = &disp_rdma1;
 		serial0 = &uart0;
 	};
 
@@ -776,5 +783,145 @@
 			reg = <0 0x1c012000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		disp_pwm0: pwm@1100e000 {
+			compatible = "mediatek,mt8189-disp-pwm", "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100e000 0 0x1000>;
+			interrupts = <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH 0>;
+			#pwm-cells = <2>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_DISP_PWM0>,
+				 <&topckgen_clk CLK_TOP_DISP_PWM_SEL>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
+
+		disp_pwm1: pwm@1100f000 {
+			compatible = "mediatek,mt8189-disp-pwm", "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100f000 0 0x1000>;
+			interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH 0>;
+			#pwm-cells = <2>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_DISP_PWM1>,
+				 <&topckgen_clk CLK_TOP_DISP_PWM_SEL>;
+			clock-names = "main", "mm";
+			status = "disabled";
+		};
+
+		mipi_tx_config0: dsi-phy@11b40000 {
+			compatible = "mediatek,mt8189-mipi-tx", "mediatek,mt8183-mipi-tx";
+			reg = <0 0x11b40000 0 0x1000>;
+			clocks = <&clk26m>;
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			clock-output-names = "mipi_tx0_pll";
+			status = "disabled";
+		};
+
+		mutex0: mutex@14001000 {
+			compatible = "mediatek,mt8189-disp-mutex";
+			reg = <0 0x14001000 0 0x1000>;
+			interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
+			status = "disabled";
+		};
+
+		disp_ovl0_4l: ovl@14002000 {
+			compatible = "mediatek,mt8189-disp-ovl";
+			reg = <0 0x14002000 0 0x1000>;
+			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			iommus = <&mm_iommu M4U_L0_P1_DISP_OVL0_4L_RDMA0>;
+			clocks = <&mmsys CLK_MM_DISP_OVL0_4L>;
+			status = "disabled";
+		};
+
+		disp_ovl1_4l: ovl@14003000 {
+			compatible = "mediatek,mt8189-disp-ovl";
+			reg = <0 0x14003000 0 0x1000>;
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			iommus = <&mm_iommu M4U_L1_P1_DISP_OVL1_4L_RDMA0>;
+			clocks = <&mmsys CLK_MM_DISP_OVL1_4L>;
+			status = "disabled";
+		};
+
+		disp_rdma0: rdma@14006000 {
+			compatible = "mediatek,mt8189-disp-rdma", "mediatek,mt8195-disp-rdma";
+			reg = <0 0x14006000 0 0x1000>;
+			interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			iommus = <&mm_iommu M4U_L0_P5_DISP_RDMA0>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
+			status = "disabled";
+		};
+
+		disp_rdma1: rdma@14007000 {
+			compatible = "mediatek,mt8189-disp-rdma", "mediatek,mt8195-disp-rdma";
+			reg = <0 0x14007000 0 0x1000>;
+			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			iommus = <&mm_iommu M4U_L1_P5_DISP_RDMA1>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
+			status = "disabled";
+		};
+
+		dsi0: dsi@14016000 {
+			compatible = "mediatek,mt8189-dsi";
+			reg = <0 0x14016000 0 0x1000>;
+			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			phys = <&mipi_tx_config0>;
+			phy-names = "dphy";
+			clocks = <&mmsys CLK_MMSYS_0_DISP_DSI0>,
+				 <&mmsys CLK_MMSYS_1_DISP_DSI0>,
+				 <&mipi_tx_config0>;
+			clock-names = "engine", "digital", "hs";
+			status = "disabled";
+		};
+
+		smi_larb0: larb@1401c000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1401c000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_LARB>,
+				 <&mmsys CLK_MM_SMI_LARB>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			mediatek,larb-id = <SMI_L0_ID>;
+			mediatek,smi = <&smi_disp_common>;
+			status = "disabled";
+		};
+
+		smi_larb1: larb@1401d000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1401d000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_LARB>,
+				 <&mmsys CLK_MM_SMI_LARB>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			mediatek,larb-id = <SMI_L1_ID>;
+			mediatek,smi = <&smi_disp_common>;
+			status = "disabled";
+		};
+
+		smi_disp_common: smi@1e801000 {
+			compatible = "mediatek,mt8189-smi-common";
+			reg = <0 0x1e801000 0 0x1000>;
+			clocks = <&mminfra_config_clk CLK_MMINFRA_SMI>,
+				 <&mminfra_config_clk CLK_MMINFRA_SMI>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+			status = "disabled";
+		};
+
+		mm_iommu: iommu@1e802000 {
+			compatible = "mediatek,mt8189-iommu-mm";
+			reg = <0 0x1e802000 0 0x5000>;
+			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&mminfra_config_clk CLK_MMINFRA_SMI>;
+			clock-names = "bclk";
+			#iommu-cells = <1>;
+			mediatek,larbs = <&smi_larb0>, <&smi_larb1>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+		};
 	};
 };

-- 
2.53.0

