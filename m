Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B8BF46436
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 09:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4967F83FC6;
	Mon, 16 Mar 2026 10:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZdGpxiyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B3AE83FDB; Mon, 16 Mar 2026 10:38:07 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4462983F8A
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 10:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joaomarcos.costa@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C1FEB4E4261E;
 Mon, 16 Mar 2026 09:38:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 915065FC4A;
 Mon, 16 Mar 2026 09:38:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2416B10368AC0; Mon, 16 Mar 2026 10:38:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773653884; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=PMR1PIcRo3h8NyX1IKA/XAAX5/XlXM5Tr7q9A2GaLno=;
 b=ZdGpxiyId2ONx/s/nBqfzuxt1ukazRHARIEoDeNAkGj5K4GazgXo6IL+m2ibXz1lNmQfFK
 n8kDTnBQm0Joaw6fRMYoTXGdRZS0vRTB/RCtUnIRkh2Oh6CmC62StDZw/WE5cEhtaRvcX8
 FFxxSBFkwg+9nz5GPrCEq6cr4E+CuVtnHSKPWdTfv5mxX9mJq7SXkQzjhesdO35N32Fz3H
 TBxSzEm2PAAAOuXZzl4B8uuRT8FFYVU6KcRfrK2KCHiq4nAOmCm1/kENvjFYKfhLlXQPDh
 6euTOBNH1TJn8OYvmg5S/aJNnIGlz1cmWQO4kMpACx7UlDuaYF/EGbhIiieM/A==
Message-ID: <bd918c30-9101-4d4a-a256-5315f468d7d2@bootlin.com>
Date: Mon, 16 Mar 2026 10:38:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Introduce SQUASHFS support in SPL
To: Richard Genoud <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
Content-Language: en-US, fr
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260313104229.1555236-1-richard.genoud@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello, folks

Thanks for the series, Richard!

On 3/13/26 11:42, Richard Genoud wrote:
> SquashFS has support in U-Boot, but not in SPL.
> 
> This series adds the possibility for the SPL to load files from SquashFS
> partitions.
> This is useful, for instance, when there's a SquashFS rootfs containing
> U-Boot binary.
> 
> NB: falcon mode is not supported yet.
> 
> Richard Genoud (7):
>    fs/squashfs: fix sqfs_decompressor.c build in SPL
>    fs/squashfs: sqfs_decompressor: simplify code
>    fs/squashfs: squashfs.h: include file should be self dependent
>    spl: add squashfs support
>    spl: mmc: support squashfs
>    MAINTAINERS: SQUASHFS: update João Marcos Costa email
>    MAINTAINERS: SQUASHFS: Add myself as co-maintainer
> 
>   MAINTAINERS                     |  6 ++-
>   common/spl/Makefile             |  1 +
>   common/spl/spl_mmc.c            | 19 +++++---
>   common/spl/spl_squashfs.c       | 78 +++++++++++++++++++++++++++++++++
>   fs/squashfs/sqfs.c              | 12 +++--
>   fs/squashfs/sqfs_decompressor.c | 71 ++++++++++--------------------
>   include/part.h                  |  1 +
>   include/spl.h                   |  6 +++
>   include/squashfs.h              |  5 ++-
>   9 files changed, 135 insertions(+), 64 deletions(-)
>   create mode 100644 common/spl/spl_squashfs.c
> 
> 
> base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da

Reviewed-by: João Marcos Costa <joaomarcos.costa@bootlin.com>

-- 
Best regards,
João Marcos Costa
