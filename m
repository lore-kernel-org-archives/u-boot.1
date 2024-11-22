Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6186E6916C
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 16:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C06478985D;
	Fri, 22 Nov 2024 17:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D92D8985E; Fri, 22 Nov 2024 17:04:40 +0100 (CET)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 262A18985B
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 17:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id BA5832BFA25;
 Fri, 22 Nov 2024 17:04:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 3cjDBmgPyX9K; Fri, 22 Nov 2024 17:04:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 964B22BFA41;
 Fri, 22 Nov 2024 17:04:36 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 6UfdSJTScJnD; Fri, 22 Nov 2024 17:04:36 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 by lithops.sigma-star.at (Postfix) with ESMTP id 6A1022BFA25;
 Fri, 22 Nov 2024 17:04:36 +0100 (CET)
Date: Fri, 22 Nov 2024 17:04:36 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Message-ID: <1028678538.57337211.1732291476183.JavaMail.zimbra@nod.at>
In-Reply-To: <20241121223217.330117-1-sjg@chromium.org>
References: <20241121223217.330117-1-sjg@chromium.org>
Subject: Re: [PATCH v2 0/8] test: Avoid needing sudo for image-creation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF132
 (Linux)/8.8.12_GA_3809)
Thread-Topic: test: Avoid needing sudo for image-creation
Thread-Index: Sj2j8gl7DaRsZ1xQ1/QGZ/ixrNCYLA==
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

> This series rebases and tidies up a series sent by Richard Weinberger
> to use unpriviliged code to build the test images.
>=20
> Link: https://patchwork.ozlabs.org/project/uboot/list/?series=3D417786
>=20
> Changes in v2:
> - Fix a few pylint errors
> - Split out image-size patch and default to 20MB
> - Attempt to reduce the diff, for easier review
> - Add new patch to drop exception handling
> - Add new patch to use the built mkimage
> - Separate out patch to drop support for fallback files
> - Add patch to remove prepared images

Thanks a lot for finishing this!

Thanks,
//richard
