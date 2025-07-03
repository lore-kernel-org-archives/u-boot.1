Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEC5C83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 05:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EFB782CFA;
	Thu,  3 Jul 2025 07:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nujpBdvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F1B82F49; Thu,  3 Jul 2025 07:20:15 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB5F082CFA
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 07:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2F70340B4D; 
 Thu,  3 Jul 2025 05:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751520003;
 bh=qPK2ZXNtBCLVJfErqNZLSohiIYroe3AB8vCNIXzi3dw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nujpBdvhkTNZhZRrmqD4e4ZTUlMS6Lz/Bg33X4hnGeUjSyG3esyO1BXvTMdvTG4F1
 HnO8sISp7y65JFYgj6gDfs8Sd/2Y+II1QnI7zKKGA28q+5flWSw+PMPcHV3oi5wi6G
 TwvZGKmYw6ulUpetridj8HTroMrzNA3eqYi+WKVNzvMq6fe+fMXRZVENDbCNwjEGEG
 xI1N5iQwVWAYBe0CFojZGg4uRwz+6mG/Y4E5Cf7RpwYScNmaB4xiyujjgon9Jz1TDu
 d3XGnuOOytqJ3JcVnyIn3LmYauXbkbvFzX7RhcKJhF2oFr3IPmFb2trxpglecNGjgN
 NyEYejTOkEofQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/5] arm64: initialize the frame pointer register
Date: Thu,  3 Jul 2025 07:19:48 +0200
Message-ID: <20250703051951.43372-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
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

U-Boot may be compiled with frame pointers depending on defaults built into
compilers are via explicitly passing -fno-omit-frame-pointer.

To stop walking frames it is necessary that the initial value of the frame
pointer register is 0.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/lib/crt0_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index f3f279f2c39..3ff0577e9c8 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -168,6 +168,7 @@ clear_loop:
 	/* call board_init_r(gd_t *id, ulong dest_addr) */
 	mov	x0, x18				/* gd_t */
 	ldr	x1, [x18, #GD_RELOCADDR]	/* dest_addr */
+	mov	x29, 0				/* frame pointer */
 	b	board_init_r			/* PC relative jump */
 
 	/* NOTREACHED - board_init_r() does not return */
-- 
2.48.1

