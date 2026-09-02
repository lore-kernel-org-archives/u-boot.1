Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81611C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 19:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44F0840AB9;
	Wed,  2 Sep 2026 19:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x0IXTtoz1uyo; Wed,  2 Sep 2026 19:43:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B612E40AB3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788378186;
	b=Ra78h01JPaBk4RMo/tY9bK1WMK3n3hg7lWEmJf9o6lwjkJACEW47Fuu6uaeB6gYOZgaP
	 fOqZQAR/LMUZaG0/VJa2EmbcdFrOcY0JNV5Sy+WDrz17/cSDOWFgZA7hQwl/a0qB/zBdl
	 zHIzfBlpvEzHDcF49cCMkb5uvmIaSADRLDSjGgEl28J8uVeamHg2uHzsbol3UJpq7QcnV
	 1+prF4dwa8/UfY8QSNR51cyAaVUzFZuYlu/L8MGGCAlUj21GTMXzukUHgDEjuarfRIlIF
	 CMlWlljIGOVzvntpg0P06/igDFD8MUHmD/OLk5U2dVFfI9OFDKQ2aDO4K3dgp/GAyig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788378186;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0MeySjZ38+NpBxHE/JhIapwa4LvT6VPaHzqdp+E4Q30=;
	b=k72xbQp12+KiQsyWtd9vi3NndNn1Aw3w9gKKJK6BKfmWlzEpz1bsd0rUw0IDMjEmh95g
	 sDSehDi4vtUo60GEOoxMcskP8vjAz6GfbvsnIY7Z7mHsxAKquVbu4dGUFDPlhqDn3qKCp
	 APSAlvooZJVJ9M+Dluvy3byrBmp0iECMRD5byK+5UI5xcb6D2I6+/4sGg/m/I/fhJByt1
	 Wz3ZiQAYLQUfIVykVbSloFL3z35qkl2fXyKbQb7jWYaLXzuL/EfLwZ6nEkJ0TKYV/elTJ
	 5uDrfbhi98ug/rvRmpedAQgnJ75GVsZJQiF2LKrgMsspbduhs2x6/cEFwYXo8HTFtKA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XFflqXgx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788378186;
	bh=0MeySjZ38+NpBxHE/JhIapwa4LvT6VPaHzqdp+E4Q30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wbtysp7URLrNFPuFzFTi/ZxhCRz5VNjuDM1SGklgDUXhBLkiTFJCheLOvp3LjTlfT
	 AmzryflP4Lr31UMyAJBX0niaxokJ1RcyGEqQjBZDIeuvYXiOjQWzFuxqeu3nFVCMha
	 KkJycq3SYs29g4rEjBoD8ywCvWux2NCMtyCMBC87hNQWzMl8W5cNJMl0jx8TNqZlVZ
	 Uy8+g1PcPTcx+Rq2Y1umxObjL9g+PsWqyZGntvKaPG5648bB4rZ9+xuil8XsyJYEmw
	 +lBWNRLqUOiB4qfYK67i/r/aHCA7BaJH0lQhtbSlSx5TD4uax+jzcPxWygxvuZ3a5+
	 vNBeli8RwaQmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B612E40AB3;
	Wed,  2 Sep 2026 19:43:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B5D321D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A30E407EE
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wVisA3obJ7aL for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 19:43:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5FB7B40805
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788378184;
 b=te1/waaGs4Vwwj71uvnu8UUZmo6CcVWxOx8XrryhTYcF46hjRZ7EYF9hWcjMp9h1ooS1
 FD7TdP3Gh3qgPFXN93GWuWvAxHjhsPjvOKghue8NfHoGEFKrBw+5jwFH0DzX7kpjLRZBe
 vElmVkOfhEW4qUOW8S+U4Rlflbh5UcLxaSobu+9AnpJKVVFVTqqEgx1BqaJ9n48m1GtKV
 0Ul2YBbcFkMzj+872Z5JwMkEbnCagcspWZ70f0CcRtdKw5B+WdynNLrCyowMYbWXTJHl8
 XImkfoZmIprHHOQ+0lVD3yAA5f1pe24W9Dtw2IMgMnnazkXDrEwPlac2BkyQoS8I5gQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788378184;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=0MeySjZ38+NpBxHE/JhIapwa4LvT6VPaHzqdp+E4Q30=;
 b=p+zBgZukP5kbpf9gO879WnLBuOXgRb15TEMMyc6brR/f0JGt5Vtf267V3rCcBigesYxR
 zw2Rk0yG01W7kRd/TYYTaAg59p9RbIoUqzKby0pOCuZVN8pQLbCsV3JTYHiFAShhD1+gz
 VnFWk4xKZOv44oUaqGdwjUg0FjOlwYzYvLVXFkfrNTmYzRt29Cz2rWKcfgmp1TYnEe2F0
 IpWEMHb31De22XprlPoeaUmRaEWTwXVLSd3PyYCgjYUK6nVPj7Nwmv3ZgYYo7vlY2OjXV
 ptpAlaDzGKHRJHk5Pb3aeGxv/ZrKjsMoJLlorFm55SQEbtdyvXI8aUtibqMAVtKAqbg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XFflqXgx; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XFflqXgx
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FB7B40805
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:43:03 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-467a6834028so950478fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788378182; x=1788982982;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0MeySjZ38+NpBxHE/JhIapwa4LvT6VPaHzqdp+E4Q30=;
 b=XFflqXgxUFqk4RA93jeWMOHS4JHszbR2Vj2gnTV5muQdVLAyAwF4OBg1H03Ug2JE2C
 HXoG+e3tzrx/zZIrnI/H6yhZWVDCiG0J/zWEx1zBsWEfU0yROfmUx/qmHDFW9RXHOrO/
 jp6WuUaKRcmO/zH5+lptfbvcmI7rEtm23r17x8z4F3ojyGdj2LAAkKUsISyv35Tr6EzC
 UZc1bEFYcImpiwdqTpcvtgHcEFOQ59P4rPzaxvgN22vgflvE0Xy8P6v0d1LssL4PfODe
 I1pjwrPcm/ozr/veH+zNHaGQ6XANe9cru8AZBrwBbNKjaDR5wGHhQVzlfqRSEfoMXwrp
 7H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788378182; x=1788982982;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0MeySjZ38+NpBxHE/JhIapwa4LvT6VPaHzqdp+E4Q30=;
 b=iG1BDSBUEfNmF0liM22mEATaU4Oiwv3gSH7ua9EXtlB4RibdrM7vS3FmIVF8sRYLks
 NSVy5b2rD1PFiUESw70aZAfgwih7C4QUkKWzvj/h0zxq04kt5yF1PEjRDfgGxiKPqB/D
 PvSnqjsNmj4ccG8a3N7sH5cf4vzyd8lFzjpIPdNcm4TSNzLp30CVtJEpsfisUaXDPvT1
 +fL7pZGqTKlUC80I4xpjHmRv9LZyH6e2+Kvd/40Nl6uzODLLsAwK5JyzDHi5Xnb6S0zC
 kffHbOiB/MmGG+nrP+ejihTk4hCtfjfghqt0fhR+1pD1dEKpMp1QXY6EcpsrquBm9rFD
 8q8g==
