Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8E5CA5FE3
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 594C160BBC;
	Fri,  2 Oct 2026 13:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kbp_Z20Rf3lD; Fri,  2 Oct 2026 13:22:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4FDAE60894
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947378;
	b=LkwpFAmJss40xRP0rQ7LbRF8vS4VkqyvRGMyUEg+3OoHb7CtzOcbvHNWVeDAu0NCA5Hh
	 lFW0F5xXBhL/bO+O1kACjNk21Cp11xuWygTN/QHPkH6Ru3W7IdHxF4UC4Yb47yvZNIAun
	 Kz4RkOKsEYsRDrQg8fYf2CmOI1gBnKWQUF1dR5O2rO6DM2aiEP9sxxL7oowy7UR5vWy1C
	 kXgNv8+n8S3OdWWr+taBXYaMHCFc6w8Fw0wS7QiNffcTf7bHgTe9RkgHHCeYmdl7Wd0ki
	 3QcYrvTFxWG2KY11lc0F9NEQ2gZ/5FZJekxt3j93S8xAwoE4YZx3Ya+EECmUBffxq/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947378;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LTDso2wElIQ6IbgpB8gagDDoLLdu66vELgnfyLiS05Q=;
	b=EA9RI9PCGJndd9YEYnGqmOQvPsj6FQJcdFPwhls3hXsxGygEP9saEzV7v/tX/eWNsgKN
	 IlVCagzubL2i4DnIFJd6vGLWuE3NyqFh9AKsU1bW1jedyJaqXSIlVtyLA564st4/kPhM2
	 Rm7iY5oNyRh59gEcOBEDARDOXckRMM9tUxyHrjfF7otUXBu+8/c+b+JuqDSEMLSjehxna
	 CahsR9I1bNNKErxEi0ZjbWDio+F7r9OHBr72peunsbxUg8NTWDnKt7rZe1s8wVAgaSO4f
	 S5F1F7kO0jM2v6lxO7SsRPNVGlId+5DDOpq4r2JnXzl0bqEjhvo+YFW2GAF6Nv5B9Fg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790947378;
	bh=LTDso2wElIQ6IbgpB8gagDDoLLdu66vELgnfyLiS05Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tVG09Pj6ulm2ROTBo8Z9+X22mG7h+wQ7IMR18bzTZwB2Z1pCwmQbZ+2XxB2PMPIuX
	 mdK06f2iun2co2s/NVzd330kflhQRjOGHlhDCY8ETMtr2XbKTbUrufZvl6j5Fax5sm
	 UOZIlSIQbv+mOqF7beTX9vcknSfA3Z9NjO0GRAOtwWX+Pv7NTd/SOCtTGm8L1zygqr
	 WfOqrMsqQHjBE1tBO90Z74hP6Rjua+bkF1Zb3sgP3lntne8qofcD3aYv/2uH+0h9XL
	 2cPJAEe9cfIyXpavy2nd5w350qg7t61MZNZE24ex9JH3A/Wllnm89RZ/0CbP2Urv3l
	 reF+vM+57EvsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FDAE60894;
	Fri,  2 Oct 2026 13:22:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CD4234D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E83C40B53
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id You8pqVcictM for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:22:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5E64640B12
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947373;
 b=ZN98DZoXhK8W/38mto07ug2gqRrgR7a7fz0BvM7rXfIJSTS+eGHDruAVy4ZwpmspOoMk
 4FwpnjTc7IBK44x6+pRA3mdH4/CRfAJzHmXQa37GfrtZr7zMuKdnfLipIzQIWve7nRQzN
 dLMkdAFgC77y9y/S7bkm+Mhb2iX2XqYtVFkj+v1UpJOuKW1PuJ1aclT62PRWsf82cFurx
 dsEedgv67qoW+DpTU9Mv2QWYQxVblRTRrg+Bx+6TXgnW6T7zb8IwUFZAiXVzZOdtxbC/Z
 9EyGDwkIFIFZNq68hibqhHzSzMxPx8v0NvMl6IqZyN2hfLK6Rc5rZqylmr27ydtz5Hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947373;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=LTDso2wElIQ6IbgpB8gagDDoLLdu66vELgnfyLiS05Q=;
 b=qpeCVoj0jaJEUx4LdgQ3gE6hBY0U2zJkwvOz6NrYXDFJicVpAFvMj0gQNmLiA4HGS2mo
 /OAH8+sQO1gPobVb+o1cLRJA2yKRBiYG++437JYCOCXgbPzYcFYsdrdYqXfMzjZ0w5vG3
 B+jX1lxvLIEF9iUL4iMxIa+dHNZIjgAmmU6+weh91tDormJz3LJ6ynpOMRIXOiG99lqlc
 YRnASfd8LWvO4zYqn3UMvyrrnZ8bUuwJj1nRjyziqdn+m6GqZeeh42o9mRoPBDmRPOT/+
 A85SZn6Tpi1iudek1+Hm5no47BwH+HGYxcEUq7YTepHG0sIEqegqSilbhyI9rV4R1hg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NNZ5ILdt; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NNZ5ILdt
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E64640B12
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:52 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b08452cafso1526780f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790947371; x=1791552171;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LTDso2wElIQ6IbgpB8gagDDoLLdu66vELgnfyLiS05Q=;
 b=NNZ5ILdtUkHdeBCXEkM58F4rxQpoxiO3Yxch/CWOYPUMejjLF2KRfcZc1g7gmDhd76
 enMPZnrvkFDGsIBoU7uF99kne77TtUib+nOGyECloihIBkJKI9VNU9e+iDqS9cIL4NOf
 cpc/hlkG5ksiVHN4AtiqhlpI6K516GM0CL2+WLISJXgwDjCK1z6/eELgkH5gGye0Gf+F
 wMQPiRlDKdorrfxi0mUuRNBeSM+q39HZwZ8JO9sNBZB91he2TIjn9pTn3DN2TPcfLTmy
 TlXeg/wzRget5osT6W7gR0KBcu4mFy3CInbecVA6Cw8cEfvul5AwnPIfYcZiX5nkGwxv
 Q9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947371; x=1791552171;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LTDso2wElIQ6IbgpB8gagDDoLLdu66vELgnfyLiS05Q=;
 b=KXG6G3JKUMDQHHIL5/+XVw5MXzw+K0llnHMy1xg1Y/SZ5cTwBT2DbzXa7zovOO6b3o
 CV7rwpJxWeYLTU3BOa2RNfvqqSDGjAcPhJ3ermrAKUu/GeSH3NRqFRpy1k7Xz4WU3aHb
 oVLJhL3d+nJv33xGMmpXeuV2Dq8rvkwU8Y/WCqkvoODAQqB0My5tQHqD8L5dDL8SXh7U
 TivoD+xQuGrBXrzE0M5hVDDLr47PP4XTvODeyEpvR4QYzoBN+fgfab8knO4kB1x8lea0
 BllnXeodFKmfkGC/C/Ph9kJUPnfjEx9NNvxUoRuywuVx4MbiWJd0Z/v4GblmMCG0iX0Y
 EwmA==
