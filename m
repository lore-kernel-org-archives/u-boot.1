Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF7606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bwy/mv83;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=f6lfKbmm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C43B80CAF;
	Wed, 25 Nov 2026 15:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4OJUfzXl9sb; Wed, 25 Nov 2026 15:17:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 619A380BF0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795619879;
	b=g8TVg3zn4Ty7fJp/90d643BCgf66mmvbQypmrzuqHdrbcEw/1HAUVHkulfyGsBYeZ64o
	 Ga8dwlPzzi+wOVrxI9BlTDolAKZZ6v2L1QdIyp1qBfJ7b9wsO+15hbQR3o0hu/MmqaSL8
	 QfEwLO3V4Wpj3XwQruBCMVRhOQP8vSpEG0rBcuso5HkAKrh8ySr+e0aRK2JBkE4pAdfQ4
	 8MtC+d83Au58ELb37u7vTgdxEKG6aKlN+W7MoExsXnn7SI0kM9PY+eBN0E1IF6/RVh/m9
	 RlkgwiMWxa24A+SUQsZHO7tmY8TA6HFI9ubXc3yvunX47jrW5lmvi7/Mo8nzhxtm2Ug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795619879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tvilLuS4AzZRHXFu6N1I5eSa2/5qqjWBVLsKHElBvHc=;
	b=Mda8wO8+8EB/scbBXq6QIWLQ9V/Du/uUO5Nd5Se7EBQ75KoLtdJIxkt3MlxcM/GkfqDq
	 1PzEheewhSEJBpD+3C6gb/4MJk6DbLXDRGEjhbjorC1jhzdFev/7Z9oR9sh06dVWcIe9P
	 12Gl7i89frajFzx74gYJpy1dx0kFTtVMefCv/eIAv5Ejkr7+DH57GaSQJ2bkoLWLKmS5F
	 GlR3t7eN0YpWwPdhXFPxdvzYX1o+YezJNDk+SF5zO8WVqWslH3FZ18b29dWARAXZnVu9v
	 j4KR31dhW0yE+AOoHX31kHGa7Bf7I4FdNNZ/vcqE5eJg9XM+n8azVqT1A+mrxnyjtww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=f6lfKbmm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795619879;
	bh=tvilLuS4AzZRHXFu6N1I5eSa2/5qqjWBVLsKHElBvHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bwy/mv83dlgPBKIFzizihJCQuKRBn7GU6DU93NXgf0spfuG2VJ4+61PBcCUEkmhSq
	 HfMFLgxfJSORn6TLtcY2yYJWydr8gzSuw6yvp0YXnPloZAX/JcDbrgKU869oKPzSpc
	 7u+zpAgm9rI2Ua47toZFwExwDWSXXJxoJsFcW5nofGztRS1tPSGhtvnffcqp3ic36F
	 ob6sGYe/5g1pbx+4fZeeP9GjoIr2BtTB+Y+0ixyMsdlChX3CAMbjMdi6fHFIZv/bkO
	 pEUxr9mUtiMh7fZUGV3IoQw8ecriQTrHAXXnJwJVY/8H7NqF7dnKJxZp3egnuCT78r
	 cMu+vN+pEHFWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 619A380BF0;
	Wed, 25 Nov 2026 15:17:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F03C032D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1E2180BF0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9uwsAbtSLsC5 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 15:17:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DAA980A6D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::135"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com;
 envelope-from=anup@brainfault.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=brainfault.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brainfault.org header.i=@brainfault.org
 header.a=rsa-sha256 header.s=google header.b=f6lfKbmm
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DAA980A6D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:17:55 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5c1479a959aso4410388e87.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault.org; s=google; t=1795619873; x=1796224673;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tvilLuS4AzZRHXFu6N1I5eSa2/5qqjWBVLsKHElBvHc=;
 b=f6lfKbmm2b2QRe4znRVC87LKxbt2SataWcDuPenPasGd6QUZtaj9BdFYDvNj/qaZ4t
 glKDgWIPqEPlQZ9xA7oIY3jqKBr/IsHHOCvtJjb6/zNpT7LfM6jM8QSgDgIl7X9IFrpI
 wS83ZMskgPVE7vf+vWHbeotV0xZYghGljGlMlqCqS+MMT6tIdZ5YxkycDtRfGDOJpQL5
 jhC50nwEAaSVOinxFH8G80KqOEScBGQd1jPBP7h/yUKdq4y7jN5Ejo8K2MLIK4tTja75
 ENjVkrY9VJ4a+wFmxB5yjJyY4bULKsWSseZ1c18kaArvzhc753tE34Q+e1Rduqv7E1lp
 9FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795619873; x=1796224673;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tvilLuS4AzZRHXFu6N1I5eSa2/5qqjWBVLsKHElBvHc=;
 b=Yx9wIBwAu7qAr7u9anLrkHb++M0XrYGOcCSDt152Hj7Le6pg/Dgh3MMo/Y1yGZzSIL
 W9vVPhWNVuY1K+U/L72VEvF+uK/mB8P43DK8Av6wR6kRbc9cguh1aF93S1hvtJiEZYw+
 nZFS2Hr+ZRdF+kDkcyEJ7ffKhzJcnwaahu1yZW3blUubcy4kZl55axK719ZlmMT1ZApw
 1/haFJg1NPt4KRT6zV4p1vI7fUAfpU51Dg5PpYCqKuk/6CJCyo6TateaM2VhZbrzvl1M
 BN8QipVYapBKDcIlcEwZqCkT/dNbebXVNE2G701/fGirTSf+xEHekcGnF6nsEyJ08YQX
 +ZuA==
