Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E47ECA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D63F9812CD;
	Fri,  2 Oct 2026 13:23:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CkgGJ4fZ2uDS; Fri,  2 Oct 2026 13:23:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CE65A812A0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947380;
	b=DfOtgBimzLb1+O3TI+m5xfd0/QPcmESe9LQ1NRSH+72A8sSts8OfClFvg9a2Ne+34o0B
	 QdJT0qOI10zV+kn6JPP9ZsZ8Mj+M4FG/AXK6B1d1XS/H1f2z1IrUQvgGUZ9IM+dt3MF8k
	 TtvfuvmV7ISQwJkoqyrhzHyTDv+YFehE4QCqFByxCnAX8rn+TiR2ClzTssPSgrKkbLC4M
	 jhVQSa0WjTF3FtRsOu9idn/m5za3WWBTT1I4v1QdQPBf/B3/vdNPHXsSRF2GAtH3g/TPf
	 YY9xtpqwgR6ymsUNJha5E14el3ra58IRFligaSb73z7H8qIsx/mgxUtbUx8tDZbEo7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947380;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uZaBuhy74hDTYiT8cbnfSysup6X0cFNpXRGX0oqb36Q=;
	b=XjFF6+81UaS/y36HOkh0PlKRdaRllyN6iz/cd9KoDL5RD1QhWl5jc8fNX26B7JUgc4Po
	 WP5eaVvnvbGqm9NfXT6lQsAs98xhSKzGee5gIgts6z55t0ycE+HktA0g5vzlBewFryguc
	 2pu4qZsb4NYsHs5wgsHMrCGqZIO+1A2uGxZ+UzY1IsSno8BlaIXXA32efVrhuPFLkqitU
	 HMJzMMvr55um9ajwTYMCaX8wUimLAjjQzzh+5L5JM7+O5gGcKZvj8gBVCrx6gRkpbqacb
	 7cKe6kboPKqBwDeRvz3dkIl7qQDY8zNpCpsfHtlmRXI+B/kxY1vCqBZV8FodzJ9YFjg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jJcEUxzV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790947379;
	bh=uZaBuhy74hDTYiT8cbnfSysup6X0cFNpXRGX0oqb36Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e4Eiys68RQ1Lq1Bp/S0jEDbL+/B+9AY3d9qQIPmY0HwCLa5LsmFBSSG0iB7F0SCPX
	 nnmmf3NyLG7q5CK4LFQdYwPfo3CPwVf51R3aKTTvYwm/i9LSyaUhsr4IBGa9GyUC4d
	 VE69Bhc3pZmsJAdZ3wBb051CoX19r6rLJxf+dfsVcl4l909Y3KzRRxtlcRfXdzFqN5
	 0Dy6MwqkeQ40G2gsG+nOP/O3QBaSFdt2bmFDCbYLNgl3Q3PXtzt/4GLWrrxLujdlop
	 OVYgn8Zl91Q4ek/gVkm4rGMXIexiO+IuNmrLye5soFhkS7md52JeFSYLH+QV5jMmyq
	 rkVfGQu2GOUDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE65A812A0;
	Fri,  2 Oct 2026 13:22:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 08C8E282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC55A810B8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jV-o5ftoLWmF for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:22:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A0B3580F5C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947375;
 b=QhABvNsolS/y7X4Ws+vRP6N2oj2BUHbAjwGDxXPCFEpB39dQM1fPcEz1kAAWBSNHBX12
 NWqX+0XVb+5ObAzvwSulViPazK3zHkFtJr/4anzijZTo3SWC6hQSCxWuWY76f0j4DVtgC
 vnd2St9bjawRrmevv3OfivO8IzukPMSFHnoXBEBvz8YeVjBf8QrCbrpZbWbYs/fTkB1yG
 7AmmQ9+l69X6fHp8aBQipdn7gOO7CVP7XedCSvpECLcQ+d3wmNTxmVePX4jcth7/pGEDb
 U6N6RzoOwFZvav1eUFJn/9AN9F0+9KooD33VrFDqn3obXB3sZ3PUeiN3P/Y4eXYApjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947375;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=uZaBuhy74hDTYiT8cbnfSysup6X0cFNpXRGX0oqb36Q=;
 b=sWJxbBG7aVZ0OHPYKWirAvR41E3mfy7GTo3hyuG3TkqgUS2Fy1DI0rcqmJpGPWHD9/gN
 844nGRJAV/r/6b1PWa3o0ugJZwhfNcN7E7BVr4wFIbL4VxETncHujmE+HvFBig1KReiZC
 pW3ic41avCYHq0WiUjAFMOJF3jF3OlEvEooXYBmHJQBYQgWFEyGHOd23OWv4qaWssSluO
 LtwxcOtCzyK6w0jUr7ZP7HG1QpTmWLpDckZfG/GF02yEm5jY6FNiSdHKrC3BZTjKk2OM4
 ouBU7ZvmCdAAYa7U9AUzR8r+zrYn6maFeaWDB654wKyq2dSqSxwsc9MtpNAoI+X2hRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jJcEUxzV; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jJcEUxzV
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0B3580F5C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:54 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a006d3fe83so328475e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790947372; x=1791552172;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uZaBuhy74hDTYiT8cbnfSysup6X0cFNpXRGX0oqb36Q=;
 b=jJcEUxzVU4vlpd11C6+omVbYMePA9+/O1nOeqCIHB+RVsn6truAtr4fxRBmCVxsTAF
 Zwv6jUxjnYUW7HmhHnzDqM5uW7PgWHjYFAkLc/5uMB4bFV4jep+S531poak3j4dve3Zn
 VSkD9U81E0DNxTHv6QWGdPftiPx4cXia6GsvV6f6mHfAFFGKfGgCth2PXOM5uXMBojbQ
 8LTYtecQgWG0IsgKlCTj+B1RDnLDyt+LysAjlWP6umNnQyHKNTa8rA03qolvJMcAUsm6
 ObKWjXuwKXWHjSJjxN4d7jliIy4EZkTwKRQy+VeD3IFShKdpFfmvTaHruAdxt7dBoqHD
 FIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947372; x=1791552172;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uZaBuhy74hDTYiT8cbnfSysup6X0cFNpXRGX0oqb36Q=;
 b=Uu5qtIQSpVUd3dGAmAqbUDUAHNa744SZaYO91dD9nR8sTGd2ne7/AWWZn/atM7JxD/
 3BnfQIgDtHsucNDZ/4RhF0uAht2cNOcAqAVkfPE39O9kl9idqzXayowG8UFF3xZ7Dovu
 4W9ulrTirZHBuH6n7BsOd2JMI14zMj/Iufupb4wp0epUPxc8KirqdXugVBWMa5LIsJKl
 zuCduYZ4SIwn/yQ6vzAnxOOJRiNg9FSSgG9dg87K4wXyHRLb51gnkTqrBdyThCwwsqdV
 KV03K/kZTrWtFVzTFF2HxYStWE6471IQCxY89OEZYICQE0OmDmUtf0dpmKcGv81ktTfW
 fYrg==
