Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3E7CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7222760680;
	Mon, 12 Oct 2026 19:15:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4r9T8r2AZaa; Mon, 12 Oct 2026 19:15:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B5ABC6060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791832554;
	b=dNubPFP3wIPVcA2hjbGCbwux5Qn0t15ywKZHVBbZ/6YTirbNoYt6ZfSAq+gXiDpOG07R
	 datOZGCjqmqkhU2OytIQrP9VicHrxQVDkf4m07QTVz6F9VM8D9BVsAql2ckjVHIq0P4Dh
	 6L0j2yWarBsMzLzxBIUydGFRqqmgRL6sNK5IRGzFCwW3vByssqkNVl9Jek0YybT12rTMc
	 2lFVw5Mp5Dr7OtBwDJ9XxvSs276N/i/qm14Ww1zc0UzIJgTQGCP2aZ96lOGedANtrPzlC
	 r2yZz1MWPJlXmJzDm2L2ot4XWWt7n2tqEChm9/2IUfBLw5nJiX/TtGbhGcTaIitPIxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791832554;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rRh3sa9RVShXHtfl8L6wJgmuv6ICY9FgflwTFhxc8dM=;
	b=ZIfL3xztBd9bJ6KvCIs2mV9B5UfGBgxOfXdX67C5NSx4BsICASv+L4X3HyjDVPf9dCXU
	 6RolAlFJimdSr6tPgFhg8urq/JpkndJ0C2cw6wa+Ad1MiR7fU6gw0vOVlPiVfyUSqp3Zo
	 +FOHRRvRsBsmHIYw1569C0C78Nc3KW1GZV1RZD/5dzukS368HL6kmU3cePogJaoG5foRM
	 WJizeYz68GdqjnIOprOT770Y+MitEqWh+epCn98o2TM9jgxZt3SVHPbbf5H2sHTRDNhyV
	 eGo2RtkuVHf8gzOQ41Z5/Ij7QdMaZ0CxYnwCEdtwR9qYxJixsO3YMc8HRnamOo+Wcow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791832554;
	bh=rRh3sa9RVShXHtfl8L6wJgmuv6ICY9FgflwTFhxc8dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3zY35tJSFvSrMyYUjLk2WXv+2NW5eMxpipIks/BzsdmUZ+i3u8s30C0stAjxmuB+
	 R5L4uK041OeR7kkDxBq1hKvbermPf8RaWbfj2SEsdL+5vV8WvNF517lrbEaiNpqRWf
	 yAJTnIEBuM+bEgLX+it2bvbrGhdvlY7euSSj7TLMkBFEVJ/mnpUW4SbnpgTMs05CyE
	 j6XwHNyqOQRe3lD106VXDMOOuXfGEC7Y1gQCWumAW4V0/M+SkO0bN8NInsVzzwuiol
	 KGiJ/+2y1TOA7dzsDvN9SlE3XMr+vJEcwf6Acm/Nuzn2nrqNG4Y4Txvhz0ZQ+D1GZ2
	 tmYhcHlHPtN6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5ABC6060C;
	Mon, 12 Oct 2026 19:15:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6490F788
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55B6180B86
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BNZEv0s_SgO2 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:15:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A60880966
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791832552;
 b=SM5NYoKFGiCG+WAzKNGWWo6nP2rb4C7pptfdwa/0bk1LPCniUIRq3fYzCVpR75rlV7vF
 iKmv7XfsQyQpxgfzEeICN7eC1iEgcPpYdHguhBWg+DUGG3p4sOA/yn2VE47Lb2IeZuK+3
 ox3MFpERMLuxAIYebmEYPm8jxhmnMjiiMp6Dc46JzRFvDp/U3kP3xEmjxwXUvXVJf2ypO
 sXcCdFBJZyqihE2mwJ1psL0wGBHnzKwz/wcucqKCsI7yXJiG3RpBF1K8D+j+5CWeZx+Xs
 azE6OP80Wewc+6Doy/ic3KRb9Inbvkf6JPcQ10ziG157xpqrD4sh12zhQM0zO5g+qEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791832552;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=rRh3sa9RVShXHtfl8L6wJgmuv6ICY9FgflwTFhxc8dM=;
 b=mNVl+sNGBMrCQN5b2FhJ4jF7AQ3vpvdQQB3NpJigkB+zG9ppOtxwO/NN7ImxDHf4se2i
 JdVfkcfctzHPUOBwpoXrh121X1ogTqiCLB3bWq07UiykMdK2X2Qw/uED2eru9yAWkihhu
 btChR91EuHvajJAhZxy1OkUlougc4fWKpTne09WHhGtfIwYixr8Vb8da4uTduNp0J0KOt
 tN36NIofzi9Z1cJXflQnhU53V5q09JENeE2klOlHWrTfw+pgJxmm4NFSH21qFaGYGUVsg
 zVjaK4Xxm7AxrE9YdDBJMZb0ro2ZxaCpvL/hNVYQBSvxFDbVImcLfHONhtpUxLCxdTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=h2OeAR8G; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=h2OeAR8G
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A60880966
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:15:52 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-823e4047037so1857988a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791832551; x=1792437351;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rRh3sa9RVShXHtfl8L6wJgmuv6ICY9FgflwTFhxc8dM=;
 b=h2OeAR8GbuiDZ9MULo6BtGM55PYggWySUxAGw0LT0kQm39CeTpaoKDAttIxjl1XPGC
 Zyw00+O2PCm8KAp9TlGu+pNbjDD4ErxtngdKZ0wk90GJHlu1MUI38PPMUTP2aPXE/ooO
 6yclGA5TO4q74LoXapKbr/EvxfxUxj2aaHAgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791832551; x=1792437351;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rRh3sa9RVShXHtfl8L6wJgmuv6ICY9FgflwTFhxc8dM=;
 b=loVEaD52EPXj/Nt+qiwtc1dqMf9CzQGJE0Q3Lxt5JIOgl7LpaPRCgIXNPi8Xees76q
 1sZVlmrJx99cnvxGp1Hc34BK+MELFUFR37vkJ/WLleIf8cVp+2l6v4Is08m550hgNBha
 aKL1kvullTzst7iMImDD6cMjCxoLVBhs176tLgQmo+y+lUvVB/W8OUs+rjMsVw/1Nvsh
 X9KTs07Xs+Bx35kYWQlIjqtk6IRxC2qXt6pa+tIBTTw117MQG6CR3lAMhIbzSuJdjO7j
 o4wecsAXJamdMfwh1U2qkYHlm4ruWTevXVvzjbpILpjFLzfNz5VM5GNXMF5NBDeJBbFQ
 +1Bw==
