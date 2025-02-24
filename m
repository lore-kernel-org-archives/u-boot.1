Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E592C021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1412C80FC8;
	Tue, 25 Feb 2025 00:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jGaYAt00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7147181191; Tue, 25 Feb 2025 00:07:53 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B81C811D8
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-855923e7f53so355279339f.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438469; x=1741043269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lqKCB3bocG1y783ZzPSYbJDlxMLcnEDjLka3Bh8Tx8=;
 b=jGaYAt00XTT/ahyRwIQChwqaeBWbjqI9TGe9QKs1DuZqswN47ZJIfhfknV/uGoqxe0
 +SXCLyx4CkubTsn9twvYM7WCG0BzGeHaNDNrb6WikeNDJeUzKuBRT9mHz9MrMId5r0mu
 sPwOskf5Ivt81zzHxjXpdPmU6TSnOLymLmKkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438469; x=1741043269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4lqKCB3bocG1y783ZzPSYbJDlxMLcnEDjLka3Bh8Tx8=;
 b=kPKgJP8zu/cvLCgjI5xsZCxlAjjsnDJKAQkvx7jB6Y9+maCrlvB0bHJY0IzzQckrJy
 JixwcGMxAIiiH3Yh4ELnyzu11dng/wZE+bOsIzGEg8vOUFXD/XaT54+06XJKnOfCzxXz
 uF4J8XyxKib0cCsBsv54tXyXIIjydiFRzs3WXo7dYdRa+wgylnoVXEzOJH8Y0xd92b+l
 /OyS+mGiEaQXC3vxGIWjl3PCiFhMQi5L94w+vlxEWWarE9vv3KuvKfLludL/mYgOEFvt
 fdGBG/HLKYPH+cfy0npMgKXVT26Evv73j613fNSb/+0Vo4v5Dsyy38DPwhPB3b6UnWLG
 Zhew==
X-Gm-Message-State: AOJu0YyDp2wD8+ETan4HVkrNpgBt1cEcQNDoh+js9JZxL/pT2SpEyTn7
 VhFv6ONfxDQjNn2H8htDrb4OE+/pyKrNxhPfCYAExwNAvXTXEi20PAsfnYwXROjiippjOQ8HRFI
 =
X-Gm-Gg: ASbGncsi6C8gubXS65PrpdyJ/ZbAULUdZWQm/L7OnGY1yOnDvnAtzMyPKL6SzrY3B8+
 batyuVKFfrD8eDiRyUIjIvj31b56tYFFQxQHc9nzjCosoVcPM1rY9gJLC1iDBvd8JMinjEHbEbg
 gM1jMXZhSkG3PAPE39WNwLy6fM0Vf3E1C6HO0coL45/HITRhIprsBfFW/TfCHZmWtqWMXg09CHk
 AzV6YYA/gSd317Tebsax7Lyiit5J6KmXEl5nq3r9tX1icexTec2UJPKLWuyfH7XvkV2hFbM2UTr
 B3IJwq4gbR+1YdpBCnl28MdOoiHDtxCGsqoobySlhuZVKy3FLTrcu+VQ6HhZP04=
X-Google-Smtp-Source: AGHT+IE/Ehfo+EbU6N418cOhGt3LjxTiSf0Jx3VJU5NZMWBkXwrC+Y86Fd7/x97R9v9y2Ord1BpDtQ==
X-Received: by 2002:a05:6602:158a:b0:855:d60d:1103 with SMTP id
 ca18e2360f4ac-856203c5856mr134645139f.13.1740438469498; 
 Mon, 24 Feb 2025 15:07:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 25/44] x86: emulation: Set an MTRR for the RAM
Date: Mon, 24 Feb 2025 16:06:14 -0700
Message-ID: <20250224230640.2665206-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

QEMU likes to have an MTRR set up, just like real machines. Add an MTRR
which covers the total RAM size.

This does nothing on machines without MTRRs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Support memory sizes above 3GB properly

Changes in v2:
- Add new patch to set an MTRR for the RAM in QEMU

 arch/x86/cpu/qemu/dram.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/cpu/qemu/dram.c b/arch/x86/cpu/qemu/dram.c
index 62a301c0fd3..ba3638e6acc 100644
--- a/arch/x86/cpu/qemu/dram.c
+++ b/arch/x86/cpu/qemu/dram.c
@@ -4,7 +4,9 @@
  */
 
 #include <init.h>
+#include <spl.h>
 #include <asm/global_data.h>
+#include <asm/mtrr.h>
 #include <asm/post.h>
 #include <asm/arch/qemu.h>
 #include <linux/sizes.h>
@@ -44,6 +46,22 @@ int dram_init(void)
 	gd->ram_size += qemu_get_high_memory_size();
 	post_code(POST_DRAM);
 
+	if (xpl_phase() == PHASE_BOARD_F) {
+		u64 total = gd->ram_size;
+		int ret;
+
+		if (total > SZ_2G + SZ_1G)
+			total += SZ_1G;
+		ret = mtrr_add_request(MTRR_TYPE_WRBACK, 0, total);
+		if (ret != -ENOSYS) {
+			if (ret)
+				return log_msg_ret("mta", ret);
+			ret = mtrr_commit(false);
+			if (ret)
+				return log_msg_ret("mtc", ret);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.0

