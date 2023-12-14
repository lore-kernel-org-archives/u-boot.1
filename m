Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C518C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1692F87ACC;
	Thu, 14 Dec 2023 17:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RpfddI0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C40D887AD6; Thu, 14 Dec 2023 17:51:48 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51AC787ACD
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7b6f43740b4so328057939f.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572705; x=1703177505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6oIQefgMtqpis6xG6Hg9Li9bgP0R6wmvWJfX3noPTs=;
 b=RpfddI0KC+y93pXzzmQKwAx8C1EsnieCsizmmqzLEGO5izcg3qu2gJHIBxLzMzjIXs
 oMo/+PHHgLcA3sc5X9cKF6MJkBo1Hs3XkbDTOfQ0dQgTl8/aqCAMM+DjoFbUCQwRToOP
 MSCPRR1jpIr2Sn+UyXMXZ2mynkJ6lIegCOJPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572705; x=1703177505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6oIQefgMtqpis6xG6Hg9Li9bgP0R6wmvWJfX3noPTs=;
 b=dkzRWrF53F8lzI/o2P0vIRmEpHGn5fHKGcCzqX0c7r2jKgy6Ow0y8aJYgWMPhOSVY2
 iiw802pIvOyrqaQs1FJmE41sXtM+m7Ppe8mm1r5o+JFmjrkNs/bTtfcT2BPhxSMFojY2
 rx3GK5RzfMpcc8d3J8HmgNACWYdpITrO6EY4cVHa66iF3Cwh07EDTzUJ4NCkaFLasQGW
 n8NKKzIu3uuryh88d+p4fJoTo0WEcfZatdSrZs9S9h4kfAC6Fvnoo99gjP0Oznt3ohj1
 Nx4t8fzXT/HROVflPCYlvlQqgauFyQb2F+YZEmwaScYvYgAXtvtsHF4r5B/ErMm6IcFg
 wraw==
X-Gm-Message-State: AOJu0YyxhGfhSdV0jiJ2vQzfpmzynmd8o/syTouV5xwTEfc+T9ncx4Ey
 V5NTzROdpV/nI9OPIODIx6CApJTeXsFBkcrWYHCX1Q==
X-Google-Smtp-Source: AGHT+IGd3DZH/lyft/KnU3enOG8HTJaFM8ygG09KzdVYcTRhVwGWIqHDpZiXOZj/zMbH+9kwOiTvTA==
X-Received: by 2002:a05:6e02:4:b0:35f:83a2:d90d with SMTP id
 bb4-20020a056e02000400b0035f83a2d90dmr1068727ilb.36.1702572704858; 
 Thu, 14 Dec 2023 08:51:44 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-spcece.org>,
 Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>
Subject: [PATCH v2 02/21] m68k: Add a reset_cpu() function
Date: Thu, 14 Dec 2023 09:50:11 -0700
Message-ID: <20231214094939.v2.2.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

