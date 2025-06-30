Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01D0C83000
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 08:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DEF782F46;
	Mon, 30 Jun 2025 10:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NGYTT8Jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E591680B9B; Mon, 30 Jun 2025 09:57:27 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 666D981D6A
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D425646277;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B927FC4CEF2;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751270225;
 bh=C+YoQrvp13f6ofaAyQ76mBfgIUbx71z2GYt9vCIJ/jg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=NGYTT8JoK9IiqKa5f5xdtOjd9TIwp2Mo4HUg9a8P29QRIsgst2vm5T470d80yZQaF
 TlMN8EKC3cM9DT1EJ9sWMx89Rj7xe5uFxkRlaw3UoiO1L/jqGN3yrPvmWdtHstXUrI
 an0NOkLD/wXoW3nsvl4O4uJRJoTIo1VNQ4AHe65WlXd3w6Y45EjcTaeZ10cY6rSDVm
 s4xnBmB0XOHPGo/70EOn3/ABpg2nqg6uq+3i00Et1b05vPwxvdA9l5tetI2gX1ZrB0
 TCdYAmMy/NzjBhegnkjZBEZ9GF3tLG1VM4UdV+jNSwzsgMSmZv0BmwSjypvExxsbzS
 k840JXB4Y9DSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AF9EEC7EE2A;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Mon, 30 Jun 2025 15:56:53 +0800
Subject: [PATCH v4 4/6] boot: bootmeth_android: Conditionally dependent on
 abootimg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-sc7180-android-boot-v4-4-24cdb50e860f@gmail.com>
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
In-Reply-To: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751270223; l=2044;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=7C9uzM2soKSCqA3JNzElAV8R0IY3qJ5Iyq7YkLB/LPY=;
 b=gqfOQy8uUR7K0VrXWwP01J+hRzL15PFZuP4526PpMKTlMAqUbeeV7golMBEEnWwzhW4h9PMgD
 +l5w3XZ3flMCuPS4htbnsP/luiloZzgGmmXmjZq5KNWqwCUduLnuyWg
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 30 Jun 2025 10:02:49 +0200
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: George Chan <gchan9527@gmail.com>
---
 boot/bootmeth_android.c | 2 +-
 include/image.h         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

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
index 11d33ceeb39..82a861ba8bf 100644
--- a/include/image.h
+++ b/include/image.h
@@ -2050,6 +2050,7 @@ ulong get_abootimg_addr(void);
  * Return: no returned results
  */
 void set_abootimg_addr(ulong addr);
+void __weak set_abootimg_addr(ulong addr) {}
 
 /**
  * get_ainit_bootimg_addr() - Get Android init boot image address
@@ -2071,6 +2072,7 @@ ulong get_avendor_bootimg_addr(void);
  * Return: no returned results
  */
 void set_avendor_bootimg_addr(ulong addr);
+void __weak set_avendor_bootimg_addr(ulong addr) {}
 
 /**
  * board_fit_config_name_match() - Check for a matching board name

-- 
2.43.0


