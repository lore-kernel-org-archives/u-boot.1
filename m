Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2B606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zb0itnh4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gh5/RIhB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A59D80E68;
	Wed, 18 Nov 2026 15:28:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pSfxukaQYhiC; Wed, 18 Nov 2026 15:28:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5003D80DE7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795015699;
	b=LjNhXjBzeG/nB2yPnHytKbr4lle5jkiYwW2DPiQA4RzZ3zwpiv2/kPVMY/MXVZCVbieS
	 UNUBdMeOHjlQmz/VLriUKAo3eWocTVI1PLRk9pAt9HQvePMZRvB3agXVu5+MXi74CrBI9
	 JfD7g1by60cgg2S75sw31+p8vhoXSPmRK3qHl/3R7QsvjsBYCS+zfkhjfi7rhtCATSdoH
	 Q08io/9Yllb+BjAs8A/r2+xh3ZjiudaFS5C6bFvwxeOrWezSxnvQ68jzWTd4xSSap8mS3
	 NM1q0B72+hUxBNBP4jAMWI3P6xi3YW4tbcLufOFYYtyk6+2B2AX+JOi+gLgLQDaMtlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795015699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XfcyARD4dYF8RL6BBppGB6NPtsD5hjElSnSXvGgKBXw=;
	b=GmloDQ7F6jtCuduDay0RlA0R2jan0hXEGcDTiNAuXmBLLsf9NwCRLfOWNelOpK46+hhz
	 dUKwVmgGi5YEdDsj14IpSW2rB5sNrmGuNSHkFayMoZYXbqRudGyZwsTeHMacjUEzCW/sY
	 CvXTQqa/Gt2Az2oROwBZYpbY/475JwmzLvNvjx1IHk5rzKCVdXMELaGQgTQZpygJbe9bc
	 f9VFVitGMDP1wdaAZ2QsnuGVxDu9hkNHw49VrU1K+FBVmEXIloGhIEyRdMFH7dL4hZXmj
	 mwR1yNmi3V1FTkuzT6+lfmPil8y1w9Gd5RW4WOUSmeTRwAoTraq4TJPEHci2ixZO1+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795015699;
	bh=XfcyARD4dYF8RL6BBppGB6NPtsD5hjElSnSXvGgKBXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zb0itnh4SSuiHfd9bM+1zDm/9AjDnNEK2Xr+efjAOY6d039DqEfWzox1g5DQ1X3+W
	 mKQpNB+NBOe+8dbf1fMlBh5lZUHORiFs+vjUSYmYXbp+qtFw9UFgQZopBCFgJtDS0i
	 iBIRfiepVvrIa9VA7SryhmBW2oqsznvc9aF0Vr3kg8GuhLRNmcUTG516iBL/k9SZDa
	 5w1wi95pu+NG2kq7ZDS4TMmY7hWcsgqMXt+80deM/7gGDHYqkCwClVRScVJaWRTaVv
	 2bG3voY4o+r2LI186NLzKHrw9VaV1H2UDntrwD26/+nSdkr0EntVJutBwhsPEejGw7
	 CHcPEVImF3ojw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5003D80DE7;
	Wed, 18 Nov 2026 15:28:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E0BB4A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE0A54091D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLQfytDVbnqa for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:28:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 24BC340875
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gh5/RIhB
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24BC340875
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:28:16 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4a451915d8aso588559b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795015695; x=1795620495;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XfcyARD4dYF8RL6BBppGB6NPtsD5hjElSnSXvGgKBXw=;
 b=gh5/RIhBg1eXhI6blNjLU8yKhAr8GJ216j/gWJqqQEE/yPXIkiZgd4UgTQ3BC/42Kp
 pVqbPFyVatJAUbcrfqyR36QAVyigzngk3gpxqemdVNfNIMBzBNb35DWnGRH8dc8QFWOo
 VajM8jPKBgSAwCNO2aLcMX31RewuDx7IWL1y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015695; x=1795620495;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XfcyARD4dYF8RL6BBppGB6NPtsD5hjElSnSXvGgKBXw=;
 b=fIA5Wm9uKgXRVDNvBGt9i8QogbAHrjTkE966IwXLEJcvbNpdRCBtOidvCuuM2zK0pB
 mxdtOcb3aOE3aRMVMmbEISYUAqtzu7ubS4khPM0uW/pRsh8kg+aybquzqRndzF7Dlcb2
 pXKMwUbP4SRcaIqsBGyFJQdu0imsDP+EsoQebU4hDEt1WjWE4lbnt+gPpuFsXEF3X73C
 2/mUTTXXsBOoHpV/rdOwTLDwOkK5wLcHzfWtTWOaVgtesQ9lPafe8fUxoeOXxhMkTo9s
 FvmRKhQpNSD9ZMzUWb+NKYfZH5oMtzrfGd6OEJh/zK436XemVbXQgnd2AG/9McQ0a2Ss
 c1JA==
X-Gm-Message-State: APuU4Z8U2jUkwz1CkfofBCNqV1yKixdmCMymghTGt2wUb1tcmzL5snSH
 ewvaYrVAhkCGHSLb+uMKmeFvg/CuKXlRu0VC30tlmyVd0Dd0J1a0nwcaoksHROBZ/wQ=
