Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2E1E67803
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 18:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A874783E70;
	Mon, 22 Dec 2025 19:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sk2wHwIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46CC083D1A; Mon, 22 Dec 2025 18:43:14 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C48F83B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 18:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-34ab8e0df53so4045327a91.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766425390; x=1767030190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BPY8ZnhOKfwYeYYJXbbaC+yQlVtyDPvYfLlFBjOalnE=;
 b=Sk2wHwIUWmXve87UFyWt9Znl89iMIKM6xijaEChxKOV5RGTpIgnfykK9uNIfql//4i
 k/+3FUhtgRblnSLIr6kxj8dHMAMCdD0uUdZY4GCCoRE5q5QH+lqLbDz5bd079hPlxwi4
 cgdoTWDTm1xcxioXOoBMbv0vg556TufJM6I/UrAckdcYb8SDj8rKOPFJT6ErFzBlVvkh
 bzGgNCcFIl+E0yJsVYL2Ahpsvh+rFvs56CEQ6TESVPOIw4by4YxTKA4/cRNNQPdUfWeM
 nkE2ColKMG2DurRZbdF3HNbm9O9E70V0AYxpu5BVBCuRFKj9Xwjf+oMw3ZUR4iNNObtj
 8NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766425390; x=1767030190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPY8ZnhOKfwYeYYJXbbaC+yQlVtyDPvYfLlFBjOalnE=;
 b=JAqiJsTAY2QGc+2WfPWvyxJ+3IhzK/zfZ918ZOjBmlmOvORBhFtfM7ohgV5PJgBka4
 4vdcBBd/FbGumRnoaYx5VK/uq/aznIaNo+bQXvLBSj6JHt4C/4RT/Bu0AS1yxhZ9zT/a
 pXQWZbC6QvqmA7BnF+RK6NEuDaRq1BV9CNzh9bAdthDJg6RjLZKJUPR0eOQMeOK2hzTd
 LX2gwGmkyHvv7oc/IzApzYB19P6WJ2V1D5VSliOCs423AaQqdMQ+qINQvjTejWsUVOPe
 Q47JGd3OsId3ct0s4h6+YgeWtF5roM7ls0CPIo7kZmJ8rtSPaP7amP34oEsZM6/nUn+5
 iJHg==
X-Gm-Message-State: AOJu0Yzk+RXMLjQbi6LC3IceTtJA34KMm/n3W+gBjnF+Ar0kLjzRvTVa
 k7YKsC9R2JcbmkZiATYAzHW6TOWxbLi/RxMCLJDRKuMlNJd7tNXf8OZU
X-Gm-Gg: AY/fxX5uY1QN/d3gk3VHWNCMeIs5laj/WS1RUjnV9Q/lhri9j1KbGx8gBUNxmam77IW
 kE2TElMeNZgnk+hB9fbKatOQEfmvT+nLKJRXG4MIrpHBMhJZYE5u0dp3Y6PFIg01MBgIiotFonz
 DngaxvrAGc2o3S/uAUDNwcLcvjZDtSgUMLwcgU68RMY3YgrIas0oYWPz77ZiGnrrHs+tSBAU2Yc
 BkxdPQR0qjZ3oYQvDuJmc+5V/trnZtHQfRifouVE2WlXjG4fd0cMHa7voSrSPzBYGu7u/C3xxqG
 4QM42MT7gaWlirneOWLhZqcE/9DL8yJ3p7Bep6O6ismxqkfZb8GkYebXF5fUWLfaiGo3L+POhXD
 dZtdEWqrO/zFad72o9D+ki6z8v2scrl4six3qmQowUyZfDV7N8+avKT6uCQgS/wdtni+nthsUyq
 yt6PsSQRfHNR4kR3AaMN5sCiBLEOnBwx1t2dpLqzJ4CEY/94GDG6evJJIL9XcbueciyTx/zh7f4
 DE8zvocFwgGVuovzon4LA==
X-Google-Smtp-Source: AGHT+IHPr/wDReRR8MrQaP43Qpb+TZR50iRiNbigjNTxljUDtcD9O7r03QjdTVmj1U9Bh9fndxmnEQ==
X-Received: by 2002:a17:90b:1f8a:b0:340:f05a:3eca with SMTP id
 98e67ed59e1d1-34e921beb7fmr10109482a91.20.1766425389572; 
 Mon, 22 Dec 2025 09:43:09 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e7710a5f8sm5353064a91.6.2025.12.22.09.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 09:43:09 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] checkpatch: Add check for space indentation in Kconfig
Date: Mon, 22 Dec 2025 17:42:55 +0000
Message-ID: <20251222174256.2455458-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 19:04:16 +0100
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

U-Boot requires Kconfig options to be indented with tabs, whereas Linux
allows spaces. Add a U-Boot specific check to warn when spaces are used
for indentation in Kconfig files.

To ensure this check is executed, move the u_boot_line() invocation in
process() to occur before the valid source file check. Previously,
Kconfig files were skipped by the file extension filter before the
U-Boot specific checks could run.

Example warning:

WARNING: Kconfig indentation should use tabs
+    bool

Link: https://lore.kernel.org/u-boot/20251222162026.GA847766@bill-the-cat/
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 scripts/checkpatch.pl | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c755880ef93..7e4d6cd227c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2753,6 +2753,12 @@ sub u_boot_line {
 		ERROR("CONFIG_xPL_BUILD",
 		      "Do not use CONFIG_xPL_BUILD in device trees\n" . $herecurr);
 	}
+
+	# Kconfig should use tabs for indentation
+	if ($realfile =~ /Kconfig/ && $line =~ /^\+ /) {
+		WARN("KCONFIG_INDENT",
+		     "Kconfig indentation should use tabs\n" . $herecurr);
+	}
 }
 
 sub exclude_global_initialisers {
@@ -3943,6 +3949,10 @@ sub process {
 			     "It's generally not useful to have the filename in the file\n" . $herecurr);
 		}
 
+		if ($u_boot) {
+			u_boot_line($realfile, $line, $rawline, $herecurr);
+		}
+
 # check we are in a valid source file if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|rs|s|S|sh|dtsi|dts|env)$/);
 
@@ -4034,10 +4044,6 @@ sub process {
 			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-annotations.rst\n" . $herecurr);
 		}
 
-		if ($u_boot) {
-			u_boot_line($realfile, $line, $rawline, $herecurr);
-		}
-
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
-- 
2.52.0.322.g1dd061c0dc-goog

