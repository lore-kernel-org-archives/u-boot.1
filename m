Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F94AC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E27887E7;
	Sat, 13 Jul 2024 09:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lVsEaTsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F98887B9; Sat, 13 Jul 2024 09:03:46 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65C55882B6
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3679e9bfb08so1499047f8f.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854223; x=1721459023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6SxEJQQcIFhvLUs5YOUWN7LzpOrdSAVy8Y9BNloW2g=;
 b=lVsEaTsfesL8PLgiplUxLzublaKrNhcnDueQA5eIXltFUOGelqC7n/itzGV8ZKkFcB
 I9HFkzU3KlAlvcTIq9V2Y32sN6tf9FJu69j7T0U0KGISrKR9bdIXpSdWmVQgzdcpHkjS
 kj/ZXYGNuDjnHVGf/65Gqxml+ytPSOl/dfk/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854223; x=1721459023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6SxEJQQcIFhvLUs5YOUWN7LzpOrdSAVy8Y9BNloW2g=;
 b=RTXaJx8AyEuXnGCleyZt+7p/4+zQDeTwcgHUaPdEycroyw9W2stSQM9n6jNH9IxLHV
 cnayGwRIxdL/2uOb7+oiXVGnP62wbC6LTAU9qdQTJp4XG86IGLmty9puV7CXWyLtYGhF
 0iiws7XwKMlomlR1H5ad7r1Ec3pQu2xh5Bzhm2+D/1msGNVLYCr1qXv1w4C61t931P8Z
 mL0abe+VQOqk/U/PBSAneHjbyy5xXoNs28MuYMq9flxZ+PnJ+8UyX9n8ZmHIOg8VhP+W
 2uQU58lMcwzLY+5dJNXuVHadhrq3y1knWjfucYtVvhMPAi/l2cC3xIajPRQSJ6BOr/bM
 Ks9g==
X-Gm-Message-State: AOJu0Ywy8AJEQ0GKrM8kLy3gBUInO8ylMHczV+5p6hhhaZ3yaq/wXwPJ
 yav/ctUavEuDWBqaNAugA7iF7deRK26rc1VlX+ahnEJDgBAOfaosV+FD/MKgYXD21uCLBQotAgM
 =
X-Google-Smtp-Source: AGHT+IG6x8RUiwvalWND7dJ48aPLn50NC79Q/WrhMQ49ES5ucrlTkOpZkmcFxRokuyfUr4hxOP5cmA==
X-Received: by 2002:a05:6000:156d:b0:367:8fe2:7d8b with SMTP id
 ffacd0b85a97d-367ff70cc5bmr4641319f8f.31.1720854223402; 
 Sat, 13 Jul 2024 00:03:43 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/21] sandbox: Fix a comment in os_find_u_boot()
Date: Sat, 13 Jul 2024 08:00:36 +0100
Message-Id: <20240713070055.2172883-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

Fix a missing dot in a comment, since '..' is confusing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index 6a8a5e7b89b..1491d00504d 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -964,7 +964,7 @@ int os_find_u_boot(char *fname, int maxlen, bool use_img,
 	p = strstr(fname, subdir);
 	if (p) {
 		if (*next_prefix)
-			/* e.g. ".../tpl/u-boot-spl"  to "../spl/u-boot-spl" */
+			/* e.g. ".../tpl/u-boot-spl"  to ".../spl/u-boot-spl" */
 			memcpy(p + 1, next_prefix, strlen(next_prefix));
 		else
 			/* e.g. ".../spl/u-boot" to ".../u-boot" */
-- 
2.34.1

