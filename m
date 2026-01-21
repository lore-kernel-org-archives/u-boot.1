Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1139C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 14:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18EEE8341A;
	Wed, 21 Jan 2026 15:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sdQHOSCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C30DC839D5; Wed, 21 Jan 2026 15:57:37 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD1D83015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 15:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4042fe53946so2548299fac.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769007454; x=1769612254; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sbRrTaMMArHSFIM6PaT8EYSt5xvJwe/bkO04WPN7mec=;
 b=sdQHOSCPXY8PxjOAY8ZNUP/kjQ0yKIR9sD38ye/keJxpyD+ebiFFcDKxTnZpHmWxio
 /0LlGz8BFNJ4P1kD6AWS7jf+Ql0XasGc17+BwOgOpHTzwfoaOL/skEdHI67z4MXh/0/R
 Q2S8udmo2JVYVFOzcK8EJ+FgGvXSb6uT5PFv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769007454; x=1769612254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbRrTaMMArHSFIM6PaT8EYSt5xvJwe/bkO04WPN7mec=;
 b=ZhTVWqDlQoG9fIS11RYqD24mfVCUI+64HliQjHTKezPXjKHgFDFZQYiAq37OeKLLQ3
 bG1/N9c/7X8oRufq8n9zNwQgqRO9fCZn/uJNlU3kmj1tnr8U5K/PnfNNlqC8Iow/JaMM
 3FxMIsKUschYS2S0mzEgD89bJs7jzsRA5kSudPZrbDD15IGcPjWU40+ukTbYrFDoF6SN
 H9WPHLmGVCOUMWndkEMOWFENalChmCwUIKfExFsB50g2Q3+jLPIfzwrQNILJ1mUOvY9S
 AGvUjS9DW3ZBtTw8BGBgkeWusYRWq8zxoqk1n7EfIg6a9oVPqvwjvj7gHvDrWrNXQhsV
 ZPDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNSgO87GZsyVOr9AxG3jTxIywcPA3FWc7ZhT2x3BgDdFpWXeE6Oyv8/QBjOH82DpP3Rw1nQ3Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yz90RxE3ImKfVfdkUV0aHtS4rbes5tyvcVoIP8phh8E9EB80bd3
 WvYH1gTrWx87uvE41my90avP70EprXGdTCiBR3Ipyld7xt/iTwDat2srI43QocvCnD8=
X-Gm-Gg: AZuq6aK/qL5vZGuWrhdaaWUNUYhBW3JWrZyv3L0qEUs1NKJd/jAYMwVLbxazbWayor8
 LoENjC+lCNmgYi94W3TVTvXMvnXZa8+tjBCG6iFM4qq35ttVlWAMTIbnIsAN5fK1s8FEt0DLW8w
 pH8FwBehmt2LoIuY6d+j1m8rbWAxqD7aL+ToHWngtIPwQgBpz/BIWaDq1PRGMoEErSLsGGB+EBo
 pcYyiCthcMYU5aKG1VGBowmezE9RSV10Ras9F1rn9EJg0whHVuWHNgxFDh6xhHXNqTSZpvQmsU/
 a1f6iuh38mxMjmn3ftDNl2ESK9fSK28LDMeqehPgsVyziw9Um1Jcx7k3tJiw/UViJ9X0r14zwpD
 wqg1geXk7wZxNESi4RiGldRMXL9EREeFJopYb4YpDaudKNnoZnZ5dLQ/KHbh6S2BlalAc4bTN/9
 1VEowHE3Yha2M9ZXZQQR2OodKi7O5/6+ZaAG/dVIUhNUIM0TktX0NCoVP/uN4BCV2IirdWcw6UM
 dw/N/alabmiszsnyTdB+pheUHcYxJM/GR3dkGI=
X-Received: by 2002:a05:6870:aa85:b0:3f5:b9c7:6d00 with SMTP id
 586e51a60fabf-4044d0c9074mr8804278fac.57.1769007453909; 
 Wed, 21 Jan 2026 06:57:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bb545b9sm11240630fac.9.2026.01.21.06.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 06:57:33 -0800 (PST)
Date: Wed, 21 Jan 2026 08:57:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 me@samcday.com, aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Message-ID: <20260121145730.GT3416603@bill-the-cat>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uaeeq1ATtI5VMhB+"
Content-Disposition: inline
In-Reply-To: <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
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


--uaeeq1ATtI5VMhB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 12:09:17PM +0530, Varadarajan Narayanan wrote:

> Add a 'request_arg' op to struct sysreset_ops to enable sysreset drivers
> to receive arguments given to the 'reset' command. Process the
> request_arg() op before the usual request() op.
>=20
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>

Thanks for doing this.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uaeeq1ATtI5VMhB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXDpWgAKCRAr4qD1Cr/k
CnqcAQD45uDwgYBiH96Zj3GwMLySnkRb5TslfPSINRCgizHf8gD8CWtddvB/tTmu
EETGLgw9VIgFZKixYOoK6ziTgUxehwc=
=V1zJ
-----END PGP SIGNATURE-----

--uaeeq1ATtI5VMhB+--
