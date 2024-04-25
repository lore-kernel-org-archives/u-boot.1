Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF03C10F1A
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 07:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7894888F0B;
	Thu, 25 Apr 2024 09:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="R+MIOBnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9810088F11; Thu, 25 Apr 2024 09:52:39 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A204D88F0C
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 09:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id D4A1E109;
 Thu, 25 Apr 2024 09:52:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1714031556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=FIsn9QrdcnuxXsiHo1gq8RFsEM13ahz9WIN/K7Zd9o8=;
 b=R+MIOBnLsOi3pmSBCRBLQoNpQf7PSaBNxri8DLRAqV1k8ZX5LkOEI8JPMDBFAPYayx6Oe+
 7UgKHW3+cIEhVEvhb8m+9d9goRnudpwBlSuoFxevwUHq+2zOGeQNewszpvapFD2TLc9O8X
 8BIzWiln73JeeF06NfYZxKk37AuGDWxOwASGIshaFbI0X/6M4+Ofn24s1EGzE9oH5SyoYD
 fslvVhiHGzZBVKqc6j//Z63Zlpx7H6U11PvYTDEf0ifx72gXpAR6cPLSlKD6f6BDjRs5bL
 G86SgrZkytU2JpgBxW8vz2Cfn6PhdT4TTLwu/9jDXDOwN64bhaYL+dNqjX9O5w==
Content-Type: multipart/signed;
 boundary=741d942a38e8194029a91d31f320dc294341270b6abbd23dc66197ab6cd9;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 25 Apr 2024 09:52:28 +0200
Message-Id: <D0T1H31G99ZV.1I8SXBRR91ECR@walle.cc>
Subject: Re: Capsule GUIDs and LVFS
Cc: "Jagan Teki" <jagan@amarulasolutions.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "FUKAUMI Naoki" <naoki@radxa.com>,
 <chris.obbard@collabora.com>, "Paul Liu" <paul.liu@linaro.org>, "Heiko
 Thiery" <heiko.thiery@gmail.com>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Masahisa Kojima"
 <kojima.masahisa@socionext.com>, "Patrick DELAUNAY"
 <patrick.delaunay@foss.st.com>, "U-Boot STM32"
 <uboot-stm32@st-md-mailman.stormreply.com>, "Michal Simek"
 <michal.simek@amd.com>
From: "Michael Walle" <michael@walle.cc>
To: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "U-Boot Mailing List"
 <u-boot@lists.denx.de>, "Tom Rini" <trini@konsulko.com>, "Richard Hughes"
 <hughsient@gmail.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>
X-Mailer: aerc 0.16.0
References: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
In-Reply-To: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
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

--741d942a38e8194029a91d31f320dc294341270b6abbd23dc66197ab6cd9
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Apr 25, 2024 at 8:19 AM CEST, Ilias Apalodimas wrote:
> I've cc'ed all the people I could find in board specific MAINTAINER files=
.
> Can you respond to Richard with the proper company name & board name
> so we can bind the following GUIDs to a vendor properly?
> Richard any guidance on how this should be done properly is
> appreciated, since I am not too aware of LVFS internals.

Thanks for taking care!

> Kontron KONTRON_PITX_IMX8M_FIT_IMAGE_GUID c898e959-5b1f-4e6d-88e0-40d45cc=
a1399

This (board) should likely be dropped to lower maintenance burden as
it is EOL and "not recommended for new designs".

> Kontron KONTRON_SL_MX8MM_FIT_IMAGE_GUID d488e45a-4929-4b55-8c14-86cea2cd6=
629

This is probably (at least) the wrong name. SL is a
System-on-Module, a small PCB that will be soldered on a carrier
board and cannot run on it's own and a customer using that SoM will
likely have their own bootloader. There is, though the "BL" which is
the in-house board for this SoM.

Company name is "Kontron Electronics GmbH".

> Kontron KONTRON_SL28_FIT_IMAGE_GUID 86ebd44f-feb8-466f-8bb8-890618456d8b

Company name is "Kontron Europe GmbH".

Both entities belong to the Kontron Group, not sure how this is
handled in LVFS though.

-michael

--741d942a38e8194029a91d31f320dc294341270b6abbd23dc66197ab6cd9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZioLvREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+E9MAYDQM+Pw5Zk7pl+wZBQSLolTYenKNOvIQYhy
JIx00cdCoLAzaYPJE8XIc3ZlCuCxwBIBf2gNeqS2eGt6p7dzvSpJZHX/7rJYSMOm
1jzDWqOW9YNsecZL2yWcDYXT5rnaVXBl7g==
=uWNl
-----END PGP SIGNATURE-----

--741d942a38e8194029a91d31f320dc294341270b6abbd23dc66197ab6cd9--
