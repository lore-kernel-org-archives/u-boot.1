Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEA8CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:07:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E75F380E2E;
	Mon, 28 Sep 2026 15:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OOFsfMd0Uxse; Mon, 28 Sep 2026 15:07:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E818180DFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608059;
	b=KIB7qk1tY2wmY/4eGG035scM0NQ5j4Pn3B0/z9DTAaP6JBkuCG7w0arqK1qz2Hz9Gd/y
	 Vd0xdkPs3HDJnny7AMm6rFCdseSafVpIkGVgDUGpw9Dn+VWb2nTpd4Aarby3XFNxXCN+7
	 UE0MCKL9nR8hj2PokzYANgAedFXmpbAY4iI5Vh6oXLsUGKnPFP35TB/Nu8VORgPCtq+vo
	 KIL9z/iuxEntvokPq5io4Y7bUUAAoTYCTazoE6HURBGdGQDV89qoIPqOBnY653dAJjxpO
	 S6uWUYLRO690M7MUicnTY/YQhtVQm1el/z+sbMtjMxoHZHQoyUwXglLglVk5/qdhAfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608059;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kebkm+KKC0A2iRI8/FPasUx7BIIGPrbvNpxa/qy17qc=;
	b=EGDmIMCBi9d7v1G0piTruvD7dJ65tB+rTStEpbvltKoEbDL5+FmJ8ubXOEL5MPQ+hiYv
	 uT97gerriKIfC86476/9LIGvIjMU3ZX+kMv/2pKQKsAASfSSlT3l4Gxdqt60ZztpCBLsq
	 +bqhML7k4a5RFrA/hx12YSPjMygKD+A830nWNClm6Yw0VUi65UP/sho4wCL7nwVU1OQUN
	 Sem0iXb2kqSC1mY834SFJL5V3XmJHmAvJbzUt9sNpdNrdTd7qLIcReUzsBLphi0i/KxG3
	 Jpq0ubMD6hMHN+rN6+G2NVFXLT4iiJGhc15LfPxBiSJ3OT1qKG0KZU9a2GfVQf2SCwg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608059;
	bh=kebkm+KKC0A2iRI8/FPasUx7BIIGPrbvNpxa/qy17qc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DJpA6kF0B/XWTpon4jcs1IkxnS9nMhEgugVkmhZTVOZHpdSMHhGw1wAWZmc3LA2fg
	 mYxxYE5Cd35Eok/1HQDaK4WMjGg5bma+gwQH8gGtIHfmInvweauKyTSKV46Yfk9JiS
	 SWKN8HBoroEOtvtXPXoWcpxao33qGhdJXCDvSU4AUMAsnv8384ke4vuVj7uK74gl5f
	 rOtpI+PJcVVWTZpyXacHP2UmX7G0ywXmsUwClx39r2AgiW2VWfehVo8A1l9xnA32b+
	 vm3VVFVkIf5O7d2bzClQPhHOO66zDBd45GJnSm+WIlMIZV/RQMZnu31G40PxZkKohQ
	 T28d8myZFUrew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E818180DFA;
	Mon, 28 Sep 2026 15:07:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 635E7D1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55A14606D0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYK2_F4Eg7AB for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:07:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4011B606B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790608057;
 b=UjnVyOFOAk6y3x+8xqaXzhgXOdecJiRLjPzstVewQWI5u//LtJMp2igmYrruFDLcyPsH
 iMfuwH8PpVUUPMUmpYmwHlqGeqitQPaMMU/iR6VXtez6jqpdrihOJgetq5Goq/9kpe7Ln
 1a/OoKYYl7mXYyYnqP6of9ud8yAldUlL8KrSsBd1C7/RCAi4RnQ1p7capQ0pqDYFfbROe
 YiVcN3bgq8L5Ct+Kfb76u7CgKDv4QCFTycksThyD/FsFvb4yoLqpKEW5FlAc9nI6HYEEp
 H6eTeLPnmPnjoCpAAJJw0Aoxof1SOIRQv5ke0zkvtq51nCbRIY1z4JFB5w/r3pEgxuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608057;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=kebkm+KKC0A2iRI8/FPasUx7BIIGPrbvNpxa/qy17qc=;
 b=ddCIDLRQxsRFZMomokvtyMs5yGH2cWZmZftxu7ACkExUMbc7fJpUdPtGGsgyj+2g1mbn
 MfInl+4J9HsQNDnR65besQwZeFYbZE+77DzTSgpVbtWL4cr2RPrzG59LWYJ4eCC7pwh24
 aRmYQajh6un58IiKMFo2npBKI2LOWbZQAi/pwFzy9pCiQFhSR+Dn/RkFydfzmIJEw0YMa
 Y1cnFEb6J83qVCGbmwowbGfz6IKznIoU67uqeKjOGZSPsGUUnQ3Z7C9nCFYf8zHnZrApM
 fUitzod6pn/sM4GU0fXrItTsACkGr3tAPC62QMUHXOkvqU82dvV5/MWnmIQYs3CLjKQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RXz0lAYo; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RXz0lAYo
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4011B606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:07:36 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso9719445e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790608055; x=1791212855;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kebkm+KKC0A2iRI8/FPasUx7BIIGPrbvNpxa/qy17qc=;
 b=RXz0lAYoYm+7hdoZQGdvco3lHb9IJqOeCtzv99RB+RCR6nRAYRU9dC6aH+ZQRH5+mW
 0MjilqamVtOydwp9QA+vK3RpFTG7WVhs0BT9sl0UkCI51wpc677R7ugI8xVggDDr85S7
 CFLWjScXDDQRSIsAqQoSTDkHQmRzzikJ7C7RA7qieW/jnLF0jrd7hxMBaaLWvZzPccis
 K5qx35VKC7F3lF7kzFCL9Ioe3dIn5gBfKZU/7dfmaYhO64mLlbJB0s/H9Xns4bshCIyA
 cFhlOf5BZTuIwqUIFWQlqOehOc019okIy/PX0UmcnT4hNcvN6MXOFSQE2KaM21l06evl
 P0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608055; x=1791212855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kebkm+KKC0A2iRI8/FPasUx7BIIGPrbvNpxa/qy17qc=;
 b=gM+hxV/faiZCCa9Qt/yZlWHBtDCEyQafeaO8A3V1rPL2tgBwDR7b/FxJ2G6Y90MLAZ
 3WMxk0deNDLi04pYuPm3t8oir09tRiYNsxfsxXDYhvl6szW+JPWkhFJrsXF1CxAKfqCj
 Tygg46QtkGr+WAs+kcDNDMcOryPEGAmNh9IYQq/CXgejRoqoZmaHOytfLMWDYcdAdS72
 MjabZ2dpxky/L3Bg4wZskej6pC5ymoO2Fd7SbQMAX3nEOifyYf0VRGuD3A0dSFjAAdMJ
 H7eo/JzmB1d1SyZAItfP72PfXFcKmHiryuAJo4EwvmHfp2nCp20EufNmCvVT8GmBDp53
 w1nw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCdBqKpSoDHQipStgr/1AiZ0qFnxbtOYs17IWPGgcD2kyV0axXqJsqNAQW4fsI159KPzpGgJQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lA3Zd1d7iJpUTqzKV/3lj+xWCgZAmCES7lEQS76tFvENF6RFzp
 5Zd3EEiPBJr+4G+TGd50lbPnPR0dcNiQUNOhXEvXrNv/mCSlBCSK1Lflt6MHYbopgVE=
