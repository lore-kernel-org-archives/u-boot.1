Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA3BCA6004
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 21:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C11534047E;
	Wed,  7 Oct 2026 21:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgx_Vu4BJlku; Wed,  7 Oct 2026 21:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 056D24043C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791408185;
	b=HMD/P0PAj8uzHBU1AjDGrgFDshgvMepvjrlW9y7/l406Jav6sJFDjcNJw9qefSvs05Yy
	 IpHoG8iwoFM4DQrwVRVGK9JHseCxf9wB5Vvfhdk7Db8u3E2CXQeN571qwTbzlJn7fW//L
	 kRt2lCDmZLksWUA3udVH0cqmYzz/KgEqxSR4gS3JvMKfTLLix2/e2WZaAcTmFzfWaj688
	 xkheI4oQx2xkGWBLmEdV3e0eXZNX8TcAE6KtasIOAGKncdBtda0RARtJYmCJc6AcSeeje
	 A170TuBx591rf8qOr+SNP1tURgohUv/kFATIciz4Kryscu592fvdLgITvJFuNvQ4+Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791408185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7SKuZ6KtffXecUvWpdfHAATo/0b7PsKnDIzbdKiBNwc=;
	b=smT/vHeQJi7a2qAjRB4Ho4Ny/kdmWlN0w3LR8ezt8q3tL8ltL1OBJWa0gQ1ns9sZtH35
	 0w9XYqux/GdEwr6AOkDvw06SQ+TrrO3Ttgq6UhMi6cKytmACAUn1UdOyr3BLv8tqR8GjU
	 C1ZXmTJTWsqWzhptBWhBrFlAjxcT4adFEHLb3ZrKKfqb2vSS5n6fN35Jh1PooMLSE5yPx
	 DhUPHt9XnBM1Kr6wunbX+T36UjvpSf0fIk3thqp5ed3POkowZyZiq0jSlgfG5R3sJzhiy
	 KiBMLcq5MPt9jkp3hoG+d0JQdj/zw1f6VevQg4wsbMK4iQ502C/jK4A+OhslHFr6wCA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791408185;
	bh=7SKuZ6KtffXecUvWpdfHAATo/0b7PsKnDIzbdKiBNwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bijyVmfhZgAuzP8aQo1D0tbSvKXrNVRr20cn800I9fQDrfuR93PklDbB/f7NHd0iw
	 BrYcVammiT0k8lZjJS0ohoibRsgD47q5im/49KYUfrJoE7YQNo+zY1cEDUg6MbPd9h
	 iaSS+6AKCqZa5mTyHObyaO07KKjwlAnRKLfSvbL9TUG9CHFOHOyAdk/ZEUAbUYi3zU
	 0S75vuS2nGsTIc8/ioZC1xcPwIOeBG0O7wXrEEFbhDVyh5IN5f4hB9BxKaiiD5IZVX
	 YaonWe9ajwNj7W+1elU87wUHb2IWkFpNgn1Xn8SrQKpiQ6YQ9gn8ZQjrisEacYFvTV
	 4/R8RpaFsBnLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 056D24043C;
	Wed,  7 Oct 2026 21:23:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE19E338
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4052400AC
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rHIyQLHct1un for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 20:13:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 385024004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791404019;
 b=ln6q8qRwYKh6+G0CJYypPCgBg2ShlrKYqQClbPr3TI/jJFicDrYOhYO/9yi1GJHc8NEs
 TyCcntULfaPgddzWg2rZ+dGgBRmGuC+wlWf6KvpB70FkRjGqW1Vzy8MVcXO3RuWO5tN6Y
 9wLS5UTtPFLLs8MNoXdHURFh/ofNbFDFuG5av+xbSDfssfh/BrD4h5fOucWS64SKmGOED
 Jt4sToDOfLb1/WoiX9bSHalRRULP0+XclLEr6p3BBqgBNSnPIU+8QY0rtlu4Cj/N0LKpB
 o8prgoY3FE2M3+JfBIPjhsuvbhEo7mhryX2nGirXieqj9PnuSkoz9LpFa8lGcI5y4Lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791404019;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=7SKuZ6KtffXecUvWpdfHAATo/0b7PsKnDIzbdKiBNwc=;
 b=azAdB5k5vrM6mHyDgktIGG8OlwjjT4wKc7OtERn+UZxnKCxZTImsVyLKR+jInkkjIE9Z
 GHJijkdKMiPRxaXdTz7ff8t2bd1KGFwzEElGr+onBxptlfnR+uyx1SATfuwEMbpGYg6ZL
 o9DANdmSmomNmye3PHs+Jh0WHVYfYzIE62iFzBsty2/xYTD4kKVyreJOj3fbwZfL13KLQ
 Xb/xxteWx/CYKe6GBRTxNqbKxANFiBeMuRd3oL2QCII3aucAyJdp2g0nNkp1l25WOSi6j
 IjWcMq2MmrEbY2Rv1SBoF/p/A2kS8IDxXYu6FKMp35DieOjo6gYDGde1yL8FVMkRxDQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jAFY99W7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jAFY99W7
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 385024004A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:13:38 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3a4a7eb86a4so1708835a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791404018; x=1792008818;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7SKuZ6KtffXecUvWpdfHAATo/0b7PsKnDIzbdKiBNwc=;
 b=jAFY99W75NEFnrHtj0drm14UgEXXHxBNXuyVaHrE7TUKbDz3NMpflp9id46dcm2yDM
 YLIyBm+p9xmc2kR8FZCDhbgziYsC4jPM6GKNAGtG71YK/+btIOq4Aad9mCip+bQTZCFa
 tuOKAAZFO8RXswkGGkMSVKRrpONPWeUewulwlFtW60B+xUJf/rOO1ckxhZ662vDi2rMy
 fsqdAJhERLDkXmt5Sxd3iBJ3HlwWXEBn9LK0hML2/wXRgjsApwZzQOiijk9H1bwHco8s
 wjbsaIBp7cJnqNpbAZqJUATQj/Mn+Yga0Q0W7TdhdizjfNLLnhw2i0UkGL9HVDEUUXAl
 VnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791404018; x=1792008818;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7SKuZ6KtffXecUvWpdfHAATo/0b7PsKnDIzbdKiBNwc=;
 b=wLmn1owQYnxbn/gCbxFlSraiXEZS8ModLYK5TYtCIBVmWBaHnTmCZvM4GjTz21VTgs
 LXvIwAnkcNaLMmY+7FYcXRezMjy2SUCRVK2Ho1/++GrItscf+LVIpeJvGKG/SbB3vdl/
 elzNpzjRZMlHryH9HVcu4GzgZgTPKM4iGFZ3cSO0AeCpA+IbmRYd+LgbxQbGZXIAooAE
 HP5VGNmsVbQ2JEL9eyu5eeqkGvm+DCSllnlVAIBt4qTHzrNlr2MScJb7MqA1lA8Vulsi
 PBjXoeQzcFfucq6tVaiIXvDq2Hfo+XWl0LUyuCqoqXWHnyovoHtZ02kQlr2D2VX8ZGY7
 OHiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7HUqInAYVrfwH7Uuq+69tuPNb5uh0jRLg2cRCPHfK5bJwdzDm8u0qusZhwBTRhZX53duQPPg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKrmkthv4/in43BvxvBaMArY4a5ANP24ESvjJlHjgLJ7FPe5/LZ
 ghY4CyLAp/eH0N7mtpfH1njPqa5KzjTr7KcUj7L5E2urRdD9x7ozV/tDQJcOdA==
