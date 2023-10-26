Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F38C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1201987B2E;
	Thu, 26 Oct 2023 07:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G4VAIw7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42ED787B24; Thu, 26 Oct 2023 07:31:53 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99DEA87B1E
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ba8eb7e581so112003b3a.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298309; x=1698903109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSlmcmhian9jA6bQ6FwNP+u6e3gkMVRlAhlaAxq2KoQ=;
 b=G4VAIw7JloRVA3AXa5Ufp+NCoy5d6LnpP8Xfd9BTraAm3mnhdY3rC/r9+D3SuzHhi3
 9fyhMN3keaKeU6kF3uFOTMglpqy99yMAIF6q1C0izdFkJjAeJC91eigPu9F6+A+XmkqU
 ktj0jsz6qaZo24uzZSGJNJe2R4W9o3HEF2XvZBPva3CttqwIJchz0VtVqxZpiwWmPtfJ
 ZtbD2KbOgqirqk4irS/0Gp/0xAbQUP+qlYvtL8hQfvPhBeWHluGUkk93tIFcYxM4BM3a
 +NPDUQeTi6fyD4x+gAY2PBm1VEao4RWS+Dq344jbeewfbUO9NmDoSgMWSBMnWlC7xDov
 KRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298309; x=1698903109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSlmcmhian9jA6bQ6FwNP+u6e3gkMVRlAhlaAxq2KoQ=;
 b=IzY5suwRuq4N0vWoZegQ5vZsQn9wbbVtp48acXlWwF9bSuDZzp+sUBwupYBBH5tvxw
 eND9Udp7+IHbWrmFnHc8VQ/ZckkqtX945FYPDFqWER05a1LhTEZpNwtjoXEdcxr4OCSZ
 q2XzpWQSGxaWnSZpvqxWZvCwJG92Mluz3rVcKjS4dHdX/GtPu9sOVMy4l/WH1UWYx7v5
 7OvSTn0qHZd1IL1EFHvm0XAgj/ZhcPmRoZF4uuH3SMK7HhDY67bfzEuFVTj0p8e3KpRA
 vOuZ5F4CTQOmNXL/qaPpStbsZVwu4vmpdEwmbRe0BrAbqQW8eXH5j92xvQiMGWRlDeJS
 z7xw==
X-Gm-Message-State: AOJu0YzBR2SWQlpiQNwEQzNW43/2bSXeMsSLdmkiT1gZwUxIRvyQqxn6
 bv8fmUfsQ0jGPcOCfnkbtGVRyg==
X-Google-Smtp-Source: AGHT+IH6Z7AS0EwoTwe42cvyaC2hQRMKhOdXCRTd3BTaDn/C4rPr3NEtavWQDhawWbjYPvhDxM20Xw==
X-Received: by 2002:a05:6a00:1a8f:b0:6be:cb8c:92c7 with SMTP id
 e15-20020a056a001a8f00b006becb8c92c7mr18554087pfv.3.1698298308908; 
 Wed, 25 Oct 2023 22:31:48 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:48 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 13/13] block: rkmtd: select CONFIG_RANDOM_UUID explicitly
Date: Thu, 26 Oct 2023 14:30:52 +0900
Message-Id: <20231026053052.622453-14-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026053052.622453-1-takahiro.akashi@linaro.org>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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

This option is necessary to compile any way.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/block/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 048a6caef00f..5cda21551043 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -265,6 +265,7 @@ config SYS_64BIT_LBA
 
 config RKMTD
 	bool "Rockchip rkmtd virtual block device"
+	imply RANDOM_UUID
 	help
 	  Enable "rkmtd" class and driver to create a virtual block device
 	  to transfer Rockchip boot block data to and from NAND with block
-- 
2.34.1

