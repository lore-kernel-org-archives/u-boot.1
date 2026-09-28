Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15396CA5FA7
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDF1E80EAF;
	Mon, 28 Sep 2026 15:06:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hUw2H08UitE9; Mon, 28 Sep 2026 15:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 449E180E4D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608005;
	b=RS/Z/lUMmMugoJb4FXSIknA73imY52CVy+aQWea0PHNHbRst2QaqCmfWNrKTyNHSgNB+
	 LfkIx1qYRw36XI9HTVWZPESQ35zv8ncYT9bkNvDs0AtFKIlxlTmen8pkXpc8EIMW6tLZp
	 YGEuHoKPQVkaqWPGLZ2u6BchkY6JaX1szQcX0jfepgt6vF1xm8i5OBc3uFY6gw+rvJkBd
	 zP+f0LSQJfZSbUV9jzyhUpzrSVoH/FbkH1VDGes54pZ6RZ8SfIOGAW6EoDI+IQR680s8Q
	 /WjI/wuI3r5qFo+fwPeYs4OHWtiIr2whDDZXS5FChJZboUjdJqp+e1NceT9QyIxgZdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608005;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=c4vPrr2fVBuyxy2lsyfUV8oojrGrkdiaFQBLLLG+apg=;
	b=riqEUyUoAPvNNPRGUG2id4eAyVtEELbr2Is4WWoWFezhNlj5DG0NlCSp6WL5zmaNBNQO
	 8oJ1qaWxlCBe+2vFwt5uaTp3xryMI4oe2EAjtOQggjkf26tlqE7qlHfbAtRBgJf2rgmCP
	 Km7JqsMqksZducSpWVDEwK1WGAPuzjmLkbCmho8K4ACW9Ufo8WsSMODjRfi/irAGSS9Yf
	 KG6MsZdrF9MqNbz/EkS7xBcgHlhcUcL2BYbNNa1/N3XmlhZewUOdlJRHYARChHsXK19J/
	 TDMpWblNyhmzNijG1MajzbXbtq/V+m4XV0VqxAYqenG857Ls8+KEU0FZNJtYfbmQ98A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608005;
	bh=c4vPrr2fVBuyxy2lsyfUV8oojrGrkdiaFQBLLLG+apg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ziotJn4pm8drFPk94ws9ER/kFGbbF9R6Z8wAB8EBJ+F05XXLpITORUrMXY5TmBpN6
	 7E9dpDCX3aRTDpyNGKzIRw+F6r48mR5wDza4tvHCOPwF9MgsyidVWSLGq+gikfVSeA
	 APS6WdFsQjT8+I0AtYyrODi89Wqo46s1T06samfV6MAkVdPOorOr73QRjXO+6uI/qp
	 w8UVFzM5/Axwc2Ty+GF1E6TUZvkX/Fw2R5PNVjsdYAeFIcnvfZDzVGhZwu4767JJt5
	 cvEgtqYOND95n0++s9CBaRYP/glS5z/jxpaYWPGB9CJGdzSQDiYe9XdxNkhzkqIMnF
	 WmbCHgFQT2ktA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 449E180E4D;
	Mon, 28 Sep 2026 15:06:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD12B24E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C97E140675
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8LsTMNyVl2CE for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:06:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 36120405E8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608002;
 b=ZXlJrW8FfARFJLeJ2XLcqp7jCFGsZEiQUBOvqcu09rEzlB1DZfhuN8u6Fa7g759Izok/
 Zv0nP3VB5wNibhlxuZX7kvGzkFCTgaa9WOpkx7WnzUgMcA7BHSCoPSfqm1/hx84OyDzYH
 jtF4swC3LUAA+ssysqanzwrmbp03cfbbElTV8afrkRf5M8AAIW7nN4W9piE6dIJGvFmJ8
 BmWBRQF/KcS3cDZHv0+dkUGuq1GR/fh7xulMElDU3pUfmMDYn4WYKJz/a/j7paJ/4s82o
 ao/Vb60ukl9jbeJobOGGnA28M6DEIHBGbZFriSHYVB0WpXAVHXXH4Qh89HzRuf1HclQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608002;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=c4vPrr2fVBuyxy2lsyfUV8oojrGrkdiaFQBLLLG+apg=;
 b=OOfL6RDFnD4IAojz9fDCO4sJyS/XI45ehWi+j6ixmRCNu4LPXQGOcu3hpvtG71whrieP
 Hesj6edjZcvkqpMmFLiFw4+wOw48BdejVFj2yoSHVeZDjOfX2JCH2daLVTv/FdFbn5L26
 SOFl/KRnYcoNO2IAf8G+n0qmdPjV5NsQyDIZ52WSc15X9mnVX2dVjY6cc/HhOrJ9ybqtb
 q89zAjExJnRhj1pwtez48icPW0jHAeJ1pA95nDh2HbqnRXog0tysozhmMw1xc0REcFOAD
 UBfridLoSoJla2n4x/yAYEdEK6F6qgTSpZQX3eZAkpaL3/UGp6hKbQUKGG1lGGBPQXw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ix+rizWw; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ix+rizWw
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36120405E8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:41 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so17397685e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790607999; x=1791212799;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c4vPrr2fVBuyxy2lsyfUV8oojrGrkdiaFQBLLLG+apg=;
 b=Ix+rizWw/30xKR4qZrPxvvgOjtRzo9+jKOcbgPmFRFRPrsfHEVtsEGOaw/vpOm6nMr
 jy7vVH34Kwv3iAp3XTpAcOdXNQKWdJ+ex5aLALVNRCiJwHbfDax/IVFaUyoKvjHf3ESF
 Y42VOLlHpi+ebTvQF4GK5flqHqsi+H703NcugRaPwRIKKKRYwHAKvWwpm2q2SadLZ323
 puUby6x0h35cOBCqt7HY0JMEOfgTQ9JrcpjuL9oVzNtPmf8idSmJ8u128B3Tr7iZOH49
 MekvkeJXtLDPkd0fDrNOK3ilHYZ1tRRsBavzUhAt6jW+eqbHAu5KPbmB0beqWv99kfti
 ANgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607999; x=1791212799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c4vPrr2fVBuyxy2lsyfUV8oojrGrkdiaFQBLLLG+apg=;
 b=j8571Yve476hPhrLT5Vz4AH6idfVI05ph+iyszlyZ+065GE3JZ+Q0vnn+pkFoZPab5
 5nYoe77xOejNeWGzaREwjExEDWV1C0XTAod19tp7SxUNMnRV3toEJ75nZS+2DwEAvhQc
 vp1GIlErzO7qZ8NnATe4n5LVB7jqPKAwr/Yrj63z0gOcCci+tqH3zmpouRf8yltQkeYy
 kNrI3nbxmYa4wgNfXtRl3yBeGf9sDSd2/g1fzbT8Vhh/6kksO620seFqkF4s0I7VsTGS
 Ltc1jM97ZdUKEGPBMOAN2de3ZV7ZRos38sdn6keiH7mXjfa++0BH2hC2GBWLtMMt//sD
 7nNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVmO050Q/EFnrnzSKWfb/UOrCLzyISo2JGVMEmiHgM2QY5MuS0xVARLuSqwZFV4kLPFNrpmh4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n+iP3TOq8lV3q2dTN8ikBFIxlL3ufr4lElK09bhQrpS3sGm1RT
 ilUBNTa2xdAFni2kfAah9uw2ASaFnSKxgeXc4wo26zDwrpajtUYvFY21A6lWA5x25Ek=
