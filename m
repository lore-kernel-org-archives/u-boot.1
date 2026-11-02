Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC806606B1D9
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tVklRBUO;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=JbX/pFaj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFCC6406B0;
	Mon,  2 Nov 2026 17:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XC6cicwRHRwU; Mon,  2 Nov 2026 17:25:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CCA13406C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793640358;
	b=V+jJEaP2lb2OJogdl5/iGQvXk4hI0Oxn0A7rYwmRHPSHm37djXOCWfQQ/ScopgaTRH0s
	 HYt8izFb2C9qvxbKzzDP8RMUzDtKtoIdFXI8Yn2BXocBo8TIY2n7mR5uf7TcHKe4XWR6c
	 0425GnI8Nz777uK+ThJpqgtzzz08zSPpwl0MGAlAjxp/ihbLBt/CjXMCbqhENKR1ovfZq
	 1PrXUIEIWlRPTtAuQlEB1W3b5bpScpdI+h7b2isTiYWy4JZb60k7iboHzFamJ8dPMpUML
	 dRkuIzNbW/lWJ9VRoDG/N0cgIdZvLIPBVBCflRUGAzQ7UTzueXeGRObfAMIqJ8H+lTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793640358;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fIxnq9/aPptglcI3bm7dq+4+R93f97eZCKhHYXbyIBk=;
	b=iAD7hKi2BoTLmFeYsA0L79TBA3XLdM6C0J/eZyEROZ6Y/LM6AEoL1h0EoZpb2ngPd4gK
	 eVQ2/p0qvMS2xoBDp80fL92on7x6677Aru73r9br5eI+o6IF9CaArp338hccreBJVVc5P
	 5aYgT+VxDyIaz2g08H6RDH999VQjZ7uD7DPgrs9jE0mHbk7IvgNIgXyM05uaKM9ACOdHL
	 ROTGtYP+QcAs/M1nUnmzwWnP0aTcuVx23Tr83PhSE+5ihdNzbVUFykqnQoRjJVosLN1jY
	 Sskr3+t6hQC7U+G69hWMez9BVi8Dso0qr4MF1ejI1iHgmh0Izb93PAypMaa+1I2rwrQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793640357;
	bh=fIxnq9/aPptglcI3bm7dq+4+R93f97eZCKhHYXbyIBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tVklRBUOCZTRQQQSjG1PLLUQQZMPBqWNruGwHgAtZE+maEUsG4ajsQbE0J5UjvnhY
	 F4fXfHLYwaZVD8K+Hjkz7i7H9PYNzbXA9MVP8X92PtYPzLdJAsRlVHtwOuzBVYAOdJ
	 +5Dnh82hlkuuVObECsC6PaepK9M+eUKOaik21lQ6eANJ+SgUwLvF+5GhzzNxaAzHwU
	 gugVVWU8266QPWSOg1ePDX6cdV5R4cv76AQODqq+urhgUqkjZw2Cr3TOt1dNwQxEi2
	 tnASV3yHxdVuy49jBVRrxukrWU2IOtVp4zc/cWe8V/tgfduxFaq+ohu970OroTdtEE
	 cwL/r1B9Z3Lxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCA13406C4;
	Mon,  2 Nov 2026 17:25:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A0B96411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 924C960642
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:25:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IT8puXt5i906 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 17:25:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CDB3B607EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793640355;
 b=ktnWbtEam3vG56JTjBdNBpJPJHyZ3pNa6Mns18Js5zwqFvQCE055X5dTLlDoma/BjyK8
 kyN1ENvqsaYY8bEthSWf33m3J8Jc06IaWTfCmNq1nWF676z5vW5LCAp7DdnowtSoXVxI7
 hcfpfXl81BhuRcdvnmapdcCzPmcA5zFUjgERzr4tzr+TwvYALykZzPVTcZsWGoe6rBYEl
 qDERwJX/TDev3FH3d+zihcik1DyBTapXwKMcG3OHpBs/z+lAxioBJzavQPgBwkvvn9LoS
 qVGuxvRfGv1YfsS1QNBjOZChxRFc62463cL6NeiLPOb5MwrwhzTrqdAY6xW2U0/zzaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793640355;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=fIxnq9/aPptglcI3bm7dq+4+R93f97eZCKhHYXbyIBk=;
 b=JrjXf9MCptygUGWttIEqOmxNLCW8EsM9cL7+c67PPiHGw4m2PVakq/lCPqX0wXexpNY2
 lX2vUbHFEDfEUbm9JQVQHAid4LNLbWFkFKcz3N33n2P8AX3Reiou6odQbfBgsUc9GaNoq
 eX/13bzvH3OtXX8cx6HFgVIJv9/NoxERAu31QFKTcOgPDV3Q81o4M41sXzkT5YKNdla+z
 Vcj9IIoCt6+NO9HBXaIgowL2lW35Gej73+iYb5y7LQttLBY9v8GtemQBt6mjf2RkP3gBL
 if7ITBTF9Qxx8C0HGqi63NVv5KZDZRK3jGPJantiQWszKZuxY7emsfd40NmZ5XVwxvw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="JbX/pFaj"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JbX/pFaj
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDB3B607EC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:25:54 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-849c2965b9eso1584550a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 09:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793640353; x=1794245153;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fIxnq9/aPptglcI3bm7dq+4+R93f97eZCKhHYXbyIBk=;
 b=JbX/pFajQYH6PECRYJLbS/ZwiQbQbFvAwWlkkk0IxZB8qIG+Eoor1j+ZFKyFWKQkck
 +8w9igoI9uUd1PZP2RcxET5SdiiODtkrFVnTUM4K2Y1wjsTj6gcOG7aqNQYH0Hi2VWy2
 CNWyVXizrXaWWxJPvK8hUmPEshrQ7TMlovebQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793640353; x=1794245153;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fIxnq9/aPptglcI3bm7dq+4+R93f97eZCKhHYXbyIBk=;
 b=MkQcWpqkuc5wmzwIKjSTWYODa8e4CvT+0oCRe0HNJMUxIQPwobz/lVKz0EVXUokfPj
 /TnheUK2Hd/9D9qJHWsw720BG/ifsBH34PxfsqRfAUfAoiV0fIVvyd8AsCXEORFuvu/2
 NDazwDbH1FlN5gAU4rG2JMfg6e6LdiJ5tHL/6fOkQPnEpQktj7QQfPStxz/Jr2Za96+i
 vlCkAlMxf4FhUuWd9ILPoxeSzuKBZXX8kDUH0NpNo1DHhC1yLn7yyBexkHCmHR9E83e/
 kVGqh5oNpbCvjz5CBLsGgCkEn5aupDB80h8nXbXzZsguUK4EWuJ9BvrQnR2tKk3R0OFL
 KUaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/pZaWMqySDnZNhZ90+c8N7xI7TBi4VPTuIwmlS3ZQSCS4WloPaVYXSGcNk0YdDFbQITbWc5c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJySxwQp3gNKsLPFD+D4EzUJOaQDq/tZDzwe5k+lCuSXf6UI4jP
 26YC8LcxnERlpMvjxrTRx0B8vyfY6huIyYu8YO2VkkbFTYk6ZmbcjvyUgm2YLnrwdMw=
