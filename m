Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B2FC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E480888B2;
	Thu,  4 Jul 2024 09:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Oy/ppJLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0C2888F5; Thu,  4 Jul 2024 09:49:13 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E71888CF
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42564316479so1857205e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720079350; x=1720684150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heeNVSuPfmKGlf8ZfBiv+awmb/TEadwE07nfjXnqUpI=;
 b=Oy/ppJLV5EDItDrWHorfWT0rW/5Ngp6CsrGm7LkyjGuwpuwkSgjPim35C64VflSYuA
 RL6Xqd/ccyW3HWZVnE/IiGP0Y2AIQMUqrTEuQO1QcUQNW2m4iqjDT6OYxrzekJZpkpxq
 1/b/WaCHU7sD2NIaYnBGqkv2GA1pIhPcvgI6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079350; x=1720684150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heeNVSuPfmKGlf8ZfBiv+awmb/TEadwE07nfjXnqUpI=;
 b=iAQqSCMOvF5EvL5d8wnITCzghwGTxnHGIpADq/MPyye3b9a/Oxf7o9VG3Mt8vMd59v
 0M4GyzZRc8n2aZYN57oWwRAA6CSj7jxKsQ3NbnGUKrhjVGyyKR7F0zCpncZE/dWZi8EV
 k8E71XfPROIiLbZWo/+Ik4uK4ucR/Cz7fW/ZzcAWgIqBC4XzEX4GKbhBMrI3ucjK+uZY
 x7rbmtaSyk5WAvyysA8T8uUVQ4DvU4P6xlnYe/wVvM0uWhayKOgOc9jXZuZxOqakazKj
 j8NJvpvHUMn21asPkgG6TXReb82m0cu/R/agToTKBXlYaJ1Lc83zB2nwQPgt4tejvcrA
 ZHGQ==
X-Gm-Message-State: AOJu0YwChnWQWDxbJVAw9Rv7Q//6mxOFjjqxZTXUQ0/3YNwpRBAV+MIv
 XTlUnghsp3QEjTGabWz6+0bqV+r0dNI4FURjeT+Fggu1o97o/+T8fxH4YukHOkOem6XPp0mXyGk
 =
X-Google-Smtp-Source: AGHT+IGt5qCcPmEDyRoDF7V0q24PvjiJpxsHtpqLp//HZvlsKhYDaBvFjDdvDcFqX68TMDxx8KDcMw==
X-Received: by 2002:a7b:cd95:0:b0:426:4186:efae with SMTP id
 5b1f17b1804b1-4264a3d1d13mr7336625e9.14.1720079350025; 
 Thu, 04 Jul 2024 00:49:10 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm12885515e9.32.2024.07.04.00.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 00:49:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>, Stefan Roese <sr@denx.de>,
 Ying Sun <sunying@nj.iscas.ac.cn>
Subject: [PATCH v3 4/5] sandbox: Increase cyclic CPU-time limit
Date: Thu,  4 Jul 2024 08:48:58 +0100
Message-Id: <20240704074859.2956745-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704074859.2956745-1-sjg@chromium.org>
References: <20240704074859.2956745-1-sjg@chromium.org>
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

Now that sandbox is using cyclic for video, it trips the 1us time
limit. Updating the sandbox display often takes 20ms or more.

Increase the limit to 100ms to avoid a warning.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 87b0ec3ea8f..83c81edac20 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -636,6 +636,7 @@ config SPL_CYCLIC
 
 config CYCLIC_MAX_CPU_TIME_US
 	int "Sets the max allowed time for a cyclic function in us"
+	default 100000 if SANDBOX  # sandbox video is quite slow
 	default 5000
 	help
 	  The max allowed time for a cyclic function in us. If a functions
-- 
2.34.1

