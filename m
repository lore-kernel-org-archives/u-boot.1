Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C0606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q1+tzTAl;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=T1gIcWzX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2D4D6071D;
	Fri, 20 Nov 2026 17:24:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXg0Ucju8zcq; Fri, 20 Nov 2026 17:24:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 780A16062B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795195466;
	b=qTmR9jwBPmyb+CSGezeNWbhGAxJ13ledq5atEK3HNiuKnPPnR/bwbCWAw61a9dGk2p5E
	 Dx1HnBwBI3VHNACD0g7DBxfUjRamOBV0cb+QRyxn7N2l3hje2zctCKvcsCjapeDPWBX6j
	 vUbXUnMEjZGADgk8WHwMfza2Pi9lzq8sm9ZyGsdI+6poem+2JaawNn2d/ErXaRUXKQQTg
	 EDGDcHyySxDvpUUTJ1DmMNmKQPOUFRKhldwbuckS/RUxtm083n3Vu4kw6/TolWFjTCIr3
	 mijEUwEo2js+GyBhnm4/1y0YRDnuCO3ZkrS8rEGqVDEyhOBxFMIfu8swxLXGACkU5lA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795195466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rOm28YMFt2Bz4doWB7aZu3HZ7orrzkhMg06kw4X43aA=;
	b=kKOzmWGBQO5BD4uaPXUDqmykHUgXfulBwXj1Md3YTRLnTJg8UevEqgQVKuKm9rrBpTCC
	 cYlKFRgO1Uwvxvq64igjUMRosEHqQg/uHh0Zwjyba5qXqt2VF7wQ795X8joifarA2mNuI
	 rO4UL3ygJbUHG2o77xe1Ztx6d9SueM4ujIvreV0nEWw41AwNzsuJzqg4WjT5kN70NZQww
	 uYTTUx/3lJXagkPmKAPIh++nioBKV4PR58qaliJ8eWD3EMLPHsCUSKBOSR10RZ8sXy1yH
	 NEPrToOmgtiEGt8GKm9L583OBKey/uBESBG+u2VBETRrNX0qMLbC2TtEAp57pcfKV+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795195466;
	bh=rOm28YMFt2Bz4doWB7aZu3HZ7orrzkhMg06kw4X43aA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q1+tzTAlOz7LnWYY/tODF2gG0iu619+zAg01kfEmd9eux0k+gCFPk6lYlPClLpoS5
	 5h+YRX33IGduE014fWbmt8IqvUzSKNBUq1NxgJeWiP667CMy2w+JwJHOOqGpc+tLBz
	 NXqX4cQGLLpboULOXSMLbWc05U/IVy87t1t3TYCyNfzE92rNYQuLgwsd6omgWhKgWI
	 nGaZb28uHRF/Nn8SthED1xmYPfDQou1FYLQq2SnFLbVrlfqpkBcs8OmCqaDAwGOe53
	 NOZUzKvQvXxBrttqixGSav+bUHUmUu+VCuYqD5yg1FzclbvQKl9p3FbdNAcbEY4mvV
	 Dlc6dS7nbsjAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 780A16062B;
	Fri, 20 Nov 2026 17:24:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B43B170B
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 17:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A7DD40778
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 17:24:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TWMQO-QTbRNy for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 17:24:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FCBE405CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=T1gIcWzX
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FCBE405CB
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 17:24:22 +0000 (UTC)
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-67be4f2f4d4so1428537d50.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795195461; x=1795800261;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rOm28YMFt2Bz4doWB7aZu3HZ7orrzkhMg06kw4X43aA=;
 b=T1gIcWzX0nxdouPP4408u6+CgJZAoO246XVrVUGFi1n/ftOqb3KZrfXgpDDQt21vpt
 WTMvjLQrsHqcWtpxNq/RHyV2PkDiXiCBtM0JIOsrUp8dLb87dCaZpA+frv/FmeK2eSTQ
 Coo58PEgNEQTOgeY0ayC84pbRkdrbtcKJRbPNrN7P0dNlrmd8ZGJOgDk+ek5tQzk8d7U
 fFaWDZ43JsuEgS1efi7ZLMTcJWBKmCs4YB4kSKlUe7pra6NNIzsSvJmquhzHxma/qUa6
 KzmmrCtn66AT9b3MlHRpwT3cAd3wzZ43+z233M8IYnedoaJUQ9Ar4I3IZCV5vEVwz7YF
 2a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195461; x=1795800261;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rOm28YMFt2Bz4doWB7aZu3HZ7orrzkhMg06kw4X43aA=;
 b=VjI8P+Uc1kAdHHv1B/JuoB/fsLUBC5DAomKYr/N6mDR/tsz0c0y3+g9BJKYqQRNasR
 /bUSwvl2yoPuGtrW+U97L1cK13W0YOXviS++xfPJvYxviYiSUWy64sERXBn9+aN0G6JC
 hEx3ChlDXrLRC9bGJTILd5tEKXnnYEJ0Zy5IdcBAaWGSKTSi6t0m9cAzRgIhRHxE+05E
 UYf2IqdgTqx6fa4odgduQeBQ4dodW6QX9Z7HTMKMy/qWMJDZQm3RmCYd20+TaZNG6tDU
 CrxctiBzEHKQMjbrdT4/eaAmV3m0OiaD+o1reh9qnjJknZe0AvaKylKpAjbcvZsBtpOa
 zQGQ==
