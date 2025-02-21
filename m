Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C728C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 20:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3651807C4;
	Fri, 21 Feb 2025 21:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jxjH8fDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1801E80EC0; Fri, 21 Feb 2025 21:32:55 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 456758001F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 21:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5fce03395d4so2031091eaf.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 12:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740169970; x=1740774770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wtael3p/NLxQZLd+f7MpzrdCy6RdP8C5//8NuVJtaZA=;
 b=jxjH8fDmsnNQyben5Jw0Ai7YhiGIdg1S8NvZYT4HU6hpMwLg4ZsVRcpb6eoCRdrJmU
 CcgcaWksETer5rFHIRe2vcPgbhkBo8dU37AdMwIS8sF2zam1tV9PnDTo8tPsvwCYJ1ep
 WVq0MTIuTVc5MsdYlgESjXr+Bcko2RJN2IktE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740169970; x=1740774770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wtael3p/NLxQZLd+f7MpzrdCy6RdP8C5//8NuVJtaZA=;
 b=a2DgUNno+zYh99tRuThCefWJXrTsnaKwRmP70xXVxVqVKnNFqJAB7h4qBQExl3Cccz
 59Vkt7OR7mGOv62pnfcYoeBsygf6jd0gCtUs25gklA+BP+TMK61T8UGaXWU6NBu/9H5s
 QuBtJo360CK49lqDj1ZIkzj1sjZ88VQre22AZX+bYru+3YAZMX8PzNhSQex6TOEjABel
 SeMbutJFZrxkOnxooBiLcMfV9sCrgaKU2k6HwWFDX6/BjGEZHEZsYwkC6u43zWLkuuMB
 8EgsKo24TmpLEeH4H4XoLrmntKmC4gnVzKrxizUfALFrhDWef+9dl+xQq/Y2mJ6GqR4F
 hH6w==
X-Gm-Message-State: AOJu0YxKG9HVUwcnCtMhR0IuECY4HIas3CDHpCjDsTOXMhPDMwkHiSY+
 gXTljAidAqcldPnvyxi37g9RvtoVKntkqcxmKG2690TQ5qjZVbGz/dDV90lRQKUcecqWc92Kj7o
 =
X-Gm-Gg: ASbGnctTMrcfX8nL2hOhSPmFhth0pVCxLifWRKSuuE+n4QWARl1P/3qnq8t4oE3VE+i
 YQKwND0nbSXDQv3kebb1ne1WRLJvDvZGgsYo63HMWG2Dx+G3IFLP53Myo2MkoKbRITaslJGyWc0
 eWMy9RQ0G79Q3jeQKmOyhTqHImxAPTzof0V7BDx/CAOGPkz1ENC52alhWARx4xeadgCZTL+8X2s
 Xn7v65N2RVyKb8Ekd1sB05o4ssTyqKOX7IPBZqQh0kmXOKxhp0UHDldO+kKYAMdswHPTN8/x75K
 G2DWOXkJnQJ2NgJ11s+nODD9ojydBOHkJbuNe7lodpLzTyoTXx4XkDdMKcQhOvg=
X-Google-Smtp-Source: AGHT+IHszluu9fSgKpRctg4sngL9Rz+/JGeCiXNGhPDeQXc9D/7w0lRy/8i9E9oyVs2L2FelIrq27w==
X-Received: by 2002:a05:6808:80c6:b0:3f3:b0ae:7998 with SMTP id
 5614622812f47-3f4246d4b88mr3711966b6e.17.1740169968847; 
 Fri, 21 Feb 2025 12:32:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fce4c93aaasm2523681eaf.40.2025.02.21.12.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 12:32:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 1/3] labgrid: Deal with strange Python error
Date: Fri, 21 Feb 2025 13:32:40 -0700
Message-ID: <20250221203243.672465-1-sjg@chromium.org>
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

Add a way to work around an unexplained Python message which appears
sometimes with Python 3.12.3

Make the file executable while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 bin/getrole.labgrid-sjg | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 bin/getrole.labgrid-sjg

diff --git a/bin/getrole.labgrid-sjg b/bin/getrole.labgrid-sjg
old mode 100644
new mode 100755
index 52fc3ce..7cef0a5
--- a/bin/getrole.labgrid-sjg
+++ b/bin/getrole.labgrid-sjg
@@ -21,5 +21,14 @@
 
 [ -n "${do_configure}" ] && config_arg=",config_file"
 
+# The following spurious output is present with Python 3.12 on Ubuntu 24.04 so
+# use a redirection to drop it:
+
+# Error in sys.excepthook:
+#
+# Original exception was:
+#
+
 exec labgrid-client -r "${target}" -a query -n \
-	UBootProviderDriver:board,board_extra,source_dir,build_dir,build_dir_extra${config_arg}
+	UBootProviderDriver:board,board_extra,source_dir,build_dir,build_dir_extra${config_arg} \
+	2>/dev/null
-- 
2.43.0

