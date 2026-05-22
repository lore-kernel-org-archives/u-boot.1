Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9ECCD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 332FF84852;
	Fri, 22 May 2026 15:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="WqYitcIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC88D846A7; Fri, 22 May 2026 14:38:22 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C144841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 14:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-95f2b0bd920so5594381241.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 05:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779453499; cv=none;
 d=google.com; s=arc-20240605;
 b=Q5oujnffrzOO9kR2NhacLrqlqWF8Mp9OEavbHUFzlHxBKL+Lik9g47Pw/c4SXrvFxt
 UVonkhPrKk7LF+sFSSzCQvwf2MPCIIheKp5pizQ81uGUPIzkqTExvaR96xBv5FSZCK9Q
 FrHTyXQt0OMmWtT5oUrqIv3L0sC0z6SN+Fi+HdItrifr3DLkO51/OhE811S6rQhuGxcb
 lR4y6Q3m7g2EKOEKt0n+SkwCMdz5YcFtLF+J4RdKCGuHL4yFrcwIIl/Z3JWxMxCxvwAn
 2BeQTz0nw1y04CCeKUtNseVjiW7LN9Eo0a0SoDfBpwtQczepA7mJQh6wE/GBKFQ9NFUf
 mg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1cAvZUA3QjM2t0W+MNUINHMVCpZ5Oo15GZq2nqHV3cs=;
 fh=tN9KwEd8WMWZJqUQPcNWpVRAQiFf8uBAmwm35dpBfzo=;
 b=SO0Ln0wjCuM8tQd0LSA7oIOF1Wm1hHxQEKStoU8eEzXa06LlLD2HeFpqSur2Zga6gv
 HhmtihMmhh4N4uC/zRby78jNvJ7DlSMEHRk/WeHfg4vyM1rZogbr1Jg6ElO4rCdZcNh/
 Mx/iUKDnrSAxl7J0TcAt0U217H4GzHHVfBye3d7RKKpQclrsF8XMmShtnGHU+NohPUqm
 8VJgKTIzsH6To5waB1PdK3RQviM+bib3HnCuF+Fg30Dl7ANYFYyoqFaWGBYQfWy/AcS8
 t5Uta5c+wjyWKCqJAFkmth8W2DsuiIT6OZQ3zC2U1c/Tn/FgPuJvMgu5IreplR/bX+iH
 mW+g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779453499; x=1780058299; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1cAvZUA3QjM2t0W+MNUINHMVCpZ5Oo15GZq2nqHV3cs=;
 b=WqYitcIsIwxoesVDVMme9k/KGbAvOp4XXJh8StDSkB3PWlphGwR91mflEd2M1aQ2p6
 aQ4G9/needD0wF+nvlMBYhnT741pQ4r2Z5u/FR3COtFVAa2KQhSKMDxEkF7WtOmIFoY0
 rGTKxMZutPbvTp00zVTmZBXutMRHcS6IJie3DF4LeY4M+OYGJ4jHN4QWvpEnQ22vpvY5
 4PSOwxpTpK8+OgQouIX2HxvbSlOEan3wXrw2/Xw9Va50hs1weF4LPS4Ys6k1ScHpN1wV
 aYOaL6QyFU8O1krj/UUAvqCd39/x+HVwFUOtydl2WFOp1elOUmpW+znc9/55CoYFEkP4
 F7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779453499; x=1780058299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cAvZUA3QjM2t0W+MNUINHMVCpZ5Oo15GZq2nqHV3cs=;
 b=o/Fg9IeWJA42WCnxCC0OxFq5w9aw7gexcXpQqmVhRwh1sWVxnUbReKagzjNP85EYSl
 KUjG5szTzzgQlX7IEs5y6xDKBITT53ygnxQt5n5EO12CFoO9AUbfWeE3NKhguRoCx2vz
 tzZORjEa3/dKnMy91VXDkyau03g//+KNyAlFcQKqfEN52XR8tFWrmsj3C+R/HSQVT4pN
 AiaBrBKvCZDClXYvngZj4BCqZarqRTeu5/TV+siHIZHHSZxFs9LN/sDRwYaNVSEWjMI3
 l0OObPQgfhQ8Xj3xkJqkQ8VqrZdrEpkjKjcv0Wtq2lZJYth720J9dqwhqFqGJpbHqh+u
 Z1ow==
X-Gm-Message-State: AOJu0YzWM0TwNYExVGyU/VaWZOlrFogDJsQQjZoCZaXu40QXk9jJrsXH
 8oYD3GlKnEAlE5MBzJhzAAQn7JJG2OTSg0xb5/YQB6DAWh+SNWE1TEhlfOFVf3qEag+52QeNxzM
 lD5i9iaKZ4tryqmQaZrh+uy/LG57BYrEjCb/9pHm69A==
