Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBBEC54F32
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208D988B36;
	Wed, 28 Aug 2024 14:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iacbgOWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F5C88AD2; Wed, 28 Aug 2024 14:10:54 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0E788B1A
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso58310855e9.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847051; x=1725451851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJ3uAhukXyjblHix2uS6OBS4D6wbbgyXFHfq96WdFX4=;
 b=iacbgOWhLhoITLdTb+vroMv4MtaCbI5yWuA5z7gg6bywOZXA6tj5X1q8IBgwITvhDp
 7x56bf1mBMASBoDp9xZ72AXIicmyZoZ19+X/VPnj2gXmrYWVD+qto913FitcucH2pPNO
 kxSCYox3ZWiNNH1RmxoY1ZY1ngGBPY15yMA7AHCIpbs8ASiYKLRLr7emy1C5MpEnthRz
 0kCIf9DqT1FtUO+MLrgTJyV0zarqjUvlE4oXgz94hVt3xSG0aJLNNOgFRkCuDhnbROmi
 +D8i68v31fQXJgGVUPLLRtMurcjp2YlSHu4v2UFvUkQwwa6zRC84RHqYzb3tcHyL/kam
 5emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847051; x=1725451851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJ3uAhukXyjblHix2uS6OBS4D6wbbgyXFHfq96WdFX4=;
 b=N+o61Ztn3Bz7iNkuCJDsY5pTvGgjsekkujygSsICmJuJgJMCeyP7T6fgMosSjHv9ec
 aw88xtTLvRiprLETEE3tVasXC/1qZKsj7F53C6GPHZNHPZ7HAd6Je5VgGQCjj05UcpvS
 Tg5NRR0edvsRTBhNYQKT+i0wOhLLPATFYdaUgjhfGv9Qjmalsi0vV5HojC5+GJ0wfK6K
 nO9u7lNwDX6hibQGvoXiijHRPdoBA9uvYgqYASCfSvlUvmhL8tz+EFjOFB0cYU69zVx4
 dQKZN5YtpinXJ9uHpQ/LjNFNJ7khwVlhCiC93vlm6Hz33TJynxPZW/ghk3wkHg+bqGon
 6UxQ==
X-Gm-Message-State: AOJu0YyZjNmwDASKl7fguqQvGm8DbmwsymM0wAP4aVaz3+70MqIQRTCk
 KHKGoutae9UDHjrRmIhMnagWyHw/cyTa/gp5TYTzVmJQlQpsn6H0F8G3cOOSdJj8Wd+RJ8Yn7ec
 Btq4IkzvI
X-Google-Smtp-Source: AGHT+IEwaT0JLiqueVYy3PUSehjBX0ql7tWSlv0HEGGnIsT28zBASwCk3Ti+OmcMHziX1t9uDJMwrg==
X-Received: by 2002:a05:600c:3d07:b0:42a:b62c:8c86 with SMTP id
 5b1f17b1804b1-42acc9fe221mr121836105e9.32.1724847050711; 
 Wed, 28 Aug 2024 05:10:50 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:50 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH 09/13] net: wget: allow EFI boot
Date: Wed, 28 Aug 2024 14:10:32 +0200
Message-Id: <1a6084e845a0612546a1e86d142208af945c8f77.1724846454.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724846454.git.jerome.forissier@linaro.org>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
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

wget followed by bootefi currently fails as follows:

 U-Boot> wget 200000 192.168.0.30:helloworld.efi
 Waiting for Ethernet connection... done.
 HTTP/1.0 200 OK
 Packets received 13, Transfer Successful
 Bytes transferred = 12720 (31b0 hex)
 U-Boot> bootefi 200000
 No UEFI binary known at 200000
 U-Boot>

Fix the problem by adding the missing efi_set_bootdev() call.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/wget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wget.c b/net/wget.c
index 0e4dc5159d..cf7681a4e7 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <display_options.h>
 #include <env.h>
+#include <efi_loader.h>
 #include <image.h>
 #include <lmb.h>
 #include <mapmem.h>
@@ -429,6 +430,9 @@ static void wget_handler(uchar *pkt, u16 dport,
 	case WGET_TRANSFERRED:
 		printf("Packets received %d, Transfer Successful\n", packets);
 		net_set_state(wget_loop_state);
+		efi_set_bootdev("Net", "", image_url,
+				map_sysmem(image_load_addr, 0),
+				net_boot_file_size);
 		break;
 	}
 }
-- 
2.40.1

