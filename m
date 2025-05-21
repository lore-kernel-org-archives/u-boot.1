Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDACC2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD0882F33;
	Wed, 21 May 2025 14:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WmjWq6NU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BEC582D33; Wed, 21 May 2025 08:28:39 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6241E82BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so6223270b3a.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747808916; x=1748413716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUWqZEoeCOPi4kA8iZW60G/CH5kQ9HtU0Ua7T5EZUM0=;
 b=WmjWq6NUAOYWa0ekNyaRtAin/zOHYkmsofJmREJzlEIjjHyT0tkZwT4/MzzN2nVQuG
 HGFRyQ5eWHDe6AW5kLai2rwN0rtzFa9scikUL9k2rSkwnZMeovGI2kRNXIRyDi6q0SpU
 n66IKvycPw9SusAjciP/6H/Fzxk1bgWyUVI7Fexaycg6ELXhz2PzEcYoK0cw/RYOATjz
 KBWeeq/6YBvmilwJzLIbFsBGW8prTZIGJ/1c713Mufs63/jijgDgltRSbyYzt4L4cynF
 ineeoscHKyu9ulP+HI8DAvNni1o60BqhM9H7fR39gJmDSDZFblI+i+XDzD0gLmp+vDDw
 TKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747808916; x=1748413716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUWqZEoeCOPi4kA8iZW60G/CH5kQ9HtU0Ua7T5EZUM0=;
 b=wOuALD9+YM2upRDCqCoap2de+DAu9rI5Zzi1RNNYwHIYaLl/g90uzyEp2iVihaDv+k
 C6Gqec41i7HNHA4Ol4rcUQp9adJfmn021LrEIn+LhbaMhjoa8BCHOyLykmmnC/+jvTJX
 5jwjfSIzy3HEm0Q8GAto+rJuMDvK4i0FgWLHAn4Sg1CKiB8tGkbuXY97EwD0jeCVYO+2
 dpp1+Dtm0YUqhxtyplPvaXrKJzeYRW7jzxE/Rtl9zQ3J/erlprJNR/5/A+zsCWyx8EkY
 mMyPmInXaETRw1GciugdZof0Em5cBM9GZPinrtZ9Hg4L6p4n5jEL9C9HTKuV+/u80teX
 55/A==
X-Gm-Message-State: AOJu0Ywzl4Ro7JDjMeJWnJUY2LI0Gzknx/kBJyXm7AZwBLqVeqtELQH5
 lRf6h1KYQIn4XdYIirCwb9OwFOJ4e25hOkhILkVoFNh8Zxy1M2Dwt6xIMVs99fFt
X-Gm-Gg: ASbGncuBdyKe9C5gTXy3rhucmnhDoOFHsHFeMPuGm9w9JeWAngRYASpBgmcptBKutFr
 jXkqpqnrCPkKq6jhEDyTDdS/aploKhzThdNRVfp1K45NyPRDb4oalSmKSb9h2dRZeplQNtOb36h
 MAtHIWrfgiWXRkkQakwe4ZL31ULFwls2SgJhoqtc8kI7spRvR8bsVAKJGS6YrTGjwLJfRmbmWgE
 TnaGTBWu+KAGvoPZwasc+0J7XuzRfDzbSy5DyEbIkvi7oohMU+hUp5kgfQV0tjBOOEbKmDow5S8
 D95Ag9djPH2ZZt02FxaZqb/pkfmqdH77F8POc+8fz/THtckMQAVb4KnCV/CkjT52nY2YnX9kcFV
 tUOFlhj6ViTYUW9rR6ahJRNbDJ1Qo
X-Google-Smtp-Source: AGHT+IENxRnbfSCPBAltI3tbWcyyp5OLthdQlkwPqcicHuE6xUe2kqhGBFKyzqWDmDnGIgcw7R1mmQ==
X-Received: by 2002:a05:6a20:d494:b0:215:eb10:9f13 with SMTP id
 adf61e73a8af0-2165f87269fmr27568269637.17.1747808915650; 
 Tue, 20 May 2025 23:28:35 -0700 (PDT)
Received: from noble-leuven.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a982b884sm9277911b3a.95.2025.05.20.23.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 23:28:35 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: [PATCH v3 1/4] tools: mkimage: propagate error codes from
 fit_handle_file()
Date: Wed, 21 May 2025 06:27:42 +0000
Message-ID: <20250521062745.3458-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521062745.3458-1-aristo.chen@canonical.com>
References: <20250521062745.3458-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 May 2025 14:36:46 +0200
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

