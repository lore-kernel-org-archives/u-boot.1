Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515D4C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 09:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868FE82FE1;
	Tue, 27 May 2025 11:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fTanlzIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8237982FE7; Tue, 27 May 2025 11:20:50 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1706C82FAB
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 11:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70e4bd65106so16495627b3.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748337641; x=1748942441; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2m65nF4UcLHMwgs3cbSbDBtY/vSr/mGkGgqfnthzUHs=;
 b=fTanlzIVBNWKO23o8nE918eOjYhCvxbO5IHqOAaB62qQJpQ72f7lzV+rCCLsAQqLS6
 SW6g5e2fTd7Ad4VP8L/K3YRF6OaiW3NkNB500b2A2vyRCHKYYnQANRs1lYB5XpjD+Qph
 Uc42+pt1hhpMw/uu+SmG+3YkV07N0JWgbjtAKc/zN5JB07TCTi8CPfDKN5zTtCY4GAS1
 bL6DS9wdSvYgv0Nw0a/G5cfrmM5OUa1eWSSEx6zf9LtjrX4aBkwTdpixJwYUeK92h57B
 v6e4tVsVeDVzQZTnGO+rCEWnmHjNbGHp0EBXNCC+P2wEx0fHp0vXxAvIk22LvkZtA8bP
 sQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748337641; x=1748942441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2m65nF4UcLHMwgs3cbSbDBtY/vSr/mGkGgqfnthzUHs=;
 b=iSQZpaRKTadraaP+MHWjpYt4NxdqSlJCUnFE030dX0ONaTu6opKs1rPVbkBAgJbr+W
 tk6YA2n82QXajExWCRJbZxTFD06yC3FIXBu2p1FWEnuEuqVZd1uQvgW8//l19yCiY7Mg
 HO9e/MN+spweiKeHUVcdiF820/YefANfuhgiSA9M1oXm7jDvmPYJ0wDKYEit0nhmAFtZ
 PeTcJnPE6bjMfTVzCibYzqwHUy8N3NTxDj9HNSaPbOTnsVRUgXYTKe3F0jaaMStJeIeX
 76XzXjeN1F6E+jLZ1NOQQjFKAekexUI40Xvw9I8kVilQR5gwykhfS8kjeQdgvGgmYr8m
 GafQ==
X-Gm-Message-State: AOJu0YyWUBp7l8HqBjfSrNyH/8zo0IxW2GFUzOk2B7q2hDeYbUwGyDA3
 aBd2Lgy6NoMYKlWdX0QphI33ZiwPdSxsuxajuM2ZHG5Jh/cRf3DVq6oKPGuOIZ9Wm09PXGNYnRM
 NxbSIuPuFBrD7CFA86GfsRTzBoQidMAyEMWigd9QS4mo7mPyck4NF
X-Gm-Gg: ASbGncvNMmbH2XYC0mdAwpxZr2qRNruRE85s6/J+97SWK2wLBF9ZEkRNbduABmuIMR1
 IadqLhIynEUM5+2Jy9hTpDlBoyAoNfwkcWfHq1YUHkVJfrWSjqI58FwBMRPck9CAjVI68Ph2MfR
 sqVCy8Uw8V9LTemLgLoy9mLrAdxCm5C1J2YQQ2EnPkfn7z
X-Google-Smtp-Source: AGHT+IFbRorUyDykrxQMjxbb4HWKePkesPeTjZrIOTFMIpW6Ru2ePnPTmxc/+68DP4j9tKabQM/DCudPoaHNXb0stkU=
X-Received: by 2002:a05:690c:8c06:b0:70e:23e6:60f7 with SMTP id
 00721157ae682-70e2dabb3a3mr107892827b3.27.1748337640856; Tue, 27 May 2025
 02:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250524120904.684977-1-sjg@chromium.org>
 <CAC_iWj+XfkWPj+R1JUc0ZPFatRtpMso-Lw+uYzcgcbuKPuV3Dw@mail.gmail.com>
 <CAFLszTho++gscP4rUUY354iyVWFyPkZeMCpa-TpX0GaWOQzQvw@mail.gmail.com>
