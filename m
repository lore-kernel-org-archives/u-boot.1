Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B47C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 21:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AAF780ECF;
	Thu, 27 Aug 2026 21:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6imeaiakDpeC; Thu, 27 Aug 2026 21:41:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787866861;
	bh=JCFyYjQzOY5kGxVm5x44Q7bONssWO7Ht37lMTSrCoIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BT2KWFc7RF/6ic83tT/bF8CLTIzQpHYQ5Atq5rK0E7gtye7HoLqAaIbo/sZqqlBX1
	 psTL0KO0l1sYNCVO7ZF9tqUnxQK1xYtptuo+yM9R1ildTC8FoPbzCCqRI4s8ulTxjv
	 9fCvki40JkCFfzH9+llmnfVGgSQ0y2q4TttrmnFXV53DWkq/vEMjQ+nU3bWVR7g2k4
	 AaIG7p+YSPDpAsmqVKESsDZ07Xe9nWkba5ABebWQCcoOP5FKFp5yjGZDpG5Seg+qVD
	 omFfERPgsqtNngc3VebBKjJHyrVWY36lXsn+p60CNHxcsKwG7vYBF8ZsFq7Ifx4/md
	 ghxkT4+lk9Www==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E38F80ED6;
	Thu, 27 Aug 2026 21:41:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D920334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 21:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B57B4034C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 21:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5OzEGP-YLf5 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 21:40:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=O2Tp+8vT
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2930E40076
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 21:40:58 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7f4e729368fso357588a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787866858; x=1788471658;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JCFyYjQzOY5kGxVm5x44Q7bONssWO7Ht37lMTSrCoIQ=;
 b=O2Tp+8vTtT6na+5X+gSw0hk9G+VNBrpI7NFv+mPekemuWI9r5+O05WPMt1BSKjHB85
 r+GQfEpMiPAqR9HM04cc3nqTxAlaacCT0TYQZjeVt/JgYod1nzdbXyzbxRJU73WM2aEO
 /Ft8cJ2W8F8qZlmvk609gCrOvgxGK95aIhljQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787866858; x=1788471658;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JCFyYjQzOY5kGxVm5x44Q7bONssWO7Ht37lMTSrCoIQ=;
 b=kk+d18RBce4+hurwIhrME8lImTRWETovQs5x+wBtWl5OZQMZOCtmi/pu0fLBUZcsOw
 WfBVp1P9RYbuJp4rPw0V2MigZTXdcpFNvUTIswquF9YeL8Tz3bAoVaH5DctjdE7Tjo/Y
 dnQR6XapSj20GQ8BoUMXvHj86NqmHDCTsAyTQWYRKD1qQzJWlzGyRcixMtSIq7/u7ydj
 TwGqVUotQO5Z9EY4uTH4KBs/SBUvZ/FaH5Dk8J4KNPiWH+4cYPfYtC+SOicEN/22N2dP
 bLq2aiLbURHE7mIlYzoQBWSydTB/9tp+oBQn1KO4H1IebkOWlybHaszemA1WP45IMYsh
 CXjQ==
X-Gm-Message-State: AFuF++kwNmF6ODKtYd/hJU1xcOfOEyDpKGi5vtWUuKtkPuNcYuNdaiv/
 z9XLOo491aVABTSTDfH57rUklboxswiLGLtXbWegZ8x6TtyiCWcMg/5t26ppkQrfb1/SeYUI6f+
 bZnPc3WeFkGEI
X-Gm-Gg: AR+sD10NIi9DR9izo4jypqpTTMp8Ty/jxrA082Yjf/1JghxM8XUZkU+5XDhgaDpX+F3
 Q7JJKdSlfhvRQpAAFJ9+xhmnIfNoetK56R8m/hA00Gga43nRLA6WMK+HqO2q8mGHZnjyfhpruhl
 uRwtk0iTLx+2JTRteZnlyRFe4DKZbxlvJ0Ew+zWXGLjAEKPMUeHSG/ftnCA953A62uI87lmgde0
 esOwoammlM9AmlG1HBq2XZzRms/CaEYwQV4M0LkeqFT7vYQThCaiJcCPRBcWJZeyf+NsoNSH0p6
 hbTC7nYUteYQY9AjTV4xdRbQO06kWmJ0IBV2UiJV8qt+idkWoVhmnssWr7lErKMWyV6CmDqJcSo
 RPCldsp8yg9reaXekb+H78GHGl1gVCi9GKjon/LS9NB9KokEpPgsexTWHbFbTHaMndAASBkh9NX
 2d9RCZr7q1cWlkffwCL+F8WptwxAEppNE3KOHj9buHdXkIhrqBng2ire16lmZE+WwE+rSpUwuPb
 Nci+4JH9gd0GaUrcODNtkFFleksU3qNJ+Nbzoaoew9Qse5o8DwpC1d/LJcB4qTYVOEaSrCbBEBJ
 0MCgXCUYWkByaqc/B6E+