X-Gm-Message-State: AFq9FYIwZZ2z34/c32LlgyUuATwUkR8aGa9cnWeEcjmpGzB2NMtQ4G3X
 yT3jDS7LqZawP4rFEZ4xZwDyV5EbF7/EkTi084K3oM/a5kPcVTDSxA/RW4IF9ylaFqw=
X-Gm-Gg: AYBFou29ytwLFDOCT2owWrx4evhKB3uW4hO0MOO+V+k+zj4LvpBQpq6APlYV6d8RdNf
 3E3PFMfkrUBUp4i4ZaDAK4b/OUDylx13wOyhZz7ggvOnCrqScHRpwB7ub/x/sPayvNbfErW+3wp
 9dFmfFM8zURR+JFBPgUV/ZS9sUDnpypag4BdZaGT7joV0bG0Yufb0MZ6HVn8e3HFLw58jjlTaNo
 tw9+5qTTXgt163h2bR8e2G4OBG78+w31bCv0MXeyOP/eIZ8uSgt6v9zYh4Mt3j5USvxlaRHNh5S
 3t+00Q25tZcgSh0IzvWRdrvpFL9wwQyoiwd2s0gg9F0G94EnqY+rSOX8Bnw5hk9kAjIu/ot5g8O
 DwzZ+L02Cb1Z+4D3UpLa19h8Dh9F8w6Q4mQG7jLwt8Wp+5U5KVJxSdZHop9hPKyP1gXxXYaw1sw
 KDtdNHXx2i6u/4snYrQD7elOpBmgKTtzv7PNUybQj9R98AgbCda5Wmxxlq4QMQw+EZJDdw1iXwb
 n9wpCnU8Hh/q2vfUa9uCyXMtMekHNMXhmxBEvHMFt5rlaLWppS+S4a65iCDmJs6rmulrOsNAmzK
 xms5wthFrOzHvzbqvMhd2ENiI/KQRkWzK6V8aXexi8L5pfmc7JgzwY4=
X-Received: by 2002:a05:6000:230e:b0:488:89ad:56b8 with SMTP id
 ffacd0b85a97d-48b1256f84dmr5756845f8f.0.1790947370945; 
 Fri, 02 Oct 2026 06:22:50 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6264125f8f.30.2026.10.02.06.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:22:50 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 15:25:36 +0200
