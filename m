Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA36C54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19C3870A2;
	Fri, 17 Nov 2023 22:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B8BzlWj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC4E8004E; Fri, 17 Nov 2023 22:15:20 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F548708C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1f5bd86ceb3so378820fac.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700255713; x=1700860513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gmPTqgkWQoAWAPhsyYL5N5ubG3GvsfZoY0HEFvlW70=;
 b=B8BzlWj9kNtaNLkqF11DpXJwrdwVYl8gZ4crQYtXLG60n0GLG5SgjZfO9kx2ZBUapF
 9jICOdQwyeGuzsTzDgNVpRZWYWiNcGNgIKOENtE27N/8pjGzqGq13DP6Ct2zJC5W0R2d
 yRYY76jZxGjH15JuUT/eNOFoRmhcoNX3zriGmoF3Isc5YKSR0HePY0Ft9WGuX2CrmxZ2
 Jll9ky15wjUx8F4aKyBEMlJ4+5rhrUD/TjXRO1doy14kMd/BPWJDGb5M9M9Qr4ApOM7k
 eBSuA1Zoethr+gr4DVfFThsb/64IU4/LTw8ocZV5a40FOp/tWKFZIORlKzOSs9RQZY5q
 LJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700255713; x=1700860513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6gmPTqgkWQoAWAPhsyYL5N5ubG3GvsfZoY0HEFvlW70=;
 b=DDnedZJwLVozMf3PdTCL9DvvsXS247t6mcB39eOShwMfoVpzvk4MBi5SyQWDwn5k2b
 068+8Cp03yprZK0jJ1dAPpy9At3yQvXwl+5Lnsmk1lp5a8NtjS3RtDSJS+uBPZqe730/
 Yz/tiJP8q7OFEX/jy/pdVa52vbv8zCSvvgFBtx3v0tmtzQnwrvTLrKfEtZJtJgzx7eqD
 sF5nhuQB9g7i3F4euqxMLwofQr0BuF4lPzAbLNo22FQiCpI0q1qM0Gd+Pdkzhg7IE+ye
 YMOt0TurqtkpRPBDurEd/bE5/H43ZPBizMalxRENC2PubfRMCnfQXBzzmHI1f98XwN/D
 uXAw==
X-Gm-Message-State: AOJu0YwoXeiVL39oeAtjayVaRC9csrCUs70UOpeLOf6N6feFYIFSCDns
 zYmC51GCoStlmh18GVanZCbqpcqDhKA=
X-Google-Smtp-Source: AGHT+IEdjERpWemn5KkakrlKs9ewjReIUojET1wboUC8/JkdlfJdFjRwXVUDkiHlKFWuVv6TWZVICw==
X-Received: by 2002:a05:6871:73a4:b0:1e9:a70c:1323 with SMTP id
 na36-20020a05687173a400b001e9a70c1323mr458713oac.39.1700255712981; 
 Fri, 17 Nov 2023 13:15:12 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 zl3-20020a0568716d8300b001d6e9bb67d2sm415378oab.7.2023.11.17.13.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 13:15:12 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 3/4] board: rockchip: Add support for RGB30 and RK2023 to
 RGxx3
Date: Fri, 17 Nov 2023 15:15:05 -0600
Message-Id: <20231117211506.1396929-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117211506.1396929-1-macroalpha82@gmail.com>
References: <20231117211506.1396929-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Powkiddy RK2023 and RGB30 to the Anbernic RGxx3.
While these devices are manufactured by Powkiddy instead of Anbernic,
the hardware is so similar they can all use the same bootloader.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index a93b11cd47..dae9dc87c2 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -60,6 +60,8 @@ enum rgxx3_device_id {
 	RG353P,
 	RG353V,
 	RG503,
+	RGB30,
+	RK2023,
 	/* Devices with duplicate ADC value */
 	RG353PS,
 	RG353VS,
@@ -95,6 +97,20 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
 		.detect_panel = 0,
 	},
+	[RGB30] = {
+		.adc_value = 383, /* Gathered from second hand information */
+		.board = "rk3566-powkiddy-rgb30",
+		.board_name = "RGB30",
+		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb30.dtb",
+		.detect_panel = 0,
+	},
+	[RK2023] = {
+		.adc_value = 635, /* Observed average from device */
+		.board = "rk3566-powkiddy-rk2023",
+		.board_name = "RK2023",
+		.fdtfile = DTB_DIR "rk3566-powkiddy-rk2023.dtb",
+		.detect_panel = 0,
+	},
 	/* Devices with duplicate ADC value */
 	[RG353PS] = {
 		.adc_value = 860, /* Observed average from device */
-- 
2.34.1

