Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4105BC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 07:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F8087970;
	Fri,  5 Jan 2024 08:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JaeaM2Uw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D1087947; Fri,  5 Jan 2024 08:22:39 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD9448793B
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 08:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5572316c663so440171a12.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 23:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704439357; x=1705044157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRS6sOV0jKQVRZhOLv/3vtOvmLtv4dNgOuCr7yiIelg=;
 b=JaeaM2Uw9qoxHX+IJAlg0fhFZbhocuMZBVm/lJQnNGvA+PuETd0qCarKs76KRDb+Nu
 xWmnUtLvrqR7vmlbRYRGL54k0N4ow00+mGDAK2+pbGrpb8O5BGpXkwOMUPbVo7AP2xdF
 n1DMmCQ57YE1+EAMAcKqAKSxDBYoZKoT73haqZmrRULsAtNnKqOmd0myqkwX5905gPKu
 9UZkDC38pk9uKe1MUfUV3rPHT/1AI6JUwknwbXEJGASJiIBVUR7u1CNGV6ipov4vMPV/
 T9UXNWscgccX6umBUP6djlXrGCcYI+0IVM+k2z5wgEqBRwb69T98OWSXoGo9QrHYZ4ho
 8pvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704439357; x=1705044157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRS6sOV0jKQVRZhOLv/3vtOvmLtv4dNgOuCr7yiIelg=;
 b=TMBxArZki3w3hf0piqwopD+S4rx90NrXVeZQoiQO1UjuKjmPp21aT0apQToWRE1F4+
 KcYYJNH8hWxjwUhAu7hotXOuOplwDAARaDLdIdVYtliwUtl+FszNgPX7lU/Oa7cdbE2T
 gMEHf91UCwlVfKCXs6MBTFCqdSdbPbI83GrLlU6lKUfVRJOaRxXrKV/NwyBWrmlXKqeP
 /rAcnQxBcyUIBQLREIUpUflXAg9FU1c4NW8a9PgdbFp/Luc2MiVDvaxLJTjHRj1/MDDR
 D/uQRlwPOKWoIaytmAlV5gmojKIg/I2e3r22jxhRpTs2wtEzKFrrmIXQwDaDemuK0Oe7
 FIZg==
X-Gm-Message-State: AOJu0YxAfmQqEMbMw7R21tdAf8j0iKmP37pDB3D5EjjxTT8v9KkTs18e
 TlrgcGk5I2NsBWSlhej0X1c=
X-Google-Smtp-Source: AGHT+IFiAkY/JDIgGo56z9vsdi8lHdgwXYCjEHef0vZFUk1IMntOa6uzexm/Ls1Jw3YCWGSezhZIAg==
X-Received: by 2002:a50:baaa:0:b0:556:e6a6:cd1d with SMTP id
 x39-20020a50baaa000000b00556e6a6cd1dmr896655ede.35.1704439357324; 
 Thu, 04 Jan 2024 23:22:37 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 dd5-20020a056402312500b0055627eeb8b9sm636471edb.32.2024.01.04.23.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 23:22:36 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 3/7] common: console: introduce console_record_isempty
 helper
Date: Fri,  5 Jan 2024 09:22:08 +0200
Message-Id: <20240105072212.6615-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240105072212.6615-1-clamor95@gmail.com>
References: <20240105072212.6615-1-clamor95@gmail.com>
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

