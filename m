Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBED6C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 17:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91B47858B2;
	Wed, 23 Sep 2026 17:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NNARrOh2VouK; Wed, 23 Sep 2026 17:54:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1E89385634
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790186034;
	b=rkSIVbDcLeGsqd/ib5KseLeLA9zDyooK4zJi9p62zye9mzZecFq1pvYNxKcLIKJ0GLA/
	 9GxNaLhugwhpks7eY8EPcbzpRe0cIRkWQbGzUxG2VRd3bqcAHfucdPKjVITXpQqf+aSTd
	 9ZBLeUHt0VygAqvaDjWsiEUalbM42on5wSc9Y2kZ+B0lxag3T7x0MQUBk9QdngCyBU2rA
	 BDDZ0KO1mT5F4yo7eTQC+T5cOAdaTPBdgIzUnbXvZajfbdTnKX2PmnrCAxTV/eNm1PpTI
	 4RA/XZsemZVKl4+1botTYPA/2Ja96Ag+A0ztl9qbCnT/FvVnpnNT6vBaAia3AHJ5JVA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790186034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=u432SG/rnJ5nWLnQrl2Kh45trSFMyGO/1/IjirNNEb4=;
	b=DUAZeKvFtbLpT7Nqm41AkQFIEwVr7UusYdaAcbs+CoSOyHINS9aKDzwDz5mWTKtQbtR5
	 1uSmeMRRzvzb8V7+0z+wns2Zrna4GnMjxsAWO/4YD/FRW2zyjkhK/y7tJ1SoCosZgFX4j
	 WM/MboahR9agvuW/i2kC0XfrRo8H0lHg7ZBlDo6OP2HFVRv27NwJjWOICOGkeI61gzR3+
	 IzgAajtYfYes2vSkUhYD1hGqAPHhHsJGiTNqPQDYLx4Bfa2NsINx1ZPgSRcENStgBo+ok
	 DHdYv8o4GUqPTgVaYsmKNRa+A1tUyY+8kLQswarl+FwMRNxjTn+kzWmqvyXRmHkCWkw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790186034;
	bh=u432SG/rnJ5nWLnQrl2Kh45trSFMyGO/1/IjirNNEb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W4mKZInTvju6/lAW1eDtQaEFMeQG6OnpHHMLWOWYjIrBrG0xxbhIuBGrONubDWhh5
	 Ouu7VZaRIrz0LPy3NkES/chdyPBlpPhwfj059wVM04fZJn7pQlx8jizFrccbJTyBTU
	 Vu5O0rPrGqjRfwX7ecDVHpntbIqblcx3lrlDjUd04vcb/NpBon8Bnu6XXBUzI0IUPY
	 iLZBcluFHA+Wxbescb8tzL9t+XoL/XtXLC2TMwCzeJvwHYLWQfweyoeFO7YOIEAmI3
	 t3aHR6fm4fHwRyAHulxBw+LUUsAbY2Rb2CiCKZxNPh31lMj6c/vEcIDSYnQGjnqtPV
	 tCa7YFf4mKNKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E89385634;
	Wed, 23 Sep 2026 17:53:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D135832F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 17:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B39216F4A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 17:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RWAOVQoCKRQq for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 17:53:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7C8E160F35
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790185940;
 b=g5QTzO1OS3uNK8qO4dGCMtcBlbBq6q1vraA6VB3uOJGCLmOQAKMb5n1aROywdJ4nD831
 13kHqpPIN2VxEnyoTwT7zPfoBin2/zHVEgESH6LP0lo5XG2czJZffGcPX2xwZW7K5O6AH
 MzIgiuxY6tppd5OGiWmkXcr47RYgt+YzTFGXtAFqNF/JXVAYF8H8UkUrOwKl6tCIlmftP
 oRpBFuf2vy5l68zMpMrXLypoIrpOfpt6X6B+XPV2oX9cKFB72yRnPHlTz1bO6NypEkBP2
 4iBPhuRjnWcR7QbIwwnL41/hn35wz4pxRv3zKgH4VwLgQWOE/t0D9wH30TmVhNOR//g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790185940;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=u432SG/rnJ5nWLnQrl2Kh45trSFMyGO/1/IjirNNEb4=;
 b=pPnQDojB7GPGEsBEVfr8jubpUqcoR51e8M+6XhNyL/ZkgFiZpMiTl9pHjT1zc6FiK+JF
 evmQBoCDBOO7iN2NXGIw+0kSO3In6AQ9vaVmyAN0e7JgnXVVUh6j6kzVf4+BjPcm2cCSf
 lT0CjkFm9TrOojgPIOpqhdAlv3QFiRCecbkAMZEaVn42MmUwqjaJXjYqugioN3/fEG5tq
 ZVxiVK8uIj/+35TBdHD/52GMYUCUSY23pz8k0bk0RrgLbpAgGX8BTOZnD2wS16g+Wf2Yv
 0POdEkHIEZqasMCOEPxcsGNz7MWqtJOqgIB1kYUn5wMbWSzB/rx5X6tAOfTdiTetsTA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PfTZ419d; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PfTZ419d
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C8E160F35
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 17:52:19 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f9f7dbfso143273166b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 10:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790185938; cv=none;
 d=google.com; s=arc-20260327;
 b=WZ3bh3frrdxpVEmU+lPykp+cV7fPkFgxm+HgR9pI5j1A4zp5Bm3aLGEi/KowsOWfT8
 AlVV89z71bTlBE2iXeX01qjctbj3zwtnigtl/HAIIdqvoCChYg8FYCRS+u1k4mCf5G3+
 9crpbFCQh+Ot/DJenb7vQ1DD5qulmJwSqhcVh1eoZcAIpGNiTFSwND2Oldh7J0eVqD1W
 pBfSszey9GtM9cW12wLvOiUFVScS1GYmcpebK6/2g/WkMrTyyUljx2LRtIvcbvl5rw9d
 lTk0NxuXLFg2RzLzzlQM2LtrCOGKI7oLBr4gTXtmQHyziDSiWXqWvrbapfkEsQMv1NvC
 VZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u432SG/rnJ5nWLnQrl2Kh45trSFMyGO/1/IjirNNEb4=;
 fh=j4/9cuAsCEbB7WC/5xrWc7tPwdPT2CtJyk63Qi+Rpd4=;
 b=C4zIWaYEQyWnmLJpmG/vLLMHMUUW9qacQmK2T3v3ZQcuIe1NxZ6ddF58iZaGhJFYE9
 cX67LPydQJWz2m7StrfC8R1Lq6ET+H+oaXN0cSuUQSfkUYF2e2A/2qChE7pgIN0RHrEO
 FSGINVQwEUNbUm4KnYQvzu1LpU0WtV3PCVk0L9tFQkwVBjXCdg3cHg0yDqYEhnvnVag5
 6BneKodmIJoLSZrI8XUSQ8HXiGlKtjy1Naw7/PNIDHfpQEQbRVjbOoeUlOnECwRtx/Xp
 jddQ+wPgqrvmBhWXo+BGJJ02ukM7eT2DFOrwz9HIsBFhEFO2kBB089y+8Fj8NpZBTEGr
 a4+w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790185938; x=1790790738;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u432SG/rnJ5nWLnQrl2Kh45trSFMyGO/1/IjirNNEb4=;
 b=PfTZ419dfvRX7vVHId8DK6TitYSTLzqEWt/Zz1gIUNnE3yO/xk5+kXnCritpFPiA40
 GL3hB3iPUSVd5YbW+IIgjYKqXYdyRxU0KseSIKnlfHm8Eaxs5KAGyPbGMilULxuJY1Cx
 iCFQtGygol+aUu6XblPuH94pyOCeHPFuCE58OpRuRDiuKrY01Hl2XK/HkzuvtJBiiP6C
 u1onMC1ViZl0fWqVJXgd8idcKl4ESCSJPUDVnqbtbb4JEvWLqKtNToAJrpFKFVoo5nPd
 7Bvtr9Noew1KXYI32JQtQrnz0sTczjdAm3Uw8hApwRP2KX62MC9ZfMvwNLUPMcM22bIw
 tVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790185938; x=1790790738;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u432SG/rnJ5nWLnQrl2Kh45trSFMyGO/1/IjirNNEb4=;
 b=t+hOmZTPNu2zE98iovzWxSHtiqSZM/nYUoxrsWO9w92b8BC2CNqDgJodc6+qdGgih8
 B1c5zVgkL1EUmQKiG5NT0OnPB1cqaAxKPPLjQ8KZID2xghttKjQzEkkH4NemyszSa+2+
 z21kHrq75DN+Ux9Nl28GNSBu0xx6WZKyOE8vmt9VQtcOBJXwBPXBKC9kke95k3u33Qr/
 PPjMWtSJXRnkIIEmwEpBkjCqaGYS85N20Lf01WU0krsps7WdCkUZFd7Dxo99+LuM7UO/
 aNPE9kLiJDf/pAOwfstVqysElq+kqO2lagHpxLikgdr3+cJw5O5sezhJ7lDCsqVtPySO
 p56g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcW+qLjKhex8v0ODgTCNPr2zUonNkeTx7TLr3U4+Zl809LCNLwHz3GjfR2Bbo2itDIwZ69Wko=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kUqRPQHdAEziHZNmbAxAmjsdE3xV+kQsg42jeSLoGm0/XJlU4x
 ZKBt99Mgw44dx3yDDfFwN93Q1UEw1uFNhkNs2fd59ikLDOJu9T+oargSqGngi5px9ldGPeCdjz1
 wL4J1PP9s/RKBgzaxgTBpd4ud2OYK67c=
