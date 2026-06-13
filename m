Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5B1CD8CA8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 20:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E2A83EEF;
	Sat, 13 Jun 2026 22:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rqQckJY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778D483EEF; Sat, 13 Jun 2026 22:24:32 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCE4801A9
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 22:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gd7CH0CpPz9ts2;
 Sat, 13 Jun 2026 22:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781382267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7acIAUWDxDplwk3XLFrEfjFChPON5LSAbXGInvCs1s=;
 b=rqQckJY+ERrR2wjI5yv8fh0pVxMZZGorb3zKdDz0+Jg0zCikzWkUGnuKdDX8H6zH5aJAhz
 WFh+rbcBpSB0Z3gWYfI8Ovvm4RSEO7YLn9tJlsDchG8yEXC/WF7qC9dH3utxMC8kMB0Ad2
 ynpYhh+rp85pr35N/zQ4IWKEbqpOR5Ja0zBZ//+EZC8VYJDUG/Eq+7uejafGTCblY1YHbM
 JjbeN8jXPTxlAnnCyDPno+UeO5dPrO5BhfQO/Ye7BP4QCCj+cpgVy4Xrx8Cr7GDvJWXWk/
 jEapinupKZAMMwwInexcsRgTZ6D4dmyMg0uXuX99vVKkb0CQ6JSeCPGKKOV8JQ==
Message-ID: <0e2fc8fb-419e-4c5f-9059-2d5ba22e6286@mailbox.org>
Date: Sat, 13 Jun 2026 22:24:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] ram: renesas: dbsc5: Add Renesas R-Car Gen5 DBSC5
 driver
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org
References: <20260610182140.56393-1-marek.vasut+renesas@mailbox.org>
 <20260610182140.56393-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260610182140.56393-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 49bd7ea0768e8caa8a9
X-MBO-RS-META: bd6qyqmx3mj9su8zmbdh7wtbz9ew36em
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

On 6/10/26 8:20 PM, Marek Vasut wrote:
> Add Renesas R-Car Gen5 DBSC5 DRAM controller driver. This driver is currently
> capable of bringing LPDDR5X DRAM on Renesas R-Car X5H Ironhide board. Further
> boards can be supported by supplying board specific DRAM configuration data
> via dbsc5_get_board_data().
> 
> The driver reuses parts of previous DBSC5 driver, but due to hardware changes,
> can not be fully integrated into existing DBSC and DRAM driver, therefore the
> currentl DBSC and DRAM drivers are moved into R8A779G0 V4H specific files, and
> the R8A78000 X5H files are added in parallel.
> 
> The Gen5 DBSC driver is meant to be used in RSIP context, while the Gen4 DBSC
> driver is meant to be used in SPL, therefore the Kconfig conditionals have been
> adjusted to match.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
>   board/renesas/sparrowhawk/sparrowhawk.c       |    2 +-
>   drivers/ram/renesas/Kconfig                   |    6 +-
>   drivers/ram/renesas/Makefile                  |    2 -
>   drivers/ram/renesas/dbsc5/Makefile            |    4 +-
>   drivers/ram/renesas/dbsc5/ecc.c               |  168 +
>   .../dbsc5/{dbsc5.c => r8a779g0-dbsc5.c}       |    2 +-
>   .../dbsc5/{dbsc5.h => r8a779g0-dbsc5.h}       |    6 +-
>   .../renesas/dbsc5/{dram.c => r8a779g0-dram.c} |    4 +-
>   drivers/ram/renesas/dbsc5/r8a78000-dbsc5.c    |   76 +
>   drivers/ram/renesas/dbsc5/r8a78000-dbsc5.h    |   17 +
>   drivers/ram/renesas/dbsc5/r8a78000-dram.c     | 2795 +++++++
>   drivers/ram/renesas/dbsc5/r8a78000-dram.h     | 7385 +++++++++++++++++
>   include/{dbsc5.h => r8a779g0-dbsc5.h}         |    0
>   include/r8a78000-dbsc5.h                      |   63 +
>   14 files changed, 10517 insertions(+), 13 deletions(-)
>   create mode 100644 drivers/ram/renesas/dbsc5/ecc.c
>   rename drivers/ram/renesas/dbsc5/{dbsc5.c => r8a779g0-dbsc5.c} (98%)
>   rename drivers/ram/renesas/dbsc5/{dbsc5.h => r8a779g0-dbsc5.h} (80%)
>   rename drivers/ram/renesas/dbsc5/{dram.c => r8a779g0-dram.c} (99%)
>   create mode 100644 drivers/ram/renesas/dbsc5/r8a78000-dbsc5.c
>   create mode 100644 drivers/ram/renesas/dbsc5/r8a78000-dbsc5.h
>   create mode 100644 drivers/ram/renesas/dbsc5/r8a78000-dram.c
>   create mode 100644 drivers/ram/renesas/dbsc5/r8a78000-dram.h
>   rename include/{dbsc5.h => r8a779g0-dbsc5.h} (100%)
>   create mode 100644 include/r8a78000-dbsc5.h
This additional one-liner is needed:

"
diff --git a/drivers/ram/renesas/dbsc5/qos.c 
b/drivers/ram/renesas/dbsc5/qos.c
index 56a60b987af..a9fc0b1439a 100644
--- a/drivers/ram/renesas/dbsc5/qos.c
+++ b/drivers/ram/renesas/dbsc5/qos.c
@@ -9,7 +9,7 @@
  #include <hang.h>
  #include <linux/sizes.h>
  #include <ram.h>
-#include "dbsc5.h"
+#include "r8a779g0-dbsc5.h"

  /* AXMM */
  #define AXMM_ADSPLCR0                          0x4008
"
