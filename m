Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E022CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 13:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F386284248;
	Fri, 10 Oct 2025 15:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PQT2KPOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA8384272; Fri, 10 Oct 2025 15:44:16 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA7EE83FCE
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 15:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-43f5ec025d3so1031490b6e.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760103852; x=1760708652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Njo1IJxv0fe2jdk2VWn0PbS9KXuzpqbv271jrpvThXk=;
 b=PQT2KPOZGTHT+TucOLRjswPeSavqfU+te8p+RYPpXknOQLmKDgFUFGQNCf7eMo4/wL
 1Ql+UUe8oHw0tiMPXqrEZVMdFEGtNb4JwC1lSBrWPak/Zf4CDxYL78KswfkYSOVeE7jT
 6ixukErQetJGUIBwGKMf+rNor8RZ9DEaCdEEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103852; x=1760708652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Njo1IJxv0fe2jdk2VWn0PbS9KXuzpqbv271jrpvThXk=;
 b=sPj2E5rKLRTqk7D1sfuiIo7MnOuayC+aeFJzZ7k5fuwY7UdQ/p/aLQY3cEdAL3hcWl
 zxY5DlyJxc8UJDuUHv/TXObr9BDED+kTCrEjFajKTtY9A6cGKqjEH+9FJ0hEuAL2MsC2
 R/LD8yLU9HMxsTi0mY5f/RiqVp9Wl8aqeoDJoptI9wh8u3ZiWwh9Gu5uvqMD2l8Lj5IF
 isFeJy/0kh7694+xE5vlbcy+5J2T1xfbzYXv33W1/4KzslOvU+5IqL3B5qy36u21/LN4
 kSyOVOAWWe1O5lT56VF2KqljuGikXgPMoiQ0TY/mdJfi2Ddhqs4xGyK+6n1UrvGn2t3i
 eLvg==
X-Gm-Message-State: AOJu0YxFT2mKUWxS/68gTaQ5JZcC+3pEif7V9mAWxKXO3Bx/ixczx6ce
 PwElWE2RwXcGkm1hCaw351FyQk7OheZp62CTeLNWBVMWkFu+t6zJFvfvv4Wuf/EP3pinbjYkVm+
 ixRbKu7w=
X-Gm-Gg: ASbGncviC55KjRWJKH0heKeMoxIWhet39vrlukmBZ8vOQymt2euEJJll7XnrkInnGzU
 9LktstsGSC21Ms0sUjm2g7z/d73gIkSQQe9ceOl8KiE4CI2vSuHOzpDhj0iwGxJV5Vx2d/TLO+W
 9mxbhH+MtqBWZVo3quuCIe7uXf5sVotmqKrL+6KXIGxTMXobozG/ejJG5v8qaKS6W4WWrRs/Ypm
 gjOtAAXWlBFbIsRbjv6U/RPwOW/BWNxv9sQo0ae+KZNl/36EPg3JaZAd4IGmt77YHzf82EHW7Ug
 wbf0RppupBIzRpoBHLM9M+hxdsjE5E/chW2oTi5pscMxwFKSlz0wiE1XBxUHMzmnzcrGLdrLkZu
 nK7LPBE+TOFaj85hGS8MuOV3p47zu2Kdp0une/0hQT8ZSBwBeHYJBL8RfqaItqMuzIPAHtp7csW
 oGgoi+o8c=
X-Google-Smtp-Source: AGHT+IFLqtTUc12V5oDRq0T7EcgkTk5o4rlYWWChk/cuNAZGQ6CZnITMxUeia7Z1HPCaOWoLJn1Zlg==
X-Received: by 2002:a05:6808:f8d:b0:43f:75e2:af48 with SMTP id
 5614622812f47-4417b39af4emr6524353b6e.21.1760103852397; 
 Fri, 10 Oct 2025 06:44:12 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419895b2dfsm604927b6e.24.2025.10.10.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:44:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH RFH DO NOT APPLY] test/py: Update to pytest 8.0.2
Date: Fri, 10 Oct 2025 07:44:10 -0600
Message-ID: <20251010134410.1094470-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010134330.1094378-1-trini@konsulko.com>
References: <20251010134330.1094378-1-trini@konsulko.com>
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

This is not intended to apply directly as currently it leads to the
sandbox.py (and sandbox build with clang) tests failing as the efi
selftest now has 4 failures when before it had zero.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 672a58ae3584..4eefe374435c 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -1,5 +1,5 @@
 filelock==3.0.12
 pycryptodomex==3.21.0
-pytest==7.4.4
+pytest==8.0.2
 pytest-xdist==2.5.0
 FATtools==1.0.42
-- 
2.43.0

