Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58069C369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 13:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0F28082A;
	Mon, 14 Apr 2025 15:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DS4q6CyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40C1681B4B; Mon, 14 Apr 2025 15:08:16 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 753638004F
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 15:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso4460947a91.0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744636092; x=1745240892; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iyO1vQoOYYX62liAosa/pCt8Lci3aP10k95ZlF/i7Ko=;
 b=DS4q6CyVft0RCJB0v350RVTNH5DihxnfnnocInINc4ELe5vEiG+onnD5srQUnG0CAI
 jzCjO5G9NyBytFR91fygYbvN1gah52Gk/PooXWmRTSqGY1ETNN5wHtHA/m5axD440WLf
 xvhhjTY2nIluHBaoyD7bWLzocrj9LOZ8nrfe2hnTxsixSToUE5gpMY5j+kpRj5QU3AhX
 wY71ReWc8mnZvD/oxkGNE5qUoaNznlqvTxK6VwXmet9TzlrBs3pFG91/UuiH5xRPWvcu
 EFp1bRNhgDSziflMOHFNawSVZQEedFchof83WD2lHq7PQQt4CIGEMZ2cT49XUvFOVM+1
 9fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744636092; x=1745240892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iyO1vQoOYYX62liAosa/pCt8Lci3aP10k95ZlF/i7Ko=;
 b=fhlAcri2cZBgZKnQs8sh5L1M5OgKHsRwHBKYa4ne0RotXFenYaiUVorFkKpGLeg20p
 +WyolamcWwQ+gvJzLLcqAyHPBaXDscw6w5ZAbHMIH5UtvNBEEh4v/FHW8lzhwolq3BPf
 V/2ieJ19yTgYhxr9Osdrr3j07j7as6SmjIZWysXNycjRZhawWfdXEBpf5G5ROgOPNV0O
 TTXJY8Donw3h5k6bOrXwolXyrpFsUch/jJHlMgFtTWRoIdz7GFakQdDspKnjVbfmMORX
 LwL3fPwJ0epgKfk/t8puYFAW30yFqJgAbOc+g6Frdg9tZKU/tQJTaDEpIPEhOT1jOOD/
 lLHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjn8oa2U97DxB0C479LDNJBU3eAWrpE736cFhnuSwIvLcMEs9cdsXQxkW0AtEEh9qAuhdbSs4=@lists.denx.de
X-Gm-Message-State: AOJu0YxuflwEry4HCVj8/H2c/dQfTzkkt8rDeHChYyDaXnrn03gj/Uxy
 x+OsEm6Y2zd6fE3rFFeRUYQAcuB92SUS3ei/7LlGk9HMOSZ05vdOKFPbpV3+OzlJxB+X0HJlMRg
 mv8v7Wme07nYxlaUOwzqHQ7CyyuzOzRSamuA0IA==
X-Gm-Gg: ASbGncuzW8Gn3iX/W7tgzBabMToFbpHwCU6FYfVFv0JsXMZ3XV9FqlAzk2f5HTYSQ/p
 c2wH1G4IXliTHzGFsivjd+5qXOYY8OEA8gOFz+1lKN1JZX74krzUbbKBX+jPWxGYqRjDj61oiZk
 5g0ESmXW+5c8kqZbrBhILZ1Ek=
X-Google-Smtp-Source: AGHT+IE555RihThIpjgiIPU4TVtRFpW9q72n+kZJcP+f4LzEVpiaotDJdtOyHf+iuq6yViOpv0Mu/hv56bwy95avQeE=
X-Received: by 2002:a17:90b:58cf:b0:2fc:aaf:74d3 with SMTP id
 98e67ed59e1d1-307730fecb0mr21998635a91.4.1744636091721; Mon, 14 Apr 2025
 06:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
 <20250329000211.GH93000@bill-the-cat>
 <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
 <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
 <CAFLszTjo8HEzKbZAbO=neF57e69vGbWYsDVV_dD=kO6j_VH39w@mail.gmail.com>
 <CAEfUkUJNUhoyRY6S9-eYV5i9RT_GgYLRs+HRWocch8jYfVj2Lw@mail.gmail.com>
 <CAFLszTj-pQSK_aKNoLUcLFBk+wAjgC_5=-5YRPGt_7DDFRL3Dw@mail.gmail.com>
 <CAEfUkULcgK9jY902Ccf_mNNCHf5m1BU=ecLK7cuviv7TdABukQ@mail.gmail.com>
 <CAFLszTi7CmWL7pxAp08gy5euD8vKs1qN5DOzi-J=9c2dZ7hFMw@mail.gmail.com>