Subject: [PATCH v8 02/12] memory: mediatek: add SMI larb driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-add-genio-510-and-genio-700-hdmi-v8-2-2a6de7cf2a88@baylibre.com>
References: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
In-Reply-To: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
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
 Anshul Dalal <anshuld@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790947536; l=8406;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=lGK6QyPUkSuAErXlE50wWae9TdAVM55g5XbDVtzDVqA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGjeVwqUfPCVsT04oz6i9enaQE4C4tPhb6/V2NxoUz8u/zNB/up1svtf0odVRP6edLDqAaYWGzK
 NUBVgz3VwaQU=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

The SMI local arbiters (larbs) gate a multimedia subsystem's access to
DRAM. On the MT8188 the display data path feeds through the VDO1 larbs
(larb2 and larb3), whose clocks must be ungated for the HDMI pipeline to
reach the framebuffer.

There is no dedicated SMI larb driver upstream, as Linux handles the
larbs through its SMI/IOMMU framework (drivers/memory/mtk-smi.c). Add a
minimal U-Boot driver that ungates the clocks of one larb, and export
mtk_smi_larb_enable() and mtk_smi_larb_disable() so that the DMA master
behind a larb can tie it to its own lifetime.

The larbs are not video devices: they serve every multimedia master
(display, video codec, camera, MDP), so the driver lives in
drivers/memory with its own Kconfig symbol rather than being built as
part of one master's driver. Every "mediatek,mt8188-smi-larb" node
binds, which is cheap, and a larb is only probed once a master asks
for it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/memory/Kconfig   |  12 ++++
 drivers/memory/Makefile  |   1 +
 drivers/memory/mtk-smi.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++
 include/mtk_smi.h        |  37 +++++++++++
 4 files changed, 214 insertions(+)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 5f029fd3e70..738b32aa83d 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -20,6 +20,18 @@ config ATMEL_EBI
 	  driver. Doesn't provide an access to EBI controller. Select
 	  this option to enable the NAND flash controller driver
 
+config MTK_SMI
+	bool "MediaTek SoC Memory Controller driver"
+	depends on ARCH_MEDIATEK && DM
+	select ARM_SMCCC
+	select MEMORY
+	help
+	  Enable support for the SMI local arbiters (larbs) found on
+	  MediaTek SoCs such as the MT8188. A larb gates the DRAM access of
+	  the multimedia masters behind it: this driver ungates its clocks
+	  on behalf of these masters and, where the secure world owns the
+	  port configuration, asks it to take the larb out of the IOMMU.
+
 config SANDBOX_MEMORY
 	bool "Enable Sandbox Memory Controller driver"
 	depends on SANDBOX && MEMORY
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index d5f5b073672..f33d8acd5b2 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -1,6 +1,7 @@
 
 obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
 obj-$(CONFIG_MEMORY) += memory-uclass.o
