Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14292E748ED
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 10:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E4F870C6;
	Sun,  1 Oct 2023 12:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E+ZOT1aC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39988870B7; Sun,  1 Oct 2023 12:00:53 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B0C870BC
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 12:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so122337805e9.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696154450; x=1696759250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1Zp1492jG7c7BEWQV1tYh/VpdeLbdjJOPPrKGl/hcM=;
 b=E+ZOT1aCCQs5/qaHhfoqvmelHqNJ6OuCxP3AfNJNY0yTsQjEGcgaGqp6aVJ95gUq0X
 G8ySiO1TJrpXYZd9nQcKEbJsAqVcGWL5XIVBDKoLZN4j9V/A3zTHVTAI7CG2dJUdU6io
 /jKsV0d9t+03gEmJxRZLQVZ5G7E6lRtfZZnfa3QKRIUKFeGs9yeNXXDUVl3MnsccHvtc
 RkloPMyDNn5D/6gYPkHMlGWk5ZaokIoKxfivcvxC6OpD5wYrP+ZGjIoDAF2Fcoelxqia
 yvsMNz/Qbm83CMD9NLRIm1fArxDzJ+O1ic6KOEC/05F4AZSXDysMROcK9+6/84EfJ8sX
 GqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696154450; x=1696759250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/1Zp1492jG7c7BEWQV1tYh/VpdeLbdjJOPPrKGl/hcM=;
 b=gzjVONssHl7GKncyjPE0ZDtZ7MLWDiY+mTmbYO5rO+zIKry1A7OODy/YV42BSGsnRR
 ItqlBnqdh8wJuBGFRVBvGuwiwtd7fmu6+Lc+b/uyFjsNDlQMItKU0wXL0EtLOlQiAudm
 SCwNFSFK9ivCW3ZXprj1yGPhuKmihLMIHx86oIf0T5ydfR970z6qJlPw4bhh+R6VrsLW
 xa+vVi0sjmnddqI+AKVVFxWCpxgX458cI0AqDiOJ+efjB3vybhNJrn8k6rmaWfFNnWjO
 qSf2ge3IVYjHJVWmsCIO3B2PGQkNufzdgPY6UxJEG0WJ7Ks0vOPZqzFCEV9QrY76mS1w
 B/IA==
X-Gm-Message-State: AOJu0YxsWvPJbt7gL1v0aSnLd/0FxcjlqvywjOd5lhOy+9GnvY4yC5II
 UBjzze5k9PGqtirXFU+iO/dacxIN1IMZ6IrL
X-Google-Smtp-Source: AGHT+IHd1ukdEFmIcAaUM8aGQeEDiyu7Y3MGYjCB27OyT8Ecm2rnw4vLuqCxnhmEDbte7iEscbd6oQ==
X-Received: by 2002:a5d:4f8e:0:b0:320:aea6:abb9 with SMTP id
 d14-20020a5d4f8e000000b00320aea6abb9mr7719609wru.6.1696154450637; 
 Sun, 01 Oct 2023 03:00:50 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b00326f5d0ce0asm3087135wrw.21.2023.10.01.03.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 03:00:50 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, Y.Moog@phytec.de,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v4 8/8] scripts/gen_compile_commands: fix usage message
Date: Sun,  1 Oct 2023 12:00:36 +0200
Message-ID: <20231001100036.34936-9-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001100036.34936-1-jmcosta944@gmail.com>
References: <20231001100036.34936-1-jmcosta944@gmail.com>
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

Replace mentions to 'kernel' by 'U-Boot' to avoid confusion.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index aa52e88e18..cdca85e6b0 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -37,10 +37,10 @@ def parse_arguments():
         output: Where to write the compile-commands JSON file.
         paths: The list of files/directories to handle to find .cmd files.
     """
-    usage = 'Creates a compile_commands.json database from kernel .cmd files'
+    usage = 'Creates a compile_commands.json database from U-Boot .cmd files'
     parser = argparse.ArgumentParser(description=usage)
 
-    directory_help = ('specify the output directory used for the kernel build '
+    directory_help = ('specify the output directory used for the U-Boot build '
                       '(defaults to the working directory)')
     parser.add_argument('-d', '--directory', type=str, default='.',
                         help=directory_help)
-- 
2.41.0

