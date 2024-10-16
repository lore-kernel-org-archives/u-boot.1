Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0673ED1AD39
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F3A488ED9;
	Wed, 16 Oct 2024 11:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Fuohgu/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7A688F35; Wed, 16 Oct 2024 11:50:49 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E3F88EE0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 95F04405CD; 
 Wed, 16 Oct 2024 09:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729072246;
 bh=sITkICSvSNQVtwu4tkgeZ0lPP4LYMF3xAKPmAvTcihA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Fuohgu/AqXOgoSbwF6ne8zypBEn1enu2c67Fd4hHtve+46UY69KsDqS9KSB54Xejk
 wZzihJvMs17i78wzkLvTAjiiYMfxJpaG4uIHJkDccdfKC6A5ALZWZh741Mo75O98rf
 fzRvairoXUjIhxdsHF7n8y7LUrdRA0CJ1M1ABY9pwR6CSjtWiwIhIGMe7ENQ2x4nnG
 JD7CX/0/nmjU8wRry48Ytx69LD3wDUqoHPNfMsu6SofoFwnrIJqVj6EDtCBQ8/zUEU
 0hYTFIsts1LIsr/igIQNWb6nOhLCKXNlQgZdEUPrT/nYjTObxyZiM3RRBs5k8Vndkq
 3T7xqDpInkxSw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: wget: CONFIG_CMD_WGET must depend on CONFIG_CMD_NET
Date: Wed, 16 Oct 2024 11:50:39 +0200
Message-ID: <20241016095039.43106-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

do_wget is defined in cmd/net.c.
cmd/net.c is not compiled if CONFIG_CMD_NET=n.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 37894eb80d6..049a672100f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2010,6 +2010,7 @@ config SYS_DISABLE_AUTOLOAD
 
 config CMD_WGET
 	bool "wget"
+	depends on CMD_NET
 	select PROT_TCP
 	default y if SANDBOX
 	help
-- 
2.45.2

