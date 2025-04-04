Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FBEC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 17:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C752829C3;
	Fri,  4 Apr 2025 19:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q4wEgMe7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE3C2829C3; Fri,  4 Apr 2025 19:40:25 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 670C8807B1
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 19:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so417515666b.1
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743788423; x=1744393223; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mo7f5Ias7AOON4BdX8MTgC1G9ihY0Ko2llXrBe3m/Ao=;
 b=Q4wEgMe7KjZo5lmPeA9YhWHkiCToYZ8dttDLn/jb7SKfZE9ecPt+Q4iOCMwh9HD1H7
 +k4xaW9p59/Z7462wAnOnpI124piwlh+Q3DcpM6e/6jvoa7/s7wF1FbOHsJIVHBeQDP7
 IS/f4f9LhCSv+agdlI/47iAstWpuj5I7GUfqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743788423; x=1744393223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mo7f5Ias7AOON4BdX8MTgC1G9ihY0Ko2llXrBe3m/Ao=;
 b=C0Id26Um8SRIjG9HwElhdyFrQ035R2KveduFM9/z0dJcWvV1OYjfROPaxU8IjJ1znT
 9F1V/i9G77hNae7YmIRDYKsiZch7GVELCGjYi6rNHV09aKqZZx/RYFb5nwAh824sRzBL
 710BJDIguyu93U7VxJS4AtNf5tjU+EesBLrOEuVg7p8MXeKZzO5G6ZBrlFzAbESmS1yS
 Y1fnUw7EjtVuPKmvXWWzZ2i32t64LD4eEgFajHMlrSwg4x5g5re3FWqUYLUhQ3OKLh93
 QtusHyE/372xT6qJcdCKLToDzBkferdof654QLvj7uZ080nag7NQY52utZWzR9ybeamM
 iiww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoQH1PaSvhAA6kTj/fpWwc7USK7oroAT25bRb84xBgfzhvkjxsKKuy8dgAfdLGAiqRLrg7OdM=@lists.denx.de
X-Gm-Message-State: AOJu0YwGB9UGnipQGCsYHw9DOjbSTlKtpAghlu2iE3YHT7qdAKseaOrS
 QhYJM6UBr5zyfxDhbitqrEBG4JLsSfzqQX5f/JrZlKoBdA1o0p4HkSIHpLyexA6/MEYshIP9WVC
 pzf92uv8TRFgEYrBczuWZ+7sjel/zI9E+GmR6
X-Gm-Gg: ASbGnctc0nN1fO4aDiALMRLvYeCzJgaZVW9gGhCyWPPR9CqCQUpRJYQ4egPowA0eKRa
 5SAJ0jlFHjFpfyxrLvSKRPuKE39Ynt0j0s8XpoG7VWmDHyHuj1pOyRPkUK6+8SgyEmtGSBEJrKy
 REnx9jpci7TokUUePr0lH2OPcc0pt/
X-Google-Smtp-Source: AGHT+IG2Ym9tj44oSKyZHvKXey4vw/hHSCUko6Xz+kDzWxX9QrAJrBKdb9Bd+4LLUhxARIfAnVU54i4RMrF3uwNurdM=
X-Received: by 2002:a17:907:a05:b0:ac7:1be2:1a79 with SMTP id
 a640c23a62f3a-ac7e7116845mr41533466b.4.1743788422646; Fri, 04 Apr 2025
 10:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
 <20250329000211.GH93000@bill-the-cat>
 <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
 <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
In-Reply-To: <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 5 Apr 2025 06:40:08 +1300
X-Gm-Features: ATxdqUGAh5KRnK6-DotoRk8KBX3xzS5TCx7SOrdZZ7KlOBpfmnMM5c0nthIEaBQ
Message-ID: <CAFLszTjo8HEzKbZAbO=neF57e69vGbWYsDVV_dD=kO6j_VH39w@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Raymond Mao <raymond.mao@linaro.org>
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

Hi Raymond,

On Sat, 5 Apr 2025 at 03:49, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Tom and Simon,
>
> On Fri, 28 Mar 2025 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Tom and Simon,
> >
> > On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > > > >
> > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > so that it is simpler to understand and manage.
> > > > > >
> > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > >
> > > > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > > > be resurrected to give some coverage.
> > > > > >
> > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > > >
> > > > > Based on how it's documented to be run in
> > > > > doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> > > > > that platforms using the handoff spec still work?
> > > >
> > > > I believe so, yes. I don't have that board to test it though. Raymond
> > > > may be able to test this series on QEMU?
> > >
> > > I was pointing you at the docs so that you would have access to testing
> > > it. That's part of the docs, running the emulator.
> > >
> >
> > I can help to test the firmware handoff on qemu.
> > I have all the necessary changes and unit tests for the OP-TEE repo
> > qemu v8 build to test this.
> > I will try to find some time early next week to review and test this
> > series before turning back to you.
> >
>
> Just a follow-up on the testing with TF-A and OP-TEE.
> Unfortunately, the patch series breaks the transfer list handoff to
> U-Boot completely and just end up with below error when U-Boot boots:
> ```
> No valid device tree binary found at 0000000000000000
> initcall failed at call 0000000060097bcc (err=-2)
> ### ERROR ### Please RESET the board ###
> ```
>
> U-Boot test version:
> 'next' branch + this series + my patch [1] to point fdt_addr to gd->fdt_blob.
>
> [1]: https://lore.kernel.org/u-boot/20250331224011.2734284-2-raymond.mao@linaro.org/

I suppose the FDT address in the register is not being read correctly.

Do you have a test case for this, e.g. in QEMU? Even if it is just
binary blobs for now, not suitable for CI, I'd like to get it in my
lab.

I did create a test back when I did standard passage, but that series
seems to have not been applied. I'll see if I can resurrect it.

Regards,
Simon
