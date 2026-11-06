Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A1606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rICPq6KW;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=S0HoXH/g
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3306B8142A;
	Fri,  6 Nov 2026 18:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFyQ_YNemP1T; Fri,  6 Nov 2026 18:17:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52DFF8137E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989021;
	b=DRa64cT6WpY3TkjrBWD1LaaC8u+JsXaH6SYMGNdWD0ZDGgeXxuqrY2LozbY56LXTbuSy
	 yKj2MXSV3HSc9Cq0jhrZhe93aB8dPaphhLYZvcmZNIFCK015SW0Lv/sgY9lmfapo4IaiW
	 Kqz7pv/CPnwAHtiSCOIi7qoLCdCZfnqjuEBPiQAxbSJNbxN1iUKBRpSQddTKeK6CVc6f9
	 X2VPGDRlXDV2SVgggSu905eKw8kVjm/sQhvOfw7CcQ4Ryh8HPtQOat3zmUZZIMuP8fmju
	 tBsMiZ/QmI61GEQT8ly5a0nroKTVtcSEujzB23A0w8f6nYjdWusW0eXlPsoZDPNd8Ug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=stQrZkUMEFd0dizJCD/WNclBpFzTU3gwVBKEIraqggc=;
	b=oS3sLEZlqs60szOqshiBMFpONJBGlVOq462YW5xRmGNSr1cS3vHkeOZZD1PNTpNwdJlR
	 sJCSIPefXJbh75pDxY7lAzp3f4b7CCNkf3sJA8fJ2nja2qbhqK/CrbfK7r1FLzW32UTJD
	 prAqwjoIvRbOk6rTRoliQH9+thd+zO+d/wExpd4SxEj9Uj8luHcCNC2YFWIULXIDwPpOH
	 PuPEl1zQd6e6nn48lw1r7NI4Cg1c0DbzSjdMcGCdYcwvPAo64m6mY/otIM7JNdyrDNh+/
	 qHN9XXTW0fM+We9h0wwTJ2g6qFjW4Tav3ZgtrMg4R1XPmTR54rE+4qlzMo1AMdhiEWQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989021;
	bh=stQrZkUMEFd0dizJCD/WNclBpFzTU3gwVBKEIraqggc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rICPq6KWC4744qlB5EBROcQehhn/tDG7MEmJ7n5wcStOCyYiwEl5muTxfE+2Pby2A
	 0eVHrnUtKWzzdvbKaj5PcZj83/ykXWRfviBDFQXYZtW4GiTykuF4PYun/Zq7QvCwp0
	 Xoy8k2cKfSPmSCc4Rl/QI51xO8+0ZrbqPk1s4KeWidg0z1jqDxLfAORvMLOROdK6S5
	 g1Kc1UccstqE66DmiQJcBjsnSh67k+9TNQwkngMRys/yTwsJETwFMkZ3Ah4DMZcmrC
	 O37N42LAwld2K3dwgCj4hDfdHLn8WPt4tZ9/ai+tK3XP21w6U8lU2UrBLLabFRPE4u
	 2AhdChSH2XykQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52DFF8137E;
	Fri,  6 Nov 2026 18:17:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CA5144B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBE17403D8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gX2Nu4DBycZE for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:17:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D9E29400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=S0HoXH/g
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9E29400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:16:59 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6b8e2d8df4fso618714eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 10:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793989018; x=1794593818;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=stQrZkUMEFd0dizJCD/WNclBpFzTU3gwVBKEIraqggc=;
 b=S0HoXH/g8epcI2PAzHTuzdrzhiRXW3WdhF1BeGLlsEJTSWj22HN1vgpVALTVHGpP7O
 HLHdM/TlKoR9NjhnWVO4WlJAlO9h3KAIq+ZTupJMS3zNNNDSkEPEV29MAOLC0XxHtAJ0
 IH1kXyjl/kuelI+kmHoZ+mp5/Oj8Q0UZZ84cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793989018; x=1794593818;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=stQrZkUMEFd0dizJCD/WNclBpFzTU3gwVBKEIraqggc=;
 b=0uSmIOe7yWfoc3Pr0nQPhK8vixzbrtoqNH6Ysaa8iMYppAuFJ5II5LxNtTmhWmtZgQ
 ge/LO8fVE1AxQ80frIZ48Z6lUjHL5EAyT3/VeFzxGbkKT3Rgdmvw7fM+6XRqJddReBi6
 4RfttQNUcOHnylyWu6X0b+hKjbUMA7+HRWTFKmCKO1IlsL4jfYJLRrQ0mmkUt3xgakWH
 IPapAp9tc8E5pvb6xyUh6fMhpQFDZaI9XBjq5zjWcfYFBiVNGYMHAT1d82sPdKY5SsZr
 VnsRNBzMfzN0Jtf0yhRbX5/wrkrcAs6xjeWbqmCAeDosWxj7Bt2EPb6n+s/PnjPWzUNb
 5J/A==
