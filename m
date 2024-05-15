Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B183C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 10:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A052488176;
	Wed, 15 May 2024 12:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bq1MfDh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FDB388179; Wed, 15 May 2024 12:19:58 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015188816D
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 12:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-47eef876f2aso2186887137.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715768395; x=1716373195; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HF+JS+HfbflDrfR9SJ1q1lRwek1sAzk2G58SOv99U2I=;
 b=Bq1MfDh31aKeXgkWLuCybGP3n0FzNT1vfhouLupuKZvhdCC2GyTjux4GVtITmjrY/p
 0NVYLTcDb7YFh2RumR0RT8JBSdWVn8H4FKH70bfcbtsW/mBNobri/r3whRwbEzBt+81u
 8HbZDYoi+RtzIcdbkkDjxl1K8mCsBAaM+SGOAHl1grfcX4WNQtRJO2rQPayC0V0+dhW2
 U9xb8A2HfhUXf87wymOPniFgzZHcVl96Z0GLDWoBhbVvLqQ5VRco+wlTeJngQ0udeYiz
 LpYSzNQBvZ3gqwxZTTBGVVuFFsB13rrA62g9nXz+05XKKK1ooOzoWHuQ+eytTOwByTfQ
 zexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715768395; x=1716373195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HF+JS+HfbflDrfR9SJ1q1lRwek1sAzk2G58SOv99U2I=;
 b=F5f19kJFab/QIHNytDChTb0KWfOLqAwRiizCP7s4++IwaAuWb6YTPyaDnpIaqVQU30
 vTuRvMrLQ53FlXWY+txJ+93GHuKSAjCr3JNp2+aTPTEYhQY2SlmsSdf1yUOSeymPtYJa
 v9WTg9oNJHgt8UWNpVMQOoUYOGykteHK8Q54nyn4X6bYKN0KbyxU7sIds50oujelDF5n
 ecy1M5/vIVs4b4ountK1mmq5mKs/EeJVwxAsfQ0COindaB8+5NT9n8lZFVSgo+k9YpJ3
 FurTTXRH26kCkcgUyIKbU6uQbK3R4tvcjYRpDe5EBbnLOpA5xfe1kC9tLIx39dVKivQ+
 h6Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY4eijjQHEc14lAkWRIFMfdoENjFfXtV2fCqhwWn8kcqb4wj2K9SzeL//n5f+YEs8AsjXlK0FYuRNcyqbYve1BkHAAZA==
X-Gm-Message-State: AOJu0YyvRcNjQnm3nyO3N2PuyJyt7SdIafDXo+tlAH6X5a0VLW1VBwBB
 DzdSF8zER4MinFX/TrlOEYCBJ9fVO+3r30pUgONFb+t1ouINAJzH3Yz7+t6ZmrBs1FMIlRFHO/X
 N2tCfIsRLqxFCk3FCrPx7oOkSrXCy+TxIJeWaJzfeLoF2JUERkEQ=
X-Google-Smtp-Source: AGHT+IHLOVr/VEmt3MdowYbGzLU9sKKB+/NK5Kx+0v4uWo0tOj6D6DtX0dftGouaQcsptfYvmW48BgPmmV/Dd25mfFI=
X-Received: by 2002:a05:6102:38ca:b0:47c:2c87:f019 with SMTP id
 ada2fe7eead31-48077db706cmr17749696137.5.1715768394653; Wed, 15 May 2024
 03:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240514164236.516595-1-trini@konsulko.com>
 <b12a9b07-2c92-4651-b6ba-3aff6ecc9219@kwiboo.se>
 <CAFA6WYPsicMrtrDg7T8m=4-vg-QAPUY1D5E=_T8gZYgT=o2b4Q@mail.gmail.com>
 <e26ab5cc-2b2d-4e96-a073-819a935f435a@kwiboo.se>
