Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82016C88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6BD480BC4;
	Mon, 14 Sep 2026 20:32:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ttxsMELryqaW; Mon, 14 Sep 2026 20:32:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8C6FD8097B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789417923;
	b=AEiY/cHaM0LK9ZsGL2QmYnN96lUSTmF1nhH0i4HLOlug+j8Tk8CeFC9/fsto58bIu5Ad
	 qI1QzTpAyBbc5FNSvkGO0E0Ogb+QEZo/we94cS2XYBOiTfdnJgBEYZ9HHqXa8Xd0QKwrm
	 Ovff0pqlPRFL05F2BJxjxaqbW+PSFAqkNFgeBUvATlLNduRpDq1cQDPKWIRsJHZ14DVLI
	 Xs1a4TP1y43b7yA+ONhyld60LUvh+vFO91rSCWs9o12UrUtvXSWfSYTCF09wfT5Q2Mr59
	 VzRBKNuu0Oj6UCZ/xF5iHauVaw6C61L1t1Vd+4s7IaeKSmIZalK/7vD9Vsc+KGCZZqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789417923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=As7dqSpStPyOul6KvRaTdZ+iQOX1kJmYZJb8FDCSiCg=;
	b=KDWRSDmOSZ/uu7jIi1hyekSnUQCAeM3vobzmePHVStE/30umKt53OLtA47doQziAcHWE
	 QGKDcowWNRyXkMCgE4YrQDntPWp1E218I4Y1PP/VS7+R4EiIOK+LLudaaVAVlRQHFqLh0
	 0mhBl/iLr8mpFgtHlCUVl2trv6kCuBZ1ILspRkcnaywVt7yY9UPww1w1rBMpirMOyiXCs
	 o7b2USbrXkVF1uDn+bkUjVFWcAcU1rotA8bQJtc3pPGs0fxXLstKM8/Ti5XN8pwE8pyWT
	 +cucvqPYWnI89IZDrx4D3AEtKs+ae4E1ZOjDU1Fa8RlffdkNUpAAPkUvFPR6X+8e5iA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789417923;
	bh=As7dqSpStPyOul6KvRaTdZ+iQOX1kJmYZJb8FDCSiCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oQ4shoP1Xmb/eVSlYxYDMUWhLT230eiOdVF2f/SalSvjfAcIs4jR2iaK778KyNBbM
	 ndeceyAIcVivzOlumg/d12OVpBNCIUOlXCObuLjQwLOqrFwKgOWSLDHk6Qj4tkOALC
	 k3i/00FtzAyAw1rSWjh2TggrRdxrTjO2c7BYLddB1UJkLlVyCyxkz1LwllGefNjcKA
	 kC8b4hSh6n9DctBRtBbZFBNo+sdsFJkRMrnbv/hN2kpypl2ZecigOOcdiw6UfeAqmv
	 JIV4c82cvR/fpJBRZQO7we9AtGLi+PVTmn5SVVPnE/NlKLOQjtazTASnROPUzGPN3h
	 AAIsM6/S/Nrdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C6FD8097B;
	Mon, 14 Sep 2026 20:32:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B0812E5
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4E24400A1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9nLLBrd5q9V for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:32:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BA98040082
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789417921;
 b=BHyA4EcUkvHFjps7euVJeiAEIt8stExGOBfH8Typ+JQYq+iih/d9eb5JAX1OEuEsf1T/
 bO+ifvR3gIzzMS6DKMa7ZzBm0Mzb/iHOzIPy0L+iIgbJsOiIjrhkcKoNgZLsrmga1Z5aP
 CL9pCzWHivLR/mnndveWQRRFqQY3FiYvazhmFIkeEO7vcNfpobj+3J1k1WRa+eFgbmlsa
 X5Tv5XMNYr+LRhsG4m3qox0CF9tsQd+M1VgDl7yFxHQeZi5xFKaLTeodMdCeQe+cuDDiU
 rCf9oao2/jvytsFBNtEtdQSTurc71yjHhNd0HkOgaVzTXOltIm8Ps3PPhoy7MGW62bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789417921;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=As7dqSpStPyOul6KvRaTdZ+iQOX1kJmYZJb8FDCSiCg=;
 b=sP92HV5ZIv+oc4npqyehQaWsRiU1heOD6RjMssqJoI2bsNT/tGUCrl4/YZQ8AX5CHFkK
 lvXeX8VMi9VJuBCPeOdqyOzuIgbhe92mN25hXTXlMnQ4iA54ZM61Ekzc7BP/t/bZqnARr
 PC/kGim0Gv/YRIprhocyhOPEcG3Fo4mBEqbRSPJLJ7+kzBSHJVAb/gm0JUEV0SXhuBy9e
 0W3llA+FDI+ewK8dX6qzKe71cLWr+FuBiB5AZaO/uf6zzGDaLYyZps/mgQ3S9S3zyE4QN
 ClhzsOOKi68+4CHoyRAfgLWuEdYCGB8XiKHoNESJX88r1OykrEsGHRe7C5wMBrKmNcA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BVMPufJ1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BVMPufJ1
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA98040082
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:32:00 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-8048c50724eso957745a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789417919; x=1790022719;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=As7dqSpStPyOul6KvRaTdZ+iQOX1kJmYZJb8FDCSiCg=;
 b=BVMPufJ1181mX8GR0efV7aY9V8bmtrMLvRsq99NpRIw7F74Pu5JUU5SzEcXHFQM10z
 BSz3BDoJ2Cvwccb8OhZWwDqXAIxSPQZ3qmZgmAjzr6OqwEzw86Dvt8/QkDsukC3ZL9MW
 f31QxRckrbR5pUgOxhNRZZ104HjokrMZM0Za0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789417919; x=1790022719;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=As7dqSpStPyOul6KvRaTdZ+iQOX1kJmYZJb8FDCSiCg=;
 b=vcTBWdyGDLeMiWtrq9T4N9BEvxvF36/QW9av3qAiEXqJ1lLv59m2VYvVMsZfuZ2FpS
 0GmBkhIKBTjMsEIvGl6tIKE1/gv9p9Btyk7hBPHAeWrN+IY6RFt7zs0Lg411mkBqo+oh
 RKrqkhzkUlqIehkAkXmgc6I/yiGizoML1R2r9lF/xANxpPvi4M7uQ/2fWFc3K+8jTLtH
 dBLy4eaPXiNAPrSCa8C2ERIWHv3poED6nJvlduczUNMpEnw+CWcC6LymoJhxe0yaG9Mq
 WqnrvLBDD/dEQ+R0i6+xvsvJG0dNMrqGEMkwJ7KF1EH42q5s5aVxhqLzwo5M6GZKhlPy
 +u7Q==
