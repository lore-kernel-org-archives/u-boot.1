Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD235FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 10:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 900EF841DF;
	Mon, 27 Apr 2026 12:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DpkTP2T+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F968423D; Mon, 27 Apr 2026 12:08:58 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED302839D9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-38a01c80c34so97665171fa.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777284534; x=1777889334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=981fWpuAbK2bvrnCZZVrwADu5/ky6PA26Iw6kXj799M=;
 b=DpkTP2T+PSsn6QALxoPN4NVGU3WiB/3RATJ5Cy7QEnXpZpBm3uP3PjMRNc9WPyRbK5
 Pqx5b07rPuGT5gIXkN8CXVI7JoD9ffNdN4xUYbW96EhYFCVHb6UrzIX/tr14W5Wf6yEY
 zqOdE69yfGTTm4t9l3mDzWNw6WcCbobnx7RX54z0LMweUJzLabYGglUwlrr+XE/xEK7l
 H0YLKkUWCGJGm22BOmFtghM0+PDsYL6HikEkg9Lmxez7hYBykNjgt2Ji0IVeXlgHn/4I
 xa18YHu8ja+DVL2ob7d8TZdz3u5THOeZ6wTrUffxb8P6c2FNnnpAZwwssEp7IcovodmC
 aB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777284534; x=1777889334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=981fWpuAbK2bvrnCZZVrwADu5/ky6PA26Iw6kXj799M=;
 b=BIwM8ZyOoVK9OMyg++do6PRkhxyQGd2gViKq5SJtEOURES+3AnOJM7U5WeK93j22OB
 f0pDZfgC+63BMrC6QDd9tpWx9jsxI+7Wy9wJ4C0NFAtvG8UxR/K2D5d0IxclAwybA4qN
 7AezYhb5ZbUTuxVoAYU8c2xOKQXtG7acAvSs5QDIzRuUNEBSVKCbuevd2zHPn7rQHbQA
 BU3DrzdF2STG9kze7nuNfEHDx4Io3Z8uhZw/wIVFTehvKtolWMu1Rr77rAIlaxEKGx2B
 uwEN+oMk3jhRIRKOaEwdh/npZUCSZsAn63EhzWwkZxZ/RfPlLXkFWf3Ka+NuWDP+PaeB
 8ZBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xPB9LDgQ5C+WjjqbVejcXIm4sPDr7dDSpvzE2+JgGR5fT158rTH0bhJAATLfhQ1cy8hMDLGA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8KuvegeQqrKX61hnOR1FTs664y3bMpheA8QgBhLgcIAz6S9Xa
 l5p+rin2bxZwzLdIOk8anF70vPhSqSs806NzQyvKlFY8wKCbtwX9MO1v7Qx1AOIHuVU=
X-Gm-Gg: AeBDietrUvfPBmYW8bifKlC/B3haMX4c2djbeOrwSqz2yChSsfj6vvMHniP308e1845
 XQtCLJ8FG9wncWQSemp+qwHuZi8uvRty84wl1/FRmdicWwWdojQMDYpLKvO8QtKAz4wo+Eh7ZFW
 2eqoPsgnA5tfEMLVel9UKrTvaqGsSevkeR3oHgfHebZpNgq2wXzDHVWJUE8xOtXSaIT4Tx4l9aA
 +C2n6BqYPIFh2hKX3GUFtt8KqDOBoU0gwPxnrNK87LFIPDo7tHOxC5vYpLPXibkAvdRfp4EWThM
 +u97UkCPX0Fo74ZfyySU7/0z68fMqCvQiK8DtoWeR4HQW8GAxRwjO7oTuYTAsyuxFW5EdsKmn0S
 lJpJTHIQLrclaelkpe+po9N1WEElJ/CpZLJt77PFh6JfNEo5UukFXL/Yov4bUjBq4GzeKHFBYHM
 ySKaFWWzvceV57J49Q+f0T/wVnENKuVbKUIrn5IABUmEmepyb22mgQaAuYe2mAnuRNVByIP77IV
 90F1bAU2Y86xcS/Xy7MUarv3LomgSG2RmLshQIs3Svzdt9HZAT6M0DBAAGbrHrIcewlKn9ccXgi
 P2JO/l7xc6P7/52WS+NGkRurH646Lb0kj2ZfmUPlAxLTVI8y7R52H1l4xaY2rXt76WIzax66MWD
 VaAus3U2sodFG1C5VahtyYTds4kiH2rS2Jf9KfgMHjECVdaZJc+5PcFPBXVPSTyEAwkG+/n3SqI
 Ak8jx9Rvzb+bQ1PO7LjtpORhF1Ani4Y5xuwgXSuiD6I+oyp8sBfbvwxqx/MK5OrCsXStVwp4y8L
 e1bSoiIOIDVKl3fv6JylZQm/yg/V2+kXQ/y
X-Received: by 2002:a05:651c:b29:b0:38e:a181:9e41 with SMTP id
 38308e7fff4ca-38ec78353b0mr146692181fa.12.1777284533984; 
 Mon, 27 Apr 2026 03:08:53 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb6f0b88sm68554791fa.27.2026.04.27.03.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 03:08:53 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [PATCH v3 4/6] common: move ram_base calculation to independent
 INITCALL()
Date: Mon, 27 Apr 2026 13:08:25 +0300
Message-ID: <20260427100832.581887-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
References: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
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

Currently, ram_base is calculated within setup_dest_addr().
However, upcoming patches that enable U-Boot relocation to the highest
DRAM bank require ram_base to be initialized earlier.

The default dram_init_banksize() definition relies on ram_base
to calculate the start of the first bank. But following patches
will move that function to execute immediately before setup_dest_addr().

So let's split the ram_base initialization in its own INITCALL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Michal Simek <michal.simek@amd.com> # Versal Gen 2 Vek385
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index f0d07cb6f593..ac4dbf89a2e4 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -328,6 +328,14 @@ __weak int arch_setup_dest_addr(void)
 	return 0;
 }

+static int setup_ram_base(void)
+{
+#ifdef CFG_SYS_SDRAM_BASE
+	gd->ram_base = CFG_SYS_SDRAM_BASE;
+#endif
+	return 0;
+}
+
 static int setup_dest_addr(void)
 {
 	debug("Monitor len: %08x\n", gd->mon_len);
@@ -347,9 +355,6 @@ static int setup_dest_addr(void)
 	 * get fixed.
 	 */
 	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
-#endif
-#ifdef CFG_SYS_SDRAM_BASE
-	gd->ram_base = CFG_SYS_SDRAM_BASE;
 #endif
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
@@ -968,6 +973,7 @@ static void initcall_run_f(void)
 	 *  - monitor code
 	 *  - board info struct
 	 */
+	INITCALL(setup_ram_base);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
--
2.53.0

