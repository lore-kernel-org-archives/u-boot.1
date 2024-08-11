Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0E7C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540B388453;
	Sun, 11 Aug 2024 16:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HgV/Pd4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E195F884C3; Sun, 11 Aug 2024 16:41:39 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D362288176
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 06A5C3F2EE
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723387296;
 bh=ZARblk+DsGYe8seZA/dgD4747L+CkxrghBrkKdgE8bc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HgV/Pd4NPfAtFK4+ZVF24RRDhBuHsa73l2MccsfNigPXoKXZ7exofhgK7R409sadL
 zCle8XaT3BWnh7N+T1Wu8RXBQv+qYZMz5juTcUfNRWkeAsaOK3+zVgcLFlD1aWhlLK
 4dELh3CeBnJkvXB+gG0IJMA/6yJLt3r+vBR5tLzt4SMWRKcHHUGd+7qzUc66kgoc2+
 EOtkoYfV6BkIM7Dc7xaj1QF7y/UnOaI1p3H1jjp7BsuuQlX9zo9J5JUJlkqH/LT7y6
 FvLXJ25rGkjfZYe5V2zUdmgYEUUMNOKPoyEI12cDm9lXuXCyl20voF3Q/fLn/xVBoy
 Q0BJD+R1pkY9g==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-368448dfe12so2139305f8f.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387295; x=1723992095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZARblk+DsGYe8seZA/dgD4747L+CkxrghBrkKdgE8bc=;
 b=aRHR9no94BeuI29qdIvstVi0M5ZgDUdukPUCJC5fv2fcznGvukzPvl2l65z6UdpYQa
 /SdvOzOCnahGky7a380p6+RJGaZ2VySllGzM5WGRddsb2pLGaXFNXyH6tp5Ukw2m38qk
 XrVxfeP0YPZUfiNOOFs0oBgOrN970GMKPwpnEVIGG+127BnyX5W8T4wZ9T1uHFbn6v4R
 DFPeHH3OOWD+lWTD15FanpO1ciYU/B7hxeusfk6efM3L9Ug7iokp0RPyIM81T7Px6vlq
 2Eeat1Ak6t5bBAW40fHdsCSx/gwyYePnN/rU6xYcOb8tKnz4rBz/IpNMb6H2doxSFmUX
 UStg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSXn4YDDah9RjfdvyQuQYWM9++SJaT+SXHMPVzpxu8n2W/yA1aW9uxWYxh2Vref0LGAzMRX684KPAl+iJ9jTnigBQ+zQ==
X-Gm-Message-State: AOJu0YwLvyPK5xZt+igFsJHcqI9ZNjafthhxa8WUCTWbkVzXP0Nr6biA
 bL0HB34yL8gXEGIvMO8Vrj0CuDRmGhcJid0XTCCtdcfRQmZo7UTaOsQQiOyaFlC/L6b9ia/yOiX
 qKrBnF2KiP2Mon6rhh5WGKPPCS2I8yxTL27aVVLWW9BaQWPWx7+IIStgPgmtVqTft67g=
X-Received: by 2002:a5d:6187:0:b0:36b:aa27:3f79 with SMTP id
 ffacd0b85a97d-36d280bc861mr8519189f8f.4.1723387295477; 
 Sun, 11 Aug 2024 07:41:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrCIfskCBM4szj/coflQG5irGHjzzcc0qdQPnbTF9xKMJemObbc4Jynkd1pe/69J4UafulpA==
X-Received: by 2002:a5d:6187:0:b0:36b:aa27:3f79 with SMTP id
 ffacd0b85a97d-36d280bc861mr8519180f8f.4.1723387294949; 
 Sun, 11 Aug 2024 07:41:34 -0700 (PDT)
Received: from localhost.localdomain
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c75042e9sm68151065e9.8.2024.08.11.07.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:41:34 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>
Cc: Leo <ycliang@andestech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: add rdcycle test to RISC-V exception command
Date: Sun, 11 Aug 2024 16:41:23 +0200
Message-ID: <20240811144123.211756-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Some versions of KVM don't allow access to the cycle CSR.

Provide a command 'exception rdcycle' for testing.

If the cycle CSR is accessible, we get an output like:

    => exception rdcycle
    cycle = 0x41f7563de

If the cycle CSR is not accessible, we get an output like:

    => exception rdcycle
    Unhandled exception: Illegal instruction

Put subcommands into alphabetical order in long help.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/riscv/exception.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/cmd/riscv/exception.c b/cmd/riscv/exception.c
index 2b58b1c449c..16e335327f1 100644
--- a/cmd/riscv/exception.c
+++ b/cmd/riscv/exception.c
@@ -36,6 +36,14 @@ static int do_ialign16(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_rdcycle(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	printf("cycle = 0x%lx\n", csr_read(CSR_CYCLE));
+
+	return CMD_RET_SUCCESS;
+}
+
 static int do_unaligned(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
@@ -62,6 +70,8 @@ static struct cmd_tbl cmd_sub[] = {
 			 "", ""),
 	U_BOOT_CMD_MKENT(ialign16, CONFIG_SYS_MAXARGS, 1, do_ialign16,
 			 "", ""),
+	U_BOOT_CMD_MKENT(rdcycle, CONFIG_SYS_MAXARGS, 1, do_rdcycle,
+			 "", ""),
 	U_BOOT_CMD_MKENT(unaligned, CONFIG_SYS_MAXARGS, 1, do_unaligned,
 			 "", ""),
 	U_BOOT_CMD_MKENT(undefined, CONFIG_SYS_MAXARGS, 1, do_undefined,
@@ -74,7 +84,8 @@ U_BOOT_LONGHELP(exception,
 	"  compressed - compressed instruction\n"
 	"  ebreak     - breakpoint\n"
 	"  ialign16   - 16 bit aligned instruction\n"
-	"  undefined  - illegal instruction\n"
-	"  unaligned  - load address misaligned\n");
+	"  rdcycle    - read cycle CSR\n"
+	"  unaligned  - load address misaligned\n"
+	"  undefined  - illegal instruction\n");
 
 #include <exception.h>
-- 
2.45.2

