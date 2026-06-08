Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A7CCD8CA7
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 23:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC5A83FEC;
	Tue,  9 Jun 2026 01:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LmseGQ6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AC98425F; Tue,  9 Jun 2026 01:08:30 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EAC6839A8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 01:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e6cfdc92bfso1740526a34.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780960106; x=1781564906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C33dVWk6nvzDk3XqqZxn4cmFywU5jZjV/X5FoBdX3Lo=;
 b=LmseGQ6wnT07cYTNmny3Ct7Pg9n7dkm41jge6s+oXC2DayRssbF4qKFks1kKN6EheB
 tVgJTI8YS3ERAzkfBFs/dRW4V7gpw4ODrYO5QEa8MqNjEBz1rE19LCsBdasycJrxwe14
 njg+8VKCnH5gm9u5s8NdfcqjQ2jaSZU4+4BrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780960106; x=1781564906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C33dVWk6nvzDk3XqqZxn4cmFywU5jZjV/X5FoBdX3Lo=;
 b=bSROYXbXIgFG4HcfROeqLCZjSydipPOmUPyTrx8T8YaMZNgfpfh5Qcd6TMVHNLHOTs
 lISDxl2wQb5FSQKVdhR7NrShBNSUqTjPLw2wvilCMGdHKgGFUZMd2g+hYuysyDq1r3Io
 VDbdIqGOTlqH/1oWZjBpuSC/ZFGsLIQdrLehpXxjvYyNmTy2i9D0Xmj2tVmgmFkGapCZ
 SZJh+Awysm2qK0OungyKY+OQdkHe55en1sU6QGpihLuW8V5eqPngoIvrkHoeLseip+34
 WcGeE0+Jc/OAtqihbWEL/3Q7SuKcAVGQQEUDCuSbGO9Xtn/7+dpHSCR94J5Bfwu/lrUJ
 cELA==
X-Gm-Message-State: AOJu0Yw2u25AVpfnVJAKTYXU1ybmGOl5G2w1rkmH7YsCioxzm2ESdruN
 fY+t/n00rGnITR+xtcmdmkxrzy2l+HAtoJOdzcyIEKUq0G0Z8CKaGqGD8MyTqlh/2ZdlBxbbmh9
 H//kj7Q==
X-Gm-Gg: Acq92OEmWQtbSYPGFlnQ6yZrAUL33Nh75vYRcdMPmu2YcMKjTpPCaAisKyGKewvzeZY
 Muta16PNKl9LFgiT2SAIcnGywIaXOLCam7zlqwSwpaLs17jXGscP5XnHhYIUnC+QgHnCbwXGqAq
 EJMoL6Um6QiCCVXrPsWHY3+ZEirmVF3fC88mse0P6nD9hnXQ5wa0msk7QtTD0t2SJ24hAtmdQlv
 eyKzJzTLvhjBboN4meEixzpPtCg5oUg2Pt8R4hKZp5414dfP8geHsuj3b4SkobQ5C9UBEAU4AS/
 C1+BTxmvuUWPlo05KwIXLHY/Uc/+B400WNInRV+MUOmI/K3ycd95HOq/OI3w4gI2xfzyVtAFdI2
 mbEGRAt+XeZQiN7IK3kLZTCpTQBMcWF8Wr8GpY7oTjpLc18egBXlQK5XUyVKAVKObiT/IQbzViG
 RXpwpCucUktx4ArBPHDz8B8T6DO5Y6
X-Received: by 2002:a05:6830:2701:b0:7e6:d58d:b643 with SMTP id
 46e09a7af769-7e70cc02771mr11496669a34.22.1780960106291; 
 Mon, 08 Jun 2026 16:08:26 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e746965asm12780964a34.4.2026.06.08.16.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 16:08:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] CI: Add an sjg-lab job for the Digilent Zybo
Date: Mon,  8 Jun 2026 17:07:50 -0600
Message-ID: <20260608230820.1923675-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

The sjg-lab now has a Digilent Zybo (Zynq-7010) wired up, with U-Boot
written to its SD card through an SD-Wire. Add a lab job so the test
suite runs on it, following the same pattern as the other boards using
the shared sjg_lab template and the 'zybo' role.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72f..2e454ad8b57 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -797,3 +797,9 @@ qemu-x86_64:
     ROLE: qemu-x86_64
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *sjg_lab_dfn
+
+# Digilent Zybo (Zynq-7010); U-Boot written to the SD card via SD-Wire
+zybo:
+  variables:
+    ROLE: zybo
+  <<: *sjg_lab_dfn
---
base-commit: 5d4d6e331d3f056ecc7ab11b72098a3cf4fdb099
branch: zybo-us

-- 
2.43.0