X-Forwarded-Encrypted: i=1;
 AL+hErGnmSPxXF76b3LftOjVkwYfwuZFQBsQTTkWI/4CbybshKww8ZN86qzKdaSt9UWzL3+pk9bP12w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8VYt5qoYV5jsvIiWum4UEbtqCq1seywN24lCWzWTUJwjnOfbLK
 UKgVDlyLE6vLzXEgHdelGYyC8zSXVWq/5e0ofcy14CnJ8onxNv87TysL8tTtw41QeYTQfUo1R5F
 Kj5W9ZQLuvTLnwwrHux1qkQjI83iI5msMBawBgUgRDAeiL1UyGtZQ
X-Gm-Gg: AZFdTZdYoN43jt7mZe83sXlRdcUbcseSMerUl0b8v9xi29rqsVWPHHZCmh68wKiK92t
 0PZvTbRVs1H2Ox+Qtr//zxzxkkWQGW2Uz+K2bkeDdK/c0zm7jCdSvXMK0yBExxFOP0ToKd+w4Ud
 Lw9zr4/7hoO98bRUhRFvo+qwuVxCKx3Y5eWklOwHMxShqDQWF2vOflMIK+bfHFySe3RyednOXvg
 3P3hY2qYHEo82iWny9lGKvz0jYNd/e6SlnvqCMwuQTRnoY6jy2FQDX2yW4k+Ify8OxxMrZLjCri
 B8TNwqCy/cfbRz4HYblcZmmA1nhUQW/gz3gY21G6NJkyDaaxHQgTZjbLxRVKVn3xC+DwP6iSCJc
 NbuR7/nREC4Oh9zx4qxbFpBs0ee80HypWWqCfLs8B7qPEzimI1ZUO8OyTZzBofQ0cytMp8wVW1I
 qYMRiXbi6JEoM4J9ZDuREUFQmlwsWbRMh5Emuzw7txQ8VbBlgYljQx
X-Received: by 2002:a05:6512:6891:10b0:5c1:57d3:90f6 with SMTP id
 2adb3069b0e04-5c1bc7d10acmr3743626e87.24.1795619872818; Wed, 25 Nov 2026
 07:17:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
 <awAlGMMg-6tcb1N7@pie>
 <CAEev2e9SdqXvipxXGXFjLqe77RA=LsbGSY8AFnL9VbbYAC0ZJQ@mail.gmail.com>
 <awB-PvfuEDIu_t0l@pie>
 <CAEev2e-SFv-CLxBYZ6CfPPs__BggKc3AsH5PnhNF9uXo_FccXQ@mail.gmail.com>
In-Reply-To: <CAEev2e-SFv-CLxBYZ6CfPPs__BggKc3AsH5PnhNF9uXo_FccXQ@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 25 Nov 2026 20:47:40 +0530
X-Gm-Features: Aa3M54rNva26JNdDE2VwXbB4Ranilbr-GcHJKkqnVwqk_Yszutmj3Fex4_2CA9I
Message-ID: <CAAhSdy2faWHx401xHTKQm7xARJt9XiK_fHbzq7LOP_uY2MdnLQ@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Disable M-IMSIC and M-APLIC nodes in DT passed
 to next stage in S mode
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 10:54=E2=80=AFPM Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> Hi Yao,
>
> +Anup to this thread
>
> On Fri, Nov 20, 2026 at 11:07=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
> >
> > On Fri, Nov 20, 2026 at 10:09:49AM -0600, Anirudh Srinivasan wrote:
> > > Hi Yao,
> > >
> > > On Fri, Nov 20, 2026 at 4:47=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
> > > >
> > > > On Thu, Nov 19, 2026 at 09:47:07AM -0600, Anirudh Srinivasan wrote:
> > > > > When U-Boot is running in S mode, the DT passed to the next S mod=
e stage
> > > > > can either be the bundled in DT U-Boot and the previous M mode st=
age
> > > > > use, or be loaded by U-Boot from some boot media. In the former c=
ase,
> > > > > the M mode stage can fix up the DT to disable the M-IMSIC and M-A=
PLIC
> > > > > nodes on an AIA system (for example, OpenSBI does this fixup). Th=
ese
> > > > > controllers are to be managed by M-mode software, so this is done=
 to
> > > > > prevent S mode software from trying to probe them.
> > > > >
> > > > > This fixup doesn't happen in the latter case because U-Boot loads=
 a
