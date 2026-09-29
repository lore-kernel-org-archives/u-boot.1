Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F12CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 07:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98DA56071B;
	Tue, 29 Sep 2026 07:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wnoCZy9CelkA; Tue, 29 Sep 2026 07:39:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D167E6070F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790667550;
	b=CYv6u1jNPKgIYLuICeWyYkKCIdZbv4PAtx7XP0u9GZF22ePmTpXqdHphNjs7xbn9uy2+
	 vUp/rfp9wvG9FTmotcK4ndfpazzB/RiA8X7s+WIFqWa6EEnt6Qx8RfRx+buk4czgHPAYM
	 CclTL+Q53I1CeE8MU+K7PAFXsb28l55djBYJqWS1HVsGDjmJf+3u8BrdJuT2/UZ4r1u/S
	 XX9dUDecEZaCoApXRK9XfiebkYZZ7sFRWC9I4s1O7BrqtgbetE0ubGvtmBqzNdeIyzvP9
	 qdeuvfttwrTLqILWIqZCuKhjuSJeg0oDtGSYtL+XDEoxzT1qaUXE+08SnwVUmmMHnYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790667550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=reERBcP7nIkg0H5NhTDudn67sVHfVnhHG4xXSa0D/jo=;
	b=gwuz1UUr7RW0pqAMDOcGB4igfkCeGoDDUHOQu9gA1hvhjsN6Ta+ZX5S6wTqlY6RWxrHN
	 ln0hNkBhDDnNL111mz8lzX3pIUuiRO/OavVYQhgzbzdCSw0lw3P9kTAAjdNUpnoXFOcxV
	 ofyY/VRWrJlxSnPjsNunKJhAchdm0LGYPsOY89rfysVWidQTb8JIFi4IxLYhpBpg6CCZF
	 Z9Z7PGqUNqdy+9CgVRiUTUJQhSyW6xs262NyN6aTHDUrhcHsQVJn1kb6LEvchDCAKv+ZG
	 pwRHt88aB9AMy9WeVvxfK/926QEBbwKatQbj6EqPr8aJeuDKELkadm4LpFOpt/SZ6lw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YMnES1dH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790667549;
	bh=reERBcP7nIkg0H5NhTDudn67sVHfVnhHG4xXSa0D/jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XsN0S+YAENVKaWpgzg0vpIVxs1zpgXLIiuHOIl10z/uuxqLKWHBYlf9OjhlRLc/tu
	 Oh/WQ4E7MACLIOgdvyleYcT4DQYm36NMwzRPRiMXnH+FsCq5A2Q53ploSF5LZOSuUN
	 phbnji/8uXq+ydMsuivQx3E1Pzzbo9lNeTJQ4EftE+Vjd276cnBvFHBUDo4xFwFwt/
	 xZuT9BDMIxZBCaZDQWWhLDzpbcmlKQmsyARn+rQm3dHqArWuBdAcOniZGm3ZSFh24o
	 OuplzMQjw0mxSfeOMxBv8+1XW+ehYtm21oeVD1NeDpIiQSO7NulEhUz+tP6zU8adQx
	 2id9D/1VAffzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D167E6070F;
	Tue, 29 Sep 2026 07:39:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B8A9F32A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 07:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5FD86070F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 07:39:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WeZcs_zeirPr for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 07:39:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 007F1605E0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790667548;
 b=qf7KCp6xsw9JF3tA3NefvCbIYIJWyvOkr3zm5U/diJhuFswKp9jvHXVsS+9/07iiU2fU
 BYOm9L4H/DIgWd+R6f09xlAe+MHD1cPa6LNp5ih9ZuV6WBwW/LktZ8Ly8pSbqEA+yOSfK
 xelGt04ecRHyJHhLe6Fk231yHMtFi/EMFspfNQ2XugHNDPKX6kCkYHMU2q0DuhkGPr8Lj
 igxHQz1Te36feHt46SPEMcBHAuDn2G8JSlxOiIDFxriiyfn/DBTga4nGT19Tq531w15ZM
 FyMHMVsQvSXm4wt0ql41NByLHKzE3iKuOfQpO4AmWKWDutbhSKFVTvKg9W/mqAYGHgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790667548;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=reERBcP7nIkg0H5NhTDudn67sVHfVnhHG4xXSa0D/jo=;
 b=Rg77JndqCqWXIPajz/pZpNLZ0ayEvZpF/x+J39+ocmmbRthcqLQEciALrWrzhl8pJlPl
 6eFwbPt27IuRDikTPVh21ZWA7JxppL1ck4LOEPf6S3s/g6wQEJrbUXtavyXjPFZqRpAV8
 +35V12YL3DM/WG3EmLC8JVF7d5NnooBYa2+Ag5R3omX5owV4CREMRyEY/BRP1U4YRzkKC
 6UooHTC42jnRbL67aefVstrAyVYgHRhADnqQpmDqNePX6uugKMWkgJvY+bNctBULdRa4b
 3siJ/HmLOstEY8n9S5oRIU9oCzVr4tHzl0IPTAdfdTd0TZOm2W7vbPCXB82abBvUT2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=YMnES1dH; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YMnES1dH
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 007F1605E0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 07:39:05 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so21698795e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790667543; x=1791272343;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=reERBcP7nIkg0H5NhTDudn67sVHfVnhHG4xXSa0D/jo=;
 b=YMnES1dHa+nntdCmbk2gDf9upylfjj1DwNnuxhEdN/luTlRU4gEjlF080QXF73MXv5
 QnBHGbjB8x+f1EB8kb8/i2PKxQWexmy0e9MCK3iTfuIXg41LKJaodJyeLzPW27b4O52s
 QcyK32+SU3Oq5/VmAOPeuQmW1eToQyMrRICI8ZesInC/QaWO2eRbFpxwS/0WUjJ1Bkqs
 QRG3IE8BSd01PZnZgUJfVdKzvpk4o7vFsB5ByiKFrrsGkwRN2FZzNJiEAx72VJj+mqkI
 pn6LPUEh/j54pKPKZ+V5eAkS9Ct175VELvUYY2HLiHixaJbSwBOf7bFeEgDn/0QfwBAq
 JVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667543; x=1791272343;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=reERBcP7nIkg0H5NhTDudn67sVHfVnhHG4xXSa0D/jo=;
 b=S2IcKuLnGz1eEAwlj13YE8Ixmua2IQ5fG5SGmHQnmrY4bcWUIuOXaiYTEkg3VtvUiq
 5zdYzyjsC3HhYrbMLqUGHXnGFGz+6FYPItRe2KnXzZ6V9SREYl/gldaNSMeTQuEt1agN
 N5pHlGZ4kV5dyKt/7YnA0DiDJG/K3E5WlKMDSgiGewmJI/84LMf+3YATYyTXGb3lbE1t
 inuv39NpZpKy+Z8N2km4gMUUozS2UuNLy6MJEHbEE3r64EIJm3u4Iw0G5AuIIlusvagk
 Xv8LZRsDZTT6TFm8JSpMK6FfLp+QGbYodk5ruZmHeBRESTLPqwU3JLa6wdbV1KFZAJe2
 atng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAYUEKD3inSkvwA25WoVdakfDQrMJFAs2i/covjMFtOT5M0PAtIjk4Ehg0gmK2LsGoMsjUFbc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++myLk13zkLL2LkTKjUHqIwf2mir5CEDSMscqmsxIQJtr+4bRoxp
 GQqr2bTxF+Sms5SjpUMC91hFOKVB5RAxg47HXGCoQzOF6cmKYMRx37n8x4S0+joOoG0=
