Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F3606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pRqIKeMD;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dAe/832A
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A570260DE5;
	Fri,  6 Nov 2026 21:37:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zlM3y-B_ATvl; Fri,  6 Nov 2026 21:37:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCD3560DCB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794001028;
	b=XKVnTHkvasW9k7TKvQW2i0leFA78NuxnxI17mbdQ6k5yTNsNxLx2m9My7wRdYD5rOZKe
	 9igpSfQbHsgF14nfafzGGcvdv+ozCePn9atlAlHFBSFaJJTWrDq4o43Sbtyhu7Vk/bZZd
	 sXfk51QQczKJ5RAqVT0JODNPNVlFIaCBgDuxJ9QU++WgxP/DZ2442kxv/Is7T/HDOh0hA
	 XO08cbuUBzcmjyvdUdYK3BpVnjEjrBKPg6r0Y3niLSS5G05k/z0tD70Vi1mUHdlJ3LZaM
	 kno7U7lrHVROeJnpeDvtxwJNJIaOxc8sbu6hHr7AmgMmsoQ6JodTjaKVZqktGTXF6Aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794001028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LoCtm2Som1c1gL2zvQK7kU5rEHSblLKszOU6ze5qPL8=;
	b=Fg+thDuwpbIuTfoF7gO1xOb4FMTYMZ/3xaHB3O8ej5QCLgJSE6bmnrfNGaQtD3DKaTWL
	 Cr08dNS8JsltAfXk0c5G2fH6XT7U0jN382Xl8i0OfsGyMB2SLG5+Yf+JIu2/FGdigzs+s
	 HxQEY7P25Ttow5soMliPPxkLtg8wwtnWxCexWkgubMRq9tz1ZS+igJDkT3+i89+36cQuJ
	 mtQnn/Ox9qDsR72LwUsV1G8909YpbheDrGK7f37BXy1eInreIUukHKKC4Kuu9ls73PQe3
	 BB1KIX7FeqppqS5g/+kwupUfkHTj1hsEkOBb24srKSUESeZ6MS9Cg9kY1FtRBnLmT2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794001028;
	bh=LoCtm2Som1c1gL2zvQK7kU5rEHSblLKszOU6ze5qPL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pRqIKeMDnsZQbRkiMEaxr8+eBjPCorVClAUx/Ye9AzZLpl7fyHlvB36w76qTk+Ivr
	 jeJteGjx2JrtBUuzQRybN38du2czNSb/O2lPPuGcNi9Xnq5BQUPEY6lx0cV0LcagMW
	 X3DuPoucPdSeLvHW+jqDut3pYvXKtoR2JJj6FWJ+UMnjc0bjbfSenW6WhLabZdr9Y4
	 M6gnFc4NZtKixmiS5u4aXypIEVBnk4Ox4Wl1Ume7W17jDE8fwTQBKtPKFj4vJ5RN1K
	 G9za+Z0nn6JPXGcWdECOYgkdXSjPi7rwXIWd4vOoZrxuw8bBkh1t8YScDe0DX+eqOF
	 JrnUZP7QfGfZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCD3560DCB;
	Fri,  6 Nov 2026 21:37:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F1051C6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4038181421
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TtDVvu4T44cr for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:37:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F85A81671
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dAe/832A
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F85A81671
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:37:01 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4b28d7c729fso755524b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794001021; x=1794605821;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LoCtm2Som1c1gL2zvQK7kU5rEHSblLKszOU6ze5qPL8=;
 b=dAe/832A25bGvK6mEE7hbNtb2F9LAuEoUbVw6LMzNhFPK8WB2Ywr4MMfq/scLzoucq
 L8kEl6V6oL+RxCaJ/B3Fe2ur177HGf8rVZGB5Y02jvHiQcsTkcDrJLdBGZAzYocyN8cz
 QYCktwYFNf1mlXbk0cQvt/UL1NqcAIiZmYWTyywZlZp8pWIvA1gSk+bULgMwMbW9Tot+
 K+3ehzN3pQiK8aRHhuRmcM4RLJ+u5vVPqrYN+dmPRmy+yP5Qt7uNPcG/UHyLInA+Kbdy
 VAmpKp9A47bi9XhVg2P2pQOb54zLPacALpN3mdlrifxL/33ux7N1ytAupPcdzEmoQ1VA
 8J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794001021; x=1794605821;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LoCtm2Som1c1gL2zvQK7kU5rEHSblLKszOU6ze5qPL8=;
 b=BszlowlbIdnDTz1fFZ5nSqlabqexM3psdTFTJetID5UJ0lxeQytuymfmoMYxu5cgIT
 wtWBJjIVwrjzcw7fnVjK7XLWaTg3n6KSSIkxnN+WYYknCB/WodQ7metml0/etaoRf8YH
 dKx6HrQ1pqna+Cufrp6cTbV6bkkq1Fjx+xcFQ//sBd2+/5K67WWnm0jw2NQT1f6VvkGO
 nF3lJ+rQxweZ3qqOiwrnnfOsmi5pLjlXx01JcZYruXgEQhX3jZT4l1JDESSW3sifyWb3
 cbC9ziHhNVa7K3tBXslNWAAYGZNVr8/KOBwvh/kexfbbVZkv2oREkjP6quNtE4xQWg28
 XBfw==
