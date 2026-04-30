Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D99FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 04:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3DDB83FDB;
	Thu, 30 Apr 2026 06:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KR+XCBeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB60E84099; Thu, 30 Apr 2026 06:42:55 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF3483FB5
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 06:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de7dc85b74so487195a34.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 21:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777524172; cv=none;
 d=google.com; s=arc-20240605;
 b=PlW29mnVdWEBVgP1GVOBoiX4U0NplE5FbOWS09BZVlUQNHuqSMleOUZZ/bO9TIP+F+
 +M2+cNFKcsgIH12B+3qmhR0rEzK9BxJvdAQYJUhGUL0VO62sXSah1yr51uEIFtbNbwgf
 CAe/vMufejcqqp5EwT21fL0rPgD+rPYLTLjH4hp6Jd+TliC/4Y2n1XP/4yGus+x7iom7
 En8PYuk9KD28l8PBm92ANtwv8wopjlyDg7bYFXETHoSeopN60gVDthEd0qa7mjmOaXOL
 c7decktqm4qqz8FAC9Ne22vSkgSNEtHeEgkNqx2GyKbn29X06a199LQTVEsODoJGED5M
 5Z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SgAAFbc/J1MF/6jjNGE3cSh4oiCyA5ebCieF70GRygQ=;
 fh=Oh5RlFq2dK+N666cySmFijARU4xnFUs7EsHB2nUn/W0=;
 b=JmUlH435gdatq0s1NcYLhm2iQauVmgp0qV5sSALQaoayKEbqadzyxKjzVzKvAy53K+
 I+oPB+34Pj7RA+KzhPukX2Rcmqu26C1kGb8JhXHVo6qn52Kdn/d/uvPrPujsi+tE8HOP
 w4zAqEzwl+tlOpvMxssOavDcnIdHHj7Wjy9cIaS0wjNb3wusMmgUN020dNmt/wKbMx5v
 cyFPxIjrCOFwseEkSs4hcpPC66l5E6UybEXRKazJ8QfFDhohIQrZLA4C+I/0jzoULgr7
 2uMKjvDdMAhGQU7EpbOMsy9OvBOy7g4dwoAMzVK+t6Ttag8k8vz3LXLxYKgZ1E5dBG5+
 tQeQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777524172; x=1778128972; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgAAFbc/J1MF/6jjNGE3cSh4oiCyA5ebCieF70GRygQ=;
 b=KR+XCBeb0XUy8c1AcM65f6vLakxg6yOylWkhY02OcbKv6gGMpskFjln9zaplG9ivt7
 cJdK6FVrgEb9N2qL0txXM/+9IO31hnpSYFuMhWM9AOAfF2CFUzN6EEjuFG/nTFNtQ2sh
 SYrI6DaLywmfT2sr+iOjmlfBBbielyPmPmJ/VmplUlYGfdYLrx+ITBp6PtRjOqNDvcU2
 l6oQXoH27hD92toIykITf1YF+101MLo+OYei+XuiX22uNcHLEAXqxY8h8yOIxqGAAwEV
 uYQjAP4lKYVroES/R73BaiIARLHx6yOvpKdFvHfG+HQQjGmho0SCZ+CXuwZuLkvGwQby
 kCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777524172; x=1778128972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SgAAFbc/J1MF/6jjNGE3cSh4oiCyA5ebCieF70GRygQ=;
 b=ckJApb0LwKIDcNQSmsUYgTlFUGArPcL9pg2nUAz+GpBFgzt+RLy21U7S4goWql8eC7
 X9A5AdSxaQsgGxvlO9uwS7zK2LZqg4Fi2uGAWcoIJnrdgcehaWEcIohWRYdwtB7N3zP8
 0Z4mar5twzHCo9/lhmFJknuCt5iVLqfmTqBnS2qQrOAwuhWtWOVApgqHu0MYNcHQvtjP
 TsrU9+K3HwVfyhwELsuvCG6CVCzaKR0eVTtHCFHvJIP8nuBBLlKxUTawnLuWvoQ7xTVb
 aJSM6rN15W5KHr2LWNlL/qg545HkXDrrobDTxLw4rSQ5mRAqCsNtYePkSnQVX+HaM43v
 vlJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SCnqSn0UKfmwP4QOhToWSX7nfgxHowasiUaEwwn0pSZR+uL6Gu3w7T8MPFitcPOS78ynhpnY=@lists.denx.de
X-Gm-Message-State: AOJu0YysS1G2uo2bP1zEI7Fn9qLCvIB3gnnxQ6iUlbAdqU4Bk8IaSjcB
 4nL6q04/B/Wdag+X8EyFU5lJtkP0k+7pHTKqQ1RW4gsyJbFx2qukYSCawXOVkA8PxIE9WvyhPSh
 BqFdaPFNKjjVRZfElufD8Mio3C5z1U6I=
