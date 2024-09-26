Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A7FCCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 11:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA13788D66;
	Thu, 26 Sep 2024 13:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e1lnsyt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF42E88D61; Thu, 26 Sep 2024 13:08:12 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20EC788A0A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cb321145easo4203126d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727348889; x=1727953689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y/7ClwDcD2JJCGmuhrd183hS5b47EsTQJv6wC+dY8GA=;
 b=e1lnsyt1H3eEez3b7hSua8gkG4HaV5uniiyuGxXPYVR7aVs8khLpOLpUajcbdLJta7
 PBFp8hh5ZF5SEFERqiQUPe+eraSLq1a496RIAxcY6l4oyRnl7x68MC5zrSw1hMUj0pzH
 t4uflWSp9jiJbx5bi8agJtG9lk0krzVtalTM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727348889; x=1727953689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y/7ClwDcD2JJCGmuhrd183hS5b47EsTQJv6wC+dY8GA=;
 b=RlTrnfIT2SQtWwm6y5oYXbx0HL53RyBIWBszVEqveejYJsCaxxB8DEf1V1lP37PEch
 0xs/8KwNj9dIDvzk6ZSulveILHwmi74kFq5B82SNKn5chjL7j76MZMIMc9hwh6OOgTYi
 gAtp/wDxnEcFeh4wfpJHXttW7J+Wj8c1B7xKeB62PebmqxqpLj39HvloKZCpTubg/rY8
 zIJ7MpFP3OHiybryLnlOOKtIq3J+EqJAWamXc8MSlfseM2AdB/ZPN4hEpaaUy8weiFmC
 WkJIpNB5XHgG4ID2zXipq1ZJ5eH3bfL1qV53UzvKa3ne1bEIOa/OjRnsuaBPx9mzeGWx
 DZTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2xzJIW9ysHXGalt6MRBUVq7aofA3FFOVyNd1+6lIaizxv6q+n6Ijp93Cm3CPhDQkx3PriEPU=@lists.denx.de
X-Gm-Message-State: AOJu0YyNUGKrEMptsSpxuYcrY/DGVljq6JvxPE5dxGqVQENBalOD0k0V
 lwfXRurghQojNn5psgj5xAss8i/N7uoQ+0qLue8wooQeqQXOiRE/2EQ8X673GCX3WbfKh7gUO78
 m53mO1QDRZzPt6QCnnCF/R4gritFecMHLZnbT
X-Google-Smtp-Source: AGHT+IGep2PRZfwMbbSjP8G4HXHtt+ZinTnu0eXz2KgCxl78ibGlEG5KNsW2TFV3uK0vlTzxGvPPl6VyhaYIMtuRIaM=
X-Received: by 2002:a05:6214:2dc7:b0:6c3:6560:af09 with SMTP id
 6a1803df08f44-6cb2f18cbc2mr39049766d6.0.1727348889008; Thu, 26 Sep 2024
 04:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
 <CADg8p94TakJXkLs=m6RbvO2T_OmYagf68e4JV655TtQ5DnxtZg@mail.gmail.com>
 <CAC_iWjKFh+g1k=HHKeApJp8OO5G78p0kruz59UUX-yfZcynJyg@mail.gmail.com>
 <CADg8p96-kG4jEd5d_7ah3s2kOzgW4_uvDOJL+wOSzdrDjoMqZg@mail.gmail.com>
 <CAFLszTjD5vLpcu7+_9xuzynLMjim3oPpg2wewug3-6nMs2CHug@mail.gmail.com>
 <CADg8p94_8znKCR=97kCj-ypMdqW59k7PbC42G-xGFr7t9+t9XQ@mail.gmail.com>
In-Reply-To: <CADg8p94_8znKCR=97kCj-ypMdqW59k7PbC42G-xGFr7t9+t9XQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 13:07:56 +0200
Message-ID: <CAFLszTg2TvZp37HTjVwnYAw9cgX1-mfipkaw7frEL4cwJbzF4w@mail.gmail.com>
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

Hi Sughosh,

On Thu, 26 Sept 2024 at 09:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 25 Sept 2024 at 18:23, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Fri, 20 Sept 2024 at 13:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 20 Sept 2024 at 14:51, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Tue, 17 Sept 2024 at 15:33, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > On Sat, 14 Sept 2024 at 20:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > >
> > > > > > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > > > > > Add an event which would be used for notifying changes in the
> > > > > > > LMB modules' memory map. This is to be used for having a
> > > > > > > synchronous view of the memory that is currently in use, and that is
> > > > > > > available for allocations.
> > > > > >
> > > > > > The synchronous view problem only exists because we are duplicating
> > > > > > data. Store the EFI memory type in LMB and the problem vanishes.
> > > > >
> > > > > The LMB module only concerns itself with RAM memory. If I understand
> > > > > correctly, you are proposing maintaining the EFI memory map within the
> > > > > LMB module ? That would mean handling memory types other than
> > > > > conventional memory in LMB.
> > > >
> > > > I am pretty sure I've asked this before, but do these *always* need to
> > > > be in sync?
> > > >
> > > > The efi allocators will call LMB now. So when we allocate something
> > > > gtom EFI, even if any potential changes from LMB haven't been
> > > > published to EFI, we won't have any memory corruptions. Can't we just
> > > > opportunistically update the memory map once someone requests it?
> > >
> > > I have given this a thought. Because what you mention, Simon has a
> > > similar comment. But to achieve this, it would require generating a
> > > new efi memory map afresh every time such a requirement comes up. This
> > > would mean, create a new memory map, put in the conventional memory,
> > > and add other memory types that were part of the existing memory map.
> > > And then remove the older memory map. This would need to be done every
> > > time a memory map is needed to be generated. And that would also
> > > include instances when a user enters a command to get the current
> > > memory map. I think notifying any changes to the lmb memory map to the
> > > efi memory module is easier, and less error prone.
> >
> > We need to get some agreement on my memory-allocation patches first. I
> > don't believe we are on the same page on those, despite some weeks of
> > discussion. We need to resolve that issue first. I did try right from
> > the start to first agree on the problem to be solved. We skipped that,
> > so now we are having to do it now...
>
> These patches are currently under review. But fwiw, I think you are
> aware that these patches are not related to what your patch series is
> attempting. Your patches are related to the efi_allocate_pool()
> function, whereas this series is trying to use LMB as the backend for
> allocating pages, as requested from efi_allocate_pages(). So these are
> not related. But like I said, you are aware of these details :)

The thing is, if we actually tidy up the EFI allocations then there
will be no use of allocate-pages before the app starts. So we won't
need to 'sync' the two different sets of memory tables. There will
just be one.

If I were confident that we could apply your series and then clean it
up later, I would be fine with it. But given that my two series have
sat here for a considerable period of time and are still not really
making progress, I lack confidence.

Regards,
Simon
[..]
