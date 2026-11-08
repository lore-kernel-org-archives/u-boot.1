Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F0606A31A
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 05:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NSjJW7HB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NpF2LX05
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E9A6405F6;
	Sun,  8 Nov 2026 05:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AT_TXs9SvwxP; Sun,  8 Nov 2026 05:40:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68D3840602
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794116413;
	b=g9s1rJxOKmK757nKzjRJSZrBroItC9lJyiLny5MLe7w6A+fBGRbaoT0M8nHx6bJ6g87G
	 6ajoDvyHjP+k2tp30KEC8V4xTJsLYmr6xOCDQ38sofzHl9xPnEIeeM2HLsBVkNKFH5gjJ
	 lJLlClxrGhPLIUokUtyaXW7B3tbwsN6ZutRQd4NHftPLVfVJt5yinFszPiuKw35GQUE3r
	 uj851J2ZmYvgjPi4+oNSLJfvgEbbvy8mfCws1ovtf9JcJJN5uwCE8DBZsM3sRXo1JokcD
	 qw5gKNxSX9yxKBg0Qht9/Wm/SXRix/UhmL9fkQ7fSrJjfp6aSlKRLOYR7Y56N4NdcZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794116413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8gNiHW16YUCUtpX7SI0LM59pzKL6piOEpyC5SbaqM3g=;
	b=tLwXXbTpWjVH/7eREXZNwOFsqDt1/yOEIqnoG5XTxt2ZaMhbDbyvlr9l5GPbDNoI1YI3
	 TJIigF0N8f8FY9I5mO4EWodvyEr2LRwfdkoL4rRa6o4muSNSziO7XlbXm8cS0wtWhf6WA
	 QA7xR+tFWbwuzRG51hZWiOuaTbY70OCyq/quHo4jtvbOZc3dr9khsssAFv9MaKRobspJW
	 y87Px3LHmKpnNRqulXDxLT0IIOXGB7OfEGoiTmGfXnQAgyqUgIxGcG7OGAwXDaORlVo/7
	 rZ0OVNiSpEV6uLW31psakXUILGssDFFQelpWQfM7EJdetP1XiLwlhp6MwJqThiy2PnQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794116413;
	bh=8gNiHW16YUCUtpX7SI0LM59pzKL6piOEpyC5SbaqM3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSjJW7HBBWxdOKR0x59CLJf3ApQBPe6qB0V5JWjUCjJ2sc57rh+XT1Bq5ShGUtpbk
	 OJbgTW0MIYrTk5vVgE5VU5rJrSXndJ9t2+JsylrLrOfj+hWtZ8cIIV2cZZUISNOYey
	 bpcOwGN9E7TRr7KHaqvR5cIUWESjc4RIGm/eqsQ9n0bvZXdbFUNWGePy63gwuEdRXv
	 YTYN9PSlYBAwoC9OR0vaAR85i9QasVNWSx2sVtLvjtrLnjq94SqIvuYD3e8LqLfwq6
	 tcjeklkKPJbV5yfZtFcSfQZ7C1QHudhaRJRiriUD7HXz0YLiBMYAQE3GyMO5pdRU3m
	 Xt5nFF0Q9wTAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68D3840602;
	Sun,  8 Nov 2026 05:40:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FEE137D
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 05:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5091E60628
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 05:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UMfKgms1PHqZ for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 05:40:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 502C36061D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::132e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=NpF2LX05
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com
 [IPv6:2607:f8b0:4864:20::132e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 502C36061D
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 05:40:10 +0000 (UTC)
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-36fb88ea38cso1103741eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 21:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794116410; x=1794721210;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8gNiHW16YUCUtpX7SI0LM59pzKL6piOEpyC5SbaqM3g=;
 b=NpF2LX05U0zosf9dExBf3Awm48aQ+7H29RVzYkmBmGpQQFcQyBEa0vQxztcJFp0G8S
 akrx5xysw7wzih2Ma7XRF6ki1XlGVqM50fpt89xGGfC+sNJKRgY0Q+yYNZ6uyeeP8DCL
 iBSgy4eYVJZY4R3Tjd+IJA+9TlGfhPEvohcKS9qLM9jDQpiXhfpf54w6nXEj07TvFNkC
 mu3Bhvgzk8dSQRwFwcuAqUpJ3Rruc582NRY5uvXRMYN9+iESQf5bCVzchRSKB/IXqIjb
 uZRosTWWmF6W7dplm4hQrPp3vCzWQ41tKvOmzWaGVORBoU0umUmRZ2QQUssr9kdEXD0Q
 7KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794116410; x=1794721210;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8gNiHW16YUCUtpX7SI0LM59pzKL6piOEpyC5SbaqM3g=;
 b=rwn3WmtQANVYc+MdE7kOF9wsmOUIvmGXlEu1iMNv+9/J0oF4yJvQ2yvQdy/MKDwFPl
 WRpH27g7IB4+EDmhBb4Ppns1gg+VCt+XY123XHR7MAGCbnmL3dbw2b7EnDXwFgYvjCRF
 vyKp7hKgRpbRVfs1EbxheN4XZ4mIOKwMDSPQnwERgUv3UQOVRLCri6AMGFctib0nspcb
 SFWfrDAZ+isuWPT54Zro9m85eS7pS73kI/y/VVZ/NTnOPRRsRj5ty4jTkGS1LBDBoZkR
 Am1sxwrTaBzn28Zx9vU893nNFjBPjiXBQmk0JZKFOvciinOMBQP5XwFt4Yeff/5HmW5Y
 2Dhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYPv8/yOuPxYUnIfdfxskhnBGZWF+R2g2FU5rLVtoj5sWJm0nP2DAHdUgEGjEXuQ0gFT5N4NY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+0oZ4i7pms2NafiUqye6jIAtzDyXyoGp/gJoEPU2wYEoilcqJf
 h06fE6VOFDXHU/u+2S50uHDZH7oMBzCpyARQgnhlGZELOhasovpe0K1And3A4RW+FX6JF0S6rMn
 1UVSthar+ZZEkvV8hm/oOJJiGZIj96g==
X-Gm-Gg: AYBFou2xcpRa4XrVQq61rj3WmzfLk7OW1MtlFuO5jS4PzeX2+jxYjno+T4Xinoa+BvF
 FGCGEPzR3g0AWbGpx2dQ09OiWPpwXNlCoSCXFzVPzJIB6wK9JkFhXxxpLs38wpOu4oF3BuVCpBv
 QrJv/MMFlGrOxXL+Z1DBRY/KMCTfS9DEi0nbCVpnOiUudTmgOXoXB7rW1sD+tNplBMWj6a770+z
 fhrZM5NfcMnklIxC0Y45M7eFmOdy0bQ94jnqzYS+SyvfzpJcKXx9jp9Fj+LCzwGLoogujDQG+sU
 eFYJAzETtnQIhFnnJej3wn44bUlJim80FT9AK/Rl1BDgkMMF3Lo/BXR/tIeFiPUQU2EDqGv/PZG
 jL3naUyrhQjQYkyMc96cnzj1wy3STYzhuptUkYPlwS+l3HxmHg6jMUHS+0/QjM1nbiRrz
X-Received: by 2002:a05:701b:2802:b0:151:7831:e403 with SMTP id
 a92af1059eb24-1b39feae484mr880907c88.13.1794116409609; Sat, 07 Nov 2026
 21:40:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
 <20261106194621.510146-3-oss.patchbox@gmail.com>
 <CABdDSeVYBMhFXb0gL6LeSysr56is2e4+jhkeVdimwZNgy9Y4Pg@mail.gmail.com>
 <CABdDSeW77pQ46JB09Uzrf+tDfMfxJWx6pCNj2tMdjB5WbH4tfg@mail.gmail.com>
 <CAGG=RgDJEwOTy=m1xb+BhBD7mHs=yuLPwQWFE8frfmxL8EJUsQ@mail.gmail.com>
In-Reply-To: <CAGG=RgDJEwOTy=m1xb+BhBD7mHs=yuLPwQWFE8frfmxL8EJUsQ@mail.gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Sun, 8 Nov 2026 00:39:46 -0500
X-Gm-Features: AclHuK_7ntprtBhce7zFQJG4AtwJcOxnlqehazoJZFgPsz6VKCjVnZa2nAMvi6Q
Message-ID: <CABdDSeU3hJSUD9rNq0G7882KLxqrB86AbHtLiTdyGjYrdxUh3A@mail.gmail.com>
Subject: Re: [PATCH 2/6] usb: musb-new: sc5xx: Free the controller if the host
 probe fails
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yuho,

On Sat, Nov 7, 2026 at 10:21=E2=80=AFPM Yuho Choi <oss.patchbox@gmail.com> =
wrote:
>
> On Sat, Nov 7, 2026 at 6:18 PM Greg Malysa <malysagreg@gmail.com> wrote:
> >
> > Is freeing mdata->host the appropriate cleanup action?
> > musb_init_controller registers the pointed-to struct with the pm
> > subsystem, potentially allocates a dma controller to store in ->c, and
> > does many other things I haven't traced through yet. I would need to
> > review in more detail but it seems a more appropriate action would be
> > to use musb_free() which is currently a static function inside
> > musb_core.c.
>
> Thanks for the review. I agree that musb_free() is the better
> choice.
>
> On Sat, Nov 7, 2026 at 6:46 PM Greg Malysa <malysagreg@gmail.com> wrote:
> >
> > I think I was off here (sorry I didn't write this driver initially and
> > musb is a bit of a labyrinth), so it probably actually calls
> > sc5xx_musb_enable through the sc5xx_musb_ops struct, but that function
> > also cannot fail and always returns zero, so musb_start() will not
> > fail either way.
>
> Agreed, musb_start() cannot fail on sc5xx. However,
> musb_lowlevel_init() has a third failure path. After musb_start()
> succeeds, it waits up to one second for MUSB_DEVCTL_HM to be set.
> If the bit is not set by then, it calls musb_stop() and returns
> -ENODEV.

Sorry I missed that third one when looking at it earlier. I agree we
should get a fix in place to avoid leaking when this happens. Let's
see what Marek says about the best way to deallocate the resources
from outside of musb_core. It looks like there is a lot of Linux code
that is removed by #ifndef __UBOOT__ blocks so I want to hear from
someone more familiar about whether it is reasonable to just expose
musb_free() and call it in this case, or if we need to migrate more of
the logic from the Linux code for musb_remove() such as
musb_shutdown(), which is also not included in the uboot build for
now.

Also it seems the pm_runtime_* functions I was worried about earlier
expand to empty macros per include/linux/compat.h so there may be less
to do than I had thought.

>
> The leak is small so I am fine with dropping this patch if this is not
> needed.

No, the third condition you identified is worth handling and fixing.

>
> Thanks,
> Yuho

Thanks,
Greg
