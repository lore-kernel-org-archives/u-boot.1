Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D821CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 14:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1AB283939;
	Mon, 13 Oct 2025 16:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3896883939; Mon, 13 Oct 2025 16:21:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4CDEF83695
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 16:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C694E113E;
 Mon, 13 Oct 2025 07:21:19 -0700 (PDT)
Received: from debian (MacBookPro.nice.arm.com [10.34.128.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A5C9A3F738;
 Mon, 13 Oct 2025 07:21:26 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 2/2] lib: uuid: add efi debug image info table guid
Date: Mon, 13 Oct 2025 16:21:09 +0200
Message-ID: <20251013142109.77652-3-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013142109.77652-1-vincent.stehle@arm.com>
References: <20251013142109.77652-1-vincent.stehle@arm.com>
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

Add the EFI Debug Image Info Table GUID to the translation table used by
uuid_guid_get_str().

This allows to print a human readable table name with `efidebug tables'
instead of "(unknown)".

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/uuid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 8d99b540d9f..e0f8d55438b 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -256,6 +256,10 @@ static const struct {
 		RISCV_EFI_BOOT_PROTOCOL_GUID,
 	},
 #endif
+	{
+		NULL, "EFI Debug Image Info Table",
+		EFI_DEBUG_IMAGE_INFO_TABLE_GUID,
+	},
 #endif /* CONFIG_CMD_EFIDEBUG */
 #ifdef CONFIG_CMD_NVEDIT_EFI
 	/* signature database */
-- 
2.51.0

