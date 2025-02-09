Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09BEC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D50E880CB0;
	Sun,  9 Feb 2025 22:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ghhco61K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890EA80AE6; Sun,  9 Feb 2025 22:16:19 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5525680C96
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d150512bd5so4355805ab.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135775; x=1739740575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0JagJnM/xhkCIE3+yQSUEiSzSFIhgVOYXdYk4EyQNo=;
 b=Ghhco61KS3e6jqukYIAfLUpyNxjaCgDzgoOZTj9zZ1GtmjZ1ZtKkIeM315I9marePV
 5mjQFsdaWZMFlYvd0A0Og+ACc1B38Phs1BihhdXy+Gh8gadYwMQ6ipjxZ4gFfqS/gPmR
 jAb+OfsCIDdBz6cqlXJCc8Z+QIWy1hRp9hRlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135775; x=1739740575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0JagJnM/xhkCIE3+yQSUEiSzSFIhgVOYXdYk4EyQNo=;
 b=bgSw0c2CyCfqK29DBWmAMss+wcTSaN1UEFjPkAW+HU9dVBEY9RtrzqIxXqnmsb5B88
 yIw7+HekoTuK8xHju7NOzGgVRmXdCG3olACEwl0OZZdk8fWbv5nojrd4bA0Pd8Z5JnAu
 /XQjUo4tNtWItLAFFXvMmmHjTnLXUCPRxLfhAm36BPqV17s5B83ZWfiVFmsuty25dPZm
 ULpbpKAZqbxxqOFcokIV6pOwRQIlssXABCZU79K1A21NN4BEeL1TfRLb2NvXAl405Ul7
 9DnxUbxgAVnlA4tXV6I2ojCkPNJzfzobvI7EmTyjLgxUHN7eiETjomC7SGO6KgHfI/26
 3J3A==
X-Gm-Message-State: AOJu0YxdGbSU0zgMqlJZVJ6s975GkcyuHsrQLmSZQMJXJLoiPDVppHm/
 FHzb3WO6JL0J1Rmg5jy0bAlQcU5p4TER/XoI31uE2lobAnaSwhwTdIVoheLtAQIrgYXuTojbO4c
 =
X-Gm-Gg: ASbGncteFqS6r90HkMlaak7CAtlygii8jXw1ycs1AOpXsWXAkrt7XbJdQlSAZiiFsrD
 +1ZfWyZiODCEVWHWz3yuC5qwmFM8Fv1guYdHu+Vj9glRqR11rexubO3nNQWOW/UFxMMXM8pBt/n
 HAE2A4F6Ob/C4c9TvYXe+901A6aZGcHntGvT7aG/TeiCLSWKN5K0hOL/fyhUIJTzR27CJJtMynq
 N6RQtvM2gCE9AwfoNAxzcnn4iJSepT8VuNt7oVYp5qK2N1aQBPZUpbJx/koGaf7jXVQ+AiJ7GmV
 BtT47BNwQPM6NV//BcgWWmqVqglGOU/NDXW2Q42av2FG2hMiwTsb
X-Google-Smtp-Source: AGHT+IFrxmqPD1ZN8AEFV5/R4feAogB0m3vuXXvCDAQMuwXwbOncpLzV0hfYW56GicE7qTJGhM/hiw==
X-Received: by 2002:a05:6e02:12c1:b0:3d0:4e57:bbda with SMTP id
 e9e14a558f8ab-3d13dcd9080mr80573405ab.1.1739135775147; 
 Sun, 09 Feb 2025 13:16:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 21/35] rockchip: Add TPL alternatives
Date: Sun,  9 Feb 2025 14:14:42 -0700
Message-ID: <20250209211502.2299245-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

The TPL image must be built for each board we need to support. It is the
only part of the image which is board-specific.

This helps to save space and reduce the size of TPL, so that it can fit
within the internal 192K IRAM of the RK3399 SoC.

As with other phases, the TPL devicetree is run through fdtgrep to
remove unwanted nodes and properties and reduce its size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Mention RK3399 with respect to the memory limit
- Move VPL things into a separate file

 arch/arm/dts/rockchip-u-boot.dtsi     |  4 +++-
 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 9525cb9c21a..0d59aad86bf 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -202,6 +202,7 @@
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
 
+#ifndef CONFIG_VPL
 		mkimage {
 			filename = "idbloader.img";
 			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
@@ -227,7 +228,8 @@
 		u-boot-img {
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
-#endif
+#endif /* HAS_FIT */
+#endif /* VPL */
 		fdtmap {
 		};
 	};
diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index a02f44d27d2..621161f6c86 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -59,6 +59,22 @@
 	};
 
 	simple-bin {
+		alternates-fdt {
+			fdt-list-dir = "dts/upstream/src/arm64/rockchip";
+			filename-pattern = "alt-NAME.bin";
+			fdt-phase = "tpl";
+
+			mkimage {
+				filename = "idbloader.img";
+				args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+				multiple-data-files;
+
+				u-boot-tpl {
+					symbols-base = <0>;
+				};
+			};
+		};
+
 		vpl {
 			type = "fit";
 			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
-- 
2.43.0