X-Gm-Gg: AYBFou0nYOAjKnFFAxeiWrIuBjw31hf+0J6o2z/oL6y2GZBB+yx2CxgQSJ62g0A1hB4
 24xQZxsP3b11o5o3LRdZv5NbqTzXhtbOeTP0JPHcJSgSx7ne66WL6ga6likwSl9L9CGgpvtWx7c
 Iyam20z/f7/hZwe2d01cCoy6vMEgUJqgRr/p7YhGlubyGLpNXo+rMr/wp++35Hla2bO8OzNWQfu
 5Zpy3Yk3ChwL1AYMluk+sESHT8Fw61TqSJm7tm1oBCcoI46gwtePgndWRxY3opuPXH/391Ur9V1
 bo7zLvLUTi/RJedCa8DWTX0MjADcFOTu1WuGNZEhupE3JTuP5+rLxOOA
X-Received: by 2002:a17:907:9410:b0:c29:41e1:c918 with SMTP id
 a640c23a62f3a-c2aade3f89amr320244066b.1.1790185937689; Wed, 23 Sep 2026
 10:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260920161930.1880133-1-jonas@kwiboo.se>
 <CAC928Hb3HdGURxLFhxocpQAWGVB2morvpLP=GEsRs_w1iE0oig@mail.gmail.com>
 <ca280adf-19dd-437b-946e-8e5e7f700464@kwiboo.se>
