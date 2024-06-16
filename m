Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB10C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 02:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 135A687FEE;
	Sun, 16 Jun 2024 04:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iyJE9+Rz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0CCA87FC2; Sun, 16 Jun 2024 04:30:42 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B9D87D4F
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 04:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b081c675e7so18992206d6.1
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 19:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718505039; x=1719109839; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MF/u/Q2Ym2gAka0KhxYbQ3NS0lvapkr72amFtmL89A4=;
 b=iyJE9+Rzxa4XHE4sWqPSSXMQ7Y323GuZvA+JE6sSjVbct5RVSkTaXbNV2L7gknnwIN
 ZN4PGUzIXrUR+a3lF98g/JXQaEhj3fM2lSSzlOu6TZG4qUpgh2vCFDtdt2e1+BHg6YQS
 xlSkYhIkOlOlugPNhwpTG/M0K8pxV0t6p35U1amNwD5TmhbUwyWDTVK3z9XwoHOeRYen
 qexPPyw3bhhNRd5puivxsV0URorff6/qS+cYHPZe/WKeM+NigqQeXhLXgDv9V5EltHmW
 4LfTqdeATchQkS1czplGS7WbgH1XUd153niqv/sRgPVPnyN2GR0kJZnV0libEVjYhx6w
 LIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718505039; x=1719109839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MF/u/Q2Ym2gAka0KhxYbQ3NS0lvapkr72amFtmL89A4=;
 b=tMMk7uOB7r8mQw+7UdNhAT5Mk2JpQgsZ/dLWILuF7LwojbjXa45sH31cARrpCD7+lP
 OnwiYQDrY7SKb6yqRMC52btR3N9o1VX/zhYkaDQQ6gIYREsdM9SFutWDkl+GRdXW8MuJ
 2i+wFd5g3JJ8EsrVo8QXVTwO3OKCeN//EnMhMFkDmxVUhwHuse74U2+W7Zfkny0CnADy
 BETntdx9y170hiBjh11eLRCkHFtwP5rhNslNEaauZtPCUFFKZVfAWpUEwnQ5RJQmsSGq
 8YHFN38A78rQc+qTh33Gnlg4ZDrxEPX64Zk1p5h4gE7qTblCqZ+YsELfNZpBr4igDemQ
 6SKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkwHgzl031UXORlN5GkuBe9Wv+3E3AvyREbQWBSf28pawWd2zHxkEyDGgkEJVRCFgOYcxwsWD1c+WqZjh3aOpcsMpr2A==
X-Gm-Message-State: AOJu0YwP0ARhDS+bbMdcj4TOj+rSlgSR0byvTyvdHpl7DZ/doV4j1V3v
 mAjZwIFn23fA3vdM++Mb2rOM/o6oDUhXiyb2/zu8trtesukIL5xO3zuCTUQACj2GLBlaDy0oG5V
 435MCIDpv0WNd9hyd4mghMPkG5Oc=
X-Google-Smtp-Source: AGHT+IEdGDaUWrpon2kSRae5nZnblKKV58N7IsCm1eJf9DhZwIS4MVcF3lhBCgnijeQQvyl1XtjHDnZ0XSfviqmr4SE=
X-Received: by 2002:a05:6214:21cf:b0:6b2:d230:3fee with SMTP id
 6a1803df08f44-6b2d2304159mr1355926d6.30.1718505039249; Sat, 15 Jun 2024
 19:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240613080604.3828083-1-d-gole@ti.com>
 <CAOCHtYjAFE0sbyYRXnbsv9EohNfH99vsuVYiZbi2Ami_xdoxWw@mail.gmail.com>
 <CAOCHtYi7vjHeCcUzgDBkayGx9W3gR6MT==8ASf+7524pu21Vbw@mail.gmail.com>
 <20240614060435.ema3wczc7r7tgetu@dhruva>
In-Reply-To: <20240614060435.ema3wczc7r7tgetu@dhruva>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Sat, 15 Jun 2024 21:32:27 -0500
Message-ID: <CAOCHtYh8RVywGXewG_O0J63N0zLp4JnnGrFA16wasOnns12YnQ@mail.gmail.com>
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
To: Dhruva Gole <d-gole@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Vibhore Vardhan <vibhore@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nishant Menon <nm@ti.com>, c-shilwant@ti.com, 
 m-chawdhry@ti.com, vigneshr@ti.com, Judith Mendez <jm@ti.com>
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

On Fri, Jun 14, 2024 at 1:04=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> Robert,
>
> On Jun 13, 2024 at 16:51:24 -0500, Robert Nelson wrote:
> > On Thu, Jun 13, 2024 at 4:47=E2=80=AFPM Robert Nelson <robertcnelson@gm=
ail.com> wrote:
> > >
> > > On Thu, Jun 13, 2024 at 3:06=E2=80=AFAM Dhruva Gole <d-gole@ti.com> w=
rote:
> > > >
> > > > The Kernel Image and DTB files are supposed to be picked from the r=
ootfs
> > > > of the SD Card, this fails in legacy boot flow because bootpart is =
set
> > > > to 1:1. Fix it.
> > >
> > > and where is that rule defined?
> > >
> > > Production boards ship with Kernel Image and DTB's in the 1st fat par=
tition..
> >
> > Besides, u-boot should scan for extlinux.conf on "any" partition.
>
> I can see where you come from, and I agree on the above points when it
> comes to stdboot.
> However when a user wishes to use legacy boot, and in the case there
> isn't extlinux.conf in such a case u-boot will rely on information in
> the env file (please correct me if my understanding is wrong).
>
> The env file says:
> bootdir=3D/boot
>
> Thus u-boot ends up looking for Image and dtb in /boot/Image under BOOT
> partition, and ultimately fails, because the /boot/Image path is
> generally found inside the root partition ie. 1:2
>
> The idea of this patch is to keep support for such legacy boot alive, if
> you feel there's another way to do this feel free to suggest.

For BeagleBoard.org we never used the legacy boot path on this target
(or BeagleBone-AI64), this was put in place mostly for TI's u-boot
scripts. ;)

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
