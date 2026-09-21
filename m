Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFE5C982F0
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E62F140B05;
	Mon, 21 Sep 2026 12:54:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLcHQNlftehy; Mon, 21 Sep 2026 12:54:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0448E40AA0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789995276;
	b=UP6vclWaTh+eTK35lNc5ukcCAujkJWO8v+vne/0oDwHTy202tMA4a1YlKmLYUQAizowt
	 uo3ujmejiF59en5xj2TedfH2a0ZDg+B74lFXE5d42eU0sh3eDcL8OMiuL08kBfFrYeN+9
	 9a/LzzBumIEeQjruA0AWnjTcX/KDMadW3q3qR4wCLN9GlOyNFo8DXyQiT+g+Lg/sPiwTS
	 Bcgt9HGCOmear9Hiq7IBbqz66AtYoPn7b8Ye79NRYy+K/FYfFmglRqAv48qVfdIf4ZepM
	 4SRN1Ya1OCAiecSKZHogaZFLscwUENPQgV1+1JyThTb6jYJm7eJKbKgcBQChS3U7hsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789995276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SYpJK3SNCndfLRONi7QRr3Cil3cnJL0iA0+7jYC7Qi8=;
	b=X75ePVccmyP3u/fcSbSNqnYoZCyLvaP4VAr097y5narpdGmTWvo8eBkFy99Kmd5ywU9Z
	 Eq6Ey2/exjGftW8bee94cVMMrJmUcLHFq7RCfYyaAQm/HKZIXV797b/UcHNs14iOy78if
	 6oPt5n9zH7hMl2oJuh9z6evRJbxsHLH7+E6PXFT+EFm2CYZFIMNRufsDnhyFD2YRBIgqX
	 d3AEIW8TL+gt/6aWI0yVo8wUkaTFPk9MKkZ0G+ZkLXHIFpPpMf/BJj3y4tt8DASwCytto
	 lwweKWZTTMFVIeO+kJOW+h0tzxSEmGYs58SejSulq1a5l0otywP66UvCQwzsWo2N63w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789995276;
	bh=SYpJK3SNCndfLRONi7QRr3Cil3cnJL0iA0+7jYC7Qi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bo8JuUkXjhYSDI59P+4bIqgh/E+jjWKXZIzhwK1sVz0FdzqQMckBOAJC1fssSKvRN
	 69Qkl+0v/KOJOwUmU5DCc6K4Gs2zA5bTKZRMNMnSQ9deKf4RVaD+fFclk/jeSRstAm
	 meAMhoIxDIc9AD9GUyoq4k27RQsSS/B0i0OfcdYhJufZNzOEjIE/4U0VzwMhUhU06W
	 Uze3efWsOPdiDoXdtz1UwMX93nQWpOK26FRR3TRjlWAvkoEYzHzen6jRXX8M3xQKZA
	 T2BfVzUA/p3V0plzzNJmcsUnwuyD3r9nY5KW2IJRgiLF4DnKH+80xcXfL6o+21OVRm
	 lN1A2qkCm5gxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0448E40AA0;
	Mon, 21 Sep 2026 12:54:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D36B237
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EADD4007E
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JAvY3emiqWiV for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F116F40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789981829;
 b=Zz7X/9QkrYzppVhK8clqiXQOiTdyiny0SlNOolz4oS4wlfNcOVMbXb6Oi59nsD05vS+A
 steC1iwx5kNxHGQcqcVBNrkVNWicS7z9I5kSNcAvCFdLGK7SSdwDyNPLo2atcnEFCNv52
 4/DTKyLEt5cus/3wwZvvX2yMWokEQsUuGjFyx7Uz7WrJ6cJZ/Wm46V1x54DGJcGO+1Ooy
 dZ9W52MfMVwmCtAP/1IrmE4xXK/bgEpf3E7LjOwbhcj2ABWkph4b8M1HuPE9aPC08tYau
 WWbW3ImTAqn6ESIB7A/Df/gOdWhM3KBS5om7RS7vVQf9khOnammXPtz8nRo02NRo9TA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789981829;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=SYpJK3SNCndfLRONi7QRr3Cil3cnJL0iA0+7jYC7Qi8=;
 b=dNVEwMM1cUYBxxfwTtrvwbkPcr65HmfB6i8MsXJif9hYoomEZov0pQPcCBJWRsZFJjoY
 TO+/CsNWpE6IQeVd6BJMmTTE1N3LCEXB33wqZDDhZ4dvvJI4t3hsr9kGd28n3XXtfLzPY
 Hs7vaBY8YqEbD0hcLlfebaUbpg3yLGDFjFoTiYvzdW+hGQLjlIfB1uOdh/wQF8r5wrCu+
 3kJgQsvWVbcfh0t56LOZC/2jF1oxlT/7W6HoPTHgAltt7er9V2nqAkADfXRPzocz2fduW
 LhkNCf31Jk9gIUC0B8/nlDKVGGXM/V6EzRaXQ62yrNd5fR1L7zd1Nh6An3Rmib1ihfQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oMc6Ra0a; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oMc6Ra0a
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F116F40050
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:10:28 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f635552aso2243567f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789981826; x=1790586626;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SYpJK3SNCndfLRONi7QRr3Cil3cnJL0iA0+7jYC7Qi8=;
 b=oMc6Ra0adC5RLe8xWX5yJZUGaBVmovkiEa+tPaz5dSYeLTdHlTXSv4m7HCMvBOQUmy
 aP+S+Bd7XH1URLF6soXrsgeVIjUUkg7CixCZuEsSJiBNwZRDLapHIWgrXD1zkF06gKO5
 gWHzB2/NUypWBaIhGLKPGLpc7QT7M53wOctcJ5W4HItbplwLmvfSQgBLD3Hlsp/JRltv
 CcrPtL01nAD+Buzg76m91nh+redxoABzVRGHkZFxDDEi+kGeKeW5wLJ619/4Y7vBlHPy
 1I2xaBGoKGwXQ2okk+/hh7oWfZWIDh7IcXHaFvRUCyWSuHHBa0nzaUk+DS/+310FQDAW
 zwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789981826; x=1790586626;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SYpJK3SNCndfLRONi7QRr3Cil3cnJL0iA0+7jYC7Qi8=;
 b=pnAIxprx6SZDmAPI8ADQqnVoY1QnBcR5Zycwag+nT3z0nu2JnwSkxHEj30X/nPex/t
 kPFvwBoD3hkXfTpzAvPz3yMuUAQKS5n51qvfOiYZ2wJZee7eBUPbU6MiVOTTcob7DVS5
 8XJqYRNeSBYXcZIeNXQQzcEGcdo/FXVZcqfuyIpLr+024mok+xqFsKkfry9rUlWS6NfL
 WoPyKEjXnSmpY1yasGXDShv/Fs044q7YjvnULYqY1ey/zJ15/Qim7MGQeEHhxbCaglkE
 cnifg9ojEWYsln2j04J9tVSV/9AyDwwq1l59RcBIvWjIgzV60Rla5fpzLxuZ6DjJpdSv
 NlLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQI7XxOfywnKspY5Eb8IgwxLCUkGVmynf1GRV6GaZ+YwX3h/68juJJJefXeBBIMgPtiaks21w=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nVchjZPp2BSfM54mLqWDpLi0iYdFfj5gFIdDla6Nyb+rqj7v1u
 FU0nN5/EIdkZ6O6GV6CMOXosC639QH/uZwbjkbNjN6Ei/63dwjOkmuYI