In-Reply-To: <e26ab5cc-2b2d-4e96-a073-819a935f435a@kwiboo.se>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 15 May 2024 15:49:43 +0530
Message-ID: <CAFA6WYO8r-v46nPSpOFw9+Ud9NJcbOwFEu2E=0HmWKuPMybdiQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 b35b9bd1d4ee..7e08733c96c8
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 15 May 2024 at 15:09, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Sumit,
>
> On 2024-05-15 10:49, Sumit Garg wrote:
> > Hi Jonas,
> >
> > On Wed, 15 May 2024 at 13:11, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Tom,
> >>
> >> On 2024-05-14 18:42, Tom Rini wrote:>
> >>> git-subtree-dir: dts/upstream
> >>> git-subtree-split: 7e08733c96c84eb323f47e9b248c924e2ac6272a
> >>> ---
> >>> This moves OF_UPSTREAM to be tracking the v6.9 release and is for the
> >>> -next branch. To test these changes yourself locally, either use my
> >>> "WIP/14May2024-next" branch or run:
> >>> ./dts/update-dts-subtree.sh pull v6.9-dts
> >>> yourself locally. I intend to wait a few days to apply this to -next, to
> >>> give people time to test.
> >>>
> >>
> >> There are currently more boards/SoCs that use OF_UPSTREAM in master
> >> branch than in next branch, a few Rockchip SoCs and other boards/SoCs.
> >
> > Glad to see more OF_UPSTREAM adoption.
> >
> >> Next dts/upstream sync will probably be good to do together with a merge
> >> of master into next :-)
> >
> > I don't have any particular opinion here and rather leave it upto Tom
> > how he would like to merge stuff.
> >
> >>
> >> Also what is the expected sync cadence of dts/upstream? Linux v6.10 will
> >> probably be released shortly after U-Boot v2024.07. So will next sync be
> >> to v6.10-dts if that happens in the U-Boot merge window or do we expect
> >> 2024.10 to use v6.9 DTs if the v6.10 release gets delayed and miss the
> >> U-Boot merge window?
> >>
> >> Linux kernel typically have all major DT changes in -rc1 and fixes in
> >> later -rcX, so for next branch I would suggest an early sync to a
> >> v6.10-rcX-dts tag, and then sync to the final v6.10-dts tag once v6.10
> >> gets released. That should give more time for testing, migration and
> >> cleanup using v6.10 DTs in time for a 2024.10 release.
> >
> > I can see the reasoning for an aggressive DT syncing approach, it has
> > been brought up in the past too. And the major reason for the current
> > moderate sync approach [1] is to limit any DT ABI breakages for
> > U-Boot, we are even prone to breakages with syncs against major Linux
> > kernel releases (eg. v6.10-dts etc.). It has been a long time
> > discussion topic where we have been advocating about requirements for
> > DT ABI stability [2].
> >
> > So having DT syncs done during the merge window will shorten the
> > testing window for developers/maintainers. And more syncs means a
> > multiplicative factor for testing. However, time will tell with more
> > and more platforms adopting OF_UPSTREAM, if there are any real DT ABI
> > breakages seen in the future. But surely if they are very rare then I
> > am open to adopting aggressive DT sync approaches.
>
> I agree that syncing multiple rcX tags may not be that helpful, but an
> approach where maybe rc1, rc2 or rc3 and then the final tag is merged or
> something similar. At least when we can foresee when next Linux version
> will be released close to an U-Boot release. At least early in U-Boot
> release cycle know what Linux version dts/upstream will be targeted.
>
> My main concern is how to best handle new boards and features/drivers.
> E.g. for Rockchip the RK3588 SoC is under active development, new boards
> and features/drivers are actively added/fixed in upstream Linux.
>
> New Rockchip boards have typically been added after board DT have been
> merged into linux maintainer tree. Now if we wait until merge window to
> do a dts/upstream sync, the result may be that it may take up to three
> U-Boot releases until a new board is easily added using dts/upstream.
>
> Another approach could be that we add new boards using !OF_UPSTREAM once
> they are merged into linux maintainer tree. And then migrate the board
> to use OF_UPSTREAM once the board finally ends up in dts/upstream.
>
> But that can also be problematic when board .dts-file start referencing
> nodes/symbols not yet added in the soc .dts-file in dts/upstream.
> Adding the "missing" but maintainer merged soc nodes to the soc
> u-boot.dtsi could be one way to work around such issue.

I would suggest you to then maintain the under development soc
.dts-file in U-Boot too. Since with !OF_UPSTREAM, the soc .dts-file
present in the U-Boot DTS tree (arch/${ARCH}/dts/) will be used
instead of one from dts/upstream. This was especially done to support
use-cases like this via the directory include ordering. You can later
switch once you think the board is well supported by dts/upstream.

>
> Anyway, some guidance, predictability and earlier sync related to
> dts/upstream would be much appreciated :-)

IMHO, let's try to provide a stable base to encourage further adoption
of OF_UPSTREAM and have sufficient data regarding DT ABI stability.
IOW, let's stick to the current moderate sync approach for a few more
U-Boot releases. My motivation has really been to reduce
developers/maintainers' pain regarding DT maintenance in U-Boot.

-Sumit

>
> Regards,
> Jonas
>
> >
> > [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
> > [2] https://www.mail-archive.com/boot-architecture@lists.linaro.org/msg02162.html
> >
> > -Sumit
> >
> >>
> >> Regards,
> >> Jonas
>