X-Gm-Message-State: APuU4Z9LHBCZCRp85RkZE/YHftIJBp3xkHB7R/pXbPpwJXv5PlLJJNpq
 clzboCmI3lcs1nI3k76xVzGpThHg4S61WFNtkPLG08sXp8HUz6pBOmTqka9/Yiy0AfeO7w950eX
 ycu+o86XS2hiq7AWvi8k8AjmigBHV8Rq07cA0u4zY7g==
X-Gm-Gg: AZFdTZcsJtX2xoolon+Y2vJEUos14h66N8eq5ZSGsJcQ1O/N932pbp04KT3B6vK4UDP
 2fD2QSX4RiIqlxvzHRMak+c+dCKyBbnMWq7q0Q7fb5wIO5AY13JapaAfzWersGK8c9pid5+2Qia
 gMDvGdslxSm1sfqtHIyia1SZyswhg/wLHAjWktO/ssm8lhNJvTUsw3M8gekklnTb+YKGstj/Fk6
 LT/90xTH4WZuA3wbtA5r8yRtdJVd00ESZ1jDTL/F6ixIp/eX2PbkXYthpRUDzDWGNPU6KjiJ19+
 7SCjBBoTymPc9svyik6lXNR3LclFiCp4H8P+OLKtDESWGSoCYnEqp4AI9K2X6X5JatqnQwV9p1u
 cc0yBlUu8xt+DPZzszWNGRiYuxpmZfwElzMlw87oRHIAU6yMKfV2f/aFEk+GHYEULps6FJOc8xS
 Cto83HarOfYQxLBWOiDZpRzuB87RE88Um34tuyofKchCGt7Q==
X-Received: by 2002:a05:690e:190a:b0:679:91c8:8366 with SMTP id
 956f58d0204a3-67df450e15cmr1527937d50.108.1795195461429; Fri, 20 Nov 2026
 09:24:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
 <awAlGMMg-6tcb1N7@pie>
 <CAEev2e9SdqXvipxXGXFjLqe77RA=LsbGSY8AFnL9VbbYAC0ZJQ@mail.gmail.com>
 <awB-PvfuEDIu_t0l@pie>
In-Reply-To: <awB-PvfuEDIu_t0l@pie>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Fri, 20 Nov 2026 11:24:10 -0600
X-Gm-Features: AclHuK_g0zVtKqzKVcnV2nJPm7tj7SlGvTl4tsZV1k2eATENEIPrkdvvDgUKtrY
Message-ID: <CAEev2e-SFv-CLxBYZ6CfPPs__BggKc3AsH5PnhNF9uXo_FccXQ@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Disable M-IMSIC and M-APLIC nodes in DT passed
 to next stage in S mode
To: Yao Zi <me@ziyao.cc>, Anup Patel <anup@brainfault.org>
Cc: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
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

Hi Yao,

+Anup to this thread

