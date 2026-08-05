Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9655C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 19:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 603A580D6A;
	Wed,  5 Aug 2026 19:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nA_zIGsNxTYy; Wed,  5 Aug 2026 19:20:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8470680D4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785957646;
	bh=zQvThufackjIj/HlxbMz7i9w03As47kccOISHsXyLSY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jcAueUcsc5zuBwpfvcPC1pK/Cy9ETEgMQ7AgmrOcGDVD/sVU9QGXuU7gHDNU16KVL
	 gyCctQ7Z94aqj8ZVFWVPmlqDRu4mV79P6NoofDDGdiBxuQpDYchGSQIHaIR0jTE6Kv
	 hrfo/ydlTaDZGGlxaQSFdkIsBW+aUncPqY0FFCF/eaEofEJjMg0PEj19AYnfFMflSW
	 JdwO7Ozr2k4Gl5HjifWuPSDkuKZuoqkA4iBUhpxO4QCjvvK4j93V1a55PAEHaMME0n
	 ZRDaOp8dLKKY8F2e/AyheE+NoVJBI4fyHKZAtW+9C5cdT1ojaBXCjs+TJZcMorxenE
	 UjojIjqpj3Qdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8470680D4B;
	Wed,  5 Aug 2026 19:20:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D8BC218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:20:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AF1C407AC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:20:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0LlPkOuRiuo for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 19:20:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1E449407A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E449407A9
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E449407A9
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:20:43 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4960fb63c75so894934b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 12:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957643; x=1786562443;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zQvThufackjIj/HlxbMz7i9w03As47kccOISHsXyLSY=;
 b=nhgL1dSC1wFLI+mEDICRR/b/34awhG+kOcTxwFcuFwdiF/uw0Ef2c2DXOaINeW/KST
 MXjuy0W/4PVT5yxEMRBHHXhBdHtlIYQpDAutrozj0oag9Pp+C0d/x+qkh3DEaXTuKCQK
 fCnYnScN6yC17eqdQkSFYvHlCiWP0TIqCBpjaz1YYpT+J2+GuwHBu1i/y2y9AE/7EFL3
 GN79zK/eI+9IJIQSbD2xVDzIHFj+OmmOksyb5kKcqbhLLj4kgstrqGhYZaJEGeE8GzPx
 ms7kQ3fTRJuNxYIwjwVK7RqTgaVRB0okzsM1D1bU94ZEmHhC5xa4NlH5HKF98UpP6Bdc
 q4Aw==
X-Gm-Message-State: AOJu0YyJJjscLzsgkgEnMUE0YJC2ZHGDey9POmJyfISH/3+85+gIw47D
 xrBT/avqB7IT7rN01meTRJordWUA7Wl3Jfnfp+PmuTx+llpjoovLSZ1VrrfrPxgXr1g=
X-Gm-Gg: AR+sD10M8WzJoMX7Xnibnpv+AAU9UcKaafyKFa+kAas3ipY8lWai+nSxk56yAU3zM5m
 uwTuiceTN9O7wc0nAhxkUqOvopgfDkxvANOyI0twDccuT4ea5L6P04JZHeD36y02GZqYfeti6M+
 AGKIvOObtKX1hJeGavqmEwiwDMBolk5LYQmqf9UJqmz4+WnQC4TAOEVzD73DITKEpuKjwIGBFLM
 mS2f3b0wT96j3SLHdudKvhzxyRLPpccxPaIreTKgno6F6ZTtNrXXxcpQRBOFxUBh+2ofVhHY82b
 1+BSF+Kg/fY3XWLQBQ2l5pSd2d909cGNfUtcdBHlzxVd2O2pqg/QuhxpShiBijV/Od7HgxpTjG4
 oaKYiue2AQiY3ezwyXwB1GgEP4FaE011IEX4gIYwOdn6RyBy+ItupZyZpyfX6jhbzGOQ7FLGibZ
 jMVZUZ6DT6HC9s7tT8xmUf0XWCggMe4Bdn9VPoIc9ux6gce3RNuBFAbNNC8KSUF0QUgw==
X-Received: by 2002:a05:6808:344c:b0:497:d3d6:6a56 with SMTP id
 5614622812f47-4afadbff918mr4528459b6e.0.1785957642822; 
 Wed, 05 Aug 2026 12:20:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ebef:9550:d591:36ac])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae4b2b68sm2755884b6e.5.2026.08.05.12.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:20:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 05 Aug 2026 14:20:34 -0500
