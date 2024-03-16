Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1A3C54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 21:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2756288072;
	Sat, 16 Mar 2024 22:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tmc0NMOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2418804F; Sat, 16 Mar 2024 22:50:36 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919BC88073
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 22:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1DBCA60A6D;
 Sat, 16 Mar 2024 21:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95ECDC433B1;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710625826;
 bh=AsUi/uNZMYWMCVyFQx4FfgLfmdg8qJK54QDHdMqrKiY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tmc0NMOd8mgLszWQ9VcxPpn0cLBTkaKFN0fVGqYHi8PkEyxA4m3h4pe0id0y6P9Tn
 RAR7RQZIJvADwWALqZ03yt/3i5+fCQwRennAyUtnRZf4820P9K7WCwAjVl7hSk+x4z
 biAJVtfyS2moBeoAAm7cmJPHXKfuBzUx6RTBYkDgXZPOSWbQn/yJDL3JT/t5ILPO9f
 IZpxlYgULhlK5+XkyqqriWqmBL5I//0RFxOYSoE89z9qud2wThZoEnt0HSQhybpTH5
 /YhcYv9ArRA83n7gQ6+che84+PJPDRuFXdfdCYOk27wYJFLxIegJnkqMBS/elHEJiV
 Y5yMwVoSeI8Wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA9CC54E68;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 16 Mar 2024 22:50:24 +0100
Subject: [PATCH v3 7/7] efi_selftest: Update StrToFat() unit test after
 CP473 map extension
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240316-vidconsole-utf8-uefi-v3-7-4e8a3d349447@jannau.net>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
In-Reply-To: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=j@jannau.net;
 h=from:subject:message-id; bh=S73V6hU7BXR4dSCPxvtFJHg4c7CFAqBG6lzmd2874Rc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtRvIgphX/pvhpSY3BJ89e7r1JpJkpyHD309FzydReTX3
 kyJvnXPO0pZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEzE/gUjw82ciw1zoue7fXjf
 o/9e5fudwpfczbmele9PqmdJ3E1d94GRYdGGqr9fLq9LWTND9tq52ieJ/ldvd/XGXK6fzqjI2d+
 ykRMA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

Test that Unicode code points which map to CP437 code points 1-31 are
converted to '_'. This ensures no FAT file names do not contain chars
which are control characters in other code pages (CP 1250 for example).

Signed-off-by: Janne Grunau <j@jannau.net>
---
 lib/efi_selftest/efi_selftest_unicode_collation.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_unicode_collation.c b/lib/efi_selftest/efi_selftest_unicode_collation.c
index 32c99caf35..ad7dfa9fb9 100644
--- a/lib/efi_selftest/efi_selftest_unicode_collation.c
+++ b/lib/efi_selftest/efi_selftest_unicode_collation.c
@@ -220,6 +220,18 @@ static int test_str_to_fat(void)
 		return EFI_ST_FAILURE;
 	}
 
+	/*
+	 * Test unicode code points which map to CP 437 0x01 - 0x1f are
+	 * converted to '_'.
+	 */
+	boottime->set_mem(fat, 16, 0);
+	ret = unicode_collation_protocol->str_to_fat(unicode_collation_protocol,
+		u"\u263a\u2666\u2022\u25d8\u2642\u2194\u00b6\u203c", 8, fat);
+	if (!ret || efi_st_strcmp_16_8(u"________", fat)) {
+		efi_st_error("str_to_fat returned %u, \"%s\"\n", ret, fat);
+		return EFI_ST_FAILURE;
+	}
+
 	return EFI_ST_SUCCESS;
 }
 

-- 
2.44.0

