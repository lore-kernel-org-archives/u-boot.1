Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028E8FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 04:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D50484119;
	Thu, 30 Apr 2026 06:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KSyQS4L0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39AE984150; Thu, 30 Apr 2026 06:33:07 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C31D84099
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 06:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so508605fac.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 21:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777523583; cv=none;
 d=google.com; s=arc-20240605;
 b=YxP0T0zu7rm4krIx57EovjQ76oI+JG7r3BXh0WhGzxwAcRIG9aI1IZ6/L707yK7j+F
 9Cj1K3a3jpr/UKDdJoKr25Gj3lzdnHnE3E30rEN0dhL7tLJgth/RncviXSUEMtDbdJnO
 +ruh9yy4Hfhcvus9dEMxO4qHeeQ82pcM4NF2TQXJk03mm3wL7PJ9amZ120kZPjLzsvIj
 k8z+e7tvC6sI5xFyu4WU7SfxUoSifgDZLdZhepkuMmSde2Z8YWQWzO+jkCk9zSamL0ya
 ahXqq6GG57ec+hu678jePx8/y+ZcW0LeO/KRHilcV8nmwgsgTWBT+IU1C5FtAKgrrZfR
 3xJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LfA4x/5HwJW1INgyOwYv2avkQlp+g08YW5VhBweEFAE=;
 fh=sLmCnAy7HsE3/uV5iNe4toUcSMQ+UPv3pnM0TnHchu0=;
 b=EZo+ocI9nEd2kwzqezqfStD+BffBN7jfz98vTd0l6xxf53lFwejSfPvw7l4+gtCn/G
 UDQqr4p9t9/Q72JtKZORxTqDuh8fqgJYGRZMeOIEenDqxioozrIuhxOSw07kiCvWiBZq
 KVRaJGASCdq+lhBh6TOM9MS/ykC3GQ4bBQlg9W7JICIFt3zFrgSUfHU1yyQIzx8y9h6a
 Be74yaF+4kFD8f6PrkxAbys74pvm+4JTdnC/qkaVdvKLsLVo2+ex79be3D6PNtAI1YGg
 LLNQ8d9PgW5ulZNsF7OyYKx2m5RFh7pZ1d65bxrggXcZm+1ZQrvRqnL3spP87Nmx3kC1
 73NQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777523583; x=1778128383; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfA4x/5HwJW1INgyOwYv2avkQlp+g08YW5VhBweEFAE=;
 b=KSyQS4L07JDeDpU/JTG2JvNMIF2V63bwSq3qCsal5MNgyAkOLELEdWMbIMx8T63rYp
 NCa9CGbpOL+aUdnMr6snBOX2i1aDS3IhTOURWzRkrvhQW7JCkQUmPhnpLLlcdEQEA/1w
 68lJJHrf/7Vw7odbNMxGIz2F3sLaRPwjzqCbv7BAlN/S43a48p9szG364Zf03uX/JWO3
 wmzgTw7fTfDUshW/oXQNzY7WONerN+Z+N5n2p2FvRimBvWCikW460YQMhlF0mPIW/Mnw
 McdZ/B6HbGrrHvCqTDRlLpQEoVdBRJnOEFU0RiuacjO3/byPSYnlz5DBtvGWE56Ahmdp
 x1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777523583; x=1778128383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LfA4x/5HwJW1INgyOwYv2avkQlp+g08YW5VhBweEFAE=;
 b=pts8pPRvBdaDYHj2Ahzcck8/JZta2gU7ftTBh7lGL38neyywkKtFGqhZfiwBmU4Nws
 WCc43b7gpOo9Y1/eAXG3DTsXFILa5lodAztj/1tPOmLaygTz0icM2/AkpVrdRZXMcm3N
 poPpxIEs3k390iGEgWZu3Gh9J2BBXx3ZEsG5VnaIx33RMB1I2vKXnt7njLxyu0t3FpUP
 Q8UOk8vJDxwDFNeJk0iwI+kVQxJp8WQnWVixIIPZTgHYnEdGnnRLUXuMUTclMnltC8k3
 InAz8CTUFcLx2rthhfFZpbk34IQgVRsMyckHEIA4KLf2N5uaqoAMBto/Gfa1Kis4QW0i
 OkpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9WhyTiQ3y+j3WulmZNMl5nfy4jLZTU+XRKex7+CrLSj0RiccWW0zyMvaPzPJqcR0EAS+GPGY=@lists.denx.de
