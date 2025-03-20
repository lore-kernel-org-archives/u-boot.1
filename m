Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F5C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 03:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC9F8083E;
	Thu, 20 Mar 2025 04:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gyPRNpFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1011803CC; Thu, 20 Mar 2025 04:40:24 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 821F38193A
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 04:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e5bc066283so510757a12.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742442022; x=1743046822; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BtqUlfTM/rNDE6ZTn4hucV83RkTvCTv7mJ9V3gA+p/s=;
 b=gyPRNpFm7TqKF4DIBZB+mUOkIwETUQr47rBfPBMd3HzoVXV8oq1NyNThPdo0DzNr6A
 4MGG8+Gn3Yj0ZW8UNd/q/LtRWAQHez8SEOFtqoM9r4RVoDs23Kb6WC/DupDWBCaePHp0
 JdFJBHWoJS6FOLBI8ePduFO5aat36NB8nbuAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742442022; x=1743046822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BtqUlfTM/rNDE6ZTn4hucV83RkTvCTv7mJ9V3gA+p/s=;
 b=AKCzmZebE9ZoIfW7elMIcGY6FPAwcRmtudyoqu66LAYSbE46Ployjw9sW0N4avW5pt
 xGTeGuTf5VxIn7XE5bEnMqj0aqjSF/JMZcIxydzo62YtJq9e9/nqNs1d58sEhiAO6SIQ
 3PdbBtALqmPpsQGf0AAr49nEqRZT6r0EoBgRdQj36noC9f+XCqKRyRu59Y3lEwaN2azU
 0oIP8KU6+y2Sba7yEMqxR5v/Lg69SM+u9ecOtz1W06uG/c9k0PvRIUuNyzqZ5c7sOtq7
 DFV57hyK4yWPse6qvcucQnMBmcFnoT6lTf4QOx+dqKRSti7VGVl0hOPLp7lJveB2mnWB
 iVIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkzW5NMn4gRs6SccuoysppFz61h64+9nibc2JjwCDjAq3bZZkNoBhe2INnvTrvJb7/Sy7OymA=@lists.denx.de
X-Gm-Message-State: AOJu0YyZ05M6ImWOyyCn++iLdEw/brTwLGvGnrev7Jj/Z91tg1yNpqHJ
 TR5+RebXVaVkaBHy8uEgipRvDtjVZ8+ib7C4SVC87q2v7gdPuQFu7MR2E8I2EZw9RvJOgcO/JvW
 dCbVlLEGpLaLa3CBmaY0iXfsbyp0E50CS/EdW
X-Gm-Gg: ASbGncuXHeR9AlpdVk9QP0p4atRkujmDdqxyalomrKv+XUAGNduYQgBjjSCCXt58/um
 /QHY6/pb8PeH1u4WQDqNJm9PNXxoN8BxKI6dtYr/j0TGUS++GFgLGw0nIVC/jvBlIlg/ypdraLh
 z2M+1m0rUbYD2aBlp8ycqxhiR8rqs=
X-Google-Smtp-Source: AGHT+IEc/jxCAhENbMd5pDsm5cRcLGbC7rn1nU+oSBjdswqUY+OEYp+SGkCSvrsv1Lee9m/JpQeVhWKlW/l9JgPmnds=
X-Received: by 2002:a05:6402:5190:b0:5e5:e78a:c501 with SMTP id
 4fb4d7f45d1cf-5eb9f2d3926mr1802415a12.13.1742442021876; Wed, 19 Mar 2025
 20:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250319072203.327431-1-ilias.apalodimas@linaro.org>
 <CAFLszTi8gTWr_BYv9nAJ1d_kN0FJQ+tbVGL81EsOFuALtWR96w@mail.gmail.com>
 <CAC_iWjJ+CQt9VR7s2kUKaWsNoP3uMCQAMMn_cAW3HKHyR=avQQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJ+CQt9VR7s2kUKaWsNoP3uMCQAMMn_cAW3HKHyR=avQQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Mar 2025 03:40:09 +0000
X-Gm-Features: AQ5f1Jp66-Dp3J0SHIYmzp00ilPh2JS-y1NPrkC7qS87ZK13Vpw4OWfyDa6NkKE
Message-ID: <CAFLszTgGs6E1SeB+EoqgxwNT5GHry8wEMiACrzex0TVUJFsB2w@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix page permissions for platforms running at EL2
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, Caleb Connolly <caleb.connolly@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

Hi Ilias,

On Wed, 19 Mar 2025 at 16:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 19 Mar 2025 at 17:04, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 19 Mar 2025 at 08:22, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > We currently set both and print both PXN and UXN bits when removing
> > > execution for pages. This happens even in the existing per platform
> > > definitions of 'struct mm_region'.
> > >
> > > That's not entirely correct though. For stage-1 translations, if a
> > > platform runs on a translation regime with a single privilege level or the
> > > the translation regime supports two privilege levels and we are not
> > > in EL1&0 with HCR_EL2.{NV, NV1} = {1, 1} only BIT54 (XN) is needed
> > > and BIT53(PXN) is reserved 0.
> > >
> > > Currently we support Non-Secure EL2, Non-secure EL2&0 and Non-secure
> > > EL1&0.
> > >
> > > We already have get_effective_el() which returns 1 if we are
> > > - Running in EL1 so we assume an EL1 translation regime but without
> > >   checking HCR_EL2.{NV, NV1} != {1,1}
> > > - Running in EL2 with HCR_EL2.E2H = 1
> > >
> > > The only problem with the above is that if we are in EL1&0 and
> > > HCR_EL2.{NV1, NV} == {1, 1}, then
> > > - Bit[54] holds the PXN instead of the UXN
> > > - The Effective value of UXN is 0
> > > - Bit[53] is RES0
> > >
> > > So let's re-use that function and set PXN only when we are in
> > > and EL[2|1]&0 translation regime.
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >  arch/arm/cpu/armv8/cache_v8.c | 28 ++++++++++++++++++++++++----
> > >  1 file changed, 24 insertions(+), 4 deletions(-)
> > >
> >
> > Perhaps add a test?
>
> Sure, I'll send one, but it obviously can't run on sandbox.
> We can run in QEMU with an without virt, but we also care for real
> hardware (which is all problematic AFAICT -- at least the ones that
> have an EL2 translation regime).
>
> Any pointers on where I should add the test? A new file under test?

I am more talking about the algorithm than the effect. You could write
something which calls part of your code (an exported function) and
then checks part of the resulting table(s) in memory.

For example, if you pass in the value of find_pte() then you could
write something which calls pgprot_set_attrs() and then does a few
spot checks on the resulting (fake) page tables, e.g. to check that
your fix holds.

With effort you could run such a test on sandbox, but it might be
easier to enable it on QEMU on ARM, bearing in mind that it would not
be messing with the real page tables, just checking the algorithm.
Probably only a few dozen lines of test code, but it would help
provide a basis for people to build on as things grow over time.

There also seems to be some code-duplication in this file.

Regards,
Simon
