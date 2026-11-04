Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEFC608BC62
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f2FDPyb9;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=EPXvEwzP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE18C813AC;
	Wed,  4 Nov 2026 19:27:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ESdI8jDEYFfd; Wed,  4 Nov 2026 19:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 387AB81384
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793820475;
	b=SIk2hXtEVZPaE3eN1KWTjZmSKX/4mri2d9jvIsTDgPIIoH53NKQn3BLmUNZ6Delmug0O
	 o1ybpfkd7jNcCUlrwk6fU97WL8iEm13TxPveW5TASkRllC0pHRvNkLRSv9c+hOfjx1dk3
	 6XadUPIlJep8afv2G8TKbYYlsZQOqdO23fw60sUVgDnJ5CjSaM6Z71YU0t54RSQYrnKVa
	 xHbA+DH0V0HGDMhKGUsQyFar2sC4m63ft1YO+pZiVg8h89BjLNK0WnOfP05QmI6AZaj/i
	 piu1xyzfoJIkbVW05S0fgYecyU0n5pMJPMdkEVqxdFIczxgPhakD6AcWeAT+6rl6NYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793820475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7DvlvAyXZqmZ5iBODg7QeevFxM7uYlxrVi8FVvP6uU8=;
	b=lsCwudJ2aibeiYmL0Z1xK+QTUQ7j9oPf2WHsqQXrqtTRq7qtAYR5VUdODPl/TWX/5/Jx
	 1HrVAIWMnC87w4W72tPWmq1nLPCFRHGr5JKHjr0TmwsjXeMLYM7PS6rRT2j/HW43P8lBh
	 o7Ek6xgjxoukNbAcOoGhhbm76pjbW8li2l+1XZW3c1I2XWV8+tqT4gI+xfklZ6koxwwQD
	 KZ8e1B3g4w5UlxnRvLMG6CMB++TWmyUqLUz4uJ6Vm1Ne5uQRUMEh1mSzqsYTQIh1Bxm9k
	 pfNuijhhqs18TvrGqeqAfl0d57mpXu6QidHh62GZ/F3Z2Q/hNehExEIjz2KIJ1I3M7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793820475;
	bh=7DvlvAyXZqmZ5iBODg7QeevFxM7uYlxrVi8FVvP6uU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f2FDPyb9QyO8ddaI4DfYRsCBPwFZyHtcYb301FcsJyyx5/8fPuKdq0bDXdUAJaTxi
	 3e8blnPDFXiFmoUHVKhF3/zTIG3MbB4joMMjdcB2sRxP+anG+TJUKdkhAs/cZJ0LUn
	 36dk34dM6ZEMGNnxFZTI/TV6Tk6osoP8Ue8NxVL9wxoxF+V+n31LX4FvFUe9ODcWDP
	 MhKr8Lo4zvI2G5e60+w6G4Rz32YcRPjXztfYdb08Lpt24/yE53/xogxOg8OIGUjbjY
	 iVH8vz1yf4XmpaQl5W96E9OJaDE5oYK2nbuKel0dAqIBLTUbQTCMFgihxk/fZK0MUH
	 zwbUfUw1a5dug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 387AB81384;
	Wed,  4 Nov 2026 19:27:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 139F39C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED8E34034F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DMS4xyYnEe_i for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 19:27:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0C23740062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EPXvEwzP
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C23740062
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:27:52 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-483c607ccb4so700156fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 11:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793820471; x=1794425271;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7DvlvAyXZqmZ5iBODg7QeevFxM7uYlxrVi8FVvP6uU8=;
 b=EPXvEwzPR3ejg9IbKULC0HCDN3KjEjzkHAiXMbYyXnl4Wb+NVhDZ5+kkWdqXvp92oH
 ZWE1mqHzilipNwcduwqbEGlxruJPGkPZTtBhVHoI5WBAOdknMCfRA3XcQDgJ7kWuj0kw
 NCKjz1N2jZBTp48t2+DrC1++YNsNfDY4iamz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793820471; x=1794425271;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7DvlvAyXZqmZ5iBODg7QeevFxM7uYlxrVi8FVvP6uU8=;
 b=CeeA6iWHzwSmINlzixdFgkffOgTqZX/8Fxtyqr/C3liLclBxEgXs2rpKw3MjJSIpSO
 4g3OVsmmirEIoygfTrkZ68f25zbDqV/3E+H0fCy1reFyW05U0LbqR0a8xfi5jar+59Ms
 qSdH3OgdUJPnIkt6Uwt8EUH+n/pR9RLyRhUzPyPDre6ZMZMpmjyEel/zUhBJgznAOHW5
 b2fVEgY452iP8m1nrsvplMm0dd7QEhAV0kHam8skOaOMvMD23QKUJgXQWbJcHvm4d1OI
 xTyYFRu3MFlBRiWRNxfJwkrXEjtCxosxM/EXyFM5CDOOB5mxOh3b1wiRu1iObSCLSVqX
 0zwA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHs7fGwCqCSApDgF21NS+gB5mWolRR0lageBAP2chEbFHouRGOK/KKB/ZjK4yhe2MXBBXwIq8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+wjuySD2+DGSB9dvftnbLHjojs1/6teln0EEVGtp7ntLT+rQJp
 c+MWtXUeiAMMAEKoMY9EgL/lGBCOu8yeM810D4tBcmJjal99Zx3+YvTQUkkozFNgk6I=
