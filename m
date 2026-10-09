Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE202CA6015
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92824608F5;
	Fri,  9 Oct 2026 16:16:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GfulIFR6zH5X; Fri,  9 Oct 2026 16:16:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6A69608C9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562571;
	b=hWKBnd29onACSfjIYxLlGHH52YeLvYy5Afn4Uv+DkQC2G++Yvqdp5T345ZvKNMLyD/R/
	 TpyhYXS/x/PYPdkHL5qVyGcuciuT+XbE2JxmSDeHJue6Vt2+StIMF2AH4tlcE3EA2Zgyf
	 KnjglJDpHB0JmzVsFDtO+zAfbnyvU7+udot+efwL9KC+gcnzJAGKtTZKLl38qPymuZXGM
	 4wXj6yLBOVXCyBAmYslvqWL13wlWkmncz4HjMW69pzfFoOg7rj+SHHzV/BxwA0PLjDC/V
	 Ki3f+egRm5VW/KGJx1Dy+DH18gXePlQPGAePcwcQKmerXdX8MLosVgSGynwulsEbTBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lpwFA+Tdw58uuNTxa6Ahmmwhi+Gx83oJ+aTrMA0Ok5U=;
	b=curNYTHTz59oSO/ptv3GdtTxzToZ7VKNCM+1/HSJC67xNv19vY+qklJ5F4iT8KOw3QvI
	 Z3TNyya/AYa57c6v53zwYUvzvh1xU0+zaX4bCIO194O9xwSX8+7TZs2cXcBsRCPBKsSeN
	 l6j89778KogmKjiHP8ItW6cNXZfgvXg9vF1ZR1RR6/JSjzGrfKysEuL+Kbbn5fwGIG6wW
	 XfHWbFb/KjtXIv4B+elO4MjR00i6relaJokwuhYjKkm90xGyuI9vk2i67wRXZkRUf/Y+z
	 MTldSdmWTHvBkfu1LqDvEYUyC8pke3R7okqX9xsr38FIOokgLgTEtxo4wY1BHd3mYJw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562571;
	bh=lpwFA+Tdw58uuNTxa6Ahmmwhi+Gx83oJ+aTrMA0Ok5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nhYLv3z5s+eG9dgJAi3wZVcy4RBIergVcw34Gf7NNyl/wi8euFwtHKZUcfvGLi7UK
	 JBNeh5n1YGLtLdLL0S1P3tNSFpBqSUaT92dExAK7BCZmdLLbtBfsS0S7B/tJdEm6s9
	 gPFn/rs67zzRYx8qwuQDTXahaua3W+l70NBU7xB/3usEEa3foTqGfUaFSv7ChWW6YP
	 mK0WODPfEMMF5ok6ns8a4H0z+8fI+XDn4pzpUfVseWp4V832JGDyivhSWGZqePmZU5
	 QzPpW0bMR6W1o+yBpIf+L1Zp+/GAXraHg0zqEeE6ji69ky8tzHKvCe0MSJh14rF1HN
	 b2nnueTiHelbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6A69608C9;
	Fri,  9 Oct 2026 16:16:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C31452AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B53B040129
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXa2-P65KSpS for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:16:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E029B40102
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562568;
 b=QgrTXmTzvEcVz6NeT2ieUPX0yfhWuCfP0uPUs4pbUX9aLG0kW8Tp2fRpXIf6Gnbv+lS8
 Yw7Gc47LBLEBJeLQ5PiiOyiOuvOsR93Cg7cHbCk9OIPTyfftdc7UN3crjtKCSMWTaO00T
 ycPSlCirEmEgxx9GArNj+V6Jf33hd7510pJ3Sy1Aud0XJYiaMGo90WA06M0gVNr9YmFyU
 aQIK4MItcj5gNAzPQ8fbEqvBDI1mcxfOOG8HdWpZlOgajHy4wpO5kErUjWiCuU8cADpFr
 NQYrdfsWj6IG0wzLsQ+RpHVCQM1pf4d1HX/5HUEfIDlBucud2I2cnTdypjnNyJPViCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562568;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=lpwFA+Tdw58uuNTxa6Ahmmwhi+Gx83oJ+aTrMA0Ok5U=;
 b=lmHm3dlDWVCa7b8lU9Xoh9Jl2Sy6fq5v16j6c98iIhO+y0zxg8aXEucoTchfLhFzMkmK
 EhTlLVUB16UGs3Oevoiqn6p1xu6wYxWKhWZlChLpmyx7HD2xRReGPXMOJ92MjGS3dfKiT
 EuxEvMLMmHrbmHivJcUMDTLQ2+UrZ9dEl/lkd3zJATkhfytS6z/lwnJwjrh3Nie2NbETx
 +w4kXt45BKVzFeDXuBxrTwlwYY+fK2Vk6AVgrikoRKGmJw4q6KiTxePNZ0/U/YhZrJ+36
 w+WK7DE1YRHHcXObWxnz26of9G6MTAhVfe+52ZZeU+b+kOgJ8+vG99qyLJaea67WOaA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IYiDzqeg; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IYiDzqeg
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E029B40102
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:07 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4a4cb36ae00so2564465b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562566; x=1792167366;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lpwFA+Tdw58uuNTxa6Ahmmwhi+Gx83oJ+aTrMA0Ok5U=;
 b=IYiDzqegAb6QmgTX1iKRQO7LS6IPrH0N/ewIq8LR1jHyx3B2uPQcH0j2ioRjHsOBRf
 h3iaJiCsiI9loG7ou58XxJT/WsgOk38KdPSNXszjFLIBEvQTy5POggiIB/2fLVYy2649
 cyJA2sP28aL50yhAhQ6HdA16aBBJEBwtxB6aS/gO9AiH7U8qlAvQysz80oCs9a/4TrZ8
 27PyKygOxliFe67DPJVBlo5+QSXVSnbgGrWX8riRlIN94LpO9IrnvycIZq6xPyKRNubx
 qOUb67TyXWtE/aAa8rNd7RJ5qwwdhTFhBj1s1BT6TyAOkC2iULgQUJVgNjLiSN2BsZIh
 Qp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562566; x=1792167366;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lpwFA+Tdw58uuNTxa6Ahmmwhi+Gx83oJ+aTrMA0Ok5U=;
 b=O0bEOj7rTHyqLzBqtO/S6xpUTlCJImFPbyLNEsS1vCU8hG2zHCPkgOJAxGQ/LhkDvE
 WIJC7ffRWEvhWwShF6hpDMflnVf4gMFriTgaZp5ERQhKyW38Q2kavpvvsbJq2DEIlkG5
 gUhBPzsXxcvePAb3eLIv40pdbeHl8/GpJ+PBYrmLYw0BZEDN2oCEvVUitP843W+F78CV
 wRZm+dOA4QBsisVbtPmrUOB2BGBUHOD4zO1GjFlUctKOFfNb7Ew3REIlH8QUQYPhyjig
 SOlqKOOrDU4fp8sI8gfNBVCJ7tESSMp+vPjdKNtM3SY2MQZXEoSyObbpDVYg0uAkoJWI
 +OkA==
