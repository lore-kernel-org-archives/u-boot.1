Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11F606B9C4
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U7wWpk3H;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Mg0/wzgt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BE1440825;
	Thu,  5 Nov 2026 19:58:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wzn-0uRbetgZ; Thu,  5 Nov 2026 19:58:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0D3DF40818
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793908704;
	b=DR+LXdS9sHlO7KxiPVosk9+V0o96QbFXcIWF2ytGd6JOGVSnc2oybJk8zN3SEQmeWQ3t
	 7qC45EsZy6ZNK1ISYOrA4ZKpoOKsODs03RE8UJFSqeMKtiJQls4H4knhv81fJcTNABnSl
	 YLbvxX14tCrATCFc240QQIW3wXGj0vdTx5t3frlJvi1mk4canRZjxg6dofNIGr0ZYZH5M
	 Ov8bU2pM0kbXiWNwqW2mptKifZi85FBeT8lvaKqKpoY7X0sifNkzucFDxH99o+xpSmIVo
	 peLrILuBQvm271OS0wTyA8wiEwp/Iw/G9fu0dpITZz13/5MUzqyk8ArabgqEm4X9ldw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793908704;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JlqJtnfrA9k3XO7rZsr/r4MSN5mqyYkT8YhPG6+RX0o=;
	b=IRAvZ51Rc9YDMBVpRpKygA1TequBMSb8eCCymuPAXqTcYym0vJO7DalyYTuAVOJxTbld
	 aziPYg3RI8HGCSDSsHvLwT+IyhAa6utsxnWN1jjM2COGz7p41rXLj+qGon/rWfwSrR20o
	 M3r6NwOy2JJQBLAbieSWYki6fd0d+soJiZWl0u6HJ34O1H4pTAtAbPOwuzqqvmK49MyDi
	 TnPJPxY69zN7k5mQrsbVkOz6aAGbFTmO4kcLWZBvewKnvPbXFh5S3kFCMAU8+cZGSRj/v
	 PFn/zVYTR/e/m2LXLvfRfX3FQsbqwTrPrdujpit3DJ4QVFjVIpRnrr5BDgQR6geLnMg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793908704;
	bh=JlqJtnfrA9k3XO7rZsr/r4MSN5mqyYkT8YhPG6+RX0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U7wWpk3HA6J+exCBRtHiSpcLi9z0Nrjhl4Wk/lnZk7/UvFVD1PDcSJxSEkFrgsjVd
	 ujao9U96HHwAZHq7uIw/3LXgOYK94jrDHlKdBVJk6xkvwijXOaVkufTwbO0Pgkyx4E
	 q8CJW50jGC1v3c7rv1Qqg19VdpPIYj8lwRsMi/xGqeGfccV05nSRE3zmBE344qKU1G
	 7YQM8b0Cc/RYRp1Mrj+OO1BzQLYFMLudW7XqahPCK9uw+oseWUydtXtmALFjZ5JSMh
	 N88BChhtFlhudt5yn2KKkuf9H0hiOkGcUNSeJ4Wa16pT9jYYxu5wpX+YDW+mn0Mrit
	 +ea/rlyyQ7WUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D3DF40818;
	Thu,  5 Nov 2026 19:58:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AEF2280
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47FCD400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wdZJIPIGrOwa for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 19:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 669E740012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Mg0/wzgt
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 669E740012
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:58:21 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4c5d8c7f326so885754b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 11:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793908701; x=1794513501;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JlqJtnfrA9k3XO7rZsr/r4MSN5mqyYkT8YhPG6+RX0o=;
 b=Mg0/wzgtrKwe2szua/UKPYz5f2OlBs1z+XusRFlQ98W/TLA6hZB4Uvbc3l1ngmLq5K
 JWavB6k4kYingoaScJz8OiizHZ80Q9ZL0sn49WR7jCTonig8vfWUxS/yyr1z3zNZVfJj
 XIEMjZ5Qi+UreSOCfXwSI0GN4aI4aiy3bpSKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908701; x=1794513501;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JlqJtnfrA9k3XO7rZsr/r4MSN5mqyYkT8YhPG6+RX0o=;
 b=OMK+4LWeN6y7bX972IHrLmozLiugVxTD2AueWzHXJIrgu5lLbH9XG8ksO6UpHZtKP1
 IEAcUlrcokZVGSJqvWIoAgomE/8bK9qVghhlMETq6SdZbPBB9Ukx6Rd/i1iMRYHu9Elg
 5EgmZkHzA7WLZLTWthcIc8CpkFstTJ0lzo318l424pPxmp3pVWLiaJ3kPI+wW04RnM5f
 zN+iipL80VtrBYNnMDTQr9j9Vza6dl1jDzVsqRVAoA70f7iH4jZYvV+v8oZOW5GlAlVz
 w5z3wUW/TTU3RaJiHRRXqOLdkpmCWAqmpd4mVQY8ukuqO6LO/yBe7DdLaGCoda92jl0V
 yDgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3jGiZOuBnBRa8z06/cClromKgvwdEmydh8It1lvtEfVnhX4gKwWwviG9X0XlaZ1DO9HpK80o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+7DdTqqK7a9sPcZzZaLP6AQMePKcAY8i1/A2iw0eZKaFbGk9hx
 PjLzjf+7zD3Z5kuhdzr08z4Snv2YtfdV1k7MumuJUC0Lc32E6+VmiAUz2GHnOdDn2WE=
