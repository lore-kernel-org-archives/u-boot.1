Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B892DCE7B05
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C6CC88CD8;
	Fri,  6 Sep 2024 14:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FeOHI5cE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30ADE888C1; Fri,  6 Sep 2024 14:34:59 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E4D088C9F
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42ca573fd5aso3422715e9.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626094; x=1726230894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nw/+cdQPG/ROM9iilfJJB8oj5oic8yJ+2SSNidMrUsc=;
 b=FeOHI5cEUYsYinJpO+Rm3XgJtW2ikNGZM+6Kzs3tUypmHmnMfAPq2iDVFQs/r9UWDf
 kthvol+170eVnqF5Uq5AQBAumcYIFKOuLb9Qtg4UXt0Nd5NtWqIL9v2D6nDs8HvE9JH7
 Nr4awF0Po8xUNwx+AUXRq0POqJd/EtTLkq0uw+iYsXEYqVQIM6LgP6qWMXvnsSpNQM0K
 S0YlZM0SKEO9T9IhLIaObzc0T4hMKNWytAdNMgAYAzcqN1J+6iMQ6hJQ7gtDzI5VLOEH
 NBg8MCGVYinNTev3RcGYZR5rkeQn9+WJuW5/rgtolSF1xTXEjx0H+ndhrgl5KxLQygx6
 7XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626094; x=1726230894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nw/+cdQPG/ROM9iilfJJB8oj5oic8yJ+2SSNidMrUsc=;
 b=LYhHcqX6S0tI3YBgz53wfyjAvxUXFvobk9Np9lKjICV8icYuG8tp6AQfZFI2dlpcza
 iD3Zp6HTZBCmX4kj9ldgca1jFOQXSDZ3YBdB1cK/jr4WUUYUmcxHTENvOp+bgemoJhxK
 ki2+hBiA5H6ahfGG71yJ0ejp4Idlm1EOl9mB+uO+sZEXBYUHMy0EPcC418AQJRlL1Dul
 k0W6fMt65PPxk/uUwvfoRqGLe5EXqEB3H7nwmdCZGzHbNQaByKMAG9xi+Sd64/0AfuuU
 2hQjLrXTHHvqQm6EFqGtJyYGnyxUksfdCp893yDTYL8Dy0GFibZ+iKlGAU3pGU2ItoYQ
 LCag==
X-Gm-Message-State: AOJu0YzgUVd3mPgDRN0lX1Ed+kcxF/ZsJbkAxa7qhSVAQqNYUIJF9uuY
 3eFxJmFAlZd3klzKIiZsPx7CyPbtYA7MAvc4E34bOJKGtWw/Mu/sAI9lUivvMPJaZHS378T9D89
 qqdfhiJW3
X-Google-Smtp-Source: AGHT+IGGdbmFkX8ae7f4n8wAouAsO/dItmla1jgSDlhobEu6fqwTE1Lv4NEa/Y4CRo0z1IOR9Fa4Cw==
X-Received: by 2002:a05:600c:1c21:b0:426:647b:1bfa with SMTP id
 5b1f17b1804b1-42c9f983745mr16838265e9.8.1725626094298; 
 Fri, 06 Sep 2024 05:34:54 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:34:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v10 05/25] net: move copy_filename() to new file
 net/net-common.c
Date: Fri,  6 Sep 2024 14:33:21 +0200
Message-Id: <eddf1a52100ad9c0d34a3d5c8080dc61e66e976c.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

copy_filename() can be useful when NET_LWIP is enabled, therefore
move it out of net/net.c which is built only when networking choice
is NET.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/Makefile     |  2 ++
 net/net-common.c | 13 +++++++++++++
 net/net.c        | 12 ------------
 3 files changed, 15 insertions(+), 12 deletions(-)
 create mode 100644 net/net-common.c

diff --git a/net/Makefile b/net/Makefile
index 70eec8caf0d..a9cecee637a 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -42,3 +42,5 @@ obj-$(CONFIG_CMD_WGET) += wget.o
 CFLAGS_eth_common.o += -Wno-format-extra-args
 
 endif
+
+obj-y += net-common.o
diff --git a/net/net-common.c b/net/net-common.c
new file mode 100644
index 00000000000..a7f767d5e9c
--- /dev/null
+++ b/net/net-common.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+void copy_filename(char *dst, const char *src, int size)
+{
+	if (src && *src && (*src == '"')) {
+		++src;
+		--size;
+	}
+
+	while ((--size > 0) && src && *src && (*src != '"'))
+		*dst++ = *src++;
+	*dst = '\0';
+}
diff --git a/net/net.c b/net/net.c
index 1e0b7c85624..c1d10a77b9e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1689,18 +1689,6 @@ void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport, int sport,
 	ip->udp_xsum = 0;
 }
 
-void copy_filename(char *dst, const char *src, int size)
-{
-	if (src && *src && (*src == '"')) {
-		++src;
-		--size;
-	}
-
-	while ((--size > 0) && src && *src && (*src != '"'))
-		*dst++ = *src++;
-	*dst = '\0';
-}
-
 int is_serverip_in_cmd(void)
 {
 	return !!strchr(net_boot_file_name, ':');
-- 
2.40.1

