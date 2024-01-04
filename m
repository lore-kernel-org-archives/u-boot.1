Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DA3C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E86879FA;
	Thu,  4 Jan 2024 16:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KkgoSyUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D6487996; Thu,  4 Jan 2024 16:12:21 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0113879E1
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35fff16827fso2454195ab.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381128; x=1704985928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3EmRuX4GGUumpaDDZfaBjd5VIp1c9BDXmBE/S030AUw=;
 b=KkgoSyUkWwj7L/OX3qgz31YsJlRXYsD4WV9N4m/zvfZsliQEPnmnlXBi8leCnhhQHR
 5hrOXobSZTH3OO6bgIBURG2hmmb86+FmIUvYVU2ec44httF9atrpsiyPDMVMo98bLsBP
 43BQio5rNHvI4Kp7oY8KXiL2faAdk5x4B+x8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381128; x=1704985928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EmRuX4GGUumpaDDZfaBjd5VIp1c9BDXmBE/S030AUw=;
 b=LMk1QaolUhr8c1zJfpTEux7RLgq5IMkJc/biyT+bKcT/gec3W1NlN9YJ0Mt5Z+mL6l
 MTQACcKmQlNcPognuO6ZO2Mqa9Lq0N9Os1i1n2tSSx+KVGmOqcAlDiAk2mGhMXAHz0xQ
 ghuO5mlg3YZ/aw38gz0z6GhEw/AIFVyZYJ5KBjIVtFitgT/iGq3f2xNK2/1dRU6XveMW
 T0ru9t8fFoGnRYthzuLKWdgbY94oL3NlbbExXy/saE1B6JBoToYi+XgiObvFtUunoECd
 Yy1vfimbyE5NPvMq6LaDscHAARZEJjRzQbe2etLoVVDkcooc+v5ADF+8oSmP5AFwlSmN
 NJ5w==
X-Gm-Message-State: AOJu0YwL+oaqcpeqpBcyDO1dgEArA9u35AP7zJYWVPWgMrNG2eEHYMyi
 BlwAGbOPPgSFaCo9cUWQz1sJ4LNOKXrIfGQ+rCN76xHneTMg
X-Google-Smtp-Source: AGHT+IE6MsnhC9z/0Jp2nkIPMoVgZMS0VIKKpoibvYqBarIyI0ljuFwjjWQJUeLsWKHNi3RWRSkAbg==
X-Received: by 2002:a05:6e02:1568:b0:360:dd5:4060 with SMTP id
 k8-20020a056e02156800b003600dd54060mr642767ilu.2.1704381128581; 
 Thu, 04 Jan 2024 07:12:08 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 11/19] expo: Add forward declaration for udevice to cedit
Date: Thu,  4 Jan 2024 08:11:44 -0700
Message-Id: <20240104151152.697855-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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

Some files may include this header file without first including dm.h
so add a forward declaration.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/cedit.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/cedit.h b/include/cedit.h
index f43cafa5aa2..f9a4a6d9e8e 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -12,6 +12,7 @@
 struct abuf;
 struct expo;
 struct scene;
+struct udevice;
 struct video_priv;
 
 enum {
-- 
2.34.1

