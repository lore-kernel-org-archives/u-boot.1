Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08877C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 12:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D6682F30;
	Sat, 28 Jun 2025 14:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="No+SQI+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B91C82E52; Sat, 28 Jun 2025 14:25:31 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DBF580C83
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 14:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DC4D6113A;
 Sat, 28 Jun 2025 12:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B19F2C4AF09;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751113522;
 bh=eHUMwEFD+Cq3LJrc6xbo55gc3FiSY8BtlVktHVql+YY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=No+SQI+m0mHpTo+AqWul9sjpegcql9c4HGqHWvKitvTKxWB5X3V3VUfNYFE8mSQoc
 K1yaxrLI/tRI4mSeZPyU37i7QW4UAcwKkA7jP/yVxsoVCILYC6RP2wbXeE5mDs4K/B
 AEl6DgM7ACkBhTmdh1NjGPG/SJlA8mgVGjOuvKy1097WOK7xOVio6oS71lOKU+u70G
 nKinApJNYkizM8UiInnvzTV3S5M+f9yaVw8qjA6vEZ0h8DCscolSjdcJtoxK1Bphjf
 +LBhdGC7BLrZpiqXVS8HAgvidgCOFKWNXJ144oDPB8DZnDQkGNjV+4mz4gUepElAts
 VOfJqF0PT6Hxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A8B8DC7EE32;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sat, 28 Jun 2025 20:25:22 +0800
Subject: [PATCH v3 4/7] bootm: Append bootargs value when bootmeth_android
 provide cmdline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-sc7180-android-boot-v3-4-105098a19165@gmail.com>
References: <20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com>
In-Reply-To: <20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751113519; l=680;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=KXNFVFL5HddagemUBAB7NDgbvaNS8Lbmx2/LdQwZWpw=;
 b=ODo9OSkjxsNgelINwV/bCuq6K6MTIaQKJfTfc25kFWJ5ajGxBmjhCpV2xKsUf06hR04vR/uS3
 8W8gRg3ZGUcC28KkGjLq8Avd3uGtyLySgFrUf0o+cJ7zQERcUjPUpUe
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sat, 28 Jun 2025 14:35:07 +0200
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

Old logic wipe bootargs env with cmdline, new logic cater the value
by prepending cmdline value to bootargs.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 boot/bootm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4bdca22ea8c..d8e0c3527d0 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1165,7 +1165,7 @@ int bootm_boot_start(ulong addr, const char *cmdline)
 
 	snprintf(addr_str, sizeof(addr_str), "%lx", addr);
 
-	ret = env_set("bootargs", cmdline);
+	ret = android_image_modify_bootargs_env(cmdline, NULL);
 	if (ret) {
 		printf("Failed to set cmdline\n");
 		return ret;

-- 
2.43.0


