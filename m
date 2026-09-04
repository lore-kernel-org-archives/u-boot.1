Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D778C79F87
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AEBB811D8;
	Fri,  4 Sep 2026 13:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q564ndFrP-v2; Fri,  4 Sep 2026 13:50:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4D86C811C9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529825;
	b=K2HwxGZloEesYQSLFC3YqagSnV7F5HyQ55zdTxG5xPEeMBQxnw8jES1K3wff6jbG1sqe
	 NQ40iEzi/LcLZ3GbOA+7S1QkEGQBfsYV2M05kjEZodKl9Um9FXU+P40YXQH7tR+NEsnns
	 P1kCDW0CKM3AT9d+jyrcCDLcZaCain9CkgvfQ/i6YJkfPO9jbqHB654zJsqq0NqjgNKBH
	 sRCL5h4T859SieOOKNlpUuPIDrDTkT7aDv1x8mEWv2ASZUkdABYEidwRnIs/uFltDKuwr
	 7JhoVlPzOlQyJZRy+N+2fZWdWo3vQ8lInB242Sco1144mVi/wFbqz2l8G/qPkPYIyfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529825;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=caA9vx20rUvQreQw3qBMFeDEh8vA0gPK8kBWb7sNDEY=;
	b=agvb/QNLbbzoZ0FSPdJvC5zsOnqN9+MPIcUn2jYM7o6iqPxr0u13r5J9RerDOn30+Ili
	 O9j5iTcF5Y6s4sLDKC15Y7GRqXYK7CTTYGK8r9nbYpDeEnsM9AYYqX3odeT96bbyJIfXf
	 WLYflKrhbQdMvymRkiLfc3LT7gTD3f+iV8EL7eBLLyvfBBi8x4FDYe+OmD9OOR/7AVBR/
	 miJe8GOzlIBk4i2m7GMjvBtj0pTf+OhsqQCS4YAspeE9k1mkTjBJyS89H3BK1FhX9IpWE
	 b+0Bivz+6ZAFsXkBjzpcMN5/qTvMwtI3vHggioyDwFA/3PjYx9veLiJHveyUErxJS3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529825;
	bh=caA9vx20rUvQreQw3qBMFeDEh8vA0gPK8kBWb7sNDEY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Emwuf93iN67SWdFrUe1OVQgRMkMpaZbiICke0/Pp3H8e7EWtFvZrCUdc1pIwgsn0Q
	 69MTUcrm93RPmatr5yqB3TbTIoCsEvTRWKVjJ5+9cmOfbY9iMwB/ubxDAetrMnM8il
	 qd1EfEl6ALuqS8l67KM+Dva0+EQd1nLtW9O3eaAUEPENG6eCl6AgdOzjhGqxgwkMwS
	 K7WVTr8WCLgM3vBazsydaRjgnJlbW6agOpioawMW5BVWZvqXOuIOQw9Nr1iW01jZPb
	 X29pn/Lw+RJNjntollmyP+yGwh9MvZPoymUpGWaFE1dzAdCdqOKp4vfuPpUratzCeT
	 04iMYVcTJhJPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D86C811C9;
	Fri,  4 Sep 2026 13:50:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB2633DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CFAC40B87
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ksGpYG3vytka for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A107B40B48
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529818;
 b=p45D35FnuGTUwY2oVEgq97jQxIuzgnQz1nXAuud/N9mydGSzwthRCPmprd8NG8+QPyLP
 9gndMeFwfYLOZe8oDvLMM4zQTnSxa+/uv6ynUWKPOGCyhNBpXJoxF2H77JfVVfag2fG74
 6xPzKYOUFfF2a033cTKJH4TXRps4nYU2oxR+3asJBEPr4Ug6kZ4e8lJ/3tdpRpRHR+15g
 oF2PhaUzrV5TCgwMb0jJu7vSDUwBaobRWbEy3yQzotGikX3QjtmDldx7xmGFk332haEei
 c33YFBZ6hn4dSvH4LImsIkw7vgYq88S0Ysf5FHZQ5rFhrkEfi9w4Qr3RnxLidaljsMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529818;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=caA9vx20rUvQreQw3qBMFeDEh8vA0gPK8kBWb7sNDEY=;
 b=A8N+FybNkhiJrlPhWoN7AIofqL7gHTi0NG2XyvTGbcv/dpzRk6MoXC1iFzwvpt+FKOpc
 q4IrJGY2isl7NOEBWgvnpVTpb/jyB6UbHWUauy1Bsh+l135SqrKQuD8BZDIjhsA3V8fAB
 BRXqhZ1/duFtqEQhEab6i9MHvNeXtuPEg56E2A+aSh4J/vEwnGhH7XQsfpvoFT0a//SUV
 rNnC4ZFC5rrFxE3FNfvthbhOGObkHleUjykvmvuMVoT2/wUhHFH5a7j3+Ih62N5j89f1M
 jFymijJp3IuzTr5hacIwQdDfmpuevBCeA/pKlT0DaZs7V6RHIYeGRK+lPDNFW1nVGig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nli1bHfK; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nli1bHfK
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A107B40B48
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:15 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4858595f997so649918f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529813; x=1789134613;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=caA9vx20rUvQreQw3qBMFeDEh8vA0gPK8kBWb7sNDEY=;
 b=nli1bHfK4r4MPhsaaZQYjeoYiVmbqDKOBtVCvx7STD0XFaOB+NwG4GwTa5KEA4xJzS
 eRURH968Wl353Ur/0Y6lqxB+HeTJixgrC140MSicVlxUDmUbODhQN8pyPwICygmrF3Jt
 FRjQ6FHvPHnDLMF3zRVY7zf5W1t/olJT+htAsmPhuhEABfgKzl1B7J7yRWYof3DaKU0B
 rH/MoTHLs5VNBdhHN7YoW2NQONMHTlMJF4nlE9y6mlxS9wbcqMmCFjNNDNlVEvTQRZxg
 XMv734HUPjMxo9ynCTCKB0XoPCyFR3KiAtvfBFFzWeKqtgBHE3seWSULl8Yab1OLJGxt
 qPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529813; x=1789134613;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=caA9vx20rUvQreQw3qBMFeDEh8vA0gPK8kBWb7sNDEY=;
 b=liHUSBl/MU7642jA0sXzCsKiVmfZx3Nwv8JRHRtPASxPXFHgGU+zm7XNMumVAGhUTt
 CgMHn4c60FzN3CIRtSOkhDo9EPsdc1GHCgFr/JYVlUc/SH5qnHx8sHnm+gdVLpccjKZe
 50U4fD/1QrRKQcILsskzD7cY6laj7vI5nMubd30BVVCdigo/L6QcOZvJg3HvXwlH5l6I
 a7fkchuNFnmYblPK+NiuUb+nrIRigL6HKiel9IrupKzS+UNOTDfARucChT62NaBqZ1wo
 SGJtZMyPIB3vVCbQDywTasHLLgc34wI5BXH+SPmL4Vxc8rQ4RUwgbeEUYfEbvEcS8lSP
 ZIlA==
