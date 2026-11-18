Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2DC606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q9+ophin;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=bBJ+f6Kv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C387181233;
	Wed, 18 Nov 2026 22:22:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jx6sojZePO-A; Wed, 18 Nov 2026 22:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CFE4E8122A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795040521;
	b=GBIon5PMIru9LpualfEo7Ycsyc9p12YBToDRkjp5/3OYVrEa2/8+CQS/FaEs7LnA3VcC
	 NjV6akVIOwqxXvDQoz7FB/6m/75Rb9QTJ/B4tpKsFA7F9SljQc6+nNaBe/BtcnhPjYUou
	 ifzYt9uVsbnkGbvkeO3EYPXhbf0ILx6BJW84ccD3vM28sfbsQdwrQq0fd/NyN3mZSHe53
	 XEWxb0I4IA1AKW04gGC/fgN879ArN5CdKLd5h9LRsxa3rWqeDTwsKjthMkol5HAwyLL9t
	 mIX55WUXD1ckKvlenpAMMefGpufQROVHSfunRnZ45jHvUaIW4hHPjh6jNBTd6EVNUtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795040521;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9IVlvVcLTTwtXSq//suPwl3hIu2X82EAmUDr4CCqym8=;
	b=E8GlRWsMjZi0GVwpxRAro0QPLgn9+M5q3MLEPoTB1SboZvIfWO8FS6TkCshz/4adiFsz
	 HUzSYZV+LRIO7mF18SsUZc3iI1Jpc6wSH6DS47v8fCDMtysAQ2oMKJWW5VsIjKmeZgege
	 /RtucLshaMVI/98xEJcmd/nge1j9bsdRkMyc7rKCGhv32dKoviQsUDtR57tadYvrWSdeu
	 9LVE4/z//AVJdo0c4+y/mACqTo+kYpUTQRdUjc+V6ep/ARzWS6DCuGBi8faI4giF3pD45
	 IsypWJQBXPbslcsuBLhfT6A1UO/7uwf5KYx9x0vw8QGHyD6NT9NdvrEs0CdjivOCCDg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795040521;
	bh=9IVlvVcLTTwtXSq//suPwl3hIu2X82EAmUDr4CCqym8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q9+ophinB0W4zyZovfm0cmg+e+T6+BPAe5w1KKc1Jzy7eAdmAO6lPArAlx8z9Tuft
	 wH1Qj59/iGljAhvQQk97jxBO3wPfVMyEAjTTYGPomkP9kALNTfN7VbcmN4t5S5yoUp
	 qpNBVgi16qg727eoyHvMhpHcG7VjeoqhgxI4jRkDWD5MnFoHOEuo9JSq3Z8Pl6uN5h
	 jYU/TvrKpncQZpgBrpcm4G9QW2Ukimo6rtcwIF3710cfkV7ECGljx600zZX8oDJt6+
	 3/MF+8vDYFOiRhnjALZy6pC9RTabKBCarWhXpjYPfn09bJKdtzWRPjv8f+nxhX86Ky
	 Su7uPaS2E8jFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFE4E8122A;
	Wed, 18 Nov 2026 22:22:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AFAF19F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95B2860A3C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:21:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6TKaeWS8O0mt for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 22:21:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 266D7606F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=bBJ+f6Kv
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 266D7606F6
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:21:57 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b4e04eda5aso13821627b3.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795040516; x=1795645316;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9IVlvVcLTTwtXSq//suPwl3hIu2X82EAmUDr4CCqym8=;
 b=bBJ+f6KvwDW6Zd3a8fmJI7g9FcCiNViLe+9Q1HCbXx1iS3LathWQHR9U7Yc8k4PWH1
 p1xfXLJLpbSTpgL7YAHxCq8uRIvABTX0mGbvqjaSVlee9ETml1xtmEZI53xRvWR1IT3u
 QTeHk+hBBv5yn1yQJndvK6D4Il4UZ/lZK8SygXRl1YJ+qH3O6ND78WmzMfgpNe8f+0yl
 5ixYUe7KSuTlUYKOq4u7IKi/IOFy60FE1n4230NJwd5jIDS/DJkwCov2CrR3OBWol9rn
 1YZlAJ9Ratt5ameKQBdesqSzmQGB6RCD6rB1i9jUt1/N1bQeodsftq10+zNRx/mL+gdl
 qgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795040516; x=1795645316;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9IVlvVcLTTwtXSq//suPwl3hIu2X82EAmUDr4CCqym8=;
 b=m2yrz0+f3hfHLjQTPo2qdsjvdur75N7WBIdNTVhUNW3K7gYtQxYPe1HPhmpRQAimFh
 HL3P7g6fh2v0jTOlm5mQByEXpVvFPozd8Apy1Wk9IN4a/a50WBiPYQ9NGVmCIwJHnfTc
 5uYwqlJ8mpkWSaY2UKAsWN7TQnvhkqcKgVzAGekSKVdotQ0zSqXh4MG+gc7OPbsqx4be
 NjCFSGEuXl8GmMYYLtC/Lfk8pBcpA0N+q1eu5b+etxlzqcMgWe41T8dZ/fPqsGF1rvXe
 gInvtPl3/ahVg8mN3p4fJbOUj2kaxQdkOrUPAwyLce1wuSmhpyTPM3QdouRtG4/0tMI7
 ESvA==