Subject: [PATCH] phy: mtk-tphy: add v3 hardware support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-mtk-tphy-v3-v1-1-f1d6268b8d89@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwNT3dySbN2SgoxK3TJjXZPkpESLJAtLM9OkRCWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgDxV/RcbwAAAA==
X-Change-ID: 20260805-mtk-tphy-v3-4cba8b8965ba
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=h7ybyFr77rf/v9RtmBGjJhTryPidmQo44QYHtQJGXkk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqc40DWLtGzQZIQ+XHilBMJ38mRrTsG3noWhTPP
 IfgYisF90WJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanONAxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATsUH/jtyqGYMtEJxtDZ5ZztB1XdC1cSAPjgdKwc1oFb
 obwhCppE5YChtm+q/2ehaUm39irYJCTBHXYZ9DrCykprIDe+7KdXbxmq2KQv+eeDEkO2GDqAIBD
 r+W3dHkQFm9ct795ZyWxpbT1ndCmFn0TpCJvhhhTxSNAuyezBpqM4BghJRujg8RX+l5M+vVXamj
 NM7blwUvrN8ljfm2Ea20rLRiPgb5R1x2oA/KIJRdWf0+aU4lzI+5aioMtyyxYKGiHcqbb+jtftL
 Bftda3II12RX8VsBjL5VLYwZ2z+DYh1KlshCLphzJIqwuB0al9n3rY+rvWiVHyElhY6hxbjxh68
 T8MI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785957643; x=1786562443;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zQvThufackjIj/HlxbMz7i9w03As47kccOISHsXyLSY=;
 b=MU03ULQw5MRebhf0ywMT3gvoOp8h0JM9l4GtBWBOxR2Y+5Yy7Egmp1EopqCONPIw25
 RJ2ydeDErm1wqopLBH0JHllCpGF9KIk5OtzL7aQkuGSksWYaictNVyrwmHyL5nYznqoY
 i+er8vkiGUCTE9md+Xy/pwxjGVgwgv0+C3xuQniqAtfEbt2kabfA4vTQKaReE4CsTYha
 FxeH7lcGhWvkkwAR/bHayrIIA/IucbS0ZehAHch0CO6CuXUK9S3LkQNyd3QPUwAa9+YK
 8JBDBSajA0F8w7sglOket3FWOA9hes1JDEEP8P3Ymg35vJprFT0J1N87g3VIUSMbR24Y
 SA1g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MU03ULQw
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

Add devicetree compatible and match data for "mediatek,generic-tphy-v3"
in the MediaTek TPHY driver.

According to the Linux driver implementation, the only difference
between this and v2 is that v3 doesn't need to set slew rate. There is
one register write in the U-Boot driver that gets skipped because of
this now.

Also, according to the upstream devicetree bindings, mt8195 is also
v3 TPHY, so it gets updated as well.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/phy/phy-mtk-tphy.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-mtk-tphy.c b/drivers/phy/phy-mtk-tphy.c
index 0a45dc58629..05172f220e6 100644
--- a/drivers/phy/phy-mtk-tphy.c
+++ b/drivers/phy/phy-mtk-tphy.c
@@ -228,6 +228,7 @@
 enum mtk_phy_version {
 	MTK_TPHY_V1 = 1,
 	MTK_TPHY_V2,
+	MTK_TPHY_V3,
 };
 
 struct tphy_pdata {
@@ -331,9 +332,10 @@ static void u2_phy_instance_init(struct mtk_tphy *tphy,
 			FIELD_PREP(PA6_RG_U2_SQTH, 2));
 
 	/* set HS slew rate */
-	clrsetbits_le32(u2_banks->com + U3P_USBPHYACR5,
-			PA5_RG_U2_HSTX_SRCTRL,
-			FIELD_PREP(PA5_RG_U2_HSTX_SRCTRL, 4));
+	if (tphy->pdata->version < MTK_TPHY_V3)
+		clrsetbits_le32(u2_banks->com + U3P_USBPHYACR5,
+				PA5_RG_U2_HSTX_SRCTRL,
+				FIELD_PREP(PA5_RG_U2_HSTX_SRCTRL, 4));
 
 	u2_phy_pll_26m_set(tphy, instance);
 
@@ -813,6 +815,7 @@ static int mtk_phy_xlate(struct phy *phy,
 		phy_v1_banks_init(tphy, instance);
 		break;
 	case MTK_TPHY_V2:
+	case MTK_TPHY_V3:
 		phy_v2_banks_init(tphy, instance);
 		break;
 	default:
@@ -900,8 +903,12 @@ static struct tphy_pdata tphy_v2_pdata = {
 	.version = MTK_TPHY_V2,
 };
 
+static struct tphy_pdata tphy_v3_pdata = {
+	.version = MTK_TPHY_V3,
+};
+
 static struct tphy_pdata mt8195_pdata = {
-	.version = MTK_TPHY_V2,
+	.version = MTK_TPHY_V3,
 	.sw_pll_48m_to_26m = true,
 };
 
@@ -914,6 +921,10 @@ static const struct udevice_id mtk_tphy_id_table[] = {
 		.compatible = "mediatek,generic-tphy-v2",
 		.data = (ulong)&tphy_v2_pdata,
 	},
+	{
+		.compatible = "mediatek,generic-tphy-v3",
+		.data = (ulong)&tphy_v3_pdata,
+	},
 	{
 		.compatible = "mediatek,mt8195-tphy",
 		.data = (ulong)&mt8195_pdata,

---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260805-mtk-tphy-v3-4cba8b8965ba

Best regards,
--  
David Lechner <dlechner@baylibre.com>

