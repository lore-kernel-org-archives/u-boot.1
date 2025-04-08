Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6C0C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 20:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF0C8210E;
	Tue,  8 Apr 2025 22:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F9T+Ftzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992148219C; Tue,  8 Apr 2025 22:21:47 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BA8820B0
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 22:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72c14138668so1442116a34.2
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744143704; x=1744748504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wTH7ZoDQWwXnQYyCxeNydHl43ITvQXl4yZOAr8VinHc=;
 b=F9T+FtzbK9P0RW4WSLiA3lbSFc1sAV7Z80fiw/fc8V2xGBh29h28r5iUfjhBmKJ7eS
 aU4qz5W1USsNCnnNwn1dtiL3+J1FixxYMyf5gzKFZovzntPbTxMuR5qmwILh1r+8TgDw
 orMaRmV54xzNKKbKtsdbT5mbLt7AUu/3FNWbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744143704; x=1744748504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wTH7ZoDQWwXnQYyCxeNydHl43ITvQXl4yZOAr8VinHc=;
 b=WDegNqV5PIPW/9jylqm+SbBNwfxZoMLHbAljJV9T2MqJCjD8GHWOxwf9Y53l34vfEA
 HpAcNWbfEK8mo11X6NVumLDA+crKR8+F51GHSlqAOUZKiA22LATjzJEdjE+aBf75q5LI
 j2JHPI2qgx51N5I3ffrATTA3KjROl91Owrw6HsXTv0SVqkTubTS4bB7dskyTQQE1khgP
 ic/ghwZGZUXiTSVaTSFadZc6iRjxhABhD5CHXn9MGLKFjSbax9RD5v1DJdaDQZ7z+LAA
 ek7QgHgfNrdCuzByRKheMvG0GpFdghYcPn12jOVGqWj/mvNZAWR6+e2bVFBZaTha1wvS
 DJGA==
X-Gm-Message-State: AOJu0YwQCXKFlTfUExhuSLEILSiiw1QakB2jgYmY8cSUT8hRksihDNiq
 ssCnWLdNucGGH1eiK1ErO4MKwsyRJG+hxAfMzkfYC7Po8yL/55o3VqWNqfRWMXoFXAAF562mHKR
 t
X-Gm-Gg: ASbGncvZAieL8XujY1BjYoaI8KRrzNpMInf/QQmUtArtxxQgktuBtbPkHySS3Kh8a2S
 9WXirlFMVTgjoAYCCaw3wdBH+u0ojTdCtbwili4HlcuPmsLkWbo5CTfCylpyWniL4cTWLsGeK0D
 mY+BKyvgKeaZBLFOinTnyGBy2qqkj940aRjlUo3iagqaIlgdP1mHfTt8xLajvY3SancG19lzFhf
 BYQp+Iu8aIfnABxRsj3M1UgNB3VAV6AByYOD21FooI/2jUgZtpqrAdCzDEVtK4dHZywURjQfYY7
 v8BsbVJkRuHFos7vcEWk95uKpZEUaXaR2g0DcKX5uUW5hG5UnfdKcXu1cVrb+lApb2ALJODa1QA
 UrL9lOrBw
X-Google-Smtp-Source: AGHT+IGs9+jSESXif69RyBqhfwVXjX4ba8tklyxB8xGC9xv4Nur0UKkklSm4ZMjPQWb1fYymJOxjaQ==
X-Received: by 2002:a05:6830:6990:b0:72c:3235:3b97 with SMTP id
 46e09a7af769-72e70a662e4mr291153a34.22.1744143703614; 
 Tue, 08 Apr 2025 13:21:43 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e6517724fsm582391a34.19.2025.04.08.13.21.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 13:21:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] Dockerfile: Update to a more current TF-A release tag
Date: Tue,  8 Apr 2025 14:21:40 -0600
Message-ID: <20250408202141.1434754-1-trini@konsulko.com>
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

In preparation for using TF-A more in our CI loops, switch to the
current release tag for TF-A.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index e14d1640f9cd..3b0c403618a8 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -230,7 +230,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 # Build fiptool
 RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
 	cd /tmp/tf-a/ && \
-	git checkout v2.10.0 && \
+	git checkout v2.12.0 && \
 	cd tools/fiptool && \
 	make -j$(nproc) && \
 	mkdir -p /usr/local/bin && \
-- 
2.43.0

