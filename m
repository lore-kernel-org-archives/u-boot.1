Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B960E748EE
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 15:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E508691E;
	Sun,  1 Oct 2023 17:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GdyNcAOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5F0870B9; Sun,  1 Oct 2023 17:55:38 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905E48646E
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 17:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d8162698f0dso17559780276.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696175734; x=1696780534; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IX9Y70tYWaNnXMCZn6h0hoL7MLzgiCUgipNgXp8396I=;
 b=GdyNcAOg0b5BxpJ83j25omELm25MjLA2cuqQh8rGhU30WJ5o9/SntddM/6GgfRO8SX
 Q3JD4/JxvLp1VCLRYAEtj6kL7tZRWKL+apdfoAmqBbxNBpiJ7/m9HekTY9PNauz2HWao
 wdmAUJkhgFH1qJrhAAQlBlKBPou2f8Gkiv6Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696175734; x=1696780534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IX9Y70tYWaNnXMCZn6h0hoL7MLzgiCUgipNgXp8396I=;
 b=Kag+4IgLImlJYi7uVZjDT5vLy3oQ1173ua3AtH6Cx78xhlyytY/00UKVHvlol0fYAA
 7A7JVmiaomnyAlHAygBXWAWNH1vKeOA0GeuC9KPxU1/4fYOowT/0pwneHwXj/cJI2iiY
 3+Iz0vT7S/OB4jtSlq97QoCALpp6Wl6DhiEPIUjmXn63iSeFr+IoIN5+A82iIUWIilWI
 W0gZK9uCf8EQA2+iKI5pjaF3a6PWW5l1UG2KRcjGpE8JMPYf7VkZaAGtpWQNySftC75U
 l9KiGxpDggfCkCFoNlDPSFK7nM+IsmpbaLt9hXBFg9V4lon1Uf/F//kl3h9ubhnuGpiJ
 oSXA==
X-Gm-Message-State: AOJu0YyIlhQK4Cqw1YNKPbJ5WZ3VcqeyRvvZUK6r0z7WOzXKm+KIjjrY
 3H0KF2/0+VP3O8ZHRWH1IVDuGw==
X-Google-Smtp-Source: AGHT+IHgy+J+vWlb/N8MdxW+SMkrkTfXP/0hYuPSnUBfPgaeqp3313PEPWqqXKX4nJt//6NBEe7uYw==
X-Received: by 2002:a25:6893:0:b0:d12:25d:fd60 with SMTP id
 d141-20020a256893000000b00d12025dfd60mr8431588ybc.9.1696175734338; 
 Sun, 01 Oct 2023 08:55:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-13fb-ab5b-9ebe-9b3a.res6.spectrum.com.
 [2603:6081:7b00:6400:13fb:ab5b:9ebe:9b3a])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a258011000000b00d85abbdc93esm6186721ybk.12.2023.10.01.08.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 08:55:33 -0700 (PDT)
Date: Sun, 1 Oct 2023 11:55:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, "Andrew F . Davis" <afd@ti.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefan Roese <sr@denx.de>, Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Mauro Condarelli <mc5686@mclink.it>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Nikhil M Jain <n-jain1@ti.com>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Roger Quadros <rogerq@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: Re: [PATCH v2] Convert CFG_SYS_UBOOT_START to Kconfig
Message-ID: <20231001155531.GA2767539@bill-the-cat>
References: <20230825015948.780662-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fnHSK/A/uV+k2z0J"
Content-Disposition: inline
In-Reply-To: <20230825015948.780662-1-Mr.Bossman075@gmail.com>
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


--fnHSK/A/uV+k2z0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 09:59:48PM -0400, Jesse Taube wrote:

> Commit 65cc0e2a65d2 ("global: Move remaining CONFIG_SYS_* to CFG_SYS_*")
> renamed CONFIG_SYS_UBOOT_START to CFG_SYS_UBOOT_START. Unfortunately,
> this meant that the value was no longer available to the Makefile. This
> caused imxrt to fail to boot. All the other boards that used this
> variable were unaffected because they were using the default value
> which is CONFIG_TEXT_BASE.
>=20
> This commit converts CFG_SYS_UBOOT_START to Kconfig and sets the default
> value to CONFIG_TEXT_BASE.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--fnHSK/A/uV+k2z0J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUZlnMACgkQFHw5/5Y0
tywNQAwAoNh1zn/EC0SjA5KL6kYSn3O8vpGUFpCWnU+OjFE/rlteZHEgjwPSD8a0
j9GekfiJ5BE6/J/0/Pb9XNxICFXVDYn1RGFeD0o+pnwlUpZaIRMzT4xH/sVluNld
DG7oSTfD4HBnbPXF1UXi5dvA8qBvs42Wca/HE+fnTbIzfKLZ+MBrueOBwF4/Uiqs
WExVENzfp3CScTQhNfRpFiah6zrvazQ+6AI5niT7tKN+nEHYUELcQ4a5S38a05wA
hBFwD67ydavVGDo2XlSPGyHXhbgAybprpBiaAmHzG1ESKBOgYVIXixm7eLHChi7m
ozyBEre8kr85QuwE5dDHeyITbNMCsHwoCFa62JqdBzJj/6qcyVuN1VOVwa8M7KUL
O+MpJ/IpMjKu4rO2Oztvz2GBaqK7wt1ny02NuTyXVxnr/f7NP5Av6vPyxrolUk5p
l50QDJgxxlzZ/BqhFTTFV5qQyv8vkMROOTFheMofepWnKNfCVklAqFbFRW5eSm5k
OetUqQar
=fKMU
-----END PGP SIGNATURE-----

--fnHSK/A/uV+k2z0J--
