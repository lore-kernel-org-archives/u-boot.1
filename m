Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABE8CD1297
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 10:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B21183F37;
	Sun,  9 Nov 2025 11:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZepCmAA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E95583F4C; Sun,  9 Nov 2025 11:10:46 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B7A83F37
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 11:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-110-120.46.114.pool.telefonica.de
 [46.114.110.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B5715409F2; 
 Sun,  9 Nov 2025 10:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762683034;
 bh=tru7sfLwxSH2HagR0e7PAjDoJZIHGs5+v8BQjhDH7q8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ZepCmAA3zu2hS2sy+6bdDdyUgUH9ucxyrC/sfAv9ZtG8mnyjGGMSlkWRx4qAg7YqR
 kB6/fKFaOrM5YriwwsLYtc1wzQQYgTCmp3PHw+TNkuXEKB6eo+hcIplxGE6u41CZuk
 kbP4Y+HqYAhATCKRktDM7TELHup8D1VBosoVEu1LkHvOFb0eOAd4X1zNG0ZEY1tx28
 MOXDGHxkoq+vZlHn9P/RvWUhb9CDHg6J2YiwzxddkNlvB/DwH3jdovJFSzygyQ7SDY
 WpPxxUfN9LDr5Fa8r3lI4csSGjGrvyi792TXEE2ukFNng+tszWJ/AMRbv3eJ0RD1hw
 nNZwIjpLRa5N10kZs3/fHdvt0b28SZK5NRJ9bsHxv/UD8ugNazH/XcDb1gF8gnHrgh
 2Qc6Hqz9QAoj8V5QUcRSZNCEUWz3KaxiAFQ1w60nHpPGloGK1sGCXr7C/HazCH+ijd
 A2uUGYvpfvLDbwkkWz7TNgODyOoYAQ3LQflowCKiYQ/04LmXxHGTYn4SCHIynYlwJs
 Fxln5a5aiGANXWmKZacWzUa69EGu4IqwO7h3VgmAiELW9zoks4mIvFnjsTRgF9TqAc
 AOnupOqLHwmVmUvSBCOiRmWFMHO7JZiBaWD78SbPoeB7UDOThxu9XROlnrCfDeqFj5
 xvLAFlbn+zOtM0LAJ2pJh3LQ=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 7/9] common: default CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000
Date: Sun,  9 Nov 2025 11:10:08 +0100
Message-ID: <20251109101010.306268-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
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

For some tests the current default of 0x400 for
CONFIG_CONSOLE_RECORD_OUT_SIZE is too small.

Raise the value to 0x6000 which is already the most common value.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/Kconfig b/common/Kconfig
index 0c25a8fc866..47d17f4e7c6 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -26,7 +26,7 @@ config CONSOLE_RECORD_INIT_F
 config CONSOLE_RECORD_OUT_SIZE
 	hex "Output buffer size"
 	depends on CONSOLE_RECORD
-	default 0x400 if CONSOLE_RECORD
+	default 0x6000
 	help
 	  Set the size of the console recording output buffer. When this fills
 	  up, no more data will be recorded until some is removed. The buffer
-- 
2.51.0

