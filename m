Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE1FC47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77EEC87D6C;
	Mon, 29 Jan 2024 13:58:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="T7AiIe9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CFE87D6B; Mon, 29 Jan 2024 13:58:34 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A6A887C44
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EC3333F048
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 12:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706533110;
 bh=eVegKe9LjEo5baDYSOXnI9Ie4V9ippd39v10zjfQWew=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=T7AiIe9FM+p76dMFWiPr1gOKqvdZLYu7eB2cnlutefhwdl1V/bku0+O2EbtgmJrE3
 SwUD3lzHQrYIjM7cOO6cq5I0TV+UapgdyQMIP3z1GtWt8TBxdU9uKZmKAzE/s6O81l
 aHxHH506TM653zprLpNuGBoGCOoY9U2iUDe7lLcEW3zkxJYGBVAdlsmnYTzpl7WtCB
 3Df8xsj6VwLdA2X9utkbu3H/yoiLSLyLJEDCuoRTWkfFffzQ0P7Rbozc6BYQmmlg7g
 50eygd8TFtmmEd7tzmCORlIUbH4PQMufq3slEpJ6IUyDrc3p46wNfK8TQCIpzny21c
 yMJ47vW5L1QVg==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33aebf85ce9so481579f8f.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706533110; x=1707137910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eVegKe9LjEo5baDYSOXnI9Ie4V9ippd39v10zjfQWew=;
 b=mO5i+4Hc8LTnmgOk6KVpXdynwJTNF++wcG51piCBs9RKwZEvX20PSYG76/8a+cSKHP
 UGsy4oU1d8HwNgTYHdXxTaA9mcw/hnetddedqLdfCOEh29KZbE0mKau9DoCjEyKZOxDK
 qoTCN/KhZbdAEYHDJt6JvPC6FVx8YQQC2uRc+DwdWU1f2yXveMxOXmZx9tKO3ls+JqCJ
 yVj6e6tK+HwFzVUGQG+SZ6oGDHFI5qNoFd7oC0WZLXxeuR7ny1U00qsva7PJi3EsFW8y
 X26ICF/AQ5RIlaHL0/UGB3CQcrTAWn1AF3DFYfj7alizs9v+UNLlA8WeDRJq+jTaoL/1
 O8dg==
X-Gm-Message-State: AOJu0YyyGEaHPsPbJhMr5NbYXmmOd2vNceWi6sP8LBQqlnzsY0XCt/Rt
 NgNgEuPZwduvfFBcY+itarU7PUltvG5X15NkzrGKOwb5Oe2WdNGK1nj68vs9xfyT4Mr3nlj6iGI
 zLUpq2QnD9hMczVpw9NFjlFVnEtnZeCY0bEPWy+DKQAQXh5Jm27kqtgwzX6IZfpZwSlI=
X-Received: by 2002:adf:ce0a:0:b0:337:b669:846e with SMTP id
 p10-20020adfce0a000000b00337b669846emr4416230wrn.39.1706533110637; 
 Mon, 29 Jan 2024 04:58:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbpfn9R9u4j3ilGWEfHfZADyswxSmmz8qfh5elbYlA9QNK300rfT7Qoju6oYtniaoVFa7GPA==
X-Received: by 2002:adf:ce0a:0:b0:337:b669:846e with SMTP id
 p10-20020adfce0a000000b00337b669846emr4416211wrn.39.1706533110274; 
 Mon, 29 Jan 2024 04:58:30 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a056000100f00b0033aee3bfac5sm2289482wrx.16.2024.01.29.04.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 04:58:29 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] smbios: get_str_from_dt() - add sysinfo_id description
Date: Mon, 29 Jan 2024 13:58:18 +0100
Message-ID: <20240129125818.47453-1-heinrich.schuchardt@canonical.com>
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

Add description for parameter sysinfo_id of function get_str_from_dt().

Fixes: 07c9e683a484 ("smbios: Allow a few values to come from sysinfo")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/smbios.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/smbios.c b/lib/smbios.c
index 7bd9805fec0..11b7611a84e 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -207,6 +207,7 @@ void get_str_from_dt(const struct map_sysinfo *nprop, char *str, size_t size)
  *
  * @ctx:	context for writing the tables
  * @prop:	property to write
+ * @sysinfo_id: unique identifier for the string value to be read
  * @dval:	Default value to use if the string is not found or is empty
  * Return:	0 if not found, else SMBIOS string number (1 or more)
  */
-- 
2.43.0

