Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA9606A329
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ErzJTnEV;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=K4fneeEE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 679C280F1C;
	Wed,  4 Nov 2026 18:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mn4NRSLzazUi; Wed,  4 Nov 2026 18:30:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AAA0780E39
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793817019;
	b=HLWaf2+HebmGP8aZ8l1fZ7GtcKJxYVIyNesqVQMewofQh5IMnetDc7DOby5ym57lr+05
	 H6D0Oc+bVkFsdeIpSLB5a4i/sxmeFj67uGC+HEUKz5b2yCJi4+rvAep1I2e63BQ3cDZft
	 hjP75Fl36u9ONjRStwJRAD9HQ4kVj2R23vDCceB3W6Z2pDG888r3G/fkERyMv+TlSLzMe
	 R96r67i5/LIq+2HkRHgcrDNnn2Ix4kgY22f6v1d3ozehxasv3bgCLbddWnRoOF9jDEdyB
	 zMLbaK3YvVQUJL93YSUOm1+ZjvhjmrsjSYa9HlfXsPOngocpPKexG5LHsAysGZ4Nxnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793817019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WTeAwyWqVn3GSaf4M18+pwnEA3yYEZxF1xDPD+9uR24=;
	b=qFEQKZq3QQZioov5+igeN/ruunM1pznHq4OeqZ0Lp0ge9VOr/bowdpvBAgFaihX3LjlB
	 oIY2A22RcyfgEPoQqM29CnfnFc/q+VKcmHj+UIVz+RKcifsr2Mjw7T8OnktuwypWer/sf
	 lOMRfOI4VXYDv437Ug1Q0ArEA+YJabGsQO/qx3OkcCVkgjt4pLYGyO8NaPvSXbsUWNr4v
	 N6HONtjaLczMXLtaEpPARmPIHVXP8+DQ08VtzfSWYL5Rw4tPJc6HZIrZhZQK+UquSU+JJ
	 oCmKeG/Chk+U3Fw9fSa6FxxVD16qqstUT2ZFvXZ9ORK79RZOJ72hRUO0AyV6aG6fxtA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793817019;
	bh=WTeAwyWqVn3GSaf4M18+pwnEA3yYEZxF1xDPD+9uR24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ErzJTnEVltfemgCxCGHwcDrp6fkm3HRh4YgPGsBDmqQCEoRucwSN7PxQES0lFtVEU
	 tLRdhDWVIUdWFuH9AGNolRRb5rBMT3s6U4bwhee3IFdf2ovDa/QYGGSYjKRIQXVy1p
	 F8zWQG43u+wtjBV0QFrY8XMi4NGIMBxUBjult82YCVgts2/JFcavMKzspRz4r9TrsH
	 MuNPaloZjOfkOiPeM4TlqXqgYMcoA6S99qfdduzgq/+IIRLunaHdAD6e5TKFcp18pv
	 Ed3QGwF9xaqM0ThUDM6oaf4Ak69RwdgqZhtnlJW+aMHuzi2JAdMMVbdYMaRCY7wiIE
	 WHxymoK2rKiUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAA0780E39;
	Wed,  4 Nov 2026 18:30:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D647177E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 18:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EDDB60697
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 18:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OINd_XuuCqh2 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 18:30:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CACDB605C9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=K4fneeEE
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CACDB605C9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 18:30:16 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-703be215729so425464eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 10:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793817015; x=1794421815;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WTeAwyWqVn3GSaf4M18+pwnEA3yYEZxF1xDPD+9uR24=;
 b=K4fneeEE2nM0ypOSCQD/H0YFY6qCgZO7InVW2KnhYgSdAJMnLOEcYjPHfxsx9YokSz
 /5sd6wA8LWYOlvZFu1dyGnQmhTZTlFaRI+crBGiEpAEwvjltalU1ZOoVV62xpbt27nfD
 7TaQp4HNvPxCxEvkfjp/L13qS7yTlcS0guqMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793817015; x=1794421815;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WTeAwyWqVn3GSaf4M18+pwnEA3yYEZxF1xDPD+9uR24=;
 b=u/fxCh3mrmR76m0vQ2kKRzA5lYysoC+47V9UDZ0Ub+70hGVDFbrtyzIFNqLgZAHLVd
 V4hdNCmh9c0OE4GOmDMQtR7w0uxIqAPpOiHa1i4n3WCRnxsqs/YGTk2psPdvIcbAvYVI
 fK5bCMYM33ceFa+UoWE4ajPIjKSPnep7iV9DVlrdhy9Ru5sJ+TWjJARSzhPbWPys1A3f
 QjPVgxV5EmNUIHaoEZe+0FcPB6HqaiBr8aC7VkUsMaCI+VsQqBOsoLwzs4tuN2dB6NTO
 +rqP/WAdRLLoi/xRg/iz2FCtcwMijfE3aD8VG/CBtEbrj76dvfxAQFHjGfXfLeDjZlep
 lNbA==
