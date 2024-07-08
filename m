Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AFCC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 14:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD7E8877E;
	Mon,  8 Jul 2024 16:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720448192;
	bh=b2bGweZ+I6l+nKcLJdOhiJJ/XGSWlObNosJZnRrwQ/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EHMwFyGqwror3QO4I8tBoRV1VXHlhUAsnXw6Nub2MUeQqG+eh4eeidNNcV0iE24fu
	 WuIYJLz0yuEqVDxWNaZcvJPpDD2lo2i4wOKb4Bbt5qF+xzhmrlnLeAyLUelhiVWFI2
	 Bl2E6vVAlT5qAk3dYDDGSdU+z4Mk8frURQtgpFoeg2fPBGT6xeKmrx+YpfuPAkBxuO
	 eK2YKz/eZI/AZo+OPC+0LTqiS7nzChA8rGlHBBE1YV4A0ZoX4Hps/CCpnxsMzKd+X+
	 0ozgA6MTYLi9W25GNeUfaVMVlLMK24DYNe9zV8+UDhEyxYcfnyW7rJFRmSlya8lchK
	 0XmzSYxxAWixw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6175C8878B; Mon,  8 Jul 2024 16:16:31 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E9C888756
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 16:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4WHmQ32M70z9s37;
 Mon,  8 Jul 2024 16:16:27 +0200 (CEST)
Message-ID: <1978c1c7-4cb2-4529-8a20-c744934a44a6@denx.de>
Date: Mon, 8 Jul 2024 16:16:26 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-marvell 00/16] Turris Omnia DDR training changes
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240618153439.9518-1-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240618153439.9518-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WHmQ32M70z9s37
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

On 6/18/24 17:34, Marek Behún wrote:
> Hi Stefan,
> 
> this is v2 of the series adds some changes to DDR3 training for Armada
> 38x and Turris Omnia.
> 
> I also put one unrelated patch (Fix ethernet PHY reset gpio FDT fixup)
> here.
> 
> It depends on stuff in Tom's next branch.

Applied to u-boot-marvell/master

Thanks,
Stefan


