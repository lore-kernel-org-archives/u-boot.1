Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96039C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC03082EA9;
	Wed, 25 Jun 2025 15:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TbEQ7cDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFFF282CBC; Wed, 25 Jun 2025 15:21:40 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A1F8006D
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so58831195e9.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857689; x=1751462489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOdobLjIH1jt368VaAKJsPTL5yrMI30iorg0cjIMArA=;
 b=TbEQ7cDmofAKyCVpDt/tZM6t85WidwUCTY/fcNab104i94LQqr2nNIKgL6YdD1JBou
 092/dWcxtRYSTwY9R6gTMCSYCIREZKT27BNinyXqj4OyZcCJz23fABmY4vg6CcSJmTZF
 3/4LCnF4Fsa2ryREUoztXE/Ta7PucsFoLLDarxp6fUkyWnwFxwjrpbYRdJ64YGMpvJHZ
 6jJqOEdm1kRxYkYxaXnQiyddkE5Ewt+equ11NOhfG81BAZL4s3nTYJh7dPy0kV6iZHFc
 9d19P+oGHmtZyLn7HkzBpsBiGp3FKAP3t6jNJGg80KUr47NV4NodD2EQ9fZIIVnByPyL
 If3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857689; x=1751462489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vOdobLjIH1jt368VaAKJsPTL5yrMI30iorg0cjIMArA=;
 b=jdFDbOLcvm+GHl6fPN5fmn5jJ1aHtenvmqi0CMzc+ZwB5SLtQVpCvigcVnDkCjr7K4
 s4UiAY/rahauZvCwaGKuv+3XvJCyF2qYsclvuH33NaX8fNYSKGZNPKAEJCHVUwf36IPc
 O/BR7k135+t2tkMgYwKx68Ge4bFMU64+DvGIdXjw9pCBxHh3Tsig79++D1DPGiTzk5zQ
 0PdQEvUWVZNZcT8t/AoPb/an5wcsXccueHwXS6OuVE1g9+Fwb17ngu67vBeiNLP9nOG6
 7+lJOzldsbyTqTfzrEXCbJugkJB/EWlzd2vlrdbTzyYqheeGVHX20SuItjWhxqvPwT7w
 p25A==
X-Gm-Message-State: AOJu0YzftBgOvGVCB/m/6/nAzlZDVrbzqNWej7UX7DGdXnGgbOpzw4if
 iGIWlt5JDrQDRNotYT6dM5g1mUl3xnkbELceYXZHTctf8QU8tALSL5/AZMypbQhpaNXpBmoCwJ+
 oThxK1DM=
X-Gm-Gg: ASbGncuOoqEbNLM3xbqBm0dkX3FYbrq1VJH82rFFVtuK/5v750Yd8VGbD6rduuyS5+2
 gOArGUxWjZ0aB5bIQZq3gY4alxV0AMh846xVA0P4x3ZY/PiwQe6W6f+BotTzmsHKBUt8c1EG7LY
 wPZzt1pxUc6WryaMTpWuOVPc4PBEW+aP8Z4NbrFSUQeELKULdGqKrLcpX8WTS+I2dCAtkE17qOH
 btaWcrFezOJLhjY2s6ebcY6PhU0JYOA44mObazfejGG+xaSHHqSDvuavF9k3W6KFjZiqmdOUgXX
 clbr87qo8OYLBgITHdBw3Y/2Whp8ruI4QKHVlj0hMxHAcPSEiLSZjh6qA8S2lyUae8mbFJA=
X-Google-Smtp-Source: AGHT+IH7MKFcU9Xc5mXRVVzo/GltvIgq4OcGcpaZSgojIdJy6PFG1PyCgDIIGKMqm29xkke4yOiKdg==
X-Received: by 2002:a05:600c:4f41:b0:453:745:8534 with SMTP id
 5b1f17b1804b1-45381ab8dcamr28224275e9.12.1750857688632; 
 Wed, 25 Jun 2025 06:21:28 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:28 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v4 02/13] lwip: move net/lwip/dns.c to cmd/lwip
Date: Wed, 25 Jun 2025 15:19:10 +0200
Message-ID: <20250625132108.3292932-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625132108.3292932-1-jerome.forissier@linaro.org>
References: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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

Prepare to split the dns command from cmd/net-lwip.c by moving the
implementation from net/lwip/dns.c to cmd/lwip.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v4:
- Enter cmd/lwip/ unconditionally (do not depend on CONFIG_CMD_NET)

Changes in v3:
- Move this patch before "lwip: split cmd/net-lwip.c into one file per
  command".

Changes in v2:
- New patch

 MAINTAINERS             | 1 +
 cmd/Makefile            | 1 +
 cmd/lwip/Makefile       | 1 +
 {net => cmd}/lwip/dns.c | 0
 net/lwip/Makefile       | 1 -
 5 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 cmd/lwip/Makefile
 rename {net => cmd}/lwip/dns.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385..e8f644fc75b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1409,6 +1409,7 @@ F:	net/
 NETWORK (LWIP)
 M:	Jerome Forissier <jerome.forissier@linaro.org>
 S:	Maintained
+F:	cmd/lwip/
 F:	cmd/net-lwip.c
 F:	configs/qemu_arm64_lwip_defconfig
 F:	drivers/net/sandbox-lwip.c
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8..9c5bfc91659 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -134,6 +134,7 @@ ifdef CONFIG_NET
 obj-$(CONFIG_CMD_NET) += net.o net-common.o
 else ifdef CONFIG_NET_LWIP
 obj-$(CONFIG_CMD_NET) += net-lwip.o net-common.o
+obj-y += lwip/
 endif
 obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
new file mode 100644
index 00000000000..6c4ab58d06b
--- /dev/null
+++ b/cmd/lwip/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_CMD_DNS) += dns.o
diff --git a/net/lwip/dns.c b/cmd/lwip/dns.c
similarity index 100%
rename from net/lwip/dns.c
rename to cmd/lwip/dns.c
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 5df222589b8..255c7d018b0 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -2,7 +2,6 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
-obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
-- 
2.43.0

