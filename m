Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41375ECE587
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 19:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC98D88D00;
	Mon,  9 Sep 2024 21:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pr1r6c6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3784188AA4; Mon,  9 Sep 2024 21:45:38 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC41088E29
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 21:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a9ae0e116cso133726485a.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725911134; x=1726515934; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XJQUl+JzLtsHhGK8zJHP7v8QUTSZBBzk0QhBS9sJDlY=;
 b=pr1r6c6GNCzeKuMAGUpxn/O256TIiUkYUjqhGedOHqQ7n+d4PwBSRPCXkGA+wnKx2A
 ykxsfIbtFyLIBva5LPuWARcz+ImVmH2DdR9foJZZA92yWYT2xJau3BGimzOanBjLUZi6
 8N8lA3O/ntQq2TuhB7sSm45Ic1ChYgzheWk4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725911134; x=1726515934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJQUl+JzLtsHhGK8zJHP7v8QUTSZBBzk0QhBS9sJDlY=;
 b=DQfSJ/4cTts7uWTBY1Zc3HfM57xAcDoFscJ/wI88Uw4sQNVxjoQmlWt+4OzA9U7/Jn
 bZkMY+Lo9FlcZUb2/6lf7I+9OFrjXztix9ENHNOJZ1atIuBmkQZRYGmWkVbLn2dlnANm
 q+qDes2MihupakrXvG31JHd4mqS7UDOUYsMfDb8IRv4fAXtydR3IgRKX2fiQ4j5nDX62
 PfviADeNbuqxetvzcAH2zMNt14P4Y73cfD47e5hGhoW3Al1+wRwU3830jElyJdGG5ZmT
 wYaMZcydldQGpF5xYfDnWA+Q9DxBQdVo6H5hjg2kx7B4hMl1IpZiRGmd7VsNTQzldcMm
 Wkfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFxaszQ8uWjarABc7zuzUmnvyTB7drsracShOM4hWudGHqh+WtyqUxOA66wSZUFcSvQOY+rTk=@lists.denx.de
X-Gm-Message-State: AOJu0YyM384GQIr+WbUZ7GBaapYU3ScSArOVvGr4duVg/bRVO+ZCrwo+
 dYaCTsta85N3AIKs1AFjSucgWjOpsUgQfdLjZFLnyqOmYOLmj8KRAETZJLGezq0=
X-Google-Smtp-Source: AGHT+IGAxcNNqBlbGxcWAIJASQ/fVI4HauMen5OHqID0OicE2zctPcCrqnvccitwKLYOiXYaib5R9Q==
X-Received: by 2002:a05:620a:448f:b0:79f:137a:e4f7 with SMTP id
 af79cd13be357-7a99731e759mr1578261685a.12.1725911134471; 
 Mon, 09 Sep 2024 12:45:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7a040dbsm245713385a.86.2024.09.09.12.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 12:45:33 -0700 (PDT)
Date: Mon, 9 Sep 2024 13:45:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PULL] Please pull qcom/qcom-next
Message-ID: <20240909194525.GD4252@bill-the-cat>
References: <20240909101245.1302713-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gJzXmIunrUp8lfLC"
Content-Disposition: inline
In-Reply-To: <20240909101245.1302713-1-caleb.connolly@linaro.org>
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


--gJzXmIunrUp8lfLC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 12:04:46PM +0200, Caleb Connolly wrote:

> Hi Tom,
>=20
> Various improvements to Snapdragon support:
>=20
> * Bumped up the pagetable size to handle newer SoCs with much more RAM
> * Made memory map parsing more robust, fixing chainloading on SM8550/SM86=
50
> * Populate fdt_addr_r with U-Boot's FDT by default, and set $loadaddr to =
prevent
>   crashes with some commands which expect it
> * Added initial support for SC7280/QCM6490 and the new RB3 Gen 2 board
> * Add debug config fragments to enable debug UART on some SoCs.
> * Enable RPMh regulators on SM8550/SM8650
> * Map the cmd-db memory explicitly since it may not be in the memory map
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipeline=
s/22255
>=20
> Thanks,
>=20
> The following changes since commit cbaf53fdf12534be50075fdd84105c68295542=
4f:
>=20
>   mmc: consider cd-gpios in Synopsys DesignWare driver (2024-09-05 19:08:=
14 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git HEAD
>=20
> for you to fetch changes up to 41864bb2b66d0c68e6b2f6ae0c70d3c239ad258d:
>=20
>   board/qualcomm: add debug config fragments for some SoCs (2024-09-06 11=
:59:51 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--gJzXmIunrUp8lfLC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbfUFEACgkQFHw5/5Y0
tyy07wv/QIG7ve23qlIp0BD6QI3o+95z4RpwVo8Byz9mQOAcSOv12ygVnZEWFLjm
ulgJ0jfK/0brdbx22Nfko8OarKm0dtIdTzdr3NS4PaTXsnWvvEi/6CvTMCzgmNai
xmYe/knS7SXlviInFjFtBhp/2FlT8RR7F9WPZoGZZEig3X3MqgtiWPO/jp3ZRxxV
mY7RvmM2uXea6igDoaLSLmw9AA6yUZmynrn0v9te/jvPbGiLzFAqThDW2JHKWuZ9
dMnTdORfg7fhX+RY9p0RHIors1CvTMOvPTdhhkTMXEiLVziVBBeiLOHdSUn7wOaz
GTtrTLR/4l2X4Ali9ueRya3bbQgZTJjQKgWSl6eNQ/STXjNo00ypMCaRPpn4xPDY
/X51MwuBpF+aap2IN1opaXDgnswQVtt4M2pqUT/XQaf4B4PkoOo1gahHLkDmv1O/
y0jSkQmKekGaX+/v00KqepnlboxZ7XV1+4S/1aWbbijjLehfRDfzUgZPcMMIfRbo
6XN5x2eW
=X5Ve
-----END PGP SIGNATURE-----

--gJzXmIunrUp8lfLC--