X-Gm-Message-State: APuU4Z8wXEhCVmhOBswJ4bpP7a0PNZAhMDDMQn39AIPu1pwPvyC7m0my
 CSPg5JjREaA3M6XNu3MQlZ3vMOmuwV0e3E7eroFFiD42ihsvZvwvmF3CEToyVMGmcUk=
X-Gm-Gg: AYBFou04lJ7XWw9Vi6v4txcAEpz5qF5tKoi1Y+lVTPr4NBkb/49NkvIOaY6kxR7vs9X
 VpmI29hvjlKZQ/YNrlfrAAALvFS9ehd9fGz8+u90TklJ1t9hZsU4Nc2gGUJWKBC2t1GumhAIY/D
 HbpKOSpYY5VtVE2uRaS4Yj3IOMr9AbXjX9B67EwhD0S1yPkYmIhG/3ZZo1HpTCGojHfTWCIVyuq
 hzqZdAuhevublIFKw/Zhlr6/R4r0EYmj9buhXRuJbr6EK3ilJErvUDI/tM+X6hFfkAV3ntwirLw
 QPeQRGBgRA0YpgDCRXlXWlHq9jSqRkbb9K0EoSvt6eppRCs9ZJzXgTnqGUDaoqdd6NDgJtch7uZ
 iexGjX/+/OOsnT/hrxtwSNsL55+L0SlPbzaHuxMslKsoK6xwwICXuNcfXpxTUtB5AEksc7MQuud
 XkmGROFs+s6Cj24NHHgVcCbWsaw5x4wnfxlOi9dXZ/zgjC+qdFi7fUAnyIbjttY7qyG+1neptNz
 HFH1epg8PltO4x53cYrwcgHVr1Zj24rm7uaJ1FWSWEsTcpSUhz/NRfUNQl6MmBWY6icorL5GZMn
 GlRRA3D5u/ZPB74UcrUFOzR2FxpQqRdymA==
X-Received: by 2002:a05:6808:5197:b0:4c0:12f3:6007 with SMTP id
 5614622812f47-567e0fa64f5mr2836420b6e.4.1794001020970; 
 Fri, 06 Nov 2026 13:37:00 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7e70338sm2475624b6e.12.2026.11.06.13.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:37:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Nov 2026 15:35:56 -0600
Subject: [PATCH 6/7] board: mediatek: add a Genio 520/720 UFS boot config
 fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-mtk-genio-720-spl-ufs-v1-6-90c578b6c43b@baylibre.com>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
In-Reply-To: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Rv9a848GlBCScGYYpRLkvW0eocX4kUFDXg6dolvIxcw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7khiaVnRDGi8JXCgxRoIOuaibcD8tNJ034Egm
 7Omh088ATiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5IYhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1O8H/1glH9ZPbPpC4LQzk4AUqKGh5xc+fxl72PryxPD
 zoisu0D6/9ZywMgk0XUtyiRcriytJL17Tk86iBUVXJ6KqeWY05Sz/tQhN6zexd6GBFQYO1NK6Wh
 0j6+pHVGqR+MtkG1rfq7+0v0+V6nOpjuVsHwlZw5iXHhtP6g8BvvvztCde+pZkANk65Lw5subQT
 aUU+SOhSkL1/OvPy3g5wufDDN9F9YWOM8LLJMxpEKJApIgaF958TJjkAU0fd3pCqNVadr7lONLY
 MhQpptzhigcnxZ5qEPx4MmWUa1vlJlI+VwPx4IF8MerSfTUUOKIK1NWqpznNKsL9bM0L6i704T8
 qDEA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a config fragment that builds SPL for booting the Genio 520 and 720
EVKs from UFS. It sets the BootROM image header to UFS and makes SPL
load the firmware FIT from the bootloaders partition (partition 1) on
the main UFS LUN, which holds the GPT and is SCSI device 2.

Disable MMC in SPL, since SPL would otherwise pick MMC as its boot
device. This also keeps SPL small.

Use the fragment together with the board defconfig, for example:

  make mt8391_genio_720_evk_defconfig mt8189-genio-spl-ufs.config

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS                 |  1 +
 board/mediatek/mt8189-genio-spl-ufs.config | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index fa8a3ca086c..601e1c5c89a 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -6,6 +6,7 @@ F:	arch/arm/dts/mt8371-genio-*
 F:	arch/arm/dts/mt8391-genio-*
 F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
 F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
+F:	board/mediatek/mt8189-genio-spl-ufs.config
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
 F:	configs/mt8391_genio_*
diff --git a/board/mediatek/mt8189-genio-spl-ufs.config b/board/mediatek/mt8189-genio-spl-ufs.config
new file mode 100644
index 00000000000..884b9b97a44
--- /dev/null
+++ b/board/mediatek/mt8189-genio-spl-ufs.config
@@ -0,0 +1,10 @@
+# Boot the Genio 520 and 720 EVKs from UFS instead of eMMC when using SPL.
+# Use with the board defconfig and the -ufs devicetree, for example:
+#   make mt8391_genio_720_evk_defconfig mt8189-genio-spl-ufs.config
+#   make DEVICE_TREE=mt8391-genio-720-evk-ufs
+CONFIG_SPL_UFS=y
+CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM=2
+CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION=y
+CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM=1
+# CONFIG_SPL_MMC is not set
+CONFIG_MTK_BROM_HEADER_INFO="media=ufs;arm64=1"

-- 
2.53.0

