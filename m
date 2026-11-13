Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B992606A332
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iDrWgHlH;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=g+t57jPg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4DEC81A3B;
	Fri, 13 Nov 2026 19:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H7MfC62t57ME; Fri, 13 Nov 2026 19:43:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EBFA28194C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794599023;
	b=FEASan/0AQhWRpW0unDV91O84fBIQjKbvzgV+x5lbcwkV5Szq6rTxE1XQjkpt4234JeC
	 IF53TIf4/Mrt+UuM1rDH9leCDYJK5xSYxBbjHHXi0vDuGeNHirH073mswM3E24MrWdvAm
	 cKpzjggYfDCs7d5LA+wpk+xjDGJMauAVL6G7V7h9OWoIZtgIgTdPDyfT0rg4UchANHwah
	 UcgQfn9VySt71iwAVnq9fToRhMoZdoU59Zs2smbq27QZZUDzO3eZTE87Dpd/luRaEggMu
	 3tl54LvQka+OvOfWddxT1oIEp4Ko37As4qX0+EY7HA+w2G6I8UURgvFyWbqEFEnMFOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794599023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Mcx48WLyUeKM2ak2GBxgaePDfCL9FZgsN4LhZ7abQfU=;
	b=LsSFtT5yeX6ATS8hE4yHkWTdnIvw0m4m8IqDOOK86ecl5VMEBkXpPwhhpe8YQsPfNGEy
	 0rraQE2dMghxjpgJG3hUFkdECT1eU/1kL8I+/Va/e8Ria20QqdkP4jrnABrfDVh5tnRhl
	 8GghiKhCSBHD4Ozzzg8icNggghTCMJM8mSvDk97IecRRzEm57+9vx/1ifDxAXngSTi+k8
	 woURqjWUwIa7XqYoP77VS68MmjIvjOQ/vJOV/44grHqkJrkRBGjDKnOH0D+lr3VDs5IE4
	 GVyZp7B3hTOyaf/TqINY5555fyKFdPLLEnO694mP57ke36TX+92m2+N5Bhn5RXzv3tQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794599023;
	bh=Mcx48WLyUeKM2ak2GBxgaePDfCL9FZgsN4LhZ7abQfU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iDrWgHlHR/pyavEsv5YCpXVuB9prAQmR/dE4HiYqcs1e1s6HwyX4hfn70fR/Bykfi
	 e9mSvIz3lCOwXJaiJTqwslErINIVe6DMu80OB3mA2ObCNeiFiyIsCG4e/KmDQblPry
	 mbfDPf82FMIBIETCmhAge4NrSd7ZXkkubDmkhMceJkNjVg+G2ZQNf5xYYtwVj3xTzk
	 IpXdF4vrsXX/bNnTZ5W6wWY5zn2HL8Z2UyUZWBuc4VImJ3ycc7FEGnntXpoNImMFDg
	 AoG2DD7+HFqNUVqVnoVwTw7ns3Dpm0KWrvJeT++m9E5FoLeTIYjiavvvR0w1prGav/
	 Nj72MqX4T6Pug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBFA28194C;
	Fri, 13 Nov 2026 19:43:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 31AA6260
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16BEB608B6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C3nqyNzZ6Rgt for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 19:43:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 65D9160D91
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7708869e7=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=g+t57jPg
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65D9160D91
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794599018; x=1826135018;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=nTjcqeZfSvizUnlIxWJaCtQ5p2s3YAwi0KQDwPyAnEs=;
 b=g+t57jPgKDS1W8N3pOgecjGUgRaILUrFPX7ZD39lcOMK5LDy1vuskU94
 BjxYvyJZiMbNmbRcJlQk+6yp6luD/2xtyc/dec2z0XGj5jNAF0APlDDk5
 gYGzb3RpWxl99UZxeMab+aSIwlSuVaoL0YjHhrWhucLbrHQ6jEnQ6hi0a
 gCcJ622GZQH5SOIcM2xcpewdmTQPOd4/AaZgUWVoymUnBwilu3BLrOwfJ
 WdfOMc5EhYGwZsUMSEPsXulgqOBSx4Zo0l3bS3zTlfRf4qSkyqNgMtO/m
 CJIjI0zqfHX2Sfhv1QGdADoQ2UkQH9N1Y02MvRL6m37etSx7CHQ9zwg5F w==;
X-CSE-ConnectionGUID: BK8UA3ooQkCGdhKyXOlo6A==
X-CSE-MsgGUID: YvEjDYq5SmOl1x7/ifIK7w==
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="77185701"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 12:43:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 13 Nov 2026 12:43:36 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 12:43:33 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 13 Nov 2026 14:43:01 -0500
Subject: [PATCH v5 7/8] configs: qemu-riscv[32|64]_smode_defconfig: add
 RPMI configs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-rpmi_v4-v5-7-6787318ad186@microchip.com>
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
In-Reply-To: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Yao Zi
 <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>, Subrahmanya Lingappa
 <subrahmanya.lingappa@oss.qualcomm.com>, Charles Perry
 <charles.perry@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the RPMI SBI MPXY transport, the associated "mpxy" command line utility
and the RPMI clock driver to QEMU S-Mode defconfig for 32 and 64 bits.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v5: none
Changes in v4:
 - Add this patch
---
 configs/qemu-riscv32_smode_defconfig | 4 ++++
 configs/qemu-riscv64_smode_defconfig | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/configs/qemu-riscv32_smode_defconfig b/configs/qemu-riscv32_smode_defconfig
index 4629bf3acb61..772510f67151 100644
--- a/configs/qemu-riscv32_smode_defconfig
+++ b/configs/qemu-riscv32_smode_defconfig
@@ -17,6 +17,10 @@ CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_CLK_RPMI=y
+CONFIG_RPMI_FIRMWARE=y
+CONFIG_RPMI_SBI_MPXY=y
+CONFIG_CMD_MPXY=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 9d50df410a06..6f0dfe9a9026 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -19,6 +19,10 @@ CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_CLK_RPMI=y
+CONFIG_RPMI_FIRMWARE=y
+CONFIG_RPMI_SBI_MPXY=y
+CONFIG_CMD_MPXY=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2

-- 
2.53.0

