Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400C5FF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 17:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8802B848B6;
	Wed, 29 Apr 2026 19:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OGcpBN6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8636848BE; Wed, 29 Apr 2026 19:14:47 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A031848B4
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 19:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ba61a0a2d26so1730398166b.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777482884; cv=none;
 d=google.com; s=arc-20240605;
 b=R1PHPoF8Ba0g5VO+PRKEd1gOZpLSoMVh/u32ZF5D2L9dUmI70FGQweGr1Wgbe0qjUn
 ImIwuDKw75WN3w7IkmZ66Q9l0K92Ci2oXKn07wh6B4Fvo7chD5h5pYi4tRqNb/pJQMOQ
 aJmKawOXJemcNd5Xf1rDzx7ybhCHrBr1LXTnxVGHIbyEQe1opacsq/eOmkWBNC0/9Xtd
 zMMmrW4kDJjtRnxX93Kd8cqeT9WA8n43Dxf6+sDEZfy1DTBy45FDOyZ9zNQ0PsgpXWQb
 +5h4+xuEHa7CPFEmR1e3utWRmb7CyILkqnAAHheBiIQ4mv4WDyelojgRdI0fzMbbePGE
 wFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pt8wtkycxt66H1hCLVb3amhkXW+KbECwShFxXmd3b9s=;
 fh=SPi/X0WlztfyTm38DRlSkfy/6oW86yZLUHiv9TSsvno=;
 b=UiX+XPsg86fjjhcwz/xGIJ1ooxu/dzaORs5P8/QFHTXTVOJepUHCaOy0InFwFpJfbG
 7/fNq1dm+1g5qPo0XfqkBngaayOLcj9X+CWMpWpCeGHYQusyLGcJUxzPvsav/OxGuVCJ
 4trbP1YRxtbDkJDMR3KHQsAQT8zfR8Dft5lmBeoPOpXK52IA6sSlDqD3hhxZMLficrU0
 6UsNIxOD8U/TsRfOZnvGDQrOnWk5aNykWXwcQLgImN/Vk9EUHALHFdScpaY24eAGIhWw
 3wER9CA6EOvh7SO9R9qaEbco3+OyucWQFy7XxxlwagnaUmDJhlBl/HPnnzMzJGDoE9Y4
 J9Rg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777482884; x=1778087684; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pt8wtkycxt66H1hCLVb3amhkXW+KbECwShFxXmd3b9s=;
 b=OGcpBN6X+bAknQHrpoq00KsMB5WNeHA0Nl99zdzVUHMe9OJHtSW4iP0hF4NdauKV1j
 bFUIXaWovI2vfkrvN1/tjn5n4uVE9W7jb9a4bRPgyIzXyZmjAuluytIAXazO0Nkv5iRl
 0c5/Fxe5NKxa5go/dFwDaIuDyRpe+qVKaqS6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777482884; x=1778087684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pt8wtkycxt66H1hCLVb3amhkXW+KbECwShFxXmd3b9s=;
 b=A0HzqUacoP7NKv/eDU6kZB6tQ2BEayvkFGYtC96qWCJBHHsntbkm3A/hUdLPAD04Be
 xQogPJSoSfxe5vCmqX8Vnx7lIDBGWw137YIdCmrzixwSuvWH3G03z4PGx+utQtNndGPO
 ac3rPpcXRgsiHQreptR5A34pQScUFDFhaT5MWdm8D/PYdifsS9I1AZxLSulwT2YbTg4z
 yhD6DTNrFYxRJzpdYlGxvwaPy59QgSNn39WQeJUemjzXWUSZjK2VkLOudwRY401K4/I4
 Uhqw6NF+q5O4eNWpeD8ewpyxBOIWJ4+IRZ7eVl0MX8MmVdN5JYE4YYu/9H2L0czv614E
 PwJQ==
X-Gm-Message-State: AOJu0Yz4qi3GLyZUo8YuRT29DisNrqBF7G21eKcjr9hYxgdwOdjztrBv
 OizhWh3GJ4soWqTu+ml70ra/wUtjeir9ugv1V5yn/AYpMl/fAp3EQN8HZ1poRq2WSVM1FDfLjyp
 oLpcPxDsDaU/1T7mWX/LbwyR2a83htmBa9P33UK0V
X-Gm-Gg: AeBDiet47rGe2YuqTWlK3LSCukPPj1+j4+OKvSRhUPa5FCkfrXRzqvYw6UobOG/YVFZ
 jw8t9wDvNXHJOIpk+dUEHpFdtf6k3KBNkNwX/KNaYFB8I1iQqS6RA/NOmF4YcU8RAC5qFz5HcnR
 aWbYxyAnpkOlRlnSRzNVyILkF1z3+NgFTiPNGrn+yVRVtCISsvzQUO77fFZtQn30yBSmwvocwRa
 j72/y2YcPTWSqbbkvZWJ8HCf0qI6TONKETSd8PbsYkcpWeEm5xIkjy8eN2hRtPDtQBuznsKsnIr
 hi9b++0YReSFob+UDQSzmrR+AHl8IgHBLBSt96+53/Zhb4e30QwO
