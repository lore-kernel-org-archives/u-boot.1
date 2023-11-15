Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7F0C48BD7
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 14:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341BB87264;
	Wed, 15 Nov 2023 15:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UN7rgSrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEBDC87440; Wed, 15 Nov 2023 15:24:09 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A596E87258
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 15:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2E68940D83; 
 Wed, 15 Nov 2023 14:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700058245;
 bh=uQ+WdoQ98mwECcJqJAs9lBJwWbNyNSEie14J52zFVxs=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=UN7rgSrkLfCoT5FRly8GDPb18w6y8BtVH07s98BuqtWMy8lQQUkT/mWdK/R/mdYe/
 A1U/6sYXaw0zyg8S7ip/2utmY98ScxdJUSpERlCAp4SRx8KwIWyTZN6Uvox4Q4SxGv
 xyUx4Xe7G2T3jzrF0pUE8CfJMlGOL6ScMBTdEB4beAmZcrVtaRKIn3QLsASyRUY5Lj
 P1lb1aBMCNO7ke59m+j1IQ6U8VooeQmQHBWqpko9AjqE3eQccMAm8x0BfYaUzsVfRM
 q8yXprZCwu1XzQebttaLODZ4iePMWN5eMVOz7Se2qPvFROFHmnsN0vXOuRTusZKP7I
 jj4x0t4ZyaOkQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Zong Li <zong.li@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/6] risc-v: add ACPI fields to global data
Date: Wed, 15 Nov 2023 15:23:51 +0100
Message-Id: <20231115142355.123038-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
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

