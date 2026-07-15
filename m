Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9966AC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 15:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A109184B70;
	Wed, 15 Jul 2026 17:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NDlUIX4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E4BD84B86; Wed, 15 Jul 2026 17:03:19 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B1D84A3A
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 17:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba3e6so835595a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 08:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784127796; cv=none;
 d=google.com; s=arc-20260327;
 b=LVQnTOofvQcrWPEwg+MGZTunGwOWe2ujmfZzAgDQflzRF+HRJb/ldnyHzGgU7543vE
 QD4LfNnHKrKjTXdPrmU42MWM04PPo8jYjcfbuxu5m/C/F7DBW1oX/nK6keZPV8pZlHIv
 Adg9Fpb/QQZRUsiz785PJLMgYBFkL3iv6/Xuoca+BLOtTLkLGlY3ICeVdq4xmKz8+QCJ
 8sgBwfWS9rXwTHSilQkBUmqeSr0bb6Wod9jT5kiv13b+3vqcxdf999BrH9mF0H1RcfLj
 1xsZq+gEiS8zPAOXJHQ4eHHFk6D2XyXtCXGprN7yEgTbfEjG48/lXDd2bMBDNqLVfkNc
 vnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SA++Gm580RSluFTIUxzbMfJ8z+yeBb8/zAMV5UevX3Q=;
 fh=rxZd6MfFs0sj25BBlQCLbO2OdqYKVduRyrxLLVKNEps=;
 b=B5scna4Sr2unZv4tVG1ZR/1IpRg5Df5AhsqZOo8Lfzprzjw5vQ/7st6TiAstmbxzKb
 5cXbnMnl3dZG3qeD3PXdlDZJJg9/pWJ1or5VN1YET/MNDqbH8xJ1YaqpG2eT5tb9/Qid
 16hcF2dFrX8RL6lo0A7D0RjvWEQMdkr1RZ3hrpbOCLCJMI8XmBLCoZGAWSO7B+6SEhs2
 Zxmcrk/XRCQqlfndQmPOqnrPa1knCnzWHiq8a2IIZFtF/TotBl+o7Pc9z/PhSuUlkmlS
 tNXZMUzpuVnwixLfKdeNOsnNFFDEC5yu8y30f/udArf/V5fRXfhLvaP3Sf7ku1QsnxRO
 v6eg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784127796; x=1784732596; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SA++Gm580RSluFTIUxzbMfJ8z+yeBb8/zAMV5UevX3Q=;
 b=NDlUIX4HCl6Y8w6fM2CUB+blrhCbbwzHOCYF5rrG954L1zKuEJZubvsS+tYd1/Nz/S
 p0P/ahZ05c5xTg3p+AGd4wy6nBR4YicYRX/1qVVIbqKFYuMmnng8T7bAkjtwFU7kSC6E
 ypf1II22tsAmd2Qa5iVGUozLKnTGQxB28yIww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784127796; x=1784732596;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SA++Gm580RSluFTIUxzbMfJ8z+yeBb8/zAMV5UevX3Q=;
 b=KLSVvHySyGjMqE+fXaxtPD37hpqfd9Q9R92xTDWJGjJnV9/Sdv2gJfq+svMg6sDMYn
 2TNrx79HBwzhIBLcmk1QGU68Rg0qOxnb3X9D80FPny5unHh2N3qUXt40+4MyTCXvlVTU
 xa+oWGGPhYErfCgxetr98u8o1VMvZLt/qmSeS2m4e5B+E3DLXGHjXLcPXN0L2y01+cTU
 jAd1w3NVepEyRmcWPt7S4dscFmT9YF3Typt2yKPWdZbtProz6xy83I3vRmKuHwRZa0vI
 ubcUhABU1hVUPK/cg0oV5jwU+pysWlzpfEM/r4WZqwbbiekB20fiy+wzeZM2NfNd83gm
 H6VA==
X-Gm-Message-State: AOJu0Yw2zWCYnW2+OxlFK1/qusHiFrIrpdl7avTTfFXPD10/lTXMg86h
 vHR/0n6fi7R/4Q28TLYRMOTgbfrdVcnHxeKaEU3UMq3+/4eVN33ci/VsG0+MSlDrCOcgW3p9LZm
 RHGjfo6D40ww2AsqBnBwWryLeYeNPEacPWtLfoWqXyvyHcNtGPK3Mc6X6
X-Gm-Gg: AfdE7clTXIa99+QqTe6I0/KaoVvpduc/mq2JFbVpziLZTTSUo0HAFVnPks7t8EPp1BP
 KbJTXiB6OmVpXaEXaj7iZFcOmS+kFVDxd2kLgZf2iC2OdV26gpF70JqIJAoO1OFPsrOC1SuHP2B
 Dh5Z1ozhO7+j11YeZ7Z+3Hs46TO9bcw7fN9om4oAuXBII3X5cfMhW09nuqdmmKEtNZZikfX0idc
 0o7zWDZ8YG+VkBUtMOjbbl5IjpPsaczoTq0/KxDQadbZVyOfc7T5t8HENY1FPqow8XwOFY=
X-Received: by 2002:a05:6402:915:b0:698:9251:2f72 with SMTP id
 4fb4d7f45d1cf-69e1a0494e4mr2105732a12.35.1784127796102; Wed, 15 Jul 2026
 08:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-binman_bootph_fix-v1-1-3603996799e0@ti.com>
 <CAFLszTg5Qu3stt8AkeBpWibTyYxp1tXAern3aLE6MEHkHmVRyQ@mail.gmail.com>
 <DJXETQLM9PQP.C2LCLMD6LMI@ti.com>
 <CAFLszTg4hhLezFpkvkHY9qK_WQ8xfcRi8AWx2RcVkAeP+RPMvw@mail.gmail.com>
 <DJY1KP97NN91.2F605W5BR722H@ti.com>
