Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A513AC369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 02:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBBD08081A;
	Thu,  1 May 2025 04:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gsxu1ABy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40376809A5; Thu,  1 May 2025 04:02:17 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D778070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 04:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Zny3m6wvgz9tkJ;
 Thu,  1 May 2025 04:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1746064933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUYHbqsNQUhwk9ms7yljcpQgr4HDnWdKUaKFmYm7y5o=;
 b=gsxu1AByuilPeaXA5r2z2uxghlawhnZMgxoJUqn6NGjKSjPUtPijr0RYOPm556LKhsofrw
 6xzRCgc40B+RU96esAS260S/FcO0tIekMkUJDfsfDyUWB5IYLRPtDncrfeKy6JnV18XMgv
 3+f+BcYezu7dFF85dbsSN3wBbR0ptWnFDHTfmS9MFr/Cl492Tgpa8Auqct1F2cKReUeD5C
 2Rs+ojM6wR+sltj05TT+v77G0xhJo7mrijUzTIwOFj4aS4nGE1aQlPMKmKrJyVOQXFEj1Q
 Nlls8dEOmPvsrbBuz8yAzw9E4hDM89y7mbv0vlKQNv7NjwhGQRNRU9D32UAsKA==
Message-ID: <96025fbf-c636-4726-8534-d95e54ff1017@mailbox.org>
Date: Thu, 1 May 2025 04:02:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/22] Deal with exfat versus byteorder
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20250501010456.3930701-1-sjg@chromium.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3iimth7p49pi3opui1kq3tjipdr74abh
X-MBO-RS-ID: 6e90bbf3f2a98057319
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

On 5/1/25 3:04 AM, Simon Glass wrote:
> Since exfat has its own byteorder functions we need to be careful about
> including the normal U-Boot byteorder headers in code included by exfat.

...

>    net: Use a forward declaration for cmd_tbl in net-common.h
>    congatec: Include env.h to permit reading the environment
>    dhelectronics: Include env.h to permit reading the environment
>    imx8ulp_evk: Include env.h to permit reading the environment
>    venice: Include env.h to permit reading the environment
>    phytec: Include env.h to permit reading the environment
>    ronetix: Include env.h to permit reading the environment
>    toradex: Include env.h to permit reading the environment
>    advantech: Include env.h in imx8qm_dmsse20_a1
>    tegra: Include env.h to permit reading the environment
>    synology: Include env.h to permit reading the environment
>    amlogic: Include env.h to permit reading the environment
>    freescale: Include env.h to permit reading the environment
>    google: Include env.h to permit reading the environment
>    liebherr: Include env.h to permit reading the environment
>    technexion: Include env.h to permit reading the environment
>    elf: Only use network environment-variables if net enabled
>    net: Include byteorder in net6.h
>    net: Include string.h in net-legacy.h
>    net: Include env.h in pcap.c
>    net: dc2114x: Include env.h to permit reading the environment
>    net: Move env_get_ip() out of the header file
> 
>   arch/arm/mach-tegra/dt-setup.c                |  1 +
>   board/Synology/ds414/ds414.c                  |  1 +
>   .../imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c     |  1 +
>   board/amlogic/jethub-j100/jethub-j100.c       |  1 +
>   board/congatec/cgtqmx8/cgtqmx8.c              |  3 +-
>   board/dhelectronics/common/dh_common.c        |  1 +
>   board/freescale/imx8ulp_evk/imx8ulp_evk.c     |  1 +
>   board/freescale/mx7dsabresd/mx7dsabresd.c     |  1 +
>   board/gateworks/venice/venice.c               |  1 +
>   board/google/chameleonv3/board.c              |  2 +
>   board/liebherr/xea/xea.c                      |  1 +
>   .../common/phytec_som_detection_blocks.c      |  1 +
>   board/ronetix/imx8mq-cm/imx8mq_cm.c           |  1 +
>   board/technexion/pico-imx7d/pico-imx7d.c      |  1 +
>   board/toradex/colibri_imx7/colibri_imx7.c     |  1 +
>   board/toradex/verdin-imx8mm/verdin-imx8mm.c   |  2 +-
>   cmd/elf.c                                     | 41 ++++++++++---------
>   drivers/net/dc2114x.c                         |  1 +
>   include/net-common.h                          |  9 ++--
>   include/net-legacy.h                          |  1 +
>   include/net6.h                                |  1 +
>   net/net-common.c                              |  6 +++
>   net/pcap.c                                    |  1 +
>   23 files changed, 53 insertions(+), 27 deletions(-)
There are no fs changes in this series , what does this series have to 
do with exfat ?
