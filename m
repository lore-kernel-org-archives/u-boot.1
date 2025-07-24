Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEE2C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F58A836AC;
	Thu, 24 Jul 2025 10:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jv61V4qN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1FA683678; Thu, 24 Jul 2025 10:34:58 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B308A83692
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso4576145e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753346096; x=1753950896; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsaSz3iNo+0aBIIAKdC5+hyC7KZZXamofyy7o4tyYVw=;
 b=Jv61V4qN8QYv1sXvSrojHMAo7N5WQvlwZKbDzaJaVPK6gswJpRDafscfUO7Sc00gUV
 6kx1XivUDzGRRlUJCBrs5iOKDXhgYY9sIEdOPA8LssDK85Ex+fEJV904HYeyJsLojv5m
 QpYiW+JiwkB9dOPeges5mXCa6F5AExSy7UszoUVyH6k5P376MEbsVqdU/noqFxqv+d4n
 tbhZBruAA44zmin1My0C+Pmuiotk82XXMosFqble1ESn/6MAWIp996BFagsBW0+VeUet
 4/J0DuDIYxyJMwMS58n1dyXAOzVz5HnrHjTpKvLbDDYEKq3LdN7L1GVT0EHwugQg7pNs
 bmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753346096; x=1753950896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gsaSz3iNo+0aBIIAKdC5+hyC7KZZXamofyy7o4tyYVw=;
 b=q5rMhfBqEXuNSLXwD19cB/qiydRK6WBwZNAiNq1Ls21JZ25ny/fggU0bbhRQeiC5Tg
 8rxprYi532lGqmiT461PbS1XlhdFP+45wAVPZk3apqXfcMqhIy5SBgQUq7QeRJBtjGdp
 26t5vNa8UVmT9ofayMAqLkHeTw10KdUQ2sYh7jE2k9I69qLthPwSaxkAI4XGv5dW37Wn
 25lICVG3iR91hVANe5ibIzFeMV5/5LSn87PzMCn6sDzgX+JP5s2sAdJd5LDAB89yKVBi
 XKUXKzRFsWDn92zOlyklTMA8o8ITasFnb4WOODo4eEnw4VYQWK9NZzmNBYYcuThY0k4o
 omig==
X-Gm-Message-State: AOJu0Yywzhq0LVILYZ41Hcny72Aa8kThRfgnPvUj8+hzeHghi100EBsb
 5b9CqxG7kSnO0pcDnvxXWxewhXUSU1wt/1zBml1pqK/EC0PHrMPC3xa1UQpULrH4fqsn1XiMWYX
 2N+dTKITICQ==
X-Gm-Gg: ASbGnctiH2o9iq/aHWnRZMeaL0ToD3f9OnKVlyy7+zUA0lmsbedpVdMTy/PXLqugHvN
 84R21uJIskY9GrHlUZeU5uLFvZbfhaA9UrnqlSGrfgBPF7I5BSWc8hpWCtQj+ne6Tco09f5oQD4
 75FDVlSHecAsKH8YlPo07hX0yuEReZrNqxTF8FzfSebO2jJjt3VMkIASvvJEEoiLgs4dXCQ6jPQ
 TiwAbDTFqwH8SnG8h/bfwkPd/dx0deDBQKjr3QPg5u8hAmBrY2/wLeCcoEqk98gdkTYY3uUiSN1
 7RRueQ25XavRRC936/p8M07VGgoKhSSBBj1rCDjueK2U1VEAL96DIWHU5ufFugHNlx9tLm617/Z
 U/mXbQkk9J8IdTh+d/QjvSWRxbpzuaA==
X-Google-Smtp-Source: AGHT+IGjZm23MmkPVXx8HoJXu3MwjfhjsQTtaSFqBAKyH3w9UNaNBSnfR/Ti5LaxJc2wt/HRQzqu4A==
X-Received: by 2002:a05:600d:15a:10b0:456:1b8b:b8ab with SMTP id
 5b1f17b1804b1-45869f5c5f9mr34223885e9.30.1753346095911; 
 Thu, 24 Jul 2025 01:34:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bcf7:2df7:a82:bef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870577af8sm10962605e9.32.2025.07.24.01.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 01:34:55 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] binman: bintool: run 'apt update -y' on first invocation
 of apt_install()
Date: Thu, 24 Jul 2025 10:34:21 +0200
Message-ID: <20250724083433.57867-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724083433.57867-1-jerome.forissier@linaro.org>
References: <20250724083433.57867-1-jerome.forissier@linaro.org>
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

'apt update -y' may be required to make sure that the list of packages
is up-to-date and that the subsequent 'apt-get install' operations can
find the requested packages.

Fixes the following CI error:

 Fetch: zstd
 - trying method: binary download
 - sudo apt-get install -y zstd
 Exception: Error 100 running 'sudo apt-get install -y zstd': E: Unable to locate package zstd

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 tools/binman/bintool.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index f46bb52a7b3..141cc66657c 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -55,6 +55,9 @@ class Bintool:
     # must be called before this class is used.
     tooldir = ''
 
+    # Flag to run 'apt update' once on first use of apt_install()
+    apt_updated = False
+
     def __init__(self, name, desc, version_regex=None, version_args='-V'):
         self.name = name
         self.desc = desc
@@ -421,6 +424,11 @@ class Bintool:
         Returns:
             True, assuming it completes without error
         """
+        if not cls.apt_updated:
+            args = ['sudo', 'apt', 'update', '-y']
+            print('- %s' % ' '.join(args))
+            tools.run(*args)
+            cls.apt_updated = True
         args = ['sudo', 'apt-get', 'install', '-y', package]
         print('- %s' % ' '.join(args))
         tools.run(*args)
-- 
2.43.0

