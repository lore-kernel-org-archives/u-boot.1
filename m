Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713B7C47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673C387B4C;
	Thu, 11 Jan 2024 14:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="X/tnRfRh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85CD287A99; Thu, 11 Jan 2024 13:58:32 +0100 (CET)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 674348753C
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 13:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.orlov@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kjuJit04/Qm+ukYhkXfjevwE+5xkuqyNXeK7qsZSU8Y=; b=X/tnRfRh4f0mAn6QJjrji6w3i4
 6OPgLivAHhRpDdoY/INBvDnfTNfRXPdgD0810YPuJOQ6i2XSjZLRBktiJr2lcgFID0963+sUiYeiX
 HlnkSAsyeSNUM6dP85EhceQp+MoRYD9un1WMqse4EHaBSPc7rZGmR/WIkjhytj+5LcZGDwnLMwF+m
 DBs7RyMTM7rvwXduIYDNddtouAYNlmGzvRFFo2fcuoEipHX9WR8cXT8ZD7oSHy75v8Og5PmjVCWIN
 iY13MP+Fw9MdloNvNu9L5iPIQVPRmKC81wN5MGxKG/bSP6HFcwsRKWcIn9lXqZ4iH8KH4K61KEXI/
 DcsBkGAQ==;
Received: from [167.98.27.226] (helo=ct-lt-2504.guest.codethink.co.uk)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1rNudZ-00432e-6d; Thu, 11 Jan 2024 12:58:21 +0000
From: Ivan Orlov <ivan.orlov@codethink.co.uk>
To: sjg@chromium.org, mkorpershoek@baylibre.com, bmeng@tinylab.org,
 takahiro.akashi@linaro.org
Cc: Ivan Orlov <ivan.orlov@codethink.co.uk>,
	u-boot@lists.denx.de
Subject: [PATCH] cmd: license: Add CONFIG_GZIP dependency
Date: Thu, 11 Jan 2024 12:58:19 +0000
Message-Id: <20240111125819.1787378-1-ivan.orlov@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jan 2024 14:08:34 +0100
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

'License' command processing code could be successfully compiled only
when CONFIG_GZIP option is enabled, otherwise it can't find the 'gunzip'
function definition (it is defined in lib/gunzip.c).

Add CONFIG_GZIP dependency to 'license' command config option in the
corresponding Kconfig.

Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 26aeeeed03..0d63cbfda1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -188,6 +188,7 @@ config CMD_HISTORY
 config CMD_LICENSE
 	bool "license"
 	select BUILD_BIN2C
+	depends on GZIP
 	help
 	  Print GPL license text
 
-- 
2.34.1

