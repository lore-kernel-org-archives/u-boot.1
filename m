Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2331C4706F
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 18:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD8187A81;
	Thu, 28 Dec 2023 19:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dhYF5Q5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6AF879D8; Thu, 28 Dec 2023 19:02:22 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6315487A75
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 19:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e67f70f34so5094016e87.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703786538; x=1704391338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRS6sOV0jKQVRZhOLv/3vtOvmLtv4dNgOuCr7yiIelg=;
 b=dhYF5Q5z1WIJuAtOhu2gZVW+sF0fInnW5s0+00dwy0rufGf7lTX5D8EBQbedml2BjM
 RsBsxPXStLh2PoEEvE0oR4qw1wK0H563DScDuh2jr6lnbw9KsQaetA/SDKePgqlyuHKT
 LdL+mGAneCTrYZ3OD5Am3APMtMqMcl32BObpQDETeks6VzdJpvWgPt1z6IZH34aJAFSr
 9ezY9clrP9Xywqtcz9rK/VabuRJHl0DskQHCSOke02cPIOArLVQjWvxJbTGM9Z3Fyzmp
 tDdMSJppkXhTXUCFB+h1wmctip+KwinCVJLefnnkPIjZ55lSpQYyu0HYdu+gdmhcUcVo
 tKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703786538; x=1704391338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRS6sOV0jKQVRZhOLv/3vtOvmLtv4dNgOuCr7yiIelg=;
 b=EBegZNfffcncpdqoFDtqpCFUYhS5934KzAvNRqgACWcUvuB8ROm8KCBD+siAs061p7
 2KSxsrJ/Datlkad6POMbAQ+VT58PwF3EvE3coR2RCSnxahGBY4Us/s1nP1Y9SPDDTDXC
 fVcu0oVQyxUNjbXUkKa+zRm5+R+4o47ISzjtsl4rJIlRhE115ycxi1VQ8g2Vj46eMRx4
 l15+sA8FJ32Dvs8sEncsSX7vLkbf4wI+9GNox2dkjP0PAfax4ol9rRPmYxUxyoxpOh1S
 pll76aX9gxvwY8c4NbgDCxJvgcZNLMzEUVmJ+qanlysu+2yruZrnkvxmO/qrjwNXpsvk
 vTpw==
X-Gm-Message-State: AOJu0Yzgq6HOoj0PPzBr2NmfYAf3R/KXD9hVojdZSHXPaJ1H50aVAqfr
 sIMQxMjiC78cXJmnbHAmcYs=
X-Google-Smtp-Source: AGHT+IEPqdl9ur1jxCji+joleXaz1V878fzCR6ThaRKKcdXra6Ltiy/Bx60ogp0W32xz8UwkA9nabg==
X-Received: by 2002:a05:6512:3131:b0:50e:8ed1:cf10 with SMTP id
 p17-20020a056512313100b0050e8ed1cf10mr283544lfd.42.1703786538408; 
 Thu, 28 Dec 2023 10:02:18 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 s4-20020a056512314400b0050e6b04a5b2sm1955101lfi.251.2023.12.28.10.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 10:02:17 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 3/6] common: console: introduce console_record_isempty
 helper
Date: Thu, 28 Dec 2023 20:01:51 +0200
Message-Id: <20231228180154.50473-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228180154.50473-1-clamor95@gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

Add console_record_isempty to check if console record buffer
contains any data.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 common/console.c  |  5 +++++
 include/console.h | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/common/console.c b/common/console.c
index 1ffda49c87..6f2089caa0 100644
--- a/common/console.c
+++ b/common/console.c
@@ -853,6 +853,11 @@ int console_record_avail(void)
 	return membuff_avail((struct membuff *)&gd->console_out);
 }
 
+bool console_record_isempty(void)
+{
+	return membuff_isempty((struct membuff *)&gd->console_out);
+}
+
 int console_in_puts(const char *str)
 {
 	return membuff_put((struct membuff *)&gd->console_in, str, strlen(str));
diff --git a/include/console.h b/include/console.h
index e29817e57b..2617e16007 100644
--- a/include/console.h
+++ b/include/console.h
@@ -84,6 +84,13 @@ int console_record_readline(char *str, int maxlen);
  */
 int console_record_avail(void);
 
+/**
+ * console_record_isempty() - Returns if console output is empty
+ *
+ * Return: true if empty
+ */
+bool console_record_isempty(void);
+
 /**
  * console_in_puts() - Write a string to the console input buffer
  *
@@ -131,6 +138,12 @@ static inline int console_in_puts(const char *str)
 	return 0;
 }
 
+static inline bool console_record_isempty(void)
+{
+	/* Always empty */
+	return true;
+}
+
 #endif /* !CONFIG_CONSOLE_RECORD */
 
 /**
-- 
2.40.1

