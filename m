Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BCEC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 08:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D294482B0E;
	Tue, 27 May 2025 10:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V48dmXRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ADD882B12; Tue, 27 May 2025 10:20:23 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EFD182A36
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 10:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-604bde84d0fso2324122a12.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748334021; x=1748938821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=19EGRWxAkvxw6VTSM6QMKqeN7hGB41WI+Eg9Cr7mLbo=;
 b=V48dmXRZb84FbsVTqBrmhE1Rph4emvFPsh0bW0lYU0kO67jkb/vVcyH8sCFOkFElw5
 jG6u5aowoxJs1pOQ/+Ur73+sRWWx+f/diNBecMVzdU+W9nibXlk+9P5GCeP0Y5gjPAvJ
 PmwVb6yRuJ8QdPl1nILVSqmkRw0YABbb547WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748334021; x=1748938821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=19EGRWxAkvxw6VTSM6QMKqeN7hGB41WI+Eg9Cr7mLbo=;
 b=lkxnOHzp4FFBLjYEqI9fX0A+oE8nSn903iyhm1zDyyl025+6cze4Gug7UwFxiw57gz
 kC5h7YyL4lNRueimm8RxYhdX/PwajKfzDuWDcvydkCNe6FD9g9819JUPxpjNtXyuniJ6
 65JKuun3zC/T/Cig5u1yvC02ULQ2Bc7wlYJPLnHGAWJmRiBTkbrWLwkaoIeBijDi+X8w
 U+c2gb7EJinHrDxuVugZ+SxUKjZnHBOA22dgeOwHPTuxNMyIdCbJN6CVsMrtNNsg9CMC
 X+T7k3IPYNGJkLORz5idp0mgivhBAp6t50CmyhSdZVxFBrcd2lpGM9KSXXF/5oEEKqE3
 XG9g==
X-Gm-Message-State: AOJu0Ywyii3xRzYB/hrupmim6+blVM+OkEsfky+WYzr07MDLuY8juecD
 5d0n73BlFUxsvNHZjF7tcrYa71piJRVDe7VgQMdeoKImMeUnaa3V+vYsicYw+SaQzvL/XEqUI8o
 HP9+dJB1Gsxm9Ea8TO+G4zeuL2KliQ3zrRERih6xV
X-Gm-Gg: ASbGncsDrDj7XAe2E/5rgdtCRiZr0TKOtc8aXxKzhFD8Lt5h5LCf+bpZ0ThU3Wmsq2P
 bOXX14c9m1A5KtOkwa9JQb3bmlOZ1957rGuZgw6atkjlasKdlgBu6ocsGvEL1al9hx08xGbCXRi
 aTzbL98MKgWqQEfKvX/u7xOUFVgUAaQek=
X-Google-Smtp-Source: AGHT+IGApme4IOQnfPwMgeIyFIbAApcuHw+xH8ApYKIjn66cMFlhG6LJi5XM5V9RhRQ/5ZlDYxZq5ZmyUV+jIOaB10Y=
X-Received: by 2002:a05:6402:90d:b0:602:3b60:926e with SMTP id
 4fb4d7f45d1cf-602da1f0d5cmr9163160a12.10.1748334020610; Tue, 27 May 2025
 01:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250524120904.684977-1-sjg@chromium.org>
 <CAC_iWj+XfkWPj+R1JUc0ZPFatRtpMso-Lw+uYzcgcbuKPuV3Dw@mail.gmail.com>
In-Reply-To: <CAC_iWj+XfkWPj+R1JUc0ZPFatRtpMso-Lw+uYzcgcbuKPuV3Dw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 May 2025 09:20:09 +0100
X-Gm-Features: AX0GCFvhC8Itz6RJsr-M89Lf0Ah-IA0dFyGjNxSKFQQlrQaOyBS5SsbHRaTyxk4
Message-ID: <CAFLszTho++gscP4rUUY354iyVWFyPkZeMCpa-TpX0GaWOQzQvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Sat, 24 May 2025 at 19:13, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Sat, 24 May 2025 at 15:09, Simon Glass <sjg@chromium.org> wrote:
> >
> > A previously rejected patch to move the EFI public cerificate out of the
> > devicetree has recently been applied. This series reverts the change,
> > pending further discussion as to why it was accepted.
>
> I spent a good amount of time, writing the commit message an
> explaining why this patch was sent

Yes, that is [1] and I did read it carefully before sending my series.

From my POV there are two things wrong there:
- The signature is not an internal U-Boot ABI. It is how U-Boot works,
so if a build systems wants to inject a key it should use that
mechanism, not add a new mechanism into U-Boot's build system. If it
would help to have some documentation somewhere which says this, I
would be happy to send a patch to add something
- QEMU is blocked from accepting devicetree additions due to another
Linaro employee's refusal to accept a patch[2]

> (which btw wasn't 'rejected', you
> forcefully reverted it back then with no agreements from anyone)

The original series [4] was applied (I believe accidentally) against
my objections. Heinrich pulled the revert [5]. I went ahead and did
the QEMU patch, to help with your issue*.

> and
> why we prefer to do it this way. tl;dr early boot loaders that pass as
> a DT is a problem now.
> If there's a good reason to revert it, please explain it on the commit message

The reasoning hasn't changed from the discussion three years ago -
please see [4]. There's also lots of discussion on your original
series and my revert, e.g the cover letter. A highly relevant part of
this is that devicetree is where config should be stored, so the build
system has control over what is placed there.

But in any case, it isn't right to send the series again, under a
different name, e.g. not mentioning device tree.

[..]

Regards,
Simon

* The QEMU patch is still outstanding after three years. Could you
please talk to Peter Maydell and see if you can get this resolved? I
have sent it twice since, most recently in April [7] but there was not
even a reply.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250401112729.2181793-1-ilias.apalodimas@linaro.org/
[2] https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
[3] https://lore.kernel.org/u-boot/CAPnjgZ2uM=n8Qo-a=DUkx5VW5Bzp5Xy8=Wgmrw8ESqUBK00YJQ@mail.gmail.com/
[4] https://patchwork.ozlabs.org/project/uboot/list/?series=253693&state=*&archive=both
[5] https://patchwork.ozlabs.org/project/uboot/cover/20210802144431.2396678-1-sjg@chromium.org/
[6] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191352.2597585-1-sjg@chromium.org/
[7] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191352.2597585-1-sjg@chromium.org/
