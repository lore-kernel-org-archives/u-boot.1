Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12170C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 14:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C358060668;
	Fri, 31 Jul 2026 14:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OxD-n5W-_Jgd; Fri, 31 Jul 2026 14:53:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8F0D607AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785509629;
	bh=Uqff32a5kah/C+hPYXpnoQjMs4RVr46nJxpp/XUL1SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VHSbYeiK8ZpeS88d7xm9iANQe9sNDsvjxYIjG9jDo7OHvNJyYo9kAnmyyHiAY7Lgu
	 BUfW66icnLhUZzVzpSn6wDhrJQvFloXmbKE9wfaz1nBXoSMuzzXi3ZxcGoynANOzI9
	 Vcl9Wt433Ix1184ox1YVxCy9o8dVlQBouqMv80GhmDgaQ8cS/C1uXx70C0FtdFRpGo
	 jK2DTcSUsDTP3ezKsUIwGBuUzz4vSe0u4FYp37wuwrbkoYfpTL5Z+QYyZw1Wugi2vq
	 VGb0vQnVcGme0KTn3J8UN5fY+/R1FwzJJXBVW8bByRAXMAkXONbvQVljIbSJngkj5S
	 3nfzWEDffAi7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8F0D607AC;
	Fri, 31 Jul 2026 14:53:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C7F8E69
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9EDB400A4
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TAYMo7QByNQS for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 14:53:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 981884004C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 981884004C
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 981884004C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 14:53:46 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso571817a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785509625; x=1786114425;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uqff32a5kah/C+hPYXpnoQjMs4RVr46nJxpp/XUL1SA=;
 b=soFAGJLGwGtHlk/UCImcxfEmjOspXxAgG3rlX9wBc+iZM/yOURYtBTRPieqA/a8FSM
 dgt3VyR1ch4MqeqK1VmbHvOfaKAAawG+ilKWYAzKGRW8qGY1mPWSiMV1mmRNY4PJIoJs
 mhMIfk3B/ODshJeUKhmcCvmbPCKDV4D6jcY+D9c748zBmkNYwOplY5mvuTpfR445Bgqs
 6Ak4ppCQyQRdJvDJ84fbgE8kISpQUBc/xUkLuzruHZfevKEowYbDwZYijhakeyUAlmUD
 31DlP/lEYlSonsIUto1biDJYX7zhRr9OOOliALIxEY8hrCXGhyqdBPDuudSxNzahok0/
 +vUg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrr0sU/C5GkKQEmxfzR1cWs68WBea5X6Qrr59eMODrVv2xUz3VLGDOJmwrMAZamaXy9ZOcfr4E=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw0MWRdgo0vd8Tg+NeRHOiW+hX7OET8ZL8sKd7aBymiekeSV9lM
 zz/nLO5Sd446qjQP8mXkfNs17M1VcejM/C6WLkp5wI9I2+P1CuHptRSHlkDRfBwdHPk=
X-Gm-Gg: AR+sD10fA8rbP4v6JGp51DMYMo3CDmgKDIFwMf3stL3lrmj6XAmK8dloailiDv3YS+I
 +F67fc9pbiAT162uXhF5PTbQ4MZ4MMebbQlpSl+oQJOQGiZv+9BY+4ciGvdv97GXADKrULoYNtL
 KgcAZtZWdrn7uehCB5tv5cmIBkOrV67zGzn/b8VW2wiFyzQBD3pg3VrUo4yRM7C/sD0bmIWBApT
 CuamygQWyAMMw9gQ2yh89wcXqjbYBGc30OpIRdRhuC6blRPkER4Qh4X1usHaRoB4TTB1ZSwweQv
 BtMAYgN7jr93UnS4zoKZjZ7RNgXQxvwQ7H6bdzp/aUjZPk8u9r/4uaEu+OtyWeJ9vBbkpfjgnaV
 ls/x3xqzVvgmKnADKTecbrJWOTAFgn24GwHhYUkLGiW7M/NfztEsapi4BI6d4gvjdddkoFn2hZF
 BnsUckeu0zP4gLq9OUI01Bo/Zri599LDffjDglIMs4MjEwIhtNWhTofIOQOnUBx+Rs/URVVM13g
 zJpuSut7F2tRrHZUR3c4QIl1ufepWsBx1xk6kB4E6JchIwvOUSIQnOO2dwvt9r048F5Z9DHCMoi
 NP7SZVi9cg==
