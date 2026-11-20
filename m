Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30C606A330
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nk9FVIVf;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UadsBjpE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2327D8177C;
	Fri, 20 Nov 2026 21:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E0_h3A7N65eS; Fri, 20 Nov 2026 21:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 610AD81779
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795211452;
	b=TFZIExO5s2GCamB8qS8dkKhbYgijCbVzgXQ/jh8FS22hNTl53GSwsBzbWd7QSAKf+OQu
	 eoAkXBUPpYrBieM7aoL2ckn/O3gGtsGERVci35WK76t+9qlnmUxop5Mf8X6YIfjh1CgOG
	 1K2cxQuI+Gu2OBldcagFhhYy4dE7UBiPv+f1QtDUOv3SKwO1OUz8D8ubrtKIEJhWrPwqQ
	 VT6odSErklm6iY2PMMPwbwvPtIjE3UryCV1Is1c6E7btMsluw5pFL0ObsZwNPHimDM0ST
	 MrClSN/Cg5WJ2qGlPM6Me+LvnG6jIKeaQBe25KXk11t54pxv/6jMES9QSKUumJiMZAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795211452;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SuWRLmNi2NvGf9fE+xVutTzBafVOrr2qRxNxTln7a5I=;
	b=SdviZVr1nNO8E/RraDPUYx/7v3G3KK/6Vm09H4XyN40C6fezAM6yu+5OCGwJhttBcAWA
	 TT+ModbNCFZ56vtvGpqJIaKsYDAzfrloozmdhWdRT8dnWPBbtf2HrWyXtp8/B9fiKb2qg
	 9xZ5wtGW87SaYDg0CfQ9We/S+MQbwBfQX498gXFpPMA1Ez4db1yu4wfLco0R5PEMVvGIi
	 VJONYNGt1srLsRk++eRIsgKLnoccG+4DTCI3hAD5RY0Cp+m+GyEJNUJgPXx8L+SYI0ygj
	 HU1zwFJBOSh68NexKJp47w9J7UbtEZ0P8793iTvmo0ymbv0RoAmT6YLBuztrrhb7dCg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795211452;
	bh=SuWRLmNi2NvGf9fE+xVutTzBafVOrr2qRxNxTln7a5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nk9FVIVfdwR+qQ3iQC3KzCUmNRyEjB3V7qlQwVfim/XQGMNL/pNjLfbvAv0JUWrBl
	 iutKibg9YkOvIvjmhA6ikwOBzRSqohM4Y/QjGllGP1mrZTXGwfI+sUJhduQ4GZJgiZ
	 g0J9etuQOaxA9bHxHKQONpHGk0AlZZTOTAzjsn2gHuxpPhvavl6P2HGUGTH04zd4mO
	 /LcIoYIPg1Eb9frrBy4my1QQ+3/x6YYRlri6BEVNHforlOWJ3lKIgoWOEVGGy+duHw
	 oDc6UQ6mhsF5RPgAoh3wehJqQrExg7qVlORWHAMoEoMEUwxl0LiP5eGzxU0uSZ9O0K
	 zjNWRVCrd4YAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 610AD81779;
	Fri, 20 Nov 2026 21:50:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 84408169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 662BB40D91
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sj0MAcoLnjuH for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:50:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 838D340D6C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UadsBjpE
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 838D340D6C
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:46 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6d68de53053so1010316eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795211445; x=1795816245;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SuWRLmNi2NvGf9fE+xVutTzBafVOrr2qRxNxTln7a5I=;
 b=UadsBjpEYd4rzfQydeT3WJS8mjoCXteKEwIsKrJujLCWnM4mUUjtGi0WYhxRX/5Roc
 NvEThxPaEL7zRZrNm5ROCgH5beH4d5OX9dFoGZRdmO1trkQozeIddK3WggxWx1biUypP
 FRGUq07vUjwmCVDYPf3TEDOOcvqny7u8mc1sngcAY4e6OLXxYgVgh95eC6D5V1wnvTmP
 CuTZOUwmM1B+kjpyPK9RWkj861a7CENwsUrUbdeCO/9/6C5Pxd22NMPpAasL5Md5ZUA1
 gRwaGs02PZAFwTkMBc/M7LyqHa/5nvieXlO+ZdA7FfKQzMNAYzOvJ6SYLIs+icTflyKh
 KAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211445; x=1795816245;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SuWRLmNi2NvGf9fE+xVutTzBafVOrr2qRxNxTln7a5I=;
 b=tqrAll2tiNL9IilNsZr5KQlPTRYM00lpjOamIzZEVrDIYfEUblPcjkRiS1F/TINJfH
 5iMT+dREKZ9rBB8Tgw7flJGMAcEvKg5EJbD5rSp9D3MHXGY7K8/70YhfebWiV0oMJ0JJ
 /O/GmfQ+cYN1noMDJdUsAoUUPTLDz41LVF0HqOa7CI4zIThH1F7CFBwwDfwFrCskageM
 i9E4AKcmKksggUe3inci9U7m6tn7azjjOBqRWVuH6DW4fdF9FiIdVnwsnzhlIz3F5Sqq
 PoFTMBKGp0+ARq2pBWqEjy/vjLJxbura+kQWDvE+IbssvBnbX+0GlsTTu6to+Zkz79rw
 5xWQ==
