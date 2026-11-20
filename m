Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FB606A325
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g3L2jE5S;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=YpG27qjK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EF608134F;
	Fri, 20 Nov 2026 01:04:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WmGRQfAy5_7B; Fri, 20 Nov 2026 01:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15F4F81174
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795136671;
	b=YHkW5K48w/lUu4spiG3BH3zEdSnV981i2IhOQT6TyjXZ80x7Dyw6Rc9tz/qxrWJQLe2t
	 wH0LS7/moIZzBif0t2ySfzt1oVzM7Q3ayoWpuKIIDhsKBjaGyZVjFFnkwGHVAsf6cnpGk
	 46C/aV8NQ1Ry3kk6KoR/klNP4brpt/jPgdL9D4y5bnJI1UBE7mvhShz7IVo4Y2Kc5QUSM
	 Ml8E2t1MAIiCDKXzKAtiyapeYkGRvyoG8ElemlL3IM7I/BzZJxmY91lflDr+/KcndqLy9
	 ddtLurhWmAeff1xbcGGndnHk4TlMPV+bAj/RLFDRGgBKIFtoQUNYtKNnh/0Zj1M3Qgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795136671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/VKqEE9o9cEybjfGrl137zVOlfXks2X79sE9yvCUTgY=;
	b=hIi/avspR8e7fn3nlMKAKdjqjtf9QP73MWLq78hPGmPnh79xl88DmsTU/XE8aisLTTqD
	 2tsZ4o3vS1N1mZ/DFLYaNqBjh4lOq9AcIWGnETGuykO/cSMkT1D1p6cvzyqEsEjt3pzvL
	 fhrWKTY351ddkefgmCEZaIz/ox23FTtt4k+83ghXpfUHEg4pdMmwSKT9X6U9u5FsmKJaH
	 WuL4uvgbDHjkgHXeJFjOsM7j6Ul9/hpymt54W/ViMUXIqyCBs6SaB7WVLnYxwNsQ4iaNR
	 BdOFvJ3ZN/FWIEMBaNk2CeTiMzA0N8Pii+q/NYzL0QqVvMsg1Krzb5q+ZvQkdar0/sA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795136671;
	bh=/VKqEE9o9cEybjfGrl137zVOlfXks2X79sE9yvCUTgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3L2jE5SyEkXLKlseiVib+D3mkjdbngz1unVIvWNMI67TQoiT02HQGbXdaLI6D75I
	 ujjr6oY9y4IoifsmFlXn033X9mi2msKZKT5/YT6art7Zjj5AJFAPpFJ1M3c1A2XFNG
	 fuXuefCVtyYeoBO0FNtC/9GbeaDgJLHAfqLkGleffQ6rXUm5iJKZxkWT245ZH5MAbe
	 bIQ1/Qiomvi7EIGiY756Bmyw2WlnR9wFA8cSR8IlMiUCbhg2WRc3n4iGPjj3eY6PdB
	 uqgkJp9T/EzwalHKtAgi2oOeI3pQaXNANcfC6B+GWTfLUT9Ux51p1klStwTh1vOg+o
	 79HYqqSE/1rvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15F4F81174;
	Fri, 20 Nov 2026 01:04:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A3BD79D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 01:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E45AA40079
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 01:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DfV_o2a5WIG7 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 01:04:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C381940063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=YpG27qjK
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C381940063
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 01:04:26 +0000 (UTC)
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-675617e81f9so522596d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795136666; x=1795741466;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/VKqEE9o9cEybjfGrl137zVOlfXks2X79sE9yvCUTgY=;
 b=YpG27qjKaomuQDhT/exp9JpJ88F7LAYuqt+jISHfrSZ2h3ZOCT9Uh17KnHJUP2wtLN
 MEdnJVcY25Y6dShMh7amexW+lWjH1FRenULGjee324tOdwvr+CrKUXbhTWJnPcelIRdY
 5xeKity1BStgVyZSYt0MKDSUtCHZJlgq44BK6P7N6RqbcXmMDsiCMGiOnp8T1KqoylJl
 DGa1/m3SvzdBl5zs+HYBZS7xFbXvcI0mfT2oO++EJhbeXj5+B9frn86Qb7x046Al/qud
 AzdfQIwT2ZyBmR4GzX14I8S9HjNwCW1+exL7CuOHwP7Eot+p76BO4lfHrq2OiLFlUMYE
 yOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795136666; x=1795741466;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/VKqEE9o9cEybjfGrl137zVOlfXks2X79sE9yvCUTgY=;
 b=YmYV0/mffkCqninEi+2rAqOyYqdYLIGbSeTjZjAV71J4GOCiKG9SN+7zX7VVyFgEX/
 PolMMF8qNQHiItq4QLE2KCbwJzlJ8TtOHU5IAJqWe2B6DV4pvFLB855Wrc9y1TCSwtMJ
 zxwrgn8hfI5sDPxWicliW/oXX4UxJSGg3EX+Cij5lRVfH2XD4JqZZYvLfLh0TgreEDQu
 lI49o6juDs0lqFVhL2sAev8exkrE8JfUoahDL8h30YbsI9nW4P/6+Gt5czHABp54cNqO
 F8Uplw805X4kQ827slLSszgZJrCJuzVqTvjJ3+gKux8H/bRuBWp9F+oJUl5zXtlnZyOe
 TbIA==
