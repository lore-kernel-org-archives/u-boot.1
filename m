Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377E0D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E948789460;
	Tue, 12 Nov 2024 15:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D2fbuB/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C9A89489; Tue, 12 Nov 2024 15:13:49 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B21FA88CF1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a6af694220so20272215ab.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420826; x=1732025626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQ9780L92tisri25Ea4q+f8wctU2QtWEdf0HwT/RcaQ=;
 b=D2fbuB/WmYZ/lAPzMU1X6vHSNL216FvdLWr7VDPJxH3JAFWGMSHV6me9T4+HVQ87Q3
 YvmvOw1QyEFTsjIJAKdDqiCi4q06rV7OVf1diG19yC6bpYYvr2MzYipKocAptJjJsBeA
 oVKieon8aHIcyNaJ3V98ijGCI6Kx88UGwvmAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420826; x=1732025626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQ9780L92tisri25Ea4q+f8wctU2QtWEdf0HwT/RcaQ=;
 b=kpfYsiUECBNAcwDTCWL821Uh4XoCdqrFcyMnTKNztwIQlGvjSEd8ao9BqI2eyK0eTZ
 j77xgpS768rrYiNt6MMXyNmIbMZam3mH14sI+VB59z54YL/RdfHy9wGkirBJSNBm879O
 qZ3/EdNyFBuyKMmfMme2Ub4cOUctRHdEh42ZxHCCTWTcl/owFOT7C4nCgSgLo/zsewqk
 As8c014PSN6WUFlvNwP2gZO9kqdRNnyvLPPk4EvqwuRuqD4qZox36CN3wblcSgGt3m4Y
 46QmR27QzBXs68h8NBq3RqQGOn5RumtfN5nIOM97aexp/VektvM29YF4Ol/mW1xXeKWk
 UxVg==
X-Gm-Message-State: AOJu0YytaSwiWXwmGMnSeCS39/PtmlEpKupTaRs6GvLSmDdM6VmfRs/4
 BRH1Vm2Lyt+ZRnC1mDy2jfBrbN7ImkQn8d3vbvVCSfas6Xxp58n5LYSjBve7ysMc8n8wbjUgK28
 =
X-Google-Smtp-Source: AGHT+IEjobndFt70daaw5PaPFGOoLTgvgLeUi79Qvvr4x6966iKBM8NhkvtQf1D80ML1sXGnyIIqvA==
X-Received: by 2002:a05:6e02:1f03:b0:3a5:e532:799d with SMTP id
 e9e14a558f8ab-3a6f19e86dcmr163414365ab.3.1731420825886; 
 Tue, 12 Nov 2024 06:13:45 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f98932b9sm21275355ab.77.2024.11.12.06.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:13:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v9 09/12] test: Add a section for closing the connection
Date: Tue, 12 Nov 2024 07:13:23 -0700
Message-Id: <20241112141326.643128-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141326.643128-1-sjg@chromium.org>
References: <20241112141326.643128-1-sjg@chromium.org>
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

This can take a while and involve multiple steps (e.g. turning the board
back off). Add a section for it and show the output.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 42c81b2d13f..fa9cd57b04b 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -183,7 +183,10 @@ class ConsoleBase(object):
         """
 
         if self.p:
-            self.p.close()
+            self.log.start_section('Stopping U-Boot')
+            close_type = self.p.close()
+            self.log.info(f'Close type: {close_type}')
+            self.log.end_section('Stopping U-Boot')
         self.logstream.close()
 
     def set_lab_mode(self):
-- 
2.34.1

