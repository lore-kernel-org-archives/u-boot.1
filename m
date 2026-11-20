Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D752606A339
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PpgQznae;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=bcI8Nqot
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F86C6064A;
	Fri, 20 Nov 2026 16:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qut6cQtzF8dP; Fri, 20 Nov 2026 16:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38F4E60671
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795191006;
	b=fAz94UF3Em0fLc3XH7WvpUruZEcC0Jpbdx3QJ0jvTSTXg4Ags+llGbSXiIj/RH10o2bQ
	 OMmeHCy+lXraHEYUiAyGepk9ZZxzwyXl5DojT0hk5//krqwZg1fdfm+DbUqEaFWmhorKV
	 96fu8iHxc+yLZEaTN/v3P3mLx38tz1OVPc+g5JaW/Njr5Cqv8ek8zdDdjWOrMIP0BSYS+
	 pawZ4QynZijtMF0MvZa0v2u1QqoGFJjtdu2wDfqug914b45ncgEwBi6VJD/H0kG9NzzH7
	 e6YeZiyoo1K/TfRl/VUQJ2dCwPICvc283Dv23Q+GNGql23mU/XOWh2nw1G9eAbEaFsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795191006;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rEycDfJyZWZ4/ssB+DaIlhQ7XGS5bzbjY3t+vHlQi74=;
	b=BJjl584KaX8hu5PONRYGgI9V34uHjORHZPEp+AM+yra0ppfEwzY8RFygXQpk2lRf0qGU
	 ubMIvJo9YW9cD0aXku6n889rSKzp9429QoiZ5h+2aeAIgZhHlajJ1qnC8kJqa7CSU90JV
	 V41F8199YBYJZUZqadO3QM0QojkSexIH7WfzbR4nmNUtP9QPShGo06mYnQmMTYOWcNYRk
	 Nk0UdrmeJ7nC76+ME0c83ByY63w9zWY3RxBSpMsFcd88w7Hq1fd6HeCNch1yklajBSbXu
	 JWsjzAGZ/MX4fMqCk5XMkxf0ZDjnm79C/Sw2jklvgOAYMYjwEUzLFCdEIOWoqEhH7fA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795191006;
	bh=rEycDfJyZWZ4/ssB+DaIlhQ7XGS5bzbjY3t+vHlQi74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PpgQznaeqUAA7VYQ7QiM8OJDnZaqsNEd4v1fUDONnkR47Zk/2VyqnmGeSUzaGDTj5
	 gBd7l/pTqams7p1qjB2diZMXVD6+1cJ5G7bvJjtOCq/knlSZflS5IhgYjYNFPrUaDu
	 fyAJTfEI4Vm600fhCt2hsH+ZJaBtLq/rTfeOwEW1M3zhprUZpHFtucRlFjMlQ2qI+9
	 68uVqW5YRI0wQV9owPQzD1XcTR1a3LmiO0zoRpzbXMQyoZWbZ28pjiYFSj/dGSTd9v
	 9Z13H61s9hbvqw8UIx94V0HAJ1sZ3siXNCLL+LtNp6Z9hXpDHX4I6LIPrQ9Ggy/JgF
	 X+ueD8thMP+vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38F4E60671;
	Fri, 20 Nov 2026 16:10:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D70E1E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:10:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EC8B40098
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:10:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OY7LqDHpav-m for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:10:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8D10540050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=bcI8Nqot
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D10540050
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:10:02 +0000 (UTC)
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-67921b515a7so1262859d50.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795191001; x=1795795801;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rEycDfJyZWZ4/ssB+DaIlhQ7XGS5bzbjY3t+vHlQi74=;
 b=bcI8NqotG5UamILBrd84lNjD4tj7rq/ATa3nG4cmBb2BXtRdhvxAFOOxXnsIawF16r
 Hl+LoTLvk1hWk3Mdk4sEVsdlfnbm+ocGHPwCM6XTH2o08+KsmyZtl0Vfx7E4z55cDcYu
 hB5OIfLqNgyop5XrmJrHAMMb+YxSAfgP95JEJG4/eLuQf+OKLD7BGQzF880q70xZmpWB
 EyfRzQWbDhkK49ZnvE6avI19VQRXzPHvjnK+GkVWHEGK/eQieUDu6z+BtM8Z64uS3zqd
 y5O8Zo8eOp/lVkwYvtlJ5j9Jkb7mwJwdxtw5TLx8FhOuuGks4dgzI+PG5be6RnUOgMWK
 P8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795191001; x=1795795801;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rEycDfJyZWZ4/ssB+DaIlhQ7XGS5bzbjY3t+vHlQi74=;
 b=08vDY5x90R8Rv13G25Pt5n9g2nrwCQEGg6jlNKySAttItBDGmyC5q7ioUxv984XV/R
 C+Md3GQIw1guv3O2mk4YnAsrH8BM0ASeI/65aCZMnt56edLf9LH+zgLTk3XJdbyM2kAV
 mfQnZ8RYIH7XOqi1nNz7pAxKmQJtr+0g8wY5f3r9sNmpnxbrv5DXQoqzX1tUhcAdC/Hg
 lD50bwhOF/b/sHyCuja8Lun8w/9hQhNab1MA0iK7QXdhNzHdvtmiYjAfjFyA0mbsw9JB
 GWETlDIYT24rBvp3OrTwFAxB5Py48Jj4eNg23hY4qGiK+RFlMWujPFQak8MtliHPfo24
 7mwg==