X-Gm-Gg: AYBFou0XXUwtZbhyoAm9Gd0ntljXIVp8HqUQ8PyfH0mSAFTfrOYxgDDOdzE2Gh2JU9D
 reNadATBnxrPrk/iy89hIW1VIFlUHLjlngK/L0RA3pAx4DyEGRL7ylSWhMCgtgeDREWBvMcc+6S
 yNv33jZtnRhbQKH6yRBYSintI/i4FSMl1RQYsT1X4x2z9pJt03UkKhb2QIljDwJJeR9vA64bZTV
 iT+EQKoGRl4L7eF5cXZhkdfYmVSun1hXRR88OgrK66raeI0uPAhcs9kSm0Q0b35zStjMLnVnHyc
 zoTQsntoHrEzNNvp6gDsskWJ7oy5y0SBWME9LB61Oy5Vymfsg7yoSBWZejBy3O3P3/gfigt8Efq
 CbnQBTvaBGW8Hw6q+bsqD5n3/K2Lv1X7kNl9TMYiSKxh7qQ+GFSymG2+sUlaTPxEMSmTs7UmG+5
 vUUBk9INnuaim99RpC7TPpl6VVIghsK4mM698rA8ZTT7ybmOaDi1vkBXTnt+0l/WSqBCR4gl0Mb
 ByOC89VoQ==
