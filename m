Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F972C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A337887AD3;
	Thu, 14 Dec 2023 17:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DFHkxqo5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8843587AD3; Thu, 14 Dec 2023 17:51:47 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F83287AC5
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35f77a076e1so2162805ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572704; x=1703177504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CBT60uiP4+j9cauRH/CkSpdQijkPMwjpQPjTvsAf3Y=;
 b=DFHkxqo5rl+LQK9ui5vsQIU6sPxVfk5+BPJzkGGVEfd/tZsDuZAPDJiZ7agD04dO9/
 +mYoj/Cj8MwZgZ32bERMgbb6cBfx+YA81D05yACriJFqF44maPhqC3X10HF7A1EubHam
 WrKEFN5nIfH2t6lh6Uu3+ob5lf+Hd2s1yA/+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572704; x=1703177504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4CBT60uiP4+j9cauRH/CkSpdQijkPMwjpQPjTvsAf3Y=;
 b=uvnJWKgmJ32IAPHqoUTJRinpsK+psMuZait2t/zorfLuLM6R5Vf4VmhdbQkk01AQrk
 rNFte8rBpBcBiXB+AgfbErD5WWkK79VHTyazC7jXHkfuAYQccqm0BB+B/jedLgIjuIC+
 edr27st5uYqDn070dIlabfP0/54/ZJeO2F7N0mSQYgz8GY+H3X1EEM2NDYw9ivK8Zm0L
 AZAVJ7ap63WP3KpmUWV7rEjhNlrW3pTtCBWzyB1f6yByaghqUthNGFf3Ppf9mZcCn2B5
 nT+Lye1dNHhHUN12YsMXRGuzpT5XR8lRayfOPZ/bKYLjoI1WcsG2J1WDTAR16G7QQK2z
 aCPQ==
X-Gm-Message-State: AOJu0Yy/DnaPIvMOC3YuluSSnWxBFbWRx+MbgmY7VfVEUjUPKs+iYlLi
 toFV1fCN57DTckqZ+FVdlL+6dNJfUxh9tPLaXDSxFg==
X-Google-Smtp-Source: AGHT+IGdAfIGP38fZnfTrFYrjzSEMekNT8hQEAEbqJ+/2JZi5waNgwapCb8h7XB7KTyra7maqQ2eoA==
X-Received: by 2002:a92:c24b:0:b0:35d:5994:ffca with SMTP id
 k11-20020a92c24b000000b0035d5994ffcamr7051107ilo.32.1702572704052; 
 Thu, 14 Dec 2023 08:51:44 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v2 01/21] mips: Add a reset_cpu() function
Date: Thu, 14 Dec 2023 09:50:10 -0700
Message-ID: <20231214094939.v2.1.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

