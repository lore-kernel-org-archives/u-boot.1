Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77717D5A6C3
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 01:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D49289502;
	Tue, 26 Nov 2024 02:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C4ewiXjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D439F895E2; Tue, 26 Nov 2024 02:52:03 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B7B894B2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 02:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ1ptqt065186;
 Mon, 25 Nov 2024 19:51:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732585915;
 bh=P3qVbNaT9E8obmTe7ST0XMoPqAGNWdCoQ1vnxwhkrX8=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=C4ewiXjPral4f6y3wQDZNzRtQTPTpcY6jHGDMVfnmYzsGSNtL2C5j3O/4WJHJ/uno
 rmlxWKUXAgYIB4vbEGjGCpmuQoH4D973QsiZGtzI2kTuuj2eK65hcQ81dFgDeJ0F6S
 QX+ho/l2XW6D9kjuwkwMW+g88jj4XMx3aNHC8aNo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ1ptuK015084
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Nov 2024 19:51:55 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 19:51:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 19:51:54 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ1psGt006119;
 Mon, 25 Nov 2024 19:51:54 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <m-chawdhry@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>, <sjg@chromium.org>, <devarsht@ti.com>,
 <ilias.apalodimas@linaro.org>, <afd@ti.com>, <u-kumar1@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 0/5] EFI Capsule "dfu_alt_info" fixes for TI Boards
In-Reply-To: <20241124070828.617558-1-s-vadapalli@ti.com>
References: <20241124070828.617558-1-s-vadapalli@ti.com>
Date: Mon, 25 Nov 2024 19:51:54 -0600
Message-ID: <86ed2y69tx.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Siddharth Vadapalli <s-vadapalli@ti.com> writes:

> Hello,
>
> This series fixes the commits which introduced EFI Capsule support. The
> blamed commits unconditionally updated "dfu_alt_info" with the
> "dfu_string" corresponding to Serial Flash and therefore its associated
> partitions. While this addresses use-cases where the interface is indeed
> Serial Flash ("sf"), it breaks use-cases such as USB DFU Boot where the
> interface is RAM ("ram").
>
> As of commit
> 52c0e5f8a3 Merge branch '2024-11-22-assorted-fixes'
> of the master branch of U-Boot, USB DFU Boot on AM625-SK is
> non-functional. Logs:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/726854b49eb199f4acf79028212fabdc
>
> In order to fix this, update "dfu_alt_info" only if the interface is
> "sf".

Hi Siddharth, this is an issue that I also discovered while working on a
separate issue with Collabora, but haven't posted a patch yet.  The issue
is that when DFU booting, spl_dfu_cmd() will setup it's own value for
dfu_alt_info before calling run_dfu().  In our existing code, however, this
will get overridden by set_dfu_alt_info().  This issue isn't specific to TI
boards.

Can you try this patch to drivers/dfu/dfu.c to see if it solves the
problems you are seeing:

@@ -153,10 +153,11 @@ int dfu_init_env_entities(char *interface, char
*devstr)

  dfu_reinit_needed = false;

+ str_env = env_get("dfu_alt_info");
 #ifdef CONFIG_SET_DFU_ALT_INFO
- set_dfu_alt_info(interface, devstr);
+ if (!str_env) {
+ set_dfu_alt_info(interface, devstr);
+ str_env = env_get("dfu_alt_info");
+ }
#endif
- str_env = env_get("dfu_alt_info");
  if (!str_env) {
  pr_err("\"dfu_alt_info\" env variable not defined!\n");
  return -EINVAL;

thanks
Jon

>
> The patch for AM62x in this series has been tested and it fixes USB DFU
> Boot on AM625-SK. Logs:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/feaed5b0a30aff752306d370531a4e10
>
> Series is based on commit
> 52c0e5f8a3 Merge branch '2024-11-22-assorted-fixes'
> of the master branch of U-Boot.
>
> v1 of this series is at:
> https://patchwork.ozlabs.org/project/uboot/list/?series=433959&state=%2A&archive=both
> Changes since v1:
> - Replaced "SPI Flash" with "Serial Flash" everywhere.
>
> Regards,
> Siddharth.
>
> Siddharth Vadapalli (5):
>   board: ti: am64x: evm: Set "dfu_alt_info" only if interface is Serial
>     Flash
>   board: ti: j721e: evm: Set "dfu_alt_info" only if interface is Serial
>     Flash
>   board: ti: am62x: evm: Set "dfu_alt_info" only if interface is Serial
>     Flash
>   board: ti: am62px: evm: Set "dfu_alt_info" only if interface is Serial
>     Flash
>   board: ti: j784s4: evm: Set "dfu_alt_info" only if interface is Serial
>     Flash
>
>  board/ti/am62px/evm.c | 8 +++++++-
>  board/ti/am62x/evm.c  | 8 +++++++-
>  board/ti/am64x/evm.c  | 8 +++++++-
>  board/ti/j721e/evm.c  | 8 +++++++-
>  board/ti/j784s4/evm.c | 8 +++++++-
>  5 files changed, 35 insertions(+), 5 deletions(-)
>
> -- 
> 2.43.0
