Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765B6C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B4382CE7;
	Tue, 17 Jun 2025 12:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FzWQYLRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 686E182CCE; Tue, 17 Jun 2025 12:07:47 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E4D82C87
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so3124404f8f.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154864; x=1750759664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7B1jqkU0ZB9bfTKoSuygoKRovifI7TwPxghUo+wV9U=;
 b=FzWQYLRRMsmaVN7NfJ+YYzfDLxUoWL7a/tckqApxVFKBETJ+TcZuq/+ZYo2XxqtUes
 31LMbGcy7IZZhxpbbvCbz1lF1HI+UZFL6xc59Xhhblh7pNZJTZIGYY9cBs7UT2dCbKEz
 idd7inb/quZAGwrqyFgLhUX+Y6cr9XJi/KYswyqe54i7DwRG1LoH/+7ibWpCjleh/MBT
 1pZIuJuDfTMnqD4bJ6qK9k6vrQDO7TiT1XuVGr/TdZZRokjrRkJtyyOzl4P/f0IPZRvK
 e0H4wWicXPGySJU2UTYDTVhuDTfUly+sgKzLSN/9EcdsqOwCxJuyTDdYOjUoYpf/C87a
 x8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154864; x=1750759664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7B1jqkU0ZB9bfTKoSuygoKRovifI7TwPxghUo+wV9U=;
 b=WvArWyQvCTGZGzqBi+vtnYEmWE0P94lC0CAQCHTXqju7Hr3kAam2Jj+WTXhPOwSCNC
 diKV+gMOnZZlwMq03oI/99FeeBgws6jXOAfbQ1fkK9mg2DZ/C/cWiwlR4Nc8Vgx0Bqj1
 9AaTWvFevikPitBYeS8FVh/Vt+g690nEVdJ65BNLrC7aGS74jfCutD6PO+WLnhq23E5K
 6DuVM520HaeVmmlpcHmASQexgsHDPxQmrJmNfxqXvt33uJVdvaHMcLARUVqrISTC74me
 U0+gLSayWzle2AEsKISZlmqgvl7EGXIkaYAg91s/4A8kXpIcQHxnORbz1llh2z05/DXa
 QTBw==
X-Gm-Message-State: AOJu0YxOYI5a+8EhyOLhlAaHHa0rEhCzGqqW7jpGH5BM2MwhaRFHQYIK
 5NosJUVyEJtg0MuMj96ldbL61qYUKnC8aqLbFGzYOpQdRQwt7XCGf0tIuH5eNphjbYRYPesDflj
 U8wRK
X-Gm-Gg: ASbGncuTKBrE7zzdS7TKZgSHGvXwb/zf16cSmXUSEhsBpvT9vggOAa94r2b1Ie/ylXb
 Gqg/B2MvEbIMJ0s5+tnKrV93dwazIYrQRwPMGlXZ6a+tLo10qMCsu20UeVb364Svoly/rXuKyaY
 elt1R54dyUb7PmLpAVFWa+Cb94rrOysPrbmNRq5bn0XC12c3O71KGABrDixBizAXxeVFA8M93cJ
 KrsyCtxyy+sEHm/fJYguHFme1WG8B3pwjC/glfCT+fwvAqpLdPMzbYa0fRNGNw7Z7CkdOhbQvGJ
 3C90VB8FZc0WD2nXvDA27zF1bOqsJ5a9mpY58pPzMEMwnxnVTZzG4DZPDQwcd0rMdR5VY5U=
X-Google-Smtp-Source: AGHT+IFGJvV4Jk1kTSWpd27ADYuYcGepS5w/VODFl0AVN5I81hHatwH5bDUpGFK3V50mmMqai2alng==
X-Received: by 2002:a05:6000:144e:b0:3a4:eb92:b5eb with SMTP id
 ffacd0b85a97d-3a572e998a0mr8895325f8f.50.1750154864270; 
 Tue, 17 Jun 2025 03:07:44 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:43 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
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
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 02/13] lwip: move net/lwip/dns.c to cmd/lwip
Date: Tue, 17 Jun 2025 12:03:52 +0200
Message-ID: <20250617100720.2544758-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617100720.2544758-1-jerome.forissier@linaro.org>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
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

Changes in v3:
- Move this patch before "lwip: split cmd/net-lwip.c into one file per
  command".

Changes in v2:
- New patch

 MAINTAINERS             | 1 +
 cmd/Makefile            | 2 +-
 cmd/lwip/Makefile       | 1 +
 {net => cmd}/lwip/dns.c | 0
 net/lwip/Makefile       | 1 -
 5 files changed, 3 insertions(+), 2 deletions(-)
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
index 80cf70b7fe8..102422470c2 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -133,7 +133,7 @@ obj-$(CONFIG_CMD_NAND) += nand.o
 ifdef CONFIG_NET
 obj-$(CONFIG_CMD_NET) += net.o net-common.o
 else ifdef CONFIG_NET_LWIP
-obj-$(CONFIG_CMD_NET) += net-lwip.o net-common.o
+obj-$(CONFIG_CMD_NET) += net-lwip.o net-common.o lwip/
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

