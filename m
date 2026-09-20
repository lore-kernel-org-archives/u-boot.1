Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8478C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32FD340F00;
	Sun, 20 Sep 2026 15:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d4qIsIQepEsI; Sun, 20 Sep 2026 15:49:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0373240DB3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919369;
	b=aR4ZaQTjXAAA4DXPSe0nshEm5uu2RqecTT+3f0K0TTC5g6M0EYHhClvmuHnzc8vmkfpI
	 zwhGeUAemSZmHLf2aJjl1uR3HgJ2Qo0aOhpivWB1B7Mgh1tpQukyDPyEqJTlA3x0icqoo
	 1EY2X7Oohn2eyXuBRrafByNrRjFssHBz/pPaeHbTTRVg9vp58y3996yM/NDpmEHp7poat
	 QPBHHqDOtmA3JxP/vJI4bVHUWSS4YnUA0lnG4AGu/S2tFIzdkjWRRw76ewzbeABjU8E8q
	 kmD9A4baEnTs6ZDhNdV7uzMOkDqyp/TDSgztBNX+xXI8L+4ZN6qt9AigFv6YwdikaHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919369;
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
	bh=PsaDEPLJ39ZzGx0zeB9lMjtCBvIcz+satBbiJ+n9iOI=;
	b=NktcOiMmRba2wt0Oog16mxzse1bO/N36S7/7571xbaSSTt0kjXBesj6ribcU0vQw8Jrx
	 z/UOnLPsGcmaHvaxq+nUHT7kE4rqhHzdGYmFwmKmumOPYpRyqJncmXTEetz8E8O+NdgbQ
	 jABHBf+okylRYvwgiJO9rOKrn3ei9jqelecNfEK5pgK/ZumzyN8vmyZy1fC2CFY2RkwCh
	 J61WxlJnYZrWmPDRiiG8qKqSBz8VDHawRSxgyqyNIVSg2MFGxAJvOea9i98xCZGLDDU2r
	 V3q7RC7FcTtk8QCHTy4dHkina218PwdwO7mmpDzPNnp5RhWWCEY67SnTKEIEj0ME4oA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m1TOtNgA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919369;
	bh=PsaDEPLJ39ZzGx0zeB9lMjtCBvIcz+satBbiJ+n9iOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jXa+6XbwfncMY9E5tt5LDp3u+eFU62vpisVvO2CdMHR+hyHnb51ZgHrgpgatOv7nh
	 SG0+O1XR91AgjaaFnb/38XNcGcBIqGyD7huwqkL1HDaFDSYl/Ws2hHbwNzfFyZ2cKL
	 00sP8aUYAXm3eLpiM6aIIMlVOODnx5Frx5rdeFrhAMjFbItS5wTlaclJ1svHzHj/it
	 S+8U+XmPgCNP4Z7g2nIdbSC2+j6qOYfxnsDHOzrWePQ0tqOrg97Q4TAwFppOwkmpve
	 TSCWgYFLQJcEoTfSxeA94OQ/XIVffFtRRpon+7PQAiITbrjbN0K9AKb2T5Xau0IDYA
	 XikauLBUaKpqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0373240DB3;
	Sun, 20 Sep 2026 15:49:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3E3F224
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A40840E22
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m3WbyfyOlJBX for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8F6DC40E1B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913783;
 b=p06chAkiFVVp+QsFnJTpemdJ0vOp6fxKHjLJXIT6xLPX7ZVMWSdzMFOWYO2tT5+hOfJ0
 y6+BE63Ww8iLcSCBecS7exmK2te1CvhsVbHx7nCK+ildNgqzwOZZv0iNJsVIoD/S1ba3y
 nuuHmDDJkZUw6qdnjPYRwXIDVc5tKnei5cJ4tiTSLfs5IoQr4CeXajS0wNd1j6LYxyPjv
 LVG8U0Kq7Qjc0ilz3k4qfI3puoMAr1bGBMjnXWmQup8zaMlWzTSzWn6eRtGMmHWtXiL98
 r1h3pvUrecaoOF/JTKW75+c5Mgd82t4X/hyBe5OaGw4EZ2UCEbfYsP3EQqqt+aT+KVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913783;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=PsaDEPLJ39ZzGx0zeB9lMjtCBvIcz+satBbiJ+n9iOI=;
 b=Gs02PnN+05qZPH7K/f3613CdBr6F8RFDynHrvVo05LoP6/Wfknux/TuutW8FFXCsqbkn
 /N2gSQFhoGKUQP2FU5xG8jekBOb8iK4SQolG3zYrpOOKzFVQlmij5lMrWuyrLft6JkanT
 Vys5p5EJcFU6WlQaqgUP6Wur+J4JUPbxyYL3drq48ynHobJFUwpqHWyuuT700k6RVKRbi
 7X56YAoqQCXQSSJnKZsM5tVIYkXjYP4CG6qE4Yo+Y2YMOHZaG14yB9zHpT+XDWL5X7otR
 kRWmvvpIUA0jNmbDwcX1WolY+gg068oV1B5VxSHhie84/qCr4fjmY1vdOS9qjSKE1mA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=m1TOtNgA; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=m1TOtNgA
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F6DC40E1B
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:21 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so12253825e9.2
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913779; x=1790518579;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PsaDEPLJ39ZzGx0zeB9lMjtCBvIcz+satBbiJ+n9iOI=;
 b=m1TOtNgAFIrarpqweszrOjZMvmA+MB18o+hesqshIfZ/UFuGj8evUrPEz/TI0qob4Y
 JyAOp7oevtTbeCdr4dXV7PF4QCZDIjNcrGhwNFb8iGxREMG8zZIICFFI/fhZCLUCGS/6
 +zZwQR15hkNazCbCa1L1GcNZOUoGydy0hTMigJblHSlniwDon7TJ2VsyW56GfVw31ss9
 WoyYt0mVqz9hrOWFkKo1nQSReaIW3LxmhDIKk0nMAz8pZHGBUdG27oKpt6suPFMCs9jj
 FpMahE/vE98b5ursHTd2QPZ/Q5C9NTP3Y7ymfwp/GrVzNu7k6KpNVRvn25UaH2jypLus
 0B9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913779; x=1790518579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PsaDEPLJ39ZzGx0zeB9lMjtCBvIcz+satBbiJ+n9iOI=;
 b=RUfpprAxJ0988K3Rlilrmj3fhOCNEu0XFIuQ0ohuKBa743Ql+q365i+MEKHkdJNeWX
 deloW8ARljc2q/0M2VfgG4lpwYFcNb5y7RHUpb2JDYoBjjZHBqvtZ+lk2hThTb0afMTm
 fo0+miVicH66Cnib8NjFM0CqzNhBd1HA8dlpZj+C7hKFrc1B8YFioizKFuRQjEPx139E
 2uHf4rp0l8mPovFx+9jqnyFSvQlBt0IfXlEneK9d1dKcJmem6DyblF7cik+g0jnA3e5q
 XZ+2+9DsYwEVDKMWj09qvapgZdqd5KFl4a1YzhjR5j98VR6zqw760lsCyG4qEvzjxoxB
 RCyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwozz3hzyJaYj31i4Ths/psD86e+gM+qV+/IZxw3hhxsgOcYumBuiV5JdbdqGzgRlCAhXRvEGU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++knEavNRNKk19CdrMTFcwXvurvsnJzWujzVfU4iJ4+WovbeWUQu
 BzcMBw/ZZlybpbV3za4ciY7CKZ7BfsvKMVwOlTWJ3dve7eLouAqCsm6Y
