Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31D8CD8C85
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 08:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED3CD846A7;
	Tue,  9 Jun 2026 10:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qSov+Td+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C308484F; Tue,  9 Jun 2026 10:07:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 143EC8466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 10:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9618F2681;
 Tue,  9 Jun 2026 01:07:16 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.27.167])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4ED3F93E;
 Tue,  9 Jun 2026 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780992441; bh=F+h++MpHLjeQRXQSYCPOg1j2CODd/F5tAGYwY0lL4SY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=qSov+Td+Y2AUoPLsLQIE6fMqlP8ZjjshIZ/2CAWFclXGkTTshJHte8c0DKfnVs9/n
 5BUK9vojQsBgJihe9gjQdupEIQL5zPlJoBnT70oB2CRh19da/Hu0UC6SuAGaU9iRpQ
 Ks52/b899lUDCx0fBnWfROqpylVjPlwyzfcodEN8=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Tue, 09 Jun 2026 10:07:04 +0200
Subject: [PATCH 1/2] lib/efi_loader: fix block io revision
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-rev-v1-1-0ccae5bf0fc5@arm.com>
References: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
In-Reply-To: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=F+h++MpHLjeQRXQSYCPOg1j2CODd/F5tAGYwY0lL4SY=;
 b=owGbwMvMwMV42vNHWNlitimMp9WSGLLUT26z/n+R3b1A9q3oQYEHHzz8ooT9ZkywynR4MeWXp
 Zj+RrVrnYzGLAyMXAyyYoos1xNEFvRFBQgWVGjlwAxiZQKZwsDFKQATiTJm/1+38/G31HDLaUue
 Bfgv09pstmfCFz+9S77NjKxZzm8i1W7pdl615OJ8Yqbtc52Rs2+C70vzRGv23eI/Xxq/1k4Prf8
 X3P9bpmYhe/gT17NTS68+LzB49ZzZtur2hBPxx1ZOfDmRJeFA+KTXLd8vTZsTUMmZq/ff8VT9wU
 mSaYu8mhq0/3HN4dldfLxuiV/xL8Fnk6//6E+syOmutPr0Vz++LlA08vP5LVIfVkRNtTsfNutak
 lvc+Tw5ldYZMTwuuzYcz1H+KT53SazRnXD9z61LozMlxD+cEg3bdkDCUWdyyUNGh4cV22UcWt1Y
 WFwZeP5NmXfmRe8s5y0vo1TffOVP7ew/ZpAJFJ7vbZAPAA==
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

The Revision field of the EFI_BLOCK_IO_PROTOCOL structure must be set to
one of the two valid values [1], but this is not initialized in the
efi_loader; fix it.

Link: https://uefi.org/specs/UEFI/2.11/13_Protocols_Media_Access.html#efi-block-io-protocol [1]
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_loader/efi_disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index f8a57539ec6..4a3ace3a304 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -305,6 +305,7 @@ static efi_status_t EFIAPI efi_disk_flush_blocks(struct efi_block_io *this)
 }
 
 static const struct efi_block_io block_io_disk_template = {
+	.revision = EFI_BLOCK_IO_PROTOCOL_REVISION3,
 	.reset = &efi_disk_reset,
 	.read_blocks = &efi_disk_read_blocks,
 	.write_blocks = &efi_disk_write_blocks,

-- 
2.53.0