X-Gm-Message-State: AFuF++nk3Bf8JkVeNdVyYKieQPMFM5kma8/yBet4qCuFhS5CMZsR5dOd
 ws8IuM17SrsAYWltV9pHNEjyGGEY+pRVy8Mv7FfuyjQJJYTuYkuy2QHN9LKCJtpeWYM=
X-Gm-Gg: AYBFou2FteeSy0W5Gg0GYOLBOq7St0G0lV/hHEgQCQX8VXcLPQifMMylnr8cH3HjeUv
 sjRCLVM4JVSMcWT2gl7c5YhO3YF1B7h9i9BQjX3hnO4cKtRBCYSmpF+PEmY+mWfv/2hJaRkpKis
 KamVrUP+vXrN9HFRGwKLsS4hK46WAp4wBBwuF7aUyVJ43wcAru/Askd+3fIVNUjdDgSCGL4JQbt
 7U64IO2pQt2/BJYWgyhKLYoJyCmxzI0b1GZzeZ2/HjHe3D9ln0IhH/yrMugZ1o1A/25WPcZSFGN
 ogs4E07gV2gpiYOWlFeQKGmXb/GQTfZIrfkJL/nPPDAz6xnBSvuTYSMZj/OjIdOVPfoTlP5bMcM
 q5D269gSO4DaLpr90A6ZJbWHhuSI2qGaMfF5PYsec+TeouNg+M5z8DOFJYlyIfvybCpg3iLQH1R
 qnptzLePPWgelYJX15FhFDtvbaW98uiYo9fFs4lU81Y3orifrsmBzu01Pfwc+216c+wA==
