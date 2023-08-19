Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6DAEE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 13:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3211869D0;
	Sat, 19 Aug 2023 15:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CXhscS6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085AD86EE9; Sat, 19 Aug 2023 15:53:58 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C0186898
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 15:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b9a828c920so28829741fa.1
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692453234; x=1693058034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/MCp6yk/7bI0hHQzWGi+/d4YYXROtdlVFm1si+RQI0=;
 b=CXhscS6lPMp2OtN3ih89l43ZklHI7plN67PD/Jb76trQIkbKSCQZwz+PujOoPMQ0I5
 xBmT7VP4EYpHAeDsMv9BYFKcfjjfXawvgBW+m0vX+uKxVdjMhp2cmfWjHy2U9Fy7+m1L
 11ySsjvsos6ZHtgcD2B/fW8Ezxm8tNNxJnHU8r0xQijoJcSXtVhDEOoq7pXiNa1Xf/wK
 8uV/X9AeWbymnz5VBgaX5ooipR+tIFNDSUP2ZboJQGHzWgiq8IoFyl8/BpQMrxieAU6S
 nFN+IIenaUrs3p9+tpMwsNHHxQ73e4+x09h2fbPdA2z0m89Jn40hqrU/bZ3cahXQhxl9
 sPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692453234; x=1693058034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/MCp6yk/7bI0hHQzWGi+/d4YYXROtdlVFm1si+RQI0=;
 b=HYSxBw7s8bAeX3xHPGWPoLosC0OAqtnGrx9YO0t1pPDfrTfDyLqUcDOGXfNmVCklDp
 SdXFeIPpRIgEJZaeNfh0cwlwjcTbFXcEdPvNXzPmvDmzujLYGcEITMaIa/EGjL4MAWKz
 pkam+hYLtJANGLpFbCf4AdwnYyDcMJsgZ1PENQrydKz6Bb8CmZURWFsRJ4gPuHYljsi6
 lftgwE6rFFJvNnA84hgXJhT+RpofZex2xgpV/PtouXhU+1MNV6GF8NeTi05Em4FgOSMm
 Bc2pb2U8dp4oeDfrczx5uRfuQK/PPPMQjw3YJG1ddfjmGJr53XO/+G+glVgXgquwafzp
 cwaQ==
X-Gm-Message-State: AOJu0YzfKkC0+/0UFsLfHzHJ+jC7qXYerfxrO6rrSzetbdTwdHXYC3F/
 Nkw6wzFGhaxhQnin10GqxGeYr/g2s2yYIcUPjJQ=
X-Google-Smtp-Source: AGHT+IFTm4800ezOw+M7Pu7K1WF0F7lpcRCqerTtR8YQvELtx5E2B+IsGgD7N5F6htFOS5rDTPN894IPWQf9d9QSdR8=
X-Received: by 2002:a2e:97cd:0:b0:2b6:e2e4:7d9a with SMTP id
 m13-20020a2e97cd000000b002b6e2e47d9amr1490665ljj.38.1692453234331; Sat, 19
 Aug 2023 06:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230727215433.578830-1-sjg@chromium.org>
 <CAPnjgZ2krc9eTrCye9UC6=HM8oTrpVmv8mHEGHJRu5kqu7ts+w@mail.gmail.com>
In-Reply-To: <CAPnjgZ2krc9eTrCye9UC6=HM8oTrpVmv8mHEGHJRu5kqu7ts+w@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 19 Aug 2023 14:53:43 +0100
Message-ID: <CALeDE9OF_a-e=BOCfDG90uju4Ma7_mrLczAwOSo9rjvjR5sahw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] rpi: Convert to standard boot
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Matthias Brugger <mbrugger@suse.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
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

On Wed, Aug 16, 2023 at 4:08=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Matthias, Peter,
>
> On Thu, 27 Jul 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > This series moves Raspberry Pi boards over to use standard boot.
> >
> > It also moves rpi over to use a text-based environment. Unfortunately i=
t
> > is not possible to empty the header file due to several CFG options.
> >
> > Fix the repeated "and and" while we are here.
> >
> > Note that this reduces rodata size by about 4.5KB. We could get another
> >
> > for a total image-size saving of about 15KB. This is mostly because
> > HUSH_PARSER is not enabled anymore and the environment shrinks down by
> > about 3.5K. Hush is not actually needed anymore, since standard boot do=
es
> > not use it. Also CMD_SYSBOOT is dropped since standard boot calls the
> > pxe_utils code directly in that case.
>
> It has now been about 6 months since I sent the v1 series of this.
> Even this v3 series is now out of date (in the cover letter).
>
> Is rpi still maintained?

Yes, but we've had conversations about this in the past and snide
comments and regressions don't enamor me to your patches...

That said without seeing this email I actually started tested them yesterda=
y.

U-Boot isn't part of my $dayjob and I've had limited time of late,
that's slowly getting better.

Peter
