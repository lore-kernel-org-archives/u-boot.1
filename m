Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C18C54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 11:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95733874FC;
	Tue, 21 Nov 2023 12:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CfYQV2gY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD4687438; Tue, 21 Nov 2023 12:36:08 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE3387438
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7b05e647c09so183692239f.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700566564; x=1701171364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9y5h/1c9Kh328O9+SckjW2urJLWbt1UFKR5X8ZqEDAo=;
 b=CfYQV2gYOuCl5zUdD04jsj/bg/CwTTs3KAPptWs0og04V6bPnGMuhYpEHY7Lzrlgdy
 IKikVDsKiXvkMTOiC625AlA5ONyIkv117rkwY3Oi3khxN8qEqOpX4CPfZXRZoW7/2BMO
 dSxAIcNeRw5Yt8F/usmH+jXsm7Kg19Jh+0c7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700566564; x=1701171364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9y5h/1c9Kh328O9+SckjW2urJLWbt1UFKR5X8ZqEDAo=;
 b=JmBOl1pwwPv3OtK15vvkYwZlyRk1TKLmDVHlb7Ur9HcWycnly4QHP14vTGOj+fXhZj
 uXuL++Elb7oWe5rBGpWLrMZYET3aM6IHKlUDFOssud4rKR/E5Xo17j5MksbXAmA0FWWk
 y0pcB9tM0bDMGA5ts+ZlmzSkqL2QleyI9dO1HwxNxzuIvarQbfnBwhAz53tiGZngSAgc
 Fvd/6jupjUcv4StiRDRh0mmWPa9yAyj75Kza5/hjaMZOXIDOIanEj5FF6AmUrRE7Swfs
 fotLnCT7pe5/fV2j75x1XKj+3R1x6f1y2Txh5QqNUTGFZDi3ReBgfXlJ0MElScVH2cdh
 qSIg==
X-Gm-Message-State: AOJu0Yz8egZo6bC0eDbEYaftnHOG3l7wYrtAgZTSVVjc7vr3AOAPPQcP
 6ekQzXwyGpgzaGCOuEigygpgqicXRDk8+wowpZrnQA==
X-Google-Smtp-Source: AGHT+IEFQQIZDavPugIlyBVd91lFUhZVqfls6oWOTcAi5WerK0WBEU64UXz4skm42/8mH6eMLgtHKw==
X-Received: by 2002:a6b:d211:0:b0:7b0:aea8:2644 with SMTP id
 q17-20020a6bd211000000b007b0aea82644mr7228586iob.8.1700566564111; 
 Tue, 21 Nov 2023 03:36:04 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a0566380f8a00b0045bb982a3d2sm2559190jal.60.2023.11.21.03.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 03:36:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/7] efi: Use puts() in cout so that console recording works
Date: Tue, 21 Nov 2023 04:35:47 -0700
Message-ID: <20231121113557.800353-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121113557.800353-1-sjg@chromium.org>
References: <20231121113557.800353-1-sjg@chromium.org>
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

At present EFI output to the console use fputs() which bypasses the
console-recording feature. This makes it impossible for tests to check
the output of an EFI app.

There doesn't seem to be any need to do this bypass, so adjust it to
simply use the puts() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index a2d137d7a9e1..28087582e8d6 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -182,7 +182,7 @@ static efi_status_t EFIAPI efi_cout_output_string(
 	}
 	pos = buf;
 	utf16_utf8_strcpy(&pos, string);
-	fputs(stdout, buf);
+	puts(buf);
 	free(buf);
 
 	/*
-- 
2.43.0.rc1.413.gea7ed67945-goog

