Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F76606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iomMFgrU;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FqHwOJmg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7152440B3F;
	Sat, 24 Oct 2026 00:10:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 36XO0nNOsu6b; Sat, 24 Oct 2026 00:10:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DEF0640B2C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792800631;
	b=m6SrELpAL9YBhsYJwvwWyMXSZUq5wMCytOwD7/vbn3pBS0PgEplhGLQHRhuhDORspxLu
	 lUMeztkXIfxrnXmrTEoItpo+xfY6TuMu9AE8mZNyyjcC4Uo0gh34GZQXhXZIzoE9BRZQq
	 S8T0Xm98s2kbLCCC/AcSKbJG8UBDXzOovRqqdLooYfAeFnN5RHBwtuvm5fKemj4yPX6F4
	 OPFuTBVeHxhARNoPao+8sufAq+gFr22G++cqqcmiG9ohlsdtnVDIebJraCuLXuNjIdSNt
	 lBZyR2oOmSLi3V/d2guXR4KJ6WUWAwO2xR8fGqxLQaP3zfG0BbieyJ8Dmql7XNwPtZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792800631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KIz7G54bUVwQ36Pd6Y7tZas5nVfjD4nweaF2/xPbhOI=;
	b=JrhbxI2WWWyMwD8+PtIU7HGuzExunG9h9Bp5Lp039iGMF3hKDZoYgyujtNCsrX1dFeCJ
	 0UK0Aby9Y1mkOpUmjpj2T1N5a3KMMIT6IVguD3AwbjcT+Hk66LyNs7W8RFAKuY8TFxcZF
	 Nk7O8xXix8c09fuSCv5RR/37b9L0fhY57+E00E59Deorjvv4LXP38JHeIcizfwFuv5iQ7
	 bWj4Tab78C6YDo+xhLn7SEHjFaPoVRdfsoYPDs91wz41jsU31qz3pHrJSTKne0rgZcBcF
	 chxo3iOQe7zDKiIJgXW62bhKSQH/WvmXYJrMRVDAYYN/xUh1kmbtIPga12bGdeW37tw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792800631;
	bh=KIz7G54bUVwQ36Pd6Y7tZas5nVfjD4nweaF2/xPbhOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iomMFgrUTeGuIfp+AU/4VtZ5THMvno1O63E1MlWK0wDmMtabTgsRTpiDSneu40qrv
	 obGfXHBPdlv9FeNfaRzCIJFO//7vINtQUf7OmJ8VX8E+7FDzj9VVhQf2ZP73jTcBXi
	 gwF6OsOKm1P3tSZ+LQgb0Zj/Bg6zSJ0oHt003H2vQ3CeDQBN5wyU02vHpXfD2XnZXW
	 HHl/P/drTvJzipo//CLWl4NHyVewFoXR84YL3xuYLPLbg1Er4jGReWf2i8WJJiVkAL
	 YofqaHB3CVu3PWdNhHFEWaHpnsB8srAwXg4l8xnQA1zlCGzD9BZp/PPCXK0EbeZzTL
	 yCuLFn/8cBvEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEF0640B2C;
	Sat, 24 Oct 2026 00:10:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E2DD0235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C944F4016D
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XiLdzMThlQGH for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 00:10:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5EA794009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792800627;
 b=FK4FAUML4ErnYhvk7svWJynPHWhQdgZchqUe9dMrWpH/1VI++JQe9akiroRAInN7H3u1
 7Tex14Eesgo77fvL3dMV5HSF+wLIz8qYfusUIaQ2O0/pN76+afNm5DZ6DeajYmYVIIKms
 a8H2qAvBe6fOFTUi2wjPdok1m6kcKX3r7opIYAI5XCQ0YNXtu6xOJNxxOHZxTgzY3JRsf
 R/etuX7jrNV4sviZBy1NWjQ8hmkCRNAr7u0ec84C7KGJ6RC8Q+2w6ZKU5gw1K/UqqOWsQ
 jdV/qr1DiLelkPN9Kt2BSdNq9SbUtNFWaGKlDIAhGMrmP2LxAOWvmXhQidJ2H96Fc/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792800627;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=KIz7G54bUVwQ36Pd6Y7tZas5nVfjD4nweaF2/xPbhOI=;
 b=VK1QrZUaR/XwN8GWpkeG/QYui2GnsHmg5DvhcvIrYGu6L5rDeDQQAXH8BQ2ghRckXkND
 DOPhm2+xFgU6zVHXG99WBfqWdv6d6VC1T7T6OQNjxaTzpBa8OpH5R58CvXtCYrvWPAuOc
 blAwudR8pjHal7VDG/xlZfBT1J2lUkw/SBpVkfmI0iM07tpnVZ6+zJuckuyb6nOXMoBwh
 ig1B4qNpKrE3zgOkiRU0/1ZNlBG04FREqdCtukxFiQtJUEZcIywoOHkGduW9+jA8uWaVt
 VggnfG4pSjw2K+cJ+H22K5XBLuGa6AgtXHZwbtSu3MDqW76NuxHUnxaSbkqEAGRPrnA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FqHwOJmg; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FqHwOJmg
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EA794009E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:26 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-825b40f8a26so700924a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792800626; x=1793405426;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KIz7G54bUVwQ36Pd6Y7tZas5nVfjD4nweaF2/xPbhOI=;
 b=FqHwOJmgNWj0mPyoYTaSvrZdSxT3O6wYdEpO0ysreDYIbttUOSBa8550LVkmmv2myO
 yHgAMMN8rg6Dq8O89gp088MqQZzxzSEQ9LYCtZgg54a21jyjM0zuOtIX7Ci6++YXuNZ7
 i+S4Oap1vpPLopsxD9B5EvdgHVx4ucL/sjIKdGzMz2AFrdtWsHOBnUO8omRJmtj5V+vO
 Iz/s36So6INffI8BVQ2jCj2SyWZ5KlhiHbwpo8yHyrA19glgWmX73+RVS1CfUNNZLkJu
 zWOJaw8fLe+4y2jyjRrBcsr2kjGq1xM9vRMoHt67UPQVZ4sTF6KLzgVS1Z+Ug02ldTE0
 u9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800626; x=1793405426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KIz7G54bUVwQ36Pd6Y7tZas5nVfjD4nweaF2/xPbhOI=;
 b=UAAcfqQ5GItdmz5376GIZoljL1dMSRtvxXDKS5bhiSieQDZ9f+0QdKrMUrsHfI+HQg
 swNF4gpANZJfINiiUvr9TPl9oQ2wjAPtN20X2q8U7/XAwJRKSmbAM2d1rpLdZYhnweYA
 j4APzmff1xobHkCrPso/Ub2eOu3y3KcsaDTRXxq7N5IvL0+nU/zkBTprKkGVM4GM0N2R
 OqqLFisLKVE6j2HnUs9BRAMe4GI3LERhKxUdehE+VNgFDnVDAue69QzPsSaRp6AZ940t
 zssAjNXs2DIDFWH3YGIOclxrVfs0RnEZWGyQOgNyuqZvHknkDoOcVc5NBF8xTYhgxOWs
 DbWQ==
