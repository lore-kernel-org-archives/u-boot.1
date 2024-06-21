Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCDAC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48E2988540;
	Fri, 21 Jun 2024 21:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gs+d7W2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 144DA8855F; Fri, 21 Jun 2024 21:52:16 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F5B884D0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eba486df76so74187039f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999531; x=1719604331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqWjVuQJCqVOZF9dUg365Y0q5FGRMWVG6yjYRoEh8Rk=;
 b=gs+d7W2pZZCSZE1q0Yz6mYVi2IAj2GU93UgaIQOveNal6KRpxEi5Fr6U5fJ1R9OrRh
 /61TP+t27vbfOX2DeV3yu+KJvz5nnEzIi0EoSuB6FFbgAzyaHuzoumgH/LPn4P4o3qDv
 PvJhrJmeQ3JXaB2FSSpmEZKMRRpVA4tcC+TjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999531; x=1719604331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqWjVuQJCqVOZF9dUg365Y0q5FGRMWVG6yjYRoEh8Rk=;
 b=lkJu3FmQS4+CCKoQ0p2LRFY85XL27hzvHmGguZ7DBTvdZkVKr9OCmj9BS8M9L/6oEj
 tJBeeHaTfqTcWo4ChcbZto9QsGDCG1CI4EVxjpP025pQnT5oWG+L6Li2LzBylzto5OKw
 qlGPPvvYDMPeh4pYxy+azet2gEPQKZE4l+0w3XDH5l9sheMLs9BPJlZEBvQJTuql23+z
 a+h/1lLs/WnWIMJwKhozzdrNEktNNUo1Abzf+fo/0RdpX8h2wwzr0ICDHQ3m/sIt6SPh
 VlJagwfqwVRmNx8nL1WlaYo5i4nYjyMQPhCyZnX3uK2mjP9DDma29x5TqjJKTY68Vv5a
 IoOg==
X-Gm-Message-State: AOJu0YwXhDjpAM3exVuYuqNTl3MjAuPMDwV76dGWwCqQtL8JJ0Hrink/
 CltUd3oR4cuIYm0GZm/tBwDKIiQGwu5E6qn0gds4u3kEgb4dWgECN/lcx29j26Z4+XTinLxPueX
 mkA==
X-Google-Smtp-Source: AGHT+IGPNZspZPZUfIR4PdmYpvZcGxj8o4MuWtVLWsbVQXmYgKVypCHtR+Iy5/Hr6mQ7cuH+YMCbWA==
X-Received: by 2002:a05:6602:1653:b0:7eb:65ed:c1f2 with SMTP id
 ca18e2360f4ac-7f39aafec80mr50606639f.0.1718999531182; 
 Fri, 21 Jun 2024 12:52:11 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/43] trace: Update test to tolerate different trace-cmd
 version
Date: Fri, 21 Jun 2024 13:51:22 -0600
Message-Id: <20240621195204.2675252-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

