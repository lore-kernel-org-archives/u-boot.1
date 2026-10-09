Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598FFCA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21577608D4;
	Fri,  9 Oct 2026 16:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4e0c3UnLWRxK; Fri,  9 Oct 2026 16:16:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 481BA608D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562563;
	b=H+sOOWxlCK0NFjqPXyRP21jAGuTJzktDi1O+QjQ575MdinhPO3zoXUtSlzzS7+Agczg0
	 uAkwv3UKm5OWiyfmYCIDarDVVsGdOh6dW1vm61h3wZeW2oQO9lgpxBF/uLvGqhdoP7pXI
	 U2rbgvFskcJa3deCmecfs1ccVbjmjepRsBKlaat76X5WBGsfj+xiDeJm+c6yuRMUeocRX
	 yK0k2Gkudl/hslTuo2z1Ze6HRWYSvEsIofb2DSonkcDuucbSzwRPxORLhdWkBYs7MJugY
	 8mKEDc8mqyfYt+xwManFMKEBc3D1e5TPFs6H99dO81v1tqqcpOZcwXdr1sR8eXkusjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ShnBQEoUl45QyoPK2gNfXSaJeRsko48jmDBdBIFHcAw=;
	b=e77ujZYt95FLWrrnd1FXy3chOBeqFFEQ66fiA5nHQxEAELzs9SxJ67sclB5SKI1biLfc
	 IfbxVyGj4hEG5yWAVzQZfEE51egOXQP569bIvbyO4K9FAVElY6OKAwY5opBvIbhvxZkhL
	 CSSNFjF9J2RGZjK7xqcI2RSJQdo1rII22soakqH20JltiHpjyAbkmnb8rIGnzZCXpAL6D
	 XIP/xyX2vnLeTQFtfhge3QLBcpPGYFb2Lr9uZMzrYr0NusSaplvCdHyqEWfo1ARLaiNQ/
	 D5IbzH71C7HOMj6sZqj2Ioij1vcCD/ZcMAnPKsdgobhZVL2SljbebEA98QFQAqRiDGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562563;
	bh=ShnBQEoUl45QyoPK2gNfXSaJeRsko48jmDBdBIFHcAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yV5PHRVcfNIon1OK8ZBXHrA/dDICCcMx8lyMQrI3+2Cxkau9CnqGBhG7p2k/5CfNC
	 PkZOWFPOpskK1SpF22iFCQqj+5HPXjxEiuAblwvlUAe6QEQIEDV182T4ichjIj4Qgg
	 1aaAPJN05WU+fGUQDsvHqXFOMnlKA00a0ha3j84qaTD/fSJeWsS6YVqDhDL1+othvc
	 E8wG5Xmylg2lpMmIkyyeiUobZf8vFgtGx663tBx38Eidi7XUZsDKtFUKV2jNbNtdhv
	 Ek450K09Lwc4o+Ithhf0tcsbP2N5koABoY/FLu8U+eKfxh35i2+S+0rm8h910HjrdA
	 jN3otTXduLbQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 481BA608D5;
	Fri,  9 Oct 2026 16:16:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AAAC422
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C9E581412
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ETJawLJM3pBj for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93BA481416
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562559;
 b=Zj4fVnAIQAsx712AQuChW91AlD9+CLnIX4n4d4EH2qngdAwPfGdY7zhvJuCHWs/IQCsu
 Kk2Fl1B07oYek8ceQVgpuyH4VpnV9PE54sDCmf4tyBI1IpQ6zcPbRsqoToWYQecqJXmW5
 dZG7idDjyyKAIoUVpqqSjUgjyn5aNqLJ3ysdqGDJW4t0fmXtGMKKquLrtjB+wchPWg5+Q
 PoARMElhmNgkTHFt6P8VrqMdEDe+RxEhZ+HICaj7cauX0Ww+ddpqjw30YRaryRfR0vDS9
 iJPNOS5m/e6YpnwibVH1sye/zdIp74CI+UxpQpe6n+9SBORZSVD2yttDNgDwr2J9oLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ShnBQEoUl45QyoPK2gNfXSaJeRsko48jmDBdBIFHcAw=;
 b=S6MNamQYNK9asaGllzi8AyqpeWZb+h2I4ImUCDctAd4YhL2xtaFp+WR3buQyh6PMCFlN
 ehysARkx7YG+qrcqcQvHo0HY5eobRFiY+ykTK1vke3T5wtoxP0o9qAs2w9UjTA+Sqfadw
 1x9f3oLO1iLZo17dHGBQJH7mp9t23e2zNMCsoftGY4EmQRpL/kPUkgBLThHM/4wbsNwKI
 9Nt0CTN1XZt45GhmFlGe3vfGJQzV1axl5eMCGwFKE5TA3kKWKbPUTsKaFYEX8LViI7uO5
 Mj8W7bXI7FeE81iyZDu02FeVHl/4WoxIpdra6EWuWaa/2h0vtgPgGx3a15NIcurNJNw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=S7HqW4cO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=S7HqW4cO
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93BA481416
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:59 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4a451915d8aso4042059b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562558; x=1792167358;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ShnBQEoUl45QyoPK2gNfXSaJeRsko48jmDBdBIFHcAw=;
 b=S7HqW4cOuzEHyug6oRwv0k8w+F2DkO9jVt4f8suxCGnGnCUuI280yXXm/CgLJGWgji
 Df71Y28S22zVn+r2il50xr8giisiCU1HhdmleFpoUhF+cPegFFFE1ZTrWjJlnh0xz/YM
 sfx/Fhrr9kQ+v3/pZYHboba13Qd5+ORcuIQZHG+TJSuCLevHhz8e0TPin5KOoajkLcwL
 0l99nDx6TslYSEl7IePGQAcTVyi0Ji1Y9s4jRKHmk30X21sWOZpRAygB1gMuX23jjl/R
 hgpDHxtZkRnyJ1rrjL8BvWdHbmRQrMEjSiW6h6J7fGKXYnMSUsPvpiUej5e7bueQ01rj
 a7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562558; x=1792167358;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ShnBQEoUl45QyoPK2gNfXSaJeRsko48jmDBdBIFHcAw=;
 b=MmZrWezfYUMVSlXRCVBiTFbWDQeOy2FXn9oTaMky3hWqbqJVq+Qq7EvIBjhLURu0oB
 jjoe7t4g7BQgWX82mlNmWJBZQ2BNIpSSHMm3TkgubPelDmQ6jlNHxtF4LPiKRocnj+a4
 AzCoByr1aZqJ4tFp6K+0+Cpift7z8EOPy+nWmgghJqp93zg/y7ZhLl1wxx6SvEA9A2zY
 B3g58aZTih1CeWCXbt4G4tmejQqEz3NGMvy71udecpCm0QRlJsBKZaluUXDpF1S1FaZt
 T3d8AoQ9r+08UE97ERyTDMfGPMX7/eZhjXVz8ArVbI4XBVxc7DIDKED+wv3QEvFRHMv8
 ieOw==
