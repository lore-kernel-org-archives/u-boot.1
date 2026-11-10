Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C050606B2C2
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P6y8VZF3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfFhyPH1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FF558133C;
	Tue, 10 Nov 2026 13:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oVZlIOECjmmZ; Tue, 10 Nov 2026 13:05:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A95D7812F8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315940;
	b=BMAF6GZcfEaJhGdFP0T9NpEOkjLn7cR6K7lN/nEFi+YezPG/kpltyDv1temySR0UUeEa
	 PSWSBvSaHGpCqexYX3Sf8EKH4yQWm9RlFMdfRBw6Gu+AzV9tkqCom/VKLT/OZaGgmzscM
	 uZodnrj1U7VhDPW6UDG3JqQ438YjRuVOg+dkVNUZ0EUtqwS8d0M17m1wkG+8bZkB5p8ow
	 2BoDvUv/Rk7ruczvq/8buPz3o95bGFA3THGguoLndSGKk3VsLvofS6saG9GgkCA5XDQrV
	 kbj9K0Flo2rp0R02vAQiU5Mycn89Q6cGTgca57LjJqtGWDstzSHra8of6eWRGnOf/2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315940;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=vk5LHBgW2mKr7re2MENzm4o6RsDIVVEdLee3DrileoU=;
	b=GZPTVSyOAqIBsrlcnpT4dXbGh28zPwa/ShZ/68I69BSOT0eeC9Bh349LBWMwgbzWSOl2
	 Gwia4CBYcVLVDjHw6wcNVm71QVVih/hJxs80TnoKnb42FmzhrfUeUSzOsyfH3HR2EsFE0
	 /0u6Rfa08d5/1w6o9BKTo9dIXBUusTRSwLE002Iu1lGaEGRws/KzY48tAVWA2uRMtxiNb
	 hJYVByauGnexj/RPDSLO899Fs719KUviAOYF6LT9SHSOVina/+RJKZCFUTqQZLbgemirA
	 3iy+2Unmb+Ovyj+Zt97ARK9r3xMgXCq0vCi4xlrW1d7D3Uy7qTN6LnxcSY7UFq5e8HQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315940;
	bh=vk5LHBgW2mKr7re2MENzm4o6RsDIVVEdLee3DrileoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=P6y8VZF3IZz1WIdSHSbdv81Uzi3a02+gW8skBs9P7VW3zq+/aFdHs1tTdaqhKmdMY
	 U/xjSu6SEt6AYIcamyrjPFYBNaGeHpPhnThvZhPM+r2I4XS5xF6wqGwnO3jqxR/ypF
	 eaplQBcI/OIVPEgyGc5VKVh5OfmT+qEELjYB/rt13pUaGrhX11IPuryTPAbFlDGLLA
	 W4uhaw6LJTkItWG4gICztGekY7GRo30PnjiWIWwRBMlwEUPEymw/6yH4nUaqHWBH5I
	 JSBwctaExQQ7kupo/FU5rXd11Ws5bsyRDzYT7zPnmw6I2PEbYunLALxdUD69HOx/Aq
	 HGZ5tSMXxdldQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A95D7812F8;
	Tue, 10 Nov 2026 13:05:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE29131F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FB0D607FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IMcuYO3qUtoT for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 06:19:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB93C60790
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+aiyengar1990.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=AfFhyPH1
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB93C60790
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:19:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 401826375C;
 Tue, 10 Nov 2026 06:19:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5F5041F0089F;
 Tue, 10 Nov 2026 06:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794291576;
 bh=vk5LHBgW2mKr7re2MENzm4o6RsDIVVEdLee3DrileoU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=AfFhyPH1wfgcvUGyFfshIp+jBFbGnoInyZdDhQpWgJWskiofag6ghUTc9H/2llxk3
 hgJSjquYwb5n0zono+beX3fCzaeJSCsZtnMHfQjHzWMWlDiaeUutGxR7FXkX9tRkca
 xwxvz81VCf6mReMSrnGZJhBUh2Q1pHzLyr/irPpsSCZHMHgJgNyM1/5DZ+eYVF3AZP
 a86+mkCdTChdHSPjJYKZ3kzHGZpzAvrY7280pUF4xf98P0Y7Q8zW+5rUzpwAlmEJVk
 j9ORNVBPpYlD01xSACpfwv8DO2ogeSqQ6ziL8gpgy3e1nTQ23WsSkM6JmqBT6RQZWd
 +6jYy10Icda6g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D9DA8488F1;
 Tue, 10 Nov 2026 06:19:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 06:19:37 +0000
Subject: [PATCH 2/2] sunxi: configs: OrangePi Zero2: talk to the AXP305
 over RSB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-h616-rsb-spl-v1-2-bf91cc26507e@gmail.com>
References: <20261110-h616-rsb-spl-v1-0-bf91cc26507e@gmail.com>
In-Reply-To: <20261110-h616-rsb-spl-v1-0-bf91cc26507e@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Arun Iyengar <aiyengar1990@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794291575; l=1611;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Sm82lPYxuOnv7tZpazlI8lKhm1309USyRmkrQQsHfic=;
 b=biMMnyS/UxsM1i2pruGtOwcJoUclia474RqNm9ujXwIJXq2dAKydTP4WLhGkAsrFLtj4MdB2r
 eLREDXBHZx8Bfg9hCIt5cf8At7kZbJzbb4Y3ay8J8h5HQbETXsgGbih
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

The OrangePi Zero2 device tree puts the AXP305 on r_rsb (pmic@745).
TF-A and Linux use RSB, and the PMIC stays in RSB mode across warm
reboots, so the SPL's R_I2C access fails on every reboot ("Failed to set
core voltage! Can't set CPU frequency", CPU left at 408 MHz until Linux
cpufreq takes over).

Use the RSB controller in the SPL instead and drop the now unused legacy
mvtwsi R_I2C setup. CONFIG_SPL_I2C stays: it builds drivers/i2c, and so
the RSB driver, into the SPL.

Tested on an OrangePi Zero2: before this change a cold boot was clean
and every warm reboot printed the error; with it neither does. U-Boot
proper still finds the PMIC on RSB through the DM driver.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 configs/orangepi_zero2_defconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/configs/orangepi_zero2_defconfig b/configs/orangepi_zero2_defconfig
index 371398fb70f..a45402e5ba8 100644
--- a/configs/orangepi_zero2_defconfig
+++ b/configs/orangepi_zero2_defconfig
@@ -9,16 +9,12 @@ CONFIG_DRAM_SUNXI_TPR6=0x33808080
 CONFIG_DRAM_SUNXI_TPR10=0xf83438
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
-CONFIG_R_I2C_ENABLE=y
 CONFIG_SPL_SPI_SUNXI=y
 CONFIG_SPL_SUNXI_LED_STATUS=y
 CONFIG_SPL_SUNXI_LED_STATUS_GPIO=76
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_SYS_I2C_MVTWSI=y
-CONFIG_SYS_I2C_SLAVE=0x7f
-CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SYS_I2C_SUN8I_RSB=y
 CONFIG_MTD=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SUN8I_EMAC=y

-- 
2.55.0


