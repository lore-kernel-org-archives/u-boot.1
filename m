Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990D1E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14AD089719;
	Mon,  9 Dec 2024 17:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C3asWsdp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8965D89771; Mon,  9 Dec 2024 17:29:07 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B65B89712
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7265c18d79bso787919b3a.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733761742; x=1734366542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhGXfh8sCV+shY5htSJzBcNLoZUXjrvLLPwCAqFAKrM=;
 b=C3asWsdp2AiXI1J4X1om2w27lSF7WDup2Z89DUXRj0lwStCLkNrpRzwz9q2mdOs4up
 l1F6MObKixjXYgZulduXCJixbod4hToRV7Wsb5srKbaKjS09I1c/x3Zsd6Yl852rhs/5
 6/oHSaiKhqQWBk0wMnyABq0xkuu5GvoI8v4FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761742; x=1734366542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhGXfh8sCV+shY5htSJzBcNLoZUXjrvLLPwCAqFAKrM=;
 b=flH7lWbJLI4gTA7oYey+H53ptR2eQmuCHfYVrMszzJMfmyvH4dUHxoa6KksArxsFsC
 mljRM9ImaKp5rW+P1u6mEFZDAVUe3ctu39MuyjQNgZ0y174YLWcP/E9kJ8oRTrahegyv
 0Fw5uH6MsrhwEjL/kXLSQf68PKjhNIEv1RTmdvAt4f3QYmyysprbtDepEdO4ScTCzL8N
 YHII1VFHO0kZ9XjUJcPaiNfp1eUTHYJxz+O7uewg5I0v9easIb3iyvAN1fzG3i6jUSEo
 +9Zff8aAJurw2Qjh3VmIPB0+v5BUurVCU8C/s+EVLfFobSNJ0w2gpxvWwLIe+bl7fS3h
 deYw==
X-Gm-Message-State: AOJu0Yzr5kjbOK6oSi2nDXzE6gk6DLaLVD6e32acIiRcCdfpFYRM9C3K
 kAIemeTKVb4/14DbNP2sD6Pq+VeGLo2+/fUKhADPwy6sJDsBmP8N0OcC9mX7nbB13+jeM4YT/Eg
 =
X-Gm-Gg: ASbGncsUKIiAEJZEDjZerOuWIHOlaYrsbuMeR1Ox41n61/dqt7QuUQyPrsnBoyEVCbG
 MjRyIeNkNXWL+P208MGjrOWlHwX0/KITFSDB6J5T8uVn3ldsVk7gqs/I06KBl+2OdojiVNvqms+
 uUJhLOTzWZERap+v5AxOlZ72Gi65r58j9nm41uYBZtmgCk/VPEtaCx71EOW2AdXkPOmd1vAxHOZ
 oj0ZEA7MSgPF/x7/oABHTc05QpXzDOTEl5Z3EQ0tuW1sBdFMweSJzseeBjnbtehV3DX8o9U2ZEX
 J68cgevnXXLBVZI=
X-Google-Smtp-Source: AGHT+IGSw4hFEBkQX9fXCpdmObEGiujJafcvoAv78Tsa5XQZiOt4Q3o5qIvk9s9tpI3+hOMtgav6yA==
X-Received: by 2002:a05:6602:3f8d:b0:835:4cb5:4fa7 with SMTP id
 ca18e2360f4ac-8447e352f4emr1901512539f.12.1733761731726; 
 Mon, 09 Dec 2024 08:28:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844737bc549sm272432339f.2.2024.12.09.08.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:28:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/8] part_find: Enable for sandbox and correct radix and calls
Date: Mon,  9 Dec 2024 09:27:55 -0700
Message-Id: <20241209162801.288363-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209162801.288363-1-sjg@chromium.org>
References: <20241209162801.288363-1-sjg@chromium.org>
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

Enable this command for sandbox and the EFI app.

Recent work removed the if_type member. Update the code to use the new
method for obtaining the interface type.

Use hex so that large partition numbers (>=10) work correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig     | 1 +
 cmd/part_find.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8fc76778d87..c8ca55194c0 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1552,6 +1552,7 @@ config CMD_PART
 config CMD_PART_FIND
 	bool "part_find"
 	depends on PARTITIONS
+	default y if SANDBOX || EFI_APP
 	select HAVE_BLOCK_DEVICE
 	select PARTITION_UUIDS
 	select PARTITION_TYPE_GUID
diff --git a/cmd/part_find.c b/cmd/part_find.c
index 8c071d3c374..38919935641 100644
--- a/cmd/part_find.c
+++ b/cmd/part_find.c
@@ -107,7 +107,7 @@ static int part_find(int argc, char *const argv[])
 								   &loader_part_no)) {
 						char env[256];
 
-						ret = snprintf(env, sizeof(env), "%s %d:%d", blk_get_if_type_name(desc->if_type), desc->devnum, loader_part_no);
+						ret = snprintf(env, sizeof(env), "%s %x:%x", blk_get_if_type_name(desc->if_type), desc->devnum, loader_part_no);
 						if (ret < 0 || ret == sizeof(env))
 							return CMD_RET_FAILURE;
 						if (env_set("target_part", env))
@@ -123,7 +123,7 @@ static int part_find(int argc, char *const argv[])
 						break;
 					if (strcasecmp(argv[1], info.type_guid) == 0) {
 						char env[256];
-						ret = snprintf(env, sizeof(env), "%s %d:%d", blk_get_if_type_name(desc->if_type), desc->devnum, i);
+						ret = snprintf(env, sizeof(env), "%s %x:%x", blk_get_uclass_name(desc->uclass_id), desc->devnum, i);
 						if (ret < 0 || ret == sizeof(env))
 							return CMD_RET_FAILURE;
 						env_set("target_part", env);
-- 
2.34.1

