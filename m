Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E70D6AAF4
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 18:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D867683D8A;
	Thu,  2 Apr 2026 20:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fek9BjzT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21DF083F7D; Thu,  2 Apr 2026 20:27:46 +0200 (CEST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE41A83CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 20:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6634bb959a2so1672512a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 11:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775154463; cv=none;
 d=google.com; s=arc-20240605;
 b=YmWUPyQ37z0TOTD+KpJIDwwqvMjiq4fgSIc41qZpcfUShjF+RsjTMM+wvxt7o0Vn0f
 r0xRYNteI44vR0Gkkw+YlC9OrxXMXXh6ZRUgXLC21Sm7z5sXkSriScRB1Euq+CEBBdRo
 pzv/QFlSx/AfzzqGNEc1M5a8O+pLxKWs2DXHe71FdaH7olX9l9SaDrIXx/ffid4FneEi
 ZD2iU+DDDA5AZ8uVbQ+sf3WBr5C51bTjItIDnQGRj2YffEykydvwuZE7muffklvoYF87
 28wQatnvBddVPknx48cx3leXtfpgeltN2ZRuQ3PD0kxda1NV1ZXk9vBX9QnUwves1uxr
 Xjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xT9J/YOXA402kaSWI8a+0zHf223BdZDW3q8d9Rh8HA4=;
 fh=UsL9Rnwow6VFQ00e4ZtgfmC90jjXKxMVzqeN8RRQXVk=;
 b=iGe6gm4KQQ2T5l93v1PkNLwh2Vs+xaEXAnZHxEHCUAb59ybfzP+Px5hhBlIAdmP6Wd
 MGxKNBJA8+mz41mNpiCQa2bmyjZPaH5DzxpVQFergEXR+PC4sf5VzxBt3RyXLMc2y7PA
 55ezbtFPqmGTDOxQdaQLAAxX/AYVZOp0Zzf0lcKxjzS4UCSosu/P2LAYp4K4ct6gyqYQ
 yRf3MZnXXsTmKqVv2uBXnsyIxR8SvQR+UEUWyPnjGITaSW0HWvCwwSJ4E8gh1FQPKzKY
 9XiD/6hqPzjHB8Vr0Vx1XaTm7+flTy1E7m3o8h4gfHgjt+bj215RqT11kCfs6eBFyAQG
 NOgQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775154463; x=1775759263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xT9J/YOXA402kaSWI8a+0zHf223BdZDW3q8d9Rh8HA4=;
 b=fek9BjzTYiM041/o2rhqdaMXg9wgoM/KNvSDYBfgm+KbhzgEruQqoaVFJruSBuAGN6
 pUryC2gbh5UXBxdY7k0AzUyNqrFTd32kW5SuPr7PrEJiwVTPAGXf6/cL0+5WCnVh1JLO
 k2VZDtxxm0qxpIR+qgYuwmjjCzo3dQuXM9iEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775154463; x=1775759263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xT9J/YOXA402kaSWI8a+0zHf223BdZDW3q8d9Rh8HA4=;
 b=H5ODbp8OFNaQQPi92eW4amOd6H2lQvmSklbDaKDeJZ+Fxl6tbF1ses2gDuT0YvEVDd
 SzsvX4KAs4hdabQ9aNymA12mdGBvEIspy+3IxQuw4eCs+MKk/jLBjEVOk2FtANyT1n1h
 h3WSjN+14g2ziQKk2jdRVlie4dkJPTwkKCaIV7V8yVi9Lzxw4MZZmxxD9KhTmhOHnoFM
 onfxHoYjYdeGNh0zOMkofoQRen3QV58zyTStqfNdkf6wRjrepdKuXWXDF8ISkBmsbieD
 WwhcNJQLchlbyEsQRSHjDkj3yAwR0u7szxKKG8cODinN0mQgdpX7cUfded5vjvkJEo1n
 xcwg==
X-Gm-Message-State: AOJu0YyIFzvTa9JTA+scPIw+xGL5SEO3zT/xpXcJ0qUDAGODe0Xhlmga
 luqJRE9e0fsl4qUCN50xjFOmXoVGAo3Uqv9SLOdc0M4DpbIWgcbi42pjTaEt6pWn6EF22Ra8/y8
 f0g8hoh7PSTjHns9ZjkerPQWcwuoZmJYUUsoxucJCMDZ79lTq8+E=
X-Gm-Gg: ATEYQzyIKbZAYpvsmVZoMy594a6B3jcRQFi2iAIgu9YiW2cHqG8d1YiD3Tu+34136kl
 8IVOsT3DOzi8olzJoxI+Idn7PAes4GjZZJhujUfRWDST+K+7nDo4ZZOqAf5gwj18G83EORflVY6
 ar+OlCItEuDyfIttkBdFsvlFNA0thNcm1oXFJHbJ2LNbm4tiM1N3Mtyi6usViwKOCzXwRcfFyM8
 dJrsLbMEw2OhtCc8ANSrRWpZgIv6oHD1YjbSbTbENOmdVn7wLT+OBnNFmkdzllXHhfwtOXdD6yV
 kGaD2w==
X-Received: by 2002:a17:907:c294:b0:b9c:60bc:eafd with SMTP id
 a640c23a62f3a-b9c60bcee86mr56209366b.34.1775154463173; Thu, 02 Apr 2026
 11:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260330140106.401876-1-ravi@prevas.dk>
In-Reply-To: <20260330140106.401876-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 12:27:30 -0600
X-Gm-Features: AQROBzCvOQdQkjatGqv0zhtugnD5V3OeVqPIeJH2QoCrzzc94lz11FAqAbp7UyA
Message-ID: <CAFLszThhMiXoqD4Gkd-735y0r=-1sbzkqDVUYREtvkaG8bk=Pw@mail.gmail.com>
Subject: Re: cmd: test: add bug-compatibility special case for 'test -n'
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, Franz Schnyder <franz.schnyder@toradex.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-03-30T14:01:06, Rasmus Villemoes <ravi@prevas.dk> wrote:
> cmd: test: add bug-compatibility special case for 'test -n'
> cmd: test: add bug-compatibility special case for 'test -n'
>
> It turns out that there is lots of code in the wild, including in the
> U-Boot tree itself, which used to rely on
>
>   test -n $somevar
>
> to yield false when $somevar is not defined or empty. See for example
> all the occurrences of 'test -n $fdtfile'. That was really only a
> quirk of the implementation that refused calls with argc < 3, and not
> because it was interpreted as
>
>   test -n "$somevar"
>
> which is how this should be spelled.
>
> While not exactly conforming to POSIX, we can accomodate such scripts
> by special-casing a single argument "-n" to be interpreted as if it
> comes from code as above with empty $somevar.
>
> Since we only just added the ability to test a string for emptiness
> using the single-argument form, it is very unlikely that there is code
> doing
>
>   test "$str"
>
> which would now fail if $str happens to be exactly "-n"; such a test
> should really always be spelled
>
>   test -n "$str"
>
> Fixes: 8b0619579b2 ("cmd: test: fix handling of single-argument form of test")
> Reported-by: Franz Schnyder <franz.schnyder@toradex.com>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> cmd/test.c     | 15 ++++++++++++++-
>  test/hush/if.c |  8 ++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
