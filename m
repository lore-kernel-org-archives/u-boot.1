Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F06C83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 05:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE2982063;
	Thu,  3 Jul 2025 07:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MR/8iE8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B0980E9A; Thu,  3 Jul 2025 07:20:10 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8702782A76
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 07:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1E8EB3FAF6; 
 Thu,  3 Jul 2025 05:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751520000;
 bh=4K3tpYtaAPgNA5oDwo545Cs0FOylP6R3P+ZNf3r51ZE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=MR/8iE8TNLzSnaNyFwc3XnyZ9ynkBwcJuIgvdvYHdMWtP/gJ4biv7aVfd9NPynaVk
 T2b6OAUrx9luRQy3yfM8xJ0FYXWAEEPY+guzzO8geCmnNYtLzgumV2tz8niB9f2sgI
 kvUFwLH0lwSurhAsKRm8cTRTBJSa3vPFZGh00oCoyDr1I/0/JPtpEjn1PkWTUyEfL/
 YZPvm/lEBDTaB49rX6Aug4Dqk7DLYXnl80CSr3z+7/53PB/dsz8t8agRoJJqtPWY4J
 ka6jstAfC3hdvmrV79pAAXPPEM3e54tckiy0jFyCWBdnRFM0ZAbt4cvcGs7YHYSsBA
 Kn3YZymju5tjw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/5] cmd/exception: missing include string.h
Date: Thu,  3 Jul 2025 07:19:47 +0200
Message-ID: <20250703051951.43372-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When building qemu_arm64_defconfig with CMD_EXCEPTION a build error occurs:

    In file included from cmd/arm/exception64.c:87:
    include/exception.h: In function ‘exception_complete’:
    include/exception.h:41:23: error: implicit declaration of
    function ‘strlen’ [-Wimplicit-function-declaration]
       41 |                 len = strlen(argv[1]);
          |                       ^~~~~~

Add the missing include.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/exception.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exception.h b/include/exception.h
index a7f21e73d75..0d4dff49954 100644
--- a/include/exception.h
+++ b/include/exception.h
@@ -6,6 +6,7 @@
  */
 
 #include <command.h>
+#include <string.h>
 
 static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
-- 
2.48.1

