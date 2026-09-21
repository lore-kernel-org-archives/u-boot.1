Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B86C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E128940BB6;
	Mon, 21 Sep 2026 12:54:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dctrDLsJYZPD; Mon, 21 Sep 2026 12:54:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1586040BD0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789995266;
	b=q2Aeq9/KqqpsRIvEaSNG42rcGZeagWO6jA4Si2ntS7713NiGo62a9DXymXsLtm7XQCgU
	 HTdKiFMau3q6HQ/yrFMfH44r+11wgAvCbSQJRcdIBaMCyV8hfSVWnLdqSIBPFnoiQpGHQ
	 d8VIvtOajbR9OcZi7gzWdYl4rrWSVET26cK4PnVlQC6uTYdAoF1Uayl/F5OMWl9/w7ZVz
	 qBoXXKvU1JrgpNULz2qdAjjnJfN5x86hjoLCdOKCG+vbsOMp9cuUySpskiv8U8wwFgqrq
	 pvd07bsmeAfx7CqUbPNDbmZZ2LHBCJadvN4PN/Ht7jUPRH2UPPv1CTa+giLaZ1D57JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789995266;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cug87ZJFex3qo8IIEawYHPaTMaLCcJEXHhS1qZ1iRx8=;
	b=U8sbPZAmZ9uvkcr+RZZ2KZRKvTDC9e7GUbfVeP67uGppTSa2/3kdAqszYXtFATX4T9tL
	 FErwZdg8LQ3tOxsb7bhWcV4kPQ95yJf+Elp+VtyiHfsKtZDR0EOeLyGkYyQoUlXyxd6dF
	 b4MdfJ+gwgz+jytG/3DcWVyRenir0WFcclkp7xDJiW/sahjJTHrGxK+tD47AVtjNSI6Lq
	 RklFErZgNUB7Jrn1zUavbr/eQly8WrPIOFD5AtPb3Al7HGnN7Q567R8JcSTqQ/UrA9fOU
	 4SYvMULVZQqzkQLZ/DgLIm1gVnbdY90OZvYj1DZ9g3Oe2fVf9jRlACRI+gNKlZbFseQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kalhvGT4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789995266;
	bh=cug87ZJFex3qo8IIEawYHPaTMaLCcJEXHhS1qZ1iRx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hp9VRrmlrCMoSzTVQYIsZPvW9vp/lFXSO7G4+oHQctuFfNOfxV6Fi0nhYEVofG0Xx
	 W0hfN8BzIUI58+1o1gTZdAutmx+MbUsyYz+HDCjsGNMuqm/FS1tKz0NoYN25W25II+
	 sz6T/DEtl5yoqQAm3NOFsd8J9T9ndHGK5ck9KQKd1fhJW7sUCaIiR+yZ36/xvpmZEK
	 X/QOtdBNE8stqS9cXc1heM+dnn/rNG9IFdcQSngTW/eZEaW1IGsZS/LbyvbaPTlQiw
	 omAdwoirK7BLlBUBAPJQcKicjJ6BH2vCjiXahg04Xe52l50qztVLar2QYrP594H/rk
	 Rl7OnRsVck4hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1586040BD0;
	Mon, 21 Sep 2026 12:54:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 409F4FEA
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 05:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26ECF40CA4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 05:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jPxg6XbDqe8q for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 05:44:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 639B240C8F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789969486;
 b=JVu/ZDLRJ7uRAygmNqPSyrWd3tOaqaGQa5y41M3hxzFyzLujhN4CD1wMnzc04sFxaqUU
 DSOXaJFfCZoZ37uzkSxtf8i38CAzJuFMEiU8ovuzMIK7OHXRRhP1xa670wst2HvuZ4iBQ
 6+oiPP6drvvgmo/0MvD4Cm8fjfo3FDrq+ZXnIj9HkgK30A3gdvMyM1CV/g0y1bYpRxhcG
 NTXEC9KUklcwP9nzclacz9K/iUeePuwNNojMXfCI6ZUE3K+IOUk0fTmMYqzuqftUDpSXR
 FRQfurPrwqZ4RAv+Y6wLGFnV2ITxIVelaDCBmJW66PfNv8iyFl5x98yWn/xNw1zqKzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789969486;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=cug87ZJFex3qo8IIEawYHPaTMaLCcJEXHhS1qZ1iRx8=;
 b=i0GbT2AchFSshS1BP1JpAwdaVQjzX1O2rSJ7JieG1B6NhyWZeh+rf6UiLAmwl2K4u05B
 2pB99Y6n67P+ekrTwWREbB3oDGrpMTuR7VZ4ebvcyFT9qjcWjGDSbvQjpSsyB++GKKMxH
 mBf+PF3MbGrB5NLT1mzbK11lv/ltq7BYGSI2ke4ZHd52bqqo9+Qb47Z+fUpsgqDmbNC9M
 Yu5kl1v0to5Cm3P1fyt4dFdMKEdd1qVf9hG48FZaFUnmvPBwUmUu1Cdj+4MHzBp0IkBXk
 4rYXwtxtSx3MUcLBAStV2h+fF+/tsaUQhwLBRN3/6rg9s5z93M/C6y91fhB1Qj5GP1Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kalhvGT4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=hungen3108@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kalhvGT4
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 639B240C8F
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 05:44:45 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2dd77300825so26291465ad.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 22:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789969485; x=1790574285;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cug87ZJFex3qo8IIEawYHPaTMaLCcJEXHhS1qZ1iRx8=;
 b=kalhvGT4cF+DYXtWlFf0CHCUoXVHimbV0y88ZFESNQT4xVI0+hCMBZZ2R7WSg/Jlcx
 0TW5MjtnvEmVWgzRsPxmye+j4UrUWue8kv6XDuEMWuaeCYv3f3pkf1rVMhWslBndiyW8
 bBt96S6gn0d3Pfgkht8Jcd54w7cKjpV3/M8ph97gThDLYz18RhxEn/5h+lRbo+Ohu9FK
 y7O2PzbOsMc8dEkr4x0uQnehdDBdgIvhCFlo+KgU2WIOUeK6BmRTJrrc836+IMtZIeG8
 bvHDFornLgmh3NVY9IxsshvHFq2awh0bZNt8+HCsfskJf5Qd/+jWhNP9j4MJ29oKpXlv
 EKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789969485; x=1790574285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cug87ZJFex3qo8IIEawYHPaTMaLCcJEXHhS1qZ1iRx8=;
 b=W8AmAXA1RgWirZJdGwWdGNX4BqAhcMISQbH3rSFATbf8Lj+2l/CZsBTiT1aPwvOGDH
 qoOQWg7AkI3xwYD1EWXb+R8n/XFZGIKS5HjgwK2rWCF9GCW2xNr9B4co8DK81dhyUatP
 7WIh45zg7mAVKv8RjddKI1+izu3cauBhOwvXoEs0ygY0HRQglqSAmZ+HsDX8mvc8JPhz
 UKwt0e3VF1xDbR+VubZt3gfjA4Vpp2ma2Pt/VS6Xng6ri00gk1dkcqCf+aJicsNQdQyb
 WCWzASvTgA4fM7kM1ZLx5MOIHhmRv7rQ1+iq3VrACI0iqkI2RmkQcg8xy1uZmTPys8FL
 SfVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxn9uCgZ6rPwq4OkIvcoGbrt/ypuHy9JXnB6uCStHuKMFfljidy6rOE/DbuERzzsBXnal/tbn0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nGs/r18FCHCIh+Q0l8GxyzBKO/g9xnuIW3S8IsmmBjG9qZ/XRP
 uiyQVpbhhSLcnFeSqOjV+FRrntSCS36IlDEaDKxR9ERmfq5rr7+rW1dE
