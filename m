Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A06C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 21:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E4D688701;
	Thu,  1 Aug 2024 23:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="orq4xR4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24AF288706; Thu,  1 Aug 2024 23:16:00 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8743288646
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 23:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5d5c7f24382so4156845eaf.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722546956; x=1723151756; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tYZgTQ/S1ewWlnfa6Hm1XdyoXbGrncYPnsvEYH8aX18=;
 b=orq4xR4CBwqUpaf4rcsO6s0jXWmDjB2k2IakX/6R2vZVJWQCACAYR2rn6rUK2QXYKh
 a+BgcxZcMOC+lrjrTQFC/iQvc9NzpSskU5ITkRPxz3JrwAOcCi0Id4JrNcO76GKxTo7b
 c1jnyGoZ/pxY+u01PZ2xG2xu9BH+Q6kEkPv4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722546956; x=1723151756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYZgTQ/S1ewWlnfa6Hm1XdyoXbGrncYPnsvEYH8aX18=;
 b=w0zb2AxMx7865jyk1eRmNqnFlfqLaVF75w+sRZ9xII+fn87NjdHKz4HPa/QK6Xeolp
 OGsDghmBlqluei0wV2pxWhTu1XbILuIwteNCVTt6RS872Q7kK/C4X+N6aZ8eGimGZ4cL
 Sk36armHe6N0zbb/xESof02HCftm/hkihH2ITbI4uuwqiqsq6Alp1LisYKwwkV5EdE5g
 5CVkT3kar5xP+dN7UbJ6KDEoEPRS2habteHb6silfzHs9mOnUQW9nHJ5Kfxxt3QDqca3
 aVyP05CulhcLEiGkf3czqTHrQ//20uFLiXv9H51uHKCLEzE71tAP1rLa/EIW+rOfUKBu
 Z2+Q==
X-Gm-Message-State: AOJu0YzEmGHbgBkC/1QQ6vMx7byyh9gJDHmFtVbVIz8EuvKGskTFYIgL
 ycD6R9m/XpjJyyLfh1I6i22gbDcYxZEASi4+6QeTNVyAuM5k7/Jh5vhRu3ZLSeQ=
X-Google-Smtp-Source: AGHT+IGjh9Mxtj5/Rauhxda87LI7F9HF601RWg51s5ADV42PAvUlqXA30kh1nqm674OcEoMKAbAxkw==
X-Received: by 2002:a05:6871:3a25:b0:268:880c:9e0a with SMTP id
 586e51a60fabf-26891d40a1emr1885624fac.20.1722546956260; 
 Thu, 01 Aug 2024 14:15:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a42fd16sm24166fac.27.2024.08.01.14.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 14:15:55 -0700 (PDT)
Date: Thu, 1 Aug 2024 15:15:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng.cn@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v5 03/27] lib: Adapt digest header files to MbedTLS
Message-ID: <20240801211550.GK3794063@bill-the-cat>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
 <20240731172556.1348487-4-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FNvIKE8L8aq761Be"
Content-Disposition: inline
In-Reply-To: <20240731172556.1348487-4-raymond.mao@linaro.org>
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


--FNvIKE8L8aq761Be
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:25:13AM -0700, Raymond Mao wrote:

> Adapt digest header files to support both original libs and MbedTLS
> by switching on/off MBEDTLS_LIB_CRYPTO.
> Introduce <alg>_LEGACY kconfig for legacy hash implementations.
>=20
> FIXME:
> `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> including <linux/kconfig.h> causes undefined reference on schedule()
> with sandbox build.
> As <linux/kconfig.h> includes <generated/autoconf.h> which enables
> `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no schedule() are
> defined in sandbox build.
> `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` is a workaround.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Please either FIXME or reword this for the next iteration.

--=20
Tom

--FNvIKE8L8aq761Be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmar+v8ACgkQFHw5/5Y0
tywEIwv/e8BKnT0BX7NrRwtuZ6Wu2pi7gglRRDzk4nq2Hd9gFA3gPmi8etEk9dK6
W3FB7tTjO8YT3XopnLXxrwAGD50Dm4YHExvfmImKmrdY9yq8c1687vBWEupWyRQ/
tuwgusHzg1E5C6wNcT8UdAFiph1qQ3d6eLgVoG1gOFd1SYFuChVfbaWwX14coRTH
9EmKUZAb2eAh3+cCFGJwraxja2PHgfbmXntuFpauBxFTk+NdY7lMl9x/r7cPNMHv
o8+HfsCo8n0JGUOMse7Xqeu9pwc9HyckdfPdKa4WWxpDYP7cUqImtZlfOVXR1/ac
oIiU/trZrYDZNpcxUF9HXALghvPn9aOzQdcBtDBI8//kFUScaMI/+B/1ZN9JHHTI
tWIdmGE25luUaEu52S+BV63oTFXrrOJh/IlTpZfBjheEmklUBTy5kTD9a5oa75nG
rsN1iiaRfS6T5VXxMKwRL30dCaC+4aqUBNUqCgj97PWXav2P/bM2iHO56AE8nsn9
OlKlNaRS
=7wCp
-----END PGP SIGNATURE-----

--FNvIKE8L8aq761Be--
