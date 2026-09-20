Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD16C982E1
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFCD940EF4;
	Sun, 20 Sep 2026 15:49:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xXH-sh1W1USW; Sun, 20 Sep 2026 15:49:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8797240E41
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919365;
	b=N2ac7XqkBzlSa8j75PsASvO3/55dQZpbtXoherxuwmIO4qJPlu6lpn035wBaDGKVy/fe
	 HqiURkWsRAmFfKO7tKm1lE86KwMCaS/fR8uIJvskeefGkQp9VmlxHL+VJzb85fb6fdQd+
	 Cs2wTIqeZ+7gJkFPYnqJoYTmOEhvo7pDL1Lh6G4IuubImsm9dKEUc2lvJlwAW90G0yfxk
	 ERmE2wjO3QmZg8bGuLSXeUVF46+8zxvxPQCynqHiF1IAdU/+xinE5gL8ZikPHqgQMFctf
	 6BVzuDyaJ7SpgsLEjcnVEeLP+pq8J74C3g/GneVemC9yr10AT60JKsgi9r9r1+Qay8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919365;
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
	bh=Cm5Ts9kxkXPkIkxU/OYttUFeluIQCfBdtBsJ1c0kYVA=;
	b=gOH2BIol/qoVMBkCcd6peRpEl18vrEJUGdMLHfa3nR5o3UGVLb8LN0n2DiDQP1NadGLa
	 sS90WJCTED/dVqN83lfp9+qzRGEh3NSWKe5Drzvj2sWRQPn3f4duFmn8lRQNf0y16m/y6
	 Pbcfxgg3dSn2aTH3zC8VcL1owDP/Fqh266sorxLosFpFuTAuFucTlZHixQWgUFaIlMNyL
	 JdvI9wCJw+LHgMjDf0H3aw7tDs7XXTKSiv0EvpC+TuMeX10YG7YPJfzRM3rqPt0mpmi/A
	 buxBUCjRSVgWVJdi0EqcXq8pX2dpMSCc6gXRy4+ealoRj1M3yYlzh4RgETbEaUaAONw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919365;
	bh=Cm5Ts9kxkXPkIkxU/OYttUFeluIQCfBdtBsJ1c0kYVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jzay/iQBZWeMfayczJ6k9RegGFEc6wD4sQ3zaHP09XL+o5mEfhL61zgKFSAffvpFG
	 3Jf6/zr1444AZ9qBq2Em0nI9jAqUvEEABJFlhXTtkphuFF7vlyQJg6u/l5nYsvMydT
	 AoZfw3HanBxilb/8+Lm9Q0fJc379vhhahcn/zTxXfsG0gBCH7W9kOzrwcbtoyR96NR
	 eMRXck9wKt2tDMTOF9zf1EAY6LllkuH889GGlhTP97j24Eb921NKKsWyx/AHgQ7F6h
	 U/eyPgfd1Jv+xW70qUxEFGUoisxXmFYwGgPaCvBFUmQZiB1c+MTvHUXyLXXPVcwW2A
	 UIVm3Tam3HY9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8797240E41;
	Sun, 20 Sep 2026 15:49:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB28A24D
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0DF7400D1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vnXPl9XAaR0q for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 14:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8DC1540022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789913777;
 b=nnSX8GCzwWHeHbQW6gpk3+eK6rJLeJtFY30wE0/GvWLi4lq+Lev37x+jhqvge+feAhTW
 aWYnpqC+WXcwbu9Hlp1ruqLoDuYoPcBXYUqbF7ttBIOZWbkmwp0/0FT0PLWTsffF49bYj
 3qK8pGc5oVMRGjR+RDtDLaP8qYKVfag/Eoo5hsSY+K42+DGRET2+aSHlwf2stGIjiHE8x
 NW3Mxg0uRnfdmtthiKOUhyYwa4OTUCjSNBiwoB0tUfA0q3oDIz/aWDgSpydRVbiOP6ony
 Zbe8ESLPSZ3a8O97E0CMFFTZP13DYR633g+f8GLbzEYMS25PUyGSWSOOhez16hnc91g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789913777;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=Cm5Ts9kxkXPkIkxU/OYttUFeluIQCfBdtBsJ1c0kYVA=;
 b=PNyn7IqwxzzZnmtP4piLP+vHHMKPg8/jUM3fV1kwh8lG/vkiTt8k6vo6gT7gGc7+/5Gb
 UKmXCaRN30x9ZN18qcZBVo/etdoTNCWcStJwfgJrmz/P5/M7LWTbJJbNeXTMKnBpmt/0M
 2iNZs3IKBHLEbp24byOvalwqjlyylK7fBjQC8I0PIMKJLob9HW/S4UxKpipx6tmTnoKNT
 CjXHEJlBuzKZqs8BDicSuyIrYEaaKioJzDmCDhXcNp8B426d39P1NeAMEYvk64hhNkPN6
 IslEefzFUSu63bp3NGVmZ3pSbd0J/0L3tO6/IFjHAaj8mCxiXgE0ZO8qvjJRUGvF+2g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q7K23Ayx; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q7K23Ayx
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DC1540022
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 14:16:15 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso15617375e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789913774; x=1790518574;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cm5Ts9kxkXPkIkxU/OYttUFeluIQCfBdtBsJ1c0kYVA=;
 b=q7K23Ayx0m3ROOeOnunhHLoxVZmpyJWJ5oa46Wb+nPPR79iDY7L3/bWQIZWU4JnT63
 UxdbimkD/oA+uGrHKgnE5fDWCGc2ZoKjbJF9SZUZFebSUjrbBFLp1Qtv7u9c6lsP7EkJ
 oYFxKzjv+gnufdptaoX2v0wX6nBS5HHo/qzVtnSpUA+8TJrbPtfRbHdg7jTdstKU84Bp
 CHxGVfhUQ4AwC4YHjwsBS3r5MEYCFIMPDFm44eW9/+p44oPf4ucVEBYe6cA5eMBGomzi
 iW/csetlyZom1biuLJai2zOpjmViCk6LYpCeiD31tFtJ+u1dwPzb4a5zNyp2nFZAUIfF
 +giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789913774; x=1790518574;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cm5Ts9kxkXPkIkxU/OYttUFeluIQCfBdtBsJ1c0kYVA=;
 b=RpJj/RnPwC/IKpqA2+eDJUy+59bQv7DuQRcBNiobyzJgGaat7Z61hLdL6rJ4MOG5Xy
 NY3zWVmTSpETogSn/VrBrePzQrPo7GJtA0kJ0AukySk09aPj/bcir2gBeKwNsXbrCag0
 MtABjAQSCwZttlFUs4E7SfPUvYpn8VfAQU4fs1wDpyoAumcUx1E3YHV29fUSgEci83SG
 Ip6IkNf/g9qTYYkJSpX7ys7Gav5PhCMutXhP3zfUeeFvNGEToKC686XZOqqQnjcrB3u8
 Zpe5TH14oCVlFjo9FwKGnNXigqIOiwdWjnj289xQ91M45cdrc21G4j22kXqupe6oMxY2
 4cAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzISd6ly6MkoNH82xYKTTH4GcJBumrKnZ9zsC3CKddk31JcgNRMVdyD227OV+8AslRNtwIOAt0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kLJj+Jl7z1Af9q5baQA6iHTjSDREGyL1HKW165hLRsQTfk53na
 zb1ROcwkRRbXseJaOzkm6bXQlRSpKz40pSiEdwdKSv19P3tq4e5dspFA
