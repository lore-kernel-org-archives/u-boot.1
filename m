Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516B4C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 14:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB0CB87E76;
	Fri,  9 Feb 2024 15:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=olakrutrim.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=olakrutrim.com header.i=@olakrutrim.com header.b="TiLf7W3S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7433A87E71; Fri,  9 Feb 2024 15:15:26 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A9887E46
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 15:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=olakrutrim.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=selvakumar.velandi@olakrutrim.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso9674775ad.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 06:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=olakrutrim.com; s=google; t=1707488122; x=1708092922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j/eVZgqX28r0h+8wjWKBdYK9hryKsoWfQ72M2+H4oPk=;
 b=TiLf7W3S9m2yhq5+OcnifDUcze4xAEpy/PXslwT4l3VRQDRUZk7iaEwUl5gkPbB2AL
 DRMI2eEmsNWH9BgIbd4MDogsY4RwhoxEJ0VwCfV1D8bQoJJaQNjhMWzA7UJdwp0BBfyJ
 rYR5khbrh6n+9fwLCH8xseGU0zg9aMgpF1KK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707488122; x=1708092922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j/eVZgqX28r0h+8wjWKBdYK9hryKsoWfQ72M2+H4oPk=;
 b=xKLNXK5Yc7Xp//c74PUsaVWMPW417y6Z8PRTzcqo9KlBL2eYXrwJmGbvkY/jvqfPa3
 3YiiZtQnTDI3vEkr+dTRcmEPk16ctBiJqtIy3NMEBr076iKswRrOZqjlUO3A2uR7lMn9
 IWr20E8l1JN/bAjIK9dGgbK6IIiPi/a5FwFTKe+3aJTf81o0MUL48tFDERGDyZ5ai5+j
 TaUHiMrjdf5c1pIaS/ZYQdYt4gwAey2OlTz2wLXuzAZKgr6BSw/po97QCOVWC17X4sYJ
 JvFNvGYVY4Tw2f0g0XbQsTkbeVm6JrpYF+8CN/3MM3dZ1sSAz+1QcgXnJRrEcIzBm4jU
 DHtA==
X-Gm-Message-State: AOJu0YwBt4efUkiWqj4WGK4A1SgFuZEbCaU76OjCvAB2faWh0QO4jgLa
 MUTi6kCy7NTazXFCS02r2y9Tg6M7AqtwVXqR2B5FB8DZVK2obJCntPWO+FSDS0CLR3Uw+jDO4lt
 3n+0zADCiyfdTCD1iZ2l/8IYrbzZrVuqdKwARMloa+ZhburTINKAdqd9R4/n7ccSPjK6PH/8KhL
 hK1VJlmDayRXVqVyzemhg=
X-Google-Smtp-Source: AGHT+IES9SLXtP2nfsByXvM/msjz9idL1lLckj4/c0DyqOFZbOvpo+ShHj/kbGN3IpjaTJS9CSZjCTbPLgaaRNqra0A=
X-Received: by 2002:a17:90b:310d:b0:297:12e8:6d2c with SMTP id
 gc13-20020a17090b310d00b0029712e86d2cmr231285pjb.5.1707488122300; Fri, 09 Feb
 2024 06:15:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-dvqwMWvWw0=34ZLkG37MwTRG1m_tabSi0zLkoHNY8CjR_PQ@mail.gmail.com>
 <20240209134027.GN1152441@bill-the-cat>
In-Reply-To: <20240209134027.GN1152441@bill-the-cat>
From: Selvakumar Velandi <selvakumar.velandi@olakrutrim.com>
Date: Fri, 9 Feb 2024 19:45:10 +0530
Message-ID: <CAJ-dvqzoCPRtO4hczmH+ygU8pAUKMxAzRqegcD02NbTJo619Pw@mail.gmail.com>
Subject: Re: [PATCH] Added FDT PAD memory size while reserving memory for FDT
 to avoid some memory corruption issue
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 09 Feb 2024 15:15:51 +0100
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

The FDT relocation is not disabled. I am adding the FDT PADDING bytes while
doing FDT reservation in the board_f file.
Also update the FDT length based on the new allocation, instead of blindly
increasing the size.
Currently the size is getting increased even for the relocation disabled
scenario also.
So without increasing the physical memory for the disable relocation use
case, the fdt total size is updated. thus causing memory corruption

On Fri, Feb 9, 2024 at 7:10=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> On Fri, Feb 09, 2024 at 01:22:08PM +0530, Selvakumar Velandi wrote:
> > Hi,
> >
> > Issue:
> > Linux kernel getting crash after loading kernel in VM system using RISC=
V
> > QEMU.
> >
> > RootCause:
> > Memory corruption in uboot FDT memory while launching a VM system in
> RISCV
> > QEMU.
> >
> > Fix:
> > In the board_f.c file the FDT memory region is reserved without FDT
> padding
> > bytes. uboot will add some params like bootargs while launching linux.
> > While relocate the FDT, if its decided as run in the Fixed memory
> location
> > i.e fdy_high is set as -1, then the padding bytes not added while
> > relocating the FDT,
>
> Do not disable fdt relocation. The RISC-V platforms which do this today
> are broken.
>
> --
> Tom
>

--=20
***
This communication is confidential, may be privileged and is meant only=20
for the intended recipient and purpose. No part of this email or any files=
=20
transmitted with it can be shared, copied, forwarded or published online or=
=20
offline, without=C2=A0prior=C2=A0written consent of the sender. If you are =
not the=20
intended recipient, please preserve the confidentiality, delete the e-mail=
=20
and attachments, if any from your system and inform the sender immediately.=
=C2=A0
=C2=A0

***