X-Gm-Message-State: AFuF++kr8GnUgfSByBJg9hhNNtz9Z9jlvEMr6KaeRVo9cgY2dSM5D3tB
 gxQywT8N9umNd+qcOncKu7Sczpar+ursr4t9JX9MXcgvv/Ry0xPJXhVFfdm9p4zwrnQ=
X-Gm-Gg: AYBFou3on0rr5YqZ0Bp+IHJ/poxtyQN+Gxng0Ddr1cDjQVzKfZJ14QqAccmgyxP3Ozn
 tgzONfml8f/YUsRsWsK66fNdDRwiulFX8jxF9ednfpNm8TNf87VUt+Umb3p702zTZz1LzBKWGTS
 g3J0klMqWWYxDSZ7YrHRASNJb2UYmzNJC6h4FSxhYgY1ba22TuZUZWl6UI7az9jyipBZoDdOLO3
 1DENX428IaE691h8EiKJN9Jk9VSE8VbKmRE7MhoQF0ZnRLf+BAml8Fgadrg9xZfuIECj+cpjw+h
 tQcTCREkeBgqRunIR154NfmL+P9wnsgHRI78+MelUVLGmfN0+QJbfdJVp0Yu+zZgbxZGS1UHou4
 ivKgSeobf03vdGMWxOwq8ALkhxwPpB3U5zLQ31WfGDBxMg48mBYp5aLZUEIQ0VZvfDAxsbS+t5V
 XbNe4TuwgaSQF/OTvKFomVxT/k3S614XhQP+PZIDLl963keL1aelZ99m6WK1ABguLIdQNaW2YUT
 sg=