> Marek
> 
> Marek Behún (16):
>    arm: mvebu: turris_omnia: Disable ext4 write support in defconfig
>    ddr: marvell: a38x: debug: return from ddr3_tip_print_log() early if
>      we won't print anything
>    ddr: marvell: a38x: debug: Remove unused variables
>    ddr: marvell: a38x: debug: Define DDR_VIEWER_TOOL variables only if
>      needed, and make them static
>    ddr: marvell: a38x: debug: Allow compiling with immutable debug
>      settings to reduce binary size
>    arm: mvebu: turris_omnia: Enable immutable debug settings in DDR3
>      training by default
>    arm: mvebu: turris_omnia: Fix ethernet PHY reset gpio FDT fixup
>    arm: mvebu: turris_omnia: Implement EEPROM layout for the 'eeprom'
>      command
>    arm: mvebu: turris_omnia: Enable the 'eeprom' command
>    arm: mvebu: turris_omnia: Extend EEPROM info structure
>    arm: mvebu: turris_omnia: Read DDR speed from EEPROM
>    ddr: marvell: a38x: Import old DDR training code from 2017 version of
>      U-Boot
>    ddr: marvell: a38x: old: Fix some compiler warning of the old code
>    ddr: marvell: a38x: old: Backport immutable debug settings
>    arm: mvebu: a38x: Add optional support for using old DDR3 training
>      code
>    arm: mvebu: turris_omnia: Support old DDR3 training
> 
>   arch/arm/mach-mvebu/Kconfig                   |   15 +
>   arch/arm/mach-mvebu/include/mach/cpu.h        |    1 +
>   arch/arm/mach-mvebu/spl.c                     |   37 +-
>   board/CZ.NIC/turris_omnia/Makefile            |    2 +
>   board/CZ.NIC/turris_omnia/eeprom.c            |  190 ++
>   board/CZ.NIC/turris_omnia/old_ddr3_training.c |   63 +
>   board/CZ.NIC/turris_omnia/turris_omnia.c      |  199 +-
>   configs/turris_omnia_defconfig                |    6 +-
>   drivers/ddr/marvell/a38x/Makefile             |    2 +
>   drivers/ddr/marvell/a38x/ddr3_debug.c         |   30 +-
>   drivers/ddr/marvell/a38x/ddr3_init.c          |    3 +-
>   drivers/ddr/marvell/a38x/ddr3_init.h          |   43 +-
>   drivers/ddr/marvell/a38x/old/Makefile         |   29 +
>   drivers/ddr/marvell/a38x/old/ddr3_a38x.c      |  737 +++++
>   drivers/ddr/marvell/a38x/old/ddr3_a38x.h      |   93 +
>   .../marvell/a38x/old/ddr3_a38x_mc_static.h    |  226 ++
>   .../ddr/marvell/a38x/old/ddr3_a38x_topology.h |   22 +
>   .../ddr/marvell/a38x/old/ddr3_a38x_training.c |   39 +
>   drivers/ddr/marvell/a38x/old/ddr3_debug.c     | 1546 ++++++++++
>   .../marvell/a38x/old/ddr3_hws_hw_training.c   |  147 +
>   .../marvell/a38x/old/ddr3_hws_hw_training.h   |   49 +
>   .../a38x/old/ddr3_hws_hw_training_def.h       |  464 +++
>   .../marvell/a38x/old/ddr3_hws_sil_training.h  |   17 +
>   drivers/ddr/marvell/a38x/old/ddr3_init.c      |  769 +++++
>   drivers/ddr/marvell/a38x/old/ddr3_init.h      |  405 +++
>   .../ddr/marvell/a38x/old/ddr3_logging_def.h   |  101 +
>   .../marvell/a38x/old/ddr3_patterns_64bit.h    |  924 ++++++
>   .../ddr/marvell/a38x/old/ddr3_topology_def.h  |   76 +
>   drivers/ddr/marvell/a38x/old/ddr3_training.c  | 2650 +++++++++++++++++
>   .../ddr/marvell/a38x/old/ddr3_training_bist.c |  288 ++
>   .../a38x/old/ddr3_training_centralization.c   |  711 +++++
>   .../ddr/marvell/a38x/old/ddr3_training_db.c   |  651 ++++
>   .../marvell/a38x/old/ddr3_training_hw_algo.c  |  685 +++++
>   .../marvell/a38x/old/ddr3_training_hw_algo.h  |   14 +
>   .../ddr/marvell/a38x/old/ddr3_training_ip.h   |  178 ++
>   .../marvell/a38x/old/ddr3_training_ip_bist.h  |   54 +
>   .../old/ddr3_training_ip_centralization.h     |   15 +
>   .../marvell/a38x/old/ddr3_training_ip_db.h    |   34 +
>   .../marvell/a38x/old/ddr3_training_ip_def.h   |  173 ++
>   .../a38x/old/ddr3_training_ip_engine.c        | 1354 +++++++++
>   .../a38x/old/ddr3_training_ip_engine.h        |   85 +
>   .../marvell/a38x/old/ddr3_training_ip_flow.h  |  349 +++
>   .../marvell/a38x/old/ddr3_training_ip_pbs.h   |   41 +
>   .../a38x/old/ddr3_training_ip_prv_if.h        |  107 +
>   .../a38x/old/ddr3_training_ip_static.h        |   31 +
>   .../marvell/a38x/old/ddr3_training_leveling.c | 1836 ++++++++++++
>   .../marvell/a38x/old/ddr3_training_leveling.h |   17 +
>   .../ddr/marvell/a38x/old/ddr3_training_pbs.c  |  994 +++++++
>   .../marvell/a38x/old/ddr3_training_static.c   |  537 ++++
>   .../ddr/marvell/a38x/old/ddr_topology_def.h   |  121 +
>   .../ddr/marvell/a38x/old/ddr_training_ip_db.h |   16 +
>   .../marvell/a38x/old/glue_symbol_renames.h    |  247 ++
>   drivers/ddr/marvell/a38x/old/silicon_if.h     |   17 +
>   drivers/ddr/marvell/a38x/old/xor.h            |   92 +
>   54 files changed, 17475 insertions(+), 57 deletions(-)
>   create mode 100644 board/CZ.NIC/turris_omnia/eeprom.c
>   create mode 100644 board/CZ.NIC/turris_omnia/old_ddr3_training.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/Makefile
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_mc_static.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_topology.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_training.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_debug.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training_def.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_sil_training.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_init.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_init.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_logging_def.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_patterns_64bit.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_topology_def.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_bist.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_centralization.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_db.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_hw_algo.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_hw_algo.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_bist.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_centralization.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_db.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_def.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_flow.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_pbs.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_prv_if.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_static.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_leveling.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_pbs.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_static.c
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr_topology_def.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/ddr_training_ip_db.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/glue_symbol_renames.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/silicon_if.h
>   create mode 100644 drivers/ddr/marvell/a38x/old/xor.h
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
