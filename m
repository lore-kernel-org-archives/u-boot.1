Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14113D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:14:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDEEB89145;
	Fri, 18 Oct 2024 01:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sgq+H/CS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713D988DA0; Fri, 18 Oct 2024 01:11:52 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF81189110
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cd7a2ed34bso1477346d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206708; x=1729811508; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6v/txnv9vdL9mbBd2nIbB0j23Tr0cwstIumht+/MYB4=;
 b=Sgq+H/CS35QdMMiWNylfiY0jxu4aDFe7ijsv88HeNAwHZXOP6N14/89i2urLnG5U/a
 iAjuZYEYtCa9HJZNMx9EzRk3BvuDF/cz40Rlp4VliX/HWnsx13g1BUv2bPGakEu4xmss
 41eEYAM2hZHVpWlWNn7LyDKokpb5b+TaaEbIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206708; x=1729811508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6v/txnv9vdL9mbBd2nIbB0j23Tr0cwstIumht+/MYB4=;
 b=vdWce8Zzs4gJzlanxHovkUnB8xqoccSpoOMOnEQcmMxPjnIetihDR86B+9THemNzit
 sXRUtfc7//l3iuE93sfPOFVOxGSAclAGdDEl+UnqCgjSgA/rmjVkInsy9VUlf8V8NP5m
 BDQzqq+OHofhibf+TQGKvUK3VJzypGM1UevznKu6fNK92EFDgtdbobJ1ru3e6hllpzxL
 MAEVhxAtY4+MhR6zsOU/RgBs1MWWAM7P/wlDygu1UJp7qT/o9xcgGDdD+jXQX8kNJht5
 YPlcX04Uz4Co4XusgpSUcQC3Ol/vG8o1v1W9zVt/YsXTJUggtdRbdEQItLFzsqrOIDSw
 7qUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8TogOxNLfPtNIA041PHcyYOcob8M+lagdVPk4mCsWsLoVudJ48693HLzYe3C7j6KV554ReKk=@lists.denx.de
X-Gm-Message-State: AOJu0YwziJmUnyBdRwoJYwi5S5i29WeZS/ZfN4WQnGo/vwMLKMhHPiZn
 RzNlm+sIYd1U1BBH92xK6yJTrL/uR5sR6ZiQEUCj+UdRNsV8JkP+ab7eCrM4px+z+Zuu2uXpxqu
 e4KJrzyjcAdDS7UYAGY+ENcQAcwx3Dabmkhs7
X-Google-Smtp-Source: AGHT+IF+WlOzRGJWBAWZOLxVP2JZ+5PX0Y5EDXBCYUfGsXea2Kz8SBx+h8XFJ0vo5IMygK0+xybn0K8gWq8W25e80Vs=
X-Received: by 2002:a05:6214:4902:b0:6cc:458:8128 with SMTP id
 6a1803df08f44-6cde1662565mr5460476d6.53.1729206708604; Thu, 17 Oct 2024
 16:11:48 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:48 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszThN1GbLJerc_4GST7iLORCK1E+jLR9kBRhpXGak_f-q2Q@mail.gmail.com>
References: <CAFLszThN1GbLJerc_4GST7iLORCK1E+jLR9kBRhpXGak_f-q2Q@mail.gmail.com>
 <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-4-andriy.shevchenko@linux.intel.com>
 <CAFLszTjff52keqouqR3WK=cM=PX+EiTJQqz+YWBbDe3dSTYY8g@mail.gmail.com>
 <ZwaOPy9NTV4PmY5E@black.fi.intel.com>
Date: Thu, 17 Oct 2024 16:11:48 -0700
X-Google-Sender-Auth: IGCS3Jo_76ABXXJuWgFyfXe8SGI
Message-ID: <CAFLszTiL8uA7tRkeK3+KTnVD1uTs32cx0kMWfamZBhd5LoBQdQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] x86: cpu: Add a few prototypes to the header file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Andy,

On Wed, 9 Oct 2024 at 08:08, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 08, 2024 at 07:55:33PM -0600, Simon Glass wrote:
> > On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The compiler is not happy to have no prototypes for the functions tha=
t
> > > are not defined static. Add them. This helps avoiding the compiler wa=
rnings:
> > >
> > >   arch/x86/cpu/cpu.c:197:13: warning: no previous prototype for =E2=
=80=98board_final_init=E2=80=99 [-Wmissing-prototypes]
> > >   arch/x86/cpu/cpu.c:205:13: warning: no previous prototype for =E2=
=80=98board_final_cleanup=E2=80=99 [-Wmissing-prototypes]
> > >   arch/x86/cpu/cpu.c:307:5: warning: no previous prototype for =E2=80=
=98reserve_arch=E2=80=99 [-Wmissing-prototypes]
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Thanks!
>
> > OK, but could you add proper comments for these?
>
> Any proposed texts for them? The comments were out of scope of my patch,
> but I may add anything that is provided as a template.

I found some comments in one of the files, so you could use these as a
base. Whenever you change code, you should make sure it has function
comments, follows style, etc. That way things slowly get better.

/*
 * Implement a weak default function for boards that need to do some final =
init
 * before the system is ready.
 */
__weak void board_final_init(void)
{
}

/*
 * Implement a weak default function for boards that need to do some final
 * processing before booting the OS.
 */
__weak void board_final_cleanup(void)
{
}

Regards,
Simon

Applied to u-boot-dm, thanks!
