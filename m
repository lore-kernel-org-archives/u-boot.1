Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3C3C55838
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 04:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B42080D15;
	Thu,  6 Aug 2026 04:22:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-kRWvqrqTGP; Thu,  6 Aug 2026 04:22:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 276E180D1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785990162;
	bh=UEyJfxvS1Y/tohS3KDLwWVJ0i1kyM1kqDvw1m76XMZg=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hHxoe4/djXNVkNvBapc309fXbLZxrsIfTdLQzn+7YgriSYI/QVXjLlgY57BrWMVi9
	 QspFxDz5pmHPq2QrHCdmJPmQeBfIWP7Z/WvhRwfCMo/IOiVE+inBP1tJyKgcPnfPDo
	 i6s9emC/KJVfMt1Ju39YmcTl4wuji8eSxuX/60FzyAK6+Js5mEF7GHdZCqBBMTnyDq
	 LLiT1dAAD2Csz2k9e01MHJtj878q9oumjO+G5f/Uw+NIcpNSX/nu03+3KbSH1GZ21l
	 d3EQFA+3NKmSxUwUrnJtsFwD82N+Vqe/rzSFT5d6EXn/3bbL/d6EdtjeJgSeUqAzK7
	 YoHBmjeL/KamA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 276E180D1D;
	Thu,  6 Aug 2026 04:22:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 794DF392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 04:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 627DE4060A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 04:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBlIm88BYDKU for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 04:22:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A5A254067C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5A254067C
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5A254067C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 04:22:37 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 177343F981
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 04:22:35 +0000 (UTC)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso2472385a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 21:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785990153; cv=none;
 d=google.com; s=arc-20260327;
 b=HVORTsOzAb1dym69ko31X5fV2lWRXYCZTec9ynqkTJD2HhPyH1Cv8T9oAjaLeg9+Yv
 r3vCCQA6ZWLXKQPU3wwEj0BitQL/9nJS4SQViJcThrUi3MlffMluFJ1HnXaMqDaQL1as
 VnZodJa4DLjBkQ0gLC9SWA3h4N/wDFGLYRN6MzPOztbWQl7+0+AKCXmPmAKdp6bl5ycU
 4Pfe/fUhKIdf1doY0iueRmco+gsHkQ3qgS3gGw0/2veT3oiF9qIe5BbJ01kays9VwEPC
 52Z8OtVWlGgHuVocgPz5RQ3uBNinnh1nYRY50Wcs7o8lJtDl001qmUUzV4QnxII9Xpjg
 gFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=3Nx86FkbGpmD8tE3Y7YFuJb388/hXVbHGHa6XF0RnP0=;
 fh=7lAWr5z9tIvpULmrrmB9Gn3ZBQ/8TtOKyCdhgWSh6Qw=;
 b=sf+vHt/3ZJANHQlXBVN28zOynk2C3TFNZc05jIR5TqoTieGX5V+QJBQrJmVM3v58xZ
 tvO07eFE38B6Y1vMluuIZLq/9Neew/Tzt1/7BOTgxYgIlDwTQ/e3upj2ZiofxJT0ZcYJ
 50RCNwhg85yNGJDfzGcNf7/X94h6kPiHKk43KRSlzjajxlnDnj4mGkbGsW9LvtfdJiB7
 i1vcqZcwjJHOEoeRRjv11AWjKo+gFZwcmED1sgyXArjubftBtSnxswJP0buiPi0ZSpa2
 sMAM73Z45baSU7PYKr+n80fXTt1b1V2sBUzMiG80IV1psuWPEp4EY8EHu9BK93ka990R
 X4FA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990153; x=1786594953;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3Nx86FkbGpmD8tE3Y7YFuJb388/hXVbHGHa6XF0RnP0=;
 b=bwwwxt0b3CdeeG88kHyPJDQYTqqOSi4n/81MT1fmvqMxYGso5ZiUf/crBWRgwQkE10
 xImZVPvTfvBXWXfK+/qp4wmxxBqmS/B3FkSjSqYaDZfAJpixy/BTCdGb2jYYgv+FSY69
 mmJQnK6lCBlYrL6HnDgoywLwNke0ltXZ/34B1SQ+PN8w3/cGRtMBNwJ8T4sxgoxAT2Ps
 tsS2V+QeQvGR+404rUS1keu/5RvOpxqW6NTNGTAj6K16jHelgD/HISEHQ3c0braVvcG9
 9EBGaeLlamxX+nGmglHfiYnMW97XJiy25jL768u4GF01B1MFZB5r7B3V2abHlxh20bcl
 tVNw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+rELCXXO40Vwt4qgb4xqRRdGo6JiTy3avJ7VZfvWlgTxAwXlHpHs3Xjqowf8lPZmqEG4c7KY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwL4cOOe+b1sruR18KVAY405/BH1e9vxZoZn4fnucV84EZpsBOK
 1S+Nt52QF1vNVVtU/ehWhnqYqwI6R2/BgQbTKRlGHogMZ5eQivNx14Xk5EjSeekVhGNSZfpzSvh
 wbY87Qp8hq35tTGl/36omJ+icgPhbH7rR3PdcfToEYqIiVKeTafBqtQWfBtb6NUCJE7DBN4MLAk
 79QWXc6c3NhIu6cNkW2Sxg6JSH5j8CLJTSOBq7hVYqHPanks7SrIndPzs7QkLVbfvOggMT
