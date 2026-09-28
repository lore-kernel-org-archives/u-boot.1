Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB10ECA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 19:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78A2980B97;
	Mon, 28 Sep 2026 19:14:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwayNUAlTHWl; Mon, 28 Sep 2026 19:14:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6EFBA80B7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790622860;
	b=F+c8AqG2S3plhmrOQI+sNrVXYbMSxMy1x7fHnwHfNLSR+9YizRlEknOkUKMqcrJV+eP0
	 A6LBSrR01wRmpNBictoftayK+1j/y04+8Am2oQQyKchco94BLPguqZsh0s/50Vw9qM/Pk
	 NrHj7TUEp9b1ifXGbMuUOx7G9i/pEbY+La21qQVfvZAs+fbJxztnqQZ3K+b91HeXNrIN5
	 /LW/V7Q3rFzrd1bnfBOQNyUX7wypzrHIm7GwgU1M4fnjaFOsL2B/ZKtCf4MiLgXWhOy+M
	 AHzRk5sDcVSsq9CPO9V80JdyuDMkRL9hM1pnJH8Fmm+JwOcJDeqjDK8QWE8A0Lae+hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790622860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RhS8OgOB9gzdXI1+BQIW4/XmvEgy/Wb5C5Ty7mHOiNw=;
	b=MU9VQEHps7COsDvGSOhcuReiam6rZPl2abFB5ms7dIak/+dIdU0skN/WsKlhUhjoreGt
	 JRdz7KqgRTHl7shRvFsbKjUzN3gc9kTTAVyjvUBozPpjrZSJZ7hm5Z/mAp+93rkF/ibjm
	 us0hozHR+/zSqAuLKAb+IVd1xRiHa75kf+ZawPOTuvP3pCxfeg2XGam36a2xaJzhX7LTd
	 Gfeo4bIFc0nDCywxMGpJ5JvNF/Z21ALC3mN+7jW6zBmhb2fo5wnVTWHX0qUjb4MykD9hm
	 JafKgUgyDpixqiolx9xHhBOPqgcWgmKFPEUyWrUfWI9vJdlgTawWEY48RraAlOJAdWQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790622860;
	bh=RhS8OgOB9gzdXI1+BQIW4/XmvEgy/Wb5C5Ty7mHOiNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dy213EPymySgdgxP33531IjX+r6MOLexN7FBgE9qPeQkHocVdwVf9zI0F6wFHJJTW
	 7FjjNye8prd7YSYTXEEgkVkKpm83/aeAbpfnXKsSA9fZV65vVj6OXBN9dCw1oajLTG
	 94APUVszIuDPxFn3YceFLA1jp4EGq88+YpnzohWO/pi5PfEWMojrS/3b0zH4AU48lR
	 PjsCfE0OIKZpfqQDegCPr+SmsXk4HMOYO/OlYOUmdHrfzEzzGAGayzK6HG0nN6y9hw
	 t9fOreU6xlv4RLLbF/ehU4+QwgUCrREo/kqymBJzaSLrOX/nJiSXoI/uGCXkXRI1BX
	 F+Byqwq2x88aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EFBA80B7D;
	Mon, 28 Sep 2026 19:14:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E200972
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8923C401E1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atWrqyqvjk9h for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 19:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7E9E2400B4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790622857;
 b=qg1AjHeYcnDPn2yU60ZeTNg2e8/gOvHZxgJuL2/oHjB8gGOidiUSoEzYNTW846CPYT92
 G3SokCNJO8e30j3fdr1n3pgmq11aNcvHPEeYRpFyba4r0qUODC4/cPzMSqdSZZ2WocJHY
 pjG1332yG0g7tnSx17crO+vTM+rTiY5PY/1SFsfdqK1A+Ci2+YWXUYh5KSMsam7N3q6RG
 WH97Gzd996AhC0ZoVpBUntOZVIytzVUiFl5l/lfRSX+xX7Q8LfTEwG2V9Ac8u0mUdLiX7
 m4Hy09QnbaBAAVn1o02BBk7M1uWd6vYuDLiyViG2YeFvVjJAoSSyC8A1EfmlfO9yK6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790622857;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=RhS8OgOB9gzdXI1+BQIW4/XmvEgy/Wb5C5Ty7mHOiNw=;
 b=JNaGKZ8bdahpNsi6GdZZ9Sj5vhtK2ck2zLNH8pEX8ESh1EXXFC0YMalDHPJFM5U2V3KL
 qf7wj1o2PI0eyDkwKaeeclpS9cMdBe3DK3VrRSyN6tk0XT8ArEvhtj+lbGKENeQvPZeAi
 jS04vIDyvgAJ4OakJcIOLu0LWL/QdTRtdtkZv9LYMsWGwBqGW97LE7Pvpqbk+4gMtetcg
 ZgaE7MvF29UQQMb23iU/X5yQqPxLIm/bcxhkoAlFDxRKYgWFJWigkjHaio+Yb6zs3RqNK
 Zc2E00xsushs2BTMCZyPNJ8ZeM8Zm2YSaRvmPcUdnSbi+oDcRk3hEan/aPKDBLsL8VA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZhoMqDDF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::8;
 helo=mail-oo2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZhoMqDDF
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E9E2400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:14:16 +0000 (UTC)
Received: by mail-oo2-x08.google.com with SMTP id
 006d021491bc7-6d83a14360aso554758eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790622855; x=1791227655;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RhS8OgOB9gzdXI1+BQIW4/XmvEgy/Wb5C5Ty7mHOiNw=;
 b=ZhoMqDDFi3E7Tiz42U3eggM1yXP3Oe5abMyiAjJCvlE6bsR7+Jx8MpzAVZMsjMkhfN
 ZhhmAh/bgEHqGT7w6f6UafTMImvBUPOCBKc6O1FoJSdcNKoWi2n4HJa/qropfoH0irXJ
 QA8/0P87TLmMkA3waQ99cVF0CYcL7f98pLLYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790622855; x=1791227655;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RhS8OgOB9gzdXI1+BQIW4/XmvEgy/Wb5C5Ty7mHOiNw=;
 b=NVeIXU4E3X+rZ4knfOCz8k0ftWYTS8LK0f9fJqHUAqDcjYMB7r9urJSrORxAJPtGxv
 6eJ2Gggw0oxyDZg3B/MEwd1iZBDtojDcI8O8xcI07CQv5VFTI7kZtjTCm2fJ5jU40qfy
 Cwg7RZiKH3LbRSybpll3WrNkqjy81cczx+xUybjgOaRp4ufQfK1FePqRvEEcirfU2cq9
 G0bRjMHqNQ2kNZ1pH8bo5gEdKpzOLuLUTn7LNsu3FuntLFAV9gdXLaw899mL0xp71lMc
 0JfnQzUIBlRlqRclEayI237Mc+sg7YV7fmQ6j/W8VgY8XUPR97Ahia6mz9jVYmdwvkyR
 ZraQ==
