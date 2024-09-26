Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9336FC369DE
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 12:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 693A7884DB;
	Thu, 26 Sep 2024 14:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xEO6tQPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11568839A; Thu, 26 Sep 2024 14:29:09 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6495D88A0A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c275491c61so957763a12.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 05:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727353747; x=1727958547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J0lt0CAk3ZO7XylikhJFXW/fIY2WKgkzsHgEIaTgTCI=;
 b=xEO6tQPk2eBdBOmP1kWpg3hjhFmk3WR1BU6KNM8IOUyfPYJexxE4b5ogFtoPnuNU6N
 CxUfijLTezDipW4eUSg0kXvyDX1562e8NSwoYS8l3vX2bn8NYr/pwiIJ+/SPVyrYbmCT
 WNrRtjLWPW/dSh1p960cN7PLbwzMFAwl+9GhkdOiKx2mlgbP1y3FM2Gx3imVwxI1NkA6
 8vBhr5roL9Eda6cpWTc7Qa2mJFIVGXoYDLcQXgbojkbB3+Gvf0YdmxObHG2MudgwxoA6
 frg4biU1CJ+Zc1qJLVVg2m9XXHjJV/ZBlSszVyo8svF8ZzoQaheWBvMZduYmQWPs/FtT
 tQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727353747; x=1727958547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J0lt0CAk3ZO7XylikhJFXW/fIY2WKgkzsHgEIaTgTCI=;
 b=jPokbzUktXd84+GYeUK9ZfBBiHbTOd49ybMl0czEeHVZDXLH7CqqUhK/MHOfqIUQu5
 AwmhNVCe8Pa1R9MktIxowRO7x5YLtvTjRKnX9nQGU0JCjBuQ0S26lU6i6SXVKi7ygYy4
 yeHpkd7e6l1bFUIQuD8nQtEEdTQQX8n+kwgeatP6tNFw8umSeAKtHtL4RlcduD9qL1LA
 HKnXD+sT4MLTWSpEf6akNaZEHdOAEbNM09ebSIpjQGifGRg0nPAVwepS+B+Z6n4kwrsg
 D2b/4rqr3vg4VfnNxjFi4I4ll6kXrQMXba6b2g1GqbP7rdYrGuGl5yoMkmLwLA3eX5BY
 /LpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMpKtX/t0mLCRxoyIIfZQPXfYuIT8LUrjgGLQlwIHtAJELrNUJ7kVR4pEh2Lz7YC0A4c3GXfA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywr6KSoCEM0WDGpsXn4d6x+2HORdlzJ1J1JYop9nBjehw46Idq5
 7ADdWA+S/UnyEe85P8q5PomE0v7EF5hMLOyq32tQcB3yHqg0Qwu6lIbYEwvOYDIpaaZ+tRgfvxh
 8Redjn4mOi9LWd5OeGGwzeBLNu8gNFRAgFEo/OKri7jY+tIz8
X-Google-Smtp-Source: AGHT+IHBuabbZcj2gdFiBsJ5LHouqAL0H3/mrKsyNmgjpj1Ig4eI890V/x2gSrE82UrFvg24gysZ75iNGVt2do/vnP8=
X-Received: by 2002:a05:6402:4416:b0:5c5:c5c0:74ec with SMTP id
 4fb4d7f45d1cf-5c7206449d6mr5221081a12.24.1727353746588; Thu, 26 Sep 2024
 05:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
 <CADg8p94TakJXkLs=m6RbvO2T_OmYagf68e4JV655TtQ5DnxtZg@mail.gmail.com>
 <CAC_iWjKFh+g1k=HHKeApJp8OO5G78p0kruz59UUX-yfZcynJyg@mail.gmail.com>
 <CADg8p96-kG4jEd5d_7ah3s2kOzgW4_uvDOJL+wOSzdrDjoMqZg@mail.gmail.com>
 <CAFLszTjD5vLpcu7+_9xuzynLMjim3oPpg2wewug3-6nMs2CHug@mail.gmail.com>
 <CADg8p94_8znKCR=97kCj-ypMdqW59k7PbC42G-xGFr7t9+t9XQ@mail.gmail.com>
 <CAFLszTg2TvZp37HTjVwnYAw9cgX1-mfipkaw7frEL4cwJbzF4w@mail.gmail.com>
