Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9947BCD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 15:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6198487C;
	Wed, 20 May 2026 17:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="m3u5lNFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18DDC8488F; Wed, 20 May 2026 17:38:16 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F253B846E7
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 17:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-33-41-61.ip42.fastwebnet.it [93.33.41.61])
 by mail11.truemail.it (Postfix) with ESMTPA id DA8DB1FD29;
 Wed, 20 May 2026 17:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1779291493;
 bh=9XvKyokiVA/IpedSTsxjVCyNnFZD+HcoeHh/3CL90c8=; h=From:To:Subject;
 b=m3u5lNFKdiRM94pJ9lD7k0TMrAww2bUPzgULihD9sxYtBY2yMb1SiDBbuQztI9BKS
 oUxtpJ+CHq6O7d+pifvn8xPdm7mJAGe7ZbDf8AF6xmVPxpLgtjq5Cw2lzKL1+Gmrnp
 1HTN8E/nxofPJ2Xku+FpSmySHggvvvIoxx3+3fNAuE8djf/fidhr1YIOMeBRpI/Eph
 A2F0V4VueCpQ+Z59uMHiK7alvf8/pxm1CLpifdaBVkzoVxUqBDUFfmcSJP833yoHXo
 HDSbXIUFXTAQdFIZNu4MYm4VRox5Mf8TUd7pD6t3SVQJbsHIYxFu/mLxVYosZ7el6B
 n+LFWcWCI2ZSA==
Date: Wed, 20 May 2026 17:38:08 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 1/2] toradex: common: Make TDX_CFG_BLOCK select EVENT
Message-ID: <20260520153808.GA125805@francesco-nb>
References: <20260519182856.865924-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519182856.865924-1-trini@konsulko.com>
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

On Tue, May 19, 2026 at 12:28:55PM -0600, Tom Rini wrote:
> Part of the TDX_CFG_BLOCK code makes use of an event to run one of the
> functions. Make this have a "select EVENT" so that it is always enabled.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
