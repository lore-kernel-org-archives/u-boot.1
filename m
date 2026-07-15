Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B948CC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 12:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA15984AA1;
	Wed, 15 Jul 2026 14:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Y2UrMrsg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF7784A3A; Wed, 15 Jul 2026 14:27:37 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD5884A29
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 14:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15f6d667bcso680794266b.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784118454; x=1784723254; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E6zjFxnPbQ07Fll/7xfe1cFHKxDM1spjmt/VxED5Iow=;
 b=Y2UrMrsgGObMtWbV/MNzfvWqNvytBa5zkcVmSKqfvDhPRhWLjkbBOyK3axI9luxTX/
 j1l/LTANlck5nkfZFtSrQdTtgd4ktSDYlKwVn8tgXNrY4K8X0w9keZsunlemNE6Oi+yC
 G8We/NILtY9v2FyLQeclznYld+c8zhglhDA97eyx69Sux3ieUNlVRpzx1VRhD+1FecPu
 4p7KL8Dk9Wnij2M2U3KOV47Z5EDS/abXD/UkQcDlwNXX901zYyZUUOh2AAlhVzYM/nHO
 LJrIVLE2xw39Mr3YsQgoxRSj4jxdB65KFzsnO0vnh+vTwS42VoVOcoa1/UCOcaIeUJhc
 xw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784118454; x=1784723254;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E6zjFxnPbQ07Fll/7xfe1cFHKxDM1spjmt/VxED5Iow=;
 b=Q6211FQpC5pmu9QjsYnvt3mTlf0Iw+536VkZJt3eeHSebfF/RXxX9uldx4i8c6KDrJ
 fJU+zAmuJKzw8sINz6Y+uZsn9G/tlIPmt1+M32h/o4SuKxYzkD1Fek3IOEzxW5n2LZFV
 i13ww+7B8qISv32baveq9NMo0XL0naB43BLHJMnoZyj8q/CSEv6Fi4Gew3OcsgktrDFj
 nwYuNTmZeRoTB5eukR0ZP6CJ13EYVF+ARctXsbtbpipW26ebhTjN2YbTwTYF9XqrFLtT
 WvFSsfIAiVV3VpXODQsG14UP6TxUPIi0vvgpjWGwZEen7FhAWeI/WVTtpyFGuknIxNVQ
 1hVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMD1tZ4zUsv/tIJU2S3caEQef12/qmQmolhlLwjDd7ikPrH2S0bfAuBthiimpRqmAPEK+BENk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/WM2nTj2BJ8yzYQ4gR1obBaZ5mOd7/uI2MuAV0cVowteRyiMq
 6LYUvhynkJIrRH9ObNDhEvhWe1bwaGXPRQ7QP6zOXvBFqjo8KaMkD+qV3dJsWLAFGtM=
X-Gm-Gg: AfdE7cmqMxu5H7wtwN1t9YIGV3vlOD+9duiGVvpz7whSLbrKxQ1vvUvRs6oXwooj+UH
 xz5AAdn4e7hZ+oplgcWOQp3ysEig8hLgLAI5DxIL5bb91S1CvKjby4u2Bp1dNOJ5EioWLJAHyHb
 ifkvSh4O84Ft/7QYXCL19zCzwH45d5XnhP3PA5IiFhBc14uhUdPU4P4Y45UiqFmgrI9TVo73Pst
 QIL+4H96d1Wq3i/ff9ZswayUYga+GHvhT7sdA3RyjaZL0dh09je77ihTbvpTg2EyJq+jwycbqTs
 OApQWlaqEja/qU/3eByzbfxgDVBaNWFVoN8RbyMSL/iM+8OTZcHD1lhT8DQ5ME3YqFzuD0eKr3O
 v0pZnTqoozw9HSDDIK/wjCkl4TEwTIcFxQc5UzAhSl/WXDD8sRrvwu7t5nSUC+E9d5Y8nqjfPx1
 Pq+vMVaY892UyBcP/Mk7aHvyFHa9Ex+U3f/C8rxaH0yEm/gJ5sLyGrl7I7rb2VdVcKqYbGzdbt7
 k26JA==
