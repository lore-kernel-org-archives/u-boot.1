Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8B5CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C434848BA;
	Wed, 10 Jun 2026 14:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UY5/aN4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBF58467E; Wed, 10 Jun 2026 14:21:43 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CEDC848A1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gb4dX41Wdz9vHM;
 Wed, 10 Jun 2026 14:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=No9CyWpLQOBrPV60w+Y8pDbiHTDn8YVhwnmbsWxp2Cs=;
 b=UY5/aN4pojc2O/7JqTPPQAyKnRP9LsJdcVnxTptL3C42pcySLPMTGWy9npzrkS2x1Es3DL
 f34cZQAYOpnaDy5HGfSjY97zMRpAiTeXzs7iDhQ2WyGHx1abqo7fPSGbuZ46UP58TXK0SB
 LKQgDoup9chK6hBfhxrsewYCBoLDWF/trZ5TGHDq7yu4DUkVaTtxDE6SgZLHmZi1ssjC8y
 6qto0pjv+ptcaQm4LyfUwGMH6GCW8GXT6+I2nCvEKEr4D+qcwSGKNNMcYpAv3mL9QWloHM
 /jZg9THtPQWoIBPj05eBkwIW23fYIxx9aGvO92B18UlB/ayjLdhItkvLsS6E8w==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Vincent Jardin <vjardin@free.fr>,
	u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com,
 seanga2@gmail.com, sjg@chromium.org
Subject: Re: [PATCH] net: mvpp2: fix NULL pointer dereference in
 mvpp2_phy_connect
Date: Wed, 10 Jun 2026 14:21:18 +0200
Message-ID: <20260610122132.2674311-2-stefan.roese@mailbox.org>
In-Reply-To: <20251216005352.92277-1-vjardin@free.fr>
References: <20251216005352.92277-1-vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kyia8esetszt5mi7rjbgqcfds7ytwygw
X-MBO-RS-ID: 5ce5328b42f0b57b9ef
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

On 12/16/25 01:53, Vincent Jardin wrote:

> Fix two NULL pointer dereferences in mvpp2_phy_connect():
>
> 1. port->phy_dev->dev is used in dev_warn() but
>    port->phy_dev is not assigned yet (assigned later at line below).
>
> 2. port->phy_dev->dev is used in dev_err() inside
>    the "if (!phy_dev)" block, which means phy_dev is NULL.
>
> Both cases would cause a crash if the PHY detection fails or returns
> a generic PHY. Use the already available 'dev' parameter instead.
>
> Fixes: 9db60ee470c2 ("net: mvpp2: Convert netdev_xxx to dev_xxx")
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Applied to u-boot-marvell/next

Thanks,
Stefan
