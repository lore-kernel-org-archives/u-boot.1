Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EC5C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0AD981371;
	Tue, 28 Jul 2026 12:28:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2TXAH5cKB8eM; Tue, 28 Jul 2026 12:28:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D33B8134A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241712;
	bh=1weHsLGZCVqMRl0T78GpfZEPShtO3mE5H3AjrGS87Dc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g+wYF+UZ2mlcqq1GJU6IzTBtNBTLBf6FQzk+DVL7I81CxWao5A9f+nClDkIqU1jM/
	 s359loWPxU3jlDqcqip9jHDPRYSSGzlT1m+is/Dzu1x3ewls91QPeuSLbLGu/auDlV
	 DHh4gfSsdpgJFWyWvQ3UcNj0bPsVerdkT46X9xUJwENnJyae05sTQls4YVOqeEbH/D
	 4tPX30vwnlkmdw1f+Lpa6yxUB7mjk6Y69NWq6GlYA8p29XIPzED2dr5w4Nh40ama3+
	 Cnu2U0vyIQXa6nus6rWccpDCwXy06YktN/xCi+BWsDrDl+rmGfAktletxsh8Hcw2F5
	 S6qQ4L3Vn+Yng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D33B8134A;
	Tue, 28 Jul 2026 12:28:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 258884BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 177D240A03
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:28:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ZZ3N9dgpi9S for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:28:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7D425409FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D425409FA
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D425409FA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:28:28 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49548e01d02so19100275e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241707; x=1785846507;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1weHsLGZCVqMRl0T78GpfZEPShtO3mE5H3AjrGS87Dc=;
 b=LgVf+2VQGw5A5bZo4TsDo6GykLyiJQw+SkMrPOiioqGIwBfB5lmY8gmM20tW8AX4Y+
 QsNPdmyHAVy+CNECVh2HadtEFZVc9RzHQJ56M6B86LpO62Re1coBZcW1cyIhmkFAihaO
 Yv3ZN4vDOX0pmJ26bIcqN4ImAR2tYJir3gOoj95PsQ/4Lq08Np7zDCVwtvVOET3wtHkj
 k+3+nQP5KRh4TNVXHiXHoRI4fd4ORUJtWLuAgBRdtfp2AV06ghjmBDWktLnITulXFss+
 TK1+mqyoC+jJRn8OKrLEQ1uENhUU+js2biCs2U1XWsHrL0GLFrJXnYyXoPMYri9+AW1R
 p4cQ==
X-Gm-Message-State: AOJu0Yx6Xpw3B7XpNHJvDDlhzyzr+Fqh3EA8yac4lM0TBwbb5F22kk5l
 DU1vbGxsgEDwdNzno76xG1Xbgr8bljNLPhWDXzQicmrRk1pFxV/5l8te7VNPEULvk5Y=
X-Gm-Gg: AR+sD106n02+iaqWBJ/CG/BZTy4S/++MB9dB/ZZOjDzAZJIl0lmlH/HIadthNDitzel
 9HC9852QlGV/6oqVIID50hwbQZodNr0WXMvAq30VMzBsRhwC9bV8H/FWjSdNv78Pjy4kpwavITQ
 rcsNWs4B2iGn7TX5HJwquRI8r3CP+q0SlzDC88Gmm3GSDsQWER4J6s6mX5DRpkf3Lgnwvl4rTYj
 Q92I3nTHb0+2mqkx9OuVzy1VhAECWTTEPsVrjcmUIx+rfL9mp8KwRgwbYkOuF7ZXoLtIX3oV8/I
 a8NlwHtgghbcqPXuXTg0dkEQywROekNtDRZeXoktBYOzALzVklfUmzrxz7+iUSuUMqv/lqh24EK
 39q0/ZTXyQnUlT1Yy3GI0RrMXoy5YKkfvlK05Q/i6WwdGF9Ui6MfZKUxSjfCz6jLeWzMHeI6nQh
 NMzXzAuS1gPszk1YTQrkfmEbstI7Wllh1NqJtVCeLeklZAPvFmRc52ENouKjZtP8COIBr5OplPR
 Jy/VQ2e7HfQ4rZtHu/KHu3NDWMzAxYGVXlS5e5BUULPA53zlK8SishLJk2T8bM=
