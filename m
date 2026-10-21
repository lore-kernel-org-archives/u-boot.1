Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B2606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KG1YjTWB;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=nPsLWoeY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E13CA80F51;
	Wed, 21 Oct 2026 17:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ihq6uJuD5i9d; Wed, 21 Oct 2026 17:53:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C6F080E51
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792605185;
	b=nHixEoIgtEViXlko0sBOmwBc0UTO+brRzxWj/Q/7jS2TSphyuxaCUUmB6K68E0krHk/T
	 7JUSDtcivRQw4ZJP2GgIwsXY9Y5N6n9y/cPjlj5DWlNxKQDpuFxgrBBz/Ge0yu4uFtXtd
	 lgzsgN4jnyH+aVxCAbpLkh6M3NadIJ7/mJPnDHSa+SoIOfJUDiONiw1wKL6gOkdNd2XKD
	 Kn6QS9DB0EC220SNaHbJ7FiOk6fAYVcmEXOdKNlC4uTG7YauIRMBWnE8zMZ6WTCAzcr53
	 RRmWXvnb/6lGu923Z00uKgYsxGPxTq+zpguwV0P3KTR01R8w3QO/+ZaFfKhcl0vBPtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792605185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/5rc/fEF8ShaGkpFCNO5JP5FkyAgngqTDs6kbdjeGEU=;
	b=YTeg/y3Ry7Z+gxNojPfRWyaH6k1lHZDKEe6QLwUFwI+d3RULeJSpXXTtFOl/DCQsr2qe
	 MxqlfHqed+bwdHURfzjlvvIaMF9Fi8geNOWJ5WQ1UL8YUhhWgK9TFZzqRjq7oF1LdXzlj
	 8JIdIZQfKSSPl0bZGBUrLJ8Ccxd3o3CdMNYnttx6aGZxuShunpURN8tORBzvNv9ZwxivD
	 3BXM5+5Hb0faBafpvQiDK479lhKdojiXqJmu2/hAzw6ZT3KibF/K7nusELZ8Akr6XBBDk
	 pAyh81jTx3XaItOWZgsAZfZZbFli4ACokCm16hyDs+kEQtsGp8Tr/pX9P4Z81P5UnWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792605185;
	bh=/5rc/fEF8ShaGkpFCNO5JP5FkyAgngqTDs6kbdjeGEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KG1YjTWBpDE8oOoVf9xiT9HwckS+BosnqxgJpV0dkOF/Kc3mUIlGewif0WxCjTh68
	 T81UApB1u7bw9IFajcqvztTWVPW8nhZu/cZNYn0rP0Pozgncy0HgO++ZwnVjpHnQmq
	 RtPgBmgvFI8FbZpfm/WyJOeF1Z5yie2pO9hBK+zRJ0mPDCJiSRiGRIDz3BTTUkF2G6
	 tXbKZOdTBJqBoCuVkeruxamtm1lzzjfVWviYllC8GJWvA/zT/hyFyiC25pPeltyT0n
	 4/KEIfQmq/kjQCAT8qm1p70V2ovT4a6oeY1/yWtsOUuEgK0WLrNEjkaUk3F0dLULGu
	 IRSsCEt3/74/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C6F080E51;
	Wed, 21 Oct 2026 17:53:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8E65356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEB954039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:53:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZdFutikjQuja for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 17:53:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 688AB4016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792605182;
 b=W/xS3VqN/Hd01KYqmf+Aii/wPYX6SvTGSKZFrdGqYY1CyYkg5s0g8zkfra+zESBCiKWk
 LkhtBbHzD4Xl7b2fsuEr90jXsA+6R1I49If/4qiXNUuuVLONAwKP9D9afgnr+c/AapGuF
 6iMyWFixfLlyc5FlWWvLfNAvvZv8z/A/4nEkyFcyAp+U3bIwbO153d+1v6rogiZOcRq6k
 GJpkQWxwTaVr69nuvQ4Le7h7X5UMgAymQFqiiDXz2bda17ONv7qXuo+Ysjso623k/NXDd
 JPkn+L0RU/4PPd2dCun/F5Oxln9Esy41+FPfWcvYiY42llZqYBPn5KT8HIZugTpejhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792605182;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=/5rc/fEF8ShaGkpFCNO5JP5FkyAgngqTDs6kbdjeGEU=;
 b=U2HVDH32othERMwsAhGICh4VUmAzL1Z6qs8fPUqbhcvMitKek4E0yLd6gcjGYYO6U+eC
 WOhywLZKGMfJZzme3llH3n5zroi8pkpblPD3ebRHO//JeXuSivr79atgTDg4f2ZSQNzJx
 cCivsTBWHScoB5DHN3dRvbRsKOuFh9Xb14Vum38ctdYdpiOfKxtzE6wEY+UuVHnafl9uW
 X3tjVavQlg8XiSKbwZ8TJFtrIsiWbGVJxN49++r7TQNag5jtDtHofFLHS5uZkmW+oxZ1f
 tiZT/07/V/t7jNqrpjDarGKz/6H6wyZI5fDF1jtun4/gOBxW++buc2BWgOhju5CBKSg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nPsLWoeY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nPsLWoeY
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 688AB4016D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 17:53:01 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4a451915d8aso660564b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792605181; x=1793209981;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/5rc/fEF8ShaGkpFCNO5JP5FkyAgngqTDs6kbdjeGEU=;
 b=nPsLWoeYqMzVO3dQ1WObrfMFnLCQpsLKVueVWVbbfl+fG3Qu3cUbUvGT1hS9zQKvN0
 7M/7jKc2U3LYfjn1WaYlri0+cLL/TzV7GO8QIysg2FM727LCNC+CY9qN+5uIoDgx2zTn
 nUISeT2TXKXUMNPQszUODI7cufzTly+H8vmR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792605181; x=1793209981;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/5rc/fEF8ShaGkpFCNO5JP5FkyAgngqTDs6kbdjeGEU=;
 b=R3sXP32lyntT3LJvdpbjMEbGYOWSEXfcSCsgD/xIT+egafU6r6YgyEYkT0PmmyiM4Y
 /s2Yl5eT+nBgOu/mf2WArEATciGHRAE/0d59OVoahS1Z1h8tLr0EsOjgs6yOLBucOY7I
 5JxhJPHjh3KsGEk6krzTa/jhq0np7lyRaUYVQFA4SfR5TJvskjmyCbHEoxYC4JXd9X11
 Eg2PsuHn1T8AYsodJG5w/CiB6N8YRpTj4HYpUbpT52GGh6JCqQytBJPPR6tBUTX2BspG
 udLNdJLXMCmVa4tbBJ7q+8tqS+bIL8OffTO7d3vxrd7fQKFX91YQqEtJSFFc77LMQjXI
 6tww==
