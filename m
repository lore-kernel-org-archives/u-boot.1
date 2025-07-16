Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20128C83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 00:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D15183152;
	Wed, 16 Jul 2025 02:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mmy5LYGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C58B583106; Wed, 16 Jul 2025 02:15:49 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A7D83111
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 02:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73e62c8f39eso184692a34.3
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 17:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752624944; x=1753229744; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NbWXnZ+NccTvbmqsdFqj0JguES8nclLn4QXRxYbhDB4=;
 b=mmy5LYGoFJK0j5CDDmqz56bMHarJNVr61svk6hon/jfA1NEEviuOMPxRasZ78OSz8H
 yfea1R91Ge2h1xBpFSz/sHr+g92HvWe54/d9OHKuDbLc4f6oT1lQO6l0hqt+UbPg8o1F
 rRy3C/bzRUl3H4HcL4ntdR5sDEWj9WBz24qfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752624944; x=1753229744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbWXnZ+NccTvbmqsdFqj0JguES8nclLn4QXRxYbhDB4=;
 b=Nry6Z4oUYu6UJIdKR9rgjhtI6MN6ecT8krp1c907K0EAdHuCsMHeOJBfjhGG8cgbuE
 TuOzKipJUxDoVpa7hEX2mJxMNGGcrt55lPhebuU/+AOjfJw4bx3f5QcoC3ILSjrXs3c1
 QIj35LB1nPBU1VfFzfBk6Bb4oj12iM3Z7NrM6jX/qXFzMCjNg97itg26x5DjP66likNk
 unzoZKHAgxI/FzOVf0PsmYeX8YkyHEMWvvwAojpFYVYiDVZCfqCLbSnJ9DGT0o0soXmz
 oXoOPn3xNPaO5qINvMgeayOYNalqG3kPmxfRT0J6hDXG1Tdsw02qO4o4lFTQzWZEpPE5
 H1BA==
X-Gm-Message-State: AOJu0YxF/47oCvoTXnSYd3AtFyPklLKASRD4N4TFmqMk1Z9Kyk5a32WO
 tDRfbmwIz5x5XjOg6Hr3fD3pzdzfMwRjp0mvdieH/sUueCkRoNZpeTUjzosOxI3hu9tdRKPVdJk
 gU9Sbye0=
X-Gm-Gg: ASbGncu8NISubNCxfFMivimIEF8po4I20fHebALlu59KRirMStysDZ4ZkaYU3ZY0hTE
 izc42012CpxtrLVYTptrB2vu3A+d/0kJlnn/u0qtm0XBRrCije7QHW4hZt0wSEsZSJteeRDNNjF
 z7K1Cs+iV/4dCNYymSypI4V7aiwCS2Pi7gXj0cW2WbYlcASXcmrxQoTPRwjSrWkwCS46J/JCKuw
 2v4SCHksHr/bJ1+BZ2gG0grQs+gp2J1y330XAAHGJygS0BthkjVpOcu1AmHgbiGt3BKtKfUVVpZ
 VTRCu38QMKa4Sxb0a3daEMzdv0QD7WbbkfnF9LcMertKdwBgx7e2q7XukcCNzlgXkDMQFKm5/mm
 zhV7rYe7f8QYXFtirAMHE/fiMn4rQU1U7LtRXiBHjt8J/9h/weacoQP1by1g=
X-Google-Smtp-Source: AGHT+IHWi+D+YuVGkvH3B9pnfIfUfzIfuhTGAjfPMl5B7OIWkLNH+uCb9F4IKvg3S2tZBO1+9zCzuQ==
X-Received: by 2002:a05:6830:2d87:b0:73d:baa3:830b with SMTP id
 46e09a7af769-73e6613273amr370012a34.7.1752624943729; 
 Tue, 15 Jul 2025 17:15:43 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf10adfa9sm2543607a34.30.2025.07.15.17.15.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 17:15:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/3] CI: Update to coreboot 25.03
Date: Tue, 15 Jul 2025 18:15:39 -0600
Message-ID: <20250716001539.2483390-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716001539.2483390-1-trini@konsulko.com>
References: <20250716001539.2483390-1-trini@konsulko.com>
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

At this point there's problems rebuilding coreboot-24.08 without manual
intervention. Let us upgrade to a newer version.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 02821417ca0c..a83c80db496c 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -292,8 +292,8 @@ RUN mkdir /tmp/trace && \
     rm -rf /tmp/trace
 
 # Build coreboot
-RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
-    cd /tmp/coreboot-24.08 && \
+RUN wget -O - https://coreboot.org/releases/coreboot-25.03.tar.xz | tar -C /tmp -xJ && \
+    cd /tmp/coreboot-25.03 && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
     make -C payloads/coreinfo && \
@@ -304,7 +304,7 @@ RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp
     make -j $(nproc) && \
     sudo mkdir /opt/coreboot && \
     sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/ && \
-    rm -rf /tmp/coreboot-24.08
+    rm -rf /tmp/coreboot-25.03
 
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot
-- 
2.43.0

