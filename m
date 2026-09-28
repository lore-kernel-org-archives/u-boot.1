Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391B6CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 19:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C520D4043E;
	Mon, 28 Sep 2026 19:46:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZOx7DCtJjQFw; Mon, 28 Sep 2026 19:46:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 13E8640448
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790624805;
	b=isiZfZKnOK/uYWcR5osLx26dr5pml9sIWsVanroyQgJp207UzgCYDwdSk3YAgmOApKN+
	 KZi2Gw0cCjTqUZ45aLDp4o74GJvQPSykAMFGJutQF7eXBgAnz//BUwqvtqKYxCVrm58oV
	 HIcNHk+KEPmdlU6TibOvJemxMoHJQHwC+46gO1an8Q0EKXjCdEpXsbnkLlOF8Hp9izSDH
	 NS8YWi21I3HEQNG2T8zsFvXTd6BCx2gQi+cOEJPQwA0ncCXPEdjGiFmwiICtxCBBcfp6g
	 p6nAFLrD8Tdp8nxCXDEUl1FaNdFNzQqgdPVULvvzS6MXi3DQYppd8B/mYF8hsUluSjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790624805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DjWL33RjV95xTt1D0/ChwR8xGehOiL3e+T7GPZ2yFCg=;
	b=qxoco1R4bxN/DJSCI+Jnh6Zik+ZA85YqQKvPs9VZl3fXNrY2TPUYgMvR0lb36Q2Pa90V
	 PCL1w2pLWe9AU5H64/WWgB4OgmA03YJo/nQNx/h9xsQKbZCQVTrrwZLhNufCqeD3++miE
	 qWXeiunR5e9OePM9E5kp+CGVqOGpU9ojrrzoyx4hUqmhZvvxFAm5R7pwSy9sOtCTnA8cM
	 JXuMdGB33a3/4/7c8ljbblrcJ+9zpGWUWJ0Ug1a+1Z2oy1vQRlt5Ld3kfaUTYonFmN1+R
	 bOXbm1PJTCK5tsTgYM/jja6gYg5PEF/+uygR/ro4YID6tMrEfPrDot/A53sxEtii/Ww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Hv8nVJ6+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790624805;
	bh=DjWL33RjV95xTt1D0/ChwR8xGehOiL3e+T7GPZ2yFCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GOPE+m4phtmJlBheTLquUTxszkQlqL+gQqLJ62lfJ6kptZE/lHv8k6P9GENXQi2kC
	 dDAeJ1n51+pa8BGhkiM7ZXuf+SYxaeXstKyZxKXRr6HaOhg3e/GZg4mHWUKx8EDKVP
	 N3y3QztM4mM8r0BPXSzoet/LpLudohjX/e9Bw5Cfq0vBi6cPAS5ehUJC+qt1txKBcQ
	 iU/0+n4t8K31EQ+VN9loJhDSkw5fi5OUfhijxkFtrsGKYY+uGEh2ll/RgWh8G7YBxA
	 6Q/Qy5eXEdUix7mUyMHscY1IF7ptQzyTEdwvijJefIBW6y+BkQe/PeVk0Bxbq/46Ze
	 +EI8leqJ1bkdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13E8640448;
	Mon, 28 Sep 2026 19:46:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B247335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7D9940448
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mHzaJqe4DHxk for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 19:46:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 317AE4043E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790624802;
 b=M5zwTGEExgAMCcZnlyXlKUT/yAfyTOHfFnCC7g7XMGnHrHi4pce153o8WgQR5EjjTA9j
 K6S47/z3cKZ+p+AWV3peU/1YFm7sv6RDzP52hKoJ/Vj4UsD968KZe724L8exa5jStwbRV
 OULYqyVXYY1mSPRYz/vnCnQzGY7EL2/oFXiib6O6GsCN2+R4QnAdGI8Vlx4cfGS58E5g8
 fn2b24ikslAiQJJdCn+2EuKGgo3v+mGY6Xk8ENG4jmdDNL1+tVSphjTq/pDxWXs0DaUZ2
 YaEPxcIw+WGiFO7Og5K25Ta5kGlnk5UwprZf+85oVAz0/yki95ZpeH+FWE2e6trSIWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790624802;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=DjWL33RjV95xTt1D0/ChwR8xGehOiL3e+T7GPZ2yFCg=;
 b=gvmu5b2nF2Bo07HI80tzT+ZEpQHhhyX5GnMrZTk97GyhfInWGGptQ0OrqrmK1V0gme1L
 JPxZ5pi8KcejHcsFOyqzTgz0YzlM9jCAbXvQwngcLMCrPwPNHFJNrrAPPEteN97N03GHp
 3ecEJerPTRG/4AzmlR5hi3jOX2DmfULmG5527FJTyBt2E/mqd8GFKNcESOgZVJ9OA9H4T
 P13xYsb+Z/w+3NKFcfEWhEVDfNlHMTi/r9pnv6tyrEQLOSaIQCeFlY5h0TLSUGb+EvDHx
 ytRKKTAhLMsbxoeSO7VVa7+iexU8XcohWGonoWJ7hnGvdpSVrL2PJR/H1liThRWVaaw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Hv8nVJ6+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Hv8nVJ6+
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 317AE4043E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:46:41 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-4b94bb43008so649611b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790624801; x=1791229601;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DjWL33RjV95xTt1D0/ChwR8xGehOiL3e+T7GPZ2yFCg=;
 b=Hv8nVJ6+eU3V+qF3KymklCv4qB+1hfBbbs5dbTNljpzX9ck3OZ0rd/1OeDWJCsqTU0
 zgXS1mlBROH+O/81ch2Qas+Scj7PhmOqvvgzFzfUM2L1isWs3did49md8bmiYsvhKHPV
 UVEUy3xvJMVibVZl64wnivTSpjDZWHy107YGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790624801; x=1791229601;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DjWL33RjV95xTt1D0/ChwR8xGehOiL3e+T7GPZ2yFCg=;
 b=k5mmPJ+vV8et/dieCX/+AKfoSWlhQ9UxgnNTL4/l3xlARoxKtf9tjcsW8p12iU8uXT
 RVxStXzgwuP1ziVRxRC9+8FtvEcL+jr7MfJqh0r5FVpiZ1+pISIdREC9HDuj0pLnBZAY
 OeEbCRJkFv/1NAxXHQDTu8I36lTKz/rKM7V4DQpHr9E6oOLl7ZYmcpGcX8imrt0/nfJ7
 ga5+lf29JIgnRyfXpmf5R6x8TH2YoDM96nD8q+0kaTD8YYXOYpCizG9kh/LH3dzwXrV5
 UuiQPBrlFSXlURa+nSvurc1MHfvZAARip5WEIa6xmJmLQmRHUr8vuWBXOsexly6tmTSz
 hWYg==
