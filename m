Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C99CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 14:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3455C833E9;
	Fri, 12 Sep 2025 16:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q9bbJSQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB579833EB; Fri, 12 Sep 2025 16:23:25 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B348183285
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 16:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-74be52f5447so804158a34.1
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757687002; x=1758291802; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ppXMmKw+epVxuWU0tM//uLtLPWtPS4S+fcXFuHFVGJ0=;
 b=Q9bbJSQYbYAUFtOoyULl4VT2mOzZjjMGXvSKX88OD+saQcMH0acTef6rizvCXpK8ez
 AcoMkRh0zFhxnV6aRIUhy5hBEZntpHww98gC11/Gi4E8egSKL35kZMQw1NL03w9amMKy
 9ckP2rSjiu6W3rnoZPbBt3BuxBgAgj+A1ZO0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757687002; x=1758291802;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppXMmKw+epVxuWU0tM//uLtLPWtPS4S+fcXFuHFVGJ0=;
 b=rabe54ckDjY4i61u+Z9GWZJays+6ykMiblNC+sucWri32Oo5PYZSks2aEuJZXDoCWT
 p8s6GW18hjNu2ow3s3ViR6H494RMJnB9EsOJAcU6OJ34ncqV0vclXCYCXc5LFDGDvWfZ
 MekM4ZXvx/PxvBcK8qII7cgEIlMi51GLLxxhwREpzR31+N5mLhm/xBOEvwlxokuz5JO2
 9iHLvlC+77lNDPCzmUdGKbTXRlKJq5/Q7ekpOG6LCOb3bGprCwoSl/hB0upgcw38LD0j
 /Da+WNxwWsljOjsg/rRY/WaiP3VXiwtU0e8PgF/64boi0TiyHB7EE/uej0rfnwZ914Et
 3EyA==
X-Gm-Message-State: AOJu0YzBoqMUtqrvInGqCZNpJnY90QcWilzTnqC1UEzOMX21gdoZp5xO
 ZJSKq422u7wVjxwcyEQhdEDYOgOCMBf9BC/YecpMfMi0cEv+L1Y7tCw8ISIh0owSOt3/2iKVmVM
 MlksB1js=
X-Gm-Gg: ASbGncs77odKD7OcwT0pK4GKNrIOrdAXKxwvjX4JCZQv6sCaoUQoMg4MYoS5guI0EXS
 3p5s5SWUX3/bYzcN22bt9DaFk/WQEsRi/fppppZStMnH0DI3zSv1etftgxE7zlTBD0+NI3QEnqi
 edtcnHC+1Dn82azvX1J2wAFRj9tdmLPIMhUpLhhuPHs5rEOK4ULvuc+ssALxCVfrM4o3VMy5kUJ
 PZ/01bG2WLBT8GL0Q58+12P3c8OiDO2j6lPBT/ufeVtu76BjJbK3tpJw0Ou4n+r8CzQRR0CbK5f
 DKwCm9QiGCKR2DRXLOx72TnETx4FgtIPAZhovmqHLFUqgL551NyQ9AYfMCmnbhdD0Wo09I0LWBw
 +C/lEOjtLh8f7TTbzxPJ3D4X/+qCtAIj/3yOfvVELhK8Eg906bjZxNZ0pc4B0Xqb2UiI93lLAeh
 7Rgw==
X-Google-Smtp-Source: AGHT+IEJi/f1rnbZPYxWHpwnnEHk+wIU57rMwJ5L3XfdsvBgYRUN4iVayf5khcDtWZpAtLp4Gav8xw==
X-Received: by 2002:a05:6808:1a17:b0:439:b674:d99f with SMTP id
 5614622812f47-43b8da0b35amr1337277b6e.40.1757687002292; 
 Fri, 12 Sep 2025 07:23:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b828d3199sm790118b6e.4.2025.09.12.07.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 07:23:21 -0700 (PDT)
Date: Fri, 12 Sep 2025 08:23:19 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH v2] scripts/Makefile.lib: add CONFIG_SYS_CONFIG_NAME
 prefix to dtsi search
Message-ID: <20250912142319.GA4060911@bill-the-cat>
References: <20250826214708.309271-1-e@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mbS/zLh1qVQLl59Q"
Content-Disposition: inline
In-Reply-To: <20250826214708.309271-1-e@freeshell.de>
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


--mbS/zLh1qVQLl59Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 02:47:00PM -0700, E Shattow wrote:

> Add ${CONFIG_SYS_CONFIG_NAME}-u-boot.dtsi into dtsi include search order:
> orig filename, (SYS_CONFIG_NAME), SYS_SOC, SYS_CPU, SYS_VENDOR, no prefix
>=20
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  doc/develop/devicetree/control.rst | 1 +
>  scripts/Makefile.lib               | 2 ++
>  2 files changed, 3 insertions(+)

A problem is that today, this leads to failure to build on:
mt7622_rfb mt7986_rfb mt7986a_bpir3_emmc mt7986a_bpir3_sd mt7988_rfb
mt7988_sd_rfb mt8516_pum
pkin socfpga_stratix10 socfpga_stratix10_atf socfpga_agilex5
socfpga_agilex5_nand2 socfpga_agil
ex5_vab socfpga_n5x socfpga_n5x_atf socfpga_n5x_vab
mt7623a_unielec_u7623_02 mt7623n_bpir2 imx6
q_bosch_acc imx6dl_mamoj socfpga_arria10 socfpga_arria5 socfpga_cyclone5

Because the problem you're trying to solve is being partly solved in
another way by others, perhaps?

--=20
Tom

--mbS/zLh1qVQLl59Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMQs1AAKCRAr4qD1Cr/k
ChNnAP0R1qU13NrPDNAGPTLGjlgtylbCyMAh1MXtUIBcqwbX4AD8DsyQ8TEP8Iau
dvCDZo+676jaFkaP5GTxz8D6uL9DCwg=
=ctSR
-----END PGP SIGNATURE-----

--mbS/zLh1qVQLl59Q--