X-Forwarded-Encrypted: i=1;
 AKwUvByq/IZjbLo0zZcjv+7n6qvr0xR4yjHVr8s8PS3SiX17ebLEKrnokPwUJ65HduY9ecXjqoZvjNQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ftMrSC7NjZiJBDcF+QNGwxSi5mChUHc1qnkTi9m1SQCVyqy5e
 6WUMNAcSkOrVvqA2uTBml9X9hcJRHIgl8fxrftpEhuiK18QHaw6aS6mZXA18GqHq1xg=
X-Gm-Gg: AYBFou1b8PLZ+s4xGNMWe+qlCcqT3mA8eGw7B41xueqL5RPFIEvNPjOCLn0cWpI3Xfo
 4tvIGWd8MxG3xGMyfoWXfl+TprCs118icjSDR3ab+vEUCMdeTTKCixs3tyrs6mLuiDstcaR6EVY
 fo5/jPabpv3l1Vj1OttUgkJGLUjpGrsEvOPgRKwwhPcCARlzmCJhOT/3k0D0k9T0UeLp7LYf6u7
 74DWUPK+vgEEFBaDf73J7Jr5qXsoEHvtA2o9xsoBOIQM3nOclCl/O/zCyqYmXT4hrVfP2ANXQFq
 lKbvY2lZczFlMw3k/YclCgrmTxkL0pHACeXNFAYpLGtmO6GrHsLHN8ID2GIQk46RE5zxdG5yeWX
 b5EUtJ7WyOZpcVMGwEYqvnOP0xqZadH8gLKfaPs8LBI2tVsfK2Auw4dlRZuNnwA/Zsb/iWP0/Ss
 GrTeBlQrCvcF3Y0/QRUmLUjM6ZVgHYFweH8RBkzEAsTPq7lZbTEZHi7f5W5tX0z+L4pCMwh/kmz
 QnP2W0tdwjiG2rz8X92IeNuUVCHjC8nkO5C2p5kweaus7KKqTZmnU6ClY57M7nJq9okHpitxTXr
 xC/Q/j0jDHCAl9jRlxnY6p6ajfI3a7XF2NHuFIGbop50xmPOLT5MjEOKD3WzwDaxFBn5ciEkkVv
 DAIUkl6ETV+2RmZRbXQrW9heXzaNImzWRwMN5hoH0FDukLQ+GXCU9UWoRL5n58cdFqR4r5riz29
 +c1Qi4yWUDOfvqVFblS4Mfu/SwnVGu+KvxvKoo89YWPK3hbBlEHbs=
X-Received: by 2002:a05:6820:1693:b0:713:e404:7f86 with SMTP id
 006d021491bc7-714f2a0012bmr9524293eaf.54.1793817015146; 
 Wed, 04 Nov 2026 10:30:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4acea6c56c2sm2520234fac.17.2026.11.04.10.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 10:30:14 -0800 (PST)
Date: Wed, 4 Nov 2026 12:30:11 -0600
From: Tom Rini <trini@konsulko.com>
To: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 msp@baylibre.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, vincent.stehle@arm.com,
 daniel@makrotopia.org, francesco@valla.it, anton@binarly.io,
 aristo.chen@canonical.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 0/6] add Nord Ride chainloaded UFS SPL support- #194
Message-ID: <20261104183011.GA1164024@bill-the-cat>
References: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wjuxW/iywfo79CXX"
Content-Disposition: inline
In-Reply-To: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
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


--wjuxW/iywfo79CXX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 09:33:52PM +0530, KR Sowmiya wrote:

> Add chainloaded SPL support for the Qualcomm Nord Ride platform.
>=20
> This series:
>=20
> Adds Nord-specific SPL entry points for the XBL-to-SPL boot flow.
> Supports loading TF-A, OP-TEE, and the U-Boot FIT from the UFS=20
> uefi_a partition.
> Adds the Nord SPL linker configuration with a single-segment ELF=20
> layout and 4 KiB alignment.
> Enables the required SPL device-tree nodes, including UFS,=20
> UFS PHY, clocks, pinctrl, SMEM, UART, and QUP.
> Adds the Nord SPL pinctrl configuration.
> Passes the optional FIT TOC FDT address to BL32.
> Adds SPL progress messages for FIT image loading and BL31 handoff.
>=20
> KR Sowmiya (6):
>   pinctrl: qcom: add Nord SPL pinctrl option
>   board: qualcomm: nord: add chainloaded SPL support

I looked at this patch and saw obvious problems in the two files it
changes. Please take this back for internal review and don't repost
until it's had some, thanks.

--=20
Tom

--wjuxW/iywfo79CXX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaut5rwAKCRAr4qD1Cr/k
ChvzAP41Qs5gzpEiOqgfhtEoxiIGT6AQP1OGp2lys8tU8F0ohAD/Z+8exLY6CcCa
JdYvCGIlrckndNdr39qbYpysbVTR0gI=
=aoTT
-----END PGP SIGNATURE-----

--wjuxW/iywfo79CXX--
