Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1829D1D878
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 07:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A178283C08;
	Thu,  4 Dec 2025 08:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CfRhwBhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A66683C14; Thu,  4 Dec 2025 08:04:14 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A9C83B87
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 08:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c7533dbd87so555180a34.2
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 23:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764831839; x=1765436639; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8QmlQ6DTAgioQOFK9In1yiLuZYoVjblcob0KsP19EQ=;
 b=CfRhwBhyUas0c0aYbvif/4aIyLYLQDVSYm8GiD0KDYEcOvb7AVHtbu93F6UT5XVoWv
 R0cv9baDJfknS5PfJtGKm1AS/2FAGAiiFwkD2Xxrp/OqwSG4Jt4Xd6Xlh+O9LaQhzD57
 rfijf8Hd5zf1eH5705ikkTr8NoKAj1xjAh/e3Y2YJMBTUU5kbCpNQwD2KfUp5C/uOhFA
 hSvdSClwjYUcpnJDGFLWPFFO0yN3YOVVd22XwTaVXXAZOqIXTxiMvuPSZYPSi36Qbb/M
 72DhymdJRZQm6Rm+xVeAbJJs2FtVJT9W6jl5+sZ3b3NHzvCF8VcyrEGwTV36PRUPg6lE
 /7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764831839; x=1765436639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x8QmlQ6DTAgioQOFK9In1yiLuZYoVjblcob0KsP19EQ=;
 b=N/pH4lY42u3mGPV3aPS20+9vr6cQ51B9XIoygLfRgqUUsPqWnaipfBUZvGqeyPLL6f
 JkwpeFSJ+akmhLlgJeJZW0ix3tfbueEdkKHNi5b3z8pulSr5QB61XoUn5LuSxoHTXXj+
 nsyq6I4b0gJ+xM5bSH573m97wRK6J3luTCATgkjfMfqflNPGEzx31KrfbGkPJJdMNGSg
 jUKXxHmyPjVXhJKEKrAwfzs5cZ0n+2Yl0BjJuS5tiQrDcQclHMmZhGLCfMxF05CRoSfZ
 0++xDMYjsp+78azsRG8R5/6xpKspZLyXjgxOvPcjCT4WpENJdSsYpv5qFNB6oRsDwzi7
 bWgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsIiaZLiotKDoO26/0OPsJAve/tuE511yuj1Znl712UYq8TQ1pSIHyXMuGfZT9qEb2/jOpzSg=@lists.denx.de
X-Gm-Message-State: AOJu0YxZtvwwqLn5RMtSqqsnBJolHUa0C4vv0n4f95imD1T1WylJHnFo
 SrSkFn5rePMeWGsRrWiDizDurJo0AwxyoOP24yC4D+fUJyGmU9zlqjkAB6u/Ny1wnFQPW5DxKtX
 79rRDaUrvymU7COEMxeArYJUuH/+Llo8=
X-Gm-Gg: ASbGncvb9WQCRojhypmFECPgGT/e3jT66VDYwgmXWMa6yhaWMaR1CuS5y8S1IQLYlxz
 WVOYTHHuWBB9uWDUSxXpnh2DSs97bVUqj7LVKgyQ1d867hqmS6N2oKbQS/3/TP6G5W3DC2FzzTN
 jUAOJj5u0HunOPRnUVJmxW0xc3rcPJOMYf0yhGKWVX6yJcXNXNDYlyAuZIR/dd+DeAkwXSJ/9uG
 uq9TzsCJ/DavxV7YlzDLUxVULc5KXQ0rNYXbnL3X00F94yR12oGm2CsJR95CTmWqdQYO+g=
X-Google-Smtp-Source: AGHT+IGLvt8crblJ6OP0rfbR25puJDyckD7QZyBD5+c7bHkIXdsMEZYV05FMBOlyrbuAsto7Tp45ZnnlJbxvY9rKyqE=
X-Received: by 2002:a05:6830:7198:b0:7c7:1f5:28a with SMTP id
 46e09a7af769-7c958ae2077mr1170453a34.12.1764831839068; Wed, 03 Dec 2025
 23:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
 <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
 <CAN7C2SAjdQMUA+7sbeOgVg7stk_mvxVXomu+PO4+ENGbgAviTw@mail.gmail.com>
 <70bc39fc-6af9-4839-99c7-46de9b14c5a5@altera.com>
