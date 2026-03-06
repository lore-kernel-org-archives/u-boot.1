Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD5DF513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98B284006;
	Fri,  6 Mar 2026 03:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e41jssgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E65F83F9D; Fri,  6 Mar 2026 03:37:34 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0583E83F9D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-89a05955720so63702876d6.2
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764649; x=1773369449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtcxTw+NTJB6PEl8NjxGplDGttMi7OEdepRu4VXtWr4=;
 b=e41jssgjcRDHwMs/SXFDlunnnD2laUkiN91JnzWlKwaD+OigCQ2Imdk/4Jq3CE6vGH
 voEHsBwNq/lv3XLHrvZwAABQKIv2zs5QK2+nch/nXtuDLQ4/T541OtfBCmd4TIP8FcTo
 2Zvd1JTZROppibPuBQUv2PopBdzC3SvfUKAqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764649; x=1773369449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vtcxTw+NTJB6PEl8NjxGplDGttMi7OEdepRu4VXtWr4=;
 b=SFrPcsIo1K4Bp8wFUxJ1R8qFgDyWkXSSN13bMSddBs/W1a5KEaRhhIknAG5oKX+CBd
 lqWGHRKpMcch3ZqpXg1SQ56SnfQLbJbVNe7JOPTElSx3vhgI7+sJ3tszhtTbhwd09qly
 VJlNACzyqobTz2vGCtt1UVo+1wxps8lMOvKZ5hzQJkbi0FvC8mDSfYsE0JA42SsaxmQO
 WXRzJ9Ms4cmSSQrbuPb+xM6HAMqunFNUvQwtu9R0HuRsR67kqq+Y58Y/0RSXQu6svBMJ
 vK3iP0z4IV1+oSIOeSMbPWf4wcvX7LrTRsR0wYFD4wYThLFn1wT8UFG15y7NN+FTwrL9
 AYDw==
X-Gm-Message-State: AOJu0Yyr/FVM5e0oLCQI+JHvYhUkvs00xSGPZryJHyzraSAdeYpvH0qF
 niYVybBT6waFzLuBMa7eGZinnaB/Z6rTsOiNEf5xhOjOFcW6YUIHJP6pEkLk6vNHhBxKXQhpN9r
 Cq6o=
X-Gm-Gg: ATEYQzxqNDONpfvapUXKhb1hX5Zuw95RNjGThiuJAvelvDf5Vd20Kqvj1GsOH/7LYmr
 6VknHPq7lXtzp0URA0XWZUj3U2Bq3YOobD5L9UNsNy5ONpetCpwrgEzqhP8bRpXfbWy8LLp+Bfz
 GUG6u/mLkFOIE/p/6s93zp/Ic/P6Tl4KR49u51uoU+gF6PUdthUrgJShhns+6Eo0xxTn40yoQHm
 ox1eCirO0vUECUxiVkxhmL4n7jZ6riDINw2FEJuhfZDni//Cm1e9PGEsIj11ZKc0z4Dpk/ha0Zc
 NN3+dNvXT5FIopeH9fSx5AnwJsB7bANNGX8HBhmZnzVIAPSL4uT5Td+pSeGfcivxCsurSoYnAcj
 o8794lhnyLPTkDirBOCFqSq2I0X0TUPw3czG652PYBtkFoQGYZoeVSu3CId7Yww3vVv1xN1lcLY
 N0Mgqwv1wjBDJoKGe+og==
X-Received: by 2002:ad4:5d4a:0:b0:896:ff71:fc70 with SMTP id
 6a1803df08f44-89a30aa012amr6753036d6.32.1772764649564; 
 Thu, 05 Mar 2026 18:37:29 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 16/17] xtensa: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:25 -0700
Message-ID: <20260306023638.2678886-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Add a call to bootm_final() before jumping to the kernel. This adds
the "Starting kernel" message, bootstage tracking,
board_quiesce_devices() and dm_remove_devices_active() which were not
previously called on Xtensa.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v4:
- Pass flag directly instead of using BOOTM_FINAL_FAKE

Changes in v3:
- Add new patch for Xtensa conversion

 arch/xtensa/lib/bootm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/lib/bootm.c b/arch/xtensa/lib/bootm.c
index 2958f207397..c19ac9d1f9a 100644
--- a/arch/xtensa/lib/bootm.c
+++ b/arch/xtensa/lib/bootm.c
@@ -178,6 +178,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	printf("Transferring Control to Linux @0x%08lx ...\n\n",
 	       (ulong)images->ep);
 
+	bootm_final(flag);
+
 	flush_dcache_range((unsigned long)params_start, (unsigned long)params);
 
 	if (flag & BOOTM_STATE_OS_FAKE_GO)
-- 
2.43.0

