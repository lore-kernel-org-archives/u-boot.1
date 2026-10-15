Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323ECCC6B39
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 16:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3BB1608DB;
	Thu, 15 Oct 2026 16:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B9ElF0jAXUth; Thu, 15 Oct 2026 16:17:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F08B1608D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792081076;
	b=ktLFG+qGoel7EHPUjCNI9FauA/FwMCq935WW5mqMMInp+AzDedNrHfoshslJIg7r9m8T
	 FqBBP18xioFPSND7V/VVjK6xqHCbfM9/eQOzt93sgESp4AiwLfqlapG9DkBFMSX+piOH+
	 2FZOG5TsNwb4mrXZfIFoD44fraQLOB/4x9jQOUGWobhCFdVW49TEP+XxmIGqV423sJggx
	 EOk4O6UZl3mH73op7hLHNWP/4hrIoYRYWQ90GU8M4yytk0aAgua46Vu3g0fZOEm9qfrBI
	 IHydKgwaKQ12O4UShzp5r4l5znsp5ABNl/5enf+/8gWfgugx4LujBi28Zh8W73DBMkg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792081076;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OUlwMKLanaQa+dRioswozvIE2OySPI/luWoHDLCYIJE=;
	b=Now+ouWxfeeD4mwF5Tag5Nva9vcEyCoD20vIBQ75tLaFY5I6skLRYy9GLVbeu6fWwOYv
	 rgfE24L7Dx8e9w1WHcSOlYhrlTaLVtBGVOBxNgcErBKNEQ4+7UkR/oEeQp7eiDl+AOMeN
	 vMCQJxe1X9vLdC5jTGtBpqV1YGLf8on4jIN8/qFSzwl6CpULC9+KeYd5bBlAgNJvFpRle
	 W7l0k0Cd+qGj8OF4tLr0G+s7d0rcSUpPkB037C1AyefK4jk6IRBWMMZN/gOWdCHBGDNJi
	 vvcC6F80t+FQPHoxFYadTXTbkNgS/j4jootzr4DXumAx/h2ArUpWEzI1+BeIHuYoWlQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792081076;
	bh=OUlwMKLanaQa+dRioswozvIE2OySPI/luWoHDLCYIJE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F1k+vgOsNJgrVfbxdPZe9z8ebGcmoG8TxgGgnO0PyNLRPmYB/gyjyMI0nBSNmix2w
	 BPJbEqkBUQeK/oyboVM8aohosvtP/prvWJiYhbj81h2bd2FBNvaL2wjHpshg+Pzc2H
	 hGwsn24TvYhIPHWxzmvIFa9MiwG+07bM4d2t2ge+z44eKWl/VR5cc2Xtjv5Oeeu2XL
	 FLdVU+oIFwbkudhIZIU7qhPwszEfXtTP3aLj/kkgPaKPvmrMHT3nrROaP2IIn4rIo+
	 gtyVbqe4rZqWakm3XIDlRTILqlTZQPysDwK9qmezG5Fpm1Edhtld2PUwyM4NsZA+yL
	 HarvVTjWRZZ1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F08B1608D0;
	Thu, 15 Oct 2026 16:17:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CC297263
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 16:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE0C180F84
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 16:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qegLuG-Mafsx for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 16:17:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B94E580F80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792081074;
 b=fMAcz+0ZYxAXbt0+62D0z/SA9nfG3SPtbPadtAmx/uYpIev32herh8IB94MFRAyJujkj
 naXiS6H3aRAuA/q819z24miUHOkGk6g6LVPPyei4a3SPPj+K8daEQVZRafUvl7XVSvFZJ
 ta4lJIKUiSIBogkSvV3JqdfLpkhVmqMZyHdNvSZwsmbXr90yAEEJrHpRQA1ZW6p8cBiCE
 tl2PPdmfpd1bxZCD54ARF0GrhGuBm58X/LNmmk8vqdDrYkuh/ycHsx+kEZETrXs3XShpw
 bfFR75G+xEwYhI+TkLxKZ/qylQnCzEw6CgFNXU4ili5hXJb6cmKlmoOTUbMELqPrt2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792081074;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=OUlwMKLanaQa+dRioswozvIE2OySPI/luWoHDLCYIJE=;
 b=DHVZdGOfH+g+pdEUqFmGMxN1EBFXR7m+oPD6aVytdsV0sHF5oAzjEZM1zA+NNJYYfUHz
 RFdP/7H+I1mrB8WfxqUIpRapGcZ7Xx/WQAd7T4ASHuLUKE4vi6Q1TAOQhf0Y3N7jDvIUz
 VpNn+oUozu8Si9F9Zd27H0W5TYtvt+SFC+mEs+WTgy6OIbBVhMjge1e1M9l9e0hQ2gJoC
 vCm+tHW/KtRMpw+knRkF+ogRDW94hpYly2mRJrUByWhkP0AfAf3t1hjVIcBtk3NUymp4X
 XCjbIZ/DEoDcaX5r8RMLLb8t6/AH/wE3Ldl1b5UUuxniwW1QQr+CT82AoD6pqmD/PCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YLire7qP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YLire7qP
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B94E580F80
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 16:17:52 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c2dc8cb0decso252295466b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 09:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792081070; cv=none;
 d=google.com; s=arc-20260327;
 b=UigSkHF8HxGPowt1XQ6CML0XobJpQ7o1QaTLFEn4P+z8idNNfUH4rUBw9eL7rhDIPm
 KeDTvmjzAKNSDyacz0ryODB7A/zV+UGaNLb/98upFOnfuSexZ8DMR0ovujxR+TU7slpW
 4Z5o+SP9/3fFMfrrVrCnEEJDLHqigpi6M31qosSsp3crlhzn+DYS6YqihEyQRW/oH0fN
 8CzjSxtouFd+uVIobc6qHVt4XLy/aivlgeHDn8g8lFsXm7CAlwvsDEKvLiIc3RaDKq/u
 6WvN0pdLmgr5NwpRfLHa+2gG7om6Pg2DXh+yOOR6VrwbywrGHVdtJFIxMEq3x4CLb8ot
 QWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OUlwMKLanaQa+dRioswozvIE2OySPI/luWoHDLCYIJE=;
 fh=oIMmC8iu+RpL9QS0aPIrVHvb7dY/DmDKYgM4/PZle3M=;
 b=KFpyH7HU4Qx+v8cNX1dv7DornKvdL+fkRqlD8IDzmG2Wz/hatBUUalKgRvpfDdcUHv
 a1x9mHDTXSo81A8FiJG/wCdyW+S+UgXtVnA8MvGQypBF+Iqe5DYdvaXqc3Ue6rV8GcmQ
 s1fZDamEGeW3zOvYOGZvMndnNoAoYlSYT7DDotRd9IaiYGVkwOwrOJ4UgO+tqgQj05EG
 b7KxLmH0IJ0Lp6DJ27wUcku6+iM6gc8AfrEpgon/LP5qn2j6JFjWEe2uLlUre3Q7VY1n
 9+efWyZ7v1EsRYEeKjoF5l4HN63/T9X2KQzeqG0tB+qOQG7O4ahENmbN6L2kQIZNPAYf
 C25w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792081070; x=1792685870;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OUlwMKLanaQa+dRioswozvIE2OySPI/luWoHDLCYIJE=;
 b=YLire7qPF9VcDy8LynxTiqFZEzs+IGWbX2aqonUQ/B7w9BrjdLW+NvCzG8oV3wItzT
 QYuOpHU9Br+F2+k2CUPqL70CoNP6cBxHNX2N3xSI2Rwp7ZipyAlGYh7CuFaZ4J2Y+gT/
 4tvtJErZ2bVKtNwl9uAXVShlCxXcJh4EYPrmThiOmI/EOqrmR79ZIDAyDpV36JY6ZZbh
 Z1xlOVUhCEpEzJGfEc+P+gIe9bP05cZiurUbTHxnR1TrlqVQjqSWvk/cofD8xPXgNtlt
 cO3YeCiBCWgJBjeRx9qrn3rrbGc9QD7FiB5lAsL4lLKbki5iFOaNIPyKC8YHP3iwRqEJ
 MSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792081070; x=1792685870;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OUlwMKLanaQa+dRioswozvIE2OySPI/luWoHDLCYIJE=;
 b=WDs5AwnnYV99ktbPRhdVbcrqBkhOFmFO5EruIyIAwssO0rGM/q/GJ0CtyDj5FyLkyf
 DCPkV1TrzWkb/DE+7MM+wdSI9ZCj7CsAS1SQUqhZj9vrqw/Y/EwligChjEBTcSt9cr/B
 x0l+NpYB0QCzcyjetberMuYs1LFL8x5HeeggSB6Trpg9NGwX2lzaTJcKH4omcfmkeGvE
 /Zh9lcD032/Gk2uENsu660XOQ4T35ORTaMTLZGQ37uR2qjLlwtzUJ067NZA2IEDFMXnI
 vHlL2bGSsHkJJhSkyqOGIdGME3l8bVEL+er9/Kz+cJANSXA4dpRdcQBnTLc2jRThPKMa
 wWMA==
