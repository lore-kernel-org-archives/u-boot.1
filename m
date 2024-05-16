Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3F2C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E3F788341;
	Thu, 16 May 2024 14:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="mxyqFMnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C5888258; Thu, 16 May 2024 11:03:39 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800768824A
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=anand@edgeble.ai
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f47787a0c3so7010795b3a.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1715850214; x=1716455014;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azz8MgJYqdN8sNZFCT2jEjw9jq7YOCv/DC8X5OYMiEM=;
 b=mxyqFMnAtkaL1Io0mDcnYhaTFEQcFMtatffDgM5EPr4x3GbQrbNZz3ZL1v+VwBPRKF
 T01uMzAmCTLVYk7FXnksgrzsvoc4PrqPpvt/bU28i3My7av87aeITU92EOFKlb1B5ZX9
 S5l+jd+eJCgFzt4utFIZWQv6gqaWyJM2iOzljsQCDoOah/MMOZJy8TqRKaFkXWRegHqj
 QIqnrg6+g+yg8iB7GxMuTLD4cVroRDaCuccBdfjB2rNN8tyviMPta70+sFYo6G0NFRg+
 NTL6iJxd4DDXLDvEqBCmaHGlDJbBmXNhymo3v48WQDCodlfnwH5oHfZ0N42rHIj7O7WQ
 Ctuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850214; x=1716455014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=azz8MgJYqdN8sNZFCT2jEjw9jq7YOCv/DC8X5OYMiEM=;
 b=ufM4RtzZVTz7fT4Rp2GlhOzgYrkKjZBteter+i3R3JDtZnAdc9uhJDdRn2Vi0jo/32
 D8usTvs2BOKxq+cvuy6WzNg6lIsRvKil9hn3u1NDhJu9S9Ju35xIpZeIQWhr/xMYHCge
 DhJ5Nb90QjSsyj4QdygHPIZhsKGtwdmZDfJMQdg0Yen9IVIAA5/MW4z2ylkCr3mXnwRu
 ktkKoMwaTOJykNyAsn7QisenVwEitdotdwxaktOrLzJnDLQjUBGFGCb8GcSTrz8+ehWy
 F6BhGZG0VsYF1R7D2suuBrZ27hqBwEOh9SueSKf52owtSGsV2PZMbXQ0mqyDFJgVZjvA
 6ljg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCLMxAcWXUXodynCcT7t9AkH5s8kjWMGHGa2jWmPyvW5+Hw0w+GlUJGFDFv+bIUPhit6HD2Yg6XCuggwmaShebRYmesA==
X-Gm-Message-State: AOJu0Yx2CZC1Wn9iFnqPp31RIjV9ZN6Rp+LxqEEZLBnMGsEoyj4KQ0I/
 IrjLp1zELsuCxLmwzNSRB/BXYr5sSA0WTsIrSKqKTn7KYl5NnLqnMrU2wdoOH50KjkZQJtObwsN
 y
X-Google-Smtp-Source: AGHT+IFhZW3KU8+VWTu132853l8svVY7z/yBshaIgtWlyOGUl3sZEVX4arGWYMOa7619vg2ea7mVAg==
X-Received: by 2002:a05:6a20:9497:b0:1a9:db07:82ee with SMTP id
 adf61e73a8af0-1afde1b70abmr18161399637.44.1715850214018; 
 Thu, 16 May 2024 02:03:34 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6584e7897bdsm1325189a12.21.2024.05.16.02.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:03:33 -0700 (PDT)
From: Anand Moon <anand@edgeble.ai>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
Subject: [PATCH v1 5/9] arm: rockchip: Enable display cpuinfo to be build with
 SPL_BUILD
Date: Thu, 16 May 2024 08:59:05 +0000
Message-ID: <20240516090031.2373-6-anand@edgeble.ai>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516090031.2373-1-anand@edgeble.ai>
References: <20240516090031.2373-1-anand@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

Changes help enable CONFIG_DISPLAY_CPUINFO to build with SPL_BUILD for
SoC RK356x and RK3588.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 arch/arm/mach-rockchip/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index c07bdaee4c..6722e7c9ea 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -25,7 +25,7 @@ obj-y += boot_mode.o
 obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
 endif
 
-ifeq ($(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
 endif
 
-- 
2.45.0