+obj-$(CONFIG_MTK_SMI) += mtk-smi.o
 obj-$(CONFIG_SANDBOX_MEMORY) += memory-sandbox.o
 obj-$(CONFIG_STM32_FMC2_EBI) += stm32-fmc2-ebi.o
 obj-$(CONFIG_STM32_OMM) += stm32_omm.o
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
new file mode 100644
index 00000000000..4531d416861
--- /dev/null
+++ b/drivers/memory/mtk-smi.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek SMI local arbiter (larb) driver
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <linux/arm-smccc.h>
+#include <mtk_smi.h>
+
+/*
+ * On the newer larbs the mmu_en bits of SMI_LARB_NONSEC_CON live in the
+ * secure world, where "the mmu_en bits of LARB_NONSEC_CON have no effect",
+ * as the Linux driver puts it. Which ports of a larb go through the IOMMU
+ * is told to the secure monitor instead; U-Boot sets up no page table, so
+ * it asks for none, and the DMA masters use physical addresses.
+ */
+#define MTK_SIP_SMC_CONVENTION		(IS_ENABLED(CONFIG_ARM64) ? \
+					 ARM_SMCCC_SMC_64 : ARM_SMCCC_SMC_32)
+
+#define MTK_SIP_KERNEL_IOMMU_CONTROL	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+							   MTK_SIP_SMC_CONVENTION, \
+							   ARM_SMCCC_OWNER_SIP, 0x514)
+#define IOMMU_ATF_CMD_CONFIG_SMI_LARB	0
+
+/**
+ * struct mtk_smi_larb_data - per-SoC larb data
+ * @port_sec_ctl: the port mmu_en bits are controlled by the secure world
+ */
+struct mtk_smi_larb_data {
+	bool port_sec_ctl;
+};
+
+/**
+ * struct mtk_smi_larb_priv - private data of an SMI larb
+ * @clk_bulk: clocks of the larb
+ * @data: per-SoC larb data, NULL when there is none
+ * @enable_count: number of DMA masters that enabled the larb
+ *
+ * The SMI local arbiters gate a multimedia subsystem's access to DRAM. Linux
+ * handles them as part of its SMI/IOMMU framework (drivers/memory/mtk-smi.c);
+ * U-Boot has no such framework, so this minimal driver only ungates the larb
+ * clocks on behalf of the DMA master sitting behind it.
+ */
+struct mtk_smi_larb_priv {
+	struct clk_bulk clk_bulk;
+	const struct mtk_smi_larb_data *data;
+	unsigned int enable_count;
+};
+
+static const struct mtk_smi_larb_data mt8188_larb_data = {
+	.port_sec_ctl = true,
+};
+
+static int mtk_smi_larb_bypass_iommu(struct udevice *dev)
+{
+	struct arm_smccc_res res;
+	u32 larb_id;
+	int ret;
+
+	ret = dev_read_u32(dev, "mediatek,larb-id", &larb_id);
+	if (ret) {
+		dev_err(dev, "cannot read mediatek,larb-id: %d\n", ret);
+		return ret;
+	}
+
+	/* the fourth argument is the mask of the ports using the IOMMU */
+	arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL, IOMMU_ATF_CMD_CONFIG_SMI_LARB,
+		      larb_id, 0, 0, 0, 0, 0, &res);
+	if (res.a0) {
+		dev_err(dev, "cannot take larb %u out of the iommu: %ld\n",
+			larb_id, res.a0);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int mtk_smi_larb_enable(struct udevice *dev)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* several DMA masters can sit behind the same larb */
+	if (priv->enable_count++)
+		return 0;
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		goto err;
+	}
+
+	/* as in Linux, only talk to the secure monitor once the larb is on */
+	if (priv->data && priv->data->port_sec_ctl) {
+		ret = mtk_smi_larb_bypass_iommu(dev);
+		if (ret)
+			goto err_disable_clks;
+	}
+
+	return 0;
+
+err_disable_clks:
+	clk_disable_bulk(&priv->clk_bulk);
+err:
+	priv->enable_count = 0;
+
+	return ret;
+}
+
+int mtk_smi_larb_disable(struct udevice *dev)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!priv->enable_count)
+		return -EINVAL;
+
+	if (--priv->enable_count)
+		return 0;
+
+	ret = clk_disable_bulk(&priv->clk_bulk);
+	if (ret)
+		dev_err(dev, "failed to disable clocks: %d\n", ret);
+
+	return ret;
+}
+
+static int mtk_smi_larb_probe(struct udevice *dev)
+{
+	struct mtk_smi_larb_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_bulk(dev, &priv->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	priv->data = (const struct mtk_smi_larb_data *)dev_get_driver_data(dev);
+
+	return 0;
+}
+
+static const struct udevice_id mtk_smi_larb_ids[] = {
+	{
+		.compatible = "mediatek,mt8188-smi-larb",
+		.data = (ulong)&mt8188_larb_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_smi_larb) = {
+	.name	   = "mtk_smi_larb",
+	.id	   = UCLASS_MEMORY,
+	.of_match  = mtk_smi_larb_ids,
+	.probe	   = mtk_smi_larb_probe,
+	.priv_auto = sizeof(struct mtk_smi_larb_priv),
+};
diff --git a/include/mtk_smi.h b/include/mtk_smi.h
new file mode 100644
index 00000000000..b0166b37538
--- /dev/null
+++ b/include/mtk_smi.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek SMI local arbiter (larb) API
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_SMI_H
+#define _MTK_SMI_H
+
+struct udevice;
+
+/**
+ * mtk_smi_larb_enable() - ungate an SMI local arbiter
+ * @dev: larb device
+ *
+ * Enable the clocks of the larb so that the DMA master behind it can reach
+ * DRAM. Calls are refcounted, so several masters can share one larb.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_smi_larb_enable(struct udevice *dev);
+
+/**
+ * mtk_smi_larb_disable() - gate an SMI local arbiter
+ * @dev: larb device
+ *
+ * Drop one reference taken by mtk_smi_larb_enable(), and disable the larb
+ * clocks when it was the last one.
+ *
+ * Return: 0 on success, -EINVAL if the larb is not enabled, or another
+ * negative error code
+ */
+int mtk_smi_larb_disable(struct udevice *dev);
+
+#endif /* _MTK_SMI_H */

-- 
2.55.0

