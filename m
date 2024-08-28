Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53746C7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC7288A58;
	Thu, 29 Aug 2024 00:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ODAJgsKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D328A889C3; Thu, 29 Aug 2024 00:08:59 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 145F98870D
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39e6a32ae15so6690465ab.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882933; x=1725487733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLCrRj6pAlFRGjImJoweM//OdBLyyEKrzNSfFlyshSE=;
 b=ODAJgsKu9TuYi0wTh7NCGB2CJOSfqd8fkSIGDeS/p/lssEDgnklTcwJesT2R7FCBTV
 l2TAOCkTXs2ElexSmQ1Z4V02KVLdjRbyD7pt/euCH1QCFt4ND8ykANOMIdUMHO7e/7Hx
 ccc7IXUvuP1lLt4uJxvgjT2CrVaRCOr2gSG70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882933; x=1725487733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLCrRj6pAlFRGjImJoweM//OdBLyyEKrzNSfFlyshSE=;
 b=uUqzpFvtLEdlYwiH4CfFPohuzmN7YHW91FcVcPQ0uAZTKOkFegCvvXIbTvBgOpwQs+
 RY9seUKYIy9iFIMICTrfH13Ki397HLo+z6U3XPXrgtosgCGfXTXfR3pwbx6TwV4WEeaZ
 AMhMzTKl9xRX9KxDhX2HIeWi+9i4UWQHLnQoGvEX+GwLvPHSQQi76OE+p67xFImVkrxl
 YVmdoE7VwWa27kb55mtH17EMSgXYaeyMhyIrIknfcSoX5Mfme6CIWWxUNbRixa6KnQrY
 YHZ1KMfflR3HV9Q+Uku9IocZeAXAEpo+FhQU/7WdI9QnHOQyUFr3DY0tt7odQ3vqv2CN
 qbmQ==
X-Gm-Message-State: AOJu0YzjDlQ5CMELX62hwnADoDgpHpiwmGj4oKeKcaClYce6+nIl5LSc
 Ngx13RdBw/LDtaePpTdCZLNZy0+vGYFfExjLDph+Jz3YhLr9YKMh2fN8D+sBdoIw6VA4gA3QxvI
 =
X-Google-Smtp-Source: AGHT+IGpQCqu+ZqmBO6XtRNlnfXSP5/fI2hh3F/QnyXbR+1MxR51Z7Pk3DUFdjaygklo4Z7eWOWUPQ==
X-Received: by 2002:a92:cd84:0:b0:375:c9f0:5297 with SMTP id
 e9e14a558f8ab-39f37888a01mr11508605ab.26.1724882933355; 
 Wed, 28 Aug 2024 15:08:53 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 04/20] test: Release board after tests complete
Date: Wed, 28 Aug 2024 16:08:30 -0600
Message-Id: <20240828220846.1205813-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
References: <20240828220846.1205813-1-sjg@chromium.org>
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

When a board is finished with, the lab may want to power it off, or
perform some other function. Add a new script which is called when tests
are complete.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_exec_attach.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/test/py/u_boot_console_exec_attach.py b/test/py/u_boot_console_exec_attach.py
index 8dd8cc1230c..5f4916b7da2 100644
--- a/test/py/u_boot_console_exec_attach.py
+++ b/test/py/u_boot_console_exec_attach.py
@@ -70,3 +70,13 @@ class ConsoleExecAttach(ConsoleBase):
             raise
 
         return s
+
+    def close(self):
+        super().close()
+
+        self.log.action('Releasing board')
+        args = [self.config.board_type, self.config.board_identity]
+        cmd = ['u-boot-test-release'] + args
+        runner = self.log.get_runner(cmd[0], sys.stdout)
+        runner.run(cmd)
+        runner.close()
-- 
2.34.1