X-Gm-Message-State: AFq9FYLDSDx6Sx76pzSMArsGeX3nuDJzOQ3zc2Up+NqmvD95hQG2YCn4
 uLaYtKBxRBlmtbZifso8KkQg/nk2FqLc8UYjjYSlFIPlC2XS1nS449OIiJmuWHqf/3Y=
X-Gm-Gg: AYBFou1dxgCVorEP8VjbObJYjhgeFfyzU/QiztwOmTJ7szUjaTM3tpHJpUoaDBfa0u/
 smyeLkpvUo41zD4EpYadrwFAvui3sHZA84eV3TR7XgCq+YFJHU86MNAX96KRjRDLoAkZhjAd/mB
 LkynlOMyWa7vlAQpLe9cfNRLwLjRtb6+1uICVy/zv+QMhg2iQF0F78duEUnThTt/83nmv34kNdE
 J0MFFRgTRi+06jLU8vrpKWheL9rqj5DHc33lMeQZwK63Ka5zKDZ87WWtg12Cizcryp1ci8JLvKx
 5sAHaftGcNfi6b4F9PRlt11xWu5KqhAdaa1WCC8a94m4fH/1w4Rw5r5rQGhdwf363pUFfKbhdb2
 Jg+lnbYVVVKThvwrv9YxsyrBszgJ7+c8AfUq3GdpoShKVQyrRnKhdIO4nnS1v+bezyMMAP/q6jY
 PNMLuXAIRr2IKEaYWAfVFtJQ3DLJHW9jwUvmbDfkpVaqmlA+j0vCrTuIpzCZK/0C6eMLyQ+Lkos
 Ym/OpK0Sb9bvEVngWl7aCzZXK/pdE0T2NV4RJIh2DvVryK7h0RRUcbjTngb0bltp7cYpdl7y2Dx
 apNixb9wqTV5hPd7SeyDHjmWG4F9/WsKEpBDrYNXP0Eluw/5Ay7b6wUOmyTI4RcUQJCuSObwjLN
 85cGaoVQEPG4CxNg4aPkT6A==
X-Received: by 2002:a05:6808:3023:b0:4f3:e931:9f27 with SMTP id
 5614622812f47-5535af1c190mr1619473b6e.53.1792605179608; 
 Wed, 21 Oct 2026 10:52:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-552b7176907sm2504134b6e.12.2026.10.21.10.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:52:58 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:52:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
Subject: Re: [PATCH v9 8/8] doc: qualcomm: Add snagboot mode documentation
Message-ID: <20261021175256.GF3275858@bill-the-cat>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-8-18ce3e431320@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fl6wcAunt70P/+nd"
Content-Disposition: inline
In-Reply-To: <20261021-snagboot-v9-8-18ce3e431320@oss.qualcomm.com>
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


--fl6wcAunt70P/+nd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:48:27PM +0530, Balaji Selvanathan wrote:

> Document how to build and sign U-Boot for snagboot mode on Qualcomm
> platforms, using Lemans-EVK as the example, and how to add a snagboot
> defconfig for another board using the qcom-snagboot.config fragment.
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
[snip]
> diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboo=
t.rst
> new file mode 100644
> index 00000000000..716d88b2ba2
> --- /dev/null
> +++ b/doc/board/qualcomm/snagboot.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Snagboot Mode for Qualcomm Platforms
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The second line is too long, which means you didn't run this through CI
or build docs with warnings-as-errors, as CI does.

--=20
Tom

--fl6wcAunt70P/+nd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatj79wAKCRAr4qD1Cr/k
Ch48AQCNKyXdX7pke2J4PpEOT5HCvARr25TXuYRg/cbnrGYbiwD/X4pGpxnNMHEW
XFzznPGAL+qEBK9mfXtVyGRk6YuCxQY=
=/TiQ
-----END PGP SIGNATURE-----

--fl6wcAunt70P/+nd--
