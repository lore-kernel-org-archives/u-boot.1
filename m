Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1054CC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30E084011;
	Mon,  4 Aug 2025 23:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ML44+ZxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511AB84006; Mon,  4 Aug 2025 23:57:29 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC5383B1B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3e3f0287842so40304485ab.3
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344646; x=1754949446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQ3U3A+9MsZu+q7hOIBs2c/nunSQjmw8BIVnr4lD3cM=;
 b=ML44+ZxCeXD/8YXbm8YwBVNM9X6pkRbBMi22WLGfWf57YbqKSY/afh+MwbJCaHMRvI
 VxAGIz6rOP4hxZUd27r4p2KpR1JU1m7LfvvmGe4eVzyL4c8TogHM7MjXZKTjNgwe9QjV
 XizV/ytmlNm2FVNgWkDBqiAODMyfas2ftM4Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344646; x=1754949446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQ3U3A+9MsZu+q7hOIBs2c/nunSQjmw8BIVnr4lD3cM=;
 b=ibodebxzQVGFjkkqYX/9fdNA3q8gvkudwwIbK4cb+8w+vqyVgnC74lxAIJYv7rVPbF
 JJiPxfNyhXu78h+6EOHEXPCl6Rv1CvYK8pY0i0bIbzKscTIhLO/m9o1G25wR02wsam1b
 got2yH8tOxKSMKRTbhIAcMyosbRvR9Dl1Smu9zR1naFPxwCbzHwrQrv4Ggm1SdrFqulI
 mmj3P4zRxAl/Iyr1ZnSgKvHcFVS9DQvexsvGruubrFFZfs2ML7LQLu+ntOtFdVxUhQW3
 9Tx8sTd27a8BEwxrKUPpiWKSTBe7ElexBjmwmIeWXRjTQdifaGfEPgJKKBs+KKsL/34B
 y6Xw==
X-Gm-Message-State: AOJu0YzIzWpMMS2LX4yhKKhZ6bD4h9BLrOXLQ506FAvRt905wfBRr1H7
 QJtBIg4olY1zsMJc1vfCPK3LDg4FOvCtp/nWvHDy3/dBtoKEDtlaLF4bOclAYsC+mulDF3FNNwV
 zxFQDMRA=
X-Gm-Gg: ASbGncsKFbf4FZuJKO/4h7UYU7Y0vfr1DGqeYFpIJVBxLl9x2CeiXiM3OXHso3fIjw8
 nMw1MK9ktqqlTKVC+bucb8TXmvQMUhnUb9JOmnSp/oWua3rQZZ3T3az9yDNGOGtigR+bvbsIf9f
 AXH8c7lNON8fHZgGDLACtE1xI0JeHEqUzSJUX1ppbLqtpeyttX/apfLfXB8gHwt5DlmKrnD4Gle
 ohFKlmd0pHyPRmZxvNaowQIHvz0g68UCtZ3pKQCspeWcUCxti9xA1z68VvGe4SeZdeQ+zQJbF0D
 DOAs+E/G44D/fMaaKJW9wrjQYckSXaKHKzh9ki5z8q2xtuF7BRsID053PRydvUVvrLbd+t9ejxH
 VaonmjZApNMgq9zIjrHXYyWbcBBEU86z2OEBWFJYmZmcJpOEMFpAa7BJJCICL57uRSDvd
X-Google-Smtp-Source: AGHT+IHNXfyXPItXui8STdCq/Bg/FQGkoYzbsDOram2Gn+CI6XbWn6uC91TZZ37NgLUDD2Q6cleO5w==
X-Received: by 2002:a92:c265:0:b0:3e3:cbd4:ca21 with SMTP id
 e9e14a558f8ab-3e4161dc23emr206606845ab.22.1754344645694; 
 Mon, 04 Aug 2025 14:57:25 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a9f677f81sm1066177173.39.2025.08.04.14.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:57:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH] soc: Tighten some soc driver dependencies
Date: Mon,  4 Aug 2025 15:57:15 -0600
Message-ID: <20250804215719.1413106-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215719.1413106-1-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
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

The Qualcomm Snapdragon "SoC" driver cannot build without access to some
ARM64 specific functionality. Express that requirements in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 4aa7833930c7..8243805e46a3 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -4,6 +4,7 @@
 #
 menuconfig SOC_QCOM
 	bool "Qualcomm SOC drivers support"
+	depends on ARM64
 	help
 	  Say Y here if you want to enable Qualcomm SOC drivers support.
 
-- 
2.43.0

