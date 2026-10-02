Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C557DCA5FE3
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EE9D40DC4;
	Fri,  2 Oct 2026 13:23:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJtcAO_wioiO; Fri,  2 Oct 2026 13:23:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8BE2240DBC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947381;
	b=sYOADqNIhVnpdihNIrFgxS3P/8aDyy02XxwAOQKfaSeqjJx84ap9huCn6MQaPcOdWubf
	 KyGkI05wwb3ZIv44SGtQr2frALgLxAFdQWPvJDVeYLR2Bb5/ouCBLroqNvIoSyL55X/C7
	 qVn87JqdPDdrXpHzflffIVAVuTap+BT+nozuuqajc+O5FiQ9Ghbq4Z9hq9puxuuOI7NA5
	 tyb2BuYYPOOQg6IaEXTyq0n2S3O0OJ4cAj/6CUeUl8SYNA08uc28DMHd05OikINMSEhJq
	 A4mUedJoA8o/QF5QCS3Cg9BxIbcseFzciQ7zkQDcpPbJFnc2Y60psrw+rfZUJFuEJyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xAYu33S0etPXdZko2vdzeklCwnKNnrFGMmFRozHkagU=;
	b=pJLcpoTTCbw4qWgggpP4xb5xLQUVMcYFeVt94PCLDX0YT52sNKbFHUqTnxIHA84qprgx
	 Er6QIJ+IwVlHg/RdBdzfLxGOiul7Si0yIMc4LhC8fHHmveztjuHQ6Hn51CPZEzSTC/MoK
	 +9AiJmVH+az2lTblh0w8yOrBBUB7pHV6Z9OwvXDP2nnw6bbEfDB2SqGMz14eZFK74XVOC
	 vgyV8cqmftI4/fywzpzb9AhkNI/0xbgrCskWbz02I6hJKwXtW5k9sSTtBulOp0uwjXMPB
	 Uy/BtROqLDp3HJady3Sn3b7pQ+iS08pNLTrNiCdcbLql0MQhkY8cLEx1DGHYub3h9iA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790947381;
	bh=xAYu33S0etPXdZko2vdzeklCwnKNnrFGMmFRozHkagU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xoQnpc62iDJQdHXudfztEBuEO61zlXPOP//2eFmG2iFoQe4M+o8ddqlROgavaLVn8
	 KPU1KtFzuNGOMBemTE7a+HmgoHc8a65oA2Ht+PZCAq5uQfq2oQ+GR/q8v5FwcrkuJJ
	 JOayHOVnkK28UTtL2Nd0cooErNK+R87h1tBYWMfjP0S7WQrxEcu6R4QKXWh8aJuBVp
	 7/QCLSbAjHv7ktz+nZ2edZCA+sRDOrAYcdffmwzd7qs49H7e1M+JkMkwATkXsA+HhZ
	 gC6hZFUEWxoxpIl24IVPSS+ekqEZki8lc0x2vLsLcHdEYbiM9k+fGKKoksxRCUCQgP
	 oyZqz+OyoDIjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BE2240DBC;
	Fri,  2 Oct 2026 13:23:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AC2B282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5061B400D1
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UhIE_Ej8Pkq5 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:22:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2A0D84004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947377;
 b=ZhUDNnrv4GjvB+eQAgOj5BQQ9C1cecikyNN52kBeuYAeSAZk3UtASoFhli+YyKT/6Acq
 yMYat2+KdwioKicwtlabu3drPgTv3HBXXAuULgHqXyWZGK3fR20yMPurtgM/17X9Paau1
 ubHl2kxJQsNll2ZrKvFk/SDCKhcKJAH37YjfpUqsIy2KkZZxtEKFgCw7mHiU1NWHaB+Qa
 csAIqPXsFfMIGTu2efJmYVMsE+BG93pPfVefBxhCi6J09Kuoj5m8ZhUTkgEe9Ie+Abixb
 gJij+WIphgmqY0ZN3h9Y4A0ZeseKDvM22g5T9Hi/q4VDHJ/RfvKhrqKlQqoksrqfO2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947377;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=xAYu33S0etPXdZko2vdzeklCwnKNnrFGMmFRozHkagU=;
 b=nICOI6j0zIJAjfhUaow9IyunfItkpJIjcn0iSoPmOZN8rst6U4rPBjWCH03SuHgxDv16
 mbISNteWnlROMplAeFSYRf2Wnoy9rjZzFY2IkOvEgGnmPAj2hGDu5qyI/GDLMcUP8oVLr
 3rgogFyDtJkb/0fKqFKzgJn7vI1HLcnY9cz57ixpJQjdCivEvj7F/5vULYsvcKOiN7mQD
 icxnLDa1C71pfsUmUtBqn8iefyCqK+CkwzZ2tD69bHMMFHbd4jiVijwQ5bCv6tDpAZfTq
 Mg3dfehw2zD9qrmGrPV25VuZ20GRAc/5BSflfnQJPgmwJJMh9e1cc1eCDDlTTML9TIg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="gd/0O/Ip"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gd/0O/Ip
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A0D84004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:55 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b00a0ac65so1819865f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790947374; x=1791552174;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xAYu33S0etPXdZko2vdzeklCwnKNnrFGMmFRozHkagU=;
 b=gd/0O/IpKz5bzoXO9elRdtrsuJlrousMYyIAUK++y4NGie60ic385dFRq0vBIKC9fq
 pMBkkuNP+SFwEy38g0s9L2lXRyqjjq7guM6SJgHBMyTlr5Lo6LsdIX+p/ftfLI+qkWsU
 JW6z6WxXQs3TLv+/NEzI0Q2S4J0Zi3HaDdCyj+0ayylJeH++J2zZQweFt7UhnWIgbdI2
 VGSUtaLNZc1i1ldoOCNL8C1xMHnOqW9B5vkB+CXmlw9BjL+sALwUmIKo0Y7ypz+o6OSk
 FADfFEIU4T1Meh8tlkAqW5+WuzxaBJCZatkAFXj2kMzB3ZqX1HpwTnrG4Upjfa6TCtpD
 7lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947374; x=1791552174;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xAYu33S0etPXdZko2vdzeklCwnKNnrFGMmFRozHkagU=;
 b=aMQA3VL6Aa260SPRIFxRJLOF7JFWAdKM2eRUvvQ4JobtbZU+dkUIMciEkxoBwXfE/9
 HRZbAjLps+rlPgJpwsnhFy2bV+Xklb/RGnCthul6GsB8zRjkloHwsgQ7Ir0dZInNgizP
 GwcQazFFYMOjQVWW2tpsUwqaDfjig5nQr3qa1CbBsJZWiO4lWGYNh7TJk6qW1YtSRlq6
 zpoVerrIZZNJu0EkowOMxhU/vovzzrKkxWZKgB0FlGBGtSeQgEQeJVM1detEdTo6F46I
 nynAC+6Os45pIzHmhyQa+HK34302eIpdac4NYWEadB/MLJEjjZ2dPMFYZquzMLYg3CZY
 ucvA==
