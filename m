Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CBCE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD7D87112;
	Mon,  2 Oct 2023 03:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lAobuaT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50CD6871B9; Mon,  2 Oct 2023 03:17:18 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 420DC87216
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ae2f8bf865so8345290b6e.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209371; x=1696814171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzWoLU82ZBP++/p5qoxT3KLuipt2x8gX6kAgSIZ6vZ8=;
 b=lAobuaT44n+Odtf6qc/z+sNdVSjBM1o0dYoNndjZry1v0NU5OnUN13FfZZWS8h9GcI
 HshqUYQEj1w3LW1B7nFf52XPGujxjaDrk6ZUQSHXYy1borDnmIVhJD2TsIs78GJYmjHv
 vUMrm2+6oWMumiXWOPd1JGRVpsMM9o/rafmhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209371; x=1696814171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzWoLU82ZBP++/p5qoxT3KLuipt2x8gX6kAgSIZ6vZ8=;
 b=qvGhnuxYZsrDWJrpkNsn/Q/BpDamwa4pBZtSfPhtAjVlATCaFaoe5ioZm4hb8x53XT
 7oFn7li4ttpApuFl26Qf4MOjIK4p80rFCP/peSBxz9JeCNQ/sW8D6J+0xJpVN8PxOTAV
 qxyvg5Z0Y1onXgy+w7wNH6l8gZzdMqbTodTpWO22xrOXYO8fgxiF5ISh0g1vWcghSc7A
 6/R9iQJf30TjlzfB8Vuaxl0cSnNHjkm72B8qjPm2RijZQhyJcZuYEBxjOWTYGH+UzAkS
 NlB5GV38plSFy7rFjtaWPzBGZsDWV0m9uVn7fOlRe3bBAtXciCarV3NqtG8cBM+S78Lj
 Y4VA==
X-Gm-Message-State: AOJu0YzTvZ77qpbS1n7/N+CiinmVxe6ZquvVA9aaTtIPp0GNdWMu8xuF
 ZBgAde/kL2Y/1LEx7NVr0JDwELPqIiC1I3i5RlY=
X-Google-Smtp-Source: AGHT+IH7TPzhy5rdQB0v1fBySB+2I5kTgeR+k2UVPkdxMWBsFXabz1Jo4/X+xdHin5WTlI/vnAG6Tg==
X-Received: by 2002:a05:6808:d4d:b0:3a7:c2e8:5e7c with SMTP id
 w13-20020a0568080d4d00b003a7c2e85e7cmr13855666oik.43.1696209371317; 
 Sun, 01 Oct 2023 18:16:11 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 08/34] test: fdt: Add a special case for real boards
Date: Sun,  1 Oct 2023 19:15:18 -0600
Message-ID: <20231002011553.463514-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

The error that this test checks for is only shown on sandbox. For real
boards, there is normally no error. Add a special case to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/fdt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 1f103a1d7eb4..547085521758 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -160,7 +160,13 @@ static int fdt_test_addr(struct unit_test_state *uts)
 	set_working_fdt_addr(0);
 	ut_assert_nextline("Working FDT set to 0");
 	ut_asserteq(CMD_RET_FAILURE, run_command("fdt addr", 0));
-	ut_assert_nextline("libfdt fdt_check_header(): FDT_ERR_BADMAGIC");
+
+	/*
+	 * sandbox fails the check for !blob since the 0 pointer is mapped to
+	 * memory somewhere other than at 0x0
+	 */
+	if (IS_ENABLED(CONFIG_SANDBOX))
+		ut_assert_nextline("libfdt fdt_check_header(): FDT_ERR_BADMAGIC");
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Set up a working FDT and try again */
-- 
2.42.0.582.g8ccd20d70d-goog

