Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B62C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 19:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E8C82A8B;
	Fri, 16 May 2025 21:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A1YVaBTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D257C82AE2; Fri, 16 May 2025 21:11:52 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4ED28059D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 21:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c09f8369cso1204955a34.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747422709; x=1748027509; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C5SJyc4FX63RLb+k4xjdw2WcPZjKKG5wqRCC71DSGAo=;
 b=A1YVaBTxFixHhjSTGHg5otCif6gxtUU2LC5uX5QulGb+5u9jS9y6egrbxUYOXY7+0+
 99lxP62utzOgEW+lAPfyQoOELacKbnMwn/noQvr9GQTfXs5UQbVMb5avMCJwiBYgSOqi
 gwMJCMSqWsxi0TSYwtfW7K7R9V0UjGuLG4zxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747422709; x=1748027509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5SJyc4FX63RLb+k4xjdw2WcPZjKKG5wqRCC71DSGAo=;
 b=PrdUsh+fdCIIYXASrA2GpT5NYWPStv/p9UXIc0LLv5Psb8e4g5IjNKaf3Sawr3CbXl
 dElSFA7c58gcZepxA8bknQA53dQOocOXpJ60ycR4SlYzOhBacZKJZ3zuE0QdeiceWw4k
 os/ohlvjG4aIZl27qtCg3KFGEGF+m4Wij8/YyhBRkceIdzilJ6qVnolLMkn8h2bQhxwH
 38fzSp3lnKqEt8BfVEO/d3Asr4Ahpq7uxD/NAD+yyMZ77xz+BdBUbuTn4rJ2qnhuy6p2
 K0tMn1xBctU5jYc1nIKIa6n6nI+eNm89454LZx+Tk+682SPIxCK7yctnrwkxYLGX6Omv
 wNVg==
X-Gm-Message-State: AOJu0Yx/BntxJzko0yVEnMQ6BmZ7a9N/hAIJr0MV2nnSACDYezGDV63O
 NkItgxWhbj5LG3KXVK1Ts9bW/p1+mEeA8EbErsRaREoQ+Cn9g/xK5Gp+v/lfR9/jqxicWCON8fa
 znVXB8Fs=
X-Gm-Gg: ASbGncs8XjazYSdocBUiBuK6AOewxg0dyog1Vj26Fakq4HfKJROQ1auWHvN7P0wQ5JE
 K6pg3y+ldpyxKBYESyqcfhx8lI2Sycuqxs15Plop5KEjbFBs4xvJoOVHEG8lcalypOH5v8Iov9r
 FskpUe4TBEMR6ikfxMnuNYwUltXsamho0aw1X5YwqrMJU2HhHdct6KIag9suC2ybh4TDVpQximv
 pQ2luaRcXjcSlEnIur97pJJuCgzulGrND9p3Rak7fOImB1wGVEPUF4EjhnIFA5fJGURwi0PwB5w
 NDmzyta/h6+esbO3ZWSVp+pjy5lD0o0eYkMiEJ89/lgyeq2+JhUiD3g+q2XsI4vDaoBgu1gl7M9
 JvvLw4hZeOXUP
X-Google-Smtp-Source: AGHT+IE0q8qEpoU7aoLR9ZhHkD7MhiXiHSn/kyMA8gcfIG5zPov8Q3iFufACIobwdNhuE8h0WpjcxQ==
X-Received: by 2002:a05:6830:3506:b0:72b:8ec3:9297 with SMTP id
 46e09a7af769-734f6b6e2ffmr3635946a34.21.1747422709391; 
 Fri, 16 May 2025 12:11:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a7f762sm460722a34.19.2025.05.16.12.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 12:11:48 -0700 (PDT)
Date: Fri, 16 May 2025 13:11:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: usb: host: fix prevent memory leak in interrupt
 message submission
Message-ID: <20250516191146.GM100073@bill-the-cat>
References: <20250516175434.124221-1-ant.v.moryakov@gmail.com>
 <20250516183153.GL100073@bill-the-cat>
 <CAHb2+K4rHfzLTg8ikQAZ1WowDWb8PHz3TO5NnSm2phSy4T10Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xj1gj8BoV4SXVvY1"
Content-Disposition: inline
In-Reply-To: <CAHb2+K4rHfzLTg8ikQAZ1WowDWb8PHz3TO5NnSm2phSy4T10Gg@mail.gmail.com>
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


--Xj1gj8BoV4SXVvY1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 09:57:11PM +0300, Anton Moryakov wrote:

> Thanks Tom =E2=80=94 you're right, that `goto` after `return` is unreacha=
ble. I'll
> fix that and resend with the corrected flow.

OK. Please make sure that for all of the patches you're posting, you're
not adding warnings. You can enable CONFIG_WERROR to make the easier.

--=20
Tom

--Xj1gj8BoV4SXVvY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgnje4ACgkQFHw5/5Y0
tyzM3QwAqS9gpbNixSwpW/zy3jQwD5jwPbHr0AS7nhS59Pm8lqfbhN9CoB6PNubL
p9V+RT+O1CU7RY0n8XgjNppAWARphYVxLJzoi4gw+nfzmgyYay3xQy5flbP245ZQ
G/y7efDYukjMz4coCP7C+b3N5lfILa676t//h2+SnX4OI67uQKEN4R5unDK0HxEF
d12xTNeApjvjAVtQdBVNUl5qGJmPn6n/lsgu0aQmgIXJqxitFjVzpxVDoYEp36X4
6LOum/DbPy5TZvfsBxHptfVCjyzNhll7z7S/VRkBSNZFo6T6nNc89DaH268SxWDk
vqq+nwMR4ZM6gaXg7OdwVTwZZkWpy2ba+RhUoVm6Uu9g85XJoJEicTp6apRFFm6z
Kx1FcHP1vPoojuaDl2EzNZjLHuCyrY8eJAseyTIv5uSl66w2HBXOncS9M8p8cto1
OFHQDGsYLqhffQ+NiiLyxPavp6N3JCZssItsfRp0TS65qFXCuYJkxwXq7r9c5j+A
GRuWfleq
=opr/
-----END PGP SIGNATURE-----

--Xj1gj8BoV4SXVvY1--
