Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94151C98302
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 04:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DFD7406D0;
	Wed, 23 Sep 2026 04:50:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HCOZRpSohv_S; Wed, 23 Sep 2026 04:50:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2BC7C406D1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790139026;
	b=JqEBSxKPjc6pLUkgOTDQb7t+gHqJ3UQtdp1Z9oSQMnr3ZF61duSL9vaJVuBjsJxQcvY9
	 LhRnLcMSrsyKsrd68PicwTCg6ki9AGx2iv7CLUsBT2LLFvtzE/oM0KaTA0TX8s8y4XG1G
	 CiHjmk39pxop8vYecULtqihCLPwh+ZrZrOauMjEqczTR6YEXvItZ4HnzecVxAdCvT/qtU
	 DhTslupqfZMtX24O95zeyhuFx61obTPTwWGM5bwMF79JvZX/pPlmlQIyFcn7qZYEJ0VoZ
	 klKuDJx0WovSV5H7/jwvr5tl2LUHLbHlpkcxWBsGzwkNB13QO3WAlPGb4pbA99hwCbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790139026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S9C1Dy4dMHH3v7Eam1CnUdtCsCuHsnEvQPQh5GKHevg=;
	b=UcffYkJiJ/1vu+orQSqruBRhDJpFDjWYOcvKD0Ss7VtCfTEgh3PCCl2hIsrgzvMg5XWy
	 dJGLyn2oZl4QvcEUxV2NvZcolwO8793Dfqhfr5URCBLEUh2ZDGleSTumomhd/SV+MpCHS
	 kpZYklP9JqyiWQ9snH1h7kLeV/NDDsUg2nmO2xPaELASRi2zQ3aBZW/U2ZTdNMF8R5+8Z
	 fJXLcYJSRafNiyiIVHELDLcfMBqedx97p+Y6mbRjTEk9mhPIU0uWAhOEwMU/pOtfWz4Wv
	 FVeuyIvwV3uoGyVRENaUvNXS2O/fiP++F/XSC7XutSo4jmcfRTSulLjXhjOaL91XyuQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=a77R3lCC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790139026;
	bh=S9C1Dy4dMHH3v7Eam1CnUdtCsCuHsnEvQPQh5GKHevg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VEPU59tpYCwY0gCOUjItA0QetHceQk1NokcQ+qw8iuPJyLxilKHpUF+V8jar2hxfd
	 6zVt4hFfWF4U9difp2t6ANHG774N/EfdqTm7gPdPdHeHCipYpsLcevso8WDyg3Zjyi
	 bFJIUNlDlMsHo9WFDGhoJ0R6n9QfcroVeyyPG09v4ukjtg7Xh4O1fRRv5yid+KIo4M
	 4SnLUZeYAPRXh5aJtKBPMymdj4XPLLtgJ2HiMxzT/gcFjI65Lo8JkV5G3r9ob5C73L
	 dHXI7YaQgGOlNvX5VqTY0tZ9g76qgnPUwWPuoxNUExGNsmWxW9n4lqsApM1Bt0pJbv
	 vcAAJ9edpffug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BC7C406D1;
	Wed, 23 Sep 2026 04:50:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A6AC3D1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 04:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C633406D1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 04:50:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzSn_gQ0pra5 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 04:50:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E583D406D0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790139023;
 b=ZnRnq3znVkd4mULqdsv6Nv3RcOors12U+ZldJBF14CQ1NCQSMha0RWNX6DDxZ4f0qp4E
 MtYYtC6ryFPhiFqXDnorAmTKrv+TAKnziH/CGcIV2Lh3rYzE7CC/Yk/eiMr9uMNIBdffI
 2ySLfxU4tAAgGES0PFG3bYS9kD+tCfVFQGrKRhdbmyKCAHTt/Mvzdgn9JVqi3bP7UsfJh
 1h0yAFC9fmN5I4x+njt4TUmy67ZnpBb//nWsS8aAg1cq4RkIlua4FudG8We0f21SsFA33
 t/3u3+q/+mU/cXOGADpzknvCTFfCjM97miB1p53cQzipi7lB4dYF4OramHkSVf+AIAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790139023;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=S9C1Dy4dMHH3v7Eam1CnUdtCsCuHsnEvQPQh5GKHevg=;
 b=KO58dw1tb9KwAb5UXnM3Wlp+wWwcJ3TXQd2+6qQ5BJnMc9kyKD+1Msq2NrDaaYk4gAWF
 rFX9W0oErBJu73Raf3seKDTCOTw8QLhiA8umpgB8hEBHbBW+sAXYYYWWoQKmN0/olGn4S
 dxLIKWvHUjN92bVYqHnm5T1MzINymSNxIHn/aiGAiqqqr1JuSxO57YhJND/H6XZNMU04g
 mfOgASxsz/FDm1sphIftPvdQtQZwxrGU7xdMOv63MtZVMsiY5bjcyzZHlxtCPhbLrsekN
 smsRU82nSh4dhhHgQ7ynrofllPOb4+1MPvcv7AXGzMqtyBVncdDnLVS7Xk05vHLht2g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=a77R3lCC; 
 arc=none smtp.remote-ip=212.227.17.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.21;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=a77R3lCC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E583D406D0
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 04:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790139015; x=1790743815; i=xypron.glpk@gmx.de;
 bh=S9C1Dy4dMHH3v7Eam1CnUdtCsCuHsnEvQPQh5GKHevg=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=a77R3lCCA36WO7tJhT5p3vj0xK9jiiyeq5ijuDzwHu029SjNM+No4KfmhWKEllIx
 mw15A8z+ZKgJYBq3pe/GBrlYogHoisR0p7aC1LSmHdzHgc7S+fpl5rMMTIIYsep36
 yync3ThlSClEXvTP64FkeJWar1BiVnemDNd8asGM6DGI7Spz1ngIqzy91TS912ehj
 LoKxlT1xdE2us3PJWVDuUZ+/s7GX/QcXOtQxurrW+gK+BopmF/LOsBjw29OQUIi00
 kizbGoAop/pHx1f8zJNwpIdMUE4HuUWa9ty3zw02Ga9YDd4MDA6/WJiGjVAyMl3Jm
 9dydG9RPyaUVqANPqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1weo1h1mPn-00z4V6; Wed, 23
 Sep 2026 06:50:14 +0200
