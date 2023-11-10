Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39DEC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 16:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89FBB87832;
	Fri, 10 Nov 2023 17:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UEGBP7dn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5727186EDF; Fri, 10 Nov 2023 17:21:21 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1752B86EDF
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 17:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-778ac9c898dso135179885a.0
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699633278; x=1700238078; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lEo6c6Ka0YGXCKnn520qJBdbNDvAQxrqX9XcwcrmPJw=;
 b=UEGBP7dn9IfJwxLghqGe6IW6wmhLp+cnSpHA7lVjWPlYA6jA3NiZxs8zBWH0ArELgJ
 gW2PadzYtGglCOohVbHYyEbJUjldTeLMeJKseCVj6ii7DgQ1diKwiiwHSUfJzQslQlIf
 aAt/kXbiU+1zIC9BKPb/Nu3Gn9bsHmO7Axqbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633278; x=1700238078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lEo6c6Ka0YGXCKnn520qJBdbNDvAQxrqX9XcwcrmPJw=;
 b=hQeu550QO3pc34ibkMU1rKW2h0HXvxTw0Z3/ykYhMOh1/9L1AXXlfy1PJoARUknFmS
 99bQNQtolOhMN8RQ+0C+JkkbGsTuP5NXq3SvZVvRo6k8dXi9SL4uVVvuPSml+KdRDSvC
 7gmbZpM8yk7Hx/6Obr/eWaEtrncZEpZ/AyCuwp+2LENMNf6DVb++kjMVK8c30ite5PGK
 X6Jchn0zYBiBoAP4k6OmZk+J+W3JcPI8aOt+brAxKlmYh12P0JHO2EmQfzkO5qkesioo
 S+jqNVVO1JpTR75YyhCL/kGbtxat8t9x9Li1aS/6zwF/1GMp9CYCWVlxEZOk8RgbJz+0
 CM9g==
X-Gm-Message-State: AOJu0YyH5rENXjVBvtrrK64EV1nOv+a85Okz9cUDUnJ/FQIHTlcWXVuh
 Op3d8wr2Z7faBCwfOgsxXgWTq1RGSS/pxsutLZSk6A==
X-Google-Smtp-Source: AGHT+IGBQiaBr+YGqzLDzQGMkwlahqP63kh9AluTXqiD9XspjnPVAFtqFLyiuQV+QR1xMwhe/xMa5g==
X-Received: by 2002:ae9:e515:0:b0:777:fec:5741 with SMTP id
 w21-20020ae9e515000000b007770fec5741mr7852946qkf.33.1699633277749; 
 Fri, 10 Nov 2023 08:21:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05620a091100b0077731466526sm784439qkv.70.2023.11.10.08.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:21:17 -0800 (PST)
Date: Fri, 10 Nov 2023 11:21:15 -0500
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] firmware: scmi: correct a validity check against power
 domain id
Message-ID: <20231110162115.GT6601@bill-the-cat>
References: <20231107000547.182072-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8Any4IMvyfdYo1k3"
Content-Disposition: inline
In-Reply-To: <20231107000547.182072-1-takahiro.akashi@linaro.org>
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


--8Any4IMvyfdYo1k3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 09:05:47AM +0900, AKASHI Takahiro wrote:

> A power domain id on sandbox should be in the range from zero to
> ARRAY_SIZE(scmi_pwdom) - 1. Correct the validity check logic.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Fixes: CID 467401
> Fixes: CID 467405

Applied to u-boot/master, thanks!

--=20
Tom

--8Any4IMvyfdYo1k3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOWHsACgkQFHw5/5Y0
tyxEnAv9H4hiWeGrfnThWATlJuae4nwismiNo3UBkxLZXdLXAAko8hqPoIRTN8LC
NYlROqx4lL3P9j6SOHYjMZUph197QeT8WYk89RL7mcyczNlhTJsE2trmuoSl+mbB
gYBHdeikqkq1vZK8byEcn+RPO4uCE6vvnrIySU0PMGevf7ThuxKtFJqPe+HvLBbX
VreXdb1LokynNXVPPyJ2eNx4wmRMUxTYYTZ90QS1784yP69ILUqGugTnhcZ2E3NR
gPun6o+0RuUAEd+7dkVNkqxeAb+0fmzSKlZeX5REpTPSMrb7gNLA3LihTM1Tjc4h
WHNCMNBtvlfpJGzRM98nsqO1z+JCRuOA+01ICeO7uZGu5wINwX627UOWx5/p6Iop
uOvclJ+Ze3phVVUD2S5BTWCvSiKjjefZMeen/RgcKgD5qzhB79vEc7WCAK7kgE09
1J+T3STDp3vS0NZhunlDT7vSd/VEMDMmYfuGg6dOpVmklM1FnV36OmsZmKYamMX4
aVnfvESW
=Zi2M
-----END PGP SIGNATURE-----

--8Any4IMvyfdYo1k3--
