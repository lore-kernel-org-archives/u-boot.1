Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8B2C7112B
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 20:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED906888A3;
	Wed, 28 Aug 2024 22:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LqJN9uxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DFC98862E; Wed, 28 Aug 2024 22:14:05 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B21888703
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 22:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-39d3b31e577so31267725ab.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724876042; x=1725480842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKFpz8Bm3YR9aHf9wKgR0c1CLSIdxqGy77YJ79mxtwQ=;
 b=LqJN9uxmS+CCKQltrcUh9n7HncrY3G1gRgPUPchclBbXIVEYEJRplDg72CyoVkX1CJ
 ABrOVKcFXUrU1c0QMv9YEMR19A6btzcFSb1ifx/aDOdSm4eEAerrXU9E9cP9YFH1hHhP
 6kHYPm04tkgW0EDUUzSjyeSsAEaKHmOylBRJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724876042; x=1725480842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKFpz8Bm3YR9aHf9wKgR0c1CLSIdxqGy77YJ79mxtwQ=;
 b=NfolEb1/ywJ9vDr2wecpwfw3yFcIMNRAnQPAwr136P/JYHUf9y8l4slF3GkWZ2N1Mk
 LXUm/BOE9A+drJl+w2lAmK+2+uKQetps+ZNrd0CyzOA5xxl2xszRLoQ+0vD8UUdZcO0t
 vMPtD7sfmY7iGM2SL4ziZnNd58qQoN9BZWTP2A+LpZ05uUI8DnjEqakBgglA0+VbcNNw
 va8SfvX0CCXpRDbpE90C3g9xvpMdNeNCV/ofVRRbn4Oya4OoXoORdlk4rB9L3x9sNK91
 2YDOjcS7ojz2jiy0ErqbM00MlzFuCaB3jGn3gP81Vmsbg4P8M8mRHSGsqhCjA+7ziFdu
 yDqg==
X-Gm-Message-State: AOJu0Yy+eYf4FhE/9eAgqvFwTzKqgRtCefnq4T6aeMtC4WRYCPonX34D
 Kae7ltSxrR50OGqJIJDDMy56/WSpdFJ3+4nC5M4Pa2+eVjAW1plu8C0tic2CPa289VJeEGz8S/E
 =
X-Google-Smtp-Source: AGHT+IGVP2PfWRRAkoRS5Jj4ie4DU0KvqYZOdBvAXzxrU+uqTwhwBOkUbPmp1i0FhVLcT98INJmI/g==
X-Received: by 2002:a92:c243:0:b0:375:9dd4:d693 with SMTP id
 e9e14a558f8ab-39f377ce547mr9963765ab.3.1724876041689; 
 Wed, 28 Aug 2024 13:14:01 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e91f88sm348785ab.44.2024.08.28.13.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 13:14:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] x86: coreboot: Add timestamps from coreboot to bootstage
Date: Wed, 28 Aug 2024 14:13:54 -0600
Message-Id: <20240828201355.1111764-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828201355.1111764-1-sjg@chromium.org>
References: <20240828201355.1111764-1-sjg@chromium.org>
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

Receiving timestamps from coreboot was unceremoniously dropped some time
ago. Add it back.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 8ad01ce36f7 ("x86: Remove x86 specific GD flags as they are...")
---

 arch/x86/cpu/coreboot/coreboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index d474c79e25e..7cf38f2b76c 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -82,6 +82,8 @@ static void board_final_init(void)
 
 static int last_stage_init(void)
 {
+	timestamp_add_to_bootstage();
+
 	if (IS_ENABLED(CONFIG_SPL_BUILD))
 		return 0;
 
-- 
2.34.1

