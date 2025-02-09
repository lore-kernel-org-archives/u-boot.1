Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1128FC021A1
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25DFE80EBB;
	Sun,  9 Feb 2025 22:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M/f9Qx5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A2780836; Sun,  9 Feb 2025 22:16:34 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2136680F50
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3cfe17f75dfso36461355ab.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135789; x=1739740589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAaHfJ/jR+4E9zoNlQTFgwOCEgiPIwofFrNKl5tPYiA=;
 b=M/f9Qx5taYjlR8qQnyz3lJ80O38OZcEldAO5gwwJVxoCh1dwlZsO0G8BtqfKJ/WEpL
 +RvkpmE+ZhiR9bNzNgPfE2txtHhlWtEoWQWNGcsMQQSNUp0YVl54FRxN23bhf1neU6zB
 mmJF4EOOZCkVaa7JgbVHmGDqV6AlyailrLpvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135789; x=1739740589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAaHfJ/jR+4E9zoNlQTFgwOCEgiPIwofFrNKl5tPYiA=;
 b=Z7HrbE0tfDcnFJ0Q2Kpxg6mrV1HD7zODLUqL8eQYOAulE0t/XgK8zbOx03Qfw7ATsO
 FI0j5NRunZS1e24uaJzc9YwPBsSsXpIW7e4v4lMG9lW1OsiZqTk0MvWqNukCiYctVPrj
 F/75Bbb/I6gOAjyx1w+2yD3v1xOmkasblaiExhyl3988W9pEEKLNNTGh9aCgiB3F9LaE
 RO5ESfGlj28svy+bhuRdHp5SxZBtvrBAIJ6VUssPSUuOoDolXraLXlRQV4aCK6UQED+m
 z2WRfYcuoOgMLFVyVoeZYmAgD9yOf9XIdQlUIYMHNYX9eswpnLwkr67hJhhTH3JV+dQf
 +xeQ==
X-Gm-Message-State: AOJu0YyjQxhojGeTqF4PGgAcb251cHqjj1g0e/UTxM/ZSHsSn/G0DmOd
 N2YDCWrXNaA0McjLzdJsHqnftppRg+Bw3rSGTrOc4xfXqkyUXsiVDyKkbt7ksdaqJ65dh9Ye/hc
 =
X-Gm-Gg: ASbGncsXpnwozuXEgvBJ4naCN3kvVsQ+INLm5KjN7ezCRlStUitrWQ3sgfuygUvAjDN
 ijShoR8LlIyiqXs4wUlEckZ0HIATqOwS+2ycT0CtTtcNo4qR6lBcBhgKbAMz8jdMOM/ttJDQQvc
 TgMVr9yoOvhLv1F2zGoT+runwf53+GhDDqTuC6rJA/NP+RRgej22S7xT0FdkYKNK0eYJXfm7nBm
 i8P7z06obnOkQkg1mwgFt0Puuzm6ZHxvvjOQM/MyGd/mFfOE1iJxlYEpV7L0wTE8kmjzX7aRvkC
 jd5BHHuyOC3Jrg1SmR4ybbqmXx6Bv5veTL0wwSudGlDH0Jl/MUaA
X-Google-Smtp-Source: AGHT+IE8z0Q/pvmeu/m/aFFio1Q/rRiwxa1leEGHegJ2/vZFN7bzIrPSkTOE6p6fCmmZDunvHfYWbw==
X-Received: by 2002:a05:6e02:1d8a:b0:3d0:1fc4:edf2 with SMTP id
 e9e14a558f8ab-3d13dd2a9c4mr105478385ab.7.1739135789058; 
 Sun, 09 Feb 2025 13:16:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 26/35] rockchip: Allow SPL to set up SDRAM
Date: Sun,  9 Feb 2025 14:14:47 -0700
Message-ID: <20250209211502.2299245-27-sjg@chromium.org>
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

The current logic assumes that if TPL exists then it must be setting up
the SDRAM. This is not true with VBE, so allow this to be controlled by
whether CONFIG_TPL_RAM is enabled, or not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-rockchip/tpl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index cc794a7dca2..2a261199179 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -60,10 +60,12 @@ void board_init_f(ulong dummy)
 
 	tpl_board_init();
 
-	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-	if (ret) {
-		printf("DRAM init failed: %d\n", ret);
-		return;
+	if (CONFIG_IS_ENABLED(RAM)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret) {
+			printf("DRAM init failed: %d\n", ret);
+			return;
+		}
 	}
 }
 
-- 
2.43.0

