Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411E9CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 06:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC22838BB;
	Wed, 13 May 2026 08:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="u7vrIP16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDE083E36; Wed, 13 May 2026 08:40:49 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E628D8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 08:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id D0F73206DE;
 Wed, 13 May 2026 08:40:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1778654447;
 bh=Y0UG3FxnbehtqwpGEE4o2cYfKfgPK5RVXx2mt3iZASU=; h=From:To:Subject;
 b=u7vrIP1664yxqz7kr6DKzMoaclvm7d2WkgeWmv2XMLA7d4XZerIiQTTJTWHHDue/h
 YL0uwe12uro3Oc3fVBgMiWk1hkaAR+isCvOEA8XO4TWEIQMVAZtndM1x2PYImTZX49
 /2ByN0R/Q4xSa4r+5u9Mj2Qy0xo/R4ppAb3vi4giXjejKZHuUKCOJmaBH3UsGzj85v
 5b/fU3qgHrsyJ6SLhS7ilxg7IzXWvyEgrULrcF64fceFxYwGBdm6ysMhl2/oaOMJIE
 +6CxIPhJyoV7r+JVmlbjtIIbtY0Io2fqfUQAN5nzxv06FPoIn5oE0zyGSaAaVAeUG3
 svDZdXe/RrJJA==
Date: Wed, 13 May 2026 08:40:45 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, Franz Schnyder <fra.schnyder@gmail.com>,
 trini@konsulko.com, "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v4] tools: mkeficapsule: Rework pkcs11 support
Message-ID: <20260513064045.GB15116@francesco-nb>
References: <20260513044537.22773-1-Wojciech.Dubowik@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513044537.22773-1-Wojciech.Dubowik@mt.com>
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

Hello Wojciech

On Wed, May 13, 2026 at 06:45:35AM +0200, Wojciech Dubowik wrote:
> Some distros like OpenEmbedded are using gnutls library
> without pkcs11 support and linking of mkeficapsule will fail.

In the meantime, OE core enabled pkcs11 support (in master and wrynose
branches). Just for the record and for having complete and correct
information.

commit e9f12f64279c ("gnutls: Add p11-kit for native builds")

This patch probably makes sense in any case.

Francesco

