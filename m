Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4257CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 335B3607DA;
	Wed, 14 Oct 2026 12:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0nDUl8XOd8Vn; Wed, 14 Oct 2026 12:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 80D7A6070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980697;
	b=MqidJ3YVDyuOVIJOisx0MqwJYElA/rmiPbNTPus7uEOfCom62g4vAzGge04E6D3ncQpg
	 8htGIE6oTpQ1pCpc6ZDb8v4At9w8aHjSf1nUR7fTk4y0bGozr6lu7eidB08VV/bG4oRvZ
	 RJl7LYr8bilYLyTBKXr6iO2xTXiz6wa79OvNn6ABKKfTIOxkx5Ubz3rdAJn4eI5/8jusJ
	 YsvPiAPP2R9DwnuN3tiogzinN6r94YgdzUXqb+r5beeC0AuLnb42veXndnVB50FTx/Gza
	 mU/KGCfpYvs10YPGGeORuWtwOVIvB2t9Z3QKjbWuAoNsD1K5ubO05hInpGdT0PWpAfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CJ3TCKkrOcgBF4ui1ys0kaUBmtwT45wuCoapxOH3x2w=;
	b=Knsd+Ilda+7zGC0zKhIER4X5ItxjmXi5b3zAEiI3Y5JAdp8dSRRHEs9jXHnp9mVBi3/s
	 KZnPUbJiGcSN68z/FhRFfU9MptNPc+iznrxLAa+dyeXp3w6o7riKAIH0NFAbheDsyEX3g
	 yKNLgwOlepkxkddPzVSOQY4CkVvOjRVg49l1FmJtnejiZGWl3f7sYWpeD47WtzthXXH4g
	 gXDFSndVscvvsqgWpCNj4eBRz+3IPxcEQ64aogi+iw9WNL8SrS+Gr6hGLW9zuzFBYTDel
	 XfH4z+S/WIAvUzK0XCdDX6REmnx423f0uChB2+Wl3052a1d7v+O0pdLSwaH1r9TL97g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980697;
	bh=CJ3TCKkrOcgBF4ui1ys0kaUBmtwT45wuCoapxOH3x2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ROT6/FDUYKFdaaA9jZjw2G4myHMf1v7RPrlHSV3fXXxIcqP6CJK44etrODTT21aLO
	 QDPiCFOCF8rX7WdPoEOzXhDU/yNUIidSiAw49Bt7sEw+pPWly2qxQVDsj+af35McVy
	 v21UAM8KPKD06eMEr7tiuYFis4/zGkkBHxid+QrlNIBemASEfn3P76yz36TMSBQf2D
	 qC6Wfvcvt4JColGbvrXkwLdzNBtslVyTPZ9+3twQK482rF7n7nlzThVgeGUTtz/mMK
	 m5q6wYuFqr7xtVDRyGohy3Ur8zBk9Y4uS/asL9vQquks10OLjQhgsLK/+ETBTTBudw
	 EsjXtk9J42E3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80D7A6070C;
	Wed, 14 Oct 2026 12:24:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B50F1DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8089580DBA
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpF-B6fC8BS3 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D556780DAE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980693;
 b=MJPli+m53PkrrgZBikUzp97dCnhtpfNmnj8I42kpbdZ053QFQmYg/96SlroWrlx7UP3S
 CwHJJ3Y5tI3Y53OTaY2CYNEuNaIod0hEoVodOPiHpTpFPCseNOkJhhNspoN7R4zxccDz2
 nZdltnYU6EGA6rxE+esui8CIJoELNrs/2kE+JbY9XXjiCOj+qe9iuQJVIRBEeZ16KfCzB
 N3BOemwLLHO+UYzS9dpIPK176AJklgxn6WPszW2eSURyD3A9EzkTdZIxz6MI2qdybfkJc
 7hsfGeeMQ/EEfZpEaX6h/30DaggeZgYe8rF87wrZbQVW8ujnaPXaP7GvrhUkM2c6TIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980693;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=CJ3TCKkrOcgBF4ui1ys0kaUBmtwT45wuCoapxOH3x2w=;
 b=MkS+1++orTtgE5Z8eQL88UT1EcmYQJqkK1w95igr7+CfXkr5vIb8Zb9EODzmSfjb62PW
 G6LnjM9b8w1P/LflGluNe4kRCaEAcuHOmNew3MX7FOEs8UDBD7H5x+Il6TGI/n3zJn/FG
 nM9L/3A9TtVEPNymVFEXUZ0Nh979z4+LGL7ZWUPpV1mZLlJHO3ggNYkh1J2W9KzJEwHCt
 FvlCXSYnDhrYDxm0paOlSvYWXTmkhFU98V3sRPkXfL5V49B90d1T+ynlKogqzoPIwz7qJ
 4+M/yKnY1HERjrH1PO1FEEEchMJ7BD6TMeqhRHyyDnHbTju0z8cEQBi8LVvk4h2hnGw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=W1pfzE1R; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=W1pfzE1R
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D556780DAE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:52 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so28425715e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791980690; x=1792585490;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CJ3TCKkrOcgBF4ui1ys0kaUBmtwT45wuCoapxOH3x2w=;
 b=W1pfzE1R6ux1u820jI1EirDAsqqXHch0HtSeCy5GBZ9BSbXL4/bMLRq/9sSO7pWXNW
 tmV1WIVuuJZ4aPOAmNx/wYgfEsuSg7oGuph0KudCJuuZZMzaHHxRKpW7TlqJi6RBe++P
 iL5u+9Cfl9QY6bgZCs7HyBZ6ual5nJyTGIzLPBKSJT6J796fqCJooFh0oWCz1zMlQzeE
 zsSQzs10oKjQOVK9cSiqYUwH+ay1/aNkij7+rFew/NwuuUhhHNQ0bt4QYecHJet6lQ/g
 SK6NZ1CKByjGhGeWkViJMp3p4KB0Kcb13imeILNO7xthOv9wrFgiQI9JUtmMv48QEjb8
 ZlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980690; x=1792585490;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CJ3TCKkrOcgBF4ui1ys0kaUBmtwT45wuCoapxOH3x2w=;
 b=n2sBnwWZK2CWzbOKG2CPf2h3AZMUU8FZNYl7m4TJCkhuEcw/E22QjT0oUgYjtHQOOh
 HapykaP6LxA1LlY2VY/35YAEL4ydKYiInB7gMI7PYtWfT6XwHTpCVk/U8V5Gdj64JyTO
 /XpQ/RXu2jmk3qQK/gsmChWNQ54wIiU9VCWIkYlpOllXCGbAPdPprbjbOlsJ/GqX0LOk
 FpKbs8To0ac39EJa8gHV1sR6la/fgY6Pl45izHDZLX1mAsHZj5TbQclhMN/s/o6MXoSt
 SLc9s7t70HQW3E2CyHuI03SQhQGYfoNfOeEUHZVZRUoAm2uz1uEVJBXyYZ0BIvh0tu6s
 zVMw==
