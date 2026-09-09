Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DE3C79FBD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4F7880ECC;
	Wed,  9 Sep 2026 20:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jft96RgLNp-S; Wed,  9 Sep 2026 20:43:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 03DCE80EB7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788986588;
	b=AXQGS6iytj2pOQjdOuoB+emmJ0knqFc5K23zSLdv49/MXfCc69I8KNPWFgmzmL1+wBp+
	 6o+QckSAOK02GuH/ziiPffGsnBXCZ9Z2pXTCzZBUlybp7ICFqpn5otmOWsPQuMU9yt9S3
	 Me2cei432Nv0Ilx19N9cNGZgq+GIpneAc5yevV1/6zNDWm1xKxrIlkTK7wOVlH8z5LT4p
	 4lEvUOjrk4T4fyddlJAGb0JROzuFq8+dyo2dxK/23Sd233xOMIVXQZ2cwhlMKsVKLS/Sj
	 0Wj2BVtL7bMdyz9dQ/h3HXdzCbVRL6/oc2d2ym0uW4GsbgKN8xugR7O2l8onr2w422g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RxbnqaabCWsOzuoLedXqlvKRNkD2uFzvX6965AkqdBs=;
	b=eXCYBhR8tI9AzeFdTneGCcRzB6N+Gd0OIzxxQ5q+KxRc1JI53y0NfRpo/QaW3At3oQvT
	 We6TYHzWMAX84K2d0nRZA3qJrHMXad3Bb08iFE7Cda/h4pEGzJjbPsp1gGjr6s4JdF499
	 Gn/n0P6m8h4ZBiEBYMlAR83Gtg8WYoX0srpYfOb6dkh1a6sBbDUCQcD+t1yohAS0llBmb
	 U0eq/C7NJwALLk3bHTPh6zApO6gsc7iphmdDVUSa/d1vps9EJ+sPoKClFKNomWMoqpS2b
	 m1F+ZLt3JkteUst9duEuclSCyTkgVsWnBe5h0lXMRLrtf8YW2rNvqRsT8cEnvA/FmUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986588;
	bh=RxbnqaabCWsOzuoLedXqlvKRNkD2uFzvX6965AkqdBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0wurYNMShle1FCc6piC33BELi6BjCAxlQUqpEBugf3gZpknnpygebF8B4Zhi2Q2oc
	 RvDNvU1qg0wNjwfYkddMYZdN/WIzvI7n5Nht1wTcopayv71b9RxG54O08Q3TX4LE3h
	 PVBT7c+Xl6u8cMxLCFBDdz4iPBjGMfOZNy+Y87RChQzidDG9fkl4MMOw2HevcvT8eW
	 dltHrKWvkTVasxXxxEKAoBjC3mGmQYdQXQOD9kDCSxvLH7QNqXzYGd8SjySE9fYAPf
	 meOS98APzVG9TRISntSvdFhlh66IjOve/Ddo7dxUEg6sSc5Fh4e6wfV3xJmSUvpH/+
	 nAg3yxtcStp1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03DCE80EB7;
	Wed,  9 Sep 2026 20:43:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3D8F43F
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B597140264
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5fiayfRDhK2E for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 20:43:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8C5124025D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788986586;
 b=Rf7JEgJodDzeZ61dJqdMnmoGj6rksFR7YqAe0UqtzwqId7qpNaDbu6lumw4Y4hYQWmXE
 0QUUcXTWSslpBCWwkO4KAvaq5SdjuNOfu103dpAIVlgbq3F+7MsXOV2COC1wC6xRdf4Dl
 60OE3TUfzUQo85HLhtE7s885NyhQ1cC+0atG5LKXn7q5DFaP1BAYuECG0r7NzvHRrPDQo
 8BAqnAPzo0v4nAB5U+dAps1qXBgRd8n7sxDI1MYqoqC57yTsX767BL7M4XTyx8RB2L/so
 WPL+2c1ii+IECeu5mttULxlhvnEdxSYxFDJGrA75GQiwbYydCVbFP+5vHJnhKN7U+ZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788986586;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=RxbnqaabCWsOzuoLedXqlvKRNkD2uFzvX6965AkqdBs=;
 b=aRTQ3MjOF/yCVsIMcYnG3nZoJEx8Rc+XEIvzRw4/jR0ItZ5synvLZKMbEafuFiH+qA/P
 yxd+YWUiclDXDYtQWSNAw0HSo1Wy5tUVQIPHHE/W/sx9I6WsDMJFZYKxyvJT2amvEabLs
 MerdLloevLB5Qb3erYnAP6M2PauG+qUzFereZsWAc9emLUiki4QkTnUcpf6o7H9XeJ1xm
 tOyJp+uStin0e70t3pMfb6krxdTVswA1JmaWLkseA3Y2duUTFvjJc6NXyY08XtYyHsGMc
 SF3HnoprepIaS1SHBd3Bn7alehQc+qBdsG4hkSXAnm+tdsMginxTBnIJ57oNXkXfhQA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=a7Xd1kBm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=a7Xd1kBm
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C5124025D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:43:03 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49cf4f81d86so49377855e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788986582; x=1789591382;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RxbnqaabCWsOzuoLedXqlvKRNkD2uFzvX6965AkqdBs=;
 b=a7Xd1kBmdgPBo8W+q/03nIMyuv3kiPpkQxczIzwBTOIM0l1QB7lYEaHhKOD4Txm4yp
 BWb6mAOt6HeGf1F5Ok5pS6xSonlrYoorHNAl1aVdocfivKwrJlwX1esQsrtoIIp7d+N5
 Oi/hpbJ974+8ozbyefdxg/MulWj1Cf4GZhbktcBYrAk4s70gmAES2Jf8jHPoqgLNEADF
 pwau9l5EnSf56NE5y/MVPVabpEs9X9yLcZ34tSPdDtzaRI3Af2LJ6LjGRTUD3gDS7WUE
 TozsVxgyR32E00Fa2kUoRGk4mC03pkGpPZpeEM4uClwTRd+aVgyIdGmoJeXeKHAGLmCs
 Jndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986582; x=1789591382;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RxbnqaabCWsOzuoLedXqlvKRNkD2uFzvX6965AkqdBs=;
 b=AJCR8Svgbpw3vPSe6RiABdA5cq9TVqgxqHKV+q8ngZAotgsFy7MijiHbGz9vnGzAOG
 g1JiLkBiwS2HPHtR6xNRbgx3/nlkIwVGHEzA7h5znD7DncmKtLIj23FNuQ/IFMSaGJIB
 x//jcRJMmVRNePVDevL+a6nsJ+iOYoJvWlqlyn/Cd0ynli1I41BI79WFgiomR+cI5teo
 kAj9cTCDORaV/amTTeyki3L/FpetxiEoQsGmjQnMljAjltwfp1F7KTarWFbEjPmYOEt5
 DN9iXJiA1PNaz7u2+sc3ULr/EjonOgUBEzpahzJ0jNdpKizoi6jZ7zaX180ku9uj/cyL
 vB6w==
