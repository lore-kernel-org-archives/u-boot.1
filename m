Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBEACD98D6
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F58283EEF;
	Sun, 14 Jun 2026 14:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e0Corsbr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90CD183EEF; Sun, 14 Jun 2026 14:28:37 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88026800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6924a68e3f3so3949604a12.1
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781440115; cv=none;
 d=google.com; s=arc-20240605;
 b=Hi/m4uZlaH550bNfRPLH90tT1kkzR1TBCJ7ck7m9ExuXlmJaU6zxCMvSc8kv+LEbXU
 21AnXh/nxRX1R6xqRtfwQC1XNa0UUGTa2y3MlmhdXhnB2ANatD1egZMc6s981diER1NV
 baXeoZr8YApeGHraqEIzWzpsKFF7rpaVbbIo8a/SXgDLyh/ZKEeBlPF8LuRG0USguUt3
 vy7I8UyWcP4LvOH0qzuuYrc3VEtEzilg2fh9CXa3/Cfe8jUwxPiGaGxsGtb599saAo3d
 53wAhDkVWVvu6sl3xsHPEkF+5ESM2DGNMltSuPeZlcVrKr4x7LG/xsRj/ahTrUsB7z0u
 gTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sPP6uokdzCYYb7TL4OqJADuvnyCjuVQePEMvzMlgMGw=;
 fh=0fxkVhUN6fQF2DdPguZL3WCrJnf6qYEwD4tP0ATTw5s=;
 b=fS4SNapL4181bIr/N83p6QJdnWsOCHY80JWcW8Hw03iIUellW8ELg7He7zBiy7Kwb2
 ClCy9MA9PN6et94Wt/lx0Yn1xjVnm70o4UylL8XytFBfoijCGjIJLKZ4PTacXLm9eiia
 4GnjyRsmmCHOHOWI9+MEWmvg1O5cnajVIOkf1vVu3+SKjPaP4vkHxXJGkGLdJ7COzxUT
 HlpwqeDWS2rf+eROhpK3ntdTwSbTcNggWHNv+gNllrPgBGTsNhw476ykhgadjHv1sioI
 16Vs8y5obmqrYUSlvVhWDUsVVJIA2H/eGxNOLFMMDGetf83oU6tAxBts+mtOUmxUXsXm
 A97A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781440115; x=1782044915; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPP6uokdzCYYb7TL4OqJADuvnyCjuVQePEMvzMlgMGw=;
 b=e0CorsbrT11Jn+ohBYHJZYGUhaz9d77dn5sc+BAuiPk28xi6aJdmMN0Oc0tqDd60EV
 afrpckGkMTD2W0pI1b7KFgX9BJAb23jswRM5L/AKC0Wl51LrIYUqfUH2ri4W21D8DNc0
 PWzr2xzu3MiWj1rIi6IpJ6YJtCNA7NMWbyFr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781440115; x=1782044915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sPP6uokdzCYYb7TL4OqJADuvnyCjuVQePEMvzMlgMGw=;
 b=SUhz3kTGuMrC3U5Iw45CSq33sINw0pPlgD8U4qQam7qPugXLjb7bnqB0M6OWaB+L7w
 QuKw5UXjCsh+s/AlxcPSZCDrMcbRnKCuOksnd6o3OAMqx8mSZpQT9yaGO2in9cqcqwmI
 Lc5s0K//H83C779KTrmZkPR2wq3TbbIK1Z2CDAh6TZt91TDRfB9nIL5jQLtKhBdO0Uvt
 oi/eDVkRdSo16bUoHflnffMx8fOyQ7gpczn8bvmPURh9IBXxncyeFwFycrIbW9UgRg6L
 t7UQtrLtKy/DxMCxMG5kJM+37AbQquUOK3xiIL985JnVvFNHB+TlU8f2sbePB6BIprtz
 3OGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Dnx1s73PB4g9P4P8g1e1ym8zrCORb0vegL7ekHxg5vuvMzdpZbc/kzfGEmXucAnPtSJ4wj4c=@lists.denx.de
X-Gm-Message-State: AOJu0YyfC9pLsrAqL0sAZZhisC6PSv+UBQBEXoWM7KAlSmx4TVPIgyud
 gfPwMP32Fpjom7Sjf51X2m6xs3Wx4B/KBdQZoATrVXCD3jtHbG2mQzyAKy42ERqh/PEV33ubVzf
 2lVr+vUl7wXvdnN0W1GV2taJiCBF742trTt6WBAHYZRba6SXaIzU=
X-Gm-Gg: Acq92OFUhCMyZaPBOvWqcT/QopNMXURIbxASQFn9kkdVY7uj3XcPvkLaPauNd57rwcM
 Rem0vYBmg/x0jjbVvECcTmiZDmVE0eaKNKFhjAiPCDpYoS/IQFiaOeRE8cJ4TH80BifrVU1GINI
 pRVeK+IP31MS4FCa5HVleZ8/YfHfU+RBHijr87+YJGEpHN+lne1emeSYTtVolTFBMxF6DP+J6uR
 x35fpGTIpWJ8z09dMA4tuXYy3OTTKRUUyZ/Rhgob9gSJhu8dvz/CYtCy4jXzCwp3nfZV84D8xTN
 21WiXg==