X-Gm-Message-State: AOJu0YwMJDFpazQlcb6nc63qCtkkJSSu8BC7gN9mhvJ1RrJQWH308rXe
 xo1XLzS+Uai+ghTw9FlvtVQiSdxfJz52nWd4piHW2xgQ8xji8RBB8PA2uo5bRbYWBssgNWK8bIC
 r7m/4UL4O02e+8TVOpwMItyxv6PKaQlA=
X-Gm-Gg: AeBDiev1+CyBAZ+FFsE5UcZDeWRXO60IutJaztQqfQ0pZwT66wONlxc6+aAwJINF+jC
 BzL0laqanqIrjKlAi8NBqMsK/icBlB4wVIVG9TDFRtmBF5eTOlTDkNs7wWVThT0zxdUqrByxSJJ
 8Mz3y00/RhkTLWEeVtugDET7aY96RKfr6Ajun0tFc+Aq2yuZLvXTnzUgUM5Q8hpnGrT5lFdaV/x
 bbCCabHuGnHBaomqXRBtAuAbKXTT3ov3VQle+TGNMas1waollmqLLmnSzMPi3Dt+LMyoXmczlAQ
 YZSZNRlYdXZtLubKbA==
X-Received: by 2002:a05:6808:690b:b0:479:faf5:ef56 with SMTP id
 5614622812f47-47c5fa50907mr703047b6e.5.1777523583139; Wed, 29 Apr 2026
 21:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260423042824.3480-1-briansune@gmail.com>
 <CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com>
 <CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhdmY3Q@mail.gmail.com>
 <CAFLszTgouk66AOaL2o8PvH9EKNFabE=pjxpa9QpC_F--VhE9cQ@mail.gmail.com>
 <CAN7C2SC-MuqHK2+0vaZzZFi-up1L7=KcOSRedF6f6F3D9Uoceg@mail.gmail.com>
 <CAFLszTjz5SMpFMPjVd6tX5Lk9DKv3MMX+_qtkSgt6fztGceHFA@mail.gmail.com>
 <CAFLszThDv=YcuXUanOJd4MPeNdSiHSL2zH9jXAtbu+-8fRzF2w@mail.gmail.com>
 <0b5fc175-76be-4b64-bd8b-48c9f502c8bc@altera.com>
In-Reply-To: <0b5fc175-76be-4b64-bd8b-48c9f502c8bc@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 30 Apr 2026 12:32:51 +0800
X-Gm-Features: AVHnY4IGqePoHz6VwIYG4jBu-w0vaGFfrm6Jzv2Y7c6t1kMHVY7D_nEx5zCv0Go
Message-ID: <CAN7C2SD0pHpYx_66WikFB1vjQrni8NyHL-t29keZU3EksJE3nA@mail.gmail.com>
Subject: Re: [PATCH v6] Improve handoff prepare on SoCFPGA
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
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

