Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABA9CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 22:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5E7F8144A;
	Mon,  3 Nov 2025 23:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D87jPs03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4ABB82A9E; Mon,  3 Nov 2025 23:12:19 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B827280050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 23:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-44dbb7e3c21so2403699b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 14:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762207936; x=1762812736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UrBmoTts9Z91NJKqcFUsF1hGhr4qFlRXJpjFEjbVfQc=;
 b=D87jPs03jrZ7M7mVoES+aHzOdcX09+K3M1bkSQ4qOcrOFKW4IjtabCPwW6R+I29sVQ
 9fWLHO9RFhrNsnqkwcSLc6wXeMJzI8tvvrO+3A6o0zYsbQH+UNm87o+HPJqmHIn3rDnn
 Q40r//zfb+fMgglMzGSJMdVZax7D3pLvJxu/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762207936; x=1762812736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UrBmoTts9Z91NJKqcFUsF1hGhr4qFlRXJpjFEjbVfQc=;
 b=KDXfyCluPFaRkTwQC6RMoWqYRhrceOHGJcEiRi4EosUhOR/oTpe7Z9jvmAzO07KrVj
 QE1Qcy329Ge0js4zQaR+ZcgzTmGMbdKcoPCm2ZgJNEtXielJ9w6lqYudhhfACr2XNCTF
 I794mro22/5GucgzQzm2s4ITa7QZbzHo3dzMABvlWMsxrixMGXhCQLkQ1K5S/5K5QA43
 JqFgaDDEVKEvP7Re92aj8v8JPla3mGVQ1xLkrkW+v+Cnx2wg7idwpOZut7UED05q+8PW
 Y8i/afZLJXt6WWJy5HpfabYPGZ+QbSXdQavlPWFzpgVtsa2TUDZ7mnM19SUdLvf9cquc
 583Q==
X-Gm-Message-State: AOJu0Yz3rGB5l2BTeLMHSZZrfGCe2afNgsPf2zmEeQyWpwqK3Wi4MtNJ
 UtY3UvjraS06LNvsS8hBKDxOqUdLwZRFIpZkvzY5iJmYQskIWj5pl9PqINMyZMtD0xjIKyY4G3Y
 8NSUQMxXTDA==
X-Gm-Gg: ASbGncu1BF/xZVGE/tT6r9BeABJKSc/TVkm8CgHPGNPOtx46/v5lR0GzKIy8RsLj+0p
 cn94+MUiXYbDMF/UdqFnIQ7sA02gd7ixL867QqFfZzzhXAqKo5V6zSkVoryv7KZiF2Q1NO54QFj
 qsivDXHuJEKzTCxKGquYPPfN+MxyE8aNEE7bXYOPzEPz9ghFlhSJov3NInxsb5sk3Qno1ZmASai
 oHjngDikel/MQzsnmFn9BAFDgGBtqVC5l8iwZGhfYHuttXVwZWpKqXMlIbwngHbQqwXZyYtD+Sl
 /EwZesUFcUY9FQneV85ntcX196ko+fkRSdY9OTAiHArB4UzI78AQG57HLbMXLPUXb9i/A5D0wXR
 ZtgRXfdH6VO+oxgtcTR5e46a2/MBXImmdTHu+8Gr5flI0mqT0mjDK1mQOyDmg9KpPREnHfA3Bm4
 KUVVIMtLvM97qWd7Lhw/GSHO/ee4SuM96BTwSL2RxEUCEpAzh2Utzc
X-Google-Smtp-Source: AGHT+IFz9+p8VvuTLjL+K2eoDPkiHw9NPeN4HnGWQgUOROqxTWd5ESr9XkkzQLbv9IJr2RnYTngOIQ==
X-Received: by 2002:a05:6808:2125:b0:43f:7287:a5d0 with SMTP id
 5614622812f47-44f96015836mr6146354b6e.34.1762207936398; 
 Mon, 03 Nov 2025 14:12:16 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fd888363asm391477b6e.19.2025.11.03.14.12.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:12:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Azure: Ensure we do a shallow git clone
Date: Mon,  3 Nov 2025 16:12:14 -0600
Message-ID: <20251103221214.3398735-1-trini@konsulko.com>
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

In Azure, older pipelines such as ours do not default to a shallow fetch
but rather do a complete clone. This introduces a marginal time increase
in each task, but also more importantly takes up significant disk space.
We are now getting warnings in some cases about using more than 95% of
our available disk space so take this as a first easy step to resolve
that problem.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fc55c8b21006..d91073b6f827 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -3,6 +3,8 @@ variables:
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
   ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025
+  # Ensure we do a shallow clone
+  Agent.Source.Git.ShallowFetchDepth: 1
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
-- 
2.43.0