X-Received: by 2002:a05:6830:2a0e:b0:7d7:ed69:81b2 with SMTP id
 46e09a7af769-7f196c11f37mr169168a34.5.1785509625454; 
 Fri, 31 Jul 2026 07:53:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18ed9af83sm778008a34.10.2026.07.31.07.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 07:53:44 -0700 (PDT)
Date: Fri, 31 Jul 2026 08:53:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 2/2] CI: Dockerfile: Add LoongArch64 support
Message-ID: <20260731145342.GM1773261@bill-the-cat>
References: <20260731114720.2212170-1-me@ziyao.cc>
 <20260731114720.2212170-3-me@ziyao.cc>
 <23f5f012-589c-4710-8b93-4c6bd509e4c4@gmx.de>
 <amyy2Lyg2Xypz__p@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fa7oQwpaE3vYEr67"
Content-Disposition: inline
In-Reply-To: <amyy2Lyg2Xypz__p@pie>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785509625; x=1786114425;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uqff32a5kah/C+hPYXpnoQjMs4RVr46nJxpp/XUL1SA=;
 b=gXD84ZYslKiS/cwwyDtPoRO8p7tTRmTyiedaKRkRwX9YSsaZtIhm7vhoquoGhTDRuJ
 T2JWXv9iPDSHfCub2aT7hv9VdCe5kMCWYk1fN7mMvDN0y/J8n06lsB0VyXL1zUEwpwu1
 9FGtJY/QYyN9JYU1en8Yv/ldHIuWOAM0uC6Og=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gXD84ZYs
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


--fa7oQwpaE3vYEr67
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 02:36:51PM +0000, Yao Zi wrote:
> Adding the list to Cc so at least this discussion could be archived...
>=20
> On Fri, Jul 31, 2026 at 04:16:38PM +0200, Heinrich Schuchardt wrote:
> > On 7/31/26 13:47, Yao Zi wrote:
> > > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >=20
> > > Install LoongArch64 toolchains, build LoongArch64 QEMU,
> > > build LoongArch64 GRUB.
> > >=20
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > > ---
> > >   tools/docker/Dockerfile | 21 ++++++++++++++++++---
> > >   1 file changed, 18 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > > index fb8e2c523aad..187320c26d59 100644
> > > --- a/tools/docker/Dockerfile
> > > +++ b/tools/docker/Dockerfile
> > > @@ -17,7 +17,7 @@ ARG BUILDPLATFORM
> > >   ENV DEBIAN_FRONTEND=3Dnoninteractive
> > >   # Set architectures to build for (leaving out ARM which is an excep=
tion)
> > > -ENV ARCHS=3D"aarch64 arc i386 m68k mips microblaze nios2 powerpc ris=
cv64 riscv32 sh2 x86_64"
> > > +ENV ARCHS=3D"aarch64 arc i386 loongarch64 m68k mips microblaze nios2=
 powerpc riscv64 riscv32 sh2 x86_64"