X-Forwarded-Encrypted: i=1;
 AL+hErGePRS2D9EF9KjHLiG6etNhQhuJbQnKy3mH3rzjayFeVEXahGw1cPrNk3dk+e5E/9qhAO5aEOU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+v+KLaPut5LxxLy5JpQmaMNuBy/4yvYTEk+aD3TiomRYtk5VDe
 FqsUE1dKBSqkbjY7J/UJlULhgOvaFCBQN5E0elKni8iKpBqbc4jMbPqqY/aa3B6C1J4sy1+leo/
 y2TKVOVf8kRYLukrRXBuNUTwHk1P7SIASjHCLEGeQHLwXOu1ZH22Ileo=
X-Gm-Gg: AZFdTZfy07hp7iUHWUtNuNTJNUtkgkxVg8EnzlZdcUAwlu3/zurIm2sF4QvbhGM3U6o
 PoaBOrB6AZXbnWVbLta0E/2D9S+Pmj9wx5q1kLayt4uOc+JXt+cVlgDtqGHcO7W+9lpR/Y4RJpW
 /UW9j69DTUUOXJvKU5DlBqTdwKDa5M7rz6CYYfRg2KIgMPZyebVA1C6rohNQUkPIuZ1pWUmXkwg
 i4IXPWVPITkiiWm3x49VEQMTzVzs+MTNKpn9JybD/vuvS2x4SDalqoD9hN4mq8EUedMEYFhfPIN
 kt31wCLhvKFQyWUUqIdBFbaNGw5VUnIdvmre3z/yvzpv9xM9lOU5GQ63SnOhHMLErAZNECCmkPP
 DF/UmDdrAdFCkotLpfyvvwEhxPtzFBWknijxJe7xHk7oKYIAsNmwm//bu4PVRfkc9I4HLhfArXX
 8Bdwvd9MpQbCeeqHnzf9ggKDPhbw==
X-Received: by 2002:a05:690e:438d:b0:67b:fe7e:3785 with SMTP id
 956f58d0204a3-67dd3fc7231mr1353290d50.88.1795040516521; Wed, 18 Nov 2026
 14:21:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118-mimsic_maplic_fixup-v1-1-52dea8f39779@oss.tenstorrent.com>
 <f5e87e76-ea5e-4dc2-9b28-4f9eadcfbf5d@freeshell.de>
In-Reply-To: <f5e87e76-ea5e-4dc2-9b28-4f9eadcfbf5d@freeshell.de>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 18 Nov 2026 16:21:45 -0600
X-Gm-Features: AclHuK_6_tiXXxseHWQ5QuU2BFa80hFq8r06sPZzljK6gVFiwUafcRkNAHNRvG4
Message-ID: <CAEev2e9MeszAmxyyjbgyfMtG_Bt=Bc98O67jz9esNa--n5Tqww@mail.gmail.com>
Subject: Re: [PATCH] riscv: Disable M-mode IMSIC and APLIC nodes in DT passed
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E,

On Wed, Nov 18, 2026 at 3:05=E2=80=AFPM E Shattow <e@freeshell.de> wrote:
>
> Hi Anirudh,
>
> On 11/18/26 10:00, Anirudh Srinivasan wrote:
> > When U-Boot is running in S mode and is used to boot linux, the DT pass=
ed
> > to linux can either be the bundled in DT U-Boot and OpenSBI use, or be
> > loaded by U-Boot from some boot media. In the former case, OpenSBI fixe=
s
> > up the DT to disable the M-mode IMSIC and APLIC nodes on an AIA system.
> > These controllers are to be managed by M-mode software, so this is done
> > to prevent linux from trying to probe them.
> >
> > This fixup doesn't happen in the latter case because U-Boot loads a
> > fresh DT from boot media. Add a fdt fixup to do this similar to OpenSBI=
.
> > This gets rid of prints like this during linux boots.
> >
>
> I think it is not necessary to mention specific software (U-Boot or
> OpenSBI) in the lede paragraph of the commit message. That description
> of Linux is a testing scenario (which is fine to also mention, in
> secondary paragraph(s), or just omit from the commit mesage and leave it
> to mailing list replies for cover letter and T-by tags). It would apply
> equally to any S-mode kernel including U-Boot main app itself being
> S-mode, GRUB EFI, *BSD, etc.
>
> Essentially we accept that for RISC-V there is other third-party
> software which may integrate with U-Boot and we cannot know the
> consistency of device tree state in this context, even when we have
> provided some of these modifications in the form of device tree
> overrides to that software. It makes good sense to do some fixup in
> these likely situations. The important thing I'm reading for in this
> description is, "what is it about the RISC-V platform M-mode / S-mode in
> U-Boot that requires consistency checks of device tree properties at
> runtime?"

