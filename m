Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CAAC27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 02:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18B7D87E3F;
	Sun, 16 Jun 2024 04:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c4cFwEXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D56E88081; Sun, 16 Jun 2024 04:29:10 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C598787D4F
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 04:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b2c6291038so5066076d6.0
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 19:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718504946; x=1719109746; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aszYKufqY5UghKjFCtkNaldOvlz5yMIhek2NGPqH64=;
 b=c4cFwEXvmFBJU+QTIHnb6y/rHZQoa8uPD4A+r92vXPbDQyeRZIVwtJff8oU7Spefmo
 LfDCWbmTYb4XlJYnUnN6aoOlaybRKarq1irZC52G3geFsK/DGxP2O4br56Bq6gQV6DCJ
 O6Ffm3iJI1oHLIKN+Hu049sgZLmOykia2uy42rR58WNEdjI1mXRHkFmKJvloV//ybt3X
 XHEAEfqU/QVHDREYieNrbspUF6+VeBDk/ZI9EGm50Un/uCPQE3XjktMC0FXS5YjA5ibo
 ByVsCHNd6WGcGgPg4aT9vbQYAafuquboWHsd2UuW0j5YKKo3DUItY7dooQT8hguFDN2+
 UOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718504946; x=1719109746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0aszYKufqY5UghKjFCtkNaldOvlz5yMIhek2NGPqH64=;
 b=HK0FwzezlHpEg5mTfjRi9Vu7etTxY4Dw+yDf8stfdBtv5NaGAUA4ScdKUB4Q4paXlp
 SpgiGXXWw/gfUjvaakWmWoHPbvkzfDQI+p6V0nLJuGN00gvrclsfSx1NZhKQ/f3WHjo7
 Wl1ntQsPPuj327RMwflNQFZ5XwalygeMc+mmgEOiwyu3lB+zT3pNweyheC7jIOQGAVoo
 t/noofCe/Y/wXO23lctEaOfhZV7JKzYRsst85SIRc6KOHEG8HE/yD8isHlFDAl4pS83H
 ZiRFbGnFi42K/hJ5ihAV4rKYXMedngkFGic7/AwWM5w88dTMsBKgbmE2XN6HfsSGAtGv
 /0WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZop2kwf/a5kDl4V6oHtjvWe6pMYjcxapMYCsrvc44XuUxDlkKhcJNI7BsJWMqIZRi0R2P7N6MgHDcYktIcdVWEDp4rg==
X-Gm-Message-State: AOJu0Yzb93wtzG0XGWhqjFGNC6undz3iCFJzIodVrhjpadXrTCHk3wh8
 UAlIPu1sGKNC2CMG1C8ksvIxE6NvTw6JQ+HYhZgWwF3OildrmRJPgJ3TggOewi/ZIWw2Am9DlA7
 zgGRk+8GhOpRRH1n+fkG5YpFHPGw=
X-Google-Smtp-Source: AGHT+IEDB8Kw4EKhj0SBFHzu/zdxUmmB7AQBIXVS6771mR+n0YzANtCkeSOJxE/XPKA2xlhzU4AgcuD4APP2cNvI6/g=
X-Received: by 2002:ad4:5984:0:b0:6b0:9488:626b with SMTP id
 6a1803df08f44-6b2af26460emr114938076d6.9.1718504946570; Sat, 15 Jun 2024
 19:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240613080604.3828083-1-d-gole@ti.com>
 <20240616015536.7qqiwnipnnp7m37t@bryanbrattlof.com>
In-Reply-To: <20240616015536.7qqiwnipnnp7m37t@bryanbrattlof.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Sat, 15 Jun 2024 21:30:55 -0500
Message-ID: <CAOCHtYhcCj5=9iAspz-UcqxPzCqNhSLOtsSQ7kW0Hu3hgE27pw@mail.gmail.com>
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
To: Bryan Brattlof <bb@ti.com>
Cc: Dhruva Gole <d-gole@ti.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
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

On Sat, Jun 15, 2024 at 8:55=E2=80=AFPM Bryan Brattlof <bb@ti.com> wrote:
>
> On June 13, 2024 thus sayeth Dhruva Gole:
> > The Kernel Image and DTB files are supposed to be picked from the rootf=
s
> > of the SD Card, this fails in legacy boot flow because bootpart is set
> > to 1:1. Fix it.
> >
> > Fixes: a200f428b5b21 ("board: ti: am62x: Add am62x_beagleplay_*
> > defconfigs and env file")
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >  board/beagle/beagleplay/beagleplay.env | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beag=
leplay/beagleplay.env
> > index bbf6b925d02c..190181c8ad0c 100644
> > --- a/board/beagle/beagleplay/beagleplay.env
> > +++ b/board/beagle/beagleplay/beagleplay.env
> > @@ -11,7 +11,7 @@ set_led_state_start_load=3Dled led-0 on; led led-1 of=
f;
> >       led led-2 on; led led-3 off; led led-4 on
> >  boot=3Dmmc
> >  mmcdev=3D1
> > -bootpart=3D1:1
> > +bootpart=3D1:2
> >  bootdir=3D/boot
> >  boot_targets=3Dmmc1 mmc0
> >  bootmeths=3Dscript extlinux efi pxe
>
> Shouldn't the fix be to just drop 'script' from bootmeths. These TI
> scripts needed to go away years ago.

I agree! nuke the non bootmeth's. ;)

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