X-Gm-Gg: AYBFou1T8/3GHi1ybujCqjVa1E5HlkaI04Oj/sIVq6+OOqCthHvti8sW9QFpzX5mPAV
 9Ohyeu44USDLPrIklunPBweNem6xs3+zYqOMbYm/iZTpz2UaxlGvIkEtuY2WAqaFoP+aTJc4LUK
 xdbNWxcQ/dtwXsvLL3Vt/LlLlqJycrKjx2w5IQz/dbDPMc5LEtSqTylfjkoBGOZmx6c3P6Aa9fp
 oZFcX7Mt+I4VoTGhyh2RLqMTKwJrS0+FLfRvnBJlu0dKCuYnWCTSOwsAFD7lxELo/6rF5Hc0tf5
 iU2lPvdTjX4mXZ7FACc7J1T7jvPBUw9psf4vrAmpKKH0y6WVfqfnjZhDgj0oPBgNyLxw6tdU5yN
 TEU5LQhdZ0tj1GUXRAhOOJktAh4MbAvBZYKouJ9hAqQQoiuuxAbWcvWy01ql1dlS9QvnZ5t/nJg
 kZJdBQ2jTm++eI27lVdbFdyIp0uyDQKkHs36G6NWZgH3juRXYV/6cJLgk6fFpVNH2SiT1+MstZC
 2q3JTSYGvBpd7QWyH6oGEwjELZkCk/qTwTdaMCIUqzCjO6Hwh0lKtUE/cZ2gwwX9xo6dyrWH7LO
 BZtvHvDBCEAk2pQ+2S0N13jYVDSqi3N7FC1Drv0nIUriCWyll9ZgsFRjE5+b1PgcNf9PBjgWq91
 5cDb7K65E/NOEfZOtEcHSEVncVHt3vQuEaRUNcAesNAJQxpUkuT4L9Xg/tGjD6L/s8+nYHcVyZR
 jdvAKNNM/yzjtGzVd3f9qer3zN0xllPQ==
