Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB69C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E35887E8;
	Sat, 13 Jul 2024 09:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j4061PhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC568887B9; Sat, 13 Jul 2024 09:03:48 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97155887B9
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52ea5dc3c79so3835661e87.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854226; x=1721459026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1/6LE12yEOw+93/glH1zf4y3fKkx3ociND69gjX/5g=;
 b=j4061PhVHcAlTcm9tcUETyv5XuCxJlluaYcvVNByAnb1zIoTyPifaWbwBvBJ7IuVHK
 +eq1Mom/h9UPX4iOp686r0gsrS6qxEoUC3mVGw7x/MpuuX53Ae7zy3kZEWUhO/C7FMvD
 30oKrIqkPM0R6elmqTK5E3/1HKkza5Z0LF2lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854226; x=1721459026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1/6LE12yEOw+93/glH1zf4y3fKkx3ociND69gjX/5g=;
 b=ZR0dks51l9wCbASc5KHjOykzrT5w45oXp1R7rOhF7GYc/q2hxDS3uS1TIjG/AOWFdt
 S3pHYGxHUiImW9rj6DiVvgeIEuHQfSsC8GLC90m61FJwuC8gDv4RoQllD36MndxXD1W0
 zXxTblQCo2zcKq6EMRkJQ0kRsep/YRtdirfr+6G6Nz/TIZSWipeKlh5YPc0JnhCDu/2L
 QKJneyYwL4huCmplCvFuVPzoIeY+GOjqlfMlGvjIco55jSGrozgfW8TAar8UF/aICvre
 XMJk35aPWTiwheGJTnEuUL4s8K8yefWM063NBaL9oHRqPAf7eIX33mHUw5J1n+4bMWGU
 RJkA==
X-Gm-Message-State: AOJu0Yywt7qBQMm6zL0fXqpxY9RL0C+FRK3DbtjQEg1hZnAFAe2kVvZ6
 Lp0ly5A0kiDLsT/NQwXbqk/Zzd/Ax3qkFw85bKNDLUYBtoy1q0PCJauAqe849ehjJ/PE1D9jdL0
 =
X-Google-Smtp-Source: AGHT+IGdBcUmRV1FyqGvrCi7uNhCGOKwu8Crq2LjeN7sG0XktunLgOaSGMocUgoXMdUrAWEWYuNJXw==
X-Received: by 2002:a05:6512:53a:b0:52c:def4:386b with SMTP id
 2adb3069b0e04-52eb99a3305mr6517678e87.35.1720854225716; 
 Sat, 13 Jul 2024 00:03:45 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/21] fdt: Don't overwrite bloblist devicetree
Date: Sat, 13 Jul 2024 08:00:39 +0100
Message-Id: <20240713070055.2172883-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

When the devicetree comes from a bloblist, it is currently overwritten
by the appended one, if present. It should be preserved.

Adjust the logic to support this.

Fixes: 70fe2385943 ("fdt: Allow the devicetree to come from a bloblist")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/fdtdec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b2c59ab3818..4861da1fab1 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1678,6 +1678,7 @@ int fdtdec_setup(void)
 				gd->fdt_src = FDTSRC_BLOBLIST;
 				log_debug("Devicetree is in bloblist at %p\n",
 					  gd->fdt_blob);
+				ret = 0;
 			} else {
 				log_debug("No FDT found in bloblist\n");
 				ret = -ENOENT;
-- 
2.34.1

