Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC9AC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 18:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54DB682A16;
	Fri,  4 Apr 2025 20:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rkTZukpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE3182A36; Fri,  4 Apr 2025 20:09:26 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3463829C3
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 20:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-af590aea813so2477315a12.0
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743790162; x=1744394962; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zspd/Dd08+W4HbKSq6jQtbeQtixvU/IM/Lo4ReHWg+o=;
 b=rkTZukpCLvz+JoBTCLF9mVNs7OqO3q5s78NAyyQHxahrES9FU5lASt8es3Lic0RiYW
 NVBlRT9sEajCsL0FE1sz1NRjzXo7PVBMIX/WycOfDMrNRLXp/xBnccnbDLOF4w46ucAz
 7kP/TZPBRAXh+FtjExSJUHOBGbPWSoDvJqOEid9gAkvEZoH9HgBhJrxirvV5s+LVH8Nr
 jUVUilBRoHEkVXCYkrXtBi75Wafl6/3H4RbeTjXAp5ZUwHJSoq2c9DGv82EOteqXeY/u
 c78s1A//M55E63fGZRV6dXsIYREmD5IwSH0tK3dbmb7FIuKT4RVSEKPXNks65uebl3RN
 O2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743790162; x=1744394962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zspd/Dd08+W4HbKSq6jQtbeQtixvU/IM/Lo4ReHWg+o=;
 b=o2zpCfCCohj78TQ3mabCNfU2c4n2FIrNjOuIoTmX/BljvlVcLnrwrAUnTxAWT02dQJ
 VNwf39FJeKTdMuqQe+rrwOXctuiTpwRMVMxl2kuv0IM5bDvLHPihw/SFkLyej7aCJobG
 UsW3rwF5qEkO0o5TrY9rxd2Idl71z8xbfuMPAx+tE6d9vfjsrY4tkz3B+rFs6eTnl0w5
 +IEcVhj56dJvagWqQ68Y0UBXUyzQf91XfeeuffuvOb2uCeig6YDQ+9Qb0iFBPwDC1FZz
 KGeFKmb/G3uqazvYLi0MT7wb7DU02T6y9mt50jW2xAIMegwY8QfnnEH9LSpbL6TYOn3D
 /29g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJd/aVz3P+H14/v8wc0FlMc2k2NenEWr+BALmyKUs5yCe/w3H7JNdhYuv/aMea82f0adPfBB4=@lists.denx.de
X-Gm-Message-State: AOJu0YwaNwHjHEsu4BiCHCuTyhDnoWSsBI9P1Os3Z4Fp2zHgAX/q+qhT
 Xa5CcxfLLA+ev+3IYaFob0UxAztAmJOgkA4mU1FR2ZUU4l5IV25zUAtp76KOLVAedmeT3pK01SA
 fR9MXR1DAqE5q9Bb/CbAcaPt/UQV2i4Ugc8PIjQ==
X-Gm-Gg: ASbGncuD4Wy+iVGup9YSuDVVmgTypfsHYw5WeLRk9Ooin46DIMe8ehfJtG6l28GAZlA
 6gsWbxIXjK+Cd3u8RK1XmyDJaklZGTjqELSNtagVKxs5B0pE9PCx+woC+oodq+Z/0XJlGyDsvNQ
 kAObmij+Y/ES58TWiG+nnp0rb0SQudZVlOU5ucuw==
X-Google-Smtp-Source: AGHT+IGtyoNzsrVlW6qxkWHwZZFti8dbdh5LvNx7Xdi4ZWCKkHIboxG2I0PzGaqJCRubdLKSbxrDc7RDSljjNJcowBs=
X-Received: by 2002:a17:90b:568d:b0:2fc:aaf:74d3 with SMTP id
 98e67ed59e1d1-3057a59ea40mr10331129a91.4.1743790162149; Fri, 04 Apr 2025
 11:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
 <20250329000211.GH93000@bill-the-cat>
 <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
 <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
 <CAFLszTjo8HEzKbZAbO=neF57e69vGbWYsDVV_dD=kO6j_VH39w@mail.gmail.com>
In-Reply-To: <CAFLszTjo8HEzKbZAbO=neF57e69vGbWYsDVV_dD=kO6j_VH39w@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 4 Apr 2025 14:09:08 -0400
X-Gm-Features: AQ5f1JoWW0J32x6W19fSpfbhaD5l6-r0QzPXPzkxKIIxlIk8wuglxyMfLC6CCS0
Message-ID: <CAEfUkUJNUhoyRY6S9-eYV5i9RT_GgYLRs+HRWocch8jYfVj2Lw@mail.gmail.com>
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

On Fri, 4 Apr 2025 at 13:40, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Sat, 5 Apr 2025 at 03:49, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Tom and Simon,
> >
> > On Fri, 28 Mar 2025 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Tom and Simon,
> > >
> > > On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > > so that it is simpler to understand and manage.
> > > > > > >
> > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > > >
> > > > > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > > > > be resurrected to give some coverage.
> > > > > > >
> > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > > > >
> > > > > > Based on how it's documented to be run in
> > > > > > doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> > > > > > that platforms using the handoff spec still work?
> > > > >
> > > > > I believe so, yes. I don't have that board to test it though. Raymond
> > > > > may be able to test this series on QEMU?
> > > >
> > > > I was pointing you at the docs so that you would have access to testing
> > > > it. That's part of the docs, running the emulator.
> > > >
> > >
> > > I can help to test the firmware handoff on qemu.
> > > I have all the necessary changes and unit tests for the OP-TEE repo
> > > qemu v8 build to test this.
> > > I will try to find some time early next week to review and test this
> > > series before turning back to you.
> > >
> >
> > Just a follow-up on the testing with TF-A and OP-TEE.
> > Unfortunately, the patch series breaks the transfer list handoff to
> > U-Boot completely and just end up with below error when U-Boot boots:
> > ```
> > No valid device tree binary found at 0000000000000000
> > initcall failed at call 0000000060097bcc (err=-2)
> > ### ERROR ### Please RESET the board ###
> > ```
> >
> > U-Boot test version:
> > 'next' branch + this series + my patch [1] to point fdt_addr to gd->fdt_blob.
> >
> > [1]: https://lore.kernel.org/u-boot/20250331224011.2734284-2-raymond.mao@linaro.org/
>
> I suppose the FDT address in the register is not being read correctly.
>
> Do you have a test case for this, e.g. in QEMU? Even if it is just
> binary blobs for now, not suitable for CI, I'd like to get it in my
> lab.
>
> I did create a test back when I did standard passage, but that series
> seems to have not been applied. I'll see if I can resurrect it.
>

I am using the OP-TEE repo [1] qemu_v8 build to test. You will also
need my patch [2] for enabling transfer_ist in all components.

[1] https://github.com/OP-TEE
[2] https://github.com/OP-TEE/build/pull/821

Regards,
Raymond

> Regards,
> Simon
