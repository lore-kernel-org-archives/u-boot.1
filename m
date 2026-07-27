Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E98C5321C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D34480C23;
	Mon, 27 Jul 2026 12:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PweaXEIsieqo; Mon, 27 Jul 2026 12:13:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45B2A80DC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785154394;
	bh=cBsz6dFc1n1BJ3+nwbM4Az60KciVqSDyxBpvKDLD3fM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yKt+ejcaJ81TkU3nNULm3Brw4TsNVu+ZkozsQvZrm7u+T40smzjRntm8cpjsjUrUN
	 8oTevcoAczJOpiCUqJlVly36/1pAM1EJX2HLkTIo1Py+ROluZ0XoMHwuBNVN3l6hra
	 ZSwOg3KdvN05qM6QsQ0Ml4TiAfY1RTcZR1qbe+h8vfRB70AXbji08J8UURNHJUItJA
	 cH1DxRC+F9D2Idh5FhIgOURGd/Kq+COkeMDff7nZRM4RqVePhWIK+Hxw9q/LF6HLOy
	 X0yE3B6948LL4ayF3vcGxXHyBbj2uDlBDjVaywG8Tt+FsPZ3SzLhGZBlvdauCxHuR9
	 Opk6he/jWIJPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45B2A80DC4;
	Mon, 27 Jul 2026 12:13:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A3F804C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 957B040077
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NAwS41MvjYPs for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:13:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9584040073
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9584040073
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9584040073
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:13:11 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-8eefd4a8057so25657056d6.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 05:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785154390; cv=none;
 d=google.com; s=arc-20260327;
 b=MzqD9uL4zUG6ELBQeJWRTj/JlZXOR8eR/6zQjJTy0Swt7jXzo7VwaoDBpfZ7Vs9afk
 Pp+yCEpotlrfzYL+YaCAyFXdYmjtVxDQOSZX7Ox4IL/T6AQJ3cCfXB/LuqtOjJqfxn1h
 0wy/4PrResQT4axcC7Q8KEkiD7bRHwX1MZDbh5/d/1FEVjjnYoZUavZEYL68mkGtDfzD
 f7kxnfHxbFn0ld8ODnuABnfoe9p2h8XdqZQyF826KuuaYFZaPETx5Cedc1H0LAqH4GnA
 d+kqnNea9yS2YOX6UffVzfa20CZWRo3DGIjO/jYKhIZsSZi8foD7tVmue6Lz5nIkm+6w
 OrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cBsz6dFc1n1BJ3+nwbM4Az60KciVqSDyxBpvKDLD3fM=;
 fh=413h32/8skiJ6J7mAOOHm1WLFvYqYXkvPtJFjaa7poo=;
 b=QEtCTRFoMQMJF7VTbEvPozSqyJ6i8hGC9niFSe2NWsHzfW6YisSpAcbA+mfWYURIku
 xgQUQJ2+l5ATdKLp94SnUZYWptoKV3eg/gqu91/9GKVDlIMt0jSDAkGq+evujH5gIAi1
 h2E4+xEj3M17jpZdIc4t1XZFawXL8rZp+063iPVIVbAg8snJeQK4mS9qwwVN3eSxphqy
 51A5TYGhCJvQ9ywXK5xD06oOQkP2IuS6CRfVs+tX3CRBcRLZ6qYQYE8ghIIbyGVcwisa
 wqAsEgelnf6IFf8RpDSwdE+iAev9jWC8RKRrjpP2WX6+twz2XiaOqHMhsCmah4RyeEG+
 P9FA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785154390; x=1785759190;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cBsz6dFc1n1BJ3+nwbM4Az60KciVqSDyxBpvKDLD3fM=;
 b=JclEjyyoWltq1qpHppJp2zX/0SbapJSz2u21QpK3xJcKgrnLs/dqGGsdrQs+73f3ex
 kVtBO8ydHjJaH48uDxKa2g7aTaoJ6itSK0aJUUO0Jd9DmYI2ru0gLxYF06jf1/YHmn3K
 JoAOylGBvWk60Y+i3kt8f9WmUMHDg+/KyiechACnLjjHxZYQPDcjlYH0yfzRGtemjh5g
 zWY3yyfugX8It1sHNb7ey/yXLj6eir55JaUU4ASXEPmmxo/WF5DU+IS/2aRMA7omcjxp
 2pHZ9EDodpZ6FCHpzFAAYPg2SwYFopXCNcntcbueWIEmokuIMNcwFA6UZfyMrZQRJX4/
 rD3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpoQmV4Mtkq55nHSLTC5Q6V9OF29BybYEK6U+NqDLsy2mBKo2lHQF3gKX1z2GlH9DvRAc5WzYI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwdcYO+HeG5YnXCtlZawGKw4TEQrGIRvwUzb/y2HKDBY9RiX+J8
 amJ+WOgWAxb4DJG6H4drAXsvf1chpWKDcuCThc3rgnK//BZwzfIHbNEZeYjaueyLuLoPyR8fD/5
 CUOZM/kb4bTi4EP1O+hgmOiONCUBJlmUFew==