> > >   # Mirror containing the toolchains
> > >   ENV MIRROR=3Dhttps://mirrors.edge.kernel.org/pub/tools/crosstool/fi=
les/bin
> > > @@ -153,7 +153,8 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/ap=
t,sharing=3Dlocked \
> > >   	xxd \
> > >   	zip
> > > -# Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
> > > +# Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit, and L=
oongArch
> > > +# 64-bit
> > >   RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/=
grub && \
> > >   	cd /tmp/grub && \
> > >   	git checkout grub-2.14 && \
> > > @@ -189,6 +190,20 @@ RUN git clone https://https.git.savannah.gnu.org=
/git/grub.git /tmp/grub && \
> > >   	search search_fs_file search_fs_uuid search_label serial sleep tes=
t \
> > >   	true && \
> > >   	make clean && \
> > > +	./configure --target=3Dloongarch64 --with-platform=3Defi \
> > > +	CC=3Dgcc \
> > > +	TARGET_CC=3D/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarc=
h64-linux-gcc \
> > > +	TARGET_OBJCOPY=3D/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loo=
ngarch64-linux-objcopy \
> > > +	TARGET_STRIP=3D/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loong=
arch64-linux-strip \
> > > +	TARGET_NM=3D/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loongarc=
h64-linux-nm \
> > > +	TARGET_RANLIB=3D/opt/gcc-${TCVER}-nolibc/loongarch64-linux/bin/loon=
garch64-linux-ranlib && \
> > > +	make -j$(nproc) && \
> > > +	./grub-mkimage -O loongarch64-efi -o /opt/grub/grubloongarch64.efi =
--prefix=3D -d \
> > > +	grub-core cat chain configfile echo efinet ext2 fat halt help linux=
 \
> > > +	lsefisystab loadenv lvm minicmd normal part_msdos part_gpt reboot \
> > > +	search search_fs_file search_fs_uuid search_label serial sleep test=
 \
> > > +	true && \
> > > +	make clean && \
> >=20
> > We repeat ourselves a lot in the Dockerfile for building grub.
> >=20
> > How about:
> >=20
> > for arch in aarch64, i386, loongarch64, riscv64, x86_64; do
> > 	./configure --target=3D$arch --with-platform=3Defi \
> > 	CC=3Dgcc \
> > 	TARGET_CC=3D/opt/gcc-${TCVER}-nolibc/$arch-linux/bin/loongarch64-linux=
-gcc \
> > 	TARGET_OBJCOPY=3D/opt/gcc-${TCVER}-nolibc/$arch-linux/bin/loongarch64-=
linux-objcopy \
> > 	TARGET_STRIP=3D/opt/gcc-${TCVER}-nolibc/$arch-linux/bin/loongarch64-li=
nux-strip \
> > 	TARGET_NM=3D/opt/gcc-${TCVER}-nolibc/$arch-linux/bin/loongarch64-linux=
-nm \
> > 	TARGET_RANLIB=3D/opt/gcc-${TCVER}-nolibc/$arch-linux/bin/loongarch64-l=
inux-ranlib && \
> > 	make -j$(nproc) && \
> > 	./grub-mkimage -O $arch -o /opt/grub/grubloongarch64.efi --prefix=3D -=
d \
> > 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
> > 	lsefi lsefimmap lsefisystab loadenv lvm minicmd normal part_msdos part=
_gpt
> > reboot \
> > 	search search_fs_file search_fs_uuid search_label serial sleep test tf=
tp \
> > 	true && \
> > done
> >=20
> > Adding a few more modules to each architecture does not harm.
>=20
> This is a good idea, but some of grub file names don't match the arch name
> in the triple,
>=20
> - i386: grub_x86.efi
> - x86_64: grub_x64.efi
> - arm: grubarm.efi
> - aarch64: grubaa64.efi
> - riscv64: grubriscv64.efi
> - loongarch64: grubloongarch64.efi
>=20
> so we need a mapping between them, maybe a bash array. Or, these names
> seem to be refered only in u-boot-test-hooks as
> env__efi_loader_grub_file, so I think alternatively we could update the
> repository to use file names consistent with the tripple.
>=20
> I'd prefer the latter since it looks cleaner, though the change might be
> a little complex to fit in this series (involving updating workflow and
> u-boot-test-hooks in a correct order so no CI run gets broken).

This sounds like a good cleanup to do, but yes, we should work it
afterwards to keep this small and reviewable.

--=20
Tom

--fa7oQwpaE3vYEr67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamy28gAKCRAr4qD1Cr/k
ChkKAP90697gZoxscV+0T25ckCsCcs7xaTkxRZAOjoOM6AT+zQEA1wXJV99ecMk7
vPh2wpEP/OJB0Whxadg16lTpDVB6ngI=
=QecZ
-----END PGP SIGNATURE-----

--fa7oQwpaE3vYEr67--
