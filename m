Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EE4C98332
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D171680E45;
	Sun, 27 Sep 2026 15:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5P79TRCuJ8Vh; Sun, 27 Sep 2026 15:01:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0ED0080FDE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521311;
	b=WJ0huigBWLX8yL+eXiwFMWN6dB1Sx9J1IAW8j7+X1wxktsBBC+Yc61kr5dNBqWYs/trK
	 S2ve8fujt+XOTJfpskOQIBuCKt5IUB/4ACBqdhckZjd65Blprm1cQjJUu1NeFulH6ZdWD
	 9ya6sh3kjR6KMPDBKlXfat6ntYNFV4b6M2LhSRj9NVceokcrgdqZtcYAQveYYi04G8qZo
	 JjIy8rstHLgJat5QfTHmRH5kacfNr263hGgiJGSq60FlJXpBPUoQnqW3LBrHygP3uFD5I
	 jFsxhsvWmS4/lI6tZVH3/OpQdP3v1dMv8TCK//p3HwmX3+LRnzfVc6eayr8jztbJNPQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=G/Uz6b3caMZgbWDrSwgmR/aikf/Rz7fFAhnr+NvFAV4=;
	b=HjticpyIcKAg2iAIa7/idU9qsM9UDkwB8KHfre+k37r0W4b0AW+Pn4U+sRUX5vExRiew
	 hrfq2TPaFT1tmHkWJacYShX001uVSEDsucj6cLikOuRcZfbudyQAZGpgWlq3EW+O6a4YY
	 ZlcM3fxR3FEtKwd78hZ4reSFvnjyYkPtmTs8Z8tc8w9lscKENL1x1ZUUmX/Q4pgCyL+et
	 SWnFjGfk21z2Ok1SNe1hRWji1lu0obTRZdjloPaOtDqiWvfYlqoip3EAQGYoHEQfTxhkP
	 pRB35HKdN/u6oYTRHoO/hlPGNVRq65RTtEdL9+qPCSJFzijhX8Eimr3ItUgqKJ0Xulg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521311;
	bh=G/Uz6b3caMZgbWDrSwgmR/aikf/Rz7fFAhnr+NvFAV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HDQmcY/k1JGCBhmGSyye6mQrMSRSt5k1XqJTbzRwEzvn//VLtJ1etD2hgKtn5w2ip
	 Gfiys5bK1AeTz7RIyLg5+PuBNQvgZ4MWFy/vK0vkD5at90M+Nv9/y+pgBP9vN0mWe1
	 5XfNOpfwBvcvt3jIL049mEpoYJkMDYcIuQ1oh31s4fz19DaprCOHq6PsNiGSit6LAb
	 VWGl/9LiNrIxRvGutMRXWYKeipslP3OuW+37794GnnA1uf1itAnrgaYtz97eWk/Voc
	 Fd/knB/Pu9ooag6g7fCtFXYoY5bDWvstGbM/saEYzaWoiDCvIZyorMM0bwH+vxON57
	 yLGyrRPoMY4FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ED0080FDE;
	Sun, 27 Sep 2026 15:01:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A2EE972
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88DCB400BE
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:01:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lv97fBKQ_822 for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:01:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 80EAF40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521309;
 b=PS/y6CRpgIsgcn/rA0uvxTUP901x2CxH/hm2FZD0CpvPf1+vnG6kcCzYlcDNVt3au6s4
 a1Tfcf+9yg2Kd7+xiUAA7SiNFSq4FVgkmWqnAeGf9qwHhM9RAKn90PP+3zt3HQMPBnAxo
 ga5lTOm9UGB2c5dQ+yipkUtVgblszKYjg/OrjJHIS6LOtD3LT0KU5IAA3LZ6KvcTYQFHy
 cA/KwTFxMzyp11kPPWDxThZxTVvzDHNCBQyFxp13yhKfJz+aRK8XbqV0aZ6PPw40TjLoV
 wFgHwzprP0ZfYFpa8IeduEh5ukSc2+iFW+m3nGygVmwLTzlsx3E0W1hCY7bOMjpWNvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790521309;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=G/Uz6b3caMZgbWDrSwgmR/aikf/Rz7fFAhnr+NvFAV4=;
 b=I8vqPO3utA8X0v6OBGCIpw8H8aFuOZC7mGOPS63EAib5gxlAIFzY1emI1CpQu4krrUO1
 5wp2TaebzP25IhABXgNOcz7Ow+h53F731KyyswHZHzoqd6bL3OA0Jkn7RZz6Tei+EpB7D
 YedeSk3mEXGhGzchCrWxKvitIllMTf8ctgUFZrDSbvIJ5QFgdZbqFY9S4ma2QL1iTBZTc
 Y0QD1pnGSsPXzGHrvOpYFsqKj3geCMFpWbWsEfLbTO8xq3tncDxRHqzrVyvyrW2JrXjl5
 /oPegSPZwF38sB6kMkMdLrlDheaxXAfv6K+LZV41U48WjcoRImlUbYlLM9SXz2GBU4g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=VO29Hv5+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=VO29Hv5+
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80EAF40068
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:01:48 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aae7b7fe22so3719504a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790521306; cv=none;
 d=google.com; s=arc-20260327;
 b=dj+wrng8EzPXBs/NaoGinrkeFFY9/z5fhNXbv1iJ+/eHDrMCKTnzI+m+oDSj3Ey8lL
 vSOTF3xVcAf4KjbAi2DlJkVKS5du7i1MSWLFKPHspa9KuiYznU5cyImCjvxxgLiXSPVv
 7sir6P520ercRsJe6/Sm+IgYR+eR860bJCcWWs/INa7sRWVOBKEUjusq0LrVzGLRNK86
 Unh5vYxNY383NgtQSdJcdfdEXeKCWUQ7T3sVL5OxWY7iUm6V1U7/eCVY5HhUPRfmX/Ai
 UbztkPSsh7ZCLliw05fr7Q3RRSJ1Q/Fke3lykxx3oJAgNfcmCiOApH/FH+sSWixqGlPy
 IZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G/Uz6b3caMZgbWDrSwgmR/aikf/Rz7fFAhnr+NvFAV4=;
 fh=wePAGD22evOQNKuFPz7Xm/oPatvMYU6uavxvnKpwhJw=;
 b=syKhBUDGHSO9UJQt/fgnK77Bo3aYH/KffGxKB7xz3a9ESIi4EysIMNg2sAW29NfMBe
 K3C1hCHUT+4CizqwEHvg74p2FWZQO+mVBjfo/590bdAUwpkfCSbr4tpsSxSqxEnznO7Q
 wXgQzoQnjHcsdLqPkc1IX9mGA23QDTIWdrQ4No3MPjhQvsTjYtsGgBpJhWn2bu7vLWWV
 REx7THNjblSgH24mx2wi8lHxlBWfvnay5fW0tFgbIR4mTrtPt93Sr+wlgk8cuZFx3cip
 LOtIiQzWje6YBinioHWfysUsqK7Xjro9JO0ZSBGrse8zzIJeBEsHxITlmG37RExxJ8Hm
 +/6g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790521306; x=1791126106;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G/Uz6b3caMZgbWDrSwgmR/aikf/Rz7fFAhnr+NvFAV4=;
 b=VO29Hv5+D0IgxStuudKDBjhAJnlIcpydY9iGgJg7llkZi64W/zRxgxEr8OG9+8tWDp
 bjRGnrB2sL03nYTeAWYazWwhGmP3m7/sPZj7PHfpneSkPoYU+FUDVffGUq+/mo2+MqgY
 S/NxpAlMH6ToQ8i+BcvtQyQV1OTHV33Yz4tz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521306; x=1791126106;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G/Uz6b3caMZgbWDrSwgmR/aikf/Rz7fFAhnr+NvFAV4=;
 b=jbVl0QYi9P2cIkpCxzD59SjdWkmkOtAll/O8k/zDguF2XlIjPuCAOS2i0p98FBuMGe
 YdyQNanhDbVol5vF5UUvQW9dAu2dO7L9Osjuo60DL/rC2MP0m4ajrFXrO+A3P9cciK7o
 oeAgb+QVMv042VfiJ60Khy3HgxZm3lZw6Yj4Tw+u5Q/gMNXFOhlT4DtjK4YkX6rnRFqk
 0vIsk9FtzFTwPQebXDhAz5aS2Qqd5oZhcD9J0pmItrVQt7Ka4aK2ZQ1jLc4tq/gztE8I
 9FGM8e7nm6aDClCibAG6DGZCjzBRBFhtrMpvLeIJ4yCX+gjzCq6OheuGT8tDfEe62ACh
 f2Rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlIVSz3OsP5Yf2BzcGYDZ93CClX7uxPElK7UeCHEhzs+3SU65x/j2VGRP/IpnJW2gh4XpCEAc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJT3mju1xOXQgUmmI6Eu/60FMDe7p+3AYtit2TSMpUh8cQjMEW+
 ByTkGuY/eRvV3UOMZHIbeYbv1X4QL4Y/Usqhb1LHo5z95Y34O4WQb00ILQaTZTW1s53fnPVDghl
 FFZ9zhNgXFVljHilAPux1WSzpxHCDsETvI7jwxbMa
