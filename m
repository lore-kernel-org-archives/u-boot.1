Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDCEC43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 08:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75FC84832;
	Sun, 28 Jun 2026 10:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AERN9QTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC8C848F3; Sun, 28 Jun 2026 10:28:17 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD4E8490A
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 10:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box
 (dynamic-046-114-110-002.46.114.pool.telefonica.de [46.114.110.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 48E56420A6; 
 Sun, 28 Jun 2026 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782635294;
 bh=Mkfxbnz0mTr4tB4BQpT7GWqRmG+HCnk4b3x/Zh28+xk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=AERN9QTLefnkRbwNLQ5jWm/oUBUqMbhmmHPNKI1L5bLrS2DgPmbqzjfZidYuSxPBV
 PfLVNCaM/j2oYwXfVz784R+KNQq5TZ9ICSU84umdhdgvxtU/rt0ZadV9U2S6YcQ/Yi
 0n6VgrhK7nBl9lR7ZHYndrIIuQtkLMTBtf3jIdHb7PDh+euxsx+ZnKmZroB35b9FEb
 Hs4qDNEJ3k5a3DbycWirhRZQrU8ITzgrr85omxlX7PUXL6hB7TUDE9ipYvoNJKp8l3
 YbW/+kqzsNM0+vc4/380uveXToxa3MlL2+qCjdK+GSQvxT71i50fLJyWoJB9iAwqoC
 Gn/vXUH9spNN+3EcRUypCHeaeLfgDp64WEeX30oCpSAz8REZLxXYfz4ZG7dFo0+bBi
 TUX3kO0znCNbPWFaSna9DTeXud1DDpJdfhxGf8Wg4VEdjOm7AwQiDabf/hnU8zewyZ
 4xcRwr511ad8KiwJsPOmwYWZDjPcSUwfHQo859mAjYiSkDKw3zNlXBMFv/cv4FGzaL
 HbVL5bXzVFgFjvHNibMIiCo6aBDWLQbCtqQvFEhqT/ODbMXU9G6Klfshkjm0Mw1vya
 QZR8QGlA3M3iVvyHJcFYcYi8eDImuoW1o3xfdkeNHmxGbHUusEqFzcxFKYAH5GFy63
 vswGt7qlkWXxVtZ1sdHQn85o=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 04/11] efi_loader: fix void* check in open_file_system()
Date: Sun, 28 Jun 2026 10:28:02 +0200
Message-ID: <20260628082810.175862-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
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

The UEFI specification requires FreePool() to return EFI_INVALID_PARAMETER
when the passed buffer is invalid. But it does not well define what
checks are required. Therefore we try to avoid passing NULL to
FreePool() in open_file_system() used by dtbdump.c and smbiosdump.c.
But we check the wrong variable.

Check the pointer to the handle buffer, not the handle.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	rephrase the subject line and the commit message
v2:
	new patch
---
 lib/efi_loader/dtbdump.c    | 2 +-
 lib/efi_loader/smbiosdump.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 1e72404ecc1..865edc33a97 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -350,7 +350,7 @@ open_file_system(struct efi_simple_file_system_protocol **file_system)
 					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
 	if (ret != EFI_SUCCESS)
 		error(u"Failed to open simple file system protocol\r\n");
-	if (handle)
+	if (handle_buffer)
 		bs->free_pool(handle_buffer);
 
 	return ret;
diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index 974728a43af..494c3d18945 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -248,7 +248,7 @@ open_file_system(struct efi_simple_file_system_protocol **file_system)
 					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
 	if (ret != EFI_SUCCESS)
 		error(u"Failed to open simple file system protocol\r\n");
-	if (handle)
+	if (handle_buffer)
 		bs->free_pool(handle_buffer);
 
 	return ret;
-- 
2.53.0