X-Gm-Message-State: AFq9FYLO6CTz2PswVofnZU38BRfSJrrKkqQIuMSQar+dZ8/HYARCLEHd
 tm1EYOG/5cUVIzmgCu+wS7r0/4Y5/ZqH9aoxAmYATpohCdhy199Q32vd4RBDy/tjRVE=
X-Gm-Gg: AYBFou3SzRWAetlfATagm71M/Zn3k9Sx+ayCl8+a25qZa62FdSCN4Vl62DhADHrbcKG
 mrYP/ACtwZVpfn1ptKUev2bJnW5dFYsxXrSWUFFu0sKoangxeGsK+ErEv16XfT651ATR+rbYfo6
 DRNLLr2+dl7lSQpiju/cUbfQkfXEj8z04nXV3Xh76sY9zDADI/pHViA9w8ZAwffNtGOiySrNH3w
 k9Ze+duguBmizKt1ujtBCUuGWQiif57UjjcBS2Dx5HVfn2e40PAWrJTTJnCX+LIW1nVHSTLOrva
 qEBmRYyqBoT/+OSHCJkcsBnFN/QyVtfriSUPQEzSilBOeUNY0UtiXNMelO7BINZxTLFyazb7Ys0
 GwA6puZKFWcnPDprHPsq3wccf+DrQJ260R5ZPPCIVubdQPUP68ivPKMnbNjmPfbvp3VAZk533vf
 qg9OKhf3z06UEu5iGXGecatNQR3z9Lv3OPv7BwiiXjLO0AxpE0LXGbf0liUswCcqCrq5TRla7/3
 YlLXL/l/tBAU5qv1NZA9+xcdkIllg8rjNRnLuyhqCaCU17Q1RwSvOuhq2Hl