X-Gm-Gg: AR+sD10PHcsTvayfLjulgv1b0PgCc5x4ZXmKHwTKG6+D5Ysx6nQnGDcUl4j+4Z180Oy
 BqL2b6aqyIfLe5sC2TEcjA6TqD12QZztWzH8GaifAuuLYo1h8S6fer3+pYoWuwalx3rcqDxg9qq
 wuT/iZOKjm6+k4u/ES8Yh2S+WS8wZX9OdyqLU2ZYTAB3aBXZMK52TsVvfunpj/FUZM9w42uZJzY
 9X2OOt4P/d3mgjP6U2LDIlTPOs=
X-Received: by 2002:a17:90b:1f8f:b0:38f:837e:fc5d with SMTP id
 98e67ed59e1d1-3903c542eaamr12317376a91.3.1785990153360; 
 Wed, 05 Aug 2026 21:22:33 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8f:b0:38f:837e:fc5d with SMTP id
 98e67ed59e1d1-3903c542eaamr12317346a91.3.1785990152943; Wed, 05 Aug 2026
 21:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260731085724.75729-1-heinrich.schuchardt@canonical.com>
 <CAFLszTg3Rw8fOabWEsTKJvkazwJrnQYnAfTgANX9XDjpUczVdQ@mail.gmail.com>
In-Reply-To: <CAFLszTg3Rw8fOabWEsTKJvkazwJrnQYnAfTgANX9XDjpUczVdQ@mail.gmail.com>
Date: Thu, 6 Aug 2026 06:22:21 +0200
X-Gm-Features: AUfX_myKwwgnWIkJzRLDVlg_af591XHmVyN4uh2HxdJzh4T0NT1CrLjm3_JW3vs
Message-ID: <CAM=mAO=Eu8d-EQ3FgZ0jL3w8X2uMBddvWCLePb_+dhJGbnB6ig@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi: avoid video ghosting in EFI app
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785990155;
 bh=3Nx86FkbGpmD8tE3Y7YFuJb388/hXVbHGHa6XF0RnP0=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=WCSjp087vG2vUof8JlD4vWx1aSy5i67qDua6x02NdY9ewOrBy05e2jEFTNuW8rAOd
 i0PeHca/PvD3fZwHWwzSaJbOiYyz7FG/lNtqYxqvm/JP71x4Pvht8ZTT5NvGE1CqaR
 /dwkAUafQ/kRk3xTWjg1+e57S7FzYLkB8+bqkaFBoyAnPoWQTWGQb4mGKCWD4nJNxu
 2bd0ctV6xCogREXIblY2AkFdmKcZcNAg0HzdEqeX56dD18GegrHSC42iqdGJOfcBAJ
 am9oGHEnQtbh7u4h0v4QeL+0DlMiXBx73wpdFq+FbpT7AFezmqzrgz/+Lwhda/gJl1
 8+CoyDXUAMMsFhu7B0HfEhpAnSlRC9lgGvH2OOz3+wscnmNV+ViesEC0Y2adSJX7gS
 II4Gh3AU7uc2wBf90nhxEWvlBSYE2eFj134rR5deSPZRaCTxLpXNRFvsMCJ/pJbvXZ
 c4Obg3qwUzvloBex+i+P4cERkyy5HbXIrbDrloR8+zsRtXbsjcEKTIHgHrnmDe372J
 d1QMm/LLeaKs0Y60RhQhuKeb2rqLuLSKkN1oDwgzlGrkp1A2lTvYmP/5KaJGsA6Ydf
 M679zuHIf3CCAbjDKCBT9pLfbeW8+R6sudbYuh/0rueo0QmdQPljA38Cw13LE5Rp4p
 lHlibWNGJqNUKemaAGa0CcM4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=WCSjp087
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
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Simon Glass <sjg@chromium.org> schrieb am Do., 6. Aug. 2026, 00:00:

