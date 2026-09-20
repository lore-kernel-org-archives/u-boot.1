Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11D9C982EE
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC63440DF9;
	Sun, 20 Sep 2026 15:49:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8oog4MfKPR3q; Sun, 20 Sep 2026 15:49:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 518A740F05
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919371;
	b=mfUYyLaCxaaVrG4kCRgskyKDEwoEuN9GsFk86Zwl9mrbmMpLT0whbwHMHbpUzvHvf8t4
	 cEQxwlfubaSvYvCraPmi3Wj4E0ZwPpUjJtq9dfqsFTvf7pZCd8T/jnPgXE/m8w7NZxqFP
	 Q8jCRHGTZT5O3BMoCTl8+tsLYaD3NDeYz/PF/YdteETyIWKglkHUH5/qmjdzp8oP+ou9U
	 STalnKPRLvR7/a7IHQEWj2OquowWZ6YgAOOWQ9cM1shP6CHMQg9Oz68zI8CY9hdR9pyWc
	 m+MaZ6Eg2L1JsDXK3DiaUwZPhQs4rDW2LgqRq8afD/csuMRtiYAWXSkAH3e+55kmzsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919371;
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
	bh=Q4QOMWRFMRk31/YxaQlw/l+h5VI8CaprTZ59aWJInN0=;
	b=e2x3xe/z8lYChIE7YRj2StXDymK/a5Zti0jsdsQTVZCYSQfvGmM+wROHTicsf8JpoBYp
	 4DjvVCk9O0u5b+JOMQuOoQsdRGMeKvJY42rEFAL1HWCgf0Eex9/lKr0/TP/8+Qg28gOII
	 bEbnnhlthAgWkmuYpfNQVQK5heCCT0zzgrVqaX4jvYcR4CdEm/pVlbKc130fCuV5d2UYJ
	 OCllHv4TemrCyBBVV9k2Q0LW80pF+iJ9hWmK379dt/x9XMMCymWYZNL7wRLD7Wa/fUmFi
	 Se9nroutbsU+D/YZej2cvVS67lFGCEADr4yAsP81mAOODZKLDd9Y/KIkKzRnsxirz+Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mNpF0YwT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919371;
	bh=Q4QOMWRFMRk31/YxaQlw/l+h5VI8CaprTZ59aWJInN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XLDqRElsN4K9T11MHHPozu0uYqfoohz41dgCt03klaCqmWGM6JYRVbIkxLNCkoOWf
	 CgcFkgQBZ62+d3NbnNT/loy+B1daRVCwhxJUczU91RhjAWxS/PFMv4b0bNzu6aaSdI
	 iWkVpfCc96z5bj7HO8M6L4AqOWYpIiSqacYYo08aFmbmQiagea9rzrpykdd4cg45Ga
	 ZqxhCxcQKpy4elwBKcVoFCPn7QBbk81wmFz2728mC0jg65J3m1+PapgL1W64wNrB3j
	 Mx8nYSa4lsn2y9qbAdE3yEe/weCqS1xwQwwASo/YgUXOl9c8DGj9rFJcFn7wyfUI9N
	 /A65sI9hQwjdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 518A740F05;
	Sun, 20 Sep 2026 15:49:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1A32392
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3B5740E1B
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oBiE10nEXecF for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F315840DED
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913785;
 b=HhxONG4fxXeaRbWHMgtF1krQkTY6INOAUnHx4jDKRt6hWal0ka1VVQe5yCxfhrozH6tB
 X9IP49BORcOYWxvlOlPsyaMKHon8xpqjLPHJDoijgnApSKA4GD80Ub0LSoXeduOo4ykiD
 lS02IPQ+S8YJMWkMAy+WArZd0BfOBeYR7NR4//HkzNcRj/yfLtlsr+FcLgjsIBurrQK7k
 AWBpXBtbmCOu9xP3wnd5A9YD9glsSQtcHegj5u0766DSsuxUUQ4RI42cqFSQrNMuRWa8y
 JmVO2aBQpTgb7Il58pCaxQlEfHBLWki3h8uaO5OK2BKNyKpvLtn4AbGhftK8XDYPCJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913785;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=Q4QOMWRFMRk31/YxaQlw/l+h5VI8CaprTZ59aWJInN0=;
 b=gV84owe9ZN51mgdd13hqt2t6iy+6yyYU9W4o0IM1AO5yIld62KgY0s5G0ry/rf74P5IQ
 hMfdZXpyltDhi52n1SlP5P5fphlW4Yx92yC0qviYiFrJXnG1MdxQ0M32bnziNbCSox07U
 IMfeBaz6Bme6S4qK6S7WbdppNzSR/GnBwDxrNZh+tTyEAQgHtlS6vbxCJl9ybuY4sqQid
 3h7VZ2yo4fEfnWlOb0/DqT+wvjfoR5HUAc1K2m/syREVoyLeoUtE1CWrZ8WPPTLhMvmoY
 yt/+KmU2C/jpyoTlhx/fvQXtAneHwprOv28dz3CLEoSCDckobPLvqhs7u1R4p1tOsHg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mNpF0YwT; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mNpF0YwT
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F315840DED
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:24 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so12027175e9.2
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913782; x=1790518582;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q4QOMWRFMRk31/YxaQlw/l+h5VI8CaprTZ59aWJInN0=;
 b=mNpF0YwTveq2w/yLYm1AYgeKa+MvEs8vj88wcfnjVbzppQ3xXr9EKQ422Uy2p9rV+l
 nAKcMSAqZWBHLvTwbZJUabsaD7CebslMqOTTiCesFXPk/m30KVFvbkkqYAopW6Knx/Sr
 VHAF8yRTAv00S/+WtoCB/R/BFo/JZIbNYRlcHM8fgyQBlGZwG2ZCVoWXM7to7h/rrpc6
 +qsyNs24/sW37lHynNog27sBY1N0e0K5felCBRpym81TYBvoits7NjPcbdNMyWr+L9+Z
 OdvfqYxR4DIk3LUNx+OQJBYeNYYjmxZ4f0k9IaqJQahj4OKr6FdCZyG/J6dS9g3YW1Uf
 pnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913782; x=1790518582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q4QOMWRFMRk31/YxaQlw/l+h5VI8CaprTZ59aWJInN0=;
 b=sH054U+Y8I4AJDVSfTGPvKz+fHKyGhJTaP6z6nsiJkH+vFI3yzgsLUh5lDbn2nUyff
 zCAgc2qhbMi68Cy+2Qc2pLgnxNgzFiMLr6eBQgMnCG/MHnfqIej7yIRgStIt/s9ksXS2
 4nyOfcOuglAPYGkU12q0r1i5yIaV6nbh79Qiyogx7r4+Gq0tWcazjkjgfrwN6dLlIw0h
 DmD8Znr59iluE3cg7QaoaX437H3ZPQi485/kR9B/tNArwfhoMUq77PXhWEtmUTkg6e2v
 5njySIjQCa4nTwOSwOMbYLAgzQ/yB3+UudKKAQEA2rDxeYnKzplRXTI2MmO/CQED0RBM
 iWLg==
