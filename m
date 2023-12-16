Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63E0C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D057587C1B;
	Sat, 16 Dec 2023 04:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K1hTsLIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5886987B85; Sat, 16 Dec 2023 04:15:16 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DF987B98
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-35d6c5f9579so5298485ab.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696511; x=1703301311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y23neOU4idWVpv+eW8UmVRXPVHbMLB+fUVdIT01bSAI=;
 b=K1hTsLIM9auMzows6VIDPfO29bbkUlPa76MqMHqwvqSKxnhbo7eNSC+0NJz30sp+V4
 oDQuo+A+CFD0yIRBWIMT1AvNBPmXgEOrbyfOdWCALf6X55dw69DZ8AT8kKpap+lfCk4U
 TMUYS8Dmb9yV0dXoga2LtAGDVINzdLopMWnZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696511; x=1703301311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y23neOU4idWVpv+eW8UmVRXPVHbMLB+fUVdIT01bSAI=;
 b=sRq3phvAi/WPN8N+a7v7cxcJUmXx6G+xeap/+ATpqYsjxFTGScJPOuqrIbXiahHEdc
 9LVSVcMQiZ1m+G/DVu38eRIF039xEvMgJJJ9XbHy4kTK/XQPawsuDfau8DjTRq+2I/lK
 OXuJ1WCE2tGWY/QFdv5OLaj8fdMEoHchp038TSCc7sT2JkAyq0ycfXSu2+U8NqeCgFTp
 x1rwfoWhMsvvfliJtumiwVKXHF/Vc/V1dgDa3TRFR7oJBupw+jqNJVr6DX6wjf+CQLTZ
 b1stbeARw5SQC7wSvuzxgPvILvO3OtD5e/2vJvc6g21NHx9gS+WyovYwON14XcQ4/Bcy
 9NhQ==
X-Gm-Message-State: AOJu0Yw/iYCLXp0bLx1oH/cRU5ZmHVgmNSRneFkL8XbAEQrhFeoUO+q5
 Jq2altUO5xZwuOEQ58a42aypst0WOmsbrg6hpueVEA==
X-Google-Smtp-Source: AGHT+IEJGnvSNMtYJCkSZPYo4J+zx2QkB+JzF5APO940WbUcPjb9Z0Iw/MylRJsIuI9td++165zOSg==
X-Received: by 2002:a92:cda9:0:b0:35d:59a2:68f4 with SMTP id
 g9-20020a92cda9000000b0035d59a268f4mr16530800ild.33.1702696511256; 
 Fri, 15 Dec 2023 19:15:11 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Scott McNutt <smcnutt@psyent.com>,
 Thomas Chou <thomas@wytron.com.tw>
Subject: [PATCH v3 04/22] nios2: Add a reset_cpu() function
Date: Fri, 15 Dec 2023 20:14:08 -0700
Message-ID: <20231215201413.v3.4.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
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

 arch/nios2/cpu/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/cpu/cpu.c b/arch/nios2/cpu/cpu.c
index 79a54d1bc259..de7bfa947f11 100644
--- a/arch/nios2/cpu/cpu.c
+++ b/arch/nios2/cpu/cpu.c
@@ -35,11 +35,17 @@ int checkboard(void)
 }
 #endif
 
-int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+void reset_cpu(void)
 {
 	disable_interrupts();
 	/* indirect call to go beyond 256MB limitation of toolchain */
 	nios2_callr(gd->arch.reset_addr);
+}
+
+int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	reset_cpu();
+
 	return 0;
 }
 
-- 
2.43.0.472.g3155946c3a-goog