In-Reply-To: <CAFLszTi7CmWL7pxAp08gy5euD8vKs1qN5DOzi-J=9c2dZ7hFMw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 14 Apr 2025 09:07:58 -0400
X-Gm-Features: ATxdqUH9Xk3ELbz20Gqw5DV_990KXSMm3w8vDBQAAgCGfPNSAi928Se0UFabxFI
Message-ID: <CAEfUkULOyojCztUzuG5Li2i8Bd1bK0rwPk7L8A8h4LxiCjW_JA@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
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

Hi Simon,

On Sun, 13 Apr 2025 at 17:13, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Mon, 7 Apr 2025 at 08:08, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Sun, 6 Apr 2025 at 18:06, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Sat, 5 Apr 2025 at 07:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 4 Apr 2025 at 13:40, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Raymond,
> > > > >
> > > > > On Sat, 5 Apr 2025 at 03:49, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > >
> > > > > > Hi Tom and Simon,
> > > > > >
> > > > > > On Fri, 28 Mar 2025 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Tom and Simon,
> > > > > > >
> > > > > > > On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > > > > > > > > >
> > > > > > > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > > > > > > so that it is simpler to understand and manage.
> > > > > > > > > > >
> > > > > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > > > > > > >
> > > > > > > > > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > > > > > > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > > > > > > > > be resurrected to give some coverage.
> > > > > > > > > > >
> > > > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > > > > > > > >
> > > > > > > > > > Based on how it's documented to be run in
> > > > > > > > > > doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> > > > > > > > > > that platforms using the handoff spec still work?
> > > > > > > > >
> > > > > > > > > I believe so, yes. I don't have that board to test it though. Raymond
> > > > > > > > > may be able to test this series on QEMU?
> > > > > > > >
> > > > > > > > I was pointing you at the docs so that you would have access to testing
> > > > > > > > it. That's part of the docs, running the emulator.
> > > > > > > >
> > > > > > >
> > > > > > > I can help to test the firmware handoff on qemu.
> > > > > > > I have all the necessary changes and unit tests for the OP-TEE repo
> > > > > > > qemu v8 build to test this.
> > > > > > > I will try to find some time early next week to review and test this
> > > > > > > series before turning back to you.
> > > > > > >
> > > > > >
> > > > > > Just a follow-up on the testing with TF-A and OP-TEE.
> > > > > > Unfortunately, the patch series breaks the transfer list handoff to
> > > > > > U-Boot completely and just end up with below error when U-Boot boots:
> > > > > > ```
> > > > > > No valid device tree binary found at 0000000000000000
> > > > > > initcall failed at call 0000000060097bcc (err=-2)
> > > > > > ### ERROR ### Please RESET the board ###
> > > > > > ```
> > > > > >
> > > > > > U-Boot test version:
> > > > > > 'next' branch + this series + my patch [1] to point fdt_addr to gd->fdt_blob.
> > > > > >
> > > > > > [1]: https://lore.kernel.org/u-boot/20250331224011.2734284-2-raymond.mao@linaro.org/
> > > > >
> > > > > I suppose the FDT address in the register is not being read correctly.
> > > > >
> > > > > Do you have a test case for this, e.g. in QEMU? Even if it is just
> > > > > binary blobs for now, not suitable for CI, I'd like to get it in my
> > > > > lab.
> > > > >
> > > > > I did create a test back when I did standard passage, but that series
> > > > > seems to have not been applied. I'll see if I can resurrect it.
> > > > >
> > > >
> > > > I am using the OP-TEE repo [1] qemu_v8 build to test. You will also
> > > > need my patch [2] for enabling transfer_ist in all components.
> > > >
> > > > [1] https://github.com/OP-TEE
> > > > [2] https://github.com/OP-TEE/build/pull/821
> > > >
> > >
> > > Tom's email seems easier to follow. I got as far as building:
> > >
> > > build/fvp/release/fip.bin
> > >
> > > But I'm not sure how to run that in QEMU. The docs mention some sort
> > > of FVP thing and running FVP_Base_RevC-2xAEMvA -C which I don't seem
> > > to have.
> > >
> >
> > If you want to test with QEMU v8, just simply:
> > $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
> > $ repo sync
> > $ cd build
> > Apply my patch https://github.com/OP-TEE/build/pull/821
> > In kconfigs/u-boot_tl.conf, remove 'CONFIG_BLOBLIST_SIZE=0' and add
> > 'OF_BLOBLIST=y'
> > $ make toolchains
> > $ make run
>
> Thanks for the steps. It seemed to complete OK. I also found this:
>
> https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
>
> But I'm not sure how to actually run it, or even what was actually
> built. Do you have the QEMU cmdline I should use to make it start,
> please?
>

Besides the steps I mentioned in the previous reply, you will need to
checkout your U-Boot test branch after "repo sync", since by default
the manifest is pointing to an old release.
"make run" will start the QEMU automatically.
If you are not sure it is built properly or not, you can use "make
all" to build and "make run-only" for running.

Regards,
Raymond


> Regards,
> SImon
