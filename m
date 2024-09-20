Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F82CF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA731893E0;
	Fri, 20 Sep 2024 09:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KCbX3EmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAED9893E4; Fri, 20 Sep 2024 09:25:15 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9433C893BF
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb7a2e4d6so14382835e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817109; x=1727421909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdUM5/PpGXJKSGe7/bTQ0CTAdx3pUTNrp7nLeXQXz8A=;
 b=KCbX3EmCn4oG4wfxkP1T6cIsDxfR6nuvFP+Pm+YPhVcUKXAGiF+FdWyZGeyUiyNXCH
 7pQLyAV5AdLMclTqWyU/CGPD3yWJUb2qpxgQI642jXiMQyrvjJMSBvM4Nxk2vnGwSrnj
 97uQL/jM1Jkrn8nZXp/AZ+IKyalSGxhVVGQ9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817109; x=1727421909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OdUM5/PpGXJKSGe7/bTQ0CTAdx3pUTNrp7nLeXQXz8A=;
 b=dwoHnPoVjuK4ARe2tuN+wf4cLuJyKn0SHYUmJqDAE/kZ2bJUe199z+n31k0CiXxvng
 w24zdE8Qe54HpzNmM+Et7OklSwPv2g00Ci45kugkPw7L7L/V947HPL0Oa1Xly6EcGHwQ
 iiOBTka8YeCMf7QWRzel3Xo7VngpNEtFxg37kE+M9j3x037BfCtlH7G84niisCqscL38
 NMLyfDuLEYZ64My7kh0bFLzsQF+Vy35wG3sLctRbpo4GJ1Ci5GwB+N74JJOVAWu8buvx
 c2K78NH9G6RPj71ykMVeIGHEqJnHHHRDksBUQVa8P345VAgFXfLijcIbVjzbuDVJwWX7
 9yrQ==
X-Gm-Message-State: AOJu0YxjWuG3oqxGALCdKkjTrJ9mNGm241QEesku7bdIvo43TfS5ecGr
 am8nMbTAn6bTsxp0UHNmGvhukRkYMvWjk/HkUUVSKsk71SBWSsgBqk2l6aLeUzxqsH68kJrPf/k
 85Zhd
X-Google-Smtp-Source: AGHT+IFJgwP7MqVGgQvi8MgBgiM4+zFBR+Gw2Inpgs5Vw7l3FY1OJ6rXoQqeoMaS3Gj6xPqXg0kFYg==
X-Received: by 2002:a05:600c:1c84:b0:428:e866:3933 with SMTP id
 5b1f17b1804b1-42e7ad880ddmr13652085e9.22.1726817108717; 
 Fri, 20 Sep 2024 00:25:08 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Robert Marko <robert.marko@sartura.hr>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 08/18] serial: Support debug UART in TPL
Date: Fri, 20 Sep 2024 09:24:32 +0200
Message-ID: <20240920072444.134997-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

Some boards want to use the debug UART in TPL so add an option for that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/serial/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 3a1e5a6f287..8b27ad9a77e 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -539,6 +539,13 @@ config TPL_DEBUG_UART_BASE
 	help
 	  This is the base address of your UART for memory-mapped UARTs for TPL.
 
+config VPL_DEBUG_UART_BASE
+	hex "Base address of UART for VPL"
+	depends on VPL && DEBUG_UART
+	default DEBUG_UART_BASE
+	help
+	  This is the base address of your UART for memory-mapped UARTs for VPL.
+
 config DEBUG_UART_CLOCK
 	int "UART input clock"
 	depends on DEBUG_UART
-- 
2.43.0