X-Gm-Message-State: AFuF++kx6p9ODm8NE2X9upSQZeUmf5mNAnIG/Slik7zc83jWSeg68u1L
 okJb/CoiNLyImJEyVNLKKVqJaZK0sC3+xAwn42zDKkZuvbVGcCFLaaTiBnN8v020ZHE=
X-Gm-Gg: AYBFou15N5K0n5BTcXfhGMczHeeFpGW050I7n6Hut1kPnrHagk4jpeTiqNBXJNqFdPS
 buWJ3YEKGJW9C8AVEAcv3i5Vke5+Q6ZQl2WwpP2z43ihMb8qofC1LvXfERU5h4glZZgV8UzRnnZ
 sS5XpTZEi0+WDDr7Id0VgjqoArxs8b4YWhiByx8X2QILMSlIwNfXZoS9U2Z1rnvi/FxiN7lhnOP
 7RkOWl6kWSg3ufqMFVL+pyEWdCG49k/aaoz4fdit8wxhr4CbI8bCjBOXfH+LEPTc7fUYOZI9oH0
 utJqnKCK6nn+KxrZXL3LXPvIGyPnmmhRC5jW3bWKLRut8OHR9wd02T6d2Ca3sSnm8P6Chf5n8Uc
 mT1V+3+HHJ9hRzV2fATN6tCTntijvlgVJyoJoODFrX/JVYc16oKSq8f/XQdNjG5vMp24ca/8uhg
 e4lliCEvFjrCrYdWvMiJ+u6PJv6/hD/qC4MuW/uUSkXCBgAC+VKghFI0McfSrRGofB6iQwbdtS2
 zXsGZyYRPQejBDfDZGYrvQDr6BG0ceW0QR3r4wY4J8uIkhiYkhSkYljW1Gdv7lrhoBJ8cr29xTw
 WtWvBQJrP+LrGHQGiw5jFRP3n4PEUeg=
X-Received: by 2002:a05:6830:2a86:b0:7f8:4ebe:2854 with SMTP id
 46e09a7af769-8089759c582mr5261423a34.4.1789417918974; 
 Mon, 14 Sep 2026 13:31:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-805cb5ba734sm7945029a34.0.2026.09.14.13.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:31:58 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:31:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Eva Crystal <0xiviel@gmail.com>
