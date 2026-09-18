Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8825DC982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 15:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 419E040A4E;
	Fri, 18 Sep 2026 15:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0uWUMp86pTOZ; Fri, 18 Sep 2026 15:03:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 799EE40A55
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789743822;
	b=laHVtywgT35ONIMMEbC/Zl7x0jphS5zS/sApJ+4YxYPic7zSRpcm1wNnurZq27jAiqAP
	 nQLrNGOpVbqtXnt0bRZGt2p62azHavcm3JWGffQY7odBZyIeqMYngIUnP8fNkdxF560pg
	 kgODdqZVmZkmJKMQQMOXbphU+8U2kbakC7diH0imZWmb49mEOB1Ey9C/GrqiFn6ySumVI
	 SSIMIIiUAA1zLUMivepBFQbvvrQPmZ5ENEzdw0HO7N6XIhcuUZKJNB+7G0omUYonrVbBB
	 fA4fdECPYdZJrX3gbg7c9xuQuomtABBwOJWYILmBRMXxbQn/HlkeuqQD2KS1gM7o2iA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789743822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KLkoLuuyzh4ui/sNJvgTxN6ok/MQU5hiByGow4LVg1w=;
	b=LT2nLPGDMT1HbfmKdvO2MBYf7qkeHIU/aBkC+UfbsJwnU+nKuAACl4OyJLa6vCTZBgbt
	 kE/pmhwEM58i0cjTMYl+Z392zMPJKhT89gExw2o+higTnqvlkbebbm5C43X4ZZubQNimh
	 taUMMKO3g9g7CpU6h+KzTbH7upizVTSsVCtr8bot1N+ChW8bK+2qSJ4i1//40HHuiExXq
	 oBKqXVfhInSd0wvIOwcw/HL3vmTohkRvBUbbbHFZo8KiLv7CBnJUjhytcrN+IRV8JV09A
	 661IUy0YkKy7CYC3Cga/ul2L3tJpHxARQjt/N1kWPcIXgCHrqjpeg8nNnjWnNZNtTkw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789743822;
	bh=KLkoLuuyzh4ui/sNJvgTxN6ok/MQU5hiByGow4LVg1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E3cMn2KdFbfEjx9a+QYx2jGF4GWTdRmmFRSuyRAaY1gWQvMBUGvALXQW5cC4l2xyT
	 fxquT0nQVvIXoPuSvOZEtMSK++EU0bZAFbSI/zNnwZ/eZwelPqzbLvfXHui8u5pEI6
	 IEpW9wLQIsGnVF1EzISx/ViOPwouS8jwVi2GHTK+1z2btLm9Sf42sqEbmz/SEPPY1r
	 G4rlOiLD8MpowYosVOsrhCtZ/CKsz46Bu/p95KRcHDSPiIZz3SNctzsGAq1NcGERwy
	 37EhLKCs3Rbvir9tSr9IWbnmExMVuJqfEIcVXldunGMxJ4xh2pV7X7QGdAGiul+4+x
	 XgUNVKDpu7hUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 799EE40A55;
	Fri, 18 Sep 2026 15:03:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 35A78362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 275438113E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DnocEPIbOA_H for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 15:03:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3F69581117
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789743820;
 b=aeMug69g1pripTOzOZsPETuIXK9Z+HlUVAAtLDG2+OnOYhL3zFUINzHA2ZcS3y4O0xo+
 ASuJB4spvgDuMTF4zw/UjGDrrlS53nMudL2Ldckd2tjTRpVZrxd8N2jdr6CF2cvsHsNC7
 UhMrP1ulMMKujpx6aLvReztlY7N97t37ruQ+Mvzv+4CUqMaYBC1lY7nlLDPNrOax0goFX
 SY01KZkWRH917n3HbdayfXwLFQmObApOl94GPK8HUFr2Y1Spiz8vNcneiQThOXCE7L+Sb
 z8UZar80k0OaAbtpsX+5aHYKkt6mvpan9vL2VvQtT1RWkTnUyMXh6a+uODDJlMNVEnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789743820;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=KLkoLuuyzh4ui/sNJvgTxN6ok/MQU5hiByGow4LVg1w=;
 b=B0Gur/dnGgFSHFvIpX4WVzEd7ns4ctX58T7L845NfyZEH6Xl5VxL8LQfz99e+y32fDrf
 PFXbyOXbro2Uxt5XcTSF6INiXTEEMFabfWjSy28/9PquwmYJ4TzOIv4uw9YweF4uMNW8B
 a2OGKx/QrXt3KD4IrpxoTbM1zXvFrR2dIT3L+RZii30IWmnslq/P0ciQ/+LhiAjqfUZzj
 XT+3xy4lxeKBuO5KhjrLgwFML9CQBwu6WYYRBc8+uUX/wgNy2icYOZs7D+ewaaLOhhRYh
 svnT9OI+sA313X4MI7nM1xYEC7s+sVQbwkSgTOq5swAjSVod0Fe8vIFLW9Vx/F0jy9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=q1KK2rd1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=q1KK2rd1
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F69581117
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:03:39 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466ccde2ad8so662897fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789743819; x=1790348619;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KLkoLuuyzh4ui/sNJvgTxN6ok/MQU5hiByGow4LVg1w=;
 b=q1KK2rd1Wy93eDV1wP3YwkIlzPipvKXd94XfvSlksxepfkvd6rAFEe+rXO7iLaRxbH
 ax2gFv4Tw7S/t4Szg95xqycab7wB3ARF/R7U1mpHpx8ycZnr4FvaQb7vdRFMXvigo5k6
 On4g188BZlkFzw6lqf4y+PIdr4St4kj+Xu2vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789743819; x=1790348619;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KLkoLuuyzh4ui/sNJvgTxN6ok/MQU5hiByGow4LVg1w=;
 b=2ptyE43du1amnmfoN3OhfWz86qCRU4i1+w0ruPMlYalyqEQtL4GMgUjaE2vN464pCR
 92UeSDW3ahIBK8W6t9ZgEJnZO+srCenBjMWoLVOOWh/5mx4Hv0N66X7EYvZQeZW5vkCY
 2LmQfGgevSPLpvCpQy6DqRE5htuIeKpPMSIHE4NsvrU5JCdb/sv73u9Z6Fs1QZZ8MkPx
 1UsK/1SqylnckJFhfsh/Y0DLUDdjAJTIPCKsiqOz042vOI/PyRgrJNoE3cHj2ko7pHZR
 8Cmk1jl95n7WuDG3fHq6G8bsYiPeXzeZgtcqZfb8I7RcpDjyV5cTnUkjOs9d7ICtTle0
 wA7g==