X-Received: by 2002:a05:6808:50a5:b0:4e8:2150:299 with SMTP id
 5614622812f47-50c50f2ea06mr2159961b6e.23.1791562558229; 
 Fri, 09 Oct 2026 09:15:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:15:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:08 -0500
Subject: [PATCH 05/13] video: mediatek: mtk_ddp: allow routing the OVL
 output to DVO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-5-4fbcf5b2904d@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3557; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QX8C2JO6OVKXJYkd2MR3xKDeGXJR9cA+XAAFZQNpefU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRLzWvnty/9HGkpcgaPgoTY6kcOjAUEU+Xo87
 y/PLgJxn36JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskS8xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AhHkH/R4EkFqSa+0+bxoxvlXPDl7GTEQiWOYzSJgHf0k
 rB7SmIbTxGmvgu/uNaBKTk06ZhDtLxnRiNjxqncTZFibMMT68dIj0L/m3yg3T8EvudtcsJajpQs
 3+OAowb9Lr82HDABdkLRVhgGMy6B8PBRHcpTznYR/5tTvv+EysugFGtXYzboMINGL383vHl5Opu
 8A8ZG7llHU7GOsNFsvbrQCc4uCS4tU/3VvHOMMp8QldscPk+t90pdEuEarWXe0ZvlfiSneMdrCF
 jeuIkShj9kLtlWh5BhY3/xdKjiXKVOzEDtJ62UjtOJn8+Khi4DR/U/9bMmlR3teQE9HQuabvtPt
 Ch88=
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

Add mt8366_ddp_ovl_to_dvo(), so the DVO output stage can be driven by
the same pipeline as the DSI. The path that feeds DSI0 from OVL0 via
RDMA0 and the output crossbar is the same all the way to the crossbar
for any sink; only the crossbar's MOUT selector differs, so factor it out
with the sink as a parameter.

The MT8189 crossbar shares the MT8366 layout, including the DVO0
selector.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/video/mediatek/mtk_ddp.c | 24 ++++++++++++++++++++----
 drivers/video/mediatek/mtk_ddp.h |  9 +++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/video/mediatek/mtk_ddp.c b/drivers/video/mediatek/mtk_ddp.c
index 246e6615fa0..5eaf25dca3d 100644
--- a/drivers/video/mediatek/mtk_ddp.c
+++ b/drivers/video/mediatek/mtk_ddp.c
@@ -66,6 +66,7 @@
 #define MT8366_COMP_OUT_CROSSBAR4_MOUT_EN		0xd80
 #define MT8366_COMP_OUT_CROSSBAR_MOUT_MASK			GENMASK(5, 0)
 #define MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_DISP_DSI0		BIT(0)
+#define MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_DISP_DVO0		BIT(1)
 
 static void mtk_ddp_mask(void __iomem *base, u32 offset, u32 val, u32 mask)
 {
@@ -97,7 +98,11 @@ void mt8365_ddp_ovl_to_dsi(void __iomem *mmsys_base)
 		     MT8365_DSI0_SEL_IN_DITHER, MT8365_DISP_MS_IN_OUT_MASK);
 }
 
