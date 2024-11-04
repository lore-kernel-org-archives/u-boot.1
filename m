Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2A5D132C7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF0188D3C;
	Mon,  4 Nov 2024 14:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B7IAhSJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B0A689000; Mon,  4 Nov 2024 14:40:14 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF5F788C7C
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-83ac05206f6so158853539f.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727610; x=1731332410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEWP3z3rWYY5ipu4wycSwf1COICFT3sk4O2J+gQGz/c=;
 b=B7IAhSJPzVQGu3onlHsoxBPT8tXWqHKZcjSztKEq7HiKvA9nr78AvWePugHhrlBW5d
 miXFfPiMigxmV7VXxKuR8fUgeHKl3sK3L9ByfQnv6y6c0YEMmTtUIp0F8vHjXSNadjwn
 S+waFqPhlXRxOW6XUjYsbZs3Y3cTV6TykYZ/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727610; x=1731332410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEWP3z3rWYY5ipu4wycSwf1COICFT3sk4O2J+gQGz/c=;
 b=CvlMGWoACZx+43cryOznWgSTwSmo9Gn3nS8pUR+uhhzSVjIqJLwoQcVZqQEfiJ7fA0
 dlZ9uEWYPTD4MZQAD6kBFqMNSsYuhMkO3ej0lTyJs7nOLQxaz9Mzdp2j44GcM4jyAGOf
 xSu7zG+Hfa50t5+EA3fu/r0Rvd2itjryQg441OoSK5ZDII2E4fHs/w/9+re04PPMbwpp
 KOEiVHZpAeW56kGIodJrQ5+eUpPSxftPdmLvRgjkr6uLPyVa6JOIQd40JZHQWxXBtARf
 fx6OBPcnvOVUTS/W0BhOQiTkxnWNB3cAKj7NYn2s7YzHDkSvoUXaKPkI3XD/5unNyLxE
 4u/A==
X-Gm-Message-State: AOJu0YzLtIMaeTIOiWv+Hl7kL72cTmhI8P5Jn6YB2+sQIdTVc7yB2d0Q
 s5VjUqQu+Eav41hYy3aJbDFM9HAfjNodtI/jgYGOVJVFTO5uL/unNhBi529I8AIOIC5wIlGK9SU
 =
X-Google-Smtp-Source: AGHT+IFEJWpn1onjd4h85/8C0MwbHNMcvPN6cLuPkbJUCzCW2VO1BUG9+jRraYwy3NW4zswgqh+RwQ==
X-Received: by 2002:a05:6602:6b10:b0:835:4d07:9d46 with SMTP id
 ca18e2360f4ac-83b650688efmr1385682439f.15.1730727609697; 
 Mon, 04 Nov 2024 05:40:09 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048895f3sm1935128173.12.2024.11.04.05.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:40:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/9] docker: Drop grub for arm64
Date: Mon,  4 Nov 2024 06:39:49 -0700
Message-Id: <20241104133954.840994-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104133954.840994-1-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
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

This doesn't build on arm64 at present, so drop it for now. We only
expect to run sandbox tests, so perhaps it isn't needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/docker/Dockerfile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index c4c3dc5a901..60106a82801 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -134,7 +134,9 @@ RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
 RUN chmod +r /boot/vmlinu*
 
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
-RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
+# This fails on arm64
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+	git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	cd /tmp/grub && \
 	git checkout grub-2.06 && \
 	git config --global user.name "GitLab CI Runner" && \
@@ -184,7 +186,8 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	lsefisystab loadenv lvm minicmd normal part_msdos part_gpt reboot \
 	search search_fs_file search_fs_uuid search_label serial sleep test \
 	true && \
-	rm -rf /tmp/grub
+	rm -rf /tmp/grub; \
+	fi
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-- 
2.34.1

