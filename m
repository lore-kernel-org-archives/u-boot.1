Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D56DC982EB
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CF7E80E16;
	Sun, 20 Sep 2026 15:49:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 84EJZldtAhqb; Sun, 20 Sep 2026 15:49:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 637B580E07
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919367;
	b=Sd76eItPE2+EWfWMVGOcwtWW8K0SreHO1vHwBBz+V2uOhUYiknASD0yPE9xbH2biSiKB
	 PGuBKlrXDEq1fjxdhL9ObLOZ6eFildo3ulbsa01fPA2P2EuPI1iiJpQJFBCXcdU/SbUow
	 tv3QBSAkQbcVn8MfTEujiDSKuAgc8Mrq+Bib2VnFWKpCMl16NAdHbIRwcFbzC8DxVE65E
	 01mXG2ikvRRmM8+QuVUrSbgjXtzNQg1ijcNGjRIsyvqa73P0eHaojMsxBBv8XR+gfkeOY
	 DZMPV3p/jyIpScFyLavkZ3N0Ll7fXRbVyn0Begx658zsg7EzCbD4p1LlH9z6vgz4iEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Hg/BJk/fvtJdguZA9b8krQkKYv92xNoaa0eus6BbRQQ=;
	b=r8BdmcS/jKYE3qg+ZtciOQRhWxEhps7PzFOy8GhhgBPcXaslMMBDaVu+0IabF8r9SXkt
	 fAaTF22uvyVR3imdgTtK5Uod87bbsAMEiUzppMFfnQpi+W7RVIQrskuB9Spoea+f6WrC3
	 /DH7sM3hv5q+VZdJZj2iZnDFaexrSGU8lR68mA99rbln8z2Z1zEvw3vdcX47WJwRDflpp
	 lmJm9zbNUevgh4l2cN2jtOokEeKTCtf9Glwjcx8B1dbUQ1dXSlx0O8zxFXCuwqAJjRTkb
	 0O0e4PrLzKpZAnYMbyoqCeCHbSkG6fnccbgy+hCJJa+UeLiiNLrkamMvIlmXjZMbuUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919367;
	bh=Hg/BJk/fvtJdguZA9b8krQkKYv92xNoaa0eus6BbRQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DQsaWuL+evxFYPhWirwMKQEF5fxHyZXUjUxhlxwiEH5g8oliAUpVmx83vT1rlOQhk
	 wyoNN9Ao9zSE1S/kw6H7UFY2j6dqrhsNroM/+WBs5VnlsyqT82giSppsVE4s0iQFLV
	 fsrJ9Z9VQO9KsWXG7aM3QmVD+p1Q0sAr2OnqmxInj/8IwCOQijy4sTbk1La1Ci7lXo
	 +qG+OT5kXnYHPUebUzaoco6NwX7soAkO05RmlVd1P7PJEV3R6Jfx32u3L1LizEwY3L
	 uPM0I8QhUnX1GYfb4b/uP/zifrw/0PL+WYGrVCXxQe2aA+rdVPKIkcWOIX16a+2IE6
	 wQmoPBTe+g+Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 637B580E07;
	Sun, 20 Sep 2026 15:49:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BDCF224
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D70540E1B
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUGUI_jnR61a for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 43A7440E23
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913779;
 b=MY+IiMoajeP6m7x7+8MfyqVG5tkF0+O0ou+VMZPpZD+37/RdqWjOqrMI3X9kQvTvnRB2
 xlXLA7dkfat0ur9BpBCwUbCwRvHlY0lB2qlhei6XYNTho5QVHlo1VmDLgwmEMZ8bhX7aA
 Z+L43xlNqfNB6lmZGnWwJ4Q/0TO3cxnlY+65YPZBHqxP6EckP23gpv2oMgo6dwcCk15ab
 schfSgHJI5ML9zagvT0rOG7bh8Hg5n11I+OTmbOMTL2XBf36skkxnroqzE5yEBRMyQ2qS
 Fj8CakjsB9NNgb45dHeCe/zCaGCOg20vPFJTIcUXxHnxOl7GRe15EvPfj0juwQfWthQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913779;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=Hg/BJk/fvtJdguZA9b8krQkKYv92xNoaa0eus6BbRQQ=;
 b=E/a3SCaowT8rpS/OsKb4NDx3Z4k0vRuqOWq0yEVXPoSNr3B8TkYNt7WM0Rg6GdK7OV7Y
 JKl31ZbrsSe05HxwhvU2O7eM+pHHsJU68eqZERwQSAjbO5GTs3bmCX0SpIzgeOvDUUfSI
 HPa238guCyyRECeEnUTO1ahOSapTfow7RVwway4rDkOYJLhC+Kq+7SuFMRVGaquv4+uD5
 82VxuIEXf5K8OhiRPK7zGaRm0spkoPIIUNM8eca78ZC2haPV00HnL7knBf9514K39Co4W
 yuPXuTUaQddTafLIQCQ5SeB3cIFaK7+QNEcDxhnMyABHErSEXysOecyFxZ32ad39PlQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MYE1moS1; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MYE1moS1
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43A7440E23
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:18 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so10602295e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913776; x=1790518576;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Hg/BJk/fvtJdguZA9b8krQkKYv92xNoaa0eus6BbRQQ=;
 b=MYE1moS15OcpCWkDlXAXdMPH+IGTRM75SsAf4zYAgHYVYoddtFadiL2huPq1VuD6P0
 Q7JT6D9mzLs5GFEzkajzDsfd+r34LbhFrcxLSsPIF7uK8bBX4dR/1fee2GokUVfh0sfd
 ZWCE8mb75ulYJzbCubOZjw8iXJEVs+B6hFiOv9YnJFgYKJbFxh9Iam+zOJAy0AQvx2LM
 ZL4PiyJ4a5yu5t/JN9FZelx8DjUr+CaoQRBQNVRKXbAxd2yyKe6IyUfH50/YAMKfeLg6
 kzlWi8R1h18hfnugo5rvB5OvlsxDKNVXxpU7Sob+nf443bPNpDD3J/feo/SpH6BLmzoO
 5vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913776; x=1790518576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hg/BJk/fvtJdguZA9b8krQkKYv92xNoaa0eus6BbRQQ=;
 b=r1XxW6g/Zl2BK64kD/4gJhkBwMY+P+nafGHesbl/lZ9JwqqAUXBwF4nP+8K3wpi46K
 /uFn0KN/lWw5UYbWaF9Fx/w0rAbDtr3MV7hvRCrHYlznVzrI1bYNooJasuNb663tIcYA
 gikn+D3F6hzJ72p03FFQaa5LoJMKuONPRY11CzPAW1up/JvMIfKP15r8+hG6wh1OkS32
 kGdqtr/ChQNiJ5p2Z4quFfGzBKrGutS0vdwPHSWwmzddPPbnH1PoXRsFjQAF7A1l7ucG
 VY/OP7D549x6QZxMfaZwTv+3PsJN1/xcPbDJf7wcYX1rN9yzN3Z78RjBe20dARNfv4w3
 YWMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBypB1+U5oeBhUmcceLudZfQPXSqGkWBjY7+7bgLpW6DE5jUkzk+8qNwv3zKefmO71iBbL2Vm+0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nIBVQwS5rktUiBfQ4lBDvLcgeEBiZRnr9/YcB/FfGXibLc+vL1
 r5zp/XEMjXY3ooYKAEhOdg2HLGGPURtGvPIjujB90Nm9tGeGfWhvWmgG
