Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB937CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 18:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F11883020;
	Tue, 12 Aug 2025 20:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tMaFEaQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB8C8304A; Tue, 12 Aug 2025 20:01:37 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 401FF82AFC
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 20:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so3918359fac.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755021694; x=1755626494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AA/ZvEZPKqbWDnFHOVK/0kf5o+iVnNml96uKpWQfCxI=;
 b=tMaFEaQx5FCgCfNL8fBttaVbBauGrcOziB+Ocad2G8zkoFghIzA9FNskCnr4HZqS4Z
 LZjn2cMsCqdEh2M1H2m2RW46Jzj7FWXAq73OgJdU8VYe7wHLb0Y7PRM6tO5qrLbVn6tx
 QDJOG40+ll2a1ssI90F13RT2eK5/b4MNHkg18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755021694; x=1755626494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AA/ZvEZPKqbWDnFHOVK/0kf5o+iVnNml96uKpWQfCxI=;
 b=tAARzk2A7nZASd/fQZrqUbnKKjLnm0ol02INXkoMAXeFw2yXfCh8NtwhJKa+xeiM6h
 hb+FJcK0xC6+iIukGFpllLJmlYN8M8vc7amHrsq2TBNW8GE3Qh3n9bwgs7OwzBfgSHFi
 u+PC2PjVbOCn07JBAmcvibq4cRe09wCSosTdF9LsGzWpx5E0FlK8/GBjwbIJZcAtPLmS
 akzC8q3yU1RHr/w8nBvB1oXw2M8/nLNQ+PPTjx4/HgJ4reF8HVP7Z/3et7YHfGos3ACi
 CJoXcztR4fdlUvrLAGvkaP5aQENLIk3Bzpy35v3z0cQGOU/5EUd2g+ZjCnjmsTl69i33
 5yRg==
X-Gm-Message-State: AOJu0Yw/BJC6QjEaIqPh8QMNZsJ+FdDPM4daCdwNVc+ht/Yg95E5thdm
 PnRIiHSamqem6BP8jTYL7fU9pLEuoBiHmEXhXvH6kT+BEs97s+Sh9RSVkZAg2gAmXkaOcUat3GX
 34p8K7Pc=
X-Gm-Gg: ASbGncu3I0nB1QGhBEC0zcMlg8GPPxYNMjvsibdAsXbmTJLjsqZ+9gA/hC6Suxk0eOc
 HBGXgnMRudDkdYCUNSRMqP3v5CH0OwJfL6HQD71SqlvUO8oJ8z98ueH06TuuACD7rgz7koumVwi
 khC5fbFD3ajDEt1Tze6MsXYVwrsDVJtrnCsk2bLszTFHeanoVor0tDuX08ctVHn3Npw3iu9MTh+
 d8P9QBJXmCK4qvcgRZLnNz4ng8FomuxQNHPBAmdtEbupVswI3TMengUEDMu7ZseSV7k3LbisvK5
 42q6DKeLIBU1flwhJ2rb198I4bdY2gg8zQSe3L7s+ItblzEi0hqj83m9vIkblGFOy4ScjdH7V81
 yNkEn4Gr1S2yWE6yfYK+cCJ/UPHZJDERY4BU23/kf8VQqCAJrMko2xKcVlGA=
X-Google-Smtp-Source: AGHT+IHfzHU86SGbepXk+MgJYAcNYHM4uxvQ564a5Ieyue26s+6SQIiceXGjVC5F/WZGGl7PpH26Rg==
X-Received: by 2002:a05:6870:9686:b0:30b:b536:48b5 with SMTP id
 586e51a60fabf-30cb5c02a77mr74802fac.24.1755021693811; 
 Tue, 12 Aug 2025 11:01:33 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a717f0c9sm8530172fac.13.2025.08.12.11.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 11:01:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] efi_loader: Make EFI_VARIABLES_PRESEED depend on !COMPILE_TEST
Date: Tue, 12 Aug 2025 12:01:32 -0600
Message-ID: <20250812180132.3057893-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

When doing compile testing build we cannot rely on having a valid file
for EFI_VAR_SEED_FILE to exist, so disable this option when doing
compile tests.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This was found when working on "allyesconfig" and the issue is that the
file in EFI_VAR_SEED_FILE will not exist.
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c2aa88f59fbb..a7092c2e8a8a 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -195,6 +195,7 @@ endchoice
 
 config EFI_VARIABLES_PRESEED
 	bool "Initial values for UEFI variables"
+	depends on !COMPILE_TEST
 	depends on !EFI_MM_COMM_TEE
 	help
 	  Include a file with the initial values for non-volatile UEFI variables
-- 
2.43.0