X-Gm-Message-State: AFq9FYLxLHOzd1vOTvBWSe6UaALfaFbFFi/VSsapOKr2ay9QyMv29zu5
 scNk6uTcr5xFR06StN1qnI/Vsf6Oaf6ReX7LuN4L6KAqD74IiuYkyJFGYNau1jQ2/R4=
X-Gm-Gg: AYBFou1Rsw0L80SMDHZ5b9AfIv0cywkAbJAcY3Q/ORASaBqSfG013trJZyMK2VNzdgR
 ftpQMMeMLHeUVtMHkVExGK/OsjmarRE6Av5JsULkAFMxLwS3YTXh9jRjcRFUFs9U7f9w5OSEbpC
 C2TWlbKAjlqT85gmPenLxP+71EVNUB3jSM0zW2xoKAibkvKHt468lxE7n21LBbaw8YuKmkE92h5
 3+gu8iEX40+nvB7NFIucU054cbQhzEmyPbWt8tTHVe/fpsX5XXLb88Kf2+mPpkLRdjSwer8OSCT
 OVTWEt8twBfoGXyDCtmg9JuwCMpFJ976bPoAzoFZTjKvvAr6u1OwwtNTO0qU/cxypELz/rH9KaG
 9BGhijozjB2fJyHHB3CBZ2ghYCX4/aIlFsd1KoeGvgvdgznk+g2iC7QBwBLRpOX9XQo8LdYfL+h
 wm8B7CERiYZYpNF34ijgY/Nm6cnlYtmDYXouRWVERz9E7x26wMmtscj7tOB0Sabtd+f8Xt1VsqK
 ZfiV8voMBAuL6sgqJ9yYQYc5YjfS3eM0yrj06ujkOyWAIoKLujXCC45UP+LkLOQ3nm3z/hPjNdb
 I9DzrfpUq4IfZ3xMVrNQMEJq5lnQMXOkaqNwbDYcyJOq74LSrXcnv3M=