X-Gm-Message-State: AFuF++ly0Sj3C6IMqk2WBfZABMiXz/vOWM4P3g8zwc1dwVYRCRgFnAgx
 dQhlUhjsCdwbcUfBlimwSqadDRMRGulPgdT5y6q7RCMPq4BoCTBLAVl+wFYoSu87K9k=
X-Gm-Gg: AYBFou1CeEFvACvOMMGDDfEBZFtYerUJwoYbr9u1ULFX5ZLXkvf34b/CU17EFYM8kOv
 x8acCv0CReFIYjHIDbCXTU4otdWCZI9fpneDKCTOKLgZMZ/i+8PrcPDCoLoUXUQ7bpKOQ1Qn/4O
 HYnwEKWIxFQYB39fW0GBcHBUCwFlshg//KaZ1tBi6NFX4avI8YXzmHaPQLz5j52pQaT1AA4Yeg0
 WK5YdigiqlMav49heHwnN75/vcEdl2MF/Z2hPs9BPl/rX0T2q5vPs7BmqvsZKHdOErseSdZ1tf2
 16Lbdnorw4W2OMYaw8bwvL7oEzt3jdYyQjL9TgMf3hiOhOFXVyDNhEVOvNBGouxrIO7iUFPhBNB
 kshpfxdJWa8/jPnCEPFjLp4uKa99YrdqxGxhcwHUTzpX8qgXOD1h4bubfP263l40wuN/LgV7y/h
 DzIm7Zi05pPiL+lvHzbr77luFaxSRZx7efFxVjjvc+dllpOVENS01vkU2Y2ILs5CAHpr6ngenzb
 xG6VpXYaUpdETZMKMp22IBedzJXSXQCQz5u54ci0hBm2OwEFUOyiaq/CAQ9BnlSSqAWFeGdl/33
 SQ3LfoZLfPo6BY4h3Fnj
X-Received: by 2002:a05:6808:c2b6:b0:4cb:26a3:a0dc with SMTP id
 5614622812f47-4ccf88372eamr3047391b6e.20.1789743819010; 
 Fri, 18 Sep 2026 08:03:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4cd64622e0csm1178522b6e.0.2026.09.18.08.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:03:38 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:03:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH v2 02/11] lib: Build xxhash in the SPL phase
Message-ID: <20260918150335.GP858934@bill-the-cat>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-2-28e946f57357@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yKJBOA9m/LanqASS"
Content-Disposition: inline
In-Reply-To: <20260918-spl-fit-compression-v2-2-28e946f57357@flipper.net>
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


--yKJBOA9m/LanqASS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 02:52:29PM +0400, Alexey Charkov wrote:

> SPL_ZSTD selects XXHASH, but xxhash.o is built from inside the
> ifndef CONFIG_XPL_BUILD block, so it never reaches an SPL link. zstd's
> decompressor calls xxh64_* from code that survives --gc-sections, so
> today the option only builds because nothing in SPL calls
> zstd_decompress() and the whole library is discarded. The first caller
> would fail to link.
>=20
> Give xxhash its own phase symbol and build rule, the way the other
> compression libraries already have, and note in the SPL_ZSTD help how
> much heap the decompressor wants, since that is the other thing which
> may stop it from working.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--yKJBOA9m/LanqASS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaq1SxwAKCRAr4qD1Cr/k
CpjsAP4vm/bTI3oVh4+y3+yZHVAmc3xjnhYVI/htDdSbfsoI+wD/ax1WVgZhR2JZ
n0ju5m9cx89ASreXFSaycgM7A2mcqgM=
=lKHv
-----END PGP SIGNATURE-----

--yKJBOA9m/LanqASS--