X-Received: by 2002:a17:90b:52d0:b0:3a0:c0f0:9a97 with SMTP id
 98e67ed59e1d1-3a8a04db3a8mr2720995a91.9.1791404017950; 
 Wed, 07 Oct 2026 13:13:37 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9f1a7e9e4sm1013109a91.7.2026.10.07.13.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:13:37 -0700 (PDT)
Date: Thu, 8 Oct 2026 04:13:33 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, sjg@chromium.org,
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/6] fs: Add 9P filesystem support over virtio
Message-ID: <asan7VeJ7QoRDWKq@google.com>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
 <179139852309.3398671.7231524378185570223.b4-ty@konsulko.com>
 <20261007195951.GE3079290@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007195951.GE3079290@bill-the-cat>
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

Hi Tom,

On Wed, Oct 07, 2026 at 01:59:51PM -0600, Tom Rini wrote:
> On Wed, Oct 07, 2026 at 12:42:03PM -0600, Tom Rini wrote:
> > On Wed, 23 Sep 2026 21:29:56 +0000, Kuan-Wei Chiu wrote:
> > 
> > > Add 9P network filesystem support to U-Boot.
> > > 
> > > It allows U-Boot to directly mount host directories in virtualization
> > > environments via virtio. This is useful for loading kernel and
> > > initramfs images directly from the host into the VM during development
> > > and testing without having to rebuild disk images or set up a TFTP
> > > server.
> > > 
> > > [...]
> > 
> > Applied to u-boot/main, thanks!
> > 
> > [1/6] net: 9p: Add 9P2000.L protocol support
> >       commit: 48bb83195682d189273bdba813fa67f7f2760d59
> > [2/6] fs: 9p: Add 9P filesystem support
> >       commit: 9e14f904f8f12cd9df07e99a679453c8782e523b
> > [3/6] virtio: 9p: Add 9P transport driver
> >       commit: 09e668e32b4c14ce5c929d6cebfac75d2aefb90d
> > [4/6] doc: 9p: Add 9P filesystem documentation
> >       commit: 7d963df1bc38f5ae070ea8b96e03afc1ef7e23ed
> > [5/6] test: 9p: Add test for 9P filesystem
> >       commit: d446ef40b87d53ef7ac59ac9b1d79a16f0a065b0
> > [6/6] MAINTAINERS: Add entry for 9PFS
> >       commit: f6002d5e8018714ca80dcf1835c230c99c5090b3
> 
> Are there special permissions required for 9p to run? This works in
> Gitlab, but in Azure:
> test/py/tests/test_9p.py:46: in test_fs_9p
>     assert test_file_name in output
> E   assert '9p_test_small.txt' in "9P Error: No matching 9P transport device found for '-'"
> 
That's weird.  In theory, no special permissions should be required.
That error messag indicates that u-boot didn't detect any 9p transport
device. I'll take a look at it.

Regards,
Kuan-Wei

