Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBC3C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5100F885B4;
	Fri, 26 Apr 2024 17:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VP2qUWNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6122B88698; Fri, 26 Apr 2024 17:33:46 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6DA81EEF
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6eb6b9e1808so1402394a34.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714145623; x=1714750423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P955uJcGgbhoXtzf85BSpV4aNBBUBEfaNHJbuCpnNxs=;
 b=VP2qUWNbNu3wQpihjjuF6ujD1ElyNomnxr5zTqxPKAm+qUsO9Yc4b/ESmPCajPRP2D
 29rkSl6ABc7CMlQ+Gujnz9UYCpwPUa0u3wCbrHUyxJNEIIQb+Ts72Vf6fIb4Juq32bvo
 E3LZIrBlYlhyR3J639KNrIsJjapl/O6AyKzH2mT9I6HcqJlG4oUcOuqQnn0geNHfiURY
 Yll1IeyTpkJ3bewHVPwEu+CA+j9SBck2szNuViofiTnWu0xNETsOfLF5Og2axlzogmz9
 LvfMVxxNkJyvwMTEKMyQEuh+HIbos+/DAGjVgjofVz75bY+hf3QmrfafiBlgga+f69rY
 /EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714145623; x=1714750423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P955uJcGgbhoXtzf85BSpV4aNBBUBEfaNHJbuCpnNxs=;
 b=M6WLcutP7qy7JCZ6kO88HLrZqFzdUN31HpR3HiF1kb3d36ziZxrdlMGzvUD74Wl8Wy
 C07ZeUtInO/8YXPoHUEi8FgbOqt9wbH5a17Ow8UirH9qWexHJEh1JblsFj2EYb+0SLDd
 d0feHu2RJOo/ghfyj0xxzBEE0yUrKymvEMM0vHVWJQJf4YXKHd693nNDijTV7qjdaN7w
 ZYoCzU+ti1J9JVv3zuv5rWu8W9XWs2EayRt265v5juoC6wrlPGKrN7WBTlEHDcThbD+2
 ybxHo10SZ30aafkO3lD+EqB/iKJBr3cHkMTAx7G9V4EdRVy/NmpYAcrtY85t0fT1EKiy
 oGUw==
X-Gm-Message-State: AOJu0Yy9gjkpbAh2f+BbGGh8/+z9jEaN0vxG6QOmSQ+2lYt/Bd3Vg27M
 NNlvM+5TfX88IlyxwvXNaDEVnuDSBvAU5Qz83d88t/ji9GSGbnGehmCMDg==
X-Google-Smtp-Source: AGHT+IHS3kKbBuuplmjcGgSvNO6F03G2NMmOyUUZNXV71l1QeG99fgAMTy1yFnAyj2lJaDkd0StM9g==
X-Received: by 2002:a05:6830:1e34:b0:6ea:181a:a539 with SMTP id
 t20-20020a0568301e3400b006ea181aa539mr3297121otr.3.1714145622710; 
 Fri, 26 Apr 2024 08:33:42 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 w38-20020a056830412600b006ea27c70ab1sm3024128ott.27.2024.04.26.08.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 08:33:42 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH] rockchip: Correct UUID for root partitions
Date: Fri, 26 Apr 2024 10:33:38 -0500
Message-Id: <20240426153338.210102-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Chris Morgan <macromorgan@hotmail.com>

For root partitions, the UUID should still be random but the partition
type uuid should either be b921b045-1df0-41c3-af44-4c6f280d3fae for
aarch64 or 69dad710-2ce4-4e3c-b16c-21a1d49abed3 for aarch32. Correct
the attribute so it is the partition type that is hard coded and not
the partition unique identifier.

Note that in order for "type" to be used the config option
CONFIG_PARTITION_TYPE_GUID must be enabled. If this option is not
enabled then the type is ignored and instead the partition type
remains the generic ebd0a0a2-b9e5-4433-87c0-68b6b72699c7 for a
Linux data partition.

Fixes: 42ec247e6988 ("rockchip: use UUID for root partitions")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 include/configs/rockchip-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/rockchip-common.h b/include/configs/rockchip-common.h
index 9121bba373..f620579248 100644
--- a/include/configs/rockchip-common.h
+++ b/include/configs/rockchip-common.h
@@ -26,7 +26,7 @@
 	"name=loader2,start=8MB,size=4MB,uuid=${uuid_gpt_loader2};" \
 	"name=trust,size=4M,uuid=${uuid_gpt_atf};" \
 	"name=boot,size=112M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=rootfs,size=-,uuid="ROOT_UUID
+	"name=rootfs,size=-,uuid=${uuid_gpt_rootfs},type="ROOT_UUID
 
 #endif
 
-- 
2.34.1