In-Reply-To: <ca280adf-19dd-437b-946e-8e5e7f700464@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 23 Sep 2026 19:52:04 +0200
X-Gm-Features: AclHuK-vZh3cHdP6su3YDVMKBlxvHoY55gSd-UC6dP3BGVFwjx9vMOLHqghcfeg
Message-ID: <CAC928Hb4GK3y4NXt0tEo8U=QF57WeuhCZ=77mvc0t2=6iSpZZg@mail.gmail.com>
Subject: Re: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

Il giorno mar 22 set 2026 alle ore 15:28 Jonas Karlman ha scritto:
>
> Hi Massimo,
>
> On 9/22/2026 1:35 PM, Massimo Pegorer wrote:
> > Hi Jonas,
> >
> > Il giorno dom 20 set 2026 alle ore 18:19 Jonas Karlman
> > <jonas@kwiboo.se> ha scritto:
> >>
> >> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
> >> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
> >>
> >> SRAM addressing only seems to use 14 bits, meaning that reading from
> >> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
> >>
> >> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
> >> reserved region for its global data, malloc area and runtime stack.
> >>
> >> TPL on PX30/RK3326 does not have any use for the malloc area, the
> >> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
> >>
> >> Current memory layout possibly looks something like:
> >>
> >>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
> >>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
> >>       [..., 0xff0e08c0)                       stack area
> >>         [0xff0e08c0]                           stack pointer
> >>       [0xff0e08c0, 0xff0e09f0)     304 bytes  global data (zeroed)
> >>       [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (untouched)
> >>     [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
> >>       [0xff0e1000, 0xff0e3800)      10 KiB    code
> >>       [0xff0e3800, 0xff0e3848)      72 bytes  BSS
> >>
> >> TPL currently does not touch the malloc area, instead the reserved
> >> TPL_SYS_MALLOC_F_LEN bytes help push the zeroed global data struct and
> >> the TPL stack addresses deeper into the BootROM reserved area.
> >>
> >> Using current offsets for global data and stack does not seem to cause
> >> any known issue for BootROM after TPL returns to BootROM to load SPL
> >> into DRAM, however any change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or code
> >> could theoretically change this and cause issues for BootROM.
> >
> > Here with "any change to [...] code" I suppose you mean any change of global
> > data and/or BSS sizes, correct?
>
> Not only, the change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or 'struct
> global_data' would affect where the TPL stack ends up. However, and any
> change to the code may change how the stack is used and thus possible
> write to more/less/other data inside the BootROM area.
>
> > As code size itself is checked against
> > TPL_MAX_SIZE at build time. Regarding build time checks, I have a couple
> > of doubts about [1]:
> > - shouldn't we check for less than or equal against TPL_MAX_SIZE, instead of
> >   strictly less than?
> > - shouldn't be more correct to check the TPL "footprint" size against the 10
> >   (or 11 or 12) KiB limit, instead only the code size?
>
> Correct, this was also briefly discussed/mentioned in the v2 thread. However,
> this patch only tries to address the issue with TPL stack being placed inside
> BootROM reserved area.

Indeed. I was just wondering if in a future patch we should avoid TPL_MAX_SIZE
configuration, and instead have just TPL_MAX_FOOTPRINT configured to 0x3000
adding GD_SIZE and TPL_SYS_MALLOC_F_LEN in the linker check.

>
> >
> > With the new layout the check should be:
> > code size + BSS + GD_SIZE + TPL_SYS_MALLOC_F_LEN + <min_stack> <= 12 KiB
> >
> > [1] https://github.com/u-boot/u-boot/blob/main/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> >
> >>
> >> Update TPL_STACK to use the top of SRAM address and reduce MALLOC_F_LEN
> >> to 0x200 to avoid overflowing global data, malloc area and stack into
> >> the BootROM reserved region.
> >
> > The new layout is certainly safer, but I wonder if we are losing the
> > opportunity for TPL to have approximately 2 extra KiB as they are not used by
> > BootROM once TPL returns to it. I mean, it would be useful to know where
> > initial values of TPL_STACK and TPL_SYS_MALLOC_F_LEN came from, and the
> > rationales behind them. If Rockchip were to assure that preserving only the
> > first 2 KiB of SRAM is enough for SPL loading, keeping these 2 extra KiB on
> > the radar could be useful for future TPL development and/or maintenance.
>
> Please look at v1/v2, they safely allowed for up to 11 KiB TPL. However,
> that change should be handled in a separate patch/series.

I had looked at them, and I agree on a separate patch/series. But here I mean
the 2 KiB that (maybe?) can be used in the 4 KiB BROM SRAM area, in addition
to memory in the 12 KiB TPL SRAM area.

>
> Some of vendor ddr blobs continue to use the BootROM stack, and others
> setup a dedicated stack at end of SRAM. Mainline U-Boot use a dedicated
> stack, and it is placed at end of SRAM for all other Rockchip SoCs.

I totally agree on following a common approach over more SoCs when possible.

Not a relevant contribution, anyway that is my:

Tested-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com> # PX30 custom board

Regards,
Massimo


>
> This patch tries to align PX30/RK3326 to use TPL stack at end of SRAM,
> ahead of a future pending TPL consolidation/refactor series, see [2] or
> deep in my work-in-progress branch at [3].
>
> [2] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/tpl
> [3] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/rk3562
>
> Regards,
> Jonas
>
> >
> > Regards,
> > Massimo
> >
> >>
> >> With these changes the memory layout looks something like:
> >>
> >>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
> >>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
> >>     [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
> >>       [0xff0e1000, 0xff0e3800)      10 KiB    code
> >>       [0xff0e3800, 0xff0e3848)      72 bytes  BSS
> >>       [0xff0e3848, 0xff0e3cd0)    1160 bytes  stack area
> >>         [0xff0e3cd0]                           stack pointer
> >>       [0xff0e3cd0, 0xff0e3e00)     304 bytes  global data
> >>       [0xff0e3e00, 0xff0e4000)     512 bytes  malloc area (unused)
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> ---
> >> The overflow/wrapping was runtime validated on a RK3326 ODROID-GO Super
> >> by printing out content of [0xff0e0000, 0xff0e5000] and comparing the
> >> initial 4 KiB with the 16-20 KiB and the data matched 1:1.
> >>
> >> Changes in v3:
> >> - Drop TPL_MAX_SIZE change
> >> - Keep a small 512 byte malloc area
> >> - Update commit message to reflect changes
> >>
> >> Changes in v2:
> >> - Mention BSS in commit message
> >> - Update spelling in commit message
> >> - Collect r-b tag
> >> ---
> >>  arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
> >> index adba1b49a52b..0088d436d36f 100644
> >> --- a/arch/arm/mach-rockchip/px30/Kconfig
> >> +++ b/arch/arm/mach-rockchip/px30/Kconfig
> >> @@ -81,10 +81,10 @@ config TPL_TEXT_BASE
> >>         default 0xff0e1000
> >>
> >>  config TPL_STACK
> >> -       default 0xff0e4fff
> >> +       default 0xff0e4000
> >>
> >>  config TPL_SYS_MALLOC_F_LEN
> >> -       default 0x600
> >> +       default 0x200
> >>
> >>  config DEBUG_UART_CHANNEL
> >>         int "Mux channel to use for debug UART2/UART3"
> >> --
> >> 2.55.0
> >>
>