X-Gm-Gg: AYBFou2UdDCcrwFn9aztDyVPvKQuuZ5XwcNxSVKFvLjieLAH1pw+KrOdumdyw96TArK
 Ttu4YrkCq9qoecT9il9sQe2loTFcnBjYaNNWwL/pzCUsvLuyYEZMDU4DSfxb9YV12yTzpHegipY
 +B3bfV4K17txMTfGnYJtWlCkTZiHYAoyi1/ompySzuqGl0gWyfrDk8h+X6HtamGfoCtKJwElrxD
 5RD/m/LWA8fBfL6N++paGejEc4VgcVB4019GXTdrsd4PycUw1YlfR51ozQyl4g4RS3PuokdrVuy
 Gel4iive9/gHpFV1EtSds0e3jFKgdjgFmwsBOr0fF6FpjK9hraGv6007qP3pROLKndLn0AkInMa
 15jTje5LTtTRP/5s30eD5cFqZ7y6jXix6PasY5fpw6/ucWSPKGwCwYfS9600hp5A2oL0MWTsXzU
 kHnriHbgsRRxqus54Q88M1rxKP9/iRbriIa5WRSDEXTi52sTF/6ePLcuGkukz8kgWLAakZRbrEM
 bEMt23IlqjTUdOJG9uu+tJGQoWGboTJ3KDXCBSAAU6Cr+oediuBK6hvarOClievHoJSEyyDWdLb
 41i5/EmDAyIWOv2YorzlmyUbqFciBPf8cKu4ljcbCmzoAPr3XfF52neBH46QQ8g0M9oTyX86iJh
 njRdZMJtXYG5eKKG8d/RfOcjDJBMXB5Z5Yp/lKsBZXmWggGkD/Eth/SqQYCycPZHUqfyTycpe37
 Y4dXRvw8BX63K2eQwjPNHVXaomTGGLyA==
X-Received: by 2002:a05:6808:15a7:b0:4b3:7efc:e970 with SMTP id
 5614622812f47-5640d91bd23mr11369608b6e.5.1793820471362; 
 Wed, 04 Nov 2026 11:27:51 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9fdfa53sm2286378b6e.15.2026.11.04.11.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:27:49 -0800 (PST)
Date: Wed, 4 Nov 2026 13:27:46 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 4/4] spl: atf: pass the bloblist to BL33 in registers
Message-ID: <20261104192746.GE1164024@bill-the-cat>
References: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
 <20261103-spl-bloblist-pass-regs-v1-4-bbbbb7e65fdd@baylibre.com>
 <20261103215700.GE785819@bill-the-cat>
 <58235652-b968-4ee1-8eeb-af881c89e25f@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dxh78VFMzY7Gut4J"
Content-Disposition: inline
In-Reply-To: <58235652-b968-4ee1-8eeb-af881c89e25f@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Dxh78VFMzY7Gut4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 05:52:28PM -0600, David Lechner wrote:
> On 11/3/26 3:57 PM, Tom Rini wrote:
> > On Tue, Nov 03, 2026 at 03:26:03PM -0600, David Lechner wrote:
> >=20
> >> Make SPL_BLOBLIST_PASS_REGS also pass the bloblist to BL33, which is
> >> normally U-Boot proper, when SPL starts it through BL31. Fill in the B=
L33
> >> entry point arguments that SPL gives to BL31 with the register
> >> conventions of the Firmware Handoff spec instead of the primary CPU MP=
ID.
> >> BL31 passes these on to BL33 unchanged.
> >>
> >> Without this, the only way for BL33 to find the SPL bloblist is a fixed
> >> address in memory.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>  common/Kconfig       |  8 +++++++-
> >>  common/spl/spl_atf.c | 29 +++++++++++++++++++++++++----
> >>  2 files changed, 32 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/common/Kconfig b/common/Kconfig
> >> index 02eecdb5c98..2ac885d31e1 100644
> >> --- a/common/Kconfig
> >> +++ b/common/Kconfig
> >> @@ -1243,7 +1243,13 @@ config SPL_BLOBLIST_PASS_REGS
> >>  	  specification. The next phase then finds the bloblist without rely=
ing
> >>  	  on a fixed address in memory.
> >> =20
> >> -	  This only affects the default jump_to_image() implementation.
> >> +	  When SPL starts BL31 (SPL_ATF), the registers are passed to BL33
> >> +	  through its entry point arguments instead of the primary CPU MPID,
> >> +	  and BL31 must pass them on unchanged.
> >> +
> >> +	  This only affects the default jump_to_image(),
> >> +	  bl2_plat_get_bl31_params() and bl2_plat_get_bl31_params_v2()
> >> +	  implementations.
> >=20
> > So that's what I get for replying in order, oops. But is there some way
> > to handle what the TF-A case needs, while having a more generic "prepare
> > the bloblist" as I was asking about in the previous email? Thanks.
> >=20
>=20
> Sure. I think we could move the xferlist_to_boot_arg() call to board_init=
_r()
> like you expected and set a flag there.
>=20
> Then the default jump_to_image() or ATF code path could read that flag and
> set the appropriate registers/args just before jumping.

Sounds good, thanks!

--=20
Tom

--Dxh78VFMzY7Gut4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauuHMgAKCRAr4qD1Cr/k
Cib5AQD2SiIVaPE5yjRX7Nn7+kyx5YAd588Uy/3VvPLN3rWTsgEA2e5qOVWkT1ZM
ywus2sXCGEBDrDlOV20zTZsWhU7ClgM=
=vJQL
-----END PGP SIGNATURE-----

--Dxh78VFMzY7Gut4J--