X-Gm-Gg: AYBFou1YfXw/9KHbi9/ejkh92adZh/kWkOY0hmlL9ROoeQoZWjh3SEtT+WppSF1bjhX
 7PQR2XxGoM7nx5yAhtqwlUB/MW7gDvp0JIasw8Sv4iphRM8l4auMlYOxExgoXL+rl/1deHHJx8/
 fq6ppc1X/VJ+2tMJQd3C5mRtQDTzkCrbjiR5lzI1RhAz07e7z4h6d2nxTIkJw0lST4fbNgTiiUf
 4txLMlo/61jMk04XVC8iWQtzZXnpO72REKuOPW/jKdavwbV2eMXvNqy2ZWBNEHX+N2V59WTbzZQ
 J5y4lPtGKc0ctK8pFJayrf+mhhNCjlVFzklsqB4ki7GHAzBAlPvIL+KD7WBBblOaaskOB4F5p7w
 hLo+I3NJ4p/2wwtd2fZdJgJmmyKKjzVIyQ8OvaBzomT07bYW6OblOwcnGb5HRF0Oi2gRLdPp02x
 RGhGkUQG3Yt2Ddv7sTocNeIF+7KUAZwF5H0NRh8L/AJm6bRYmoRYBFGSE+2GkUDg0senHo5tuN+
 scaFmicMb2gPky3Cr33uW22qtbKfknXAKmEhQqEpy3QPPwf3hdYwPt3qObs1Ol7Hh6gnx8i8VmP
 inwGHBY=
