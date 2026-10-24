Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353F606A31D
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tIZh7NwD;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dbUmjEic
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCFF340B07;
	Sat, 24 Oct 2026 00:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IHAIRp8n9m-i; Sat, 24 Oct 2026 00:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 53C1E40B17
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792800628;
	b=A7aiTylkeD2W7hbad2akzbIy6TjW7gPQImNGoDCyBYb8DCt1Gdc1CqPObWEHkkqNTEWg
	 4rer5En8qqpl/STLX54+cRiQrnJKl9yPN9oDo51JavK0DvSEod2ojLn6Rp0JraFrmd/tI
	 fMFBTwEmVC6U/+Q1PoD4aXUkAxs7iaszJAqIIgbnKRDAXeTuNcN3TVAciKi2brahcNp/m
	 LW6OKjcZAW+oHnGRXWhCOv9RsXj8N66AWX0IbofXJ1L05HfLHBQetTwRYBVk0+dYO2pbJ
	 QlVRbs8b4DY+cBvyccwpS9uD6xhYvWJ5rJJe/lXmZv3xrqQ5p02YfsjoA4a8L1Lhjvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792800628;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z0rZCiP4OXxTRKE+fal/To3vyxC8sY77Uxyg/LYUDpE=;
	b=SoqjG+KwIr/ewY54TyxsVa/kd40um+C1yh1HjegvRZ/sZ+dSsMGU1h5GcibheG82NXbb
	 KAA/PTlPXEesplIEQSF6S6xYvIag7gIGai+8+TarkxkML4RI+rB8AmFtQ75jJYL2Vi9do
	 XKFQbNdkPG5pP8dGENHWNBNHhZTJ3R/Awc+TR+km7KL4IqUFfWee0BKQ704Q4g4cqZxDo
	 HWjBWXgMOCw7qPUCxnFk5GYkACBe6d/E8WMJ9pu0PIvsOGd3L1HjP2H3F7MOV0EMcH6Ko
	 VwPFLEVOsZ7ATeFZU3Aupd2MQYzmbTAd6QIkU1ObYfrCcp4ytzQKP5Idv+AEIKAL/Xg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792800628;
	bh=Z0rZCiP4OXxTRKE+fal/To3vyxC8sY77Uxyg/LYUDpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tIZh7NwDsF9cx0uU0210AHPm9Sx4m+GCafFrGMXrR1mKyng6CoAJ6PhM9m1bfE1p1
	 LiSSTZoXdjVqM0Xg5zUwQYBrxGogrUPOgx1FlinG8rZWSwsxaJNw39z8lkTzzYXjKw
	 6D/zDaaXml1J2bqBvLaObEkk/IuW85Ykiu5dMh8800Xe99lruB6Aimoct50J5khydJ
	 oPnplV5iPSlJNFzQrUjKuuICDc+B1q6j7hw+Cr7Vhx+Ratyo7HPelC2RsyzWBZIQrB
	 2p8fj6qzNpAQ3VXJ76nQtemjCU7fGi6KJrNYujb55u3tocPQLP/WWggzHbtHig1wo6
	 s2lia+7PWnQBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53C1E40B17;
	Sat, 24 Oct 2026 00:10:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 00DFE235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA63780C8B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wgz7Vjo54XZI for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 00:10:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12A4B80C79
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792800624;
 b=H9QV1Xgz8j7VHz4Q3EzOuJsMWiIRHqQbkEmbaIlcqIJ5e9GXbQYAsTLlh4By9Fek2/t4
 rQVODBZAovnOVzjk342EgsQidEGdE5HoR1YO9aO7/H4qr3GGJzfRcVcsutd3vChQYFnA/
 et87ScxB62149kLWC14gl5VYIKiMYOBiNh1fbESVs/I/ONezbaWFSUKm2uBfzKGSgMRDZ
 f/ZutfhI46GYGOc5dCcQTjr47PaghbmHRFE9cD7CA4p1q2QvYBjOA0a0rJMxFrAjstsrw
 CPJ69MKikxyucz/hfjjpJVm6kdUWk3emcjuZ+AAzj/dRFbQgLrHLsHJByMcjfUWGimQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792800624;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Z0rZCiP4OXxTRKE+fal/To3vyxC8sY77Uxyg/LYUDpE=;
 b=sFcmUdZBFkhluTG8ZUY8vSKcTi+af7lpVaG1P51ucCpRV00/L7IZ9lne/Yz8GUN+Jg6E
 YA6NZxYQezIOom1jakeXM8dVXtkIRCgOYaeXb8Ta0KfuuBsNsYbUTZ6ZWuZtkg2o8X4qO
 9g4JoyIQS4Z/+B8uovaxtK0ZPp70uF+vc1zKp92eXCHBFtW6aFPWRZQKntcJ2kW5wjDk0
 GLMwxZX/j2CdLmkKPRQ+Z4yyCG1HoDS6icqfUuxeymSvy8EqJTQzY0P3zzoPt2dgQA/ar
 p0/Pn57NbmsnCUygxKbw+vtf0+QIk9qHD/sgdODC/uwzvN89PDbJ74/e3nwqcqNxrUA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dbUmjEic; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dbUmjEic
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12A4B80C79
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:23 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4c382ece86fso704625b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792800622; x=1793405422;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z0rZCiP4OXxTRKE+fal/To3vyxC8sY77Uxyg/LYUDpE=;
 b=dbUmjEicW4iQxkLBHEz+CRKjlGMHSOxcfyojER8MF8Mjvd4Tmh26MwZ8Xg21o3ESXW
 zZtL3mMtXJDlpWb9kkWkIxjsykEM0vvQDh9/njEnhxS091o5XOQRkRH+xJWUgYl94lLD
 IhiNEMZWUEVGy1l26c11+Dw4ePAmJ941eQQNNnkK5elWm8UzJU3d9RkFANdOU7jnIvMD
 CBM0tR01Nk6RyD+EagG5zdqD3dnLeb/iq2NaaqT4/6ZV76+IUbmP5/Ds4SPAgZgDGJfO
 IxQ0BDsXOPD84MC7hNDSJY6DnCLNZxCWleS72r79df4Zy15fp4Ereh56djwqTtY4gZDJ
 13TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800622; x=1793405422;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z0rZCiP4OXxTRKE+fal/To3vyxC8sY77Uxyg/LYUDpE=;
 b=UnM5vJRNXbCIYyDrJ5Uhvg8q2KFyrBmiC2jN1kw5b9DaEJvV9oRP1UbUI8TJgLa2vU
 VJsWVOac6e10qxKBDyAlWUE7O1xJ2j39dGtGyZWzIu5vd9pcu/ay70ViY13rkGPj6NaJ
 WdqE2zr0m0SO5kuftfGzH9xGSXDw7VJtWS9ttaHxmLJ6uJ4LWFZCO/gjf9euhbqoX67X
 IaEjpxqRdGYKAsDFr6JkFZQun9V3xmuvE0WA7kUI4RyATj6qrSPCsW0j+iPF0cZYFXHZ
 dUku1rWB8n2DwQCRRzhoWzpR/Rm8Vs1A7qZtjpREswvkokM3Zhwxqs05F1xQht08s2K+
 QTxg==