X-Gm-Gg: AYBFou0GRnSyA/4+rICj6meg9wnuXqCqQaOReJ6RIplE4Pc6OBZeXJUBRgac9mBnnWx
 GBK58AYlhSovAHYljRAv4b5rmLK64gyYg9FiF7ZA+WSeQff/B1qvD1h1O22AbcihD8eABIxHBil
 DBKPhRgslAdgIB2EeWheX38s5p8HLNBmPXdEDOfJPpr3MlHQF3QyT+BMqv4TSDxbgIkwNArmMBH
 QOgS7rVL+we5qviaAeciwvStrN+N/ru3s0UiRf4yvSNEmp9Uv+Mep7Xc/Uij4BPOKN111wXR5Vo
 pi7TlE1L125QBst7twj4Aj97frZ/lsyGW9zbDTo9sjBkxu0aOhNxi4S8F/uFJQEL6zQwDO8TAlm
 szlZ3xaV6XfZvb/JkTcqdFqjuek76rRVLO22UosZ9VZqhKVKDOrUAl15Djn9mryR9dOzyevTEdl
 RVNohU1kttvYqZXRVnDSxqtEFa9vwyW1VJW6H1Z6KTpmGMjkRWPAQNapMqN/xGhQMfzcuxyA5xW
 D3e0oMmYzSgq48sGxiahH7/O1tSkm+wCQv1VEW2sUx2etrg5J2+ShqSRCTc7BVCPMrkUKUJ0xSH
 /1xpDgvyyZ5Fq1+WqoRXtnvnj+fMv9klMS8jszwlGThFLiAZsSbbLpXFJxh3amp2AdOX9AeVGnw
 lDyE9FoQHm0wnXf3BXYhMx9l6clxIAnXRQnJEArv8dW/EHdwt6/psCHB0RZrGUn2ZYkmsD2rTLJ
 szhR3fVcHWeg4fl9dKW9NkZ5/l3kj1dA==
X-Received: by 2002:a05:6808:23d0:b0:53a:a080:249b with SMTP id
 5614622812f47-567e1597ceamr148802b6e.41.1793908700889; 
 Thu, 05 Nov 2026 11:58:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9c7bbcesm4933262b6e.1.2026.11.05.11.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:58:20 -0800 (PST)
Date: Thu, 5 Nov 2026 13:58:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
Message-ID: <20261105195818.GQ1164024@bill-the-cat>
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
 <902a93a7-df59-436b-b959-ad41f7d64f19@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H3QsAbaVG1wuQltl"
Content-Disposition: inline
In-Reply-To: <902a93a7-df59-436b-b959-ad41f7d64f19@mailbox.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--H3QsAbaVG1wuQltl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 07:25:05PM +0100, Marek Vasut wrote:
> On 11/5/26 3:42 PM, Tom Rini wrote:
> > On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
> > > On 11/4/26 3:29 PM, Tom Rini wrote:
> > > > On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
> > > >=20
> > > > > Add conditional around REMOTEPROC menu entries, turn REMOTEPROC i=
nto
> > > > > configurable boolean, and update all defconfigs and Kconfigs which
> > > > > previously only selected REMOTEPROC driver to also select REMOTEP=
ROC
> > > > > itself.
> > > > >=20
> > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > ---
> > > > > Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > > > > Cc: MD Danish Anwar <danishanwar@ti.com>
> > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > Cc: u-boot@lists.u-boot-project.org
> > > >=20
> > > > Unfortunately this misses some handful of at least TI K3 platforms.=
 I
> > > > think using qconfig.py to confirm which configs have REMOTEPROC set
> > > > before / after, and that they match would make sorting that part of=
 the