X-Gm-Gg: AYBFou1DvUeCBB+Cm1saHE2da4E/TsQG97p50fLsZyEL2T/BUlmQoQke+CNINHiokLs
 jO+0g9igwEdMAvGmpTmbsPxzqQMjeE1W3/r+cA7LE+r3fbrrnXDvVFAddPJkefYIJMPtKTp1gWC
 Wcbv5Px/QyWbVAVB3GaJOSiwYzUnqEzrB8L3zh7j8E8FZLeTJMF2g2640w3XBH0yhspFWGsUQyc
 utt2Ceht0gVL7PDazCtHaU6luekwRLUP3pYtaCyKLfxnPqV5fiPhl7vdzkAMLFEGJyvV/H2KWhE
 E1v4G4vm7ep/cURSDZNgPpHK56gINJr0IW+t8e+b0NNrXwaSfwMhXSY1ENpVyDAgoL96wnOCPj+
 2tT4J0QiNbNkEBBg5DCelWNgUPJmfRAABwKBObd+yLUBrrUbfypujlEwG2Xg3G2nfoRU1Sjr642
 +naQY1J9w+L0N9kWyR2/8mfA6C+wj3d0H8FhPkV5FSP4/ER/ShbPx/SNOv/SeZ0LTlq7GRs3qDh
 dc4jSjf
X-Received: by 2002:a05:600c:4f86:b0:49f:bd3c:bc25 with SMTP id
 5b1f17b1804b1-49fc574e7d3mr110771155e9.32.1789913773844; 
 Sun, 20 Sep 2026 07:16:13 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.151.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm184107005e9.3.2026.09.20.07.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:16:13 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 20 Sep 2026 16:15:45 +0200
Subject: [PATCH RFC 01/11] arm: rockchip: include SoC-specific CRU header file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-reset-v1-1-42820216369f@gmail.com>
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

Modified ones are SoC-specific source files that do not need to include
Rockchip mach common cru.h header file: indeed, SoC-specific CRU header
files are enough, and tighten to the effective needs, thus preferable.

