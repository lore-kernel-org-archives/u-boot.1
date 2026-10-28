Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF8606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MeU2eJo2;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bEZFId6Z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 374634075F;
	Wed, 28 Oct 2026 14:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nEwFWcxGHwer; Wed, 28 Oct 2026 14:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC0B8407F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198869;
	b=luYSfiaJmxZEUh/iPP/cHuU2gvVZ5aCKuPUGBljMCRVIo3pE6BTbr+OlOzvqGjJpGTRg
	 lNRW5g43RH9WOhxtPW8KCNK3CFxpXNMTjjLZpaswKcqnzg0EuYsLEzg6BURjjyC6hSCMz
	 k153zOiSUsSSHJMG11mDOG5vxsCszatJKODMm3RdyPslbAoBqBUXynrW5XqbPpoq6jtEi
	 rFfjrTez3WkhI6W6suK/2SXGT/2pbfjPLyCTC7mMzbMQdzHbsbXEbpX7X5kYNLrKpSH9o
	 8tqCGI/Qb3o1jLnJ/Vi2f8czYbUsT5Di7lQOiWISRRTES8FmR+ID4YBfJYmb9424eCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Joolsl9I0RM147Yq5P0/o2a5p9AUCYnMyf5z3iKQ+lc=;
	b=qcbaciMNOloZRoxZggC7UkjujSFYDObWzUIXDIaTKbiz1cO5tM7UyhFnxR0uBf01TK08
	 dpyiAhs8Om0iC5LyvqXDylxNR26jOZxsUaQOKsuOOhSgfAmRJQ6GXALLpsCyo4G+sPQos
	 KLkEPdo1fE7UsYWCrRCjHNaj87iVag33zfOvEk2Wh71q7k2rnD0Bz5Vlb4J0CNyJ9yN50
	 j0yJmOoi8xYxuLMUKeD5Rre8Pwf20vfR8FF9G3MV8HhhM9XPUPLEivTo9/7a9hbf3q0xU
	 hWKRtqiLxWbKg/xsbUbkZvK1fv+I+O3oa2Gnn7cg5lVf5PdtttBr9IzVY8MPcdnxD5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198868;
	bh=Joolsl9I0RM147Yq5P0/o2a5p9AUCYnMyf5z3iKQ+lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MeU2eJo2SX0fQ3DQ+TBXQlg2w+C6FJZETrcq5DHlFODZrxGAycgwYlSaZBGTd/8tX
	 8YQVRYbuC3aet2bOpIb5WppEGiynF9Hjm6TMKS5Z//tGuK29zPnLqKjEjot7hBqj4Z
	 LKWXa9gW0b9/D0HkzYTc2Ixc5Lbj4iUhSFUYXxGfsGMduSG37FqGi8+45/5BE9iPQx
	 KHi0NiySvJNTSM5fjeWux7w0cWbSQAlRFjDA4Ewo9DAuaPNGqRNG98cKhZCsoaLOvK
	 WKPhx4sgyDCUcWMee7S5ByFTdOZIsLCot6sIBo6mn+8OgD43O221ceUp9GGWutYCka
	 HCXcT1s6wclFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC0B8407F3;
	Wed, 28 Oct 2026 14:47:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A95B356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70EB8605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5N4ystelESVM for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 06E56605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196887;
 b=BAmXTYKWMAttwijTHch2rSpA/SC7HGypJc1AHBL3BjCX8Hyn3/fvUUFl4CKbTSWtZS5A
 cRp18ooVP7LByUSj1BdQqEDnAWeSfl/ZUrnusG54pdqh9r0+sqntrITqcVc47fUQhdS/T
 8FoLcxWXVY/PP9HUYpFl0HNxtN1PZij8oC8/1BiFaPcSX3P6MP8uWa6tSfTb6MSqAThql
 K64xZrngDSxDSSJpXTx7byKYcbSn+iCqeB+p2WAjyh6KOyGcDDWRbNhOSiN7jg8IiXDNS
 +qC6ZBPc0k4nGzmw4jJDFbxazXeQcA95eGI/F6C5f9usx9Sd1MtICHOXPGi92ciYPVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196887;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Joolsl9I0RM147Yq5P0/o2a5p9AUCYnMyf5z3iKQ+lc=;
 b=awyKxrLuf3kTB2FxWMLkHYxmw1a7Tfi2w7GpNxVHA27iNPOwi8HgiTTyNFw2DwBU78NZ
 536B5UDs682Z6i7ecbtZmq0sD/XAovQms27nes8vxqBmVHMFBfQlfIEblBi86GI1d7D/t
 1TcNJ4R32t16/4TNR+7e80Cvf9Mm1pXLKV5VlvrEOqi4gquSNjMdSOXS5aXavKdKrDPT9
 ctgqIGRvetGbzywdveIS2+hycj2KF6xyVRXEGhWlJzSLs9P36aPJM9ZSGrZbZvwRt0MN8
 kxXCBN9/UH+RKDKZCHXIynz/QQTrihNhCAaBeVKE4E2Q25INzLr8v4ZtVyEFTFTqDmA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bEZFId6Z; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=bEZFId6Z
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06E56605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:46 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c499b5be0f1so11829666b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196885; x=1793801685;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Joolsl9I0RM147Yq5P0/o2a5p9AUCYnMyf5z3iKQ+lc=;
 b=bEZFId6Z2Q/LQLEVnD6gTi1m5+0XjWyGvJmkjIK9QaYowa/BdsAVzn9Ec1WETFg5lW
 4S5X+ZBwQg49XLwqrmTxE2Z1Wsg8qVX+lVuaFe1MzpZKfq9wWQeZuKAGQW7YXeFE3CGx
 jNYmzLp+K4f6aaUQFsvqQ/TykCUapI5S8+DZn5dPnHdM4rlnehhKV2B6zdgme0zjOxJm
 hvxr5b1EsMmt1H/wnGSssSLZa222OjtX9eJYbOQb1+uvGe/hI0tyVq/2j6MUZPa6a4Sz
 6MH+qcmjMnRZ+PadC/tN9kzHCFJlDWmSBy6qn+Q8rcEL+8p04zYM5wAzyh8HyJCykgFM
 XgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196885; x=1793801685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Joolsl9I0RM147Yq5P0/o2a5p9AUCYnMyf5z3iKQ+lc=;
 b=rc1GVU7+7G7cr8w6ptc0vxGzQM0QcQS9VLErHehCrYqdh7ZlM4CpXySnvgpeSG/jTN
 azPBjkOqEhs1aBJ+jKiPAFIT8Hno0o09qm9G/TF5JqGBSw4vPnK9zIaV5bMYpa2U+LE7
 Mi3LTtWZx/P9+deajGSPRmrGruhGY7ipJ1KF0Np9/ofw6G1q040CrHkIQuCiSLwrJugk
 xnYxXZVVD/jp73e0uz9k+2p/S1yltq2fm6L3Kel21x3DRs8aIgcwap3go03zLaaAmkgx
 3Z7u3nJ93eEyjYHSjft7csSowqc1sdYOioT1Ga+t/Fu0j9pE8ThH/nF/U3eh9RbAY7uk
 vAmw==