X-Gm-Message-State: AFq9FYIHXRejy5OCGzm+i9XDFYMROBiJtc8Ow28AHPW4BdWQ4tLGR/x3
 nwbooDCM6zcMa6ock1+fj4KJMkvHo4DMsFeDQ4XK0S6ClgNyRFIaGSMLCT0JqCA2jYk=
X-Gm-Gg: AYBFou1XvLREjYhciEAT+HBZmlZB3Dcj7IVWChdb5cUvgLU0qch/f3XFyA5S7HPoev3
 Y1UPz5Qz14L/s2QJqskuTtbIfdsJy+ZtgpPVsFOjCsiNvJP2COwGFq5k9PRlaLqYjqoYocPkmaL
 MerbOhTkB3UVaijZA97SOoNv505/kXKMn/ObQH46v/OcKZX3ZIGJmhToLwOep0FZGBIUVZCcLCh
 rne2IQ0CundaIkC535fElOtcjkMVdHl0HxF6EJcsOZHLtE9uQOIMBAT1p0sNdBlrr0uKNi9phFz
 URpm7ciPs/tUjcXZb1yviUxxu86+pNeeNU5RB3semLpJuV7ukN4YSs2o25kLuDnN+olG4HLIVjb
 ex3rsN2gmLw4E+d+8rWaiFCdUIrQHm3B+cbr/7AatJvgA8YdCfR3kLkMNqCx5DzmQ+bBEUdi0SH
 Qb6gQ737DMH+Z+vwfoLtbRMIARrQkqTjqU/0VbqZeuQ6cMDLSgulBwHM2ps88gd9seHpyZRhV46
 6AFkAR8gMYAf/HdEOIt/4Ppqlp9ZoTKAJp6EW12ABjlU8Q0KkE0MUroRKv0vMssKOFcuBAYKXId
 RSjfUIwfstvYOn37N/E=