Yes, I'll drop references to OpenSBI/Linux and just say M-mode and
S-mode software.

>
> Are these the only consistency checks that we foresee?

These are the same as what OpenSBI does (maplic and mimsic).

>
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
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> >  arch/riscv/lib/fdt_fixup.c | 84 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 84 insertions(+)
> >
> > diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
> > index 6dfd1a2d5b8..ce8c18a7b92 100644
> > --- a/arch/riscv/lib/fdt_fixup.c
> > +++ b/arch/riscv/lib/fdt_fixup.c
> > @@ -117,6 +117,80 @@ int riscv_board_reserved_mem_fixup(void *fdt)
> >       return 0;
> >  }
> >
>
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
> > +     const fdt32_t *interrupts_extended =3D
> > +             fdt_getprop(fdt, offset, "interrupts-extended", &len);
> > +     if (!interrupts_extended || !len || len % (2 * sizeof(u32)))
> > +             return false;
> > +     for (i =3D 1; i < len / sizeof(u32); i +=3D 2) {
>
> Read the size-cells property, or comment why this is assumed to be
> size-cells=3D<2> (and what happens on non-64-bit platform if this is
> applicable or not).

We aren't reading a reg cell here. The 32/64 bit discrepancy comes
here only then. interrupts-extended is always 2 u32s per hart, for
both 32 and 64 bit systems.

>
> > +             if (fdt32_to_cpu(interrupts_extended[i]) =3D=3D IRQ_M_EXT=
)
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +/**
> > + * riscv_aia_mmode_imsic_aplic_fixup() - Disable M-mode APLIC and IMSI=
C nodes in DT
> > + * @fdt: Pointer to the device tree in which nodes are to be disabled
> > + *
> > + * On RISC-V AIA systems, M-mode software manages the M-mode APLIC and=
 IMSIC.
> > + * If S-mode U-Boot loads a device tree from boot media, the DT nodes =
for these
> > + * could still be enabled, so fixup the DT to disable these nodes befo=
re passing
> > + * it to the next S-mode stage.
> > + *
> > + * Return: 0 on success or error otherwise.
> > + */
> > +static int riscv_aia_mmode_imsic_aplic_fixup(void *fdt)
> > +{
>
> Critically this fixup routine does not *enable* the nodes *for* M-mode.
> I cannot think of a better name for it than you have here, however.
>
> Is this not an S-mode fixup routine?
>
> Maybe... "riscv_aia_exit_mmode_imsic_aplic_fixup"

How about "riscv_aia_mimsic_maplic_fixup"? It clearly states which
nodes are being fixed up.

>
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
> > @@ -165,5 +239,15 @@ int arch_fixup_fdt(void *blob)
> >       if (err < 0)
> >               return err;
> >
>
> > +     /*
> > +      * Disable M-mode APLIC and IMSIC nodes in DT passed
> > +      * to next stage if we're in S mode
> > +      */
> > +     if (!CONFIG_IS_ENABLED(RISCV_MMODE)) {
> > +             err =3D riscv_aia_mmode_imsic_aplic_fixup(blob);
>
> This could be clearer to say "When not in M-mode then disable M-mode
> APLIC and IMSIC nodes"
>
> The subroutine name is already very descriptive but this comment would
> be fully redundant if the function name is clearer about its
> functionality, and would not need a comment. (See previous suggestion
> about function name).

I'll use M-APLIC and M-IMSIC so there is no confusion about s-mode/m-mode.

>
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
> Overall looks good to me, I want to know why we're not reading the
> size-cells, and then refine the descriptions to be clearer about what I
> am looking at in front of me so that a function name does not need a
> comment to explain what it is doing.
>
> It is a level of technical detail I am not familiar with, so if you can
> make it make sense to me then it will be clear for everyone.
>
> Thanks,
>
> -E
