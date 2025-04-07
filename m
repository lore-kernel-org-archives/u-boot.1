Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EED8C3601E
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9085F82D0C;
	Mon,  7 Apr 2025 16:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sKkrYv8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A5282EAA; Mon,  7 Apr 2025 16:08:14 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9096182CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so3926290a91.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744034890; x=1744639690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P7dTrVY9wVJ3y8ik01fCyN5yBIih0atQgC/vjZFCMZI=;
 b=sKkrYv8/WYrqodY1mumz+psbGsUrqkI+3wfkNJiegFvrm0isOUT/te5LKe5DViNZ+d
 dZvcUw8BPlR4OB1QKymmX4vI0eHKPwmlAXZBTHLypxHrCiVNGtYlLFbs+9VLEW2GG2BH
 hIwtizMlwAQTIUoODUS5PoBBv0E3tz11QDiluNaTe8KPYA949qGr/3AcAwMQgxWtJRWN
 O2GG3i2JSkf9tOc1YxZCU0RoWypbTnskSDwdqXPTFEQDAfzBos0PBHmhcN1SE7HaJuvM
 8yj1mgrWPNVohNKdcMcQz+dN2m5BOAHjvcMOfLPKv5Lz6MAKhxwYlqJZMhnJlVgWKh6B
 MRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744034890; x=1744639690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P7dTrVY9wVJ3y8ik01fCyN5yBIih0atQgC/vjZFCMZI=;
 b=w8IRsXf9tUqPaoTSZ9l2iMqFxH29ZtUef6smqIJ3ime4f35tIFiVwIkEhMHH5mxK3u
 RX1gyADak8zezWp/D4qUFzWdgHaza2s2VQelae85jKTDZrXvDjVnrwlfN/60Bo2EEGg4
 xzjOZkVKPrBqXyPgW2LPjLk2AIzZWvincTED7Ux4BbLP0nyO+BU60VLsZoF7rG7qe4ku
 giLddL7WTfZhNHfheDWinbBGoldStg8m6AEbRTfcTJM4S7ODfYtyT2PK0QxAXZAcqs27
 TRw7bagire8I3DqI4UpYrpZRrgX13zuptsfc4MHjzRR8W3jTLWbWBEAk/Vljydnu4HQZ
 mxtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpQ2bCSl8SuVTCl5vau6UbRDKf0tEXSipKz+fbrpUrB1tNwoitlVmoGCbhHZ7Hn+9RIrAdxxc=@lists.denx.de
X-Gm-Message-State: AOJu0YzjD3+sCGQkjVPOXFkIAenZx78JbFe+Ai2jEJfrfipPGNffFW5P
 lmVUQ/eOoQF8vmztZVDXo8/A133Bfv8lWIl3D4UwaCI7YOMQ+yNyW5qzjiNu5PeAhRrungvTGFH
 442Cpvhnq7JGV6ItU/G8V03eq50CqvrMjdArEew==
X-Gm-Gg: ASbGnctvYZEqrnfMLh8q7K+TPBnMW68e84JqVJ7fA7sDjEITQ3lFXrPFhdCnGku/TZU
 BQbFGomnysggtDvmwc7VgfBq+9aYRXPO9akzrmujwkGDZm7LSiGSqvuqtl/C03n/P4jR6gzZB3C
 +wk71Vyb5brs/Ybc1nHSXalcoFDsY=
X-Google-Smtp-Source: AGHT+IGiKbrADYvgjVLfqmVKmLGLHwcXTYuKOZ426H3rYEMmB0J96AzUKL0nvoncUKtj9lLnj1ccxu5q8ELoRg4BRJE=
X-Received: by 2002:a17:90b:2545:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-306a6150142mr19587564a91.12.1744034889551; Mon, 07 Apr 2025
 07:08:09 -0700 (PDT)
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
In-Reply-To: <CAFLszTj-pQSK_aKNoLUcLFBk+wAjgC_5=-5YRPGt_7DDFRL3Dw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 7 Apr 2025 10:07:57 -0400
X-Gm-Features: ATxdqUF-qpSrpjWpcPsoF16mSSOpA0pYySmGtjzmtRbYbaGzpDvjrz4Ee7ON6KY
Message-ID: <CAEfUkULcgK9jY902Ccf_mNNCHf5m1BU=ecLK7cuviv7TdABukQ@mail.gmail.com>
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