X-Gm-Message-State: APuU4Z/6vGDYtG5mE7PU2nTMxlkAajbP3/ZHrOpY1YZoYut20VfS0WMe
 SBcbn5s5a6E/jI/rap2Px0PM64hpdtnfZ1dPG9UJskoccnjXbzgKJ67WiQhids4XH2s=
X-Gm-Gg: AYBFou3/YBel6UpDAktci+VgYtWtEey4mJBp9NFpeUvGiZaxS0OmuqNHKuBRMDNRnWq
 tU6zQgr3uQQZ5rdGtQIVj/a92+OanNd1WTzvdD8FgDrO23CwHFh6fXbpYRZJcxjYVlHGkoIC36Q
 m8dgb3n2X15pIZ1bWQ7YhCcCOCJNMf0WVxn9WhDGjk6kAP466mpkeJ9fXN5sozk+fsG7GIORU0c
 Vp4F6Hqiwnp/sIhdFymP62ApeLCwQJRLERqcIbHcJBQ7/43dWW4N2Y3prIN4SpxFN4/SwgvrbHl
 sbBFpfkgbdr66CSH2J6HfJQ8Ny2oNWyiCswmWZ2AZlp6bEswCkB06O0YNQSfRRgynmny+fxiiCs
 bMZhRsjxSEbqYYmehxb1rf9DqARE5pmUnikd8sMSNiUVmQrSQe6Yg+VbDo9yaRILQzel1+2C+jl
 thE5ze/Dkwr4Q5mwAN5xDqnjEx+RyhLsb+urFe8exDwV9SGMw5vMy4meL6KchlbBmqLykdkt61Z
 xoznKH0IYb5ZQRXl+WxrXg2Y49MK1nr7XayJjcHJv1V+OrF5Zrbnb2teC6rdJWbhbyC4zC35GPz
 2z3DcDIQTxVK8+Ch/peNZ4ycAv58DAJX
X-Received: by 2002:a05:6820:3383:20b0:71a:f253:8ac9 with SMTP id
 006d021491bc7-71b39581b62mr2456220eaf.78.1795211445040; 
 Fri, 20 Nov 2026 13:50:45 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bd044fc4besm2846726fac.7.2026.11.20.13.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:50:44 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 15:49:30 -0600
Subject: [PATCH v2 3/8] arm: mediatek: mt8189: reset the UFS device without
 the secure monitor
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-720-spl-ufs-v2-3-3ef93cb27dcc@baylibre.com>
References: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
In-Reply-To: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=daRBUgAA/vbOVCp8YoUUhoP0RYSnNZgXTYiwWZsnDUo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMCBdeCZgdg8SlNg38ff1MfiOcSaJkHwyqcEF
 /js2H2KTV+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDAgRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASOkH/R+aYWXnvSfK6hJMUk1GIWa35A9vt7vFjsvCN7F
 xIR1eHRu5UyPbVHoMZTzks7A6++C3V2dLIIc5bSmSA3r+oWfegeu7exUioCWQ1JqHEUZo8WSfL6
 s6nkM05Oyi3fkhK4B6tgRn/pJxT7HdB0ALl7MAWm2g2lt5aGfRQLmtS0yiDXHnNbNJrsCZ12Ge6
 sKnqiRUiqLDP9FQYJPxQh9wOMDKAoua2xJck5jqktf5z8KOrPoElHBTudGgwV+2NGEJTM0fJ8Kz
 cNkgolr6+dyFzGeG5le3nVsKscPZbHcOMg5S+cUcrmw663vi+OURWLhfVr6SgUCtq38Yzb7QyE/
 Zy2k=
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement mtk_ufs_device_reset_el3() for MT8189, so that SPL resets the
UFS device itself instead of relying on the boot stage before it.

The BootROM only brings up UFS when it boots from it. When it boots from
SPI NOR, for example, the device is still held in reset when SPL runs,
and the UFS host then finds no device.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8189/init.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
index a0de674c452..33ddba4b381 100644
--- a/arch/arm/mach-mediatek/mt8189/init.c
+++ b/arch/arm/mach-mediatek/mt8189/init.c
@@ -8,9 +8,12 @@
 #include <fdtdec.h>
 #include <stdio.h>
 #include <wdt.h>
+#include <asm/arch/ufs.h>
 #include <asm/global_data.h>
+#include <asm/io.h>
 #include <asm/system.h>
 #include <dm/uclass.h>
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
 
@@ -18,6 +21,10 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+/* Reset pin of the UFS device, active low */
+#define UFS_DEVICE_RST_REG	0x112bd090
+#define UFS_DEVICE_RST_N	BIT(0)
+
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
@@ -79,3 +86,13 @@ int print_cpuinfo(void)
 
 	return 0;
 }
+
+int mtk_ufs_device_reset_el3(bool high)
+{
+	if (high)
+		setbits_le32(UFS_DEVICE_RST_REG, UFS_DEVICE_RST_N);
+	else
+		clrbits_le32(UFS_DEVICE_RST_REG, UFS_DEVICE_RST_N);
+
+	return 0;
+}

-- 
2.53.0