X-Gm-Message-State: AFuF++lAEcU9Ir5HZ8QXIjjaxJoktxF6Py9hL+ocar1diXcp/Wgts7vZ
 uo/K+loPHU4AvjaHCjHXPGuVDV6a5J2BRox3fkLmAv5HiHp1SQPhk4mLjr836woODUw=
X-Gm-Gg: AYBFou08/jnJgpQE9rWW1Zbxt/bHm4/mUYsEGpf1zRnwaoMXP1YcHppqtFmuJZL4YDE
 BYWHVLgPNEQ97tIn3fIY+2binXm+d0z781RJAE/5hlRoEWFgvie3MCGUls1LYtGOoTazoOtKJsN
 0EAFiM8S4r7ZFEqRbDsrQYgQCG5AM3B+PYqiF8+yP95b2u6Ns9VruYSAi8ETB0WE3H1eN7xwZad
 dgGChlpQRfgTyInzTKFe/EWlue7i3y4vM0UiFVk/7GrepWmVm5xYwjB4AiwXTN5szdty5j+DdmI
 oZYmKmxPigBAnKv/9mt+v8eCOoRTY1gmNyB4C4CM6OF6W8z85EzlBkFXZRlmaLBc0D0ML5i6JXe
 TfwDuB5133L/MHDDRdznk2Xo+HUp2FD2yVyFc971f5zXa6tZ4xel3ovOSjFS0GjVljLHcJF0jM7
 suZP49j3UfCXcHKFX4mFE2W4w/Vr82bHn22tf/rZhjVSWoK6xO088E7bnnvsdGYAfOzuvKCzkU/
 lg9VhowTEQR1vgKWXkJ1M1zunxWUmvCKD4YKzvbYDeiR7PxONdvCh1lFEHQTO4g112KK3QD8aat
 qYQbbfMzz7VUxjzIPCrj
