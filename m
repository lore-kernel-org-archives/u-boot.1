Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6582C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 13:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3CE82BCD;
	Wed, 18 Jun 2025 15:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="BE+0SDDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A4282B20; Wed, 18 Jun 2025 15:26:05 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39B5A82C55
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 15:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=peD62Dp4moncuqLxKZ1vRHWMPtsIf8Nr//tBHenChPo=; b=BE+0SDDJ8Mrh8273ngkw5VKWwG
 NArDukaafzAayaR1fW6NGWKbW6lj1EypkT8/q1EpejjdeP2WrxnKWB1Uz5KBpuMX97jP2Z5OWlNyh
 l0qTneJzJzRac/5TXfS6QhW5alnUj+IEYI2oAiGMDMb9M2P7MgXlv+IIT2oVUoz1Qu8A=;
Received: from [184.161.19.61] (port=41656 helo=pettiford.lan)
 by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1uRsnf-0005ab-Fx; Wed, 18 Jun 2025 09:26:00 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tom Rini <trini@konsulko.com>
Cc: hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 u-boot@lists.denx.de
Date: Wed, 18 Jun 2025 09:25:37 -0400
Message-Id: <20250618132538.855803-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] cmd: tlv_eeprom: improve mac_read_from_eeprom() log messages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

mac_read_from_eeprom() always display debug infos, and this messes up the
display of the "Net:" section details:

Before:
    Net:   EEPROM: TlvInfo v1 len=172
    eth0: ethernet@11c20000

After:
    Net:   eth0: ethernet@11c20000

Fix by moving unconditional "EEPROM: " header into each message and
changing debug message to use log_debug().

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 cmd/tlv_eeprom.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
index d7c229e5441..86fee7771a4 100644
--- a/cmd/tlv_eeprom.c
+++ b/cmd/tlv_eeprom.c
@@ -1033,10 +1033,8 @@ int mac_read_from_eeprom(void)
 	struct tlvinfo_header *eeprom_hdr = to_header(eeprom);
 	int devnum = 0; // TODO: support multiple EEPROMs
 
-	puts("EEPROM: ");
-
 	if (read_eeprom(devnum, eeprom)) {
-		printf("Read failed.\n");
+		log_err("EEPROM: read failed\n");
 		return -1;
 	}
 
@@ -1082,8 +1080,8 @@ int mac_read_from_eeprom(void)
 		}
 	}
 
-	printf("%s v%u len=%u\n", eeprom_hdr->signature, eeprom_hdr->version,
-	       be16_to_cpu(eeprom_hdr->totallen));
+	log_debug("EEPROM: %s v%u len=%u\n", eeprom_hdr->signature, eeprom_hdr->version,
+		  be16_to_cpu(eeprom_hdr->totallen));
 
 	return 0;
 }

base-commit: 17012e3068d047ad71460f039eeb0c3be63f82a0
-- 
2.39.5

