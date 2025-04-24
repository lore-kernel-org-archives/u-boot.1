Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707B7C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 18:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06227812BC;
	Thu, 24 Apr 2025 20:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N28o0miY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8566681E25; Thu, 24 Apr 2025 20:35:03 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06BDF8056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-309d2e8c20cso1833557a91.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745519698; x=1746124498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C670LkYPrGAbxL07kSP3qbaV6Bl5K6EO18/jJZN3YvA=;
 b=N28o0miY6tFCF8bt+pcdOhAKcWmJClTy7uWD7Zkk31Ae/J0Ml6UWj6LtTj0OacoKem
 04O2rwXJUpnJp90ZqtQDvJfIUraSKTLUYKFy38IaPLKkWKntZX4rC84ldQvcU98anF9R
 +pHwRCWHH+13OZUTohcVFBYv86+KVv8BLFnFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519698; x=1746124498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C670LkYPrGAbxL07kSP3qbaV6Bl5K6EO18/jJZN3YvA=;
 b=dJp1uwFiaiR/fysTiFYPmgGSWTHpvM6Xz8QItp/+mzIRVkygrkcXCtH9K7RdhY8KIn
 ch+rEf0JZ2VwpSiM1AQAfTo7qt7bf9Ky5qdiT2w0aR+kWYegtPJoBVsfwWPc9VctXzJT
 ir2mzEv4NLOrZtfoR9IXsMeEmLopoUC0n3Gkkc4j3lSJwB9RC7IB/kzxVp4mpO9+U1JO
 OVg7TYU8MGO/SZvMKcZTexr5Gqve7hH7i8h3Qg90Ho2JCUsEmkmTUR/dsyFKXEDUq9EC
 quCxxHrVVI2tCJm9IMxCGA6yb6G7jg75ELrgheAAIxs4v3qI9m3MgJl1IY3JXqLmWLL5
 56ow==
X-Gm-Message-State: AOJu0Yzp16fjoDMQndVaxgoXw8Op9AH8a8cbVUHYRXLWWXDAEALLudiY
 IobCYUmXvR5de8UZCRj8t2TG4KjGWUIy3JmXMYXXI58sRM+JV4t/0Sw9vcFzpewPJ/yQUB11jk0
 +y07hfusCPGm3J5sbWH+LGFRBEOAiXC2UZB5a
X-Gm-Gg: ASbGncvYslVHjQ5hXgzhTS0x5O1jGzJS0iutGhIKWwGHCtMuUfdvfSmLjUa5nxJqIWi
 8RoeYqy+XEUjVUNZYlXrv87BnZXwINUtFrOi+mGY9EZMH7PbSA3/9e4++Zus/jObweyI2JwPA9d
 nyXlz6VLeGzVDq62b3svOJI8s=
X-Google-Smtp-Source: AGHT+IG9ji+Tg0daZSVGifsWjFprasRfydJ9GRIc6E4FPkr5IFBu0+2YQXe21i9TbvF/t+NKsxi/lTueSxLU4qetSgc=
X-Received: by 2002:a17:90b:3906:b0:2fe:ba82:ca5 with SMTP id
 98e67ed59e1d1-309ed26fba7mr5746590a91.11.1745519698458; Thu, 24 Apr 2025
 11:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
 <20250423140850.GE5495@bill-the-cat>
In-Reply-To: <20250423140850.GE5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Apr 2025 12:34:23 -0600
X-Gm-Features: ATxdqUFmwbxuXcNdb1uN7cjtLbuygzQ-AxxIqj4Xwm5XcctbFLrPWdWKsWZyeiU
Message-ID: <CAFLszTgBbh8F93peSC6JO+02BLGNYnRv8fgQTSW-E3xmhsY9ZQ@mail.gmail.com>
Subject: Re: Maintenance of Python tools
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi Tom,

On Wed, 23 Apr 2025 at 08:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Apr 22, 2025 at 05:39:30PM -0600, Simon Glass wrote:
>
> > Hi,
> >
> > Tom has indicated that he would like Patman to move out of his tree. I
> > suggested on another thread[1] that I maintain it in my 'sjg' tree, so
> > here is a new thread to discuss this.
> >
> > I have already done this for the qemu/efi/coreboot scripts as Tom has
> > NAK'ed patches for those.
> >
> > For the other tools there is going to be quite a bit of churn, as I
> > would like to resolve most of the many Python warnings.
> >
> > Given the shared source between the tools, it would be easier for me
> > to do the same for buildman, binman and qconfig. I am thinking that I
> > might try a move to allow Gitlab pull-requests for reviews on these as
> > well as the mailing list, if that is useful.
> >
> > For tools which need to sync back to Tom's tree (i.e. not patman), I
> > or Tom could do a pull request every now and then, omitting any
> > changes that relate to pylint.
> >
> > Please let me know your thoughts. The timing is good as I am going to
> > be sending out a new Patman feature in the next few weeks and it is a
> > few thousand more lines of code.
>
> My biggest objection to all of this is that you should NOT use
> sjg.u-boot.org as that perpetuates your abusing owning u-boot.org. As I
> said in the thread, it should be under https://source.denx.de/u-boot/
> somewhere and you should be the one to own it there.

I wish you would stop bringing this up. Until things change, that is
unfortunately what I have to do, to avoid being blocked.

> They should be
> managed like normal python projects and we could "pip install" what's
> needed. But yes, I do think them being managed like a regular python
> project instead will make your life, and also the rest of the
> communities life, easier.
>
> Un-bundling binman and making it a standalone tool might help make it
> easier for other projects to utilize it instead of reinventing the
> tooling themselves.
>
> I'm not sure why buildman and qconfig would need to be pulled out, but
> if it's just a matter of a "pip install", sure, fine.

Actually, for me, I quite like being able to do a release with a
single 'make' command for all tools. I was not thinking of having
completely different repos. So this isn't really about 'pip install'.

Sadly I doubt other projects will adopt Binman so we are going to have
lots of firmware-packaging tools eventually*. After all, we have Arm's
FIP file format, Linaro wrote a new bloblist implementation, etc.

Regards,
Simon

* although we did use it with Zephyr in ChromeOS
