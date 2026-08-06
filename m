Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A11BC5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 386A160857;
	Thu,  6 Aug 2026 23:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LIMMkQUckGIr; Thu,  6 Aug 2026 23:40:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB545607E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059642;
	bh=kniHs1hL4uE1Zq0umbaggyAIhgLF7X3iEj9/lWGEYNE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HD3Aq0jhlVyyUPKc6ynvvQYCVH8uj0v5cjgguIMk9GC2PB3hJcZSs4+moenpW0mkY
	 cItNVjwxhVBIz/eKwlSFPp5iMudGuQ3qBgti0ymCZSLgKgVjer1ZuxsqGYnmT6ZOBU
	 lQBW6nLHzALMguboRE3cNxs83Qe9DYEZqhMX7I/7cpTJfhgP73e2G16EpCW+JOBX2z
	 L6zRngSUnzSuGPkpDYRC5KiVe6MXXl6l+NrQqcpWhldhSbRZu/Ok1hn0q7Hr4MZZqt
	 khHJ2xDTh6d61+xutb9QUiZ+14TU9GXormERf0Z2NdqwXktKTZYpTowfSiQU/BSd1R
	 4Mzx1SNBFBM4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB545607E5;
	Thu,  6 Aug 2026 23:40:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 68328392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E0544090C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I4P2nDhLmuZ2 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:40:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C297640909
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C297640909
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C297640909
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:40:38 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-458de93b53fso1347135fac.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 16:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786059637; x=1786664437;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kniHs1hL4uE1Zq0umbaggyAIhgLF7X3iEj9/lWGEYNE=;
 b=CqzWdiL7NhTre5ukhvhI/3R3M33NagM1zD5/NeBBBgS+UUibJn2v+XUiZzwh06CZPP
 iCUAWOiVsOT3jvb3zUc8rxhDPLn89DvQWu1pCxh5xqlLtydFVAD9QYQnCK40S+yxJVeR
 WeK0uSLGIySbHdOwsQbSCOvXXzSVl/GWpMFhDe24fElmFVZ62xTIQsHb7wqDT4MxuhH5
 pzGvhb127FYxJCSdY+uLVFu7Ky3YEKMxkzh+wUkz905Hsa1m5fonXuuiV3DDdXk9fK5+
 7VBmTABAjsIXVL6BKGDw1OZfydDMtT+pC+KHrHY6qT8dkt117q5UkDndcF5a6Gwe4U3f
 nIlg==
X-Gm-Message-State: AOJu0Ywq49RbVIar5zvKaOZ1MgOI4ydKvSDaoR20Ml++un8vETIVEG9E
 cUjOUdGFWAX10G8FGWY6Run5p6H6tenxsiGjxEVGffOabnLx2Z7j0TX1EgZ9dopFsvVlL4C85ZB
 I3W2NY7o=
X-Gm-Gg: AR+sD12O1fXWZt83PupMhtjCV+OVQX7zFYJHLC4TnYebwcwHeSZ88AQRu/vkKU89y2q
 IVjbrpwfr4rr9HMxMmxkMNlddWVM0JyHM3aWqFDDTMnIxpL5mgg8S93y9nV8eLGe7YC3GHzJ1Q+
 hSjM2N3dwVsBIc1q8DO6vBwz8IKIlTqVMmP/pvgyf4w1ZOpRojeeP9Oc+o4JcDnIAnXi4BmZz2I
 2melnjCis70Gv0NkO3Ki2FzyU7X9Lgi8hpObzzHCVlcneH2CuPkeAZNxeaR+H4gx72BG9Fom0JN
 F0UtzN7cg+VDma+8mN7arhhonybipkc2JM8hd8IS1/Wpv9i9WCl1Lvkup8O6TmMDVx8ngOyUttz
 mV1SgDIuyIx8JrHmUR6iIDXBueTiSHoRoxky0HfmrZVmwOPChK+WK0tC/KA6lUvvtZFlJxsilQz
 kPaefOqTTpXGUP9Ez5UqB9QWffs+M2pDJABh0I3azeXoiQ49H79f4jKBB8V2DC729xOz+iMIPSU
 taP
X-Received: by 2002:a05:6870:8256:b0:417:4693:ca0 with SMTP id
 586e51a60fabf-4599ee2346dmr9839795fac.14.1786059637307; 
 Thu, 06 Aug 2026 16:40:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:beb1:8dd1:72b8:350d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm800448fac.5.2026.08.06.16.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:40:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Aug 2026 18:40:19 -0500
