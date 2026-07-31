Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A829AC5516F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 15:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61DF741144;
	Fri, 31 Jul 2026 15:41:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x2Z25KhYqjdV; Fri, 31 Jul 2026 15:41:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F9B541145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785512501;
	bh=UWkcX85Rz6NBeoF5ObASTur/Ol3rU84Cz+5UWh4McmE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRsCsZHGFQfFTg+gOrbLKnPGwlfmhvUyAxll5SE24sOpcXHSrXLJAcK0Kl5VsFJUg
	 vivyjn27giIcvehZVHY40oFdBNKAjGRtwOk16B6JScCX+ctbalPnQvaCFfsl2UT/Oj
	 48VAnvxQrsQR1hc35jNaZG0a0ZALUKCapyLH0ULllGCb6R2getQ3M3W3JIp5Bd61nd
	 aTp1jK349e/LMcY2NsMGks27j3dJB7aaeYEcjiFCtFuzthWZ+81c+/34sdrso/b1JN
	 DiRiWehTFLtoNNtBZqk4AqXqvunRI5xJ02+hpQaxXghn+a3ghj/P8v0KYJzK4akJc9
	 OYHa5YxcCv8Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F9B541145;
	Fri, 31 Jul 2026 15:41:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F127336E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF054607C5
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:41:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOBkNq6EW7A0 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 15:41:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=richard.purdie@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0563B6063F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0563B6063F
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0563B6063F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:41:36 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c1c24ec9525so199713266b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785512495; x=1786117295;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UWkcX85Rz6NBeoF5ObASTur/Ol3rU84Cz+5UWh4McmE=;
 b=OB7R+Cyxk+qDnfS5qdPTFOKhjGXej1z7nJIH/afAGYlCKzNfNpypi5ZgoffWrOwSDo
 QutI+1UchU54NSPWkSzUDQUfb7euIqO2sGdKK8lHos5sq5IF5ysGaCYN0/k/bKdgmfe8
 o0YpIBaR1swlEjq3FIXbJC2M7/pIF+x8HAZGjjlSIcLg0WupwGqX3kLGX2KwgPpADymW
 z/ZxHLB8hp76xuxPZASCeHSwEj+bGIuyxuwN0jdXreXruoGqNpUmiPa4ufhNK6xR3SCy
 sKup7nGSkM0927oikH3vJwf6GXrfaPlJh5gDknEjH78tG3o242l5Da6d0Wju9Di0NfBb
 AWcw==
X-Gm-Message-State: AOJu0YzgjnNRYK/vhNSC+mYj4Gmd6JCfgWzK9nw8iFIBDPTcEGGg5A5Z
 zVMuAePnziGayM0Go2RfRRLMcuaJOyW+1EfHF9Sf1YXFNagrYZcMHl/ORKyP0Ur1xo523h6KQr8
 fzWXD6mI=
X-Gm-Gg: AR+sD12RR9gagf31wyINdAwAVKg0J1vBz6rpNHI809RRXWzI6jpoQBGTqPMIAMi2MEU
 3feFLwQgRaikPeF7HYm1B0zwbjpcE6an5JdtqslB/KZip9G8gTEDu7STITh6PwxMITdCMrWzjZv
 /7UjtgJ9eyzBSqjuGQNVLOsKgd0CJ8261PY+KFZy+Y5MYD+mnTj20tHbs9ktCgSk7vpxt4IErTE
 rQ/SxxePYEmovg6KWGSLzHxGxvjRaKsiFuZx7vhgauxgUeAX8AEtHcBmz1eEGlYK+8tmHZqyEQC
 1F/U5pXuex4SMjMjUcqc+7ymhJVUZUr1Gu8X/eHufUImHr5armPDPwjeo+RPxjn5zfuuNzdoV0c
 /MrdVDPY41icOrtJ3H7bMcJzB1z4xNCazHw3kKYl0XgbMpeeOVndQTOjFiMpd7S0oQC7qDdzeVA
 l7Qu9urdC46IVwaqJ68tkIAjXVJjLm24OEO0y+9oPFl+BPh/u527wc5My5rEi5IW4TRwYJd9Ut6
 pp8+RsH4qb7yQl9W82Cs/5C/CiYGCQ4UU4jKG7J8Nsr/hhD8iT60Q==