X-Received: by 2002:a17:903:b87:b0:2dd:ad73:c93c with SMTP id
 d9443c01a7336-2ddb1bed468mr157575125ad.29.1789969485214; 
 Sun, 20 Sep 2026 22:44:45 -0700 (PDT)
Received: from pc130107.ADVANTECH.CORP (59-124-202-175.hinet-ip.hinet.net.
 [59.124.202.175]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc17888b9sm28002275ad.23.2026.09.20.22.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 22:44:44 -0700 (PDT)
From: Tom Hsieh <hungen3108@gmail.com>
To: marek.vasut@mailbox.org,
	eichest@gmail.com
Cc: marek.vasut+usb@mailbox.org, stefan.eichenberger@toradex.com,
 trini@konsulko.com, hayashi.kunihiko@socionext.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
Date: Mon, 21 Sep 2026 13:44:32 +0800
Message-ID: <20260921054432.2978558-1-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <eab9d4af-6f01-4963-8fea-49a53abea2e9@mailbox.org>
References: <eab9d4af-6f01-4963-8fea-49a53abea2e9@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Marek, Stefan,

I hit this independently on an i.MX95 board (Advantech AOM-2521, with a
GL3523 hub on the DWC3 root port), so here is some data for the archive
and an attempt at the open question.

What the hardware shows. U-Boot's `clk dump` reports scmi-1 at 32768 Hz
and scmi-2 at 24000000 Hz. "ref" is index 1 of the dwc3 subnode's
clock-names, and index 1 of the glue node's bulk is scmi-1, so
dwc3_ref_clk_period() does its arithmetic on 32768:

                          before    after
  GUCTL.REFCLKPER            821       41
  GFLADJ.REFCLK_FLADJ          2     2032
  GFLADJ.240MHZDECR           28       10

Both columns are register reads. Once the clock is resolved correctly
GFLADJ reads 0x0a87f000, bit for bit what Linux programs on the same
board, and `usb start` goes from

  Device not responding to set address.
  USB device not accepting new address (error=80000000)

on the USB 2.0 half of the hub to both halves enumerating. SuperSpeed
is unaffected here, consistent with it taking its clock from the PIPE
interface rather than from these registers. Those numbers come from a
local change of my own rather than from the patch as posted, so no
Tested-by from me yet - I will send one once I have booted your version.

> > This would mean we would have to list all the possible compatible
> > strings, which would be difficult to maintain.
>
> Isn't that what Linux does as well ?

Not for clocks, no. Linux never looks at the parent for a clock at all.
dwc3_get_clocks() in drivers/usb/dwc3/core.c works only on its own node:

	static int dwc3_get_clocks(struct dwc3 *dwc)
	{
		struct device *dev = dwc->dev;
		...
		dwc->ref_clk = devm_clk_get_optional(dev, "ref");

so there is no parent-compatible check there to copy. The one place
dwc3 core does test the parent's compatible is an unrelated
register-offset quirk:

	if (of_device_is_compatible(parent, "realtek,rtd-dwc3")) {
		dwc_res.start -= DWC3_GLOBALS_REGS_START;
		dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
	}

The parent lookup is a U-Boot-only construct, added by c6583354b7c1 to
cover the DTs that keep the clock in the glue node.

On whether dev->parent can be an unrelated bus node: I do not think it
can, and the reason is structural rather than a property of any one DT.
A dwc3-generic device exists only because dwc3_glue_bind() bound it,
either from a subnode of the glue node or, for the flattened-DT glues
that go through dwc3_flat_dt_get_ctrl_dev(), from the glue node itself.
Four drivers use that .bind - dwc3-generic-wrapper, uniphier-dwc3,
dwc3-sti and dwc3-am62 - so dev->parent is always one of those four,
never an arbitrary bus.

As for what the check would cost today, the current list is short enough
to state exactly. Of the 27 compatibles across those four glue drivers'
of_match tables, three would fail a "dwc3"/"snps" substring test:

	ti,am62-usb                 drivers/usb/dwc3/dwc3-am62.c
	samsung,exynos7870-dwusb3   drivers/usb/dwc3/dwc3-generic.c
	samsung,exynos850-dwusb3    drivers/usb/dwc3/dwc3-generic.c

Stefan named the first and third; exynos7870 is the one that completes
the set. So the check would need three exceptions on the day it lands,
and a fourth the next time a glue is added that does not spell "dwc3"
in its compatible.

If the intent is to validate that the parent really is a DWC3 glue
rather than to enumerate SoCs, the binding above is the thing that
actually expresses it, and it does not need a list.

Either way, please do not let this hold the fix up on my account - the
wrong reference clock is a real failure on shipping hardware.

Thanks,
Tom
