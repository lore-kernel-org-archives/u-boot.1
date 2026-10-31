Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC8606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mt0u/VWO;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OvUvODyM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03E9560A7E;
	Sat, 31 Oct 2026 09:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEKaNF4bVd5L; Sat, 31 Oct 2026 09:12:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CDACA60639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793437973;
	b=Wi1NWHAICzi8BzEw/JZhCNm7g8FV4JMPSAWSOKxm4+/wqw+K6/P2UTKlthCiuiR8jw3+
	 iNej4kdH4mDxJg+buuiyGT0XdkzpMicg6QyIAi8VMmdesERAeXPbQTss1mMIXb5IvD6Dv
	 zPMbLk3yDuy127I2C57GBi1xpQ3ZqsayJHBhnKELBKoI4NWR/mtWslny3Avzm/AnI+78X
	 cY3SXiRT8n6LDAIfItCWlQGzUw7a9lNdLrJJIoBj1yXjfPg7YwFXnwVYGSJdp7TrD4F+y
	 iz+MhyhPiAF+cSLyk7EZLaC8IQCUg1obB5zfj/IpPJbzgPakL1vmn9TqleB2h9Gz33Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793437973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RIqPb4wsbyU8l4anI0XHhhosjKNPFFfgXkt7g7HsddE=;
	b=akGXKQ2GE7ozHAtJmN0zmdsXrZbseUAAlGqQom5dTd+VeEXMC+czEXwpq21Ua8847u9j
	 vYpac4xwQIB1Yj3Ja/xWM/JKWh1f6ajmvO8EzU3wrCZv1dqIQq93aiXzbCVT4l6NBDNjF
	 eNZ8FfrdsUOayW5bhKeMQn7j6r8ToNcVqym5rKKvuoWAe/FdTir+aOktVLkk/WHcPyNVa
	 XRSYBBsCaSWh+ia2ktu2tLilPov/VpqvgcilCIWmyjXr8v3ns7H7mYGq1Wdvf3GI5VPSl
	 HkvX2Tf8dUFHAPBPJVO6T+0bKTbm4ojB9V6j9EujnM2YB2H0BQXwM2dM4he977gCT6Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793437972;
	bh=RIqPb4wsbyU8l4anI0XHhhosjKNPFFfgXkt7g7HsddE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mt0u/VWOFHTf/JgP+mnDIElWRdhnsQtr1QfNza3Ngn/kpehVADAe8paWStzw5nhAE
	 Z4+BYSxcsT0PgGcdO82Bwrt6dqqg9AEP1wOiV6+ZM8rwYTi09JmshA44WdCGNJXyj9
	 kxtaI+vKDcxCAigvhpD5x1uRUHsPp6okSv/FhT1tpFmTM7cJe+gkigvun6u4kUa4b/
	 O9MLHnz4TRu+ol/EDaWjLIpde7OWFiN3jixTmtTP1HoGXQw4iRZrIW6ABF3xQllxJ8
	 Rc/TtxhjUKPdVYR8tsMmCzUMFI72RK8RImn5oLfWnZGLnQ/Hwu1L1y5sn41SsZ33O2
	 nyMSw+5EBRFsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDACA60639;
	Sat, 31 Oct 2026 09:12:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BEB50473
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A47CE81118
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bF2npWArOCzW for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:12:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3EC5781117
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793437970;
 b=Vt3XtJJY5vpYwtYLbNUk63BKXTtJurdm4cpRCGBDh+Fjn4QdJu+eX4hTph/gxUhaB86r
 QE1F6FV1CG/gvDI+DFwgHAV52SQmKz0trXyI+NWkPYuma7pm0eBLsv2DeQiBSgzF2sJOo
 8gpGuN/420y8eXF/CbxFoobS1UXHUByZZIv0OBi9MND7It8Jhx11LtOUyfMV82eGYy/8h
 plJSfLMz3/x1CcwnVovhV0v/158Hnz6Ff0amt2T6D6I8WThXymn/bMDtqcr6KBK5UcJzD
 Ez0u5xPhY+3G/9EF+yeqQAGNpmvFkz0BoV92zcCtZhhfVtoWmOBpnbgXrUdR4zFBipg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793437970;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=RIqPb4wsbyU8l4anI0XHhhosjKNPFFfgXkt7g7HsddE=;
 b=nX9FZCspjIirIjiIdvjfCj2twwAWeOeKiR1r24v0rqxYMhCcRG9hSvhixBMgUERAB4c5
 LCtHw9pdEZ8VAgZ+y8++4F4IbUED25GBjOOnedpjhudkFbStpcW/hp4Kh1DcA5eWgH/iz
 lJfv4dMV7FTFNrsUGSxAw47i6VgUBHsn8e2XkHWmmst0OVn66c24cwDSs//jzj4i6lCUb
 uNOagY1a1IzPjarInpJMZ9/e5KsqQk54MLcozvkpD+j1FtVXAD3SNaQkbRNPbrEHxUqRr
 uwtfqWOfh9rRgGBdU3RWkwXHyEQZLxPeQR9itm5wFD5SozCASUKexjFsAcGd8XIPkDQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OvUvODyM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OvUvODyM
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EC5781117
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:12:48 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so1897124a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793437967; cv=none;
 d=google.com; s=arc-20260327;
 b=ExuSRheDfUNFu15v1ofiLC6NbOtA62BgvKEDkiCdPFOVf2IB0FVleEdskk2boewwVa
 28wdWOLGz2Jtw49YQsAE+VCDma8qnotAdyCBzKk+T4UzC6hYotVMJB/Lf+D4HsQFUp7H
 rzXs5oNN0YliKPPme1KRLW3UtpPIb+hVq9YRfGtYPMfBEkdwdDXYrNCwP3E4Xh8rnlr8
 mCl2C1e+TIn4fVBHGeYOFGH7/XDTmbBNsxW/SL+Ssp0KBc9VqDmMLBFDkyDHwvpyfZbd
 WMHNBuN+4cHOCC9Uscm6Fg4fk7J0ISQy5nWIqEs3rcw+MVb9Ei/3YOuubHhavV7Q2mTi
 dgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RIqPb4wsbyU8l4anI0XHhhosjKNPFFfgXkt7g7HsddE=;
 fh=dTODIB8eOV8QmMXTO6NS9hJAq2JPVHLo51odT60wrm8=;
 b=ExZgI3U9SG97bsKzTMtlwnsWjMkwhLnayFktVCTm+3pDJAJzREJUb+oZk4HMhIKCsk
 cqUCkVkFP/FncXabS/qSCic1nGBtw0nAQ5+PHRcrd1o4x+4/G1wKNDXrmpe4l7/n/Wao
 l4I5lg95YkRvVF/hAU7lY0grRh1SH6EvTj74Pck4i/eYx5e1kDay4WLtkn4MjkiR2Bnf
 K1aUpkTr6wzX07Mf1vu60poSf82DSFeWrRW0OfmFDikeVkZMVYOhszpYG11vwCSpmdZJ
 k0q8Df7WOBhEoF0TPg/YdNPid/rbFapY+w4kggFprWvDC0e4xaKioIGgeKqvw6DTKI2n
 4MnQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793437967; x=1794042767;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RIqPb4wsbyU8l4anI0XHhhosjKNPFFfgXkt7g7HsddE=;
 b=OvUvODyMI4GGydyldCbEpD/RFTjbGyoO/2W8MqpZosXiwchqwKF0DHI1SWTJmmQNsr
 iHmi03xU4XWDcpCqGermR2rdhANv2P4gKRkAHhX5YKEswQj4310ejMgZnIxmIOfNMaBh
 9j0QR/JhBJhWtUqxVGWpYHcVD36s5X0VDS3ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793437967; x=1794042767;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RIqPb4wsbyU8l4anI0XHhhosjKNPFFfgXkt7g7HsddE=;
 b=0m84GHovdGMV1JQdr07ZkwPLxqYZIZJFYpS2VFSMsi3xOjAw6jFH/F3g1xZ6HNZil6
 Jwk13XriQM5LsPLWGqPzWiLUZVx7mhOomxdIeo9GXUubDpnNeUR03iE6+sTIwUARPJ//
 WnN94NqMkB4+yIn/e4pBZYvZjRamD47zhqodqEdPORfqeH9uGoNAIt0G0IlcYWkq2cZ3
 92V5ZFvxiZpXHpFWSuWLg/TSn9KFUpoktjsVM8L5Z1HvYwfR4Aahsp0RXO3IlbJa78Fc
 Ev3fspAH5Q6oJstL89q/WaxuXSm+ItXfCgoQZhUqWHvug3eXLdgXzqLZ9A5RvOY7rUN+
 2yAg==