X-Gm-Message-State: AFuF++k+DU2IWnEz3EELwW1RULM7BupUtia9+kXB0Y1MaqVteobOtn8k
 tWnHtw5k57Xs5+UWQAEbKcDv4hI4Zp0FMUwLvVV3rNne/uOUEzqzxmmcUU+qpecXF0s=
X-Gm-Gg: AYBFou0qp9+3nFlOa4jvTAlkQwA3BBc3bOCbAFqdKjO5hALxclDqkbXpaqyAWVAQgdV
 8MOUuaaUimt2i6/AdQTrymVHpOQwU3QRsygI8oGquPy7abRR79zQUNd8Pqpa0GbJT5Ycmp7ZQO/
 Z++sdl5Fe6AQQqcBqgUwOygeH11d3DfvN+SMtMKpYMRWaHQ3XGbhKtCqxPqHF7UlNE14J+6xZG/
 RnFdOCfrCAD4G89CxV44f0QE1vJ+R69LLy9qsz2/ISnkbuTarAEQsqak5oZrlnXeTSU1F9EFNxV
 SB44bfZS6J0/L9i9sBrsy/e7aytEoows+8DaoJzPVBOmm/kMEiePsKxP15lP/BtNt9vcb3YMwiI
 yapsJqHefLccf4+5SdP51eieeNbS9sc+9VdKrOQKKNZYZ17zQgLkDDAQ5TQsGgUQmXbrCteNxkf
 tNyKJdM0L0d/ScmrXaUj7A4hNS/sWPr24fHTPVynCCU5Pa16izNqhh2wqT/aDIC+yVRXQ2zjYbq
 wCHSXJJXu6JWQ==
X-Received: by 2002:a05:6808:2211:b0:4d6:90f3:74a1 with SMTP id
 5614622812f47-50c58042fdbmr1699496b6e.44.1791562566399; 
 Fri, 09 Oct 2026 09:16:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:16:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:13 -0500
