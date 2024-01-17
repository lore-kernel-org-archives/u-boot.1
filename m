Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818D5C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 22:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 989DF8795B;
	Wed, 17 Jan 2024 23:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HYIQYzZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B588087947; Wed, 17 Jan 2024 23:24:40 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81FA987A00
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E7D8661782;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BE26C433B2;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705530274;
 bh=FUWZEpvI6YkeE+BX7nDIY2uOspTicuk8yAbNUK0wKDI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HYIQYzZMkm6OE06J3OuL9pa/vKrDY3sfP5/nkwdNwFqzvsVrQEPYzo11nhr2nxatz
 ti4T8K54lKhep8OEOiBW/RwS1gD6fKbF2Aqlk6kO7P7spur0Cv5CQs6JVe6rl5pNOo
 qGRSu5MLTFZj4WenZY4jxBo376GXTYHkegSqeoqMWoXN5LDnMyREKD59lBGEnwVQrL
 CW7XriwWTgTJvDHX0SeigByY1KzUp+HHlkXwW2t7SuQTLSfhztRonkGQjwQALSiyBI
 yi4hQNUHHhiQoQ4p9zH13MRLixa3Z8yYVzx8Q5bVTF6pO83Qy+9plVKEGlXsc06qo+
 p2kASerGWRJVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7D8C47DAF;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 17 Jan 2024 23:24:32 +0100
Subject: [PATCH RFC 6/6] efi_selftest: Add symbol character selftest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-vidconsole-utf8-uefi-v1-6-539f7ce74fb9@jannau.net>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=j@jannau.net;
 h=from:subject:message-id; bh=R/KOzk/A0b3uoB67wZJBMV9GIH6TDpOY3EDG4XdGYNk=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtQVwQsS6qzPZ2yxsRX4e2qOfFJ6lsnFoNRipZwKh8mv9
 f5femrVUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCJzshj+B1p/kOWQ3Om4x0K7
 edLL3qO85w5HBdUuPdAlqT3XZdYDV4b/4ctrG5/djXW543PKh+GJBV++/edM74Bqxc1Nao7/3GY
 yAAA=
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

Draw symbols from code page 437 code points 0x01 - 01f used by UEFI
applications to draw user interfaces using
EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.

Add a simple test to displaying the Konami code using symbols used by
grub2. The output has to be checked manually on the screen for
correctness.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 lib/efi_selftest/efi_selftest_textoutput.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selftest/efi_selftest_textoutput.c
index cc11a22eee..9e5d944fa0 100644
--- a/lib/efi_selftest/efi_selftest_textoutput.c
+++ b/lib/efi_selftest/efi_selftest_textoutput.c
@@ -46,6 +46,8 @@ u"left bottom \u2502 right bottom  \u2502\n\u2514\u2500\u2500\u2500"
 u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2534"
 u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
 u"\u2500\u2500\u2500\u2500\u2518\n";
+	const u16 konami[] =
+u"Konami code: \u25b2 \u25b2 \u25bc \u25bc \u25c4 \u25ba \u25c4 \u25ba B A\n";
 
 	/* SetAttribute */
 	efi_st_printf("\nColor palette\n");
@@ -144,6 +146,11 @@ u"\u2500\u2500\u2500\u2500\u2518\n";
 		efi_st_error("OutputString failed for box drawing chars\n");
 		return EFI_ST_FAILURE;
 	}
+	ret = con_out->output_string(con_out, konami);
+	if (ret != EFI_ST_SUCCESS) {
+		efi_st_error("OutputString failed for symbol chars\n");
+		return EFI_ST_FAILURE;
+	}
 	con_out->output_string(con_out, u"waiting for admiration...\n");
 	EFI_CALL(systab.boottime->stall(3000000));
 	efi_st_printf("\n");

-- 
2.43.0

