Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8632EC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 452B7406E7;
	Thu,  6 Aug 2026 13:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VKnhem1-HWVg; Thu,  6 Aug 2026 13:05:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0B27407B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021523;
	bh=K03urPrRGXrO5MI5Q36IkApSb2Fx6q/Q2CDcuw+MS9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pH3U6ZZMSZEP0WS1Lqy6q1aEt8CeHgXsqGB+q9TUK5vhicQYUy2HbEjTMPd3xxGlB
	 HAtiMN1bucYC+umTAzOeJ8HOhxUrMaJcG4CaiR2St8YtjP2s9KZDPjcqFmjYi6K2Wv
	 td5TsoQqaNsIwJMsne97ZmF5vLi2O8IzQappms1rjKbfQVTH/LMgiGPdm48dHSkLbd
	 w+ke+ScxfVL/0FMia5waU5ZjmsaLosjXxEjzxN8QIOmg2MHV+W9LHFwhoyDorP/yc8
	 lc4KLU6c5R7EC2YIFsCbzJTD2c8gQeTHiEgjIx+CeSbWJYL2WXn7oZk6HdryO5ruOr
	 TxilqFEESXbsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0B27407B3;
	Thu,  6 Aug 2026 13:05:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28CCF282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19D234065F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgm6pswwjm0b for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:05:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C88444063E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C88444063E
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C88444063E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:03 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso1435634a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786021502; cv=none;
 d=google.com; s=arc-20260327;
 b=EbMg8BG0YvOWdKRCu/oCZrnUzsOpzrIno7hTy17w4dBRIouggO/XIjCO0wSdAn5oV4
 1i5Jcnup7IcIasNb9+21yP2oDvL2sE2E0RTKQjC8oNZ2eLDHMdLf24MKBRbcQ29qPa5j
 2XxeJm/R+3rBNxGZaKOYXbMEnPIhmLpnXtZIuu98YPqWS0ohxV8ID6PN6hGZbO9sd/5t
 KolE/Ki6yv1K4kISO83yBJGugjqVbBBOq+3OLbe0Z2inJTKUzRcsI5HWhGH0Ptpk7ZoR
 Sj6VrIrkfhbOp9HqvkkJYhLbsqaKGVJR1ybjJCGv1etKdG3zUNHGwZC5Y660AV9n3Lkj
 mbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K03urPrRGXrO5MI5Q36IkApSb2Fx6q/Q2CDcuw+MS9E=;
 fh=OiqyfJriKAEY4npMYc5GL0YTZxvo/Zyvl8rRGPa6ZE8=;
 b=jwJrd9KIEb1grg9c7AmViTA8dNVTpsmrnEEsIi0VPQwdjrzu35AEEfCHkGP6VyaIC9
 LjKd27mMs0oeuoHw4KQTfRwBe6KDE3OtXQg5bZz2oHfpUAsCLeDv4bh3No9sC0/k1fi5
 m0sIuCJzOsJ3U0vG6oB7uEp8MSdESWPcQ/xfEbM8+rNy/3lfVmd2YAiGeUA0fDWFnH1U
 bPAYzIrCFsJVGQW7OF9CcPZ0d7/NKVMQKlVAjU78GPQAmtirM4r6Xrdoghbg1u6SrUXH
 K0dkqSwvFh8wqVOyscqsZCKvBBJ28j01zyitTjdwZ2TVl0bvOpVsGQVuhIcjeH1qdIMe
 QLMg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786021502; x=1786626302;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K03urPrRGXrO5MI5Q36IkApSb2Fx6q/Q2CDcuw+MS9E=;
 b=Ykh5P2m5mEQLhMnLQ8/NRmbI1wjLHCW2Dj/8UEbsmSCsFCbjW8SoEJYZ0NRahQwH0z
 nsHlk1sVucaeWA+2eJEy692hH4c0sXIpg/inV2DB24qEyjtTEFWshqCylzig1lgfj4+D
 /dFt2Y+ovdVef6rFdPD/VWWLXxp117vwWScLVBHoIu0jFmbzj0dNUKkICri2KrmD8Eye
 M8UhQu3dfNp0W3gmVuM6PgeuMZohb8ZobWG6PC8qNFNFWgJX928wrNucH8d0z66fVQhF
 Va+WpoOe/GqIE/8ELKHQ/tVElxFQ9MCa9vF2ky+cgOpcu3Lw3hG8Wz/suAZeT/ZOSTe3
 hK2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMLccalI4p0WUdmuTrShrWCYy0y6oZf0pN9mlnPvRrkspN6nJaFC831AuFQOrbs/bfAVHpevc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzUwZQBfgOxEw2FEC84V5RyiNAix8qkhNAie11u8pYzrquv1eJ4
 Gk9MOngITCjwEqOUdxIu6RKGvH79lsoXGilQC34R9l/wnVHkzZd46IaWZdunUe+wrBAiLnf4sYu
 gSeVMDTnSOWsDDtnv1ls6nbaRT0daDHZnFxPaf5XDMmMlg08kJMk=
X-Gm-Gg: AR+sD13QU/uZSkNtltTUuaFEeu12fNN4+tIt0YrUzBzJOQUcZ5OUw3vRSAisASno2tJ
 hkbhp46mzy6VVFLrgKyPMcH9M6SRKtGb+TjQdH8jfmBVcT+Ktea3z+FAeER2T03q8qHNKvdrIAD
 dyl0+ekPqoSuneBoSB/MeDNluSzW4Q0TvhNelbJ+cDuVRyoHRGgqoS0gRIOcqx42LrKe1+oOKzQ
 ZtXwd3nlgph9YkTluYbYzQtV9Wbn0JiqdfX+xaOeFwiOYXxqVP7Oh3HT4XXe4KXdBktOD9fzYrr
 IVwAgTw4I0LesKa49wWhyXVGcRsuS12y6KbpSgFwM30=
