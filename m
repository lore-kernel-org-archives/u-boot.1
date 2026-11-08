Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1756F606A31A
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Yicvj3CO;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xUJu5rq6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2D1A6062B;
	Sun,  8 Nov 2026 06:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MHq80AziAots; Sun,  8 Nov 2026 06:10:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17B986061F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794118218;
	b=Pk/n0hGnj4KwvVBNv2QXV3WNct1eGsPE3pneTnfcnumY6tZWqFZ913Ol1KJAi4PsnX8T
	 kkyH78WOwe1kH8sIKzr82iWS+9Xfyhc6V6dZjvzjT1cCKQwj0BJhOUhJ0mryw/TscDAP9
	 3lZn48DSZb94Sd3ooya/LtNXUd2iPS7wZtRRzTmx0tlhIerdB8+xsN7BMLbdM9sjONwix
	 FolVkkTZXE8divnsnq9ld1P+/+XdqcT2hyQYhzFkfVkukzvZcX6Xu0x0/eOEoABOC9zF/
	 kjf7Gs8EQV4l0ORFNFnhsnPGCdtI4vhFkOqIMe7xZeZcuTNLzixtNUpF8vexH/SFZoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794118218;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1JGHHIa0D3vVJ7ze8X8C/k4aowwSrutnFxm9bXIb0Iw=;
	b=FPZM5npeV05G4jwObq9wRHCJMF8NxiDNEKlDiZl7ZStqBHUWKOkOU8mqn2ZHMWmM4mrn
	 nZxAlnQOsJCEczbvXknGtyprJ29Q5PYa2tvzFEs9ik2vKNo235rynn4qIs2Ry7qdWOygG
	 xvhwQfR/4MySo1IuDbYDxN1iWdHTUPd5ZdkJnCzOTpqy36Sq8wPObStcnd6LhgU/4myty
	 x3nWm/TfWYjboFNpVSIBOWLcumPmVzoBNhphyPI4TjqpoZAzkptq2NHVhH6tPWXQg8M+H
	 wRp/t9YUwy+dhd4Eieg6T8dam2BjYchKl3X0PHzGjfJUGyGSJWEQXSMUw/o/bAPRG4Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794118218;
	bh=1JGHHIa0D3vVJ7ze8X8C/k4aowwSrutnFxm9bXIb0Iw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yicvj3COVE4JFRgwDup5lCgeJwdAX5W+SH66Uw71KdcKgDT/V261QZIPAbOz8RhTT
	 BlzF1Py9fI8sVrWx4xFJIQ3hsCYxtdvAZyff5/q0uWRymPveT8Q2cgF4YOk7hxEKOP
	 EnYE394Evhj6Iqs5T4QXL9KvQrzEmJVtmpxdGeplLrFvRFumxmr7Yov3t5ZV+QIZCm
	 xuQ2C9G5gU385o9CV36Jfq8niizU3nKScwi0YlbCl4Ud3zSpBdIqaZ3i1pjlSlc5ym
	 qstBU4RIqOppF4PY/pbGoGIO6dJRqxuGAlOuzi58p766sYw+gP7GR2hWYb6QsLyfji
	 PWJQkCd2IEw8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17B986061F;
	Sun,  8 Nov 2026 06:10:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 19C7732A
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 03:21:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02CFF4051D
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 03:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9rOdPyMEmZl for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 03:21:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EC792404F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xUJu5rq6
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC792404F8
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 03:21:04 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3ad0102edd4so1075531fa.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 19:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794108062; x=1794712862;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1JGHHIa0D3vVJ7ze8X8C/k4aowwSrutnFxm9bXIb0Iw=;
 b=xUJu5rq6lh9L9UBSJlHFtNsGIUKPHorC3ZDK17ZDtYrPYzuiY1Tf9hjA/dTGIKsGQu
 qn4Qi9rbOk0gcqOCGmqI97Ehk3MH/lvVkdcTX07ouxYS7sbU5/zGlWGJHH03IBXKQCmR
 j8MXcUYSXjnvVCH1zSn6ReuCGFfKc04rRtf6wjBmMSWON0jjl1s3oVFWgt7h4Ydt5tuQ
 TZlQ8LkjoqY6pI0UZoJ6SRqBY5vxIzEUCay5Y7mq4YoZ8CnjpQ4IHFVB6yvjS2MoonPf
 N5je3Mmf8qcalH24daNP0REdhqeri+25vIZ9Zycy4hIEqydHSNbj8i1vNRyH4UhzMLEh
 M0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794108062; x=1794712862;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1JGHHIa0D3vVJ7ze8X8C/k4aowwSrutnFxm9bXIb0Iw=;
 b=AhuiiKy6RZpiyJMbgi5DhoJbukwqASO6I6ZPA6sG51Q4TQFwE8b+mcxbzNh7lZvNjs
 QTLyRYq9wvmzBuKsezQ4AJdQ78jLhSIcz6+mzPpFsi6NqOUyUR2J6p/wqBkUZC82Fs4a
 dtxOHdygXApZWkLRVNW/XPXOl63YfBX7b+MQMOoEOgqyArvMI648CJadBkIpx1OaJniD
 8L7wZtpPMXLFm5RNhTzyBZKQMjUIcy1GWaWP/YfJT0EhjgbyPfpnRZEAvNTDNJuiSsQ7
 Ol2/RAcyOR9cFqHmf0C1AQc2gOhDJ3YmP6L0C9m7u2Ws3tpct2LYQBvShrHYPaym4bg4
 Vb4g==
