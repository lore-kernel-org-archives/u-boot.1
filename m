Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76129CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CF974054E;
	Mon, 12 Oct 2026 22:43:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1RH6RyECNIcV; Mon, 12 Oct 2026 22:43:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55F8F40576
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791845002;
	b=su6XCDVjaoIniNnTVSENAPcGJejtr7d6gAErf99nXlTEy3YxBaVznl7vIs7EWOMSYOO8
	 /OmsksGP4dp1a7FT/QEF1jDNkGs0/C9/GnAx+wlPnzgb7gn8F34yDzHtRscSs0M2ZnSHM
	 75M2zRLDN5G8W6/iVz6+viCb4QtOpMhry8Uanjq9airvI92QYrZhLOuYSMPnITUdR+tZk
	 t0lu+VGhoVD/ewmVmFMhaNg74XnbELJ5t9RyPt0EjvFXiNTOy3IBFtWG1VJp91VPcH6YX
	 l/gYxPxwX6FBqxJP3HjNV1TgcwbBiDM/nAXoEK319OujwtvZRlSITogXc2N+/iyBhQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791845002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dxWLs5Ffp7f/lt7SR1fi26J3AAUU+O2Gyo4eLbD3Z6E=;
	b=s6GlTRpMYZ15kZ5ro7KKptsQFlxL64TJuBvMA6ptsONi9oDnAp6Ee1Gm49+d5MdoECOW
	 EIaEMWKgMsrOVyzgNu7DILVuiyZoivF/tHVZ9N3nN+BVuURLWY01bl5e+i1+dp6HZb8Mk
	 q9IWA6bVfbWDNSFBtxLoROsZPo01Hh+DYSrl7ucKNSl0Jwiv+mhr4t/sNw5R6ZvoA9f6V
	 kErVu+T8I4cLRt+s9bQi5TaXREz1yBBH20W98ajFMr3t7ypxecuY86kX2vkksF/NfWrWM
	 iMVSXFNQ3Eot2xpNhAmeTTVBX4hAdh07ClhP0Avg4wsTaRSo7Zl3zgvUGN7/hn0eyZg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791845002;
	bh=dxWLs5Ffp7f/lt7SR1fi26J3AAUU+O2Gyo4eLbD3Z6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wsT7e6nwfolNm2TVOpr1mdVQ1AXnzKC2E0qPQjwZShA94SC5Y3AW+Ei6voqlipX8/
	 vXIWehG+NIHXE8722jRgLadGqwAHd6OT8eFNzD/+gjNNjPlmvJUpwOXY4lW4mb3UNx
	 il80+ltGMDxRNoiv7H4AkRisUdLYiY4rDVAgSQZhf3BL55GEtqjhtEPJ2AhXoEDsah
	 OuXts6NvxZiKCpuMK8osnw1MsJVCI2tBUybfPHqHV86371upLBs0SI8Cq8c6K4XRS6
	 S3cgSyqglDb4sE2nCozAH8vTXA1TOyMGO6xJIvoUqIAS07H8aht3EqcqwK4B+5ymvj
	 3A1dtxb//Q+iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55F8F40576;
	Mon, 12 Oct 2026 22:43:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ABA1A4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9195D40226
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OOvF5Ds5Znwp for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:43:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 902D040234
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::92b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844999;
 b=P0/3CbPUFldApnK0S5Rcd2Tq1k0LSI7FeAAyp03UHO1YZ/jo/IOig4dasMs5+MfxN0Yf
 yojTuD5haSc1qraJssfVcMFkCrCkkBPju3YfC/y6HQp/7ZONvw/LxZM6UUWx/fOstjz46
 uEQ6qms1zs3FupZGU66nxJ8Zdpe/r0aVysE6eivPhX+013wtsOL06G3z5KuJxWqlsX4QP
 RnfuQMcYG3AqbJABPx9EKRETbd61xpSH0Grd59uiavy8Uv4FEQnOt6DQYmt800JxrLT3h
 yHRfzgHHK6AvD8+UW6s/wWvYZL79Vgm8tebc8Wu9LX/XbfJzgxSCdoQ7Gp4+xf9X5lQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844999;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=dxWLs5Ffp7f/lt7SR1fi26J3AAUU+O2Gyo4eLbD3Z6E=;
 b=iXtWg+GhKNpkYsvrq0TmvEDLNSRwQkF45vjLHlA61HR+aHlaFCW9Caowi/vxDBllszYy
 xtoZYh3+vT8CwgjjUzbmpxz6auz6+MYpIyvRsSQNOMTxW4X/6sT6KkjEi6FN0FSYKtbP7
 2T94ogyQPabyI+UChHMSv4as+A5Pd37rlBOT2m8rVtH+1sU9S3LhzQZiKlgKQbYXMf5xX
 8hKbDJHEp6MOGYapvrMj2N91JvQa3gQrR2tx5g/Q7ei7mqxNs5IfG/Pv+5EKPEWvHlAHE
 I8HMqvUJE+Uc/8RNd1Z9CSdCSkoCGFPG149xgWFtoCCLD1MAxRqVnyOxjyw2bj7ZN4A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QrP3+rFc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::92b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92b; helo=mail-ua1-x92b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QrP3+rFc
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 902D040234
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:43:19 +0000 (UTC)
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-98c5876f2b0so985484241.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791844998; cv=none;
 d=google.com; s=arc-20260327;
 b=CCtM2Iu9vAIF7QlC8eXq4UstjFFL9GGDA+u9+PvypW8hr9q5Mt+aggNBqQGRGR6gZF
 spSlU+LzIrfhGvDFuX3Q9tS4vjILgbvEadiRLiYzMXQCZ5vuvMNhJYLcw36lJ9oH12n/
 O10Yao4pdlncfSCsIpwTwR9MxbslwnOIYRZdK+lga3rmZzrV72e1UdOK1YPt3ZBhsssv
 Py28sKHqasLF7hGlyg+3YAmZM17K4w4XOXtqi3zZyIz/dCnwdWTGKVPcwfx56PcFt9+/
 jIan/5JvRbt4+GY5WizecgcbexeclxZzcqecjhG3kMOcAqZ4Pjt3ogSZ074EP5o3Iy/d
 RkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dxWLs5Ffp7f/lt7SR1fi26J3AAUU+O2Gyo4eLbD3Z6E=;
 fh=r2zW346KJBpWDnLq+6t26tPWA2dXe8FIMvcMqY8QVgA=;
 b=M4gOnFuFv1uzLcLXAI3u7MBzF7ntFm/eE1/HY+O/+v6iXmDENBf80Exp/NtbuBmO9M
 HaO85P2qjRKGlqFEb0JLUPMpr0YBmSxV6CwaEfgvUI+xvrJjV/1esP6GYO/A9S6+uLwg
 DUAFjvsJgUu9LatQoPGpUwmseuuQHFIM9W29zSuQRWeCvm93moAPmWafIhEwujJrdR6T
 ywBjNF3VVHTgucqAlbNwR0GzZ+7d5N2JqcJz12NbLdPF14n8wm743P1JdFri7TaRvluy
 yf0Tfnbuvddnk2nR2GFNAT0QNr9e7aHLLR5bvHbbjDoMUPx4nNWu9aGeKJPTgjD+ghiU
 I0Mg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844998; x=1792449798;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dxWLs5Ffp7f/lt7SR1fi26J3AAUU+O2Gyo4eLbD3Z6E=;
 b=QrP3+rFcxw9PzPyH2+oFL97qb8gDy/7YAfPegV4TW3alcoIpaBNFbHR0dxeY9HCJbj
 hl7dCnrxnLgEYNJL/+eMkh/N+4YARe43YkYF/Fug2qP9GCz7Bu69lROWFl9+GtYfuDZv
 Ep7x/obXAuxJUqC+aZy9zHjDX1GisQ+ohkcStbwgbuEP9KW1THTSm/o00+rUuTzRxI+B
 hydE4Cc2jMsBD2UXwf+8NpIbYimrCFO66+oX5wG673KvJc3xx7vUEEViB9YiJLU+TZ/m
 i9Wnaq6TC+02goYcelilERvjLbNa1Dv2dWCtymxEtz2xc6N6VVmpsampyTfgQUxwrqTh
 MNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844998; x=1792449798;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dxWLs5Ffp7f/lt7SR1fi26J3AAUU+O2Gyo4eLbD3Z6E=;
 b=H0cpI77gFyO4cmD61n4cTuwROuPDyI45BWq3nEeT1zv8tKfK8APaCc6TnKqFGPbwCW
 DtdWErVwF5JodrCfPILlDtS3O0Cvu1vWYg9mDdih7QInMGW7z/12hzX7zv7UHQnljuOt
 Wc7JQErMCYGB5/TwZpJHbIjLrHo11UG4Aye8jt5A+76P9qEuftmKZx+VTi/sNj7QqfDH
 Pl3nuwT4G19F+XsBEz7/PvuPtVE1OsE5LLCIBfyhtq58U9D57ihjk7IBIzKO3I3PbP+f
 hyMMFNwZ+vCfzUzGjFtuloyih4oU+arlVIwUwGpBUWupPaADTKgzabRsaMh73pbHCnAb
 z0qw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLAMyDMkN0Iwca1dzSh+ZJvubMsTrWE59+vwgkDs8lX40r2HjvPWniU3BfZKzMbqziuWQXcT4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK7nd4xD9uFJ2iL9ehU+oBcX9y3lk7eD30lBwboDecIcb9H+U9B
 UamdJjQp2b649k/nQlC6+FNZnKo+PaJGZfMyWWaaCRBC3Z/+YY+JZTpr/dhzRRQBjj64aly3cGg
 XfKXybb0Cel+WXRcK6WGeH9EU5J4c/5IDRuQU