X-Gm-Message-State: AFuF++nQG39DVqUo1bTzdjTMLGWva6u1VzbtU25Bd9gh3SZa1HDHM+KQ
 MibKBqDkXvBJ5NjYJrlQUbljizDQ0MKSloNQsdDVSKZrQfVduTJK9J12b6vKT6/U7/A=
X-Gm-Gg: AYBFou0EJ8ZMTuyPqlcfyfk3kiCTz/+WQ9Er9znMFeEWOVIYBywg5P8SrB9vcqF5A++
 HYJh7EdOFcpkAP2St7/iRIyGQdaIV/4oUT14L4mTIUHKjUrmoy8g1WmsVdcNvnuv3YEAy4bapu0
 KmdO2c/3Flgu9+yBDQDDTkbkxD0Q4oFiTBBkkcnHLC/E2L9M6Dg9FfoiWebdf7zPDQLn7QBILeb
 qPSXZyJrgRNP1NrV5w6cU0e1PEHdSCUtJ1GX2FT0++NRkohd2liZ0SdWiVlGd3qWF4BnKI2npRm
 sETilhaViO8R1H3ymGUPMrLDl1Cn/XQe1rEFv93x3grC7AC2QZOQLFsdK0psB4wal93RRxdU6ld
 M/DQOZp+0NAbMthBnP1h8QmoEop/M7MED0sYp4N6JJQ0UGfMavW2rVAjT80l9raAMP15afWJXMO
 fV9qtFYGUZSd9IaEFo6ccBZDkQis1oZMm+Aeu5pKGITzNxRrQ1mU4MwbhEyGYKA/XEMpdTC++tE
 hc0WrmurV33jWP86lwHj+25DoNXbGM6ffWrnlIlEDntHrnfAxFpkqapuUzow8RONKVAVHYu/Gr2
 d9QPPIDKploIfp6UgQsTWhfh3UwowwAX5cw0Jzp6VVsTQwtCsbFiztg=
X-Received: by 2002:a05:600c:68d8:b0:4a0:1b50:a9f0 with SMTP id
 5b1f17b1804b1-4a01eb24a0emr86889705e9.9.1790947372230; 
 Fri, 02 Oct 2026 06:22:52 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6264125f8f.30.2026.10.02.06.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:22:51 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 15:25:37 +0200