X-Received: by 2002:a17:907:ca13:b0:ba4:d724:1730 with SMTP id
 a640c23a62f3a-bb8027bb403mr357804466b.20.1777482884534; Wed, 29 Apr 2026
 10:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260423042824.3480-1-briansune@gmail.com>
 <CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com>
 <CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhdmY3Q@mail.gmail.com>
 <CAFLszTgouk66AOaL2o8PvH9EKNFabE=pjxpa9QpC_F--VhE9cQ@mail.gmail.com>
 <CAN7C2SC-MuqHK2+0vaZzZFi-up1L7=KcOSRedF6f6F3D9Uoceg@mail.gmail.com>
 <CAFLszTjz5SMpFMPjVd6tX5Lk9DKv3MMX+_qtkSgt6fztGceHFA@mail.gmail.com>
In-Reply-To: <CAFLszTjz5SMpFMPjVd6tX5Lk9DKv3MMX+_qtkSgt6fztGceHFA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 05:14:32 +1200
X-Gm-Features: AVHnY4IxvzOR9BfRwksVI_K7tLfE22-G55WkD8BpbKxsNgqZd0xQmzB29kUyR5c
Message-ID: <CAFLszThDv=YcuXUanOJd4MPeNdSiHSL2zH9jXAtbu+-8fRzF2w@mail.gmail.com>
Subject: Re: [PATCH v6] Improve handoff prepare on SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Chee Tien Fong <tien.fong.chee@altera.com>, 
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

On Thu, 30 Apr 2026 at 02:44, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sune,
>
> On Wed, 29 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote:
> >
> > On Wed, Apr 29, 2026 at 10:21=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > Hi Brian,
> > >
> > > On Tue, 28 Apr 2026 at 08:34, Sune Brian <briansune@gmail.com> wrote:
> > > >
> > > > On Tue, Apr 28, 2026 at 10:04=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> > > > >
> > > > > Hi Brian,
> > > > >
> > > > > On 2026-04-23T04:28:24, Sune Brian <briansune@gmail.com> wrote:
> > > > > > Improve handoff prepare on SoCFPGA
> > > > > >
> > > > > > Ensure qts folder header files are properly updated by isolatin=
g
> > > > > > the Python execution environment. This prevents partial or fail=
ed
> > > > > > script runs from corrupting the target directory.
> > > > > >
> > > > > > Changelog v5 -> v6:
> > > > > >  - Clean HANDOFF_KEEP comments.
> > > > > >
> > > > > > Changelog v4 -> v5:
> > > > > >  - Change HANDOFF_KEEP condition to if [ '$${HANDOFF_KEEP:-0}' =
!=3D '0' ]
> > > > > >  - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
> > > > > >
> > > > > > Changes:
> > > > > >  - Implement a temp folder for Python script execution.
> > > > > >  - Clean temp folder automatically despite execution failures.
> > > > > >  - Gate the file replacement process on the successful exit of
> > > > > >    the Python scripts.
> > > > > >  - Execute the replacement (with or without keep) only upon scr=
ipt
> > > > > >    success via the NEW HANDOFF_KEEP=3Dxxx variable.
> > > > > > [...]
> > > > > >
> > > > > > arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++=
++++++++++---
> > > > > >  1 file changed, 36 insertions(+), 3 deletions(-)
> > > > >
> > > >
> > > >
> > > > Dear Simon,
> > > >
> > > > B.C. the server is down and I don't expect Google to have an auto f=
ail
> > > > mailing recovery.
> > > >
> > > > > I see 6 copies of this v6 patch in patchwork, so I wonder if I go=
t the
> > > > > right one?
> > > >
> > > > I will try to respond to this email as politely as possible.
> > > > Please reference from "patchwork.ozlabs.org" list.
> > > >
> > > > > The per-version changelogs belong below the '---' separator, not =
in
> > > > > the commit body. Also U-Boot convention is 'Changes in vN:' rathe=
r
> > > > > than 'Changelog vN -> vN+1:'.
> > > > >
> > > > > You could try using 'patman' which will get this right for you au=
tomatically:
> > > > >
> > > > > https://docs.u-boot.org/en/latest/develop/patman.html
> > > > >
> > > >
> > > > 1) I only do basic software
> > > > 2) I used ./script/checkpatch.pl There are no errors, warnings etc.
> > > > 3) There is nothing to do with the patch itself either the software
> > > > nor the file itself.
> > > > 4) I am not too familiar with patman
> > > > 5) There are many better things to do rather than complaining about
> > > > the patch headers.
> > > >
> > > > So forgive me I really don't give a damn on whatever the header req=
uirements.
> > > > If you feel this is not passing the patch standard simply reject or
> > > > label all patches to
> > > > "Changes Requested".
> > >
> > > That's up to whoever applies this patch. I am just a reviewer :-)
> >
> > Hi Simon,
> >
> > I am going to ignore all your mail in the future.
> > So review whatever you like, don't care.
> > There are many patch not following whatever rules or guidelines you
> > mentioned.
> > Just review those as well. What a waste of time on your emails.
> >
> > As politely as possible!!!
>
> Oh, sorry about that and also the server being down, etc.. The
> maintainer for SoCFPGA will handle applying this in any case.
>
> > Brian
> >
> > >
> > > The reason for the formatting rules is mostly so that maintainers can
> > > apply them without manually redoing the patch, etc.
> > >
> > > There is also this which might help (although you might not want more=
 reading):
> > >
> > > https://docs.u-boot.org/en/latest/develop/sending_patches.html#commit=
-message-conventions
>
> - Simon

Since I've reviewed it and we are only talking formatting:

Reviewed-by: Simon Glass <sjg@chromium.org>
