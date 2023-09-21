Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0638E7108F
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58DD86BC5;
	Thu, 21 Sep 2023 17:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="d/27CS0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A69386661; Thu, 21 Sep 2023 17:37:52 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2684C86B26
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 17:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5042bfb4fe9so1438646e87.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1695310668; x=1695915468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=br9z88qqn3WBiXHR35Bhvp0xDvVLRDumL0+ofEA+GnY=;
 b=d/27CS0Sa3jR/zjJRtkSbh3N83Mm9IkegmKjV5UbG8KF6F6mPfNMozJOIrjzG/IMtM
 JnjIUZTX0sy17Pjjq+TQr1RY9Iy/ADzjLCbwVvPwj0P3Bwx+wK5ixPCQIvhJ9LQlhgRB
 h2GvB7OFj30jgP1RdUc1MC4MV38dOgwOc2YbJACQTvvYL4NFHEjtmSeS8XxOw9IeOUP6
 Gw66fE9r7j0s4p0LTnyhh/i56b90DnGn8komABYVDRXjwhDubNoc36QfSSpLievkRKbC
 DWHlk2qXNrx6C4WixTxsy9TZlSLukd6/RFrrSlaHNf+gvwgYcG6ULfgEw+JK/e2VBtu0
 ON+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695310668; x=1695915468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=br9z88qqn3WBiXHR35Bhvp0xDvVLRDumL0+ofEA+GnY=;
 b=EY8/O40fkXxwTr1sV+YQBphU9l1G84dNZc30U/J+aRq86c5L5v6fNq+XHtECTPwATt
 RwZh/7EejJmZBtGrsdvPPeyv7LQhYMGVPv4kLQNF0jGV9ioyJK/wwYAluCCQb3GECzUm
 gDuGH3o6eZdopqZ5X/JJEh+mqTNaDeCqoS/cR7rf3Ijj1kFyDdRvcAs8tJk0O6rxvwil
 XRB++wrjDeTKcbLvr/CAqdMjK2NlO5HeAeCFxFo6v/dtnqAGpE1dqkYnBxw/J3UyS7+5
 2+dxrrZqOukiIR3MYdFjpCwU62X+XRMvnYCjTz0Y9yEgXAjK1cPd64rR/u8ZbeENMSu1
 9kYw==
X-Gm-Message-State: AOJu0YwvQPEESjDQ1lCYzZVBKBjs341GYUvb1n+MUWZuv1MXBECPsZcT
 tYAM1PfJFvkU9oHFmL/jKXp5xA==
X-Google-Smtp-Source: AGHT+IE9nsvBQi88R3oltgCozioiBD0//X68DnYQa+HdrseEKW1umKVdaU/AO2AH53RF19oezCeEFQ==
X-Received: by 2002:a05:6512:104f:b0:503:16d6:1f0b with SMTP id
 c15-20020a056512104f00b0050316d61f0bmr6588364lfb.25.1695310668337; 
 Thu, 21 Sep 2023 08:37:48 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 l20-20020a19c214000000b0050422588213sm331492lfc.209.2023.09.21.08.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 08:37:47 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>, u-boot@lists.denx.de,
 Artur Rojek <artur@conclusive.pl>
Subject: [PATCH 1/2] common: add prototype for populate_serial_number()
Date: Thu, 21 Sep 2023 17:37:19 +0200
Message-ID: <20230921153720.542101-2-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230921153720.542101-1-artur@conclusive.pl>
References: <20230921153720.542101-1-artur@conclusive.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Sep 2023 17:43:58 +0200
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

Provide function prototype for populate_serial_number().
This is useful for boards that wish to read their serial number from
EEPROM at init.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---
 include/init.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/init.h b/include/init.h
index 3bf30476a2e0..e0b7fbc943ad 100644
--- a/include/init.h
+++ b/include/init.h
@@ -283,6 +283,7 @@ void board_init_r(struct global_data *id, ulong dest_addr)
 int cpu_init_r(void);
 int last_stage_init(void);
 int mac_read_from_eeprom(void);
+int populate_serial_number(int devnum);
 int set_cpu_clk_info(void);
 int update_flash_size(int flash_size);
 int arch_early_init_r(void);
-- 
2.42.0

