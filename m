Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D45FCA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 16:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90BA3606CF;
	Sat,  3 Oct 2026 16:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7A6I4wKliveg; Sat,  3 Oct 2026 16:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 987B86069C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791046667;
	b=W8pGShQHBQAU6IRSu5OFfKDWmnxoLxhruPrvprt1y83AtdpjIAuvNReTynrpP/xRHDSt
	 lCXbUGs5Y3hY/DwiVrXQgAPvitPGSL+bU9Ck0Mc95rzLYA8wsIekI7/R32nhBqZpOkhii
	 aprmTL81c+DJisdqa9KxKIIQxNpQFQ3dx9215c2yYPjPyKjWYH6BhxGYImXYf+CW8KxWs
	 EC8Ps9btFLLiTdv+fhKsR6Yk/+v77eI5ES5RW/czzHX3xqgOhTZsZDhT9JrNS+m3KTFsC
	 GrcytrGx2RvBvwo0sDqsQ+6nfgIv2vAEUTojgxBowDOSizI9fBUQft79sKsNepvUGdQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791046667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aoaUAa6vx2aUmldjRkyM2VgfIf2lLgfyp4fc2/xsgNA=;
	b=R1Oz7ukiTtyf71i03u4ODOy9TgIegZCKDRrMk7l9g7y2gKMqUV57BJGzCwXvGi2vE10j
	 jpQsGLDC/ZzLeV2WavT3S0wXnuqLYIOb1CrPeKigaENZ2X6KhNJeqVgHA3xCLzp05sCG1
	 W22ZfD3zsVgTWiJKlrp2CZK62vxiUzR/xd9p0RPGOixPr2/BIW6a1GZaEOnPuqBVXSIPJ
	 /FczDe10txkET/yzxDmZAXVV/DxC3H01GVlfmEZfhKt5mPCfXzTnc6IophcE4aREZTUyb
	 vYLYH7EnrGFwUVFItIfrTLOW8eoHNa6RXHDv2XVgWR5vidUVCdGaG5V5XR/tTFsVN6A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791046667;
	bh=aoaUAa6vx2aUmldjRkyM2VgfIf2lLgfyp4fc2/xsgNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iiKk+umB9rn2P8BT4LS2QVO8heuHZzV2OTde4s6Ves5xrdodLfY+z46A1o3CsbO5O
	 TWrkzAJeohq3czLHPsZDJf8jQyOS1X2O9kzJLtCfX4PTvGVB69szRw6XikEjKssAkW
	 zUst5Kn8V3kXANQEhkKm3umQxXIeqiqKFvnSTkser7O4cgSXYnr4c9kz0EQgUPiyNn
	 VebhEp4iLTjy5seVtFz6jn60l8CPJm75qIYvutSqbM81rbf05sq0sEf5eG0hLQoX0j
	 iPRW6M1ef/QLqAIQR9QksbAbmBGyMXsWfojivfOH/rKEUKxbYuQiL7ZqxaYQkq7lHO
	 tYLm1lyd/eUrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 987B86069C;
	Sat,  3 Oct 2026 16:57:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 190C2435
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 16:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A74640ED6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 16:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3pZwSaXXkmjs for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 16:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B5C9B40ED3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791046665;
 b=egcK+h08lVt3ouREuaFb1RC/z6vzoYI7d0zGiRhx0hCNkHJpd5DskN6mOrBZpzvxiJBa
 yx8GqHzdwLOBkNGZ94GPWANiBFixt5NtNOihkQgIDT1hkhUXzEG/li8iyDcivtoLFyL9F
 Q1guoVl2GfAm3ZRM7x/ztncgn9/skQTp6ue57EwgphEgG33nCvsO/RCDa7Nf9UsxNLTV0
 vAB374nDStVk69mxGs0oqzyDU8uSzUNwghm4huJRPILqaOhf7hn0nc/PFrwfCdgXt22RR
 ZhrApiBfulDjGVppeZY8pBxxwDE03StQd9AscDJSDDPXiuwYlYlypXMAUm+cLagz18Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791046665;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=aoaUAa6vx2aUmldjRkyM2VgfIf2lLgfyp4fc2/xsgNA=;
 b=Xo0eiKOKb3lqTv0FBnx932pLyJn5Li1IGmLKxf7E6kso12LXKOwmsGKUwNI87dRe245H
 aFrCjzbhf12m/dbNyEZ9SPQdQ3cwh1sGRhONx5Ye6dOEOV+NmxFxEdEbAs6rHBzDi++9X
 7FIAUW9KDcANmGgEJO1imW6CvOmeqyclZFp8NupKq/X2Qbe3VwN+nI2yanK3z+wtMW+jN
 4dyW+62vY2986cbjTpaFgCdgd05UdakaYcjuzeyJubODJjjGXRJjNL31luYrqRfdy69rF
 geWqnQ0KP6d2ou+vVUfAVzSu/DkXzOzVktHe6bE/XmkuPRBUvIkiQh7Bedss+kfl+Yw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iwISCSzP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iwISCSzP
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5C9B40ED3
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 16:57:42 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c29c6a3930bso83453166b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 09:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791046660; cv=none;
 d=google.com; s=arc-20260327;
 b=pq1A6AMTKvkruISpzCTwaUN/hwaDwE35zJCHgF8k0+9uTA16KfRzSZTDEX3QjHXWaY
 V9fwUBxHMPLl2ss/GCfZOjghaSaFnwF7y8U4KC+NL6gcm9CBAmeBe2QwbjouNtvn+seO
 9pbbGw8u1n0c+DMGMdWC96Q00J4tUFGo49wpOi2e7r2zjTOYoxZhFuz5DNQ9eNSht8Sz
 rTkLkNH6XmoIxQd5KodLFE6KtIcODOIaisLhXOXtNzqKuP2aPKLg+r4M5uwgRpS+/iGE
 wgEg1UIX6AX51Ef5mwhKAYJkQXsCo8j1TrnXB8HzMJOEED1PMlkLLMcIHMrBjQvTj2wn
 lYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aoaUAa6vx2aUmldjRkyM2VgfIf2lLgfyp4fc2/xsgNA=;
 fh=oIMmC8iu+RpL9QS0aPIrVHvb7dY/DmDKYgM4/PZle3M=;
 b=QTmnQBvPpolhmPSooLF/4TjjnU1LOXq1/4C0DByLuDzUc68XSbNhDO47vccHt3WQZQ
 Le5xsZUNZumhoOQqJ4uBaOm0j5ULLhLTSp6UrooaMYwhh/EFapGTE3VgD20btfYoImoX
 ZWVSZ5xRU17B3flnD67LV2M80i7aBeYh+IzVzIJIG0PIKXZx68CZJ886wf/6HUdxRt/S
 DwY08suzblJVkZJELNPsZqhpE8DccQa0Sxy8W0OfRbABFT6kTVWu/0CoQcU9xJ3l18Qd
 RYtOs+hMSgmHDvU8GUdRGoHhRyBJHWB7L3TtgeTrDuTvZeytt9mO467CMJSlEJzSAEKI
 Y1mQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791046660; x=1791651460;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aoaUAa6vx2aUmldjRkyM2VgfIf2lLgfyp4fc2/xsgNA=;
 b=iwISCSzPybISX8ZbzBGRvPV+Rf9kk9R4IulscDhoZTDgCuZCI3L0aiZi0rtkU83CBa
 8Ua+1l6M1xb8cYJF86RjKB9ZgewMz9z7gPKXzhLKxqjXGlbKuV9e8O836+J0mz9YPj+v
 tFpbm73aw6TQx14ZoygIFVatribSCauXu518bjQU8G7qKPnA+XEYJOG4gUHWvEI3b0J1
 7/fy29dp/QjSsJXw4KzvLirx0Lm1SRjqD7SAlOqPxcYjSHnUbqgBe6W9gS3+DGAcNfRn
 rP0bX9mOOKCLHcQNGbuanHcWljUJbs6Q+O1CUtpSzhZd1K6OYVwcCp0sFKczHRoRWuh9
 GUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791046660; x=1791651460;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aoaUAa6vx2aUmldjRkyM2VgfIf2lLgfyp4fc2/xsgNA=;
 b=y/YV3Fn0+op9I+7lmv5bM9v1nAWrhIM0nvh5i6+DtTrE8h521z6PyQ/yGETD00Xcwx
 XNZTNWdW2mRP0Z3SctCl1cHscyWmbnh4wqzharF8SUeIzO77hSHQ3/JTmUyNS1JU3ryP
 qRGbfNqoR1in7Sj2X505poFPdM9IB3naUTyXLOqafF27WR1tN+4Bnd12rvCgU1OhkLQu
 K5bQ9dZcboq2djgy3qgxWdniajwq+BdXJwzv9gTFsZsR09ohQRE0H4AefSJfTs8WolJn
 1nGLtY1sm5UhE09G4Hkv4nrnpZzmmJkNl5qlafgVI/YsXe0yoLTqrZugf4Te5N7IGG2b
 4YZQ==