X-Gm-Gg: AYBFou0Iws1D3e5fsaskKP78x5JFfrlgVKZzcOrh/kZ7cp/gtVII0TLq+zfWuw6A6zM
 BYi3r6MHl8bIh82jjw2C6VVUK5SR8A9dmQ0Us2iYyS4mz9N85FUK81j6B0l2BDAkvAniFSlRezt
 jyNCnp4wTAro76skNFEv78F+hXYUDyc0ULBxlrWpo0DFwxRp9GuSxl9obUGYFGnZvWVGHw35q7S
 5OPcSgfuYNNuTwnCD3lwM19o1PpdTb9W02uj7hmsLeYxikSfciPLdjfe1cRll35j3L1l+okeXRH
 6WkQ4mpc0DbR0CiuoQWYQn0oi9L+RLn8EcWgYyIxWUI5/36JduaSXg7Iyx0ikv86HZzBHnDlpnC
 ZpqjjtCao2/nfJ56dWq/ZltMWCorVecoB147sm+p3+hGn/5ESVMzR+84nOG54zOIXyS6jgO88nB
 8DUtQVf9KlLOiBmTOhWfJpH83ZtVybUDyj1uw9J0IAtJABgIjW
X-Received: by 2002:a05:6000:4381:b0:487:c3f:5750 with SMTP id
 ffacd0b85a97d-4871e3a9c43mr13804356f8f.40.1789981826311; 
 Mon, 21 Sep 2026 02:10:26 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4885a0549c3sm8759766f8f.25.2026.09.21.02.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 02:10:25 -0700 (PDT)
