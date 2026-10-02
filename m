Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F26CA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52688810C6;
	Fri,  2 Oct 2026 13:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tMtLrI_VBGye; Fri,  2 Oct 2026 13:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8EBCF812E8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947385;
	b=qQqEBGY/QB0t1Jz2O5HbwLmDbVoEyZ31L94bze2hgDI60DBVZMyjYCzJn9JxVEXBM6nJ
	 CFYHQQbFLahorcpxHMzb3Pn1d8fnhFp6wuSLyVfmKP6sdRrnqyyL156f5K3zZ13BAqsem
	 +4fnpHuKAs+3rnu5jCvU/KigTHdMF5psvsnhvUNfjKtJSRH0eOsp4DN1CP2FzOWH8YeA+
	 Se7lhhm6HJHrhLkLGaDu2PDlrXTpMyG78oIlo/bJ6DyvafaVZm0WPl7GKRukPZnle/JCF
	 misBoeyw7yzybgaLVzq/0Pc9JEnlnmQ4uQh+qozLUcQNwi5yE8I7RstqhBHR3AP4Ucw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
	b=VAKWZNV0wGQrVGWadWS8IurnIRLX3bmQ5TogUFAEezmvm0aBhe4GvvZQg5EwM1e1SvQD
	 3ENsdZCL9WeGwIPzSU9zwKWniYEZL6u/F2a3/krm9zXDxdfTZ1uWz9gUTqFkJLdUgsBwP
	 qBQ09nv+m9XijX7JpL5e1AfBoaB3HJyU5jMDJuv5htH8+BNcDkEW09fbVeu6CcaPJZZpj
	 LQ5toHidJdgPMj5j1QiEcTGLGIi0X7M62R7sBrlS8HLoYdkVNlqlCmvIhuJvVPPyKLl+A
	 Ks5ymfFRNhErJIyK04F1HI3BAPcF23T6wFVgNwpnY65MxUZq4jIf7G5jLMhoF6ljQwg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790947385;
	bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oypGMpJyHyr+P1IF/cJJD9zF11dzSptN33/nM7NnJEkjhq7ppyDjbt5vg6pAYTaJa
	 wX1bkWeuAaVJ5fhcBy0OsBcwWGe0gdexXnxlWPJpOR4FDpe0rqreeSNwQcyDVlFC1k
	 tVudGRPAIRCtLDzZsT3UhE1fspMnOD/xSE1BJJC+n2IdUih1g2kH1FUZMfRyiARnUO
	 BDjagkcOVyLk64r7KOZo4Q5Vl0tePM/3NrxjBp+sQwQKFGDxzKaybiuT/6u25iIZRH
	 djrWtkL7STgFKfUK14815VVCGrVUDWJFj2tIqsbHl67U429shqKRMcuOnMFuuGPF2j
	 CQ9RbDONuHf8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EBCF812E8;
	Fri,  2 Oct 2026 13:23:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EE8634D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60FD2400D1
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDCTAoy4-eeb for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:23:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5D3E04004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947380;
 b=QG+XuvXvbDm7Jj+9sNbtcplo3c8ZQ/QfPClTH4DbYbaNEFm8E6BLE9gly+QCEUFhJfCt
 d5C/pQJ1BZ9iujcjvWGAbFYDuGw1U3TpDcAD15y9o4gBz7NrK2cdzu8UpM7wKVjvqHqsu
 I8EbyM+fYRud50ZulL6xkT4eI2SPnmJL0hEE50rF7K0VOdLKGtw7UMHLrzsZGasgLKqF2
 mPMAB/KqEwyLaKXTTNJSlZaIZR1jRjskNEUbwUZ2m04/vnEtcgfxw9bY0G2XXn49VzRIQ
 f+cznggS05spN/Whp1Hs5NoaaZ8IQZ567vlHsjtTKjo1roEavOYyTl9K911VaTaDavA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947380;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
 b=Zwc2Pc5UA33W5pbX+s6jA01VllYshxH9ddWcWCqc3uKNT6faC5kvUE5WQOkkib5SHJvg
 Cm/BPUS9cF59krYLtU7C7lp+lA9op/tdGQ39E6GR4KEm/CKrXyeeD37TEte562HdZI5SH
 YmFrtNb5mfemCqqL66c7+2hxg3JGuADdsuL9Nk7dCKI3AS/5yaTE20VBUyaXM4mckEvWe
 T2kfkK+Udv7BoCaiajB7fyZctkX1UM31DHvSnKT3EOovbRymSf1eAvhEgIp4r+jlFwRze
 eu+XHWsdOnS5EE65i1LQzTVHe+B4oarUCotzcpZHxEizwpRi7W+UFoXVq8HZ7CYcmnQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=TVEHRITu; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TVEHRITu
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D3E04004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:59 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48b02a2359aso971431f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790947378; x=1791552178;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
 b=TVEHRITueqZ6fiCver2wh+ZvtnzKsq3HubfGwXPddJG+x+N/bNeMIYqKYioeS4GR+o
 V8ecVUCdieMc9VXcEh5UDqnGsJGw3l0au/2DoQkS/KFpLUbMIkNsI9VulRyJ414Z5Zuy
 /SLZrJYujce0tCLRceoz0rGiQ1eu8fkK4LUrDuT2chs/iB83k13VUimmTjezdzTybHhN
 nIMCBimweJP5sFKLyPbJaQU6TBG0P+KTZWRNN5e19NSyJaZ/fxEUUraZtSoLxGDxEvIk
 GhWoeyd5mZBMt/+nO81C6P0r9+7iuHRTjvGa9LOQwIxxtK/Az1eL0w8WDfNW3sVzhIC9
 EtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947378; x=1791552178;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WySkgNOyhXUCX12PQY2jCJO8T58c8yyYdPtG3TzkXw0=;
 b=IPjVjGVuwiX8V4h3FTRupL24gHsw972tFMct/Kwrkn7nMPow3AW+mTuSr03UOk038B
 mowdbiu0RK9la/CVlSbZq308BtlcLvb6Anly35DL4gjgvhFrl7uBi8F2+6CStYMxq08L
 q07xM9RbSGoDGo2EESBmDZRwxvHDBfLwiNXqkvSD8zuY1ihLkkCUhYG46aClnP/hVJ/l
 0CVgBRWPaTDroAZRRKP+EBIj+O7dT/Y37PtxqamidAJb20d+BetXGpYgc5si4mFnbqvQ
 ZTIXZUJgCVTTBJO5CM9RHihgvm/VSfHUzl/vflMWGmJ2czH+EG6NeJOSv+p+3VZ/D8AF
 W2Lw==
