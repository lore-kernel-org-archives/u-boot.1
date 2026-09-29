Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2707DCA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:15:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5D6480F16;
	Tue, 29 Sep 2026 15:15:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9w1wROkFwbi; Tue, 29 Sep 2026 15:15:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0788780EF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790694958;
	b=TXkeGOng5SGb3nelBOjRQFc3xCIPf5oiwod03zBgDWYq2sOGIj7oT0275Z5QPppBAQPw
	 3fX7og3aKCbYe+Nyd7gpU7OedmuOvswaN/Zkwk4R4uRbFRB91CYitLVSwV3XbmfIK/Uac
	 ULCklWaaZe1uAqXQvfOiTxhQ1xd550KpHxfLV32go+Gl9KQwc4JMsqmtMZOtWOjy97Pcp
	 rAsVVuRCSE26PSQATL7IvOAuxfcuAPLe8nxRKyVGMjhXunIoPcqNOcDMl/CHzN5H/sk3n
	 UbaQFkQFG2Us7rIFFQqivOj+XOIjZtP4Jqin2KInnBZvJ520FuoIHRMI0iNep2KexDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790694958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dbw5SEMVCDGsu/X0jWA1cYleM4eJddmuJqXy9IMwKEc=;
	b=cLBL6cOGZhKkPwu0hho/eWJdgEMa7ERarEo9FyrZby5hawbs+MMpqIlx4NVtxtbq38cB
	 XkryNr3+FvrncN5SlgvEooMZb1jfBzOsLyUwYd7Eg8GEpkUOHPypUBcTcMxNldaoJFICV
	 rTgymVi4qR/G73X6q/ZqtfGBQg61HlQhXh3+lfXNam0RkWh7xZ4awkG1mwnDuKCoVmbOo
	 xGt99/PYKAYImmsGR9iePW/NDy6kbpBEoEKUk/posD56u2yEuarYPfmymRfNxXTdWMN5t
	 Hph6PcCPGMfQ2cRuYZwUpZ+S2BVdEN/kdkAFkSj8+gHPF8drj6yYyaxjccGORAY3nug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790694958;
	bh=dbw5SEMVCDGsu/X0jWA1cYleM4eJddmuJqXy9IMwKEc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zL0qNg+8Cs43Annqn1tQXGEUc+bBxre+TOR7dVVYyV3RGTiDiNBGn22nUftk2elnP
	 LFmGmCJJCmo/hjjRChgAMAofH8obtjf47VQ46OHE57tmqJWG1wh7TbLxLIWQBdkWCz
	 iz+u5B9BaddZemGBRz5mpX1EOKuwjGI9+87wWh74QSu6p/b5lkY+nZ5QO82NT8EV4o
	 NjTuYSNVlUJck4caR3RPwzS3lOq+bYDxaGp/G6/Ix5dMHETFXTgq1fMgYa3IwluTfU
	 GBRbJtonAgVwzRQMweGSZkvI4KxIPxl1gviU9u/nkzCCqlEmnRQoFbMZSuvd4kGhgQ
	 6actjAiw39x1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0788780EF5;
	Tue, 29 Sep 2026 15:15:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 402CD335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 244E64032B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:15:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OLfZfqp5EXa6 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:15:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2002740304
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790694953;
 b=D9ukr/q1a/LggjNH75dYiaPKDXdaYdG9e2Nn7k+nwgrzq0jG6xExKRi/jNW2Oy7vhSsd
 gusSd/NTwONC/Jb4qPaPwZZrdBYOG/VQWrM4R7zVGmLRWoHh+jt0M1gHgCCk6YDWriAeW
 EvrqfORdnJWFdQQX7ieHpUxxmI76hm2mxcHQdFEj9FgT59N8A7bS+ALImvxfNBCWm3tf2
 ZJ/74A+KrSb2sgWD67TGvBiOB46fcoy/YZ7OfOV+wp4csyIJU09vnWw0lWudsb44H+SA9
 P7B88Dug/N7wu6Xw2v4s6xNAmIUqlBTqnes5GbWZBBs97pMR57pUt6/m4vCpEKZ+kjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790694953;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=dbw5SEMVCDGsu/X0jWA1cYleM4eJddmuJqXy9IMwKEc=;
 b=Y95mUNvtrdVEwFHW1ZpYk/eAI9mlEdiQCumGpFmMuq84178MyNYAZZ01/Uiz/A9Qq1ks
 687bzOMfEGhUTlwkRdJ0dThE4UTeS4ssfCEknQlA5J8/EmcpMkDarX3vTempXhBOpTiar
 eBHhuHz5lqU+5f/RxXoZH9Tgo7hRAM++756JAx9xKLwMQesSOoDaVhHpUAJFrhs91WGKg
 PA9IBdH3ro7U+K7aYkIaN5Hwd2DoamQIrhcELqbGYBzHUccLDRhD663zgqrWWBzkPFVSU
 rrqFPSp7NI4BZFjQhUDbyVR7treHTmB//c8WrjZBy4EjrI79IHfHK9SPkhihX5ugo1Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=atWS23XQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=atWS23XQ
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2002740304
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:15:52 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so32610505e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790694950; x=1791299750;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dbw5SEMVCDGsu/X0jWA1cYleM4eJddmuJqXy9IMwKEc=;
 b=atWS23XQ3yxr9A4xMgWam4cNlne0GtZNo9rENeAzucbCW7lPlVZkrphlSLLHGmlcEQ
 OvFIJhGrcRnLfkO5SeBxpHpGxKfYjoLfwV8HCQgYtNry1pkkwrtQVrI0pnjF62czz8Ba
 O3QZOdGBvRyVtp9mQbh8kvzK+MtFWOuFn/qWPbIHjQ+ChnzrJ0OYXDGRkRemNu3JIrvn
 DBNysh95nZwc0Njhf2P9DnTAZ8S57Gn5mrtsj85ePuUecXoFT6tWB3MEjEi5moxZgLoe
 cBJVXOGO0TBvqmXxl3PBLRDW3d6coEPKXO+0e88mQUZgh3RsSYMAVf/mNbeeWpsgOwXX
 f1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694950; x=1791299750;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dbw5SEMVCDGsu/X0jWA1cYleM4eJddmuJqXy9IMwKEc=;
 b=0mTe2k2YBRhBrReFr77PysrvyM5ofuiDNylJBk5He763IVE0Xg6Sp4++ZAcz6AV/7I
 DskHAk5Zh/CexjLn9h58eyj/zayz/d9Bi5t28ST7TA35zKl9ygR67rzqoy5cWXpIbsAV
 ya5I0Y7/y1xKfP6yu42pZMQXuxsF9hJANylGjPFP+Pr+tdf1FwYleKxaXpShei/5dR0k
 Yxigc1pZT1kpvR9MtOvCLGl+eGcPE33c9Dhigi4xsOOaXG2ZU3w2uYHiFSNTjIb74pkR
 zXkBIiMJGHpz88a/xdBk6xOJliRi691sNgdzXURoU1DYrOIm10GKqJrtKdnl6DDmAYZl
 HpQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvkger+j1l6cF+vRfgxyd8ICFYOuhzxZPKoyqtCf5Zz+b/Y6qGqS6MLuHDK6jbf8p2VfyIJM8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nZzE0KQldHAE72EEnqGxsuLjnlWwV+DjQeR1g5loV/S6qD7gAM
 wgLeCE5nJm++vgEngdDlI50F+ONptXORFYhH3ytrKDUh7mL22N3NqjtFJG+v+AWgB7Y=
