Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ED9C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FAB82C30;
	Tue, 20 May 2025 14:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BXXmY3n7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E72C82AB9; Tue, 20 May 2025 09:58:20 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2141B82A4B
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 09:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-afc857702d1so4800281a12.3
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747727896; x=1748332696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUWqZEoeCOPi4kA8iZW60G/CH5kQ9HtU0Ua7T5EZUM0=;
 b=BXXmY3n7gsVJa//i3n1/zxxqLc8RMtbqlVu8yhJiqaEgk8D/VKVnAGP4IHF27dLb8G
 fis6JdqWhM0mFqVQJGuEraMw1fuJ8f9WWtpdnv8CmLLbMmRRzyO9dIfdEepPlTROwMW0
 yz3e28++SRiqmnaJQDAhC+7ZMI79scCCLtAHUi6Aweta1CijCGcP8MeazSVhP6l8FRta
 h/OvQdD//j/TgA2NUuthPMcaw5UntOB2mYnh3LigCLXghwOCfZoTWEVmZ1RMMDp+WKly
 agsIh0cLlcMPfMEgSvLPSCtRUq6LBhlGn/744In0sTGAX07x9QTDsd/lG0IfOE7x+idj
 5KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747727896; x=1748332696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUWqZEoeCOPi4kA8iZW60G/CH5kQ9HtU0Ua7T5EZUM0=;
 b=IwGInHzqKSs/zFPIIwtUY+sZzytBgDh2wLkb/qIhLVcMlpGoT66fW5+AXSRjdpVIl2
 lTChtHKWv9WR4W+LiKGlJFiAvayVFs67+/gQuQOeg8ik7hj+g/iB5Q+MGz2NYceYYZvL
 xqZIpJzI5E6u2dKCw8nQOPkyoUxGKqAAvv9nTptjoGTFsTdwz8OI/vNXrhNmDwHMULcQ
 ES2/4+U7VgsRM55SF98fb+sHhOUWn332F1PId9AmjiNnmLcY9+hfOEE+0NEPC71spSU/
 opNDhj7lq8GacbTlnQKj0mFO0pLt0sWiEdNNv+k4M3vgBa+WZ01dTUbS5uEYKGiTeAI3
 P0hg==
X-Gm-Message-State: AOJu0YyY42FQsii80kYqcEYrAaq/LXm11DEyMHs092Sdj1TgzErMxwWU
 wRtxcjvCy7uP8xfPRZ0/tNebucb/rsUj6veYbMPXgajZnKlVt5WEtjc36wc6ChBe
X-Gm-Gg: ASbGnct4ZhBnsL8ZAli8iO/ul7po0hfkXYwLtP/trx8HmixwOhcXo4IJI9jygq0ItvV
 5G7d4Q5ggPtdeBIfkrUrSRCQ/svP0qqYqQHcCq35oyHSt/FRJRMx0QeHf4pzl43oPW0UCX0aC73
 7SWVgRxIV0A5EdsQDyU0rxm3by6o+/mCUAsa2iLn/N+YAbD6ICvGKs1qpeAhPa3Nkh9M4rmEx/S
 2S+DY3YtXRDXwpN7uMb3tyTJddzasVA3S/1dY3An10xckV/YmRGcpwAf7sCBW8p2IkAbrAVE8YX
 IY45tPGE0i32YfPLUSaLD9N1fFeD6iya+Z2UWI2k6F2fCqqpxtiZy6q0L7FYwgtE2n7P8fSWmhS
 a0GyMMCP46R9fAlmA6WZ3xcW27MOScb18JedFgI8EuNv7HIU=
X-Google-Smtp-Source: AGHT+IG1/QNcluBBP8K6+kGoGRWT8YvJ6lbBL2jybsVylMeHYFC0c2ABCm55hx9niJXTCKm+EHqhvQ==
X-Received: by 2002:a17:903:320b:b0:21f:35fd:1b7b with SMTP id
 d9443c01a7336-231d45bfa9amr212178425ad.50.1747727896322; 
 Tue, 20 May 2025 00:58:16 -0700 (PDT)
Received: from noble-leuven.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4eba49esm71544795ad.163.2025.05.20.00.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 00:58:16 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: [PATCH v2 1/4] tools: mkimage: propagate error codes from
 fit_handle_file()
Date: Tue, 20 May 2025 07:50:03 +0000
Message-ID: <20250520075735.132308-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505100852.9364-1-aristo.chen@canonical.com>
References: <20250505100852.9364-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 May 2025 14:28:13 +0200
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

The fit_handle_file() function previously returned a hardcoded -1 on
error. This change updates the logic to return the actual error code
stored in `ret`, allowing for error propagation.

This improves debuggability and enables downstream callers to
distinguish different failure causes, such as FDT_ERR_NOTFOUND or
other errors.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index caed8d5f901..3d2fbad3853 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -750,7 +750,7 @@ static int fit_handle_file(struct image_tool_params *params)
 	char bakfile[MKIMAGE_MAX_TMPFILE_LEN + 4] = {0};
 	char cmd[MKIMAGE_MAX_DTC_CMDLINE_LEN];
 	size_t size_inc;
-	int ret;
+	int ret = EXIT_FAILURE;
 
 	/* Flattened Image Tree (FIT) format  handling */
 	debug ("FIT format handling\n");
@@ -854,7 +854,7 @@ static int fit_handle_file(struct image_tool_params *params)
 err_system:
 	unlink(tmpfile);
 	unlink(bakfile);
-	return -1;
+	return ret;
 }
 
 /**
-- 
2.43.0

