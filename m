Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850D0D132C7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E258888C98;
	Mon,  4 Nov 2024 14:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Te2Z72Fp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B10889D2; Mon,  4 Nov 2024 14:44:31 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC6288CA2
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-83ac4dacaf9so153930039f.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727867; x=1731332667; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1FS+8m9GoDjL6+SeV0DbmLAsz8NebQSSH8FgrwpFtKo=;
 b=Te2Z72FpblTqRBT40AQL66gdWp1jVtFfn9AxeA6f5NTkpVeCYSS9CEv7JF1HDHYs0X
 JQ8yQBSprvUF2ZBuGNTzjXCPCzj7hAfHiLj57L/0slkOtHUksFIY79tfCFKQc4znbNx5
 57Z04axpM3Mb4yxFLrgEvVjUw0HavU5aUDKLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727867; x=1731332667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1FS+8m9GoDjL6+SeV0DbmLAsz8NebQSSH8FgrwpFtKo=;
 b=XU2wSxUi2wl+vDZzy6oQ8GeNMTtLOSx5qz0vQEy1niuw0PqRRfh4FfivtYQx1ehptf
 pTof0XJJ6e4zQ3zgwJZoCnnLPYo6HJl0CMnwqBiQyucAqY/FEwfKl5d4i3WpYSgs4L2c
 m/2QqThT6oqKAtCgEtj2DCPWqlCrzpuiVqFsKswa6b6DwRwS3CSn+pfsEximz9q+QOhr
 qEvD6/YvgZinbXMb7MDaUaklsIc+fbWw19vmi3Dz8DWi+ikf2J6dijJa3ryXornR9K+G
 KDgiCzD9G5wRAxobgwD3dt57i4QojktYevTVmtshg9t56lRxjLuxwLuLngz8vmpjeeHG
 gQiQ==
X-Gm-Message-State: AOJu0YwWY+6RJNxs08ab/wzCy7DsQqX0WudwVLT9D46Gc79O+dIkfckb
 l8/51SLCh4XQGIOrf49v4Hgr4DQzJW1LAcg+zZyiTdDPEYvvrlg0SVOg1rmsDA2vpUDdXvuHkoc
 =
X-Google-Smtp-Source: AGHT+IFVXLfmPEX4QkrLEbM9LWCbEviGsYgiFBu8RmCQiP1MImk8bUAZ5AIDYX7fSdMJz+6ZMddg/g==
X-Received: by 2002:a05:6602:3408:b0:82c:eeaa:b1e0 with SMTP id
 ca18e2360f4ac-83b65037cf5mr1720870939f.11.1730727867287; 
 Mon, 04 Nov 2024 05:44:27 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048e4f61sm1917489173.82.2024.11.04.05.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:44:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] Makefile: Fake external blob with BINMAN_ALLOW_MISSING=1
Date: Mon,  4 Nov 2024 06:44:24 -0700
Message-Id: <20241104134424.845473-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This flag was lost by a previous change and has never been restored.
Without it, binman cannot fully handle missing blobs which are
themselves inputs to mkimage.

Discussion on this at [1] indicated that this was necessary but the
patch was not updated.

Restore the flag so that all missing blobs are reported.

[1] https://patchwork.ozlabs.org/project/uboot/patch/
    20221206020336.315465-1-trini@konsulko.com/

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 93685d0dcb9 ("Makefile: With BINMAN_ALLOW_MISSING=1 don't error")
---

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7275a02f24c..f92f46b3ab7 100644
--- a/Makefile
+++ b/Makefile
@@ -1398,7 +1398,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
                 --toolpath $(objtree)/tools \
 		$(if $(BINMAN_VERBOSE),-v$(BINMAN_VERBOSE)) \
 		build -u -d u-boot.dtb -O . -m \
-		--allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
+		--allow-missing --fake-ext-blobs \
+		$(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
 		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
 		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
-- 
2.34.1