X-Gm-Message-State: AFq9FYKbA4ONzn7iHzH39z1CMfFRmPhuh7Rh7WmsIi0y3mwWgCAYKQGT
 cJmZgwc8qPGsrVXc7D2nj1EJrGH3jjO7VqIAX+Xz0BQmTlMD8Qkc3xkhquCpucFebsyjcwCjN4U
 WItXu
X-Gm-Gg: AYBFou1ZTz94qXfSEvKNCnBHSYVCOdvbC+lNFyJOtdATV8wEGPTgZpGZWZcClOiH9H2
 AK05A4VcK288UDFpONvorHD+g5vlQiejlAadyCBQBE192xeR5mjXJ1fB4sMcuVg9Npo2DHUzybW
 e+Ik5lNMeVGuMfLz/HAlw8RW2NtpRq/n3CPDMyiJuTm7D+XBljTYH8ZkeWOw/rkte3mMq/NvhBo
 gKqkrovaQA8RD2dcP0qBqK7mhzsZtVDjJLvxgynqa1MiuljbrqYcolOqUy4NmU1V9BJ5g2QbwsK
 XcbyI6zw5oSQtYiYaeGcB5AdaAB32/ZPMXktG0wWT+Y7EjgYZ+R3UzmfxhlR8n8pohQ2ho+PtBq
 k3l7JjACJkPuj+ZdhxeEwPc6CpZyxx/U07K+/DZnBDdnH5UbS1esfhBobQWJO75xMxZoCbt9QP4
 bu61Q+97mCxuheiri5XHEf+8YAan370mOGD4/3pM4Pt+0jwgjomT7aJMVIIcSmGSOFysLD0Nqvo
 I8vUdOIlzCBFu32cO8LoMgW+tGt8+Ws3MK+KppeS3tfgLI/YFXoLPzhS7BUK1A9H9vJPePm9ky1
 NOynUnySimFW1+gE7g3Kmt0xPQ1CC1E08QHNvS89FAtbSi8I+0TRnAIwR4r70NbazxWpbf+s5lR
 djfsGY8MfQQ==