X-Gm-Message-State: AFq9FYJdtkn9IoXOk555rfJauJe+8xOd5Mfd21ux5UDAmqQPPFwwm5Wz
 uwQT3xtN9Bq4l1ZobkjU1iBLsin2GdpRwKSzR0ILFc1pPpQZLdDGfxlrFqqnbKnZJ9I=
X-Gm-Gg: AYBFou2B7PB8GMucyLyN52rCMdgsTCy6EWvz/C3y5hbBYFTA/7dzZ9bS+Dd16uHGTeH
 Rg7i7oG9Bcuog6i0Dc8tA0HwXQCIALC08TL+CLTcgNlIMYSdsEIT2biVsF4o2NfoAfpiWWCGhYc
 nEVFkWR93ZD8tGk8anLtTs0Zv+tuzD+8yA8nzw/gvPqajbWqUjUyf1ofEe49lPndYwdO2dg0vZw
 NZ89Pi5NjYPHfZIkOz/27/I6gRW0Z0GEYOtaQR0h2QAMNkPwiSTnk/VQ8m1V41gZYCeSNvIzA+W
 TNjWLiz/fatP32RS5kFRjaVLasDKmTeFA3MRNNGBexBcMTGb0/W/IXrC5sTNQCP2HcWqAc6azFX
 orIt/Myzv7ci7gom8Qz7dVokrKkx6d1ZcZdLGEn1k/N5sYteWni94d5LKKpkBtA3fOzC4tFLfjO
 Kt5rwb7ncsDvmx263YAga2BYLeUvm1yAq6G7SJ3NDBxY0SOGFlLN+AeTBgL3SStxufPrku7x1FU
 EzbwwFEwVKnBO1kcVA/1EHtUC/XsRbOfLb508/gq7tRtP9FLj2xnW+P/nmzZzn/UZws1yMPz+r3
 j0LXavn8Vt0DmidcXqC+suFygKu5pYmjGTWLjg1N4iYIw95DvZyL5SmbzzZgzPHOOA==
