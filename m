Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F82EC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD5888B23;
	Fri, 23 Aug 2024 15:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uKAqkyAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07D3788A1E; Fri, 23 Aug 2024 15:49:23 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7336288A5A
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso16366365e9.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420960; x=1725025760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALJZhM9QCzxl8KYaUtyIpLCZizsdfn1cqW7h7h5CSXA=;
 b=uKAqkyAfH55CRkHLFaZmbf8sO5oeSbm4Nsta7XrueIADPq8Mokvvjhg0DBsv/sAv3y
 khg2NYUNaI9ueksrfl5JB3m88abehGpRQB0yceD/4QCJK/0VM6ViTA8GWQjbKthUhPV8
 oJy9ANv6WC9ENx3r+XtptlrZCrilu/PPccSE1RRTGi/tD386W0ST/KEtb5agxrVXUlB7
 vIByq6UUMaaEjFS++zOBbI7ZdspmVtu5rDVMKjwB1cY3iEUBgmc/V2hZtsyj3/OxKT08
 /XVfPJ+rUxCiibE6Kl82G6oUOz3+18NlO31QMmBIxygWbMIpQJljDqk8FJ8J+pPNN1EC
 yekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420960; x=1725025760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALJZhM9QCzxl8KYaUtyIpLCZizsdfn1cqW7h7h5CSXA=;
 b=iPyfYjvnYasIHuDr13yZe0lp/lZlpeBLrnysiPL54DiowAoJx6DtX20Zi42KhuAGxh
 NMj8U3ZCSPQuHtUd7HYMshEGWW8NHLIY/5zfwPQoLe9wCKTclQ/cIIBIt0Z62iITYH0k
 HcwWeBuW7VvDtuNJMC8oIt6s9IzcUG+WsgPasF+FP3UxMXY0HG02r2uWgulIexTVDZ2i
 4HVeWrQW3jGPNfHXVyiSguhqImGWhgUJuwWJoZvlhZEGTde+M/jjeqwmADzMlwoGgfjV
 aiLNAA2zcqjrGIxIgB1D60Eo/JhSIZ9QifjZx+m3Ji9iBXa2VU40NfHRVICc8jzaaz4V
 fRmw==
X-Gm-Message-State: AOJu0YymARZHIF5kZ2kwMluup9UMQxLdgC7X5TflqA/fuALe//xY3Xll
 hfMNfopv4a9ukKq1GeXTyUXAaigyJVpNv2Rs5N7SsCrPv4tDCEXPjhPo110cPYZaOgbOBb31XgL
 9mgxfGJYJ
X-Google-Smtp-Source: AGHT+IHaF01Z8QWx+0az5zZJUUZdTxY7A5K3BQsAI73lKf5yW/O8YSm8HPNaTFzi8SmCs45wKVIhDQ==
X-Received: by 2002:a05:600c:3541:b0:426:60b8:d8ba with SMTP id
 5b1f17b1804b1-42acc9fd9demr18357455e9.28.1724420959550; 
 Fri, 23 Aug 2024 06:49:19 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:19 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, Marek Vasut <marex@denx.de>
Subject: [PATCH v9 09/37] net: wget: allow EFI boot
Date: Fri, 23 Aug 2024 15:48:13 +0200
Message-Id: <174c122a2953d503dfe1d69401ce6c618ca0e3d3.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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
index 0e4dc5159d0..cf7681a4e79 100644
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