X-Received: by 2002:a05:6402:3809:b0:6a0:e8a5:7ef4 with SMTP id
 4fb4d7f45d1cf-6a198ebacbfmr2499582a12.3.1786021501747; Thu, 06 Aug 2026
 06:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260731085724.75729-1-heinrich.schuchardt@canonical.com>
 <CAFLszTg3Rw8fOabWEsTKJvkazwJrnQYnAfTgANX9XDjpUczVdQ@mail.gmail.com>
 <CAM=mAO=Eu8d-EQ3FgZ0jL3w8X2uMBddvWCLePb_+dhJGbnB6ig@mail.gmail.com>
In-Reply-To: <CAM=mAO=Eu8d-EQ3FgZ0jL3w8X2uMBddvWCLePb_+dhJGbnB6ig@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 07:04:48 -0600
X-Gm-Features: AUfX_mxJt5x2kV8ar3zxwUoblhJ9yPlSVdW07tbI0XKfZ0JKtX6Pa1G_8g8LBTU
Message-ID: <CAFLszTiwvPhE+WLW1ym7wz35cCYY4wbF84drF2D34paP83uP6A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi: avoid video ghosting in EFI app
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786021502; x=1786626302;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K03urPrRGXrO5MI5Q36IkApSb2Fx6q/Q2CDcuw+MS9E=;
 b=ny8MrFk5AEigTuWwCE7DnaDx+HEbJ93PVVGny9sCtr22zQR3DfJgVUO58NvCbOOKf3
 cqZuaCxtKFzO64bulfMcmn61AGAP/JAM0uSOOhA5yr4AiotPwGb5/+aT8Uflq/c2eLGF
 0HdWV9R3PdMdl2AN+NyGEnr2LEfH+UFdOAEuI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ny8MrFk5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Heinrich,

On Wed, 5 Aug 2026 at 22:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Simon Glass <sjg@chromium.org> schrieb am Do., 6. Aug. 2026, 00:00:
>>
>> Hi Heinrich,
>>
>> On 2026-07-31T08:57:24, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> > efi: avoid video ghosting in EFI app
>> >
>> > When running the EFI app via QEMU with EDK II using
>> >
>> >   cp /usr/share/OVMF/OVMF_VARS_4M.fd .
>> >   qemu-system-x86_64 -enable-kvm -m 2048 \
>> >     -machine q35,smm=3Don \
>> >     -drive if=3Dpflash,format=3Draw,readonly=3Don,file=3D/usr/share/OV=
MF/OVMF_CODE_4M.fd \
>> >     -drive if=3Dpflash,format=3Draw,file=3DOVMF_VARS_4M.fd \
>> >     -hda disk
>> >
>> > every character printed to the console by the U-Boot app appears twice=
. See
>> > https://gist.github.com/xypron/7214e785c7d73104f8541bcac363a192 .
>> >
>> > The reason is that environment variable stdout has serial,vidconsole a=
s
>> > value. This is defined by board/efi/efi-x86_app/efi-x86_app.env includ=
ing
>> > include/env/x86.env.
>> >
>> > Provide a proper efi-x86_app.env file which does not use vidconsole.
>> >
>> > [...]
>> >
>> > board/efi/efi-x86_app/efi-x86_app.env | 13 ++++++++++++-
>> >  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> > diff --git a/board/efi/efi-x86_app/efi-x86_app.env b/board/efi/efi-x86=
_app/efi-x86_app.env
>> > @@ -1,6 +1,17 @@
>> >  /* SPDX-License-Identifier: GPL-2.0+ */
>> > +
>> >  /*
>> >   * Copyright (c) 2015 Google, Inc
>> >   */
>> >
>> > -#include <env/x86.env>
>> > +netdev=3Deth0
>> > +consoledev=3DttyS0
>> > +scriptaddr=3D0x7000000
>> > +kernel_addr_r=3D0x1000000
>> > +ramdisk_addr_r=3D0x4000000
>> > +ramdiskfile=3Dinitramfs.gz
>> > +
>> > +/* common console settings */
>> > +stdin=3Dserial
>> > +stdout=3Dserial
>> > +stderr=3Dserial
>>
>> Please can you keep '#include <env/x86.env>' and override just the
>> three console variables afterwards?
>
>
> Hello Simon,
>
> the EFI app should not be x86 specific. You already fixed this in your pr=
ivate repo.

Are you planning to bring in support for ARM, RISC-V, etc? In any
case, if you make a change the commit message should mention it, so
people are not left guessing whether this is intentional or not. BTW
my repo is public :-)

>
> Do you miss any value?
>
>> env2string.awk uses vars[var] =3D
>> env, so a later assignment wins, and we avoid duplicating netdev,
>> consoledev, scriptaddr, kernel_addr_r, ramdisk_addr_r and ramdiskfile
>> =E2=80=94 otherwise any future change to include/env/x86.env will drift =
away
>> from the EFI app.
>>
>> Also, the previous include pulled in pciconfighost=3D1 which this
>> version silently drops. If that is intentional it deserves a mention
>> in the commit message; if not, the include-then-override approach
>> fixes it for free.
>
>
> The EFI must not drive any hardware directly. There is no value in pcicon=
fighost.

Again, please just put this comment in the commit message.

>
> Best regards
>
> Heinrich
>
>>
>> BTW an alternative is to leave x86.env alone and make the vidconsole
>> entries conditional on something like !defined(CONFIG_EFI_APP), so
>> efi-x86_payload.env and the other x86 boards keep sharing one source
>> of truth. What do you think?

Regards,
Simon
