Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91EDCD5BCE
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB3283E45;
	Thu, 13 Nov 2025 12:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pFsgCU3J";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ol5W3Efi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E1FB83E46; Thu, 13 Nov 2025 12:56:26 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3EDA83E1B
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d6dyw3tJdz9tWZ;
 Thu, 13 Nov 2025 12:56:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763034984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O7dD8k+DXKw6sOajqmq3zSeMwnDjEjozj1ZxT3EHF3Y=;
 b=pFsgCU3JKkISUqWX1S75Ka3hszxVZsUCQUOD8qZOT35TY4gkS21fv3arOIhCdZlnB96sfZ
 fMp5YrHqGlav/pxwccNmmPAbrQOy0WAgMRVMHYZOoXIW3c55WM/JyIyEfM9iFDdNCjlzlc
 zk4cEmSWLSiXRbmJyJQC8Yhi/2/eD2jvQHkPYHWc6cV8vhte9gqYPInXBfmmwF8qmeeNzi
 qewACJlI6ysjkiAQryrsR3cuB6nmQ/RZCq9HmYjQjvgrbgQvuAQoq6diFNAk7kI03CcjG4
 +eqiHv3tigV1oNiGVMmEhw4EfLN/OCKWM0WSQRAEdmkjggFVgLDdfPcSGE4+Og==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763034982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O7dD8k+DXKw6sOajqmq3zSeMwnDjEjozj1ZxT3EHF3Y=;
 b=ol5W3EfiobGN1jfi6jPT6XFSRzH3BfUrc6cdFq6UfAUoO3WwTx96q9x3Mvkw0XZQVOd/Q4
 8vUQpG2hIF6GIK3/tGdfApxe0agZXK0FTYIDzfw3VKhQa407cymhoQ7hySq0H6qpft7zgR
 INoyBW7+s90seADN9KOaSMLuGQG/s8q10iDy1p8knFWTO+SmK8dqCJewQRanE339rjzAvN
 VKkKKyCRzjkwxNrXEnLzn7BJQwnLoNXOvA833u1BQvJRXXoDOwcUNDeUu6OtS+Ni8VZdal
 Vm/+znge36XcitEbmAXPMiSk9gW9WxqgjDqFcUJMI3gR5TESE4IEXqrv5mrhOg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] MIPS: Assure end of U-Boot is at 8-byte aligned offset
Date: Thu, 13 Nov 2025 12:56:09 +0100
Message-ID: <20251113115618.947927-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 02671388e27e3db2ae9
X-MBO-RS-META: qg5f61o3t985c94jtxywzwy1hdad8g5g
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

Make sure the end of U-Boot is at 8-byte aligned offset, not 4-byte
aligned offset. This allows safely appending DT at the end of U-Boot
with the guarantee that the DT will be at 8-byte aligned offset. This
8-byte alignment is now checked by newer libfdt 1.7.2 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/mips/cpu/u-boot.lds | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cpu/u-boot.lds b/arch/mips/cpu/u-boot.lds
index 9a4ebcd1515..133ea05df3d 100644
--- a/arch/mips/cpu/u-boot.lds
+++ b/arch/mips/cpu/u-boot.lds
@@ -37,7 +37,7 @@ SECTIONS
 		KEEP(*(SORT(__u_boot_list*)));
 	}
 
-	. = ALIGN(4);
+	. = ALIGN(8);
 	__image_copy_end = .;
 	__init_end = .;
 
@@ -56,7 +56,7 @@ SECTIONS
 		. += CONFIG_MIPS_RELOCATION_TABLE_SIZE - 4;
 	}
 
-	. = ALIGN(4);
+	. = ALIGN(8);
 	_end = .;
 
 	.bss __rel_start (OVERLAY) : {
@@ -64,7 +64,7 @@ SECTIONS
 		*(.sbss.*)
 		*(.bss.*)
 		*(COMMON)
-		. = ALIGN(4);
+		. = ALIGN(8);
 		__bss_end = .;
 	}
 
-- 
2.51.0

