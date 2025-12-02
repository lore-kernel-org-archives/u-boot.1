Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CADCFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 08:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A08683E36;
	Tue,  2 Dec 2025 09:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M7nnJzdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4320583E3A; Tue,  2 Dec 2025 09:59:18 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C83C583E28
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 09:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c7aee74dceso1548179a34.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 00:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764665954; x=1765270754; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LxPmZe0iRurDe7Q2ByPjx510TV5X/C0lgYvHwfmn/4=;
 b=M7nnJzdxN4weKOBhdno+vugSKnbGC4BTtY1HmA3TPvD7OtxbFxZAkcugC1TzxT+Mb7
 WcGshXF2aPH+01wl9bBT0gBrsKdwG46XHDIZLVwmZF762Iu9InOLMt/r0gvmozRE9VcJ
 /TM0IMX+mHOKPkztHoi9zaNPgqJNc6HAtijnj4+5uqP7HV+F3NULOe799TE6ZHvd2DtV
 YcrzSbN9lwK07roj8Xf3M2be7ptseOmZq1JAN3sP+tBj3p8xMjZl7kckT0+jgh3cayUo
 eJwbvw8oyOb2H/5PtR1x0CAJdO7FWsT3MSIC2hObMzvpJueVBXOFYCVR1yHneldTHZ22
 OcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764665954; x=1765270754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8LxPmZe0iRurDe7Q2ByPjx510TV5X/C0lgYvHwfmn/4=;
 b=v7XjFV5WMcVdiVp392AvJwTzA6cg+3ox4Eh0L8FkziwfR+0cJoWZBxhEGKpYM8c3xa
 ScLlhn6N5bBE/RlfJ09NiPkWpR3EEfRai867P8O2TvO2ev0uxi6lXgMGD40j5IJIwVAa
 uUwK9DMKpfdcWk5mdUv+9P7QD4BIEwbsRs/dQpADNm08gSZRRZ3oCyxvPyauhiRG0LhQ
 FXPo0U1E/ToHTIe8CqV14/7FXQ4dEVa/v7XXfqsANAZVp1afBWOV65saGNbB4Tq1HNvF
 ot5r2ZNP2y7MUMeo5MkdDaQBNKXDhZ93wJQzq57AE43Jkx+78nHrM4ekhH2eU6tOBdn0
 yjeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8FWn6KeT+nhzD0EuDEHD3cxTjBvxWDat0imrKkIWlfzHuKC42Eeky6MBPdYzbCgJeM2HfjCg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz2mm3GPeWKvTzYQWk6TdotsP61c7cHVzQ/pUF3PajsAytueeP
 XmI/NjFO1zjvRa5N4rjSUXY4kiDYGyMnnOi1TQvZELAAsS59TwzgLhgYtTYJpcbkNZORq3GP8it
 j08tqJKdpp5uFwLla0PX7vxdvoL792WQ=
X-Gm-Gg: ASbGncvOIi7p7WNORnYHVoos+4Whf8HY7p0NdjahcG7aUguTkEHLPyJkdyR5CQS2Zp0
 g+Zf3HWb4ma1ManQrSaYHfqoil79sStJ4hMelCXttsWuw5IHlDYONqjFAqAehynPXSqYm82aGuG
 BmWN1FO2lRH7h9l395dLgJuQu1SP8HKSpIicrlpYv+/NoTf5tzpMILtg/4VphTdY1XjZznJ9c+n
 QSih5S90ShDIp73eNF2hUX7TVTcAI0Kt32/KK+DIPtlCQ2gvXXFQj0hdOdXtsEuW62KOUMs
X-Google-Smtp-Source: AGHT+IF/TLMK2WIbaECKdKib5M3+Z+xSw1z0FTx3jIFkJyhLARdDWEOagsBjFQsM5KD8rJ9YQ9xm0KJ1ISq/pp2FLF8=
X-Received: by 2002:a05:6830:44ac:b0:7b7:6e45:7f2c with SMTP id
 46e09a7af769-7c799098bbfmr17956288a34.30.1764665954542; Tue, 02 Dec 2025
 00:59:14 -0800 (PST)
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
 <CAC_iWjLYvzHHJ+KYj68KWa=E+V3wc360HRf_dWCh7ny5bdEU9A@mail.gmail.com>
 <CAN7C2SAEZgm8KshbGU3d48U3w01vtG5zvbzZRbA_3tE5S0E+Lw@mail.gmail.com>
 <CAC_iWj+Jo1fP2ucXPY+q6+rFhHsT3PKz7H2J4dH-3cyAk01HEg@mail.gmail.com>
In-Reply-To: <CAC_iWj+Jo1fP2ucXPY+q6+rFhHsT3PKz7H2J4dH-3cyAk01HEg@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 2 Dec 2025 16:59:03 +0800
X-Gm-Features: AWmQ_bn84s1GBWRJ7MwgnHfsVAENrZ45VKhWTfkvTgfbsBAS0M04G38iDSQ8mKk
Message-ID: <CAN7C2SDDAtxfDiHUac9q-WfB8jr_eRPDKcbfrtbcyXDbdV7_nw@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, 
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

Ilias Apalodimas <ilias.apalodimas@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=
=9C=882=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:53=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> [...]
>
> > >
> > > Ok, let me go through my irc logs in case I find it.
> > > Reading the email thread we should compile with anything > 8.1 right?
> > >
> > > Cheers
> > > /Ilias
> > > >
> > > > --
> > > > Tom
> >
> > Hi llias and Tom,
> >
> > I have a question might be wrong or not even exist.
> > Tom mentioned GCC 8.1 kbuild but u-boot is considered as
> > kernel build or it does not always be that case?
>
> We use the same Kbuild system as the kernel. I updated that a few
> months ago since we where stuck on a really old version.
>
> >
> > At least so fat there are nothing can build properly below 10.0.1
> > Using ARM official cross compile binaries.
>
> I think I tested with gcc11, but I I don't remember testing with 8.x.
> I probably missed something on the backporting. I'll try having a look
>
> Cheers
> /Ilias
> >
> > Thanks,
> > Brian

Thank you IIias I don't really know all the u-boot things.
I had provided the first draft for fixing GCC check.
https://patchwork.ozlabs.org/project/uboot/patch/20251202041029.186-1-brian=
sune@gmail.com/
Now it is on 10.0.1 if 8.1 is the case will update after your confirmation.

Thanks,
Brian
