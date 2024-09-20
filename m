Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ADCCF9C6C
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61A9D889ED;
	Sat, 21 Sep 2024 04:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EGDIDAxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C27E8785E; Sat, 21 Sep 2024 00:52:17 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EADC8817C
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cd46f3a26so21991835e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872733; x=1727477533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pfdHDTvIq+GqLJ7ercfbkhUYg5qQGsJkQO7v7+V8y5M=;
 b=EGDIDAxK9wwtwgqcHV+5jpUUOr6gJ0ULTFj3lCeYfh1rSGjxWP2Z5xsKXOb4V6jzrc
 grI4phddgrbkwhbrb2wrg4Ss76POIITNjNsvohdMGWzwaHiOi6XaDmpwBpLlDqqz2x4i
 kDU+vsnAe+w26G8cmgVn/NbJSjYHUJzX145QeQTc+xwFDpUSyq9Wsk8aLfcNRYQLtqNS
 H1kX5/x1vCs2u6PQ9JGYNZjSTeh7jcMGTp3pnj7PWBblu7WozGa2kXF8PLl/X5JKnY+Q
 ekQrjZ7u4oI2/gyHti3Fz4o0iTmAW6gRdfCVVR5m5ulGpO9oW9ESSvZmgz68Qa8eOCTH
 2zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872733; x=1727477533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfdHDTvIq+GqLJ7ercfbkhUYg5qQGsJkQO7v7+V8y5M=;
 b=xSKhwm/UK3ihOwvC64uLKTXINeK2AWr1HKO+hRDC4EpRiu91MIrlr7T993iB6/2miT
 AXHv4N1w4c9FO2Patr5OMMWhIJYvRsrnzzz0+VIxlEStHXfv6M8SBx08PplvrQr2vOSz
 HT5ZcvRlhYUUs4Zv9pctvElrDBGjogmIUTQCOIwK4o7++vhiB47q5pcSsn4mx/u7GK6I
 /MgHNoEqqUN5hqovBCUMAxVCDUqHQFLK5s+3PW0y4P7CoI6V85bapES1v7rfCjg4EG3E
 tT5lnumRf5Vj3w7s53+pvPXQ9lXiNyJZVh3ubXeusyM6F5AAPTkqluClc5HxaWeDESnl
 lWUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb6F3MQh+DGxp5PA7V0vN4u/nekp2QFpOA+dyO5XizsdwI5V3PGnrKjgi2nmMoEPyFWjWYs/A=@lists.denx.de
X-Gm-Message-State: AOJu0YxNO/nqE7sYoOQXHGxA1WhSWpT3hKl/kN5JJFAjwTgmvKl2CBq7
 qVbMX+hzEJzuzJSjFw7UYmSIPizRR1diG5NqdMnnNjMlF3HSP6YU
X-Google-Smtp-Source: AGHT+IHUKOOfOz1xaGoUmWkBAdR9sS4DhOEdJZEVcGX2QFbLXqs6RIDvhOJ/p7iapEsQOsIf1qSn2Q==
X-Received: by 2002:a5d:58e2:0:b0:368:31c7:19dd with SMTP id
 ffacd0b85a97d-37a4225294dmr2418142f8f.5.1726872732588; 
 Fri, 20 Sep 2024 15:52:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:52:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v4 11/11] test: dm: Expand ofnode options test with new helper
Date: Sat, 21 Sep 2024 00:50:04 +0200
Message-ID: <20240920225101.2008-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920225101.2008-1-ansuelsmth@gmail.com>
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:11 +0200
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

Expand ofnode options test with new generic helper for bool, int and
string.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/test.dts | 3 +++
 test/dm/ofnode.c          | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 25859ad852d..e5381b56da4 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -103,6 +103,9 @@
 			bootscr-flash-size = /bits/ 64 <0x2000>;
 			boot-led = "sandbox:green";
 			activity-led = "sandbox:red";
+			testing-bool;
+			testing-int = <123>;
+			testing-str = "testing";
 		};
 	};
 
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 39191d7f52b..7c0adcd596b 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -614,6 +614,15 @@ static int dm_test_ofnode_options(struct unit_test_state *uts)
 	u64 bootscr_address, bootscr_offset;
 	u64 bootscr_flash_offset, bootscr_flash_size;
 
+	ut_assert(!ofnode_options_read_bool("missing"));
+	ut_assert(ofnode_options_read_bool("testing-bool"));
+
+	ut_asserteq(123, ofnode_options_read_int("testing-int", 0));
+	ut_asserteq(6, ofnode_options_read_int("missing", 6));
+
+	ut_assertnull(ofnode_options_read_str("missing"));
+	ut_asserteq_str("testing", ofnode_options_read_str("testing-str"));
+
 	ut_assertok(ofnode_read_bootscript_address(&bootscr_address,
 						   &bootscr_offset));
 	ut_asserteq_64(0, bootscr_address);
-- 
2.45.2

