Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5690C98302
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 04:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6780E6077B;
	Wed, 23 Sep 2026 04:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wczARWl_vgR; Wed, 23 Sep 2026 04:56:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 61CBE6067F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790139407;
	b=asWhrutRU8rnxL68ih+dYCJBUekoWbOPZy5+FB41sXNoy9ktVEMF63rAFQDjflkh05MT
	 XrS98CknUSmXtiFnUv5U7j7xZV59KNkNa6f85AxdGZCpGe0X4mEflJoNFk9HkVxxZNDlX
	 4W5q1qgPd9WFs7FRU4A5RvwXJOS8j9vAqPjuXYb1xlSv1qBo19175KBUeJc/0UTA8xeV/
	 mt8sl6onu0Nlrp/MOYXrtEnv2CoswRAaSF9330LgmHin+swFzGhVU+TDqizPTa+MLHWbm
	 NrdrP4IomATMthqoNbLer3zGQpxBAznfYXDY57W3McKJfowdo83LYe1wqJDs72kujZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790139407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=64uJ0enajOphWgr/QRJ0CYeElLkXoHvl0VS1WYKKe7U=;
	b=Q5DxWJ2PufOU0dypZ0aClwiUUFEg2RS/1BVYCNoQlpUut0be5xrwI+0HUGK1F4JkSFDx
	 ye3/Ff1LbbzXUuC0PMcphBXas60q0IV+zSNtykmKXUlKOQghxDvRb//Dt+yab1qI/GMSQ
	 eBQ9DFhpEoDgkK7Dd1vo+gNAQweErMDv5Pzm5CeFx98aBhVykfqSwn/HRUBF340kVvYyz
	 LAZNKDF8VSDZQXIMHs49cePoQUttwnLZcWixyKWSgqisc1m6Aii3Nd/UOWFpw+4HVxH6A
	 LTccvLTkGCG6Zc1fa720YMNpgctzWZ8qDv+KOtAzcQ8KAQdZMdVjsVNR76/NGGjYznQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790139407;
	bh=64uJ0enajOphWgr/QRJ0CYeElLkXoHvl0VS1WYKKe7U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GTlcncMoqXe7GoL7KiQ03tHEbdW4ttlzFj5LCLSHaQTbxUDlcGaDmqntC2n1xvjAo
	 kuvl3MzyNdGEA2v8BPf9IgJU7ilgRfw4YGVCUZ3AXCzf1B5FfjW7DweN33vfOFPBan
	 p3YjSWays3fmrO7oiMoYQMDM4PfNCAhYto1+DKsZmZy68zlCw1877mF54eMEub+zu6
	 4in7Zbazec35asQwo0fMsHu9L4zswTK9AdbSzRtxYwWEwf94DhQ6Go4KRkvczbB+4g
	 ho5pbcwFkc7nBVFn6zf/RntS9dbzuAb3/u+ZVqopXqkn/Q0XS6khi1QbJGXncAFRa4
	 ecHp5nErwh2sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61CBE6067F;
	Wed, 23 Sep 2026 04:56:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 923403A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 04:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8380580CB6
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 04:56:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DD7Wzjq9LxHA for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 04:56:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E7DD8808C5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790139404;
 b=lEORYx5os1wWxdlDZYcqH1AmP0+HV4K+seBzs/pAaEEZfbCuyBdqyufhik8Jmt174sXQ
 mk6BIOVhyGk4IcW1WasvSsVXjc3sGprmJQfyEtyNBrPCUyJW8HZfB14PA23Ip6i12yft1
 agqkba+5FQ7AQinqS299pS6TJuSw3Q93IwR0echBxX8n+K7auPT24RB8VZ9Q9lsHPiEYY
 rajjWJthLF9KuQKjDZS0bF3cROVtIW89ADXMMjbstyCcufklifwy8+XCx8qX2fei49G1b
 htZuoHdFji1i/VVy+x/CufX4t5mUc52PAW/3emW6YA8KfMLS3wmtz9boIfh67D0APjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790139404;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=64uJ0enajOphWgr/QRJ0CYeElLkXoHvl0VS1WYKKe7U=;
 b=Karny9Y7wCiPzeHTnZl9ngW6C3fBvqbpWTiRJlOQ9KDhCYeA1k1I8X2x1QJM+a6L8E2X
 Z25+C7hQIAcr/Ph/VrGbo6KAE025gWMZYOOSJbycS+8wAI78LpDa/2ockTPb9vMPQZIGv
 5xDGe7rrIvuBNd/lqUKS5AM7ZQD9Hena8TiOc6lPus/dl4HY2Co1op2KoeG63C6qX6ynQ
 0bNSKvucSe5OFVFrTWM6kmmn9jW/CLaEhLNGd9hWVcq8edErZMBFhfm3ITntuQmU2jRLu
 4hxyLu5e9reW7S9tdDeyuhzjiFlTRkow0wIJTJsjmfQ2nhKhFIEYWViu21V6LwPtq3w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=mRr0S+Nt; 
 arc=none smtp.remote-ip=212.227.17.22
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.22;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=mRr0S+Nt
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7DD8808C5
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 04:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790139380; x=1790744180; i=xypron.glpk@gmx.de;
 bh=64uJ0enajOphWgr/QRJ0CYeElLkXoHvl0VS1WYKKe7U=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mRr0S+NtW08ndvyBl8ZMr+uFQqu2Yk6T40k+wHidbtkuMUO/PS6GwKhRznBIyPk8
 tf9XZjwHRLH5pEZ5lof0UUTNTTMDR7A7cv96v8FL50bap2UE2ehnohomCcXVQbW76
 5efWZQpcAd+YfarxKcY2tmerONXE9hm8ut/Zw5KfNS80s6WzhT9scCL1spBgRd0Bl
 J26JnzUMUug57ORmYmCaU5HKKS1S9+QYvCzhRLOQH66wSxerGQ3BRE97G4rgM5v8D
 mrKS6FcjeaNF/8njG4UuPMlA2wLRqgsiilFs+R1/22oGi47qDN2rLSzts0cn1yrJE
 Yl5aSZChbmguwB/85g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1wo7ba2SA9-017MFR; Wed, 23
 Sep 2026 06:56:20 +0200
