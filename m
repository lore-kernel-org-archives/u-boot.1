Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70675C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F6E8887EA;
	Tue, 11 Jun 2024 22:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V/fKeea+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6DBE887C7; Tue, 11 Jun 2024 22:02:37 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C30887C6
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7e201ab539eso239205039f.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136154; x=1718740954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kQ0sfNktLS9BPxE2/bMuAta0itAhnN3N9PgOmsWa5Q=;
 b=V/fKeea+ULUd39yciwWFZWjDwdCPJjsTnQoQ1+MS04Bd4opR0jw95gQZkhEoJ569M5
 JttlLN+vbiIRUUSKPaiGsfQCDNx9JQGkHtTuKam1rZmfrxLk92F3KIiw7TXRKf/YDVjK
 NxjXyl4hq07X3n3TIm3VUN+jlmikWMX8s1GNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136154; x=1718740954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kQ0sfNktLS9BPxE2/bMuAta0itAhnN3N9PgOmsWa5Q=;
 b=O+IBNJuh1S0gxvu35ZhxauqXjx0Xy4sqAhGYviUI/3JCOz0Crd/NU6gE01Sx02VB9J
 huOmchjrDWC/WxBVQxwuOCdOvpUfP01IieYRgti2BdFVzp5pFiy0tbVoVKjQT0uM+zkG
 oms+GJONYm8mxZrVztUsUOtoXQ0YOWvLsxQuwgtgwkc4VTNp932XBN0GeO+/+YfDvjRJ
 tLzZE0hvsYijXwHcKImtt+KG0IDPhh1xT9+ME0ssyPQyN/Q+XtJiAXbdeaeR6huOF1lH
 oguHR8EY0myy1v+Sf3y+KKvUzZyr3E6YmM25qV69iGTRfpNaZv1QIQaLMrRJHHd7giLT
 Aw1A==
X-Gm-Message-State: AOJu0YxN1ikFfVdpbvfwDw0k/SMlQynfSOUwJgRDkisZinr4Z+7T4KUT
 QQloKRAsUNfAr8BO/DJwAnjnBudi9VSuO8mPz5SKFClp2uwWK4S8ip3yb4+pcWBCnZvz6++HDa7
 nbA==
X-Google-Smtp-Source: AGHT+IEgbKaTxMTU0XUtOA6rkYPrm6dyjZZWgnA63tI2soSpXFucB1WOM0F+E3M5UEMhifPnIgRBrg==
X-Received: by 2002:a05:6e02:168c:b0:375:c3a3:4c16 with SMTP id
 e9e14a558f8ab-375c3a34d74mr17914505ab.18.1718136152682; 
 Tue, 11 Jun 2024 13:02:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 23/42] test: Release board after tests complete
Date: Tue, 11 Jun 2024 14:01:37 -0600
Message-Id: <20240611200156.2245525-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