X-Gm-Gg: AeBDievbTJFuQqcoi5+Ywe4qdJmqwMUcmpiPVPr4XU8Ep1lb8tl5CG9NH+zTXMfiwJ6
 0Dp0IWkjGMW+t5deG5vyJh5m1fgApvSq2qEb1d8CYBrFyH+jTaxJl2qNS66YqvSN7lHrJ9Yat/T
 Zoxzwa52l5AF8d7RZeqcp5I/KsWOHAm2MBmllW6K0oAvBSUHayv/cwN/bzL/9Hs/84GfFfoMWc1
 HRGScyx35422e87183YbTyccyEcJw0TdcvixjSu8KF/lAr1gS9uWuhN/vNxe+jnDQT1y+BcQfA4
 M1j4KEIxup21OdYfnQ==
X-Received: by 2002:a05:6830:378a:b0:7d7:b841:c6dd with SMTP id
 46e09a7af769-7deba185859mr929875a34.11.1777524171789; Wed, 29 Apr 2026
 21:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260423042824.3480-1-briansune@gmail.com>
 <CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com>
 <CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhdmY3Q@mail.gmail.com>
 <CAFLszTgouk66AOaL2o8PvH9EKNFabE=pjxpa9QpC_F--VhE9cQ@mail.gmail.com>
 <CAN7C2SC-MuqHK2+0vaZzZFi-up1L7=KcOSRedF6f6F3D9Uoceg@mail.gmail.com>
 <CAFLszTjz5SMpFMPjVd6tX5Lk9DKv3MMX+_qtkSgt6fztGceHFA@mail.gmail.com>
 <CAFLszThDv=YcuXUanOJd4MPeNdSiHSL2zH9jXAtbu+-8fRzF2w@mail.gmail.com>
 <0b5fc175-76be-4b64-bd8b-48c9f502c8bc@altera.com>
 <CAN7C2SD0pHpYx_66WikFB1vjQrni8NyHL-t29keZU3EksJE3nA@mail.gmail.com>
In-Reply-To: <CAN7C2SD0pHpYx_66WikFB1vjQrni8NyHL-t29keZU3EksJE3nA@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 30 Apr 2026 12:42:40 +0800
X-Gm-Features: AVHnY4K24Q-lyik4s550V0p_8it341cVuQPgF6p80iQGSxWnfVLtH4eBdvVxy-U
Message-ID: <CAN7C2SBCrNm8ojLq6p82e_B4F=ffy9BP5KXQPEDiBS6zdE4RAA@mail.gmail.com>
Subject: Re: [PATCH v6] Improve handoff prepare on SoCFPGA
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 "Chee, Tien Fong" <tien.fong.chee@altera.com>
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

On Thu, Apr 30, 2026 at 12:32=E2=80=AFPM Sune Brian <briansune@gmail.com> w=
rote:
>
> On Thu, Apr 30, 2026 at 12:28=E2=80=AFPM Chee, Tien Fong
> <tien.fong.chee@altera.com> wrote:
> >
> > Hi Brian,
> >
> >
> > On 30/4/2026 1:14 am, Simon Glass wrote:
> > > [CAUTION: This email is from outside your organization. Unless you tr=
ust the sender, do not click on links or open attachments as it may be a fr=
audulent email attempting to steal your information and/or compromise your =
computer.]
> > >
> > > On Thu, 30 Apr 2026 at 02:44, Simon Glass <sjg@chromium.org> wrote:
> > >> Hi Sune,
> > >>
> > >> On Wed, 29 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote=
:
> > >>> On Wed, Apr 29, 2026 at 10:21=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> > >>>> Hi Brian,
> > >>>>
> > >>>> On Tue, 28 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wro=
te:
> > >>>>> On Tue, Apr 28, 2026 at 10:04=E2=80=AFPM Simon Glass <sjg@chromiu=
m.org> wrote:
> > >>>>>> Hi Brian,
> > >>>>>>
> > >>>>>> On 2026-04-23T04:28:24, Sune Brian <briansune@gmail.com> wrote:
> > >>>>>>> Improve handoff prepare on SoCFPGA
> > >>>>>>>
> > >>>>>>> Ensure qts folder header files are properly updated by isolatin=
g
> > >>>>>>> the Python execution environment. This prevents partial or fail=
ed
> > >>>>>>> script runs from corrupting the target directory.
> > >>>>>>>
> > >>>>>>> Changelog v5 -> v6:
> > >>>>>>>   - Clean HANDOFF_KEEP comments.
> > >>>>>>>
> > >>>>>>> Changelog v4 -> v5:
> > >>>>>>>   - Change HANDOFF_KEEP condition to if [ '$${HANDOFF_KEEP:-0}'=
 !=3D '0' ]
