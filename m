Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111BDC5AD05
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 22:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CB4260670;
	Fri,  7 Aug 2026 22:01:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kn-OCViV2Nx7; Fri,  7 Aug 2026 22:01:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4F38605CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786140064;
	bh=mn52VNlXuDw29e8xgA0+LgYFU8oVIJRYpT53BYKOZ2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GjNxhVN8HlTL3B9iM+p0aH/L8wyvSmA3Pz4RWPWOqwCUTAj9Psw66OlChYson2kus
	 AMBEsD1PB3nRTTmp949JrknNPqagglxPQhs+J+ZqNQhB1UXGTEhM9cmEiojvcyNCdv
	 xEocwbmNZdx1WZzL0CYYYs/cXoTNw0WbLglMTEKSPc9yC35rCjNMRkEO1OMTHktiAS
	 +70d7nvB4mwu1d9wfbwC/0NGcPOuEetCn4byh7c+ZsztesPezo560ZGjBgjmbE+RNa
	 P4Y0uKhvrhNFCIIAzLbX76du7cW+T2fbYtHSXAsqyKZ8sZQFaWj4wy75JU85sIB8l+
	 FITE9B3m+zPKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4F38605CB;
	Fri,  7 Aug 2026 22:01:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E9AE282
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 22:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C442605CB
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 22:01:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IFJ3R8aPh6pI for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 22:01:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 76239605B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76239605B7
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76239605B7
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 22:01:01 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a1995ac437so75921a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 15:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786140059; cv=none;
 d=google.com; s=arc-20260327;
 b=VzxJQf/dNHIgaIfI07rfTWh8w1nBag1FLkRbmAYXG2d0owN9zVzMkK0Z9UQ77XraIP
 j2HF82fzcuPGyYSIzS0anUQBcLSzjPPvH07elsh7Vc9qze7A+BOIew+i9i4z0WHRHMhz
 DC6cCq8/xoaNq1Pz0VQgiJg4GTYYgRh8IBrREW2vA0iCw6Ayvv0B5zUSZ25NrOPl3IGj
 fiiNq5n8hbHjU8EefozJcrdliXxPi2wQ+KHRrWmKYO19QUJXp03fs8iVQg5bXPIZ8WyB
 KNOLM49gGw/iEEQLdOJ/KzMS1kfzv10Q6qY6RCy9Owbeb4XX3i/aqKwg71xFQ+CSOiLT
 fcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mn52VNlXuDw29e8xgA0+LgYFU8oVIJRYpT53BYKOZ2Q=;
 fh=tyTJNzsmu0SVdf4taO8NdDXeBg7rXzfLfpXqMo7uAXg=;
 b=mNNDX4vJiCQnPQYpHJmF+Xx8lo3nBtCnS09pAQEwvvT8l8OcsBzVO0PwP4BYAt6jQg
 6pCPKLyFXU2+83W5FTwK2feG6GtlvNXH7/VXC4wufQbIWtZQ0W2tOlOJvrOoLU8rXA+E
 +UVAz0adFo0h+HDopO+NFIPvdHfhi62pl1nHTLCJLhATJuX/LOqk71UkbUIG5FykCArq
 pMbV4ycVV1Iq9XBVIJBRl8SLeLFz6OvyD4gdBSn2hF8HgiGDrHKddGNn/0OhR/knX3UZ
 i7Keagvx5lUMjS//xKJM9vPajT+Hb6AouxVqlRhTKTpFTlp4X7V4DOMCbijsat1r1VsS
 E59A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786140059; x=1786744859;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mn52VNlXuDw29e8xgA0+LgYFU8oVIJRYpT53BYKOZ2Q=;
 b=RvEvfd35DJibU/cR9RVnSSoZMROHyfEWZ6s8RKMIM34Ms/i7OMtjQMwKZ+6fic1Wr6
 LfApinbSafaG2erDZUqVHiFhibUXwSpEGwbJWCTvhI11vLhoOA+hPdB+HrcTdqFgngfK
 OVbac5STHMOVRpRBinmM2B41kDuX3NDB2i4srxt/t7UkyZUfym7KfqohuFU4F5ELCt6u
 jUb84J5qE+YcPn5scGE8hM0/c1fOWl6CriY9qoE2wgi3qoyDxT80Naj3WLO/R5Mf+ACO
 1FbeKKgF/2P6f/3ElPGXufASrCyS8AZdDQNojap8ZUX0fNOIYesPXGpspekRhtepU5K9
 glmA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmoAeqEw5FBtK+skX2cMAOo94D16SqUN0UsdN3B9GqGelKTJLRpMSSyFrqD9NuOAmN0D0cIHk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzUKoi4XnS5nfR8rkMB9WxGKHs27RWr0lzt4a8goOeqZPW/o7li
 s239Z7AFAWWqXbGkf5LWoqZIQMIKzAgHEekO1/tJIXTWKCCPRZXerkQrhmoOhMSBV8KJgLIO2kP
 zi6O+rzf91LjPu/I4f5JzHq6DsaD+NUPq/VRjbCz15kDgO8oFszVHOA==
