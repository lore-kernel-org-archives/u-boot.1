Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB51EC5AD2C
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97066605E9;
	Sun,  9 Aug 2026 01:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2eQPssz42Bu; Sun,  9 Aug 2026 01:36:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 346A960617
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239389;
	bh=PqoHr09KUCZelRmFurv1SscO/A2p8FhCGbXu0o/1ZvQ=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=ABY+6ZQJy+Mr5ULfQGcL4hCHGtdRk8jJ90BCb6tQm2k3/ELjtvmSAzGcTFESGPXZm
	 tDDTzJj+BtwDrlNCr+ilXlHnPDVq8DNg5cRLaTflwk7Y3YrtVHNyWutxC6fo1E7kUq
	 NLxqkOLBW2trKNrAuWbL3y984AMcT3152dEOLX+o59z+F7TMlQaTxED12EM4WnnaDh
	 ESXARaKG8EqT4ADIFV9vTCCxIKVYRI7/gQTWw+nyAhlciQ3uiL7dlXgpRpFe4F0L7d
	 eeJJhJXxsSKuCt0YfY4XTzMoDmmbyQBqxKH9gTpPgaXO6Fr6Dn115fXcp4y+yavlNs
	 nUSiN0hDsygnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 346A960617;
	Sun,  9 Aug 2026 01:36:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27F74218
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D72580B89
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mB7P3E3rOSK2 for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:36:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3DCA280B6D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DCA280B6D
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DCA280B6D
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:36:26 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hHgTM6spMzKryM;
 Sun, 09 Aug 2026 03:36:23 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: board: renesas: Document Retronix R-Car Gen4 V4H Sparrow
 Hawk SPI NOR layout
Date: Sun,  9 Aug 2026 03:35:31 +0200
Message-ID: <20260809013619.444419-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 47ugsn16jgqtk3iuqii8wn5utu3zihwg
X-MBO-RS-ID: 7ba9a85cc206679abad
X-Rspamd-Queue-Id: 4hHgTM6spMzKryM
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PqoHr09KUCZelRmFurv1SscO/A2p8FhCGbXu0o/1ZvQ=;
 b=i1THxRVIGjCLGVu5gaxjrriLCWtFzJ5PZ2IsdCt3tdbnuebcbOfmf1tZYZ6A1Rkx5jlvRI
 5abSYWjcIknWYxJFqCMS6nDUOpw07gStQNS4Cww8iLDv+dRh9Y1kp4A6iKhiYwpTkMOSZC
 EwTNJdHAe8tQopyNzy963u44HrF8L9LMeOkOfPwfciK0kTgSBEbvfkJcy+24iQtkwYYg4O
 GOypeQwFvgsGyUG+hfdRi3TiOQFXkDNBRCycDqWH8ambYcgECvD6gt5BLZV2kQDXEY1RUi
 YDXQMFvFjVV3TwQN/2UTxLqbg8nVqkNk0zgl6wPaqvgQrD3m+pd6cceJstwc+g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PqoHr09KUCZelRmFurv1SscO/A2p8FhCGbXu0o/1ZvQ=;
 b=TpyHgNn6WrTbmkJSW9paiMY3nkW/LukBHz1tcX6b3zqe4pLj9XR+078yIDoV5uzDzvERBH
 cnYAUEIIDZW5PQOZvkAdv1rMR1fWy6+lwkmUtj4pOtUsSejHLnWTKrlcJgHWb80cuhnLmQ
 Pu7+MQrFoyrcxU+sdvFWKzmAWhx1JrRaNXP8neFPZQ/FaT5oYLYw3fOYB6hcvGKKxVDmqC
 d7nuR/vK7XKd7wYFiG17L6TxNMPKDfRPAdn7u4/5SCBKkcwhXiu9g6srpbiWgVB+sczRPh
 ioVksKe/YyJwomce+1GS8E0vnv3mKi5AII4ZgXm1vnJRAXZVrZhbUc7Rlz5Zbg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=i1THxRVI; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=TpyHgNn6
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TpyHgNn6;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
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

Document the SPI NOR layout, placement of U-Boot bootloader,
U-Boot environment and optional PCIe controller firmware.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 doc/board/renesas/rcar-gen4-sparrow-hawk.rst | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/board/renesas/rcar-gen4-sparrow-hawk.rst b/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
index a1b92ecab57..7d006a3d2b1 100644
--- a/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
+++ b/doc/board/renesas/rcar-gen4-sparrow-hawk.rst
@@ -59,6 +59,27 @@ Finally, write U-Boot into SPI NOR:
 
     => sf probe && sf update 0x50000000 0 ${filesize}
 
+SPI NOR layout
+--------------
+
+The Retronix R-Car V4H Sparrow Hawk board 64 MiB SPI NOR layout is listed below.
+
+.. table:: Retronix R-Car Gen4 V4H Sparrow Hawk SPI NOR layout
+
+   +----------------+----------------+-----------+---------------------------------------------------------------+
+   | Start          | End            | Size      | Content                                                       |
+   +================+================+===========+===============================================================+
+   | ``0x000_0000`` | ``0x02f_ffff`` |  3072 kiB | U-Boot bootloader ``flash.bin``                               |
+   +----------------+----------------+-----------+---------------------------------------------------------------+
+   | ``0x030_0000`` | ``0x033_ffff`` |   256 kiB | PCIe controller firmware ``rcar_gen4_pcie.bin`` (32 kiB used) |
+   +----------------+----------------+-----------+---------------------------------------------------------------+
+   | ``0x034_0000`` | ``0x3f7_ffff`` | 61696 kiB | UNUSED                                                        |
+   +----------------+----------------+-----------+---------------------------------------------------------------+
+   | ``0x3f8_0000`` | ``0x3fb_ffff`` |   256 kiB | U-Boot bootloader environment copy 1                          |
+   +----------------+----------------+-----------+---------------------------------------------------------------+
+   | ``0x3fc_0000`` | ``0x3ff_ffff`` |   256 kiB | U-Boot bootloader environment copy 2                          |
+   +----------------+----------------+-----------+---------------------------------------------------------------+
+
 Bundle TFA BL31 into Linux kernel fitImage
 ------------------------------------------
 
-- 
2.53.0

