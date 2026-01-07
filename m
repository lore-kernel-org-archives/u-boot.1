Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C87CF6BE1
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC3384062;
	Wed,  7 Jan 2026 01:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QnIUIjSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5379884067; Wed,  7 Jan 2026 01:32:53 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CE1F84062
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c75fc222c3so846569a34.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745969; x=1768350769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxtPUljqYicGjIVo9PSbaZcpEgfPJVOFIsDfmIU+9Oc=;
 b=QnIUIjSl67/1xz8/w44qAcU3vZT0rauDH9gxkC3zBqwZhOz2FcXQ/d8WQVcdpuv/Hr
 C4Kz9WSmADYY4r721mc6WEto1C523iQZ0goswHLpTD8g7gyO7EF8pqhQII1jkfM7S9Li
 Tw8jW78QuP80QCVJAE0gPwEJAm3kQFdaKbG84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745969; x=1768350769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dxtPUljqYicGjIVo9PSbaZcpEgfPJVOFIsDfmIU+9Oc=;
 b=Dqi+IPmgUBLn9I7VKeDh8Hpbho4xPMeV7/EkV3wBf9CB5rOkBs4YpZ0E+SWiKgqnXp
 CIBUcMS2TrXWqSafMBuXY+cEdFgzdW4DbOzOeRE1ncokLc/Pv//iyqQGITRZVrCWC+yg
 +ictLXn5/LTuouBZKIqUxtkcCF0T/3CI9s+4jGseWZFXN062uJHwobYuDBEG9KMDx6Pf
 uKAMKf2xP7z/rMrBURJIxxnowy6JEmi0zfp41Ki4teejIXd5dHCLdP6Ze7elu8+CUejf
 XCkFJ6M1YqAEW4S7xBt77m3aMiIVWMk+7q1LHDSgMu1kBA5CPndDOPPBd22G+kmwd4nm
 zDhw==
X-Gm-Message-State: AOJu0Yw7btW0gbdpoPZFNB14QiIpx1P6zaNoVoeBto7VSdBxyu7Qzkmw
 VOWpJHh7SeRJK6SvQniV082MnhbBJ5a4roinlndQ5KINgtkM4XsGnRxxHRCkfCj7yqTi188ISru
 J9U4=
X-Gm-Gg: AY/fxX5pYx2sZwjlbPua5BEanwBxVgM4MzxctPvi23WqCgruMe+1fDnKATCr3b3CwNr
 R0FFkLr/tFp9rtF8IfpY3IZP+o2au8eBnVK0qI1/wrp0RNl38t26VV4aG1HVKZYPE4ikOha1fMm
 v7AaKAPVkXSds6SC8Fy7HKIie/DjQ1fdP7bRGvOTWVrFYP6cByITJW6t3Nq0Qi3h3/paRaVT02e
 337e2LFLAwdEQc7mjPAHtDUxqCUsKxQL4saYsPPit4dbuMileKUNUbx35wgkt1N1dwzUyICEIK3
 Dgo1EeUSLKKfhQbwWOMRqSckb93btomcvU34xC1dean2EeE0PxeqCAhr+mLpCeZ9qradGBd368Q
 sPVqPXj77eo6kwq3QqjxQ+N0WVwUD4kNnFJjLxRYyrqzQc6ho8aT4uvnT4xpb2JhZ3jkRMGo448
 cX+nbGnkUhf7xFzB0v
X-Google-Smtp-Source: AGHT+IGkISRB2LMHO/VLry/fQtfKd328RXpsFW4YBy4NfwNJfxE3wgiDyeRUHT5n2XKucLNxE2Phsg==
X-Received: by 2002:a05:6820:8317:b0:65c:fe5e:b96d with SMTP id
 006d021491bc7-65f54f7b4c7mr183387eaf.66.1767745969376; 
 Tue, 06 Jan 2026 16:32:49 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Simon Glass <simon.glass@canonical.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 10/10] x86: Add cleanup_before_linux()
Date: Tue,  6 Jan 2026 17:31:27 -0700
Message-ID: <20260107003131.3064800-11-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107003131.3064800-1-simon.glass@canonical.com>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
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

From: Simon Glass <sjg@chromium.org>

This function is not present on x86, but there is an x86-specific
version which is never called. Add the former, making it call the
latter.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 arch/x86/cpu/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index c373b14df30..f756a9ebf09 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -80,6 +80,11 @@ int __weak x86_cleanup_before_linux(void)
 	return 0;
 }
 
+int cleanup_before_linux(void)
+{
+	return x86_cleanup_before_linux();
+}
+
 int x86_init_cache(void)
 {
 	enable_caches();
-- 
2.43.0

