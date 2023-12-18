Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EC7C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CAB1876E8;
	Mon, 18 Dec 2023 20:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CcuRFf/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0EFE8717E; Mon, 18 Dec 2023 20:12:25 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD94D876A4
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ca0b968d8dso1565327a12.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926741; x=1703531541;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4e5UR5bn6f6W69urc7LaIK92HUMTMv6kxjqLJdyHxE=;
 b=CcuRFf/klhxOP15wl7dmL3br0UBd4hXTP79U8D67cvR4tGOUeFnRC7KeE01+JK1J0G
 hBbQ8r5SmTZDxPR4P+UuD71U8nN7k0QbRSR+WfxG6wxbucWhfjE2lBzI82U+TPZ/1QsB
 ss5GYaYOE55/6Oyg1vFlrd2TU2PFU7onbs5NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926741; x=1703531541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4e5UR5bn6f6W69urc7LaIK92HUMTMv6kxjqLJdyHxE=;
 b=JqshquF1hqK+3MLqLlmwWDMnBHOKx9sUD8LV8owD0C5YkYstn4fstVrmjUA8/S7W1l
 vnY5hecFYrbDkK7JZtJapkHBnGdJt5wvUgA954OClsnyAmNDipnFJAJSoAjofsK5wChZ
 9DW7xDYZYYxWXDGvXkZpZq/Oq+MWRWUam5wAZe1RYjTqrby5nRWGUyUMmaR2AibQ7g56
 AcmYwsO4Y+nWdH6B37xd28oh5ulsHQcPasyUCrnuMKrQJbpVlTbNXf0ZE9K3oGoeHrL8
 et/hdEfNL2VsCHmafGsHHNggB5mR4C7tHEsjsxKYO856tDCNs+i7UyIK8i+1b6fnoUNi
 MMkA==
X-Gm-Message-State: AOJu0YxMpSDaOUdsF7ut49zzKVfDCiZS4hUSjaoCvZOrnfjV0rxhR3x5
 DHw/PyZXkvOcASlx4U/GVHLD6Q==
X-Google-Smtp-Source: AGHT+IFiNVqPwDmvphVJqzE4F9N6MjAy9QV6uNMhip2IoNZ2tOltvdEAQ9gB5M2DdZ/EMPHQDvKUrw==
X-Received: by 2002:a17:90a:94c9:b0:28b:67de:3de8 with SMTP id
 j9-20020a17090a94c900b0028b67de3de8mr917625pjw.48.1702926741205; 
 Mon, 18 Dec 2023 11:12:21 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:12:20 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 14/17] ARM: dts: rk3328: Enable VOP for bootph-all
Date: Tue, 19 Dec 2023 00:41:11 +0530
Message-Id: <20231218191114.129329-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Model: Firefly roc-rk3328-cc
DRAM: 1 GiB (effective 1022 MiB)
Video device 'vop@ff370000' cannot allocate frame buffer memory -ensure the device is set up before relocation
Error binding driver 'rockchip_rk3328_vop': -28
Some drivers failed to bind
initcall sequence 000000003ffcd5e8 failed at call 000000000021a5c4 (err=-28)
 ### ERROR ### Please RESET the board ###

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 arch/arm/dts/rk3328-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index a9f2536de2..5258fec566 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -68,3 +68,7 @@
 &spi0 {
 	bootph-all;
 };
+
+&vop {
+	bootph-all;
+};
-- 
2.25.1

