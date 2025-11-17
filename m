Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA1BCEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 18:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ECE683C19;
	Mon, 17 Nov 2025 19:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Re8N0q3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF70E83C29; Mon, 17 Nov 2025 19:16:39 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B7A83C16
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 19:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-29853ec5b8cso54461375ad.3
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763403396; x=1764008196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VDCt3KKwuRQBPIFxd5px9qBTjdj5urVvtLTw9qT7bEg=;
 b=Re8N0q3nFYlZsLWPbIi/sWGOJla6cgIq8iD7zYGageKpQa3N80xJRvtlHXTM5C0aiV
 VsdUanyDZbnymMomm5SxcO9GgqdA28//QMneYr91zlriXmZlmXGohvGJf4cFmV6GTEx+
 hdjV5V7di/Vdc93UDpVF2CebBSh4p52J75DjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763403396; x=1764008196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDCt3KKwuRQBPIFxd5px9qBTjdj5urVvtLTw9qT7bEg=;
 b=LYB57HlyamTJHe8nVPwfJwfYwils/n3PJsam/AAEibHQYZXJ2pJGu6LB1OoThM+1DB
 SQ/Jom6bhNMiIwvpg9BURvbMR+Gb+ngVgBlORNQMhD0FjcQ8C2lXJjVQewl9hFb7F/Gz
 gszRstUdAVsrpdC81FLnkqvsR4zbdbZREYWTsYl/JTUkIPfm5ZV+d/INMc796l9WgEBh
 Vlwh91jIKlKm4VgP4TbROPLQwYUP63J8r60XXA7cO2b1MieQUCES7r7rbuAqiblZE38M
 Y/ZISQzP+daOjjIZ8awwzrJZjzbwWawpHOcINIw5pU9k+dawOU679rUDrYgUV/KP6oKI
 0+pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW9/CjUrTwBgFMkYAzedXFjqDqjPGgf/Fn4Gxj0/ySqG73l/XE8n6cZK7mEAZHQoEVrxk9hiM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywdy5cRNpD3VSq/tFh6INq8Ie2I8RwvfiHQe5xRF8cR+fZpkwK3
 gqrjyUfebGHMeYq+9FnfQXOmP4YCstICYV9CSYW11qUpoiI6A835kHUbOuq9i0rwZ+ofwjwA0kc
 W0JQrSBuSPlMovPurtY+GuD/84FyT2x9bbODLvpuq
X-Gm-Gg: ASbGncthOC+GV83ECmAHNxBUz+nlGObSJhrk0UWk3RBveLPrTzpNgWVjKLZA2j9U2Y4
 6KT7j0RcQ3wwSwGBcDGPm465rIsIzwMShXjTUKbYp6FPxaTWJ6dr6JCoOs6ehnhxVYB8QzEu6oX
 m+SPF5aysbWRy5S2FL/qdjTdyQGN9W5HgTT0MU8kn4ipr0MT+i2ZHjJrQrp+61kzwpLR5G+GgC/
 xlZoWLBxKx/pfTPLhJ4L/DbwNLE5BmCY3mjctDknuZCZ+oNdwGrKNEUT+Y0mi5xXEVVqg==
X-Google-Smtp-Source: AGHT+IE25XtL7uL3BoaZChgVV3WG8fUPp/mzrpGFjgYHdndn3kxrd2ELWwYDWa9AVSkhkK9EdY++uQJ/Y7Gj3rIcnVU=
X-Received: by 2002:a17:903:2c0d:b0:290:2a14:2ed5 with SMTP id
 d9443c01a7336-2986a6bc3c9mr136684355ad.4.1763403395902; Mon, 17 Nov 2025
 10:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
 <CAFLszTiHVqgn5eox3p7CWt0=XjAcYMBjR7F03UqweRftZg5fDg@mail.gmail.com>
 <20251114141943.GV6688@bill-the-cat>
 <CAFLszThhPVcKhcbxA77HCwrRcq9H1+p_YvEmir3p6TEkLb1YQA@mail.gmail.com>
 <20251114144331.GA6688@bill-the-cat>
 <CAFLszTibCE57HPEgEnkVkzmcLVMbQsk5mDKP5+mrn+ZHQOGeAA@mail.gmail.com>
 <20251114185450.GA2125796@bill-the-cat>
In-Reply-To: <20251114185450.GA2125796@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Nov 2025 11:16:07 -0700
X-Gm-Features: AWmQ_bmMYkydXrCDqOFh1czIBt8x1dkl_eOWeGAYKKk-vSHF-Nm1d9fyvhRyVrg
Message-ID: <CAFLszTi0nD5Fkur8Hin5yNvQhmdj72CBV9SRzdsY=NSLK+H8Nw@mail.gmail.com>
Subject: Re: [PATCH 6/9] test: cmd/fdt: do not use fixed buffer addresses
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
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

On Fri, 14 Nov 2025 at 11:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 14, 2025 at 11:10:59AM -0700, Simon Glass wrote:
> > On Fri, 14 Nov 2025 at 07:43, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 07:24:53AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 14 Nov 2025 at 07:19, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Nov 14, 2025 at 05:31:40AM -0700, Simon Glass wrote:
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
> > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > >
> > > > > > > The location of memory depends on the board. Do not assume memory at fixed
> > > > > > > memory locations. Use memalign() instead to allocate a buffer.
> > > > > > >
> > > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > > [snip]
> > > > > > >         /* bytes */
> > > > > > >         print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
> > > > > > >         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........",
> > > > > > > -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> > > > > > > -                          (uintptr_t)buf);
> > > > > > > +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
> > > > > [snip]
> > > > > > This is adding memory allocations to a test for hex dumping.
> > > > > >
> > > > > > It would be better and simpler to use a fixed address and make this a
> > > > > > sandbox-only test. I struggle to see the value of running these sorts
> > > > > > of tests under QEMU?
> > > > >
> > > > > Removing context to highlight value of running tests on multiple
> > > > > platforms.
> > > >
> > > > $ ./tools/qconfig.py -f ~PHYS_64BIT -l |grep sandbox
> > > > sandbox
> > > > sandbox_flattree
> > > > sandbox_nocmdline
> > > > sandbox_noinst
> > > > sandbox_spl
> > > > sandbox_vpl
> > > > $ ./tools/qconfig.py -f PHYS_64BIT -l |grep sandbox
> > > > sandbox64
> > > > sandbox64_lwip
> >
> > If at any point you have made up your mind, please say so, rather than
> > continuing what I intended to be a discussion of the pros and cons of
> > this patch.
>
> Yes, both Heinrich and I agree we should be running these tests on
> hardware. Don't run them on hardware as a position has been rejected.
> You can stop reading here if you don't want an explanation.

OK. I'll discuss this with Heinrich at some point to understand his POV.

>
> > > Good, and as soon as you restrict to "sandbox" we stop running
> > > "sandbox64", it's why sandbox64 runs so much quicker in CI.
> >
> > This is a C test - test/cmd/fdt.c so it is built for all sandbox
> > boards. The restriction you are referring to here is for pytests, I
> > believe. The core of my argument is that running sandbox tests on
> > other architectures is mostly a waste of time, assuming the compiler
> > is functioning correctly. This patch is also devaluing sandbox, the
> > major advantages of which is its fast, native code execution and fixed
> > execution environment (memory map, etc.).
> >
> > At the very least, it would help to be clear what bugs we are hoping
> > to find with this change.
>
> The position of "don't run tests on hardware, only on sandbox" does not
> sound sensible in general. In practice we need to do more, not less, on
> device testing and saving milliseconds by skipping tests is noise lost
> in the time it takes to acquire a runner and clone the source code or
> even which runner we test things on. Spending time on "should this run
> on hardware or only sandbox" is time not well spent. Finally, "do a
> bunch of stuff on hardware" is still the best overall method for finding
> unexpected platform bugs. It's how we catch "some clocks are wrong" or
> "we configured thermals wrong" or "we configured memory wrong" and so
> forth.

Those bugs will not be found by this test. If the platform is unable
to reliably execute code, we should have a test which boots to a
prompt, runs dhrystone, or something like that.

>
> You mention QEMU, and yes, we will be executing these on QEMU in CI, on
> some platforms, which are our fastest pytest pipelines. But we will also
> being running these on hardware, which is my point and I believe
> Heinrich's as well.

OK I read this far.

1. If a test has *never* failed on a board and never can, what benefit
are we getting? This is not just about test time. It is also about
making the tests more complicated to deal with non-sandbox
environments. It's about the poor people who have to maintain all this
stuff.

2. Sandbox is basically the unit-test platform. Some of the tests do
quite a bit more than simple unit testing. But they are unit tests.

3. We should be clear about the goals of testing, not just blindly
enable all our unit tests on all boards.

Regards,
Simon
