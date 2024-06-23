Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA83C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B620882F9;
	Sun, 23 Jun 2024 22:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XIU/F+/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B978588405; Sun, 23 Jun 2024 22:30:41 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50533882E2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7eb01106015so143424539f.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174638; x=1719779438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqWjVuQJCqVOZF9dUg365Y0q5FGRMWVG6yjYRoEh8Rk=;
 b=XIU/F+/V/+80EPY34O2j7E33NYqfkj7qYjahKV0u6ExXoBzQktdnPcES9zAOAFBNVQ
 RNetFHNjm0yqxftnw65T3XEmnJVLc6VLhhEUWm5Vcy/Ep1ANYTTJdTqxsxk3TS+h1Pew
 iqDu26cAbOFrHHfxKhvqvQAzmR+NYUG+dpi2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174638; x=1719779438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqWjVuQJCqVOZF9dUg365Y0q5FGRMWVG6yjYRoEh8Rk=;
 b=R1WgbRA8nVj3CcsnvQ2wLlUirOlxiVRWHsMeOB7EbIw41dTwczkfSf8qH0bZ/qKhb6
 T6L2IA6ilxrToQkDZ9ZunT5FR/ZA1v014TFOCZ6hkIMcr9NzlC9jYpiR+Yb0/g+E4/mo
 VfCZ1lXyne+DqjNjm3NJdxOr6G1lhrzpqTCZjGrcpmqcE7mnDXL8EfM5kCoHe+ayiLwU
 tA1M85onEEUV8WPd4bHa9aMgtNAWR/J6kMw5eqfves0UajkUzOkhPUPbwik6lKqkNWBA
 cYHZnyPIfdmCbrv1Xz5RdrmMwx2XZYCuULPIiqaYj7mlS3Cj2gqexAzmg90V5G3RkY1z
 fiDg==
X-Gm-Message-State: AOJu0YyWcjsdgqEU1Y58MAE4SQj8j/zD1LeCmF4UEKLxF9YXyc3cxlvm
 7DPLZyXWlw6qYYCkC4pA++nJLBy/XQ1LXaEIk0jQcGdWre5sMnUwt69iFc7jCp+3lByaT1Zqn8f
 yQw==
X-Google-Smtp-Source: AGHT+IFeHbz6wO2B/nyEfiZ9rhT49GjrHF/1WcV8BLA6mQ8XPtwEoq5d3s2tcUleoXTsbQrkJlZLlQ==
X-Received: by 2002:a05:6602:1688:b0:7eb:7bc9:7fc9 with SMTP id
 ca18e2360f4ac-7f3a74d757bmr353018539f.4.1719174637850; 
 Sun, 23 Jun 2024 13:30:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 01/14] trace: Update test to tolerate different trace-cmd
 version
Date: Sun, 23 Jun 2024 14:30:20 -0600
Message-Id: <20240623203033.1566505-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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

Some versions of trace-cmd (or some machines?) show one less dot in the
CPU list.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_trace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index 7c5696ce747..f41d4cf71f0 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -12,7 +12,7 @@ import u_boot_utils as util
 TMPDIR = '/tmp/test_trace'
 
 # Decode a function-graph line
-RE_LINE = re.compile(r'.*0\.\.\.\.\. \s*([0-9.]*): func.*[|](\s*)(\S.*)?([{};])$')
+RE_LINE = re.compile(r'.*0\.\.\.\.\.? \s*([0-9.]*): func.*[|](\s*)(\S.*)?([{};])$')
 
 
 def collect_trace(cons):
-- 
2.34.1

