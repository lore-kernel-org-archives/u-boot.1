Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7715BC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 05:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B61848751F;
	Thu, 11 Jan 2024 06:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dbPL0M58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D22E876EA; Thu, 11 Jan 2024 06:25:31 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1902871DA
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 06:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5989407dd3cso630522eaf.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 21:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704950727; x=1705555527; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VWbjMr7vRy/do9STS0NItHhvLJyjRnY9nGr3ZfmfPXM=;
 b=dbPL0M588mGe9qV/AEgfKUQtWERDb/Fm6iIfvdMsTicHOdRADpQhP+QxR7nXcf7Sdq
 yafMYtMq76+/MBCNcRRQcz9tEZN8g9w6Z312ndE63kqI1wjmyOdJFDsVFjdJsjsShPFj
 Tid117xGwSzZAdSAuTv4PYS+S1TWUr28xcB+WHP9C3HwCBS3NVc/amZCEmOoxwEXJVOV
 ApLfdaM9Rq++VQk+6jp/+eO+yG1+I+E8FZRglh3g3Ht+C9UVtVn7v0QLfWZfjE6KWric
 Qw96GaccpCa+JEx3gyyQFeiL7S/0hM3LoWo3moLeQPoJJOjUIjuAmkneoNQY/S0uSfRF
 UI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704950727; x=1705555527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VWbjMr7vRy/do9STS0NItHhvLJyjRnY9nGr3ZfmfPXM=;
 b=IR0epSEEh0u3ciXwilcd/W823s8vG/kd/9fyFCA8z1sVw1vvd9ODiEUKPjWuA+IrzW
 lNmTW0GaVLW435KHPQLXwAri3cbktnR/xcLCzm+/u69aTJjUfeR1KaL6nAgkDJ36Te+H
 sQjI6k/REcD5Q1zU0bZu+TrBV7LOKbXlkzyaI0pMWxcgLjUqE96d1IMuM4Z1ZdKyjsN6
 ZgI/ppC1Q69n2wpM87W0CW139q8juSdZF4cxKZuhQOLNQSvzv1ZT9iO5xhb1zIRRuD/5
 vojdlOxOZCoWBVVUKYzQ8CxqaM8/WBG3Gbxx0KGHJEKiDnKJlE+V6gjfBXwq1A5+PDhJ
 SqWQ==
X-Gm-Message-State: AOJu0Yyrxfs17r+wlGQ0gKDy+3uvXMQWo7WQyhuJYp1vYvcs2DDsFrWr
 hmyItUO4bgzilHfy0hsA/mEMA34nv0yVTZRjA7c=
X-Google-Smtp-Source: AGHT+IGN7P9pAd7ilHQUnp3mYWdkM0nZ0ljuXKIK7a2LQuSv37rZrzjh/Y+uSF1eihEiSk+pT8LUsKACZAw4a4i6tXc=
X-Received: by 2002:a4a:5a84:0:b0:596:269d:77aa with SMTP id
 v126-20020a4a5a84000000b00596269d77aamr549560ooa.18.1704950727302; Wed, 10
 Jan 2024 21:25:27 -0800 (PST)
MIME-Version: 1.0
References: <CGME20240109015516epcas1p368e48c6d3e2433577bf7d0684966c45b@epcas1p3.samsung.com>
 <0a3d01da429e$e4427ec0$acc77c40$@samsung.com>
 <20240109174945.GV1610741@bill-the-cat>
In-Reply-To: <20240109174945.GV1610741@bill-the-cat>
From: Minkyu Kang <promsoft@gmail.com>
Date: Thu, 11 Jan 2024 14:25:15 +0900
Message-ID: <CALrBrZ2P9cGB6m=O6gaiXKxZPmZ4ooSqT_aPPCWkazb6tht2gw@mail.gmail.com>
Subject: Re: Please pull u-boot-samsung master
To: Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.denx.de
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

Hi.


2024=EB=85=84 1=EC=9B=94 10=EC=9D=BC (=EC=88=98) 02:49, Tom Rini <trini@kon=
sulko.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Tue, Jan 09, 2024 at 10:55:16AM +0900, Minkyu Kang wrote:
>
> > Dear Tom,
> >
> > The following changes since commit
> 2f0282922b2c458eea7f85c500a948a587437b63:
> >
> >   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
> >
> > are available in the git repository at:
> >
> >   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
> >
> > for you to fetch changes up to 5631d20e2ef1008d55569790f79672ea8cc6894b=
:
> >
> >   pinctrl: exynos: Convert to use livetree API for fdt access (2023-12-=
07
> > 18:58:48 +0900)
> >
> > ----------------------------------------------------------------
> > Sam Protsenko (7):
> >       pinctrl: exynos: Improve coding style
> >       pinctrl: exynos: Extract pin parsing code into a separate functio=
n
> >       pinctrl: exynos: Rework pin_to_bank_base() to obtain data by name
> >       pinctrl: exynos: Support different register types in pin banks
> >       pinctrl: exynos: Refactor handling the pin related dt properties
> >       pinctrl: exynos: Reduce variables scope
> >       pinctrl: exynos: Convert to use livetree API for fdt access
> >
> > Stefan Bosch (2):
> >       common: board_f: change calculation of gd->mon_len to fix s5p4418
> > reloc
> >       arm: s5p4418: fix relocation of vectors
>
> Taking just the pincttrl changes here (as I know this blocks other work)
> I've taken that and I assume Stefan will fix microblaze shortly and then
> his work can be picked up.


Ok, I'll rebase my branch.

Thanks.
Minkyu Kang
