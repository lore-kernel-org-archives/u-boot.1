Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F808CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 20:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A754B8486B;
	Wed,  3 Jun 2026 22:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CKkuFKIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9AE84868; Wed,  3 Jun 2026 19:45:51 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 802458467E
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=compholio@gmail.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-9639f50efc6so4134301241.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780508748; cv=none;
 d=google.com; s=arc-20240605;
 b=R1Xe0W4bikqXpBROXMAjdVWQyEqWMz5R8ffDgHuGfWUk2my7qXVXMYTsxKstL1tsQh
 X0wDG/lXIHODumv+0pESYF4ch6N+mjY2FKAQIbByCKlAKPEm1mpvzpugZgnM7HL4S7Zh
 ldxx29fauS9MLCdQhEooBAxUV0xvA0oeUfGSKMiYHCrvLqI1Htv/b1nk6q+Bm3wIqNfZ
 kSVgwJ9ijCQv83csPyR+fnts/WEZi8qASDmxdRkybIrieySfwbkXy4AiCzUKi6C+ZVMO
 N4y+MRZTX8f0yd7qL/87fbJkgEJ2PivW9oM2XmL4P4c/bMsYPgs2P/0e99zP+xMkfUEi
 mZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+eNl1Flvq4DYR+CU2prrNWcBE3II07SpwrPaqtNibAs=;
 fh=oc1K78mEQyzoqS6zkPeJ7dptk6HQ3hrenIqmrOeZVo0=;
 b=R2LA/FCGntBCoVzVzxfUpAyCtruXFYUINj11DCleHVCzwqzemL657K4m9j03ctEVX/
 8uP0bO5eXri5fYJE4A5c9+REooUFGoyBxd+D2EvEnY0LlRFWh4OABFZaOrHk+mSMB3+F
 DlNwBgtl2i87XGSXtOfxykDp9At3Jx5/o6/ip5kneskEKu3n+M3GNogenkHdYM1GDoAa
 NoRrlDXk26u6vZc++hPGxSagbQknf4lFJmNjgDiy2AFrws2WHPBZ64CzHiTEoSNjCbaB
 EA1ZHShMJihXbZA5/JfsJOle0U7c+9CwK+CVWqxhjS/123xUtPiQ+rOzXiGcwr+2UYtl
 SFWQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508748; x=1781113548; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eNl1Flvq4DYR+CU2prrNWcBE3II07SpwrPaqtNibAs=;
 b=CKkuFKITsL8TDTe6/fCQ52ulteKQQQJwKegiwZZJ1lGbvGq0py3pcE3z/H2XPz7Do7
 0RjE3WR9wLMxLHDxgP1nxPmIaQa5WMvSwbwui1cbss/vLh5m+c/BgXK3pGHwjH/O+ujn
 GIHvQInDk/kCs5Shaeh7qmlAyDUC999R3MfmZJe/RE36jU7S+k48lhFHZhsEE3n2fI9N
 Yc7uwNfkTlvmxNmYd6QqpCs1U8/9iosxEEtlsUEThjF3dZPb9ISKZkMs/e2FUmRv4IDr
 9ZoInKTeppgLUL1VPW0MY17sfaBim+b9ApaAP9xiqIfdX5Cg7SLLyAU3GpjmZ7SBhOur
 G0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508748; x=1781113548;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+eNl1Flvq4DYR+CU2prrNWcBE3II07SpwrPaqtNibAs=;
 b=KLREysGifp5I7khZYBga63idYSw15mDcH74k8ISfvR51LBBUq896xo/FiDOMnB/X3I
 We/TMRqgIgHweVaP4dX9UH3Pj/YRmZ9EAzHJyRoUOR1o8AcXEUkuVvotGHs/K/BHzCBX
 pZ0IIFXRX4i4cnoj5mRiT/mw/tVjeBs7y0vUwXCpoIMXAl4Rp1r429zZMssS8BiNr5jw
 M6kG4asAA2zTzIK79EyV3vHJgb3cf3FOhjPw8yfH+EGE8s5ncK4Ouohkxj2ZBXaMcHNW
 jhSs5urQZoPL1sMg51mPKTgqx9JyE3kIb/kqC2L5CAmDRu4U8TgvQpOHTs1uShbT+k1r
 j+1g==