X-Gm-Gg: Acq92OFnOAyAdBMDwQ8BT/PLoDRSnjFPzugWsMtR1TqupAg7Buh7YKyCzp8ce5e9/c5
 frufRJZzwTZZB7vrWmXFpfciE4WeMzIpt2a762Km2A/KMBfzORhTK5/gkVdOwcw1/KYkTTBSCRN
 s0tqd5t7i/vCZ04mhvuImm2pNWgFN0QUZNViF4yfBhaiBncIZ21+kwuyPj1MFJGuw2ryO0QDwn/
 6HjbLcimex7kDIMvDXTPxeEk4TspC/L8D1ExdcF9ZgrgtJUxzO+dDXNY6q1jFeOkHcH5NofYzHZ
 2YrzU7c=
X-Received: by 2002:a05:6102:809f:b0:632:5db8:f672 with SMTP id
 ada2fe7eead31-67c8547c41emr1302646137.6.1779453498791; Fri, 22 May 2026
 05:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAPWaX55jG=pc+SD09V_z4T5q8qBcetZ8OJeKnrDF6w7pQ=tr1Q@mail.gmail.com>
 <20260520143639.GM1858239@bill-the-cat>
 <CAPWaX56ZFuBYURp9m7HMjYf25_sDA2dpEP_8H1h6Z0=ke=_0xA@mail.gmail.com>
 <20260520160945.GN1858239@bill-the-cat>
In-Reply-To: <20260520160945.GN1858239@bill-the-cat>
From: Anton Ivanov <anton@binarly.io>
Date: Fri, 22 May 2026 13:38:07 +0100
X-Gm-Features: AVHnY4IUFrBMVhdNMtsV7z6_EbDAOQq3DNBkJiyk9px-K9BzVzvY_9O81GueMT4
Message-ID: <CAPWaX57UgAPOEL3sA66D+B6zJ8icPWCNG_YOyCQQyMLMLFQDOQ@mail.gmail.com>
Subject: Re: Multiple vulnerabilities in the U-Boot FIT image signature
 verification logic
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Vulnerability REsearch <vr@binarly.io>
X-Mailman-Approved-At: Fri, 22 May 2026 15:09:24 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

All the patches have now been sent:
[PATCH] fdt: Check return value and len of fdt_get_name() calls =E2=80=93
fixes BRLY-2026-037 and BRLY-2026-038
[PATCH] image-fit-sig: Check that the strings region is within bounds =E2=
=80=93
fixes BRLY-2026-039
[PATCH] fdt_region: Check the return value of fdt_get_property_by_offset()
calls =E2=80=93 fixes BRLY-2026-040
[PATCH] image-fit: Check that external data is in bounds =E2=80=93
fixes BRLY-2026-041
[PATCH] image-fit: Check nesting depth in fdt_check_no_at() =E2=80=93
fixes BRLY-2026-042

Thank you,
Anton


On Wed, May 20, 2026 at 5:09=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Wed, May 20, 2026 at 05:02:19PM +0100, Anton Ivanov wrote:
>
> > Hi Tom, nice to meet you.
> >
> > While we understand your concerns about AI-assisted vulnerability
> research
> > and AI-generated security reports, we're not sure why you think these
> > advisories don't require attention.
>
> I'm not saying they don't require attention. But I am saying I'm not,
> and I don't think anyone else should either, without the reporting human
> doing, well, what's outlined in the various links I've sent, pay
> attention. The hard part has rarely been finding a bug, it's been
> dealing with fixing it and verifying it's a problem.
>
> > We have recently started using AI tools for vulnerability research
> > projects. We use it responsibly, conducting several rounds of human
> review.
> > We have confirmed that all the security issues described in these repor=
ts
> > are valid. Furthermore, each advisory contains a PoC section that
> > demonstrates how the vulnerable code can be triggered to lead to DoS or
> > arbitrary code execution, as in the case of BRLY-2026-038. We used eith=
er
> > sandbox_defconfig or qemu_arm_defconfig builds to confirm this.
> >
> > As for the content of the reports, we strongly believe that they contai=
n
> > the minimum amount of information required to understand the
> vulnerability,
> > including the PoC and suggestions for fixes, as well as the other commo=
n
> > information, such as the CVSS score and disclosure timeline. We
> understand
> > that this format may feel unusual to you, but this is how we typically
> > report vulnerabilities. You can find more examples in
> > https://github.com/binarly-io/Vulnerability-REsearch. Please note that
> most
> > of the advisories were created before the AI era.
>
> That's good to know. Unfortunately the bar for entry in the security
> research world is now zero and so as a volunteer and community project,
> we don't have time to investigate if every reporter represents someone
> with a long standing history or someone new that unleashed an LLM agent
> on things without a general understanding. That means the bar for
> reporting from long time researchers is much higher than it used to be.
>
> > As an alternative, to save everyone time, we can provide the necessary
> > patches to resolve these issues. Does this sound good to you?
>
> So yes, following the general project guidelines for submitting patches
> as I sent before, and also if applicable
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-assistants.rst
> a patch to fix the problem, and updating our test suites if possible to
> catch regressions, would be appreciated. Thanks.
>
> --
> Tom
>
