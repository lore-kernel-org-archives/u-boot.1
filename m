Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080E5C83F10
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 00:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03057869A6;
	Sat, 26 Aug 2023 02:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GKu1EZhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCC6186A7D; Sat, 26 Aug 2023 02:51:54 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57CA486430
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 02:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5236b2b4cdbso2092918a12.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 17:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693011112; x=1693615912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d65lPZPpK+iEz4AtuFlkH3Y4uqCJdQBuQ93V2nuWWxs=;
 b=GKu1EZhpTy6rhNwj65fuyX+AZzBrTnx0S5tzn6qskeXtaKjy6xIzBaOvex60kUHxhv
 BkDY3G8/UatvawOVuOm2EbEmnBycAFv5h0N9n3rOtHrl82+RLjHoKbODvHu213X9JytV
 OTotyrlmhxlL343AMxFoabwzM6wsVUwCjOXqsIYg9Udbj1nWdCnmRyPWYx1L+S9AWOEy
 NjMbRXskF3vdLQjqNSXOzTKuNOX4SIRGVlTexTaw7/gWPksBFPB2awEbMEgk/9TreJ9U
 zPUVP+dRFd6Ok1eRY1Cdcznhzz67L0FGUMVFZGF4ZPj/bOg7FeHgxclMopb+1srshsnc
 Ds7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693011112; x=1693615912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d65lPZPpK+iEz4AtuFlkH3Y4uqCJdQBuQ93V2nuWWxs=;
 b=PZUZ/tNUt2NuTGo6OZz3/JXoF4bIjbyANwZ/70rHMBrwnDY3S5uPlSSZf83jZEQcp4
 gCjYnlvnw3SJVophCnpWnnVQSobVKtwZHfZRW5qFTx19ICE0xTtGQUGAoKaVrNm7hSeY
 3fP0BpP0erTa9ll5danE1rBCTvqjfIOLmYYFxkFhfyay3s0fhBaoHF1upuguvWLVn4XN
 uRIfnE9R+9/KqCGMblz/ORMMqSN/KgG/ov4qgRFlLSb/vxlH5Car90/fv/obQtTUVQIq
 1gV4LZCAga20yo077Np6j6HAhqn3v3TOMj0mRAN/WJe1HZPM/kcpUKYaeU3xKHuCzksL
 BOjw==
X-Gm-Message-State: AOJu0YyMA/71eNXxVLJrEviM6i+EBk2+kWGpz5L84GZyN8lLqyAaMRGH
 v3WHAlnSsdMvLWEqLSk3UbYC8MxatB/if79SJyPJ3Jo+nW4=
X-Google-Smtp-Source: AGHT+IEyJ+XAdo+pVnw7jRdfXPHNoZcTWfPwfnNQihjWZ15h54kgDrsDbKynMg9Vkr1VLeaEckpM+HwrM2UfGOnMYxA=
X-Received: by 2002:aa7:d952:0:b0:523:ae0a:a447 with SMTP id
 l18-20020aa7d952000000b00523ae0aa447mr16257579eds.13.1693011111661; Fri, 25
 Aug 2023 17:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230825013930.1753078-1-sjg@chromium.org>
 <CAJaLiFzS+oHkRuGCNDGj=xA4ooNvYrV38qYED+ipA2M_O_uJuA@mail.gmail.com>
 <CAPnjgZ0kpMBatC475FmMF2sai_waMFK_Sf3mWxeSoLB_qYdXNA@mail.gmail.com>
In-Reply-To: <CAPnjgZ0kpMBatC475FmMF2sai_waMFK_Sf3mWxeSoLB_qYdXNA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 25 Aug 2023 17:51:38 -0700
Message-ID: <CAJaLiFy1aMgOKyPM=aK-heVow91baY9U20Jo0cG0KaCCMJ4mCQ@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Drop some TODOs
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Fri, Aug 25, 2023 at 4:53=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tony,
>
> On Fri, 25 Aug 2023 at 14:17, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > On Thu, Aug 24, 2023 at 6:48=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > The existing TODOs are done, so remove them. Add another that came up
> > > today.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  doc/develop/bootstd.rst | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
> > > index ec3136535783..3e566e994d6c 100644
> > > --- a/doc/develop/bootstd.rst
> > > +++ b/doc/develop/bootstd.rst
> > > @@ -752,9 +752,7 @@ To do
> > >
> > >  Some things that need to be done to completely replace the distro-bo=
ot scripts:
> > >
> > > -- add bootdev drivers for dhcp, sata, scsi, ide, virtio
> >
> > Good to see SATA finally in bootdev driver! I'm testing bootstd on a
> > couple boards, and have been waiting for SATA bootdev. Any idea, if I
> > should wait for it to be merged to the next branch, or is there an
> > easy way to do it with one of your patches (I can test it on the
> > latest master branch or next branch).
>
> I believe it went in in the last release - see drivers/scsi/scsi_bootdev.=
c
>
> If you need something else for SATA, PLMK.

I see. That's scsi_bootdev for the scsi driver. I think we also need
sata_bootdev for drivers/ata/. For example, the Marvell Kirkwood SoC
boards use sata_mv.

Thanks,
Tony

>
> Regards,
> Simon
>
>
> >
> > Thanks,
> > Tony
> >
> > > -- PXE boot for EFI
> > > -- support for loading U-Boot scripts
> > > +- implement extensions (devicetree overlays with add-on boards)
> > >
> > >  Other ideas:
> > >
> > > --
> > > 2.42.0.rc1.204.g551eb34607-goog
> > >
