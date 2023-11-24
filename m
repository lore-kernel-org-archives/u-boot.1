Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C56C61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 11:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E7F087626;
	Fri, 24 Nov 2023 12:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="iVNn9pBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1835D870D5; Fri, 24 Nov 2023 12:37:12 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4469C870DD
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 12:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32faea0fa1fso1037658f8f.1
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 03:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700825829; x=1701430629;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9PFG/RKDf9AXrLEZh/ecmmD0nDgd4L5WXTH7eiUvOM=;
 b=iVNn9pBzEGxPKx0CpbYFtV2KmEvBTeqn5z8iLiGS1ch06Smlx4T0Ydnd1fMVb0ohwY
 8HYxj6znqbWYW/B1GO1sWpMUyqPhdXic8KwYlm+0sUntKUZ0kbLoO1YzKCUwCdvm0Yya
 cCR9oaOQKOF4QFKbwf/irgEJcGfcxAFz1/KQCe4BZR6L84JdzgAQyguIDgqgNW3AFrul
 aITbVCyLnuYj6wtMJW8Q20DnP0OwVXTv4TMuR35e9EfiZ0S2SvriOeoEp/BhVB7Fag6m
 f8urqmSsqBGCW4mBm8wNb1ChLiB2EIY77g1Azff04e3AjdpfCTQ8BqHxZMNPWnqe8Wt8
 0pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700825829; x=1701430629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9PFG/RKDf9AXrLEZh/ecmmD0nDgd4L5WXTH7eiUvOM=;
 b=XXmgLTAUtwBmtR7dUvH9LKefGoR4sr17nzCpEFxZ1XHR8xvOXqj872lFzuu8Wopo5Y
 V1uq3QwWpoK04o1nphSZNUedI+aDXZt4D3vjlvm2e9OO7jypoEvRzXQTX7G/17gt09iC
 lEUWinKOtlvVTnZFFF8klvpj92+D2eIkSL36QpeoknjYdHWJ6QHJE3nT4dPQgSvXnOoy
 m8n+YGawFNPam2NPrLwznuOa0Kz5rhT+b7HBKsBHtNn4+X/hguoLMJS9qRbM72hZf4IH
 z0k7h7mgA0NmkImtpy5i+Vi942HLojMMtAruYoHPu0GaMzL8xmowZAI4J72stDT/VpVU
 Tp4A==
X-Gm-Message-State: AOJu0Yw3pXbY05WVNpjsVPdR3DmfdtH0Zl8W49GZiU94hK2BhswwbDog
 V64n9KxfRPAs35wldQYihcZ2G2kAJBtAHTgjA6Bawxin
X-Google-Smtp-Source: AGHT+IEswwV3sEQf4iq2e1MQ6nrluTqUteM9u7J7TcvBnezDxaQ/TlkuQHcu1LnjdmbijSNZKQPb2w==
X-Received: by 2002:a5d:63ce:0:b0:332:c789:4bed with SMTP id
 c14-20020a5d63ce000000b00332c7894bedmr2563309wrw.23.1700825829161; 
 Fri, 24 Nov 2023 03:37:09 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 o8-20020a5d6848000000b0031980294e9fsm4052093wrw.116.2023.11.24.03.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 03:37:07 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Akash Gajjar <akash@openedev.com>, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 3/3] defconfig: rockpro64: Enable SF EFI var store
Date: Fri, 24 Nov 2023 11:35:52 +0000
Message-Id: <20231124113552.112243-4-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124113552.112243-1-i@shantur.com>
References: <20231124113552.112243-1-i@shantur.com>
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

RockPro64 uses SPI Flash for storing env, also use it store
EFI variables.

Signed-off-by: Shantur Rathore <i@shantur.com>
---

Changes in v2:
- Refactored efi_var_file to move common parts out as requested
- Changed ifdefs to use CONFIG_IS_DEFINED
- Fixed typos

 configs/rockpro64-rk3399_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 4cd6b76665..f550f2ae43 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -8,6 +8,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_EFI_VARIABLE_SF_STORE=y
+CONFIG_EFI_VARIABLE_SF_OFFSET=0x7D0000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rockpro64"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
-- 
2.40.1

