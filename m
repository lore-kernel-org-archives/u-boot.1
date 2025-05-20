Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCCBC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A277782CC9;
	Tue, 20 May 2025 07:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TxuCUhvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0819F82BD9; Tue, 20 May 2025 07:22:41 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA47E82CBB
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-442ec3ce724so42137865e9.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718558; x=1748323358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gz0FBT2PRpQ7wti3FF8BzG2UcXh/a7kQXjjzcGtZsCQ=;
 b=TxuCUhvKlEMSJnVVFsdL5fpbfOB6Lry+PvWH1B6iPvbsiUh7CFNzCw0TnU6TTt7z1l
 D2I8jLbFR8QrmZhxtQqDY/4AO28KDaGYMto4qg+K/KFLKQKFc2EqmV6kVMQnolYwv4i2
 8X1pCTQ9vHqL5E+nMgIdW1HJHLA7+9rZjXrov9QuJjtM5SRnMCRt9q3m/MEPm5AfSuBO
 hyy/zCHWn7AqRWMbf8bHBXARFGL3v682/1559zMnAYXWXhlBjVdkqKs9eiERo5Ix/m+y
 jL5lAXF0vkSZQiY5Q4MpUvfqxeVxJUgG7q8po/Z+klI4c/VM03gyIEgAJbOvYOVsJQK2
 005Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718558; x=1748323358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gz0FBT2PRpQ7wti3FF8BzG2UcXh/a7kQXjjzcGtZsCQ=;
 b=GbyS4hPnPZJnfVBgyzCcK7acm9s/3jj4VTujRSNfh3LkWvxLDh0gwgTAlOT///Alkp
 p1Ne3MXFPBBW+S0iLmUlbnF5l43UrraVjoxc8qv48u5Bq1/X5RW0avPxk8R5hb40VDy4
 ZtqyRYpM7wFs8t9K4BAMQgoIDfpsvePufVKLJUqXEJsxZgC6goL2FwjiCe5fwpJdcm7d
 GHDKk+oFQmkRMWm3JYsVIMA0yzN1S0sxLqRt7cgglyC91uVMnCr4O8K/+U24gt6LXuay
 4XM5H5OB2xUT2xMZpdt9HvP+lJbKWnfQ53+Q1g4CHd+fd8UoE4Yk32vA0eJc20zX2qcz
 ayWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs5fjqgptoqDSjrluIJpiodkSiIBOdcx6QKAN6fV+cYp4cwoObjhqlM+ms9+VrvxBQWz9XIus=@lists.denx.de
X-Gm-Message-State: AOJu0Ywhigx2xVQmd+ecmf+RTxk0eCcraIQ05RgqzuqQmdS64mQOR9h5
 LRvuHEHK19H928iyTj2rAJ4vKXI2lAMdW2WH99qE/39J1y6YwqoB//fBXW2efJBkwb0=
X-Gm-Gg: ASbGncv2h/wnPKGkRuYRO0iPKzrG/SNi1+EQBv8Mhs4pwYs2dIxTBVzk7d+RqDEL+MQ
 Bom8GiFLujNh4P+vDbeRAG95hJ7eAWIv04OWcBPv0zpbe0XOGHx3/O+DEFibYYnTDGr7zSGRIsy
 eNoN1h/9z4pa0H13dBY0oyKhHh2zZQi7CglAI5XJo23EorI5Nr9aCyOimvP5mnik82RzMV7HMDU
 BKH75YnUOsAPr1TwbULScwez/a5STGYcEGdgtFuZIaMV9mARtwGyqSnc5mptSeozNA28welinX/
 cZ3Aew3qNjfRHx636I0MgYzQd/BQCZTbjKvOQ830IW9f+rvGB5rx1Kg5PZxhIRrE3XCX97DgoHU
 =
X-Google-Smtp-Source: AGHT+IEQxnOpIMHAt+AxHPNqTNWwoXkAfZJr1Ytpg+qG5Dpb9MXU7723SyujZc0LXWwCto24FBe82w==
X-Received: by 2002:a05:600c:5247:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-442fd60b4e8mr119775415e9.6.1747718558189; 
 Mon, 19 May 2025 22:22:38 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:37 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 16/24] kbuild: remove redundant 'set -e' from cmd_* defines
Date: Tue, 20 May 2025 08:21:27 +0300
Message-ID: <20250520052153.307194-17-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 5439f09f488f ("kbuild: remove redundant 'set -e' from cmd_* defines")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 80caddde09ab..fa91445f132b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -159,7 +159,6 @@ cmd_gensymtypes =                                                           \
 
 quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
 cmd_cc_symtypes_c =                                                         \
-    set -e;                                                                 \
     $(call cmd_gensymtypes,true,$@) >/dev/null;                             \
     test -s $@ || rm -f $@
 
-- 
2.49.0

