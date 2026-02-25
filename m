Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2011FD3776
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822F883E8E;
	Wed, 25 Feb 2026 18:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pe5Le2At";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA7D83EB3; Wed, 25 Feb 2026 18:13:02 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CFE983D77
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7d4bc9e48bbso2896545a34.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772039579; x=1772644379; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N4t0IGzZVpNd6c/CPydj/i/dIgRZfnsF7TF9Zq6KrLA=;
 b=pe5Le2AtJCgIbuEvNmzCUprGU+4oI8XTBuNO7pTKc3fyp01W+0XQ30Kqd4PCmfxgrD
 C3WeIicegyxkZP4QctSgXe27lFtF7DVzWciAMuq2ApcyeKLnp+pFQTNbqFSPNz7PNM0K
 7/DbNvwQi4/9JHoRBHt0Kh/SNQ5KsgSsUdxwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772039579; x=1772644379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4t0IGzZVpNd6c/CPydj/i/dIgRZfnsF7TF9Zq6KrLA=;
 b=a+4EsIZzO0NZHSLK73ZTfPr0bUE+XzdSPRp3UbbwOP6b2Kzxkjaygus1qFjezS8DdG
 DtJniLWkQegxe5MU6Ub43Yd2kGN2LRNTgw7vDzRRdDpfMTHqw7RQMJT5LeQtBpPNrrTC
 1bjbeI+ueCYkGsWdLIfxQEUYAzWCfujeSgev0ExzqNlncZOTpVv6UHul4IcnxMzwVUzG
 80Dvs+xywyXV2V8uWiwSI3HCMtHIBxMbbWWyj7hJ1i6fuNXFbg6E6PQS7rxuzl48Jbjg
 caEUO/rrQJo4RjV9GwNKZKcV/qBgZSEsmEdeVe05+yOh8ZAEQYURagkaVpFr/tQHs621
 6/bw==
X-Gm-Message-State: AOJu0YxrRPi0YJQjYZt1ZG14LigX1+pMfIhNTxaAIQV59y8/IQxmBuEY
 Ss91YWYwuUKS/OD/dZhZJVXOA1yxn6D8h/zNqf+CVhSbq0ZRiXr9Za/Q+XoPTbnrCIlyyHtY8Ih
 JZ5RVGLYyQA==
X-Gm-Gg: ATEYQzxDcihtV9c9gMvT32LbZUA2BPcAyzk7bV9EdI0JkSHxCVnwNQh+YprSzh0+4iU
 VAl4Az1aOqPdy509Yrjhve8aFDSWivDAfuS99yfqpT43YdBkIB5gxh0pQDm3v5zKwh1m59BOGxP
 U9SnB4vJ0lqzZnis3LTmA60LosGUFE8An1uCCuIbO24CbQqNVc9Fgm2cUZa3//M2ho/BeSprpqu
 Ol4h//bhh+la1VTQnNkk/5ke87W00MzXwGVwtlDoufnWoSmMeFDWJTqqBrbEhr78PQMweQlYO7V
 dhds7fh3nzij+ajJsly+bx/iNe3umecW9j+w0tR6CDJ/LC1huXVrQxltbQq7vXu/omnaOZk/Rt0
 7I1YFfAyZL3liRzpSvhIcYyHmaDdkPtDXn+qm46zhjd+UPGlb4CmXrXF629sGjGwKJmbvqdTjXO
 qgHrodxIn+cgRYoyVx3YGVEvR9h8E7EXVqVFOEZl0Za0yY05mLHq5EIMj8KHbBTBLOF330yoNO8
 WYPgU6qaZk7hEIQa1g8RKTP8Tg6xCfV15UMrnPcWtJhxxxEIwI=
X-Received: by 2002:a05:6830:2b2a:b0:7cf:ccc0:db0a with SMTP id
 46e09a7af769-7d582a8470emr612151a34.33.1772039578534; 
 Wed, 25 Feb 2026 09:12:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d038752sm14195356a34.17.2026.02.25.09.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:12:58 -0800 (PST)
Date: Wed, 25 Feb 2026 11:12:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 5/6] test: Add a helper class to create disk images
Message-ID: <20260225171256.GR1593142@bill-the-cat>
References: <20260225162357.3449937-1-sjg@chromium.org>
 <20260225162357.3449937-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3gj3FE3Ksv/oDMD7"
Content-Disposition: inline
In-Reply-To: <20260225162357.3449937-6-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--3gj3FE3Ksv/oDMD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 09:23:49AM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> Provide a way to create disk images which consist of multiple filesystem
> images.
>=20
> Provide an option to use the current directory for images, instead of
> persistent-data directory. This makes it easy for C tests to locate the
> image.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>=20
>  test/py/tests/fs_helper.py | 97 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)

It seems wrong to ignore the existing function to create disk images.

--=20
Tom

--3gj3FE3Ksv/oDMD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8tlwAKCRAr4qD1Cr/k
Ci4GAP47BBXzOJZm9IbiMPOH0JNVvQMxViCR8zJIvEpOUAr/oQD/QAEz9U1lmVgW
0PKiUqsxMxWhWtu/dIqi6Fq1SL7z0g8=
=UDAU
-----END PGP SIGNATURE-----

--3gj3FE3Ksv/oDMD7--