> > > > problem out easier. Do you have time to do that, or should I pick i=
t up
> > > > and do a v2? Thanks.
> > > I can respin this, but do you know which platforms got missed ?
> >=20
> > I lost the list, sorry. It was a number of the r5 builds. Perhaps some
> > fragment got missed? But qconfig.py -f REMOTEPROC, with a db built with
> > and without the patch will quickly show which oens it is.
> I have this in either case:
>=20
> am6254atl_evm_a53 am6254atl_evm_r5 am62_pocketbeagle2_a53
> am62_pocketbeagle2_r5 am62ax_evm_a53 am62ax_evm_a53_ethboot am62ax_evm_r5
> am62ax_evm_r5_ethboot am62dx_evm_a53 am62dx_evm_r5 am62px_evm_a53
> am62px_evm_a53_ethboot am62px_evm_r5 am62px_evm_r5_ethboot
> am62x_beagleplay_a53 am62x_beagleplay_r5 am62x_evm_a53 am62x_evm_a53_ethb=
oot
> am62x_evm_r5 am62x_evm_r5_ethboot am62x_lpsk_a53 am62x_lpsk_r5 am64x_evm_=
a53
> am64x_evm_r5 am65x_evm_a53 am65x_evm_r5 am65x_evm_r5_usbdfu
> am65x_evm_r5_usbmsc am67a_beagley_ai_a53 am67a_beagley_ai_r5 am68_sk_a72
> am68_sk_a72_ethboot am68_sk_r5 am68_sk_r5_ethboot am69_sk_a72
> am69_sk_a72_ethboot am69_sk_r5 am69_sk_r5_ethboot aquila-am69_a72
> aquila-am69_r5 aquila-imx95 imx8mm_evk imx8mm_evk_fspi imx8mn_ddr4_evk
> imx8mn_evk imx8mp_evk imx8mq_evk imx93_11x11_evk imx93_9x9_qsb
> imx93_9x9_qsb_inline_ecc imx93_frdm imx93w_evk imx93w_evk_inline_ecc
> imx95_15x15_evk imx95_15x15_frdm imx95_19x19_evk imx95_19x19_frdm_pro
> imx95_a0_19x19_evk imx95_navq iot2050 j7200_evm_r5 j721e_beagleboneai64_a=
72
> j721e_beagleboneai64_r5 j721e_evm_a72 j721e_evm_r5 j721e_sk_a72 j721e_sk_=
r5
> j721s2_evm_a72 j721s2_evm_r5 j722s_evm_a53 j722s_evm_a53_ethboot
> j722s_evm_r5 j722s_evm_r5_ethboot j742s2_evm_a72 j742s2_evm_r5
> j784s4_evm_a72 j784s4_evm_r5 k2g_evm k2g_hs_evm phycore_am62ax_a53
> phycore_am62ax_r5 phycore_am62ax_r5_ethboot phycore_am62ax_r5_usbdfu
> phycore_am62x_a53 phycore_am62x_r5 phycore_am62x_r5_ethboot
> phycore_am62x_r5_usbdfu phycore_am64x_a53 phycore_am64x_r5 phycore_am68x_=
a72
> phycore_am68x_r5 r8a779g0_whitehawk r8a779g3_sparrowhawk
> r8a78000_ironhide_cm33 sandbox64 sandbox64_lwip sandbox sandbox_flattree
> sandbox_nocmdline sandbox_noinst sandbox_spl sandbox_vpl sc598-som-ezkit-=
spl
> sc598-som-ezlite-spl stm32mp15-icore-stm32mp1-ctouch2
> stm32mp15-icore-stm32mp1-edimm2.2 stm32mp15-microgea-stm32mp1-microdev2-o=
f7
> stm32mp15-microgea-stm32mp1-microdev2 stm32mp15-odyssey stm32mp15_basic
> stm32mp15 stm32mp15_dhcom_basic stm32mp15_dhcom_drc02_basic
> stm32mp15_dhcom_pdk2_basic stm32mp15_dhcom_picoitx_basic
> stm32mp15_dhcor_avenger96_basic stm32mp15_dhcor_basic
> stm32mp15_dhcor_drc_compact_basic stm32mp15_dhcor_testbench_basic
> stm32mp15_trusted toradex-smarc-imx95 verdin-am62_a53 verdin-am62_r5
> verdin-am62p_a53 verdin-am62p_r5 verdin-imx95
>=20
> Do you also have this patch applied?
>=20
> [PATCH] remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC

No, because I thought this patch replaced the other patch, sigh, sorry
for the confusion.

--=20
Tom

--H3QsAbaVG1wuQltl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauzf0wAKCRAr4qD1Cr/k
CgQoAP9YVR03dpfQ9OUhC9Pt/GsFvbGufiinSU7MZsOr8j6ISgD+J+zc0YcuYJRq
TBg8R3r0Z6ukQkPmwVOwgVhSLnhISA4=
=43T+
-----END PGP SIGNATURE-----

--H3QsAbaVG1wuQltl--