In-Reply-To: <DJY1KP97NN91.2F605W5BR722H@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 09:03:03 -0600
X-Gm-Features: AUfX_mxyl_5MVhW4L4ZV2rI-p1SzwZH9xizIWxQ7NGwN88ueocEBRp8TQwL_QxI
Message-ID: <CAFLszTg66dNp9c8SC+4tfR25L81cNBrUet9f67Kb+nmOd1v-Dg@mail.gmail.com>
Subject: Re: [PATCH] tools: binman: fix changes not being written to source.dtb
To: Anshul Dalal <anshuld@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Mon, 13 Jul 2026, 23:24 Anshul Dalal, <anshuld@ti.com> wrote:
>
> Hi Simon,
>
> On Mon Jul 13, 2026 at 7:43 PM IST, Simon Glass wrote:
> > On Mon, 13 Jul 2026 at 05:34, Anshul Dalal <anshuld@ti.com> wrote:
> >>
> >> On Fri Jul 10, 2026 at 12:44 AM IST, Simon Glass wrote:
> >> > Hi Anshul,
> >> >
> >> > On 2026-07-07T10:44:09, Anshul Dalal <anshuld@ti.com> wrote:
> >> >> tools: binman: fix changes not being written to source.dtb
> >> >>
> >> >> In the current setup the changes done to the dtb by binman such as
> >> >> bootph propagation are only made to the intermediary *.dtb.out but not
> >> >> the final dtb.
> >> >>
> >> >> This means the final dtb that's in *-binman.dtsi never gets the required
> >> >> changes applied. Therefore this patch fixes the behaviour by writing to
> >> >> the supplied dtb before exiting with a modified test to catch any future
> >> >> regressions.
> >> >>
> >> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> >>
> >> >> tools/binman/control.py |  3 +++
> >> >>  tools/binman/ftest.py   | 41 ++++++++++++++++++++++-------------------
> >> >>  2 files changed, 25 insertions(+), 19 deletions(-)
> >> >
> >> > Please can you spell out the concrete symptom? What breaks in a real
> >> > build when u-boot.dtb doesn't carry the bootph propagation - which
> >> > stage reads it, what does it expect to find, and what goes wrong when
> >> > it isn't there? The *-binman.dtsi reference is confusing since a .dtsi
> >> > is a source file, not something written to.
> >>
> >> The actual issue was observed while we were adding support for our a new
> >> platform 'AM62l EVM' to U-Boot where the missing bootph properties meant
> >> that the parent drivers were not being probed leading to boot failure.
> >>
> >> >
> >> > Also please rewrite in imperative present tense: 'Write the modified
> >> > dtb back to dtb_fname so that ...' rather than 'this patch fixes the
> >> > behaviour by ...'
> >>
> >> Yeah, the former is more clear. Will fix in the next revision.
> >>
> >> >
> >> >> diff --git a/tools/binman/control.py b/tools/binman/control.py
> >> >> @@ -677,6 +677,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
> >> >>          dtb_item.Sync(auto_resize=True)
> >> >>          dtb_item.Pack()
> >> >>          dtb_item.Flush()
> >> >> +
> >> >> +    # Copy the intermediary dtb ('u-boot.dtb.out') to the dtb supplied to binman
> >> >> +    tools.write_file(dtb_fname, dtb.GetContents())
> >> >
> >> > This is updating an input file...really not keen on that! The updated
> >> > dtb should already be written into the final image created by Binman.
> >>
> >> Perhaps it's an issue with how we're using 'u-boot.dtb'. As I see now, a
> >> lot of platforms (including TI's) are using 'u-boot.dtb' as the fdt for
> >> U-Boot FIT. Do we not expect the final U-Boot FIT produced in those
> >> builds to have this propagation logic applied?
> >>
> >> To test things out, I built the am62x_evm_a53 platform and the fdt
> >> extracted out of the built u-boot.img lacks proper bootph propagation
> >> without this patch applied:
> >>
> >>         fdtget -t r build/u-boot.img_unsigned /images/fdt-0/ data > extracted.dtb
> >>
> >> It makes sense to not modify the input files so then should we change
> >> the DTB we use in the u-boot's FIT to 'u-boot.dtb.out' instead of
> >> 'u-boot.dtb'?
> >
> > Possibly, but are you using Binman to create the FIT? If so it should
> > use the updated FDT. This might be a hole in how Binman works?
> >
>
> Yes, we are using binman for FIT creation here.
>
> I'm not sure what's the correct behaviour here either, in our binman
> DTSI for the platform (k3-am625-sk-binman.dtsi) we explicitly set the
> fdt-0 for the u-boot node as a blob-ext with "u-boot.dtb" as the
> filename.
>
> Since the same file is given as an input to binman and we don't want to
> modify the input files we have two options here:
>
> 1. If 'u-boot.dtb.out' is known to be the fdt outputted by binman with
> all the fixes applied, we could just use that instead as the external
> blob in fdt-0.

You should really be using the built-in u-boot-fdt entry type.
External blobs are just for blobs built by other projects.

>
> 2. We could have binman detect a node as 'fdt' and apply the required
> fixes in-place before spitting out the final 'u-boot.img' FIT.

If you use u-boot-fdt then you should not need to do this.

Regards,
Simon