On Thu, Apr 30, 2026 at 12:28=E2=80=AFPM Chee, Tien Fong
<tien.fong.chee@altera.com> wrote:
>
> Hi Brian,
>
>
> On 30/4/2026 1:14 am, Simon Glass wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > On Thu, 30 Apr 2026 at 02:44, Simon Glass <sjg@chromium.org> wrote:
> >> Hi Sune,
> >>
> >> On Wed, 29 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote:
> >>> On Wed, Apr 29, 2026 at 10:21=E2=80=AFPM Simon Glass <sjg@chromium.or=
g> wrote:
> >>>> Hi Brian,
> >>>>
> >>>> On Tue, 28 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote=
:
> >>>>> On Tue, Apr 28, 2026 at 10:04=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> >>>>>> Hi Brian,
> >>>>>>
> >>>>>> On 2026-04-23T04:28:24, Sune Brian <briansune@gmail.com> wrote:
> >>>>>>> Improve handoff prepare on SoCFPGA
> >>>>>>>
> >>>>>>> Ensure qts folder header files are properly updated by isolating
> >>>>>>> the Python execution environment. This prevents partial or failed
> >>>>>>> script runs from corrupting the target directory.
> >>>>>>>
> >>>>>>> Changelog v5 -> v6:
> >>>>>>>   - Clean HANDOFF_KEEP comments.
> >>>>>>>
> >>>>>>> Changelog v4 -> v5:
> >>>>>>>   - Change HANDOFF_KEEP condition to if [ '$${HANDOFF_KEEP:-0}' !=
=3D '0' ]
> >>>>>>>   - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
> >>>>>>>
> >>>>>>> Changes:
> >>>>>>>   - Implement a temp folder for Python script execution.
> >>>>>>>   - Clean temp folder automatically despite execution failures.
> >>>>>>>   - Gate the file replacement process on the successful exit of
> >>>>>>>     the Python scripts.
> >>>>>>>   - Execute the replacement (with or without keep) only upon scri=
pt
> >>>>>>>     success via the NEW HANDOFF_KEEP=3Dxxx variable.
> >>>>>>> [...]
> >>>>>>>
> >>>>>>> arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++++=
++++++++---
> >>>>>>>   1 file changed, 36 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> Dear Simon,
> >>>>>
> >>>>> B.C. the server is down and I don't expect Google to have an auto f=
ail
> >>>>> mailing recovery.
> >>>>>
> >>>>>> I see 6 copies of this v6 patch in patchwork, so I wonder if I got=
 the
> >>>>>> right one?
> >>>>> I will try to respond to this email as politely as possible.
> >>>>> Please reference from "patchwork.ozlabs.org" list.
> >>>>>
> >>>>>> The per-version changelogs belong below the '---' separator, not i=
n
> >>>>>> the commit body. Also U-Boot convention is 'Changes in vN:' rather
> >>>>>> than 'Changelog vN -> vN+1:'.
> >>>>>>
> >>>>>> You could try using 'patman' which will get this right for you aut=
omatically:
> >>>>>>
> >>>>>> https://docs.u-boot.org/en/latest/develop/patman.html
> >>>>>>
> >>>>> 1) I only do basic software
> >>>>> 2) I used ./script/checkpatch.pl There are no errors, warnings etc.
> >>>>> 3) There is nothing to do with the patch itself either the software
> >>>>> nor the file itself.
> >>>>> 4) I am not too familiar with patman
> >>>>> 5) There are many better things to do rather than complaining about
> >>>>> the patch headers.
> >>>>>
> >>>>> So forgive me I really don't give a damn on whatever the header req=
uirements.
> >>>>> If you feel this is not passing the patch standard simply reject or
> >>>>> label all patches to
> >>>>> "Changes Requested".
> >>>> That's up to whoever applies this patch. I am just a reviewer :-)
> >>> Hi Simon,
> >>>
> >>> I am going to ignore all your mail in the future.
> >>> So review whatever you like, don't care.
> >>> There are many patch not following whatever rules or guidelines you
> >>> mentioned.
> >>> Just review those as well. What a waste of time on your emails.
> >>>
> >>> As politely as possible!!!
> >> Oh, sorry about that and also the server being down, etc.. The
> >> maintainer for SoCFPGA will handle applying this in any case.
> >>
> >>> Brian
> >>>
> >>>> The reason for the formatting rules is mostly so that maintainers ca=
n
> >>>> apply them without manually redoing the patch, etc.
> >>>>
> >>>> There is also this which might help (although you might not want mor=
e reading):
> >>>>
> >>>> https://docs.u-boot.org/en/latest/develop/sending_patches.html#commi=
t-message-conventions
>
>
> I have reviewed this patch.
>
>
> While the functional change appears reasonable, the patch cannot be
> applied in its current form because the commit message and version
> history do not follow U-Boot patch submission conventions. Specifically:
>
> - Per-version change history must be placed below the '---' separator.
> - The required format is 'Changes in vN:'. Custom formats such as
>    'Changelog vN -> vN+1:' are not acceptable.
>
> Maintainers rely on these conventions so patches can be applied directly
> using git am without manual rework. I will not correct the commit history
> on behalf of the contributor.
>
> Please resend the patch with the commit message formatted correctly.
> Further review or application will only proceed once this requirement is
> met.

Hi T.F.,

Drop this, I don't care.

Thanks,
Brian

>
> Best regards,
>
> Tien Fong
>
