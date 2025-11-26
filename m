Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C603AD1119B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 21:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5E183A24;
	Wed, 26 Nov 2025 22:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M/xpyOZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D6883A3D; Wed, 26 Nov 2025 22:52:05 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0973383990
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 22:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c6da5e3353so205149a34.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 13:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764193922; x=1764798722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=U8PkgeSSYjcbMyxupmWPQirg7lf5ayGICl/4OxxR5G8=;
 b=M/xpyOZRM5P01cM/o0o5DkIlX053HnianCIfqlZ91fFdV1WBxL0kdb1531MTSD+Oji
 24JhN12jj9JI2e4M2NF6iXTtbkkG2NqH5WbhfNIv7rYAcNimPaixXPnJg6lC6Nf9pT6y
 lz9ILVbgsN5ah8xC413lwmdZeDx/U9iu0Dn1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764193922; x=1764798722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U8PkgeSSYjcbMyxupmWPQirg7lf5ayGICl/4OxxR5G8=;
 b=NxhKBv+IHG2Y857YFcqroUPK3yYWJh/Hr1hhcaj7RYZ54pKjP6wHLxSHswrAkNs66F
 ANR/tRWGZBDYmaUE4VYYZlWBQg366mD14enUev6l4pMd84JKV7pGZZj9TgUzAqrGBlwh
 /2U/Xp4lSvcJe5e7/HSK+W8S3E1GUD5VsQ1KplkkUQ5ELNEn8hAcQW6P/dvEXiV71nOY
 iQUlsTX9WphAs56IO7ciCgbM4+8S364ifvS8jB1CzeVMjfe/LacBVb1zenveHcfgZzlx
 3ODz10DXjuCRxr1Z7R6TixN2lsN6pJRBvVZdj8AX/ScwhxkCHtmA23jhiMBPgdcEpsRU
 ZxaA==
X-Gm-Message-State: AOJu0YxUzpZnuTS/UDkKmuvxHNfwDWiy9u5ZbUiMmSTbzIKcppEnzJR5
 oFEIEnpz0WYJroZIAgx+rQ+zoo0kgxZEVnlR1kC8QZcY0glBV+lX1zd6tHHbvpOxEMsUv9LABW5
 urKfE7hQ=
X-Gm-Gg: ASbGnctSKHZf2ASpAXRjoLf1j4SkdqAFlDGumLAO+OvxNkKp8CFkQMk/RK+Ks8zSZ/r
 vkwK15anh/yRP5AIw4Z0Fb0ve1FKOir9SLk28UgYn9nSoYV8X/Bw5EBc7Z8CxeDdsH8B/zUEPJ0
 MmtxziLlSsZsqmZtrDNns5Dm0e99huld9oPNXd49OMFYVotVwfuuegG8FarxCTCoVvHmIqIiO0C
 Q+bzq6+jCTWulw2Lnsg3i1RkAUVOmaukdQ/PKueSBwd1aYy9XE+Fs2A9Meb8RySXoKQG28FvVXb
 WKBrxsXHiajAhBzGPqKhFgpiFwk0CSCD2Nj31cNIo/BLn5WgdFVy/iww8jOlAhit0gAn39vDu5F
 FL/+TSF6yBHWIIoPrMGcGgHmNeXPaqKIuzwT7woMv046pqpFFeYWSxN1y4lGd/Qbz6c5Mv2HmTE
 pTsZrAIHJuGLzcE6D+KcaC4FXNXt3o0TTCTx98jjOfRWaM/j8xubAB
X-Google-Smtp-Source: AGHT+IEtCYxgpakdX3/bcZvh7mcut13IZB1+n71HzFoU5vYmr+V13El+ISGbbMug2qssEzia8jE/dw==
X-Received: by 2002:a05:6830:6998:b0:7c7:2c63:f2d6 with SMTP id
 46e09a7af769-7c7c412ecc7mr4261704a34.11.1764193921712; 
 Wed, 26 Nov 2025 13:52:01 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc21380sm9544731fac.12.2025.11.26.13.52.01
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 13:52:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Dockerfile: Switch to distro-provided trace-cmd
Date: Wed, 26 Nov 2025 15:52:00 -0600
Message-ID: <20251126215200.3887177-1-trini@konsulko.com>
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

Now that we have moved to Ubuntu 24.04 the distribution provided
trace-cmd is new enough for our needs. Switch to installing that and
stop building it from source.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 630b7f0e1416..f2ee724d118c 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -139,6 +139,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	sudo \
 	swig \
 	texinfo \
+	trace-cmd \
 	util-linux \
 	uuid-dev \
 	vboot-kernel-utils \
@@ -310,22 +311,6 @@ RUN git clone https://github.com/stefanberger/swtpm /tmp/swtpm && \
 	make install && \
 	rm -rf /tmp/swtpm
 
-# Build trace-cmd
-RUN mkdir /tmp/trace && \
-    git clone https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git /tmp/trace/libtraceevent && \
-    cd /tmp/trace/libtraceevent && \
-    make -j$(nproc) && \
-    sudo make install && \
-    git clone https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git /tmp/trace/libtracefs && \
-    cd /tmp/trace/libtracefs && \
-    make -j$(nproc) && \
-    sudo make install && \
-    git clone https://github.com/rostedt/trace-cmd.git /tmp/trace/trace-cmd && \
-    cd /tmp/trace/trace-cmd && \
-    make -j$(nproc) && \
-    sudo make install && \
-    rm -rf /tmp/trace
-
 # Build coreboot
 RUN wget -O - https://coreboot.org/releases/coreboot-25.03.tar.xz | tar -C /tmp -xJ && \
     cd /tmp/coreboot-25.03 && \
-- 
2.43.0