X-Received: by 2002:a05:6808:c40a:b0:4c4:9f7e:92ce with SMTP id
 5614622812f47-55c0029622cmr621151b6e.38.1792800625747; 
 Fri, 23 Oct 2026 17:10:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04248804sm328636b6e.3.2026.10.23.17.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:10:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Oct 2026 19:09:13 -0500
Subject: [PATCH 7/7] doc: board: mediatek: document Genio 520 and 720 boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mtk-genio-720-spl-v1-7-f2c0ee094fd0@baylibre.com>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
In-Reply-To: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14373;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=dpCUNiPa5/cO7rdbBpCEA68XKd4yo/ygJHriA2qN+ss=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2/dVie4w3bcK2OIkIbgjsHwkIjYwNcbfsFbXb
 cajAH9GUKuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatv3VRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2x8H/igoMPJzZwe4hrx/iOlMDwy0OUY+yDZEuORAZ6I
 hY8VNO6D2d9qGLsCwR3Yy+gTGmjvzej6HGAed6bSzCB1rXroD6nuyT8hSi/e38YeG7cw0twtaI7
 tNKLNsCTc2JRUsjtpgap7XlYnaIurrljb0ra8DIS18cMF6Kv1WmxM2JGenL1RtGgbOudqfhQXb5
 Nk/do1DMcqdnnfp2XADslAI47+VV4qEcpoZQ2MW5PYsLPHmc8EfMEPaDuUHGmmunkuC7DIR+lBn
 MN2dcz1J7Am7sqPufepv8SE4wU3uyH2JrtaUkkIjj6GHS3OZyubexsbcdZtxN9gSr0kxTmv+Eq2
 dwgQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a board page for the Genio 520 and Genio 720 EVKs. It describes
how to build U-Boot proper as BL33 for the platform's own BL2, and the
DRAM description that the earlier boot stage passes in a transfer list.

It also describes the optional U-Boot SPL boot chain. This covers the
DDR-loader handoff contract, the MT8189 image layout and the eMMC
BootROM size limit, as well as the build and install steps.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS              |   1 +
 doc/board/mediatek/index.rst            |   1 +
 doc/board/mediatek/mt8189-genio-evk.rst | 306 ++++++++++++++++++++++++++++++++
 3 files changed, 308 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 9087cb56c34..fa8a3ca086c 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -9,6 +9,7 @@ F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
 F:	configs/mt8391_genio_*
+F:	doc/board/mediatek/mt8189-genio-evk.rst
 
 MT8365 EVK
 M:	Julien Masson <jmasson@baylibre.com>
diff --git a/doc/board/mediatek/index.rst b/doc/board/mediatek/index.rst
index 7ca1bd9fde2..21f01ec88ad 100644
--- a/doc/board/mediatek/index.rst
+++ b/doc/board/mediatek/index.rst
@@ -8,3 +8,4 @@ Mediatek
 
    mt7621
    mt8188-genio-evk