X-Gm-Gg: AYBFou253jT8F+FkMtwYUwW8DlamfYKrnYR1XxYANhMQ7PI7owQUbx/pOJNbxRHomSv
 W2kLp/PhvY0UCTpCD67h8UJSX97vZYZ0q6wSqOIyTEFMAeZO+pmegN0jJVBG6G+fEOEnJRbd6Eo
 Six0YmYHccAbylFfwpNAwQr5sujCW+nJJp3rOXWWqMAhlLzjTy4erwwXjaEdxEiZxINGfmvB5Lm
 kO/r4iaWZLPJCQXl6Gw3YCOH3A/DNq9M0xHnKfcDpFyEjFAWrNrYTGKU9oP7pDeQgdarDcUA6Ev
 FPfJTso8t05QDVbIE0hg9u/6fJQEWMLuZFHRbbM9ykVZLxEVHh2ioLhhqfq405LBQLOP5k/AeZB
 M2TZeQoM4kbmdinZ5OK3B+ZIdrD+sPUuvK8bSsa7Z5SDC4zQ1Ki3461A29JqOkY5INuIqBxvrVh
 SiDUGzCuFWJ4WDTfZ+FhYAlZZwQVpH13Owh/srEymXHEMf7Vh2l6A34M2Kk/CEmCsoezr5+lKcK
 7SH3CCeBtb2DxguZxCrwYQlWa1cDvxlHb03/XG35StTwiIOPtCw096PwZiJ+coKBSCFXQ/GH/UW
 ryR3UK9HlWcfY/jZCLSDEY/cEIuB20nU60EGfODx8LhMScFLhWw1IS8=
X-Received: by 2002:a05:600c:310b:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49fe66c8959mr221094535e9.1.1790608054988; 
 Mon, 28 Sep 2026 08:07:34 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:07:34 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 17:08:47 +0200
