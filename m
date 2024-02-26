Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD75C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA36787FE0;
	Mon, 26 Feb 2024 18:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gNyYj5Wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C668E87F4F; Mon, 26 Feb 2024 18:26:48 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD8A87F9B
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d288bac3caso17215081fa.2
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968397; x=1709573197; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=topWasnRLqEapH6DShkxIcdK39V/HsSOrxCBuPqsOyY=;
 b=gNyYj5WfAw/BwQCIAp1pQyHo0xJiRf/NUO9SC/YkbiuRofyQv/R3I48qrQI0BFNjRs
 60rbB54siUWA6LnKo+iYKg9sZzWCU8el63aK9/alw2iQ+vOWZrWMiC8p9NSLpzowuv2b
 /EQ/1ZI8kX045AYEhZY0qizz71NnNRtMqGQp6GUtURqkOoSvQdMv7AQCqg4u5YtwzIsX
 0Ng88yBaVj9sOqAbHiJuzcysI2KgvO78v3R4SFTGH92dIFHeBl/4jGc09TPJa0oI8VPK
 OW0uJMQB+KvXGi37lKy6xpaudfzV2uEB3qfVVBtktUx1JoidCgf0J16rRVMXtyvhq16I
 BurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968397; x=1709573197;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=topWasnRLqEapH6DShkxIcdK39V/HsSOrxCBuPqsOyY=;
 b=ajkYVgm67lwMIbk2jSQTu0TPV6pC4uZ/7pMX2yB1YpHiDWvtn1bZqe/kbL2y4IKrOI
 chCxUms3QCoNveR6nRGtzKZ+pxzG6PVjd3C/YjpzxnzpCT/18ZxekgBWjyFRV4XBnwIQ
 pTX2J6cdWejiMNQ/qdk1REdAYWo08pHV2rNUcnsmeP8Rdwshd1rG5VD5t9PVWD11T4ao
 QAdpApfZR9LPiYDnHyxIyrARLd8Fnis686oZCesYhwyn/auRVK9W8y92cw6jc9jTP5NB
 i8D6bgysK7ZM9fRkKZw2ucFXkVKecQJQve8JYNHW1VRIT0tBeA3nk2aBTV6qUplMx/Ts
 BSVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbos6eq0xgKP0GOUyXDrgVXKrOs38XTzaMf+1cfwWm298TjvX6dok55l3nrnM9ZAkZEsLR1oQAitt7T5F4lK3PU/GKqA==
X-Gm-Message-State: AOJu0YyqWWhmEX6x5i/B2QrxdhNKux4pqmAjUQwuPLvaX1FBMq3DWanK
 SraDlVfgqW2V6SRsbf2VvrCvX8RpmgDz5KTx0XsRiCK4gUkV1+6LICql6wNNnBE=
X-Google-Smtp-Source: AGHT+IGffqnIfwj0wdsLy/IeM8zTQNtj186rfLdvAlpBSkSvi8nz9Yy0ySCZJUdu4QlReWdy79I30A==
X-Received: by 2002:a2e:a549:0:b0:2d2:6227:d30a with SMTP id
 e9-20020a2ea549000000b002d26227d30amr5627848ljn.2.1708968396796; 
 Mon, 26 Feb 2024 09:26:36 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:36 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:20 +0000
Subject: [PATCH v5 16/39] board: dragonboard410c: add chainloaded config
 fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-16-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=uUR57ae7XCl6N80/g8XLDnnOGI5ZqafrsXOFKjVvw0s=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3eFLmXVvJhYdOwG66/dAazdDxbx9m+e8Tv2mJDfj
 Esrr/BodZSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJrHvJ8E+P6aqxznvTP3w5
 FW82Sd5fGduvvW2lWnZi+ITW3HURK7sYGZa1SqoeYJXrE/OYsX5FPlPmn6IExbpPRsd25W374Tx
 1Vz0A
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

Add a config fragment for building U-Boot such that it can be
chainloaded by aboot/LK rather than being flashed directly to the aboot
partition.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/dragonboard410c/configs/chainloaded.config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/qualcomm/dragonboard410c/configs/chainloaded.config b/board/qualcomm/dragonboard410c/configs/chainloaded.config
new file mode 100644
index 000000000000..3fd064924a1f
--- /dev/null
+++ b/board/qualcomm/dragonboard410c/configs/chainloaded.config
@@ -0,0 +1,7 @@
+# CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK is not set
+CONFIG_TEXT_BASE=0x0
+# CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR is not set
+# CONFIG_REMAKE_ELF is not set
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_INIT_SP_RELATIVE=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=524288

-- 
2.43.1