X-Gm-Gg: AYBFou1Ok49TxbxSUGaipAYUbvOSPBJCrhv+n8LGjRgLxUadCB1cf82CabLhkp1p6hp
 3S0oFKBFmYHSCx4ECKp9EGRhz1mXixF8xtXhrRIPr/Skw50rt4koBfBUWzBTj0Pgl6xOPBrBVu7
 RafmQcDE70HrtCrYIt8D8Iaz9j40UZMSld9vWHAzK5FrnmtvH+ud1iD+TMmFGhSv+xIbF/VNNUm
 uFWw3RkJ6R6UM4PMTtksPOcECPxtR1thBvgoJUqC+khEIRZ9oRPYbXRFFqRQoav7wjxT3Mh09Ui
 IigAUweTvpGkQqGNfHnFdS8dZ7amCRo/mT305hYj5FVCM7I/I+qAFaT9MAFb2u8cwwYSIDooJbw
 TRmFHti5seN5TXi+SZoZdT58KXBzgqlY4ABT0gnV3Eb0jcjEZWfcOuLdW7t0VOr/1XRYbMqU6Za
 KFCwR3mYX3XKVNzh+J0NIxW8/Kewdv7/HgHbq41ofI+2xCObWG6WhIwbO+cXOmnpfcCTJMo3wXu
 lPCNfh3sAymtTRtnJWkGYWGFHXg+qOPCIbs3hVbHW4V/Z3nONo6rZa97AmOC1Un11AoVQpq23HB
 iA4nAis8xm2OOB9BR0Q9/1Fuz9hBdXI84DUkIE+1O4rg/ZV40ibR7naZtRs8kMonOJw=