Subject: [PATCH 10/13] video: mediatek: mtk_disp_mutex: add the DSI
 pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-10-212f51b1742b@baylibre.com>
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

The mutex serialises the components of a pipeline on the same frame: it
holds the list of the modules started together and the source of the
start and end of frame signals driving them.

Extend the driver, so far only used by the MT8188 HDMI pipeline, with the
DSI pipeline of the MT8365 and the MT8366: the overlay to the DSI,
through the colour pipeline on the MT8365 and straight out of the rdma on
the MT8366, which the per-compatible data selects.

Two compatibles are added, "mediatek,mt8365-disp-mutex" and
"mediatek,mt8366-disp-mutex". Neither node declares a generic fallback,
so both SoC specific strings have to be listed; they also differ in
the module indices, in the DSI0 module bit the MT8366 needs, and in the
shift of the end-of-frame selector (6 on the MT8365, 7 on the MT8366).

The MT8365 mutex has no clock of its own, as "no_clk" in the Linux
driver says, so the shared component probe now tolerates a node without
a "clocks" property instead of failing on it.

The driver includes <dm/device.h> and <dm/device_compat.h>, for the
dev_err() it now uses, instead of <dm.h>.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.c  |   3 +-
 drivers/video/mediatek/mtk_disp_mutex.c | 120 ++++++++++++++++++++++++++++++--
 drivers/video/mediatek/mtk_disp_mutex.h |   9 +++
 3 files changed, 125 insertions(+), 7 deletions(-)

diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
index 3846a46f698..5d0e69a75b3 100644
--- a/drivers/video/mediatek/mtk_disp_comp.c
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -114,8 +114,9 @@ int mtk_disp_comp_probe(struct udevice *dev)
 	if (!priv->base)
 		return -EINVAL;
 
+	/* some components, such as the MT8365 mutex, have no clock of their own */
 	ret = clk_get_bulk(dev, &priv->clk_bulk);
-	if (ret) {
+	if (ret && ret != -ENOENT) {
 		dev_err(dev, "failed to get clocks: %d\n", ret);
 		return ret;
 	}
diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
index 0e1d2e3ead2..36a1fca26b1 100644
--- a/drivers/video/mediatek/mtk_disp_mutex.c
+++ b/drivers/video/mediatek/mtk_disp_mutex.c
@@ -6,7 +6,8 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
-#include <dm.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
 #include <linux/bitops.h>
 
 #include "mtk_disp_comp.h"
@@ -16,8 +17,8 @@
  * Register layout of one mutex instance @id (as in the Linux mtk-mutex
  * driver): the block packs the per-mutex registers 0x20 apart. SOF holds
  * the start/end-of-frame source, MOD0/MOD1 the attached modules 0-31 and
- * 32-63. The offsets are index-based so a future DSI helper can drive a
- * different instance/controller.
+ * 32-63. The offsets are index-based so the HDMI and DSI helpers below can
+ * drive a different instance/controller each.
  */
 #define DISP_MUTEX_EN(id)	(0x20 + 0x20 * (id))
 #define MUTEX_EN			BIT(0)
@@ -48,6 +49,47 @@
 #define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
 #define MT8188_MUTEX_MOD_DISP1_DPI1		38
 
+/* The MT8365 and MT8366 DSI pipelines use instance 0 of the mmsys mutex */
+#define MUTEX_DSI_ID		0
+
+/* the MT8365 shifts the end-of-frame selector by 6 instead of 7 */
+#define MT8365_MUTEX_SOF_DSI0		1
+#define MT8365_MUTEX_EOF_DSI0		(MT8365_MUTEX_SOF_DSI0 << 6)
+
+#define MT8365_MUTEX_MOD_DISP_OVL0	7
+#define MT8365_MUTEX_MOD_DISP_RDMA0	9
+#define MT8365_MUTEX_MOD_DISP_COLOR0	12
+#define MT8365_MUTEX_MOD_DISP_CCORR	13
+#define MT8365_MUTEX_MOD_DISP_AAL	14
+#define MT8365_MUTEX_MOD_DISP_GAMMA	15
+#define MT8365_MUTEX_MOD_DISP_DITHER	16
+
+/* the MT8366 drives the DSI straight out of the rdma, without the PQ blocks */
+#define MT8366_MUTEX_SOF_DSI0		1
+#define MT8366_MUTEX_EOF_DSI0		(MT8366_MUTEX_SOF_DSI0 << 7)
+
+#define MT8366_MUTEX_MOD_DISP_OVL0	0
+#define MT8366_MUTEX_MOD_DISP_RDMA0	4
+#define MT8366_MUTEX_MOD_DISP_DSI0	13
+
+/**
+ * struct mtk_disp_mutex_data - per-SoC mutex data
+ * @ovl_dsi_enable: set up the mutex of the OVL -> DSI pipeline
+ */
+struct mtk_disp_mutex_data {
+	void (*ovl_dsi_enable)(struct udevice *dev);
+};
+
+/**
+ * struct mtk_disp_mutex_priv - private data of a mutex
+ * @comp: common component state, must be the first member
+ * @data: per-SoC data, NULL on the SoCs without a DSI pipeline
+ */
+struct mtk_disp_mutex_priv {
+	struct mtk_disp_comp_priv comp;
+	const struct mtk_disp_mutex_data *data;
+};
+
 void mtk_disp_mutex_config_hdmi(struct udevice *dev)
 {
 	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_HDMI_ID),
@@ -65,8 +107,74 @@ void mtk_disp_mutex_config_hdmi(struct udevice *dev)
 	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_HDMI_ID), MUTEX_EN);
 }
 
