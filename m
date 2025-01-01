Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA0BE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83FF080691;
	Wed,  1 Jan 2025 23:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DmsQCWQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4468F8066C; Wed,  1 Jan 2025 23:16:49 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F177580628
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21680814d42so126292225ad.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769805; x=1736374605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qy4VAXUQfYue2jbahqTX7P91yP37rqxW8rcqUEDr+Ks=;
 b=DmsQCWQGhDwqzz1GTcnjRGwHtptetLA6D/oxXa9S0G5YzUmv9WUQIXbAZCm0KYWuy9
 JSTSGsOezXHE3x23jK6+lwsB4Ar+9x+DTIKg8qFYKsrwaaXCDpN1apaV4VTN6BaDRNmN
 hSaR15RCGj9nyUA5icynPZKnOYrXiL7vVxXx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769805; x=1736374605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qy4VAXUQfYue2jbahqTX7P91yP37rqxW8rcqUEDr+Ks=;
 b=DwtxxOV3493uXgyUf5Qg5g/0/aZxTJdtHrULYPc1twVLaq+np9XHZJSCscQfFSHap8
 K1wh+2Smq4hiODAsSxJ9bwieMZSIaAVWkJtnDZwuiBtZy0WH4mim3loh5E3JAc/FTE60
 wOkpVTK1iS4VRYbYaBnAKo5ljWvpCBiTfgSsSL4oaulR9doqHtLyG8weXKxoRWD7JcHU
 hEuZG5HzYUk+e0FG0aNQrQAMPoU6sqIVL7QhxakZGHCxHqMfTfwwq/tYxRO8n1AEMr24
 8Y2LgVSwyJvP3KQHlF0klaPqzgHsqqZpE5xwll1esH3OoJ1y+qWJh2+76+Xzc1IjWwBs
 XpdA==
X-Gm-Message-State: AOJu0YwDy0pgMy9y4sw/WiLWT8RUSphIUJXBi1p+8BDapenWiwkpgpXF
 uyzK4QO6gsu0iQIcFudq9FDN+7Tlcwn2/FLXQdBxjSUN3UP4dgwU6+oFlruW2sFKYbl6vyWr2fw
 =
X-Gm-Gg: ASbGncutEPdRnQHKA3C0zxkx1aQLONBTnBcXS7++48zXdmwMkQesn4vGh+wEJLYeg8z
 IylFmySi7Z+dR7k0pj2mYP0vBGztSipkpV0wLzhG38ijd6WFCkMWvvqTavwutmyxXih2N2+vUVc
 QXmDJMViM473OjbUlRfinrW/Z2bTkBIegPFChVeRgwzB4MblpHFAisgzy2abPuM4gsMk6YYAJfM
 s5RC4dfsBAaEQBcjLYnXWf+AHMgf9I1a01k3EgqNnsiRqBxAGloNdA=
X-Google-Smtp-Source: AGHT+IFQXX+JDf4kr/LUqYdcdpbfbhbM3/5kDoGKlB0zqJvAXLNTMlKN15M2ooo976a963p34uutNw==
X-Received: by 2002:a05:6a20:d045:b0:1e1:9893:9a1a with SMTP id
 adf61e73a8af0-1e5e085855dmr76747615637.46.1735769804941; 
 Wed, 01 Jan 2025 14:16:44 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:16:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 34/67] upl: Require OFNODE_MULTI_TREE when writing a UPL
 handoff
Date: Thu,  2 Jan 2025 11:09:20 +1300
Message-ID: <20250101221003.1944600-35-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

This requires a new oftree to be created, which is only supported if
this option is enabled. Add a 'select' to ensure this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 705947cfa95..f9263513268 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -786,6 +786,7 @@ config UPL_READ
 
 config UPL_WRITE
 	bool "upl - Support writing a Universal Payload handoff"
+	select OFNODE_MULTI_TREE
 	help
 	  Provides support for encoding a UPL-format payload from a C structure
 	  so it can be passed to another program. This is just the writing
-- 
2.43.0

