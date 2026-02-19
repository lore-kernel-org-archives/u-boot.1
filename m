Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C160E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB73F83DBF;
	Thu, 19 Feb 2026 14:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rF4iAK4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F9B83DEA; Thu, 19 Feb 2026 14:28:54 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89EE83D8A
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2BD2A4E4023E;
 Thu, 19 Feb 2026 13:28:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E6DEA5FB45;
 Thu, 19 Feb 2026 13:28:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4E4BD102F18FC; Thu, 19 Feb 2026 14:28:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771507730; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Q1dd2b2tcsvVlIT6toqmwPIRsZIb41C/TtQare/3EGk=;
 b=rF4iAK4YJTpKNSxcjxTjNDAR97VdDT4DsC8ooqQOgWf7wXSdtIO8dxBKw1TiHGyF7Ek1O/
 VeSbDhjfk7rrNVfyLdLoRXl8kXEwz2t5yfFvQa2dOYBe9dJ5iTCuExjrrdwRgeJnzzeaZG
 pb/sydI3rQt/O+Dz3a8iV1fsPFBKWju0coam1N5EnnDTdg0cmeRiQC5aCVkont8OpF2FsI
 Oo/w9o/acFt7Wj14TsCghdpgQIaVamBPYsndrh/iwonV9qKHXDaxEZNzgg2aN+PQnAMBlz
 bDdQomjd2+sFrhGynkKJnuFOlOsrSCnjXUUwzHNyK62xvDzegSUzGqyhwOaRDA==
Date: Thu, 19 Feb 2026 14:28:48 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: =?UTF-8?B?U8OpYmFzdGllbg==?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Peng Fan
 <peng.fan@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, Julien
 Boibessot <julien.boibessot@armadeus.com>
Subject: Re: [PATCH 0/2] serial: lpuart: fix RXFE filed offset and handle
 Overrun flag
Message-ID: <20260219142848.266d6edb@kmaincent-XPS-13-7390>
In-Reply-To: <20260218-lpuart-fix-rxfe-offset-v1-0-86a78b224f13@armadeus.com>
References: <20260218-lpuart-fix-rxfe-offset-v1-0-86a78b224f13@armadeus.com>
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

On Wed, 18 Feb 2026 15:59:17 +0100
S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com> wrote:

> This couple patches fixes the RXFE filed offset on i.MX9 platforms and ha=
ndle
> the Overrun flag which can prevent user from accessing the U-Boot prompt.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
