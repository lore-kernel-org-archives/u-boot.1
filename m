Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C94CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EBB8363D;
	Wed, 22 Oct 2025 17:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="g1scmea/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B5078363D; Wed, 22 Oct 2025 17:24:41 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388F680422
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 17:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 156A7C0AFF6;
 Wed, 22 Oct 2025 15:24:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D4133606DC;
 Wed, 22 Oct 2025 15:24:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 43C24102F23AD; 
 Wed, 22 Oct 2025 17:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761146678; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nfQwfq3MB8mN3/Hxa/j4cal3aU8KtFrNaNtW5fuJamU=;
 b=g1scmea/pm1brGpSi3l9VQ8WCgt+827U8jRslXn4BYtNpyVjpYNZf4lXTj2cQwbYNBVNW2
 wq+WdGHgfHNJRO6wJwqJAsrGV95/8c2YP2qD3MnUbT3UKTuLDcxWNr96RPyq0TTdtAzW7p
 KTKyxvliF2IxtRhqoRzDLFIPDbIFTSepFmO92CbbpL8L+nyKyL/FZmrUPj/oAgHLvQG2xJ
 CuK45Wf9RQ0IOdxlc8EYTOihdwVPnr2s3L6jKMzOFh/ihN6rCkmZFBEDM8SBSdhKGfDdkb
 pHOeJVDDUgrX1iQ/xjZV9pVeuk+kH1WDSxuaQB1B5GmA2eQoe2KroKh6z1uRBQ==
Date: Wed, 22 Oct 2025 17:24:35 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Jagan
 Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 14/20] board: sandbox: Convert extension support to
 UCLASS framework
Message-ID: <20251022172435.76b1d03a@kmaincent-XPS-13-7390>
In-Reply-To: <20251022-feature_sysboot_extension_board-v4-14-d24b5ef7b468@bootlin.com>
References: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
 <20251022-feature_sysboot_extension_board-v4-14-d24b5ef7b468@bootlin.com>
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

On Wed, 22 Oct 2025 17:20:25 +0200
"Kory Maincent (TI.com)" <kory.maincent@bootlin.com> wrote:

> Migrate sandbox extension board detection from legacy implementation to
> the new UCLASS-based extension board framework.
>=20
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>

Forgot to add:
Reviewed-by: Simon Glass <sjg@chromium.org>
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
