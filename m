Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B297C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 825078744B;
	Sat, 18 Nov 2023 22:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kDnPfiTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1153A874CC; Sat, 18 Nov 2023 22:06:13 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64061870E2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7b06afbd3cdso133360139f.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341560; x=1700946360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNVaek+O7GjkmT8Y0EBZ3p1EOozK169Cakl7Vz5Z2Tk=;
 b=kDnPfiTSfkVP4ZPUOGdLTDq6jycDft1e+5hCP2EcAUcUi91WhEU/n2bLVhhyuBQ8wQ
 VVu7XH20erDh7AHtcpf9SB/Isl/0gRxHEQ0Vb/FIYJjvwE2uPi9x69vlTXrU7c0DdHPk
 VYQxCkMJIouvHd/OHF1bO1yH71B1Tr88bTf+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341560; x=1700946360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nNVaek+O7GjkmT8Y0EBZ3p1EOozK169Cakl7Vz5Z2Tk=;
 b=E6/jZ4+j+LMkWwiG/9l7Rw0sQsQSW2MrlmJp1GZcR37BCSNaz0Xrdn26ByOnixM3QU
 x7zj4HcL2sI7ZeFnBxmpO+liknnA9lZRXdrdeWbim49DADT4yRWcz2IV3tZ4QQl3KgS4
 x5FCAm5ozw2banmK2RZ7XlMqE62JEbLlA8YVvhLPJ5jiwbsSP/lXXHDazeVn91+3ps/p
 6d7S33n/DE1fCzU33bkL3on37BC77+fGI/8G/7pVhCxZVpk7nzyVhLyJuPu1qB+NUTAy
 pgvqG8EiLBUQvSBsCti000LPWH5upV+KnGO4agpW5y+3CGDFkP8phjJGBkXOISTLbahK
 mamg==
X-Gm-Message-State: AOJu0YxWJZ7oVRqz/SqOrPiEbvqXmX4FP6iMoswuQtD7Ik2Yg6Y/tYbY
 SK/M6AaTvI/OitL62m1q185Fh1ptt8yAYH4rpXnPoQ==
X-Google-Smtp-Source: AGHT+IGNk0W29Gq0Nubf6FZNzI8Uc7Vg8PKj6EYv2WbKwLTEgshrtsi7m8tXlVFwUx1291HrlS19Dw==
X-Received: by 2002:a5e:8d03:0:b0:7a9:9235:7817 with SMTP id
 m3-20020a5e8d03000000b007a992357817mr3542832ioj.11.1700341560040; 
 Sat, 18 Nov 2023 13:06:00 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:05:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 05/32] bootstd: Add missing header file from bootdev.h
Date: Sat, 18 Nov 2023 14:04:53 -0700
Message-ID: <20231118210547.577026-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

Add a dm/uclass-id.h to the bootdev header file, since it uses
enum uclass_id

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 include/bootdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/bootdev.h b/include/bootdev.h
index b079a91b5b7f..c1362673d418 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -7,6 +7,7 @@
 #ifndef __bootdev_h
 #define __bootdev_h
 
+#include <dm/uclass-id.h>
 #include <linux/list.h>
 
 struct bootflow;
-- 
2.43.0.rc0.421.g78406f8d94-goog