X-Gm-Message-State: APuU4Z8BP57xf68kFAINTnyL86QLEK3CQLhNjp5ceX1sI267OY/J/XCn
 C5uJFzCsEN+O+G38zfejM53apRzTBGpKM2WJsacqfvxfkEUzuOrk72mCIB1QOb+m2ZJHxxkocuT
 RHKSN8BZzcXba1rAH1tqsU3i9N+/HBIUklemEV43fTVh7DW0rsXiIauOWSA==
X-Gm-Gg: AZFdTZejefklSzx4COR16+ZK8Z10sH8VMGqXbmk7gpZCZ49h7e4nbjtozurf6Yctc2q
 jJ63aYJZoHpn/sUPg0UYrnQxAMlzQD/o8cqrv3gZpSWVkVPibxtAdfFwaO+ehXnbVPWEzxZnnfE
 sZhJHIzbM544x7f0BBBe8+FGcnt1YjWruFZ01Wv/rXJgUILhKDuyjk3ZoRyw5cH+a/WUwYsaI11
 JMgabKgw1Ee10RKKsOGE+6hj+sT4YpXpgysboHPbgYr1BKQ87Sgn8f8gsHaG/kKIN3ZIB89oFnA
 I8xGtW306bIxivGWhLyZU4AcdRAT/2Jm48sPAeZNaa1F4X3hDkI9U2JTxK+6ycRp3LZD2+gDIWJ
 iZSiVPc8RbThRuAxtJpF4CvgYpK3SMad6Tv+ZMxKKnYVueMYvTZmn8KW2sf697K5yxgTf9MB8JD
 gOHxOAUg1duN6DWRjLJC676U2yOd7Z4xs09zrbTP6MdrrhMg==
X-Received: by 2002:a05:690e:4852:10b0:67c:664a:9006 with SMTP id
 956f58d0204a3-67df442350bmr1154779d50.64.1795191000966; Fri, 20 Nov 2026
 08:10:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
 <awAlGMMg-6tcb1N7@pie>
In-Reply-To: <awAlGMMg-6tcb1N7@pie>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Fri, 20 Nov 2026 10:09:49 -0600
X-Gm-Features: Aa3M54ozpmh9xHesf86XFizfHfmJO07Am2mxL4H6k3mbOnw2Zi3d0EW1FOcgEa8
Message-ID: <CAEev2e9SdqXvipxXGXFjLqe77RA=LsbGSY8AFnL9VbbYAC0ZJQ@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Disable M-IMSIC and M-APLIC nodes in DT passed
 to next stage in S mode
To: Yao Zi <me@ziyao.cc>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yao,

On Fri, Nov 20, 2026 at 4:47=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
>
> On Thu, Nov 19, 2026 at 09:47:07AM -0600, Anirudh Srinivasan wrote:
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
>
> Please add a blank line after this if for readability.
>
> Isn't the !len check here redundant? With len =3D 0, the loop would never
> execute. I'm not sure whether it's better to remove it or not since it
> might make the purpose more clear. It depends on you.
>
> > +     for (i =3D 1; i < len / sizeof(u32); i +=3D 2) {
> > +             if (fdt32_to_cpu(interrupts_extended[i]) =3D=3D IRQ_M_EXT=
)
> > +                     return true;
> > +     }
>
> Please and another blank line after this loop.
>
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
>
> Should we use "reserved" instead of "disabled"? Quoting the devicetree
> specification,
>
> > "disabled"
> >       Indicates that the device is not presently operational, but it
> >       might become operational in the future (for example, something
> >       is not plugged in, or switched off).
> >
> > "reserved"
> >       Indicates that the device is operational, but should not be
> >       used. Typically this is used for devices that are controlled by
> >       another software component, such as platform firmware.
>
> Another possible problem is that these loops overrides the status
> unconditionally, turning already "reserved" devices into "disabled".

I don't think we should be using reserved here. OpenSBI sets the node
to disabled, so we should be doing the same thing.

I'll add a check to see if the node is enabled and disable it only then.

>
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
>
> It should be possible for an APLIC to deliver interrupts to both the HART
> and the IMSIC, and this branch seems to disable such an IMSIC, too.
> Please update the comment.

I'll move this disable block to the end. Then I think this comment
will be correct.

The APLIC that support both MSIs and Wired interrupts case would be
covered by the block below this (which would now run before this
block).

>
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

Thanks for your comments. I'll address the style issues.

>
> --
> Thanks,
> Yao Zi
>
> Meow-mrrp-mrow, I'm a cat.