X-Forwarded-Encrypted: i=1;
 AKwUvByJAyFVB+xY2CDvqxbGXY/I//sWesAs0ToEWzuLMa3oOeAaPBcp2jNa03wOyTJ+k+Znlz4eFhE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lUKzxw4V3ZhXscVU22E2eyBf/DyvEbSvab6yyoVo1RBNaE5aSt
 bvBSXWJyiam0nB0F8mEwZgPNvJR5MhiWZf/q4wixf0fot8NglkXIRlMNxdHj2DV49hE=
X-Gm-Gg: AYBFou24ypZBE5jR0r1OhMxh3ssQyi/6ExxAfCq9klXojLFmvQX+NzCLqb9ZXcf4yHZ
 YzoEqiQckEnib0oDGJohJVsNjHGfs320dwc2DA+Rz5EzxX/ArpsYWO1pcVOhnX2xqJGius8NiyQ
 oKTt+MI5rjC+ZoRYyTYmHVkJk41EqAHUQykBzoVqI8r4OR8cIBzZ2QAXBLUTjOdQDTMUI6ng2DY
 WnhNVWvHS65DF1/kDtnSL5yIEACaO0qSWZXTuXxgxSsuZCdk3lOv/+Hd1wOsLm1d3MVO86Z/nXf
 Dvha91785njrYqezb8kdM6ap4zxe9UgBlZOfs5vJBD7j6HBuIPe1bSvzGEWGB9BOhnWakyC/hSj
 TTgLAkcvyDPF58spKQcOo/p0rSQV2o6ImN5/zSO9v1UpoKD9sRxhF92KEFBe2n6rSkN2LND9R2t
 TeC5x3SLYdIuEpJQkv6o4pAn2wWdNXD/qLykWMFuD7v4a1ZDXLAzC2aFDZZpgcW71di0XXAbGAR
 oWQcD6FM0cExJMf+4lJvh3KrkSmajG4kRmhkZMQMZ9ayBnh9y1RABbdLA==
X-Received: by 2002:a05:600c:6088:b0:49c:fc6c:be15 with SMTP id
 5b1f17b1804b1-49cfc6cc100mr345730045e9.27.1788986581749; 
 Wed, 09 Sep 2026 13:43:01 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c06f04sm18308935e9.13.2026.09.09.13.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:43:01 -0700 (PDT)
Date: Wed, 9 Sep 2026 22:42:58 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>
Subject: Re: [PATCH v6 3/6] arm: mediatek: build Genio 510 and 700 boot
 images with binman
Message-ID: <aqHEIuVBz7Q3WK2O@macbook>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-3-4d4a11d5741d@baylibre.com>
 <9671c6b7-9b70-4b7b-9811-7947597b1c0a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9671c6b7-9b70-4b7b-9811-7947597b1c0a@baylibre.com>
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

On Wed, Sep 09, 2026 at 14:39:26 +0100, David Lechner wrote:
> On 9/6/26 10:30 AM, Carlo Caione wrote:
> > Genio 510 and Genio 700 use an external DDR loader before SPL, then load
> > the remaining firmware from a FIT. Keep packaging optional because this
> > platform firmware is built outside U-Boot.
> > 
> > Separate the container, loader/SPL payload and firmware FIT descriptions
> > so their layouts can be reused independently. Generate the loadables list
> > to include every OP-TEE segment.
> > 
> > Request AArch64 BootROM entry for the DDR loader. Disable SPL binman
> > symbols since U-Boot proper lives in the separate FIT, not alongside SPL.

[...]
> > +config MTK_GENIO_IMAGE_CONTRACT
> > +	bool
> 
> Do we actually need this separate option since only MTK_GENIO_BOOT_IMAGES
> selects it? Seems like we could just use MTK_GENIO_BOOT_IMAGES instead.

Yeah, we need this. There is only one selector in this series but
the other consumer is the follow-up MediaTek download-agent support:
MTK_BROM_DOWNLOAD_AGENT (will?) selects the same image-layout options
without enabling MTK_GENIO_BOOT_IMAGES.

--
Carlo Caione
