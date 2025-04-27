Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A239C369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 12:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73A480FDA;
	Sun, 27 Apr 2025 14:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NeBLzhXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 269218209C; Sun, 27 Apr 2025 13:25:34 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB6F80C93
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 13:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D3CD1A430F6;
 Sun, 27 Apr 2025 11:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56423C4CEEE;
 Sun, 27 Apr 2025 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745753130;
 bh=HxYelnMUyic7USwMUl5iPYXMfEHQoqCq5mxh9+4wO6Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=NeBLzhXENntRNvbfTSaVMrWHFZSr1ZwM0HCePHAaOC+WT01vptvuytkaJeJTTRkv2
 MhOzJ016cdhTWkNkIcwlBiHpSLNUy4+pHiOjO88d/dLmoXDz8+jXQfwV62ott1o5E9
 95FuqFQixmZlc5MtsfHQl5KXqr8vjvbzn2ImDKoXCoXbOUav/Zst0c1P6NPqxcE8lR
 2yZcrLxfAAmp30zEM2zqVElDSsu8L4DZefknCEtxvqp/Cw+US7kbDy2EOu/zGbMCfV
 A6rLtJe+gbuha5vy9ivJ88O52MkgcF7m33vKPI5Z778c9ORszUUXCgnYplpt9l6l2o
 QDJV4y1WtY8ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD1C369DC;
 Sun, 27 Apr 2025 11:25:30 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sun, 27 Apr 2025 19:25:21 +0800
Subject: [PATCH 2/3] boot/bootmeth-android.c: Reuse fastboot memory block
 for unzip kernel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250427-android-boot-v1-2-bb6b37c9c9f1@gmail.com>
References: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
In-Reply-To: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745753127; l=1287;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=ugLpxrUUrjW2ErfABS319vt1y5sqKu5fwdIFl4zVGGM=;
 b=DwpjZnwwoUszR0Kesxi9yE0r9CzeWPQ76RnmYvbigKN+pL58rb+DpDAGJjWLciBeNaIZ6XcPJ
 ZZjI7a59t1qBnQ4Q4CFUAb9gUzDlQ/FZgiMBLM09vWDB7ZTxcExbjo5
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sun, 27 Apr 2025 14:43:01 +0200
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

Some androidboot images have gzipped kernel so we need to reuse
extra mem block for holding gzipped boot.img, and let loadaddr
to hold unzipped kernel data. Here we choose fastboot memory for
reuse and avoid dramatically increase memory footprint.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 boot/bootmeth_android.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 654ebfdf1fc..27ca2907052 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -518,6 +518,18 @@ static int boot_android_normal(struct bootflow *bflow)
 	int ret;
 	ulong loadaddr = env_get_hex("loadaddr", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
+	ulong fastboot_addr_r = env_get_hex("fastboot_addr_r", 0);
+
+	/*
+	 * Since there are some soc with very constrain mem footprint
+	 * so dont borther to allocate extra block for androidboot img
+	 * instead, reuse fastboot mem block for androidboot img
+	 *
+	 * The idea is to let loadaddr as source boot.img for unzip,
+	 * and the original loadaddr is for holding unzipped kernel.
+	 */
+	if (fastboot_addr_r)
+		loadaddr = fastboot_addr_r;
 
 	ret = run_avb_verification(bflow);
 	if (ret < 0)

-- 
2.43.0