X-Received: by 2002:a05:6870:d10f:b0:45e:6cd1:9a3f with SMTP id
 586e51a60fabf-46f84e27894mr6726818fac.0.1788378182563; 
 Wed, 02 Sep 2026 12:43:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:518a:9db8:615b:293f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f336c72fdsm4241804fac.17.2026.09.02.12.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 12:43:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 02 Sep 2026 14:42:17 -0500
Subject: [PATCH v4 3/4] arm: dts: mediatek: add Genio 360 EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-mtk-genio-360-bringup-v4-3-2d38f522c72b@baylibre.com>
References: <20260902-mtk-genio-360-bringup-v4-0-2d38f522c72b@baylibre.com>
In-Reply-To: <20260902-mtk-genio-360-bringup-v4-0-2d38f522c72b@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13824;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=gcUE4LzjR+eKMCtVG5xAf8wJdUIJ4Mk19e3EC1NTXUo=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmHwsYp8//WdnN1b2JMtQxuj0kGuejzlDPXdne
 RH5UKHzl3GJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaph8LBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AB30H/0k08DABjVosXljgkIUpAHe8o9wLS45OYFqdA9m
 nd6XnT4JJErljVQbDaTtJFBd6jOTJkzi/QdiiHSfKlyxXX6XlMiRECG50z9/IXKHpKRL6rJfCWf
 9hrBAcgfTfjvsaGvGxukVGzP+nMqgZweu4hTW4G7ZDJJvRshx276gdaWZw7pBEbnvf3zjSCimBP
 dqMxgeks+neh6pDgOZCVAGC5Q5pb7Oadd8naXklycO/dQY0QktlVa3xKhqL3PucXdHcsiJ39lrB
 rMsOhrdo2Y8CjucpBYrqyFBrBooIVuKY2JuRgqsQEfyXELl3gBa4KFyFumi7rNHyXWmHU2Gj29d
 GFNc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add a devicetree for the MediaTek Genio 360 Evaluation Kit board.

Upstreaming of this board has not even started yet, so we will have to
carry a downstream version of this for some time.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi | 521 ++++++++++++++++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts         |  14 +
 3 files changed, 536 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1b533721bb4..bd093e219d9 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1089,6 +1089,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7988-rfb.dtb \
 	mt7988-sd-rfb.dtb \
 	mt8183-pumpkin.dtb \
+	mt8366-genio-360-evk.dtb \
 	mt8371-genio-520-evk.dtb \
 	mt8371-genio-520-evk-ufs.dtb \
 	mt8391-genio-720-evk.dtb \
