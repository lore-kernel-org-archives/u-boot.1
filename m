Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8F4CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61ECC881CE;
	Thu, 28 Mar 2024 19:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gjBWhshw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15F7988158; Thu, 28 Mar 2024 18:59:59 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7284881EE
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-341808b6217so756258f8f.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648794; x=1712253594; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O6Q4iPHqNBQ1Q20gSfmWBGk3J7Uofd34Sexw0LNLNLk=;
 b=gjBWhshwAMWS5Rzk0y0BSU9Foz0oVNOqFc0cGei0dn6gdhgrn4/+c0SeRW3325eK8Y
 1Mre7IT3JVAesDI9KbasfWD9EyJ/CDjdq7+a2iNz97RlJoZoSpjYc45Zhe9tVhNDnRin
 tgSXB29ibiZ0riAWt7XzcZHq6PvXvTO6ZgTyzsYtVyvW2xw4qRaeJVPsjSHiGvmzgO5m
 259pKQO53w76iamcPuPQPkGd1TYAaxGxxMo9woEc/vo2T0kVGiLuNfTnmMztUAhvzdOF
 fZ3YExRFzXX9W9eqN3gMYAGe5h4FHbJZAdEr6X3R+ANmBHpldSfd6ZmLIsQ3LdzIr37u
 RjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648794; x=1712253594;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6Q4iPHqNBQ1Q20gSfmWBGk3J7Uofd34Sexw0LNLNLk=;
 b=gBrVu2Idw32oYbtxg/QOO7nT+4PxyG0dIMy36KLDb3Ab+YgglbdEDzAa29AE3GGYWf
 UQzVj/0432qzMa2krpmTyMzgmsYEeHDeJ32wwDkkBdTPXzQjSIpURhcw5IECNTd7sFyu
 WtdOMXS6Q2kJ+qgwPO0JQZl+00tVbXEp6gmxuNwo9klLIgYp56BVy8Lvoa/2J8BlJT/G
 k1F0WUSC0OMp9L6NvRukQFnLBkL7MpaRbyrIZPA0M/xZKy8Pj+cL699rGhZYCOPY/UGO
 b8YZkv3dUhp48ULE3vzq52XhJYFwk5DdjMSZ3nq8hbttndAVePdJNWyQ7skvxPPkADbj
 2MaQ==
X-Gm-Message-State: AOJu0YwNI8Qd/J7gHyfXiKSfH/5sowsna/t6MEXNt8fDI+i/EgR3kbg9
 jtu3MHC/Lfoji6zPf00h3fFQk3Wxp9Y7wkv2xKScE2paS+cQIYwpiR+w0dFWY8+m5NgXoStBT9c
 H
X-Google-Smtp-Source: AGHT+IGbcEhcdVMO475goFsEquqv8Vwu0uqUCqwB9EyNJFTCQkI5Sxgy2HS0nphxHRDyqw+gLbNxtA==
X-Received: by 2002:a05:6000:1c5:b0:341:b5d5:a1d6 with SMTP id
 t5-20020a05600001c500b00341b5d5a1d6mr2619100wrx.50.1711648794446; 
 Thu, 28 Mar 2024 10:59:54 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:19 +0000
Subject: [PATCH v5 13/16] dts: sdm845-db845c: add u-boot fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-13-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=JWwpm6PYEfZfiLMJYt/BfVr0y0ivgV4Se6+WvKM3mNY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDVwfjk3+tyFodb9WW/p+j+lRH+aev9T6YOGbhX5nk
 tZ6Lu5g6ihlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQAT2WHIyNDK2PndZR2zWWaV
 jHc196Pu2tNHJmvu/6oXMq1/Z57DRgeGv4JnfUNeJN8Q3V6Y0qF0L0+r42LENebzVU1ijQEbap9
 EXQcA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The USB VBUS supply for the type-A port is enabled via a GPIO regulator.
This is incorrectly modelled in Linux where only the PCIe dependency is
expressed. The correct way to handle this will be through a
usb-connector node, but for now we'll just mark the regulator as
always-on so that it will be enabled automatically during boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/sdm845-db845c-u-boot.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
new file mode 100644
index 000000000000..906f9faa5451
--- /dev/null
+++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Needed for Linux to boot from USB, otherwise if PCIe driver is not in initramfs
+ * the VBUS supply will never get turned on.
+ * https://lore.kernel.org/linux-arm-msm/20240320122515.3243711-1-caleb.connolly@linaro.org/
+ */
+&pcie0_3p3v_dual {
+	regulator-always-on;
+};

-- 
2.44.0

