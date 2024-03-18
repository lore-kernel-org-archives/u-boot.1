Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035DAC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 10:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1AC879DC;
	Mon, 18 Mar 2024 11:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ak2B2u/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064B087BF1; Mon, 18 Mar 2024 11:47:45 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96DFA876D3
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 11:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 10C573F68A
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 10:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1710758861;
 bh=KiNiTDed3ua9VpZMKQcyQICChrexmhARuWioGnnLyDk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=ak2B2u/hjGhJTWSAn7pHt0AJoC7UUT9NqQjQA9f3MOvXVJv//XNIJD45a0hShVKcF
 t+gWvWGLKeoStz+n6An9Np10ts7guowzR1dJIQAzQdMrB9KtBpeWMtIwOzhOsD0KNF
 OfH4WRMOBfbtm2txsDTkyjYj16p1mQGu0k4zOseyi890SGAICJeDZwQ5h4+LGHyUgM
 zJ8KSl0sdI7RNjjs5ek3Kbm5nYphksox2JGOlHIDYeDjlrrWQbhglsMsS1O5oFgtrm
 0YZsZHURaXjDFY/jJ8EdjYOjLPxnj9xLfip/IJK1QMvpZcRN2Benek/hGjE4UELFPd
 60/hoM8BovDXw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41413823c1bso2111505e9.1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 03:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710758860; x=1711363660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KiNiTDed3ua9VpZMKQcyQICChrexmhARuWioGnnLyDk=;
 b=cojudNH+JmRRUvCiSn+kuEr5J7k4GEzRxw2l8AX1olQjzdUhLaRcQcL+VgFNp367uI
 s+oVcj2We0cBzjIaUOmWk8Y2lGXqwP/Lvr/HVtPcyGB2YYYMEmoc932VXb8Dm11zNqdT
 fmH9bSJb3NiNP+VhjwWW/qpCzc2ICgaoHN6b7Cdx+E6LTIFeZtXCGVU+8Agqe2dc7Xyp
 vSBjQ0z3zefVbjIrVHM9oReUqto+fAwTVKLipJYurJUFOPsSkQr2oife5w5U3rQ9idTq
 34eSAKbfKG5te6WYhSoNw7JgoYXLhFRMIBNZoLj27YpDJqlJMLn4vjgTxweQ4Y0wtNbh
 StCA==
X-Gm-Message-State: AOJu0YzpdNqxt2pHnBrh3shs8MUDROhs7auzqt16My529wyl9e12ZBHb
 f8ogTtPrVwMXRTv9pVQFyATGzkifat5mtUf+O/v+6kz/uoxemv7whnda4/YhmP7eP80K6hDP/vk
 QnmXZnHbEqK1lVgNYMRpYKdUw9AQVNjP/XNAVCLmjwc0SoHlbljbZybzNwuWELjpnTfE=
X-Received: by 2002:a05:600c:3551:b0:412:b02d:71f9 with SMTP id
 i17-20020a05600c355100b00412b02d71f9mr10803049wmq.2.1710758860745; 
 Mon, 18 Mar 2024 03:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErhSvn0ibXO+edntQPC+taw4THiGEwHlwcwsxJE0CBUQc11qFaBgXgTUAR6aINOTSnRHVTEg==
X-Received: by 2002:a05:600c:3551:b0:412:b02d:71f9 with SMTP id
 i17-20020a05600c355100b00412b02d71f9mr10803028wmq.2.1710758860330; 
 Mon, 18 Mar 2024 03:47:40 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a5d694f000000b0033ec6a1b37esm9575126wrw.8.2024.03.18.03.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 03:47:39 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 kojima.masahisa@socionext.com
Subject: [PATCH 1/1] .mailmap entry for Masahisa Kojima
Date: Mon, 18 Mar 2024 11:47:16 +0100
Message-ID: <20240318104718.18365-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Linaro mail address is not valid anymore.

Cc: kojima.masahisa@socionext.com
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index d1f08f3eca8..59f84711000 100644
--- a/.mailmap
+++ b/.mailmap
@@ -57,6 +57,7 @@ John Linn <john.linn@amd.com> <john.linn@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyothee@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyotheeswar.reddy.mutthareddyvari@xilinx.com>
 Kalyani Akula <kalyani.akula@amd.com> <kalyani.akula@xilinx.com>
+Masahisa Kojima <kojima.masahisa@socionext.com> <masahisa.kojima@linaro.org>
 Love Kumar <love.kumar@amd.com> <love.kumar@xilinx.com>
 Lukasz Majewski <lukma@denx.de>
 Marek Behún <kabel@kernel.org> <marek.behun@nic.cz>
-- 
2.43.0

