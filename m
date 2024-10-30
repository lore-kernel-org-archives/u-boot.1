Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA3ED6B6DA
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 21:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D66288B9F;
	Wed, 30 Oct 2024 22:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Fhtbt9pU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23F389228; Wed, 30 Oct 2024 22:02:38 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E9BC8887A
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 22:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.c.hoisthospitality.com (unknown [87.215.50.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 638D93F18B; 
 Wed, 30 Oct 2024 21:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730322154;
 bh=P/3gpQhkatxFPI39TLsdzTuuLvbjIHDG1wxSNzVMtSs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Fhtbt9pUt1L37lBG5DcbAe10hfDKAmCta4Ea0yZ6kCkFd9JwgmoRbnbaHFJIBpgGk
 PWIjF9L8loZL7QI0Dh4by3FO9aT0qTa9mrEnbAmhuuM/LkMMpVM8LKe9dLb6M/h7SG
 muceyFqHW77XeRwsod+Z0CS63hZkQw7wg8ODo7R8Lsexk79515AY0CZ8VwN1ytBhNC
 MVRSiE26QEugv2RBwKG/gcuJChSx6X5Mel53ny7axfIGfqwDoi21Em3uJhBEKxq2FB
 DmMlw/BoL/2wwKgptfiZ0FzyNbazkxm18/VRJ0PF19so2/x3lvKqQwQpBTVt8lladY
 rwj10qca84ubQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: pass end address to efi_dp_from_mem in
 efi_dp_from_name
Date: Wed, 30 Oct 2024 22:02:27 +0100
Message-ID: <20241030210227.55952-1-heinrich.schuchardt@canonical.com>
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

efi_dp_from_mem() expects the last parameter to be the end address and not
the size.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_device_path.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 9de3b95d073..d7444588aa0 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1073,7 +1073,8 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 		efi_get_image_parameters(&image_addr, &image_size);
 
 		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-				     (uintptr_t)image_addr, image_size);
+				     (uintptr_t)image_addr,
+				     (uintptr_t)image_addr + image_size);
 	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
 		dp = efi_dp_from_eth();
 	} else if (!strcmp(dev, "Uart")) {
-- 
2.45.2

