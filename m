Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DA4CE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E385986C91;
	Wed, 20 Sep 2023 05:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jHaM1/14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC0EE86CB1; Wed, 20 Sep 2023 05:00:51 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA42F86C24
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7927f24140eso238749339f.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178848; x=1695783648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NLbWOZoHWYi3aEf2HOHpznMQoy0FDzhr0usXmb4hp0=;
 b=jHaM1/14zEs1bIMSVcLVyaRonvEGjHpD4NlQZjPFXMWTRexlEXSxUgqvV7n74PSa6p
 LPc9aA5dUfDVrbppB6ELoEfQnVy81zjbAi9usnktV9gTfK33mXpHdS4/Vo5r5BGsYQuO
 7Xw6U7RxmtwhfBvO747/3St3n+7mlisthKkxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178848; x=1695783648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NLbWOZoHWYi3aEf2HOHpznMQoy0FDzhr0usXmb4hp0=;
 b=roxhComdH4VEu4r0yyNTR4utUuY/K3e1y9GxsqPj7rc2vkPYiBGTNik8dyLmRA9DKh
 VxYUo2YY1BRuxuwvOrHBtZU8i6eCZRZixWAlCty5yWiJjkRrGrO2TTslpAY7jZBB8Khs
 Eugs+kwFeDQB+nHH7OfloThwyLja6VednlsQIZFc3pS2spmpPKYEODeLWekv7sNJQ+NT
 WFG8QfqN4RcdZWg+/s4EXPvQe966cAWgzqckUlYPia4sxg59kZjxHDlFv8/IUJlnnqQ7
 iHIrHNwkxwVKSI84KBiTgl8ti6fKDnhJ0K+BjmCNmHjBYi5KA/02UPo6aHXeC0zfGyb0
 R9eg==
X-Gm-Message-State: AOJu0Yx7ZVEpkH6jQ/vKtHU1zbBHk/77tLKnFtS+DAT4SLTJKV+K7mrA
 YkgT/mHnbglp8P1kKffnlYI5CBjcf0xuzq/+3cc=
X-Google-Smtp-Source: AGHT+IHcbaSwAs7VXgQjhB2MJlf59vWc0bX9mNoMFnfsPlc/69QQMh3bXVypLzJgRryDTcjkFzn7gg==
X-Received: by 2002:a05:6e02:1a82:b0:34c:a166:9866 with SMTP id
 k2-20020a056e021a8200b0034ca1669866mr2005119ilv.4.1695178848514; 
 Tue, 19 Sep 2023 20:00:48 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 20/20] x86: doc: coreboot: Mention 64-bit Linux distros
Date: Tue, 19 Sep 2023 21:00:21 -0600
Message-ID: <20230920030027.1385833-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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

Add a little more detail as to why coreboot64 is preferred for booting
Linux distros.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v2)

Changes in v2:
- Add new patch

 doc/board/coreboot/coreboot.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index 3ef563b71dc9..10ef78bb5ada 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -82,6 +82,8 @@ build in `$CBDIR`::
       -device ahci,id=ahci \
       -device ide-hd,drive=disk,bus=ahci.0 \
 
+This allows booting and installing various distros, many of which are
+64-bit-only, so cannot work with the 32-bit 'coreboot' build.
 
 CBFS access
 -----------
-- 
2.42.0.459.ge4e396fd5e-goog

