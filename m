Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997D2C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 22:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53E5860E21;
	Fri, 18 Sep 2026 22:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Nu6Lco2malK; Fri, 18 Sep 2026 22:18:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0BD2860C11
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789769913;
	b=GqaQ35jsy05meEkb3+EsCkiOuYSWYhaXzijEc06JUGUZsmL2/xvGP6y6J/EoPDDzVkAS
	 zCQkA2dUJewzRjqftdTDbkB3P8779CObG8r97MZb3Iq1tecn9fwoOm3rN5YbTraU7SK6V
	 0r6fzz5MbXtFD3EFpyDxBSmHj7Uf7B+JY1J7SlijVRduU5lKUKrQVkWe1ZHfuiUQQt+wf
	 XSCf2mwvctK8hP/opKlW8t0fKKUzuOpplhJGUQQZvbI5nwy4chFqXyYX1Uxv3Hv345ngF
	 vtakeu3z9RiMSfrDTj4d//dyX477cef9z/EvNLdG8oDTxWmrkE0u1DUYD7o4dmr76yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789769913;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aUQPafHGNkjmi4D2Xxbozu45o+9kx6dO39G5uDDwijc=;
	b=AFM8mV8WXuGPumrciGt74tR1r9UIq2fOtgQuW1bgYsfX+yDYPezfmk0h6SFadXXL7m/Y
	 oYWmlcSB8eWI87lDW5aaJPSuLdtPBsMP3LBRLAB6xwoFeJai/EOXXjI6Xx4qMb/jQ50WA
	 pb/CnelW8sCR7QR5bqPCPUKqFGo8KqoK2baA5n/mjKBv9FeSVrhWAI8b1GrmzH+73GzZz
	 sDSdJELbCHqO+u+kh7tRL4veMYAe4s/LLOwoi3nCHITcJZPB4S7KFuw5RZO7CqrdDoJrd
	 fi8weK7ia6glza1XS2USytaJ2uztc44MrSZTVvdtO2tzZHIDc77IkfadkxqxqNlcHOg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=h3b0bvFY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789769913;
	bh=aUQPafHGNkjmi4D2Xxbozu45o+9kx6dO39G5uDDwijc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tt52EM7j4KcHcLV7T6LwyFhEutYfANbTVifzGmXJUEkkLnxGATfgHIuYY7LGl+Gl5
	 baG3iLUvp9TwGR/6lXwCYxh6DnRNJoWGKwks79UY1ehyFl532W2h5PMo162MxdFWXh
	 RfwjSsozFg+kaHYGkCyiuPc+ODEuOaAMzzGOAhNoN8n3fKLv2vRzzGCGyRqs5v/Y8e
	 rXp+pHVhqN3vwFexn6lB1cHhgH9TbWVI1lBAjLHGI8VzURtBcxqADt9861blas0KoY
	 MsJv5IKQGk+a6yDel5/9Q2mH804qj24TCbYqYcSOLgULSY2T8uR1h80yBii3IiOghE
	 UOWG9AwJnXedg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BD2860C11;
	Fri, 18 Sep 2026 22:18:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B52A0380
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4D1460E21
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_lcSQpYc8jr for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 22:18:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8017260DE6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789769907;
 b=EBt6YDOhP0Gu/Ki26sukTrqhTcQMfle5VSYRgLNQ1SUFQ2ORJOfu956R94Wr7Ze9Ltee
 3R0f7kgd6to4FonLgJPlSOwPU5kadFNT8W1Dt5ITqby0cKStmdK+01nq4fBb+OcYCID+U
 k5Od9GtSfW/4MLIGE8l+Fqqy10pAmcB/B2Z5XEyo11THQpNyJ9g4HykdWVLoErPxUC34P
 B2CkZvZs9e6Wt8Hx+tSLMfnD+XenbUt4bO7R45J0FMpAkTnGaZyayNRmWUTPtXiPBZpw+
 1NpJJwVqqNfL/4Qa0DC6MfUuW9Mrtx6Dd9S2kNqLBsY4CkSIaFLeqI1lzhUcUGC351w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789769907;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=aUQPafHGNkjmi4D2Xxbozu45o+9kx6dO39G5uDDwijc=;
 b=TznlxT1chAtED9+uedDJtUgP5e7EzzFjz8fDjGhfMS0hrCGTE0tzyqRkT/V+cZgB0lYT
 CbazFVWzrIlq4dW6CpvEgZWyYOkkwxHHj/RyPHm7MWDvAGc0RACGtkAdyWHF+Y/JnvxXx
 G/8y/+V7wisAyl2zNgc4FXF6uKyE8pKJCfDKMfotX2qgIfvGevFdTon1oXIxk/7FYrv2n
 SHfq7JbbRBsH9mwKgzDVYByYl8wBpwkWphzRFp8FDxvhuAk4Y8i9jZvsGj33kFKejan2s
 C28JLhwc9eutYBws22nSXqEtxZvgSGHMhVYUnXYE/ku/GCeEWVgf2q9CNXeZkOoEexg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=h3b0bvFY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::c;
 helo=mail-oo2-x0c.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=h3b0bvFY
