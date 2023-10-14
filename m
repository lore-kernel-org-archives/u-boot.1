Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750EBCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCB5F86F16;
	Sun, 15 Oct 2023 08:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O/SqUjeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B693869D1; Sun, 15 Oct 2023 08:00:21 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E3B886E14
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 07:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c620883559so2349269a34.0
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 22:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697349479; x=1697954279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o59Dj/4LoqreSRd8KDqmGyNYINT0BekWTO3ZzORg+Q4=;
 b=O/SqUjehM42qHZSpFW1Pv5qqibdrATbL1D62qzXJ0Q2zet/PY6xUJODrIoJ07iP2ba
 A9CRpC/OP/e93YHw0bKYYNHwR4sXpfHfCqmElp3zgJskoRxovhLZ04F4XAOk5b4t+TIz
 MEsBDq1wykZZRktug69wIiqNQU0e+Dzy5YFFwid8TMyHlcCDoYTNbtlPh9qm7Od+qfD0
 XhNmO1BsRhjwTRsHN3mbOV3SQNsZD9D/ja773Wmq4amefK9jxY1uV1974VMWmpOCiyl1
 jkZwMAMiEist1aAZaEKqT8KXGrGayn73Z9bKKOyhjRRXahbfccVv7ldA/thoNVxBb2Fv
 844g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697349479; x=1697954279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o59Dj/4LoqreSRd8KDqmGyNYINT0BekWTO3ZzORg+Q4=;
 b=WATTecwbqfnCAWbWctbBD98ZmLzIZVwwcldyEoOm/KTbXY2clW7HvWkYuVDisUQkoy
 5/N+x+FgsR7pKr1X4Yjg6ABvpSD1MggCoIjcLJ+yf3vPJYIodYTFchmZ/ErFDWvTAgxl
 LVol0Q1gS7E8pfqbjVWiIs6b7GxIZFbkOYEZYytacdAmNtS/svwAVHo45WX0Llp5EgOk
 7i06ncawSbbQnF/m0NfPODzL0SGVV2U12/W/2SPYgrPRTlmtE8Zl6c9Mv/6d0QDt+WcW
 1C2UOl6RkxU3YlLW/jsCqmJhmKauHMkSu0Fjz59x4xpJGXJmK8xtRqcAfZz/AeblcZNO
 vB3w==
X-Gm-Message-State: AOJu0YzUEZn50g7vEDHpwggrKhZYLcC8T976UlI2N2120qmLNemkkaZZ
 lEb37hIf59/O0hGDFhG3mkGkfcxDDjLcAA==
X-Google-Smtp-Source: AGHT+IGrMD26Sdsfxwl+2irl125ZUDvbqOduI5EDSHJYXRCJAF5342tbKxbpY3+7p6GPj9TtovbLZg==
X-Received: by 2002:a5b:a86:0:b0:d0a:8973:b1c with SMTP id
 h6-20020a5b0a86000000b00d0a89730b1cmr26330776ybq.12.1697316504917; 
 Sat, 14 Oct 2023 13:48:24 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 y10-20020a0ceaca000000b0066d20f29e5fsm1946088qvp.35.2023.10.14.13.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:24 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 15/29] net: Fix compiling SPL when fastboot is enabled
Date: Sat, 14 Oct 2023 16:47:51 -0400
Message-Id: <20231014204805.439009-16-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

When fastboot is enabled in U-Boot proper and SPL_NET is enabled, we will
try to (unsuccessfully) reference it in SPL. Fix these linker errors by
conditioning on SPL_UDP/TCP_FUNCTION_FASTBOOT.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Use SPL_TPL_ for compiling fastboot functions

 net/Makefile | 4 ++--
 net/net.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/Makefile b/net/Makefile
index 3e2d061338d..64ab7ec740a 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -27,8 +27,8 @@ obj-$(CONFIG_CMD_PCAP) += pcap.o
 obj-$(CONFIG_CMD_RARP) += rarp.o
 obj-$(CONFIG_CMD_SNTP) += sntp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
-obj-$(CONFIG_UDP_FUNCTION_FASTBOOT)  += fastboot_udp.o
-obj-$(CONFIG_TCP_FUNCTION_FASTBOOT)  += fastboot_tcp.o
+obj-$(CONFIG_$(SPL_TPL_)UDP_FUNCTION_FASTBOOT)  += fastboot_udp.o
+obj-$(CONFIG_$(SPL_TPL_)TCP_FUNCTION_FASTBOOT)  += fastboot_tcp.o
 obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
diff --git a/net/net.c b/net/net.c
index e6f61f0f8f6..8357f084101 100644
--- a/net/net.c
+++ b/net/net.c
@@ -511,12 +511,12 @@ restart:
 			tftp_start_server();
 			break;
 #endif
-#if defined(CONFIG_UDP_FUNCTION_FASTBOOT)
+#if CONFIG_IS_ENABLED(UDP_FUNCTION_FASTBOOT)
 		case FASTBOOT_UDP:
 			fastboot_udp_start_server();
 			break;
 #endif
-#if defined(CONFIG_TCP_FUNCTION_FASTBOOT)
+#if CONFIG_IS_ENABLED(TCP_FUNCTION_FASTBOOT)
 		case FASTBOOT_TCP:
 			fastboot_tcp_start_server();
 			break;
-- 
2.37.1