X-Received: by 2002:a05:6830:2702:b0:7f4:dd63:928d with SMTP id
 46e09a7af769-7f4f239231fmr3070665a34.13.1787866857630; 
 Thu, 27 Aug 2026 14:40:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c81d7c76sm4919031a34.4.2026.08.27.14.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:40:56 -0700 (PDT)
Date: Thu, 27 Aug 2026 15:40:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [SPL] ELF loader support - design discussion
Message-ID: <20260827214054.GG3959812@bill-the-cat>
References: <CAJM1RwPMXB8qLm4+4h_hBLqsq9=YBW_GndXroi5En4VGBVq-oA@mail.gmail.com>
 <20260826195843.GA3959812@bill-the-cat>
 <CAJM1RwNf4__=jf+1G8yGMsr42_gi0sJaos=WEBi3T9FbiwRA6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gWaVqDzl8vj8HrPW"
Content-Disposition: inline
In-Reply-To: <CAJM1RwNf4__=jf+1G8yGMsr42_gi0sJaos=WEBi3T9FbiwRA6w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--gWaVqDzl8vj8HrPW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 05:16:44PM -0700, Urvashi Sharma wrote:

> Thank you, Tom, for the quick response.
>=20
>=20
> Yes, I understand that SPL Falcon mode is intended to boot Linux, and that
> actually aligns well with our requirements. Our plan is to use SPL as a
> lightweight secure bootloader that loads a set of images and performs some
> platform-specific initialization before handing off to Linux. At this tim=
e,
> we are not planning to include U-Boot proper or any additional boot stage
> in between.
>=20
>=20
> Regarding FIT, I understand that it places image contents at their requir=
ed
> load addresses, but that is not really the problem we are trying to solve.
> From our perspective, particularly from a secure boot standpoint, ELF is
> deeply integrated into our platform architecture, tooling, signing proces=
s,
> and secure boot model. Our entire ecosystem is built around ELF. Having
> said that, Elf provides us many benefits that suit our secure boot model.
>=20
> As we move toward U-Boot, we would like the transition to be gradual, sin=
ce
> we do not want to disrupt the existing ecosystem all at once. We are
> therefore trying to take small, incremental steps.

That's interesting. Well, as I said, things should already be
designed such that you just need to add ELF support as the existing load
mechanisms should handle getting the contents loaded. If that's not
quite the case, it would be among the enhancements I look forward to
seeing posted from you and your team. Thanks!

>=20
> Thanks,
> Urvashi
>=20
> On Wed, Aug 26, 2026 at 12:58=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
>=20
> > On Wed, Aug 26, 2026 at 11:56:36AM -0700, Urvashi Sharma wrote:
> >
> > > Hi Everyone,
> > >
> > > Hope you all are doing well.
> > >
> > > I'm working on a use case that requires booting via SPL in Falcon Mod=
e,
> > > where SPL is the natural choice given its minimal footprint. Our board
> > > specifically needs to load an ELF image from storage (e.g., MMC/NAND/=
SPI)
> > > directly into memory as part of this boot flow.
> >
> > Note that "Falcon Mode" is specifically SPL boots Linux. So please
> > explain your use case a bit more, so we can help.
> >
> > > U-Boot already provides the bootelf shell command for working with ELF
> > > binaries: it parses an ELF image, maps each segment to its linked
> > address,
> > > and jumps to the entry point. However, bootelf assumes the ELF is alr=
eady
> > > resident in memory - it does not read from storage itself. This diffe=
rs
> > > from the existing SPL image loading methods (MMC, NAND, SPI, etc.), w=
hich
> > > combine storage access with image parsing in a single step. Since the=
 FIT
> > > and legacy image formats also don't meet our needs, there is currentl=
y no
> > > existing SPL loader path that can take an ELF image from storage into
> > > memory.
> > >
> > > To close this gap, I'm planning to implement a new ELF loader within =
SPL,
> > > built on the existing spl_image_loader framework (registered via
> > > SPL_LOAD_IMAGE_METHOD) that already lets board/SoC vendors plug in th=
eir
> > > own storage-aware image-loading implementations.
> > >
> > > Since this would be a significant effort, I wanted to check with the
> > > community before proceeding - has anyone worked on something similar,=
 or
> > > have any suggestions/concerns I should consider?
> >
> > The SPL frameworks, generally speaking, are around ${content} from
> > ${location} and then executing it. So at the high level, you should just
> > be needing to add "validate and execute ELF". But the baseline
> > requirement is to explain why you have an ELF and aren't just reading /
> > executing something in say a FIT image already.
> >
> > --
> > Tom
> >

--=20
Tom

--gWaVqDzl8vj8HrPW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapCu3gAKCRAr4qD1Cr/k
CjPiAQDs8/klOtWv4DtVMVrE+4CdiIyJaoD/ZykahZ7WPYi1EwEA7wNfhGJA6TYF
6FyBO4lzcY8A5MghdDkdSMudCMqg8AU=
=qp2q
-----END PGP SIGNATURE-----

--gWaVqDzl8vj8HrPW--
