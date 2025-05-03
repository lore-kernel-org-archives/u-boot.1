Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6D1C3ABAA
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 02:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65AD820EB;
	Sat,  3 May 2025 04:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k9aVqElN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBBCC820F6; Sat,  3 May 2025 04:10:45 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914D181F66
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 04:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so4035861a12.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 19:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746238243; x=1746843043; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jAsymb99/9MZ1Dzbdq5ev5DLllqeoVoozdSb3r/j830=;
 b=k9aVqElNto9ZM+39mtORIZkxFAyfWtv1fFubQYgqRAOyzgsG5kBeWz4Kr0QZX6v24m
 FRr/5YhAcXs2ejunbfF9g1KAoPeM0toyTpQYjfJJdYtNGgADpRpbJ5phD/QyjmmMQWxG
 VyFJY4GSWLOnFstRYizo8a8ixnVXhFsZ7wPHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746238243; x=1746843043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jAsymb99/9MZ1Dzbdq5ev5DLllqeoVoozdSb3r/j830=;
 b=rBdGx12LZQs0Hp1+YjP4mHZBMcNJ8k1fev/qNlasYscfjuhiIDLDbB81UCm0S7847p
 Od05lWDs/6jEzdPPmMR8nP/WbyRquRGttmcG979rnYSm9Jq3MyQuPDIxTem2ZD8URr3W
 YoG9ylLRYOad24s3b5z0ay/C2NCjpHVwLCLiE/EIlgX8D52YSe2lA+LAsfePslqoYb2C
 /UcmZyq8/mYygqjP1Ub7d3ZnyTV+KEbw2Vw2AYj6ZU6xn7gxeoHI6DduLG6tEwlBjW8j
 a1bpMAnMgSetBroSYLcsOaknHZZUzxqu1+xx7Uge7cS9XZxPEPMsqpY4WKxEPWBN9neJ
 gqhg==
X-Gm-Message-State: AOJu0Yz668cbP0QEF5seEJBUF062/bW7pmQMvhsAqd+PLZG7kTpiYY4D
 OYFeDN3bAcY+Tj6F5AtvRdoa3Y7i18fVsMvyUf5KqjyCqI8OnPOX8caHN+t3Tt9zr9SktpzmOJc
 Y/i/5hEkprwoJbYuKBGUf0j5BOuhVyzkGNMkb/0yz3804Wi0=
X-Gm-Gg: ASbGncuJvjckYHViI2yeFIgrJSH2jYjsE2eT0ezLLxEW3zmLBPOzGpppCoKrRIIHaSO
 VSwPopLDU1JpFxBVq3Xnv1rNK0r+G+xQjMcqIQipKV3rir23a2VTLTdeq2ujZbimfN+8PHFDZed
 sK2L19MEw/N4eel1tGMRYnYT6Fz8MDTjsS9A==
X-Google-Smtp-Source: AGHT+IEU7ENEibw+Z5ZDZpz3DW1aF2dkpA6rWGfYt+7rRkQywMXm1EmqhphDu/Fv8CIKoiCXkbbpCxrIG7BB0Pp93mc=
X-Received: by 2002:a05:6402:510e:b0:5f6:20c4:3b0e with SMTP id
 4fb4d7f45d1cf-5fa78013766mr3881605a12.8.1746238243055; Fri, 02 May 2025
 19:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-3-sjg@chromium.org>
 <20250501140617.GD1261075@bill-the-cat>
 <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
 <20250501153316.GH1261075@bill-the-cat>
 <CAFLszThcmQYqXO8rqiYKS-1TdyXcTbfTuaOTa3W8vWMTzKn-YQ@mail.gmail.com>
 <20250502140649.GQ1261075@bill-the-cat>
 <CAFLszTjqhnJNvzRUx5UD0ibSOnu+fFUCJa8CUDrTYy7vw1cjyw@mail.gmail.com>
 <20250502150429.GV1261075@bill-the-cat>
In-Reply-To: <20250502150429.GV1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 20:10:30 -0600
X-Gm-Features: ATxdqUGRC0rduvsiuwuctUc45t1uy4W2GdMm3XeBUNRSwTlogAM7ZLz745QLlz8
Message-ID: <CAFLszTgKn9pbDs365Vztj+-gpcu=PUx5W2dRzpSS=qLdgD6nhw@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Oliver Graute <oliver.graute@kococonnector.com>
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

Hi Tom,

On Fri, 2 May 2025 at 09:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 02, 2025 at 08:52:37AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 2 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 02, 2025 at 07:11:56AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 1 May 2025 at 09:33, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, May 01, 2025 at 09:04:45AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wrote:
> > > > > > > > This file reads from the environment but does not include the correct
> > > > > > > > header. Update it.
> > > > > > > >
> > > > > > > > Drop the unnecessary config.h while we are here.
> > > > > > >
> > > > > > > Are you sure about that? It was explicitly added in commit
> > > > > > > ab61cc7d98f6 ("board: congatec: Remove <common.h> and add needed
> > > > > > > includes") probably because of CFG_SYS_... usage.
> > > > > >
> > > > > > Well I assumed it wouldn't build if it had it, but perhaps that is
> > > > > > incorrect? I understood that CFG_ things had to be values and you
> > > > > > couldn't #idef them?
> > > > >
> > > > > The cases where in that series I added config.h were for good reason,
> > > > > either failure to build or tricky size change reasons. All were
> > > > > intentional. An audit-and-remove of config.h would be it's own series as
> > > > > yes, there's perhaps not the need now as whatever complex chain was
> > > > > unwound.
> > > >
> > > > Oh dear, OK. I'll respin the series.
> > > >
> > > > Hmm but I see you have sent a series that does some similar tweak[1].
> > > > What was the goal there?
> > >
> > > I fixed your problem. Please don't bother re-spinning this series, it's
> > > not clear what problems it's solving correctly.
> >
> > OK thanks. The problem was trying to include net.h in include/efi.h:
> >
> > https://patchwork.ozlabs.org/project/uboot/cover/20250501010456.3930701-1-sjg@chromium.org/
>
> Adding headers to headers needs extra care (so that we don't end up with
> massive implicit include chains).
>
> > So long as that works, we're fine. Having said that, even if it were a
> > problem, we could always refactor things to put the Ethernet decls in
> > a separate header.
>
> Yes, if there's some problem down the line then some refactoring is
> likely the thing to look at, not adding more headers to C files (the
> right path is to unwind the header chain and fix C files, your series
> doesn't remove env.h from any header).

I hope we haven't got confused here.

My series removed env.h from being *transitively* included. I had to
add it to C files due to that.

Your series doesn't help with including net.h in efi.h - you can try
that and see that it still fails.

But as I said, we can move the decls into a separate file.

Regards,
Simon