X-Gm-Message-State: AFq9FYJ5bQxCP1kn8wTL8LRM3Lvo1FKP/oVZtwVuhgG9Lrq60skQw1MB
 St96ccq3jcHTN5vJdDgQwmilFa3+flB9648y89L78w1zOzLnsiYDvPCJw4VbxKO0JniYNSIZx/7
 YVuhWkgyCSXWwSJ0TWBlacelXOkuah1rkjoqvYhf09AUc1wF0EodUfg==
X-Gm-Gg: AYBFou1ybkKQVtQ6tY1zXA6O8Dy0N/9HHQFrD1t+cVtxhUofD7GpJxfxluZLjxt/jAg
 bfl4KwXqd0G7AdYMdFDu61B2NhJAEdT9UV0GSW+aDW4LxktALj/JYDAStG/xad5aAGKu8h3weUt
 HLh4t0VIZzq/gMfol+kuAgiDySXjKtgmfg0qQTvKzaKaGL9scKw3bSnqb6DbbRGBt6Qj4tokxLa
 vlG9Xr2BvcvBEdQ8IfcXj6P4Ueg3eLZGuEtjxZ0Z+vOb0bJayDE6gC7Nfo9Z+L5VNJh75dY7PhM
 Byss7vzW3BhdmWHRYJ0eG2A8YATeu84/lXy99k4A5sOvDadYbTfXrDyuPbGTP/7twxKEZFsDByP
 lkI1x8Ba3VqAj9v+KVT9RXEaprUNAU8mkeXYZ9DFPRMCdzb+nfr/o4fJCx/cOpU+63eJN100=