-void mt8366_ddp_ovl_to_dsi(void __iomem *mmsys_base)
+/*
+ * OVL0 -> RDMA0 -> COMP_OUT_CROSSBAR4 -> @sink, where @sink is one of the
+ * MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_* bits.
+ */
+static void mt8366_ddp_ovl_to_crossbar4(void __iomem *mmsys_base, u32 sink)
 {
 	/* OVL0 -> RDMA0 */
 	mtk_ddp_mask(mmsys_base, MT8366_DISP_OVL0_BGCLR_MOUT_EN,
@@ -109,14 +114,25 @@ void mt8366_ddp_ovl_to_dsi(void __iomem *mmsys_base)
 		     MT8366_SEL_IN_DISP_RDMA0_FROM_DISP_OVL0_OUT0_MOUT,
 		     MT8366_DISP_RDMA_SEL_IN_MASK);
 
-	/* RDMA0 -> COMP_OUT_CROSSBAR4 -> DSI0 */
+	/* RDMA0 -> COMP_OUT_CROSSBAR4 -> sink */
 	mtk_ddp_mask(mmsys_base, MT8366_DISP_RDMA0_RSZ0_SOUT_SEL,
 		     MT8366_SOUT_DISP_RDMA0_RSZ0_TO_OVL_PQ_OUT_CROSSBAR1,
 		     MT8366_OVL_PQ_OUT_CROSSBAR_MOUT_MASK);
 	mtk_ddp_mask(mmsys_base, MT8366_OVL_PQ_OUT_CROSSBAR1_MOUT_EN,
 		     MT8366_MOUT_OVL_PQ_OUT_CROSSBAR1_TO_COMP_OUT_CROSSBAR4,
 		     MT8366_OVL_PQ_OUT_CROSSBAR_MOUT_MASK);
-	mtk_ddp_mask(mmsys_base, MT8366_COMP_OUT_CROSSBAR4_MOUT_EN,
-		     MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_DISP_DSI0,
+	mtk_ddp_mask(mmsys_base, MT8366_COMP_OUT_CROSSBAR4_MOUT_EN, sink,
 		     MT8366_COMP_OUT_CROSSBAR_MOUT_MASK);
 }
+
+void mt8366_ddp_ovl_to_dsi(void __iomem *mmsys_base)
+{
+	mt8366_ddp_ovl_to_crossbar4(mmsys_base,
+				    MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_DISP_DSI0);
+}
+
+void mt8366_ddp_ovl_to_dvo(void __iomem *mmsys_base)
+{
+	mt8366_ddp_ovl_to_crossbar4(mmsys_base,
+				    MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_DISP_DVO0);
+}
diff --git a/drivers/video/mediatek/mtk_ddp.h b/drivers/video/mediatek/mtk_ddp.h
index f7efbd64cae..9d557d2c34c 100644
--- a/drivers/video/mediatek/mtk_ddp.h
+++ b/drivers/video/mediatek/mtk_ddp.h
@@ -27,4 +27,13 @@ void mt8365_ddp_ovl_to_dsi(void __iomem *mmsys_base);
  */
 void mt8366_ddp_ovl_to_dsi(void __iomem *mmsys_base);
 
+/**
+ * mt8366_ddp_ovl_to_dvo() - route the MT8366 mmsys muxes from the OVL to the DVO
+ * @mmsys_base: mmsys config register window
+ *
+ * Take the mt8366_ddp_ovl_to_dsi() path up to the output crossbar, which
+ * selects the DVO instead of the DSI.
+ */
+void mt8366_ddp_ovl_to_dvo(void __iomem *mmsys_base);
+
 #endif /* _MTK_DDP_H */

-- 
2.53.0

