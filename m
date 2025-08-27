Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B152CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 18:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71BE831B4;
	Wed, 27 Aug 2025 20:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kv8F+pGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5773831BB; Wed, 27 Aug 2025 20:38:41 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8547283106
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 20:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-74382041c9eso93151a34.3
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756319918; x=1756924718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=She4A55eUfhWhowln8DWLQbpjxDUIBp5z50hZAmpeT0=;
 b=kv8F+pGbxyhg1FNQ4baJKteZeHEvmQZBxIGQlWVLXMS3ROs+1m6fbwlBwE+vkioRCU
 FlxS4jKniPma0V71ju6iUKlWpRxIl5s7OM978CFf7KogNDXWDtep7YmiC9ifSHlb8zrJ
 a5mY2N4lvqYXrkzIbV9SMUE9Gt2tkqS0fGtzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319918; x=1756924718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=She4A55eUfhWhowln8DWLQbpjxDUIBp5z50hZAmpeT0=;
 b=qBhORGxl/JZ1/fr4W5ubtM5HNbWq80mr8qbYjuE36gSTYsbMSidHVRIwbLvmBRKEWD
 JsQCw/z8lXIm7P5jgdPXZXAOtelo/f3s8CdgzzH1wrcWrpsWXophtxJCJd4qZd/knrwg
 G4EU3/T65hHeHBNvmDLdiQhOhXwGNVffUzghotseslSEylVeYUnEBxIvBbLN6KvoGnT5
 QF3SaYAqCZhBtw9NM1vDdO9AvOPn/qKUqzPh7s2H+MUmS8SlcniXNs6B+kEfzqcyQGtS
 XZUCKzgKi4dV89Vdur04A3A4rKYcd1RyAZbC24+mA40B6dU1P4AyBAwzqFZQWgerRE2+
 0hCQ==
X-Gm-Message-State: AOJu0Yzww7+61WTBrccTpFjrKFj1aVk4bs+Hb/1IYvcHwcz6zhmtx1GG
 ZV/ZytLAFMHTgUA2t3qdhXhMAwzOBYh+NeEZ73Kj8ckgzLlBf51MoHDJW7LflbcMCduiGtjL2fg
 Ya0szsRs=
X-Gm-Gg: ASbGncuz8bYF2l9sB/vMRaxG3DOyhHDUI56D6l9CBKBtWqQNdjW1Y/jgFeunU//x6RA
 6dM8UH4iDbnklF1IjrM4rlxBLAh5MzQWlGLWCAJMa6Pz5PxXZX+VSTWWG8Thy3upIDYfE8uSVTd
 7LH8HMEd0vXnVQLl4GftfYbWEhFKSSv/DF5Ut4lFQYhtLq0HTiGfqo2RZ3YFyT+/S8Yb3zvxVkv
 xkEU9pBANEzZkT4uGnlcwQMljY7Bvlzin4f8Nlas4HySsABiFqQE9moaxqbxZHNUBi7Be3bX3ck
 e250FLXtPzpAHt+hEG3coWv7ivx9NYO1dFLr05AFQU4ZoORddsDNrhSy/pKNrppPpuckyf7uUMX
 FpPIOHwJWg+8uWwdPTJE4MiIQF9297Yj6Lg7vjz8/CCccH0mJvX7EI7ptCus=
X-Google-Smtp-Source: AGHT+IEs3hLVL4utbLoPnnUC2TD1YVM/UL6vf/aTq0M5JGCtVz4A+ezqDcUVCvrhmKTKC66DGED6IA==
X-Received: by 2002:a05:6830:d18:b0:744:f0db:a19d with SMTP id
 46e09a7af769-74500a8cefdmr12145846a34.33.1756319918277; 
 Wed, 27 Aug 2025 11:38:38 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7451b4f302dsm2483665a34.42.2025.08.27.11.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:38:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Subject: [PATCH] checkpatch.pl: Ignore mdelay instead of udelay
Date: Wed, 27 Aug 2025 12:38:36 -0600
Message-ID: <20250827183836.678142-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Whereas in Linux, on ARM there is the notion of delay operations and
mdelay and udelay are not the same, here we just have udelay and mdelay
is a trivial wrapper. Tell checkpatch to not complain here.

Reported-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .checkpatch.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.checkpatch.conf b/.checkpatch.conf
index c368d4147260..0827f347f6e5 100644
--- a/.checkpatch.conf
+++ b/.checkpatch.conf
@@ -19,6 +19,9 @@
 # Not Linux, so we don't recommend usleep_range() over udelay()
 --ignore USLEEP_RANGE
 
+# We also do not have a functionally different mdelay() and udelay()
+--ignore LONG_UDELAY
+
 # Ignore networking block comment style
 --ignore NETWORKING_BLOCK_COMMENT_STYLE
 
-- 
2.43.0

