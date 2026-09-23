Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011C6C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 14:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 188B660850;
	Wed, 23 Sep 2026 14:25:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1XMTHzpNMEz; Wed, 23 Sep 2026 14:25:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5251760835
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790173531;
	b=E6RgSqRSpPk2jcaiN5ArZOu2Kwl/T6JmnDx7xjcFeG9cVtMree0gUozPpXp2D4KrT0/x
	 Xhry/641n9NKprSAIVMTj+MnU5vWIm2ToyfzTNRhgnbm1h+xeDQnI47okOXpPvWrsvcVO
	 z05xdv0EuDiN3ItpRKv22yzttIFBnFsIJtYFZkvI4iAGyC5P8Md30xSjwHI462ug/wMqg
	 rwSE/bPN61QbqZh2M21/v08z8RvU8W6fW1hff4M7YSZDX5fLseLSISxs70rMnG+aSmqzn
	 /i/nin2UWk0NQ1ZA8uxgChxHGolQWjMh2SanEskpSjEcEFyihbCHkhsyEe9gK/ySISA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790173531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B4/JMuohBb0x/OauIX66avEHmB9LH30xLjVjYqcrl0I=;
	b=boCZzSMR8Kirthb+/z5bAG10ppeAIhF4GMCZAakRNii1vBXPjTxjVDDfDQ8SINMRCn3/
	 VM0zCNS9lF9RBIMcaG1GJ99ObqF5hWmm0SEPeobVDPBBivPLtRi72Pwf7IXt5lx92RuKa
	 qO7n2Q+HAyKhlD2WlKwYbha+2zyTwJBOD4VszWjrEwIM22etz/CpswzOKgoX27qHzy+9r
	 H93Gj8LcWwXFn3cDqtgQpmmBbk5JlaKTCPZm6yzcxTBLoUe96LSOYA4RoIYtakmNedFfC
	 9N8YuATJCIXe+nwb5PiCcFZwSox0tFyXjiWk+2N+1bqD9Rj4eWvvY93PAHYYvrGRhoQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ILM85g6N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790173531;
	bh=B4/JMuohBb0x/OauIX66avEHmB9LH30xLjVjYqcrl0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UMU/UqQoEmv/X9of1MjVpum1kcNIqjYP43MqYzXbKEKjNFbrDf7G7o1McYhm9zoeO
	 MD33nOmrtysb+qXXkZpKk2A0GF24W3iejjAg21GjRaOiBacbGKISgH4FsWraILm2Gu
	 V7nyFP/x+a72G68vAgbWnc5S8Dio0R+lBvtrQP5Z7Yw4nAS1YFkYxxq4in0hvk/n1x
	 W3/VBfqm5aQ5FUIc6Sbw7rASGn+Bh5KBUifOeQ9CbNZ7fVRYo0WBYZWDEjedZ5vy+3
	 AgivpTwL4YTUBfJMZT5lI7swjQK56Sb+4CYyVGKnsbUYQolgufvRTtV8l48TbFg+9L
	 j2PeP0EMwvqVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5251760835;
	Wed, 23 Sep 2026 14:25:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4308A498
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28CC860835
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:25:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vPdkJBqW-9hu for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 14:25:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 863AA60766
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790173529;
 b=s8Fo7hz6iEUoSJuhknR36iezdLP85AJU2rz/mKSWZ8O2ALwv0Kb4N7Cor86SIY398PuX
 uzfORCCWq5cv80OL2Ddo9FgbSw7Zvzn5m/+9z+Qi9HbxOGPeu9WGh8BpUH0EP0wFQU9Bn
 PfUgTUMtEKKfOpPEJt9NRBAfJ2vNWkMnNwSYhROwugTyDxg5Oq+C0E5/JWvBwMXN8aK1Z
 bHHbrlG/+9qM3QBQX5fE9KGpTIyZ8PjqJBnpOf2lbXvkcjoWy36rOq4JFS+dof8/6K+VO
 Rvt8ePvxE8brQ/l2WB/sYaAWa+25b+a7xvxVbpq9niM9h2B26Nkhcol7+xff1/mN/Dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790173529;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=B4/JMuohBb0x/OauIX66avEHmB9LH30xLjVjYqcrl0I=;
 b=sQE3Cz5iYxxBtNnR2xXy5jStk629QqXtucT3asfjdbwzrXFH9kjPrYnHbLKGPas4pKIS
 6RsaM7FmcBJQkVJX7mPXQhSbzMPnzeeSOLdw/q0Lm8+o4poV746X+mEjS89o5sj+6zPRv
 uJLlKegt+MXGIKchjaiAQVMZkzUaQjPLtp9OOv8wtDYOPz2k3qbAe8vb4mJjf9ichXiW6
 c+kvpfb/m09oyN7EDN8Lm2mQJogsxcU9I5KuaWDJRr7Xwp3WDGNOFjR8ts+RIjgG+quOc
 oeg8swluksvFcrnBiIANDhQiYYC07EQE0YBSXX8cJZsFDPvpXIE4gl9JIaBuT3nMM2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ILM85g6N; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ILM85g6N
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 863AA60766
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:25:26 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so5903695e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790173525; x=1790778325;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B4/JMuohBb0x/OauIX66avEHmB9LH30xLjVjYqcrl0I=;
 b=ILM85g6NviWsgiCADPgdM6WuDw7+lydRLb80MTCI8cKQkEJEbFT5H/IZi7aecreVBb
 kdL1dQrBCxL0gwuK8Amz6i9Y5+0VojRarneu/6AplHbEX9A6HW1ExycHp/EMSiGUAfLN
 a4IbQFNtFaLfoQ0clcIXKr1A1aUa10+SJF+bSaGyRb0d2hgPzXjlKGoC1R6nTB4iQTJB
 Gh9Dk+H/zQQeaaPjDqxLrGehlT7/1M/MXYlN4ndH4pmNICWRzt7GOhUxAqPCIS51xv+x
 Z6cywIN92xWUDopLViKnGrVytKt+U5L5Z72rrpb/m6S0d1p6k8WWqTTnPlNxQJMfvDaM
 jmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790173525; x=1790778325;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B4/JMuohBb0x/OauIX66avEHmB9LH30xLjVjYqcrl0I=;
 b=ST78Gaj6WFvqzHXsEa14grBa3pxZtt/BC+t6c0P/m4PwB2FkR2zNfdyTqoOlS7qCuO
 P9My8KRJoQDvsrcnYsUP5L1Dty1QMy5cEw4TqmR1xE8naMng4gWKhtQdACC0lTezAI6k
 2FRg9hjMVpvdi/un0AVIxGnEJHorK7WdbO8cuPJIkEUKP398RDbAxPMuvHfYR87SsNWE
 IB5OU8fadxEjfMo+CmyaERGUWnrO8BexD8Bl7yt2WDXF7i7ZOwfS3k+EW//7WYsrxUF3
 x+nDxU/FHN5vXlBLinAGP8fK+h2U0omJtzy+OXDK74z6W45PG0oF9XHBHclVlL4u9HBg
 jpcg==
