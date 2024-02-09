Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE73C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C2287EA8;
	Fri,  9 Feb 2024 10:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="az+9/0xQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640A487EA8; Fri,  9 Feb 2024 10:50:48 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DFA87EB8
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-511717231bfso934391e87.2
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707472239; x=1708077039; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gd/cvSRSn5Hqi3Bpos3bmrr2fBWP4jiUWU2T2mRB5uU=;
 b=az+9/0xQLRu4qswzWm1ZusYPM6kVB6GyVZnK+ohxs46xOcY3sxnrzpRPz1iYhLAkpC
 RAz3+CynTGz4nH8ekWg7W44iBDMSG5J2eLZmg4oBjXA8eMOq0ZEwjNIPcByDw2d0H3B/
 GU5bRT56+CWN7dZ7R4o1m2q7kTF5eYDG5xu2F0/3+Qt2Igr35bE1w10zNE+vgMBAxzX4
 mhKzVXSym7kbLAdEaF9EawyGPG7HvSWAC0bQj9+u6+7/fTeZj8EfcyWr+ROvE8KoHMeb
 vpblePs/iuTJVIxKMUHCnaeJNHcNL0/n9iy5ne4asJ3pd4CRtnz/s8DaHyQg0f0omCg0
 ip2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707472239; x=1708077039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gd/cvSRSn5Hqi3Bpos3bmrr2fBWP4jiUWU2T2mRB5uU=;
 b=Cfdlk/esrDsio+VBK5eNCrbayuPi3jC7zM8xVDlPl5T5pgzReHDiU7n13Kj3VQJPAj
 BXlOPLtIW/r5Js6MkntG19y1lBNO/gthPGfwot25V5iXEDwDwVtYu5Jyu5ouldWAeIGn
 nNjh8NQY0RZMntKaySVz3kj56gpLGqDC5nyNbJ3bE7a8hrBJjF3z+acNY33WA3Kwyc1G
 3UZXuqGATy65p4sRelhaE6rTDXwZrFlijg6x+V/mTJ/Ox2thTQDzDhKnM6E7qGqruhVE
 0JcpMZf7lJAj+/FzuMrL3BSldWBFTf3XFCqYFWehR7RGXrO5OzaZuM/AInEoesH7XGEt
 2fIw==
X-Gm-Message-State: AOJu0Yy6RVgpfNrKSAQpaLWWmTJL2NcaIbTpPDl9aWIn77mzWihATKFt
 TJrUzRpN8UHE80lXJIfVKhzmGybER6Lr/uBPi8vxOCH7B46Bm2dx595Jy3ktCdozNReFpXiePrj
 V2PI9wbxbt+jWVNMaIR8JUksNDVDUMepLttpOZUpikVSCDUHtbQQ=
X-Google-Smtp-Source: AGHT+IEd7uy2Xy0MsmyXXfSHL2wiLIAH7htR9sEb6Ug5rEfBGLyMZOQXZw02Q7Q/iI9wrnp25RwTmZcGP94oIpyjUWs=
X-Received: by 2002:a19:7418:0:b0:511:6077:c99c with SMTP id
 v24-20020a197418000000b005116077c99cmr669931lfe.30.1707472238835; Fri, 09 Feb
 2024 01:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
 <20240206223153.3060433-8-igor.opaniuk@foundries.io>
 <87zfwbhwo5.fsf@baylibre.com>
In-Reply-To: <87zfwbhwo5.fsf@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Fri, 9 Feb 2024 10:50:26 +0100
Message-ID: <CAL6CDMFVgGM_AHjecDYEkjZaEPV2FcS4mg3dCToRqBXSYSQQ4Q@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] doc: android: avb: add slot_suffix param details
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Mattijs,

On Thu, Feb 8, 2024 at 3:12=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Igor,
>
> Thank you for the patch.
>
> On mar., f=C3=A9vr. 06, 2024 at 23:31, Igor Opaniuk <igor.opaniuk@foundri=
es.io> wrote:
>
> > From: Igor Opaniuk <igor.opaniuk@gmail.com>
> >
> > Add info about slot_suffix param for avb verify.
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> > ---
> >
> >  doc/android/avb2.rst | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
> > index a072119574f..c0b2bedb831 100644
> > --- a/doc/android/avb2.rst
> > +++ b/doc/android/avb2.rst
> > @@ -39,15 +39,17 @@ Provides CLI interface to invoke AVB 2.0 verificati=
on + misc. commands for
> >  different testing purposes::
> >
> >      avb init <dev> - initialize avb 2.0 for <dev>
> > -    avb verify - run verification process using hash data from vbmeta =
structure
> > +    avb verify [slot_suffix] - run verification process using hash dat=
a
> > +        from vbmeta structure. Provide [slot_suffix] if vbmeta partiti=
on
> > +        is slotted
>
> Any particular reason for this to not be exactly the wording as in cmd/av=
b.c?
>
>         "avb verify [slot_suffix] - run verification process using hash d=
ata\n"
>         "    from vbmeta structure\n"
>         "    [slot_suffix] - _a, _b, etc (if vbmeta partition is slotted)=
\n"
>
> It looks good, but I think it would be better if both are the same for
> consistency, since both texts are user facing.
Will fix it in v2, thanks!

>
> >      avb read_rb <num> - read rollback index at location <num>
> >      avb write_rb <num> <rb> - write rollback index <rb> to <num>
> >      avb is_unlocked - returns unlock status of the device
> >      avb get_uuid <partname> - read and print uuid of partition <partna=
me>
> >      avb read_part <partname> <offset> <num> <addr> - read <num> bytes =
from
> > -    partition <partname> to buffer <addr>
> > +        partition <partname> to buffer <addr>
> >      avb write_part <partname> <offset> <num> <addr> - write <num> byte=
s to
> > -    <partname> by <offset> using data from <addr>
> > +        <partname> by <offset> using data from <addr>
> >
> >  Partitions tampering (example)
> >  ------------------------------
> > --
> > 2.34.1



--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