X-Gm-Gg: AR+sD12z/u/0WRmeWfD3JTkvRbGabZDClmVMbyBroNeL4IE7mlSZI56TMulfSvAEW36
 IAkgt3QiNY0YL4UJJFfZUV+4sAI0JTXTayXKqbdf7k1ZxP5JsZme+/NdM2hdYlD8s1SY4neS2JD
 L7dd+StgdS8Qva8KhYDRcukHkMu24z9gd+OCZEAbeW7E7hbpC/+CgLU4BZS96ozGE4qk30j5IZq
 J+5TvglEiMpTAQIHyUE2pSt8JpBdyfZPOlHEGmYx/MYJKUomQpsrL2gPUO+vhHlOkG5542Myuav
 lsiYfIIrljxCsvCJCTULb/aXJeexA7wjDIEcuN0Cuj0=
X-Received: by 2002:a05:6402:3252:b0:6a1:6da8:a8d1 with SMTP id
 4fb4d7f45d1cf-6a1f4da49ffmr851037a12.2.1786140059155; Fri, 07 Aug 2026
 15:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260807090431.464978-1-jonas@kwiboo.se>
 <CAFLszThA3502QnQxSGyQL+WPEz3tovqE8VA7512gjVKUPSBMEg@mail.gmail.com>
 <a1436f49-823c-4708-b640-92c67fc6362d@kwiboo.se>
In-Reply-To: <a1436f49-823c-4708-b640-92c67fc6362d@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 16:00:47 -0600
X-Gm-Features: AUfX_mxtCTKCOysZiw8CsTJ9q8NyU3UE0igt7TxFj36Iign-dQRq5O4gAQSddh8
Message-ID: <CAFLszTgso=ayEMwx+cF9FDPis1VmO4yQYH+3qoxWbah_GSnfug@mail.gmail.com>
Subject: Re: [PATCH] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786140059; x=1786744859;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mn52VNlXuDw29e8xgA0+LgYFU8oVIJRYpT53BYKOZ2Q=;
 b=HIMio1IDM33p9c+Wq8hhRtYHT30VaA13HdKU6FJMTXwtamtYd2ASmkirian9o5ZdDD
 JiQ5JVthT6fAdcdnKFWazinmyseUAOixn23JqFLqS8rWoONMqh6FbzU7zUrK/6MLUqX/
 917902Fxm0Uyz6i+zSvb1GvZEF/DN5FaxYLOA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HIMio1ID
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On Fri, 7 Aug 2026 at 15:41, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 8/7/2026 10:40 PM, Simon Glass wrote:
> > Hi Jonas,
> >
> > On 2026-08-07T09:04:31, Jonas Karlman <jonas@kwiboo.se> wrote:
> >> rockchip: px30: Fix TPL_STACK overflow into BootROM reserved region
> >>
> >> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
> >> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
> >>
> >> SRAM addressing only seem to use 14 bits, meaning that reading from
> >> 0xff0e4000+ wraps around and instad reads back data at 0xff0e0000+.
> >
> > Typos: 'seem' -> 'seems', 'instad' -> 'instead' and 'possible looks'
> > below -> 'possibly looks'.
>
> Thanks, will update in a v2.
>
> >
> >>
> >> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
> >> reserved region for its global data, malloc area and runtime stack.
> >>
> >> TPL on PX30/RK3326 does not have any use for the malloc area and the
> >> generated GD_SIZE is typically around 304 bytes.
> >>
> >> Current memory layout possible looks something like:
> >>
> >>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
> >>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
> >>       [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (unused)
> >>       [0xff0e08c0, 0xff0e09f0)     304 bytes  global data
> >> [...]
> >>
> >> arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
> >>  common/spl/Kconfig.tpl              | 2 +-
> >>  tools/rkcommon.c                    | 2 +-
> >>  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> >> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> >> @@ -129,7 +129,7 @@ config TPL_MAX_SIZE
> >> -     default 0x2800 if ROCKCHIP_PX30
> >> +     default 0x2c00 if ROCKCHIP_PX30
> >
> > Just to check, the layout shows [0xff0e3c00, 0xff0e3ed0) as pure
> > stack, but BSS (e.g. dram_info in sdram_px30.c) sits after
> > __image_copy_end and is not counted by the TPL_MAX_SIZE assert in
> > u-boot-tpl-v8.lds, so with an image close to 11 KiB the real stack
> > headroom is a bit less than 720 bytes.
>
> You are correct, current BSS is 72 bytes, will update the commit message
> to mention that the 720 bytes must fit both BSS and the stack in a v2.
>
> What is interesting is that global data is so large, especially when in
> this case nothing here is really using global data. We could save 16
> bytes by fully disable CONFIG_TPL_SYS_MALLOC_F, but that was too
> intrusive to be part of this fix.

Well we have DRAM in there now. Actually now that Ilas' series is in,
we could take a look at trimming and aligning things - some things are
long which could be int, which matters on arm64.

I also did some work on struct board_f which is another way to reduce
space, if we can find more things which are only needed in early board
start-up. I suppose we could even expand that to include the
board_init_r() calls.

Regards,
Simon