X-Gm-Gg: AYBFou1EZA2hkNq94bP8MBAHGXuFJNk6bFSMuilD9IVsxdFxYosVXgOhzce6JC4brbV
 9LzET4XCDDj3BHFXU5nZ3enMkKD7/dn0QGZmqVGQ6O5fySoPFmPpAogcbru9T63YpicHxypjVoc
 JyaFiqA7YbofzKFPY6P+nCoDH+YGdwAHBweO6FUTKrWh/kaGUoLHj9eky00+VBdy8BwMcNxVlpV
 7FIoPtE3Hx9yiw6vsGPApeaVKzK3X/fXats36wo+UKqEvtwnNJgLtdrOdl+Nqy+Up/EyrJ65TAc
 /6ylViR2UcEO5Sq8+HeUxDdrw/+MLYxrqy0uSYXanGuGeh1q09H3fKz8tfRNNpFULO390ujwsGk
 kHl8AUYGWX3f/DxXcFN8xUtwuKX1s0+3PS/dSOjGvp7hxD2dA7Gm2cVzy8VLH2UGBEteb4AA+08
 ksBdFCronJUqXAUKZxweRWhhBa5hiYKh/3x5OdMmFzPCaIyjgXTBB37ILOseQhKhpHoDlXAZyWw
 tUlpNBMubhhuNelY3koTQPuHaOSQQPEtDm2sH6NUeiJ3/+MA95vF6A=
