Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B76606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v/nEzbUM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C89581380;
	Thu, 19 Nov 2026 18:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bpib26eqtkiO; Thu, 19 Nov 2026 18:34:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 62F80814C0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795113287;
	b=V2XAelkZcbYFsluqBKm7sU4W3T6Vi8BHkWyYRICwHsVojJ7anQmq0ZVwZszR8RzppqaR
	 bgbEimgA5YeDvnUFr1tVjtrqcvEqWnzMjqcaQ5aAwSKU3mfZZu1mxi+o9Xvj2k/aJhARH
	 j9ax88eKaBCt9/0AgJYL8pYCL2EHvW9dOm+QfxTQRG00QUPdIM8KKA3xWuHkVoGH6+kJ1
	 jgojwXJB4PBy6X7md9LOy+boIvN7UVUWasI8VQrpOWjYrmpp2KiYRKg1HKqVTVwlN9JLN
	 vBgzXdhbiAxpEtKKZtkju/wjSItZA4pPP9rYnMnOV0UuzQpmlQjMTGOqZgoJVsiwRGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795113287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:To:
	 Cc:Subject:In-Reply-To:References:Message-Id:Date:From:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Kdq9pLS13GR1rhLVWeeZ4MMaF6Olz7cETFBzMQ+TH6w=;
	b=mFcMitZrRDIKir+DufBkEudK54ovLxkhNVZeithSKe1vl+35zUPF2UNE62VY/wD+g2BX
	 Wy8iPtG7X/WjhiropXXZhKgn19lMMm227yp4WT3ZndYkraViRxAnJ0JeeUJrxF+eNtUG4
	 fpi3iWtZq/R+z9iULLipNCCPgwuXVlUXV/XIFOYMu4q+BCiwSFRlPUafpKnPbdtF+hUWk
	 T4YPQFP+Eq5CAFFRYeQHZ2xYudEXq0LWdULraJBhpMv4aZC9+cZd90QovA6GYhMSvkzln
	 A0CcdW7kThELd+sWCnJ61faGcHS5lQ3hGuWjto0zfkfNopIALlQ7CteTi/KrpwJpJuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=lst.de;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795113287;
	bh=Kdq9pLS13GR1rhLVWeeZ4MMaF6Olz7cETFBzMQ+TH6w=;
	h=To:Cc:Subject:In-Reply-To:References:Date:From:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v/nEzbUMeHaEyj0bRjgiUNxT8kKFSClMCMYY1uDeMQ8FRiefsbgOMRqLU7BZx/v27
	 iAlHl5CFxoUd/Z92lB+T6tvs3sE7ekaAxu55E2pJM6AhBREbevlW7X63HZs+oYZ4cc
	 7omPQeNf3nD/YPkaF2MZp4QdlKmvALWIHlxd7LWZp5ccUBUluwheeO1GL0sS45FmFN
	 QSciIyetDaNfJFQQiOGA5cbdKhb+zCK6pH933aN5KBr+2zjhBu2vCYZ4NFEXGabbpr
	 sn5IpltRAc8I6+DiwWoLwtjpaQAMP60M3LvuOcdokuAJCPt1Qmgr0VJFshY6XmFRNe
	 mzEVI//KoAEww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62F80814C0;
	Thu, 19 Nov 2026 18:34:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 023342F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E704B81374
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ja70MmYITUZT for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 18:34:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 27EAC812CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=213.95.11.211
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=213.95.11.211;
 helo=verein.lst.de; envelope-from=duwe@lst.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27EAC812CF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:34:44 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2005)
 id 313E568CFE; Thu, 19 Nov 2026 19:34:40 +0100 (CET)
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH 2/2] configs: enable NVMe on Raspberry Pi 4&5
In-Reply-To: <20261119183244.D163768B05@verein.lst.de>
References: <20261119183244.D163768B05@verein.lst.de>
Message-Id: <20261119183440.313E568CFE@verein.lst.de>
Date: Thu, 19 Nov 2026 19:34:40 +0100 (CET)
From: duwe@lst.de (Torsten Duwe)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Torsten Duwe <duwe@suse.de>

Enable NVMe in the Raspberry Pi 64-Bit default config and scan for devices.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
---
 configs/rpi_arm64_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 87780c2286c..3cc12f7b266 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -15,7 +15,7 @@ CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_FDT_SIMPLEFB=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="pci enum; usb start;"
+CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
 CONFIG_SYS_PBSIZE=1049
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
@@ -43,6 +43,7 @@ CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_BCM2835=y
 CONFIG_MMC_SDHCI_BCMSTB=y
 CONFIG_BCMGENET=y
+CONFIG_NVME_PCI=y
 CONFIG_PCI_BRCMSTB=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
-- 
2.51.0