X-Forwarded-Encrypted: i=1;
 AKwUvByZUWoupC6gY2GtMwANXxa+rohCpk0wR+8USESHPMcnbQnj14K6vf/NP5e4dQC4JlbPYXVCG7Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++njUzePWeUOgxQaV0nSZqLK5YgXYqZHcuVR7V3sPIxJ/1bCnGYn
 /W9BOaW17bz6WnDRKkYO1A26uiYC2Qzw4XrVS/xWysAwgEaHbbXvkUntne2pl4+xewQ=
X-Gm-Gg: AYBFou1kKE2+ETEw4uNz8nscGW+cpxPM6mmuPNaNtRgW+bAfAuGyfvXzQlKofCW+dy3
 x2BwE0GC4t3J6aiH9AeV/bYdqRSmub2b95yGW7P5UqJM0blIOvoyw8k+tBjd5BB+cGODRM1iGNA
 jgp9YEi1M2/B2Uo9hbeoqVAiD/xyjkn7EuqFRpj92FfCru3HAHVgvNUrtamrBg1oIUZTm0gU4ig
 DiA4kP0+tC2b9o7ihrJ9uOTVt51yJ1V97D+mNI63FcWUiuMiihmx+R+RuwG+7sXEYQvZ9QOZk6H
 tI2uOW8CCIQE+z9KvMVoFhVL7GlL/u6x0Xne5djnhICsf2ejoPxzPSTFN6ue9qV3qWzh4pKyH0Z
 1yWfgq9dXgjhdb86iHpR32NiPp5ZYxumCrXjsfd4xVa2bn2MAjhhSIvT1/dvBxf6ilON+mpcaNE
 gZ4oCv7BZp6jduHa2OVz93M5yucMoUP+LHj+wZ4SXcZq4vV1J2wzjJQ2c7ViHshKoPbo5z+ijP2
 bdSiBXqXCBRz2dVzVhR3jUDRgnhYhLV9d/0IJPnAjE0glrz9Exjb1FDQg==