Date: Wed, 23 Sep 2026 06:50:04 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_03/13=5D_video=3A_mediatek=3A_?=
 =?US-ASCII?Q?add_display_pipeline_component_helpers?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-3-dd9dde2f972e@baylibre.com>
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
 <20260904-add-genio-510-and-genio-700-hdmi-v5-3-dd9dde2f972e@baylibre.com>
Message-ID: <5AFCA678-1F89-4B94-93D7-BD44B66FF1DD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9taIrVqlPFh5dzIymyP3dGemMqZnvqMjiCbwhxOltDpW9RgBkTg
 Ey+VsYzX7RuUyFq6Kj8wdwKNM5zq0bxs6Vcu2Chmn2sAkjUnJlBDmpHyxLzPKcSPA7ZsH+e
 dL8nATVB4MYnsLmI18YtmujEokKBRDjJRHpdl92JyxcpJkfMoyWp5abZ0DgFTdbiXKp+58M
 kyEdFOSi9qMXvwG7lym2g==
UI-OutboundReport: notjunk:1;M01:P0:yCzaox2Nuno=;wnDvIV0R+02nVFUTikJiOpkbowh
 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
 9+cn
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

Am 4=2E September 2026 15:50:09 MESZ schrieb Julien Stephan <jstephan@bayli=
bre=2Ecom>:
>Most of the simple display pipeline components share the same probe and
>enable sequence: remap the register window and enable a bulk of clocks=2E
>Add the mtk_disp_comp helpers holding this boilerplate so each component
>driver only has to provide its own component-specific programming=2E
>
>Signed-off-by: Julien Stephan <jstephan@baylibre=2Ecom>
>---
> drivers/video/mediatek/mtk_disp_comp=2Ec | 90 ++++++++++++++++++++++++++=
++++++++
> drivers/video/mediatek/mtk_disp_comp=2Eh | 34 +++++++++++++
> 2 files changed, 124 insertions(+)
>
>diff --git a/drivers/video/mediatek/mtk_disp_comp=2Ec b/drivers/video/med=
iatek/mtk_disp_comp=2Ec
>new file mode 100644
>index 00000000000=2E=2Ed41440f06ab
>--- /dev/null
>+++ b/drivers/video/mediatek/mtk_disp_comp=2Ec
>@@ -0,0 +1,90 @@
>+// SPDX-License-Identifier: GPL-2=2E0-only
>+/*
>+ * MediaTek display pipeline component helpers
>+ *
>+ * Copyright (c) 2026 BayLibre, SAS=2E
>+ * Author: Julien Stephan <jstephan@baylibre=2Ecom>
>+ */
>+
>+#include <asm/io=2Eh>
>+#include <clk=2Eh>
>+#include <dm=2Eh>
>+#include <dm/device_compat=2Eh>
>+#include <errno=2Eh>
>+#include <mtk_smi=2Eh>
>+
>+#include "mtk_disp_comp=2Eh"
>+
>+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val)
>+{
>+	struct mtk_disp_comp_priv *priv =3D dev_get_priv(dev);
>+
>+	writel(val, priv->base + offset);
>+}
>+
>+void mtk_disp_comp_update(struct udevice *dev, u32 offset, u32 val, u32 =
mask)
>+{
>+	struct mtk_disp_comp_priv *priv =3D dev_get_priv(dev);
>+	void __iomem *reg =3D priv->base + offset;
>+	u32 tmp;
>+
>+	tmp =3D readl(reg);
>+	tmp =3D (tmp & ~mask) | (val & mask);
>+	writel(tmp, reg);
>+}
>+
>+int mtk_disp_comp_enable(struct udevice *dev)
>+{
>+	struct mtk_disp_comp_priv *priv =3D dev_get_priv(dev);
>+	int ret;
>+
>+	/* ungate the feeding SMI larb first, if any */
>+	if (priv->larb) {
>+		ret =3D mtk_smi_larb_enable(priv->larb);
>+		if (ret)
>+			return ret;
>+	}
>+
>+	ret =3D clk_enable_bulk(&priv->clk_bulk);
>+	if (ret) {
>+		dev_err(dev, "failed to enable clocks: %d\n", ret);
>+		if (priv->larb)
>+			mtk_smi_larb_disable(priv->larb);
>+		return ret;
>+	}
>+
>+	return 0;
>+}
>+
>+int mtk_disp_comp_disable(struct udevice *dev)
>+{
>+	struct mtk_disp_comp_priv *priv =3D dev_get_priv(dev);
>+	int ret;
>+
>+	ret =3D clk_disable_bulk(&priv->clk_bulk);
>+	if (ret)
>+		dev_err(dev, "failed to disable clocks: %d\n", ret);
>+
>+	if (priv->larb)
>+		mtk_smi_larb_disable(priv->larb);
>+
>+	return ret;
>+}
>+
>+int mtk_disp_comp_probe(struct udevice *dev)
>+{
>+	struct mtk_disp_comp_priv *priv =3D dev_get_priv(dev);
>+	int ret;
>+
>+	priv->base =3D dev_remap_addr(dev);
>+	if (!priv->base)
>+		return -EINVAL;
>+
>+	ret =3D clk_get_bulk(dev, &priv->clk_bulk);
>+	if (ret) {
>+		dev_err(dev, "failed to get clocks: %d\n", ret);
>+		return ret;
>+	}
>+
>+	return 0;
>+}
>diff --git a/drivers/video/mediatek/mtk_disp_comp=2Eh b/drivers/video/med=
iatek/mtk_disp_comp=2Eh
>new file mode 100644
>index 00000000000=2E=2Ef538129b7cb
>--- /dev/null
>+++ b/drivers/video/mediatek/mtk_disp_comp=2Eh
>@@ -0,0 +1,34 @@
>+/* SPDX-License-Identifier: GPL-2=2E0-only */
>+/*
>+ * MediaTek display pipeline component helpers
>+ *
>+ * Copyright (c) 2026 BayLibre, SAS=2E
>+ * Author: Julien Stephan <jstephan@baylibre=2Ecom>
>+ */
>+
>+#ifndef _MTK_DISP_COMP_H
>+#define _MTK_DISP_COMP_H
>+
>+#include <clk=2Eh>
>+
>+struct udevice;
>+
>+/*
>+ * Common state shared by all the simple display pipeline components:
>+ * a register window and a bulk of clocks=2E @larb is an optional SMI la=
rb
>+ * device (UCLASS_MEMORY) enabled and disabled together with the compone=
nt
>+ * (used by the RDMAs, which are the DMA masters of this pipeline)=2E
>+ */

Thank you for providing all the information=2E

Could you, please, format it in Sphinx readable style=2E

https://docs=2Ekernel=2Eorg/doc-guide/kernel-doc=2Ehtml#structure-union-an=
d-enumeration-documentation

This will allow adding the header to doc/api later=2E

Best regards

Heinrich

>+struct mtk_disp_comp_priv {
>+	void __iomem *base;
>+	struct clk_bulk clk_bulk;
>+	struct udevice *larb;
>+};
>+
>+int mtk_disp_comp_probe(struct udevice *dev);
>+int mtk_disp_comp_enable(struct udevice *dev);
>+int mtk_disp_comp_disable(struct udevice *dev);
>+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val);
>+void mtk_disp_comp_update(struct udevice *dev, u32 offset, u32 val, u32 =
mask);
>+
>+#endif /* _MTK_DISP_COMP_H */
>