X-Gm-Message-State: AFq9FYIvo2N8f0LqemgTD/Z1/6AAwEpKT7Cp78C3oL9TSs9Kjzx+XCV7
 lfg868jrUgcdLiqgNMK8Mo1fQ69jBEhinsmvDOUhn1RXicw0e88RoRo8GTan7dtDRHNyJ30pccE
 QuB6upMq4P/STRZUdKc83KCUvtp8uGb8HHJFH
X-Gm-Gg: AYBFou3n3dEpqOvq0I73YR3WJs+K60V353HV96CDOuez9vk1i9NefRzJNabXAhRxPT2
 utBqpFApQhyegFfTfJUVkqqxt41jK5hmAxC/GIKFNbGwUF75XNnJlG8xwMQDozAb8yRzzTPfPK4
 PwI7s90q2EWF/1K1+g4StQgXJNukjupiKS/pcUWFLzFZSzU/jeKtJBdBtZf8it6kAKoFlrpxsyt
 pLJmpvuabQsdk0Dwai3zH2uB2N4v9BvUCp1v8GLfFhtt8pQejvIj1VxOgeeEZWgONfifeo3Ke2Q
 GkFKMWEf1rIwmhT0QY4w5WgXUKNmAh053Imp6BHKlCxXKgYG+Kc/scUu
