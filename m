Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F80C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 15:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F972886D9;
	Fri, 19 Apr 2024 17:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IiB9t/Jx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE545886F3; Fri, 19 Apr 2024 17:56:16 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B60C886C1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a554afec54eso228967866b.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713542174; x=1714146974; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5IcliDXMun906uxVz00JJ6iBPfvBoa70SciDMlld6C8=;
 b=IiB9t/JxojO5CXzAPWFDC5+TBXxOIAXI692m/j942n2I+6OV2S6ukUK21RgXH9LIZ/
 zYpg5uT+p2rmNfUZAthSIn/+wSxa2j3mcANiZ7paSAtBtR9OhUvtXkVD6Fnozq8gv5tA
 daw63fXU/5PTiBVAzEB0JKtVXTeFlFiHJYclDlTWjq+OEJ/IpQszXZ/HFDE2Dwu5edtR
 4d0ZN1qM40cN9E0L1R72lYwixyS1IpqHj5O2+NKBIq+Yee/25xoOI42xsoGd9WQEFFAC
 BzPU/q81rtxa35AcOcSJ+sySlc71w4VGZ4FE9mOYwBU2F+WvHf57rb0d6lq065x1yemQ
 P94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542174; x=1714146974;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5IcliDXMun906uxVz00JJ6iBPfvBoa70SciDMlld6C8=;
 b=s17GiEIJZJ/nDaj4IHgrcfnS29YIWUPzgf4i++ps2NzROjHLwd+hC0rnUjuz/WCV6Y
 A/SAO6HnjBpOQPIb5LLRFnJJpzNsHHZUhfX3Gd7JexJr9KnG7LDWu+cuD5nAFg49g+04
 Pn38VLZr+XFB8t8FjAXdEJTuNY5QapN5rNo9OyHVzDFQmB7kxsSxDojzEN7BWeDtRJ37
 I14ERBc8OmUmH63eThwgYF0CzDAy9IVl/WhSSr4VzDFBmnYIMykGyaV5rBB2V8bnv63K
 O1jVfRhmY3P6/Lo/tcEZnhUUCPatxw6/QJBnDWRVcT7bX2Wd2uqaaWj/b0uza2LQwf3s
 orNA==
X-Gm-Message-State: AOJu0Ywi70xJs22LczlWL6JUNeS+4DYLbbohSbfsBwKtOxtH2vMK9Iml
 beyjqFytiRO67g6KohjmxSpvwsFh66ZGDEw5Fisi1e+YIuIRGAXT
X-Google-Smtp-Source: AGHT+IFeDVEdcPQWKMmH9z5L+qgeiNTe/NOEt30BK6EGD8l3I56OCoe1uGyizODDMsJPvAZS8bi+TQ==
X-Received: by 2002:a17:906:5f89:b0:a55:5ba6:ace9 with SMTP id
 a9-20020a1709065f8900b00a555ba6ace9mr1695035eju.9.1713542174142; 
 Fri, 19 Apr 2024 08:56:14 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a1709066d4a00b00a52567ca1b6sm2360346ejt.94.2024.04.19.08.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 08:56:13 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=1e73297c6b31b8f0381d2ce7d7ea77880b457bbc60e357257256ae982106;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 17:56:13 +0200
Message-Id: <D0O8071ECQTT.86194R293SEC@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 03/18] video: tegra20: consolidate DC header
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-4-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-4-clamor95@gmail.com>
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

--1e73297c6b31b8f0381d2ce7d7ea77880b457bbc60e357257256ae982106
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> Consolidate HD headers and place the result into video/tegra20

Was this supposed to be "DC" headers like in the subject?

Other than that this makes sense, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--1e73297c6b31b8f0381d2ce7d7ea77880b457bbc60e357257256ae982106
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYilB0ACgkQ3SOs138+
s6FYXQ//f1CZOJRSpVHMBu9PmtX1aLwkizE71tL6vjaMxYKxX9oQUZL+yOfg8Irn
DkCHL0+O35W0UMr4qGHh4u3pkyBsAYQQOc/4MOuqTDAPACGRsn1Sp4cIcDENY+AZ
3Zga1tNmU3qiyx+DH4N7PdjC5daCgldRFkx9ucqd+Lj9+WrZziwm9/Zw/hh7ZQKa
906hWMvozIcdCFb667wGgW4scf93yfyz+ywpPPEzhp3dKO96BpCcrsNkEfmgjrMa
xhM760Z85QfWUhIONXxnr5Rw5KSh8O5b8I87cjINXteikNqwsTbuLhcaLWC/Wenu
c3zZlook59Ha8RdaJsr5CoQg7ln4b3FbbUOduk3Rk6mk1SJIC2Dpw63FURphZA8C
oiZmT2wuOsg4xIikfv1oA7iFXiPv1fcqVDSiqevS2UgHfbbFJZ/UBcaQYU9rDR5T
CUPDbDlA+P7GepXae6uaf1xhHdm4L8/8CUugBPnATf1RUvA7qbpczCh3wI2m5B0G
DMt25aZbPu3AKUGoKuxrDkMv87uX2T3CDAvGjbDr8Ml0k1suVD/c9yp4bdotWg0W
z6HqKiKeJk8KCslLXNEyKqMUOoHLLTKAVhjSDEZGzHxyWw4viLM28cuAKLBeNghJ
lBY+pnnB8DRgNiBxNAT2Wbi6anj2hr6C9uyrR8XTs15pir/FIpg=
=61JY
-----END PGP SIGNATURE-----

--1e73297c6b31b8f0381d2ce7d7ea77880b457bbc60e357257256ae982106--
