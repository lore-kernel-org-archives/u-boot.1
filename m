Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77312CCD19F
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74BE83893;
	Mon, 20 Oct 2025 19:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PWvpzSpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 379A8831D6; Mon, 20 Oct 2025 18:36:45 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1DB682C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5779A43CFB;
 Mon, 20 Oct 2025 16:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 378B8C113D0;
 Mon, 20 Oct 2025 16:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760978201;
 bh=HDMHiMyn9tQsClVhZrtWBKQ3PXWE8KoGBbbwAoMbjRE=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=PWvpzSpJhDwG1Hptkj7WFaWvAcE9wUYHv/Wb9WoEwEbBlEYhE/R165mPZj2Wzl94O
 LNPjvo8V+HRWFcjbajX8omj2tntu6NsQ8loAPiuBy5FXh9I8Yvh13E18B+Ps1Ommfz
 rOWlRBxOfOqb+Vli/0VAF3G6v3gnoB7jMT9emQ3xgtjHMoxztunzdKBBPxMZXl+nJu
 7gbydmTZto8UvpPaFf68ZqY1Jb9/Gua0MUFiQUkv2ESj4K1IOtBC0ZxZIAFGRLbb41
 DF0epMGFoywOtaRacTmESn+e4Ge7JPUm4BfAdeMXLmniSr1m8hfUooxAOxkwW4o/5+
 pH5uk3KJMqhNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 231FACCD199;
 Mon, 20 Oct 2025 16:36:41 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Tue, 21 Oct 2025 00:36:33 +0800
Subject: [PATCH] boot: bootmeth_android: Conditionally dependent on
 abootimg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-abootimg-minor-v1-1-88a12f53d8de@gmail.com>
X-B4-Tracking: v=1; b=H4sIABBl9mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyND3cSk/PySzNx03dzMvPwiXUNzc1NTC0uTRGNzMyWgpoKi1LTMCrC
 B0bG1tQAftXR3YAAAAA==
To: u-boot@lists.denx.de
Cc: George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760978200; l=2098;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=4uMc+7Ut7q3MkWXCPAn8CwIr0ccGA2b3VMox67PjwlM=;
 b=DrNyxFWGuHqkyZOTnC8Whvk+bwzSYrCetTX4l7KgHMQjo0rUyUyFHWTc5fgnhgVE32PXdM/R8
 6JmtS4vCh3uDhE7EdrqAgoWU4GBe58jdVRk2AAPyocSArOZKs392yXp
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 20 Oct 2025 19:17:28 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

If target u-boot img do not support androidboot v3 or greater,
abootimg might not be necessary.

aarch64-linux-gnu-ld.bfd: boot/bootmeth_android.o: in function `boot_android_normal':
/home/user/sources/u-boot-next/boot/bootmeth_android.c:541:(.text.boot_android_normal+0xd0): undefined reference to `set_avendor_bootimg_addr'
aarch64-linux-gnu-ld.bfd: /home/user/sources/u-boot-next/boot/bootmeth_android.c:543:(.text.boot_android_normal+0xd8): undefined reference to `set_abootimg_addr'
Segmentation fault (core dumped)

Signed-off-by: George Chan <gchan9527@gmail.com>
---
Cc: 
---
 boot/bootmeth_android.c | 2 +-
 include/image.h         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 8c2bde10e17..d7740b86d67 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -534,7 +534,7 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
-	if (priv->header_version >= 3) {
+	if (IS_ENABLED(CONFIG_CMD_ABOOTIMG) && priv->header_version >= 3) {
 		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
 					     priv->vendor_boot_img_size, vloadaddr);
 		if (ret < 0)
diff --git a/include/image.h b/include/image.h
index fc2f2487095..55a6af69b31 100644
--- a/include/image.h
+++ b/include/image.h
@@ -2039,7 +2039,7 @@ ulong get_abootimg_addr(void);
  * Return: no returned results
  */
 void set_abootimg_addr(ulong addr);
-
+void __weak set_abootimg_addr(ulong addr) {}
 /**
  * get_ainit_bootimg_addr() - Get Android init boot image address
  *
@@ -2060,6 +2060,7 @@ ulong get_avendor_bootimg_addr(void);
  * Return: no returned results
  */
 void set_avendor_bootimg_addr(ulong addr);
+void __weak set_avendor_bootimg_addr(ulong addr) {}
 
 /**
  * board_fit_config_name_match() - Check for a matching board name

---
base-commit: 4e4a9de31de2a5f395ee25c59e4026422fbcb27e
change-id: 20251021-abootimg-minor-17755894a376

Best regards,
-- 
George Chan <gchan9527@gmail.com>


