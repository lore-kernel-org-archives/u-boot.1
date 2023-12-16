Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82861C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBAE87B9A;
	Sat, 16 Dec 2023 04:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PIYyfpVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2222087B9A; Sat, 16 Dec 2023 04:15:13 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDEBE87A9B
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-35f3e4ce411so8368435ab.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696508; x=1703301308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CBT60uiP4+j9cauRH/CkSpdQijkPMwjpQPjTvsAf3Y=;
 b=PIYyfpVD7WsVDRzGASf2pNzA7jSDU48YqF3mhugEVP1OjiCXYvAPMSwICOM8Qaf3zW
 6hPJagua4h2/nReKybexbcD3ywJgoUda3SFSQnFBN5rH2ikOoWGUaVKnS9YiL+LOiqF9
 WV0A0Qyr643P+7dxcyaL/pJTnlASckWzDWDcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696508; x=1703301308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4CBT60uiP4+j9cauRH/CkSpdQijkPMwjpQPjTvsAf3Y=;
 b=o5dawCun5SxFTKxA8FtL2c99GfqnDlbbB1MsEFv0a5AGnfOFIa/+8ZEm65qY+f24CU
 iLYC1t0h3iB1YlQfZ6gso0D4ioAWferau5VZYW+JieuijkSFcJULtjiG7PceKfCFOUmY
 Vpdb480IbRSEkAsq18k9Ol5VhbwZ0vrdZOflGTCIb/inJSxg1po5/eJgTdCltGHzeKA5
 VSyS2zEI5PoBLXN98GiT5tdQuGsRyr4QACTfzSPWgF1VRyMvz8BV5Qdo5vsC42OLOUhe
 QoggUNroTBdzoHAMozpXf+FqBI6vDrQYogMPFXHkRVd9WaKKsKvpk04RUCFkt4M5HLVh
 b/oA==
X-Gm-Message-State: AOJu0Yw59hCZl/OJFXa4Iv8U1v4sVyypR6jp/V29Es98cy7R6Es9KvLP
 7xgVDFkkqjtZGtWaIvggt8lEtnt1j9y8CtCDAkvehQ==
X-Google-Smtp-Source: AGHT+IHS72Dpvz9JSyAWjLbi6p61lrl9wCgy3QPo9t1/L8Nr9M9AJIpMIqyZErEJlCdhS6q484DxHw==
X-Received: by 2002:a05:6e02:170a:b0:35f:8406:2292 with SMTP id
 u10-20020a056e02170a00b0035f84062292mr5067599ill.91.1702696508714; 
 Fri, 15 Dec 2023 19:15:08 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v3 01/22] mips: Add a reset_cpu() function
Date: Fri, 15 Dec 2023 20:14:05 -0700
Message-ID: <20231215201413.v3.1.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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

The current do_reset() is called from a command context. Add a function
which can be used from anywhere, as is done on ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/mips/cpu/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cpu/cpu.c b/arch/mips/cpu/cpu.c
index acfc9dc43f17..443465047715 100644
--- a/arch/mips/cpu/cpu.c
+++ b/arch/mips/cpu/cpu.c
@@ -4,6 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, <wd@denx.de>
  */
 
+#include <cpu_func.h>
 #include <command.h>
 #include <init.h>
 #include <linux/compiler.h>
@@ -20,9 +21,14 @@ void __weak _machine_restart(void)
 		/* NOP */;
 }
 
-int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+void reset_cpu(void)
 {
 	_machine_restart();
+}
+
+int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	reset_cpu();
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog

