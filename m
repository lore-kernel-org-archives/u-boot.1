Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151FFCE8D6C
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 18:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF84842A1;
	Fri, 14 Nov 2025 19:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F1KdBGAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EFE0842E0; Fri, 14 Nov 2025 19:11:14 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA8BC8429E
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 19:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-64198771a9bso4287838a12.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763143871; x=1763748671; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NbwFz7yAPRVqNc9bKGSfYdX4EkH8hxj/joxVAujy84I=;
 b=F1KdBGAcVDPbkGb/fjQJSgTFyiiFUCjZOSmvh1qh8G+dP9qXQ/fH0zg5L5ySVDn0o4
 dZMfgna2p3p8wxuVGbZGgai8fF7NfFPYw+B0OPTjjPoHw9M8ctHerUWth3nFKA0Mi5oD
 gUqqIvujl5BeejROJuJLWdBhZuLpKnc93awNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763143871; x=1763748671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbwFz7yAPRVqNc9bKGSfYdX4EkH8hxj/joxVAujy84I=;
 b=YWT7MpgHkA6oZzKflHe/QN7LPbOYZTObq4nh4Ikc+HryZIR3OslOvnFTv/1ueo9rrH
 IJOaw9BmANsrJumoktNo611j+myaB7FvYs3uzHaDTPM1esO4UdqItlholwsDtxld2eHn
 mg+pkAaTQKzvlp6ZHpHxoXQdgcf81lv484E6vTdi/RwgtO7bDxJUOyTeCYDBMKaj+i22
 TSHMfLmhLjXVX0WdFnGxW0iL8uGCdzR7JOpPgA6kEPoDT6vZjCuKpk0U2mp6MN9BewGI
 n2Y8WG12kBBoIqwccPnc156Tfm8hEpTHTKh5v/KfYvADblhhe45MTLuniKNv58kR7xwm
 eKpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAZ9IyYUPL12FMFfozbQwK0q5qLjBMg+opyuUV5Bk7W0dAfTmt5oSqx4o041WBXk5S/tiEcpU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+dzMqLMPK2fhWzrwpZc9x45FDsQAfcQzSoe2Rnb6I6Z/VZBgC
 o7r+8h5Vspr9E6peJ19UrV+/AmBKM2z17nJjcJWszmiIf78mrirHIPWYLXCqNu4EWP/xoQtDPR4
 iYUKYfHyZj619KBta6lAVgdFRXfVHVDpJObX13y/9
X-Gm-Gg: ASbGncsRhPglIztkz3Igggcf61tVPJ72j8/pol8IPnQm0Vkv2UattbWxf2A4v9OmFnO
 zOK5C2shnarcew/8S3Wb+3x9Seh+rBJqP8eKZ9iWaGhEHJNDUz2M/N3L0POQ+P4NsFviqaDIvhj
 oR1QM2nf+CJ+AjpvyVWyqvf4ixSxADS3eCAOMVOLb8wcZuHdDO1+Qm2pOkOGue5fDEyiCMg9hLW
 J2BMJwHsDBbuYR09SiToBu2+qNpCQRIB/DIc46WWRvQxqGr7x/cxrN/zywPYmW9UrNqcQ==
X-Google-Smtp-Source: AGHT+IGhA04YX7lvW6xHyqbC5VClJYyhzwmBahBcwEjz07sTne+gpUxqPgkNVrm8NOBJwd0y2uDe1PSj9g6KBgL158I=
X-Received: by 2002:a17:906:dc8c:b0:b70:b077:b948 with SMTP id
 a640c23a62f3a-b7367badec8mr423135366b.35.1763143871018; Fri, 14 Nov 2025
 10:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
 <CAFLszTiHVqgn5eox3p7CWt0=XjAcYMBjR7F03UqweRftZg5fDg@mail.gmail.com>
 <20251114141943.GV6688@bill-the-cat>
 <CAFLszThhPVcKhcbxA77HCwrRcq9H1+p_YvEmir3p6TEkLb1YQA@mail.gmail.com>
 <20251114144331.GA6688@bill-the-cat>
In-Reply-To: <20251114144331.GA6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 11:10:59 -0700
X-Gm-Features: AWmQ_bmDNt6b1GA8-S4PSLOijYfqDT40yTSJaRN0yq_WIZ6uvHVL2JD23VBdXJ4
Message-ID: <CAFLszTibCE57HPEgEnkVkzmcLVMbQsk5mDKP5+mrn+ZHQOGeAA@mail.gmail.com>
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

On Fri, 14 Nov 2025 at 07:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 14, 2025 at 07:24:53AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 14 Nov 2025 at 07:19, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 05:31:40AM -0700, Simon Glass wrote:
> > > > Hi Heinrich,
> > > >
> > > > On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
> > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > >
> > > > > The location of memory depends on the board. Do not assume memory at fixed
> > > > > memory locations. Use memalign() instead to allocate a buffer.
> > > > >
> > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > [snip]
> > > > >         /* bytes */
> > > > >         print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
> > > > >         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........",
> > > > > -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> > > > > -                          (uintptr_t)buf);
> > > > > +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
> > > [snip]
> > > > This is adding memory allocations to a test for hex dumping.
> > > >
> > > > It would be better and simpler to use a fixed address and make this a
> > > > sandbox-only test. I struggle to see the value of running these sorts
> > > > of tests under QEMU?
> > >
> > > Removing context to highlight value of running tests on multiple
> > > platforms.
> >
> > $ ./tools/qconfig.py -f ~PHYS_64BIT -l |grep sandbox
> > sandbox
> > sandbox_flattree
> > sandbox_nocmdline
> > sandbox_noinst
> > sandbox_spl
> > sandbox_vpl
> > $ ./tools/qconfig.py -f PHYS_64BIT -l |grep sandbox
> > sandbox64
> > sandbox64_lwip

If at any point you have made up your mind, please say so, rather than
continuing what I intended to be a discussion of the pros and cons of
this patch.

> Good, and as soon as you restrict to "sandbox" we stop running
> "sandbox64", it's why sandbox64 runs so much quicker in CI.

This is a C test - test/cmd/fdt.c so it is built for all sandbox
boards. The restriction you are referring to here is for pytests, I
believe. The core of my argument is that running sandbox tests on
other architectures is mostly a waste of time, assuming the compiler
is functioning correctly. This patch is also devaluing sandbox, the
major advantages of which is its fast, native code execution and fixed
execution environment (memory map, etc.).

At the very least, it would help to be clear what bugs we are hoping
to find with this change.

- Simon