X-Received: by 2002:aa7:c70b:0:b0:6aa:f14f:5571 with SMTP id
 4fb4d7f45d1cf-6b4d5ee0692mr2495196a12.45.1793437966907; Sat, 31 Oct 2026
 02:12:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
 <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
 <CAFLszTjKMRjF7hmEt6_bbnsRpi9Q=NHidRQC8zv4ToUEpqBarA@mail.gmail.com>
 <582f30f6-7d5f-4dd5-a8c6-60d027806786@0leil.net>
 <CAFLszTj=yHHYYojiX7TGAiFZun7qWsu7zO6awfLdWwYF8HkQmg@mail.gmail.com>
 <20261027162712.GD2177077@bill-the-cat>
 <CAFLszTgng+4ERbALFKRkXRoT+q=GLJthX6B7+bvq2F0ehWNO+Q@mail.gmail.com>
 <20261030175602.GH3309461@bill-the-cat>
In-Reply-To: <20261030175602.GH3309461@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 09:12:34 +0000
X-Gm-Features: AclHuK8YM-oFrPdqqGs3f4PZakyANgpgdvRYIn7zq43t1aY2BdYyn-PKy-4bYn0
Message-ID: <CAFLszThEVtDwQykhBOKpxjttQLLxSiz4G6CHNZ3JZa=WLVbwwQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Fri, 30 Oct 2026 at 17:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 30, 2026 at 05:27:33PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 27 Oct 2026 at 16:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > [Big trim of the CC list]
> > >
> > > On Tue, Oct 27, 2026 at 09:06:00AM +0000, Simon Glass wrote:
> > > > Hi Quentin,
> > > >
> > > > On Thu, 8 Oct 2026 at 23:53, Quentin Schulz <u-boot@0leil.net> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On 8/7/26 9:46 PM, Simon Glass wrote:
> > > > > > Hi Jonas,
> > > > > >
> > > > > > On Tue, 4 Aug 2026 at 13:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > > > > >>
> > > > > >> Hi Simon,
> > > > > >>
> > > > > >> On 8/4/2026 9:19 PM, Simon Glass wrote:
> > > > > >>> Hi Jonas,
> > > > > >>>
> > > > > >>> On Tue, 4 Aug 2026 at 04:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > > > > >>>>
> > > > > >>>> This series takes the initial steps required to try and remove use of
> > > > > >>>> syscon_get_first_range() or syscon_get_regmap_by_driver_data() to get
> > > > > >>>> GRF base addresses at runtime for the Rockchip platform.
> > > > > >>>>
> > > > > >>>> The GRF base addresses are fixed and known at compile time, yet drivers
> > > > > >>>> keep trying to resolve them at runtime delaying some operations by
> > > > > >>>> several ms.
> > > > > >>>
> > > > > >>> I suppose all addresses are known at compile-time, if you have a
> > > > > >>> single device tree. I have always hoped that we might end up with a
> > > > > >>> generic U-Boot for rockchip.
> > > > > >>
> > > > > >> I do not understand how removing these unneeded syscon drivers and
> > > > > >> helpers would stop such goals or make that any harder. From my point of
> > > > > >> view, they are currently making such things harder and only adds extra
> > > > > >> code, runtime and energy waste. E.g. around 227 ms was wasted resolving
> > > > > >> fixed known base addresses for RK3399 last time I measured it, see [1].
> > > > > >>
> > > > > >> Most drivers or any SoC specific code is already identified using a
> > > > > >> compatible that is SoC specific, i.e. the RAM or CLK drivers are matched
> > > > > >> using a SoC specific compatible and seeing how all GRF variants are
> > > > > >> unique there will always need to be SoC specific code to handle the GRFs
> > > > > >> base address and reg offsets.
> > > > > >>
> > > > > >> And for drivers that are more dynamic in nature the DT typically have a
> > > > > >> phandle to the GRF syscon node anyway, so getting it from the phandle
> > > > > >> will be a better option and closer matches how Linux handles similar
> > > > > >> references.
> > > > > >>
> > > > > >> The biggest current blocker for a more generic U-Boot proper on Rockchip
> > > > > >> platform is rockchip_get_cru() and how it currently makes it impossible
> > > > > >> to support multiple SoCs in one build due to how it is used in the
> > > > > >> sysreset driver. Fortunately, I have a pending series that also cleans
> > > > > >> up the unneeded rockchip_get_cru/clk() related helpers.
> > > > > >>
> > > > > >>>
> > > > > >>> I wonder if there is another way to do this, perhaps reading the
> > > > > >>> address once and caching it?
> > > > > >>
> > > > > >> I really do not see the need for that; it would only make things more
> > > > > >> complex than it really needs to be. We should use constants where
> > > > > >> appropriate, e.g. soc specific drivers/code and use generic phandle
> > > > > >> lookups elsewhere.
> > > > > >>
> > > > > >> At least that is my end goal with this and pending follow-up series.
> > > > > >
> > > > > > Long delay while I took some time to look at this area in detail.
> > > > > >
> > > > > > Pre-relocation is an area which I sort-of glossed over with the driver
> > > > > > model implementation. There was talk about keeping the pre-relocation
> > > > > > devices around rather than recreating them. We also looked at
> > > > > > providing post-relocation devices access to the pre-relocation info.
> > > > > > Over the years we have had discussions about having 'simple' versions
> > > > > > of drivers (that don't go through driver model and perhaps don't use
> > > > > > device tree) but no one has made the effort to implement this.
> > > > > >
> > > > > > Anyway, after a few days of hacking I've come up with some
> > > > > > improvements to the existing code, at the cost of about 500 bytes of
> > > > > > size increase. It works by using slightly better algorithms for four
> > > > > > key functions - fdt_parent_offset(), __of_translate_address(),
> > > > > > ofnode_pre_reloc() and lists_bind_fdt(). The result is saving on
> > > > > > firefly-rk3399 of 230ms, about what you are getting. Note that I have
> > > > > > made no attempt to enable the relevant options in TPL/SPL (it only
> > > > > > saves another 13ms), so your work is mostly complimentary.
> > > > > >
> > > > > > The key difference is that this should help all boards, not just
> > > > > > Rockchip, plus it still uses DT for everything. Tom doesn't want me to
> > > > > > send patches at present but I did write up a post about it as a way of
> > > > > > providing the comparison. [2]
> > > > > >
> > > > >
> > > > > Please refrain from pointing contributors to patches that are
> > > > > written/assisted by AI/LLMs as those aren't currently welcome in the
> > > > > project.
> > > >
> > > > Do you have any update on the VBE series I sent? [3] It was written
> > > > before the AI era. I believe it was originally sent 18 months ago. It
> > > > is the final thing to get VBE running on a real board in mainline.
> > >
> > > Your use of AI is not the reason your patches haven't been welcome.
> >
> > OK good, that's progress and I've noticed you have been softer on
> > AI-assisted contribution on the list recently.
>
> I mean, I'm not blind to the various contributors that aren't disclosing
> that they're using LLMs. I'm also frankly unhappy with one group that's
> both doing it and needs to fix their internal process to review stuff a
> whole lot harder before posting it. That doesn't change the fact that
> older former-frontier models produced a lot more garbage than useful
> stuff (and so older stuff is best thrown out and started over). Nor does
> it change that todays frontier models make garbage without careful
> guidance. And checking my own notes, I'm personally at 6 days since the
> last Big Name AI just made up a number in translation, so I don't trust
> them to not make mistakes when taking a data sheet and using it.
>
> So yes, people are fixing real bugs, and other people are willing to
> review it. People are also submitting poor quality work. We're also
> getting some stuff that's Fine (but also didn't require complex AI to
> make to start with).
>
> We rely on the linux kernel, and device tree compiler, so No AI was
> never a possibility. And if you have to set aside ethical and moral
> questions before using a tech, that's not really a great argument for
> using something.

I agree with your first paragraph. I wouldn't want to go back to older
models - I still remember when it would write code that didn't even
compile. Even now it certainly makes mistakes and the more complex
things are (and the less the human actually understands them) the more
pernicious those mistakes become. But Rome wasn't built in a day.

I think reasonable people can disagree on the ethical / moral side. I
consider that a software engineer uses a lot of 'natural resources'
just being alive during the workday, so machines that can offload some
of that and make SWEs more productive are likely a net win even for an
environmentalist. Power bills might be another matter...

Strange to say, at this point I might prefer that a new contributor
run his patch through a decent/recent LLM before sending it.

- Simon
