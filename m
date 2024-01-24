Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C521FC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 20:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F2387C69;
	Wed, 24 Jan 2024 21:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ODkZ8d2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BEF487C96; Wed, 24 Jan 2024 21:27:57 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3710187C32
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 21:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cf1c487235so17720231fa.2
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 12:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706128074; x=1706732874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5z7thg8JWWpiS5+Hv7B6GEHm2pbckpZFqVN0IlQBotY=;
 b=ODkZ8d2v3hZOv/bZ2tIcNVOrloySL//L0FqNyGW6bkftupfAFggFhWaCXahe82wkn+
 isWGt/yRS8ugxj+vUX3e5tm6H35p+9Dqju1nnnldQFPxxi55EPCf2O7rQCc8tqsjVpGP
 jay1fLeXtJDs4jPU/fte0JxF9gSaIW5F49t0qtD4uE3TAWvJycwFjQRH6O/GrcYhKODC
 n0xjMas2IEf0I6JEhPF2/L8t7AQjHwbJGSiEGAz42yzlgFAuOmibMRHuvPBjFo4cWEGy
 qIulqvdqzsw8k75EfzEckL5ivGl0xtx/eoAt2/Fye22zxZ5HM41em7u5V1esuRWLD2rL
 MKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706128074; x=1706732874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5z7thg8JWWpiS5+Hv7B6GEHm2pbckpZFqVN0IlQBotY=;
 b=D+SFYJ4Kbw8sPYUGkMJdUaU0VhpsqsWLpMJ82rzov/UCRwF8reEiFlH/0us6nrBdBA
 3EHaqbig6PqJx/bwXCcv2j0i0LQtv08z0aG7ibSPLdVkMcnZ0Z8nVOXaYsVSgdiUCfrV
 9wytQ4U4omnZN+8bOcCOy93yvxvQICgdXsUnI1xp5VkaGHU9JGdpBjk4kejo71+/nEnl
 E1C5yEGkiTYIWxHJNzrMt3fKxInIwOxSmyVqb2e/u5yvhdRd+RSEMAApqhg68aaAMLaS
 QFnnANWTUf2cie/fDH+Ug87s8IKI3z2j8+UDZ6zSvvee5aIH6C25yU/S68I73UvtGx62
 q5Mg==
X-Gm-Message-State: AOJu0Yy3C85LUonML8luzNZb/yqie86aUsAgk0rd2trt9vzIJixoe7qG
 9BUDMvL8pmF2fp/UcVM5Emkj1oN+DDmydV2MSxTxAENuiyDPspRY
X-Google-Smtp-Source: AGHT+IEkuCSPWkqdLriYzIiuxZBll56xzoPo5EWKVPHl6KbqDXIZvM6BzNsnmJDGvNwIbTsr0EEYgA==
X-Received: by 2002:a2e:7804:0:b0:2cf:2fb1:bdb0 with SMTP id
 t4-20020a2e7804000000b002cf2fb1bdb0mr343872ljc.72.1706128074202; 
 Wed, 24 Jan 2024 12:27:54 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 dm24-20020a05640222d800b0055c1433be60sm4656763edb.50.2024.01.24.12.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 12:27:54 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] boot: pxe_utils: skip fdt setup in case legacy kernel
 is booted
Date: Wed, 24 Jan 2024 22:27:31 +0200
Message-Id: <20240124202731.39212-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124202731.39212-1-clamor95@gmail.com>
References: <20240124202731.39212-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently, if boot with extlinux.conf and do not set the fdt
U-Boot will provide its own device tree. This behavior is
beneficial if the U-Boot device tree is in sync with Linux,
but it totally halts the booting of pre-dtb kernels (3.4 for
example) since it uses ATAGs. To fix this, pass `-` in the
fdt extlinux field as a signal that no tree should be used.

Suggested-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Tested-by: Jethro Bull <jethrob@hotmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 boot/pxe_utils.c       | 8 +++++---
 doc/develop/distro.rst | 3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 83bc167785..6a2c881965 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -634,7 +634,8 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		char *fdtfilefree = NULL;
 
 		if (label->fdt) {
-			fdtfile = label->fdt;
+			if (strcmp("-", label->fdt))
+				fdtfile = label->fdt;
 		} else if (label->fdtdir) {
 			char *f1, *f2, *f3, *f4, *slash;
 
@@ -731,13 +732,14 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		zboot_argc = 5;
 	}
 
-	if (!bootm_argv[3])
+	if (!bootm_argv[3] && strcmp("-", label->fdt))
 		bootm_argv[3] = env_get("fdt_addr");
 
 	kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
 	buf = map_sysmem(kernel_addr_r, 0);
 
-	if (!bootm_argv[3] && genimg_get_format(buf) != IMAGE_FORMAT_FIT)
+	if (!bootm_argv[3] && genimg_get_format(buf) != IMAGE_FORMAT_FIT &&
+	    strcmp("-", label->fdt))
 		bootm_argv[3] = env_get("fdtcontroladdr");
 
 	if (bootm_argv[3]) {
diff --git a/doc/develop/distro.rst b/doc/develop/distro.rst
index 8016acad09..c81da8a0fd 100644
--- a/doc/develop/distro.rst
+++ b/doc/develop/distro.rst
@@ -81,6 +81,9 @@ as specified at `Boot Loader Specification`_:
 * Does not document the fdtdir option, which automatically selects the DTB to
   pass to the kernel.
 
+* If no fdt/fdtdir is provided, the U-Boot will pass its own device tree, and
+  if fdt is passed with ``-``, then device tree will not be used (legacy booting).
+
 See also doc/README.pxe under 'pxe file format'.
 
 One example extlinux.conf generated by the Fedora installer is::
-- 
2.40.1