Date: Mon, 21 Sep 2026 11:10:24 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Tom Hsieh <hungen3108@gmail.com>
Cc: marek.vasut@mailbox.org, marek.vasut+usb@mailbox.org,
 stefan.eichenberger@toradex.com, trini@konsulko.com,
 hayashi.kunihiko@socionext.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1] usb: dwc3-generic: fix ref clock lookup indexing
 wrong clk_bulk array
Message-ID: <arD0gD8AMpO_B6kT@eichest-laptop>
References: <eab9d4af-6f01-4963-8fea-49a53abea2e9@mailbox.org>
 <20260921054432.2978558-1-hungen3108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921054432.2978558-1-hungen3108@gmail.com>
X-Mailman-Approved-At: Mon, 21 Sep 2026 12:54:14 +0000
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

Hi Marek and Tom,

On Mon, Sep 21, 2026 at 01:44:32PM +0800, Tom Hsieh wrote:
> Hi Marek, Stefan,
> 
> I hit this independently on an i.MX95 board (Advantech AOM-2521, with a
> GL3523 hub on the DWC3 root port), so here is some data for the archive
> and an attempt at the open question.
> 
> What the hardware shows. U-Boot's `clk dump` reports scmi-1 at 32768 Hz
> and scmi-2 at 24000000 Hz. "ref" is index 1 of the dwc3 subnode's
> clock-names, and index 1 of the glue node's bulk is scmi-1, so
> dwc3_ref_clk_period() does its arithmetic on 32768:
> 
>                           before    after
>   GUCTL.REFCLKPER            821       41
>   GFLADJ.REFCLK_FLADJ          2     2032
>   GFLADJ.240MHZDECR           28       10
> 
> Both columns are register reads. Once the clock is resolved correctly
> GFLADJ reads 0x0a87f000, bit for bit what Linux programs on the same
> board, and `usb start` goes from
> 
>   Device not responding to set address.
>   USB device not accepting new address (error=80000000)
> 
> on the USB 2.0 half of the hub to both halves enumerating. SuperSpeed
> is unaffected here, consistent with it taking its clock from the PIPE
> interface rather than from these registers. Those numbers come from a
> local change of my own rather than from the patch as posted, so no
> Tested-by from me yet - I will send one once I have booted your version.
> 
> > > This would mean we would have to list all the possible compatible
> > > strings, which would be difficult to maintain.
> >
> > Isn't that what Linux does as well ?
> 
> Not for clocks, no. Linux never looks at the parent for a clock at all.
> dwc3_get_clocks() in drivers/usb/dwc3/core.c works only on its own node:
> 
> 	static int dwc3_get_clocks(struct dwc3 *dwc)
> 	{
> 		struct device *dev = dwc->dev;
> 		...
> 		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
> 
> so there is no parent-compatible check there to copy. The one place
> dwc3 core does test the parent's compatible is an unrelated
> register-offset quirk:
> 
> 	if (of_device_is_compatible(parent, "realtek,rtd-dwc3")) {
> 		dwc_res.start -= DWC3_GLOBALS_REGS_START;
> 		dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
> 	}
> 
> The parent lookup is a U-Boot-only construct, added by c6583354b7c1 to
> cover the DTs that keep the clock in the glue node.

I came to a similar conclusion. In Linux the dwc3 doesn't have to know
about the ref_clk and it is therefore only managed if it has its own
ref_clk clock set.

> 
> On whether dev->parent can be an unrelated bus node: I do not think it
> can, and the reason is structural rather than a property of any one DT.
> A dwc3-generic device exists only because dwc3_glue_bind() bound it,
> either from a subnode of the glue node or, for the flattened-DT glues
> that go through dwc3_flat_dt_get_ctrl_dev(), from the glue node itself.
> Four drivers use that .bind - dwc3-generic-wrapper, uniphier-dwc3,
> dwc3-sti and dwc3-am62 - so dev->parent is always one of those four,
> never an arbitrary bus.
> 

I think it would be possible to define a "snps,dwc3" compatible node
without a wrapper node and then probe is called. Because it relies on a
wrapper, the ref_clk lookup won't work. So one thing that would
currently work is to just test the driver name. Something like this: 
if (rc && dev->parent && strstr(dev->parent->driver->name, "dwc3"))

Every wrapper driver currently has dwc3 in its name:
- uniphier-dwc3
- dwc3-sti
- dwc3-am62
- dwc3-generic-wrapper
However, if we have to handle this corner case, wouldn't it be better
that probe fails entirely when dwc3_generic_probe is not called by a
dwc3 wrapper driver? Or asking differently, is it supposed to work that
the "snps,dwc3" node can be used without a wrapper driver?

If that's not supposed to work, I would propose something like this at
the top of dwc3_generic_probe:
if (!strstr(dev->parent->driver->name, "dwc3"))
	return -EINVAL;

Regards,
Stefan