X-Received: by 2002:a05:600c:4e90:b0:49f:bd0d:59f5 with SMTP id
 5b1f17b1804b1-49ff06e506dmr167323835e9.18.1790607999228; 
 Mon, 28 Sep 2026 08:06:39 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:06:38 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:39 +0200
Subject: [PATCH 02/13] video: mediatek: add ovl component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-2-212f51b1742b@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

The overlay (ovl) is the entry point of the video pipeline on some
MediaTek SoCs, such as the MT8365 and the MT8366: it reads the layers
from DRAM and blends them into the stream handed to the rest of the
pipeline.

U-Boot only ever shows one framebuffer, so the driver configures layer 0
with the XRGB8888 framebuffer of the video uclass, blended over an
opaque black background, and leaves the other layers off.

The overlay is also a DMA master, so it needs the SMI larb feeding it
and its port taken out of the IOMMU translated address space, U-Boot
having no IOMMU driver: extend the component larb lookup with that port
index.

The driver matches "mediatek,mt8192-disp-ovl", the generic fallback the
MT8365 ovl0 node carries behind "mediatek,mt8365-disp-ovl", and
"mediatek,mt8366-disp-ovl", which the MT8366 node carries on its own as
that SoC is not upstream yet. The MT8366 overlay is the only one of the
two able to drive the per layer bit depth of DISP_REG_OVL_CLRFMT_EXT,
which the per-compatible data selects.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.c |   1 +
 drivers/video/mediatek/mtk_disp_comp.h |  13 +-
 drivers/video/mediatek/mtk_disp_ovl.c  | 253 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_ovl.h  |  45 ++++++
 4 files changed, 307 insertions(+), 5 deletions(-)

diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
index f9eb9e00de6..3846a46f698 100644
--- a/drivers/video/mediatek/mtk_disp_comp.c
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -89,6 +89,7 @@ int mtk_disp_comp_get_larb(struct udevice *dev)
 	}
 	iommu = args.node;
 	larb_id = MTK_M4U_TO_LARB(args.args[0]);
