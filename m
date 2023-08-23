Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5988EEE49A5
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 00:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F196F864D0;
	Wed, 23 Aug 2023 02:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eVLgu2+Z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BEMRulJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7009E864C3; Wed, 23 Aug 2023 02:18:48 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A53864C0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 02:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RVmz92lLhz9snh;
 Wed, 23 Aug 2023 02:18:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8tZfRE59qEZWA3Pw4lRk78K2DV5rZclFCB4RaA/d9I=;
 b=eVLgu2+Zw49pxn7kVnEvLD7LoqhlmdPV9NOazAashzXBm0wb0xJGGtMtJdoTP+OEi30Fwz
 QJtuCa35i/pKwyZ5GTJo4wfZfFptEMD3QxpK6+COlbJyYJayRJgwyEyhk2g5QBoqoLohHH
 ss67Csct3HhG3mfd4Pt0+KnnrDjEaaIW3uJv/R7ZoZNtvwY7DMSmHjm5L/IBasvzLPdlD8
 2Ite3GSlFHWsW7Q2Y0JCH+Y9Y33ELlM6ljxikFQsy1xOvGHge7qTYEjMIVvVhX3hQj9z8K
 341IMJ5zRyOVQGslg6OJW941WF1JWOlheK1nrZ9hdv8CvumDicRGUhtwIRQuNw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8tZfRE59qEZWA3Pw4lRk78K2DV5rZclFCB4RaA/d9I=;
 b=BEMRulJlRQ5/nmuysaATx83/DBDE92uPx2jh+1+1FTrybb45YUJnQmHnnD9AiHg6hx5k3F
 561MdYt9q+eBN7gEzYXISQm5/RskG2VfaQHUiwkmF/8NVGgiYpqCYgc5u3TU4S+yHNCivN
 jKbyieVTtOHzHEo2jAV6biGTmuX2GM48fy7m4cDF+Qul1ElVYobSnep+89OVUIiRslzhYg
 El0OR0RfgUtmiakwomg86bTaUbxMfPIOuumUAdXMDYLKoTLXDYLAw44dD1bNUSPE5YBNlH
 jqIJsMOMWpvwdwa+Ik0PiTs4sqALdfBywc5p/CI6BAMGrbGYWPsX6K4lN197lQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/5] configs: sandbox: Enable NVMXIP QSPI driver
Date: Wed, 23 Aug 2023 02:18:21 +0200
Message-Id: <20230823001821.266578-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
References: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9jfcrgzcst5amtfjhuo744s1fceq7iom
X-MBO-RS-ID: 1626091aa1ff01d9ca3
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

Enable NVMXIP QSPI driver on sandbox, since it is already enabled
on sandbox64.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: No change
---
 configs/sandbox_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a57ab23d9a2..e1203714c60 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -226,6 +226,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_NVMXIP_QSPI=y
 CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
 CONFIG_NVME_PCI=y
-- 
2.40.1