Date: Wed, 23 Sep 2026 06:56:12 +0200
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
Subject: Re: [PATCH v5 04/13] video: mediatek: add ethdr component
User-Agent: Thunderbird for Android
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-4-dd9dde2f972e@baylibre.com>
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
 <20260904-add-genio-510-and-genio-700-hdmi-v5-4-dd9dde2f972e@baylibre.com>
Message-ID: <07974913-239B-419F-A9BD-A1D72A0549B4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pGhpmFh1tVNItkb5+hu2HF3WNOC/V+Q224+ayz8CFVL2HVYNXXa
 e2ay25GdUEnpnNp7/03TftyfRnTa1o8i6G4tUggfdWE8DBQgbse8clxqVT98YZmYqB3VHwa
 mccERGNXx8fgucQ7FEb0g8AE8koLhB5H9ebLdlalwqzpCP+wzGe5TBg2foLLQTD3j6JfTLq
 2+ZW4NYgdZPY1jYCOB/9A==
UI-OutboundReport: notjunk:1;M01:P0:y90h5Orl5xQ=;kpEnpnLsukLVeTUbLfRKa0o/Hd0
 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
 40eghjykDukU5
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

Am 4=2E September 2026 15:50:10 MESZ schrieb Julien Stephan <jstephan@bayli=
bre=2Ecom>:
>The ETHDR is one of the components of the video pipeline on some
>MediaTek SoCs, such as the MT8188=2E Two of its sub-blocks are used: the
>mixer, which is the block's first register window and does the
>compositing, and the HDR video back-end, which sits on the same data
>path and is put in bypass since this pipeline does no tone mapping=2E
>
>Signed-off-by: Julien Stephan <jstephan@baylibre=2Ecom>
>---
> drivers/video/mediatek/mtk_ethdr=2Ec | 104 +++++++++++++++++++++++++++++=
++++++++
> drivers/video/mediatek/mtk_ethdr=2Eh |  27 ++++++++++
> 2 files changed, 131 insertions(+)
>
>diff --git a/drivers/video/mediatek/mtk_ethdr=2Ec b/drivers/video/mediate=
k/mtk_ethdr=2Ec
>new file mode 100644
>index 00000000000=2E=2E08ce5fbf518
>--- /dev/null
>+++ b/drivers/video/mediatek/mtk_ethdr=2Ec
>@@ -0,0 +1,104 @@
>+// SPDX-License-Identifier: GPL-2=2E0-only
>+/*
>+ * Mediatek Video ETHDR support
>+ *
>+ * Copyright (c) 2026 BayLibre, SAS=2E
>+ * Author: Julien Stephan <jstephan@baylibre=2Ecom>
>+ */
>+
>+#include <asm/io=2Eh>
>+#include <dm=2Eh>
>+#include <errno=2Eh>
>+#include <linux/bitops=2Eh>
>+
>+#include "mtk_disp_comp=2Eh"
>+#include "mtk_ethdr=2Eh"
>+
>+#define MIX_EN				0xc
>+#define MIX_ROI_SIZE			0x18
>+#define MIX_DATAPATH_CON		0x1c
>+#define OUTPUT_NO_RND				BIT(3)
>+#define SOURCE_RGB_SEL				BIT(7)
>+#define BACKGROUND_RELAY			(4 << 9)
>+#define MIX_ROI_BGCLR			0x20
>+#define BGCLR_BLACK				0xff000000
>+#define MIX_SRC_CON			0x24
>+#define MIX_L_SRC_CON(n)		(0x28 + 0x18 * (n))
>+#define NON_PREMULTI_SOURCE			(2 << 12)
>+#define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
>+#define MIX_FUNC_DCM0			0x120
>+#define MIX_FUNC_DCM1			0x124
>+#define MIX_FUNC_DCM_ENABLE			0xffffffff


Could you, please, provide a Sphinx style comment for each constant to mak=
e the code maintainable=2E=20