X-Received: by 2002:a17:907:d645:b0:c34:db91:aa1e with SMTP id
 a640c23a62f3a-c49bdfbbe19mr310838866b.4.1793196884565; 
 Wed, 28 Oct 2026 07:14:44 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630210266b.38.2026.10.28.07.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:14:44 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 61/63] usb: dwc3: import from kernel v6.16
Date: Wed, 28 Oct 2026 15:09:27 +0100
Message-ID: <20261028140930.3025368-62-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v6.15 to v6.16.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v6.15..v6.16
Commits imported:
80e083943775 usb: dwc3: gadget: Fix TRB reclaim logic for short transfers and ZLPs
630a1dec3b0e usb: dwc3: Abort suspend on soft disconnect failure
170940f7e685 usb: dwc3: core: Don't touch resets and clocks
613a2e655d4d usb: dwc3: core: Expose core driver as library
850e634006f4 usb: dwc3: core: Avoid redundant system suspend/resume callbacks
8da7644493b4 usb: dwc3: Specify maximum number of XHCI interrupters

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 206 ++++++++++++++++++++++++++++----------
 drivers/usb/dwc3/core.h   |   2 +
 drivers/usb/dwc3/gadget.c |  24 ++---
 drivers/usb/dwc3/glue.h   |  36 +++++++
 4 files changed, 199 insertions(+), 69 deletions(-)
 create mode 100644 drivers/usb/dwc3/glue.h

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 66a08b527165..8002c23a5a02 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -26,6 +26,7 @@
 #include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/devinfo.h>
 #include <linux/reset.h>
 #include <linux/bitfield.h>
 
@@ -36,6 +37,7 @@
 
 #include "core.h"
 #include "gadget.h"
+#include "glue.h"
 #include "io.h"
 
 #include "debug.h"
@@ -1699,6 +1701,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_thr_num_pkt_prd = 0;
 	u8			tx_max_burst_prd = 0;
 	u8			tx_fifo_resize_max_num;
+	u16			num_hc_interrupters;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xf;
@@ -1719,6 +1722,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	 */
 	tx_fifo_resize_max_num = 6;
 
+	/* default to a single XHCI interrupter */
+	num_hc_interrupters = 1;
+
 	dwc->maximum_speed = usb_get_maximum_speed(dev);
 	dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
 	dwc->dr_mode = usb_get_dr_mode(dev);
@@ -1765,6 +1771,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				&tx_thr_num_pkt_prd);
 	device_property_read_u8(dev, "snps,tx-max-burst-prd",
 				&tx_max_burst_prd);
+	device_property_read_u16(dev, "num-hc-interrupters",
+				 &num_hc_interrupters);
+	/* DWC3 core allowed to have a max of 8 interrupters */
+	if (num_hc_interrupters > 8)
+		num_hc_interrupters = 8;
+
 	dwc->do_fifo_resize = device_property_read_bool(dev,
 							"tx-fifo-resize");
 	if (dwc->do_fifo_resize)
@@ -1851,6 +1863,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->tx_max_burst_prd = tx_max_burst_prd;
 
 	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
+
+	dwc->num_hc_interrupters = num_hc_interrupters;
 }
 
 /* check whether the core supports IMOD */
@@ -2148,27 +2162,16 @@ static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
 	return usb_psy;
 }
 
