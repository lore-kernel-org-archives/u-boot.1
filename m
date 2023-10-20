Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91E1CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 08:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BEF6870B0;
	Fri, 20 Oct 2023 10:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PLHuRXGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 010EB86FB0; Fri, 20 Oct 2023 10:21:53 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FB6386FB0
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 10:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9bf0ac97fdeso82094666b.2
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 01:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697790109; x=1698394909; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zFA09g7VCc6TBL0x5GblSQyMKDPCXSOAnafRplNIEc8=;
 b=PLHuRXGPfN33+4B+NrF/fO6ZXGDAXjOpDj60a0waR9hjPjYiI54P6kZ0sq4Nuni/do
 94z1BMM2dtup1hmC7YFj/lDAeNC71pihPwP6Ms3Kx11bk3/EXMRy2J9s/UyCDFpTSG3M
 K18iDcU1heshXykdmJP7+7jBauM9udwkucpUMFeacQ8vM25M2sRA9WFQEkTm4EEDWUrq
 MjsYCV98Uibdor1SCaUXZYAVqn3xjkVLPLzZMTXPmS4n217zv5/B+DUZhnnpovxR5ziS
 /23a5Yty2q7yRKLSXUhYFuUByXwMl9EhP2Lh4ZIefcHBghEL3PDou5YGM6wk5AsuJOZw
 aVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697790109; x=1698394909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFA09g7VCc6TBL0x5GblSQyMKDPCXSOAnafRplNIEc8=;
 b=pbqJm7s6mB0ogh6YWfymrEdaNhY/TM66rEdWl7UsNvgY8CaPtuANYWVH8H9CMjtTKi
 Wcip8XNoKIYZluFwPPBqdjnAcXPWqha/s32KanrtkM4u/PjgTTpHdvC7PTYoJZN7JA8t
 Z0rG2zIlq0j2uiDE0qwiTi5NmGXbwCP4U5YpUbMcubqicH6cHGBEo2J9743qhs9PbkUT
 pRdwAGPc0xBvOGy+9eVYIaJ+1tNCdGJNjqZZE96IXRdTUWG6VdNYjLcUytdp4mcP2Om6
 SqR/Fpp00Oe0iwYjbUwhgJpM2hYYlRdGFFSiCWh1D63mbSOJuG5XRk9SAduShDW3PIVE
 sxxA==
X-Gm-Message-State: AOJu0Yx2s+VFvjr3ukMF2PAuEE43SgscWVvoMLDLDmfRY/1NF9hOU+7S
 mXc49dUPy+5we7+VPBh/vBdwrEhMcie0nltt4UGQI9YM
X-Google-Smtp-Source: AGHT+IHwfJZi3sb91D/iF2LthRaWIr5Qtsbb33jeA8tAopHv5piduuJGYEE8YbhBlJGPywPG2MkUO/qyw3gVN07XZZU=
X-Received: by 2002:a17:907:2d27:b0:9a1:c991:a521 with SMTP id
 gs39-20020a1709072d2700b009a1c991a521mr681091ejc.4.1697790109411; Fri, 20 Oct
 2023 01:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231018205358.1557234-1-judge.packham@gmail.com>
 <637b7903-e40c-4760-8f37-5dbbea5184a3@denx.de>
In-Reply-To: <637b7903-e40c-4760-8f37-5dbbea5184a3@denx.de>
From: Chris Packham <judge.packham@gmail.com>
Date: Fri, 20 Oct 2023 21:21:37 +1300
Message-ID: <CAFOYHZB7jJWwD24oWzx6u55w2whHYjK56f=QyN0LWU4Z8dSP+Q@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: AC5/AC5X: use fixed page table size
To: Stefan Roese <sr@denx.de>
Cc: u-boot <u-boot@lists.denx.de>, Marc Zyngier <maz@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 20 Oct 2023, 7:18 pm Stefan Roese, <sr@denx.de> wrote:

> Hi Chris,
>
> On 10/18/23 22:53, Chris Packham wrote:
> > Since commit 6cdf6b7a340d ("arm64: Use FEAT_HAFDBS to track dirty pages
> > when available") the default get_page_table_size() sets some flags for
> > more efficient handling of dirty page table entries. This causes
> > problems on the AC5/AC5X SoC (specifically a lockup when calling
> > __asm_switch_ttbr() via mmu_set_region_dcache_behaviour()).
> >
> > The reason for the lockup isn't at all clear but it can be avoided if w=
e
> > provide our own get_page_table_size() which stops gd->arch.has_hafdbs
> > from being set to true effectively returning the AC5/AC5X to the older
> > behaviour. This also opts for a simple fixed page table size rather tha=
n
> > trying to duplicate the more complicated logic to optimise the table
> > size.
> >
> > Signed-off-by: Chris Packham <judge.packham@gmail.com>
>
> I'm not 100% happy with this approach / workaround - still it fixes an
> issue on your board, so:
>
> Reviewed-by: Stefan Roese <sr@denx.de>
>

Yeah I'm not super happy about this either. But this is about the best I
could come up with.


> Perhaps you (or someone else) can look into this in more depth to get
> to the root of this issue at a later time.
>

I did spend a reasonable amount of time tracking down where things were
going wrong, even if I couldn't figure out why. The commit message
basically reflects what I found.


> Thanks,
> Stefan
>
> > ---
> >
> >   arch/arm/mach-mvebu/alleycat5/cpu.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/mach-mvebu/alleycat5/cpu.c
> b/arch/arm/mach-mvebu/alleycat5/cpu.c
> > index 8204d9627515..7ba57ae75e76 100644
> > --- a/arch/arm/mach-mvebu/alleycat5/cpu.c
> > +++ b/arch/arm/mach-mvebu/alleycat5/cpu.c
> > @@ -63,6 +63,11 @@ static struct mm_region ac5_mem_map[] =3D {
> >
> >   struct mm_region *mem_map =3D ac5_mem_map;
> >
> > +u64 get_page_table_size(void)
> > +{
> > +     return 0x80000;
> > +}
> > +
> >   void reset_cpu(void)
> >   {
> >   }
>
> Viele Gr=C3=BC=C3=9Fe,
> Stefan Roese
>
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
>