Subject: [PATCH v8 03/12] video: mediatek: add display pipeline component
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-add-genio-510-and-genio-700-hdmi-v8-3-2a6de7cf2a88@baylibre.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790947536; l=7232;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=S6TNPrhyC/dfweU3GDxPTDjziZ3MIR0A5FqcMtmgQis=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFnkjJuDPKEVsKm+1yk61EtrmaNqKYHiy+A08PZk/5f2w/NF+0xByac7Cefqno8G387WwjDMU29
 WI1MesceaewY=
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

Most of the simple display pipeline components share the same probe and
enable sequence: remap the register window and enable a bulk of clocks.
Add the mtk_disp_comp helpers holding this boilerplate so each component
driver only has to provide its own component-specific programming.

The components which are DMA masters also need the SMI larb feeding them
ungated, so add the lookup resolving that larb from their "iommus"
property; the enable and disable helpers take care of it from there.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.c | 123 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_comp.h |  96 +++++++++++++++++++++++++
 2 files changed, 219 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
new file mode 100644
index 00000000000..f9eb9e00de6
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -0,0 +1,123 @@
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
+#include <dm/ofnode.h>
+#include <dt-bindings/memory/mtk-memory-port.h>
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
+int mtk_disp_comp_get_larb(struct udevice *dev)
+{
+	struct mtk_disp_comp_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	ofnode iommu, node;
+	u32 larb_id, id;
+	int i, ret;
+
+	ret = dev_read_phandle_with_args(dev, "iommus", "#iommu-cells", 0, 0,
+					 &args);
+	if (ret) {
+		dev_err(dev, "cannot parse iommus: %d\n", ret);
+		return ret;
+	}
+	iommu = args.node;
+	larb_id = MTK_M4U_TO_LARB(args.args[0]);
+
+	for (i = 0; ; i++) {
+		node = ofnode_parse_phandle(iommu, "mediatek,larbs", i);
+		if (!ofnode_valid(node)) {
+			dev_err(dev, "no larb %u in iommu\n", larb_id);
+			return -ENODEV;
+		}
+		if (!ofnode_read_u32(node, "mediatek,larb-id", &id) &&
+		    id == larb_id)
+			break;
+	}
+
+	return uclass_get_device_by_ofnode(UCLASS_MEMORY, node, &priv->larb);
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
index 00000000000..26b0327a804
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -0,0 +1,96 @@
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
+#include <linux/types.h>
+
+struct udevice;
+
+/**
+ * struct mtk_disp_comp_priv - common state of a display pipeline component
+ * @base: register window of the component
+ * @clk_bulk: clocks of the component
+ * @larb: optional SMI larb device (UCLASS_MEMORY), enabled and disabled
+ *	  together with the component. Only the RDMAs, which are the DMA
+ *	  masters of this pipeline, have one.
+ */
+struct mtk_disp_comp_priv {
+	void __iomem *base;
+	struct clk_bulk clk_bulk;
+	struct udevice *larb;
+};
+
+/**
+ * mtk_disp_comp_probe() - probe a display pipeline component
+ * @dev: component device, whose private data starts with a
+ *	 struct mtk_disp_comp_priv
+ *
+ * Map the first register window of the component and get its clocks.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_probe(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_get_larb() - resolve the SMI larb behind a DMA master
+ * @dev: component device
+ *
+ * A DMA master component reaches DRAM through an SMI larb, which must be
+ * ungated for its accesses. The component points at its IOMMU (M4U) port
+ * through "iommus", and MTK_M4U_TO_LARB() extracts the larb id from that
+ * port. Resolve the matching larb in the IOMMU's "mediatek,larbs" list by
+ * its "mediatek,larb-id", so that mtk_disp_comp_enable() and
+ * mtk_disp_comp_disable() then enable and disable it together with the
+ * component.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_get_larb(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_enable() - enable a display pipeline component
+ * @dev: component device
+ *
+ * Ungate the SMI larb of the component, if any, then enable its clocks.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_enable(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_disable() - disable a display pipeline component
+ * @dev: component device
+ *
+ * Undo mtk_disp_comp_enable(): disable the clocks of the component, then
+ * gate its SMI larb, if any.
+ *
+ * Return: 0 on success, or a negative error code
+ */
+int mtk_disp_comp_disable(struct udevice *dev);
+
+/**
+ * mtk_disp_comp_write() - write a component register
+ * @dev: component device
+ * @offset: register offset in the component register window
+ * @val: value to write
+ */
+void mtk_disp_comp_write(struct udevice *dev, u32 offset, u32 val);
+
+/**
+ * mtk_disp_comp_update() - update some bits of a component register
+ * @dev: component device
+ * @offset: register offset in the component register window
+ * @val: new value of the bits in @mask
+ * @mask: bits to update
+ */
+void mtk_disp_comp_update(struct udevice *dev, u32 offset, u32 val, u32 mask);
+
+#endif /* _MTK_DISP_COMP_H */

-- 
2.55.0