X-Gm-Gg: AYBFou3r0bwGbqLl451RsFcVTZ8t+TgGGgdQyQ/WniWf48gcWUWykwtxd74qetqq4Gc
 qPYqbYeHtIA6emCPxOx9hMmV6ImGcacvT8WVtd2XxO54CXwsbWxPZ6DygSkCxOmfrA+aIwJqzNs
 fAIDdnQsS6XpwbUlM9m+psEyAdnCXqxDqlnyXQXfM41fAQ/VFR7kv8GedpdflnrG2ScuA3XVtfX
 iiLocm7+/BIbUHjJy1jSfSht6mrzXfECEcnDO5Tn1AhMu40mf3Pzc0k9VjYRPH0a6Pe77Tkrd4T
 DdBMMkzOjx1bPjHX0wg4ItcPYatsT5q/u3bAU4MeCUPY3DZLFOVEIzAa/rUD1tXQBapvWI/vZ8m
 J0SwBLb9hVJ6K+eRT0kxkeZYjSOqiDrD6iY72GxfvLV+maD84g5ruLpCHWEqpTJrkQ35PcTt40Y
 ebN1JWM5kekzYQofxsd6Ie8Z0RLDnE+4EwRVjWrZi1e6x13TwG2X2L9Io=
X-Received: by 2002:a67:e704:0:b0:7ba:9a61:23eb with SMTP id
 ada2fe7eead31-7cb37afe149mr3008409137.37.1791844997836; Mon, 12 Oct 2026
 15:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <e38b2ce1-a74b-4266-8d34-8a8eeb9981c6@arm.com>
 <20261012200814.GA3799261@bill-the-cat>
 <CADvTj4pfFC6JOSwK1AUEQwZ9=6niGAx13e5fiP09L6hbey4rzw@mail.gmail.com>
 <20261012210300.GJ3722450@bill-the-cat>
