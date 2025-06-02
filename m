Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF43C5B555
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 20:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF3081F32;
	Mon,  2 Jun 2025 22:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="FeCima4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED66981FEE; Mon,  2 Jun 2025 22:10:24 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2D4E81E72
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 22:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 49376576-3fee-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 49376576-3fee-11f0-beb8-005056992ed3;
 Mon, 02 Jun 2025 22:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=VbmavOC7FZ9g0autyYRyxkjx65XSykKZZnwet2C4SQU=;
 b=FeCima4FKzM22u3e8IKxN4xrvvh4XcUhRoYW3A2TnPjFsUMjpzX3AR9SCCEP5Cv3y0WK7Lye3gqLQ
 0wRkNLPtso/9hokDtAyLnDWL/HCG9e+gwXbUa6qqYpCeJmBVF9WqFjkCax3or1dgSlFukC5As/+x47
 OV0sQnWDDn1+YGKk=
X-KPN-MID: 33|3Lz0EHE57GDrYqyn+LpSVm9M4/giT8yRWzmbBO7gR7DWOlS8svTVZNYvAixAOC1
 TsQYlKEuLSXu71UFrWQFWh4nXcWHnDKtZw6ICMQILfps=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|WTTemvaTzRm4pleeEUcD1Nfk47mg1booo6Tv8b3s7X6bU5UaKIudDLxe/BDD8YD
 LdUBZh7WT1kdh5CNRHBvxuQ==
X-Originating-IP: 80.61.163.207
Received: from korngold.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 9cb56de2-3fed-11f0-9dc4-00505699b758;
 Mon, 02 Jun 2025 22:10:22 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] cmd: smbios: Fix header for type 3 entries
Date: Mon,  2 Jun 2025 22:10:08 +0200
Message-ID: <20250602201009.90885-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.49.0
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

Change from "Baseboard Information" to "Chassis information".

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 cmd/smbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 562dd7959be..ed419f19028 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -280,7 +280,7 @@ static void smbios_print_type3(struct smbios_type3 *table)
 	int i;
 	u8 *addr = (u8 *)table + offsetof(struct smbios_type3, sku_number);
 
-	printf("Baseboard Information\n");
+	printf("Chassis Information\n");
 	smbios_print_str("Manufacturer", table, table->manufacturer);
 	printf("\tType: 0x%02x\n", table->chassis_type);
 	smbios_print_str("Version", table, table->version);
-- 
2.49.0

