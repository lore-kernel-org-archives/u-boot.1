Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D997D2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23DAA8920C;
	Tue,  5 Nov 2024 17:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n/fMuMbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEB589229; Tue,  5 Nov 2024 17:08:06 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9871189025
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a3a5cd2a3bso20404745ab.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822877; x=1731427677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkNTjj60QJ2JRF0Jw3a3akU43lIOn1QanNvErTDtkkE=;
 b=n/fMuMbhh4LcSFjrPYdXB3KMv5bIl+8a2cBxD/JjZ9G9NqIvbJLa0O3xq0+JKm74QH
 Dokm/LqGNo0KSCzVO8dkPH4Kc9hHb9A3QVvtnsWvspWbFO+53LgOYhOSZXm3Nq+rW0Aa
 Jzpgrr5jehZBJT4PQS6I1bmeCxbb2d7IEFAY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822877; x=1731427677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkNTjj60QJ2JRF0Jw3a3akU43lIOn1QanNvErTDtkkE=;
 b=eUeEb64oOXCQlgVATlzkjztuh6jfbVX1K5N7QeGDi6ZBnowbjDOSZ3CdleTJJf2XEA
 AK/YhqdvRZTciMF34/8UmExLySyel9uryomCqRgC/8lYOcB50BVRAyZ0/E9QkZ3ng3sW
 0yGW1jzsAaBbYVtjf5iMeoK1EQQxjDy6s5UYdKawOaITLyK2oeF6DPpIcz8We+nwFISh
 de4N7Dxnl6XwJswtLhwallssbn1gmoecQe1+jhI8/deicMShhXFYC3Ikt+OXD0QJ256L
 IFUJbiyC7eFqjgVs3Gi9hQkEakHlxSh9loRIgX2QA0NVd70mZF1CnKrpKMIlcHLcnqtf
 NbSA==
X-Gm-Message-State: AOJu0YzeqFkl+Kb6VKJSSVf3WdkIbltAVBBvhLrx4MhK3kByjvfZgXIs
 Fhl+o3GHV62E5gPtm6lODipVV2WAWlGlXBwIINNxnjNe5ROwbAoMPcMlV695+SWiGyYhLu7Q8jg
 =
X-Google-Smtp-Source: AGHT+IFLqLz4FUHYjK80Dwz+4ZRQEdRcMNlxgtac75B2J1/3MbQlkTT87n0avJRhArZZieHLgSue3A==
X-Received: by 2002:a05:6e02:52e:b0:3a5:e3bc:c1bf with SMTP id
 e9e14a558f8ab-3a5e3bcc3ddmr202895905ab.23.1730822876813; 
 Tue, 05 Nov 2024 08:07:56 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a99ccbf5sm29640285ab.44.2024.11.05.08.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:07:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/9] docker: Drop grub for arm64
Date: Tue,  5 Nov 2024 09:07:34 -0700
Message-Id: <20241105160738.3795497-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105160738.3795497-1-sjg@chromium.org>
References: <20241105160738.3795497-1-sjg@chromium.org>
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

The error seems to be due to not using the correct toolchains:

   ./configure: line 32517: /opt/gcc-13.2.0-nolibc/aarch64-linux/
      bin/aarch64-linux-gcc: No such file or directory
   checking for options to get soft-float... no
   configure: error: could not force soft-float

That is at the top of the file, and needs adjusting.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Expand commit-message to show the problem

 tools/docker/Dockerfile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 84661b036c6..458deb7c1ad 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -139,7 +139,9 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
 RUN chmod +r /boot/vmlinu*
 
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
-RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
+# This fails on arm64
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+	git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	cd /tmp/grub && \
 	git checkout grub-2.06 && \
 	git config --global user.name "GitLab CI Runner" && \
@@ -189,7 +191,8 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
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