+   mt8189-genio-evk
diff --git a/doc/board/mediatek/mt8189-genio-evk.rst b/doc/board/mediatek/mt8189-genio-evk.rst
new file mode 100644
index 00000000000..2491a2ab6fc
--- /dev/null
+++ b/doc/board/mediatek/mt8189-genio-evk.rst
@@ -0,0 +1,306 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2026 BayLibre SAS
+
+MediaTek Genio 520 and Genio 720 EVKs
+=====================================
+
+The Genio 520 and Genio 720 EVKs use the same MT8189-family boot flow:
+
+================  ======  ====================================
+Board             SoC     Defconfig
+================  ======  ====================================
+Genio 520 EVK     MT8371  ``mt8371_genio_520_evk_defconfig``
+Genio 720 EVK     MT8391  ``mt8391_genio_720_evk_defconfig``
+================  ======  ====================================
+
+The configurations share their memory layout, drivers and firmware-image
+layout. Each board has its own control devicetree.
+
+U-Boot can be used on these boards in two ways:
+
+* as U-Boot proper only, started as BL33 by the platform's own BL2 and Arm
+  Trusted Firmware-A, or
+* optionally, also as U-Boot SPL, which replaces the platform BL2 and loads
+  BL31, OP-TEE and U-Boot proper itself.
+
+U-Boot proper
+-------------
+
+In the usual boot chain, U-Boot provides only U-Boot proper::
+
+   BootROM
+     -> platform BL2
+     -> Arm Trusted Firmware-A (BL31)
+     -> OP-TEE (BL32)
+     -> U-Boot proper (BL33)
+
+The platform BL2 initializes DRAM and loads BL31, BL32 and BL33. U-Boot proper
+is linked at ``CONFIG_TEXT_BASE``, ``0x4c000000``.
+
+DRAM description
+~~~~~~~~~~~~~~~~
+
+The DRAM size depends on the DRAM fitted to the board, and so do the regions
+which DRAM initialization reserves for use by the hardware, such as the DRAM
+controller's tracking buffers at the top of each rank. The devicetree built
+into U-Boot cannot describe them, so the boot stage which initializes DRAM
+describes them in a devicetree overlay. It passes the overlay to U-Boot in a
+`Firmware Handoff`_ transfer list, which U-Boot reads as its bloblist (see
+:doc:`/develop/bloblist`).
+
+The overlay contains a ``memory`` node with the DRAM size and a ``no-map``
+``reserved-memory`` node for each reserved region. The first compatible string
+of its root node must match the one of the U-Boot devicetree. For example, on
+a Genio 720 EVK with 8 GiB of DRAM::
+
+   /dts-v1/;
+
+   / {
+           compatible = "mediatek,mt8391-evk";
+
+           fragment@0 {
+                   target-path = "/";
+
+                   __overlay__ {
+                           reserved-memory {
+                                   #address-cells = <2>;
+                                   #size-cells = <2>;
+                                   ranges;
+
+                                   dramc-rk0@13fffe000 {
+                                           reg = <0x1 0x3fffe000 0x0 0x2000>;
+                                           no-map;
+                                   };
+
+                                   dramc-rk1@23fffe000 {
+                                           reg = <0x2 0x3fffe000 0x0 0x2000>;
+                                           no-map;
+                                   };
+                           };
+
+                           memory@40000000 {
+                                   device_type = "memory";
+                                   reg = <0x0 0x40000000 0x2 0x0>;
+                           };
+                   };
+           };
+   };
+
+U-Boot proper applies the overlay to its devicetree and passes the reserved
+regions on to the OS. The transfer list is passed to U-Boot in ``x0`` to
+``x3``, following the register convention of the Firmware Handoff
+specification. Without a transfer list, U-Boot uses the ``memory`` node of its
+own devicetree, which describes 8 GiB of DRAM.
+
+U-Boot copies its devicetree into the transfer list to apply the overlay, so
+the boot stage that creates the transfer list must leave enough free space in
+it for a copy of the devicetree, with room for the overlay to grow it. A
+transfer list of 256 KiB is enough for the supplied configurations.
+
+Building
+~~~~~~~~
+
+Select the defconfig for the target board. For example, for Genio 720::
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ export KBUILD_OUTPUT=build
+   $ make mt8391_genio_720_evk_defconfig
+   $ make
+
+Use ``mt8371_genio_520_evk_defconfig`` instead for Genio 520.
+
+The EVKs have DIP switches and jumpers which connect either the eMMC or the
+UFS storage. The default devicetree is for eMMC. When the board is set up for
+UFS, select the UFS variant of the devicetree instead::
+
+   $ make DEVICE_TREE=mt8391-genio-720-evk-ufs
+
+Use ``DEVICE_TREE=mt8371-genio-520-evk-ufs`` for Genio 520.
+
+This produces ``build/u-boot.bin``, which is the BL33 image. The build also
+produces ``build/spl/u-boot-spl.bin``, which is not used in this boot chain.
+No external firmware is needed. Install ``u-boot.bin`` as BL33 as described
+by the platform firmware.
+
+U-Boot SPL
+----------
+
+U-Boot SPL can optionally replace the platform BL2::
+
+   BootROM
+     -> platform DDR loader
+     -> U-Boot SPL
+     -> Arm Trusted Firmware-A (BL31)
+     -> OP-TEE (BL32)
+     -> U-Boot proper (BL33)
+
+The BootROM loads a MediaTek image containing a platform DDR loader followed by
+U-Boot SPL. The DDR loader initializes DRAM, copies SPL to DRAM and enters it.
+SPL then reads a FIT image containing BL31, OP-TEE, U-Boot proper and the
+U-Boot control devicetree, and uses the standard FIT and Arm Trusted Firmware
+support to hand off to BL31.
+
+The DDR loader is a platform firmware component built separately from U-Boot
+and supplied to binman as an external blob.
+
+Boot storage
+~~~~~~~~~~~~
+
+The supplied configurations boot from eMMC. The BootROM loads ``mtk-boot.bin``
+from the eMMC boot0 hardware partition, and SPL loads ``bootloaders.img`` from
+GPT partition 1 of the eMMC user area. SPL selects the partition by number
+through ``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION``; it does not locate it
+by name.
+
+Make sure the DIP switches and jumpers are set for eMMC, and use the default
+devicetree.
+
+DDR-loader handoff contract
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The contract between the DDR loader and U-Boot SPL consists of a fixed image
+layout, initialized DRAM, a transfer list describing the DRAM, and the
+execution state at the SPL entry point. The BootROM loads the image payload to
+``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
+
+   offset 0                                     +----------------------+
+                                                | DDR loader           |
+                                                |                      |
+   offset CONFIG_MTK_GENIO_DDR_LOADER_SIZE      +----------------------+
+                                                | U-Boot SPL           |
+                                                | CONFIG_SPL_MAX_SIZE  |
+   image end                                    +----------------------+
+
+The supplied configurations use the following values:
+
+=====================================  ==============  ========
+Setting                                Value           Size
+=====================================  ==============  ========
+``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``    ``0x2001000``
+``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``   ``0xa0000``     640 KiB
+``CONFIG_SPL_MAX_SIZE``                ``0x40000``     256 KiB
+``CONFIG_SPL_TEXT_BASE``               ``0x40000000``
+``CONFIG_MTK_GENIO_BL31_LOAD_ADDR``    ``0x54601000``
+=====================================  ==============  ========
+
+The DDR loader must:
+
+* initialize and train DRAM,
+* copy the complete ``CONFIG_SPL_MAX_SIZE`` byte SPL region from
+  ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR + CONFIG_MTK_GENIO_DDR_LOADER_SIZE``
+  (``0x20a1000``) to ``CONFIG_SPL_TEXT_BASE``,
+* write the transfer list described in `DRAM description`_ to DRAM outside
+  the SPL region and the memory used by SPL and the images it loads,
+* leave the MMU and caches disabled, with all of its writes visible to the
+  CPU, and
+* enter SPL at ``CONFIG_SPL_TEXT_BASE`` in AArch64 EL3h with exceptions masked,
+  and with the transfer list in ``x0`` to ``x3`` following the transfer list
+  register convention.
+
+SPL passes the transfer list on in place to U-Boot proper, through the BL33
+entry point arguments that it gives to BL31.
+
+SPL obtains platform information from its embedded control devicetree and
+initializes the console, clocks, pinctrl, watchdog and eMMC through U-Boot
+drivers.
+
+The MT8189 BootROM loads at most about 930 KiB from eMMC boot0 and does not
+start a larger image. The loader and SPL regions together occupy 896 KiB,
+which leaves little room to enlarge either of them.
+
+The DDR loader runs from SRAM at the load address, and the SPL region stays in
+the same SRAM until the loader has copied it to DRAM. The loader's code, data,
+BSS and stack must therefore all stay below the SPL region, not only its
+binary image.
+
+Firmware image prerequisites
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following external binaries are required to assemble the complete
+firmware images:
+
+``ddr-loader.bin``
+   A MediaTek DDR loader which initializes the DRAM fitted to the target board
+   and satisfies the handoff contract above. The input may be shorter than the
+   configured loader region; binman pads it with zeros.
+
+``BL31``
+   The U-Boot build variable naming the Arm Trusted Firmware-A BL31 binary
+   built for the MT8189 platform. It is loaded and entered at
+   ``CONFIG_MTK_GENIO_BL31_LOAD_ADDR``.
+
+``TEE``
+   The U-Boot build variable naming the OP-TEE binary. A standard OP-TEE v1
+   ``tee.bin`` image is supported. Binman removes its header and derives the
+   load and entry addresses from it when creating the FIT.
+
+BL31 and OP-TEE must agree on the secure-memory layout. Place
+``ddr-loader.bin`` in a directory which can be passed to binman with
+``BINMAN_INDIRS``.
+
+Building
+~~~~~~~~
+
+Enable ``CONFIG_MTK_GENIO_BOOT_IMAGES`` to assemble the complete firmware
+images. For example, for Genio 720 with the DDR loader in
+``/path/to/firmware/ddr-loader.bin``::
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ export KBUILD_OUTPUT=build
+   $ export BL31=/path/to/bl31.bin
+   $ export TEE=/path/to/tee.bin
+   $ make mt8391_genio_720_evk_defconfig
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --enable MTK_GENIO_BOOT_IMAGES
+   $ make olddefconfig
+   $ make BINMAN_INDIRS=/path/to/firmware
+
+Use ``mt8371_genio_520_evk_defconfig`` instead for Genio 520. ``TEE`` must be
+set for both configuration and compilation. Do not deploy images if binman
+reports that it used fake or missing external blobs.
+
+Binman produces two deployable images and one intermediate payload in the
+build directory:
+
+``mtk-boot.bin``
+   A MediaTek eMMC image with load and entry address
+   ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``. It contains the DDR loader, padded to
+   ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by U-Boot SPL padded to
+   ``CONFIG_SPL_MAX_SIZE``.
+
+``mtk-boot-payload.bin``
+   The raw DDR-loader and SPL payload contained in ``mtk-boot.bin``, without
+   the MediaTek BootROM header. This is an intermediate input for external
+   MediaTek secure-boot tooling and must not be flashed directly.
+
+``bootloaders.img``
+   A FIT image containing BL31, U-Boot proper, OP-TEE and the U-Boot control
+   devicetree. Each component has a SHA-256 hash.
+
+The FIT can also be signed, as described for the Genio 510 and Genio 700 EVKs
+in :doc:`mt8188-genio-evk`.
+
+Installing
+~~~~~~~~~~
+
+Use the board provisioning tools to place the images as follows:
+
+===================  ================================================
+Image                Destination
+===================  ================================================
+``mtk-boot.bin``     Start of the eMMC boot0 hardware partition
+``bootloaders.img``  GPT partition 1 in the eMMC user area
+===================  ================================================
+
+For example, with `Genio Tools
+<https://genio.mediatek.com/doc/iot-yocto/latest/tools/genio-tools.html>`_ and
+a prebuilt Genio image for the target board::
+
+   $ genio-flash -P /path/to/genio-image \
+         mmc0boot0:/absolute/path/to/build/mtk-boot.bin \
+         bootloaders:/absolute/path/to/build/bootloaders.img
+
+Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
+the platform recovery path while testing.
+
+.. _`Firmware Handoff`: https://github.com/FirmwareHandoff/firmware_handoff

-- 
2.53.0

