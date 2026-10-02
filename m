Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9BCCA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 070A540DDB;
	Fri,  2 Oct 2026 13:23:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q5hyUfFtoSFQ; Fri,  2 Oct 2026 13:23:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1E6A140DD8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947387;
	b=XiEClF+ER4TsbeHZZ/F+rsc2pojRhu1jZ5nWAnGXWrtFXh67r9jXd/3C2khxnP3bQ8yh
	 Dr1q1AFPFr/EHp1w1eAzYg03lpwJC5xiR4T2BSn8gi31zivuUifTP/bHc5uFzKEJUjEue
	 h9mF/y9pXQT7QzqCoG3q8SHYygqhKFMaHaLjo3S1rhdHOieh0ePBEe9wY/CTFVMd/Amyf
	 4CyR2BfyjkA9xxfsGKFiySWqvckFp9gewp18D3qX3yOAmBgcnywR0KsGxj/CrzaYqEhdK
	 eOZ+a3b7/ADoErOROA8ieAVO7fiRLiIKhW/Fjb+lt8Ua3AdBd4rupO+Ntrr4O3XBBJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=elAPlq9DFO+HSmMGqwKW6DORWQtc8x9/o4mxF2k/IMM=;
	b=O9MxztY0HM+2LQEbfqtihDrgulzC1+xWq1XCRxrI5cuhiTCXW5S/38vtmQ2HOcGFS4Ir
	 L+ToZ8mh2qVyu/IZHIYQdilYTUgq9vvRM6pKsyTQbMfJl/ncSXcw+PG9NeNadkHpuucxs
	 mVz/+d5dIOse6k9/myGKzK1MwItd6KHLfJrPp2P7Q3h6rh2mn+22Hwbkxb46F/b6QKjLi
	 CWwme2cnoZtr5YW7+n2csAhtDingynwDWT82PEfaMw/5KTetsHVEOmKrmMcyKk3E/09XT
	 StellhXsw4ihKZPaG9IQAiErRZMlDlGaGgDHk52Fko1ANfGzkH8H91Aw64UsonetS0g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790947387;
	bh=elAPlq9DFO+HSmMGqwKW6DORWQtc8x9/o4mxF2k/IMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j2BEov+LXvJufKeA+pOaOtJJMjhYwxWwNhtAharWNKtAQmG6g0Tqvg3UHECxmXcST
	 HiGlKB611fUS/PW8CuPZgJYNzd26ccbVgzP+5G4FiiOk/5tp79fql4o+SZ6wQyk6Lt
	 HWLFeXSM6qCsuAtlgPt3jj99r1xtMNYNcQ/JigFAfFFIRIhxDiBeORe1KxFpKet7hm
	 /t+tB0KwH32mlFPfIDQs/AT6jhlbGn349TJ/tPiTk8y+KJeux7o6pTYiYfSZiCazlV
	 AiV66Bdw97h1+8nkD3JzjJTtghg7m+I4Bj2zU+8ovzJb9fabgrW1yREIi/FYs0Jc/j
	 Ery0dWSUg/gMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E6A140DD8;
	Fri,  2 Oct 2026 13:23:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2A4732F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94CA260C2B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2bFc_GdoNood for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:23:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 43EDA60B5E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947379;
 b=bargAlcB4m+zuf7aNxWr+nclFrA+GYW2pEmT3nk+DJxcKktR2MColRIxESsYbqtgPZhr
 1rKe8A68ood7l7mb1ZqA6tMptKNnqe4o8wMXpqqXuQu2MZ3IgF573TGRsoxk0pgifViy9
 fwnsqiJfP9DO6x/KBqK/PeJEayYW0lLdnGzKvq+xkQ//bCrvlrc4OFy9v0Oyk/wJOlmHW
 BWznvJjDn1QmUyfDgzu26COY6tSMM8S7MEc2hYM9XorTOXRbBz2m8dGOjQ0CrGvggSf86
 lPWSr6WFqc5ZMWBka8ZlBRo61TUb2LufTzlo9aFTReuuY9k8CVa9eqpwCjOf2OpuEXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947379;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=elAPlq9DFO+HSmMGqwKW6DORWQtc8x9/o4mxF2k/IMM=;
 b=GTlasSeO3uxC+DzAEZt8HisN3BH4TwJdH7yGb+d34iGNY1yPau9A8e/TgWy2XCpBkUHn
 T9ZYawnznyWvIe0GXwFR+K1ULxGjWN8C4b2SCM15sZuZX3WW8ll2axp4OO9hzv+EovyxS
 PaeyDnqj1rvZ2u+EN07QcT8900siBduZSxCsVY4E5R8U/+YLlih9nVG9fIxZAohuctpEp
 r2yGWhIimZDTqfS71GMfH86Fa5Fvoa9kT6S5+HsD8RHfgH1ev70MLuCmJh1srGp6gQcoO
 2uZwYns4qdIQGadvz+qdCo+PLDkFirOYPTbpbEoquTWwtjzkmudvo8LJfjW5J6A0Pyg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Bml5vb26; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Bml5vb26
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43EDA60B5E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:22:58 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b0591cf85so1379205f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790947377; x=1791552177;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=elAPlq9DFO+HSmMGqwKW6DORWQtc8x9/o4mxF2k/IMM=;
 b=Bml5vb26h8nNux1AZC9JE/DNYRvpjGnTYMYFU2FuROKruchgxqTqoaUlRS6Xw3V5Ww
 EXJW03rEt70agr7wVZExq3fRMK4tjsCn8p+FuZ/K2OSNfg6h/cPzaJMUQLtgB/PPK2V7
 /lO1jPO7RA+L/flXYxcYbThFl2q+FNYq9s6oJ/2RGtjLY8Jr0e8YnobwhsIyFRKRWHWt
 lNRSP1MXRVQzMA1Tj0/klT72Y0qcGT2SxG1RN69urU3wC2Y1mjczi+CVAF9X+9e7cNZR
 rGQ61vqCO9Uy4z0SxFSqP4FiPdGeVGf8Nt8SogDyU1V36vJPhgZ8G9blQp9X3XsXuK8l
 /1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947377; x=1791552177;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=elAPlq9DFO+HSmMGqwKW6DORWQtc8x9/o4mxF2k/IMM=;
 b=DNPoayJbXnuawGygIVOZQ/FUOgJkPf7Y1e4z4GJgW49A/R6w+ZkdBi6VY/4HGHhTI9
 lET3BGeXInlvOrvlOQ+WbiB6/jYg+IXyWW6XhXMoomTxKEm1x4zIDH0gHDcu0+ksEaA+
 ISgLY71ly+2uXJ9/YqozfjtskeQDhxSVY2eYiCRqtdr3B1aiqcxBioZOghAuPWjPNtFB
 M/wSqRbeVaXmUkKXhHTEEppQKbwEcpSkEKh4+1n0kxx7SGHTRFk12LIn7ytuqPRxU8gY
 po4Otq+UC5k1DVV2uzwbYH64tPRS7Xdrp4AenxmLMf392GKJY4s81Lmy7czMchd2PE15
 rugA==
