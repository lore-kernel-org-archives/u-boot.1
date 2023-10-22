Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FB5CDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 06:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 350E3876CB;
	Sun, 22 Oct 2023 08:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mxfKMt08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55993876CC; Sun, 22 Oct 2023 08:20:15 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576E0876CA
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 08:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B58303F20A; 
 Sun, 22 Oct 2023 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697955610;
 bh=e4i4HRpNUX+vG3MHf1QQ7vLJ7y+BzKHilFiX5UAAcdg=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=mxfKMt08CIg8xKOOuMup43NZk1G6J/wMKT+V0i/HWrv9VyeUt4lLE1l6+i5hI++HE
 CGOgtT7WfNioakv/cpc5Ydw/tUDPJFE3SxEUsqb3jN4j5g/r9/PVGorSBAgLW5sfG4
 tPP3F6BHT1pBAzD6Nd0r6RXsp9rDR/5LnSA6zD1Pa+QitqY7zN+P1jnhm14aVMj69A
 8+H+mAPaE/wXvONsE0PCS4YSdfp9vhwbbKwF16HoiW6O16CZ7u4L6T6vogXYwnBmMD
 jq7xkuwlqA7AR67H9ypsdri7lLBhB7vkCNW1FpztcznEgrRxm3X4OimX3GMp6r5T5s
 lrXYThBJY2oAg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: fix efi_dp_from_eth
Date: Sun, 22 Oct 2023 08:20:12 +0200
Message-Id: <20231022062012.97271-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

When compiling the sandbox with CONFIG_LTO=n, CONFIG_NET=n an error is
reported:

    /usr/bin/ld: lib/efi_loader/efi_device_path.o:
    in function `efi_dp_from_eth':
    lib/efi_loader/efi_device_path.c:985:(.text+0xcf4):
    undefined reference to `eth_get_dev'

Add a missing configuration check.

As the function is exported __maybe_unused can be removed.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_device_path.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ed7214f3a3..f3a0e855b3 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -977,11 +977,14 @@ struct efi_device_path *efi_dp_from_uart(void)
 	return buf;
 }
 
-struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
+struct efi_device_path *efi_dp_from_eth(void)
 {
 	void *buf, *start;
 	unsigned dpsize = 0;
 
+	if (!IS_ENABLED(CONFIG_NETDEVICES))
+		return NULL;
+
 	assert(eth_get_dev());
 
 	dpsize += dp_size(eth_get_dev());
-- 
2.40.1