X-Received: by 2002:a05:600c:1d1f:b0:49f:c199:e1e2 with SMTP id
 5b1f17b1804b1-49fdf1474demr43354525e9.28.1790173524668; 
 Wed, 23 Sep 2026 07:25:24 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c3ed96sm418125e9.2.2026.09.23.07.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:25:24 -0700 (PDT)
Date: Wed, 23 Sep 2026 16:25:07 +0200
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
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>
Subject: Re: [PATCH 2/3] arm: mediatek: enable U-Boot fastboot DAs on Genio
 510 and 700
Message-ID: <arPe_JbLjVvUXjRM@macbook>
References: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
 <20260914-ccaione-upstream-mt8390-da-v1-2-b76f9e30ac38@baylibre.com>
 <6070e105-ef8c-41bd-9dcb-29f6f0b92af2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6070e105-ef8c-41bd-9dcb-29f6f0b92af2@baylibre.com>
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

On Tue, Sep 22, 2026 at 11:27:35 +0100, David Lechner wrote:
> On 9/14/26 8:35 AM, Carlo Caione wrote:
> > Some provisioning flows need U-Boot's command support in addition to
> > fastboot. Provide a U-Boot-based download agent for Genio 510 and 700 so
> > these flows can run without relying on firmware already stored on the
> > board.
> 
> So this is providing the same utility as in the previous patch, but also
> uses U-Boot proper? Why do we need both?

I'll explain that better in the next respin but basically U-Boot proper
is preferred when the complete agent fits BootROM's SRAM download area
before DRAM initialization (it is preferred because well, you have the
full U-Boot at your disposal).

The SPL alternative is useful for tighter payload budgets, because it
avoids the space required by BL31 and U-Boot proper (an external DDR
loader is still required).
 
So it is just matter of space really: if you have enough SRAM usable as
download area it is better to go with proper U-Boot, if space is tight
SPL is your only option.

> > diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
> > index 6f1ec052b95..75b51f4986e 100644
> > --- a/arch/arm/mach-mediatek/spl.c
> > +++ b/arch/arm/mach-mediatek/spl.c
> > @@ -33,6 +33,9 @@ void board_init_f(ulong dummy)
> >  
> >  u32 spl_boot_device(void)
> >  {
> > +	if (CONFIG_IS_ENABLED(RAM_DEVICE))
> > +		return BOOT_DEVICE_RAM;
> > +
> 
> It seems like this could unintentionally affect other MediaTek targets since
> they all share this code. Should we also check one of the FASTBOOT config
> options here?

Uh, good eye. Thanks for spotting this.

> >  #if defined(CONFIG_SPL_SPI)
> >  	return BOOT_DEVICE_SPI;
> >  #elif defined(CONFIG_SPL_MMC)
> Should we have a precursor patch to clean up the existing entries to also
> use CONFIG_IS_ENABLED() to keep this consistent?

I'll clean it up in this set, no need to have a precursor patch.

> (And I assume in the config from the first patch, this would fall though to
> BOOT_DEVICE_NONE since there is no u-boot proper in that case?)

mmh no, spl_boot_device() returns BOOT_DEVICE_MMC1, not
BOOT_DEVICE_NONE. The point is that there is no U-Boot proper inside the
SPL DA, but SPL can load it from eMMC.

Thank you for the review,

--
Carlo Caione
