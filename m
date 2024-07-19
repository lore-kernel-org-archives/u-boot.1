Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BA2C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 11:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F25988B7C;
	Fri, 19 Jul 2024 13:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PI3XhSSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF98988BAB; Fri, 19 Jul 2024 13:00:17 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEE2888001
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42793fc0a6dso11334585e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721386815; x=1721991615; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WE+v9/IYadKTGvIviz3OHQ81kCUhYJKYbMlayf/9YvE=;
 b=PI3XhSSYC4Ro73hBn9WWkk963XS2X9DhSc3eSCGu9W3To0P9sQhiLIyQfU/hrafTvu
 obZCX2t/RrHLGDq9h70Y6PCMHf1lctS1dXiDtZQhcm3zgYR6eRCYunwhnOKC/LHI6FIi
 pxDNNFxA1okKAp6Njhm4piMxB03E8ZhXqWVLq0oh1I7ul4DRVCVVB1u0HwGm6hHjEXNS
 rj9Q7lIrcZuyFB27gA/eYHAh9ISbfWFHZaxTzJ67D6qeCRVvtb9STIByv2z/Mf4eGj6W
 o1NSwjuSrXXfxnH9gMjOvVitFk9J0fdHqWVuNiTe8TBMwRp5hm172190BqCrZfNmAiKj
 SDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721386815; x=1721991615;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WE+v9/IYadKTGvIviz3OHQ81kCUhYJKYbMlayf/9YvE=;
 b=aCMQXr26GKyFRSmWvNCvjR3u82gmTuwQw0YyGUIZZSU7Qnd2FMqjxnR2mG8s3rwAmT
 p4ldNsdp+Ovx4O4o/2bkAvVL5mLXeC2UORYZiBEkP27EjOXwA/JaE6QrGJTKQll4J3Ia
 gpDH3DOhJ+mByGjuBY4++TlhTJhbUT4q0JWf9sIyogfQblFuQmIKgz95lMVy9y1gLrDa
 IZjFIPsQOV6U1wAuGNZhLQ5dzNZ2V3103M48g531KbXH5rwDDntA2ejStGU6KWt2X0h2
 /DdZowdnopkKcR+25G5qUzNJ48G91+PPvbXSUkp+h3/5fj5VFwtzZxldHQJvQqsv3Xgt
 oUNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgievES29UJF1bhWjMNhzCrE/jbQEP7Xeq0+dLBihfsoTvyFkfXDnyl41/xbFdEXTc9iyLubAsDboi4iIGEGUNsQDccQ==
X-Gm-Message-State: AOJu0YwUTybB0wk7MbdCNUbH+4llfg1xQj07JvBMwWHkCJuUyvk7yD6e
 jIwa+OlkLYw3g8LlVf/HCgoWmmpwfKjYBZICI16HBZYq79mORg+yjnD7gRwCTzE=
X-Google-Smtp-Source: AGHT+IFyt935sJtRMbaRH96TZOE204ek6t0wusNmUSFLDlqEJOiB/L7Aq18DYj6RsvMqLgIotkGfMg==
X-Received: by 2002:a05:600c:1f95:b0:427:abed:3608 with SMTP id
 5b1f17b1804b1-427c2ca7a2fmr45312375e9.5.1721386814985; 
 Fri, 19 Jul 2024 04:00:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6697c3fsm20556055e9.0.2024.07.19.04.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 04:00:14 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/4] ufs: properly fix cache operations
Date: Fri, 19 Jul 2024 13:00:09 +0200
Message-Id: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADlHmmYC/x2MywqAIBAAfyX23IK9MPuV6GC65V4yNCOQ/j3pO
 AwzGSIFpghTlSHQzZH9UaCpKzBOHzsh28LQirYXslGYcPX+wrRFtEYbR7jxk060SqtRaCXHboB
 Sn4GK+M/z8r4fkLgU32kAAAA=
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=985;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+OvyvowGCVp1isBZr978pyBMDj+qPXv56diUjrE7gVc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmmkc7GEyEF2Mv5Sjop2XtmUWYaOgymfKbr8tSGvqt
 VISwHCqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZppHOwAKCRB33NvayMhJ0XT3EA
 CpwuTLZd6gryeT08tQnghcJLJnQomF1GBIwsKzF7y09dtv4arQMEencEmAY06BhocqKvAYVTjbUASy
 k+nauJZhrUdJKs50U5FNsMtA9H6EuWA0JB834OJIjDVwCNbhhnwF2Rd3g1cOGDNGqjXjBAEgvhf1XT
 lZ4OWJ6cNQLn5p12QsNImk5sZpBcINZfAh/PeXSsMlMH2KesVq6iVMZnHfDjSNTwwT6AuHnvhYys+A
 nyHDzZnEMMlGbNGNguBxrMBmdoFDIQMC1sJexF9UvRz47q0UNP5L2mJov2vQzXMe5XguVqbdoNV7+n
 pKYFZ7jXBYQdz/m/5pNc5DTzX2Cvsk4i/d0n0S5V9z8mlUpWQJhgN6qLuwZ3xQnT2UuBBiD6lNK23+
 wzVnLYl0hs/UhpXcf2WXdWoR/dAHIkip46rtSVzzXizQ/XSv5n2Re/o184NGPf0GVD/VWRV+wAm75r
 RyIGBiOgRS/J15OE2ThDwlWrSURpUE+YznllaXcZTuwhJ8xNe6GeDSKcjGkBtHM0zFUEkonDHshfHc
 /5h88sXOnI9X6v9umN1KjSdbC1D12IApJ3aBoahYxKCDzVMtzMocVfCiHb3MfMNnXdIH4kHRJyeaYa
 u87HFyWN91+k3uQbbx930IAHhewTPsCUphtd4+dRtvtFTfjSRftPpua3/vlQ==
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
systems, and it appears the dcache handling in the UFS core
is quite wrong and causes all those issues.

This serie fixes the dcache operations, and fixes a big data
write corruption due to a wrong data end address calculation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (4):
      ufs: allocate descriptors with size aligned with DMA_MINALIGN
      ufs: fix dcache flush and invalidate range calculation
      ufs: split flush and invalidate to only invalidate when required
      ufs: use dcache helpers for scsi_cmd data and only invalidate if necessary

 drivers/ufs/ufs.c | 74 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 30 deletions(-)
---
base-commit: 3f772959501c99fbe5aa0b22a36efe3478d1ae1c
change-id: 20240719-u-boot-ufs-dcache-fixup-d9a980a97835

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

