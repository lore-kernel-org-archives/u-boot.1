Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70A7CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9DD086BA1;
	Sun, 24 Sep 2023 22:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZuwacEeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68DA186B5E; Sun, 24 Sep 2023 22:40:34 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 223C686AE6
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79fa5d9f3a2so123402939f.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588030; x=1696192830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+Ze21jVx8j0a0Uh9dpQ3jqNU7Md9gWDoUk2AkvuKbE=;
 b=ZuwacEeq9v2BIobxTJ0iHReYsjELvpBw7574VFL60H2Qxf/Vhzk2cJxIpX18txoZNC
 fpXxI0/3t0RA9j37sGNnY1N+R99p/ult9vnbzSu3k2wzek2QmUO0j/d9NsVF5emoXW5d
 xicvXeaQR5/TW78aOr6v7pD3GEKX//2YbRTeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588030; x=1696192830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+Ze21jVx8j0a0Uh9dpQ3jqNU7Md9gWDoUk2AkvuKbE=;
 b=pkHEWrWzVHL+zX+cpFnX5L/fznbtL0p6XqTh/8QwlAuWDBt4/sTgQzaJ50A3UbW2s+
 eCkuNggp4IV54/Of2IE3RusoVsFCDp7Vb1XaZnUtaCH0H18LCSe7YhbwOt9ZKw+6tNmo
 ixQnyXnYqOOn1NzY4q9Je4Rz3vN2t8Stb32rr5onHfAJAXtqUKnSsa4e+AtuWUsOINCC
 IUgk7WOiG4lvsQ/y+OHsrqnTa5W+jC0/zns25FZMZunXMhxiiaWfxKfeYPKFqZqU/9Ec
 nqUNZjCXXcoEsIweq+K8zgQPAB7x0n3glDiglevURiV8e7H+AsuXqeEBcGeSF+gE8aAJ
 vDCA==
X-Gm-Message-State: AOJu0YxSJM3LfT9dSrgyoHc4wNrsIg3vD4jvy6LULtEAeD7gboAE2fA5
 Nj0eAJxFUvmRTOqlvJ7YQRlYxLoI25aQbY2gvNc=
X-Google-Smtp-Source: AGHT+IERlpgqYb3YSsXQ6s3q7ewQwBVxUTAJmJEiNhdg/tS6MKZ8P+A7BjDSoyBvb+flllM+7Zyzkw==
X-Received: by 2002:a6b:fc14:0:b0:785:d4f5:2225 with SMTP id
 r20-20020a6bfc14000000b00785d4f52225mr5192229ioh.19.1695588030715; 
 Sun, 24 Sep 2023 13:40:30 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: [PATCH 12/25] armffa: Correct command help condition
Date: Sun, 24 Sep 2023 14:39:30 -0600
Message-ID: <20230924203953.1829820-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

The help text should not be build unless CONFIG_SYS_LONGHELP is
enabled. Add this as a condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/armffa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/armffa.c b/cmd/armffa.c
index 7e6eafc03ad7..28b65678a8e9 100644
--- a/cmd/armffa.c
+++ b/cmd/armffa.c
@@ -188,6 +188,7 @@ static int do_ffa_devlist(struct cmd_tbl *cmdtp, int flag, int argc, char *const
 	return CMD_RET_SUCCESS;
 }
 
+#ifdef CONFIG_SYS_LONGHELP
 static char armffa_help_text[] =
 	"getpart <partition UUID>\n"
 	"       - lists the partition(s) info\n"
@@ -195,6 +196,7 @@ static char armffa_help_text[] =
 	"       - sends a data pattern to the specified partition\n"
 	"devlist\n"
 	"       - displays information about the FF-A device/driver\n";
+#endif
 
 U_BOOT_CMD_WITH_SUBCMDS(armffa, "Arm FF-A test command", armffa_help_text,
 			U_BOOT_SUBCMD_MKENT(getpart, 2, 1, do_ffa_getpart),
-- 
2.42.0.515.g380fc7ccd1-goog

