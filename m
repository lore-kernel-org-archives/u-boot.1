Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E96CC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E70FA83826;
	Thu, 24 Jul 2025 11:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cY9hV3XX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DAA836B8; Thu, 24 Jul 2025 11:14:05 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8CC836B8
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso7913015e9.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753348443; x=1753953243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hu8Mcop5oHsyYfnc05G9Dt9IKwWmHTSu5i1lxRHuwao=;
 b=cY9hV3XX49j98zukEQG7AiU/KtPazVxVYxh6FyiRy4rb0nNDtAllL1K7kg6quiDQl1
 t2qV+zaste6hHelWGpOGZ4DcCkshAUwiBnnzHGsbKH7I8Vf2I4X5uAVnLjxstowSXEM2
 SfQsXOXX9Kb/WXOwbC5kc51MOTczCTNlSLQ+6lcKb585LtKynz+QXK1Dn9dIuyLKebsj
 Sr3Dc8nlP1H/sM8JwDQyjAXXg8ABkWDhfA+g/reqJei/2VrvzTgYLp/Ln/GJZ8hI7Yzl
 V8fOaooD62fzAyX81rNDyEy4nR0Gz7By37edzTYUc5qL5EhW5VQtZ51XBrMvR09189CC
 IKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753348443; x=1753953243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hu8Mcop5oHsyYfnc05G9Dt9IKwWmHTSu5i1lxRHuwao=;
 b=HhBYafk4T8v1AfbyXtCoq9DivKX4no3A2oLiS88VjH/9rwvJHlgtXYowsKJy3ZDgqE
 UTFvLn56OKqORbg30C++UodsYrT0ArTOhPUcQTeZnWTIP3pi5JXZPPETVqwLBjD6Teq4
 YQ35tgkvltlZ20Znv2T4NgsZaeiFBE8Ad2R3IwTm+MGduMuRi+FgzeFcvaS7/P81NtV7
 FafJWu3c72Woh5qHdnS1mzwqFMYlJQj/22ca1m8FH1kiNbeCnj5WujrwJ8/C6BkcROEQ
 a+pfWQ+/B68C7jU5EmQXFKTe76QYt0xvE+RLDkVTShWyWUZ8hVhvuZOzE79CW0cm+qhZ
 cFOg==
X-Gm-Message-State: AOJu0YxUiMDaxEzVopi3CZYQOoXa9lXtvH17Eh7868Z9a+z/NF4bTL6x
 UjIOLPGqNaz0jejXw42UU7p0hO2vMwk4osUjxHQLMvAPynAoe9B9DRTvvditRSepNJBygdJ2w/7
 y9ZPu/EzyzQ==
X-Gm-Gg: ASbGncvzqQfhgQQWrDpf4lm7ssZ196EzufCpNlhQnUnVjZq+kPV6/AYQ/sdFP+BIchx
 pngXS2OPIAt+LqmFyOkCxsdAaj8TY6AWg2+xHfuORBR2IKAQiMJK25hxFc/+ofy5aKj8CXiUcdM
 nFfMlHB24LGe6HQOL6ZEmxBstspK6ybXZp8RH3J2kiVbPV4cMZgKW5jUFF6yNpQMtjqT4zyOsgu
 f1G8CFCMWzMMj11g5QuampJfcUKxJonwFmqUC1f+vLviNYGWUocM27y7Kzu2WbEEsvFRP2V6iPO
 DSIDEEDXB75chdjw/FWwJyl1VnRNfREc3JZ7LHV5lzzJE4vQs5dKszfWlkKTk7Z+Xs7Pj6mEwpF
 DG4Utv1yo+s6nsfjSknFTds8ejB6XgsEG5+yRC5F4
X-Google-Smtp-Source: AGHT+IEIz+HGXg1T+cjKnTLym5fR1wql4COq4F0hCTMAnVvGH3q399+Fhy1k113Adn0aJXnyF+5cWw==
X-Received: by 2002:a05:600c:64c6:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-45868c8f506mr65228855e9.2.1753348442475; 
 Thu, 24 Jul 2025 02:14:02 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bcf7:2df7:a82:bef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586ec63d29sm15522595e9.1.2025.07.24.02.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 02:14:02 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/2] binman: bintool: use apt-get instead of apt
Date: Thu, 24 Jul 2025 11:12:40 +0200
Message-ID: <20250724091342.59902-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724091342.59902-1-jerome.forissier@linaro.org>
References: <20250724091342.59902-1-jerome.forissier@linaro.org>
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

The 'apt' command is not meant to be used in scripts or tools. Please
see the man page [1] for details. Therefore, use 'apt-get' instead.
This avoids the following warning:

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

[1] https://manpages.debian.org/bookworm/apt/apt.8.en.html#SCRIPT_USAGE_AND_DIFFERENCES_FROM_OTHER_APT_TOOLS

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v1)

 tools/binman/bintool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 81872db377f..f46bb52a7b3 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -421,7 +421,7 @@ class Bintool:
         Returns:
             True, assuming it completes without error
         """
-        args = ['sudo', 'apt', 'install', '-y', package]
+        args = ['sudo', 'apt-get', 'install', '-y', package]
         print('- %s' % ' '.join(args))
         tools.run(*args)
         return True
-- 
2.43.0