X-Received: by 2002:a05:600c:154b:b0:495:5e86:4e11 with SMTP id
 5b1f17b1804b1-496c64262ddmr23208525e9.12.1785241706673; 
 Tue, 28 Jul 2026 05:28:26 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45cb67esm79397335e9.8.2026.07.28.05.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:28:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:28:23 +0200
Subject: [PATCH] clk: mediatek: mt8188: fix top0 gate polarity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-mt8188-clk-fix-top0-gate-polarity-v1-1-56bc92ba6055@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCMBCF4auUWTuQBGmnXkVcJOlYR2sTklSU0
 rs36vKDx/9WyJyEM5yaFRK/JEuYK/ShAX+z88goQzUYZVrVGcJnIU2EfnrgVd5YQlQ42sIYw2S
 TlA+SabveWXck3UPtxMR1+fs4X/7Oi7uzL98wbNsOSwxt3YUAAAA=
X-Change-ID: 20260728-mt8188-clk-fix-top0-gate-polarity-82679bab4819
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785241707; x=1785846507;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1weHsLGZCVqMRl0T78GpfZEPShtO3mE5H3AjrGS87Dc=;
 b=F6TfYDcQgRtdj+b3of4KqIPlz/eu9kwT0kuPb7KT7AKqOFtMbFerCgLMGxk3Qlbxz1
 rF8gvWHcZ6cvIWSuoQZ+FflwVZJh5YgxtR2w8fC50J9iLu7OmtY9B+cZTsTb1XI2I8FD
 s6NhqSifZszoLsrKRK1/QHkalxnT9tlDtnRop41gTzPo0Eijx8UNQe1p01vLNm8qS7+e
 vNeMTbMUacuM5j38Q4d94wNNsK3IOdCnIodoLuf+xqGYWOSeJNu/1UewuxU5KaufdMtd
 atFrHI8lHAvLj8RH258SdxHhKUHW3DPS94ygU0XlZu4kYzpXcDyR1gCylX7g1haXJ4o4
 PP3g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=F6TfYDcQ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Gates in top0_cg_regs are active-high. The GATE_TOP0/GATE_TOP0E macros
set CLK_GATE_NO_SETCLR flags, which treat them as active-low. Enabling
the clock is currently disabling them.

Switch both macros to CLK_GATE_NO_SETCLR_INV to use the correct
active-high semantics.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
This was not detected before, because the top0 clocks were never used.
Some of them are part of the video pipeline needed to enable hdmi.
---
 drivers/clk/mediatek/clk-mt8188.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index eb98f7fdf6a..e0855da3bc1 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1363,7 +1363,7 @@ static const struct mtk_gate_regs top1_cg_regs = {
 		.parent = _parent,				   \
 		.regs = &top0_cg_regs,				   \
 		.shift = _shift,				   \
-		.flags = CLK_GATE_NO_SETCLR | CLK_PARENT_TOPCKGEN, \
+		.flags = CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN, \
 	}
 
 #define GATE_TOP0E(_id, _parent, _shift) {			   \
@@ -1371,7 +1371,7 @@ static const struct mtk_gate_regs top1_cg_regs = {
 		.parent = _parent,				   \
 		.regs = &top0_cg_regs,				   \
 		.shift = _shift,				   \
-		.flags = CLK_GATE_NO_SETCLR | CLK_PARENT_EXT,	   \
+		.flags = CLK_GATE_NO_SETCLR_INV | CLK_PARENT_EXT,	   \
 	}
 
 #define GATE_TOP1(_id, _parent, _shift) {			       \

---
base-commit: 0890d2d1db70b581e10d39fb39537cff85f90fb3
change-id: 20260728-mt8188-clk-fix-top0-gate-polarity-82679bab4819

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