X-Gm-Gg: AYBFou3SXnv8Bubu9cPu1TEP7m3f+xYAxHgmEkprhdR4zOA9wYdsqRDxCkew6Zek7EC
 vpcRKY8JbNq3U7n68MWYQMVp/vBPRO9CW1JbebxpMc3/xm63UWhmtPv5vqdqHoJ0+pFrLxxFgoM
 UCQgqu92wcI4D++9VQAVjiOovwQeHb3PeUDsksuSKecjAykTDITybCSDSMXjpit7wQJ0wyQWjf+
 TLtrw93m+yw5hyFI56NVSk6eK8TCdMYGkfq4ESVkF7LkXVGGkDOdrShVuJ208RoZjF1z5ctRbMQ
 Il/8FvmAUddIM1l+6kNKgzZ9LKOTsFZmI3kbpvPQb9nk7L+VqisKOg==
X-Received: by 2002:a05:6402:4044:20b0:6aa:ee54:970c with SMTP id
 4fb4d7f45d1cf-6aaee549b5bmr4237338a12.23.1790521306112; Sun, 27 Sep 2026
 08:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105615.1E6E668C4E@verein.lst.de>
In-Reply-To: <20260925105615.1E6E668C4E@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:01:34 -0600
X-Gm-Features: AclHuK-aQWKnlKnDNokHwFmXWr4lpwi_Fex-xjI91CLtI-4qmKUc57dfSCX405M
Message-ID: <CAFLszTgE5S_b+F+qLQkTm1jbSt-JVHvncq8m147qwpbp1B-EsA@mail.gmail.com>
Subject: Re: [PATCH 1/8] core: skip parent device nodes without a DT reference
 when looking for dma-ranges
