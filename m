Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C80EC54798
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 17:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 741BF87D37;
	Sun, 25 Feb 2024 18:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LR9xZmNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D9F87DEF; Sun, 25 Feb 2024 18:38:41 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE32587CDB
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 18:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412a4a932f4so1603675e9.0
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 09:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1708882719; x=1709487519;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mO54U1l4z9kYPv7kUYvG6myS4OFvGvH6K1/4NvamWxc=;
 b=LR9xZmNjIgTfj/rzNNLa6kokq3vJCUDSF8ndZN60gUh9tQ817/BtihnUjNQBL+5WaQ
 U8btWps6kcfjtrZh6AgxA2bwRJBke5xytlqI4JjXG+2MaHdvcPwPWfbVNIrX7HGAF7Wl
 1tdPJQIc89ef+syK4iqRfMAALYcDj/2ybWSSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708882719; x=1709487519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mO54U1l4z9kYPv7kUYvG6myS4OFvGvH6K1/4NvamWxc=;
 b=EsvfXcO+AUUnqfeZUvo9maN8RxebebuZ2xMNE38GS5XnlBbE3rsKj8o+onwUV3MY66
 dNG1zGwJYOJxcwHaON7Iido6xNCuLRtT4VwvyzAFm1b+NPi/MOJO8a2isGMvIxHMa8MC
 2HlTI6STdNZxV99QFnWLjmw6qMwQbuLsGnf4EdGsLBDKpSB4f0rh5FBVGrbQe4PvNfM7
 3SFdDLS9IlBbKhCVt4P0LQT+9YnBNgvd7B4htPNYNbFhVes0CJk3RSeCg2CEKprDwhIJ
 bUfIYUTH1eMvaYeyywIdUwM53KJiuEywp9cDI8Ewa79nLlx6gZ0YS1IuVNxrX5hfshwZ
 G+Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuVuwzRnA6xmjzf7Q3ilLv3FHq8Iz7vMsb4D2l36WagyXkbtNuoCP1PJw8kf+Mtm3VcwOiQP+9Jwiq74uStT/NtdP6Tw==
X-Gm-Message-State: AOJu0Yzp4qVpVMrdt6gxTTdGry06qTUGfQkO7zFp/Q8Qw+LA1jC75V+O
 VI8KbkFvKxadHtwAx3Vdz4Mx1H3LMiTzVbjmTg4nLXZN6o6AvYQk+zZTfnOrPBs=
X-Google-Smtp-Source: AGHT+IE9qullt+Zpz6Gj8BpE4bR8/95zC/e7Es58O9OLuhbUXcVHlZrUgH5fkUN91B73xmPwrHqTWg==
X-Received: by 2002:a5d:6d0d:0:b0:33d:a452:2fff with SMTP id
 e13-20020a5d6d0d000000b0033da4522fffmr4486297wrq.11.1708882719107; 
 Sun, 25 Feb 2024 09:38:39 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:7ba6:d425:45e9:5878])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a5d6191000000b0033d4cf751b2sm5613046wru.33.2024.02.25.09.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 09:38:38 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] arm: dts: k3-binman: Make optee optional as requirement
Date: Sun, 25 Feb 2024 18:38:34 +0100
Message-Id: <20240225173834.1637789-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.40.1
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

Boards can use the ti_spl_template but avoid to define a tee
node to be loaded. This is true form board with 512Mb or less
memory. We can limit this in configuation removing the tee
node

configurations {
	default = "conf-0";

	conf-0 {
		description = "k3-am62_ccm_m3";
		firmware = "atf";
		loadables = "dm", "spl";
		fdt = "fdt-0";
	};
};

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/dts/k3-binman.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 758c8bf6ea..5ef5af315a 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -293,6 +293,7 @@
 						keyfile = "custMpk.pem";
 					};
 					tee: tee-os {
+						optional;
 					};
 				};
 
@@ -360,6 +361,7 @@
 					entry = <0x9e800000>;
 					tee-os {
 						filename = "tee-raw.bin";
+						optional;
 					};
 				};
 
-- 
2.40.1