X-Gm-Message-State: AOJu0YyvuvL5egoWmTn0ZJbG8RuRM1/GG1rOn1PUzZ5QwrwTq6nk3gbt
 gqex6Z7cWv/7RPyO/B4v0AzsmIll/M4LUamMXhNDHsh1GKdY2PgmdxcoOkqcut1PG4yGRnzmUO8
 dVZR+I9JoUdIDTsQ1vTGyeEm5Iz9SLH8=
X-Gm-Gg: Acq92OGp6fdywx4m+0NxTh60wrkMdlDi7krCTQJAfGHAWqKDPu7VkonkjuS6MCaHqyI
 Ad3Dn9FHsycmtP7g/aMilyzXDy/8Yg5it5s/+cSgmS8FWh9WAvfSGLwJLltqchu4YhqjsbMSDDI
 nqeMYgKz26pR/GA4hgIgstaRlpxxIkn4tHkiPBErcjBoBE86crT3F+E0xNppAFUwVqHnbWDwOGJ
 CIBvMwmbC6hoNVcm7DqXYiTFKDh0kL/JeurXmprSnAy6McXR0I/YsJ64EEhAoUIM0NoV+7ipeYj
 6dvydYWSTJoqIEM1cw==
X-Received: by 2002:a05:6102:8011:b0:650:94b2:b209 with SMTP id
 ada2fe7eead31-6ec2808155emr3370901137.4.1780508748300; Wed, 03 Jun 2026
 10:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260602210141.62966-1-erich.e.hoover@gmail.com>
 <0a768686-d9c9-54ee-c101-92077805b504@gmail.com>
 <CAEU2+vrQijegaxRhjGoMr=kKcQ2mbXMh8WD3oEpa+HzDfbUE2w@mail.gmail.com>
 <86b83c9e-2344-542b-8c82-f3106150878d@gmail.com>
In-Reply-To: <86b83c9e-2344-542b-8c82-f3106150878d@gmail.com>
From: "Erich E. Hoover" <erich.e.hoover@gmail.com>
Date: Wed, 3 Jun 2026 11:45:35 -0600
X-Gm-Features: AVHnY4L-oM-kvl4OreGAYXvhcVFvpkTbnfDpPKxB2XqpruTk_4QJmKQCkT7z3BE
Message-ID: <CAEU2+vrTq-3Xy5MwHAJZ_zjx7bdM1qih=3Tmkp_u758WcXf+YA@mail.gmail.com>
Subject: Re: mkimage: allow zynqmp to use a register initialization file
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Mike Looijmans <mike.looijmans@topic.nl>, 
 Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 03 Jun 2026 22:19:36 +0200
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

On Wed, Jun 3, 2026 at 11:34=E2=80=AFAM Sean Anderson <seanga2@gmail.com> w=
rote:
> On 6/3/26 12:25, Erich E. Hoover wrote:
> > ...
> > Yes, sort of, if you are using "zynqmpimage" instead of "zynqmpbif"
>
> I've never seen the point of BIFs; I've been able to do everything I
> want with zynqmpimage.

My understanding is that "zynqmpimage" only works if you have one
"partition", so if you're passing the ATF or other partition data I
think that you have to use "zynqmpbif".

> But this info would be good to put in the commit message.

How's this sound?:
=3D=3D=3D
The ZynqMP Boot Image Format allows specifying the register
initialization file with the "[init]" attribute.  Since this
feature is already supported by the "zynqmpimage" backend, this
commit implements a binding to that existing support.
=3D=3D=3D
( https://lists.denx.de/pipermail/u-boot/2026-June/620814.html )
Please accept my apologies again for messing that up the first time around.

> > ...
