Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1CAE69173
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 16:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F928985B;
	Fri, 22 Nov 2024 17:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8088985E; Fri, 22 Nov 2024 17:06:25 +0100 (CET)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E085489850
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 17:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id B79702BFA41;
 Fri, 22 Nov 2024 17:06:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id crd4qJ2hcym4; Fri, 22 Nov 2024 17:06:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 50F8E2BFA25;
 Fri, 22 Nov 2024 17:06:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id FOpTOAinhYnD; Fri, 22 Nov 2024 17:06:21 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 by lithops.sigma-star.at (Postfix) with ESMTP id 30ECA2A881A;
 Fri, 22 Nov 2024 17:06:21 +0100 (CET)
Date: Fri, 22 Nov 2024 17:06:21 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Message-ID: <1630220217.57337239.1732291581112.JavaMail.zimbra@nod.at>
In-Reply-To: <20241121223217.330117-4-sjg@chromium.org>
References: <20241121223217.330117-1-sjg@chromium.org>
 <20241121223217.330117-4-sjg@chromium.org>
Subject: Re: [PATCH v2 3/8] test_ut: Add an image size to setup_image()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF132
 (Linux)/8.8.12_GA_3809)
Thread-Topic: test_ut: Add an image size to setup_image()
Thread-Index: aXsI37QWm4R3z8x0DTlRjqEjJi8NQg==
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Simon Glass" <sjg@chromium.org>
> An: "u-boot" <u-boot@lists.denx.de>
> CC: "Tom Rini" <trini@konsulko.com>, "richard" <richard@nod.at>, "Simon G=
lass" <sjg@chromium.org>, "Francis Laniel"
> <francis.laniel@amarulasolutions.com>, "Guillaume La Roque" <glaroque@bay=
libre.com>, "Mattijs Korpershoek"
> <mkorpershoek@baylibre.com>
> Gesendet: Donnerstag, 21. November 2024 23:32:09
> Betreff: [PATCH v2 3/8] test_ut: Add an image size to setup_image()

> Add a parameter to indicate the size of the image to build.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Richard Weinberger <richard@nod.at>

This SoB chain is odd.
I think "Co-developed-by: Richard Weinberger <richard@nod.at>" is more corr=
ect.
Same for 7/8.

Thanks,
//richard
