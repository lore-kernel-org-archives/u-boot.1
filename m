Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B3AF01819
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 09:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E217283F2D;
	Fri,  6 Mar 2026 10:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="IZKXFmPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF7BB83F75; Fri,  6 Mar 2026 10:40:18 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A543E83F00
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 10:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id A0F081FB6F;
 Fri,  6 Mar 2026 10:40:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1772790015;
 bh=haoeDBi92SGyCwzrMMac79oO+6WVX2BstdyeVgYpci4=; h=From:To:Subject;
 b=IZKXFmPxNd/yeGX62oWzIiSx6zBx35XPhv08vrMGuNAcfs/5bUQKO5eTor2lh4OZE
 0FcqiBCWPu3ECHaz2eJ0JKgXOUaDjjGeD+43OG+ZFu0kkL6m+7fiDIG/xAr02ucKlJ
 RqxQJ2ifbbmKyNtOL9rJ4ZaeYq8Vt7VkvA96OlTeJr6KV/TG1yPGEbJiqkIec2VBs0
 maEHggk2Oc2/fGATT1NYZBRVSX5lsegNVlivE+x1whI4vYPbIOrU+279hWcs98879w
 MlH91yFLxlqvDpR/Qr/zCxXK4y4k42y6jZdz8l6y/CgDAMZ4G9V1BXVmAWIloisvMp
 8jww41nd6i36Q==
Date: Fri, 6 Mar 2026 10:40:09 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Philip Molloy <philip@philipmolloy.com>
Cc: u-boot@lists.denx.de, linux@analog.com,
 Philip Molloy <philip.molloy@analog.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/4] ddr: imx: Remove duplicate includes
Message-ID: <20260306094009.GA30812@francesco-nb>
References: <20260306085824.886254-1-philip@philipmolloy.com>
 <20260306085824.886254-2-philip@philipmolloy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306085824.886254-2-philip@philipmolloy.com>
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

On Fri, Mar 06, 2026 at 08:58:31AM +0000, Philip Molloy wrote:
> From: Philip Molloy <philip.molloy@analog.com>
> 
> Signed-off-by: Philip Molloy <philip.molloy@analog.com>

you need some commit message to explain the change, the title is not
enough


