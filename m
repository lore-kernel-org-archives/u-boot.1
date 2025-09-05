Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8EECA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 15:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2A78389A;
	Fri,  5 Sep 2025 17:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FwP8RnNJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECDC6838C5; Fri,  5 Sep 2025 16:06:28 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F0B83807
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 16:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duttaditya18@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso1724296b3a.2
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757081184; x=1757685984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AYGHZ76uYhclX+bAmF/UjoCB8puVeMnNvCHvofSw0yI=;
 b=FwP8RnNJ8vxJr2J16rOiJBd1r0H4UE7VZBHhyvSAxG7h/NmeauGQSSjNSRy8UM/2Vg
 njqNk89GVZo0MyJ30SYIA5HoVakC/hmazJH93WnAGrx5m11Cn3YrOH/EKjvvdxiKGy0f
 mMp9su1ij7EfojszFNDSr+sStBzvJdAWVULGNMyORkvCu4YlnywcqSo1TIAulFyCWWLR
 r3DN1dLd/XwW/GlWHMTm2kPGuOKuXadyQFUEUHwGgrRu6IbtkM5VlxD3oXfs+lwGdZho
 bRJiAny8my4YfQjbNSv9wI95TkVmC9VrYNC58fyvZ6DnD1j2HRCI1XSWqjWqCt4wnPMS
 PfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757081184; x=1757685984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AYGHZ76uYhclX+bAmF/UjoCB8puVeMnNvCHvofSw0yI=;
 b=YlL3JuCb4q2hDry4KOhBhX7u6uyJW+EjZ1Zu09J+6U2mAgrRaC78bY7yC4hwAUBosn
 OYAxOalqwGzdYU3ZaOy+SyoFAsr0dOCLiAwlKYjjr73ulrBSoBZeIxNEY3/+g/+U4xrN
 tlLjp47fpJoO1CFvo5XmxcAtN20D/P8XSSp/gXGQTwnLPBigvnateerLKvKHZorITsXK
 tQ5KpaSHuE5cMtB7y8lrMzlLbjVzHYHyfucSEPIaJXJ9SbGlza5WskkDaltwU3tkClbY
 Ughc6pwW0eE5+WCEFYQCkcaxSWyINlTIrbgB3uxy6MRYWpw3dC9soxOQ5M0PA8EwnY+s
 XNOg==
X-Gm-Message-State: AOJu0Yzz4l8mtuMnmAzOHHstqmp17ClV0Lo0Yv7tjgoB9/pyijGvEGs6
 LsjIIzKyK7nbE6tM6+XmnTfh1wjj8Ymt2q/gPXMi7o88En0x1W5bnSXG+hziL8tG
X-Gm-Gg: ASbGncvSdzkK2dSkP10qy6xUU8LPI6d7lK19rsm6LufLnvdt/UMjywujvK1/7QyG7Zg
 lUm/gn2B4ccC2u0j/j87LLcCo2+JDTbBr+/yQGa+jCfsPEKHHGGzC5jVbe10SkAKntyM8wCWG1V
 l+O2mGcWfvLjiZLAAZiqPJsYYpUapof5C61d85J7nUMz4kLzEhNUWLA0Yjb4zlCGFQP+2ljy8A3
 FQs8c1u76B8X/zsK6c8O+RGkuUMefqwt0lqQVoVa48iQl1aWcnKsl6hX80nGlNpMzWFnmLemavK
 HF7TyyTq+InW0lfN01ixhiIAIfJCfOsJlnsBYHL1MUhMOjrbfcSF3rXQ4G/iCECv46oMs4HXW6H
 qtGesISDR2svyXCt/4RkorA==
X-Google-Smtp-Source: AGHT+IEcObMsckOU+lcHlvKX8VClEYkZ4YFotNGAA152TtteMvJenxUcCCDQO2Enk7EIMTxO1pNw3A==
X-Received: by 2002:a05:6a00:4105:b0:772:46b5:cc90 with SMTP id
 d2e1a72fcca58-77246b5d45cmr30835656b3a.32.1757081184123; 
 Fri, 05 Sep 2025 07:06:24 -0700 (PDT)
Received: from pop-os.. ([106.222.200.18]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4fe18asm22391871b3a.95.2025.09.05.07.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 07:06:23 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: u-boot@lists.denx.de
Cc: Aditya Dutt <duttaditya18@gmail.com>, Harald Welte <laforge@openmoko.org>,
 Asherah Connor <ashe@kivikakk.ee>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] cmd: terminal: avoid serial_reinit_all() with DM_SERIAL
 enabled
Date: Fri,  5 Sep 2025 19:36:11 +0530
Message-Id: <20250905140611.238951-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Sep 2025 17:52:17 +0200
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

serial_reinit_all() is only available when CONFIG DM_SERIAL is disabled
and CONFIG_SERIAL is enabled.

Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---

Running the following:

  make am335x_evm_config
  scripts/config --enable CONFIG_DM_SERIAL
  make

Gives a linker error because serial_reinit_all() is not available in the
case of DM_SERIAL.

  cmd/terminal.o: in function `do_terminal':
  cmd/terminal.c:28:(.text.do_terminal+0x12): undefined reference to `serial_reinit_all'

 cmd/terminal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/terminal.c b/cmd/terminal.c
index d803bc6c896..14610694255 100644
--- a/cmd/terminal.c
+++ b/cmd/terminal.c
@@ -24,7 +24,7 @@ int do_terminal(struct cmd_tbl *cmd, int flag, int argc, char *const argv[])
 	if (!dev)
 		return -1;
 
-	if (IS_ENABLED(CONFIG_SERIAL))
+	if (IS_ENABLED(CONFIG_SERIAL) && !IS_ENABLED(CONFIG_DM_SERIAL))
 		serial_reinit_all();
 
 	printf("Entering terminal mode for port %s\n", dev->name);
-- 
2.34.1

