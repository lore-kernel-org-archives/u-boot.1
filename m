Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CFFC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 08:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 049BB8091A;
	Mon, 12 May 2025 10:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1747038350;
	bh=G5n6PxLhRqxatyVq87CLsL2Bq785cCb9S9ldu8NGSPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0CKpDS6X3G0OVlJDr6DFKjPqWX4oDXsZGeOmLoLEdMa7B63U48zr87cG0I5IaHME+
	 zFnoA+1WmZvLyzLvSszQM1wJusU9tiUyNJEvhZtlmMap91RcEop+8zNUu+e2k5a8D9
	 P4t96cG4lTQHh+SBronTFSI380D1KbltB56p1TJcLgpzgF7BiVM7Czt9x0xBcPssts
	 b04/AeNWlMvWkcBfxUklW5JOEzy8Y0rW8C9VG2Ub7fdbTj/fnMVJHNJx6iBZ4x18kv
	 i/L3JSYu8hLwcTlMeJpwRfjrojQDV6+ifC4A09bsKbKAUD2vN8GM2TYxxu2QEmzhTZ
	 v3sBaxD8YJANA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9753182162; Mon, 12 May 2025 10:25:48 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E45805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 10:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Ie/K6FbF"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B7E5101EC11B; 
 Mon, 12 May 2025 10:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1747038345; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=G5n6PxLhRqxatyVq87CLsL2Bq785cCb9S9ldu8NGSPM=;
 b=Ie/K6FbF0z7lEYVDxi8UM4k5pdLVj27C1IeNnWGU7I0Vacirx3d0QMXUK5rv7k/PxWaM6M
 asA2/eQ45uh6sV8A5hA6qMq2aKVykliD8HeCwQwXNohHXo192IZasU0UmrSEr6tT4UfLSS
 tfxxKKI3AiXyuiUY/iKKbTHPzB12pz3oCSiEJ7QbQ3FDp+Bch20XHqVNwOom/uia80+T7Q
 kc+44too/TtQjVhqo60m5cCkh7CXrzEOoOiSznRoMzRGUthuhgS0q15cJK3AeMBq3Cphf3
 lEQHDlxEktLwrbMKf6y03n/QA7lAMNfAJ33XexRxy1pOYgaI7NCcSI0PBkr4ZQ==
Date: Mon, 12 May 2025 10:25:42 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, uboot-stm32@st-md-mailman.stormreply.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] ARM: stm32mp: Correct sign extension for memory address
 in dram_bank_mmu_setup()
Message-ID: <20250512102542.5ff9f240@wsk>
In-Reply-To: <831cd958-018d-4f39-91ed-5a9c44853bc2@denx.de>
References: <20250510065256.267546-1-lukma@denx.de>
 <831cd958-018d-4f39-91ed-5a9c44853bc2@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WuTL9JMq5GSaWquHQ7Hykyn";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3
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

--Sig_/WuTL9JMq5GSaWquHQ7Hykyn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marek,

> On 5/10/25 8:52 AM, Lukasz Majewski wrote:
> > On a system based on stm32mp157c, with 1GiB SDRAM (starting from
> > 0xC0000000) and CONFIG_PHYS_64BIT enabled =20
>=20
> STM32MP15xx does not have 64bit PA range , why is CONFIG_PHYS_64BIT=20
> enabled ?

I've wrongly looked on defconfigs - Patrice has enabled
CONFIG_SYS_64BIT_LBA=3Dy, not PA 64 bit range...

It looks like I've prepared a fix for a problem, which I've created ...

Sorry for the fuzz - please drop this patch :-/

And of course thanks for pointing this out...

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/WuTL9JMq5GSaWquHQ7Hykyn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmghsIYACgkQAR8vZIA0
zr260gf+Jhw30Ilf4pnZId85yB34MvynLFsblaI+Fi6vWaUGtCvr11R7hnf4VIHP
AZIE3b6AAVyZYG4jTuouubo+hCvnOorWf/hpVOuLQjkbJ+Lv+J2dekJuZ3MG4Sug
H+ofKivOrlRd+zJmPbrywInWfg9jwRz0ipAsY5wh/QeN/syKS3iV5dfJY+Ky6aj9
2Xk+oLOBsySQUaA52JMqppPg0rHgVJPa5bdv6HC8oCGX8gZiJ02U2Dw8St4JoKxU
fYHpaz4Y/zbrKPMC4Qzl+Q4ne5rWlw3/5g658VB8p/xHehtAmI1Di3Q+L9BFLhOc
Atm7KJ7o3sAxFVw5WTKuxCW5o3XaeA==
=5zve
-----END PGP SIGNATURE-----

--Sig_/WuTL9JMq5GSaWquHQ7Hykyn--