X-Received: by 2002:a5d:4acc:0:b0:487:342:eb28 with SMTP id
 ffacd0b85a97d-48b068bf31bmr9801498f8f.24.1790947378035; 
 Fri, 02 Oct 2026 06:22:58 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6264125f8f.30.2026.10.02.06.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:22:57 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 15:25:41 +0200
Subject: [PATCH v8 07/12] video: mediatek: add padding component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-add-genio-510-and-genio-700-hdmi-v8-7-2a6de7cf2a88@baylibre.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790947536; l=2767;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=8NVL1QwtjD3+tPQZIVEXzXw8aViia+0LefrHdWkwbHg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJdbGztT2es+cMuf/9puPfTacbdS2lCFW0194sBY15QZ5+aG2wb+rnkXr5sUTGpbaInBwL0ZHg5
 sza/GzbW4IwQ=
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

The padding block is one of the components of the video pipeline on
some MediaTek SoCs, such as the MT8188. It is configured in bypass
mode.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_padding.c | 49 +++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_padding.h | 20 +++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_padding.c b/drivers/video/mediatek/mtk_disp_padding.c
new file mode 100644
index 00000000000..621dab2d245
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Disp Padding Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_padding.h"
+
+#define PADDING_CONTROL_REG	0x00
+#define PADDING_BYPASS			BIT(0)
+#define PADDING_ENABLE			BIT(1)
+#define PADDING_PIC_SIZE_REG	0x04
+#define PADDING_H_REG		0x08 /* horizontal */
+#define PADDING_V_REG		0x0c /* vertical */
+#define PADDING_COLOR_REG	0x10
+
+void mtk_disp_padding_config(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, PADDING_CONTROL_REG,
+			    PADDING_ENABLE | PADDING_BYPASS);
+
+	/*
+	 * Even in bypass mode all the settings must be cleared to 0 or
+	 * undefined behaviours could happen.
+	 */
+	mtk_disp_comp_write(dev, PADDING_PIC_SIZE_REG, 0x0);
+	mtk_disp_comp_write(dev, PADDING_H_REG, 0x0);
+	mtk_disp_comp_write(dev, PADDING_V_REG, 0x0);
+	mtk_disp_comp_write(dev, PADDING_COLOR_REG, 0x0);
+}
+
+static const struct udevice_id mtk_disp_padding_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-padding" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_padding) = {
+	.name	   = "mtk_disp_padding",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_padding_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_padding.h b/drivers/video/mediatek/mtk_disp_padding.h
new file mode 100644
index 00000000000..ea97918a570
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_padding.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek Video Disp Padding Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_PADDING_H
+#define _MTK_DISP_PADDING_H
+
+struct udevice;
+
+/**
+ * mtk_disp_padding_config() - put a padding component in bypass
+ * @dev: padding device
+ */
+void mtk_disp_padding_config(struct udevice *dev);
+
+#endif /* _MTK_DISP_PADDING_H */

-- 
2.55.0