X-Forwarded-Encrypted: i=1;
 AKwUvByTsT8FyfbPgRxPL+CAvpNuJcE2obdsorq1PeH8OYFALLTFy6RRPW5x1cKEKqp2t0RAPMLBfuI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nKtnGmSMt0ClgBelE26AiHTvo+j/4tfTwjbM2KkCGmPO0acK/3
 kZTiQOPq6Uk4U1OJU+9ToMrcg6zvEp8ClBdPmZ+64c1C4Iw4gQi/SPHw
X-Gm-Gg: AYBFou3pKzLj6k2sw654hbTd/X36ib4e7ojxYfzF4eIu3WTO3lCPsExwviOgjd2VVDV
 u8sg07YMbUZAMK+DWou/aJApl0dZgUMPCdN6/0iSdremjjfHhIJD1tlQRVaNI/eCuCKU6MKQ4FL
 iJtV7wnJ9iQc7uWcwADqTGjQCuBCRiu2gvMwwfgXSXq8SAsMTIeJk0kgosADH6HCpwIn1Bwn9zS
 QlTCa6+kzhIE4vHlD9M8WrE0aHVRQhgkSqvAO1FxAJ9pVT90COleLU8lLy+q3bTZnbb+rrdbDmD
 F4hWMmVTxPnrRgJxskhE8a1H+ZjVkFjziJftq+mAx/XUajLrZ90sVUzriO3FRWZE7lbdjKA1/FB
 Q/U8vkBHEmU4PiwCFYtrt6QouHiT2tBw2Ttv0IdsUXJdzy4ODNVQk0Gelh136SqmeMT6ayErR2k
 PKuyClvgeadF8gusllKPXDN+SCYkoXILTYgc7Vintcidv3tVPplxIyWnWpuU/LbYLucBZvFQx/k
 aVyI+jn