+	priv->larb_port = MTK_M4U_TO_PORT(args.args[0]);
 
 	for (i = 0; ; i++) {
 		node = ofnode_parse_phandle(iommu, "mediatek,larbs", i);
diff --git a/drivers/video/mediatek/mtk_disp_comp.h b/drivers/video/mediatek/mtk_disp_comp.h
index 8214af38b27..fbc2174352e 100644
--- a/drivers/video/mediatek/mtk_disp_comp.h
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -18,13 +18,15 @@ struct udevice;
  * @base: register window of the component
  * @clk_bulk: clocks of the component
  * @larb: optional SMI larb device (UCLASS_MEMORY), enabled and disabled
- *	  together with the component. Only the RDMAs, which are the DMA
- *	  masters of this pipeline, have one.
+ *	  together with the component. Only the DMA masters of the pipelines,
+ *	  the overlays and the MDP RDMAs, have one.
+ * @larb_port: M4U port index of the component within @larb
  */
 struct mtk_disp_comp_priv {
 	void __iomem *base;
 	struct clk_bulk clk_bulk;
 	struct udevice *larb;
+	unsigned int larb_port;
 };
 
 /**
@@ -44,9 +46,10 @@ int mtk_disp_comp_probe(struct udevice *dev);
  *
  * A DMA master component reaches DRAM through an SMI larb, which must be
  * ungated for its accesses. The component points at its IOMMU (M4U) port
- * through "iommus", and MTK_M4U_TO_LARB() extracts the larb id from that
- * port. Resolve the matching larb in the IOMMU's "mediatek,larbs" list by
- * its "mediatek,larb-id", so that mtk_disp_comp_enable() and
+ * through "iommus": MTK_M4U_TO_LARB() extracts the larb id from that port
+ * and MTK_M4U_TO_PORT() the port index within it, kept in larb_port.
+ * Resolve the matching larb in the IOMMU's "mediatek,larbs" list by its
+ * "mediatek,larb-id", so that mtk_disp_comp_enable() and
  * mtk_disp_comp_disable() then enable and disable it together with the
  * component.
  *
diff --git a/drivers/video/mediatek/mtk_disp_ovl.c b/drivers/video/mediatek/mtk_disp_ovl.c
new file mode 100644
index 00000000000..6f07bf5d0ef
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_ovl.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Overlay support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <mtk_smi.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_ovl.h"
+
+#define DISP_REG_OVL_EN		0x00c
+#define OVL_EN				BIT(0)
+
+#define DISP_REG_OVL_RST	0x014
+
+#define DISP_REG_OVL_ROI_SIZE	0x020
+#define OVL_ROI_SIZE_WIDTH		GENMASK(15, 0)
+#define OVL_ROI_SIZE_HEIGHT		GENMASK(31, 16)
+
+#define DISP_REG_OVL_DATAPATH_CON 0x024
+#define OVL_LAYER_SMI_ID_EN		BIT(0)
+
+#define DISP_REG_OVL_ROI_BGCLR	0x028
+#define OVL_COLOR_ALPHA			GENMASK(31, 24)
+
+#define DISP_REG_OVL_SRC_CON	0x02c
+#define L0_EN				BIT(0)
+
+#define DISP_REG_OVL_CON	0x030
+#define OVL_CON_ALPHA			GENMASK(7, 0)
+#define OVL_CON_AEN			BIT(8)
+#define OVL_CON_CLRFMT			GENMASK(14, 12)
+#define OVL_CON_CLRFMT_ARGB8888		2
+
+#define DISP_REG_OVL_SRC_SIZE	0x038
+#define OVL_SRC_SIZE_WIDTH		GENMASK(15, 0)
+#define OVL_SRC_SIZE_HEIGHT		GENMASK(31, 16)
+
+#define DISP_REG_OVL_OFFSET	0x03c
+
+#define DISP_REG_OVL_PITCH	0x044
+#define OVL_PITCH_LSB			GENMASK(15, 0)
+#define OVL_CONST_BLEND			BIT(28)
+
+#define DISP_REG_OVL_RDMA0_CTRL	0x0c0
+#define RDMA0_EN			BIT(0)
+
+#define DISP_REG_OVL_RDMA_GMC	0x0c8
+#define GMC_THRESHOLD_BITS	16
+#define GMC_THRESHOLD_HIGH	((1 << GMC_THRESHOLD_BITS) / 4)
+#define GMC_THRESHOLD_LOW	((1 << GMC_THRESHOLD_BITS) / 8)
+
+#define DISP_REG_OVL_CLRFMT_EXT	0x2d0
+#define OVL_CON_CLRFMT_BIT_DEPTH_MASK(n) (GENMASK(1, 0) << (4 * (n)))
+#define OVL_CON_CLRFMT_BIT_DEPTH(depth, n) ((depth) << (4 * (n)))
+#define OVL_CON_CLRFMT_8_BIT		0
+
+#define DISP_REG_OVL_ADDR	0xf40
+
+/**
+ * struct mtk_disp_ovl_data - per-SoC overlay data
+ * @smi_id_en: the overlay tags its DRAM requests with an SMI id
+ * @supports_clrfmt_ext: the overlay has the CLRFMT_EXT bit depth register
+ * @gmc_bits: width of the GMC thresholds, in bits
+ */
+struct mtk_disp_ovl_data {
+	bool smi_id_en;
+	bool supports_clrfmt_ext;
+	unsigned int gmc_bits;
+};
+
+/**
+ * struct mtk_disp_ovl_priv - private data of an overlay
+ * @comp: common component state, must be the first member
+ * @data: per-SoC overlay data
+ */
+struct mtk_disp_ovl_priv {
+	struct mtk_disp_comp_priv comp;
+	const struct mtk_disp_ovl_data *data;
+};
+
+void mtk_ovl_config(struct udevice *dev, const struct display_timing *timing)
+{
+	u32 width = timing->hactive.typ;
+	u32 height = timing->vactive.typ;
+
+	if (width != 0 && height != 0)
+		mtk_disp_comp_write(dev, DISP_REG_OVL_ROI_SIZE,
+				    FIELD_PREP(OVL_ROI_SIZE_WIDTH, width) |
+				    FIELD_PREP(OVL_ROI_SIZE_HEIGHT, height));
+
+	/* the background must be opaque black, or alpha blending has no effect */
+	mtk_disp_comp_write(dev, DISP_REG_OVL_ROI_BGCLR, OVL_COLOR_ALPHA);
+
+	mtk_disp_comp_write(dev, DISP_REG_OVL_RST, 1);
+	mtk_disp_comp_write(dev, DISP_REG_OVL_RST, 0);
+}
+
+/*
+ * Layer 0 is always fed our fixed 8-bit-per-channel XRGB8888 framebuffer, so
+ * the 10-bit format check Linux does here never applies to us.
+ */
+static void mtk_ovl_set_bit_depth(struct udevice *dev)
+{
+	struct mtk_disp_ovl_priv *ovl = dev_get_priv(dev);
+
+	if (!ovl->data->supports_clrfmt_ext)
+		return;
+
+	mtk_disp_comp_update(dev, DISP_REG_OVL_CLRFMT_EXT,
+			     OVL_CON_CLRFMT_BIT_DEPTH(OVL_CON_CLRFMT_8_BIT, 0),
+			     OVL_CON_CLRFMT_BIT_DEPTH_MASK(0));
+}
+
+static void mtk_ovl_layer_on(struct udevice *dev)
+{
+	struct mtk_disp_ovl_priv *ovl = dev_get_priv(dev);
+	u32 gmc_thrshd_l, gmc_thrshd_h, gmc;
+
+	mtk_disp_comp_write(dev, DISP_REG_OVL_RDMA0_CTRL, RDMA0_EN);
+
+	gmc_thrshd_l = GMC_THRESHOLD_LOW >> (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
+	gmc_thrshd_h = GMC_THRESHOLD_HIGH >> (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
+	if (ovl->data->gmc_bits == 10)
+		gmc = gmc_thrshd_h | gmc_thrshd_h << 16;
+	else
+		gmc = gmc_thrshd_l | gmc_thrshd_l << 8 |
+		      gmc_thrshd_h << 16 | gmc_thrshd_h << 24;
+	mtk_disp_comp_write(dev, DISP_REG_OVL_RDMA_GMC, gmc);
+
+	mtk_disp_comp_update(dev, DISP_REG_OVL_SRC_CON, L0_EN, L0_EN);
+}
+
+int mtk_ovl_layer(struct udevice *dev, const struct video_uc_plat *plat,
+		  const struct display_timing *timing)
+{
+	struct mtk_disp_ovl_priv *ovl = dev_get_priv(dev);
+	u32 width = timing->hactive.typ;
+	u32 height = timing->vactive.typ;
+	u32 pitch = width * VNBYTES(VIDEO_BPP32);
+
+	/* DISP_REG_OVL_ADDR is 32-bit, the framebuffer has to fit below 4GB */
+	if (upper_32_bits(plat->base)) {
+		dev_err(dev, "framebuffer at 0x%lx is above 4GB\n", plat->base);
+		return -ERANGE;
+	}
+
+	/* opaque layer with alpha blending on, as Linux sets it up */
+	mtk_disp_comp_write(dev, DISP_REG_OVL_CON,
+			    FIELD_PREP(OVL_CON_CLRFMT, OVL_CON_CLRFMT_ARGB8888) |
+			    FIELD_PREP(OVL_CON_ALPHA, 0xff) | OVL_CON_AEN);
+
+	/*
+	 * The framebuffer has no real per-pixel alpha channel, so without
+	 * OVL_CONST_BLEND the hardware reads the (zero) alpha byte from
+	 * memory and blends the whole layer as fully transparent.
+	 */
+	mtk_disp_comp_write(dev, DISP_REG_OVL_PITCH,
+			    FIELD_PREP(OVL_PITCH_LSB, pitch) | OVL_CONST_BLEND);
+
+	mtk_disp_comp_write(dev, DISP_REG_OVL_SRC_SIZE,
+			    FIELD_PREP(OVL_SRC_SIZE_WIDTH, width) |
+			    FIELD_PREP(OVL_SRC_SIZE_HEIGHT, height));
+
+	/* the layer covers the whole region of interest */
+	mtk_disp_comp_write(dev, DISP_REG_OVL_OFFSET, 0);
+
+	/*
+	 * Without an IOMMU driver the overlay reads the framebuffer with a
+	 * physical address, so take its larb port out of the translated
+	 * address space now that the larb is ungated.
+	 */
+	mtk_smi_larb_port_set_pa(ovl->comp.larb, ovl->comp.larb_port);
+
+	mtk_disp_comp_write(dev, DISP_REG_OVL_ADDR, plat->base);
+
+	mtk_ovl_set_bit_depth(dev);
+
+	mtk_ovl_layer_on(dev);
+
+	return 0;
+}
+
+void mtk_ovl_start(struct udevice *dev)
+{
+	struct mtk_disp_ovl_priv *ovl = dev_get_priv(dev);
+
+	if (ovl->data->smi_id_en)
+		mtk_disp_comp_update(dev, DISP_REG_OVL_DATAPATH_CON,
+				     OVL_LAYER_SMI_ID_EN, OVL_LAYER_SMI_ID_EN);
+
+	mtk_disp_comp_write(dev, DISP_REG_OVL_EN, OVL_EN);
+}
+
+static int mtk_disp_ovl_probe(struct udevice *dev)
+{
+	struct mtk_disp_ovl_priv *ovl = dev_get_priv(dev);
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	ovl->data = (const struct mtk_disp_ovl_data *)dev_get_driver_data(dev);
+	if (!ovl->data)
+		return -EINVAL;
+
+	/* the overlay is a DMA master: it feeds from an SMI larb */
+	return mtk_disp_comp_get_larb(dev);
+}
+
+static const struct mtk_disp_ovl_data mt8192_ovl_driver_data = {
+	.smi_id_en = true,
+	.gmc_bits = 10,
+};
+
+static const struct mtk_disp_ovl_data mt8366_ovl_driver_data = {
+	.smi_id_en = true,
+	.supports_clrfmt_ext = true,
+	.gmc_bits = 10,
+};
+
+static const struct udevice_id mtk_disp_ovl_ids[] = {
+	{
+		.compatible = "mediatek,mt8192-disp-ovl",
+		.data = (ulong)&mt8192_ovl_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8366-disp-ovl",
+		.data = (ulong)&mt8366_ovl_driver_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_ovl) = {
+	.name	   = "mtk_disp_ovl",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_ovl_ids,
+	.probe	   = mtk_disp_ovl_probe,
+	.priv_auto = sizeof(struct mtk_disp_ovl_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_ovl.h b/drivers/video/mediatek/mtk_disp_ovl.h
new file mode 100644
index 00000000000..1882309f6d8
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_ovl.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_OVL_H
+#define _MTK_DISP_OVL_H
+
+struct display_timing;
+struct udevice;
+struct video_uc_plat;
+
+/**
+ * mtk_ovl_config() - configure an overlay
+ * @dev: overlay device
+ * @timing: display timing, giving the frame size
+ *
+ * Set the region of interest over an opaque black background, and reset
+ * the overlay.
+ */
+void mtk_ovl_config(struct udevice *dev, const struct display_timing *timing);
+
+/**
+ * mtk_ovl_layer() - scan out the framebuffer on layer 0
+ * @dev: overlay device
+ * @plat: video uclass platform data, holding the framebuffer base address
+ * @timing: display timing, giving the frame size
+ *
+ * Point layer 0 at the XRGB8888 framebuffer, take its larb port out of the
+ * IOMMU, and enable the layer.
+ *
+ * Return: 0 on success, -ERANGE if the framebuffer is above 4 GiB
+ */
+int mtk_ovl_layer(struct udevice *dev, const struct video_uc_plat *plat,
+		  const struct display_timing *timing);
+
+/**
+ * mtk_ovl_start() - start an overlay
+ * @dev: overlay device
+ */
+void mtk_ovl_start(struct udevice *dev);
+
+#endif /* _MTK_DISP_OVL_H */

-- 
2.55.0

