Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6874FCDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 16:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DDE86DED;
	Fri, 20 Oct 2023 18:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OspoaagF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E25E86E5A; Fri, 20 Oct 2023 18:55:16 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F9F86CEC
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 18:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7af52ee31so11285857b3.2
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697820912; x=1698425712; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C8aZ7RkChN1jgysMc5emhY7+gFu1DmUuEsdj5wGz8Vg=;
 b=OspoaagFOUGG6Y+s6Z3i756vqMGS/ANYnr2ungF6j0V5btEiQeTIp79qov4avZeGCG
 vjQk7sSlF0ugc93Rp4pxba3CFZKOP20nRt0k61SyKFrgaxI/eQ1a4p6sRk5DljYm/Tew
 e4NzpZ0/n3kYQ19pXJcHu1uiI+I9jf/SJqhUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697820912; x=1698425712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8aZ7RkChN1jgysMc5emhY7+gFu1DmUuEsdj5wGz8Vg=;
 b=qMD50lGTXZ1tdxYds6U/Us4G0ngmshoB1vAgn+ovwSb1iWgvS+YOeeGGqtm0PPA1LU
 7XBBF9Z946NKr6cCGidP1khsD0wksrhu6qgjOudVAzyhHWSLOVK7GpGwTC7q0jfCfVfT
 +XrYhnbCLe+hXDCyp8ttgGCjOTi9ibMtVbGFaORoXQc0J5MmkEwRc2gm34Hq8JkqkEs6
 1+cHB+nI3HxBxNIVBNlcr5t0VKjWeEUx79PmvfFD3vHvNfvUUaKpJhsxqxQwjbLCN8Gr
 cDwikqW5jaY4xykV+kzpGT+N6FotvPLKkUnCB4SIafyJH+pbgYcvo8fcb9ah3xmICy5j
 tv9g==
X-Gm-Message-State: AOJu0YzmSH2S1afSxKzDc/DsuVmOWiuJK4AemIKXND9gfyJbvQX8gKff
 wH2e+bArpCQT7OLYnRr0GDNrZA==
X-Google-Smtp-Source: AGHT+IEBezHNViKLknKGPMEFXRX2qrqpgZINoKiqSdwePaqxdxZStKJAM5dGx+MgQ3cjzwdp3qSepg==
X-Received: by 2002:a05:690c:85:b0:5a7:bc5d:125e with SMTP id
 be5-20020a05690c008500b005a7bc5d125emr2973941ywb.38.1697820912614; 
 Fri, 20 Oct 2023 09:55:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c3-20020a814e03000000b0059f4f30a32bsm814189ywb.24.2023.10.20.09.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 09:55:12 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:55:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20231020165510.GM3119521@bill-the-cat>
References: <f84925f4-9c3f-4901-902c-49bb10a10765@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A00qxSpi9UJAdpHP"
Content-Disposition: inline
In-Reply-To: <f84925f4-9c3f-4901-902c-49bb10a10765@denx.de>
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


--A00qxSpi9UJAdpHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 02:51:08PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull this next small batch of Marvell related patches:
>=20

After dropping the page table size patch (per other discussions),
applied to u-boot/master, thanks!

--=20
Tom

--A00qxSpi9UJAdpHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUysO4ACgkQFHw5/5Y0
tyxXMAv/bse6cSQGz5Nq5B1rl4F+yxQdLJArS/5qyGmgLoWIh7WxwAz58B/j9paG
m5X/YZUgtUgbo7ASE9RcmdslWzRkZ+2vq0EJSAuTMPiv8Q1T0aw+Cbp6XaMipmNk
3xFwjR0BuOUVqLgDEtf4xr1gOBFyjN6ki1l2GP0IaLdRwH+Ya0jfw96ENegaOLF/
BF4pyaxaNHo0nHWkDFS1rhO7c1qFDiIsVggGgVvu5pRLOFEBey6gO7QBL58uTnez
v24R3XkaNEryq/RBCmrKxkd6RwG8Q6bvSys27HeRfi0+aoQuE7D1SIMppJ6qx7AK
KjwXguNUEl9C4MtNlZFCedeM/KVuJfLVKjQ3B3y9ej8+Kjh7io2ANQO3UDhbkAQs
8KA8HRvAaXgDxfpmly4eF1IpSw7uMKNiJYVKi1BK2bN+jBtbqvIircfgaYxp2SuC
CkExf+1AyUd77KCvHh/UrWeL0AJgN9t6rPnKsLUOvdu5J8t8aXerYyGnOc9tA18O
5WntvT+L
=HKlD
-----END PGP SIGNATURE-----

--A00qxSpi9UJAdpHP--