X-Gm-Message-State: AFuF++nNJw5D5bBj9Ad9f+oSP0/FzZmBeNVqgAOPe+PoVeHoNJu2CSPk
 Wsp9pS8tc6+QLFssW8DpPmqzfnlTnT4HpAVlt89YwGkouOY6P2uy7Viz/+fzFwMoGDU=
X-Gm-Gg: AYBFou0pklIu+rntyE/o8FtFWITfILwfT+J0Km0hvY0J1V0HNkgzgTPYaj1lKZBul5a
 9Qx2pcVjygnVPluCz4c566F9awonpLa0fCzhgk879qXYCIJPVJLy9LbMN4ngYb21if+GizYQdv7
 Pd5MFgYrwEqtuhJHZfnOqeA+CVFtucn1PpmJrqbsBUNKr5+OCS9/aLTRnEJ1CG4hVVyQuZobZKi
 h9OCnA7LB5INsc6wbULwDKdpkmVujLsKdlKNx4lMOkNS0HgMo4tSmK3DFpBoqCorGix/0771keI
 ULDorNfTEk7Q4X7i2ePqhj6Xd00fRIEnbOqN0xuS2O4gjk7arq6BQGZT5OOJD7wXGUqWxtOpswx
 Ng8py9l6oy6MwCUKJcwJsMkaNFvEzuoTqKRVZ8ZGqyMZsH+2q2uzYWlbLCO7Kp2Tf/HKZMksuad
 wsPTvlHbF3W4YVUOfL9qP7dcuJmNIf036qgivIQedkxW0HWy34XWLXu55SWPsr3bezG0XLk9nzH
 2gk71msmFYx2cfdgXWFITNZ5jMTFEeW4x1yUcx1GsX3wKoE/jvCipc1ghofFAqpOcv+9jFNEgLE
 PjekJQrFycK7YU8z5kc=
