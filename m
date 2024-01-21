Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FA3C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 13:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25CE387708;
	Sun, 21 Jan 2024 14:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XJUkFZ9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B0E8771B; Sun, 21 Jan 2024 14:42:06 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9A687705
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 14:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AEBC840031; 
 Sun, 21 Jan 2024 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705844522;
 bh=cduD+GoQGvBLYXszY/nZqpq/cb1VaXR8lGf8xyRxPvc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XJUkFZ9IG4wIAeevuM9k92xjRPfTzmeAn1p+Jj9ke880l2sc70Fny0Q+Yb20eu4kM
 3op9kslMeVuboQMjELjWwXHQJLlJXXUdtDh8d0cInX7ONx57T8R1jBwpvahpG6WcL3
 izOhwTXTgJCMvoFMY+gq2j4tHXgs0M7ACmkdIlmEWML0+dg0gyzPWOEEtqIsEUiIOB
 gBCROF0t2k09XveqEGd0+H1TgNiANeSVCq/raXdJ5Aq4xzbST+Nhf8wV1IMGy1JL6G
 Xe/rYtb6n1Zyy97y7vXrHN1pM1fGk8v5XppkLdQp2TCguL3eLe0ehCNIHBawVnh8C6
 yQf5MWin+M6KA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] MAINTAINERS: add include/acpi/ to ACPI
Date: Sun, 21 Jan 2024 14:41:59 +0100
Message-ID: <20240121134159.173678-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Add include/acpi/ to the realm of the ACPI maintainer.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index da477a4e6ad..d8284da0ddb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -55,6 +55,7 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	board/emulation/configs/acpi.config
 F:	cmd/acpi.c
+F:	include/acpi/
 F:	lib/acpi/
 
 ANDROID AB
-- 
2.43.0

