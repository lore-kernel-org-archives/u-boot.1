Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFD7C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0704F8776E;
	Sun,  3 Dec 2023 14:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QJsxnr+8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TKS4oNS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6815087716; Sun,  3 Dec 2023 14:17:16 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1DAD875DB
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SjnQK412sz9sdB;
 Sun,  3 Dec 2023 14:17:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHaeLuGhY9j+V2p8DyPWZD8p7lxFWmFM25ZUgHTh9qw=;
 b=QJsxnr+8AaWKQytXyMdvznBJdGiy6b6uiuvzaaIaq04JXsRXxeMx0vgicUQ35evsjLbaY9
 C3Zq4DJYMsHSCMAKVzkpxq5W8daX8FC33wUjAogygOTb6+Q/6wwrMOlAhyQO7v9vNduwJD
 9cZocj/pULaajEFaVMkP3+AJx++AqC0vvj7jzp6kktfUZM+vXWqKpVtQ+auuU/na9Cki9j
 zW0W6zQBbV5QPPmDvOD4wNkl3qnwTOLhVEIr+ZwWZ2wwCw//CMGncZmLaiR1h2RMMdSZ7V
 R9LLd3USdaFiQ8OZ52MWFreEM3xa3vVBMsz3IsYK9jZZNmtDqIm5HBpNps48Ew==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHaeLuGhY9j+V2p8DyPWZD8p7lxFWmFM25ZUgHTh9qw=;
 b=TKS4oNS87Wn9v6Q6X5OOFhwGbcix5KliCjOXXW2cxLe8Trf210o54xjYfxxp4PwH0Of2oz
 JTBgYBDlO1qAAYhPJ981CsgnxDzfnLCDvMZoqqY2IChe9LsgVpZCzCcagWM0YsyoaeDMrs
 d6nM59zysfqTV+a+ViJitT0qJQ0IvosJh3if7cm+r2eAjfD/n5e0BeUVKwA838heb+fnY+
 uw8Zi24o196Wl+XEh+Rxrljq3iA6HfpCKc0vWc3oZjYJrHLj0pKuqlS9NXoEgEBApGE7EC
 mkjNWnnsW8D8EG0s7XMAtpbCRpgMJUNl8mOyGXFZQl4nlbfnImdhZxaATmKRyw==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 09/12] ARM: dts: renesas: Synchronize R-Car R8A7792 V2H DTs
 with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:21 +0100
Message-ID: <20231203131635.119191-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 92d3ea632368da3c4dc
X-MBO-RS-META: sdesbd1cj6fej3pngstg1frnmn4s61a4
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

Synchronize R-Car R8A7792 V2H DTs with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a7792-blanche.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/r8a7792-blanche.dts b/arch/arm/dts/r8a7792-blanche.dts
index c66de9dd12d..6a83923aa46 100644
--- a/arch/arm/dts/r8a7792-blanche.dts
+++ b/arch/arm/dts/r8a7792-blanche.dts
@@ -239,7 +239,7 @@
 	};
 
 	keyboard_pins: keyboard {
-		pins = "GP_3_10", "GP_3_11", "GP_3_12", "GP_3_15", "GP_11_02";
+		pins = "GP_3_10", "GP_3_11", "GP_3_12", "GP_3_15", "GP_11_2";
 		bias-pull-up;
 	};
 
-- 
2.42.0