X-Received: by 2002:a17:907:9814:b0:c16:afdd:9dad with SMTP id
 a640c23a62f3a-c1fe7faf429mr8392366b.22.1785512494743; 
 Fri, 31 Jul 2026 08:41:34 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7f7b:46f5:a0f7:875c?
 ([2001:8b0:aba:5f3c:7f7b:46f5:a0f7:875c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd38fde4asm185585566b.0.2026.07.31.08.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 08:41:33 -0700 (PDT)
Message-ID: <e718d218ebacadb1e0579690b322ec88ed7a6a8e.camel@linuxfoundation.org>
Subject: Re: makefile confusion about configuring u-boot in OE (ARCH and
 UBOOT_ARCH)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Date: Fri, 31 Jul 2026 16:41:32 +0100
In-Reply-To: <20260731153027.GN1773261@bill-the-cat>
References: <68767aba94c02cab3697b18b65de848cfadb7a2b.camel@linuxfoundation.org>
 <20260731153027.GN1773261@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1785512495; x=1786117295;
 darn=lists.u-boot-project.org; 
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UWkcX85Rz6NBeoF5ObASTur/Ol3rU84Cz+5UWh4McmE=;
 b=b9T2XhYhIr67fcGBz1IBcNsInSw2stoajR8GvqdSJy8MJhYolBxnszqa14cpf4v2vg
 oPuN2vVfBDu50Ti3RGSj91XlvQSck2NGOM2nIqM2MaIyn/CpiYRn/qCqifSegtyiKDBb
 j+Q3YIJJYjroU3R4y/v7A+INlNkDiNmbPKThQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=google header.b=b9T2XhYh
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

On Fri, 2026-07-31 at 09:30 -0600, Tom Rini wrote:
> On Fri, Jul 31, 2026 at 04:01:06PM +0100, Richard Purdie wrote:
> > Hi,
> >=20
> > I'm trying to clean up some class code in openembedded-core and I'm
> > getting confused about what the "docs" say I should do vs. what the
> > code does (vs. what OE does).
> >=20
> > https://github.com/u-boot/u-boot/blob/main/Makefile#L381C1-L399C20
> > Makefile in u-boot says:
> >=20
> > """
> > # Cross compiling and selecting different set of gcc/bin-utils
> > # ---------------------------------------------------------------------=
------
> > #
> > # When performing cross compilation for other architectures ARCH shall =
be set
> > # to the target architecture. (See arch/* for the possibilities).
> > # ARCH can be set during invocation of make:
> > # make ARCH=3Dia64
> > # Another way is to have ARCH set in the environment.
> > # The default ARCH is the host where make is executed.
> >=20
> > # CROSS_COMPILE specify the prefix used for all executables used
> > # during compilation. Only gcc and related bin-utils executables
> > # are prefixed with $(CROSS_COMPILE).
> > # CROSS_COMPILE can be set on the command line
> > # make CROSS_COMPILE=3Dia64-linux-
> > # Alternatively CROSS_COMPILE can be set in the environment.
> > # Default value for CROSS_COMPILE is not to prefix executables
> > # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefil=
e
> > ARCH		?=3D $(SUBARCH)
> > """
> >=20
> > so that implies that ARCH from the environment would configure u-boot.
> > Fine.
>=20
> But is unfortunately a relic of our "copy the kernel Kbuild files in".

Ok, I did think that might be the case.

> > kernel-arch.bbclass in OE exports ARCH and UBOOT_ARCH.
> >=20
> > I want to stop u-boot.inc inheriting kernel-arch since I'm not
> > convinced it is entirely compatible and we need to make changes there
> > which we don't want to affect u-boot.
>=20
> It's not entirely compatible, true. It's largely (for values of being a
> few years behind in kernel releases, but not as bad as we were at the
> start of this year).
>=20
> > I therefore naively changed u-boot.inc:
> >=20
> > -EXTRA_OEMAKE =3D 'CROSS_COMPILE=3D${TARGET_PREFIX} V=3D1'
> > +EXTRA_OEMAKE =3D 'ARCH=3D${@oe.kernel.map_kernel_arch(d)} CROSS_COMPIL=
E=3D${TARGET_PREFIX} V=3D1'
> >=20
> > This proceeded to break all our u-boot recipes.
>=20
> Now that's interesting. For U-Boot, "ARCH" is meaningless. Whereas in
> the kernel you have to set ARCH, it's just a Kconfig question in U-Boot.
> Usually it's harmless to set.

That is not my experience. With both MACHINE=3Dfvp-base with meta-arm:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/75/builds/4127

and MACHINE=3Darmuarm64 with oe-core:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/4493

it breaks if I put ARCH in EXTRA_OEMAKE (where ARCH is coming in as
arm64).

> > I think I'm concluding that:
> >=20
> > * ARCH from the environment no longer changes u-boot and the comment is=
 wrong
>=20
> The comment is wrong and I don't think it's ever really mattered, but
> there's times when it's been non-harmful.
>=20
> > * OE shouldn't/doesn't need to set ARCH
>=20
> Correct.

Ok, good. That is an easy patch then! :)

> > * we should just drop most of this from u-boot
> >=20
> > That brings me to UBOOT_ARCH, which takes ARCH and does:
> >=20
> > =C2=A0=C2=A0=C2=A0 if=C2=A0=C2=A0 re.match('p(pc|owerpc)(|64)', a): ret=
urn 'ppc'
> > =C2=A0=C2=A0=C2=A0 elif re.match('i.86$', a): return 'x86'
> > =C2=A0=C2=A0=C2=A0 return a
> >=20
> > on it.=C2=A0We generally use UBOOT_ARCH with mkimage, e.g. "uboot-mkima=
ge -A
> > ${UBOOT_ARCH}". We then have code which does:
> >=20
> > =C2=A0=C2=A0=C2=A0 UBOOT_ARCH_DIR =3D "${@'arm' if d.getVar('UBOOT_ARCH=
').startswith('arm') else d.getVar('UBOOT_ARCH')}"
> >=20
> > to find code u-boot which implies UBOOT_ARCH might not be right.
>=20
> So, for passing the architecture value to mkimage:
> https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/boot/image.c?ref=
_type=3Dheads#L62
> is the map between strings and values. PowerPC probably still needs a
> fixup if powerpc64 is something that needs to be mapped.

Ok, I can perhaps document that mapping and point at the definitive
list of which values it should return, thanks.

> > Am I right in thinking the valid values for UBOOT_ARCH are "ls arch" in
> > the u-boot tree?=C2=A0
> > If so, the arm values in that function look dubious in that arm64
> > shouldn't ever be there for example?
>=20
> Exactly. arm64 is a valid UBOOT_ARCH but is under arch/arm/

So UBOOT_ARCH_DIR is a smaller subset of UBOOT_ARCH and is the list in
"ls arch". I can document that too I guess which should help the next
person trying to figure this out.

> > I'm no u-boot expert, I do know something about the OE classes and
> > build processes and this all looks a bit of a mess to me. Can anyone
> > with a bit more experience tell me if I am missing something obvious
> > here and if this is as much of a mess as I think it is?
>=20
> It's certainly a bit muddy here at times, yes. We use Kconfig to
> configure things, and we're a little behind but that language doesn't
> evolve quickly either. We use the Kbuild infrastructure to build, but
> we're lagging behind and don't use all the features of the kernel
> either. We likely use little enough of them that it would make more
> sense to just set CROSS_COMPILE as needed via EXTRA_OEMAKE (unless
> someone is aiming to build with llvm instead, and so the KERNEL_CC,
> KERNEL_LD, etc, options).

If someone wants to use llvm these days, changing TOOLCHAIN to clang
for u-boot would swap all the CC/LD options behind the scenes. I don't
think u-boot needs to know/care about the KERNEL_CC_* variables and
friends, as far as I can tell it doesn't currently use them either...

Cheers,

Richard