Subject: [PATCH] spi: mtk_snor: combine mt8188 and mt8189 into
 mediatek,mt8186-nor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mtk-snor-fallback-compatible-v1-1-74559b491b4a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw6CMBAA0KuQWTtJhYifqxgXbZ3RkdKSTjUmh
 LtbcPk2bwalLKRwaWbI9BGVFCv2uwb808YHodyroTVtb06mx7EMqDFlZBuCs35An8bJFnGB8HD
 sOk/M7swWajFlYvlu/fX2t77di3xZT1iWH+tKVruAAAAA
X-Change-ID: 20260806-mtk-snor-fallback-compatible-5733ceffb9fa
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2jwDljmlZfaM8hKbsCHfQXVaA1KY2HjjwlsJOcDDKmw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdRtsFiA7t/zL6quH0rZVeah6WKCDINApoEa6b
 Y7dQlRQ1wSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanUbbBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AAuoIAJRVybuDjEXngEXdCRAz6lg553OVFou8g8AlaxK
 QgeNqSxch83Ttk7D1TJpK2cAVT6vHso4z5XE1j7sm9L1ANM56lEtSiAooduHGZ6WWncL6icvdrw
 SNhc9ShP92Zs7n7W4vI2fur/Y3nRwqtKbGR1gOHwIA550/6VS1g6AEDUh10f7UAsNCFNkbRboJL
 9//GqkmZGUCinJbv+IgFuNYLEAjckUjrO5hy+rgCsg7U7kj6JN9Ub0GLnMICpft3LCfNeSxcDph
 FhbJ4ql3xyGVfUMZuwb5N9KKfV1AvCkqwFnDbKDsINLiZcNBh16QrqSsISJO8HSMg+x2MPEH2BH
 fBG0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786059637; x=1786664437;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kniHs1hL4uE1Zq0umbaggyAIhgLF7X3iEj9/lWGEYNE=;
 b=ay4SFQ/Ri5Pbv4mdOOe3ENms7sE45ggWehBNbvECbSSVZns6naBlrQuH16/XzbbLAH
 asuSH9TnjrkXU3KtnHk1HyCFuJIk29EOZbwu03b+C2bzpygAGf69Egw1WWLAYiVNKiXj
 VCs5QIzv3X0ApGtdYa1yvTu59NVBO0qT/0PP0oJ14kfencvFomPpj3xeeNYv7Ly4vN4b
 BbktdlNLgmszq5ZqQuIgxs2WGqyQxnAU0nCeJ4AYXhxRvpilanzJLaUFHeXMNV76lnxC
 ihajaWTz4ilLHovp4wWVfGzdsS3nN/eoP4+IbcOaNwONt1aXcVEPFmPy6YhAIUi4g6sn
 O3Gg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ay4SFQ/R
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

Replace "mediatek,mt8188-nor" and "mediatek,mt8189-nor" with
"mediatek,mt8186-nor" in the mtk_snor driver. Both of these have
"mediatek,mt8186-nor" as a fallback, so we can use that instead of
adding each new compatible when we add more similar SoCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/mtk_snor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index 40fc1826db6..95bd8f06eb9 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -607,8 +607,7 @@ static const struct mtk_snor_caps mtk_snor_caps_extra_bit = {
 
 static const struct udevice_id mtk_snor_ids[] = {
 	{ .compatible = "mediatek,mtk-snor", .data = (ulong)&mtk_snor_caps_default },
-	{ .compatible = "mediatek,mt8188-nor", .data = (ulong)&mtk_snor_caps_extra_bit },
-	{ .compatible = "mediatek,mt8189-nor", .data = (ulong)&mtk_snor_caps_extra_bit },
+	{ .compatible = "mediatek,mt8186-nor", .data = (ulong)&mtk_snor_caps_extra_bit },
 	{ .compatible = "mediatek,mt8195-nor", .data = (ulong)&mtk_snor_caps_default },
 	{}
 };

---
base-commit: 24ecb168a113c9de96c172086bc357597a8d1e6e
change-id: 20260806-mtk-snor-fallback-compatible-5733ceffb9fa

Best regards,
--  
David Lechner <dlechner@baylibre.com>