X-Gm-Message-State: AFuF++mR8Bd+u07BezNG0xsAl5tUwGmAMrOxn4/z9Gv5JLABViEy29T8
 dCOssFOgo1/14wgqYXew6b+YcdhDxtzbqdfSITc833NeediaevRxwIUqVGImuvi0l5vKXT0qTuD
 guA+w6BZJiGI/P6svXYRQHMyijy0Itho=
X-Gm-Gg: AYBFou3MqdFNH5pktYCJ0Q/Z2I1jq1ZuItIz2LDQJJ7FevMpMAjX/rLqNmIzUz3ziBo
 30KthBE1IynLCJc7NzfI6YMZpScgNe/T2GIaYoQSnRNXmnOej1czvydSPn8V03ZFiU7zmhJqqVv
 mAPN+gVkG/Y6cjC3i1KykRjcNbko76jaf9sCMDKTyQoc1YvEsSDfkX1RxR+Cl7jyr2lZba7uPS6
 fRYPRV2zwrUFieZwSgn9tTRzeY5qFaJ2B/vj7sX2lia2Rbgb0x3s3bBMMSEhd9YrjrSQZ0DZgz3
 umIKtuzmziv93RCTIp/aIKH86pZEwtsasPA7uZTwac6w1EhXqLeA8Uo=
