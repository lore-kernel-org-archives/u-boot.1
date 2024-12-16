Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C563CE77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 18:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E397801CE;
	Mon, 16 Dec 2024 19:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NqfoO9OL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 053B0800D2; Mon, 16 Dec 2024 19:08:05 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECEA9801CE
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 19:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43635796b48so15513215e9.0
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734372482; x=1734977282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hO6HN/1ZHKXZDlbmBO3+BH1EtfZLQTmPvADU2ZuQYXc=;
 b=NqfoO9OLFFZhwD6qqbYCFLI2pmdldHZ7nARuELQXW5/FdXsKuf6dURj3o19+QHAYMl
 tjUMFuUzPgCYAyOXZn+r+2ev5W+E0Uq6iEJDfyYNCO9qJl4dFBnm5ZSxZNkUVYoi+Ufw
 OzWfWzYwjJDvIYOiaZeAT26efZ9boet99LJBAiOXrJ0FyL4tz23Y17E8z7csVKELviMS
 n4tBsD53p8kn2c4HFedyiB1qQJbkIW52zNt5KbCPDbc0/ggV/5jShtT87dqeEFoTDhQ4
 xJ7nCc8CiQM/oCmVjrVrPIpDcREwSiJrXlpcf115WNkl/K1Df8JEa3qnDqNs0NiUy+q6
 SWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734372482; x=1734977282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hO6HN/1ZHKXZDlbmBO3+BH1EtfZLQTmPvADU2ZuQYXc=;
 b=R2UkjcCgmZAn0rBvbWPzV4xb8OrDTb9GLFEf1DL8FW7KZt/GLxE+trEnDDmxHxXPa6
 hGGvS4XNCg19JRbTDU0QMMTaTZclesyKnOgUpr+nwRLpLJSpl7py9uvcb9N6i7z9EQQ3
 nqZSBP2vDkY+nGzE9p8qW2lLnBptgPrMnpvUxIGpjHpBIog47Ll/ii/cZqLb7Z0HivIa
 J5870pobXOUzbDYuuEw4rS0bjpgydm05HSAgKWpwUh/tpZMtoLBdkucKMi1QsX2yz2qj
 qKi/8dIOzqYrkRd1QM+Mz6nCKF3Ti5so5Bmqap3S24CQ3gKBEnNu2aH+UTfeoqdwfL6S
 2Nlw==
X-Gm-Message-State: AOJu0Yy0+OJZNQY5S3G++1eubmuoS+TknqhyIDLc+5NQnzM315XO1YYL
 jsrrpQd8XiPDR6HWXhuSAKJpD7kDLbp4+1dguV5k0yv23fGdQBWPKTnGoQBfOG6qIYADN+9Si+u
 iM2M=
X-Gm-Gg: ASbGnctsRPoxcAKk2xlIXpzRLOX9yMGstQUpd9SPdZGnypoR1S7x9GdX2xEGe24yfSS
 yKglynmx700XcjozFneUDeh2xYOHNABh2MqWha0ZUsTxvrGke66E9O5ToECbec8q4ent2EEOr2K
 qs1BkECG+QWyt1dG8skSOIggJZGp1dIoFvDIFEW7ZScrsPJ1jjU8gowXdbQdDYh9h0ut0MmBJvx
 lM3y0+Ofm7rkflNzFNwthV7xs1HKLZM7GDKjlvpVEtsAr1ee9idQoFfP0FXuwO+fvD4/NrE7uSh
X-Google-Smtp-Source: AGHT+IGIcKG4oYgZYmdlj1KomR5Ve99YJtZrgStybynJxeAjZLveIdm+z4U6PXwjfY0cihZTjjNjHQ==
X-Received: by 2002:a05:600c:510a:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-436480633f7mr2961405e9.0.1734372482491; 
 Mon, 16 Dec 2024 10:08:02 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:ee3:c001:477a:6a2a:86f6:a454])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436360154absm91501605e9.2.2024.12.16.10.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 10:08:02 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 4/4] test: lib: Use CONFIG_64BIT to detect 64 bit compile
Date: Mon, 16 Dec 2024 18:07:36 +0000
Message-Id: <20241216180736.1933807-5-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
References: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
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

Should use CONFIG_64BIT to detect a 64 bit compile and not
CONFIG_PHYS_64BIT. This allows more platforms to run the
full test code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

(no changes since v3)

Changes in v3:
New patch added for this version.

 test/lib/str.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/lib/str.c b/test/lib/str.c
index e62045318c..48351abc75 100644
--- a/test/lib/str.c
+++ b/test/lib/str.c
@@ -224,13 +224,13 @@ static int str_itoa(struct unit_test_state *uts)
 	ut_asserteq_str("4294967295", simple_itoa(0xffffffff));
 
 	/* Use #ifdef here to avoid a compiler warning on 32-bit machines */
-#ifdef CONFIG_PHYS_64BIT
+#ifdef CONFIG_64BIT
 	if (sizeof(ulong) == 8) {
 		ut_asserteq_str("9223372036854775807",
 				simple_itoa((1UL << 63) - 1));
 		ut_asserteq_str("18446744073709551615", simple_itoa(-1));
 	}
-#endif /* CONFIG_PHYS_64BIT */
+#endif /* CONFIG_64BIT */
 
 	return 0;
 }
@@ -244,13 +244,13 @@ static int str_xtoa(struct unit_test_state *uts)
 	ut_asserteq_str("ffffffff", simple_xtoa(0xffffffff));
 
 	/* Use #ifdef here to avoid a compiler warning on 32-bit machines */
-#ifdef CONFIG_PHYS_64BIT
+#ifdef CONFIG_64BIT
 	if (sizeof(ulong) == 8) {
 		ut_asserteq_str("7fffffffffffffff",
 				simple_xtoa((1UL << 63) - 1));
 		ut_asserteq_str("ffffffffffffffff", simple_xtoa(-1));
 	}
-#endif /* CONFIG_PHYS_64BIT */
+#endif /* CONFIG_64BIT */
 
 	return 0;
 }
-- 
2.39.5