X-Gm-Gg: AYBFou09NeogdojERZhapcF7ZGtVXQjkgblWQcykcAR9Cq3w3OaWinki3RVWjgjZYRH
 2U8Bxj/L949dTHWJapJwc8dZhqe1xSatj3Gcd3numqnync5U2JT/INREaH3rliW7+wu8jR/KDjr
 +DGo68ptmVYfoiiHqtXlkHBDHBrclq4moWQyAVPCPIwZYFrBpcwpxRxMhQHCbHLypZPhIpjynQE
 3JW+OCrJfW1okKgR41HsUNP0aMYV4KpMiuuxUxfSPlpR7hkjtrmu7eRH3mywQoC4EhWn01UAyRV
 0db3TcrieJhS7JPMTkJCEE+nX2yRX0U5MAJPEFjCy2+frrwwmLRxInpzsdMDXjvea7QoEuy8tPS
 28HPjFrLoVvHkv/Xjh1YxAt88u0UZuiRfOjs/ZqTrMQWqGLcMszFm/Fhx54sechgkyizOT9+tgF
 4h+58VHjNAJQOJVfBi9R3Ys7O5G4lF+MZg/qNPnr5WMNIrXGZJ9QGpZ8eVPslzL5EylTqzK5z1G
 k4c+Lmuqg==
X-Received: by 2002:a05:600c:5020:b0:49d:726:cc9f with SMTP id
 5b1f17b1804b1-49fc56716f3mr105112745e9.5.1789913779004; 
 Sun, 20 Sep 2026 07:16:19 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:18 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:47 +0200
Subject: [PATCH RFC 03/11] rockchip: cru: remove unnecessary common cru.h file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-3-42820216369f@gmail.com>
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

Move the only remaining function get_reset_cause() from cru.h header
file to clock.h which already provides the whole common interface to
Rockchip SoC CRU (Clock and Reset Unit). And remove cru.h file.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/clock.h  |  2 ++
 arch/arm/include/asm/arch-rockchip/cru.h    | 12 ------------
 arch/arm/mach-rockchip/cpu-info.c           |  1 -
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c |  2 +-
 4 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index 8d3819778eb..4bedf1a0294 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -194,6 +194,8 @@ void rk3288_clk_configure_cpu(struct rockchip_cru *cru, struct rk3288_grf *grf);
 
 int rockchip_get_clk(struct udevice **devp);
 
+char *get_reset_cause(void);
+
 /*
  * rockchip_reset_bind() - Bind soft reset device as child of clock device
  *
diff --git a/arch/arm/include/asm/arch-rockchip/cru.h b/arch/arm/include/asm/arch-rockchip/cru.h
deleted file mode 100644
index cffbc18691e..00000000000
--- a/arch/arm/include/asm/arch-rockchip/cru.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
-/*
- * (C) Copyright 2019 Amarula Solutions.
- * Author: Jagan Teki <jagan@amarulasolutions.com>
- */
-
-#ifndef _ROCKCHIP_CLOCK_H
-#define _ROCKCHIP_CLOCK_H
-
-char *get_reset_cause(void);
-
-#endif /* _ROCKCHIP_CLOCK_H */
diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 4a23fdd70ba..7f20f7aa667 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -7,7 +7,6 @@
 #include <env.h>
 #include <init.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/err.h>
 
diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
index 5a71e94ae1e..713d3eb2eb9 100644
--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -13,7 +13,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 

-- 
2.34.1

