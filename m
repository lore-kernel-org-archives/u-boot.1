Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AA5C369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 07:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D6F8215E;
	Wed, 30 Apr 2025 09:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KQBTiKAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5803A82ADA; Wed, 30 Apr 2025 09:16:21 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F8D982145
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 09:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-108-068.46.114.pool.telefonica.de
 [46.114.108.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3B6653FF28; 
 Wed, 30 Apr 2025 07:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745997378;
 bh=JrFF/V4mCh+fiAv2WLVXVFvJyvgGV1lNx9QVQUssFSk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KQBTiKAUXkP5GoOe0idaA/iqehN+zxRq78vpZ4L/v0G9d0S7zGr3NRgUh5mSgLH9u
 OJFz+Q6sn48mToN3WntN6f5zudMLxdYrnNOCvRaAPgdjE9lO4QIhoLxiJUqYdc1cLJ
 GqJo+0paf8K8O/qeRXkHkI6yMA94biJtxv4YJ/BcusfwK3MkCTlCExZwA+ADa1CTGO
 1eWHkPEjRmheTADBuluOppzfMlzBBRhubHE052179JPAe1yAE3gyxGCEfrk5qyDCd4
 PFqcxmX6qy6R78+233p2P3Jrz1pOsBMKINDyYXnHImNLKgX9VbYaviZ/uitCx96+W/
 nZiteCi0KJu7g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot/image-fit: improve 'No Image' message
Date: Wed, 30 Apr 2025 09:16:13 +0200
Message-ID: <20250430071613.13508-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

If an initrd is invalid, we see output like

    No Unknown OS RISC-V RAMDisk Image Image
    Ramdisk image is corrupt or invalid

As most image type descriptions end on Image, we should not repeat that
word. Instead of misleading 'No' we should write 'Invalid' here.

    Invalid Unknown OS RISC-V RAMDisk Image
    Ramdisk image is corrupt or invalid

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/image-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 41ab1f552b0..856de6b731a 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2196,7 +2196,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	 */
 	if ((!type_ok || !os_ok) && image_type != IH_TYPE_LOADABLE) {
 		fit_image_get_os(fit, noffset, &os);
-		printf("No %s %s %s Image\n",
+		printf("Invalid %s %s %s\n",
 		       genimg_get_os_name(os),
 		       genimg_get_arch_name(arch),
 		       genimg_get_type_name(image_type));
-- 
2.48.1