X-Gm-Message-State: AFuF++lV4xrgeJiXsYrX7zmSHxRxCHz5MVvOei9n0U45ZlvyvBE1W4Fv
 EBA2iCUbqpkrKCryZevj35oCbZih8aclNYbaMYGb8hbAzKGcmJGqB5GaOOYFnMW10o8=
X-Gm-Gg: AYBFou3RU3UP+zQzRfWfOjiYaYRMfAKu/EHGioq9xknQS+VKlVYWAEzPiea6B4ZGj87
 yQFP2a7K1xbTub7aqft4UpJJcqsK9i8TxOvg0SRWAI6nZ8eJEPGFQiDQT8NxslZZsuJEquIYgnb
 y2hn5PUvAPoiYmGrWSK0JL71eHkYyLdgbgjgVKR89JOFERG5ZusHDXc3DH7gcALilmHwJA0tims
 pZD6XklmK3uAnkhJPhOO8GyPS0uq3yQjoXvulLsRwCdRqIFAOvAmTzj3A0IAn/4aCygx2ZIWjdL
 HoD8YYZ92Zbp2mkMEupyV7rNenimLhgimdDAZZiJ1F6rhAF9kvTFkVtfP3Ad22VxizMx9T0vYyJ
 PTaarrVM/O+pGjKhqtJfrJ/kcyiElOEGOMcbkYE27Wfp9y90OCEqQpwTas0eFVounYBDggoWGap
 umFuZiiB6XCE29j/Ygr9plg2Kmj7AWMUwLXy2Nvboqovk9fq0fmgGchN3GDWifp8OHZ2fw21/Qn
 Amy36ixge5Em4BOddpUOG6n5OY0fBE9D6cPhjLH+SvlXofartz2zFzM4i9jJKAZaAeeuZfKYkf/
 cf4t/kuLPbEmTH360onmnGeaLs7EYi1bEvEIzeI+ix/zOFoG7AeThCA=
