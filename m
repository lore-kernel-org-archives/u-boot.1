Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EF8C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 07:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 688828141D;
	Tue, 11 Mar 2025 08:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJFSAJ5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3C68168B; Tue, 11 Mar 2025 08:35:02 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D017A811C1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 08:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-549963b5551so3830132e87.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 00:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741678499; x=1742283299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSIfUBGKLkWiLaFTDbO6UT221ycRY7CcUyVAA3D3VLw=;
 b=AJFSAJ5SWAin2ECfWNy9s8EQcnHI3nU+3Dbhh6VsxTKWY8Vb0h0Hu/POIQcgsz9j9q
 cFi3UlkBLd93jMfa4L+uYzpTfueJafg137syrKx7pTekuNJaPHknYB5APUh4nKFESs+T
 P2ZJWmNDYwE5E+87///ozSnanbOhyJIB1KENB7j9x3ZZL8ySgosf/1QcvAkvMcncHyUg
 1Cj2gbRfnNCQqAqqLSu13z2oXqGNeHI3N0rGqg7xwEUvHJb9TCw9Fy+lhp36BV+IZW0l
 TnlnFIxqUGJg+u9qn7ShZpz/XKxKfhU2lI6iNDmO5x1dz3w/CRKMawogxievQ/CpFZix
 HTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741678499; x=1742283299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSIfUBGKLkWiLaFTDbO6UT221ycRY7CcUyVAA3D3VLw=;
 b=LuATIjArqj9jxZN1SMFxPyTy17gx7YOPNM3nZCQNdPTB54vPPLfLQ+a4EZ6iAfUC+p
 voK52XQuMHNmXJivKAhQo66Tbz/D62F26/Qkt1hbiHnD4dyA10CIV6G3URjjuGamrCtB
 vsJRShzRH0hwn5W/zqMRHfHKMannsInl8GiM0ApNp1lPJKeI4fvLM924eCtDHEFU3Xpf
 +2jQzzvJE0ZbeuMrhyD7UzmMyxuASx2AjIKWyAWnJVNFMjnwHGbpoD1P0T/BSu0ZVqJP
 ri30VLTCoAY2bioh/63PjZX5ajBVWzTmhGYuNNz1n5NDRwMTz/YJRDUeVUMrvyzYIoQw
 xl6w==
X-Gm-Message-State: AOJu0YwF04skQtIkyuYj0cY/xouZoSHoMNql1o3mPPup5tEX53+eApV3
 cYQe7HGtUNXKzylQlk0R9MkPnYCYn6c8UX9l8peaCRj6FooM7iW7yx3yBQ==
X-Gm-Gg: ASbGnctqaCGuKBYx8Uo4/EhhjqOM4i8rot75Kf+3CLX2iWP6VSGrFzzFc2YMdR9xwuE
 2CutHl0FQ0fSqW/+IyUS+94IXE8kTYCNAEPJvUou+7y7dCYSyKybGd5RHJUv4c0Av4eyy5nYjEw
 avDhHeL+K35lXBlLnyGlH+TyTkhX4XN1SK7beuo0nMVGiaWMXTCPiPOBQLeyPygU8phXkpJ+dT4
 iuMXJlPDfUmablXJ7jPnEUBqyWicvsMfHhHCGfKrjPLOxskrcicYJQx/i+cYG6sqmc8OYz9vgJc
 E4BVlD62r2x354leZb0WM5XHVRySpzKxNLhk
X-Google-Smtp-Source: AGHT+IFYWDWyhTHYdpJeQ8HeP5DKnFhZrNRx3qM6cAb9c7idXx9WEvzbUS6y/nSVt2wzA6yK4XZvQQ==
X-Received: by 2002:a05:6512:281e:b0:544:ffbe:cd22 with SMTP id
 2adb3069b0e04-549abaed4cemr783162e87.46.1741678498637; 
 Tue, 11 Mar 2025 00:34:58 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5498b0bd196sm1676430e87.113.2025.03.11.00.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 00:34:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] common: edid: update timing selection logic
Date: Tue, 11 Mar 2025 09:34:38 +0200
Message-ID: <20250311073438.13428-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311073438.13428-1-clamor95@gmail.com>
References: <20250311073438.13428-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

Older EDID timing algorithms relied solely on detailed timings, typically
optimized for a display's native resolution. This caused issues with newer
4K panels on older hardware, which couldn't handle those high resolutions.
To address this, the algorithm now also considers standard timings, offering
lower, compatible resolutions. Future improvements may include checking
established timings for even broader compatibility.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 common/edid.c | 308 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 273 insertions(+), 35 deletions(-)

