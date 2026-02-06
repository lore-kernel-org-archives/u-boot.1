Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0716FEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 14:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D12A83AAD;
	Fri,  6 Feb 2026 15:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NxmzK0xE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F3383B8F; Fri,  6 Feb 2026 15:20:34 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D92838FA
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 15:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 34E9A4E4243B;
 Fri,  6 Feb 2026 14:20:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 052C160729;
 Fri,  6 Feb 2026 14:20:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3AFFA119D1EC5; Fri,  6 Feb 2026 15:20:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1770387630; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2CkhJ+udkIaSsU0Pk9vTBGrUYnYs2M+dGHKlvfOVpKM=;
 b=NxmzK0xEWoL2k6Tx0UBqYUES4vXFCwL/eFf0MeD8b5/MmX+XlwrFUhW5qMY4+/5FdaOOQ9
 OUy9JMwjHU+yNmwluLe/MtNXwYbkH2mGHGNpf4Mz7qggTa6WnrNV3ywVisTrqQbTj1VtdK
 g+Y5brC8a3e0dEnPVCm/LeAfCrGaNoaO4SKClY2/gPKW4jDofSA+/lsBSpfD6z2+Fg/t1T
 ss+F8a32PHxWB+lJDqDp3Y2p0yc/ZkVS/3MDW6X1IvTYTZeecjT6mlaHo5zWaG7cu87sdi
 MO3NMy4DSbFK11e+NnyKw2c+bcZRSwIJJaN/JAcQLtcVXOvT00SLE26QMpbwvA==
Date: Fri, 6 Feb 2026 15:20:27 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Michal Simek
 <michal.simek@amd.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, Simon
 Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 0/2] fwu: Mark failed bank as invalid during rollback
Message-ID: <20260206152027.1c371812@kmaincent-XPS-13-7390>
In-Reply-To: <20260119160746.1330877-1-kory.maincent@bootlin.com>
References: <20260119160746.1330877-1-kory.maincent@bootlin.com>
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

On Mon, 19 Jan 2026 17:07:40 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> This series improves the FWU (Firmware Update) subsystem's handling of
> boot failures by properly marking failed banks as invalid during rollback.
>=20
> Patch 1 refactors fwu_state_machine_updates() to use an enum instead of
> a boolean, adding support for FWU_BANK_INVALID state.
>=20
> Patch 2 detects rollback at boot time (when boot_idx !=3D active_idx) and
> marks the failed bank as invalid to prevent future boot attempts.

Hello,

Any news on this series? Does something prevent it to be merged?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
