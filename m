Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8754BC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34791876CF;
	Thu, 21 Dec 2023 22:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k9OQvJF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C0B6876D0; Thu, 21 Dec 2023 22:07:16 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6AF869B6
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42795ea3e35so8177531cf.2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703192833; x=1703797633; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=okZwMN6paKeoUq4c/Qsqx9e0JONa/kTR/liZ6B+NfOg=;
 b=k9OQvJF7JvyfYaRUm01LvgjNS6JRAMElvl2Twaintt2nN0Ixh8PNJeIswqdtM91Yly
 cNuxMLek9nyIFtVzJnGvmZFrDr5e5f+phFjocNyLSAlgGYXlyTOlbWH/3D3zV83vwlx6
 68YPaocE5+1xNfGcomKTOFUNS5Nqwtemmb/64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703192833; x=1703797633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okZwMN6paKeoUq4c/Qsqx9e0JONa/kTR/liZ6B+NfOg=;
 b=tpS3dFEXmdmivc23AZ2XanVU+A781UxoQHbIAbzKAkDKS2mmE3T991rJ0hToJOK2WD
 0/qVSufXM5tpRIDdiaqkbq+4m55Hv3f63OF1OFa1vyv6HST7n7ak+6UJlg3pIhl/DvXK
 AVCrF+EDM+y6oPVCJv8UnMD18J+GD17zqAFsGCmpvd+eTAIioy9isKu3o4tyLBIXfvEE
 keQAgnvulFQsI/zNxgtmMS0MoC8ja75HGynmR25XauPc2JexSgxslK2ec0Tabj4w39Dx
 NxnOCKf9hbXaLmk4TOlLWt4woduqG7QApuzSO9TevWfIIf6ZUp7Rfi9fsTmandDAFFk7
 dgiw==
X-Gm-Message-State: AOJu0YwRq8Yw3AEnGaR5LnZRdyxu3cpKwZkFTthUAJoYG9HLcijpYiY1
 KQojJTx80j3kx/uhuUW7zurZWFSFDSdKMA==
X-Google-Smtp-Source: AGHT+IE5nUZmhxkjOTOWyoo/3per5E0mgI+6L4i066rXDItlb09+n/Ah9s1gt6veXxa9y9RwtTRfdg==
X-Received: by 2002:a05:622a:1715:b0:41c:ad7f:5720 with SMTP id
 h21-20020a05622a171500b0041cad7f5720mr474324qtk.61.1703192833332; 
 Thu, 21 Dec 2023 13:07:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 do14-20020a05622a478e00b00423e8909bfesm1155092qtb.6.2023.12.21.13.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 13:07:12 -0800 (PST)
Date: Thu, 21 Dec 2023 16:07:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] iommu: fix compilation when CONFIG_PCI disabled
Message-ID: <20231221210711.GR2513409@bill-the-cat>
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
 <20231211-b4-dwc3-qcom-v1-1-46275113b4f2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OicxHPso5FF3BYG5"
Content-Disposition: inline
In-Reply-To: <20231211-b4-dwc3-qcom-v1-1-46275113b4f2@linaro.org>
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


--OicxHPso5FF3BYG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 06:41:40PM +0000, Caleb Connolly wrote:

> The dev_pci_iommu_enable() function is only available when CONFIG_PCI is
> enabled, replace the runtime check with a preprocessor one to fix
> compilation with pci disabled.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--OicxHPso5FF3BYG5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEqP8ACgkQFHw5/5Y0
tyxkXwv/ZkPWtPdK6hgRvZHSllB7EMpRvzcD3OsUyfKhS2TJkVdxIT4P+LiLVwME
nmrkierY90pF4fWkV9Gs3NQAQX/QguF+2CWGrhBaofBlnVlfQj55k1WR0nxyRfV2
ELW7Wl6zzvl3mf1TRk5I91/V+Y+d/WyQ5TWWYJFLC53QzOAwct3Cls+H94/7ZPVI
CrWvBzNUk0ZTBOdQbRcBmIiDqeS/xX5BPurgJDmUwV2v9vHz4F5i65UpwWMoJn15
7GEnc6ISHiAOgL8gANC6nEfkzOraBI5zRiHW9MZQJHivztrDePqo/KeGvjRZK8Oj
o1O3a0wUYSxvNSTbm5u1nethlgB/qjw/U77KsOvbU4jtBOUsG6U7eYKLlH5uOdzw
I7ZVSWoTDktSQwWu+qNQ7KIEcsR9KPDcuKVRCstOlJMfyJxzMx9oiKb3U/4DRhKo
+6ag7Prt5qAmRA2z/yAlZzVtedYntucpKruuXf/SKpoBmOn28DPYbxceB+E7B851
VH8YFESv
=UylF
-----END PGP SIGNATURE-----

--OicxHPso5FF3BYG5--