X-Gm-Message-State: AFq9FYLWI8U15Wp3XROOeuVjGwe/UKrp5Ka7GaOS3DXTvxXAZeAK8vMq
 pkFBgLjT0yhLNo2BA2byK3j5yOcfiGrQS0k007xVQdImjdO1JCR074L4BbiDRRs5Zhc=
X-Gm-Gg: AYBFou3FR4upPbmr1Dq3rqE51u2VsXxWEDkKxRAmQrg6tslO4yx+V73dAoJw104mgFA
 XlRYsPmvn+NRneAelnoJwNyPqoYAwu4MqgysxqlV5iBNjz+dAF5tMCg7t63cGHzEgfbzYWtSmXS
 4wFlTvlrA0EJXzJVfvDH4DwPmXzbNMsX79GHa8zXzUFycbU/NTZ4wdcIJMrgglspg7ki/WBzyDX
 AyvziIIJUCSISmjzKbu65hH7C4Zl7ovKizeT7IxmkIZxT9FJDQKt5QWlXjFQrL0CCMfxqgjJbDX
 z0WsY1SBYr4qSJm3SCW8vTcCWyYXI70JmUYIShGBSVXmkaul5dvoJ0EWF6xP3IBiA4EeZyXwy51
 2IVpL9WK0i5Sw7wiTm7BtXzK7dESh9E43CQYiCJKf6wMcQKNznWydu4+1+lOG4OUJ881lzEq4ct
 AjW9sinwvK09CU8/NuXMyyObEM7rLI5XT4kjliD5ob8N1DJX5bcSBwsaKGY7XTwxdJo/DCbRIg7
 ne/558+eqATR+TazZo53ZQdc3t3LhprvvNxXckWUWezTLYwQyQNmImswi2R
X-Received: by 2002:a05:6808:19aa:b0:52d:10ca:d7ca with SMTP id
 5614622812f47-55bfff63a7amr680581b6e.8.1792800622540; 
 Fri, 23 Oct 2026 17:10:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04248804sm328636b6e.3.2026.10.23.17.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:10:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Oct 2026 19:09:12 -0500