> > >>>>>>>   - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
> > >>>>>>>
> > >>>>>>> Changes:
> > >>>>>>>   - Implement a temp folder for Python script execution.
> > >>>>>>>   - Clean temp folder automatically despite execution failures.
> > >>>>>>>   - Gate the file replacement process on the successful exit of
> > >>>>>>>     the Python scripts.
> > >>>>>>>   - Execute the replacement (with or without keep) only upon sc=
ript
> > >>>>>>>     success via the NEW HANDOFF_KEEP=3Dxxx variable.
> > >>>>>>> [...]
> > >>>>>>>
> > >>>>>>> arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++=
++++++++++---
> > >>>>>>>   1 file changed, 36 insertions(+), 3 deletions(-)
> > >>>>>
> > >>>>> Dear Simon,
> > >>>>>
> > >>>>> B.C. the server is down and I don't expect Google to have an auto=
 fail
> > >>>>> mailing recovery.
> > >>>>>
> > >>>>>> I see 6 copies of this v6 patch in patchwork, so I wonder if I g=
ot the
> > >>>>>> right one?
> > >>>>> I will try to respond to this email as politely as possible.
> > >>>>> Please reference from "patchwork.ozlabs.org" list.
> > >>>>>
> > >>>>>> The per-version changelogs belong below the '---' separator, not=
 in
> > >>>>>> the commit body. Also U-Boot convention is 'Changes in vN:' rath=
er
> > >>>>>> than 'Changelog vN -> vN+1:'.
> > >>>>>>
> > >>>>>> You could try using 'patman' which will get this right for you a=
utomatically:
> > >>>>>>
> > >>>>>> https://docs.u-boot.org/en/latest/develop/patman.html
> > >>>>>>
> > >>>>> 1) I only do basic software
> > >>>>> 2) I used ./script/checkpatch.pl There are no errors, warnings et=
c.
> > >>>>> 3) There is nothing to do with the patch itself either the softwa=
re
> > >>>>> nor the file itself.
> > >>>>> 4) I am not too familiar with patman
> > >>>>> 5) There are many better things to do rather than complaining abo=
ut
> > >>>>> the patch headers.
> > >>>>>
> > >>>>> So forgive me I really don't give a damn on whatever the header r=
equirements.
> > >>>>> If you feel this is not passing the patch standard simply reject =
or
> > >>>>> label all patches to
> > >>>>> "Changes Requested".
> > >>>> That's up to whoever applies this patch. I am just a reviewer :-)
> > >>> Hi Simon,
> > >>>
> > >>> I am going to ignore all your mail in the future.
> > >>> So review whatever you like, don't care.
> > >>> There are many patch not following whatever rules or guidelines you
> > >>> mentioned.
> > >>> Just review those as well. What a waste of time on your emails.
> > >>>
> > >>> As politely as possible!!!
> > >> Oh, sorry about that and also the server being down, etc.. The
> > >> maintainer for SoCFPGA will handle applying this in any case.
> > >>
> > >>> Brian
> > >>>
> > >>>> The reason for the formatting rules is mostly so that maintainers =
can
> > >>>> apply them without manually redoing the patch, etc.
> > >>>>
> > >>>> There is also this which might help (although you might not want m=
ore reading):
> > >>>>
> > >>>> https://docs.u-boot.org/en/latest/develop/sending_patches.html#com=
mit-message-conventions
> >
> >
> > I have reviewed this patch.
> >
> >
> > While the functional change appears reasonable, the patch cannot be
> > applied in its current form because the commit message and version
> > history do not follow U-Boot patch submission conventions. Specifically=
:
> >
> > - Per-version change history must be placed below the '---' separator.
> > - The required format is 'Changes in vN:'. Custom formats such as
> >    'Changelog vN -> vN+1:' are not acceptable.
> >
> > Maintainers rely on these conventions so patches can be applied directl=
y
> > using git am without manual rework. I will not correct the commit histo=
ry
> > on behalf of the contributor.
> >
> > Please resend the patch with the commit message formatted correctly.
> > Further review or application will only proceed once this requirement i=
s
> > met.
>
> Hi T.F.,
>
> Drop this, I don't care.
>
> Thanks,
> Brian
>
> >
> > Best regards,
> >
> > Tien Fong
> >

Dear Tom,

Sorry for the trouble.
Please reject this patch series.

Thanks,
Brian