Cc: u-boot@lists.u-boot-project.org, ludwig.nussel@siemens.com,
 jonas@kwiboo.se, sjg@chromium.org, daniel@makrotopia.org, anton@binarly.io
Subject: Re: [PATCH 0/2] Close the FIT signature fail-open on the image gate
Message-ID: <20260914203156.GG1764417@bill-the-cat>
References: <20260914200905.280557-1-0xiviel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0XC41N9O+Knkc3Q6"
Content-Disposition: inline
In-Reply-To: <20260914200905.280557-1-0xiviel@gmail.com>
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


--0XC41N9O+Knkc3Q6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 08:09:03AM +1200, Eva Crystal wrote:

> This follows up my report of 2026-09-08, "[SECURITY] FIT signature
> enforcement fails open when the control DTB has no /signature node":
>=20
>   https://lore.kernel.org/u-boot/CA+pz=3Dk+hAU5dqbO4GOLJ0fRMRdyrq=3DkTSnw=
Uc0OcR3r9PotUgg@mail.gmail.com/
>=20
> Tom asked for a fix and a test following the sending_patches process, so
> here they are. Everything below was measured on sandbox at
> commit a44f46af0aa1 ("MAINTAINERS: tee: update Jens Wiklander's email
> address").
>=20
>=20
> The fail-open
> -------------
>=20
> fit_image_verify_required_sigs() at boot/image-fit-sig.c:187 looks up the
> "/signature" node of the U-Boot control devicetree and returns success
> when it is absent, at boot/image-fit-sig.c:203-207:
>=20
> 	/* Work out what we need to verify */
> 	*no_sigsp =3D 1;
> 	key_node =3D fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
> 	if (key_node < 0) {
> 		debug("%s: No signature node found: %s\n", __func__,
> 		      fdt_strerror(key_node));
> 		return 0;
> 	}
>=20
> With no /signature node there are no keys marked 'required', so nothing
> downstream can fail the image. The only indication is a debug() call,
> compiled out of a normal build.
>=20
> 'iminfo' at this HEAD verifies images but not configurations, so it
> reaches this gate directly. Against a control devicetree with no
> /signature node at all, and a FIT whose configuration signature carries
> no 'value':
>=20
>   ## Checking hash(es) for FIT Image at 10400100 ...
>      Hash(es) for Image 0 (kernel): sha256+
>      Hash(es) for Image 1 (fdt-1): sha256+
>=20
> That '+' is fit_image_verify_with_data() reporting the signature
> verified, on a board holding no keys whatsoever. The comment beside it in
> boot/image-fit.c is correct that only 'required' keys can fail an image,
> and that is precisely what makes a missing /signature node fatal to the
> security property rather than to the boot.
>=20
> With CONFIG_FIT_REQUIRE_CONFIG_SIGS=3Dy the same command gives:
>=20
>   ## Checking hash(es) for FIT Image at 10400100 ...
>      Hash(es) for Image 0 (kernel): No signature node in control FDT: FDT=
_ERR_NOTFOUND
>    error!
>   Unable to verify required signature for '' hash node in 'kernel' image =
node
>   Bad hash in FIT image!
>=20
>=20
> Relationship to Ludwig Nussel's series
> --------------------------------------
>=20
> The same early return exists in the configuration path, at
> boot/image-fit-sig.c:686-690, and that half is already being addressed.
> Ludwig Nussel's "Improve FIT signature handling" series has been fixing
> it since April and is at v8:
>=20
>   v7 4/8, direct link:
>   https://lore.kernel.org/u-boot/20260618144742.v7.4.6d1d5d14140677a76a7c=
d7bb99a9088d8c8f480c@changeid/
>=20
>   v8 4/8 review thread:
>   https://lore.kernel.org/u-boot/66a3267d-1980-4b86-be3a-791707373554@kwi=
boo.se/
>=20
> That series introduces CONFIG_FIT_REQUIRE_CONFIG_SIGS, closes the
> configuration gate, and also restructures the closing check at
> boot/image-fit-sig.c:733 to cover the case where /signature exists but
> holds no required=3D"conf" keys, where reqd_sigs stays 0 and the check
> cannot fire. The v7 form was applied to u-boot/next on 2026-06-30 and
> then dropped after CI failed.
>=20
> This series is complementary, not competing. v2 through v8 change only
> fit_config_verify_required_keys(); fit_image_verify_required_sigs() is
> untouched throughout. That image gate is what these patches close. The
> Kconfig symbol here is deliberately Ludwig's FIT_REQUIRE_CONFIG_SIGS
> rather than a new name, so that whichever lands first the other reduces
> to a smaller change rather than a conflicting one. If 4/8 lands first,
> all that remains of patch 1/2 is the image-gate hunk.
>=20
>=20
> Kconfig name and default
> ------------------------
>=20
> CONFIG_FIT_REQUIRE_CONFIG_SIGS, depends on FIT_SIGNATURE, default n,
> plus SPL_FIT_REQUIRE_CONFIG_SIGS which selects it.
>=20
> Default n is a measured choice, not caution. Full test_vboot suite on
> sandbox with these patches applied:
>=20
>   option at its default (not set):  32 passed,  0 failed
>   CONFIG_FIT_REQUIRE_CONFIG_SIGS=3Dy: 19 passed, 13 failed
>=20
> The 13 are not a defect in the patch. test_vboot's first step is
>=20
>   test/py/tests/test_vboot.py:312
>   run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-',=
 True)