To: duwe@lst.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Anders Roxell <anders.roxell@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org
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

Hi Torsten,

On 2026-09-25T10:54:32, Torsten Duwe <duwe@lst.de> wrote:
> core: skip parent device nodes without a DT reference when looking for dma-ranges

How about 'dm: core: walk up to the first DT-associated parent for dma-ranges' ?

>
> If a device node got created dynamically, there is no guarantee that the
> parent node has an associated device tree node which could specify dma
> constraints. Especially PCI(e) enumeration adds intermediate "bus nodes",
> also dynamically.
>
> Try harder to find the correct configuration by walking up the tree until
> a DT association is found.
>
> Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
>
> drivers/core/device.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

> diff --git a/drivers/core/device.c b/drivers/core/device.c
> @@ -459,7 +459,19 @@ static int device_get_dma_constraints(struct udevice *dev)
> -     if (!CONFIG_IS_ENABLED(DM_DMA) || !parent || !dev_has_ofnode(parent))
> +     if (!CONFIG_IS_ENABLED(DM_DMA) || !parent)
> +             return 0;
> +
> +     /* Look for the first node in the parent chain */
> +     while (parent) {
> +             if (dev_has_ofnode(parent))
> +                     break;
> +
> +             parent = dev_get_parent(parent);
> +     }
> +
> +     /* No parents have a node, bail out */
> +     if (!parent)
>               return 0;

The comment 'Look for the first node in the parent chain' reads as if
the loop finds any node - please make it explicit, e.g. 'Walk up until
we find a parent that has a DT node'. The loop itself can drop the
break:

    while (parent && !dev_has_ofnode(parent))
        parent = dev_get_parent(parent);

The existing comment immediately below says 'We start parsing for
dma-ranges from the device's bus node. This is specially important on
nested buses.' When we skip past dynamically-created intermediate
buses we are no longer starting at the immediate bus node. I think
that is fine because those nodes cannot carry a dma-ranges property
anyway, but please spell that out in the commit message.

Regards,
Simon
