Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E390C3A59D
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 00:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C477087F77;
	Sat,  6 Apr 2024 02:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PavOJR9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B89288119; Sat,  6 Apr 2024 02:46:37 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0500287F6F
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 02:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6151d79db7bso31822507b3.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 17:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712364394; x=1712969194; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VNzUBvCNeq+VjGKHmFzBb4lpsWZUSP5yVZYbHxjJWMw=;
 b=PavOJR9nGCWvCZGNEPWM2GIp3q1VoPr+xFM2L4dorfcNB7om6gRJnCjPmZ/TtIQ4G9
 zQS90W2cKXG+ABD/QHntCt4UYjOrCMykL0Qwkrf+vZTjg9zVMZtAeLanUORPDTpPHOSW
 SzUSxZJPe5fq55LfXhXG5JfwSWGWx6N0PxCks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712364394; x=1712969194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNzUBvCNeq+VjGKHmFzBb4lpsWZUSP5yVZYbHxjJWMw=;
 b=NRDrjCCCEoGpd5j85SHRRyiaM/FPPVIquTHFA8td2O8Ei/xSfRz4lvyQtyLNsotHLk
 fgzClhjl2plGbO0qw9BJUWvoiFUil8KSd0rKjF5aNXch3EP8u/ykv5US3Lyn+8+9n7ef
 /RiqcO17JcqTTtYZsBUQPDc6mNpPaK7exBhXk7OUV2Wy8fHl7c8L/hna5780DXyL4CgD
 VHX2L/clem/miuS8FEgOgzsQuGH2FXEpLM4DfMPSILlYXz1wzeLzvdfVfx7djaZ88SK0
 EsMP/M1Dfo4SWun/k9bX2yNK1cPKdbXGUW9uUk3itZdMH8I+7nKeB9ohws9kgo52zSQZ
 WfDA==
X-Gm-Message-State: AOJu0YxXJUaFT8MIcgB0CrYVOafIpx9zACHg1J608bycqIzYLEwrjfSy
 2bMye6P63GwTQh5f0NJKQanL2i2LjBy4WVoLnb0ymZ3ZtVNY3vl0vho2DST8jNY=
X-Google-Smtp-Source: AGHT+IFIL8W2JRtVy+NqhBKGBARVYA2nSnOqUs6XyU3IOEVS2MtBkXrXThm6o+ODMpF9ZHr+oXcEoA==
X-Received: by 2002:a81:df11:0:b0:615:1d51:6188 with SMTP id
 c17-20020a81df11000000b006151d516188mr2915666ywn.26.1712364393825; 
 Fri, 05 Apr 2024 17:46:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 jd6-20020a05622a718600b00432ba01f939sm1264259qtb.88.2024.04.05.17.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 17:46:33 -0700 (PDT)
Date: Fri, 5 Apr 2024 20:46:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240405
Message-ID: <20240406004601.GE114971@bill-the-cat>
References: <20240405164605.920442-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K2ECv2IGZ0ygLD9Z"
Content-Disposition: inline
In-Reply-To: <20240405164605.920442-1-festevam@gmail.com>
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


--K2ECv2IGZ0ygLD9Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 01:46:05PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull this material for from u-boot-imx/master, thanks.
>=20
> The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea=
1a:
>=20
>   Merge tag 'u-boot-dfu-next-20240402' of https://source.denx.de/u-boot/c=
ustodians/u-boot-dfu (2024-04-02 22:37:23 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240405
>=20
> for you to fetch changes up to f6be41c83c17c09dddfb1e29a7ca391b5190634d:
>=20
>   arm: imx: fix signature_block_hdr struct fields order (2024-04-05 09:39=
:18 -0300)
>=20
> u-boot-imx-master-20240405

Applied to u-boot/master, thanks!

--=20
Tom

--K2ECv2IGZ0ygLD9Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYQm0kACgkQFHw5/5Y0
tyxe3gv/Rv0iPBkeukWQgPmN9nVHL8E9UeLODvDeSLCVyJKA2NOaPI8L7R2Letb4
0s5n/zBD7AkGaKBHY0/hcES+VMyBVwGL3i9vxVScMY0hTg2ZhI9iUQ9VDumggFud
EV14yGkHBrGvRDm6DaEL8c8ciTkanM8HW9yQUjA+GKuwOTFoseQTft6sbJAn3ELm
SJ87BWPEmejCV4f8p48zEvaEJ6Zl3Y9UK48/hA0ZjFXiDo93Y/NSf9y0STCm6Mzn
PhpdQxWpNTF2CKjmsUjflzWbgvILYH42Q8L/pW2yT3pIbPe+VweFYggHbPexc4Ii
UlhO6MOiLA532OC/dGDD30jqW9bae/1+WlcELl31kZgzYmsOQoKUsSManrGcnflN
fBRtD9R7qiSZZfzuiXPHkSkQSFnMlPWBqE3bVly+1oEBkLMJYheREIxEu8seQqEs
5/z17VP0cZvDyzXYZSWrVhc2V9rLIgfRon5gUKZDvwo5lcEsnMP+zqjq+sBlPktS
zD8JbH9P
=GLj+
-----END PGP SIGNATURE-----

--K2ECv2IGZ0ygLD9Z--
