Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46E9106F30F
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A6B83A1B;
	Thu, 26 Mar 2026 10:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fOO9XuSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F1FA83A1B; Thu, 26 Mar 2026 10:21:11 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE8D9838BB
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=WUYw8Ex9VbY8fd1R1429v5qz8qnNHPGg9bw4EgrW9t0=; b=fOO9XuSGuPEXuwfUEkGhFNzx4x
 3GcwvjXIJKNHh3Ga0ODxlTNLhv+fm0kDh9ccMnJ0UrDL96qwsl1i5T7QG70aGwK+qe5UYIr1nOtPE
 I+R0MQVQ83ItDW0klCIX/PPjglCCQOFDFOfT66yTuWSgtkLZsk9iekXrVRjH/4hw3n+rQul+6KBsf
 oKSwx9B43EFT8FunjOzZK6d9r0eOSn4fpSlGEfvuonsIgiTxqEDC3A8beMPbgU7aK1Uea2eZRE8Hf
 bFMJSXQHoG2Ha4WKvo+r13+KygIKFr9LDXLtukcT2Tpsgt+0GxzytzLIwXzulqq4OXd9XCZ/OpqeF
 9wwPwfjQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1w5gtn-00013x-3D; Thu, 26 Mar 2026 10:21:08 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1w5gto-0007bp-0k; Thu, 26 Mar 2026 10:21:07 +0100
Message-ID: <4c4aec95-2c2b-4158-96aa-1e5d04c31767@ew.tq-group.com>
Date: Thu, 26 Mar 2026 10:21:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] TQMa6 with preparations for integrating
 additional TQ boards
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com
References: <20260323134746.787430-1-Max.Merchel@ew.tq-group.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <20260323134746.787430-1-Max.Merchel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/23/26 14:47, Max Merchel wrote:
> This series introduces features for sharing across different TQ boards,
> simplifying maintenance by avoiding code duplication.
>
> These changes are implemented for the TQMa6.
> They will also be used by TQMa7 and TQMa6UL, whose mainlining is currently
> being prepared.
>
> These changes also serve as preparation for further work on the TQMa6
> (in following series).
>
> Changes V2:
> - Drop patches 1 and 2 from the series.
>    They cause CI errors and need to be revised.
> - Drop patch 12 with planned SPL usage the values ​​can be
>    read from the device trees.
> - Uptate commit log (Use imperative mood)
>
> Markus Niebel (2):
>    env: tq: add shareable environment settings
>    board/tq: Add common baseboard API
>
> Max Merchel (6):
>    [cleanup]configs: tqma6.h: remove unused define for PHYS_SDRAM_SIZE
>    [cleanup]configs: tqma6.h: remove unused define for PFUZE100_I2C
>    board: tqma6: change to use shareable tq environment
>    configs: tqma6: change to include tqma6.h in baseboard headers
>    board/tq: Add common mmc API
>    board: tqma6: use common TQ mmc function
>
> Paul Gerber (2):
>    board: tqma6: use common TQ baseboard
>    board: tqma6: update eMMC DSR handling
>
>   board/tq/common/Kconfig          |  13 ++
>   board/tq/common/Makefile         |   9 ++
>   board/tq/common/tq_bb.c          |  78 +++++++++
>   board/tq/common/tq_bb.h          |  39 +++++
>   board/tq/common/tq_sdmmc.c       |  46 ++++++
>   board/tq/tqma6/Kconfig           |   8 +-
>   board/tq/tqma6/Makefile          |   1 +
>   board/tq/tqma6/tqma6.c           |  39 +++--
>   board/tq/tqma6/tqma6.env         |  47 ++++++
>   board/tq/tqma6/tqma6_bb.h        |  28 ----
>   board/tq/tqma6/tqma6_emmc.c      |  88 ++++++++++
>   board/tq/tqma6/tqma6_emmc.h      |  19 +++
>   board/tq/tqma6/tqma6_mba6.c      |  26 +--
>   board/tq/tqma6/tqma6_wru4.c      |  29 +---
>   include/configs/tqma6.h          | 266 ++-----------------------------
>   include/configs/tqma6_mba6.h     |   3 +-
>   include/configs/tqma6_wru4.h     |   2 +
>   include/env/tq/mmc.env           |  82 ++++++++++
>   include/env/tq/nfs.env           |  51 ++++++
>   include/env/tq/spi.env           |  23 +++
>   include/env/tq/tq-imx-shared.env |  38 +++++
>   include/env/tq/ubi.env           |  47 ++++++
>   22 files changed, 641 insertions(+), 341 deletions(-)
>   create mode 100644 board/tq/common/Kconfig
>   create mode 100644 board/tq/common/Makefile
>   create mode 100644 board/tq/common/tq_bb.c
>   create mode 100644 board/tq/common/tq_bb.h
>   create mode 100644 board/tq/common/tq_sdmmc.c
>   create mode 100644 board/tq/tqma6/tqma6.env
>   delete mode 100644 board/tq/tqma6/tqma6_bb.h
>   create mode 100644 board/tq/tqma6/tqma6_emmc.c
>   create mode 100644 board/tq/tqma6/tqma6_emmc.h
>   create mode 100644 include/env/tq/mmc.env
>   create mode 100644 include/env/tq/nfs.env
>   create mode 100644 include/env/tq/spi.env
>   create mode 100644 include/env/tq/tq-imx-shared.env
>   create mode 100644 include/env/tq/ubi.env
>
>
> base-commit: eb00c710508d09b2a3b9aca75dd18280f1304703
Any further feedback on this?

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