In-Reply-To: <CAFLszTho++gscP4rUUY354iyVWFyPkZeMCpa-TpX0GaWOQzQvw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 May 2025 12:20:04 +0300
X-Gm-Features: AX0GCFtVPvRyMGi8eQbGxblJ3Mrd-k10fn0CSFzWNk_JdnMzQQvsASIUebef2tE
Message-ID: <CAC_iWjKjZ-Q_hreO1Z64AFBWXOHB_YB_+Au_9psecVO+ATE_Pw@mail.gmail.com>
Subject: Re: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, 
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 27 May 2025 at 11:20, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Sat, 24 May 2025 at 19:13, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Sat, 24 May 2025 at 15:09, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > A previously rejected patch to move the EFI public cerificate out of the
> > > devicetree has recently been applied. This series reverts the change,
> > > pending further discussion as to why it was accepted.
> >
> > I spent a good amount of time, writing the commit message an
> > explaining why this patch was sent
>
> Yes, that is [1] and I did read it carefully before sending my series.
>
> From my POV there are two things wrong there:
> - The signature is not an internal U-Boot ABI.

It is, as it is for every firmware that builds out there. EDKII does
the same thing.

>  It is how U-Boot works,
> so if a build systems wants to inject a key it should use that
> mechanism, not add a new mechanism into U-Boot's build system. If it
> would help to have some documentation somewhere which says this, I
> would be happy to send a patch to add something
> - QEMU is blocked from accepting devicetree additions due to another
> Linaro employee's refusal to accept a patch[2]

It's not blocked. It has been NAK'ed and IMHO for a very good reason.

>
> > (which btw wasn't 'rejected', you
> > forcefully reverted it back then with no agreements from anyone)
>
> The original series [4] was applied (I believe accidentally) against
> my objections. Heinrich pulled the revert [5]. I went ahead and did
> the QEMU patch, to help with your issue*.

Heinrich applied the patches initially, and you send the revert, that
none of the patch reviewers ack'ed.
You reasoning back then is that the RO functionality was moot, because
we didn't have it. It's here now.

>
> > and
> > why we prefer to do it this way. tl;dr early boot loaders that pass as
> > a DT is a problem now.
> > If there's a good reason to revert it, please explain it on the commit message
>
> The reasoning hasn't changed from the discussion three years ago -
> please see [4]. There's also lots of discussion on your original
> series and my revert, e.g the cover letter. A highly relevant part of
> this is that devicetree is where config should be stored, so the build
> system has control over what is placed there.
>
> But in any case, it isn't right to send the series again, under a
> different name, e.g. not mentioning device tree.
>
> [..]
>
> Regards,
> Simon
>
> * The QEMU patch is still outstanding after three years. Could you
> please talk to Peter Maydell and see if you can get this resolved? I
> have sent it twice since, most recently in April [7] but there was not
> even a reply.

Because they NAK'ed it a few years ago, and aren't willing to take it.
I don't think there's anything to discuss and for the record I agree
with the QEMU maintainers on this.

Thanks
/Ilias
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250401112729.2181793-1-ilias.apalodimas@linaro.org/
> [2] https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
> [3] https://lore.kernel.org/u-boot/CAPnjgZ2uM=n8Qo-a=DUkx5VW5Bzp5Xy8=Wgmrw8ESqUBK00YJQ@mail.gmail.com/
> [4] https://patchwork.ozlabs.org/project/uboot/list/?series=253693&state=*&archive=both
> [5] https://patchwork.ozlabs.org/project/uboot/cover/20210802144431.2396678-1-sjg@chromium.org/
> [6] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191352.2597585-1-sjg@chromium.org/
> [7] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191352.2597585-1-sjg@chromium.org/