X-Gm-Gg: AYBFou33+ytOm6tZQzvnJNi9e1MEAdSx8pCs5AyrJu1JXxBMmuCqy1yaicKBwZVemm6
 Oh6r92d++pMiwQrtkIo90RyIeAqaxO5Sp+7qchJ5hKqQrNIo13Io9C7XNojj6WViHZK3rVjJWei
 O/Xxxz+BwqFd4xt1ztJugcMtYNGa35zlKVtZvkdXhFHLrnSKSAZEYJKrbvzd6rd/iUilBiAKTGh
 2x00EVYB4VY6bPeRvzkWrOZDT/tWT6D74NNiOUdTUm9rfU8bbvx9IbOrBmM7xJbLmGZISq59udF
 MeC9f8Yvcvpl1q8SasPDnVo6fsibLs1AnaC/NPx+wwB6J3+QoTcbuB+vzE6bPVU79TlkLW7jOKZ
 ccXkrfv3pfPfy3yUse8cM37tXPLSecYtFMW7BuDg6yYZxKe31Z0RiLULlH+Ge9qR6KIHydxVobv
 laWBrMSxWMt93BMIBXNeQ4KoY3jOWtj8gbuOzUBaImyZGrcbv8duHECjgdrVdqxLY6h5znBRESB
 7iYbiYA