X-Received: by 2002:a05:6000:480c:b0:488:8904:cf19 with SMTP id
 ffacd0b85a97d-48b12739924mr5350618f8f.10.1790947373715; 
 Fri, 02 Oct 2026 06:22:53 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6264125f8f.30.2026.10.02.06.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:22:53 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 15:25:38 +0200
Subject: [PATCH v8 04/12] video: mediatek: add ethdr component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-add-genio-510-and-genio-700-hdmi-v8-4-2a6de7cf2a88@baylibre.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790947536; l=5483;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=qAhkq2f9Phk5FlUIMFXFT9QR/1QDQnFtZY4DvwKHtcU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO6Lum035CVW/mtIv8VsoEg0o8EyddyZKk+NwGaIrOnz58D7a2ptn4xuohHv0qcTzf+hhAs8j6S
 iT2JMhda6+gc=
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

The ETHDR is one of the components of the video pipeline on some
MediaTek SoCs, such as the MT8188. Two of its sub-blocks are used: the
mixer, which is the block's first register window and does the
compositing, and the HDR video back-end, which sits on the same data
path and is put in bypass since this pipeline does no tone mapping.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_ethdr.c | 106 +++++++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_ethdr.h |  39 ++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/video/mediatek/mtk_ethdr.c b/drivers/video/mediatek/mtk_ethdr.c
new file mode 100644
index 00000000000..6b480ad8319
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <errno.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_ethdr.h"
+
+#define MIX_EN				0xc
+#define MIX_ROI_SIZE			0x18
+#define MIX_DATAPATH_CON		0x1c
+#define OUTPUT_NO_RND				BIT(3)
+#define SOURCE_RGB_SEL				BIT(7)
+#define BACKGROUND_RELAY			(4 << 9)
+#define MIX_ROI_BGCLR			0x20
+#define BGCLR_BLACK				0xff000000
+#define MIX_SRC_CON			0x24
+#define MIX_L_SRC_CON(n)		(0x28 + 0x18 * (n))
+#define NON_PREMULTI_SOURCE			(2 << 12)
+#define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
+#define MIX_L_SRC_OFFSET(n)		(0x34 + 0x18 * (n))
+#define MIX_FUNC_DCM0			0x120
+#define MIX_FUNC_DCM1			0x124
+#define MIX_FUNC_DCM_ENABLE			0xffffffff
+
+/* HDR video back-end registers, in the "vdo_be" register window */
+#define HDR_VDO_BE_0204_VDO_DM_BE	0x204
+#define HDR_VDO_BE_0204_BYPASS_ALL		0x7e
+
+/* Fields used by this driver but not present in the upstream driver */
+#define MIX_SRC_L2_EN				BIT(2)
+#define L2_SRC_SEL				(2 << 20)
+#define L2_OUT_SEL				(2 << 22)
+
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height)
+{
+	struct mtk_ethdr_priv *priv = dev_get_priv(dev);
+
+	/*
+	 * The HDR video back-end sits between the mixer output and the final
+	 * merge, so put it in bypass: this pipeline does no tone mapping.
+	 */
+	writel(HDR_VDO_BE_0204_BYPASS_ALL,
+	       priv->vdo_be + HDR_VDO_BE_0204_VDO_DM_BE);
+
+	/* enable internal clocks */
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM0, MIX_FUNC_DCM_ENABLE);
+	mtk_disp_comp_write(dev, MIX_FUNC_DCM1, MIX_FUNC_DCM_ENABLE);
+
+	mtk_disp_comp_write(dev, MIX_ROI_SIZE, (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_DATAPATH_CON,
+			    OUTPUT_NO_RND | SOURCE_RGB_SEL | BACKGROUND_RELAY);
+	mtk_disp_comp_write(dev, MIX_L_SRC_SIZE(2), (height << 16) | width);
+	mtk_disp_comp_write(dev, MIX_L_SRC_OFFSET(2), 0);
+	mtk_disp_comp_write(dev, MIX_ROI_BGCLR, BGCLR_BLACK);
+
+	/* only configure L2 since only rdma4 and rdma5 are used */
+	mtk_disp_comp_write(dev, MIX_L_SRC_CON(2), NON_PREMULTI_SOURCE);
+	mtk_disp_comp_write(dev, MIX_SRC_CON,
+			    MIX_SRC_L2_EN | L2_SRC_SEL | L2_OUT_SEL);
+
+	/* enable the mixer once its geometry is set, as Linux does */
+	mtk_disp_comp_write(dev, MIX_EN, 0x1);
+}
+
+static int mtk_ethdr_probe(struct udevice *dev)
+{
+	struct mtk_ethdr_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	priv->vdo_be = dev_remap_addr_name(dev, "vdo_be");
+	if (!priv->vdo_be)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct udevice_id mtk_ethdr_ids[] = {
+	{ .compatible = "mediatek,mt8195-disp-ethdr" },
+	{ }
+};
+
+/*
+ * The mixer is the first register window ("mixer" in reg-names) of the
+ * ethdr block, so binding the ethdr node with default register index 0
+ * gives the mixer registers.
+ */
+U_BOOT_DRIVER(mtk_ethdr) = {
+	.name	   = "mtk_ethdr",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_ethdr_ids,
+	.probe	   = mtk_ethdr_probe,
+	.priv_auto = sizeof(struct mtk_ethdr_priv),
+};
diff --git a/drivers/video/mediatek/mtk_ethdr.h b/drivers/video/mediatek/mtk_ethdr.h
new file mode 100644
index 00000000000..620558132be
--- /dev/null
+++ b/drivers/video/mediatek/mtk_ethdr.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * MediaTek Video ETHDR support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_ETHDR_H
+#define _MTK_ETHDR_H
+
+#include <linux/types.h>
+
+#include "mtk_disp_comp.h"
+
+/**
+ * struct mtk_ethdr_priv - private data of the ethdr component
+ * @comp: common component state, holding the "mixer" register window. It
+ *	  must be the first member: the shared component helpers cast the
+ *	  private data of every pipeline component to struct mtk_disp_comp_priv
+ * @vdo_be: HDR video back-end ("vdo_be") register window
+ */
+struct mtk_ethdr_priv {
+	struct mtk_disp_comp_priv comp;
+	void __iomem *vdo_be;
+};
+
+/**
+ * mtk_ethdr_config() - configure the ethdr mixer
+ * @dev: ethdr device
+ * @width: width of the frame
+ * @height: height of the frame
+ *
+ * Put the HDR video back-end in bypass and set up the mixer to output its
+ * layer 2 alone, over a black background.
+ */
+void mtk_ethdr_config(struct udevice *dev, u16 width, u16 height);
+
+#endif /* _MTK_ETHDR_H */

-- 
2.55.0