X-Gm-Message-State: AFq9FYIA5zWPWUfzEVHZ/vdQfxvPFLgBOETk4hHGnoaLyTlAlsGrBkgP
 5q8kJU5rTTse4+x8TZS78qY1fLnnkTfCxLlN7C0vVyUPli17pDj8rb9pESPLQlVhHO4=
X-Gm-Gg: AYBFou24VvasZ/5KfiivhjLfFwug5MiqL3aaWaKIQVRv4tM5UAPinuEzNM4cgvnT2aC
 3pRsVzNBbpSWk774VYOeLwkz1NTkA1SruMPYKRN34tEtIOunJhOFwcIDyLzjpDOB/kSpSuyLOk6
 FfQq4e3R8ulVQ+85Bnbt2j7MzBKUXNjKJZa4xtbgQAiQZrUBWu0es2O0/q/RqoyrdA4SC5OEnjY
 8iLtDsXBEqjN45boow/OqfSZLuWXjlHfMtOngAjw+0OVz4qpEK6mUGNt2GuUvHlDEclE9gYMHfr
 WjzRHRWBiqSK5kqbFtWBa8MHsaoDE2O5BIrUGyv4LMvhI83QBMc6GF9tD+3GxDNhm05mvF6Qi2E
 19HHXaapX5HAHBmmcQl+akqwBPm6A6CGawph7NgaxyeUnkcWWdPL2+J6ONezrBMU2y6ZjVWhetO
 80kDHq21X1Dty8S0ZVZTLRnmU4Q1k6o0EuKx7lubR7nN8VYKLUQqI9QomzTeXaf9UNZgOwkDNh8
 AmKJ4WLLRg+JMloqF5Lc5/0OXycK59jImqpE+3j9G6R7IuPSMuHNQoo9+DipypyBIqZlOkxV94Z
 8gSkn9ZbUW16U19mPxW2dTxWdNUh32NO9uz/EgYxkQ13W5H1qZvIb5M=
X-Received: by 2002:a05:6000:4283:b0:48b:127b:8746 with SMTP id
 ffacd0b85a97d-48b127b875amr5727223f8f.0.1790947376770; 
 Fri, 02 Oct 2026 06:22:56 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6264125f8f.30.2026.10.02.06.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:22:56 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 15:25:40 +0200