+static void mtk_disp_mutex_ovl_dsi_enable_color_pipeline(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_OVL0) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_RDMA0) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_COLOR0) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_CCORR) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_AAL) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_GAMMA) |
+			    MUTEX_MOD_BIT(MT8365_MUTEX_MOD_DISP_DITHER));
+	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
+			    MT8365_MUTEX_EOF_DSI0 | MT8365_MUTEX_SOF_DSI0);
+	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
+}
+
+static void mtk_disp_mutex_ovl_dsi_enable_no_color_pipeline(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
+			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_OVL0) |
+			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_RDMA0) |
+			    MUTEX_MOD_BIT(MT8366_MUTEX_MOD_DISP_DSI0));
+	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
+			    MT8366_MUTEX_EOF_DSI0 | MT8366_MUTEX_SOF_DSI0);
+	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
+}
+
+static const struct mtk_disp_mutex_data mt8365_mutex_data = {
+	.ovl_dsi_enable = mtk_disp_mutex_ovl_dsi_enable_color_pipeline,
+};
+
+static const struct mtk_disp_mutex_data mt8366_mutex_data = {
+	.ovl_dsi_enable = mtk_disp_mutex_ovl_dsi_enable_no_color_pipeline,
+};
+
+void mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
+{
+	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
+
+	if (!mutex->data) {
+		dev_err(dev, "no DSI pipeline on this mutex\n");
+		return;
+	}
+
+	mutex->data->ovl_dsi_enable(dev);
+}
+
+static int mtk_disp_mutex_probe(struct udevice *dev)
+{
+	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
+
+	/* the HDMI pipeline needs no per-SoC data */
+	mutex->data = (const struct mtk_disp_mutex_data *)dev_get_driver_data(dev);
+
+	return mtk_disp_comp_probe(dev);
+}
+
 static const struct udevice_id mtk_disp_mutex_ids[] = {
-	{ .compatible = "mediatek,mt8188-disp-mutex" },
+	{
+		.compatible = "mediatek,mt8188-disp-mutex",
+	},
+	{
+		.compatible = "mediatek,mt8365-disp-mutex",
+		.data = (ulong)&mt8365_mutex_data,
+	},
+	{
+		.compatible = "mediatek,mt8366-disp-mutex",
+		.data = (ulong)&mt8366_mutex_data,
+	},
 	{ }
 };
 
@@ -74,6 +182,6 @@ U_BOOT_DRIVER(mtk_disp_mutex) = {
 	.name	   = "mtk_disp_mutex",
 	.id	   = UCLASS_MISC,
 	.of_match  = mtk_disp_mutex_ids,
-	.probe	   = mtk_disp_comp_probe,
-	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+	.probe	   = mtk_disp_mutex_probe,
+	.priv_auto = sizeof(struct mtk_disp_mutex_priv),
 };
diff --git a/drivers/video/mediatek/mtk_disp_mutex.h b/drivers/video/mediatek/mtk_disp_mutex.h
index 76630e6291f..34fecaaaa1b 100644
--- a/drivers/video/mediatek/mtk_disp_mutex.h
+++ b/drivers/video/mediatek/mtk_disp_mutex.h
@@ -18,4 +18,13 @@ struct udevice;
  */
 void mtk_disp_mutex_config_hdmi(struct udevice *dev);
 
+/**
+ * mtk_disp_mutex_ovl_dsi_enable() - set up the mutex of the DSI pipeline
+ * @dev: mmsys mutex device
+ *
+ * Put all the components of the OVL -> DSI pipeline under one mutex
+ * instance, and start and end their frames on the DSI ones.
+ */
+void mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev);
+
 #endif /* _MTK_DISP_MUTEX_H */

-- 
2.55.0