X-Gm-Gg: AR+sD11RGSpa87YFRGAMQWJqqNnmu7GHimuKXQ3RtEZ4IRTZMAvG3HzC2CP+heytnFT
 Rzd7ntS0+Qj9v6tRpelrmYNwAQWO/bZnfiU0fYVQtWuskJf7YDnQ9uO1Wd1RoTp02lrMrN4NoJ5
 lA1FGp/39zfigjRNSb6lWeQwfKJq//FJ4VBIBuQmxX3U6J2KqhEpVklv17z2mpJ6mK+2L0UF3Zy
 NyX04eoE6hRmNjVkBIm0E3dOwAvPNbZh5kPehNuEFIKGBDvfW8/beHD//102gV0UoEhcmoxlOIf
 2fjOU5vUgwgIF8pKs/vRr7xBEWr5ShBgU48mcg/P5TEGweqG6zdnUKO34ih4uxKtMSODyzOBBxD
 leRmO8Y3hXwNY0V91VqQxTu3fcrP3CR2Zi+B//pY+aI+DRhNPisEHQB3Hkp4tnwcTy5M=
X-Received: by 2002:a05:6214:d08:b0:8fd:6dc5:949 with SMTP id
 6a1803df08f44-907ec8d4dbamr99160046d6.62.1785154390151; Mon, 27 Jul 2026
 05:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <alujuCnNh13eRfdA@vicb.net>
 <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
 <amNcqiirO1PbPS9H@localhost> <2c79df57-d01b-4f27-8506-ccbd6daef7c3@cherry.de>
 <amXzjSrD9Bo6et7h@localhost>
In-Reply-To: <amXzjSrD9Bo6et7h@localhost>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 27 Jul 2026 13:12:58 +0100
X-Gm-Features: AUfX_mwGR7wWXhpvFyrnjoV_k8fxRlbiO83U8PGN9rFIuL9ua3ORhMUFweZC8Yc
Message-ID: <CALeDE9NfUQcQPninY=f+ohNpVz9OtcF+b_yU70E2v76-qCuGjg@mail.gmail.com>
Subject: Re: RK3399 TF-A hash verification failure for atf-3
To: Vic B <u-boot@vicb.net>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785154390; x=1785759190;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cBsz6dFc1n1BJ3+nwbM4Az60KciVqSDyxBpvKDLD3fM=;
 b=Ylzqsv4UIU9XGKD4ga6eGOgaXExOUq9GnT27h9g2M2fufGLLLkjf0dzrN1zfwkurTP
 IWfHSeDLC3hYEQBjatiB7uW0y6rSsXcxSFfIowfvcOshYr8MdToqE5N9LyI82NbYSmCO
 AdX/+vHji/C2aKZRDsobm1YgOXUvra3vK8IVyx1eu12a2hTQqT/YE5bTWRaduYY4L0I3
 vpT/4nYVD4D2Cg4RcYvt4sPnrIJSlatYWGSIqj0IaDzLQS3yo5LXx1JK/5nPPCawq3Mp
 9sgUGEe6IeY/hqgFzoCLxVTKqFIVyoO4FZo+290NvnuxGbVqpvQ89zMtCu8dAgb9YElY
 U0FA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ylzqsv4U
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

On Sun, 26 Jul 2026 at 12:46, Vic B <u-boot@vicb.net> wrote:
>
> On Fri, Jul 24, 2026 at 02:55:20PM +0200, Quentin Schulz wrote:
> > Hi Vic,
>
> Hi Quentin,
>
> > Since this is not really a U-Boot issue but rather TF-A as I understood it,
> > maybe add (or switch to) the TF-A mailing list in Cc/To? c.f. https://lists.trustedfirmware.org/mailman3/lists/tf-a.lists.trustedfirmware.org/
> >
> > The few times I wrote there I got first support in under a few days.
>
> Yes, switching to TF-A mailing at this point is obviously the best way
> to go now.
>
> Although GCC 14.2 from Debian's stable which hits this issue is no longer
> supported by TF-A (according to TF-A docs, minimal supported version GCC
> version is 14.3), the same failure also happens on Debian testing with GCC
> 15.2, which is another reason to continue with TF-A folks rather than
> let this go.

The thing to note is it builds and works fine using the Fedora gcc
toolchain so it might not be considered a TF-A problem by the upstream
project. Now many that comes down the debian build options, or
settings in TF-A code, or some random combination of pieces is what
needs to be worked out.

> > > The Armbian's attempt to fix the issue by increasing PMUSRAM_RSIZE
> > > in plat/rockchip/rk3399/include/shared/addressmap_shared.h from 8K
> > > to 16K seems like more promising course to me - although the resulting
> > > build with oversized pmusram isn't really usable, it produces much more
> >
> > I don't think generating a broken binary over erroring out is a good thing
> > (it seems however to be quite useful for your debugging session :) ). What I
> > mean is that I don't think this is something we should get merged into TF-A.
>
> I'm sure this one shouldn't get merged, although it is useful for
> debugging, when the broken binary gets loaded by u-boot (which is
> possible after disabling hash verification), it most probably results
> in the M0 PMU running garbage after having the first half of its code
> overwritten by the overflowing part.
>
> But despite the M0 PMU running garbage and most probably not working at
> all, the system appears stable even with this obviously broken binary.
>
> And this is IMHO yet another reason to ask for help from TF-A folks, as I
> have no idea how to determine whether the resulting PMUSRAM image works
> as expected.
>
> Cheers,
>
> Vic
>
> > I have neither the time nor knowledge to look at the rest unfortunately, but
> > I really appreciate you giving lots of information and debugging output, I'm
> > sure this will help someone help you eventually :)
> >
> > Cheers,
> > Quentin
