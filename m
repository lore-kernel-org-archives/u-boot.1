Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC10C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 12:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B1E387E1C;
	Wed, 14 Feb 2024 13:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=olakrutrim.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=olakrutrim.com header.i=@olakrutrim.com header.b="chhHqkP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFAD987DE6; Wed, 14 Feb 2024 10:27:51 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6965D879E0
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 10:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=olakrutrim.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=selvakumar.velandi@olakrutrim.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d70b0e521eso39904275ad.1
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 01:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=olakrutrim.com; s=google; t=1707902851; x=1708507651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SK8OhHBUN8WwUrXzSUe62hnpb8AoHatMFZNaSHwg/Nw=;
 b=chhHqkP4uWi6VeouuXnNBvr/f8TDljzB39zK5dig1jhpJ6BXfJ+jH8BNwySuznQTZR
 x3+3pP5BIQbOx9mu89/KcgOx4jblxWd1t2+vCREAhyjKVwmuBgU5PEn7WHBRs45N+eMY
 J+OX5b+7jo+o95hoxq2jo0DOpHJ76zn0Nxyis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707902851; x=1708507651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SK8OhHBUN8WwUrXzSUe62hnpb8AoHatMFZNaSHwg/Nw=;
 b=JQ+/XG60diXucz9PJ40aNFZ9c/FIDZnmOx1YZhkiyWcl4bWbv2TYqrWkyqwcMEReAA
 KqQShfiUm0zlSIcK+yLNDtxd92T0k9bfHBkHCtilOlOL07whXvbhagCiv+K4nLxS3AFw
 RCS6jyJlpNfFdkXhaIlSHKR+X0tStUSrFQgD3vcRIAFEWlKxp4vyAI0P2XGFcB555hXX
 laogqkqrsXgBVBYmRXfZU7ZuFhgC6GNZTDBS6QPs+j1StC1ieGw3D6NfA6PugC1Emw9X
 dS03aBmxr4p2plbtFBBV5URf9l67M/QSlsvNBoU4MUOKl9/OApy9qWk7e7MNLwnyNEAf
 rkng==
X-Gm-Message-State: AOJu0Yx+PkuZzUkdNpdCaY0b5cQSK4A7K7LzJayBF1lxdK0mpcZTl7Gi
 XtuO7LbYbSENfHprTMKN5zgvf/hzkH6Kt4+2yd4r/9AtqqPXPOr82j8MftUz1DpHFQtg1Jb/pWQ
 fsGPjxiLD6nEI7vOktjXObl54fJ56opGc3JDHFSnv4bTxWHxr1Xldjv3JWP4JgewtdVwLF2TmXb
 TKbOH7yrxc71dh2eLuR/2xpbREQq9wmg==
X-Google-Smtp-Source: AGHT+IGYQGwSLfQjhS2BCPt+KHNn6bDcz4PVrLolm+yJ4FOuICc63YAwF5Wxo5kKyjWRPn0Se/js2cbJPvd+usAj9bo=
X-Received: by 2002:a17:90b:2349:b0:296:2589:c05e with SMTP id
 ms9-20020a17090b234900b002962589c05emr1724692pjb.30.1707902850594; Wed, 14
 Feb 2024 01:27:30 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-dvqwMWvWw0=34ZLkG37MwTRG1m_tabSi0zLkoHNY8CjR_PQ@mail.gmail.com>
 <20240209134027.GN1152441@bill-the-cat>
 <CAJ-dvqzoCPRtO4hczmH+ygU8pAUKMxAzRqegcD02NbTJo619Pw@mail.gmail.com>
 <20240209202509.GQ1152441@bill-the-cat>
In-Reply-To: <20240209202509.GQ1152441@bill-the-cat>
From: Selvakumar Velandi <selvakumar.velandi@olakrutrim.com>
Date: Wed, 14 Feb 2024 14:57:18 +0530
Message-ID: <CAJ-dvqzSVcJr+9fumE1OQpFD3KXN+c3+s=QNEtyQo1G6HYuGzg@mail.gmail.com>
Subject: Re: [PATCH] Added FDT PAD memory size while reserving memory for FDT
 to avoid some memory corruption issue
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 14 Feb 2024 13:42:37 +0100
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

Hi,

The issue is happening in the following scenario.
1) Launch the QEMU for RISCV virt platform with uboot and ubuntu OS (Host
system). Now the OS is booted without any issue.
2) Enable the KVM in the ubuntu OS.
3) Create a VM by launching the same RISC V QEMU from the Ubuntu OS (Host
system)  after enabling KVM.
4) So now the qemu is running from the HOST OS and launching the uboot and
then OS. The system crash is happening in the VM OS booting.
If the FDT is reserved with stub bytes then the VM is launched properly.

The issue is not happening while launching Host OS even if it use the same
uboot code.
As per the image_fdt code in uboot, the  FDT size is blindly increased even
if the relocation is disabled and updated in the FDT header.
So i reserve the Padding bytes while reserving FDT in uboot board_f phase
itself for adding bootargs in uboot after image_fdt.

Regards,
Selva


On Sat, Feb 10, 2024 at 1:55=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:

> On Fri, Feb 09, 2024 at 07:45:10PM +0530, Selvakumar Velandi wrote:
>
> > The FDT relocation is not disabled. I am adding the FDT PADDING bytes
> while
> > doing FDT reservation in the board_f file.
> > Also update the FDT length based on the new allocation, instead of
> blindly
> > increasing the size.
> > Currently the size is getting increased even for the relocation disable=
d
> > scenario also.
> > So without increasing the physical memory for the disable relocation us=
e
> > case, the fdt total size is updated. thus causing memory corruption
>
> Please explain on what system you're seeing this with, and how things
> are configured and what else is required to trigger this problem. Your
> changes to boot/image-fdt.c change things so that we don't pad the
> non-relocated device tree (but we need to, we still change the bootargs
> and so forth). And the changes to common/board_f.c look like we're
> trying to do that instead, earlier? But we should not have a kernel
> corruption problem unless:
> - We aren't relocating the device tree
> - We aren't relocating the device tree far enough away from the kernel,
>   but this shouldn't be a problem on arm64 and riscv where the Image
>   header structure tells us how big the BSS is to be and we obey that.
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





