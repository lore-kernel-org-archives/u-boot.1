Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF81606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xx7DBMWN;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rSKzdRRJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 018D640B12;
	Fri, 27 Nov 2026 18:46:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YaEgWQznblIs; Fri, 27 Nov 2026 18:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D0A5940AAA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795805191;
	b=K3h2rPK/bk7y3Z9PGyh/LjB48WRMMIBmTDDJTz51cZOq8e1eRDbBJh+ycWS5zeeKmzlq
	 R59SlstwbuE1IZCM6BIrlS2r1ylHErZdKR+cTLqiVP4rFoiRPwHiHtNzmZXRtzTpgtAwO
	 gXBb8dOnrP+XKB/V88oU3V4Bkqi3M6LVGRDHRkaMn+t2tPEHNlcsdGaHQ1Cm5pc3K4k/w
	 ydTT9ID8wbqrX6gHW+EvKB/KAKyJ1gBZdlYeN2wORXdG07IExGAKCVNuy3dHpCJTWWSiQ
	 kbciao049R6WDUvUCX7cCW4iRuG+PvksFiA8MKE1zLsQYPQIZPeNcYQ+ZgfR6TZjASQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795805191;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wiWgwKRqCpHaUVt8IVqWzcL6oPrcXaHx2Tfcl5iM2YE=;
	b=EAx4WrhhKDKqxUjj6ihZ5fV+me9lfITsp0GPSOn0kjdks4+9UcSXNsBD8mlOZu/7r4Ak
	 BsnZsnOg/mPpT43MwXWzfYA6LDW3MQY5u7iXiQNYLRtcA+MvkB2oumeJeTPwqINAG2gQ4
	 5piF1ieclt3o8YWdUb/9eTG0NSAjrN4srMIKDYYNq7GxukyRrB3oGAuAXcEmWDg7eoyLe
	 oNHHUPMMkLe7jzLLbTLoXXzzbai3AliC3T6GACMa+z5qJ0V4F6cs/OKdM0rA/vpwKVKa8
	 ivUuZGlQgiNBHIjx22oosbCYpAIX0OacUfe7/D0YNujJOPaGKArk7Yai+j33FUgnjhw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795805191;
	bh=wiWgwKRqCpHaUVt8IVqWzcL6oPrcXaHx2Tfcl5iM2YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xx7DBMWN74Pi7KPQVvx14tIrLMlsIbOGthMw4grkP0RyLdqAaG6FdRCEaQUlHuMtt
	 QGEE1TVJdXPGzIEs8Uydik2Qcd08yb9rpTITYKGAsEitcqFjJpARFfTF+G5R5juFy0
	 owjuo2DT3DDCI7W0hfZi1xA26G29cK0QbT12QND4+F6zTjfh1xrx9sI2y2DlBq4dkj
	 I+SZ8X+VFH+dlxRBVt7+/L2OIQ5CYxQdtIy0CgmRmM+3T0uJqWXyYjvFsm3Aijkzy9
	 R31ZJw3K/2YjbGxjI0YnMEvbWassIIePFBL6/2ANRp0G0dycEI3EPt39E2FN1VRWNZ
	 6tUkJrS5AxbVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0A5940AAA;
	Fri, 27 Nov 2026 18:46:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C64452BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B778B812CE
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ubHNABQ1I4uC for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 88E9F812CD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rSKzdRRJ
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88E9F812CD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:46:28 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4a77dcc4ca0so4359617fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795805187; x=1796409987;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wiWgwKRqCpHaUVt8IVqWzcL6oPrcXaHx2Tfcl5iM2YE=;
 b=rSKzdRRJRralYarokzmLbCOZwQGguWgQSBDkz1vbx0xbDh5BqjpCdI75G+YAztsE6E
 9McCrFl+Z0WLAFNSTTMLnuosJ1r8qAj628yAvFLeL1qpHSAsa+cRQXW8RFKuNZ/d5794
 RCeuR1NoP+WVcYzs/Po0ekYFzmPyEPtupmp+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795805187; x=1796409987;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wiWgwKRqCpHaUVt8IVqWzcL6oPrcXaHx2Tfcl5iM2YE=;
 b=lGUEMgLKokcPom4CCwSWLLCqm15E4u1bVqmfe3Gk+aPlww971sdWk7gcY0FX9rAiVi
 7Xf0rVDraQo9KvkPk+X96A/vxdpmFHHDI3iNGYwbDNgd1V0T+jsWWSnIDbpIL8OTmezj
 /NFSjWfYBmqzHrOrPFcUACrz3G/a0YuA2n8b+Z1rCyr11TuhyFkvQHhQhqyczSWJ25FD
 feRAutt8c5pKAqlhuOm2krWvfmklk4qZ8z7GnznG6K5NVDhrzmuAwz1lsgygjwJ2pG+e
 5uGKQUIS35Owxf3qeswbToomGoTFoyCek3z/oBqHx9jFDFZlIdRsvBdrPCVL2kdjIZjm
 WHpQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHrrLSc/m0TqDCR+TLfHr9Hy6QAYp89UqOToCFfL24J/iNoaf0BqWObjLBalfOuNGhlhl8lzv0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/TrseOMXRysmn9ONN7tEeDBUYvwAMXiPfWTeDTViDvZkwo7AUR
 FUnMCmjo9XK8mk8MdBufajOW3GJGcHTDkMUZudmYtXz40ZJgRH3BShzRDFCTWi8Ydi0=