X-Forwarded-Encrypted: i=1;
 AL+hErEhduCYRw1nlPonDcN9sknout/8SowMih8SLqp2y7ad/PQaBYI1809cVy02WpdctlYOytFy23Y=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9bCEXaUwNHSHH18zDtUvRA18SGiKaXzkY75IQQBXvs2exuBwE+
 RZmeUJK5zwMVWjNPi3Yua56cIkBrqth2ZIvs1TwkXmO2ArCERRjUQ+u+w96XoLpsOu/64/pnu32
 W+nqF6VLJNZE/jtReQ0EH3l9MHYIJC6l9Q32wsiCaQTHRGHerOa+ckVI=
X-Gm-Gg: AZFdTZduq0rBMoOwBpjUR3u2ueSIAuh1uU5ssohX5Dg++8NZ4SPVVmpl9BLoTTrcBHK
 Pzm4Yu5TEg5kX9a/qP5Oyc/q8BYzTPtUgd7NHkyQ2AlJrxzavTuizKWfqyZM2pylB62LhtzDOs+
 BFq1qGHEoyiBlTiVJr270bcVW8YvzU/5nuuPtI21EErPxI6YfuUBCO/JBoBOxMO+OAXbBbRyhe9
 XzIgiPpANWwkThi4Cgw+0rKqOYjHjeipKFEpugkD8czEudQN/cWCJcFvSVVrbbIVCI+aABZfEXA
 7Am4Lxf1RjVZBEH4EU+CDjLtoE1f53IP5abuE79Kd7CzdvUYQNXMnmOWdGVoFC6zOa9UjTdJZIM
 EnRYpSWuFnH2qvbuHnX1BiyQdirVhK6O4TpnjYvTvDjFsmLdxIoXZw3rbh7zQxAMq2RD2ERl+QK
 ksmKtPP7TT8YOTms/wWfyD6LOuOh0=
X-Received: by 2002:a05:690e:d5b:b0:67d:be3c:959b with SMTP id
 956f58d0204a3-67df44405b4mr536803d50.70.1795136665620; Thu, 19 Nov 2026
 17:04:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
 <ae7bc060-5d53-4d55-b006-89ac5fcbada5@freeshell.de>
In-Reply-To: <ae7bc060-5d53-4d55-b006-89ac5fcbada5@freeshell.de>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 19 Nov 2026 19:04:13 -0600
X-Gm-Features: AclHuK-j2vCXgftAUn7DKdOaePjm5ovg574m144RJMlAaGLJaCA2ZMs9vVtg5eU
Message-ID: <CAEev2e9bQedLhXAdSPcr-tUHZVWDP-+6amy8NtgajDZ16mxJwQ@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Disable M-IMSIC and M-APLIC nodes in DT passed
 to next stage in S mode
To: E Shattow <e@freeshell.de>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Troy Mitchell <troy.mitchell@linux.spacemit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E,

