Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A35C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 15:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B61B887483;
	Thu, 16 Nov 2023 16:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qSq/2EJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3CFB8749D; Thu, 16 Nov 2023 16:53:47 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896EB8747E
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7b9bd9f8bfaso373744241.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 07:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700150015; x=1700754815; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nXsrYJIb6b6+wWvnHw0JL1OrtOX/LbsmZv+imjlwrCM=;
 b=qSq/2EJQZ0wlDpQ5Xsz63HMEvxM7HiQoyye1ZFTo1TzFp8eBVP4Pbl1ScKv6WVqXF4
 zkyeVOaWhYjuhiKIFWCn6iQaXiLJl7GJF3xL0YCtN3WBOUYP6euz7D9w0ZhGzWdq8nos
 D6pJ6PVCMmDua6IklAlUCWwqyWNGkLYty0PVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700150015; x=1700754815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXsrYJIb6b6+wWvnHw0JL1OrtOX/LbsmZv+imjlwrCM=;
 b=ZQYG008afodc85OI7DZr7xPUXL8cSP9OOPwvzRfdUcmCwaDaKNqpTEQJf29BnKNhCJ
 Jh8LaNVHcVER/0uewGkr2A9Z9R3unVtAGgcg0TQU+VE+YJovk77ZhKUJG4/9dqREl8O6
 shJqLfjZUE6oBaSheYy540d2BkFA7gN1FvJCb+/Z8zz9OhJJ21rAkU4BGcHCVQCowEXp
 SJdrZDb5qObNC9OSAD4Oswj7+MoBk3I39tR/BqS3X/5gPxFwldpofwEcMPOnCT+KozAh
 1TwubT/aY1WNCJbWB3+7Z42JkAJ5SVKHV3QMUQGNVi4JLFayd9HEyb5HF35+2WLytjma
 jy1Q==
X-Gm-Message-State: AOJu0YzH5CP6isAcS2hVdV6r3MCo8JHMamY1tLdJasVHslwfiDQf6Qjw
 Fkgvnnf5x1I85N7uV8FnPK0aKw==
X-Google-Smtp-Source: AGHT+IFTsOtRnFYRficXDcthASBwNNGdTm7qTKdEoEQ508WPn1ci6u8BQ+TEeNO4bK9pkPi/BAb19A==
X-Received: by 2002:a05:6102:100c:b0:45f:4acb:d50c with SMTP id
 q12-20020a056102100c00b0045f4acbd50cmr17148833vsp.0.1700150015251; 
 Thu, 16 Nov 2023 07:53:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a0ceb08000000b0065af24495easm1463509qvp.51.2023.11.16.07.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:53:34 -0800 (PST)
Date: Thu, 16 Nov 2023 10:53:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 7/9] Revert "generic-board: make show_board_info a weak
 function"
Message-ID: <20231116155333.GT6601@bill-the-cat>
References: <20231113030001.240020-1-sjg@chromium.org>
 <20231113030001.240020-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wGYfXlaipHneCGth"
Content-Disposition: inline
In-Reply-To: <20231113030001.240020-8-sjg@chromium.org>
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


--wGYfXlaipHneCGth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 07:58:27PM -0700, Simon Glass wrote:

> We already have:
>=20
> - a sysinfo driver-interface which can obtain the model
> - a weak function called checkboard() for showing board info
>=20
> The current implementation has a weak function on top of a weak
> function. Now that all boards have been updated to use checkboard()
> instead, drop the __weak on show_board_info()
>=20
> This reverts commit f7637cc01414b9c87b6b0f861f34d83c19bfaaaf.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--wGYfXlaipHneCGth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWOv0ACgkQFHw5/5Y0
tyyp2AwAmoeJ9HUxGm+Rt+g35gY55ZieJcKiFWEhiu/gjLNAW3g01ZlnNIugBTRd
KQyPcaGx7QmaBi7VmipoJnHz5O+l4bmcKHI2B3rm5k07JgtxFZpGH+g+YBX5hFIR
RC6Yh57HWryd1QPXqWhopT1Z6xOPK79tx2oLbVIsSEnZTnWo6Ptpe8EBIzBw3JUl
egEsVyvkGKrxtfjX1keEJFervdoV9oEJn7hSlqWd+6g65oz1dvzmYOvaKGQ+CnOs
fQseCx0nhcA9MN49nEtb9PObZb/u6fPE326qUxwMKmxtptZX7eoFVl1lVrQPaLVb
17fvg3PJlqLBEq+OGX9hTk8PLmkCEBjE6clcRSO0oyv9DR8gRBjkSZZGEwVLCeQ0
gWaJ45xXQwl/Swt822BbM4szd7Tno4G1SqEyeAjN1dwxo2yXxuWNWFoXE0puNvxn
Da0MF9VpwpxR7v4slMrKmrSyXUYtiyjiPizDHt9dPCFnqRNrM7Atzqe3YvT0QAJp
QJZCbr0V
=LmNg
-----END PGP SIGNATURE-----

--wGYfXlaipHneCGth--