Partly reverts 'commit b52a199e323e ("arm: rockchip: Add common cru.h")'

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3399.h | 1 +
 arch/arm/mach-rockchip/rk3288/clk_rk3288.c      | 2 +-
 arch/arm/mach-rockchip/rk3288/rk3288.c          | 2 +-
 arch/arm/mach-rockchip/rk3399/clk_rk3399.c      | 2 +-
 arch/arm/mach-rockchip/rk3399/rk3399.c          | 2 +-
 drivers/clk/rockchip/clk_rk3288.c               | 2 +-
 drivers/clk/rockchip/clk_rk3399.c               | 2 +-
 drivers/ram/rockchip/sdram_rk3288.c             | 2 +-
 drivers/ram/rockchip/sdram_rk3399.c             | 2 +-
 drivers/video/rockchip/rk3288_mipi.c            | 2 +-
 drivers/video/rockchip/rk3399_mipi.c            | 2 +-
 drivers/video/rockchip/rk_mipi.c                | 2 +-
 12 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3399.h b/arch/arm/include/asm/arch-rockchip/cru_rk3399.h
index d941a129f3e..8d0a15efd50 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3399.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3399.h
@@ -64,6 +64,7 @@ struct rockchip_cru {
 	u32 sdio1_con[2];
 };
 check_member(rockchip_cru, sdio1_con[1], 0x594);
+#define MHz		1000000
 #define KHz		1000
 #define OSC_HZ		(24*MHz)
 #define LPLL_HZ		(600*MHz)
diff --git a/arch/arm/mach-rockchip/rk3288/clk_rk3288.c b/arch/arm/mach-rockchip/rk3288/clk_rk3288.c
index af6c5d1f59b..d725730f5bd 100644
--- a/arch/arm/mach-rockchip/rk3288/clk_rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/clk_rk3288.c
@@ -7,7 +7,7 @@
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3288.h>
 #include <linux/err.h>
 
 int rockchip_get_clk(struct udevice **devp)
diff --git a/arch/arm/mach-rockchip/rk3288/rk3288.c b/arch/arm/mach-rockchip/rk3288/rk3288.c
index 62dd9da6578..81f9c95bc09 100644
--- a/arch/arm/mach-rockchip/rk3288/rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/rk3288.c
@@ -13,7 +13,7 @@
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cpu_rk3288.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3288.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
 #include <asm/arch-rockchip/pmu_rk3288.h>
diff --git a/arch/arm/mach-rockchip/rk3399/clk_rk3399.c b/arch/arm/mach-rockchip/rk3399/clk_rk3399.c
index de552b5903b..170071d243d 100644
--- a/arch/arm/mach-rockchip/rk3399/clk_rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/clk_rk3399.c
@@ -7,7 +7,7 @@
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3399.h>
 #include <linux/err.h>
 
 static int rockchip_get_cruclk(struct udevice **devp)
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 8687a9347ec..85c95172699 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -12,7 +12,7 @@
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3399.h>
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index a4ff1c41abb..794cad3ea22 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -15,7 +15,7 @@
 #include <syscon.h>
 #include <asm/global_data.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3288.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <dt-bindings/clock/rk3288-cru.h>
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 6e87db18be0..3df942edd34 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -14,7 +14,7 @@
 #include <syscon.h>
 #include <bitfield.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
index 25ceab98ee9..8136ad070a6 100644
--- a/drivers/ram/rockchip/sdram_rk3288.c
+++ b/drivers/ram/rockchip/sdram_rk3288.c
@@ -18,7 +18,7 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3288.h>
 #include <asm/arch-rockchip/ddr_rk3288.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 6fa8f268770..b792caba203 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -16,7 +16,7 @@
 #include <spl.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3399.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/pmu_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
diff --git a/drivers/video/rockchip/rk3288_mipi.c b/drivers/video/rockchip/rk3288_mipi.c
index 574ba8c6957..dcda469cffd 100644
--- a/drivers/video/rockchip/rk3288_mipi.c
+++ b/drivers/video/rockchip/rk3288_mipi.c
@@ -17,7 +17,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3288.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/rockchip_mipi_dsi.h>
diff --git a/drivers/video/rockchip/rk3399_mipi.c b/drivers/video/rockchip/rk3399_mipi.c
index 68316df871c..2f4e99f714e 100644
--- a/drivers/video/rockchip/rk3399_mipi.c
+++ b/drivers/video/rockchip/rk3399_mipi.c
@@ -17,7 +17,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3399.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/rockchip_mipi_dsi.h>
diff --git a/drivers/video/rockchip/rk_mipi.c b/drivers/video/rockchip/rk_mipi.c
index e7b5973ca58..c3768ce0b0e 100644
--- a/drivers/video/rockchip/rk_mipi.c
+++ b/drivers/video/rockchip/rk_mipi.c
@@ -17,7 +17,7 @@
 #include <dm/uclass-internal.h>
 #include <linux/kernel.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/cru.h>
+#include <asm/arch-rockchip/cru_rk3399.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/rockchip_mipi_dsi.h>
 

-- 
2.34.1

