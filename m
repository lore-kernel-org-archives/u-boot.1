Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD95E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0C789647;
	Sun,  8 Dec 2024 20:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="obkjKo94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E14D7895DD; Sun,  8 Dec 2024 20:08:06 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686DF89578
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 20:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d89a727a19so43068496d6.0
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 11:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733684878; x=1734289678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BvRX292RCbNHBo7WSapkwDJbjBRvTdTitZ7TO4A2KIA=;
 b=obkjKo941AyGPDK7pR5yx5BHNPtaktF5Tm1YgIxS3szbWBjfLyI/XOx1pBIHUrT6SW
 oa6MbgTXhXMIcQB9fyzIj3jiCXl9k+jDu8SoPy/QBsm1adW9ZEojAgpgxUqordU1Uvjn
 ctsUQp/PvKJYUyU2idgqdlwC7tOvz3E0o5NdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733684878; x=1734289678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BvRX292RCbNHBo7WSapkwDJbjBRvTdTitZ7TO4A2KIA=;
 b=SqYM3KTCDZIhha15HBOanpQELWtPiPY+43ODbGUCAB5fyGWmqBo8UbYwxHguLG1bTY
 doHSc2VdDBNvrdOI0bGJGphkdfp7O/QEUvhO+1CsDGWCnX5GwZivrUKnOjWbKlTUoEpD
 ZzCWMWd9hXQcXuwmv3VEeZpar4LOk+Rk4ZB0wNfkdMxe09aTxbJlQjqHjyMR5HEfIeEN
 a4DecNSOxreZk2U/5nyk0Rd3hXq3xiiA6fjjz6FU35Vp5MkvZCMzjuQXxC65pJhpap5C
 G2HRWSg/CAYgH2yULeZ5YVXS+Gh1ygSHYAyH9FaArKLmURzBLbeFwR2HK97mJQ9huFji
 SrWg==
X-Gm-Message-State: AOJu0Yz4f8ldrofihMcNDrY/SX5m1Sw7kLozIHKSN1/F7YJFQhsv7T1+
 O55fRQkHmto2UhVipRnQu4gfGeKZzXFxmoqwm3AiXRIDviHFxM+0MA8Wq/SZuoIw7VRclo9LFo1
 jQUY=
X-Gm-Gg: ASbGncsGSpBRVFnbvgeBHXGRqg2Xgn9o11RvP+JGfu+nUImNhJGpWXOUQl1AVNsF4aM
 xp34/+VCNGgZsRkg89WgYaJeWH4Qlki+n8hsfRnSx2jKm3ckwqi23nZMZ97HMCCglSh6WQ2gn/N
 z8i464OmyBujMmns1ILEfCE+JuNwn2NGauF+8KIK4uRf4MrsnfMy/gM3rrOlz4TdhFdHl7dYTMm
 IZ35ABvwAIIOEk+SJ7vKVOpXFKLrJ4njT99WN3TWIBYqUqqYW9cvoOh9QcDK+LMv+D31Q90VA==
X-Google-Smtp-Source: AGHT+IFHcCA8BevsQOPF/iu8kRcJdKNcpzt1RsRbRx5qbQ9cemGF993i6pKWqLoy23iLdYfxgr8/aA==
X-Received: by 2002:ad4:574e:0:b0:6d8:f6b0:bf52 with SMTP id
 6a1803df08f44-6d8f6b0fdadmr140815956d6.16.1733684878365; 
 Sun, 08 Dec 2024 11:07:58 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66ddeasm41154076d6.25.2024.12.08.11.07.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 11:07:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 6/9] docker: Ensure we use the cross toolchain for aarch64 on
 arm64
Date: Sun,  8 Dec 2024 11:07:29 -0600
Message-ID: <20241208190741.4192601-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208190741.4192601-1-trini@konsulko.com>
References: <20241208190741.4192601-1-trini@konsulko.com>
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

We do not want to use the host toolchain for building our platforms in
CI (it is both too old, and would be inconsistent with our CI
practices). To do this we need to set the toolchain-prefix so that we
don't end up guessing "/opt/.../aarch64-linux-aarch64-linux-" as the
prefix.

Link: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/32
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 38a9c4b9ec69..5d77e2b62696 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -323,6 +323,9 @@ RUN /bin/echo -e "kernelorg = /opt/gcc-${TCVER}-nolibc/*" >> ~/.buildman
 RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
         /bin/echo -e "\n[toolchain-prefix]\nxtensa = /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-" >> ~/.buildman; \
     fi
+RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
+        /bin/echo -e "\n[toolchain-prefix]\naarch64 = /opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux-" >> ~/.buildman; \
+    fi
 RUN /bin/echo -e "\n[toolchain-alias]\nsh = sh2" >> ~/.buildman
 RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
-- 
2.43.0

