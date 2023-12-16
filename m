Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB0AC4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9707887BB5;
	Sat, 16 Dec 2023 04:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YT4U+nRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E5E287BF2; Sat, 16 Dec 2023 04:15:15 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08D8A87AFD
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7b783ee6d73so54566539f.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696509; x=1703301309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6oIQefgMtqpis6xG6Hg9Li9bgP0R6wmvWJfX3noPTs=;
 b=YT4U+nRfi577Cm7kFgIZYr79yeRUPaH9VCF6hrxoF/5vrq7IXauKXUStWN94t81B2C
 mNaAMVon1VFmMraS7Y94pWuvdlXmR4odQn+iA5/dcpM7ZcM86lSt7oLrAlpyZtpRR4BV
 LfaiN9AhmgKR/lQ1EZNex+j0fnGebHTkXHy0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696509; x=1703301309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6oIQefgMtqpis6xG6Hg9Li9bgP0R6wmvWJfX3noPTs=;
 b=CSeFE7mgrg2DYGF8dWecjGxvA/8l/qM3A7SzsW7Ki+5c+Udt1/ga7T5Dw28Y5Kra1b
 5QAUzyoAw2R2D2/K0dGVES0ZZiWIMCFqlQ7/p4i1DdRAOt2kx5J41URIYtx/GU8Q0l0Y
 tDc6YBGZIBYG7CZjHGXMp6JEW5TIZ+41e5g+5UDBldJN8XcojLM1cOez4zK8aVERE/Bq
 mqS2peYGh4uhQGuepxQ7C6Bd8F+aCTT09nAbByLzOWy7eUaZvN3u8+zVjClWIl4vn1Y4
 1xCI4zdN9PGsmeVsuKTYUIUe9UX/AsfxQGHCaKIoN76pr68xOPcU9cxOQ2LuBeSxXgb3
 3cCg==
X-Gm-Message-State: AOJu0YyK+FiG8QE1YOhay194Djuti5M0hWLazD1ijELU2EWVvR8oRNs7
 f01zq/yms8cLKINltLnU7A/eMXD+gHM7LEQO/5FeAg==
X-Google-Smtp-Source: AGHT+IH4x1v18v9neDuWuqZx6wb9FwtgMxazAhGGresq6sTwYsNLCjJ4aZdjGgz9EIQNMT0296iLyQ==
X-Received: by 2002:a05:6e02:3a83:b0:35f:989f:bf49 with SMTP id
 cr3-20020a056e023a8300b0035f989fbf49mr1226003ilb.26.1702696509523; 
 Fri, 15 Dec 2023 19:15:09 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-spcece.org>,
 Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>
Subject: [PATCH v3 02/22] m68k: Add a reset_cpu() function
Date: Fri, 15 Dec 2023 20:14:06 -0700
Message-ID: <20231215201413.v3.2.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
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

Since there are lots of reset functions, this one actually just calls
do_reset(). Future refactoring could correct this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Angelo Dureghello <angelo@kernel-spcece.org>
---

(no changes since v1)

 arch/m68k/lib/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/lib/traps.c b/arch/m68k/lib/traps.c
index c283351181d8..ae8ae6ccf592 100644
--- a/arch/m68k/lib/traps.c
+++ b/arch/m68k/lib/traps.c
@@ -7,6 +7,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <cpu_func.h>
 #include <init.h>
 #include <watchdog.h>
 #include <command.h>
@@ -65,3 +66,9 @@ int arch_initr_trap(void)
 
 	return 0;
 }
+
+void reset_cpu(void)
+{
+	/* TODO: Refactor all the do_reset calls to be reset_cpu() instead */
+	do_reset(NULL, 0, 0, NULL);
+}
-- 
2.43.0.472.g3155946c3a-goog