>=20
> which boots an unsigned-images FIT against a devicetree that has no keys
> yet and asserts that it boots. That assertion encodes the old contract,
> so enforcing correctly breaks it:
>=20
>   E  assert 'dev-' in "... No signature node in control FDT: FDT_ERR_NOTF=
OUND
>      Bad Data Hash ... ERROR -2: ... can't get kernel image!"
>=20
> This is the same class of CI breakage that got v7 dropped from next.
> Making the option default y would require test_vboot to be restructured
> first, which is what Ludwig's 5/8 does. Until that lands, default n keeps
> the shipped configuration byte-for-byte unchanged in behaviour.
>=20
>=20
> The console message is conditional
> ----------------------------------
>=20
> The message is printed only when the option is enabled; the debug() call
> is kept otherwise. Jonas Karlman objected to making it unconditional:
>=20
>   https://lore.kernel.org/u-boot/44dbc75b-13e6-4242-a1a9-43264f379391@kwi=
boo.se/
>=20
>   "Yes, printing a verbose error message for something that should not
>    always be treated as an error is an issue."
>=20
> Rockchip enables FIT_SIGNATURE for image hash integrity alone and has no
> /signature node by design, so an unconditional message is noise on every
> boot there. Gating it means a board that has not asked for enforcement
> sees no change at all. Measured with the option off: the string
> "No signature node in control FDT" appears 0 times in the boot output,
> and 'iminfo' prints the same 'sha256+' lines as an unpatched build.
>=20
> printf() is used rather than log_err() so that this applies to main
> standalone; log_err() in this file requires Ludwig's 3/8. If these are
> ever squashed together, log_err() is the better choice.
>=20
>=20
> NOT TESTED
> ----------
>=20
> Being explicit, because some of this matters for review:
>=20
> - SPL: SPL_FIT_REQUIRE_CONFIG_SIGS is added and compiles through
>   CONFIG_IS_ENABLED, but I have not built or run any SPL configuration.
>   Compile coverage only. It needs someone with SPL verified boot.
> - Host tools: mkimage and fit_check_sign build with the patch, but I have
>   not exercised any fit_check_sign behaviour change. CONFIG_IS_ENABLED
>   is false in the host build since tools/Makefile only defines
>   CONFIG_FIT_SIGNATURE, so host behaviour should be unchanged -- argued,
>   not measured.
> - Sandbox only. I have no signed-boot hardware. Everything above is
>   sandbox_defconfig on x86-64.
> - Jonas's Rockchip setup: not reproduced. I reasoned that the off path
>   stays quiet and then measured that it does on sandbox, which is not the
>   same as booting an RK3588.
>=20
>=20
> No Fixes: tag
> -------------
>=20
> The early return is original behaviour rather than a regression. The
> oldest commit touching it in this path is commit b983cc2da0ba
> ("lib: rsa: decouple rsa from FIT image verification"), and that one
> moves the code from common/image-sig.c to common/image-fit-sig.c rather
> than introducing it. I could not identify an introducing commit with
> enough confidence to tag one, so I have not.

This is a very long cover letter. It also doesn't fit our normal style
(which you can see many examples of with "git log --merges"), can you
please rewrite it to be more concise and fit the normal style? Thanks.

--=20
Tom

--0XC41N9O+Knkc3Q6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqhZuwAKCRAr4qD1Cr/k
CqFFAQC6C+XedbVNxcO6gkSz4ru5eL/l22B53HNCzYLIwV5bXAD/TniMbiDqtFYo
zLZwwbRY8rLm+kwrboD6jrUbj8zgdwQ=
=N8un
-----END PGP SIGNATURE-----

--0XC41N9O+Knkc3Q6--