> Hi Heinrich,
>
> On 2026-07-31T08:57:24, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> > efi: avoid video ghosting in EFI app
> >
> > When running the EFI app via QEMU with EDK II using
> >
> >   cp /usr/share/OVMF/OVMF_VARS_4M.fd .
> >   qemu-system-x86_64 -enable-kvm -m 2048 \
> >     -machine q35,smm=3Don \
> >     -drive
> if=3Dpflash,format=3Draw,readonly=3Don,file=3D/usr/share/OVMF/OVMF_CODE_4=
M.fd \
> >     -drive if=3Dpflash,format=3Draw,file=3DOVMF_VARS_4M.fd \
> >     -hda disk
> >
> > every character printed to the console by the U-Boot app appears twice.
> See
> > https://gist.github.com/xypron/7214e785c7d73104f8541bcac363a192 .
> >
> > The reason is that environment variable stdout has serial,vidconsole as
> > value. This is defined by board/efi/efi-x86_app/efi-x86_app.env includi=
ng
> > include/env/x86.env.
> >
> > Provide a proper efi-x86_app.env file which does not use vidconsole.
> >
> > [...]
> >
> > board/efi/efi-x86_app/efi-x86_app.env | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
>
> > diff --git a/board/efi/efi-x86_app/efi-x86_app.env
> b/board/efi/efi-x86_app/efi-x86_app.env
> > @@ -1,6 +1,17 @@
> >  /* SPDX-License-Identifier: GPL-2.0+ */
> > +
> >  /*
> >   * Copyright (c) 2015 Google, Inc
> >   */
> >
> > -#include <env/x86.env>
> > +netdev=3Deth0
> > +consoledev=3DttyS0
> > +scriptaddr=3D0x7000000
> > +kernel_addr_r=3D0x1000000
> > +ramdisk_addr_r=3D0x4000000
> > +ramdiskfile=3Dinitramfs.gz
> > +
> > +/* common console settings */
> > +stdin=3Dserial
> > +stdout=3Dserial
> > +stderr=3Dserial
>
> Please can you keep '#include <env/x86.env>' and override just the
> three console variables afterwards?


Hello Simon,

the EFI app should not be x86 specific. You already fixed this in your
private repo.

Do you miss any value?

env2string.awk uses vars[var] =3D
> env, so a later assignment wins, and we avoid duplicating netdev,
> consoledev, scriptaddr, kernel_addr_r, ramdisk_addr_r and ramdiskfile
> =E2=80=94 otherwise any future change to include/env/x86.env will drift a=
way
> from the EFI app.
>
> Also, the previous include pulled in pciconfighost=3D1 which this
> version silently drops. If that is intentional it deserves a mention
> in the commit message; if not, the include-then-override approach
> fixes it for free.
>

The EFI must not drive any hardware directly. There is no value in
pciconfighost.

Best regards

Heinrich


> BTW an alternative is to leave x86.env alone and make the vidconsole
> entries conditional on something like !defined(CONFIG_EFI_APP), so
> efi-x86_payload.env and the other x86 boards keep sharing one source
> of truth. What do you think?
>
> Regards,
> Simon
>