X-Received: by 2002:a05:600c:3514:b0:49c:fa21:e749 with SMTP id
 5b1f17b1804b1-49fe67043a0mr253653675e9.31.1790667543381; 
 Tue, 29 Sep 2026 00:39:03 -0700 (PDT)
Received: from macbook (host-79-45-166-197.retail.telecomitalia.it.
 [79.45.166.197]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf9b72fsm79292725e9.9.2026.09.29.00.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:39:02 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:39:00 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>
Subject: Re: [PATCH v2 1/3] arm: mediatek: enable SPL fastboot DAs on Genio
 510 and 700
Message-ID: <artp7Bnc8b0FBD2t@macbook>
References: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
 <20260923-ccaione-upstream-mt8390-da-v2-1-8f264678ac29@baylibre.com>
 <5a9f1311-09ad-4c8d-8df6-09c26106d3b4@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9f1311-09ad-4c8d-8df6-09c26106d3b4@baylibre.com>
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

On Mon, Sep 28, 2026 at 17:43:22 +0100, David Lechner wrote:
> On 9/23/26 4:17 PM, Carlo Caione wrote:
> > From: Julien Masson <jmasson@baylibre.com>
> > 
> > Genio 510 and 700 need a way to provision blank eMMC and recover from
> > unusable boot firmware without relying on the installed bootloader.
> > Add a BootROM-loaded fastboot agent that also prepares the eMMC boot
> > settings so newly flashed firmware can boot.
> > 
> > U-Boot proper is preferred when the complete agent fits BootROM's SRAM
> > download area before DRAM initialization. Provide the SPL alternative
> > for tighter payload budgets, avoiding the space required by BL31 and
> > U-Boot proper. An external DDR loader is still required.
> 
> This is a bit short on details of why certain tecnical descisions are made
> in this patch.

I'll try to improve it when possible.
 
> > +	/* Reset to x1 SDR, backward-compatible timing for each boot. */
> > +	ret = mmc_set_boot_bus_width(mmc, 0, 0, 0);
> > +	if (ret)
> > +		printf("Cannot configure the eMMC boot bus: %d\n", ret);
> > +
> > +	if (!mmc->ext_csd[EXT_CSD_RST_N_FUNCTION]) {
> > +		ret = mmc_set_rst_n_function(mmc, 1);
> 
> If I understand correctly, this makes a permanant change to the eMMC hardware.
> It is documented in patch 3, but I wonder if we should add a comment here too.
> And I wonder if anyone would not want that setting.

This was ported over from the downstream MTK code so I think that this
is actually needed. I'll add a comment here.

> > diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> > index 20befdba0e2..61fefcf9a34 100644
> > --- a/board/mediatek/MAINTAINERS
> > +++ b/board/mediatek/MAINTAINERS
> > @@ -18,13 +18,18 @@ MT8188/MT8370/MT8390
> >  M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
> >  M:	Julien Stephan <jstephan@baylibre.com>
> >  S:	Maintained
> > +F:	arch/arm/dts/mt8370-genio-da-u-boot.dtsi
> >  F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
> >  F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> >  F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> >  F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
> >  F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
> > +F:	configs/mt8370-genio-da-spl-fastboot.config
> > +F:	configs/mt8370-genio-da.config
> 
> These are not sorted in order.

:(
 
> > diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
> > index f296a72cf18..d8ef6e6afba 100644
> > --- a/drivers/usb/mtu3/mtu3_core.c
> > +++ b/drivers/usb/mtu3/mtu3_core.c
> > @@ -843,7 +843,10 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
> >  	mtu->mac_base = ssusb->mac_base;
> >  	mtu->ssusb = ssusb;
> >  	mtu->max_speed = usb_get_maximum_speed(dev_ofnode(ssusb->dev));
> > -	mtu->force_vbus = dev_read_bool(ssusb->dev, "mediatek,force-vbus");
> > +	/* Fixed peripheral mode must not depend on OTG session detection. */
> 
> Why not? From what I am seeing in the Linux driver it doesn't do this.
> And I'm not sure why mt8183 has "mediatek,force-vbus" here in the U-boot
> devicetree. Maybe lack of proper pinmux for that target in U-boot?
> 
> I feel like we should not be doing this for new boards. I would only expect
> to need to force vbus on a board where vbus wasn't wired up properly. That
> isn't the case here.
> 
> Is fastboot broken without this change?

I tested it and it is not. So it looks like this change is actually not
really needed.

Thanks for the review,

--
Carlo Caione
