Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B548C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 08:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E57EA81F4E;
	Mon, 24 Mar 2025 09:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692EF81F71; Mon, 24 Mar 2025 09:35:05 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9DA0981EDD
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F4ED1A2D;
 Mon, 24 Mar 2025 01:35:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.34.124.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F2B23F58B;
 Mon, 24 Mar 2025 01:35:00 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] efi_loader: fix ipv4 device path node conversion
Date: Mon, 24 Mar 2025 09:34:43 +0100
Message-ID: <20250324083443.1537006-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When converting an IPv4 device path node to text, the
EFI_DEVICE_PATH_TO_TEXT_PROTOCOL will produce the following string:

  IPv4(5.6.7.8,TCP,UDP,0x6,DHCP,1.2.3.4,9.10.11.12,255.255.255.0)

This string erroneously contains multiple protocols: TCP, UDP and 0x6.

Add the missing `break' statements in the dp_msging() function to fix this
and obtain the following expected string instead:

  IPv4(5.6.7.8,TCP,DHCP,1.2.3.4,9.10.11.12,255.255.255.0)

Fixes: aaf63429a112 ("efi_loader: add IPv4() to device path to text protocol")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_loader/efi_device_path_to_text.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
index f6889cb7399..452ec1b2e8b 100644
--- a/lib/efi_loader/efi_device_path_to_text.c
+++ b/lib/efi_loader/efi_device_path_to_text.c
@@ -181,10 +181,13 @@ static char *dp_msging(char *s, struct efi_device_path *dp)
 		switch (idp->protocol) {
 		case IPPROTO_TCP:
 			s += sprintf(s, "TCP,");
+			break;
 		case IPPROTO_UDP:
 			s += sprintf(s, "UDP,");
+			break;
 		default:
 			s += sprintf(s, "0x%x,", idp->protocol);
+			break;
 		}
 		s += sprintf(s, idp->static_ip_address ? "Static" : "DHCP");
 		s += sprintf(s, ",%pI4", &idp->local_ip_address);
-- 
2.47.2