X-Received: by 2002:a05:600c:548d:b0:49e:816a:9bae with SMTP id
 5b1f17b1804b1-49fc58500e5mr116481555e9.28.1789913782396; 
 Sun, 20 Sep 2026 07:16:22 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:21 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:48 +0200
Subject: [PATCH RFC 04/11] rockchip: cru: improve and simplify reset cause
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-4-42820216369f@gmail.com>
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

Split reset cause code into two functions: the first just returns an
enum identifier of the cause, to be used wherever needed (such as in
roc-pc-rk3399 board level code to detect a POR); the second returns
the reset cause string description used just by print_cpuinfo() and
therefore static and bound to CONFIG_DISPAY_CPUINFO.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/clock.h  | 11 +++++++-
 arch/arm/mach-rockchip/cpu-info.c           | 41 ++++++++++++++++++-----------
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c |  2 +-
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index 4bedf1a0294..fa346b68a5e 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -194,7 +194,16 @@ void rk3288_clk_configure_cpu(struct rockchip_cru *cru, struct rk3288_grf *grf);
 
 int rockchip_get_clk(struct udevice **devp);
 
-char *get_reset_cause(void);
+enum rockchip_rst_cause {
+	RST_CAUSE_UNAVAILABLE,
+	RST_CAUSE_POR,
+	RST_CAUSE_REG,
+	RST_CAUSE_THERMAL,
+	RST_CAUSE_WDOG,
+	RST_CAUSE_UNKNOWN,
+};
+
+enum rockchip_rst_cause rockchip_get_reset_cause(void);
 
 /*
  * rockchip_reset_bind() - Bind soft reset device as child of clock device
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 7f20f7aa667..2ec96a20c3d 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -31,41 +31,52 @@ enum {
 	SND_GLB_WDT_RST_ST	= BIT(5),
 };
 
-char *get_reset_cause(void)
+enum rockchip_rst_cause rockchip_get_reset_cause(void)
 {
 	struct rockchip_cru *cru = rockchip_get_cru();
-	char *cause = NULL;
 
 	if (IS_ERR(cru))
-		return cause;
+		return RST_CAUSE_UNAVAILABLE;
 
 	switch (cru->glb_rst_st) {
 	case GLB_POR_RST:
-		cause = "POR";
-		break;
+		return RST_CAUSE_POR;
 	case FST_GLB_RST_ST:
 	case SND_GLB_RST_ST:
-		cause = "RST";
-		break;
+		return RST_CAUSE_REG;
 	case FST_GLB_TSADC_RST_ST:
 	case SND_GLB_TSADC_RST_ST:
-		cause = "THERMAL";
-		break;
+		return RST_CAUSE_THERMAL;
 	case FST_GLB_WDT_RST_ST:
 	case SND_GLB_WDT_RST_ST:
-		cause = "WDOG";
-		break;
-	default:
-		cause = "unknown reset";
+		return RST_CAUSE_WDOG;
 	}
 
-	return cause;
+	return RST_CAUSE_UNKNOWN;
 }
 
 #if IS_ENABLED(CONFIG_DISPLAY_CPUINFO)
+static const char *get_reset_cause(void)
+{
+	switch (rockchip_get_reset_cause()) {
+	case RST_CAUSE_UNAVAILABLE:
+		return NULL;
+	case RST_CAUSE_POR:
+		return "POR";
+	case RST_CAUSE_REG:
+		return "RST";
+	case RST_CAUSE_THERMAL:
+		return "THERMAL";
+	case RST_CAUSE_WDOG:
+		return "WDOG";
+	default:
+		return "unknown reset";
+	}
+}
+
 int print_cpuinfo(void)
 {
-	char *cause = get_reset_cause();
+	const char *cause = get_reset_cause();
 
 	printf("SoC: Rockchip %s\n", CONFIG_SYS_SOC);
 	printf("Reset cause: %s\n", cause);
diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
index 713d3eb2eb9..7b8f658f87f 100644
--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -50,7 +50,7 @@ void led_setup(void)
 			press_pwr_key = true;
 	}
 
-	if (press_pwr_key && !strcmp(get_reset_cause(), "POR")) {
+	if (press_pwr_key && rockchip_get_reset_cause() == RST_CAUSE_POR) {
 		spl_gpio_output(gpio0, GPIO(BANK_A, 2), 1);
 
 		spl_gpio_set_pull(&pmugrf->gpio0_p, GPIO(BANK_A, 5),

-- 
2.34.1

