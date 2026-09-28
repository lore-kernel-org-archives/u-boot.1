Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49557CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 21:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FECA4051D;
	Mon, 28 Sep 2026 21:28:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R5Yt6vhWWv8w; Mon, 28 Sep 2026 21:28:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 67D8440379
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790630916;
	b=N80GCiQajeOcP8OQgrlXPezdVYAPf/72p7lrv///SMUWeWSsNJOBjhxZRfUBqgO/PnSf
	 swfyqpAMh3iiNGHKIcJ9pKKJ81UNqsY9fI52VWcrYNsIxF8Pc7+/rFplKz6Sk7KtnjLuH
	 VijPPZyNFvDaCAwi/3rDsu8hf2LW2+BcsTIBBv6gyGDPZpat2eH6SD54TgXLpXkgZQRBD
	 o6Xu7pUiDAcaOPvGV86tREw6cnGvLTQv/B+P72kJMoPC6RtEKNeXjZs83apA5c5Ob//sF
	 pp4ithVEpBzYk3bgo/xpS7oJaBatfNfIDVfIqvj/s+PpYToiGPguqumbKpTY6s6UJqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790630916;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AwWEZOnTc7f6ExQKStvS0QaWm1qFmbQaZyT7/TDKWw0=;
	b=N78oeEB/C+9zRTMkEGm6p3y/gBRFj+Kp3DKnhfWecu6gTHz8J0ZtyzyRA7XQFctWNnmh
	 GLkTteNkaZMqffscG8CT8ozlznR9fBFLKOB1+bkDnI6IM6tAyLT9l3Nsz7wGmqJ/SIGop
	 AV6/5SqZjt1YlpRgdnLuE4iBji5ysBU60jOPFc4dnItsfsAjco2ToUiccR/hnX4Shl/x3
	 JaUwj9p8J6s/ZaHAIcQFaU8IEG5ks+T3Cpz2e4qwBTp/4o7Il6wN/YWCyLUbwXWsFzQcu
	 fU7K8FvDzOPXPR98tu9U/lu+ZoEckvMPJVnub8zVMG9XPgApjrf+O+hbWizqJ/zASfQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790630916;
	bh=AwWEZOnTc7f6ExQKStvS0QaWm1qFmbQaZyT7/TDKWw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DTJ3/DoNloU6LsL9AVGw77C+n2Fsh28pupnlW/vEKdpOggzST1EjflEDGS0DasoiN
	 69nbtbFJhrnmTX9b+3nlQHR4Xw2f3usoRCLSq3IGpABc33iD5e8h77JkIH9AKKtv8j
	 KpmRPi8YTVpIZ96TKOWTfg0zX0Wf244qhZFB82IKoBLsCrbMLCwPF5x+pUkaFrKeMa
	 FP2niuajTVQwgCZADsCtVsE+Dj6aM1qbvFbzWr7NA/agvYWk1RWN1RCyctsegx5vCe
	 VycTqNeMoT10Xkmnud0EAu03STKVoiQytFeHNfpB6WKB6srlAddzYuRmw6RfdFa1AA
	 BDSVMNSQRnOgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67D8440379;
	Mon, 28 Sep 2026 21:28:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E9B7372
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF6EB80A58
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70V0uLxOEjr1 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 21:28:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 297C480A49
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790630914;
 b=EJKXBYii8/5EiVKfiuTnnHZEP9xuutPYSCy+fzTpZ5ZLdfzU0Xw5ApovaNny3+5qyjip
 p5PDdp+edNpjF4sma1wifuBNtT/yJpx+YWsagjYt7C3bhD640IxIzArRA0e4CzHcNkDfl
 UHdQCCkaYyv5mqPX5ckt8dvc8YKxL8s1hMbNIm/2S81JycL1OqwnwU6QQTmgFOoubSJzW
 Y3xloWOvgsTaNTpYcqfvTQ0deunbuTaBdjRoUGkzVY2TJs2BrnwultesUG9XFOXg8cbmW
 4pd69aN+5dQdv0zWRf0EZJ0wjbWAo6rvpXXitufpw9ThC5zKOm9P0BGgaseEa+9aYEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790630914;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=AwWEZOnTc7f6ExQKStvS0QaWm1qFmbQaZyT7/TDKWw0=;
 b=ZorFp8EYvzWd9ZoMpKPq0kCWIv+LVkaIO0G43zBxSN8IrB7yNu1oBlEg/AQqwxdP5SgO
 Mfm+Cbo2Zm8U+Iunzg+5wIevcNy65qwJzfAC2HNDn00fK1YW7LLKRVUCP1v6K6BQ7u+p7
 EEq3vbT622uzUtEk6fgBWkH8oIPwl3jvOAaVVOei8QEbMOBbajH0Smscb70dmWeCZtM7i
 IWjn45sRLywRuS/w7DzmqNk4LDVTiBsO9ZSlhbf8cLecG3rdrgXVr/ZiPpppY4JCjByA0
 LMlucCN2rDnS8yE0S+J94KIowtT0Oq2Bvk9PDJtgZZxihPe7rsYNqJ+aL5kjbdBrF8g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XIi80JXr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XIi80JXr
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 297C480A49
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:28:33 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-81b485c8368so1180630a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790630912; x=1791235712;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AwWEZOnTc7f6ExQKStvS0QaWm1qFmbQaZyT7/TDKWw0=;
 b=XIi80JXrCkgdTcqpew2ICXT9efDRiwsZXg0R46rnR5xlZ03gTN3Zk0bxZedYw0TNg/
 /+fsZAa8GRnv9pO0sW9FJBVIs3F8+adtK8tmWVhX9eT7vZWywpHtFN09ldsClhrjxhv2
 o8P2nZZL3RI/s0DGTImdvbVnU51LOmbF4hrPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790630912; x=1791235712;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AwWEZOnTc7f6ExQKStvS0QaWm1qFmbQaZyT7/TDKWw0=;
 b=TgJLLW/56iWglyBAHxGGkY7UFN6lq3UnmUiT0MouGqLW9YM9VFNnyqdUjHCx8DpvXX
 TsM3FNrxtpEgHZJVfkn1l4q98XQj3zx2cr7nbHnBC9Qf2QGyBs6B+PVaqmJ2DGRXnzqx
 P1fMcSIZfVnOHq0xIgzMnzOW970JtrPm+8tsU+jQE0nRrPQf/MxgAT9ssb/n1jyYpKqj
 8KPXiS5EWbAszHwPqQ75wuoAhkA9BcQmOj6YNqZ7lIF27F+127SQRv2BuEAxFKErMgPw
 0a2P0oz1xgWr5lico4tNrgqkIqJ6nfgUgGrCMCTDk8pqHoyXXheOx+j8YK/h8RuiN+Ex
 N8qQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8dIkQy0NtIiIoBoJnOGUtscY2tp722m+GF9LmLo8kUXowrGEyk3Gk6zNZUBfE7JBTOC4ByB0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lcXcsf3r6Olzja1H+gDmjVXGralL84R4sDVBUvDMFB8isDpFcm
 +QUR6bGUtFdcFiqFJGaCgpgCyApUMURPgSzRcuYoRjI5GOiPpvhVsV/xUevfOoUjfX9VrP4YeaK
 Ncuwqajw+zvCN
