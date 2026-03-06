Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6A5F513E9
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 405068401F;
	Fri,  6 Mar 2026 03:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N3JJW7CC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFCB83FEE; Fri,  6 Mar 2026 03:37:29 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 981A783F9D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-899fc265126so70213546d6.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764644; x=1773369444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7cFBkHB1czKTTYQWm0iXwUKSl6kktUFYyLTIp60S1E=;
 b=N3JJW7CCqRuOJrUjTtGomfMydUi4JlleJPoV0Yp8Cm92avfOOv4b8bUefJdQAwKdPG
 +pZP52wr1un2N2M52Y9+H8qG4oszK5iGzj+IORnOuXogbAxVGiGn0D8YMnLR1Ly6l9vo
 haj/5yjJ3tVc874kJnD60kMdkQPXxzweFik0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764644; x=1773369444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m7cFBkHB1czKTTYQWm0iXwUKSl6kktUFYyLTIp60S1E=;
 b=hCYZ+hO4CZtbnt9UXR8B0n7bqi9qFvTQHyd3eRmVbicrNHuryhya0mQP3K41veroL/
 4CTVotTkgOa6+wHGG9+qUsAefeEGri2+vTz9iGrTeoPJ8IeXY22qrmsspfBvyHvzAUSC
 2wJQgF1oCEUc4GQNwv/hj2VzcFVJQNpnGDfjOEeVKJBVqqDHwYNLzJReOJuCECZ+RpSu
 cNfwcG1WvGVthxssJPPX9zQo9oylBTwNnkJQT3XU/bW+f1E8KWOHjmgdU9fCDTI1HKHA
 Qpatr1yxEiIWz+4lS8eDcP3YRHt6D3LLJw/kRGHOyfiTC6+qP2RFKOIgUayntRk0OO6t
 oHJA==
X-Gm-Message-State: AOJu0YzoZhV/Krj1JWF38SvLYvambT4Q9cTwZGCAXTwfhQnfeOYFCt6q
 cwfa9oAsH8H06siSHcAN7MYMcztEqasmwF3BLYjCCvKxcvi+PGOeFoGbfM373Bs2b0h7FRL5cub
 Dcvo=
X-Gm-Gg: ATEYQzxdzk7X7VxEWg6puepPM6xklHO3dVpPEqS12p2MbhhQa/3CBlGp1m6nytrIq1R
 oaaiLGxtM0h42VN+ronfZtO9U0oSNmy2MS6qACgqDbkJB+JNzWD6StKLAvinHte6fsU7yE0oad8
 UVNqC9dxjUjnuFYAT2lRUK+tpOGtrEDOslwORwA+n/BNGQRxu5Jj7doEO0nzvYIxdQfHL8K8Zqx
 uhPUtCQBMuDDxjbnK4BcjWgamkOE1QVlFAjdQeJmEUgq3yYHWEJmFdaB7+xBMNM/P+kTGWYdTQK
 UlPlt6l+4C+u9zyPpvH1XU9i85Q45T0bYC5owW/4xw8I0OzQml18hr169CXO27DOR/0WwT0bz81
 /iugqNazyp5NCKml6rkfLJMJmBoSrmBKiiAihIEeg6myToK992/S7/LDaHk6gE6moL/6syrbWt3
 L+HC78TmZgj3QOvc+dfQ==
X-Received: by 2002:a05:6214:5096:b0:899:f2af:bd7a with SMTP id
 6a1803df08f44-89a30b16bdamr6036586d6.56.1772764643884; 
 Thu, 05 Mar 2026 18:37:23 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alison Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@sysam.it>,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 13/17] m68k: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:22 -0700
Message-ID: <20260306023638.2678886-14-sjg@chromium.org>
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
previously called on m68k.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Acked-by: Angelo Dureghello <angelo@kernel-space.org>
Tested-by: Angelo Dureghello <angelo@kernel-space.org>

---

(no changes since v3)

Changes in v3:
- Add new patch for m68k conversion

 arch/m68k/lib/bootm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
index 3dcff8076e3..7e36ac73169 100644
--- a/arch/m68k/lib/bootm.c
+++ b/arch/m68k/lib/bootm.c
@@ -65,6 +65,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
+	bootm_final(0);
+
 	/*
 	 * Linux Kernel Parameters (passing board info data):
 	 *   sp+00: Ignore, side effect of using jsr to jump to kernel
-- 
2.43.0

