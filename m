Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82732CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45AFA86EA4;
	Wed, 11 Oct 2023 21:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XgBYU26h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B6D86CF3; Wed, 11 Oct 2023 20:38:45 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D3486CD0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7dafb659cso2191787b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049418; x=1697654218; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4cCsTvhFfccQVNovBlx7BtAlALQ88qkalMehy7TBsqE=;
 b=XgBYU26hARu+SBFBw2zyWHYcNsrc+N7e1LExh9g5WhlTEVRMO8fwZaet6g4pnskp0R
 RAk+SWpfgRiyX7Rt9dUCMGcCtMO/q+rAeslapynbrgLTN974cNEQ9srATDRS247zkUD8
 nV4sG6h6CmaVH4q7uPN1KU8WM74Wzu0s0CPsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049418; x=1697654218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cCsTvhFfccQVNovBlx7BtAlALQ88qkalMehy7TBsqE=;
 b=A0ZB0lRM7g2SGqZfFge2wfiy62ggCwhRA5MiqOgMqGxxoNQkMD+JPwTPQoeCeGqElU
 MiqF/8c6U2Y7eCIKYHKteUnjEHxM2V7qGFl6K56+LPbC2Ad92yYhM9RDpzlCfjOXt0s+
 hQvZv4soU9VQ0DY+33XfE2dLQqOAqpL0N2OoVf8mmeIeywU6hY4Vjw2rLKzUUNUCF8r8
 +QHtdNG0z2imcq/9Rgas6LaCOGfCGo60oa/w1KQyWTusXbSNGluz/6r+2btf73/ZYW8k
 3/LSAGYoVEEy4GVxl0LsPo7g+60ji9IuAAhquPBkYDa7Hr5E8fwNDlHb+1iKVcW5TJkd
 HW1Q==
X-Gm-Message-State: AOJu0Ywm43WVoQSwY4/Q+lceyWI+OFMxu1mBEHkGQqbZz9WYg8ciuU93
 eYR9qTU1kz/8u7abUMo/fP4c9Q==
X-Google-Smtp-Source: AGHT+IG4qyzqABGTex74HbN4k/gYObnMG8Z7KqhJo70ML8N9P+dXW2zyfnGbw7zamwhCSmbPuyIWig==
X-Received: by 2002:a81:92c5:0:b0:5a7:d11c:f0ed with SMTP id
 j188-20020a8192c5000000b005a7d11cf0edmr4172914ywg.33.1697049418598; 
 Wed, 11 Oct 2023 11:36:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a815d07000000b00583b144fe51sm5363717ywb.118.2023.10.11.11.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:36:57 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:36:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 2/5] iot2050: rename overlay sources to .dtso
Message-ID: <20231011183656.GN3119521@bill-the-cat>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
 <20230925080909.365098-3-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IUkby3s7ymJSIKXq"
Content-Disposition: inline
In-Reply-To: <20230925080909.365098-3-rasmus.villemoes@prevas.dk>
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


--IUkby3s7ymJSIKXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 10:09:06AM +0200, Rasmus Villemoes wrote:

> Distinguish more clearly between source files meant for producing .dtb
> from those meant for producing .dtbo. No functional change, as we
> currently have rules for producing a foo.dtbo from either foo.dts or
> foo.dtso.
>=20
> Note that in the linux tree, all device tree overlay sources have been
> renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
> 81d362732bac). So this is also a step towards staying closer to linux
> with respect to both Kbuild and device tree sources.
>=20
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to u-boot/master, thanks!

--=20
Tom

--IUkby3s7ymJSIKXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm60cACgkQFHw5/5Y0
tyx8xQv/XZIM88RPNoLPhTOB03BT7ZndxB5sxFz6JcEdsBpNgsMtLbs6PgtNQ4Z6
jbegyv5dwc7IQjlaCmMFdi54lqnVtZkApuKuehNL7PKCxjeHXb+odo2yLlifzuk3
Dd5pvDX63QE9KwaZ2ktqzddrcPCauS7JT7xw/0Yc+h4Js5ftDybYAqjM5zEz1pm8
utlyuNBS0CRTmJtidAXNCPPNxdbrilEwj/M3GAN3lNSKle8ENxDbJd7YKC3XVYhw
1BJiPbYJy6DnNI7PmB4sETzWCLlNcbKaa9YMA2iPFvr1FXKFAbLeSUGmS0e3xitc
TRPUtbmMs/1tZ0G2X2iTm5yo1bq3bNGoqn3t+vhtJ3YPld8+xY9Y0JkPEMHTJ8QS
5hSDWUjMCXt5k4FxnAuBDvCGsHGFK+ppjI3+ESjRcC1DmeB8z9KIVNkxdQxm+6wQ
IPIImzOMOsI2psi6KYqTIRGiUw2G0OPmA0FDg8hKjXeQq9YYFsJkoX3FhDQ9kwG2
oQK2qrk7
=oMys
-----END PGP SIGNATURE-----

--IUkby3s7ymJSIKXq--