>+
>+/* HDR video back-end registers, in the "vdo_be" register window */
>+#define HDR_VDO_BE_0204_VDO_DM_BE	0x204
>+#define HDR_VDO_BE_0204_BYPASS_ALL		0x7e
>+
>+/* Fields used by this driver but not present in the upstream driver */
>+#define MIX_SRC_L2_EN				BIT(2)
>+#define L2_SRC_SEL				(2 << 20)
>+#define L2_OUT_SEL				(2 << 22)
>+
>+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height)
>+{
>+	struct mtk_ethdr_priv *priv =3D dev_get_priv(dev);
>+
>+	/*
>+	 * The HDR video back-end sits between the mixer output and the final
>+	 * merge, so put it in bypass: this pipeline does no tone mapping=2E
>+	 */
>+	writel(HDR_VDO_BE_0204_BYPASS_ALL,
>+	       priv->vdo_be + HDR_VDO_BE_0204_VDO_DM_BE);
>+
>+	/* enable internal clocks */
>+	mtk_disp_comp_write(dev, MIX_FUNC_DCM0, MIX_FUNC_DCM_ENABLE);
>+	mtk_disp_comp_write(dev, MIX_FUNC_DCM1, MIX_FUNC_DCM_ENABLE);
>+
>+	/* enable mixer */
>+	mtk_disp_comp_write(dev, MIX_EN, 0x1);
>+
>+	mtk_disp_comp_write(dev, MIX_ROI_SIZE, (height << 16) | width);
>+	mtk_disp_comp_write(dev, MIX_DATAPATH_CON,
>+			    OUTPUT_NO_RND | SOURCE_RGB_SEL | BACKGROUND_RELAY);
>+	mtk_disp_comp_write(dev, MIX_L_SRC_SIZE(2), (height << 16) | width);
>+	mtk_disp_comp_write(dev, MIX_ROI_BGCLR, BGCLR_BLACK);
>+
>+	/* only configure L2 since only rdma4 and rdma5 are used */
>+	mtk_disp_comp_write(dev, MIX_L_SRC_CON(2), NON_PREMULTI_SOURCE);
>+	mtk_disp_comp_write(dev, MIX_SRC_CON,
>+			    MIX_SRC_L2_EN | L2_SRC_SEL | L2_OUT_SEL);
>+}
>+
>+static int mtk_ethdr_probe(struct udevice *dev)
>+{
>+	struct mtk_ethdr_priv *priv =3D dev_get_priv(dev);
>+	int ret;
>+
>+	ret =3D mtk_disp_comp_probe(dev);
>+	if (ret)
>+		return ret;
>+
>+	priv->vdo_be =3D dev_remap_addr_name(dev, "vdo_be");
>+	if (!priv->vdo_be)
>+		return -EINVAL;
>+
>+	return 0;
>+}
>+
>+static const struct udevice_id mtk_ethdr_ids[] =3D {
>+	{ =2Ecompatible =3D "mediatek,mt8195-disp-ethdr" },
>+	{ }
>+};
>+
>+/*
>+ * The mixer is the first register window ("mixer" in reg-names) of the
>+ * ethdr block, so binding the ethdr node with default register index 0
>+ * gives the mixer registers=2E
>+ */
>+U_BOOT_DRIVER(mtk_ethdr) =3D {
>+	=2Ename	   =3D "mtk_ethdr",
>+	=2Eid	   =3D UCLASS_MISC,
>+	=2Eof_match  =3D mtk_ethdr_ids,
>+	=2Eprobe	   =3D mtk_ethdr_probe,
>+	=2Epriv_auto =3D sizeof(struct mtk_ethdr_priv),
>+};
>diff --git a/drivers/video/mediatek/mtk_ethdr=2Eh b/drivers/video/mediate=
k/mtk_ethdr=2Eh
>new file mode 100644
>index 00000000000=2E=2E4a1bae3ddbf
>--- /dev/null
>+++ b/drivers/video/mediatek/mtk_ethdr=2Eh
>@@ -0,0 +1,27 @@
>+/* SPDX-License-Identifier: GPL-2=2E0-only */
>+/*
>+ * Mediatek Video ETHDR support
>+ *
>+ * Copyright (c) 2026 BayLibre, SAS=2E
>+ * Author: Julien Stephan <jstephan@baylibre=2Ecom>
>+ */
>+
>+#ifndef _MTK_ETHDR_H
>+#define _MTK_ETHDR_H
>+
>+#include "mtk_disp_comp=2Eh"
>+
>+/*
>+ * @comp must be the first member: the shared component helpers cast the
>+ * private data of every pipeline component to struct mtk_disp_comp_priv=
=2E
>+ * @comp holds the "mixer" register window, @vdo_be the HDR video back-e=
nd
>+ * one=2E
>+ */

Please, use Sphinx style descriptions=2E

https://docs=2Ekernel=2Eorg/doc-guide/kernel-doc=2Ehtml#structure-union-an=
d-enumeration-documentation

Best regards

Heinrich

>+struct mtk_ethdr_priv {
>+	struct mtk_disp_comp_priv comp;
>+	void __iomem *vdo_be;
>+};
>+
>+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height);
>+
>+#endif /* _MTK_ETHDR_H */
>