diff --git a/common/edid.c b/common/edid.c
index 48a737690db..e2ac7100a88 100644
--- a/common/edid.c
+++ b/common/edid.c
@@ -16,6 +16,197 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 
+#define TIMING(c, ha, hfp, hbp, hsl, va, vfp, vbp, vsl, f)	\
+	.pixelclock = { (c), (c), (c) },			\
+	.hactive = { (ha), (ha), (ha) },			\
+	.hfront_porch = { (hfp), (hfp), (hfp) },		\
+	.hback_porch = { (hbp), (hbp), (hbp) },			\
+	.hsync_len = { (hsl), (hsl), (hsl) },			\
+	.vactive = { (va), (va), (va) },			\
+	.vfront_porch = { (vfp), (vfp), (vfp) },		\
+	.vback_porch = { (vbp), (vbp), (vbp) },			\
+	.vsync_len = { (vsl), (vsl), (vsl) },			\
+	.flags = (f)
+
+static const struct display_timing dmt_timings[] = {
+	{ TIMING(31500000, 640, 32, 64, 96, 350, 32, 3, 60,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(31500000, 640, 32, 64, 96, 400, 1, 3, 41,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(35500000, 720, 36, 72, 108, 400, 1, 3, 42,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(25175000, 640, 16, 96, 48, 480, 10, 2, 33,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(31500000, 640, 24, 40, 128, 480, 9, 3, 28,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(31500000, 640, 16, 64, 120, 480, 1, 3, 16,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(36000000, 640, 56, 56, 80, 480, 1, 3, 25,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(36000000, 800, 24, 72, 128, 600, 1, 2, 22,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(40000000, 800, 40, 128, 88, 600, 1, 4, 23,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(50000000, 800, 56, 120, 64, 600, 37, 6, 23,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(49500000, 800, 16, 80, 160, 600, 1, 3, 21,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(56250000, 800, 32, 64, 152, 600, 1, 3, 27,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(73250000, 800, 48, 32, 80, 600, 3, 4, 29,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(33750000, 848, 16, 112, 112, 480, 6, 8, 23,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(44900000, 1024, 8, 176, 56, 768, 0, 8, 41,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(65000000, 1024, 24, 136, 160, 768, 3, 6, 29,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(75000000, 1024, 24, 136, 144, 768, 3, 6, 29,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(78750000, 1024, 16, 96, 176, 768, 1, 3, 28,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(94500000, 1024, 48, 96, 208, 768, 1, 3, 36,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(115500000, 1024, 48, 32, 80, 768, 3, 4, 38,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(108000000, 1152, 64, 128, 256, 864, 1, 3, 32,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(74250000, 1280, 110, 40, 220, 720, 5, 5, 20,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(68250000, 1280, 48, 32, 80, 768, 3, 7, 12,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(79500000, 1280, 64, 128, 192, 768, 3, 7, 20,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(102250000, 1280, 80, 128, 208, 768, 3, 7, 27,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(117500000, 1280, 80, 136, 216, 768, 3, 7, 31,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(140250000, 1280, 48, 32, 80, 768, 3, 7, 35,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(71000000, 1280, 48, 32, 80, 800, 3, 6, 14,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(83500000, 1280, 72, 128, 200, 800, 3, 6, 22,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(106500000, 1280, 80, 128, 208, 800, 3, 6, 29,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(122500000, 1280, 80, 136, 216, 800, 3, 6, 34,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(146250000, 1280, 48, 32, 80, 800, 3, 6, 38,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(108000000, 1280, 96, 112, 312, 960, 1, 3, 36,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(148500000, 1280, 64, 160, 224, 960, 1, 3, 47,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(175500000, 1280, 48, 32, 80, 960, 3, 4, 50,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(108000000, 1280, 48, 112, 248, 1024, 1, 3, 38,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(135000000, 1280, 16, 144, 248, 1024, 1, 3, 38,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(157500000, 1280, 64, 160, 224, 1024, 1, 3, 44,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(187250000, 1280, 48, 32, 80, 1024, 3, 7, 50,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(85500000, 1360, 64, 112, 256, 768, 3, 6, 18,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(148250000, 1360, 48, 32, 80, 768, 3, 5, 37,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(85500000, 1366, 70, 143, 213, 768, 3, 3, 24,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(72000000, 1366, 14, 56, 64, 768, 1, 3, 28,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(101000000, 1400, 48, 32, 80, 1050, 3, 4, 23,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(121750000, 1400, 88, 144, 232, 1050, 3, 4, 32,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(156000000, 1400, 104, 144, 248, 1050, 3, 4, 42,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(179500000, 1400, 104, 152, 256, 1050, 3, 4, 48,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(208000000, 1400, 48, 32, 80, 1050, 3, 4, 55,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(88750000, 1440, 48, 32, 80, 900, 3, 6, 17,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(106500000, 1440, 80, 152, 232, 900, 3, 6, 25,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(136750000, 1440, 96, 152, 248, 900, 3, 6, 33,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(157000000, 1440, 104, 152, 256, 900, 3, 6, 39,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(182750000, 1440, 48, 32, 80, 900, 3, 6, 44,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(108000000, 1600, 24, 80, 96, 900, 1, 3, 96,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(162000000, 1600, 64, 192, 304, 1200, 1, 3, 46,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(175500000, 1600, 64, 192, 304, 1200, 1, 3, 46,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(189000000, 1600, 64, 192, 304, 1200, 1, 3, 46,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(202500000, 1600, 64, 192, 304, 1200, 1, 3, 46,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(229500000, 1600, 64, 192, 304, 1200, 1, 3, 46,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(268250000, 1600, 48, 32, 80, 1200, 3, 4, 64,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(119000000, 1680, 48, 32, 80, 1050, 3, 6, 21,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(146250000, 1680, 104, 176, 280, 1050, 3, 6, 30,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(187000000, 1680, 120, 176, 296, 1050, 3, 6, 40,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(214750000, 1680, 128, 176, 304, 1050, 3, 6, 46,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(245500000, 1680, 48, 32, 80, 1050, 3, 6, 53,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(204750000, 1792, 128, 200, 328, 1344, 1, 3, 46,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(261000000, 1792, 96, 216, 352, 1344, 1, 3, 69,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(333250000, 1792, 48, 32, 80, 1344, 3, 4, 72,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(218250000, 1856, 96, 224, 352, 1392, 1, 3, 43,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(288000000, 1856, 128, 224, 352, 1392, 1, 3, 104,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(356500000, 1856, 48, 32, 80, 1392, 3, 4, 75,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(148500000, 1920, 88, 44, 148, 1080, 4, 5, 36,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(154000000, 1920, 48, 32, 80, 1200, 3, 6, 26,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(193250000, 1920, 136, 200, 336, 1200, 3, 6, 36,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(245250000, 1920, 136, 208, 344, 1200, 3, 6, 46,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(281250000, 1920, 144, 208, 352, 1200, 3, 6, 53,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(317000000, 1920, 48, 32, 80, 1200, 3, 6, 62,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(234000000, 1920, 128, 208, 344, 1440, 1, 3, 56,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(297000000, 1920, 144, 224, 352, 1440, 1, 3, 56,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(380500000, 1920, 48, 32, 80, 1440, 3, 4, 78,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(162000000, 2048, 26, 80, 96, 1152, 1, 3, 44,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(268500000, 2560, 48, 32, 80, 1600, 3, 6, 37,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(348500000, 2560, 192, 280, 472, 1600, 3, 6, 49,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(443250000, 2560, 208, 280, 488, 1600, 3, 6, 63,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(505250000, 2560, 208, 280, 488, 1600, 3, 6, 73,
+		 DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_HIGH) },
+	{ TIMING(552750000, 2560, 48, 32, 80, 1600, 3, 6, 85,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(556744000, 4096, 8, 32, 40, 2160, 48, 8, 6,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+	{ TIMING(556188000, 4096, 8, 32, 40, 2160, 48, 8, 6,
+		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
+};
+
 int edid_check_info(struct edid1_info *edid_info)
 {
 	if ((edid_info == NULL) || (edid_info->version == 0))
@@ -168,11 +359,11 @@ static bool cea_is_hdmi_vsdb_present(struct edid_cea861_info *info)
 	return false;
 }
 
-static bool edid_find_valid_timing(void *buf, int count,
-				   struct display_timing *timing,
-				   bool (*mode_valid)(void *priv,
-					const struct display_timing *timing),
-				   void *mode_valid_priv)
+static bool edid_find_valid_detailed_timing(void *buf, int count,
+					    struct display_timing *timing,
+					    bool (*mode_valid)(void *priv,
+						const struct display_timing *timing),
+					    void *mode_valid_priv)
 {
 	struct edid_detailed_timing *t = buf;
 	bool found = false;
@@ -191,6 +382,71 @@ static bool edid_find_valid_timing(void *buf, int count,
 	return found;
 }
 
+static bool edid_get_standard_timing(struct edid1_info *edid, int i, unsigned int *x,
+				     unsigned int *y, unsigned int *freq)
+{
+	unsigned int aspect = 10000;
+	unsigned char xres, vfreq;
+
+	xres = EDID1_INFO_STANDARD_TIMING_XRESOLUTION(*edid, i);
+	vfreq = EDID1_INFO_STANDARD_TIMING_VFREQ(*edid, i);
+	if (xres != vfreq || (xres != 0 && xres != 1) ||
+	    (vfreq != 0 && vfreq != 1)) {
+		switch (EDID1_INFO_STANDARD_TIMING_ASPECT(*edid, i)) {
+		case ASPECT_625: // 16:10
+			aspect = 6250;
+			break;
+		case ASPECT_75: // 4:3
+			aspect = 7500;
+			break;
+		case ASPECT_8: // 5:4
+			aspect = 8000;
+			break;
+		case ASPECT_5625: // 16:9
+			aspect = 5625;
+			break;
+		}
+
+		*x = (xres + 31) * 8;
+		*y = *x * aspect / 10000;
+		*freq = (vfreq & 0x3f) + 60;
+
+		return true;
+	}
+
+	return false;
+}
+
+static bool edid_find_valid_standard_timing(struct edid1_info *buf,
+					    struct display_timing *timing,
+					    bool (*mode_valid)(void *priv,
+						const struct display_timing *timing),
+					    void *mode_valid_priv)
+{
+	unsigned int x, y, freq;
+	bool found = false;
+	int i, k;
+
+	for (i = 0; i < ARRAY_SIZE(buf->standard_timings); i++) {
+		if (!edid_get_standard_timing(buf, i, &x, &y, &freq))
+			continue;
+
+		for (k = 0; k < ARRAY_SIZE(dmt_timings); k++) {
+			const struct display_timing *dt = &dmt_timings[k];
+
+			if (dt->hactive.typ == x && dt->vactive.typ == y) {
+				found = mode_valid(mode_valid_priv, dt);
+				if (found) {
+					memcpy(timing, dt, sizeof(*timing));
+					return true;
+				}
+			}
+		}
+	}
+
+	return found;
+}
+
 int edid_get_timing_validate(u8 *buf, int buf_size,
 			     struct display_timing *timing,
 			     int *panel_bits_per_colourp,
@@ -217,8 +473,8 @@ int edid_get_timing_validate(u8 *buf, int buf_size,
 	}
 
 	/* Look for detailed timing in base EDID */
-	found = edid_find_valid_timing(edid->monitor_details.descriptor, 4,
-				       timing, mode_valid, mode_valid_priv);
+	found = edid_find_valid_detailed_timing(edid->monitor_details.descriptor, 4,
+						timing, mode_valid, mode_valid_priv);
 
 	/* Look for detailed timing in CTA-861 Extension Block */
 	if (!found && edid->extension_flag && buf_size >= EDID_EXT_SIZE) {
@@ -231,12 +487,17 @@ int edid_get_timing_validate(u8 *buf, int buf_size,
 			int size = count * sizeof(struct edid_detailed_timing);
 
 			if (offset >= 4 && offset + size < EDID_SIZE)
-				found = edid_find_valid_timing(
+				found = edid_find_valid_detailed_timing(
 					(u8 *)info + offset, count, timing,
 					mode_valid, mode_valid_priv);
 		}
 	}
 
+	/* Look for timing in Standard Timings */
+	if (!found)
+		found = edid_find_valid_standard_timing(edid, timing, mode_valid,
+							mode_valid_priv);
+
 	if (!found)
 		return -EINVAL;
 
@@ -461,34 +722,11 @@ void edid_print_info(struct edid1_info *edid_info)
 	/* Standard timings. */
 	printf("Standard timings:\n");
 	for (i = 0; i < ARRAY_SIZE(edid_info->standard_timings); i++) {
-		unsigned int aspect = 10000;
-		unsigned int x, y;
-		unsigned char xres, vfreq;
-
-		xres = EDID1_INFO_STANDARD_TIMING_XRESOLUTION(*edid_info, i);
-		vfreq = EDID1_INFO_STANDARD_TIMING_VFREQ(*edid_info, i);
-		if ((xres != vfreq) ||
-		    ((xres != 0) && (xres != 1)) ||
-		    ((vfreq != 0) && (vfreq != 1))) {
-			switch (EDID1_INFO_STANDARD_TIMING_ASPECT(*edid_info,
-					i)) {
-			case ASPECT_625:
-				aspect = 6250;
-				break;
-			case ASPECT_75:
-				aspect = 7500;
-				break;
-			case ASPECT_8:
-				aspect = 8000;
-				break;
-			case ASPECT_5625:
-				aspect = 5625;
-				break;
-			}
-			x = (xres + 31) * 8;
-			y = x * aspect / 10000;
+		unsigned int x, y, freq;
+
+		if (edid_get_standard_timing(edid_info, i, &x, &y, &freq)) {
 			printf("\t%dx%d%c\t%d Hz\n", x, y,
-			       x > 1000 ? ' ' : '\t', (vfreq & 0x3f) + 60);
+			       x > 1000 ? ' ' : '\t', freq);
 			have_timing = 1;
 		}
 	}
-- 
2.43.0

