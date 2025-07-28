Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E8FC83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 15:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC43830B4;
	Mon, 28 Jul 2025 17:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RS694uz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 469BC830EA; Mon, 28 Jul 2025 17:47:13 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082E482F6F
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 17:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a528243636so2758830f8f.3
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753717630; x=1754322430; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jvNkJrp9KYOo8llD6JdLAgIrb3fsqkechyet8Wm1aAY=;
 b=RS694uz1MS/biO03+bPSlNGv7Z0WtFn/HbfNXtPt3K5qEqcIgqUrvh7+Z8yleJmWxP
 kVM0R37ZT5SKZzA/4GIqhq/Lshw10LzYmB3i5/ngkjGodD3RFDsyyPE+hjBbvdbEHvOp
 wU6n6GsXedUIzLC8HCfp/dRALdIrBdMN3GgtgbewtpvSeSNZFfPRqSJZfOJih0R0Cphp
 5Q9u/v53KaUNcQY9BbVIMjsoZR3zKM3/yQtLNSU50Kx4fgrS4N0XivBtjRhzsChUFvp8
 ooUbnes5tqNiPz24rwo/yaJ8HR35cSrrZ709b1xsEFjUvVDj5yxvn8qUPzneqBvjG8an
 CTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717630; x=1754322430;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jvNkJrp9KYOo8llD6JdLAgIrb3fsqkechyet8Wm1aAY=;
 b=h4frp3MgxMePZNqtMM3JlwzXD0bM83WUFUvWXqvCma7vtmnPFMeIUESx8WgvrvzjHu
 d1t//wfrbISAuko+fuQvxAqbTkH6JxXqH1MqqUlMtBi2V+ho++YIRUrlWQMH6/UHI2Pj
 p+2V/TSdWZ3glsG+wjxuHrztGPd7NVDWnvn4+6YQ0dFz3boMK6GaEKITCJEGTLCCkN3J
 Hq68iUIK+L/tn5Bhq5PyJ8+kreqs4nyGGKMmlrQQA9wQXG9DqnOGmhJYr8lZySpk7BQd
 lUo4DLjUvywHsM8IU7cVPinKN+3M2UTXoEolm6ogDhT4Qoj+rj/zd3LcO2karBx2ROjv
 vVVA==
X-Gm-Message-State: AOJu0YzdWzLZ8ky/jirc1Z+dO4KiOMh0E1zSm1iQaitvaCaOpUR1UTNG
 KsC3wquHSqFAbxBBy5rtcTZ4NyctS8sq+C0ZVdBtmECwvfipvqzgMRRgKtcGCUgfgPvhuRQnxIe
 YXZ7M
X-Gm-Gg: ASbGncs2/EcNTyXsE6x4HIUN5/X2XEg0McRidnLdNe3UGqZ49a6RobXbZNOoz+cemlh
 KvtVPqPszhZH89/6raNaBcuCYkYTpY+/AkjB37ZRYpGEWyJ3XQj9Aw5uesV6KjMEJ1eAv/NYxlB
 SacfmJ0YwQpgx50uWZ+CS5MkmhMHfRiitgqgAM23tBsDIye5YYTpSOI1bDFm2qLKonLagcxPJQf
 k19i3vd/lvFEroiNtkC6a3AP/7v9C9OfwusXN3GiiPVS9QP7gBlMVLNVOfEDk5bvNwviYtHlWHW
 24XsJ4tI7AZRfV83opflgtU0HsRxr72c9ddHudWZizjIZ/mut/EwEEe5W5bbLOA67XzFUGWp826
 NdhQpp/jIB5hoXGdrwr8PZ4T6dAMFwK7Q/ZMBlll3sx9Rd13uGA==
X-Google-Smtp-Source: AGHT+IFkLAMPGjU0yIcvdt3hvjK+TXbbmOXRnIwzDoHLXnLE/20dkCq0OYfaDTgBI/RYEi0N4+BbhQ==
X-Received: by 2002:a5d:6b09:0:b0:3b7:767f:b2a5 with SMTP id
 ffacd0b85a97d-3b7767fba9cmr6497196f8f.31.1753717630226; 
 Mon, 28 Jul 2025 08:47:10 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f0c64fsm8917134f8f.60.2025.07.28.08.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 08:47:09 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 28 Jul 2025 16:47:09 +0100
Subject: [PATCH] mailbox: zynqmp: Fix off by 1 errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-zynqmp-ipi-v1-1-b2bd144a9521@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHybh2gC/x2NQQ6CMBAAv0L27CZtDaHyFeOhLavsgVJ3jQEJf
 6d4nEwms4GSMCn0zQZCX1aecwV7aSCNIb8IeagMzrjWdM7jb83vqSAXRhNtd7Pu6o1voQYxKGG
 UkNN4JlPQD8kpitCTl//l/tj3A8g1k5V1AAAA
To: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Use resource_size to correctly calculate the size to pass to
devm_ioremap and avoid the off by 1 errors previously present.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mailbox/zynqmp-ipi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
index 851aa737c03..f62277385fb 100644
--- a/drivers/mailbox/zynqmp-ipi.c
+++ b/drivers/mailbox/zynqmp-ipi.c
@@ -188,7 +188,7 @@ static int zynqmp_ipi_dest_probe(struct udevice *dev)
 		return -EINVAL;
 	};
 	zynqmp->local_req_regs = devm_ioremap(dev, res.start,
-					      (res.start - res.end));
+					      resource_size(&res));
 	if (!zynqmp->local_req_regs)
 		return -EINVAL;
 
@@ -197,7 +197,7 @@ static int zynqmp_ipi_dest_probe(struct udevice *dev)
 		return -EINVAL;
 	};
 	zynqmp->local_res_regs = devm_ioremap(dev, res.start,
-					      (res.start - res.end));
+					      resource_size(&res));
 	if (!zynqmp->local_res_regs)
 		return -EINVAL;
 
@@ -206,7 +206,7 @@ static int zynqmp_ipi_dest_probe(struct udevice *dev)
 		return -EINVAL;
 	};
 	zynqmp->remote_req_regs = devm_ioremap(dev, res.start,
-					       (res.start - res.end));
+					       resource_size(&res));
 	if (!zynqmp->remote_req_regs)
 		return -EINVAL;
 
@@ -215,7 +215,7 @@ static int zynqmp_ipi_dest_probe(struct udevice *dev)
 		return -EINVAL;
 	};
 	zynqmp->remote_res_regs = devm_ioremap(dev, res.start,
-					       (res.start - res.end));
+					       resource_size(&res));
 	if (!zynqmp->remote_res_regs)
 		return -EINVAL;
 

---
base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
change-id: 20250728-zynqmp-ipi-0b1791238085

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

