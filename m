Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0DFCAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B6BA8384C;
	Fri,  3 Oct 2025 22:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HRZoCi0Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A35C7838BF; Fri,  3 Oct 2025 22:39:23 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900B883826
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-911520e43edso111869939f.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523960; x=1760128760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Ffy6ejd2LDuR6U4e2CJaUFRjE/2H3ATv4n/+rGcjV0=;
 b=HRZoCi0Q/jB3jgD7mMqonfb2+kvVFZOOmY2e13fCgKfV/z0y8FZ2w7iDoplAxLfJMk
 4ldkWZRz5XDN5J2vNpp5KXqcQAZIMeHd/Sp04XxzbSn21tj6UE2jQ64M8z0/iQEf+U16
 J2E6uILln/DItgVoEa+dkRWoI5SC8dfXn+2dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523960; x=1760128760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Ffy6ejd2LDuR6U4e2CJaUFRjE/2H3ATv4n/+rGcjV0=;
 b=gmdDOMJWz0WL7/IY/8RYhxtKC3Xuh9S2TYZdWzoX0rHlYxGRJxaq9hHP8uEdnU6Q/L
 7sQUrT0EaCMzR07rsF4nGCzNdJ+2tB4s4Akx4GQ+03Qmy/qNtFezsortXPhZj670hfKN
 jit0TCEzPphtzFvQ1++uUrAAUgU6lR8vL/91DEVPOhfdw6rqZ6WhBKKFJmFGxS8OcOR3
 amCDa+Qp7/FTr3OTXt2ol+Xg5dnQO8d7pBtcJAuXCy5z9LaiwDR5EqKhmhRSRApj/9lp
 rmFiJC6pwbkSAWThbGPP3s1SfMfvNEqHp9jMaLSURsN4PoVh/OoeesGMxr4W4+zuxSMI
 /Q+g==
X-Gm-Message-State: AOJu0YxeM4Z0cJADyn11xBNM6vlayugaMABIkWxoUInYsidLjMuNpewK
 lT46VgtYXMnWvN8pDfNmUbT5XPqzLLLDK5+rmDB7S5yJaxR9BRU7W2xFilYXvvMQiYWTVcqbHII
 1yHAhO00=
X-Gm-Gg: ASbGncvVlB2xa2XB2oupUrxJRIn4U9lkEz5nABzw+3lfCU7J2qUcxmI3uPkzt6HBEsa
 xAxdtRXPQ+fhKdaTH2y9+XaVpbW/zb3Gn/8muUUIDPLQqIp4DS9n1SMtuc+U0hC8PhQYMCBZ/to
 ObwLLlrscjVUogeLLQfFj2JsonjQlwHJpTBB4pJBDhHSqWMWYKt77576Wk/uV4y26mE954uUHMy
 8pcUo0YNYbae4HN50iGBpQ4wKh/Fgm8f99OREwZQsQh3EEhQqlqrhKQtLyVLgICnVYngAFSjq2n
 dz5IQVx1GiZyc68d+H5AUPlxSUWh9gzoJgQErX+Y+fRcYgLvPgtKTVUCY2MDdGyecC04E9hfI4q
 2der1spTegNYNyH846ALta2FTfr5QGIZUeTg5t6M0FnKnX23T08x32ujOHsQDx6F4FlDbNa9fJs
 qWceMkAUYnyg3Us185vjUp6IA=
X-Google-Smtp-Source: AGHT+IE6txlUrpcJY1lT/7i2H9lLtZJy6XQMBQc6RCeBB6ko8tryYyc5+9XFb1D0rXIxRHlJ192g8A==
X-Received: by 2002:a05:6602:2cc5:b0:926:295d:81ba with SMTP id
 ca18e2360f4ac-93b96964867mr587421839f.5.1759523960215; 
 Fri, 03 Oct 2025 13:39:20 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a87bb84b4sm213861239f.18.2025.10.03.13.39.18
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] SPL: Make SPL_OS depend on supported architectures
Date: Fri,  3 Oct 2025 14:39:17 -0600
Message-ID: <20251003203917.1029944-1-trini@konsulko.com>
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

We can only enable Falcon Mode (aka SPL_OS) on architectures which
implement certain hooks. Express these dependencies in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index defc8bd6a8ed..63f6f8d962fa 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1203,6 +1203,7 @@ config SPL_ONENAND_SUPPORT
 config SPL_OS_BOOT
 	bool "Activate Falcon Mode"
 	depends on !TI_SECURE_DEVICE
+	depends on ARM || MICROBLAZE || PPC
 	help
 	  Enable booting directly to an OS from SPL.
 	  for more info read doc/README.falcon
-- 
2.43.0