X-Gm-Gg: AYBFou1HrrL+6ORAKZMA9Qt9H1QO53gUNs7Zs49Wvb6IPR1lzJ7SF6hKdVNCsoxbGVH
 N+p/WNUNZzXFYUeYglVDIw0X1BpVyS7qGgwHesL8wu7Tgt2n+VJUYSR19jM4HnvADPjKi5Xfnv/
 4N8Bu15BDVt5VJeVmLBdZLYqLuC6+wMfOBLz0pT5xd2WbA3st4/CQNqB7kAn3/DwQcmq2jlPTRF
 lyHnIZhgtDknOsKBSzHYZmpswpjZ7NpG0y7W80mOCS8a/wWLHh5Nn5ItTNSTboA/oEfhWPnznTy
 7XWrbrFUD1j5e7Y/HI1aonS3g4+mQaMuO+FLzwzjKniQx3ykjYiueghjKipdaoknRk7GjOZ402m
 N26v9omgrJpDtnX9J9u18J3p/Vjasxj2/7NpdjOEO3ZUMGnQcCqk1mb9vRyD6nuU7et2I0Rhrw5
 bZjE759hBgOxaskIYt/XPQ1Yhobu4zABiDUGeP2/6XHyXc24Fs/U5GDt78I6Yx8mHEmG4PYf4GA
 Rkx8zKsdG9J9/1LATqNEZH2ofWn6QLQVYDh5l/8ndcarc48G1JIK6YhbgebgJFweS5w6h3TB9y9
 aWVZV7it/3KFSm7gF8QsYCYizdoNug==
X-Received: by 2002:a05:6830:638b:b0:804:ca33:4aff with SMTP id
 46e09a7af769-817806940f9mr16130106a34.9.1790630912326; 
 Mon, 28 Sep 2026 14:28:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d58f177e1sm2683130a34.24.2026.09.28.14.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:28:31 -0700 (PDT)
Date: Mon, 28 Sep 2026 15:28:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, mkorpershoek@kernel.org, lukma@denx.de,
 marex@denx.de, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, vandhiadevan.karunamoorthy@oss.qualcomm.com,
 dario.binacchi@amarulasolutions.com, sjg@chromium.org,
 pbrobinson@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 6/8] doc: gpt: document 'attrs' key and
 gpt_partition_attrs var
Message-ID: <20260928212828.GU858934@bill-the-cat>
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
 <20260928064041.1432227-7-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gj0YlhhM9AGYS+DW"
Content-Disposition: inline
In-Reply-To: <20260928064041.1432227-7-sumit.dhami@oss.qualcomm.com>
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


--Gj0YlhhM9AGYS+DW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:10:39PM +0530, Sumit Singh Dhami wrote:

> Document the 'attrs=3D<VALUE>' key of the 'gpt write' partition list in
> doc/README.gpt and doc/usage/cmd/gpt.rst. Document the
> gpt_partition_attrs variable set by 'gpt setenv'. Update the example
> partition list and output to show 'attrs=3D' usage.
>=20
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>  doc/README.gpt        | 11 +++++++++++
>  doc/usage/cmd/gpt.rst | 11 ++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)

Documentation changes should go with the patch that does the feature
support.

--=20
Tom

--Gj0YlhhM9AGYS+DW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarrb+wAKCRAr4qD1Cr/k
CpqtAP9lYLJkkZkTUQqf647LQPI1s0lYF+Q0xNIpzm7UZFHjkQD+NNQ8uhSQ6IfY
GSeczn2RiQXBlzT0DNczbZO3L/9wqwc=
=PeEV
-----END PGP SIGNATURE-----

--Gj0YlhhM9AGYS+DW--
