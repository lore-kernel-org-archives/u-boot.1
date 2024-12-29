Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2FDE7718B
	for <u-boot@archiver.kernel.org>; Sun, 29 Dec 2024 16:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F2180243;
	Sun, 29 Dec 2024 17:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iimn/Yq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C401804E7; Sun, 29 Dec 2024 17:36:02 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A80801F5
 for <u-boot@lists.denx.de>; Sun, 29 Dec 2024 17:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-46792996074so83878541cf.0
 for <u-boot@lists.denx.de>; Sun, 29 Dec 2024 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735490158; x=1736094958; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EHoxtqUVT5Pd80HY+MZpSjZca2Xxx8HVb0VO2E3pkw4=;
 b=iimn/Yq5nsi51otCG69vpl/JfP1AduHqGvpZbgZLjJQSm56S5HF1nTOgKlekCMY+EC
 hX55oonVvOkTjSbe8pGx0cDRRUQAyFTojqypirjri+4kyeVyIusBUfdu5lc7Nq/ttB2Y
 eT8sPupINM7MGo50t4p4ThYpeFB9BLGFz2ZAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735490158; x=1736094958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHoxtqUVT5Pd80HY+MZpSjZca2Xxx8HVb0VO2E3pkw4=;
 b=rF74wpO+03p6+YXIwUwUJ8hiw/gmjS6RlN2A5umba1Dn/IxCzDSHGk7XUkTASijzWk
 hjYMgfbkhedHQ/zrpid4oCOrfqNxsWwEDtMHiny9fmrd7BneY/H9AaoUwClmtFddjqmh
 xW8py6jDPHHBl4x4WIM4kfWQ8VLBtZTp2L0JKf69Dvz9mEhVHAUbXwl84FYtakLx6oWE
 qBHZVVkI3quMTQ2hVwGVvvOhBgmb+dlTWM6AquFoZvDZKbX5Ik1vAUPXHEp0VC1VL4C1
 8BlF1njTa+25UBi7X6p3QWPpNo14QvVd+hBeVttuOvsLLVxRYOMJhDvhqW5JatyzLQO4
 mTbQ==
X-Gm-Message-State: AOJu0Yz3t8AcoLzQn6oaSfjcxB05s9o1sRWVmH6NoYt2QMvYRHmT8Y02
 6KZhtigMZltPA8hm1cACHz4FY7oK3o7EBhdlV4D9alnmLMNrxSaG9zSQ/LMzW24=
X-Gm-Gg: ASbGncsBkMLdPZL3l3iDvc45GTAMZN/C6kJ100LphtEx3ELQVYl67E3tHkErFprVMWz
 sYUIyxJSJG7AT9fx1Ylu5n33+97g/fSziifeR4z7JaKzvR8JxBtCyTX5dzoI5R62q1EdzuulBUz
 dmwjr7t5Ap93Rjja8GdXW2Ev+E5iW+/8bbQO9xv8dCFDXitp4DRzJJYvdvVZ6RfxZ3JtpKE/M7n
 C9FFCDxxRhHXZbz34XQxn2fjFnG+Q9CraPHF1Bt2mA21bLIODvsbpa9Nw==
X-Google-Smtp-Source: AGHT+IGQisA+z4BIhJRsESo/raoOGFgq5RnEDzePYyBpUbHmxWjHgBPGi1FHAIPq1nyDrCfqzEMJEg==
X-Received: by 2002:a05:622a:1a8d:b0:467:8378:9e8 with SMTP id
 d75a77b69052e-46a4a8cdddemr591078911cf.17.1735490158339; 
 Sun, 29 Dec 2024 08:35:58 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb30b97sm98210171cf.86.2024.12.29.08.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2024 08:35:56 -0800 (PST)
Date: Sun, 29 Dec 2024 10:35:52 -0600
From: Tom Rini <trini@konsulko.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>, "marex@denx.de" <marex@denx.de>,
 "Simek, Michal" <michal.simek@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "william.zhang@broadcom.com" <william.zhang@broadcom.com>,
 "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Message-ID: <20241229163552.GA3476@bill-the-cat>
