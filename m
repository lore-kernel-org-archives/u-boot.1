Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1FCC3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05CC782991;
	Sun,  4 May 2025 15:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DLgN6hkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 586968219D; Sun,  4 May 2025 15:24:12 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FDED82982
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad1b94382b8so54570366b.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365049; x=1746969849; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXp4yk8WDZYTaXHerc52NoYY1La85Q/D1hf5AdsKE8g=;
 b=DLgN6hkH9Cn+86qNGb+fA5FOwcdPReftFFUTynSc5isPviwlLx+A88Hz8rkLCmW4E9
 pUK5tGMjhQUBsd4tZxw9HVuq2QFsiT78bEZZMUuwdOLBknxBSlo+C5JRcsWz8+7DtMV2
 1yMaF5+om4qctCs/xyLtiriWWhCmXCQ7GHbhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365049; x=1746969849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xXp4yk8WDZYTaXHerc52NoYY1La85Q/D1hf5AdsKE8g=;
 b=KYeSuMvc9ChNuBGInzKt8HFx35R0Qmx8qHkKjFr92yd1CsMdWiI+tBfMqBFdBdxeAS
 ec033fODqhYeQpcjXeZ8ZmWAjDceaGPXLN5KgiIMRp29Huv7n6+fzHrFkmUpXM8qJEDs
 3+M+K2tAn1vkfvtE5zgDIU/ih4k2SmiNazk8IDC4IwiYTcJoH5MGekuIOK81Uqb42PaF
 rfrCoDyzyDrIYPv0OkeNPOG1qSi6GDBhhMnyL6i/RSRDLjWNQGpEabv/l6AvD4ExaHFG
 VVDmUADVBF7VNjjhIu2KJ4n0LGavCIzUyCxAtAj0oMBYUvvsq0sG2xXLFm0J2x6Dyxlq
 pZ7Q==
X-Gm-Message-State: AOJu0Yyt+8D7BCkwvtVLQy2KCl+212kf2qRy9DWfQovA1lwo/HXKijLz
 XRTDTxwsGE7ijw71g0EVaxFf30HScyp5AQHmi4bqvThRBr3rnpQY/2GlRGkNonzWqPmzoz5Iruv
 vNpR2sds=
X-Gm-Gg: ASbGnctoSWcHZRuccY14lIqkx8SQorhGJVHD1lq2qTtDDSaUebjVfNwrEmKCmvX7cPg
 ae7SiMq3D6IEQiYl3GW+Ys4Ry2VkdbqpdYb9L8BIkiDvZP+Bd3K20NP2tbkWgEtSVp0ffO59aEm
 mKOZyj8PHBG3aTp1I+jg0c/Hh13waAErYRvRwCMpuo6rR3VUDH4gLTcFLM1TSBfEyQvxWhf+YNZ
 eCe8l3ItE6vRyUmTeUaO6RwaB8uNGdrzvCflcyer8kKKbq5pK63BiTqUh2e8TkRiCVbb1uGMiJw
 5QP1U0yprQfloUqPnZImBoc5RdyITxCDUuiS
X-Google-Smtp-Source: AGHT+IHigvnsYjwcHjKdCQBrgviYxKC/mcQ5IEAPPwdQSTd5uHa9U96T92foa2wj3OtBTHLFokN2Hw==
X-Received: by 2002:a17:907:7f90:b0:ac6:e327:8de7 with SMTP id
 a640c23a62f3a-ad190827b91mr495766166b.42.1746365048853; 
 Sun, 04 May 2025 06:24:08 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/30] u_boot_pylib: Allow control of capturing
Date: Sun,  4 May 2025 15:23:20 +0200
Message-ID: <20250504132356.2317305-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

Tests often capture output so they can check it. This means that if the
test fails it is not easy to see what the output actually was.

Add a -N flag which writes out the output after it has been captured.
This is not a perfect solution but it is simple and seems to work well
in practice.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/terminal.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/u_boot_pylib/terminal.py b/tools/u_boot_pylib/terminal.py
index 84531831760..4b9a907a547 100644
--- a/tools/u_boot_pylib/terminal.py
+++ b/tools/u_boot_pylib/terminal.py
@@ -28,6 +28,13 @@ last_print_len = None
 # stackoverflow.com/questions/14693701/how-can-i-remove-the-ansi-escape-sequences-from-a-string-in-python
 ansi_escape = re.compile(r'\x1b(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
 
+# True if we are capturing console output
+CAPTURING = False
+
+# Set this to False to disable output-capturing globally
+USE_CAPTURE = True
+
+
 class PrintLine:
     """A line of text output
 
@@ -280,10 +287,17 @@ class Color(object):
 #   ...do something...
 @contextmanager
 def capture():
+    global CAPTURING
+
     capture_out, capture_err = StringIO(), StringIO()
     old_out, old_err = sys.stdout, sys.stderr
     try:
+        CAPTURING = True
         sys.stdout, sys.stderr = capture_out, capture_err
         yield capture_out, capture_err
     finally:
         sys.stdout, sys.stderr = old_out, old_err
+        CAPTURING = False
+        if not USE_CAPTURE:
+            sys.stdout.write(capture_out.getvalue())
+            sys.stderr.write(capture_err.getvalue())
-- 
2.43.0

