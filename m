Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47421C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41FBB829D4;
	Sat, 10 May 2025 13:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NspzFS3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7AC829E7; Sat, 10 May 2025 13:06:01 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FE19829D4
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5fbfa0a7d2cso4926481a12.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875157; x=1747479957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n22EZao35aq9cgLgvZj/Pjvaqv0fTvrMH2/1+C5VvE0=;
 b=NspzFS3Tins0dIRDWfsZ7B5qZAliRKABBC6Cce6TquAo5UopSviEilYgk+aspO+5mf
 BIE12c9JYKx5R692wDwZUYh5uzqC+z/ODHiPp/9sKIc41/DTu9fpLxHZXoFTm8Jy0anw
 m2qZ1GRm45b9E4zdg0OtbL8wMTqVWbJi651Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875157; x=1747479957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n22EZao35aq9cgLgvZj/Pjvaqv0fTvrMH2/1+C5VvE0=;
 b=aNfmz/Qcufa4ykfbGxhhZMgg6JpD5tFfPCo13gF3rZ/jvlS56RTNYeblSHxLG7IGXR
 GZ4zCX1TxwObTy791Tn24DHpDYj9kXj49aF+OvdOrfrbsoS5ilm0J789CtzYbM3d/jFg
 OGm6sQ7cx40G57v0HZWktr7ExA7wEJh70cCVvgRwGtNRNP78HbHtUTJ1bEkepN1F5BFi
 tC5Z3EmtDMry0epfqvFRTHcbGoS851GYYMZB8p+oKUWNaFNig6XefXBxwYZlf7uuR3JR
 W+9qhbO7eapSWl38Fk5z4kIg70BLhfTZBitLJfDTOgX9r22Ahxvsa2MqUgSWOIykuor7
 O2rw==
X-Gm-Message-State: AOJu0Yx94b/3DtYJNi6kfd8ZAq4JDOBnv8xN4pMozP8wzMrH2au/xEwD
 4paDQP9Mdc5XdvlgLML8rWF3TSzUshrXzR6EQNmBY95I7hZ9dnGZIYq3x6uSPdYF0WVoR2nqeTM
 VujBdDtF+tg==
X-Gm-Gg: ASbGncvvKTrPQhOlw/f0qGh0JEQ2/a5nxDgS5nFUtlR/6qpAMSacNpE+iS6mh3tJSV9
 3EaAIZZLsnPRxT1h3lQfkMfnr42ODR7FM2zktHjBGTjDSCpvTs0gZ0036ZCZCFvxDlnXgVFoUyO
 tr5Pe26ciIqvduA8wxZzIckl4+O2/L9R6jBij3abdudaG9s+gH+Klro2fb2cHnPuQG9jWeusfQi
 1AxiweoGYW2seCOCL7u+9V1idpt90Lf4VHTnrH7atFZzfvTK03RBYjRAdm+5kKLVic0i8nNlzja
 vqHZw7/DX29SIXWU+7DXrv1C8wWM48Xrp5jjMzRPKHZOVD31XlNICXQWSQ==
X-Google-Smtp-Source: AGHT+IEIHpWNHC7vcGIazeTQG1vF3d64+15KOnmlH4H+axhRRQA5t/7IO/hd3myiRDsPDzD5sd8YaQ==
X-Received: by 2002:a17:907:1b1c:b0:aca:d6f0:af0c with SMTP id
 a640c23a62f3a-ad2192d4a49mr631690666b.59.1746875156957; 
 Sat, 10 May 2025 04:05:56 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:05:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/25] patman: Add a test for collecting a PATCH prefix
Date: Sat, 10 May 2025 13:04:58 +0200
Message-ID: <20250510110535.1453745-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Add one more test for completeness, since this occurs commonly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index da81101ea93..55abf52bdb5 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -877,6 +877,14 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         self.assertEqual(None, patch.prefix)
         self.assertEqual(None, patch.version)
 
+        # With PATCH prefix
+        patch.parse_subject('[PATCH,2/5] Testing')
+        self.assertEqual('Testing', patch.subject)
+        self.assertEqual(2, patch.seq)
+        self.assertEqual(5, patch.count)
+        self.assertEqual('PATCH', patch.prefix)
+        self.assertEqual(None, patch.version)
+
         # RFC patch
         patch.parse_subject('[RFC,3/7] Testing')
         self.assertEqual('Testing', patch.subject)
-- 
2.43.0

