Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012B1C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169A083F7B;
	Thu, 24 Aug 2023 18:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sksGtAaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D49386596; Thu, 24 Aug 2023 18:31:30 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 754158082A
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5925e580f12so810617b3.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692894686; x=1693499486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aTvuTuOzfaRdiRtsomc429OitGS90q8fL3aZrxJxces=;
 b=sksGtAaa93mcCPamAMTYUwUnuWMkwrhtW/sXqcr1OmpSWJP+IKgGA+pc7F+R7V4TZT
 s8qT7CVz8so++ALxdWxR/6X8iXI0Z4V4/j0rdI5JVCPq9udXvQlQuN6d6W9LNAuEVMYm
 Xnv/35+VHHj9Mz37N3lq54Bf0u4gqFZBQr8SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692894686; x=1693499486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTvuTuOzfaRdiRtsomc429OitGS90q8fL3aZrxJxces=;
 b=MmtknKELxPHOPNFFYzWOb1w/0xb33iUeNlyDoVbCybcIPYtSiIuG7QQ2hG+8YgfCTe
 PSZ9Ni9ih1RjMEs7Cjppo09yTUdbQMRU5i5toQ55GMgX6nDadYZbp8T25YJPWxo6GL6K
 8VaJopq7TRFTNJfjuN+sVdvKmJSzsR2dOgv0Cd6nQKhbRaTd0N7oexXOVBei7dTHr1ST
 LQzU9aagf+K8vg3x5oQlAxi40KMQ0eRNeLYnKqVukv/wyS5Id8amyDjeYv4hLxCh8BgN
 EmEnM2vMCqd4d32HKJ91j4fIcuK+uO51ADscQnerKGMJRXEgKjWdxy+EP+cMhnGA3cZd
 HUeg==
X-Gm-Message-State: AOJu0Ywq2kCmT5U/0yNEe+v9Z3RaBxa1niFBg+Uz51/IYbOeAzFbu0+n
 AVfGQsUAToIQm2qSstbl6/iglQ==
X-Google-Smtp-Source: AGHT+IGfMcxNypdpV+TyMpN+HUseIjfn/I3eHhGWdAzXnikQ8n9OHPSECawGFUzUAKh5wx1dKc/klA==
X-Received: by 2002:a0d:c4c4:0:b0:57a:f72:ebf8 with SMTP id
 g187-20020a0dc4c4000000b0057a0f72ebf8mr16649602ywd.28.1692894686117; 
 Thu, 24 Aug 2023 09:31:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 p188-20020a815bc5000000b0057a6e41aad1sm3970072ywb.67.2023.08.24.09.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:31:25 -0700 (PDT)
Date: Thu, 24 Aug 2023 12:31:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: rick@andestech.com, ycliang@andestech.com,
 yanhong.wang@starfivetech.com, sjg@chromium.org,
 andre.przywara@arm.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 marek.vasut+renesas@mailbox.org, jbx6244@gmail.com,
 bmeng@tinylab.org, ganboing@gmail.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v6 1/4] Kconfig: Add SPL_SYS_MALLOC_CLEAR_ON_INIT
Message-ID: <20230824163123.GC3953269@bill-the-cat>
References: <20230824162521.22240-1-wiagn233@outlook.com>
 <TY3P286MB26116769A6FC3BB12FB91A77981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zLUF4vZuTOtmtWlW"
Content-Disposition: inline
In-Reply-To: <TY3P286MB26116769A6FC3BB12FB91A77981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
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


--zLUF4vZuTOtmtWlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 12:25:18AM +0800, Shengyu Qu wrote:

> Add SPL version of SYS_MALLOC_CLEAR_ON_INIT, this would help devices
> that need to clear ram before use to work correctly.
>=20
> Signed-off-by: Bo Gan <ganboing@gmail.com>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--zLUF4vZuTOtmtWlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnhdsACgkQFHw5/5Y0
tyyBzAv+LaDk8sMbVcvsJEwcIqHHZVGwppyVwVclUVv1g+svKJs+EGuViyo/0sZH
kxhwZzE5tRbj/XdxS2J26kz/uJ/xqZPIAIhFgPht9AV4vIWddhopOcsOZvxn/Vfp
hs1XwI+XTUvJ29DzLv1ajhNKWhV8/SxiB30QF5qeTPjLoDDVgKBv59eZbb7WwhDf
kHvAmVDld85tSw3yZ3wtUZfd2MgH92tvQGQ/yxSni2y9wUCqCYL2numjuhchu8dd
MZN45ade2NrTIgOhULop0ousqxLE3j1pOX9bSsPIQGYOPE7WWVRmHQmWyjHdGpK1
cWVfm0+s7Viz+gRBgGiaBeHjJfwaym7XeBvfXX37X5TPsHj9Y+GXgZlMMKmD1mcy
L+JFqPBanKmS2P+c30uhVCExyI0WmtVrCgW90Ddo5VpNu98KC1HNVnaLI3v7ccA7
EopaMgCDY4ObzvGFlMAt107JGDLdvr6iRKIpMqjR+ZxUv8/JQX5EXwX6a+BFOHhn
UL0vDYPy
=kq06
-----END PGP SIGNATURE-----

--zLUF4vZuTOtmtWlW--