X-Received: by 2002:a17:907:c319:b0:c15:ec09:d099 with SMTP id
 a640c23a62f3a-c167921d6d9mr174032566b.3.1784118453684; 
 Wed, 15 Jul 2026 05:27:33 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e6ecsm15062266b.44.2026.07.15.05.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:27:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/4] Add GDSC flags, fix checking of non-POLL_CFG_GDSCR
 GDSCs
Date: Wed, 15 Jul 2026 14:27:02 +0200
Message-Id: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBBA0V+RWWtSTTx/RSz6GDUiSAeRiH9XL
 M/i3gsYAyFDk1wQ8CCmZY5QaQJ20LNHQS4alFSFLLNceMdW9JP2LKStZaYqV5hSQwzWgD2d36z
 tfvNuRrTbe4D7fgDhmQD7bgAAAA==
X-Change-ID: 20260715-gdsc-flags-0c90128d6b7a
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Ajit Singh <blfizzyy@gmail.com>, Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118453; l=2258;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=CAdZRk6mSSbICWjCSDcx1Tu3LurZXIocfej2UBf9MHY=;
 b=zbFLNEuEtAYXPf8h8kN9/jFxq8iyQ/LOVK/986s8QLpMrkuTL+s6Cpd1eCfL3fUhqbClhm70c
 Gqln+IyoB1pDWBuTqw7PdZi/a7KT6ocmLuWoQmTeF66Zl5FnWiMMxTI
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 14:38:59 +0200
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

Currently the u-boot GDSC driver has no flags passed, which leads to
some GDSCs being treated wrongly, mostly ones that don't have
POLL_CFG_GDSCR set.

Correct this by import all GDSC flags into the clock drivers and then
start using the correct behavior for GDSCs that don't have
POLL_CFG_GDSCR set.

---
Changes in v2:
- Take over series
- Split patches (done by Alexey)
- Rebase on latest u-boot code, adjusting more clock drivers in the
  process
- Link to v1: https://lore.kernel.org/u-boot/20250108115911.4163437-1-alexeymin@postmarketos.org/

To: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexey Minnekhanov <alexeymin@minlexx.ru>
Cc: Luca Weiss <luca.weiss@fairphone.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Ajit Singh <blfizzyy@gmail.com>
Cc: Biswapriyo Nath <nathbappai@gmail.com>

---
Alexey Minnekhanov (4):
      clk/qcom: Print more details about stuck GDSC
      clk/qcom: Import GDSC flags from Linux
      clk/qcom: Add newly added GDSC flags to all qcom clk drivers
      clk/qcom: Treat different GDSCs differently

 drivers/clk/qcom/clock-milos.c    |  6 ++---
 drivers/clk/qcom/clock-qcom.c     | 46 ++++++++++++++++++++++-----------
 drivers/clk/qcom/clock-qcom.h     | 20 +++++++++++++++
 drivers/clk/qcom/clock-qcs8300.c  |  4 +--
 drivers/clk/qcom/clock-sa8775p.c  |  4 +--
 drivers/clk/qcom/clock-sc7280.c   |  8 +++---
 drivers/clk/qcom/clock-sdm845.c   | 42 +++++++++++++++---------------
 drivers/clk/qcom/clock-sm6125.c   |  8 +++---
 drivers/clk/qcom/clock-sm6350.c   |  4 +--
 drivers/clk/qcom/clock-sm8150.c   | 14 +++++-----
 drivers/clk/qcom/clock-sm8550.c   | 16 ++++++------
 drivers/clk/qcom/clock-sm8650.c   | 16 ++++++------
 drivers/clk/qcom/clock-x1e80100.c | 54 +++++++++++++++++++--------------------
 13 files changed, 139 insertions(+), 103 deletions(-)
---
base-commit: 501d76ca801343cce6dafb17740a8b679ed17072
change-id: 20260715-gdsc-flags-0c90128d6b7a

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