X-Received: by 2002:a05:6830:2406:b0:845:8d86:9f7f with SMTP id
 46e09a7af769-85d364a9eb9mr8379507a34.8.1793640353454; 
 Mon, 02 Nov 2026 09:25:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d35499153sm9776390a34.9.2026.11.02.09.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:25:53 -0800 (PST)
Date: Mon, 2 Nov 2026 11:25:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v3 3/4] tools: qcom: mkmbn: Add support for ipq5210
Message-ID: <20261102172551.GF3309461@bill-the-cat>
References: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
 <20261102-ipq5210-v3-3-aacf3930848b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3xWie3Fb2Y6hPW9o"
Content-Disposition: inline
In-Reply-To: <20261102-ipq5210-v3-3-aacf3930848b@oss.qualcomm.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--3xWie3Fb2Y6hPW9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:22:28AM +0530, Varadarajan Narayanan wrote:

> - Add ipq5210 entry to the 'boards' table
> - Add an argument to specify the U-Boot Proper/SPL load address and
>   drop it from MbnData
> - ipq5210's boot rom expects the SPL image size to be 4-byte aligned.
>   Enable the mkmbn script to pad the image to 4K.
>=20
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
>  board/qualcomm/config.mk  |  2 +-
>  tools/qcom/mkmbn/mkmbn.py | 63 ++++++++++++++++++++++++++++-------------=
------
>  2 files changed, 38 insertions(+), 27 deletions(-)
>=20
> diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
> index 769e4a51ca0..dd61ffd98e8 100644
> --- a/board/qualcomm/config.mk
> +++ b/board/qualcomm/config.mk
> @@ -8,7 +8,7 @@
>  # Create Qualcomm signed elf images
>  CMD_MKMBN =3D $(srctree)/tools/qcom/mkmbn/mkmbn.py
>  quiet_cmd_mkmbn =3D MBN     $@
> -      cmd_mkmbn =3D $(CMD_MKMBN) $<
> +      cmd_mkmbn =3D $(CMD_MKMBN) -l $(CONFIG_TEXT_BASE) $<
[snip]
> +if args.load =3D=3D 0:
> +    error(
> +        "Cannot proceed without load address.\n"
> +        "Ensure CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE is set\n")
> +    exit(1)

The call is only using CONFIG_TEXT_BASE the help says
CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE and so if it could be
CONFIG_SPL_TEXT_BASE in the future, please just write this with
$(PHASE_) in config.mk.

--=20
Tom

--3xWie3Fb2Y6hPW9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujHngAKCRAr4qD1Cr/k
CtRMAQD8/UQV10Ito3vGXXhJsoxWMA2hvbQlGK6eloWMvuNfeAD/cz5CBVK2cYQp
Fuy2Dj9BfHz/bW0oGyB+Z5eiqcQq/AM=
=sKhV
-----END PGP SIGNATURE-----

--3xWie3Fb2Y6hPW9o--
