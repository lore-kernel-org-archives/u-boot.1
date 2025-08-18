Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F46CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 12:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD73F801BE;
	Mon, 18 Aug 2025 14:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=silbe.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B65B802C1; Mon, 18 Aug 2025 10:23:32 +0200 (CEST)
Received: from bbox-ptr.sascha.silbe.org (bbox-ptr.sascha.silbe.org
 [IPv6:2a03:4000:20:16f::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A00880050
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 10:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=silbe.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sascha-ml-reply-to-2025-3@silbe.org
Received: from twin.sascha.silbe.org (twin.sascha.silbe.org [192.168.1.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "twin.sascha.silbe.org", Issuer "stunnel Pseudo-CA" (verified OK))
 by bbox.sascha.silbe.org (Postfix) with ESMTPS id 63D411E165F;
 Mon, 18 Aug 2025 10:23:28 +0200 (CEST)
Received: (nullmailer pid 1412739 invoked by uid 71000);
 Mon, 18 Aug 2025 08:23:27 -0000
From: Sascha Silbe <sascha-ml-reply-to-2025-3@silbe.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH] am335x_evm: re-enable legacy image format
Date: Mon, 18 Aug 2025 10:22:35 +0200
Message-Id: <20250818082235.1412022-1-sascha-ml-reply-to-2025-3@silbe.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <yh7ro6sfsbjh.fsf@twin.sascha.silbe.org>
References: <yh7ro6sfsbjh.fsf@twin.sascha.silbe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Aug 2025 14:57:05 +0200
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

Hello Simon,

in case dropping CONFIG_LEGACY_IMAGE_FORMAT was not intentional,
here's a patch to fix it.

Sascha

-- >8 --
From: Sascha Silbe <sascha-pgp@silbe.org>
Date: Sat, 16 Aug 2025 14:31:39 +0200
Subject: [PATCH] am335x_evm: re-enable legacy image format

When am335x_boneblack_vboot was rolled into the generic am335x_evm
target CONFIG_LEGACY_IMAGE_FORMAT was dropped as a side effect of
enabling CONFIG_FIT_SIGNATURE. This breaks distro boot using scripts
inside legacy image files (boot.scr).

Explicitly re-enable legacy image format so that distro boot support
is fully working again.

Tested on BeagleBone Black.

Fixes: d780965927d4 ("Drop the special am335x_boneblack_vboot target")
Signed-off-by: Sascha Silbe <sascha-pgp@silbe.org>
---
 configs/am335x_evm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 2b68902edef..9393cced885 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -15,6 +15,7 @@ CONFIG_TIMESTAMP=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
-- 
2.39.5

