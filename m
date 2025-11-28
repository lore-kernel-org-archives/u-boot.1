Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A59CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13DE283A3D;
	Fri, 28 Nov 2025 17:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K572Gx5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF7B683A5A; Fri, 28 Nov 2025 17:21:11 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D7E835C6
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c6da5e3353so1271537a34.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764346867; x=1764951667; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yu+jmZIDln7+NHdvNJQFNFbTrBP2bwEWYh/KF7Dx3rc=;
 b=K572Gx5Cqj+6cO2gvblMv6SWV/3vwhmumrsZEozCPLKa4q3ciworMfC33vouNBGcGp
 VMyWfWT8l62KSmwQsj11znBil9ntR+z1AX5tnrJo7VWjZQbDEz86nPsyU5W4Vs8SPMYX
 kgatb1mgbrFALuuPC4laRDAnbzYpvSJRX4HjGVXv8s1ifTDnU1s8mGPrwcwXchjuUiqp
 o9AoJXO2aMevKx3BqNiWmjFpXcKJDusEagbmhoosUNP11EFrgwAH0Q2VQDshJelAcuaf
 3YLYyNACy6B/jte3W3egn2jgw0zmkaEbuj+m4ZzMC+5WHGwYIpd9rFt3wl+oJENwQZ/A
 bOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764346867; x=1764951667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yu+jmZIDln7+NHdvNJQFNFbTrBP2bwEWYh/KF7Dx3rc=;
 b=JkI5DKaSVDtC+3gizhh3/pKFTKRF/mpXluyTUy9lIxD6Oo6klB6yqAe82nqRBUGr+8
 uLawZelibQ1WiuqmiionXhW4fCfZVYbLJ7xn82aOsh/a9pLaFiLHk7/5MAwZDsa104MQ
 Qv+Ij1z6dXxqxta+hH3FSSWHgBe9eWiXNsgX8a04HBK6hRmoVJPl/kqOd0ngzmK54mmu
 cLesteSpY+76kgsN9ju8Kq5sf86Cy5WkoEqUg5dHDDIQSute6jY4wH54UJAqXEwHw4pF
 f5XiIpN/wK/iqcSxDhBNUQRxY7uUFPHR2SYaJDz3SJb5NppXQKvjsgVvhxzGPdVanuPp
 alAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpohLEFADAzpfuyPKixnLeQnF/cayLmV7H2b11sJD0oaB3PjYQc3C0JCL/SevvafkTVKMoIaM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5d0jBbBqMp+0pDQ+lXqQNWU6Xb1GnX9B/iZiAlMBFD9YXFwB4
 cUSkkHEmC6qO1k8/F8vPpeLwIFCZddP402W0yVBA//JxgUZQrFqcKMIijLzMIVo6CY3PL3wofSR
 RyHZznRgKb2awkfk0Vdw9POTDe1+WfR8=
X-Gm-Gg: ASbGnctQ/X6W+k8VC62Lfo7osQIY9jznLvCNLIjtUKb44bDSHXbxDVz4QskQP7Yoy96
 a6KoZiioGse5WU/CVa67lgZXOdXkiNHsRs1pCg9/fIy9K9MBeXAM5HlSosecC2af8mBbnmedT/v
 ZQUi2IKllgnPNjLCUjytGVyKMDDH21XUv1G0VFKGtso7qUMc4PSzMlHOxkmcHOYY1Lwcq/Q9FJZ
 NYKh/XfNuEd/6ZKNNvoiSZAdDEUT8rMOkZrXrCqXMpPwTs0YEldhFtEDoWODf/OsAjZkgo=
X-Google-Smtp-Source: AGHT+IE+w31/6KyIgKEBue3L97n8JbwM2zGL/VZ6pDjVtxssCRiMtDYFdV5/jdjH/uLjS9FGR2B+7WoG5BK0CZDPZiM=
X-Received: by 2002:a05:6830:83b1:b0:7c7:69c8:2d2 with SMTP id
 46e09a7af769-7c7c4130bdemr8149524a34.13.1764346867119; Fri, 28 Nov 2025
 08:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
In-Reply-To: <20251128153130.GC2125796@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 29 Nov 2025 00:20:54 +0800
X-Gm-Features: AWmQ_bkYT80QyAnZjPIb03GhxNi7L5Ruk9ZYnGKICugaipxNEX5iOYL-S_BuE7Q
Message-ID: <CAN7C2SCe5s2m9G8ep_GDc_7YU6YTVrO5jf=+X_0CyNzwqLmwEg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Tom Rini <trini@konsulko.com>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 u-boot@lists.denx.de, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>
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

Hi Tom,

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=8828=E6=97=A5=
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zakuan wrote:
> >
> >
> > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > [CAUTION: This email is from outside your organization. Unless you tr=
ust
> > > the sender, do not click on links or open attachments as it may be a
> > > fraudulent email attempting to steal your information and/or compromi=
se
> > > your computer.]
> > >
> > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > >
> > > Hello everyone,
> > >
> > > > I already have the referenced commit in my test branch, and I can
> > > > confirm that the same compilation error still appears on CycloneV w=
hen
> > > > certain directories produce no SPL objects.
> > > >
> > > > The existing fix ensures that built-in.o is always present, but it =
does
> > > > not prevent ar from generating empty built-in.a archives, which old=
er
> > > > ARM 32-bit linkers (such as CycloneV toolchains) reject as =E2=80=
=9Cfile
> > > > truncated=E2=80=9D.

I encountered this mid of this year after 2025.07.
The uncompilable distro is Ubuntu 18.04, however once I update
to 20.0x and 22.xx there are no issue anymore.

But I did not deep investigate this issue because distro updated can
resolve this issue. I simply think it is u-boot no longer support old GCC.
Just want to point out the failing point of my experiences.

Thanks,
Brian
