Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FC606A33E
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HJ2XEwKE;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=CQaJiYS/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B239B81283;
	Wed,  4 Nov 2026 22:42:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RTplLYpCMalc; Wed,  4 Nov 2026 22:42:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D483E81257
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793832130;
	b=PMBwRfKy7qIg05i/yoY1epZ7M+jhH1GU0RHCFyXVr0CS02SBXPtRXgJhdZmVLB/bt1o3
	 0R5t/KaPFVstG1M/aBaPwG8kokZHaEakfIdH27/dolQtS5BOAtb9dod7Xda1xOLu/DThj
	 sudLEXwvfZaW2aEyhPzFf2o/IdxHufV9p6oTud2qSFyFSjzR/aV4HhHQCUV6lQZfCjKQe
	 PomTaHFhR+20QYgqleMxP0lohooSFIyKzZtsr6bw1rgowNMJvtHqtJnzvrWtQj9/ODpcY
	 H8/sYIgNlYFKhs0qXAYlB83Ln92RACh1mBO0OIZEbK+71SuMdt+os4Kqudjzzg0vPHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793832130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IyJeFWikDKqwBmy0KKVvauVQRXwtl0PqC3rYdvTxmCk=;
	b=Ai4q/t/LDzNuJF7FFHHJVbCNrhdBNwzQnxrKdIJm0mRT3Gn3Tx0UZ3jz10gkbR5MtEX5
	 bdUIYnh/sRLzGjqFr6aCAC0JfjPKNsw8JT2nLgMb5LTRnlD8mE7Fro2hGl/XCP1lpaO5z
	 +Taz9VDyax/kBFV1ZOeYTIeNTK7zuxTID2dfsLjI3miR/xIWVbQCc6o3Lbm6YQdhpVpcr
	 4ydH9DjH9v96LUsSrF6h4k8wqvGOiWuQf6F5mb4UM4MfSZadWEDLEa8kAwM0kscDQkIfZ
	 ZV7JPlJ/IRuzcZfH4fwo7pJVBQRpUUZTbiCHb47jM34GlS6h+MtXm7FBhzqYCDcm/ug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793832130;
	bh=IyJeFWikDKqwBmy0KKVvauVQRXwtl0PqC3rYdvTxmCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HJ2XEwKEBlhW0Abw7fxDoHQbLWm3kSO/vrzAunJJG1QucHhNQrd+Aq56QxxF51qyH
	 a8WMpm38RG0P6b8Yn0xEHSeIHv8dgeBSksSB/gz3jPQ+nWLFAHUEf22k9Rcc6tlS8E
	 dLlwc6OU7PLK4+DtSewyqZXoa+unzlOsxyU9LYbVZFmUlgWMrbNJDCxQC7mht/JsLK
	 gIBzChyz6T6Plp7rBOXHNLnkuOZq0KH3PVFx0fdjWMVUP1O695QmO1siA+/RYRTz5+
	 +ioYXW4YSTTSBb0Nm3N149s8+xUSVmIdGJPZ/+AbLuPiQ5Z6MeIHS1mguSLzl6p6bG
	 fTplZoaJBVltA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D483E81257;
	Wed,  4 Nov 2026 22:42:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F16CB00
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 22:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6250640858
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 22:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6sRGXBmuk1RT for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 22:42:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67E9D40856
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::9;
 helo=mail-oa2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CQaJiYS/
