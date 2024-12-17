Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0244E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 15:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B600801CE;
	Tue, 17 Dec 2024 16:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HNKYgvj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FD1801FB; Tue, 17 Dec 2024 16:55:21 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FF6E80107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 16:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-467b086e0easo21383441cf.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 07:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734450918; x=1735055718; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6qAexMBj9xHHj3KuceLkfUhBSKWLhKn92GZaT50y88E=;
 b=HNKYgvj/2/n8CIE74AgBsmV26+6eirtoQco+kHSsgj2xGYJcTlGqQG6lggKx2DuWbM
 Rhr13Dl/ucsUdp3JQGumQ7mb+IdOf1HD3Ce8mHx3/5MQnhGfJLk7ijSZl5qPeUXgkC0U
 /y3n2zhOY3NzFtSGpPcssPLAfWL7XynOA7eHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734450918; x=1735055718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qAexMBj9xHHj3KuceLkfUhBSKWLhKn92GZaT50y88E=;
 b=lpz/vfi9Ivu/laMP7HMTLj9sKsKMSd22/i5/uYNvpJQtSAMknUS+88/nMO+K9HpQsd
 1jLn94HqOes8BWtDa0Hsc3HB8wWqyt1n+1YjWNuGyvLsB6QpNykwAl3I4UXPLTaFiJS5
 1AzE9Mgw/4iMFXPBAuBHAYlAZi8Vc6rVsnOa3iZ94FlOk0LTtvJhBc12HzyV4Dg8a+JV
 /VQGOG/NXQWliJJARX5sDZ9xxMKZxC2gOerSLlBxD30SO9gDSXUHMhkBcHqosiALKuwc
 88rkcOYeuWMu9NeaNITmpHyRA5IWOB3NduqNkMeuv2bkRrUmyyf/x9aVH1+8ccEQaI2V
 t6bQ==
X-Gm-Message-State: AOJu0Yz9jk7CrSqUCe5LbETmG7MDapNFTg/jHC64hdB9aGmA9s+0Chqe
 v3VqnPR0/ohn5Q2qrQwIr+6PPbvMF5hTlsOS3w5uc/k/MTJFmwDf18FyWImlVmg=
X-Gm-Gg: ASbGncsCo+OjRS5ezvMq4/jzo0dkOPF7aKeSVEmd7+oBBrqmwnmRjuJhiecAvL3pf6u
 AU476vFPsrVUvPueuwVF0poBNjubmHPjCv4KySv8CgKPAChq+qf9X6XWr1ZUdtRGonbutHvmG76
 z6H7W+9YYAjKbX2mg7XASGBRfZ7TbIdsqQNwdMDUrH5ltZSmjjP8+nO51yW4v5MiJ2NHyLSWTdK
 kH4YJZHMQo1efAGunfDHrg9z1XcaKDWao4y20gtTLjYGHOjf623+SnF
X-Google-Smtp-Source: AGHT+IHhEck9gdyGb3y03FGtfgNnhUu1rGht2AheSovCe7R3cqS601D2XTQKoPCYVu54k/aO9lEU0Q==
X-Received: by 2002:a05:622a:52:b0:467:7eb6:a007 with SMTP id
 d75a77b69052e-467a5803adamr258796071cf.37.1734450918291; 
 Tue, 17 Dec 2024 07:55:18 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd22f175sm39949526d6.8.2024.12.17.07.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 07:55:17 -0800 (PST)
Date: Tue, 17 Dec 2024 09:55:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH 02/10] arm: dts: mt7629: fix sgmii clock selection for
 ethernet
Message-ID: <20241217155514.GO1505244@bill-the-cat>
References: <cover.1734406967.git.weijie.gao@mediatek.com>
 <0c13bda7a1809c7bc6a6782b4f942670a9ff10d1.1734406968.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9U7PhWb+Sb7N/qf8"
Content-Disposition: inline
In-Reply-To: <0c13bda7a1809c7bc6a6782b4f942670a9ff10d1.1734406968.git.weijie.gao@mediatek.com>
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


--9U7PhWb+Sb7N/qf8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 04:39:20PM +0800, Weijie Gao wrote:

> Setup correct parent of clock CLK_TOP_SGMII_REF_1_SEL to allow
> sgmiisys1 work correctly.
>=20
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  arch/arm/dts/mt7629.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

What is the plan for switching to OF_UPSTREAM? Thanks!

--=20
Tom

--9U7PhWb+Sb7N/qf8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdhnt8ACgkQFHw5/5Y0
tywNbQv/Q8g4ecrMqH0ACGBHGKKu2m7qjNuPN1FuZCZVqJWSdkJhoIWlk2A36lkq
BrNghd1Zh3aEG8Vk319TNnMsz0W9zjH1vQNlb+41K1/fs6gh+fMClQECYgjId+53
/DnKe1z0S3IN8N8s463o9A5F0w1U4R13tUh/YYb3L71bq93G3S2//+oCEE7y+DiD
ST1/XM6gGDS/1vfVBSgTGktjMdvv/p9ZymtLWagCgw95ypjhiUAmX4/VABqhy3gJ
Qo3hlVWesgis/DeQiLms5py9x7K4jDmB53OaUrL/V13Z26Sq3mB0x6NVyPDMsqRo
ni6GGDCczc17y0/mnkMUQMrPTgCxSpqFxgv1RizSbzZmFQYDBkCHuvMfa1ebNaD7
5B8iOoJ6vSGbr15vCjNFhA7avfUBoYD9fsYl2aOkZBagkY5G2Fe40lBwJ/OoP8kN
yjwIr+kzUC6xnBjNVUZvNXSBQPCBHypwyQytj7DJVtTrLtMXfQk1MCZcISHtU6jG
QQisnE6U
=4AIx
-----END PGP SIGNATURE-----

--9U7PhWb+Sb7N/qf8--