X-Received: by 2002:a5d:64c2:0:b0:482:e968:86f9 with SMTP id
 ffacd0b85a97d-4858708cae2mr13827359f8f.14.1788529811248; 
 Fri, 04 Sep 2026 06:50:11 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:10 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:09 +0200
Subject: [PATCH v5 03/13] video: mediatek: add display pipeline component
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-3-dd9dde2f972e@baylibre.com>
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
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

Most of the simple display pipeline components share the same probe and
enable sequence: remap the register window and enable a bulk of clocks.
Add the mtk_disp_comp helpers holding this boilerplate so each component
driver only has to provide its own component-specific programming.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.c | 90 ++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_comp.h | 34 +++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
new file mode 100644
index 00000000000..d41440f06ab
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek display pipeline component helpers
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <mtk_smi.h>
+
+#include "mtk_disp_comp.h"
+
+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+
+	writel(val, priv->base + offset);
+}
+
+void mtk_disp_comp_update(struct udevice *dev, u32 offset, u32 val, u32 mask)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	void __iomem *reg = priv->base + offset;
+	u32 tmp;
+
+	tmp = readl(reg);
+	tmp = (tmp & ~mask) | (val & mask);
+	writel(tmp, reg);
+}
+
+int mtk_disp_comp_enable(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* ungate the feeding SMI larb first, if any */
+	if (priv->larb) {
+		ret = mtk_smi_larb_enable(priv->larb);
+		if (ret)
+			return ret;
+	}
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		if (priv->larb)
+			mtk_smi_larb_disable(priv->larb);
+		return ret;
+	}
+
+	return 0;
+}
+
+int mtk_disp_comp_disable(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_disable_bulk(&priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to disable clocks: %d\n", ret);
+
+	if (priv->larb)
+		mtk_smi_larb_disable(priv->larb);
+
+	return ret;
+}
+
+int mtk_disp_comp_probe(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	ret = clk_get_bulk(dev, &priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/video/mediatek/mtk_disp_comp.h b/drivers/video/mediatek/mtk_disp_comp.h
new file mode 100644
index 00000000000..f538129b7cb
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek display pipeline component helpers
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_COMP_H
+#define _MTK_DISP_COMP_H
+
+#include <clk.h>
+
+struct udevice;
+
+/*
+ * Common state shared by all the simple display pipeline components:
+ * a register window and a bulk of clocks. @larb is an optional SMI larb
+ * device (UCLASS_MEMORY) enabled and disabled together with the component
+ * (used by the RDMAs, which are the DMA masters of this pipeline).
+ */
+struct mtk_disp_comp_priv {
+	void __iomem *base;
+	struct clk_bulk clk_bulk;
+	struct udevice *larb;
+};
+
+int mtk_disp_comp_probe(struct udevice *dev);
+int mtk_disp_comp_enable(struct udevice *dev);
+int mtk_disp_comp_disable(struct udevice *dev);
+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val);
+void mtk_disp_comp_update(struct udevice *dev, u32 offset, u32 val, u32 mask);
+
+#endif /* _MTK_DISP_COMP_H */

-- 
2.55.0