In-Reply-To: <70bc39fc-6af9-4839-99c7-46de9b14c5a5@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 4 Dec 2025 15:03:48 +0800
X-Gm-Features: AWmQ_blhBcwWS85yr7ft2bjS9Nq8mUV2Fa3hBIuimrABy10pd2dKLnSkX2CMT_s
Message-ID: <CAN7C2SB9tpYfcWq9d9ZdZrfU_V-9yfu6vW=L1W_jPXjRdRisFA@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, "Chee,
 Tien Fong" <tienfong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com> =E6=96=BC 2025=E5=
=B9=B412=E6=9C=884=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:11=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 4/12/2025 5:02 am, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > Ralph Siemsen <ralph.siemsen@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=
=9C=884=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:52=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>
> >> Hi Brian,
> >>
> >> On Wed, Dec 3, 2025 at 1:17=E2=80=AFPM Sune Brian <briansune@gmail.com=
> wrote:
> >>
> >>> But did you disable also all "CYCLIC" as well?
> >>
> >> I have "CONFIG_CYCLIC is not set" which disables all the others.
> >>
> >> I also have another patch to disable the watchdog, adapted from [1].
> >> This didn't seem to make any difference (but my ram calibration
> >> doesn't take very long).
> >>
> >> [1]  https://lore.kernel.org/all/20250603115442.19971-8-nareshkumar.ra=
vulapalli@altera.com/
> >>
> >
> > Hi Ralph,
> >
> > I do diff the mainstream and Altera trunk.
> > I cam repeat the same behavior on altera trunk when all WDT CYCLIC turn=
ed off.
> >
> > I plan to investigate under another board.
> > TBH if it is board specific case then there is nothing harm to simply
> > turn on CYCLIC or WDT.
> > But the truth is that Altera trunk force using designware WDT by defaul=
t.
> > Because under distro I do full "memtester" and "stressapptest".
> > Nothing really fails on those two.
> >
>
> I have tried to disable all WDT and CYCLIC configs on both Altera trunk
> and mainline U-Boot on my side.
>
> I made some changes to the standard socfpga_cyclone5_defconfig as well
> as the common Kconfig to really disable all watchdog configs.
>
> I cannot replicate the issue on both cases, I am able to boot via RAM
> through ARM debugger, as well as through MMC boot after triggering reset
> in Linux.
>
> I am using our Cyclone V SoC Development Kit, details of the board can
> be found here
>
> [1]
> https://www.rocketboards.org/foswiki/Documentation/AlteraSoCDevelopmentBo=
ard
>
> I am thinking this could be related to the power supply not being fully
> stable before SDRAM calibration, perhaps you could try other reset
> methods, such as cold/warm reset, or power cycling the board and see if
> there is any difference compared to using the physical reset switch key?
>
> Thanks,
> Alif
>
> >>> 3) I use socfpga_cyclone5_defconfig and only change minimum settings
> >>> that I needs.
> >>>  From this issue mentioned to current day.
> >>
> >> Then it sounds like it is a recent issue... hmm... I'm currently on
> >> 2025.10 release version (plus some cherry-picks). I'll give a try on
> >> master/next once I get some other things stabilised...
> >>
> >> Regards,
> >> Ralph
> >
> > The major reason is the ECC on mainstream is completely missing.
> > BTW [1] I do manually inserted and test no luck on that.
> >
> > Yet still thank you for the help.
> >
> > Brian
>

Hi Alif,

I think almost 90% or even 95% above board only uses 1GB socdk as well.
I am undergoing a deep investigation.
Cyclone V SoC FPGA boards also do
not have issues w/o WDT CYCLIC.
The issue happened on 2GB variant boards.

If any parties or users happen to have 2GB please do point out it is
OK.

If not it is a 32bit bug on driver or other files.
Calibration time is indeed longer.

No time shift is not a solution or inherent problem here.
2x512x16 ddr die is used to introduce a signed possible issue perhase.
aka 0x8000_0000

Thanks,
Brian
