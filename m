Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792E8CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDD884878;
	Wed, 27 May 2026 14:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="x9N9PH8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC808464D; Wed, 27 May 2026 10:46:35 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E84118404D
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 10:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 985D51A36E1;
 Wed, 27 May 2026 08:46:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 55D05601A1;
 Wed, 27 May 2026 08:46:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 086141088845E; 
 Wed, 27 May 2026 10:46:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779871592; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=jqB/Cas9vyPsauF5GoSN4cN31d6RiMaA6qVpTr8i3Hw=;
 b=x9N9PH8RT/nrtLPT5S3WaWluHv8MmIXGlLJovEiInuqBiLVF6imh2jNTcbPbG+jCHlLz0X
 68PSJgJJhA71/RpUxGdUMaFh/0qI4XF3JNvBvYOSHjuNPUuF3kQGtMTvRhQgysrnAd5bpM
 SXekMO7Lf2gQoO2ynLYrY+b8Gp8Opir5Hbsb/VoGo9ajjhr0fCsd8NGT7j+bbGvjWmogOS
 f5TdUCYvG0RLCTbXzuMwbDgThoR+CbRSY98zXjEAqFNZtQfDIee/vI8R6sq543NgN8V6UY
 QMUVGEvo91Iup5dET2uwtj+++4Lzq7PygDB9Cc+ecBkRiqCOqu66BJImGmy4/w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: <u-boot@lists.denx.de>,  GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>,  Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Frieder Schrempf
 <frieder.schrempf@kontron.de>,  Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,  Tianling Shen <cnsztl@gmail.com>,  Cheng
 Ming Lin <chengminglin@mxic.com.tw>,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH] mtd: spinand: add support for Etron SPI-NAND flashes
In-Reply-To: <875x49l0lf.fsf@bootlin.com> (Miquel Raynal's message of "Wed, 27
 May 2026 10:26:36 +0200")
References: <20260429081313.151656-1-weijie.gao@mediatek.com>
 <875x49l0lf.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 27 May 2026 10:46:28 +0200
Message-ID: <87qzmxjl3v.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 27 May 2026 14:57:52 +0200
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


>
> [...]
>
>> +#ifndef __UBOOT__
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#endif
>
> Please drop this #if block

Actually I missed the fact that the target was U-Boot, so it is fine obviously :-)

Rest is still valid.