On Fri, Nov 20, 2026 at 11:07=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
>
> On Fri, Nov 20, 2026 at 10:09:49AM -0600, Anirudh Srinivasan wrote:
> > Hi Yao,
> >
> > On Fri, Nov 20, 2026 at 4:47=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
> > >
> > > On Thu, Nov 19, 2026 at 09:47:07AM -0600, Anirudh Srinivasan wrote:
> > > > When U-Boot is running in S mode, the DT passed to the next S mode =
stage
> > > > can either be the bundled in DT U-Boot and the previous M mode stag=
e
> > > > use, or be loaded by U-Boot from some boot media. In the former cas=
e,
> > > > the M mode stage can fix up the DT to disable the M-IMSIC and M-APL=
IC
> > > > nodes on an AIA system (for example, OpenSBI does this fixup). Thes=
e
> > > > controllers are to be managed by M-mode software, so this is done t=
o
> > > > prevent S mode software from trying to probe them.
> > > >
> > > > This fixup doesn't happen in the latter case because U-Boot loads a
> > > > fresh DT from boot media. Add a fdt fixup to do this similar to Ope=
nSBI.
> > > > This gets rid of prints like this during linux boots.
> > > >
> > > > [    0.000000] riscv-imsic: interrupt-controller@a0000000: no paren=
t irqs available
> > > > [    0.000000] riscv-imsic: interrupt-controller@a0000000: failed t=
o setup state (error -22)
> > > > [    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-contr=
oller@a0000000 ((____ptrval____)), parent (____ptrval____)
> > > >
> > > > [   10.727605] platform cc000000.interrupt-controller: deferred pro=
be pending: platform: supplier a0000000.interrupt-controller not ready
> > > >
> > > > Reviewed-by: E Shattow <e@freeshell.de>
> > > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > > > ---
> > > > Changes in v3:
> > > > - Reword commit title to say M-APLIC/M-IMSIC and drop references to=
 M Mode to avoid any confusion
> > > > - Link to v2: https://patch.msgid.link/20261119-mimsic_maplic_fixup=
-v2-1-e29e04bf1b76@oss.tenstorrent.com
> > > >
> > > > Changes in v2:
> > > > - Rename riscv_aia_mmode_aplic_imsic_fixup to riscv_aia_mimsic_mapl=
ic_fixup
> > > > - Drop most references to OpenSBI/Linux in commit message and just =
use M-mode/s-mode software
> > > > - Link to v1: https://patch.msgid.link/20261118-mimsic_maplic_fixup=
-v1-1-52dea8f39779@oss.tenstorrent.com
> > > > ---
> > > >  arch/riscv/lib/fdt_fixup.c | 86 ++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  1 file changed, 86 insertions(+)
>
> ...
>
> > > > + * riscv_aia_mimsic_maplic_fixup() - Disable M-APLIC and M-IMSIC n=
odes in DT
> > > > + * @fdt: Pointer to the device tree in which nodes are to be disab=
led
> > > > + *
> > > > + * On RISC-V AIA systems, M-mode software manages the M-APLIC and =
M-IMSIC.
> > > > + * If S-mode U-Boot loads a device tree from boot media, the DT no=
des for these
> > > > + * could still be enabled, so fixup the DT to disable these nodes =
before passing
> > > > + * it to the next S-mode stage.
> > > > + *
> > > > + * Return: 0 on success or error otherwise.
> > > > + */
> > > > +static int riscv_aia_mimsic_maplic_fixup(void *fdt)
> > > > +{
> > > > +     int offset, err;
> > > > +
> > > > +     /* Disable M-IMSIC in APLIC-IMSIC configuration */
> > > > +     fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,imsic=
s") {
> > > > +             if (riscv_node_handles_mmode_external_interrupts(fdt,=
 offset)) {
> > > > +                     err =3D fdt_status_disabled(fdt, offset);
> > >
> > > Should we use "reserved" instead of "disabled"? Quoting the devicetre=
e
> > > specification,
> > >
> > > > "disabled"
> > > >       Indicates that the device is not presently operational, but i=
t
> > > >       might become operational in the future (for example, somethin=
g
> > > >       is not plugged in, or switched off).
> > > >
> > > > "reserved"
> > > >       Indicates that the device is operational, but should not be
> > > >       used. Typically this is used for devices that are controlled =
by
> > > >       another software component, such as platform firmware.
> > >
> > > Another possible problem is that these loops overrides the status
> > > unconditionally, turning already "reserved" devices into "disabled".
> >
> > I don't think we should be using reserved here. OpenSBI sets the node
> > to disabled, so we should be doing the same thing.
> >
> > I'll add a check to see if the node is enabled and disable it only then=
.
>
> I think this is probably an OpenSBI defect, please try raising this to
> OpenSBI upstream.

Hello Anup, I've added you to this thread as you had added the code to
OpenSBI that marks M-APLIC and M-IMSIC nodes as disabled. This current
patch does the same for a DT that U-boot loads from boot media (hence
is missing the fixup OpenSBI does) and passes to linux.

Do think these nodes should be marked as "reserved" instead? It seems
that "reserved" is to be used for devices controlled by different a sw
component, which seems to line up with what's happening here.

Please let me know what you think.

>
> [...]
>
> > Thanks for your comments. I'll address the style issues.
> >
> > >
> > > --
> > > Thanks,
> > > Yao Zi
> > >
> > > Meow-mrrp-mrow, I'm a cat.
>
> --
> Thanks,
> Yao Zi
>
> Meow-mrrp-mrow, I'm a cat.
