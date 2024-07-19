Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15FBC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 13:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEB188BBA;
	Fri, 19 Jul 2024 15:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MKD90ZQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77C8488BC0; Fri, 19 Jul 2024 15:57:00 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C81088B8D
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 15:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368526b1333so542350f8f.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721397415; x=1722002215; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H6kCWILjwa/l7q4hky/FWVQZCpyBG5Rys5PjAIpygKA=;
 b=MKD90ZQwrxdM05Kk95A5rlkaBrPwDJlqaFcN+CZ+CJ7HK3ZjIt0dTbbJVef46QfN5/
 YZ+ybmGeurryJwXbliaO6FLJRZvYfXxLVCAdOR0VlGlIQeTnJBADZQ/gbO3IfKzZeeJI
 BMSUc+os+7j0X66jg3aKqDSvjAq+qt2rpLKmS73L7S11gznaQu0nLpU/OeQucxPzZEii
 r+u7csBFFA3Zp6qjlxRwOdCJnF0KGVcgD+m1CrxfhJnNePEKRUmUNWcG/RcRP5jyC1a6
 5n7BWj1Gvt7AM/Ko7r0rWbvqSwa0bDfZm0922GtOlEC5bWYsO8fpu691IcJhu8JP2RD6
 S2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721397415; x=1722002215;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H6kCWILjwa/l7q4hky/FWVQZCpyBG5Rys5PjAIpygKA=;
 b=NyGT+oeB/IzJAsFmoummi3TIKcZOQsc63hLWOODKolC/VeJ2SJggR/wCVlD9N7SioN
 nTexCTtQh7SjaTN5cJds1OJ+sqG3N2pnBF0AarbFs8frxAIvLEagleSIel/T53rK3U7v
 TVjBOtAA+aK5XdRlZ5zNrgMe0Tcl8LPrOkTScwptqux5tn5C3pBbJyThx4ieRp5wYRgt
 I85ZoeeVL/0TSknaU9lCC2nNNpVooX6mnReJeGDNVSrknRufqmxpVDNnNK+bVmk+BbP5
 88qm+Tz0ZYB0BWu6tXjyPSW75+8vAXm0272bRrfghUYOvvPd7GhdAb6DaXANuVMPuxwX
 iowQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMITujqDySAn6lZjpLddSWTw8XP38w9gCG0QwW38Aja/AWHW5MrrO1E/yv33/pfcY/yKJLZ5Rlujrh6TnTYhiHPtIrpg==
X-Gm-Message-State: AOJu0YyfNnRNvVxosAhjS8H9mTNXiVnG7WQ5YUdRgaK29VH0YeACOGEj
 FWeYldpohfcJL/smVPQGlSH6/+gWPJgAaWTUbuZWqCyqSsQbo0YdsOKIKadEN7I=
X-Google-Smtp-Source: AGHT+IGxjKiHtH3IET3whLnQuNwAzN/1neaVcc35k0qIbLOzdTaVUEWPcGUtPiu/E7fn0WPEGzYyPQ==
X-Received: by 2002:adf:e682:0:b0:361:e909:60c3 with SMTP id
 ffacd0b85a97d-36873ecc9a7mr1923633f8f.9.1721397414639; 
 Fri, 19 Jul 2024 06:56:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bc21sm1694083f8f.39.2024.07.19.06.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 06:56:54 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] dwc3: gadget: properly fix cache operations
Date: Fri, 19 Jul 2024 15:56:49 +0200
Message-Id: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKFwmmYC/x2NywqDMBBFf0Vm3QETWx/9FekiTa5xNkYStQXx3
 zt0dw4H7j2pIAsKPauTMg4pkhYVc6vIz26JYAnqZGt7rzsz8M7vlDYOH99wdCFC2Ts/gyf57iv
 DGQy2e/Rt25CurBka/g/j67p+af9dZ3EAAAA=
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=999;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=SwUiAHa7877BWYISLlfVOV7kbKMuxkKpyNfkJ8GVT2o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmmnCkD/QN6DLJnHhXI9Fyl2IPKjTG7LdnBn1iTO/6
 XB9aKIiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZppwpAAKCRB33NvayMhJ0SH3D/
 9F3VNzIX1az7P8gpJDaVg6oQehYYGZ0eA5Wc7vOJ80lpo9uvZqBSn/MV8m8bi9EmNhYKJ6Q3mtYgo3
 r3w9ILAaKV81yvdRfbJfYDJdTWNwabO5j+Ya6HiwYCzcUsb4OnNwauXd7uNFAxL53L2q8Eat9AnASz
 2D9PVuui7HxsnKHUtJxCc0/J5KbK5yKWv7EGZWZK6+0rOdV+Eni6f9/ZfS3HWRfjQ2tLP8Yjq5fhcg
 +yqExGxAbykpFrmybDP92ssLhIh5Latp0V3nJkTCRXazcwUZ/wisP7IUfWfC44rnjckp7fXtcGMWhF
 hnxaKgz28mUUA5blxVi+RcPF5hf1CfrvguGtXcrRmD+JFdG8z7ZTnnGUmO9cQgzG1mHX+ZgQRBnu3A
 WxdaGvD5mHfkbvAnXAbFqghmUlSrdPCBO0QOqmM4O01ey9/vzja1MUQ6VNBF9t9n+oagsTUBKHszVq
 7dDcLo1n7WrmJrFjtd78dDrRLoYGo0noVmTUk6v3eQHTORjYnOkkxKA4scJuti8w6Vo26UCUet4lW5
 ZDBetqjaztFCqJQNSWD0qZQxkrn5Xtw62afWj8WsH2urpomjb1JJnowZHAaEvIV5MvV+KSJay1xyPy
 Y6cp6lBsGzTxppKhp0sKytLbVlxQXRrTUauYjUUOz9hnLTCAx6CUfbpx59kw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

We experience huge problems with cache handling on Qualcomm
systems, and it appears the dcache handling in the DWC3 gadget
code is quite wrong and causes operational issues.

This serie fixes the dcache operations on unaligned data,
and properly invalidate buffers when reading back data from
hardware.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      usb: dwc3: allocate setup_buf with dma_alloc_coherent()
      usb: dwc3: fix dcache flush range calculation
      usb: dwc3: invalidate dcache on buffer used in interrupt handling

 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/ep0.c    |  6 ++++--
 drivers/usb/dwc3/gadget.c | 10 ++++++----
 drivers/usb/dwc3/io.h     | 13 ++++++++++++-
 4 files changed, 24 insertions(+), 7 deletions(-)
---
base-commit: 3f772959501c99fbe5aa0b22a36efe3478d1ae1c
change-id: 20240719-u-boot-dwc3-gadget-dcache-fixup-ea1e92758663

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