X-Received: by 2002:a17:907:1c84:b0:c2e:4e08:19b4 with SMTP id
 a640c23a62f3a-c31a9a28c7emr1841282866b.3.1792081069847; Thu, 15 Oct 2026
 09:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-qconfigdoc-v2-1-b2338cdd8a35@gmail.com>
 <CAFLszTjZ9-u6mTdw3HN9xv1YLwS2GL7nF57wuK-=dJx0OX2kwQ@mail.gmail.com>
In-Reply-To: <CAFLszTjZ9-u6mTdw3HN9xv1YLwS2GL7nF57wuK-=dJx0OX2kwQ@mail.gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 15 Oct 2026 18:17:38 +0200
X-Gm-Features: AclHuK9nMOU3-gE8vlHZhYxRcMVO5Hh19dUwGPZW-XAg27n8867vtUj_4W1TqqQ
Message-ID: <CAC928HZjd6Dh0LLtJRjAi1U54BuZOCJuhC-iwQ2qnf0cfDaOLg@mail.gmail.com>
Subject: Re: [PATCH v2] qconfig: Improve the documentation
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
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

Hi Simon,

Il giorno ven 9 ott 2026 alle ore 09:20 Simon Glass ha scritto:
>
> Hi Massimo,
>
> On 2026-10-03T17:00:18, Massimo Pegorer <massimo.pegorer+oss@gmail.com> wrote:
> > qconfig: Improve the documentation
> >
> > Specify where the database is created and under what name. Add text
> > value lookup examples, including quoting, escaping and regular
> > expression cases. Update other examples, or just their output, in the
> > section documenting -f option usage. Trivial fixes.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> >
> > doc/develop/qconfig.rst | 40 +++++++++++++++++++++++++++++++---------
> >  1 file changed, 31 insertions(+), 9 deletions(-)
>
> > diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
> > @@ -81,22 +84,41 @@ Each term is CONFIG name, with or without a tilde (~) prefix. The tool searches
> > -    tools/qconfig.py -f SCSI ~BLK
> > -    3 matches
> > -    pg_wcom_seli8_defconfig highbank_defconfig pg_wcom_expu1_defconfig
> > +    ./tools/qconfig.py -f PCIE1 ~PCIE2
> > +    10 matches
> > +    MPC8548CDS_36BIT MPC8548CDS MPC8548CDS_legacy kmcent2
>
> The sentence above still says 'to find boards which enabled
> CONFIG_SCSI but not CONFIG_BLK', which no longer matches the example.
> Please can you update it to refer to CONFIG_PCIE1 and CONFIG_PCIE2?

Ouch! Sure, I will fix in v3, sorry.

>
> > diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
> > @@ -81,22 +84,41 @@ Each term is CONFIG name, with or without a tilde (~) prefix. The tool searches
> > +String values can be searched for, too, including regular expressions, but
> > +taking care of needed quoting and escaping. The values stored in the database
> > +are the ones from the Kconfig files, before expansion. Moreover, since they are
> > +stored with their double quotes, the quotes must be part of the pattern.
>
> This is much clearer, thanks. One point I might have missed earlier:
> the pattern must match the whole value, since defconfig_matches() uses
> fullmatch(). Otherwise a reader might expect something like '"arch/.*'
> to work. Please can you add a sentence about this?

I'm not sure I follow your example: '"arch/.*' will catch any configurations
with CONFIG_TPL_LDSCRIPT values starting with arch/ and therefore, from my
point of view, it is working as I would expect. The '.*' pattern matches
anything including starting and ending double quotes. If you would like to
utline that the pattern must match the whole value and not just a part of it,
maybe I can reword as follows:

The values stored in the database are the ones from the Kconfig files, before
expansion. Moreover, since they are stored with their double quotes, and the
pattern must match the whole value, the quotes must be part of the pattern.

Would it be fine for v3 ? If you prefer anything else, let me know. Thanks.

Regards,
Massimo

>
> Regards,
> Simon