X-Gm-Gg: AYBFou27O3rVacLEhaQmwjjiIlJlkpZ1cG9HCofy7Yv+RxZoSPRkWxYa8umzWTxJwsj
 xWs4/KE79RaC2QgugruDj84hqWtg9jFfFmKNAIAKvlmkvz0Y3xwr6C1AfI6MKmGgWuevYZfZOV8
 Vdtzh8ZU3p74XDgFfGTF5gI3I6q9HuE7lwoGeVql5tNv0tUO+BY8Yo6/kAy/qqAdHZct9cnJ7IT
 JUpodwXSOIqGc3pA2XHAgUIWNlyMCB30+OiK0N7Vtq7QnYrur6/NOJZjCOUDdXi07qD48qRiqDJ
 tQVXSz5pvQtvrgourXhGFQwFmz000OMwQIvuyEYkPDzhHGdz6WqdMUJ7/LPdJXHL6MlmnVnIMgQ
 WGaVHMH+i36iBceKDe5/KMxf5aVw2gSOW0703dOuUMIpNX10ahi7g/6PgyjtxOuGJ7oFt46mLK/
 ALAqsPlPZh8LmBhHcKEDYj1C19kYjpVLewD6WlC3W0oelT7vLqOqnUiHNkPJmhlcwdO+nPy8Ebz
 IkFY/llgZljyjSDwEVyQVZVXACsAkz/ta+K0RQMldqtU8HYaTDHZQbLgxGrFPKZ0bmrflqpm6gg
 i+MtKmyelLtRSUFPfiMhl9+gZkXvKrnRUv54VnpyC+Ak7e9WkZu+LGg=