diff --git a/arch/arm/dts/mt8366-genio-360-evk-common.dtsi b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
new file mode 100644
index 00000000000..361d9cbf2ad
--- /dev/null
+++ b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
@@ -0,0 +1,521 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+#include "mt8366.dtsi"
+#include "mt6366.dtsi"
+
+/ {
+	aliases {
+		ethernet0 = &eth;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/* 4GB */
+		reg = <0 0x40000000 0x1 0x00000000>;
+	};
+
+	firmware: firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: secmon@54600000 {
+			no-map;
+			reg = <0 0x54600000 0x0 0x200000>;
+		};
+
+		/* 12 MiB reserved for OP-TEE (BL32)
+		 * +-----------------------+ 0x43e0_0000
+		 * |      SHMEM 2MiB       |
+		 * +-----------------------+ 0x43c0_0000
+		 * |        | TA_RAM  8MiB |
+		 * + TZDRAM +--------------+ 0x4340_0000
+		 * |        | TEE_RAM 2MiB |
+		 * +-----------------------+ 0x4320_0000
+		 */
+		optee_reserved: optee@43200000 {
+			no-map;
+			reg = <0 0x43200000 0 0x00c00000>;
+		};
+
+		dsi_reserved: dsi@60000000 {
+			reg = <0 0x60000000 0 0x02000000>;
+			no-map;
+		};
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	usb_p0_vbus: regulator-usb-p0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb-p0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 53 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_p1_vbus: regulator-usb-p1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb-p1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 55 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/*
+	 * Panel VDD and IOVCC rails are switched by the same enable GPIO,
+	 * so both -supply properties on the panel node point at this one
+	 * regulator instead of duplicating the GPIO across two nodes. This
+	 * works as long as we don't care what the voltage is. Technically,
+	 * there are two separate regulators though.
+	 */
+	regulator_dsi0_lcm: regulator-dsi0-lcm {
+		compatible = "regulator-fixed";
+		regulator-name = "dsi0-lcm";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dsi0_lcm_pins_default>;
+		gpio = <&pio 119 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	backlight_lcd0: backlight-lcd0 {
+		compatible = "pwm-backlight";
+		pwms = <&disp_pwm0 0 500000>;
+		brightness-levels = <0 1023>;
+		num-interpolated-steps = <1023>;
+		default-brightness-level = <576>;
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&snor {
+	pinctrl-names = "default";
+	pinctrl-0 = <&snor_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&disp_pwm0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&disp_pwm0_pin_default>;
+};
+
+&dsi0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "startek,kd070fhfid078", "himax,hx8279";
+		reg = <0>;
+		reset-gpios = <&pio 65 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pio 63 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel0_pins_default>;
+		backlight = <&backlight_lcd0>;
+		vdd-supply = <&regulator_dsi0_lcm>;
+		iovcc-supply = <&regulator_dsi0_lcm>;
+		status = "okay";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+
+	port {
+		dsi0_out: endpoint {
+			remote-endpoint = <&panel0_in>;
+		};
+	};
+};
+
+&mipi_tx_config0 {
+	status = "okay";
+};
+
+&mutex0 {
+	status = "okay";
+};
+
+&disp_ovl0_4l {
+	status = "okay";
+};
+
+&disp_rdma0 {
+	status = "okay";
+};
+
+&smi_larb0 {
+	status = "okay";
+};
+
+&smi_disp_common {
+	status = "okay";
+};
+
+&pio {
+	disp_pwm0_pin_default: disp-pwm0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO64__FUNC_DISP_PWM0>;
+			output-high;
+		};
+	};
+
+	panel0_pins_default: panel0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO63__FUNC_GPIO63>,
+				 <PINMUX_GPIO65__FUNC_GPIO65>;
+			output-high;
+		};
+	};
+
+	mmc0_pins_default: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO127__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO128__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO129__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO130__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO131__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO132__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO133__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO125__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO127__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO128__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO129__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO130__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO131__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO132__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO133__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO125__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_pins_default: mmc1-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO134__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO136__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO137__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO138__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO139__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO135__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO94__FUNC_GPIO94>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO134__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO136__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO137__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO138__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO139__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO135__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	usb0_default_pins: usb0-default-pins {
+		pins-vbus-valid {
+			pinmux = <PINMUX_GPIO54__FUNC_VBUSVALID>;
+		};
+	};
+
+	dsi0_lcm_pins_default: dsi0-lcm-pins {
+		pins {
+			pinmux = <PINMUX_GPIO119__FUNC_GPIO119>;
+			output-high;
+		};
+	};
+
+	snor_pins: snor-pins {
+		pins-ck-io {
+			pinmux = <PINMUX_GPIO57__FUNC_SPINOR_CK>,
+				 <PINMUX_GPIO59__FUNC_SPINOR_IO0>,
+				 <PINMUX_GPIO60__FUNC_SPINOR_IO1>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+
+		pins-cs {
+			pinmux = <PINMUX_GPIO58__FUNC_SPINOR_CS>,
+				 <PINMUX_GPIO61__FUNC_SPINOR_IO2>,
+				 <PINMUX_GPIO62__FUNC_SPINOR_IO3>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+	};
+
+	eth_default: eth-default-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO12__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO13__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO14__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO15__FUNC_GBE_TXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-cc {
+			pinmux = <PINMUX_GPIO20__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO23__FUNC_GBE_TXEN>,
+				 <PINMUX_GPIO22__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO21__FUNC_GBE_RXC>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO16__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO17__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO18__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO19__FUNC_GBE_RXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO24__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO25__FUNC_GBE_MDIO>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			input-enable;
+		};
+
+		pins-power {
+			pinmux = <PINMUX_GPIO27__FUNC_GPIO27>,
+				 <PINMUX_GPIO26__FUNC_GPIO26>;
+			output-high;
+		};
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO28__FUNC_GPIO28>;
+		};
+	};
+
+	eth_sleep: eth-sleep-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
+				 <PINMUX_GPIO13__FUNC_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_GPIO14>,
+				 <PINMUX_GPIO15__FUNC_GPIO15>;
+		};
+
+		pins-cc {
+			pinmux = <PINMUX_GPIO20__FUNC_GPIO20>,
+				 <PINMUX_GPIO23__FUNC_GPIO23>,
+				 <PINMUX_GPIO22__FUNC_GPIO22>,
+				 <PINMUX_GPIO21__FUNC_GPIO21>;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO16__FUNC_GPIO16>,
+				 <PINMUX_GPIO17__FUNC_GPIO17>,
+				 <PINMUX_GPIO18__FUNC_GPIO18>,
+				 <PINMUX_GPIO19__FUNC_GPIO19>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO24__FUNC_GPIO24>,
+				 <PINMUX_GPIO25__FUNC_GPIO25>;
+			input-disable;
+			bias-disable;
+		};
+	};
+};
+
+&ssusb {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_default_pins>;
+	role-switch-default-mode = "peripheral";
+	wakeup-source;
+	status = "okay";
+};
+
+&usb_host0 {
+	status = "okay";
+};
+
+&usb_host1 {
+	vbus-supply = <&usb_p1_vbus>;
+	wakeup-source;
+	status = "okay";
+};
+
+&usb_host2 {
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	supports-cqe;
+	mmc-hs400-enhanced-strobe;
+	hs400-ds-delay = <0x10100>;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&mt6366_vemc_reg>;
+	vqmmc-supply = <&mt6366_vio18_reg>;
+	no-sdio;
+	no-sd;
+	non-removable;
+};
+
+&mmc1 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	cd-gpios = <&pio 94 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&mt6366_vmch_reg>;
+	vqmmc-supply = <&mt6366_vmc_reg>;
+	no-sdio;
+	no-mmc;
+};
+
+&eth {
+	/* The TX clock delay is provided by the board, only RX needs an ID. */
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&phy>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default>;
+	pinctrl-1 = <&eth_sleep>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy: ethernet-phy@0 {
+			compatible = "ethernet-phy-idc0ff.0421";
+			reg = <0>;
+			reset-gpios = <&pio 28 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <10000>;
+		};
+	};
+};
diff --git a/arch/arm/dts/mt8366-genio-360-evk.dts b/arch/arm/dts/mt8366-genio-360-evk.dts
new file mode 100644
index 00000000000..1bf94e9512c
--- /dev/null
+++ b/arch/arm/dts/mt8366-genio-360-evk.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+/dts-v1/;
+
+#include "mt8366-genio-360-evk-common.dtsi"
+
+/ {
+	model = "MediaTek Genio-360 EVK";
+	compatible = "mediatek,genio-360-evk", "mediatek,mt8366";
+};

-- 
2.43.0