Received: from mail-oa2-x09.google.com (mail-oa2-x09.google.com
 [IPv6:2607:f8b0:4864:30::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67E9D40856
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 22:42:06 +0000 (UTC)
Received: by mail-oa2-x09.google.com with SMTP id
 586e51a60fabf-47bb3ddaaf6so852845fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 14:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793832126; x=1794436926;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IyJeFWikDKqwBmy0KKVvauVQRXwtl0PqC3rYdvTxmCk=;
 b=CQaJiYS/5EZHpY5XHWhj1XSd+vKQ6w9gElFfnXXUV4R9goCG1SPI0ihxkPKXPmnKwD
 bbxasepErkiOuW5dD/kdCKO8YfDpfytCjC+jxQyZ3jwWh/fOolGoYyqbNSvMgkB7qkDF
 q2dfUX1I6ndDHmL+smCCOgBSVRwXVmNU5U2FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832126; x=1794436926;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IyJeFWikDKqwBmy0KKVvauVQRXwtl0PqC3rYdvTxmCk=;
 b=GDaLdVuZontZh2sQv7uPBFyjXdCJ4odbAnUgXgYD9Zb945SIw+jejYa/JD5PiV15WF
 VgtScmcraWZ0J45ryY+LIw0G3XBeljcnXDCzO56SqEmwEeAwlfuxv1nLSr73pmki28WC
 UirklUfLTZOL424n1u1QsK1BIcCLerzLhilrh1/goAobqwQiheyX93DJgrmnOyEktdF5
 6oBAACi84WNHID2G2IPYdLQWZfyWW63BOoUYwnlRWQlAlMaX08D8ykC85PkAfwoYwLfy
 Sw9Qn0OvQ8YF/kdruUw6nodLz7zfxxTC2kVmWwsq/RRCVieZmUe0HYV5c+lq7Na3+YZ9
 b4MQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByGqqLfB+R6fYjdEeJjHorsYxuNFGY3Z/00IFLCcsb98opSyCzBaCZEnI9+cqu4tijaWT4hpho=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/2U3mflk8DAR1PsVxNXDEyU0NlrNe36N8sCpuvGjGZlV9A3Dp1
 gAusnLJHWSK4zgqIkllgXt39QSChTCXfXEsLAUx9/Mx2pzGwAQfbg3V/ze2dbUcRYaA=
X-Gm-Gg: AYBFou1as0NdKTwcO7SIy2oUTVSSzoS2CaKW5Ye/4jkZF34Wf04pfyZOy1mELvNu2az
 EcOSeDVgqMLXSNhmxlTGGSUkju3w8kKcnDCfrRFkarbiUIsQBfvPsi6twb4gEZZ3AUlT1BjcTS0
 /QJMHcWb9O+jXoWndpi9TJlY4oGqo55gKxnQPpsabrJlBvNiXxRjaxmFgXGLeDziO/1ApZMpKQ/
 E4ait8gbeuk3tRjHPVWhU/nQIVNVlse35C1ZXEIwPUSL3l6iNUzEh/7ZlJbi5+EssAi6lnYoncX
 k8Ay4tm8ck6t/qCXpm3ur6hBDdXkT91PNS7mjZAWqJqgQet+DUaX8zumEJdngvMOG9v1oB5P9n2
 d8LKTMg3Uf13NdVvJmKPk1MTvyOHsLhj7H5IM0oVOBZzW4nmf+crIND1UX7qWtOcUxLDen1Zq7k
 54jJHqgf4HXVRZMwJRRZd43knHY6pW9hKXT08DgxQy0ApaMG3r3wS9p1ivBqZHac0kTWspvE6TW
 Edu25+A2gtK45kHyNh4/mllxpfD4lZ8KOCEshTmKwSCozCqJD94k+MPDxI5bRFEa6/PwYK5+zoL
 CBTSgVSOpYTtbrAMJNubPiFcmoizZryYOBpYUB2mKf7f/x/8lbSE28RwykxXydHP9PIIzdx3wdv
 IkDXwYxtfl3t4AQW/W4qNxymd83nNavw+jo/1E8iwVFnUh29NzW6vMcPVKjglISq9DhDUnhrWph
 QiWtIbyP5h1lS0ZmoVpeRiUx4LMTzCxQ==
X-Received: by 2002:a05:6870:3508:b0:4ad:65da:cba6 with SMTP id
 586e51a60fabf-4ad65db23ddmr1374118fac.0.1793832125574; 
 Wed, 04 Nov 2026 14:42:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4acea4903e9sm3091135fac.3.2026.11.04.14.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:42:05 -0800 (PST)
Date: Wed, 4 Nov 2026 16:42:02 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH v2 0/4] spl: pass the bloblist to the next phase in
 registers
Message-ID: <20261104224202.GJ1164024@bill-the-cat>
References: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l/cfhVViUBKVTbGw"
Content-Disposition: inline
In-Reply-To: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--l/cfhVViUBKVTbGw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 03:51:53PM -0600, David Lechner wrote:

> U-Boot proper already accepts a bloblist passed in registers with the
> register conventions of the Firmware Handoff spec, but SPL has no way to
> pass its own bloblist on like this. The only option today is
> BLOBLIST_FIXED, which needs every phase to agree on a fixed address.
>=20
> This series adds config SPL_BLOBLIST_PASS_REGS. With it, SPL works out
> the register values once, right after it finishes the bloblist, and the
> default jump_to_image() passes them to the next phase. When SPL starts
> BL31 (SPL_ATF), the bloblist is passed to BL33 the same way, through the
> BL33 entry point arguments.
>=20
> The register values come from a new hook, xferlist_to_boot_arg(), the
> counterpart of xferlist_from_boot_arg(). It has a weak default in
> common/bloblist.c and the ARM version in arch/arm/lib/xferlist.c, so
> other architectures can add theirs later.
>=20
> This replaces "spl: atf: optionally pass the bloblist to BL33" [1], which
> only handled the SPL_ATF case. The Genio 520 and 720 SPL series will use
> it.
>=20
> Testing:
> - sandbox: new "ut bloblist reg_conv" test.
> - QEMU arm64, SPL -> U-Boot proper: on top of "board: qemu-arm: Add SPL
>   support" [2] (which also needs scripts/Makefile.xpl to skip the SPL
>   devicetree when OF_OMIT_DTB is set), U-Boot proper finds a record that
>   SPL added to the bloblist.
> - SPL -> BL31 -> U-Boot proper: Genio 720 EVK.
> - 32-bit ARM: build only (Cubietruck with the option enabled), checked
>   the register order in the disassembly.
>=20
> [1]: https://lore.kernel.org/u-boot/20261023-mtk-genio-720-spl-v1-3-f2c0e=
e094fd0@baylibre.com/
> [2]: https://lore.kernel.org/u-boot/20261009-spl-for-quemu-arm-v2-1-46042=
7488c17@gmail.com/
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Work out the register values once in board_init_r(), right after
>   bloblist_finish(), and keep them in struct spl_image_info.
> - spl: atf: set the BL33 arguments after bl2_plat_get_bl31_params*()
>   returns instead of in the default implementations, so that boards which
>   override these functions also pass the bloblist to BL33.
> - Link to v1: https://patch.msgid.link/20261103-spl-bloblist-pass-regs-v1=
-0-bbbbb7e65fdd@baylibre.com

I think this will do it, thanks!

--=20
Tom

--l/cfhVViUBKVTbGw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauu0swAKCRAr4qD1Cr/k
Cm6NAQCVmr0VUFGP13e5NJtwFBF0yhnVkEZvj4knpnlx5RownwEAsEnYADmrYMuJ
TbKwMQ+eNIzCZ7b5dO7ZNKl5dMdi/Qc=
=WE1O
-----END PGP SIGNATURE-----

--l/cfhVViUBKVTbGw--
