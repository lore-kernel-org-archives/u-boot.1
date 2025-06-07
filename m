Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A454C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 12:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 513C282B0E;
	Sat,  7 Jun 2025 14:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XrxOjd22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E8B807B1; Sat,  7 Jun 2025 07:25:32 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AFEB826AA
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 07:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 39D60629F6;
 Sat,  7 Jun 2025 05:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EAF4C4CEF2;
 Sat,  7 Jun 2025 05:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749273926;
 bh=xr25KyLYI2y5tTEbgf3CW9NICYmZJAqxy1NajCengeA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=XrxOjd22QVa2aYllMEhH9oiNdr8Qoa62KugO04srpEFNlI/1jHrkGRx7wuR8unCHU
 8C+AoBT1a+VXEJLCmnaUYh1vjqJh9Qh0qvLSQ+bXxWlxetT3Wy5s3lZ/85VjAYsW7w
 9MNU2g80dSCWie8tDyNXN9XkkZfA7f2+tdB9Khs8Cq21m3Wlbp//NBgWNxSnK7FoOb
 oXpKB8TuX0KwutNDgMI9zDhQ/8oF8kp/kO/46ICrh7kaHgIez3Q7JI14oYRwdgRs3F
 wBc1DxpJhGuzrfCeYW+5WMFbLmKcijG7gqT9yTS8ZI0POox/Mf3e1T5aUqHV45POwm
 jUDDOtOFlMQng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 41F42C61CE8;
 Sat,  7 Jun 2025 05:25:26 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sat, 07 Jun 2025 13:24:58 +0800
Subject: [PATCH v2 3/5] boot: bootmeth_android: Conditionally dependent on
 abootimg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250607-sc7180-android-boot-v2-3-2df5d7f61124@gmail.com>
References: <20250607-sc7180-android-boot-v2-0-2df5d7f61124@gmail.com>
In-Reply-To: <20250607-sc7180-android-boot-v2-0-2df5d7f61124@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749273923; l=1934;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=Pw+fB+o7H8WqB3aWCUfny/w8rA6W42UU9qxo/DLLHPE=;
 b=UZVMmk1xn6W8c52JzaBqlo/qeLoCqlpKCjN9Qae/pihn/+TWNISOxWgxxXJXIMEnYor+ytJIR
 cR6N2pUMzsxDewEHeYsfrDvO6HHoXFNZLLskGTUUCJ0+ShSJ3sOWbDF
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sat, 07 Jun 2025 14:23:14 +0200
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
index 1e1bded690b..2c03dde768d 100644
--- a/include/image.h
+++ b/include/image.h
@@ -2038,7 +2038,7 @@ ulong get_abootimg_addr(void);
  * Return: no returned results
  */
 void set_abootimg_addr(ulong addr);
-
+void __weak set_abootimg_addr(ulong addr) {}
 /**
  * get_ainit_bootimg_addr() - Get Android init boot image address
  *
@@ -2059,6 +2059,7 @@ ulong get_avendor_bootimg_addr(void);
  * Return: no returned results
  */
 void set_avendor_bootimg_addr(ulong addr);
+void __weak set_avendor_bootimg_addr(ulong addr) {}
 
 /**
  * board_fit_config_name_match() - Check for a matching board name

-- 
2.43.0


