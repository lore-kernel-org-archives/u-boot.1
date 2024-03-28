Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687FDCD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E68F0881F7;
	Thu, 28 Mar 2024 18:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UXMThWSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1DEE8083F; Thu, 28 Mar 2024 18:59:58 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E20B0881F7
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34175878e3cso876559f8f.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648793; x=1712253593; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NRQksOoQBBCu1S502LG/RKcB23CbUdRKpxTRdGODXGI=;
 b=UXMThWSOoc2ry335j3uKMs5LFJZqLnpbJtDcdWMijSzk6L64ZwNsFBSbx5e9+Fos1R
 LKufpE/IBC7DIH2LpayqM5Q6hifHHHgDxxx/YSZ3sJ47cFCNhoAtUgRGzrE7kGld+hCT
 YBrrt29xXFfvKT/8/I6IKZ61FefCSAeq+k+xjT1WBDRt5n3xHrGyCivKvVRcuUY7lSUT
 5YS74urMlGZtEfpVb+mJsW172XiVtY31kaMgjZ3Dw2H9cmCvlMCRQxwkuFaQ92rjxKY2
 gnuk70IPWmyvo1NldVOzcT+JJTwTQ8gFJIs/7p4TqUV0MvMDoqA4M9B30ian2MY+0JER
 lZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648793; x=1712253593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRQksOoQBBCu1S502LG/RKcB23CbUdRKpxTRdGODXGI=;
 b=t3tds2fH300fCPdvoJh1Ja4lk0o78BmYQ4Rz0uTlDumlPMNDn+mthORfkCjIxC2rks
 uRuIksUER8/nl7CXElmog5DRUGHY5UlAxsCztutp2a+QM25pQGuvjNccm9oAFB63Jtfb
 gEd3gWNNzYS9xUSJAsUXBRHeODgEdwPFNUk4WUcOIUQ0Oub6P1HjqPOHxj1769n83cqj
 /gDBCGis9ET1yDDjpDsHb2DfGANX56Q0smUmKMOJn2JMwLKsueXaEqc0QrJFmmjduqsX
 /+AxHxk/+paWGDrI8mB8w0rdylpicZOi3z3A2x3iVhInHzWd2sCFToNxtS/Hc9+hJLc0
 9UvA==
X-Gm-Message-State: AOJu0Yy8I4AOfihgsxLloH+WtojMKJsW0/W8J6Zb1oOt2WRDelEt4QvK
 DCFff3XZJBifS9Edr7aXVlVVM2I04RMsVxTbxAtT276p7MsjmOkzeavOor1kNig=
X-Google-Smtp-Source: AGHT+IFsdJfUVJ7sSrtbMiLU4oWxTWgHD3j2+0/MOfOOEgFZGb1X8xJdS/F8fXvkBoxzGxy8mYwbug==
X-Received: by 2002:a5d:67c3:0:b0:33e:7f5c:a75d with SMTP id
 n3-20020a5d67c3000000b0033e7f5ca75dmr2407025wrw.57.1711648793498; 
 Thu, 28 Mar 2024 10:59:53 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:18 +0000
Subject: [PATCH v5 12/16] mach-snapdragon: call regulators_enable_boot_on()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-12-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=iHXnsqcVLhfSIq88PzmJ9sTxqmVwLCybN5TBqignPCs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDVzbrq01kAhauFz2jZvo4fcSX24xWU5dPLuIQ3DK7
 cO3M8PiOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBE/O4xMuydLiEodstg6t4j
 ryNvi5h/cNw7TeBE7DeN9lndbLPVmg8x/C/e6fyg5/mVY4/TG+4+lm6MXC/Gs2p6zv0v//dP7gj
 4fnk2AA==
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

Make sure we power on any boot-on or always-on regulators. These are
used for peripherals like USB on some platforms.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 65e4c61e866a..3d5994c87886 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -15,8 +15,9 @@
 #include <dm/device.h>
 #include <dm/pinctrl.h>
 #include <dm/uclass-internal.h>
 #include <dm/read.h>
+#include <power/regulator.h>
 #include <env.h>
 #include <init.h>
 #include <linux/arm-smccc.h>
 #include <linux/bug.h>
@@ -160,8 +161,9 @@ void __weak qcom_board_init(void)
 }
 
 int board_init(void)
 {
+	regulators_enable_boot_on(false);
 	show_psci_version();
 	qcom_of_fixup_nodes();
 	qcom_board_init();
 	return 0;

-- 
2.44.0