Subject: [PATCH v8 06/12] video: mediatek: add mutex component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-add-genio-510-and-genio-700-hdmi-v8-6-2a6de7cf2a88@baylibre.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1790947536; l=4557;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=8IdpaNo9jzOxxQwCmAMhfgcHKN1xc9e5b2kh5E9cyls=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPlvs8i6VGJGMoPCZUC3Men3UeA4MMYl5f07JcBWdzEjP7hsF47t7eqW7PCmcJ15hmmKkZdpbCl
 TEMuaoRjpQwQ=
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

The display mutex synchronizes the components of the video pipeline
on some MediaTek SoCs, such as the MT8188. Only the modules of the
DPI1 pipeline are attached to mutex1; the module bit indices follow
the Linux mtk-mutex driver (MT8188_MUTEX_MOD_DISP1_*).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_mutex.c | 79 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_mutex.h | 21 +++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
new file mode 100644
index 00000000000..571d4c8b672
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Disp Mutex Support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <linux/bitops.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_mutex.h"
+
+/*
+ * Register layout of one mutex instance @id (as in the Linux mtk-mutex
+ * driver): the block packs the per-mutex registers 0x20 apart. SOF holds
+ * the start/end-of-frame source, MOD0/MOD1 the attached modules 0-31 and
+ * 32-63. The offsets are index-based so a future DSI helper can drive a
+ * different instance/controller.
+ */
+#define DISP_MUTEX_EN(id)	(0x20 + 0x20 * (id))
+#define MUTEX_EN			BIT(0)
+
+#define DISP_MUTEX_SOF(id)	(0x2c + 0x20 * (id))
+#define DISP_MUTEX_MOD0(id)	(0x30 + 0x20 * (id))
+#define DISP_MUTEX_MOD1(id)	(0x34 + 0x20 * (id))
+
+/* the modules are numbered across MOD0 and MOD1, as in Linux */
+#define MUTEX_MOD_BIT(mod)	BIT((mod) % 32)
+
+/*
+ * The DPI1 -> HDMI pipeline uses mutex instance 1 of the vdosys1 mutex
+ * controller. The SOF register packs the start-of-frame selector in the low
+ * bits and the matching end-of-frame selector shifted by 7. The selectors
+ * and the module indices are the ones of the Linux mtk-mutex driver.
+ */
+#define MUTEX_HDMI_ID				1
+#define MT8188_MUTEX_SOF_DPI1			5
+#define MT8188_MUTEX_EOF_DPI1			(MT8188_MUTEX_SOF_DPI1 << 7)
+
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA4	4
+#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA5	5
+#define MT8188_MUTEX_MOD_DISP1_PADDING4		12
+#define MT8188_MUTEX_MOD_DISP1_PADDING5		13
+#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE2	22
+#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE4	24
+#define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
+#define MT8188_MUTEX_MOD_DISP1_DPI1		38
+
+void mt8188_mutex_config_hdmi(struct udevice *dev)
+{
+	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_HDMI_ID),
+			    MT8188_MUTEX_EOF_DPI1 | MT8188_MUTEX_SOF_DPI1);
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_HDMI_ID),
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_MDP_RDMA4) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_MDP_RDMA5) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_PADDING4) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_PADDING5) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_VPP_MERGE2) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_VPP_MERGE4) |
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_DISP_MIXER));
+	mtk_disp_comp_write(dev, DISP_MUTEX_MOD1(MUTEX_HDMI_ID),
+			    MUTEX_MOD_BIT(MT8188_MUTEX_MOD_DISP1_DPI1));
+	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_HDMI_ID), MUTEX_EN);
+}
+
+static const struct udevice_id mtk_disp_mutex_ids[] = {
+	{ .compatible = "mediatek,mt8188-disp-mutex" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_mutex) = {
+	.name	   = "mtk_disp_mutex",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_mutex_ids,
+	.probe	   = mtk_disp_comp_probe,
+	.priv_auto = sizeof(struct mtk_disp_comp_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_mutex.h b/drivers/video/mediatek/mtk_disp_mutex.h
new file mode 100644
index 00000000000..6b2c8863a20
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_mutex.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_MUTEX_H
+#define _MTK_DISP_MUTEX_H
+
+struct udevice;
+
+/**
+ * mt8188_mutex_config_hdmi() - set up the mutex of the MT8188 HDMI pipeline
+ * @dev: vdosys1 mutex device
+ *
+ * Put all the components of the RDMA -> DPI1 pipeline under one mutex
+ * instance, and start and end their frames on the DPI1 ones.
+ */
+void mt8188_mutex_config_hdmi(struct udevice *dev);
+
+#endif /* _MTK_DISP_MUTEX_H */

-- 
2.55.0

