Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4857DD10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 16:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ADBA839E8;
	Wed, 26 Nov 2025 17:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TlfdC9P5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81A983BF1; Wed, 26 Nov 2025 17:24:12 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82842839A8
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 17:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3eae4e590a4so2268314fac.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 08:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764174249; x=1764779049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TUUzeR+N8OmNeUnHdb4HOa/Mq+3q820cNNX7qxJxsGE=;
 b=TlfdC9P5VWyyT3OvLen0Nk7JNIQWBJ79yVsc8B/JjoHuIsaUY+hnvhYfe+EiZp8WlS
 oa9x4PoEzd/nBijUKvC33weQ44bay6mbH+tI1pW0Ko8aomRKksEXWOpuGUFL8ovE+rJg
 FyhKPvBHyHB0uTZDdcjX7zAzTy1pK4oAL+UTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764174249; x=1764779049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TUUzeR+N8OmNeUnHdb4HOa/Mq+3q820cNNX7qxJxsGE=;
 b=s1GW0XN6Xkj3VlyMkG5K+CkX71M3NKvf9PdlfDYarP5Aw+iRZpiUkfYQdZWzGiG2IY
 ZpZ+ZsT84YBmvn3tUhpllMt6FGkPX4H5bk+gRVyXdAA34JZNdLkICJAU1+zw2ak+QBUU
 Zh4Uq2OsVlhaMluac99KqatHFl+zug38I8RvSYSByvd2kq+/qXBUlQmOfC6g2YJS7A4y
 UU3KxtA0Mq/Fyz7LUGf7j9B2LFI6UinlpFMuFtGkGkVfqHPNpGVl3882Q94aEKChwq3X
 gCKGqDbP9KHUj1l01HKkaVtqrh+VZwzFAecFgoFojYBNDZUtJ3txETZnTQR12DL3l+J6
 6Hdg==
X-Gm-Message-State: AOJu0YxNLASVWUC7dTdoiMaEOj1ERZCnWnUQWrgncZCFOsHUTeFzhX+h
 itndJ6ILO1oomApml3xg2Mo0+tKUgCiUDP9QnUKldUuoTp5RsHhkIbfPA5sWvsYKHDeLxJ6FU6y
 yQ/etcPQ=
X-Gm-Gg: ASbGncs3+D2vaqExAlJRWW5gYwvvv+xuz35hvJwkKKLgGphRg/bg8/yza5/V8bORj04
 5H/imrPBK8rxSY4yT93ffWHj12e44zeUPGxXnEvoz1T49gc/AK8vWUPlY0UY1Tk6jQ3+CWg2OMR
 C1k7eu2UdbjzMwQgDyaOaLibc4uS06CEudBfTJGIDzfIHWjcZb2gu+zCs9YLNqvw7Bij3F2p61m
 TdWqSoLancND4wRw72u0a3QNR2u5Guea51U98C2FeZTWQo/Us+X+U2UCy2mSG+yTpAD/ATlgLVf
 L4iMOJhGtIPc+ULXOysyNuhRbXiaWwiw7R5ADuSF1XmW+wAKuvNSPsL7RlnVWLk7kzNzLDWYG24
 bDW8ywiwMp2wcOoOOBvwAHWx6dSSyEBxWdIERlAD2dL9HD9P2UXzjAk7mkC97EOLViPQQM68/A6
 G8UccJI/YrOLCL7Jq4CkwBBd2x8/VPE04StvTrVDuwZpOXaHXLkk2gyd2/8EyH1oQ=
X-Google-Smtp-Source: AGHT+IH7f9qVsV2UkpCwxSgJABIbMgtRp2QdTyS8zwR331F2TV3AaHaLK88rpqlh1z39xTqod286Rw==
X-Received: by 2002:a05:6870:56aa:b0:3ec:3845:f229 with SMTP id
 586e51a60fabf-3ecbe6238a3mr8362245fac.46.1764174249166; 
 Wed, 26 Nov 2025 08:24:09 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc8e0e1sm9276858fac.18.2025.11.26.08.24.08
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 08:24:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Dockerfile: Update building trace tools slightly
Date: Wed, 26 Nov 2025 10:24:07 -0600
Message-ID: <20251126162407.3767965-1-trini@konsulko.com>
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

We have not been picking a tag for the trace-cmd build process.
Currently the tip of libtraceevent fails to build. Address both problems
here by picking recent stable tags for libtraceevent and libtracefs
(trace-cmd has no recent tags). Further, as it is often reported that
this fails to build due to a race, stop using "make -j$(nproc)" as this
is also small enough of a set of builds to not be an issue.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index f98b42e73570..960e4a7177f5 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -311,17 +311,19 @@ RUN git clone https://github.com/stefanberger/swtpm /tmp/swtpm && \
 
 # Build trace-cmd
 RUN mkdir /tmp/trace && \
-    git clone https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git /tmp/trace/libtraceevent && \
+    git clone --depth=1 https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git /tmp/trace/libtraceevent \
+	-b libtraceevent-1.8.6 && \
     cd /tmp/trace/libtraceevent && \
-    make -j$(nproc) && \
+    make && \
     sudo make install && \
-    git clone https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git /tmp/trace/libtracefs && \
+    git clone --depth=1 https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git /tmp/trace/libtracefs \
+	-b libtracefs-1.8.2 && \
     cd /tmp/trace/libtracefs && \
-    make -j$(nproc) && \
+    make && \
     sudo make install && \
     git clone https://github.com/rostedt/trace-cmd.git /tmp/trace/trace-cmd && \
     cd /tmp/trace/trace-cmd && \
-    make -j$(nproc) && \
+    make && \
     sudo make install && \
     rm -rf /tmp/trace
 
-- 
2.43.0

