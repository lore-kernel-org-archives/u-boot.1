Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFABC36014
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 14:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1338829C3;
	Fri,  4 Apr 2025 16:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s74f9igH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB83829CF; Fri,  4 Apr 2025 16:49:15 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EEE8829A0
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 16:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2295d78b433so21668595ad.2
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743778151; x=1744382951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qT7sjS+Cb1SgG/PP+J1WBFI9h8WX1/173SUwqfZzuoQ=;
 b=s74f9igHpMGWg8TQRUmpxtVvitWcfcTMlpWjblkfWuWQrhFLH8gSKvNQ0xj8FkkA20
 1VsZsoGOP8jtspFtV4Kx0D6U+6LY6v4WDmzUSm21PNSX5qZDpDT55lll0XFlGb4IpBNK
 e3cA6d/ryKa84rvay0RGekfLstsfTp07ehdsiv6Xkbjpqpc3GTtivgLqh22jP2lnxShU
 ryC2aznqlPjR/8pYVfuRhFbCHfMOsurVuLG1ckEtY8Uc5SdxSsyQsJXTCdowmYFxkm4L
 /9TIqmc6aPx/hpgpboxxgKnRD3Y1ctgzZgO+O83eHvPPN+J2Q3ZAtD+hh3r4gS52ZO/z
 1W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743778151; x=1744382951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qT7sjS+Cb1SgG/PP+J1WBFI9h8WX1/173SUwqfZzuoQ=;
 b=oQxu3RmSGYAC2z3n5u99knzUTEu/3zhA2LI1jbVMDF4xn8l89ctD9On+pXaXSSPO+6
 U9y1J2nWaZcnx9rRv+j/GOQ7B73zMSMkQ6FLnGV5tuGpcSHDoJNmkdrpne/IBQ/4TU9j
 QZ/Fsgrx5WpB7K6Z0yZJXitvMf30Hj15PTs5ijWt6D6YVZ/ptCvbfGYPjUsDomEmWMtY
 jE79vqa3c0tS0pubGxzuiSMuZqAnfwikiARpMshrpjt8CwOh32JkXO9kDEQ35f97TLBm
 Y9769YI/SKwLOAqwFecmnUg5WHN7yTSUaWrI7BK0YHEumNpd91pqGbwiACRBDposnXvK
 mvhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs+Nx57m6YuUkbwqzXN5gv09tSrrBOYCaPQLBAAD5GgaR2Q/jfASLNzcvavYLLdiWSGf2nDw4=@lists.denx.de
X-Gm-Message-State: AOJu0YxLov26ZeCCfolHmEmnmTFLN5rZR3wCxgnrHWeqbXEm4qxCbcTd
 07tk+KCOfwWlxJN5RQRdZ9dFnRfj5lF1NZ8TqvL1zN0+ji56l92Qa3ugsbdv4eccYt6bBUFYo/v
 O0KWl7vJFpkXTG4H/IDNE+LLjbXJVKbbTmAzzCw==
X-Gm-Gg: ASbGnctmlQ/0ELdPqifmFjKRHJMqKImzymljxxcjcj124fWEfF/mXF1IJBMVzbpheQP
 DIX9wv4C+8vwGF7As3cf4RVWr9hNfMH5yC5vgFMsQCGpvSjgopW2v46n24zXjcR9U5MDx/VcCOI
 dFxUlkQkMN4VtNqRPB4semNGdGmXE=
X-Google-Smtp-Source: AGHT+IH3TriuaHiRlv2AeTv28k7Lha3S5SMbrhhf/j2MAtOsthQhbUmT0gFPOEWU8V/qzU9mGKIoZj5GqeT8w6dRD/s=
X-Received: by 2002:a17:902:e950:b0:21f:45d:21fb with SMTP id
 d9443c01a7336-22a8a046021mr46257105ad.3.1743778150557; Fri, 04 Apr 2025
 07:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
 <20250329000211.GH93000@bill-the-cat>
 <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
In-Reply-To: <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 4 Apr 2025 10:48:57 -0400
X-Gm-Features: AQ5f1Jomm2Diy3py2mx-xl92hgxDoR9JVjwfjVBbutcVmVOTVu1a6AAOuP0GYsg
Message-ID: <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
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

Hi Tom and Simon,

On Fri, 28 Mar 2025 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Tom and Simon,
>
> On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > > >
> > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > so that it is simpler to understand and manage.
> > > > >
> > > > > - Unwind some of the nesting in bloblist_init()
> > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > >
> > > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > > be resurrected to give some coverage.
> > > > >
> > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > >
> > > > Based on how it's documented to be run in
> > > > doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> > > > that platforms using the handoff spec still work?
> > >
> > > I believe so, yes. I don't have that board to test it though. Raymond
> > > may be able to test this series on QEMU?
> >
> > I was pointing you at the docs so that you would have access to testing
> > it. That's part of the docs, running the emulator.
> >
>
> I can help to test the firmware handoff on qemu.
> I have all the necessary changes and unit tests for the OP-TEE repo
> qemu v8 build to test this.
> I will try to find some time early next week to review and test this
> series before turning back to you.
>

Just a follow-up on the testing with TF-A and OP-TEE.
Unfortunately, the patch series breaks the transfer list handoff to
U-Boot completely and just end up with below error when U-Boot boots:
```
No valid device tree binary found at 0000000000000000
initcall failed at call 0000000060097bcc (err=-2)
### ERROR ### Please RESET the board ###
```

U-Boot test version:
'next' branch + this series + my patch [1] to point fdt_addr to gd->fdt_blob.

[1]: https://lore.kernel.org/u-boot/20250331224011.2734284-2-raymond.mao@linaro.org/

Regards,
Raymond

> Regards,
> Raymond
>
> > --
> > Tom