X-Received: by 2002:a05:600c:8484:b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49fe66d8135mr280597155e9.20.1790694950486; 
 Tue, 29 Sep 2026 08:15:50 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013b8f6f5sm20981725e9.10.2026.09.29.08.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:15:49 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] clk: mediatek: mt8183: fix infracfg gate lookup
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Fabien Parent <fparent@baylibre.com>, 
 mingming lee <mingming.lee@mediatek.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260923-clk-mediatek-gate-order-v1-1-085391165c36@baylibre.com>
References: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
 <20260923-clk-mediatek-gate-order-v1-1-085391165c36@baylibre.com>
Date: Tue, 29 Sep 2026 17:17:56 +0200
Message-Id: <179069507655.1887049.7152498911367399690.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790695085; l=4161;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=O2YPTpTEZfQhz3ZpHTqzZOtK+ZZDtxpyWyhQJTN1xSg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEg2RQBYRwr2ShJ9SWtEpJZYG0I0uIfVLshWiY9uYYziP6Vgd2HBCJ8hMVPL0hH3Rqfw0AH7hnp
 NKJ3tib4d9A0=
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

> Add the missing CLK_INFRA_SSPM, CLK_INFRA_SSPM_BUS_HCLK,
> CLK_INFRA_SSPM_26M_SELF and CLK_INFRA_SSPM_32K_SELF gates, based on the
> Linux driver, along with the 32 kHz external clock that is the parent of
> the last one. Move CLK_INFRA_USB and CLK_INFRA_DEVMPU_BCLK to their
> places in ID order.
>
> The common MediaTek clock code looks a gate up by using the clock ID as
> an index into the gate array, so the array must be sorted by ID and have
> no holes. infra_clks[] followed the register layout instead and was
> missing the four SSPM gates, so every ID from 51 up selected the wrong
> gate.
>
> Fixes: c9d7e79f02ef ("clk: mediatek: Add MT8183 clock driver")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 08e06c60f68..aff5d629c30 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -18,10 +18,12 @@
>  #define MT8183_PLL_FMIN		(1500UL * MHZ)
>
>  enum {
> +	CLK_PAD_CLK32K,
>  	CLK_PAD_CLK26M,
>  };
>
>  static const ulong ext_clock_rates[] = {
> +	[CLK_PAD_CLK32K] = 32000,
>  	[CLK_PAD_CLK26M] = 26 * MHZ,
>  };
>
> @@ -683,6 +685,14 @@ static const struct mtk_gate_regs infra3_cg_regs = {
>  		.flags = CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN,		\
>  	}
>
> +#define GATE_INFRA3_EXT(_id, _parent, _shift) {		\
> +		.id = _id,						\
> +		.parent = _parent,					\
> +		.regs = &infra3_cg_regs,				\
> +		.shift = _shift,					\
> +		.flags = CLK_GATE_SETCLR | CLK_PARENT_EXT,		\
> +	}
> +
>  static const struct mtk_gate infra_clks[] = {
>  	/* INFRA0 */
>  	GATE_INFRA0(CLK_INFRA_PMIC_TMR, CLK_TOP_MUX_AXI, 0),
> @@ -737,11 +747,9 @@ static const struct mtk_gate infra_clks[] = {
>  	GATE_INFRA1(CLK_INFRA_CCIF_MD, CLK_TOP_MUX_AXI, 26),
>  	GATE_INFRA1(CLK_INFRA_DXCC_SEC_CORE, CLK_TOP_MUX_DXCC, 27),
>  	GATE_INFRA1(CLK_INFRA_DXCC_AO, CLK_TOP_MUX_DXCC, 28),
> -	GATE_INFRA1(CLK_INFRA_DEVMPU_BCLK, CLK_TOP_MUX_AXI, 30),
>  	GATE_INFRA1(CLK_INFRA_DRAMC_F26M, CLK_TOP_CLK26M, 31),
>  	/* INFRA2 */
>  	GATE_INFRA2(CLK_INFRA_IRTX, CLK_TOP_CLK26M, 0),
> -	GATE_INFRA2(CLK_INFRA_USB, CLK_TOP_MUX_USB_TOP, 1),
>  	GATE_INFRA2(CLK_INFRA_DISP_PWM, CLK_TOP_MUX_AXI, 2),
>  	GATE_INFRA2(CLK_INFRA_CLDMA_BCLK, CLK_TOP_MUX_AXI, 3),
>  	GATE_INFRA2(CLK_INFRA_AUDIO_26M_BCLK, CLK_TOP_CLK26M, 4),
> @@ -754,7 +762,9 @@ static const struct mtk_gate infra_clks[] = {
>  	GATE_INFRA2(CLK_INFRA_UNIPRO_TICK, CLK_TOP_MUX_FUFS, 12),
>  	GATE_INFRA2(CLK_INFRA_UFS_MP_SAP_BCLK, CLK_TOP_MUX_FUFS, 13),
>  	GATE_INFRA2(CLK_INFRA_MD32_BCLK, CLK_TOP_MUX_AXI, 14),
> +	GATE_INFRA2(CLK_INFRA_SSPM, CLK_TOP_MUX_SSPM, 15),
>  	GATE_INFRA2(CLK_INFRA_UNIPRO_MBIST, CLK_TOP_MUX_AXI, 16),
> +	GATE_INFRA2(CLK_INFRA_SSPM_BUS_HCLK, CLK_TOP_MUX_AXI, 17),
>  	GATE_INFRA2(CLK_INFRA_I2C5, CLK_TOP_MUX_I2C, 18),
>  	GATE_INFRA2(CLK_INFRA_I2C5_ARBITER, CLK_TOP_MUX_I2C, 19),
>  	GATE_INFRA2(CLK_INFRA_I2C5_IMM, CLK_TOP_MUX_I2C, 20),
> @@ -772,10 +782,14 @@ static const struct mtk_gate infra_clks[] = {
>  	GATE_INFRA3(CLK_INFRA_MSDC0_SELF, CLK_TOP_MUX_MSDC50_0, 0),
>  	GATE_INFRA3(CLK_INFRA_MSDC1_SELF, CLK_TOP_MUX_MSDC50_0, 1),
>  	GATE_INFRA3(CLK_INFRA_MSDC2_SELF, CLK_TOP_MUX_MSDC50_0, 2),
> +	GATE_INFRA3(CLK_INFRA_SSPM_26M_SELF, CLK_TOP_CLK26M, 3),
> +	GATE_INFRA3_EXT(CLK_INFRA_SSPM_32K_SELF, CLK_PAD_CLK32K, 4),
>  	GATE_INFRA3(CLK_INFRA_UFS_AXI, CLK_TOP_MUX_AXI, 5),
>  	GATE_INFRA3(CLK_INFRA_I2C6, CLK_TOP_MUX_I2C, 6),
>  	GATE_INFRA3(CLK_INFRA_AP_MSDC0, CLK_TOP_MUX_MSDC50_0_HCLK, 7),
>  	GATE_INFRA3(CLK_INFRA_MD_MSDC0, CLK_TOP_MUX_MSDC50_0_HCLK, 8),
> +	GATE_INFRA2(CLK_INFRA_USB, CLK_TOP_MUX_USB_TOP, 1),
> +	GATE_INFRA1(CLK_INFRA_DEVMPU_BCLK, CLK_TOP_MUX_AXI, 30),

Nit: CLK_INFRA_USB (INFRA2) and CLK_INFRA_DEVMPU_BCLK (INFRA1) now sit
under the /* INFRA3 */ comment, which may be misleading to the next reader
who may "fix" them back into their bank. Maybe we should just drop all
block comments or add a comment above these two such as:

  /* out of bank order: array index must match ID */

-- 
Julien Stephan <jstephan@baylibre.com>