Subject: [PATCH 6/7] arm: mediatek: build Genio 520 and 720 boot images
 with binman
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mtk-genio-720-spl-v1-6-f2c0ee094fd0@baylibre.com>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
In-Reply-To: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4830; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=6BkUQfLd+IN5OkdAKicE1vCAgSrjG6dducWB4S+N2m4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2/dPKDS+X3d05UwsAqEy1vbaz72Y1y2bldmMP
 el5hDMHTqGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatv3TxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A668IAJ+sXg9iYFTPIFrJDy1OCSvGgIBO6K8ObBcdpjk
 +C2XG6tR6tEI+hiKxZTJLNNuy8RKoTPqsVzyk+s/4vjswXKNRchHrvz80Lo9kMN3/XzyiIanpRf
 PXecCqkewYZLJuBNg7Mzdlr0U8JKKS78HZTfW6Nh9sZV1N9JxNuxpaQEKRZ1Oib1Vz7HSU/vYX5
 ajz+bO6OIN0FBTWrJn60i+VSPXJGf1rcSrt0lGbb32+NvpTboXZjR6IUfu7Px63Bf9JvKuJGu33
 H+9k+bNwxIIy9/SrA9rQc74f7rR5gyI2wTV0wSa1A6EotVukw9jP3PIeoqyXg9FJZ81NXZJq3+H
 aEXs=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow CONFIG_MTK_GENIO_BOOT_IMAGES on MT8189 and reuse the Genio binman
descriptions to assemble the BootROM image and firmware FIT for the
Genio 520 and 720 EVKs.

The MT8189 BootROM loads the payload to 0x2001000 rather than 0x201000.
The DDR loader needs more than 600 KiB of SRAM including its BSS, so
reserve 640 KiB for it ahead of SPL. BL31 is linked at the same address
as on MT8188. The DDR loader runs in AArch64, so request AArch64 BootROM
entry in the image header.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi |  9 +++++++++
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi |  9 +++++++++
 arch/arm/mach-mediatek/Kconfig                | 10 ++++++----
 board/mediatek/MAINTAINERS                    |  2 ++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
index a69e2db5a04..53e06bc6af1 100644
--- a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
@@ -1,3 +1,12 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 
+#include <config.h>
 #include "mt8371-genio-common-u-boot.dtsi"
+
+#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 520 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 520 boot chain"
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
+#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
index a69e2db5a04..0ee1ef3a869 100644
--- a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
@@ -1,3 +1,12 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 
+#include <config.h>
 #include "mt8371-genio-common-u-boot.dtsi"
+
+#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 720 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 720 boot chain"
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
+#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#endif
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 1773da597ec..01db231a4f9 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -223,8 +223,8 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc;arm64=1" if TARGET_MT8188
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
+	default "media=emmc;arm64=1" if TARGET_MT8188 || TARGET_MT8189
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
 config SPL_MTK_FIRMWARE_AB
@@ -246,7 +246,7 @@ config SPL_MTK_FIRMWARE_AB
 
 config MTK_GENIO_BOOT_IMAGES
 	bool "Build MediaTek firmware images"
-	depends on TARGET_MT8188 && SPL
+	depends on (TARGET_MT8188 || TARGET_MT8189) && SPL
 	select BINMAN
 	select MTK_GENIO_IMAGE_CONTRACT
 	help
@@ -261,6 +261,7 @@ if MTK_GENIO_IMAGE_CONTRACT
 config MTK_GENIO_BROM_LOAD_ADDR
 	hex "BootROM payload load address"
 	default 0x201000 if TARGET_MT8188
+	default 0x2001000 if TARGET_MT8189
 	help
 	  Address at which the MediaTek BootROM loads and enters the external
 	  DDR loader.
@@ -268,6 +269,7 @@ config MTK_GENIO_BROM_LOAD_ADDR
 config MTK_GENIO_DDR_LOADER_SIZE
 	hex "DDR-loader image region size"
 	default 0x4b000 if TARGET_MT8188
+	default 0xa0000 if TARGET_MT8189
 	help
 	  Size reserved for the external DDR loader at the start of the
 	  BootROM payload. This is also the offset of U-Boot SPL and must match
@@ -275,7 +277,7 @@ config MTK_GENIO_DDR_LOADER_SIZE
 
 config MTK_GENIO_BL31_LOAD_ADDR
 	hex "BL31 load and entry address"
-	default 0x54601000 if TARGET_MT8188
+	default 0x54601000 if TARGET_MT8188 || TARGET_MT8189
 	help
 	  Address at which SPL loads and enters BL31. This must match the
 	  platform firmware's link address and secure-memory layout.
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 1129cd84c75..9087cb56c34 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -4,6 +4,8 @@ S:	Maintained
 F:	arch/arm/dts/mt8189*
 F:	arch/arm/dts/mt8371-genio-*
 F:	arch/arm/dts/mt8391-genio-*
+F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
 F:	configs/mt8391_genio_*

-- 
2.53.0

