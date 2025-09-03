Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D181CA1009
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 15:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D7E833C6;
	Wed,  3 Sep 2025 17:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cLGs9ct6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF3E831EA; Wed,  3 Sep 2025 17:17:21 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01774833C6
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 17:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-319c2a87a5aso12999fac.1
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756912638; x=1757517438; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jk/moh8nNuNc+cBMAguPxWCa8cn7d7HFqqKuwst7ZBI=;
 b=cLGs9ct67DkwLTnAssKCugxC1STpURJVuyGkEk0WyJSIfa2a6nFImzAwZOVP9UzO72
 ADGOAAe+RWLtbU62sXIVn6TPgpLWLCLF66mqv/iR4xrIK+oyVnQn6t70XH6ZZWr64ZiC
 JC7y1ePl6+prrGUAj7G9B0yL19j/vNXDOuZ5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756912638; x=1757517438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jk/moh8nNuNc+cBMAguPxWCa8cn7d7HFqqKuwst7ZBI=;
 b=apPIsjn9eLNqLN7XLgRRp99eC/tdkXKJ4nLsD6EDw/blDmFA4MymmGOfY2EKoE7Qat
 g+w8Y60qM+wm8Fm+dbuefty9qnadICvhN0K8yFG3q968FBTyui0GVFhpfu/7EfGrFTkb
 hAELYByjXnSqnpqh58srw58R2/E8ukMQ8e6y8KnZFDHc+mWTt39DKLowxrPQsTRiN7CN
 bcjNJ/5/d18dS0zetKCVbCDx7WP1yUInPfv3+pDW5a9adE62sQ8AEhCk0iJtup/kPBgK
 66xXuS/B8n4HBPl8LkXN+9h4lJFrH9zAM/0wxQ/effHW8XeRLaQOWd/dC3shRcPIP0BR
 Lqmg==
X-Gm-Message-State: AOJu0YzqKYxVBqVZwVceGdusqlErVirEdCIMpi1YdkbX1BTiG5eHVYHf
 5L9l0q09lMZ8B/x+hZNWGAHG64XEflgQlibq03XFGFRYxcL6O6VHl4JH0oMuUmuj+ec=
X-Gm-Gg: ASbGncuLr5Pb/yA92nSGT3nq1le99MKUQB2Jvx8f8TyE+Pio1vnciMVaikD55ZiUtC/
 d+vAyVARKxqpCEV2lRD+SlFmcWP57zBLtLRawjv03qfApkdOvlYldLrLJYhY0U8EuWrjVAosUCz
 4HdI7HQZuwG8L2X10k8N55kBiFHMQnka497Ru/y4vNoy9TYKXiz+VFDYShvlAJsHU0uXXPgXURP
 VLZRHcz3R9zmSh7+MYUSusa6ah7qp/CAHT8OGwVfPWHsKkpgIf/dhjgqXv5GWWl3uoN6dcNhy8j
 zR9dafmSlqPMhMLSfZXSCuyGxG3ONVgtaNQ6wcPvn/2YqC5y3mW9y4SgJAxR8vIZk9iQflxzlMw
 7STgQBxOqI/bUjKjuCHG2EG2sPxvbcO+cWk2oBaRPbI4ngQpGlh/t1rVJ
X-Google-Smtp-Source: AGHT+IEBD4wc+LSVnL7i2/JnAcE4RnDAVpyV0xa8Rg7YH0X0Q+40gSCwwEMOqryFZOS/dOi1m9jYrg==
X-Received: by 2002:a05:6870:b313:b0:31d:655c:4ac4 with SMTP id
 586e51a60fabf-31d655c79aamr1171213fac.19.1756912636652; 
 Wed, 03 Sep 2025 08:17:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7457438a327sm2304127a34.22.2025.09.03.08.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 08:17:15 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:17:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2] env: Fix up indent
Message-ID: <20250903151713.GH124814@bill-the-cat>
References: <20250903142245.90689-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YCLzKIKuJ8uSsCD7"
Content-Disposition: inline
In-Reply-To: <20250903142245.90689-1-marek.vasut+renesas@mailbox.org>
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


--YCLzKIKuJ8uSsCD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2025 at 04:22:26PM +0200, Marek Vasut wrote:

> Replace #define<TAB> with #define<space> to be consistent in
> the entire file. No functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--YCLzKIKuJ8uSsCD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLhb+QAKCRAr4qD1Cr/k
Ci4dAP4sunGiG/awXJy7epquru6sgqsfqhEsM/bRVdUNkDQCSwD/ZglqZYzGcHhS
o+xwwVqZVRLsAVINtzK4h/VNuW+Hmw4=
=P944
-----END PGP SIGNATURE-----

--YCLzKIKuJ8uSsCD7--
