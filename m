Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511A5E7D26B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5857786DD6;
	Tue, 26 Sep 2023 10:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WyBlTvLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802DB86DAE; Tue, 26 Sep 2023 10:57:09 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC0786DCA
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-573c62b3cd2so4923355a12.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695718626; x=1696323426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCiFI5cvzmRJ/iu0RJpm4jrUvbWpf9FONcgj8uQfgwI=;
 b=WyBlTvLbswzSOu/K8yBpK5YQEmpg1+Q18aNFUXsdAqmEEI/ipUZZfWUScXYEFqEfzU
 n3r3i3LFq2CsozzjtMLUFqkLCnbAta5QD9f6YqrWdZxDDOkcBAI6OKz9BuFLJwnPv2eI
 qGe63DZS65WfpwhH6XXTDoyptpgaToAJPk0BiW8rohAp/hnNBg/Ej9cS2rshIY6jUecJ
 vbHGaFoz/8Ta+NMn5bUvr+tHY+BooDY7Olu/07X5+jC3+8doX9i+odNFAZatJJ1lJiGT
 HP5osVU5dNt//fwuLX/QiN1pFwDGA1EeTZIMFMAGsL8cx/p8VY/PTzjbRQd1T6r0h9ob
 11xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695718626; x=1696323426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCiFI5cvzmRJ/iu0RJpm4jrUvbWpf9FONcgj8uQfgwI=;
 b=jOtcvUzpM4kT4jvd/mOb7O1/dyO/dqGpTSXUrNi060uDQPCiuPcfxWvONhhX1UAenT
 PMeHsIKDQT408ZlcOT2z/T0CvP13f4NV+qUkuuaJnX0TgPmTj7ShUDHXj3hf/pQjy72h
 PaT/OZVvR7k+i1pNJs1cGaACWtd7h3PSR2SfZhGYV/54KijexPL57zgcc8kNbEZwmn6r
 Pfq1RwF7mIH9U0XW1bB7PWTt88T0EVp4yi2sFyXUHDLgCKNw88JI+/CROkVe6ico23q0
 Q4RMTVwBPog7++/TxpEq4RWQWeFYw+LXCbPiIsgv8UIa4TR2rHZQHzCiwxpkBYgjKPoa
 aD7A==
X-Gm-Message-State: AOJu0Yxt/gEDclmPKSXA8wLPq3k25CqebRO9FeK+dCfs8JpHgah0DGcb
 jlD0ZutwmXSlvadUpcvU3QMzkAKcrcl4dw==
X-Google-Smtp-Source: AGHT+IHV2qRxGF9y3j9Wrg8qXEEd5fOdyMRmf40GrWZRspk7Llq3SF5xG8glX9SBnLcI4fa7nnCZfQ==
X-Received: by 2002:a05:6a20:3258:b0:14d:abc:73dc with SMTP id
 hm24-20020a056a20325800b0014d0abc73dcmr6020902pzc.32.1695718625746; 
 Tue, 26 Sep 2023 01:57:05 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:c707:b24b:e4c0:3696:f2d7:f673])
 by smtp.gmail.com with ESMTPSA id
 je20-20020a170903265400b001c5fc291f02sm6515863plb.216.2023.09.26.01.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 01:57:05 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] pinctrl: npcm8xx: add name for gpio function
Date: Tue, 26 Sep 2023 16:56:48 +0800
Message-Id: <20230926085651.395069-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926085651.395069-1-JJLIU0@nuvoton.com>
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
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

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 7976e3b3ed..ff49819b58 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -329,6 +329,7 @@ struct group_info {
 
 static const struct group_info npcm8xx_groups[] = {
 	FUNC_LIST
+	{FN_gpio, "GPIO", NULL, 0, 0, 0}
 };
 
 /* Pin flags */
-- 
2.25.1