X-Gm-Message-State: APuU4Z9EuTK50ECR7CzSQAvLXtDBZodkmneawelhaf2V97QQxL0Z1s/y
 3yfVW6VeU0t8sJfmnliDPQx0CH5HkZ8A85QxzNuQ7l/d9F274X2rNxBS6cqJBUMMAGg=
X-Gm-Gg: AYBFou388baS5N4COjLeJNomw8qn4WG+BWkIvWcZnyLHMj70y6IOb9ma7uuApBLlUY/
 WPSnOQjhzx+/hOjoIU5c1HhfMj3B3u0jG1kxHRKv6ByCghLWxhXzntUNzu9j3BnQLt8Uh+qNAs1
 N+3QwEbSZL2mQHqno2LFve/1MHoe4FNnBCnkRoFxyuXV+QrueagwVCPFENZGK07eU4XoEDkW1Tb
 HRanVn/BkF0jOfARkfTQCVYW3zTzompVZ6Xl4QvanxqexxGvUF35nWAHBmsPhNcms8/LxR8fRgp
 NB2z53nF9R3wjhSklCOU4+QxSLca5aorbuRK7ESmyoYb8FSMUToggatq9gqPLCI/3E84y56p6wy
 Tdfa0+PoU0DbcX1PdJR4ozSifIMELLXtT5PeYLdOdnna3Tc6QCI+vWpW5YTtbUrHuoT6Qx5mObu
 mtgWAaFpDTgZTAR7p1aY2CiNKRmidqE9WWuY9p4gWEyhiFaKM3+rxwBHtKi3XHIMDfRr02/frlD
 U/kg6LTmvi8ObcmPN69rnPWI8Q7VkWledJqTQe4Ngb0rKIK0S/ySZmyCga5n19O5YeyeLC2IHUo
 WXdP4cAYdBvpowzlHK9Kbqp9GFyckGGxJ5Sm7owb3al581PpFkw6iphvMVyqyTmatdkeMnbnr5D
 GCjDpV3hkux1MLhX5kSr82e8HdFHZylh10nam9+2s4sUeJl43yxTfAxlkm9ifgYjiSea4+azq+n
 lyLDJBSPuRUnekPAZWncSQAV+De51mfg==
X-Received: by 2002:a05:6820:2484:b0:6d8:ccbf:a7c2 with SMTP id
 006d021491bc7-716e7a47935mr1646336eaf.68.1793989018453; 
 Fri, 06 Nov 2026 10:16:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716ea131197sm2100554eaf.11.2026.11.06.10.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 10:16:57 -0800 (PST)
Date: Fri, 6 Nov 2026 12:16:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Mateus Lima <mateuslima.ti@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Alison Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/6] armv7: ls102xa: Apply erratum A-008850 on all
 LS1021A boards
Message-ID: <20261106181654.GE3669968@bill-the-cat>
References: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
 <CAP8WwTHaAnbrpwcFQd0MZdH_jUxpJQf8z1XyicRaOhW=qKHtJg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xKndUu6IwODgBeJv"
Content-Disposition: inline
In-Reply-To: <CAP8WwTHaAnbrpwcFQd0MZdH_jUxpJQf8z1XyicRaOhW=qKHtJg@mail.gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--xKndUu6IwODgBeJv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 02:39:45PM -0300, Mateus Lima wrote:

> Hi @peng.fan@nxp.com,
>=20
> What changes were requested for this series? I noticed the status has
> changed to "Changes Requested," but I don=E2=80=99t see what those reques=
ted
> changes are.

As to be clear, my comment was for a follow-up and not needing to be
done here and now.

