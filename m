Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0883C83000
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 08:03:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66ED982E6A;
	Mon, 30 Jun 2025 10:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NCbVL5Ww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4947881D6A; Mon, 30 Jun 2025 09:57:11 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9FF81FEE
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CC75046274;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9184C4CEE3;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751270225;
 bh=eHUMwEFD+Cq3LJrc6xbo55gc3FiSY8BtlVktHVql+YY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=NCbVL5WwWGfycY1AkPBzP0DV0jbQqrjkSqgy/k4GBRXsW5BW81LLwWkCI6HazCX+R
 JNJhYDu5NdQpXLgvjLgMhN44lgsMo9HwNke+Tptz3xvwrqNhRHJ9P06H6UI98g3iXF
 wvGu7gz26bQlfJCllAoGzL/YIUsVrj22q632DzMhBCVD/TbeqCZyA5T802ZY0DdTFF
 dEmm1OoNmGbOIxwRUUIYRH+g+BohUwYScLwVLtsFFBmTmIkIBiP5TSuh9xH3zxN3Bf
 pnPqG4JwuOX8F1J5QilOWGV8tCEEkgo+RQdU2MfthlJnJ5BC0LAcaZrwVO1nEAVsWt
 DHfQ2UmUZs2Tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9E270C8302B;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Mon, 30 Jun 2025 15:56:52 +0800
Subject: [PATCH v4 3/6] bootm: Append bootargs value when bootmeth_android
 provide cmdline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751270223; l=680;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=KXNFVFL5HddagemUBAB7NDgbvaNS8Lbmx2/LdQwZWpw=;
 b=yIhghEwDWeoG+x6l1/V/EOXrrWRBqgrfdvy0wBGQDnnYx/ldfrrOXjdnZEJiXKSSY5LaTmhxi
 Q2kUMQq1lGMA6OFdCIWr7qNFo6rfJ7Kyalh9hNYRXWDjeI9SuZgNPwL
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