Received: from mail-oo2-x0c.google.com (mail-oo2-x0c.google.com
 [IPv6:2607:f8b0:4864:31::c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8017260DE6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 22:18:27 +0000 (UTC)
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6c72bd8a017so786989eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789769906; x=1790374706;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aUQPafHGNkjmi4D2Xxbozu45o+9kx6dO39G5uDDwijc=;
 b=h3b0bvFYNDaJ3u9usm4GzV8PmPeFcCRTVoXnjDfiVYMUWfFvPwVIrYg3fKkv2IbdxX
 Z8hNZczEuUrwTO2Mk5tieK7Y50NQ1xkuIJRH2gfJUHbh7h2uMY1CEALuxxD2ab4V6PyK
 ftEGQpW7MKJNXdiUi80+CHF+WMerAs8gj6dLpRzzUx+woyVIEc5idUcGD1VM7HKzxWL3
 PiPmvAVVJJtnldl34cwaz9klS7niqIDLVtv+uomsYIkJprYye77CphODazLdRMhXFbk0
 T9V5Mx3ImiKof3wVc8rY3qf436eUaJxFMwtxeubcoON2dcmUqbBQm/kheitGoiKgg3S4
 4iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789769906; x=1790374706;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aUQPafHGNkjmi4D2Xxbozu45o+9kx6dO39G5uDDwijc=;
 b=ugg4eOk1uRyvX1xZGNeJGcjn25YKg2mMZBJmljNFsrmfcUpWWsTkeFyQXL0TfXOees
 4no1jep0hd+X0pxx5MZGtrrDq/4MJ4b71EykmuDseKMpmVZ2p/oIWAuP0i18BLGm1IWJ
 xVrXJG2sqYavsP37ZbgcbPOe92J6rkf38KWWe22+RJj00ANmkdBCa/mLkvYrkOY1USg+
 gT4eckgBOve9eCcM/Gvk1m8kOmxK+hp3cXcQsMbjipXguOL+hyduhmS/HiiodZd2hbkA
 jJ9DG9iErtnK+OJbQRVlvw8gIjZXFStI0YISfntuNUDIZUd8seevZdCCYRhGY/15/6Kk
 bigA==
X-Gm-Message-State: AFuF++lyTsjI8M5VUvvW/1qM/6IUrUkLTDpt1DUqo/6nrHGLk425NdGS
 +MBd3yKy5w9llnPqvb5/7Wsz2vS6bfycQ44wMNeNpqFLpDT3LTWUiknGAUUxeGfFG/U=
X-Gm-Gg: AYBFou3Hm9UvBTsBHBOIrjhdRadWVFT2kvjsGBTXegXAw61PxD4lRd6ssA0T2twZycf
 oC/kQvKv7ePKLJSjR/5Zltc3MKnax1N5Z8UcxFRYxdSX4eak5JtfOYx4me0x0FFoqz0EUz2alGO
 kjJGWAbZgmzZfHkTQxlQURB1PA57Me7IZJ3ENQh8tdXZ9427eq+HSu79wFmimt3wz0a5MzwZLFW
 Bds+V3Ny1gSAZNnQ20dAmRNxzp+SC4Z+LcJvmZUwnUrXWMkxzQYi9EcyGgX5/uyXXdUombaPK5W
 iVUDZ2EcAStTbSDVSgO14vBajbR2jAsVXkuOjt6wwozE+5I7J1GilcEq4HEvKOsjJcLoNIkV5gE
 cMXujetRKACVQg9Hi9asUqUgsGUohKc26QysIZ8fgN0e9owLy4Q9/m/7uLnfpa/gRpZOyBHtaWB
 qu1oEw/TgxI0TYMz07FKxRIUXkigIsrajg0LXCwP8nr4UBdU1Kt004zaQ3XqaB8R4KuDr6Leni
X-Received: by 2002:a05:6820:179b:b0:6b3:61f7:b8bd with SMTP id
 006d021491bc7-6ca9a63daf2mr3716837eaf.1.1789769906207; 
 Fri, 18 Sep 2026 15:18:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:921:e69:d103:4708])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd34f2d2fdsm1426959eaf.8.2026.09.18.15.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 15:18:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Sep 2026 17:17:35 -0500
Subject: [PATCH v5 3/4] arm: dts: mediatek: add Genio 360 EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-mtk-genio-360-bringup-v5-3-31451a136f96@baylibre.com>
References: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
In-Reply-To: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13480;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=0e0FjvJL/NxhyKxcxeMDFuL5m+kBW07T82Dk9h+CBUM=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqrbiTgQmhDt1dfOpdNEvGfsFVVSh6sH6R+5/Od
 y2fwVlqSA6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaq24kxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHeYH/RY9HfDyWSO1k2Ncr2ZRT7XZ6aD9p+QZAmBUr7b
 ggZJOr0pY5P8NQo3trCy046z1imhsYFWhoJME0EUvwUe38fwQogSrofNfuAqKARFzN55V6PeAgq
 PZyYSaXxVunyMXRq/Fy75xeTTQ+RlfWsd7Kr0Wob1CSMK3AnU2O3tcY6C9h2gMgBh+ghD0adHBc
 aGlxP1eK78iKwS7MPlZMBifgbJq8TzE8WkGhTERApVwRzQZUljJNOvnIfrNTLIO10/zJ7LHimGx
 Y793PlG7KOBaIjVpbtRl46B9bzSM4m2Zse/bi4+e8UmMVFORDxKGDDGolMU3/cKFYWdrA5kJVAW
 Xurc=
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
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi | 507 ++++++++++++++++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts         |  14 +
 3 files changed, 522 insertions(+)

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
index 00000000000..b4c0e44e763
--- /dev/null
+++ b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
@@ -0,0 +1,507 @@
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
+	};
+
+	chosen {
+		stdout-path = &uart0;
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
+		spi-max-frequency = <52000000>;
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