X-Received: by 2002:a05:600c:1d06:b0:49e:8222:3451 with SMTP id
 5b1f17b1804b1-49fc5001358mr126944655e9.14.1789913776414; 
 Sun, 20 Sep 2026 07:16:16 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:16 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:46 +0200
Subject: [PATCH RFC 02/11] rockchip: cru: move code from header to source file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-2-42820216369f@gmail.com>
References: <20260920-reset-v1-0-42820216369f@gmail.com>
In-Reply-To: <20260920-reset-v1-0-42820216369f@gmail.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Alexey Charkov <alchark@flipper.net>, Fabio Estevam <festevam@nabladev.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>, 
 Coia Prant <coiaprant@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>, Andy Yan <andyshrk@163.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jiehui He <jiehui.he@foxmail.com>, 
 John Clark <inindev@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>, 
 Jagan Teki <jagan@edgeble.ai>, Ilya Katsnelson <me@0upti.me>, 
 Niu Zhihong <zhihong@nzhnb.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Akash Gajjar <gajjar04akash@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Martin Herren <sputnik@on-the-web.ch>, Torsten Duwe <duwe@lst.de>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

Most of the lines in cru.h are needed only by cpu-info.c source file,
therefore there is no reason to keep them in the header file and share.
Among them are the include statements of SoC-specific CRU header files
that caused SoC-specific dependencies to be spread around.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/cru.h | 27 ---------------------------
 arch/arm/mach-rockchip/cpu-info.c        | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
index c3259b8e7cc..cffbc18691e 100644
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ b/arch/arm/include/asm/arch-rockchip/cru.h
@@ -7,33 +7,6 @@
 #ifndef _ROCKCHIP_CLOCK_H
 #define _ROCKCHIP_CLOCK_H
 
-#ifndef __ASSEMBLY__
-#include <linux/bitops.h>
-#endif
-
-#if defined(CONFIG_ROCKCHIP_RK3288)
-# include <asm/arch-rockchip/cru_rk3288.h>
-#elif defined(CONFIG_ROCKCHIP_RK3399)
-# include <asm/arch-rockchip/cru_rk3399.h>
-#elif defined(CONFIG_ROCKCHIP_RK3568)
-#include <asm/arch-rockchip/cru_rk3568.h>
-#elif defined(CONFIG_ROCKCHIP_RK3588)
-#include <asm/arch-rockchip/cru_rk3588.h>
-#endif
-
-/* CRU_GLB_RST_ST */
-enum {
-	GLB_POR_RST,
-	FST_GLB_RST_ST		= BIT(0),
-	SND_GLB_RST_ST		= BIT(1),
-	FST_GLB_TSADC_RST_ST	= BIT(2),
-	SND_GLB_TSADC_RST_ST	= BIT(3),
-	FST_GLB_WDT_RST_ST	= BIT(4),
-	SND_GLB_WDT_RST_ST	= BIT(5),
-};
-
-#define MHz		1000000
-
 char *get_reset_cause(void);
 
 #endif /* _ROCKCHIP_CLOCK_H */
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 14c7331e1ab..4a23fdd70ba 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -11,6 +11,27 @@
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/err.h>
 
+#if defined(CONFIG_ROCKCHIP_RK3288)
+# include <asm/arch-rockchip/cru_rk3288.h>
+#elif defined(CONFIG_ROCKCHIP_RK3399)
+# include <asm/arch-rockchip/cru_rk3399.h>
+#elif defined(CONFIG_ROCKCHIP_RK3568)
+#include <asm/arch-rockchip/cru_rk3568.h>
+#elif defined(CONFIG_ROCKCHIP_RK3588)
+#include <asm/arch-rockchip/cru_rk3588.h>
+#endif
+
+/* CRU_GLB_RST_ST */
+enum {
+	GLB_POR_RST,
+	FST_GLB_RST_ST		= BIT(0),
+	SND_GLB_RST_ST		= BIT(1),
+	FST_GLB_TSADC_RST_ST	= BIT(2),
+	SND_GLB_TSADC_RST_ST	= BIT(3),
+	FST_GLB_WDT_RST_ST	= BIT(4),
+	SND_GLB_WDT_RST_ST	= BIT(5),
+};
+
 char *get_reset_cause(void)
 {
 	struct rockchip_cru *cru = rockchip_get_cru();

-- 
2.34.1