X-Forwarded-Encrypted: i=1;
 AL+hErHL4ZEnKXTwR3DVRjEbYM8L884ferNelIKKAVE7OlyO6Veq8aGZwbruc9WrhsC9xYv+EES9NLI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z805uBXxYQfEM1yuNBiVPbeuNPinuYMmfNwxBoZpyM/vq9SxUeX
 k4HZTQrxnvazaeh6O1QWiaLJdY+S7XBsRP3YyGxI7EWcbt7QWJyZFg+CgEeQxLq1zqhuKcTcWg9
 fRPbHIFSoxodPEg0hJEsaHElsW33d0eM=
X-Gm-Gg: AYBFou3+n9iDBN5eJBDYgzWUYpTuo5HSMcLPHiyh7Z7KVa9Amja5DG3a/JVeq/mJbw9
 1Dc9yDV6MbhkXGLNKXEb4zyqlUw+8PCjLY2WFC1YqrgwRk2oLmTapfzHlnOMqnidduZ7S93sXZS
 Vw3HAtX5z23FoXm6BIzgzuJXMN8px3xztq15tKn3eFojz1HUrHmJCYhU68SHcm8bS/SdMOGrC0H
 KRcNklTfURflAIHZWzpOUln0WdCHy3GwA6XdWoq5pJdLBXeijpPbMlzqinbuasM7pm035z5NNKa
 LM8K2VBEMIkDSoWVxGgPaBicEflIPPFPwrn5Rb7C6sSbMKTkYHuiLjfZ/rjbwSdsg75SMQRx8d8
 ulfevj9HlJ3buYIrdnth8O45F/7yOW6R5cR/SVyytvG/90gZIVWL+qc4LWg==
X-Received: by 2002:a05:651c:31c9:b0:3ac:e902:f23c with SMTP id
 38308e7fff4ca-3adfa2387a5mr896901fa.0.1794108061786; Sat, 07 Nov 2026
 19:21:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
 <20261106194621.510146-3-oss.patchbox@gmail.com>
 <CABdDSeVYBMhFXb0gL6LeSysr56is2e4+jhkeVdimwZNgy9Y4Pg@mail.gmail.com>
 <CABdDSeW77pQ46JB09Uzrf+tDfMfxJWx6pCNj2tMdjB5WbH4tfg@mail.gmail.com>
In-Reply-To: <CABdDSeW77pQ46JB09Uzrf+tDfMfxJWx6pCNj2tMdjB5WbH4tfg@mail.gmail.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Sat, 7 Nov 2026 22:20:50 -0500
X-Gm-Features: AclHuK-RD6kWQGQVbGaySOD0JfXDFVi7iHqXgiMFD1lzkezXiv0Yv5yof8vxZHU
Message-ID: <CAGG=RgDJEwOTy=m1xb+BhBD7mHs=yuLPwQWFE8frfmxL8EJUsQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] usb: musb-new: sc5xx: Free the controller if the host
 probe fails
To: Greg Malysa <malysagreg@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 08 Nov 2026 06:10:17 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 6:18 PM Greg Malysa <malysagreg@gmail.com> wrote:
>
> Is freeing mdata->host the appropriate cleanup action?
> musb_init_controller registers the pointed-to struct with the pm
> subsystem, potentially allocates a dma controller to store in ->c, and
> does many other things I haven't traced through yet. I would need to
> review in more detail but it seems a more appropriate action would be
> to use musb_free() which is currently a static function inside
> musb_core.c.

Thanks for the review. I agree that musb_free() is the better
choice.

On Sat, Nov 7, 2026 at 6:46 PM Greg Malysa <malysagreg@gmail.com> wrote:
>
> I think I was off here (sorry I didn't write this driver initially and
> musb is a bit of a labyrinth), so it probably actually calls
> sc5xx_musb_enable through the sc5xx_musb_ops struct, but that function
> also cannot fail and always returns zero, so musb_start() will not
> fail either way.

Agreed, musb_start() cannot fail on sc5xx. However,
musb_lowlevel_init() has a third failure path. After musb_start()
succeeds, it waits up to one second for MUSB_DEVCTL_HM to be set.
If the bit is not set by then, it calls musb_stop() and returns
-ENODEV.

The leak is small so I am fine with dropping this patch if this is not
needed.

Thanks,
Yuho
