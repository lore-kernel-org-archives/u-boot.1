Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3A5E6BF3C
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 21:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC42844C7;
	Fri, 30 Jan 2026 22:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KAultVyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C14D84563; Fri, 30 Jan 2026 22:57:30 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3445D844C0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 22:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45efde72438so1686801b6e.3
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 13:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769810245; x=1770415045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xcB8PTLZb7xJwZSZ+8pbCakQ6b9WahATk3MExDJynes=;
 b=KAultVyEwc5N+f/loJyeL3Hih3djXo9xJ72WGZbHPzPUyTVdaaCTjT3ljuAuLBawnV
 H3XfUo8a6AeLaEBeq9OVUsN4BHd6Dk8pJNZtJ/0laGfhNKx28WQkKs03MPRz8ENTKdT0
 D3K5z36jriCGLNF1SPLov1ONKqfIRFPDl6/6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769810245; x=1770415045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xcB8PTLZb7xJwZSZ+8pbCakQ6b9WahATk3MExDJynes=;
 b=HRIfiC0rz2jLgKLGb7beQEPfIuwHfOZjqDk/SJp6n4fPIyGD74T/R1j4NuFgdKKQjd
 LiHbnsEPT36a9buZxwBnrfPGvbn8mPdTiS2M9l/yvvJKlgHPBeEFDRrBgf07vwvGYYe+
 0SRE6hpYugyr267khzJkZ9rhyH/HilcxnAn4GVa3CjWid2ULEx5ILBXfVs5kIxLlitp6
 4YVxoNNsVC0Lu5YLMPoybg+P84+TF6aG243HQc1WQ/qCKFmpKoPr2/wl8Ieb+hXlHVBE
 b9hLH4AH7Y59naAt56ZfiEMrcG+fpjey3sXBlw19Wr12Ch6OB60RIKxN8jegiy8VY7YF
 Rlsw==
X-Gm-Message-State: AOJu0YyBi6Qk5zQLZuKn2UZaJSg8H16c4PzULj4/BuY0FtYhu+l8Wjkl
 g+L+joDUY21MJ3HCqx6LR1cewiIuDDC3NQ5dj7IyR6EH0Bsbcnkp5NcBjj3BII/tIcA2hWBsaGP
 sjVDdD9Y=
X-Gm-Gg: AZuq6aIFsdGSvdCoAJtwmvAhhtJzrFVs8Cqg0VoIoruzJYN6DEIvkfmT0nbYQPfV6Bq
 V72fzWgUZr/AcAPh7jjfO4Th1lJ9Si5efaAD8pkkHAXDk16mazb4e9Xjatso939jzSoukfIFUTM
 3gcvURuLiDt2XvSisWUq0+5DuPsfmM0qPlHXlWcedU28uLsiuSTS/pUMtjwSCSBfODkMr6Ob1mD
 dxToTywUMlMY00s7KDaObhVtTx6M6rChszoyt1rsesRAuB3w6E3kxubXXFKOKn/Y9h55vxzjqGa
 kNGy1lwtR4U7me7dOxfBSjANgygCV1kbk1+alMui8ttftb8loIEolp/iffULnGLuuZrd9WzZsV0
 62FI9KxMExy6yJa2ZW8EIcXPH9Obz6mnrMlyM1cH1Gx3y+S+bJp8SR4mUMcG5OWjKw+uSaQpNeZ
 byIlIwYBfb7hpM/C4Dct6Rohzx8u/RWa3D/wcGCd1hWFXfnWGo5XdlJQ2CyeDG+bspNz1sWU9Ql
 v9+mirE01QMzXWMW70WqZR2a358aVWhctg2AlnuSg==
X-Received: by 2002:a05:6808:23c8:b0:45e:af0b:3afa with SMTP id
 5614622812f47-45f34b9c707mr2216164b6e.22.1769810244781; 
 Fri, 30 Jan 2026 13:57:24 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08d894f5sm5552610b6e.5.2026.01.30.13.57.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 13:57:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Update to using grub-2.14 for our tests
Date: Fri, 30 Jan 2026 15:57:22 -0600
Message-ID: <20260130215722.3117956-1-trini@konsulko.com>
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

When building grub-2.12 with a newer GCC, we run in to warings (treated
as errors). The simple fix here is to move to the latest release tag. In
order to build a newer grub from source we need the autoconf-archive
package to be installed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
There are compiler problems to resolve before CI can move up to
gcc-15.2.0 but this step will be required.
---
 tools/docker/Dockerfile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 21f0369275c6..73bf6cdd2c52 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -60,6 +60,7 @@ RUN echo deb http://apt.llvm.org/noble/ llvm-toolchain-noble-20 main | tee /etc/
 RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
     --mount=type=cache,target=/var/lib/apt,sharing=locked \
     apt-get update && apt-get install -y \
+	autoconf-archive \
 	automake \
 	autopoint \
 	bc \
@@ -155,7 +156,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
 RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
 	cd /tmp/grub && \
-	git checkout grub-2.12 && \
+	git checkout grub-2.14 && \
 	git config --global user.name "GitLab CI Runner" && \
 	git config --global user.email trini@konsulko.com && \
 	GNULIB_URL=https://https.git.savannah.gnu.org/git/gnulib.git ./bootstrap && \
-- 
2.43.0

