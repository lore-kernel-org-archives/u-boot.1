Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A94C49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3454588CB1;
	Sat,  3 Aug 2024 18:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701717;
	bh=Uy1na3uU2tCsjupadWiVhCBzIafv8KGeWHRmibVppdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IxIJBnaPovDT4k9nUsxxjHrWbG+ombN5XZKsPJBdKEJgIaRzmgXqMzC/OkMLOcEq5
	 vA5h7FZFi8zaOHK10yWtUTx7xOJ/Eg8cdlRISTtl0Vtp9hCc5jurLrzKLCx62LWyS9
	 ZrWDF0f+0lk1nDLMdl0QxC9vJkrU5F54EoooZtEOLw8ef2qpAHX7W0vs4JAXjgTkMt
	 pGWBVk69hNPIeG2N7DAda+ZN8vgw0MG4U4O+PaYYxVV8coEf/9aOiN6TZyd4aeHkeu
	 +KMJs5arsih6ft02KrR4pSy/wr03uiqPxEY72AWxMGP17X+kTsEE8wYWWRCZGAvRub
	 BPn5XBNwJ5R7A==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7136388C75;
 Sat,  3 Aug 2024 18:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701714;
 bh=Uy1na3uU2tCsjupadWiVhCBzIafv8KGeWHRmibVppdU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Qs8KbzCF1r5HSg9MR1oC3OOdjpt2Kx4fD5aAFuLmeCZQFcuH8QAoXQKYpOwlkzDOm
 qxU9IKq6NaL1Za45/Utx3KPCeVeWZYbhPbZi9tbiM6zRugWcUONfqtmw+PvteMDijO
 dUS2rM2Jz5kagPYqgrP6qX5fv3098u++cw6qttjJzPPrcVuCn0YUedSU2IoOUPmehM
 akceB5Q0a9H+qZHmFq7iT1uwyhFaVWAQZJe45zbKREzrJ3tefc8R5P+CKQKOVsMDNq
 LO88e5Ql9A5o5adqgtF8nxevwkk5cVuySApelxm8qr1CkjKTTkpGKu6rMH+qexFnH9
 4rQ8/YaQ0xPTQ==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/11] board: chiliboard: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:04 +0200
Message-Id: <20240803161513.486062-2-agust@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240803161513.486062-1-agust@denx.de>
References: <20240803161513.486062-1-agust@denx.de>
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

Conversion to DM_I2C is mandatory, enable DM_I2C
to disable board removal warning.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/chiliboard_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/chiliboard_defconfig b/configs/chiliboard_defconfig
index c574d93806..0e8737565f 100644
--- a/configs/chiliboard_defconfig
+++ b/configs/chiliboard_defconfig
@@ -53,7 +53,7 @@ CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MISC=y
 CONFIG_MMC_OMAP_HS=y
-- 
2.25.1