In-Reply-To: <CAFLszTg2TvZp37HTjVwnYAw9cgX1-mfipkaw7frEL4cwJbzF4w@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 26 Sep 2024 17:58:55 +0530
Message-ID: <CADg8p95eA-qMFtiypaTOyfAkVwdKWWD2yMa+HZyewWfR_vS2kw@mail.gmail.com>
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Simon Glass <sjg@chromium.org>
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

On Thu, 26 Sept 2024 at 16:38, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 26 Sept 2024 at 09:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Wed, 25 Sept 2024 at 18:23, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Fri, 20 Sept 2024 at 13:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Fri, 20 Sept 2024 at 14:51, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Tue, 17 Sept 2024 at 15:33, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > On Sat, 14 Sept 2024 at 20:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > >
> > > > > > > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > > > > > > Add an event which would be used for notifying changes in the
> > > > > > > > LMB modules' memory map. This is to be used for having a
> > > > > > > > synchronous view of the memory that is currently in use, and that is
> > > > > > > > available for allocations.
> > > > > > >
> > > > > > > The synchronous view problem only exists because we are duplicating
> > > > > > > data. Store the EFI memory type in LMB and the problem vanishes.
> > > > > >
> > > > > > The LMB module only concerns itself with RAM memory. If I understand
> > > > > > correctly, you are proposing maintaining the EFI memory map within the
> > > > > > LMB module ? That would mean handling memory types other than
> > > > > > conventional memory in LMB.
> > > > >
> > > > > I am pretty sure I've asked this before, but do these *always* need to
> > > > > be in sync?
> > > > >
> > > > > The efi allocators will call LMB now. So when we allocate something
> > > > > gtom EFI, even if any potential changes from LMB haven't been
> > > > > published to EFI, we won't have any memory corruptions. Can't we just
> > > > > opportunistically update the memory map once someone requests it?
> > > >
> > > > I have given this a thought. Because what you mention, Simon has a
> > > > similar comment. But to achieve this, it would require generating a
> > > > new efi memory map afresh every time such a requirement comes up. This
> > > > would mean, create a new memory map, put in the conventional memory,
> > > > and add other memory types that were part of the existing memory map.
> > > > And then remove the older memory map. This would need to be done every
> > > > time a memory map is needed to be generated. And that would also
> > > > include instances when a user enters a command to get the current
> > > > memory map. I think notifying any changes to the lmb memory map to the
> > > > efi memory module is easier, and less error prone.
> > >
> > > We need to get some agreement on my memory-allocation patches first. I
> > > don't believe we are on the same page on those, despite some weeks of
> > > discussion. We need to resolve that issue first. I did try right from
> > > the start to first agree on the problem to be solved. We skipped that,
> > > so now we are having to do it now...
> >
> > These patches are currently under review. But fwiw, I think you are
> > aware that these patches are not related to what your patch series is
> > attempting. Your patches are related to the efi_allocate_pool()
> > function, whereas this series is trying to use LMB as the backend for
> > allocating pages, as requested from efi_allocate_pages(). So these are
> > not related. But like I said, you are aware of these details :)
>
> The thing is, if we actually tidy up the EFI allocations then there
> will be no use of allocate-pages before the app starts. So we won't
> need to 'sync' the two different sets of memory tables. There will
> just be one.

How do we get rid of using efi_allocate_pages() in U-Boot ? This
function is used, among other things, to allocate memory used for
loading images to memory. This can be a significant amount of memory.
Are you proposing using malloc() even for loading EFI images ?

Moreover, the syncing of the memory maps is currently needed primarily
as we support printing the EFI memory map through a command. And I
mentioned in one of my earlier replies that not syncing the changes in
the LMB memory map with the EFI module would mean that the EFI memory
map would have to be generated afresh whenever there is a need for the
EFI memory map -- this would be either when requested from an EFI app,
or when a user asks through a command. Re-generating the EFI memory
map is not a trivial task, and syncing the changes in the LMB map as
and when they happen is much easier.

-sughosh

>
> If I were confident that we could apply your series and then clean it
> up later, I would be fine with it. But given that my two series have
> sat here for a considerable period of time and are still not really
> making progress, I lack confidence.
>
> Regards,
> Simon
> [..]