X-Gm-Message-State: AFq9FYK8ECCgfHPqQkNNSgBNaPsNwSBSt2N086TxbXfmGltkCYMRjyG7
 fBRrLJkDqRcBupAUWU4mvY1nrlGnuEn7Xxax5xJbnaPqpt5b5Q61huwvLXbkK4CgBgg=
X-Gm-Gg: AYBFou0CZ5wqMejpd/0C1Pgfv4miMdwCJBJs0rqd8ODC21NWxwO1gACmAEJvnh3nBVW
 ItNdqUxLZgHPC3bWK7lspdjpir2/3o5lpbGeERkGPDX9ZnxeFP5LH9flZ2Ttjd1GNb/VmGSVS66
 uZLfp2hBTqDZFQbqORcZuhGJVOLI7dnGkRm6MxN5RzhLzjxS65hKacdR9i1v0tPa6fYmk9rSi7g
 f5ux2TVtb6mjFCP20ORdoIN5kpGmrSpFpccSJesRMN5mfxycPjag2iDxCYs36lXzWPNMUpLCCIC
 CriaMm63Mv+Ity60vOIKncm5EreVM1ocdRRMvrkISAa97UADxlx/uToP4MNnH/RC++ba0qTrV5o
 hpro/VvyF0ZzQUZmrsM+Z9YQojd9M8PFO6Th3dNdywtxouYG9UUe1dWADdDOqG6moWH05uHx6Nm
 EKtZvwzFdT84IrQVIgWWIV2BFbd1tppdrjpOndc9pKvowCxeZo9iJuQ74ficWFiq/yEYbG8OGKX
 IU71rVWjaFEgzjGtd3qCkuZy52S272ywFv0YLDgIo0KHkzJkgKtiQ6Gruo1TGcLiWLABpJpjx08
 OVi5kzukuSvbBI+qvM1EMphQ5Q==
X-Received: by 2002:a05:600c:4708:b0:4a0:258a:b25c with SMTP id
 5b1f17b1804b1-4a18e4da3c8mr311775805e9.29.1791980690060; 
 Wed, 14 Oct 2026 05:24:50 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2fc4724sm50351815e9.2.2026.10.14.05.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:24:49 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 14 Oct 2026 14:24:29 +0200
Subject: [PATCH 1/6] spl: fit: reject failures loading an explicitly
 requested FDT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ccaione-upstream-spl-fastboot-boot-v1-1-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