X-Received: by 2002:a05:6820:4d0a:b0:6b1:b33a:db69 with SMTP id
 006d021491bc7-6d43f2c3c35mr12062355eaf.15.1790622855413; 
 Mon, 28 Sep 2026 12:14:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d5901ac3esm2409886a34.26.2026.09.28.12.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:14:14 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:14:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v4 00/10] board: lx2160a: runtime SD 1 lane configuration
 for LX2160A boards
Message-ID: <20260928191412.GN858934@bill-the-cat>
References: <20260928101330.881662-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NO+C0yaSvxUf+IpB"
Content-Disposition: inline
In-Reply-To: <20260928101330.881662-1-vjardin@free.fr>
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


--NO+C0yaSvxUf+IpB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:13:19PM +0200, Vincent Jardin wrote:
>=20
> The 1x100GE + 4x25G split of SerDes 1 is in next since v1, commit
> 035d68fc36b5 ("lx2160: add lx2160_serdes split and management").
>=20
> v4 builds on it with incremental patches to ease reviews, but with
> many reworks:
>=20
> - No more command that re-groups the lanes at the prompt: the MC has
>   already started. Use hwconfig
> - hwconfig values are named based on needed cases:
>   serdes1:split becomes serdes1:100g4x25g (patch 2)
> - Use a table
> - One patch per new mode: 2x40GE, 1x40GE + 4x10G and 1x100GE + 4x10G
> - Rewrite documentation
> - Add and apply to nbxv3
>=20
> It is now mainly tested on a Nodebox v3
>   setenv hwconfig serdes1:<mode>
>   saveenv
>   reset
>=20
> - print checks using lx2160_serdes status 1
> - in Linux, with the matching MC DPC, DPL: each case has its netdevices
>=20
> v3: https://lore.kernel.org/u-boot/20260916211549.3432913-1-vjardin@free.=
fr/
> v2: https://lore.kernel.org/u-boot/20260914170417.3052423-1-vjardin@free.=
fr/
>=20
> Changes in v4:
> - rebased on next, incremental over v1 instead of replacing it
> - 1/10 (new): drop `lx2160_serdes split`
> - 2/10 (new): rename serdes1:split to serdes1:100g4x25g
> - 3/10 (new): use a table to set SD1
> - 4/10 (new): report invalid serdes1 names
> - 5/10 (new): refuse once the MC runs
> - 6/10, 7/10, 8/10: resp. v3 2/5, 3/5, 4/5: add other modes
> - 9/10: v3 5/5, rewritten doc
> - 10/10 (new): apply sd1 for the nbxv3
>=20
> Vincent Jardin (10):
>   board: lx2160a: serdes: drop the split subcommand
>   board: lx2160a: serdes: rename serdes1:split to serdes1:100g4x25g
>   board: lx2160a: serdes: set SD1 with a table
>   board: lx2160a: serdes: report unknown SD1 cases
>   board: lx2160a: serdes: no SD1 config once MC runs
>   board: lx2160a: serdes: add serdes1:2x40g
>   board: lx2160a: serdes: add serdes1:40g4x10g
>   board: lx2160a: serdes: add serdes1:100g4x10g
>   doc: lx2160a: document the sd1 hwconfig option
>   board: nbxv3: apply sd1 hwconfig before MC starts
>=20
>  .../cpu/armv8/fsl-layerscape/doc/README.soc   |   7 +
>  board/nxp/lx2160a/eth_lx2160aqds.c            |   4 +-
>  board/nxp/lx2160a/nbxv3/eth_nbxv3.c           |   3 +
>  board/nxp/lx2160a/serdes_split.c              | 588 ++++++++++++++----
>  board/nxp/lx2160a/serdes_split.h              |  16 +-
>  doc/README.fsl-hwconfig                       |  61 ++
>  6 files changed, 556 insertions(+), 123 deletions(-)

Those two doc files, has anyone asked you to please convert them to rST
and then update them? And, I don't hate the idea of doing that as a
follow-up, but since we have people touching the files that understand
the content, this is the time to convert. Thanks!

--=20
Tom

--NO+C0yaSvxUf+IpB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarq8gAAKCRAr4qD1Cr/k
ChHYAQC/Hne7jWRlalajSKRyoG2yPxZsVMUPZsm7exZsh7eA+gD/fwsNEs+lMSnH
hts35K2DCZcmfe1TqnVHvM7Kqq3fFwY=
=7lJW
-----END PGP SIGNATURE-----

--NO+C0yaSvxUf+IpB--