X-Gm-Gg: AZFdTZcJh4wU2IKTv2yKumUDbTiStrfMG53JTOdXIIEje3ae06Y4q/vUhiJ3QA9YugB
 riXZXBv48Ax/shFRqfNyWjkdo7frBDi2xuOutVVwFZlxpCylqR4B2pQ/fB5KG+MoqK+uU8ddpzk
 3zpMTz+EvxL0ru3JRsW0BTw31oRzFP7cKDugA5dDt7tSzoO89ONEVAtwtJVceesDC3uoH7frudn
 tBCs+yv/aB8/vKlXh4+jvdGG0Ycf9RuNpb703cB/bqdhT2P6QpNR+NLqNq0EdusaaTQIAnze85F
 MYfjNG6C6X2G/t041VjMhz/9F56v94nN86VEUpMjcF3+uEWkBi6MJxYcCsffdMn/BfOIh5HyWyG
 3ji6eak0zWTwL6OPuS4yV7K5xvOONpkZMsFrKFIyL3YlHSE/3LSIudBc0rJ1uN7uRVzOa9/aXML
 aQlUX27mZwHW2ZHZJTThvzaruvuWykVg5tY9TJvvua8svScf9dUsGk3Jr89XCONLGAgR7+Ps752
 eqHzGKVCZzqwtzu4V/vVCO3ximIqy7V9/XjZI/5ZBzmjls1szIjEPHnmXBucTkX7Yttrwganjhz
 1kIFKPy6wJEhyEVgycIJaqidR7q0JI3ELZL/vk7OjP+9OzJhutENsV4uLKf/R74N/k6eRJDakJF
 OFQ0hZyKE8fKGUspAN2+icqcaeaf699+pqCwMWPYNcdY1rPplzMBN2UXZw5cQ8cILuSVo9yu4xC
 4XKIyHq+l0oR7bt41N0UIFEdvlAgBrnR/6wUlHqghzX1fR0kXW9uW3
X-Received: by 2002:a05:6871:341b:b0:479:be68:ce94 with SMTP id
 586e51a60fabf-4bc810b7cfbmr24522881fac.26.1795805186902; 
 Fri, 27 Nov 2026 10:46:26 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc61659cb8sm23574593fac.17.2026.11.27.10.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:46:26 -0800 (PST)
