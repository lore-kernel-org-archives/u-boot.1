Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E82EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84AFB86A82;
	Thu,  7 Sep 2023 18:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CRksnvSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A019986B08; Thu,  7 Sep 2023 18:00:01 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D05786B0B
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34ca860051fso4637515ab.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102395; x=1694707195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C3YemXvGS817wEPX+mQxN/fjZksjMUai/RXLQmSPTQM=;
 b=CRksnvSyiYx9t2P3IvYGH4xGvIHrnDdE0hGprfh069YCo69eRJM09JWmSNwPSRlgRy
 6ShG8B54gkcgY2n1rCp5YR1YtcpmvyOMm99XhQ1777bpOTw5f8t4kmrUhku7vbmUASM3
 iO1mD5iDLuZ1RLHViTrx3aCngRF7CZTLIu8pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102395; x=1694707195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C3YemXvGS817wEPX+mQxN/fjZksjMUai/RXLQmSPTQM=;
 b=iRkMQtJl28U4LC5vJ8XZIlem7vDppz/KtY7QjgPNO6vI3XXgNLXqonxbWPvnjH3nWQ
 XZmis+YRKPR54CxdRxMwqpfU7uPXafX6Sa3h4Jqkd9+g/i4mdAniZeB6oUnCUmDwBnea
 RKskl7sXswFHnXK6tpFDkk/I0NxXCNVF9aSzoCSHe6nuKPaDozazX5wpp+5Vty1+huhd
 FBFeQFVUIg0cZ+DGxdFNBAU+YAWCPjieaE4d0YdPE5GvmoAfPUYNDDsIXOB9LKWPvfAS
 tWsI8E8y6Y1FwsB0s3ycu6C4ukcfeEJcUuE7pzG3D0az/KbKch/OgpagVw28VGsR5c7W
 pV2A==
X-Gm-Message-State: AOJu0YxeeN0BmPtlQVjmur1aTOaajRWcIYltvg6SJocn3F3TfzIY//By
 2lXPd1GsIJKAqXJd0IXlJ4zr//qcxycvekMbSUg=
X-Google-Smtp-Source: AGHT+IFevTymFBzcEUk030QjOyek4gq3NHB3stxsE88IzDOVjLYV0QwKREioiTk1jf98F8imzBsxYg==
X-Received: by 2002:a92:cd52:0:b0:34d:f0b9:97f7 with SMTP id
 v18-20020a92cd52000000b0034df0b997f7mr87968ilq.25.1694102395111; 
 Thu, 07 Sep 2023 08:59:55 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 19/22] Make ARCH_FIXUP_FDT_MEMORY depend on OF_LIBFDT
Date: Thu,  7 Sep 2023 09:59:24 -0600
Message-ID: <20230907155933.48511-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

We need CONFIG_OF_LIBFDT to be able to do fdt fixups, so add that
condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to make ARCH_FIXUP_FDT_MEMORY depend on OF_LIBFDT

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 7ef44a26fb92..2dd05e2e1661 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -695,7 +695,7 @@ config SUPPORT_RAW_INITRD
 
 config ARCH_FIXUP_FDT_MEMORY
 	bool "Enable arch_fixup_memory_banks() call"
-	default y
+	default y if OF_LIBFDT
 	help
 	  Enable FDT memory map syncup before OS boot. This feature can be
 	  used for booting OS with different memory setup where the part of
-- 
2.42.0.283.g2d96d420d3-goog

