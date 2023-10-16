Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DC4CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 20:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A9B86BA4;
	Mon, 16 Oct 2023 22:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j1M8qPcJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7603386DE3; Mon, 16 Oct 2023 22:02:04 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E4F886DF5
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 22:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a822f96aedso41869327b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697486517; x=1698091317; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4Y4C3MQfxnSMvZ/JMau4D34NbrVrmmZl9x62tY9Bec=;
 b=j1M8qPcJYEvkoO2exFmP2locDrI4Cwi0k3KXTDiZAiWEEsDWth4relhARo4ajoR6u9
 al1+aqKyuo82gqRX+7V+9rxhLuoyGmU4gqwa2DhJpi7SyHrWzWiGvSDtQaiHLlXLPzuH
 n1tf82IKxmqtnyOw2XJ0imqlSwShF758H2Uuq4QHzVGg7o3LW6iuAoxyMLDZMy+jtdgS
 7+RkxKcRssHXmPhTia0bHITK4vQtm0VACCdGfiRbO2LRCHBTk8ZjuuRRo5ck2ZCCacYp
 +zKcXinsYCQyq2oMjnrMpo1NuGPdvlCOoGsbJgQ8rnqBK9ErJNp6aKsBtRBpnsc/TD8r
 5uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697486517; x=1698091317;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z4Y4C3MQfxnSMvZ/JMau4D34NbrVrmmZl9x62tY9Bec=;
 b=MzYHqpfI3lo0NCK4zT6D/+KP33ZLNy0lvwlwd9FW98vnpG/drq806j5N0Rsp8tJfj0
 19t8fBVcIfcsDeklqIG1Tv5+rN2CYqvdt86HlZbmsVfXqeYzVOviAvA2ePJk0lhTca4h
 4QXuvI61C01tAX+jndRmojPoRZuOgalTV/D3fQUbOsWQEDSbIvdYEk14LkpYHstZiwXN
 T8pe5LP9NzbfISJD7MTinYBTE1wkakIu1z7wJsoWQuk3DEj0jmSdz4QB+BoYNJMd4av4
 5rhOB2GlaYRELuB57zr5MgtxViUKJ8G0ENOejmpMZiCqS3LipwWXMtu7FTL3fHqzAxQm
 qpuQ==
X-Gm-Message-State: AOJu0YzQ07GkHCBR9QOMDV+3LpSt4TzIa+zBCa6JJJm7vY6y+lBVF0/V
 711XER//iwq6MtVHVE/sHp5omQN8obg=
X-Google-Smtp-Source: AGHT+IFUJDOIFeYjUThk1jHIozIU3sITmBQfJof7ikZPCkQd3+ITzk0LvToZH2NuC8+mPU49EGk2CA==
X-Received: by 2002:a05:690c:fd4:b0:5a8:1973:190a with SMTP id
 dg20-20020a05690c0fd400b005a81973190amr227558ywb.8.1697486517361; 
 Mon, 16 Oct 2023 13:01:57 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a0de805000000b0059bc980b1eesm2445654ywe.6.2023.10.16.13.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 13:01:56 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [RESEND PATCH] arm: kirkwood: Pogo v4: Enable LTO
Date: Mon, 16 Oct 2023 13:01:41 -0700
Message-Id: <20231016200142.21631-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Enable building Pogo V4 u-boot image with LTO, which results in about 30K
reduction in size.

Rebased to latest master and resend.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 configs/pogo_v4_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
index cbbade3c0c..fd62146ed3 100644
--- a/configs/pogo_v4_defconfig
+++ b/configs/pogo_v4_defconfig
@@ -15,6 +15,7 @@ CONFIG_ENV_OFFSET=0xC0000
 CONFIG_DEFAULT_DEVICE_TREE="kirkwood-pogoplug-series-4"
 CONFIG_IDENT_STRING="\nPogoplug V4"
 CONFIG_SYS_LOAD_ADDR=0x800000
+CONFIG_LTO=y
 CONFIG_PCI=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
-- 
2.39.2

