Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356F4CF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD7D088F3A;
	Thu,  3 Oct 2024 17:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zdf4OVRh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72E7D88F07; Thu,  3 Oct 2024 17:24:21 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B1688E94
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37cd8972738so858281f8f.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727969058; x=1728573858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nw/+cdQPG/ROM9iilfJJB8oj5oic8yJ+2SSNidMrUsc=;
 b=zdf4OVRhaoVoYKl4EB+cGuF9SN7P3rcd0Rk4BCS3o0J8OJ12gOspQZmwarFVMbgqjg
 uhu2cpycR7FxTMHoOAt0jMaObJLReeCredGux1fnbTi5tBwz0ta+EWdsRMkOiaY7iatq
 TanUQjP6EU91wNRfwX1b4c1g4N/QpGlkMdiuXJimFMaSJRNAjCP8LHwGNeKTesuIVZ17
 aKCZspuwvCyZOXDnY/Jye1EvRuk7KZeepTDWUMkWt81jqc5DhoMPCZEfoqQ48sW3ZxFi
 geWGWUBCXFuxiEhvv+JWRccKqfEv7MrvsUb9mqmoTAH/viDSzd+gnWRI+HEppOtjSJHw
 9Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727969058; x=1728573858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nw/+cdQPG/ROM9iilfJJB8oj5oic8yJ+2SSNidMrUsc=;
 b=BrJQP4XwuefwR5DrJwfGwFPQZcxH3sKTVw34qgBsW6Y7hEqEvIasMhMZdFTeG057qP
 dcJ4t3Y2DCK7mcUsrz2NJSH+/uwqnkmiZ/PGJLd7rmQlYN4eJIRoA7UPiNRKycR98yUB
 YjJNhxuS3nJiQNW0FAqfHIDTT1DqIfJwE0I8idC0xCr0noOXcFOkWeAjVkpHLTA1U7Qm
 /TVNookXYrst1vCBmho3iXHt7rjoATuiV2R8d56p82Wy3ulsSby2AcW3ZioDlMdIAYy9
 hO2E3uQNVGdRdgAohMPH64Cdbg7SQov5pN6rRd0x8FPE35FD2yNpY4BW88flL6AuEGvv
 1NgQ==
X-Gm-Message-State: AOJu0Yx7jq0Tv0FLvfjOBzRkprWhqSnXCCYfAXbXhR0MGDxfNQg5azEb
 PKIm3Re4Jz2+A0w57gMZSnlCBKQhzcpxqEx8JuwNlFtdSjtpJ1SCHiaqGYXHKkImkGBjZqzKm55
 ClJ1EzkiP
X-Google-Smtp-Source: AGHT+IHlHN0zwvcZOZctt41/uAmZlZCIxIzKR2mYjyfgBQQv0kamptOmlnHN/0Kasdt3cPL/QOqftg==
X-Received: by 2002:a05:6000:a84:b0:374:cd96:f73 with SMTP id
 ffacd0b85a97d-37cfb8b6405mr3844807f8f.3.1727969058241; 
 Thu, 03 Oct 2024 08:24:18 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7482sm1506220f8f.8.2024.10.03.08.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:24:16 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v11 10/29] net: move copy_filename() to new file
 net/net-common.c
Date: Thu,  3 Oct 2024 17:22:56 +0200
Message-Id: <bc7f7365861fb75269f30300d341dafea92d76b5.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

