Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F837CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 15:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E435833E9;
	Mon, 29 Sep 2025 17:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TZSFfH7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4671B8341C; Mon, 29 Sep 2025 17:09:27 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77920832C8
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 17:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 17F4E1A0FAE;
 Mon, 29 Sep 2025 15:09:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D56D6606AE;
 Mon, 29 Sep 2025 15:09:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D5FB9102F16F4; 
 Mon, 29 Sep 2025 17:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759158563; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=lTD18vd2Pbp/DP+emuLeju/kvkOcELPvR0FpifC1yNc=;
 b=TZSFfH7Jh7on5jx/75At2rJa03Zpei54djtI0bw/oxAudM5TF7ivekIHPexHPslvGFQkFX
 0d3dz43QCUBofV4TryKpXzPm1HYeALQ5diNpT0SQY9gHbj76+2c/RpinuS54s+Z8t4eKR/
 hCoMcKTSrfkDDDWfNopbRW/hxSLFY4F/k0NGm7uM9nMe8M8I6cN6HDUFqwxw2qNOKpjiTc
 6ObPkoc6zS2Ix0LIvp+aR5nMMTAQuMf2pOyeKe+NmctF2kBtUlrZ+wcXODThZnJbL0xi0e
 QSedOei6N0uIsN71TNUnzVD4+bbQOTRqXNwhwDnYouId94HbstuMSo6V+eiJPw==
Date: Mon, 29 Sep 2025 17:09:12 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] Revert "board: st: stm32mp1: Clean env_get_location()"
Message-ID: <20250929170912.3bee3f9d@kmaincent-XPS-13-7390>
In-Reply-To: <55d0805b-dcb2-4277-a4da-f4c26b48a2dd@foss.st.com>
References: <20250917141736.59732-1-kory.maincent@bootlin.com>
 <55d0805b-dcb2-4277-a4da-f4c26b48a2dd@foss.st.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 18 Sep 2025 16:16:35 +0200
Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:

> On 9/17/25 16:17, Kory Maincent wrote:
> > This reverts commit d37641c61ba212241c38e3fd22f0335fc0bebc96.
> >=20
> > Restore support for environment storage in EXT4 filesystem on eMMC boot.
> > The previous cleanup incorrectly removed this fallback option which is
> > needed for boards that store their environment in an EXT4 partition.
> >=20
> > This configuration is OS-specific rather than board-dependent and should
> > remain as it is configurable via menuconfig. Even if it is not described
> > in ST defconfigs people may have enabled it in their defconfig.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Hello,

Any news from the maintainers? Is there a reason for not being merge?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