On Thu, Nov 19, 2026 at 3:32=E2=80=AFPM E Shattow <e@freeshell.de> wrote:
>
> On 11/19/26 07:47, Anirudh Srinivasan wrote:
> > When U-Boot is running in S mode, the DT passed to the next S mode stag=
e
> > can either be the bundled in DT U-Boot and the previous M mode stage
> > use, or be loaded by U-Boot from some boot media. In the former case,
> > the M mode stage can fix up the DT to disable the M-IMSIC and M-APLIC
> > nodes on an AIA system (for example, OpenSBI does this fixup). These
> > controllers are to be managed by M-mode software, so this is done to
> > prevent S mode software from trying to probe them.
> >
> > This fixup doesn't happen in the latter case because U-Boot loads a
> > fresh DT from boot media. Add a fdt fixup to do this similar to OpenSBI=
.
> > This gets rid of prints like this during linux boots.
> >
> > [    0.000000] riscv-imsic: interrupt-controller@a0000000: no parent ir=
qs available
> > [    0.000000] riscv-imsic: interrupt-controller@a0000000: failed to se=
tup state (error -22)
> > [    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-controlle=
r@a0000000 ((____ptrval____)), parent (____ptrval____)
> >
> > [   10.727605] platform cc000000.interrupt-controller: deferred probe p=
ending: platform: supplier a0000000.interrupt-controller not ready
> >
> > Reviewed-by: E Shattow <e@freeshell.de>
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> > Changes in v3:
> > - Reword commit title to say M-APLIC/M-IMSIC and drop references to M M=
ode to avoid any confusion
> > - Link to v2: https://patch.msgid.link/20261119-mimsic_maplic_fixup-v2-=
1-e29e04bf1b76@oss.tenstorrent.com
> >
> > Changes in v2:
> > - Rename riscv_aia_mmode_aplic_imsic_fixup to riscv_aia_mimsic_maplic_f=
ixup
> > - Drop most references to OpenSBI/Linux in commit message and just use =
M-mode/s-mode software
> > - Link to v1: https://patch.msgid.link/20261118-mimsic_maplic_fixup-v1-=
1-52dea8f39779@oss.tenstorrent.com
> > ---
> >  arch/riscv/lib/fdt_fixup.c | 86 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 86 insertions(+)
> >
> > diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
> > index 6dfd1a2d5b8..49f5b3b5bb6 100644
> > --- a/arch/riscv/lib/fdt_fixup.c
> > +++ b/arch/riscv/lib/fdt_fixup.c
> > @@ -117,6 +117,85 @@ int riscv_board_reserved_mem_fixup(void *fdt)
> >       return 0;
> >  }
> >
> > +/**
> > + * riscv_node_handles_mmode_external_interrupts() - Check if interrupt=
 controller handles M-mode
> > + * external interrupts
> > + * @fdt: Pointer to the device tree
> > + * @offset: Offset of node in DT to check
> > + *
> > + * Return: true if controller handles M-mode external interrupts IRQ_M=
_EXT (11), else false
> > + */
> > +static bool riscv_node_handles_mmode_external_interrupts(void *fdt, in=
t offset)
> > +{
> > +     int i, len;
> > +     const fdt32_t *interrupts_extended =3D fdt_getprop(fdt, offset, "=
interrupts-extended", &len);
> > +
> > +     /*
> > +      * Each entry is <phandle irq>. The phandle points to a riscv,cpu=
-intc
> > +      * node, whose DT binding sets #interrupt-cells =3D <1>, so each =
entry is
> > +      * 2 cells.
> > +      */
> > +     if (!interrupts_extended || !len || len % (2 * sizeof(u32)))
> > +             return false;
> > +     for (i =3D 1; i < len / sizeof(u32); i +=3D 2) {
> > +             if (fdt32_to_cpu(interrupts_extended[i]) =3D=3D IRQ_M_EXT=
)
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +/**
> > + * riscv_aia_mimsic_maplic_fixup() - Disable M-APLIC and M-IMSIC nodes=
 in DT
> > + * @fdt: Pointer to the device tree in which nodes are to be disabled
> > + *
> > + * On RISC-V AIA systems, M-mode software manages the M-APLIC and M-IM=
SIC.
> > + * If S-mode U-Boot loads a device tree from boot media, the DT nodes =
for these
> > + * could still be enabled, so fixup the DT to disable these nodes befo=
re passing
> > + * it to the next S-mode stage.
> > + *
> > + * Return: 0 on success or error otherwise.
> > + */
> > +static int riscv_aia_mimsic_maplic_fixup(void *fdt)
> > +{
> > +     int offset, err;
> > +
> > +     /* Disable M-IMSIC in APLIC-IMSIC configuration */
> > +     fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,imsics") =
{
> > +             if (riscv_node_handles_mmode_external_interrupts(fdt, off=
set)) {
> > +                     err =3D fdt_status_disabled(fdt, offset);
> > +                     if (err < 0)
> > +                             return err;
> > +             }
> > +     }
> > +
> > +     /* Disable M-APLIC in APLIC only configuration */
> > +     fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,aplic") {
> > +             if (riscv_node_handles_mmode_external_interrupts(fdt, off=
set)) {
> > +                     err =3D fdt_status_disabled(fdt, offset);
> > +                     if (err < 0)
> > +                             return err;
> > +             }
> > +     }
> > +
> > +     /* Disable M-APLIC in APLIC-IMSIC configuration */
> > +     fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,aplic") {
> > +             int len, imsic_offset;
> > +             const fdt32_t *msi_parent =3D fdt_getprop(fdt, offset, "m=
si-parent", &len);
> > +
> > +             if (msi_parent && len >=3D sizeof(fdt32_t)) {
> > +                     imsic_offset =3D fdt_node_offset_by_phandle(fdt, =
fdt32_to_cpu(*msi_parent));
> > +                     if (imsic_offset >=3D 0 &&
> > +                         riscv_node_handles_mmode_external_interrupts(=
fdt, imsic_offset)) {
> > +                             err =3D fdt_status_disabled(fdt, offset);
> > +                             if (err < 0)
> > +                                     return err;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  #ifdef CONFIG_OF_BOARD_FIXUP
> >  int board_fix_fdt(void *fdt)
> >  {
> > @@ -165,5 +244,12 @@ int arch_fixup_fdt(void *blob)
> >       if (err < 0)
> >               return err;
> >
> > +     /* Disable M-IMSIC and M-APLIC nodes when we're not in M-mode */
> > +     if (!CONFIG_IS_ENABLED(RISCV_MMODE)) {
> > +             err =3D riscv_aia_mimsic_maplic_fixup(blob);
> > +             if (err < 0)
> > +                     return err;
> > +     }
> > +
> >       return 0;
> >  }
> >
> > ---
> > base-commit: 83b1ec64ede9998566e6a82b22848c20a33f4aff
> > change-id: 20261118-mimsic_maplic_fixup-051bd38d0985
> >
> > Best regards,
> > --
> > Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> >
>
> The code and function call-out comments LGTM, thanks for updating those.
>
> nit: If I am understanding this correctly, then I suggest to drop
> references to "boot media" in the commit description of where DT
> originates from; we simply have the U-Boot control Fdt (in-memory dtb
> with whatever modifications happened before it gets to our present
> state) as it was passed from M-mode or SBI S-mode handoff regardless of
> where it originates from. It exists, and we need to validate in U-Boot
> runtime for uniformity with the current operating mode since U-Boot
> source tree is a likely source of overrides [1] and non-uniformity in
> handoff to S-mode kernels.
>
> From what I understand of reading the code then that commit message
> could be clearer as e.g.:
>
> "Introduce fixup of initial control Fdt in S-mode for the current
> operating mode to disable non-applicable M-mode specific M-IMSIC and
> M-APLIC nodes.
>
> This fixup is evaluated once for the control Fdt passed from the
> previous stage and does not affect any replacement Fdt loaded from boot
> media."
>
> ...unless this does filter again on subsequent actions loading DT from
> boot media, as that's what the present commit message has me confused
> about now. I don't think that it does, from what I understand reading
> the code.
>
> Keep my R-by tag, and up to you to refine the commit message or not as
> you like. I appreciate your help with this as a follow-up to [1]. Thanks!

These U-boot FDT fixups are done just before U-Boot passes the DT to
the next stage (i.e when you run booti and bootefi). The fixup is run
irrespective of where the DT came from. If the OpenSBI supplied DT is
used for booting, it is run on it too and has no effect on it.