-static int dwc3_probe(struct platform_device *pdev)
+int dwc3_core_probe(const struct dwc3_probe_data *data)
 {
-	struct device		*dev = &pdev->dev;
-	struct resource		*res, dwc_res;
+	struct dwc3		*dwc = data->dwc;
+	struct device		*dev = dwc->dev;
+	struct resource		dwc_res;
 	unsigned int		hw_mode;
 	void __iomem		*regs;
-	struct dwc3		*dwc;
+	struct resource		*res = data->res;
 	int			ret;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
-	if (!dwc)
-		return -ENOMEM;
-
-	dwc->dev = dev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "missing memory resource\n");
-		return -ENODEV;
-	}
-
 	dwc->xhci_resources[0].start = res->start;
 	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
 					DWC3_XHCI_REGS_END;
@@ -2208,15 +2211,17 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (IS_ERR(dwc->usb_psy))
 		return dev_err_probe(dev, PTR_ERR(dwc->usb_psy), "couldn't get usb power supply\n");
 
-	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
-	if (IS_ERR(dwc->reset)) {
-		ret = PTR_ERR(dwc->reset);
-		goto err_put_psy;
-	}
+	if (!data->ignore_clocks_and_resets) {
+		dwc->reset = devm_reset_control_array_get_optional_shared(dev);
+		if (IS_ERR(dwc->reset)) {
+			ret = PTR_ERR(dwc->reset);
+			goto err_put_psy;
+		}
 
-	ret = dwc3_get_clocks(dwc);
-	if (ret)
-		goto err_put_psy;
+		ret = dwc3_get_clocks(dwc);
+		if (ret)
+			goto err_put_psy;
+	}
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
@@ -2232,7 +2237,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err_disable_clks;
 	}
 
-	platform_set_drvdata(pdev, dwc);
+	dev_set_drvdata(dev, dwc);
 	dwc3_cache_hwparams(dwc);
 
 	if (!dwc->sysdev_is_parent &&
@@ -2327,12 +2332,35 @@ err_put_psy:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dwc3_core_probe);
 
-static void dwc3_remove(struct platform_device *pdev)
+static int dwc3_probe(struct platform_device *pdev)
 {
-	struct dwc3	*dwc = platform_get_drvdata(pdev);
+	struct dwc3_probe_data probe_data = {};
+	struct resource *res;
+	struct dwc3 *dwc;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing memory resource\n");
+		return -ENODEV;
+	}
+
+	dwc = devm_kzalloc(&pdev->dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return -ENOMEM;
 
-	pm_runtime_get_sync(&pdev->dev);
+	dwc->dev = &pdev->dev;
+
+	probe_data.dwc = dwc;
+	probe_data.res = res;
+
+	return dwc3_core_probe(&probe_data);
+}
+
+void dwc3_core_remove(struct dwc3 *dwc)
+{
+	pm_runtime_get_sync(dwc->dev);
 
 	dwc3_core_exit_mode(dwc);
 	dwc3_debugfs_exit(dwc);
@@ -2340,22 +2368,28 @@ static void dwc3_remove(struct platform_device *pdev)
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
-	pm_runtime_allow(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_allow(dwc->dev);
+	pm_runtime_disable(dwc->dev);
+	pm_runtime_dont_use_autosuspend(dwc->dev);
+	pm_runtime_put_noidle(dwc->dev);
 	/*
 	 * HACK: Clear the driver data, which is currently accessed by parent
 	 * glue drivers, before allowing the parent to suspend.
 	 */
-	platform_set_drvdata(pdev, NULL);
-	pm_runtime_set_suspended(&pdev->dev);
+	dev_set_drvdata(dwc->dev, NULL);
+	pm_runtime_set_suspended(dwc->dev);
 
 	dwc3_free_event_buffers(dwc);
 
 	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
 }
+EXPORT_SYMBOL_GPL(dwc3_core_remove);
+
+static void dwc3_remove(struct platform_device *pdev)
+{
+	dwc3_core_remove(platform_get_drvdata(pdev));
+}
 
 #ifdef CONFIG_PM
 static int dwc3_core_init_for_resume(struct dwc3 *dwc)
@@ -2388,6 +2422,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	u32 reg;
 	int i;
+	int ret;
 
 	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
 		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
@@ -2406,7 +2441,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		dwc3_gadget_suspend(dwc);
+		ret = dwc3_gadget_suspend(dwc);
+		if (ret)
+			return ret;
 		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
@@ -2441,7 +2478,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			dwc3_gadget_suspend(dwc);
+			ret = dwc3_gadget_suspend(dwc);
+			if (ret)
+				return ret;
 			synchronize_irq(dwc->irq_gadget);
 		}
 
