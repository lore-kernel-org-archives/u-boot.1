Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F4DC7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 12:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE5F482CCE;
	Thu, 19 Jun 2025 14:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dKbrvIlx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2861D82CD5; Thu, 19 Jun 2025 14:57:26 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E7E82CBB
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 14:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55JCvMoD589700
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 07:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750337842;
 bh=M3/kAffKa83MW86Dr9cLs1EZIITUv5ktxFc8OhAlLNQ=;
 h=Date:CC:Subject:From:To;
 b=dKbrvIlx3DuMad6u3mQ2VsO9rS/OfF/jWsatgDj3wXMox4zGfXxPcYw2UzGWE8pjC
 nRha4kCDUkoafgJu7XfsC0ThWjjNmW0JG6TtdGeyMLIA6/n7nHP3khyFz3RnPnRRjc
 uaZ0pl0Wuf16Po9GrJVclzp483fNAqFq1W0yJs0M=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55JCvLEc3719852
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 07:57:21 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 19
 Jun 2025 07:57:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 19 Jun 2025 07:57:21 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55JCvKEw1396544;
 Thu, 19 Jun 2025 07:57:21 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 Jun 2025 18:26:43 +0530
Message-ID: <DAQIYU2LVE61.2K9Z7L7EQ2QQY@ti.com>
CC: <vigneshr@ti.com>
Subject: [RFC] board_f: why is TLB size estimated before board_init_banksize
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
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

Hi all,

I was trying to create an MMU table (set as mem_map) at runtime when I
encountered an issue with the init sequence for u-boot (defined in
initcall_run_f at common/board.f:893).

As part of the MMU creation, I am adding entries for all the memory
banks as per gd->bd->bi_dram which is set after dram_init_banksize. So I
called the function responsible for creating the MMU table after the
bi_dram has been populated in gd by dram_init_banksize.

Although as per the initcall sequence, u-boot has already computed a
size estimate for the TLB by this point from arch_reserve_mmu. Though
u-boot does expose get_page_table_size API to allow boards to reserve
their own size for the TLB but I am not sure why arch_reserve_mmu is
being called before dram_init_banksize in the first place.

Modifying the sequence from the existing:
dram_init -> arch_reserve_mmu -> dram_init_banksize

To the new:
dram_init -> dram_init_banksize -> arch_reserve_mmu=20

Will allow for MMU configuration inside dram_init_banksize where we can
access the dram bank sizes and also make use of u-boot's default size
estimate for the TLB with the drawback being the dram_init_banksize
would not be aware of u-boot's reserved memory.

I was unable to find a reason for why the init sequence is structured
this way, any inputs are appreciated :)

Regards,
Anshul