X-Received: by 2002:a05:6808:1a19:b0:4e7:d180:7719 with SMTP id
 5614622812f47-50c516e80c4mr8502852b6e.42.1791832551066; 
 Mon, 12 Oct 2026 12:15:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c167544b5sm12236576b6e.3.2026.10.12.12.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:15:49 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:15:47 -0600
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
Subject: Re: [PATCH next 03/13] Makefile: Pass -static to the LTO link
Message-ID: <20261012191547.GG3722450@bill-the-cat>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-4-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zdQvNX+pSy4ycE8H"
Content-Disposition: inline
In-Reply-To: <20260928110434.70686-4-pepe.schlehofer@gmail.com>
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


--zdQvNX+pSy4ycE8H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 01:04:24PM +0200, Josef Schlehofer wrote:

> The LTO link runs through the compiler driver. On a toolchain
> configured with --enable-default-pie, such as Debian's GCC, the driver
> adds -pie, and links that are not PIE without LTO, such as the SPLs,
> then get dynamic sections that the non-LTO link does not create. With
> Debian's GCC 14.2 they make some ARM LTO boards exceed their SPL or
> image size limits, and turris_1x_nor with CONFIG_LTO=3Dy, which mpc85xx
> allows later in this series, fails to link:
>=20
>   ld: section .bootpg LMA [effff000,effff4c7] overlaps section
>       .rela.dyn LMA [effe8048,efffff03]
>=20
> Pass -static, which keeps the driver from adding -pie. ARM still links
> U-Boot proper with -pie, which the LTO link passes to the linker as
> -Wl,-pie, and u-boot.bin of the ARM LTO boards does not change.
>=20
> Fixes: c1094987d1dc ("build: support building with Link Time Optimization=
s")
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Marek Beh=FAn <kabel@kernel.org>
> ---
> With Debian's GCC 14.2, imx6dl_mamoj and phycore-rk3288 exceed their
> SPL size limits and turris_omnia its u-boot-with-spl.kwb limit without
> this patch; the cover letter has the build results.
> ---
>  Makefile             | 2 +-
>  scripts/Makefile.xpl | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index ca18c3b32c9..d9f53e20b9a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2112,7 +2112,7 @@ quiet_cmd_u-boot__ ?=3D LTO     $@
>  			$(u-boot-keep-syms-lto)					\
>  			$(LTO_LIBS_WHOLE)					\
>  		-Wl,--no-whole-archive						\
> -		$(LTO_LIBS_AFTER)						\
> +		$(LTO_LIBS_AFTER) -static					\
>  		-Wl,-Map,u-boot.map;						\
>  		$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>  else
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index 221ef7f29b3..69b35d6ffb6 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -527,7 +527,7 @@ quiet_cmd_u-boot-spl ?=3D LTO     $@
>  			$(patsubst $(obj)/%,%,$(u-boot-spl-keep-syms-lto))	\
>  			$(LTO_LIBS_WHOLE)					\
>  		-Wl,--no-whole-archive						\
> -		$(LTO_LIBS_AFTER)						\
> +		$(LTO_LIBS_AFTER) -static					\
>  		-Wl,-Map,$(SPL_BIN).map -o $(SPL_BIN)				\
>  	)
>  else

This is another generic change that should be done on its own, outside
the series, thanks.

--=20
Tom

--zdQvNX+pSy4ycE8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas0x4gAKCRAr4qD1Cr/k
CuvwAQD1ETXxFFePFw1viKdJlDryr4homlusn8uN7ayeOA9HywEAmhjxnwzRkFw7
QQahZ6LHEIFns/+NFLRn/UTpn4Zpjgw=
=rvUP
-----END PGP SIGNATURE-----

--zdQvNX+pSy4ycE8H--