In-Reply-To: <20261012210300.GJ3722450@bill-the-cat>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 16:43:06 -0600
X-Gm-Features: AclHuK-cL1xeQlSXImL2pfPLIxh5_JOGgAtWodW-9vywMFr26hJpOOrOFpmjFNA
Message-ID: <CADvTj4rP6nobpBD=N2m+babdvwVHCK7kHWpVuDix=oZNFh_gSA@mail.gmail.com>
Subject: Re: Please pull net-next-20261009 [corrected]
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 12, 2026 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Oct 12, 2026 at 02:41:42PM -0600, James Hilliard wrote:
> > On Mon, Oct 12, 2026 at 2:08=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Mon, Oct 12, 2026 at 09:47:05AM +0200, Jerome Forissier wrote:
> > >
> > > > Hi Tom,
> > > >
> > > > The following changes since commit ed869863c7e2aca50d57a05d843830dd=
843138c4:
> > > >
> > > >   Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-pr=
oject.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -=
0600)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ =
tags/net-next-20261009
> > > >
> > > > for you to fetch changes up to 28ddd369e2f7199539cdefe22ce014c592b8=
90bd:
> > > >
> > > >   net: dwc_eth_qos: spacemit: add support for K3 SoC (2026-10-09 18=
:58:10 +0200)
> > > >
> > > > *** Please note ***
> > > >
> > > > Commit "qemu-xtensa: Increase the U-Boot memory reservation" fixes =
a build
> > > > error detected by CI that would otherwise be caused by "net: e1000:=
 use all
> > > > RX descriptors". I did NOT send that one out for review to avoid de=
laying
> > > > this pull request, but if you'd like me to do otherwise just let me=
 know.
> > > >
> > > > Similarly, the test added by "test: net: cover lwIP DHCP autoload h=
andoff"
> > > > initally failed CI and I incorporated my own fix (see the commit
> > > > description).
> > > >
> > > > ----------------------------------------------------------------
> > > > Pull request net-next 20261009.
> > >
> > > Now that I've fixed the sage lab in CI[1] I've found a run-time failu=
re.
> > >
> > > [snip]
> > > > James Hilliard (20):
> > > [snip]
> > > >       net: lwip: finish DHCP before starting autoload
> > >
> > > Fails on BeagleBone Black with lwIP enabled, none of the network test=
s
> > > run and the log output is:
> > > =3D> setenv autoload no
> > > =3D> dhcp
> > > link up on port 0, speed 100, full duplex
> > > =3D>
> > > and we never get an IP and so can't network.
> >
> > I think this should fix it:
> > https://lore.kernel.org/all/20261012-submit-cpsw-rx-eagain-v1-v1-1-0fbd=
c9751568@gmail.com/
>
> Are there likely other drivers with this problem?

Yeah, this should fix them:
https://lore.kernel.org/u-boot/20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20=
425c15d@gmail.com/T/

>
> --
> Tom