Subject: [PATCH 10/13] arm: dts: mediatek: mt8189: add the eDP display path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-10-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3783; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=OFnjDe609xNcrqbwuqPcF9aafPWCHtQlxkxjJFYZhY4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRMVaIBYxu3miPdSU7Bt4AWHrucLMyA2KCS53
 clyJZeA64uJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskTFRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiSQH/RLWCILAlaXwA6L8nd84ytWbtMuLnxM4xCKfLxd
 NrMK4ScGYAk6aTlZJUIRCQkk5/ZLIRqmKGFz+dEVMsPLypiH1vkCCWyc10KXrMDXNM3ic9iUFqF
 BwqZ81yY25qFhG2vkBZ1Zw4Nl/2r4qKWzpzX+1Y8TvPnB6KxhK/vl2N03j/cn8mS6RrmTyL50TD
 n6R0RyjsXdCN5TjJS2lIa7IjFMwgIm79/7XSKzXSzyOHuDe/ElFXHKb+U5MnX07YShjJJRLcvZt
 ah1hZiigiw5WzY1AYfWU4aKntIDqetlZPLN+vBTnTWkEOy3ttodQH6fZmJmHAJNDNsq5vZdlxQl
 OeYA=
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

Add the eDP transmitter, its PHY and the DVO output stage that feeds it,
along with the DP_TX and EDP_TX_DORMANT power domains the transmitter
sits in, which were missing from the SPM node. Label the apmixedsys
clock controller so that the DVO node can name the PLL it retunes for
the pixel clock.

The transmitter's domain is nested below DP_TX, which is itself below
the display domain, as in the in-flight "arm64: dts: mediatek: Add
mt8189 evaluation board dts" series. U-Boot derives the power-on order
from this nesting alone, so describing it flat would leave DP_TX
unpowered when the transmitter is brought up.

The PHY is described as a node of its own, referenced by the
transmitter through "phys", the way the in-flight "PHY: MediaTek DP PHY
refactor and MT8196 eDP" series describes the MT8196 eDP PHY. The PHY
holds both its analog and its digital register banks, and the
transmitter's registers start right after where the PHY used to sit in
older SoCs, so the transmitter node starts at 0x11b72000.

All three new nodes are disabled: a board enables them only if it
routes the display pipeline to eDP rather than DSI.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index 22c1c7761f1..0f659908f32 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -179,7 +179,21 @@
 							 <&mmsys CLK_MM_SMI_LARB>;
 						clock-names = "disp", "ss-disp";
 						mediatek,infracfg = <&infracfg_ao>;
-						#power-domain-cells = <0>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8189_POWER_DOMAIN_DP_TX {
+							reg = <MT8189_POWER_DOMAIN_DP_TX>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#power-domain-cells = <1>;
+
+							power-domain@MT8189_POWER_DOMAIN_EDP_TX_DORMANT {
+								reg = <MT8189_POWER_DOMAIN_EDP_TX_DORMANT>;
+								#power-domain-cells = <0>;
+							};
+						};
 					};
 				};
 
@@ -399,7 +413,7 @@
 			reg = <0 0x10001000 0 0x1000>;
 		};
 
-		clock-controller@1000c000 {
+		apmixedsys_clk: clock-controller@1000c000 {
 			compatible = "mediatek,mt8189-apmixedsys", "syscon";
 			reg = <0 0x1000c000 0 0x1000>;
 			#clock-cells = <1>;
@@ -816,6 +830,24 @@
 			status = "disabled";
 		};
 
+		edp_tx: edp-tx@11b72000 {
+			compatible = "mediatek,mt8189-edp-tx";
+			reg = <0 0x11b72000 0 0x12000>;
+			interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_EDP_TX_DORMANT>;
+			phys = <&edp_phy>;
+			max-linkrate-mhz = <5400>;
+			status = "disabled";
+		};
+
+		edp_phy: phy@11e10000 {
+			compatible = "mediatek,mt8189-edp-phy";
+			reg = <0 0x11e10000 0 0x1500>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_EDP_TX_DORMANT>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		mutex0: mutex@14001000 {
 			compatible = "mediatek,mt8189-disp-mutex";
 			reg = <0 0x14001000 0 0x1000>;
@@ -879,6 +911,18 @@
 			status = "disabled";
 		};
 
+		disp_dvo0: dvo@14017000 {
+			compatible = "mediatek,mt8189-edp-dvo";
+			reg = <0 0x14017000 0 0x1000>;
+			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MMSYS_1_DISP_DVO>,
+				 <&mmsys CLK_MMSYS_0_DISP_DVO>,
+				 <&apmixedsys_clk CLK_APMIXED_TVDPLL2>;
+			clock-names = "pixel", "engine", "pll";
+			status = "disabled";
+		};
+
 		smi_larb0: larb@1401c000 {
 			compatible = "mediatek,mt8189-smi-larb";
 			reg = <0 0x1401c000 0 0x1000>;

-- 
2.53.0

