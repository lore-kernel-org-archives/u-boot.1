Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31E606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iswCDjDg;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rzhLzWsT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44B1A60874;
	Wed, 21 Oct 2026 14:37:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qw70DFGGDriw; Wed, 21 Oct 2026 14:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C5866084C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792593446;
	b=GlJeYnaGqQ/AAfW0PhcBhxnDM7K6QAG2WDhu75i1F6Is9eyuxGmUYCu/rXSfGzKlVTjl
	 PvPJLGaP/7UE6UizC2heEIXYWIyd4SuwXThPtwKqzeh7fWlliv+6CEkeSAcCk95EJOCsq
	 RDwxKlRZDd4fPRI1tHrymYzpDzqbtAD2kFwdBGiOAFjqnAnLxVWWMdOoj0iQS2gzEK6D1
	 LWir/xcQbPCahQhoyogIsL2ord6BJJAzcc2vREiM0eB6ywq+j0bwnzi6LX6Yh6rzzjU/P
	 LX3eyWuPcwm0Y8nhpXjigOvQKfRep3W7ktOJq+5wScCHhri0gsGqD1yDK7QvAZOl5vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792593446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OsGTniFc1m+y1KhKU69Ts4iGhbzTgNU0pIimbfhnr6s=;
	b=kkS/Xy4Mu9xLcZnHbbk/BOW7gGtBosit3U8Jtyq1PgGNr0aiOU47sZqgXxByOEuI4mkY
	 aIMURofHQfebOFMVeBYyt4nj1+jPTuIMIOHJfUsDUCNiTgBbIuiIffIdqJPK6k3aj2B2Y
	 Mp28qYAu9QP1xLE2IiRFESgstsJ+BNc6QgHPU1e8iSLxHcoHkaau3M/UXFmndDTK+oCgS
	 w3OFGlZ5kxPa+2deBBJMpeRek70PC076ERSwqdEihtYJRbJUCeCupjZy5z1zfARkUaeux
	 cDN0t/Y/VnWkB4zpOZxtC7gK9QHlZrt4znoNjb1lpodKSgEOSlUrVL9U3LefPAcqf7A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792593446;
	bh=OsGTniFc1m+y1KhKU69Ts4iGhbzTgNU0pIimbfhnr6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iswCDjDgNKKxG2BibKBjBwZcwxyMvfZFK40ITrJCamo2mcz9BwiTWMN4fiVW9/h3p
	 NQNBFzexnIpKUjI+JUjuoKFCfwELmUEXqNRm4MgCqFZD/cWP1XH3Xdn+ZHiyucHQXm
	 DwHB1UoLptLnTZ7RIp743I8I3QJkpdEd92KfkV08kV56hvPFnvEJNso+FEdRmqbVUG
	 2Kxhryo/3haXYf0PTsmizuyYum1S62sGrcsXItirjn0pX6s3KwIFNJt1jnEANGVdCz
	 mlkoV7UKs3ubmFeTjJZ32Zcnq3Uzj4wac+slqbxcQ+fwArd/9NpEezFVBQE5l//OjU
	 WFKAwfith0TnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C5866084C;
	Wed, 21 Oct 2026 14:37:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC2CA3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9BBF40752
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VoTkCCXTCMWQ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B9B6640660
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792593444;
 b=YjcyvkH3GlOTjH35PaE2ivz+gs4PI1GQVoIqmr/DOS1U8lBc51qx/YNeI+kMxSZwo6zd
 Rv5K3TLi8sIY4JDkR490zaug8oRTfjXxOfoFXXiHxyjT8RB1y4HsE74mMTg+jAn3lLItt
 QECtnsgisC5JKzztQre2Xia56U8yE7Ab5cKNCNUiq9wuZMl50vg7kNz0i1ki05624kh7M
 A4OnLQf4J6VdD6gH2uDK4pAo1uqsOubds0U8DWoRl4DcRwZ/xL3quRpXGBtTEpUp/3oal
 QP2b548x6nEvAvYXSgjkzp/vGdgLUWCvddoiOt+6WBi8H/JNKRCMHeU1v8cN7MpMHog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792593444;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=OsGTniFc1m+y1KhKU69Ts4iGhbzTgNU0pIimbfhnr6s=;
 b=fZouMSH//eyEuOJqyYx8DBdjFCqqrbFdXjTgDQnfVCRXBW/uIflW/4kDKKFiSkTbjaLc
 9q/KEP7QFAQGVsug9+HL0PXcLXkt6T+hM3mRViI6fSGgIQ+u6Heq0+9cYG5mJmibCmEsR
 xAN9aUSb5fc1ep7NI12RFG7xPZkvMOSUFbA4q8HJEe97ETDieD8faizX0evC1ZK+G2UYH
 AG9z2prwhTRkuYwbYHrFbfboi5ewBrcX++a4/1fe1ke1uF9MFiXH58czsDzoaHaHRG+nZ
 vOk2DXLZgq8n9CuvOfm5vnR58v0sOcnZRkYZEiMgRiAj6EYoc8foW/AkCyT4u9in6Yg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rzhLzWsT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::a;
 helo=mail-oa2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rzhLzWsT
