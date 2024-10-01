Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4833ECEB2FD
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4F589204;
	Tue,  1 Oct 2024 15:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KSh9Rc5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE48891B5; Tue,  1 Oct 2024 14:26:09 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5C6891A0
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37cdbcb139cso2880231f8f.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785566; x=1728390366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mWpLx/wht1TQRpskguMCKkqT+YiI0H6xuR/wKhA6SH0=;
 b=KSh9Rc5iL8Ts39k95flU2sDxRGD5w2kzyybfdGl9YvF6t/cRQZ4kqaOYmUXWbGGGkU
 r8H0RdMWmdCxULxAVIZdMKr1sGJYEYpOK5J6Lo/W8HrPYATbHh25lXXy8Y7S9+tNtyxJ
 H9vvJl06a3c5696AV8Omvjj5HxL2NI4IZwSj+DrhJ6AflpPKIKXbkGXA90jY2etvJcGL
 7RG9ddELecG7vV+/HtkGXD4EEqbSd7mu1iX5SUzIBg5Xjf2pMUNx0Zv081hqlNNSnSM/
 fwL+ROPEMNXHwUqv5YEJ97dcI59UU54x+wURj4gxoSnOo9Is4BiBH9hAT2R9ZTZsezEM
 nnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785566; x=1728390366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWpLx/wht1TQRpskguMCKkqT+YiI0H6xuR/wKhA6SH0=;
 b=qn+vjjEUSX6YvQrtYl2inCGo2/wyTImiET0bb0C/Jf8WP9aLDcK37fKThfpF+Lw+PP
 JPBfecCYaTzYVkcopJQE0LjVhQKEYw1TYez9zQMXMEASneAbeLyvYrr5n/VWLlZz0o91
 dAvyfdsrnuHsvkQNL+cRE6Lwlaw6ji+AZA3CHJNXaoTGmRjggMChzWETstFNwtzUkXzh
 i7DbnrPtzgeI7T8cj95VSsEgvVcXZ0kRE5WJM4jJJeyywk8v12ytfk1J4lLl2R3Ggqj8
 J5W+x4Sydt42XUDLJ91+sCkydQDIWEmjsBm26wgEdlZxY8y80ghG9V5+NfLcRxdJ1hS7
 jzxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWTUrQV7gSwMVr2xHCGHb/7QrNjXwN3YimW0WTxNzhl2mrGGZ9pUfvrF/mNJvLqvqw9PTUcPI=@lists.denx.de
X-Gm-Message-State: AOJu0YwD0fxHVp47W/iglG8+86/2IOB1B9fNloXYLK2t8Jf4+r1vazTX
 3kt0tQdsmk2qzTHFDFsKlq1rmVBCBzHzIGWgj3HYwor+1Z8fVTuH
X-Google-Smtp-Source: AGHT+IHy5izUC5izP2GZwrxrG8SLPlQVTXvuRaR8dfWJtTUln/2QciydgNnYeull4d7jGyERlDqUvw==
X-Received: by 2002:a5d:6882:0:b0:371:8319:4dbd with SMTP id
 ffacd0b85a97d-37cd5a77b2emr8901385f8f.17.1727785566369; 
 Tue, 01 Oct 2024 05:26:06 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:26:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v5 11/11] test: dm: Expand ofnode options test with new helper
Date: Tue,  1 Oct 2024 14:24:44 +0200
Message-ID: <20241001122511.8832-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001122511.8832-1-ansuelsmth@gmail.com>
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