X-Gm-Gg: AYBFou0fDgS7sDNYEGVBk5J5aB8Jet8dEpAJHRDK7OEhXHe1YN5QngxE/4BAhqjmB5I
 K6Db6zAPeCaK7Tmbx0ZngVhPtsnVwD5a9WLvdiwsZWvgReHLeGK7f3YgPnHt/w8HJd9TWCsD1r1
 5sZ1ohD8nwOGAJQt44MusqzjG+jyS+mnFquln/ptjdrfENDIZVYRYRvm4jgZDG99MYcHJOIDUKN
 DwtOiQibKWOGkdUizdJR9v5YL/O0OCxdgu7f0tlNq09uiubxQzbPVKgkrR28goIfRbwbCG7i1CU
 on+Khg8zrrp99jObM1S/PxEMlWFgzl8i10ayfd+1rzjeaSzFtfJV7tgYVJj8jyuZYt/3DRI/8it
 3HTsIaZ2sbrKQ4+uGiXbBSbQLkHFCP8SHdEdtlHLFWXzAcwH8ywwTPFEWwicnISC7LDK8A8pOxJ
 rwzd/ACB8au/QrCdT/KDoimOHiM++GX+HXk3Df3HcrI8NPxEFgSqXiycYJibJ4r8xJSNmav0OdA
 27lZULtyjpmh9hJL/UJ/ELzfo0PKq1UUigZHq2ItuiC4TypyP5ETwAlWZwcUxpRr3/KUGnb8+a2
 HSR+MhYUJbX6Fdv2L2W1wNP0rHYJIHQ/XcMVRCiUfbstHRp1F9zhaDa70uf5qQenIcgyt11Jhxn
 j6ETSgmlloCu0eoZa80iFqwe7Q9kl9MQ0bV1lkdg2arYaIb3aYnQcWnz5BOYWl4qSZ2KSK2E/3M
 k4o2Uhj8v0W9jkn6cwMG7f3NNgosvx28k=
X-Received: by 2002:a05:6808:4f50:b0:573:1dfa:f0cf with SMTP id
 5614622812f47-5773fc54cbcmr3709862b6e.51.1795015695577; 
 Wed, 18 Nov 2026 07:28:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5777a2bbc1bsm1796843b6e.5.2026.11.18.07.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:28:15 -0800 (PST)
Date: Wed, 18 Nov 2026 09:28:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Romain Caritey <romain.caritey@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Leo Liang <leo.liang@sifive.com>,
 Tim Ouyang <tim609@andestech.com>, Yao Zi <me@ziyao.cc>,
 charles.perry@microchip.com, mamemaria.mbaye@microchip.com
Subject: Re: [PATCH 0/4] riscv: support running U-Boot proper at any address
Message-ID: <20261118152813.GW554944@bill-the-cat>
References: <20261117235433.3601945-1-romain.caritey@microchip.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B4N5qR09m7UWq81G"
Content-Disposition: inline
In-Reply-To: <20261117235433.3601945-1-romain.caritey@microchip.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--B4N5qR09m7UWq81G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 03:54:09PM -0800, Romain Caritey wrote:
> U-Boot proper on RISC-V must currently be loaded and run at
> CONFIG_TEXT_BASE. This series adds a POSITION_INDEPENDENT option, as on
> ARM, so that it can be run from another address, for instance when the
> previous stage does not load it at a fixed place.
>=20
> This is needed for the Microchip PIC64 SoC [1], which has two
> clusters running U-Boot from different addresses. With this series, a
> single U-Boot build can run on both clusters, instead of one build per
> cluster with a different CONFIG_TEXT_BASE.
>=20
> Patch 1 replaces la by lla in start.S. With -fpic, la loads the address
> from the GOT, which only holds the right value once relocations have
> been applied.
>=20
> Patch 2 adds a checkriscvreloc build check, modelled after
> checkarmreloc, to make sure only R_RISCV_RELATIVE relocations are
> generated. This is the case for every configuration with -static -pie.
>=20
> Patch 3 moves the .rela.dyn processing to a subroutine and drops the
> unused symbol-based branch, so that it can be called twice.
>=20
> Patch 4 adds POSITION_INDEPENDENT, INIT_SP_RELATIVE and
> SYS_INIT_SP_BSS_OFFSET: start.S fixes the relocations for the run-time
> address before any C code runs, including board_init_f_alloc_reserve()
> and harts_early_init(), and computes the early stack pointer from
> __bss_start. The first hart to enter _start applies the relocations,
> the other harts wait for it to be done.
>=20
> Note on Kconfig: POSITION_INDEPENDENT, INIT_SP_RELATIVE and
> SYS_INIT_SP_BSS_OFFSET are now defined in both arch/arm/Kconfig and
> arch/riscv/Kconfig, with the same meaning but different dependencies.
> I kept them per architecture to keep this series contained to RISC-V.
> They could be unified in a shared place (for instance a common Kconfig
> with per-architecture dependencies) as a follow-up, if preferred.

This is a good thing to see. Yes, in a follow-up please move the options
to arch/Kconfig (and a short menu for them, similar to "Skipping low
level initialization functions") with correct per-arch dependencies.
Thanks!

--=20
Tom

--B4N5qR09m7UWq81G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCav3D9wAKCRAr4qD1Cr/k
CmlxAP490b03ZIUsvbUXUB6gkkK5hPbg4PF6l30AyBp2y2ej5gD+KVhddLKy/Tmo
wI5tyFPA1ffv2rA4h555E9YYESmTsAE=
=RuEi
-----END PGP SIGNATURE-----

--B4N5qR09m7UWq81G--