References: <20241227044934.2109997-1-venkatesh.abbarapu@amd.com>
 <20241227182306.GE1505244@bill-the-cat>
 <SA1PR12MB869745E73B63621C18E0E4D6980F2@SA1PR12MB8697.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+5SMAfZw67wzVuSp"
Content-Disposition: inline
In-Reply-To: <SA1PR12MB869745E73B63621C18E0E4D6980F2@SA1PR12MB8697.namprd12.prod.outlook.com>
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


--+5SMAfZw67wzVuSp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 04:29:39AM +0000, Abbarapu, Venkatesh wrote:
> Hi Tom,
>=20
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Friday, December 27, 2024 11:53 PM
> > To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> > Cc: u-boot@lists.denx.de; tudor.ambarus@linaro.org; j-humphreys@ti.com;
> > marex@denx.de; Simek, Michal <michal.simek@amd.com>;
> > jagan@amarulasolutions.com; vigneshr@ti.com; u-kumar1@ti.com;
> > seanga2@gmail.com; caleb.connolly@linaro.org; sjg@chromium.org;
> > william.zhang@broadcom.com; stefan_b@posteo.net; quentin.schulz@cherry.=
de;
> > Takahiro.Kuwano@infineon.com; p-mantena@ti.com; git (AMD-Xilinx)
> > <git@amd.com>
> > Subject: Re: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when config
> > SPI_STACKED_PARALLEL is enabled
> >=20
> > On Fri, Dec 27, 2024 at 10:19:34AM +0530, Venkatesh Yadav Abbarapu wrot=
e:
> >=20
> > > Update the spi_nor_read() function based on the config SPI_FLASH_BAR
> > > and update the length and bank calculation by spliting the memory of
> > > 16MB size banks only when the address width is 3byte.
> > > Fix the read issue for 4byte address width by passing the entire
> > > length to the read function. Also update the size when the
> > > configuration is stacked.
> > >
> > > Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories
> > > support")
> > > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> >=20
> > I don't think you've run this through CI?
> > https://source.denx.de/u-boot/u-boot/-/jobs/984698#L289 and similar on =
all sandbox
> > targets, and Azure shows it too.
> >=20
>=20
> Ok...Could you please run the CI on the "v3 patch" once, as this patch is=
 entirely separated the parallel code with the default one.
>=20
> [PATCH v3] mtd: spi-nor: Fix the spi_nor_read() when config SPI_STACKED_P=
ARALLEL is enabled

Yes, v3 passes CI. Does the help with what you need to do for v6 then?

--=20
Tom

--+5SMAfZw67wzVuSp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdxemQACgkQFHw5/5Y0
tywHlwv6AwgypCPGTKtkejCleeDxMsYOXGrwu0D2cYgCNmTdY9bAS8VDSMq+W8F7
jgoyHgJpxZ28tHrw4EilCqKBIORs8L2SSELevCkjeEcqxgeoR+TrNO6TfttQFc2A
qNksoiXFC/FahXAqEYzKGsZZVofE7sJVx1GSkk1t58zxajp2QTqiXifzj0bxa3NT
DddEtgdC0IcTf9wea3nHP+aYtkGzUDS/YoLAMTxJ9gNxhWjA1qOnNtFboUUa6nci
5lCb+oTcWBGXoAAIlL5PkUt0fscCBaJg/aLgOifYnhOZzWBbmBsmt+H6hzE2X6+T
OHmqpn732JHMz4YSF5wjnna2s2FCBqdXtaulArmS+TwK+VJf0EOu943ck9WSWxf4
8c57JfGXFoOtVqEsRhPFiWoCi/d3eJiD0kKws9BFP4UoJnCCBtbBGWeYVLFkg/0V
2rec8sMJHuUeZBOhDRUTHO5BQ5Q/LAYkp0z5FPisfpRFrhWWnJdM5/7k2wFHnA/x
p3vGOnnr
=dD3K
-----END PGP SIGNATURE-----

--+5SMAfZw67wzVuSp--