X-Received: by 2002:a05:6402:3718:b0:671:a18b:32b8 with SMTP id
 4fb4d7f45d1cf-69377afd8cfmr4343264a12.0.1781440114964; Sun, 14 Jun 2026
 05:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260527161033.3273795-1-sjg@chromium.org>
 <20260527161033.3273795-3-sjg@chromium.org>
 <6fc3e71a-8872-4c35-969a-f54ce2869947@gmx.de>
 <20260527194345.GA93986@bill-the-cat>
 <CAFLszTh+vVMydNuHwJsK8J6adZX-ptiYvWSYza-QKEZ-XQnAcg@mail.gmail.com>
 <20260528181801.GG93986@bill-the-cat>
In-Reply-To: <20260528181801.GG93986@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:28:22 -0600
X-Gm-Features: AVVi8CfwVDagmzGe8ap0vka9DnIlUSsNqOsrOz1naYPn6mXBgPsFFx4noEcTHUQ
Message-ID: <CAFLszTi289sGAbgLnyCokYa+1uVmqeh5kjURdfj_-Aj4RfYufw@mail.gmail.com>
Subject: Re: [PATCH 02/13] alist: Allow inclusion from OS headers
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 28 May 2026 at 20:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 28, 2026 at 12:12:09PM -0500, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 27 May 2026 at 21:43, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, May 27, 2026 at 08:36:45PM +0200, Heinrich Schuchardt wrote:
> > > > On 5/27/26 18:10, Simon Glass wrote:
> > > > > Sandbox needs to include system headers in some files, but also w=
ants
> > > > > to use alist. Adjust the headers to permit this.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >   include/alist.h | 16 +++++++++++-----
> > > > >   lib/alist.c     |  1 +
> > > > >   2 files changed, 12 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/include/alist.h b/include/alist.h
> > > > > index b00d9ea97d6..69d7cdb722f 100644
> > > > > --- a/include/alist.h
> > > > > +++ b/include/alist.h
> > > > > @@ -10,8 +10,14 @@
> > > > >   #define __ALIST_H
> > > > >   #include <stdbool.h>
> > > > > -#include <linux/bitops.h>
> > > > > +
> > > > > +#ifdef USE_HOSTCC
> > > > > +#include <sys/types.h>
> > > > > +#include <stdint.h>
> > > > > +#else
> > > > >   #include <linux/types.h>
> > > > > +#endif
> > > > > +#define BIT(nr)                    (1UL << (nr))
> > > >
> > > > BIT(nr) is already defined in include/linux/bitops.h.
> > > >
> > > > We must not assume that no module includes both alist.h and linux/b=
itops.h.
> > > > E.g. include/expo.h and include/lmb.h include both alist.h and
> > > > linux/bitops.h. We should avoid redefinitions.
> > > >
> > > > The following is an abuse of the enum type:
> > > >
> > > > enum alist_flags {
> > > >         ALISTF_FAIL     =3D BIT(0),
> > > > };
> > > >
> > > > As this is the only use of BIT(), we could simply use the value "1"=
 here.
> > > >
> > > > #define ALISTF_FAIL (1)
> > > >
> > > > But as ALISTF_FAIL is the only bit in flags used, the best solution=
 would be
> > > > replacing flags by a boolean called fail.
> > >
> > > I see this as another reminder about how frustrating it was that alis=
t
> > > was introduced under the guise of "must have this for an x86 feature"
> > > but instead is a solution in need of a problem to solve, and whenever
> > > it's used for something else, yet another problem with it is shown.
> >
> > The alist was motivated by its original commit. It allows easy
> > iteration, uses less memory (no next/prev pointers in every element),
> > uses fewer allocations than linked lists (one malloc() for the whole
> > list instead of one for each node) and has much better cache locality
> > as a result (i.e. improved performance).
> >
> > I asked my friendly AI to compare them:
> >
> >   - Reach for alist when you want a growable, index-addressable, cache-=
friendly
> >   collection of small value objects you mostly append to and iterate (e=
.g.
> >   bootflow/bootdev scan results, parsed tables).
> >   - Reach for list_head when elements need O(1) removal/splice from arb=
itrary
> >   positions, must keep stable identity while linked, or already exist a=
s
> >   independently-allocated objects (most driver-model / subsystem object=
 lists).
> >
> >   One nuance: alist_for_each is pure pointer arithmetic over the buffer=
, whereas
> >    list_for_each_entry uses container_of to recover the enclosing struc=
t from
> >   the embedded node =E2=80=94 a direct consequence of array-of-values v=
s.
> >   intrusive-links.
>
> This changes absolutely nothing about what I said the last time you
> wanted to use alist more widely, and in turn what I said about it a year
> ago, or whenever that was. I'm not going to go ask an unfriendly AI to
> say what's wrong with alist, I'm just going to say that I already said
> it.

I understand that, but it does actually have value. It is less
error-prone (although the API could use some improvements) and the
performance improvements are worth having too. I have found it very
useful in bootstd and wish I had started with it.

Not that I expect to change your mind, but this is a technical
discussion which could be covered in a future community call. I would
like to understand your objection beyond just 'Linux doesn't have it'.

Regards,
Simon