On Sun, 6 Apr 2025 at 18:06, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Sat, 5 Apr 2025 at 07:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 4 Apr 2025 at 13:40, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Sat, 5 Apr 2025 at 03:49, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > Hi Tom and Simon,
> > > >
> > > > On Fri, 28 Mar 2025 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >
> > > > > Hi Tom and Simon,
> > > > >
> > > > > On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > > > > so that it is simpler to understand and manage.
> > > > > > > > >
> > > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > > > > >
> > > > > > > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > > > > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > > > > > > be resurrected to give some coverage.
> > > > > > > > >
> > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > > > > > >
> > > > > > > > Based on how it's documented to be run in
> > > > > > > > doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> > > > > > > > that platforms using the handoff spec still work?
> > > > > > >
> > > > > > > I believe so, yes. I don't have that board to test it though. Raymond
> > > > > > > may be able to test this series on QEMU?
> > > > > >
> > > > > > I was pointing you at the docs so that you would have access to testing
> > > > > > it. That's part of the docs, running the emulator.
> > > > > >
> > > > >
> > > > > I can help to test the firmware handoff on qemu.
> > > > > I have all the necessary changes and unit tests for the OP-TEE repo
> > > > > qemu v8 build to test this.
> > > > > I will try to find some time early next week to review and test this
> > > > > series before turning back to you.
> > > > >
> > > >
> > > > Just a follow-up on the testing with TF-A and OP-TEE.
> > > > Unfortunately, the patch series breaks the transfer list handoff to
> > > > U-Boot completely and just end up with below error when U-Boot boots:
> > > > ```
> > > > No valid device tree binary found at 0000000000000000
> > > > initcall failed at call 0000000060097bcc (err=-2)
> > > > ### ERROR ### Please RESET the board ###
> > > > ```
> > > >
> > > > U-Boot test version:
> > > > 'next' branch + this series + my patch [1] to point fdt_addr to gd->fdt_blob.
> > > >
> > > > [1]: https://lore.kernel.org/u-boot/20250331224011.2734284-2-raymond.mao@linaro.org/
> > >
> > > I suppose the FDT address in the register is not being read correctly.
> > >
> > > Do you have a test case for this, e.g. in QEMU? Even if it is just
> > > binary blobs for now, not suitable for CI, I'd like to get it in my
> > > lab.
> > >
> > > I did create a test back when I did standard passage, but that series
> > > seems to have not been applied. I'll see if I can resurrect it.
> > >
> >
> > I am using the OP-TEE repo [1] qemu_v8 build to test. You will also
> > need my patch [2] for enabling transfer_ist in all components.
> >
> > [1] https://github.com/OP-TEE
> > [2] https://github.com/OP-TEE/build/pull/821
> >
>
> Tom's email seems easier to follow. I got as far as building:
>
> build/fvp/release/fip.bin
>
> But I'm not sure how to run that in QEMU. The docs mention some sort
> of FVP thing and running FVP_Base_RevC-2xAEMvA -C which I don't seem
> to have.
>

If you want to test with QEMU v8, just simply:
$ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
$ repo sync
$ cd build
Apply my patch https://github.com/OP-TEE/build/pull/821
In kconfigs/u-boot_tl.conf, remove 'CONFIG_BLOBLIST_SIZE=0' and add
'OF_BLOBLIST=y'
$ make toolchains
$ make run

Regards,
Raymond

> Regards,
> Simon