Received: from mail-oa2-x0a.google.com (mail-oa2-x0a.google.com
 [IPv6:2607:f8b0:4864:30::a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9B6640660
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:37:21 +0000 (UTC)
Received: by mail-oa2-x0a.google.com with SMTP id
 586e51a60fabf-4a24c19feacso285537fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792593440; x=1793198240;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OsGTniFc1m+y1KhKU69Ts4iGhbzTgNU0pIimbfhnr6s=;
 b=rzhLzWsTauJ7XOg3czUlB8S7ocmzTN+AuZpPpg+R7a7Nfml8zAwtRmtqXsDXkp7Xu5
 ltXQAdGrsrPb8XTBwrKO4FuV+nBs4/n0nDDjfbeurC/FR2nusEeigVJygqILdcSlLX8/
 fW0r3IZR16/EVDkzI2JJ7xtKR3g5HbINLDhjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792593440; x=1793198240;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OsGTniFc1m+y1KhKU69Ts4iGhbzTgNU0pIimbfhnr6s=;
 b=F7FQLN3ce1yvEx/Aj03vll3EdJ7PoN6RfSV3LtZMQym5iG1PJq50U+5mlEHv+kavsN
 k6sZGBRVWJUPC/O1SYfoXAYLVadQdogd0b6Zesg3RXZv5KyWcn/psVk/teSv00xexZ8b
 mlW1pfURfWxBgQkiCy7ZdK+VzFq/ynToxTlBX7cm6jjtqvtTCNXFl4aoe8XyxUkHSUGW
 HO9tya0i92ubeoYE7cIvpMi0IRSJPdqHqGDa73yHL2MdpVsd4ODdpvC8OoaiZD1O9Vec
 AVddA+Ya1+n1UFLnHDc80wwk/DfHzWDqXnf+HrN8KXzTRg4S0wb9WdV3rc8rV6SKVGY1
 rGDg==
X-Gm-Message-State: AFq9FYJNDfkEvfDA4Bq4UgyWIa+e5trtban2n28WVvjxH4ZNTirIzOws
 68mmsAljH5oPb2NJcBhuyqOGRx21bX9/dw1osvmKY/rscZub2BeJTb8Wu0AHwgkF/AQ=
X-Gm-Gg: AYBFou31jS9XN8afu7+zrLF2ddbd0IyWiMlYQ6W6FhDNFh1NEmc6FOC5nuyfj9wncQO
 l/UAtyIam0kcJpBK4DdLwfIOyrGM+eaPHotaRNoXMrzMjXpemiXglNlrfqQsRZjX/SyE0sxpZe8
 qgDMennUbrNbemFAwny/OwiYmD852FchA5vUihZRTMzT/HlEn0EhS5L6f9RC9pPaed/KQ9dwQ/M
 S3Ww3rT50WTGlcwOQSP97z/+dQ9M1hcpbJUgsPaMILUiXkak7usBcXzbrdJK87HSi8khO1xvaws
 dbzETOrHJJtH/8Ihh/+qQspWLW6zrFvDVMV2TkbXAQL+R7wkqI75F1KYVylr/eGsvVNLJIxLo9j
 d3zXQrGB1I+UevtQwMrzYeJIfJPf62AQHwxLm6fPUcGpcGDPZ63o+IItoJj41CjiW2GDciTNsLW
 ZEx3SjrlbZIAiv5tp2jaB0Euqyrvtvp8qf2aDihDif96h33bDH21ds/KsUHCcf5aoz7kaNP1m0/
 OwZaHM1GMSpcKiwsO+TH/d1ZCWZbhZVadlOIXZyNzOFX5feShem5fYMzRkGhlDNWPU32e50qjpl
 azHtbA6kQkhXzAAJGNNhfvCQPx60Weqyw5u7IOYTIy8Ck65XZdY7C90Pkp1njuP4za++zCx6MP6
 Kvgs7GmKyMwcHJ1PZ/iVPZg==
X-Received: by 2002:a05:6870:3351:b0:4a7:75e:fc7f with SMTP id
 586e51a60fabf-4a7dbf93df9mr1433586fac.7.1792593440395; 
 Wed, 21 Oct 2026 07:37:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d8ec2584sm1903569fac.9.2026.10.21.07.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:37:19 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:37:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Takahiro.Kuwano@infineon.com
Cc: u-boot@lists.u-boot-project.org, vigneshr@ti.com,
 raymond.mao@riscstar.com, vjardin@free.fr, festevam@nabladev.com,
 ehristev@kernel.org
Subject: Re: [PATCH v3 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Message-ID: <20261021143717.GL720525@bill-the-cat>
References: <20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com>
 <20261016182654.GA4035800@bill-the-cat>
 <b879d1b7c63242c6aa28599bc6b6e59c@infineon.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZmWCRALp2mWtdpbB"
Content-Disposition: inline
In-Reply-To: <b879d1b7c63242c6aa28599bc6b6e59c@infineon.com>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--ZmWCRALp2mWtdpbB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 01:42:00AM +0000, Takahiro.Kuwano@infineon.com wrot=
e:
> Hi Tom,
>=20
> > On Fri, Oct 16, 2026 at 10:43:41AM +0900, Takahiro Kuwano wrote:
> >=20
> > > The spi-nor-core.c contains optional logics like SFDP and manufcaturer
> > > specific fixups. The spi-nor-ids.c has single large ID database. There
> > > are many #ifdef directives in those files and that negatively affects
> > > readability and maintainability.
> > >
> > > This series, as the first step of cleanup, move SFDP logic, IDs, and
> > > fixups to newly source files. Reworking, renaming, and reformating
> > > existing code is not a scope of this series and further cleanup will =
be
> > > taken place in follow-up patches.
> > >
> > > Here is the code size impact when applying this series.
> > > Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
> > > manufcaturers are enabled.
> > >
> > > SPI-NOR:
> > >             text    data     bss     dec     hex filename
> > > BEFORE    720685   14084       0  734769   b3631 u-boot
> > > AFTER     721827   14156       0  735983   b3aef u-boot
> > > DELTA      +1142     +72
> > >
> > > TINY:
> > >             text    data     bss     dec     hex filename
> > > BEFORE     77399    3128     248   80775   13b87 spl/u-boot-spl
> > > AFTER      77589    3200     248   81037   13c8d spl/u-boot-spl
> > > DELTA       +190     +72
> >=20
> > So this leads to imx28_btt3 and imx28_xea overflowing in CI on link.
>=20
> I don't see any errors in my local. Something different from CI config.
>=20
> imx28_btt3_defconfig:
>           text	   data	    bss	    dec	    hex	filename
> BEFORE  37947	   2896	      0	  40843	   9f8b	spl/u-boot-spl
> AFTER   38003	   2912	      0	  40915	   9fd3	spl/u-boot-spl
>            +56       +16
>=20
> imx28_xea_defconfig:
>             text	   data	    bss	    dec	    hex	filename
> BEFORE    38004	   2816	      0	  40820	   9f74	spl/u-boot-spl
> AFTER     38060	   2832	      0	  40892	   9fbc	spl/u-boot-spl
>              +56     +16
>=20
> Could you share the exact CI error or size report?

What toolchain are you using? CI uses the 14.2.0 ones from kernel.org:
https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2.0/
and the CI run is:
https://git.u-boot-project.org/u-boot/u-boot/-/jobs/115650#L3163

--=20
Tom

--ZmWCRALp2mWtdpbB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatjOGQAKCRAr4qD1Cr/k
ClGeAQDuEIPes5r7gEJJpsolZ4ADGYotCmMCdsz2+2U5cKdlFgEA/ZkbLe6ib/33
KzpeYCzQO/0cNxWrpRxiTic3fcaOLA0=
=X6z7
-----END PGP SIGNATURE-----

--ZmWCRALp2mWtdpbB--
