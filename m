Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5CEC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD1788A67;
	Wed,  7 Aug 2024 16:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="d6sBuvvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306428872E; Wed,  7 Aug 2024 16:39:00 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD9E288A67
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id A1D7620AC2;
 Wed,  7 Aug 2024 16:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1723041536;
 bh=LL/bS1JeT3iz1BPXEfYzCejHnpknMvSJSnja524LsO0=; h=From:To:Subject;
 b=d6sBuvvu4JX0dJgY/cVB0vt6q4k0r7tQNJQJvhRX3Un9DfFR5IvdiayP71ZQjNSMN
 J/cS/a7k/gyyDUeCSIC6jzrQ+iywieZj8yoaGGM0Xh1Va3nBrE6CtncEA44UetMYhc
 1ZB2lzUesRACylM9gkC4EuwnDCIlQ7TwxXreR3SIrWognot/EOk21lm/RkTGRd42MF
 Rnv8UBPg5oBlVW3oxAhvtVJPPC31nD2CqUXDpR+2ItIhuyLwEqtUtpXtQgo7GqIgSd
 JBG9FlzbAlm3qfEexr/JYUhC2DYm6qMJTo4OSQZpr0k+otSfTEWS+bkJIHppt1LYLv
 Ighx9VbTCezkQ==
Date: Wed, 7 Aug 2024 16:38:51 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: max.oss.09@gmail.com
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/4] apalis/colibri imx8: enable additional features
Message-ID: <20240807143851.GA296406@francesco-nb>
References: <20240807141655.4165667-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807141655.4165667-1-max.oss.09@gmail.com>
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

On Wed, Aug 07, 2024 at 04:16:16PM +0200, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> 
> Enable and use additional features which have been added to U-Boot
> on the Apalis iMX8QM / Colibri iMX8X boards.

For the whole series,

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

