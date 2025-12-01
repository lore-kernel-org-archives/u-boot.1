Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46363D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE03583C46;
	Mon,  1 Dec 2025 17:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V3lFX0yW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3659483C4B; Mon,  1 Dec 2025 17:52:21 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE9EF83BF4
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c75dd36b1bso2799828a34.2
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764607938; x=1765212738; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Qb0ssB46aGpTZdqa2rT9m3d8EmBvyw6fViSol0Ns1U=;
 b=V3lFX0yWKju3ICymWr983NOfeWRw2Aje2jmTO7nDAISw6h6nJmShbEvgTd8OHAjQnk
 96i4tv/xGQ1LEJiA4Q2SJb13gUPmzmZKscE/97LJdWqjGpLrGf9Qb389jl7Llde/kc31
 hHd2Qf/AijECQkOA6rvrutlmvLkmRtSyGr20e9NUD42Tvc+wWxM/zB910LBfDvRRDrbq
 3w/2CEinDzMsYD5VlK3rivfI94q62soYWnhs7cRTybcJIZoFkSFEd9xgCIA2yvkuIc0/
 YERfs6YjTvXpbEEJMw+BjBQ8d2dc86+QXG1lt79i3U2tIkYkMXcK/w5kCA5OqXzJOkyR
 cNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764607938; x=1765212738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Qb0ssB46aGpTZdqa2rT9m3d8EmBvyw6fViSol0Ns1U=;
 b=wxV9PAP1JY3odcaF6wKQmn0AmCvSmtD5KM0h44D1LUqo4DTiL3mnNdxaPp1krPsJOq
 GJqJ18fKj4GN28J+W2UDpR4WVCoHxYnNDtBuFk7k39uOcvZZ3tPXuzWOszQEzXxFb3t2
 5m3bJJKT3y2dAlXVFvinEN9aabiNtIHDQERDtWZOnOciL//DB8E/yF5SgJihPNpZ30AA
 Eltqckf9QYnhntTSCfUDixuPwJnqrKeGGMksok6AoStpUpHRxDbcoVfqvwM4qFlMjIqN
 mKGQZvU0k2H9/FbH4py/VewlLuIqOAmJxv/nJjHaNldzKkp5iXdjtLQqSuofVX4bE/Ua
 qyUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzNtsVXAuycHQAaBxzkcE+QsjJc9ILDnlRFxcJoMhUFlhqK+Ty65vgvvKSrM7BnBky1vtEmRc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz048/cSz4Pwz2K4QSitOZ8B6dw5LJmFLbfLjspd+7ohkJ0t9f2
 WckDbhOdItRKPtkaCfUdm/g4OzfTDJ0EveSPxE1kJ4Cmfc07cjpHFVmqCFJQ7htDmhVkjXG5W8m
 euw8+aGvuqkV9Zft58HG41u+1EWrNmp8=
X-Gm-Gg: ASbGncv/iHRfZ9NhWb99en/40SoIp/IQeuu5LVXSzofSu6eEvpaDRg4Nyi5SGUpUcEq
 OSB31KDzD3ICi7EodT4bO8Y0tNqdpdlpCyy/PAugU3dkIb+7iV9Pc5ECR4J8Z4PVPz5qxtRvT7R
 0Ax/alHHhqd4wvtsabjxvuQJWtWVbcxv1AmvfrvxB/kNO4Bj9qsIsdHdQlvv+Ed7NFC4iKSdjJz
 376aAm8C6QW/68bhH/5iISw5m7thRT6Ieqv0CmwShLFtEVZ18GkobpuEPl0m5WNWNEqJzEQIo58
 ZGpkFGY=
X-Google-Smtp-Source: AGHT+IEFbTN5rLRe7j1lmzXITu1V83YrfdkK52ar1WAEDtwkgKwbaUYkma+OgIr1zySXohXWHdFb0tMn/6bKHJdQhfQ=
X-Received: by 2002:a05:6830:6f14:b0:7c7:5f09:879c with SMTP id
 46e09a7af769-7c7c43d39e5mr12726262a34.26.1764607937638; Mon, 01 Dec 2025
 08:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAN7C2SCpM4V3GL=_tox+9ePEx6DcVNK+pdfxn_ysiOyvYuEn+A@mail.gmail.com>
 <20251201164405.GG303283@bill-the-cat>
In-Reply-To: <20251201164405.GG303283@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 2 Dec 2025 00:52:06 +0800
X-Gm-Features: AWmQ_bknIau7ucvGyHWXORu4Pif5ggAWIbJaRgNlKHLlZswiep7P5qJ4i5MeyF8
Message-ID: <CAN7C2SBPwcPdUQeufJ+c3XxVKVmU4PE7nbYqLaNy9ynqkWhJgA@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=A5=
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sat, Nov 29, 2025 at 08:46:14AM +0800, Sune Brian wrote:
> > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=8829=E6=
=97=A5=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:50=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas wrote:
> > > > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zakuan w=
rote:
> > > > > >
> > > > > >
> > > > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > > > [CAUTION: This email is from outside your organization. Unles=
s you trust
> > > > > > > the sender, do not click on links or open attachments as it m=
ay be a
> > > > > > > fraudulent email attempting to steal your information and/or =
compromise
> > > > > > > your computer.]
> > > > > > >
> > > > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > > > >
> > > > > > > Hello everyone,
> > > > > > >
> > > > > > > > I already have the referenced commit in my test branch, and=
 I can
> > > > > > > > confirm that the same compilation error still appears on Cy=
cloneV when
> > > > > > > > certain directories produce no SPL objects.
> > > > > > > >
> > > > > > > > The existing fix ensures that built-in.o is always present,=
 but it does
> > > > > > > > not prevent ar from generating empty built-in.a archives, w=
hich older
> > > > > > > > ARM 32-bit linkers (such as CycloneV toolchains) reject as =
=E2=80=9Cfile
> > > > > > > > truncated=E2=80=9D.
> > > > > > >
> > > > > > > Which toolchain is this ?
> > > > > > >
> > > > > >
> > > > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile our =
SoC32 devices
> > > > > > - CycloneV and Arria10
> > > > >
> > > > > Ilias, do you recall the solution to this problem from when it ca=
me up
> > > > > on IRC a few weeks ago?
> > > >
> > > > Nop unfortunately not.
> > > > Was this caused by the Kbuild bump? I remember the logic around
> > > > builtin changing significantly.
> > >
> > > Yes, and I kinda thought we narrowed it down to something being missi=
ng
> > > from the update, since the kernel does support this old of a toolchai=
n
> > > (or at least the 10.x? someone else this on).
> >
> > Hi Tom,
> >
> > Actually I am not sure u-boot itself have minimum requirement on each t=
ag
> > or branch listed?
>
> We do not currently have a test for anything other than "newer than
> gcc-6" for ARM, but should have the same minimum requirements as the
> linux kernel, but are lacking enforcement checks (but I also think the
> kernel is?).
>
> --
> Tom

Hi Tom,

Oops, missing the kernel version. Add it back for better debug.

For Ubuntu 18.04
Default used old 5.4.0-150-generic

For Ubuntu 22.04
Default used 5.15.0-161-generic

So working kernel not even up to kernel 6.

But do that issue actually caused by GCC version or not?
When gcc-6 should able to build properly.

And do gcc-6 means kernel or the gcc version itself.

Thanks,
Brian