Date: Fri, 27 Nov 2026 12:46:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 richard.henderson@linaro.org, casey.connolly@linaro.org,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/2] arm64: Add RELR relocs
Message-ID: <20261127184623.GP3176972@bill-the-cat>
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <20261125074122.1965495-2-ilias.apalodimas@linaro.org>
 <3a263d76-c2fc-4e15-9f2c-7795bb27a6e0@cherry.de>
 <CALeDE9NaEmTqxPebzYWYcyT4sYq=s+PCet0mPKuRAUtKZG3CXQ@mail.gmail.com>
 <CAC_iWjLAkaU-r1r=f30rq1iRFFJ==TrUeqJoJ29LG1Eie3cyMQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wv7qHlERSNBeACuF"
Content-Disposition: inline
In-Reply-To: <CAC_iWjLAkaU-r1r=f30rq1iRFFJ==TrUeqJoJ29LG1Eie3cyMQ@mail.gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Wv7qHlERSNBeACuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 05:14:26PM +0200, Ilias Apalodimas wrote:
> Hi both
>=20
> On Thu, 26 Nov 2026 at 14:48, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> >
> >
> > On Wed, 25 Nov 2026 at 17:20, Quentin Schulz <quentin.schulz@cherry.de>=
 wrote:
> >>
> >> Hi Ilias,
> >>
> >> On 11/25/26 8:41 AM, Ilias Apalodimas wrote:
> >> > Linking U-Boot with -pie emits an R_AARCH64_RELATIVE entry for every
> >> > pointer that needs fixing up. Each Elf64_Rela entry is 24 bytes, so =
the
> >> > .rela.dyn section ends up being quite large.
> >> >
> >> > Modern toolchains support packing relative relocations in RELR format
> >> > via '-z pack-relative-relocs'. Instead of offset/info/addend tuples,
> >> > RELR stores a stream of 64-bit words. An even word is the link-time
> >> > address of a word to relocate and an odd word is a bitmap describing
> >> > which of the 63 words following the previous address need relocating.
> >> > The addend is the value already stored in the place.
> >> >
> >> > Compiling for QEMU with RELA vs RELR looks something like this:
> >> >
> >> > $~ readelf -SW u-boot  | grep relr
> >> > [ 9] .relr.dyn         RELR            000000000016f970 170970 00096=
0 08   A  0   0  8
> >> > $~ readelf -SW u-boot.old  | grep rela
> >> > [ 7] .rela.dyn         RELA            0000000000115110 116110 0184f=
8 18   A  0   0  8
> >> >
> >> > which is ~98% decrease in the space reloc entries need.
> >> >
> >> > So let's add a Kconfig option and teach U-Boot RELR.
> >> > - pass '-z pack-relative-relocs' to the linker and add .relr.dyn
> >> >    in the linker script and the objcopy'ed binary. relr.dyn is still
> >> >    overlayed by .bss
> >> > - skip checkarmreloc, since we now expect R_AARCH64_RELATIVE entries
> >> >    to be packed in .rel*.dyn and older tools don't decode them
> >> >    properly
> >> > - process .relr.dyn in pie_fixup. It's worth noting that efi runtime
> >> >    relocs, due to how ld emits RELR, are now packed in .relr.dyn and
> >> >    efi_runtime_relocate() doesn't have to relocate anything.
> >> >    A sideeffect is that we can't support  SetVirtualAddressMap and C=
onvertPointer
> >> >    for EFI, but some architectures are already ommitting this call
> >> >    (e.g Linux on arm64, openBSD doesn't call it at all). [0]
> >> > - process .relr.dyn in relocate_code(). Note that the places are
> >> >    link-time addresses, so we still need the link-to-copy offset to =
find
> >> >    them, but the stored value has already been shifted to the run ad=
dress
> >> >    by pie_fixup, so it needs to be adjusted by the run-to-copy offset
> >> >
> >> > [0] EFI runtime services relocate themselves when the OS calls
> >> > SetVirtualAddressMap, using the relocations between
> >> > __efi_runtime_rel_start and __efi_runtime_rel_stop. Those are collec=
ted
> >> > by the linker script from the .rela sections of the runtime code.
> >> > RELR packing, however, is done by the linker as a last step and all
> >> > relative relocations end up in a single .relr.dyn section for the en=
tire
> >> > image. There's no way to emit an equivalent __efi_runtime_relr_start
> >> > marker for the runtime region, or emit RELA relocations for the EFI
> >> > runtime, so stop advertising SetVirtualAddressMap and ConvertPointer
> >> > in the EFI_RT_PROPERTIES_TABLE when RELR is enabled.
> >> >
> >>
> >> 6.4% size reduction for u-boot.itb with RELR enabled on
> >> tiger-rk3588_defconfig.
> >>
> >> $ aarch64-linux-gnu-ld --version
> >> GNU ld version 2.47.20260726
> >>
> >> from Fedora 45.
> >>
> >> I reached U-Boot proper CLI, which I have been told is sufficient to
> >> test this series, so:
> >
> >
> > I agree with enabling this by default, it should be opt out if there's =
issues.
> >
> > Looking at various default toolchains across distros (thanks Claude) Ub=
untu 22.04 LTS has gcc11/binutils 2.38, RHEL 9 is gcc11/binutils 2.35.2, De=
bian 12 is gcc12.2/binutils 2.40
> >
> > All have options for later versions so I think we should be fine to ena=
ble by default and error if the toolchain isn't new enough. The reality is =
a lot of users will be using old U-Boot if they're on ancient distros anywa=
y.
> >
> >>
> >> suggestion: make this transparent to the user
> >>
> >> We've talked about this in private but wanted to put it in writing so
> >> it's available on the mailing list archive. I think it makes more sense
> >> to always enable the option (if it's safe!), if the linker supports it.
> >> According to
> >> https://rfc.archlinux.page/0023-pack-relative-relocs/#motivation, that
> >> is GNU ld 2.36 and LLVM 15. We can use the same mechanism as in the
> >> kernel, c.f. CC_HAS_UBSAN_BOUNDS_STRICT with def_bool
> >> $(cc-option,-fsanitize=3Dbounds-strict).
>=20
> I don't think that's a good idea. You turn on an option that promises
> to reduce the binary size. You compile but bercause you now made the
> linker flags conditional the end user finds an *identical* binary
> after enabling the option. I prefer breaking the build so users
> understand that this relies on a newer linker. Whether they can update
> it or not should not be our problem.

So, we should be doing depends on LD_HAS_RELR_SUPPORT in the new options
and LD_HAS_RELR_SUPPORT is def_bool ..., and then the new option can be
default y.

> >> What I don't like about it is that if it's default off, nobody will tu=
rn
> >> it on. If it's on and we force the option like in this patch, then
> >> builds will fail on older toolchains. I bet most people don't know whe=
re
> >> to get a newer toolchain than the one they have from their distro, or
> >> how to install it so lots of headaches for people I guess. If we stay
> >> with this solution here, is there a way to tell the user how to fix it
> >> (either via a Make message, or at least a comment next to the places
> >> where we set the flag?)
>=20
> There should be enough explanation in the commit message and Kconfig
> option why this is not enabled by default.
> TL;DR there are implications wrt to EFI if you enable RELR that do not
> affect Linux for arm64, but Linux is not the only OS we boot. Since we
> have it documented, I'd rather leave the option off, at least till the
> EFI implications are gone.

Are the EFI implications something we can / will resolve, or should we
be asking the other OSes? Or, since the BSD folks do make it easy enough
to try them out, should the pushback be on you to fire up an installer
image or two? Or... is this something that won't blow up immediately and
rather you'd have to do some non-trivial testing to confirm?

--=20
Tom

--Wv7qHlERSNBeACuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawnP+wAKCRAr4qD1Cr/k
CtMhAP9Bft72KFz9/khrd8GzHuGj09U3TtDV6fzGCKtZHp/f3wEA1q5LjfuBgPeV
PJR7qENqCqUj03AYO9dWj+BpVmtDFAQ=
=KXCB
-----END PGP SIGNATURE-----

--Wv7qHlERSNBeACuF--