X-Received: by 2002:a05:6808:6402:b0:4b9:a88b:8894 with SMTP id
 5614622812f47-4d72c738d20mr14311306b6e.42.1790624800717; 
 Mon, 28 Sep 2026 12:46:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ebbd25cf71sm2450054b6e.16.2026.09.28.12.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:46:39 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:46:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH next 02/13] Makefile: Link a toolchain libgcc outside
 --whole-archive with LTO
Message-ID: <20260928194637.GO858934@bill-the-cat>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-3-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kEVfmPcX0R3QW93x"
Content-Disposition: inline
In-Reply-To: <20260928110434.70686-3-pepe.schlehofer@gmail.com>
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


--kEVfmPcX0R3QW93x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 01:04:23PM +0200, Josef Schlehofer wrote:

> Commit c1094987d1dc ("build: support building with Link Time
> Optimizations") put $(PLATFORM_LIBS) inside the --whole-archive group
> of the LTO link rules. That works for the in-tree libgcc that
> CONFIG_USE_PRIVATE_LIBGCC builds.
>=20
> A toolchain libgcc, though, then gets every member force-linked,
> split-stack helpers included. With Debian's powerpc-linux-gnu GCC
> 14.2, turris_1x_nor with CONFIG_LTO=3Dy, which mpc85xx allows later in
> this series, fails to link with undefined references such as
> __morestack_fail and __tls_get_addr.
>=20
> Keep the in-tree libgcc inside --whole-archive, but link a toolchain
> libgcc after --no-whole-archive, as the non-LTO link rules do. ARM64
> has no private libgcc, so its LTO boards now link libgcc this way too.
>=20
> Fixes: c1094987d1dc ("build: support building with Link Time Optimization=
s")
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Marek Beh=FAn <kabel@kernel.org>
> ---
> --gc-sections, which commit 34ccadcd3334 ("ARM: don't use --gc-sections
> with LTO when using private libgcc") keeps on ARM for LTO with a
> toolchain libgcc, is set on powerpc and does not help here.

Since we have ARM boards that do, and others that don't, set
USE_PRIVATE_LIBGCC why isn't the solution to just replicate that logic
under arch/powerpc/config.mk ? I also don't see a later patch that
guards and drops out -ffunction-sections -fdata-sections when LTO is
enabled.

Also, in your next iteration please drop Pali Roh=E1r from the emails as
he does not wish to be involved with U-Boot. Thanks.

--=20
Tom

--kEVfmPcX0R3QW93x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarrEFQAKCRAr4qD1Cr/k
CqmdAP48U1a8i5JTW/NYzEw7EFjUzqXqRSqCJYGok+jtWDt2YQD+PkJFfuuBvM5e
BzD6vc8a1okS9T+Bcw42A/uJdcDVzA8=
=iuZ/
-----END PGP SIGNATURE-----

--kEVfmPcX0R3QW93x--