@@ -2544,9 +2583,8 @@ static int dwc3_runtime_checks(struct dwc3 *dwc)
 	return 0;
 }
 
-static int dwc3_runtime_suspend(struct device *dev)
+int dwc3_runtime_suspend(struct dwc3 *dwc)
 {
-	struct dwc3     *dwc = dev_get_drvdata(dev);
 	int		ret;
 
 	if (dwc3_runtime_checks(dwc))
@@ -2558,10 +2596,11 @@ static int dwc3_runtime_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwc3_runtime_suspend);
 
-static int dwc3_runtime_resume(struct device *dev)
+int dwc3_runtime_resume(struct dwc3 *dwc)
 {
-	struct dwc3     *dwc = dev_get_drvdata(dev);
+	struct device *dev = dwc->dev;
 	int		ret;
 
 	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
@@ -2571,7 +2610,7 @@ static int dwc3_runtime_resume(struct device *dev)
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (dwc->pending_events) {
-			pm_runtime_put(dwc->dev);
+			pm_runtime_put(dev);
 			dwc->pending_events = false;
 			enable_irq(dwc->irq_gadget);
 		}
@@ -2586,10 +2625,11 @@ static int dwc3_runtime_resume(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwc3_runtime_resume);
 
-static int dwc3_runtime_idle(struct device *dev)
+int dwc3_runtime_idle(struct dwc3 *dwc)
 {
-	struct dwc3     *dwc = dev_get_drvdata(dev);
+	struct device *dev = dwc->dev;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -2607,12 +2647,28 @@ static int dwc3_runtime_idle(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwc3_runtime_idle);
+
+static int dwc3_plat_runtime_suspend(struct device *dev)
+{
+	return dwc3_runtime_suspend(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_runtime_resume(struct device *dev)
+{
+	return dwc3_runtime_resume(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_runtime_idle(struct device *dev)
+{
+	return dwc3_runtime_idle(dev_get_drvdata(dev));
+}
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
-static int dwc3_suspend(struct device *dev)
+int dwc3_pm_suspend(struct dwc3 *dwc)
 {
-	struct dwc3	*dwc = dev_get_drvdata(dev);
+	struct device *dev = dwc->dev;
 	int		ret;
 
 	ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
@@ -2623,10 +2679,11 @@ static int dwc3_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwc3_pm_suspend);
 
-static int dwc3_resume(struct device *dev)
+int dwc3_pm_resume(struct dwc3 *dwc)
 {
-	struct dwc3	*dwc = dev_get_drvdata(dev);
+	struct device *dev = dwc->dev;
 	int		ret = 0;
 
 	pinctrl_pm_select_default_state(dev);
@@ -2645,10 +2702,10 @@ out:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dwc3_pm_resume);
 
-static void dwc3_complete(struct device *dev)
+void dwc3_pm_complete(struct dwc3 *dwc)
 {
-	struct dwc3	*dwc = dev_get_drvdata(dev);
 	u32		reg;
 
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
@@ -2658,21 +2715,60 @@ static void dwc3_complete(struct device *dev)
 		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
 	}
 }
+EXPORT_SYMBOL_GPL(dwc3_pm_complete);
+
+int dwc3_pm_prepare(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+
+	/*
+	 * Indicate to the PM core that it may safely leave the device in
+	 * runtime suspend if runtime-suspended already in device mode.
+	 */
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE &&
+	    pm_runtime_suspended(dev) &&
+	    !dev_pinctrl(dev))
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dwc3_pm_prepare);
+
+static int dwc3_plat_suspend(struct device *dev)
+{
+	return dwc3_pm_suspend(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_resume(struct device *dev)
+{
+	return dwc3_pm_resume(dev_get_drvdata(dev));
+}
+
+static void dwc3_plat_complete(struct device *dev)
+{
+	dwc3_pm_complete(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_prepare(struct device *dev)
+{
+	return dwc3_pm_prepare(dev_get_drvdata(dev));
+}
 #else
-#define dwc3_complete NULL
+#define dwc3_plat_complete NULL
+#define dwc3_plat_prepare NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
-	.complete = dwc3_complete,
-
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_plat_suspend, dwc3_plat_resume)
+	.complete = dwc3_plat_complete,
+	.prepare = dwc3_plat_prepare,
 	/*
 	 * Runtime suspend halts the controller on disconnection. It relies on
 	 * platforms with custom connection notification to start the controller
 	 * again.
 	 */
-	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
-			dwc3_runtime_idle)
+	SET_RUNTIME_PM_OPS(dwc3_plat_runtime_suspend, dwc3_plat_runtime_resume,
+			   dwc3_plat_runtime_idle)
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 27eae4cf223d..d5b985fa12f4 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1083,6 +1083,7 @@ struct dwc3_scratchpad_array {
  * @tx_max_burst_prd: max periodic ESS transmit burst size
  * @tx_fifo_resize_max_num: max number of fifos allocated during txfifo resize
  * @clear_stall_protocol: endpoint number that requires a delayed status phase
+ * @num_hc_interrupters: number of host controller interrupters
  * @hsphy_interface: "utmi" or "ulpi"
  * @connected: true when we're connected to a host, false otherwise
  * @softconnect: true when gadget connect is called, false when disconnect runs
@@ -1333,6 +1334,7 @@ struct dwc3 {
 	u8			tx_max_burst_prd;
 	u8			tx_fifo_resize_max_num;
 	u8			clear_stall_protocol;
+	u16			num_hc_interrupters;
 
 	const char		*hsphy_interface;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 321361288935..74968f93d4a3 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3516,7 +3516,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	 * We're going to do that here to avoid problems of HW trying
 	 * to use bogus TRBs for transfers.
 	 */
-	if (chain && (trb->ctrl & DWC3_TRB_CTRL_HWO))
+	if (trb->ctrl & DWC3_TRB_CTRL_HWO)
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 
 	/*
@@ -4821,26 +4821,22 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	int ret;
 
 	ret = dwc3_gadget_soft_disconnect(dwc);
-	if (ret)
-		goto err;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dwc->gadget_driver)
-		dwc3_disconnect_gadget(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return 0;
-
-err:
 	/*
 	 * Attempt to reset the controller's state. Likely no
 	 * communication can be established until the host
 	 * performs a port reset.
 	 */
-	if (dwc->softconnect)
+	if (ret && dwc->softconnect) {
 		dwc3_gadget_soft_connect(dwc);
+		return -EAGAIN;
+	}
 
-	return ret;
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
diff --git a/drivers/usb/dwc3/glue.h b/drivers/usb/dwc3/glue.h
new file mode 100644
index 000000000000..2efd00e763be
--- /dev/null
+++ b/drivers/usb/dwc3/glue.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * glue.h - DesignWare USB3 DRD glue header
+ */
+
+#ifndef __DRIVERS_USB_DWC3_GLUE_H
+#define __DRIVERS_USB_DWC3_GLUE_H
+
+#include <linux/types.h>
+#include "core.h"
+
+/**
+ * dwc3_probe_data: Initialization parameters passed to dwc3_core_probe()
+ * @dwc: Reference to dwc3 context structure
+ * @res: resource for the DWC3 core mmio region
+ * @ignore_clocks_and_resets: clocks and resets defined for the device should
+ *		be ignored by the DWC3 core, as they are managed by the glue
+ */
+struct dwc3_probe_data {
+	struct dwc3 *dwc;
+	struct resource *res;
+	bool ignore_clocks_and_resets;
+};
+
+int dwc3_core_probe(const struct dwc3_probe_data *data);
+void dwc3_core_remove(struct dwc3 *dwc);
+
+int dwc3_runtime_suspend(struct dwc3 *dwc);
+int dwc3_runtime_resume(struct dwc3 *dwc);
+int dwc3_runtime_idle(struct dwc3 *dwc);
+int dwc3_pm_suspend(struct dwc3 *dwc);
+int dwc3_pm_resume(struct dwc3 *dwc);
+void dwc3_pm_complete(struct dwc3 *dwc);
+int dwc3_pm_prepare(struct dwc3 *dwc);
+
+#endif
-- 
2.53.0