X-Received: by 2002:a17:907:9714:b0:c2d:c060:172 with SMTP id
 a640c23a62f3a-c2e6eddc350mr214853666b.10.1791046660200; Sat, 03 Oct 2026
 09:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-qconfigdoc-v1-1-9dac84b3ef75@gmail.com>
 <CAFLszThXUz-ijZDgnP_fSKT_wfiifVi8Nw6Urp=6Ewq_OJdf5g@mail.gmail.com>
In-Reply-To: <CAFLszThXUz-ijZDgnP_fSKT_wfiifVi8Nw6Urp=6Ewq_OJdf5g@mail.gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 3 Oct 2026 18:57:29 +0200
X-Gm-Features: AclHuK9Xjzp87wE00i-UvQFrKA8qQ_ILFLCHUvO8NTBveX8nGKjdivYtiOvDO_U
Message-ID: <CAC928HY7MBd4jNTaqw-C6tq==VOb9njcvKT_4=h-iOCha+Z7LQ@mail.gmail.com>
Subject: Re: [PATCH] qconfig: Improve the documentation
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

Il giorno sab 3 ott 2026 alle ore 16:12 Simon Glass ha scritto:
>
> Hi Massimo,
>
> On 2026-10-03T09:09:36, Massimo Pegorer <massimo.pegorer+oss@gmail.com> wrote:
> > qconfig: Improve the documentation
> >
> > Specify where the database is created and under what name. Add text
> > value lookup examples, including quoting, escaping and regular
> > expression cases. Trivial fixes.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> >
> > doc/develop/qconfig.rst | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
>
> > diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
> > @@ -26,9 +26,10 @@ How does it work?
> > +in include/autoconf.mk.  The tool must be run at the top of source directory
> > +where it stores the database file named qconfig.db.
>
> Please can you reword this to '...at the top of the source directory,
> where it stores the database in a file called qconfig.db'. The article
> and comma are missing. Also, check_top_directory() runs for every
> operation, not just -b, so this might fit better in its own short
> paragraph than in the text about building the database.

Sure, I'll try to follow your hints. Anyway I would prefer to keep named
instead of called, as it would sound too "volatile" to me.

>
> > diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
> > @@ -95,10 +96,23 @@ boards with an empty string for `CONFIG_DEFAULT_FDT_FILE`::
> > +Text values can be looked for too, including regular expressions, but taking
> > +care of needed quoting and escaping. E.g.::
> > +
> > +    ./tools/qconfig.py -f TPL_LDSCRIPT='"arch/arm/cpu/u-boot-spl.lds"'
> > +    0 matches
>
> The examples are useful, but nothing tells the reader why the first
> one finds nothing. Please can you explain the rules they depend on:
>
> 1. The value is a Python regular expression and must match the whole
> value, since defconfig_matches() uses fullmatch().
> 2. String values are stored with their double quotes, so the quotes
> must be part of the pattern.
> 3. The stored value is the one from the Kconfig file, before
> expansion. Here that is arch/$(ARCH)/cpu/u-boot-spl.lds, which is why
> the literal arch/arm gives 0 matches.
> 4. Single quotes are needed so the shell passes the double quotes and
> backslashes through unchanged.

I've got what you mean and I will add these info to help clarify. BTW the first
one founds nothing because no configuration uses - verbatim - that value for
TPL_LDSCRIPT, of course. Anyway, the comparison with the two others help to
catch the fact that expansion must not be considered.

>
> Also, the text above uses 'For example' rather than 'E.g.', so it
> would be good to match that. I would also say 'searched for' rather
> than 'looked for'.
>
> Since you are doing trivial fixes anyway, the earlier SCSI example
> shows names with the _defconfig suffix, but do_find_config() strips
> it. You could fix that output in this patch too.

I've tried to update the output also of the other examples of this section,
but unfortunately now SCSI ~BLK returns 0 matches, therefore I changed
the example in v2: see if it is ok, or if you prefer something else.

Thanks for the tool and the review!

Regards,
Massimo

>
> Regards,
> Simon
