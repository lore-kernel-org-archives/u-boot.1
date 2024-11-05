Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802B2D12678
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 10:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB5FF890D1;
	Tue,  5 Nov 2024 11:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GnMCN0n9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB59688CF1; Tue,  5 Nov 2024 11:25:36 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14183890D8
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 11:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-431688d5127so41761915e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 02:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730802334; x=1731407134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f999F0ihAKNvXEXleqUEZ9/K+TdX3AsyUfItGYUr6lQ=;
 b=GnMCN0n9wfQD4/0Zl2Tsk5Xrhp5tYsOWhqBxpaRUb3BKdp7tvslae7fyRZw/G6OWGM
 G8hQsVFkxxD7PfwlkfE7jtCCqhzayzOgkN1IQ/Aa1AS8Dvr0M0Ilw/FCvvrmR5FViVLK
 fIz5cU0VaR5yWfcfQ/RlCYu9cSAUoU3dbTGwz5upPmys2sqaWteh2tBNlcVKYKmkbDEC
 Ghtkdp53rXkevG3/3H8Otvsg30NmvpJJYS/liY8fsFaS3yIZiWIMoSxhlc5G/weCfw40
 JqGazWY/ws/B22t6AOR3wuwVdxixI0JIbgeclODTFi3ux3HR+dqXf3a1wEwt8qAcvWns
 GxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730802334; x=1731407134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f999F0ihAKNvXEXleqUEZ9/K+TdX3AsyUfItGYUr6lQ=;
 b=gfyeQV8y+nj9teAplL2Q48KAdR6c5AzRp5u8jVCa0jOAbHYbigGbM/xivHsVO21DY3
 aUkXqqp8SgzBkBVgDJImhp+navhCfZFe7GT9sE71qFsSNMWotL70nI/J3nAkzoO7w+E1
 VGpVBbR5bXQyN75kYTsVCIYIMrW2euCrix0J/H2wNX4s/lClO5KXqYrsCVhUV0ES5CKu
 gkH84Fx+JvySRrTtNxn6sz/894iW4Na8xRFxs+VuxjLMS+m+s0CF0Y4nf2L73/9GJP/b
 hvrKbSOhnNxu9nAIskLonJCV2HuUVZ+bpo1zftqBCFshKaNxov2hvaBhYU2wzhhkOvhy
 Wryw==
X-Gm-Message-State: AOJu0Yx+1ASXgZ4Evv3Lm5Ck6+YLq6zSHwUOb8UjBE7VveOY6P4D2/TP
 0NN2NOa6p1YOVCfH8q8Whq6F1iTmxXA3LgDv82nLb2uYSkqD4S9iE62u/dFE930E72adZ0a958y
 o1F8cujIr
X-Google-Smtp-Source: AGHT+IGNDp8Bdb0DV/gzjo3XEfOWC2g1pD28mL4wXb9+HdYgtUixmAeWA0fIQuywsey8yghYv29oTg==
X-Received: by 2002:a05:600c:5249:b0:431:6052:48c3 with SMTP id
 5b1f17b1804b1-4319acacd6amr333676035e9.16.1730802334364; 
 Tue, 05 Nov 2024 02:25:34 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e7c51sm181643845e9.25.2024.11.05.02.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 02:25:34 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Marek Vasut <marex@denx.de>,
 John Keeping <jkeeping@inmusicbrands.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] Kconfig: describe NET, NO_NET, LWIP_DEBUG and LWIP_ASSERT
Date: Tue,  5 Nov 2024 11:25:23 +0100
Message-Id: <20241105102524.10387-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Some Kconfig symbols introduced in commit 8cb330355bd5 ("net: introduce
alternative implementation as net/lwip/") need a full description. The
NET symbol needs one, too.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Kconfig          | 5 +++++
 net/lwip/Kconfig | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/Kconfig b/Kconfig
index eb55f2511d9..6305e5eaad1 100644
--- a/Kconfig
+++ b/Kconfig
@@ -765,10 +765,15 @@ choice
 
 config NO_NET
 	bool "No networking support"
+	help
+	  Do not include networking support
 
 config NET
 	bool "Legacy U-Boot networking stack"
 	imply NETDEVICES
+	help
+	  Include networking support with U-Boot's own implementation of the
+	  TCP/IP protocol stack.
 
 config NET_LWIP
 	bool "Use lwIP for networking stack"
diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
index 8a67de4cf33..5ecff9ae07f 100644
--- a/net/lwip/Kconfig
+++ b/net/lwip/Kconfig
@@ -6,9 +6,16 @@ if NET_LWIP
 
 config LWIP_DEBUG
 	bool "Enable debug traces in the lwIP library"
+	help
+	  Prints messages to the console regarding network packets that go in
+          and out of the lwIP linrary.
 
 config LWIP_ASSERT
 	bool "Enable assertions in the lwIP library"
+	help
+	  Compiles additional error checking code into the lwIP library. These
+	  checks are related to conditions that should not happen in typical
+	  use, but may be helpful to debug new features.
 
 config PROT_DHCP_LWIP
 	bool
-- 
2.40.1