A U-Boot image may embed its device tree, but a FIT which explicitly
names an FDT must not boot after that FDT fails to load or verify.
External FDT data is copied to its load address before verification,
so ignoring the error can leave an unverified device tree for U-Boot.

Keep support for U-Boot images without a separate FDT, but reject
failures for an explicitly requested FDT in both firmware and loadables.

Fixes: d879616e9e64 ("spl: fit: simplify logic for FDT loading for non-OS boots")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/spl/spl_fit.c  | 14 +++++++++++---
 test/image/spl_load.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 64e5f95546f..a520db76506 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -491,11 +491,14 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 	image_info.load_addr = ALIGN(spl_image->load_addr + spl_image->size, 8);
 
 	/* Figure out which device tree the board wants to use */
+	spl_image->fdt_addr = NULL;
 	node = spl_fit_get_image_node(ctx, FIT_FDT_PROP, index++);
 	if (node < 0) {
 		size_t size;
 
 		debug("%s: cannot find FDT node\n", __func__);
+		if (fdt_getprop(ctx->fit, ctx->conf_node, FIT_FDT_PROP, NULL))
+			return node;
 
 		/*
 		 * U-Boot did not find a device tree inside the FIT image. Use
@@ -896,6 +899,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	int ret;
 	int index = 0;
 	int firmware_node;
+	bool has_fdt;
 
 	ret = spl_simple_fit_read(&ctx, info, offset, fit);
 	if (ret < 0)
@@ -911,6 +915,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	if (ret < 0)
 		return ret;
 
+	has_fdt = fdt_getprop(ctx.fit, ctx.conf_node, FIT_FDT_PROP, NULL);
+
 	if (IS_ENABLED(CONFIG_SPL_FPGA))
 		spl_fit_load_fpga(&ctx, info, offset);
 
@@ -958,11 +964,11 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 
 	/*
 	 * Booting a next-stage U-Boot may require us to append the FDT.
-	 * We allow this to fail, as the U-Boot image might embed its FDT.
+	 * A U-Boot image may omit it when the FDT is embedded in the binary.
 	 */
 	if (os_takes_devicetree(spl_image->os)) {
 		ret = spl_fit_append_fdt(spl_image, info, offset, &ctx);
-		if (ret < 0 && spl_image->os != IH_OS_U_BOOT)
+		if (ret < 0 && (has_fdt || spl_image->os != IH_OS_U_BOOT))
 			return ret;
 	}
 
@@ -999,7 +1005,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			debug("Loadable is %s\n", genimg_get_os_name(os_type));
 
 		if (os_takes_devicetree(os_type)) {
-			spl_fit_append_fdt(&image_info, info, offset, &ctx);
+			ret = spl_fit_append_fdt(&image_info, info, offset, &ctx);
+			if (ret < 0 && has_fdt)
+				return ret;
 			spl_image->fdt_addr = image_info.fdt_addr;
 		}
 
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 334ec77b18e..166cf331194 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -367,6 +367,48 @@ SPL_IMG_TEST(spl_test_image, IMX8, 0);
 SPL_IMG_TEST(spl_test_image, FIT_INTERNAL, 0);
 SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
 
+static int spl_test_fit_missing_fdt(struct unit_test_state *uts)
+{
+	struct spl_image_info expected = {
+		.name = "missing FDT",
+		.size = SPL_TEST_DATA_SIZE,
+	};
+	struct spl_image_info loaded = {};
+	struct spl_load_info load;
+	size_t size, offset;
+	void *image;
+	int node, ret;
+
+	if (!IS_ENABLED(CONFIG_SPL_LOAD_FIT))
+		return -EAGAIN;
+	size = create_image(NULL, FIT_INTERNAL, &expected, &offset);
+	image = calloc(1, size + 128);
+	ut_assertnonnull(image);
+	generate_data(image + offset, expected.size, expected.name);
+	if (create_image(image, FIT_INTERNAL, &expected, NULL) != size) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = fdt_open_into(image, image, size + 128);
+	if (ret)
+		goto out;
+	node = fdt_path_offset(image, "/configurations/config-1");
+	ret = fdt_setprop_string(image, node, FIT_FDT_PROP, "missing");
+	if (ret)
+		goto out;
+	spl_load_init(&load, spl_test_read, image, 1);
+	ret = spl_load_simple_fit(&loaded, &load, 0, image);
+	free(image);
+	ut_assert(ret < 0);
+	return 0;
+out:
+	free(image);
+	ut_assertok(ret);
+	return 0;
+}
+
+SPL_TEST(spl_test_fit_missing_fdt, 0);
+
 /*
  * Build a FIT with external data, overwrite one property of the image node
  * with a hostile value and check that loading fails with the expected error.

-- 
2.56.0

