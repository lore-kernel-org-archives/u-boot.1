Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E070EC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A90781FC8;
	Wed,  2 Apr 2025 00:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U2kF6qAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A0F80F6B; Wed,  2 Apr 2025 00:52:40 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E74FB8171B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso41418295e9.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547958; x=1744152758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mOUBRote2YI3pSatWFEQ422yBmZ2/9Oq3/QkjbevFFU=;
 b=U2kF6qAp2+7ZxBEIap6gxGBGRPURMKV78MYR9yVu+vR5oqu7RcOp8rJ+Cp/oMhYU79
 xmS0dyRG4TfHaxc9GdVbtqVP5zeJqT+YYkUWcxfilNrwnuY1/+1/PrW0POrD+6Op7yBP
 C6KT+++sPxHOMJ68Vp+hL1BARMmDMLBmzezn85TL0rEFWFziCvnL4Sex/8fzQ27pr9mV
 QVdiKpIMbK8zvMzysZKMREfzOF69qVcwhlGAH1i/ZMlYOB2A/m+zY6XXzUsbDlN+Yvcd
 ZqJQFjKFPQiRaXEfVhhrbtST8FGiKmkRQpBMMPvPUOyd1jNElxG7OFmsaxOXQkT0KSlS
 JbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547958; x=1744152758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOUBRote2YI3pSatWFEQ422yBmZ2/9Oq3/QkjbevFFU=;
 b=bWy0ORiBq912QB9obI4E250M5n2X8VKZ7DaOIGMKLy8GJMAyMFspqRUWfg+4tWYqdd
 w5lWiiFE75dj27UE9zQOsyySLLgM2th8esAZ9dM5FWD+y1R6yEtCumbkiXQVtKPkwPP3
 GxHpVF/SkkYHjySQBcUZmglRdULVjA5i/uIfLRi5tH2TsrgEo/6qKrXhhVkjLxqoZ6y+
 z49658IOEBHuGYJko2tJVoZWmUhXH97TcBU0JApRqo9jTicxisyhuOMPMdf+rFFgEGFs
 glZI4gwpmP3BFaF7BDJDJruRypDp4uqENv+XQ44Fh7km6WwXTFuTkGMiNCLRCTcO6wkC
 Aeug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXplyxaC9hWMGbbRaXHXPUrdsYqTzUA4UfNlwb47t5De8mpwh9CB2Dkg/RsmqJTrWL5ebH72GE=@lists.denx.de
X-Gm-Message-State: AOJu0YzTjQitxONqcd3rxemz2xh3InDFwvrtG4gHs0c8lWKGHWnC+css
 fj+ZlpJzU34Vv3COGKikng1+FkqwQIJbD74mvibCLPVva0BOu0LU
X-Gm-Gg: ASbGnct1zRvkmGqvWRzQKl3e0JzYe3iV9MmUogncBUfzmBgyKeCAi1rhm0KrfxGea25
 RKUEc/mgGoErKygao7mxPrkeNiPC1FKMSB9ukHnrEzghz12u6ZM268nCUJ6Ev0ts4uAtcBmVQ7B
 OubrUHLbAVuoeOKkFkNBO0XBFW2jnVw275SiUL2qe2fKWpERnI9wgAhbC3BbRXvoiuEPina6OAV
 qDAddkB63swU9jHs2AQI6szPJot2O4H5QEOcrMq43arc+r5qMW4Tiq6k7p5EdeoilhBgO0dR9iG
 DAJebQNsajrCZfof3YSaKom2ci6wNSKWkMTq/IMgCC6Jhcqqa61V0+Id7gLGLkEznsNbmZ3jEJt
 IR7kMKF5Su5w5vOQO06wcAJIQ
X-Google-Smtp-Source: AGHT+IFvnRip4Gf6YE5WLhtGerOCoLObX9UsOT6TfBHdbTF5BC48xfhGeRvu4LvrRQS1br2+9PEmZw==
X-Received: by 2002:a05:600c:45ce:b0:43d:7de:16e3 with SMTP id
 5b1f17b1804b1-43db628b924mr123416285e9.24.1743547958314; 
 Tue, 01 Apr 2025 15:52:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 03/14] airoha: Add Ethernet config to defconfig
Date: Wed,  2 Apr 2025 00:51:35 +0200
Message-ID: <20250401225156.25790-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

Add Ethrnet config to defconfig to enable Ethernet support.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index f09b5b603a2..f5bd647cb6e 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -76,3 +76,4 @@ CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_SHA512=y
+CONFIG_AIROHA_ETH=y
-- 
2.48.1