> > > > > fresh DT from boot media. Add a fdt fixup to do this similar to O=
penSBI.
> > > > > This gets rid of prints like this during linux boots.
> > > > >
> > > > > [    0.000000] riscv-imsic: interrupt-controller@a0000000: no par=
ent irqs available
> > > > > [    0.000000] riscv-imsic: interrupt-controller@a0000000: failed=
 to setup state (error -22)
> > > > > [    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-con=
troller@a0000000 ((____ptrval____)), parent (____ptrval____)
> > > > >
> > > > > [   10.727605] platform cc000000.interrupt-controller: deferred p=
robe pending: platform: supplier a0000000.interrupt-controller not ready
> > > > >
> > > > > Reviewed-by: E Shattow <e@freeshell.de>
> > > > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.co=
m>
> > > > > ---
> > > > > Changes in v3:
> > > > > - Reword commit title to say M-APLIC/M-IMSIC and drop references =
to M Mode to avoid any confusion
> > > > > - Link to v2: https://patch.msgid.link/20261119-mimsic_maplic_fix=
up-v2-1-e29e04bf1b76@oss.tenstorrent.com
> > > > >
> > > > > Changes in v2:
> > > > > - Rename riscv_aia_mmode_aplic_imsic_fixup to riscv_aia_mimsic_ma=
plic_fixup
> > > > > - Drop most references to OpenSBI/Linux in commit message and jus=
t use M-mode/s-mode software
> > > > > - Link to v1: https://patch.msgid.link/20261118-mimsic_maplic_fix=
up-v1-1-52dea8f39779@oss.tenstorrent.com
> > > > > ---
> > > > >  arch/riscv/lib/fdt_fixup.c | 86 ++++++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  1 file changed, 86 insertions(+)
> >
> > ...
> >
> > > > > + * riscv_aia_mimsic_maplic_fixup() - Disable M-APLIC and M-IMSIC=
 nodes in DT
> > > > > + * @fdt: Pointer to the device tree in which nodes are to be dis=
abled
> > > > > + *
> > > > > + * On RISC-V AIA systems, M-mode software manages the M-APLIC an=
d M-IMSIC.
> > > > > + * If S-mode U-Boot loads a device tree from boot media, the DT =
nodes for these
> > > > > + * could still be enabled, so fixup the DT to disable these node=
s before passing
> > > > > + * it to the next S-mode stage.
> > > > > + *
> > > > > + * Return: 0 on success or error otherwise.
> > > > > + */
> > > > > +static int riscv_aia_mimsic_maplic_fixup(void *fdt)
> > > > > +{
> > > > > +     int offset, err;
> > > > > +
> > > > > +     /* Disable M-IMSIC in APLIC-IMSIC configuration */
> > > > > +     fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,ims=
ics") {
> > > > > +             if (riscv_node_handles_mmode_external_interrupts(fd=
t, offset)) {
> > > > > +                     err =3D fdt_status_disabled(fdt, offset);
> > > >
> > > > Should we use "reserved" instead of "disabled"? Quoting the devicet=
ree
> > > > specification,
> > > >
> > > > > "disabled"
> > > > >       Indicates that the device is not presently operational, but=
 it
> > > > >       might become operational in the future (for example, someth=
ing
> > > > >       is not plugged in, or switched off).
> > > > >
> > > > > "reserved"
> > > > >       Indicates that the device is operational, but should not be
> > > > >       used. Typically this is used for devices that are controlle=
d by
> > > > >       another software component, such as platform firmware.
> > > >
> > > > Another possible problem is that these loops overrides the status
> > > > unconditionally, turning already "reserved" devices into "disabled"=
.
> > >
> > > I don't think we should be using reserved here. OpenSBI sets the node
> > > to disabled, so we should be doing the same thing.
> > >
> > > I'll add a check to see if the node is enabled and disable it only th=
en.
> >
> > I think this is probably an OpenSBI defect, please try raising this to
> > OpenSBI upstream.
>
> Hello Anup, I've added you to this thread as you had added the code to
> OpenSBI that marks M-APLIC and M-IMSIC nodes as disabled. This current
> patch does the same for a DT that U-boot loads from boot media (hence
> is missing the fixup OpenSBI does) and passes to linux.
>
> Do think these nodes should be marked as "reserved" instead? It seems
> that "reserved" is to be used for devices controlled by different a sw
> component, which seems to line up with what's happening here.

The next stage after OpenSBI is S-mode so that's why OpenSBI disables
M-APLIC and M-IMSIC DT nodes because S-mode access to these
devices is blocked (or disabled). For DRAM where OpenSBI runs, the
situation is different because typically we have on DT node for covering
all DRAM banks so disabling this DT node does not make sense. Due
to this, OpenSBI marks portion of DRAM as reserved where OpenSBI
runs from.

To summarize:
1) Disable the DT nodes of devices which are not accessible in S-mode
2) Reserve the portion of DRAM which is not accessible in S-mode

Regards,
Anup

Regards,
Anup
