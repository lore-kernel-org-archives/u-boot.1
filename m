Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F46C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 15:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D408760C;
	Tue, 21 Nov 2023 16:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="k1Isln/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5395E8760C; Tue, 21 Nov 2023 16:28:09 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605B387611
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 77B3D42F44; 
 Tue, 21 Nov 2023 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700580480;
 bh=uUf862BTNIW9VmyldswXcVc44Sm4WYP6fb2D9VBhKo0=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=k1Isln/QHifKpx/+zJhXDrI/7/LvWFcpJapPAZoHMF6zoi0tVejHyk/QLll1We1bo
 xBCSVYi/4cAhOrzwxeD6YFGcCJsmXDR8lP32fnEU700Q44J1s0ksx/W7t81ImyYbml
 AGKnysKzbcaclvpTVfGBEj/GNToww/ONvbORSyZIsXhzua6f6Hh6y4oH9j8JGV1FWt
 2ykq3pKgdFiRHHB9NxO1U3pcmAP4xPs4nyUiq7CpZQyl2qbp3ib9rAnHQ9n8cZMQb8
 RfXjVnvaPtoHR/nRwY7LyEIbe4dEbsOT5AGbRiGJNMyFk0Wi4ObJ65Ysq4x1b92SjH
 PMG8bNHJMGhvw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/7] risc-v: add ACPI fields to global data
Date: Tue, 21 Nov 2023 16:27:36 +0100
Message-Id: <20231121152740.24783-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
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

Add fields for the location of ACPI tables to the global data.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 arch/riscv/include/asm/global_data.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/global_data.h
index 937fa4d154..a8f6a217f1 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -32,6 +32,10 @@ struct arch_global_data {
 	ulong available_harts;
 #endif
 #endif
+	ulong table_start;		/* Start address of ACPI tables */
+	ulong table_end;		/* End address of ACPI tables */
+	ulong table_start_high;		/* Start address of high ACPI tables */
+	ulong table_end_high;		/* End address of high ACPI tables */
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
-- 
2.40.1

