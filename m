Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17D1D6B6D4
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 20:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A55B89255;
	Wed, 30 Oct 2024 21:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gozo7YfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A20EC89257; Wed, 30 Oct 2024 21:41:13 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B589789250
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 21:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d4c1b1455so197737f8f.3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730320871; x=1730925671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TSIdJGJ1wGgGaCOpzh4/UzsIRvE+gXp92zLNUF/zjrQ=;
 b=Gozo7YfVeuUkS4iRFSSQJKqkt2Eh/7spR+7QSP0ttjqcDdbYR8tefHDn8puaCBmiCP
 cg7WNGcv6nOZvldcsWVSP093UzfjBNJfaHjUZBJ3KMpZFpGDw6F7dWjFFaIHzFfdVgYu
 e6Rm+DarPN/gcaAg39MBxfv53kY+xtg3qhHI/+y1t9yF4k0uGf966WfOuS0DfV6vGqyn
 ypNB0pmsMrNynLY1auUt8ciARQUnutCjjmnXQIVjRpoCVppGjFwUHqQnM0FF7OuxBTQN
 NJ6cEuKuI9b9CFQ1kkpy98aZsz8z2voH0WYbRXfcyVcDZpG7Lumtj9fpAnoKJlylTk6i
 LvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730320871; x=1730925671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TSIdJGJ1wGgGaCOpzh4/UzsIRvE+gXp92zLNUF/zjrQ=;
 b=op+MafiXD73+TAdppHNYEuMmP5DmsXiFGDtLV0kvBjO7aoT4/GDX+1qJKDFrSxezT1
 HbKZk0VtSHNxcLOfNXCEiYrrp3KdoFa6z3N0aautG3gxqF2fJdt2kFEvYeDrXKpLX7aO
 sI09FeQoFbQgoEUv8uhvZ8V6loXmm2BzSjJixVSrxriwK+WfTbOZr6wfsPPUoelin60o
 COFEz7qnbRpweTgDYu96zwAmWjxdkH6u4QmzeMW86by+B0PVwFwO9TleBEeur6U3Dgj0
 NxIE/FruFZsIlQNqsI3Z72xXdNLJ9SErpdSxoroxeyYyJiSo2JdxqG1HAOuJxJ5rjfqD
 mm8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXinsEatWJsUvmy5vNxC3GDC55yH8vdFMxXib7AjGejpHPvmTn6Dr0EXH2Pr2nA1h4ebITVmbo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyka2FRShQMp+hPVaDXPidIwE3kDZaWMXlJ6JPYh4N1v/6vZFRG
 HqcmSkLqUmx4fgx5ptnoXf6NH0z6bUdKv/wd7tug83wRW6+TEIa2ggF3bzrEfjQ=
X-Google-Smtp-Source: AGHT+IGQ+M1M2a0KmCzb6DOON5g6vjx8wpzRMYtZm4VYqDb3qTJLtUkCA+9TBCmUU2yvbhl2jMJmfQ==
X-Received: by 2002:a05:6000:1046:b0:37c:d537:9dc0 with SMTP id
 ffacd0b85a97d-381b70578bemr3502539f8f.12.1730320871046; 
 Wed, 30 Oct 2024 13:41:11 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d49c9sm56346f8f.37.2024.10.30.13.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 13:41:10 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Make tcg2_uninit() static
Date: Wed, 30 Oct 2024 22:40:59 +0200
Message-ID: <20241030204100.90946-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

This function is only used locally, so make it static and quiesce
the W=1 warning

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 45f451ef6b6d..866a529857ef 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -789,7 +789,7 @@ static const struct efi_tcg2_protocol efi_tcg2_protocol = {
 /**
  * tcg2_uninit - remove the final event table and free efi memory on failures
  */
-void tcg2_uninit(void)
+static void tcg2_uninit(void)
 {
 	efi_status_t ret;
 
-- 
2.45.2