>=20
> BR,
> Mateus Alves
>=20
> On Sat, Oct 24, 2026 at 11:00=E2=80=AFPM Mateus Lima Alves <mateuslima.ti=
@gmail.com>
> wrote:
>=20
> > Commit f9147d636ce2 ("Convert CONFIG_CHIP_SELECTS_PER_CTRL to Kconfig")
> > made SYS_FSL_ERRATUM_A008850 depend on SYS_FSL_DDR, since soc.c includes
> > fsl_ddr_sdram.h for the DDR_EOR bits and that header needs
> > CONFIG_CHIP_SELECTS_PER_CTRL. The ls1021aiot and ls1021atwr boards set
> > up the DDR controller in ddrmc_init() and do not select SYS_FSL_DDR, so
> > the workaround is silently compiled out there, even though both boards
> > still call erratum_a008850_post() from dram_init().
> >
> > Move the two DDR_EOR bits next to struct ccsr_ddr in fsl_immap.h, drop
> > the fsl_ddr_sdram.h include from soc.c and select the erratum again for
> > all LS1021A boards.
> >
> > Fixes: f9147d636ce2 ("Convert CONFIG_CHIP_SELECTS_PER_CTRL to Kconfig")
> > Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
> > ---
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Peng Fan <peng.fan@nxp.com>
> > Cc: Alison Wang <alison.wang@nxp.com>
> > ---
> >  arch/arm/cpu/armv7/ls102xa/Kconfig | 2 +-
> >  arch/arm/cpu/armv7/ls102xa/soc.c   | 3 ---
> >  include/fsl_ddr_sdram.h            | 4 ----
> >  include/fsl_immap.h                | 4 ++++
> >  4 files changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv7/ls102xa/Kconfig
> > b/arch/arm/cpu/armv7/ls102xa/Kconfig
> > index 9ce94555ed0..70170e735be 100644
> > --- a/arch/arm/cpu/armv7/ls102xa/Kconfig
> > +++ b/arch/arm/cpu/armv7/ls102xa/Kconfig
> > @@ -9,7 +9,7 @@ config ARCH_LS1021A
> >         select SYS_FSL_IFC_BE
> >         select SYS_FSL_ERRATUM_A008378
> >         select SYS_FSL_ERRATUM_A008407
> > -       select SYS_FSL_ERRATUM_A008850 if SYS_FSL_DDR
> > +       select SYS_FSL_ERRATUM_A008850
> >         select SYS_FSL_ERRATUM_A008997 if USB
> >         select SYS_FSL_ERRATUM_A009008 if USB
> >         select SYS_FSL_ERRATUM_A009663
> > diff --git a/arch/arm/cpu/armv7/ls102xa/soc.c
> > b/arch/arm/cpu/armv7/ls102xa/soc.c
> > index 7ff59edd452..60f63da73f8 100644
> > --- a/arch/arm/cpu/armv7/ls102xa/soc.c
> > +++ b/arch/arm/cpu/armv7/ls102xa/soc.c
> > @@ -12,9 +12,6 @@
> >  #include <asm/arch/ls102xa_soc.h>
> >  #include <asm/arch/ls102xa_stream_id.h>
> >  #include <fsl_csu.h>
> > -#ifdef CONFIG_SYS_FSL_ERRATUM_A008850
> > -#include <fsl_ddr_sdram.h>
> > -#endif
> >
> >  struct liodn_id_table sec_liodn_tbl[] =3D {
> >         SET_SEC_JR_LIODN_ENTRY(0, 0x10, 0x10),
> > diff --git a/include/fsl_ddr_sdram.h b/include/fsl_ddr_sdram.h
> > index 182f5836533..650bfc29b49 100644
> > --- a/include/fsl_ddr_sdram.h
> > +++ b/include/fsl_ddr_sdram.h
> > @@ -146,10 +146,6 @@ typedef struct ddr4_spd_eeprom_s generic_spd_eepro=
m_t;
> >  #define WR_DATA_DELAY_SHIFT    10
> >  #endif
> >
> > -/* DDR_EOR register */
> > -#define DDR_EOR_RD_REOD_DIS    0x07000000
> > -#define DDR_EOR_WD_REOD_DIS    0x00100000
> > -
> >  /* DDR_MD_CNTL */
> >  #define MD_CNTL_MD_EN          0x80000000
> >  #define MD_CNTL_CS_SEL_CS0     0x00000000
> > diff --git a/include/fsl_immap.h b/include/fsl_immap.h
> > index 54d6e0ab377..759a484a926 100644
> > --- a/include/fsl_immap.h
> > +++ b/include/fsl_immap.h
> > @@ -136,6 +136,10 @@ struct ccsr_ddr {
> >         u32     debug[64];              /* debug_1 to debug_64 */
> >  };
> >
> > +/* DDR_EOR register */
> > +#define DDR_EOR_RD_REOD_DIS    0x07000000
> > +#define DDR_EOR_WD_REOD_DIS    0x00100000
> > +
> >  #ifdef CONFIG_SYS_FSL_HAS_CCI400
> >  #define CCI400_CTRLORD_TERM_BARRIER    0x00000008
> >  #define CCI400_CTRLORD_EN_BARRIER      0
> > --
> > 2.43.0
> >
> >

--=20
Tom

--xKndUu6IwODgBeJv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau4ZlgAKCRAr4qD1Cr/k
Cp/BAQD34H9VWxEdUFQqniw61SMtnEuUDromvo23QY/i0PoCKgEA0dz3HUkKHqUr
xTa8MnXFebDbdI4hWgGQlSC3nyA0LQo=
=ou6R
-----END PGP SIGNATURE-----

--xKndUu6IwODgBeJv--
