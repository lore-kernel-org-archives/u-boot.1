Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA139EE57CD
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 23:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D31B86AD9;
	Sun, 10 Sep 2023 01:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="azktXyQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF78F846B8; Sun, 10 Sep 2023 01:20:29 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBCFE86AE8
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 01:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d7d50ba994eso2865586276.1
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694301625; x=1694906425; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MBZDpzGc0TPdAAKcFCp3qWGSaFDpsa9b0+osqb9Sxeg=;
 b=azktXyQxw1voWXTPnw3hfZbtRMv17gv0nqJ5xyhW/NkVbRnwiX2RnRvBT/Sg0E9Wx4
 Q+J0WpjDVZvdhl1K55w3HDGi/UzfjTEtjn2LzvKUM76PZ5Xd2ulPpdRCk8h4FyB6P/My
 L14YHc6sv45mRucSjsqmg78Dm0mwq16hRbAWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694301625; x=1694906425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBZDpzGc0TPdAAKcFCp3qWGSaFDpsa9b0+osqb9Sxeg=;
 b=p8SXs62F0R6/al9LEpVXwMNdS8W6L+p1zbxTvn42sKWY1AiwNU+Ikc025BGOIYtiPn
 1O7O/t1sZRLz2GvzoijrujBkzimQdxl+MRMpIc5WaT9/42YP+u8VDfRNAKVHDAIlGMKL
 I6w0bmGlVE2tpZnKE2kxAveY2Zel6YBtPvxtss90K+mGoEoZxw5U2z/eGCPgUjWCkC29
 Nm5yeVGu0ZXRvMCFQAxWq1kxqD7g1+48byTDfX88SRpxAkeYRQ7V3tRh/syCsnFAP6/h
 WvRVEWQJ0kvHeWswmdzKk6oQ1pA2r4oXST9EGBM5+i7bdgH27FFsYz05/QG6Ri2leosE
 E5EQ==
X-Gm-Message-State: AOJu0YzZWGoNSpqSIxbwddTa3gCp+iceHMBtch3A5nLVUDRnmtQc5YTt
 uIzrsJ8IfRBHyob1W/Jz50bRkg==
X-Google-Smtp-Source: AGHT+IEuzoV3UK+xvggxVzzF42cA23Dw4lJaqYmNXtbdqXZY3/Pk4pjfy511GqhD5cjhSn4IT9u3bg==
X-Received: by 2002:a25:ab08:0:b0:d4c:cbd2:f6f3 with SMTP id
 u8-20020a25ab08000000b00d4ccbd2f6f3mr6098132ybi.53.1694301625610; 
 Sat, 09 Sep 2023 16:20:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1687-83fa-3eda-ba26.res6.spectrum.com.
 [2603:6081:7b00:6400:1687:83fa:3eda:ba26])
 by smtp.gmail.com with ESMTPSA id
 d29-20020a25361d000000b00d746487d6f7sm1004461yba.35.2023.09.09.16.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 16:20:25 -0700 (PDT)
Date: Sat, 9 Sep 2023 19:20:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] CI: Add jsonschema python module
Message-ID: <20230909232023.GU305624@bill-the-cat>
References: <20230829143710.204875-1-andrejs.cainikovs@toradex.com>
 <20230829150422.GD3953269@bill-the-cat>
 <5219f4a0-b91b-16d0-33cb-4b7fea37625c@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UtkS+yA02huoitzk"
Content-Disposition: inline
In-Reply-To: <5219f4a0-b91b-16d0-33cb-4b7fea37625c@toradex.com>
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


--UtkS+yA02huoitzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 05:37:35PM +0200, Andrejs Cainikovs wrote:
> On 29/08/2023 17:04, Tom Rini wrote:
> > Interesting.  How exactly are you using these CI images? We have
> > tools/buildman/requirements.txt now to cover the newly-added modules in
> > CI, as we call pip on that.  But, it's not being used in the prepopulate
> > the pip cache stage in the Dockerfile.  And, I'm not immune to the idea
> > that we should instead be installing the distro package here.
>=20
> I see in Dockerfile test/py/requirements.txt and
> doc/sphinx/requirements.txt, but not tools/buildman/requirements.txt, so
> whatever is mentioned there is not part of the image on CI runners.
>=20
> Following is the part of *our own* .gitlab.yml file,
> which uses a public Docker image
> (docker.io/trini/u-boot-gitlab-ci-runner:jammy-20230624-20Jul2023, as of
> now):
>=20
> verdin-am62:
>   stage: build
>   script: |
>     ...
>     tools/buildman/buildman -o /tmp -P -E "verdin-am62" -M
>     ...
>=20
> And this is how it fails in our CI without this change:
>=20
> Building current source for 3 boards (3 threads, 14 jobs per thread)
>        arm:  +   verdin-am62_r5
> +binman: Unknown entry type 'ti-board-config' in node
> '/binman/board-cfg/ti-board-config' (expected etype/ti_board_config.py,
> error 'No module named 'jsonschema''
> +make[1]: *** [Makefile:1108: .binman_stamp] Error 1
> +make: *** [Makefile:177: sub-make] Error 2

Thinking on this more, yes, I think at least as it stands now we expect
pip / similar to be used by consumers of this container if needed for
the jsonschema module.

--=20
Tom

--UtkS+yA02huoitzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT8/bcACgkQFHw5/5Y0
tyz/hAv/WqZgqiKyrPO1UrnwxVYBw/W+VpkK/2rfm9TFVd7i9Vmr/S8bbsl8KbcE
PiN6eX8YlEylHXDh8F6PXsQPAodsFSp21QKdPd4x0guU+8egsIZSYL3tRfRNlZZS
UjOsDJvBkzulL8y+MdyHiSmZkvS+nIybFIbU9wdUrqQjTi3U8qxzyHlYAHsxLbrH
bEshHL1Y2i4dFlXXhjaA7hITt1DDetEzqzyJzcogu8U/77I6UUNqr3u3hZGBUvBI
mjMlOSxngtAl/d0r2llrr2HCwHyo0+c/qBtv0ipjiTs23WipewuC6wakhq7DcBAu
gzdEVrA/9yrE3GNTVrSkG4/yimRWC7/GRVnTkW+y/E1duG4tV7xKmrauzvjYBvqc
Sfwk+XjtBEYupXNOUG6nbjXlYugEBUGbhZNIPCkimiUOSfAosRtm1cf1vQ6UAoIn
x9zqWuusg/6N/5QJSTOFtIgBhtfPKO/Y3DdzSgbQJEDu1rlkNNsGCOvyagrKdCgM
QTUwPfQH
=jKCg
-----END PGP SIGNATURE-----

--UtkS+yA02huoitzk--
