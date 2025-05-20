Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF8C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 14:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E83A82CD9;
	Tue, 20 May 2025 16:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q/hLH0H4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05C782CA0; Tue, 20 May 2025 16:26:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1381882CA4
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7F1845C5652;
 Tue, 20 May 2025 14:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 167EBC4CEEB;
 Tue, 20 May 2025 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747751159;
 bh=GyvkI/Jug/VN/e1Ni+nwmu3nl5sW1DKtzgOvTQLW0y0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Q/hLH0H4AtGYyyj5dYcQhHlNvK95Vsm/ajdJTrW6nbDmzFXvraZ9CQlH1LPBEEvVS
 svbLgcOpIqw9Fv8mkS+/3yDfo2MpQLxuMNoANQJvoF8y9eU52UoeNHi+NhB/iUmSzy
 FYfEu/vMSPx18izILzeykB3vNgJu70VXXB/sKkvxGrY43Dth/6xgtZ3mxptiiBaMwC
 L9UYaKCxhK9dHVPRsXMGDwcIMxOOHw5qr/ATmr8nbIeeABqvNZKTT33wC5R4JirOGp
 g7u6ypqYsut7+4whWAqpo4jq7ZBpkkv8iiQrAOm74HTyPM1yzSwyvF5257W2Q4POPu
 eWV2nyYQzxZGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 08D73C54E90;
 Tue, 20 May 2025 14:25:59 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Tue, 20 May 2025 22:25:58 +0800
Subject: [PATCH 3/4] boot: bootmeth_android: Conditionally dependent on
 abootimg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-sc7180-android-boot-v1-3-3075a84ea094@gmail.com>
References: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
In-Reply-To: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747751157; l=1767;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=WjgYwgaVztceTx2DDYS0GrMHIgSKhAFgtLATy38C6+o=;
 b=soghn9/18o6C7GK4RrfKR8lDBsrIn07FLIJLu2LnSYocuuyLyvdAeBG2BHbWi4jl6XPREifXm
 rgMdHA0d1ANDur42p4N8cdxXfWB6Qzzcy4MR5/ttjBQ2aW2N8WEGduM
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Tue, 20 May 2025 16:26:13 +0200
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
 boot/bootmeth_android.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 654ebfdf1fc..29a9a4afe7a 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -517,7 +517,7 @@ static int boot_android_normal(struct bootflow *bflow)
 	struct android_priv *priv = bflow->bootmeth_priv;
 	int ret;
 	ulong loadaddr = env_get_hex("loadaddr", 0);
-	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
+	ulong __maybe_unused vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
 	ret = run_avb_verification(bflow);
 	if (ret < 0)
@@ -533,6 +533,7 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
+#ifdef CONFIG_CMD_ABOOTIMG
 	if (priv->header_version >= 3) {
 		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
 					     priv->vendor_boot_img_size, vloadaddr);
@@ -541,6 +542,7 @@ static int boot_android_normal(struct bootflow *bflow)
 		set_avendor_bootimg_addr(vloadaddr);
 	}
 	set_abootimg_addr(loadaddr);
+#endif
 
 	if (priv->slot)
 		free(priv->slot);

-- 
2.43.0


