Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6EFC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 15:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E848882B1;
	Fri,  3 May 2024 17:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qYzvkGCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D6A882D7; Fri,  3 May 2024 17:20:10 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 101BB882A7
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 17:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a599c55055dso95123666b.0
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749607; x=1715354407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Y42fwSjksQRwDGFraYnUZDma/DZsRCxPs9jYWEMwxU=;
 b=qYzvkGCp3L4iL5YTUBqV5q96PvqeqmCA6xP2gSZoZatWCABabpbAiWDhoHeOh2L5/z
 Xo90Cm0CQA12mDHMeUbz5yXKgd5s5Y6Ygr2Ij1tMZLtYbRT+Ai5k5pobJxpB9omgX6jJ
 6/RR2YIiFET1du6RRy8zyRMNDRuPK+ohJ8gMEloQ2DEiiAYXlu4grKr7/51btMdMIYIl
 u3SnwbnFrQmMaL1msKB81ggNZ52MMIYR2lIPV0HFxsxIVTL6GmNwAaCLkw6V2TsU8oaE
 rdP8nWFFjV1w621pvlytfB6WCMI7jv4BxOagOM5Jk45KM9DATWqniabW6FRRx157KQID
 Zt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749607; x=1715354407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Y42fwSjksQRwDGFraYnUZDma/DZsRCxPs9jYWEMwxU=;
 b=G8eQDL8tOmwNOABH/paFuchrrVV5SPE+EQlOkhaTXl3tT4IlYC852JZjXRZLq6XS+m
 3m1JI0wJmArGu2vUCLg1FrW9qNLjN5HTtmTms1ZF4bx6xgdgiL/kJOcg0/JpoAojq8w3
 goY+I++SahhCBI1ysEAKPKAaxNBKMbbhsJdpTPR3k/PNrE+hnNvhi3lMMNBGzu14zeRR
 ksiUUg51gw7JnbJrbTCLY6TIG9OF4e4mgzoxrUsEwvByYGPrFYsh4oLaB638Aj+vYH0a
 NIbVumPE+iUhMlr3U7HgDLnwgpJx0A2ISspbt7WVR2oI5wSxH6q31WRtzisFQpHv4ZVt
 a7tA==
X-Gm-Message-State: AOJu0YxFqvujs7yeQOVVrQNP1jlCHqe3V/Whbok4QbJZ5GoqDVA38lfl
 BkJeFlT2twB78xFHwtAKRt5WtV6dijEZdR5vJaKmUkGiiPRkVoOD8u+JC5AgkMg=
X-Google-Smtp-Source: AGHT+IFy59H1HeMSDqveDTEMVqXz45m4iDPKPkh18uVhEnBiB9uBIPFSKUOnv0ZZ53u9r/Yj30zSbQ==
X-Received: by 2002:a17:906:158c:b0:a55:b25d:9c9e with SMTP id
 k12-20020a170906158c00b00a55b25d9c9emr1603412ejd.74.1714749607469; 
 Fri, 03 May 2024 08:20:07 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::11db])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a170906715500b00a599c8b6531sm309609ejj.178.2024.05.03.08.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:20:06 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Brandon Maier <brandon.maier@collins.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] scripts: gen_compile_commands: fix invalid escape sequence
 warning
Date: Fri,  3 May 2024 17:18:36 +0200
Message-ID: <20240503152000.2819669-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

Since Python 3.12 unrecognised escape sequences trigger a SyntaxWarning.
Convert the '\#' string to a raw string so the backslash is correctly
used as a literal.

Ported from Linux commit dae4a0171e25 ("gen_compile_commands: fix invalid
escape sequence warning").

This updates the script to be in-line with Linux 6.9-rc6.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 scripts/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index fec513e55474..e746adddd929 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -171,9 +171,9 @@ def process_line(root_directory, command_prefix, file_path):
     # The .cmd files are intended to be included directly by Make, so they
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
     # kernel version). The compile_commands.json file is not interepreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix = command_prefix.replace(r'\#', '#').replace('$(pound)', '#')
 
     # Return the canonical path, eliminating any symbolic links encountered in the path.
     abs_path = os.path.realpath(os.path.join(root_directory, file_path))
     if not os.path.exists(abs_path):
-- 
2.45.0

