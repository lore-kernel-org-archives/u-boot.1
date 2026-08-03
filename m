Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B38C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF9C46069D;
	Mon,  3 Aug 2026 20:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JeXaoMMAVKGf; Mon,  3 Aug 2026 20:57:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 174F360683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785790662;
	bh=VRT1ziUHeodXkgUxeunc7Ab6K0Q+FudBgYcV6WSMcuo=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=uVkAOGT7VEMOlBfwW/u6hdwZHL61O/EqIzUQqqBr6QmG29Na4L3httN/orbqzIM5f
	 vCwOiRacZXBcCHYPVZ99z6j9skJDno5VyV/ZJjZ6vm7osa+nsuGa7WIrXjAGEFO5vX
	 Se5iC3st8pQb3mG7Kba1k9jCC4GS9YY7BbyXySF8AKdSW5g3fxTZ3KCG9W6F0u9Py5
	 DTsCGWDVB+eZkzmcV804YgltK1Ncuh9D9I0wrZgj0DE/zwBeVLVodVJ6F4W0QmWqDN
	 O3WArBTXyAYNKxVEKJEaxMJeIcAM4U+fA1kDRou9j7k3vURGdOTCZvv3fWJ+EwEIyw
	 rj2YnjwbTBi/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 174F360683;
	Mon,  3 Aug 2026 20:57:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9234A2DE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8FDBE60683
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P5nUHmkXGCLL for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:57:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C78826066F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C78826066F
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C78826066F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:39 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hDTX15r2WzKmXr;
 Mon, 03 Aug 2026 22:57:37 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: spi: renesas: Add R-Car Gen5 DT compatible
Date: Mon,  3 Aug 2026 22:57:15 +0200
Message-ID: <20260803205733.134673-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: efc7c2e3d57f95c08a1
X-MBO-RS-META: qxrf9rt4ed3i7ithoywpkk74fnx14sbi
X-Rspamd-Queue-Id: 4hDTX15r2WzKmXr
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785790657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VRT1ziUHeodXkgUxeunc7Ab6K0Q+FudBgYcV6WSMcuo=;
 b=MgKDjo2a1KavQZJIUqdtZ2HW3hUvqAnesdRyUW1cI383ZzLFQRKmnn8GlHFgOUBbs+bS52
 7/7WVCV2Th4H7zgPWu+PYx4aVDkozH0lP/t3ewfbS9sGq7Os2apEtAxWgLU2wHmCAdDa39
 goKvRX5b1rRbgSjQfptxvzns6jjbl5SBRLd25dzg808TW0hXKRHxCvZXV8wCoMYg0w4NQO
 xZBvyPBkW8tnMJ9ASqGtNHx64RI4ny9plh6gFaeDzmgxphqjVuu7QjVYI882H75ulEdhPl
 +nEqljJG+unOLLtMQkS7d12gCPxxfVx+a76IiTFJ4Z4S59Lqr6WdTqDvHt2u2A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785790656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VRT1ziUHeodXkgUxeunc7Ab6K0Q+FudBgYcV6WSMcuo=;
 b=Nck3RQ+ni5TESv9N5smF73MGYWeb0Lxf0fxw/r7IHThSqCZy9CMMUUzAjcYuMP6pDSlyUf
 BFWoPwLpxdZfe5yv6UP/tOraOht6yGsAegjCbXoreBOsgYpWrsx1/ZvtR3pkoRCmMJTX4b
 yChEaepS46xHiUpxVLzVWiZznbmZbNrKpNh3Gg5XFyUJnSpJuB0eQ4ByzZX03IsTG6XHJ0
 9EXNcYdR0L13WwfbCuR5k/fLXylbTyH8s8dL4saBiBNzhwGqjiWo90PJqHpJKXgxlHyiuS
 QFkn06C8IGCAcUW+6RRs8oeM55JHNsY6fdkVQzqGdbHYjiQ/f8NMpBBcQj0kxw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=MgKDjo2a; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Nck3RQ+n
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Nck3RQ+n;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add device tree compatible string "renesas,rcar-gen5-rpc-if" to
the driver to match on upstream RPC DT node in R-Car Gen5 DTs.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/spi/renesas_rpc_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 640607793c3..76eca5389a2 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -466,6 +466,7 @@ static const struct udevice_id rpc_spi_ids[] = {
 	{ .compatible = "renesas,r7s72100-rpc-if" },
 	{ .compatible = "renesas,rcar-gen3-rpc-if" },
 	{ .compatible = "renesas,rcar-gen4-rpc-if" },
+	{ .compatible = "renesas,rcar-gen5-rpc-if" },
 	{ }
 };
 
-- 
2.53.0

