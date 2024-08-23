Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702D1C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB5B888F0;
	Fri, 23 Aug 2024 15:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xuGbDqVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F77F88A0E; Fri, 23 Aug 2024 15:49:48 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1D488A0E
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso16371885e9.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420986; x=1725025786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGz4U07JuHZb2y5jdBfc47mDP3MalPOz9Wfd8t01x2U=;
 b=xuGbDqVMjThGDaTaMnb2VGE2x9hUZAvuTe/4zK56YAwipObO2UcZCqb/MFYcxtHQOZ
 p4BI+OR2oiVlniAQeYdnh0fQw5dOi8vYEc2VDHQPM0GxF1B5g13q7SXjeQ/ztJXhZAMJ
 TX8T9FHkBAV8lk3TzlluSRJdCzYwzP2Q7elMl5MahUPMMxWYycXYFUdkfToU0/rOhWrL
 TGQ4gBgSQHlHCov4PVS5U3eOWPZ96Rwv7gZ4nHNpiMsel1k4xqtd6pp5YFRYNxR6CHs0
 Nr2HujsvOGpZSbgeyS3xeCqUPqDRdYNJVFMnWGrz9mObDB8jA66YekVFhN5Dff3r6Zl1
 IFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420986; x=1725025786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGz4U07JuHZb2y5jdBfc47mDP3MalPOz9Wfd8t01x2U=;
 b=UH8cZLCWxBCHUqKPxvAplweLqCuYoAk4LmJWZ0QioitqZX/WtSd5UC2sM+xsWNUKZZ
 mPQLHS5PiaHCzRQipt9lAePKzvmoznLCW7sw5RvbBeNpPMNppD2oGCZBNdrgu79X4L5u
 Bsy0BnI3kZ/yrsoSEmSYVtJ9vN3ZwcPL7Ng7Y4L7Q3pApNElpPj9jI7ZCaQgqfqrbd6C
 hlgX4nw9XcQWMgI9/MvwoITEFTvfzACTWJoCWppEOBDJkhdFqk4ihYKHjZSj4X8l6Bok
 q97sQDCoC9WjlnFNhwLkFRbVLXeM0JVqxVip1wgTI+sNe5Gjgt8iaWLd9R7Rl5XT79k5
 yrsA==
X-Gm-Message-State: AOJu0YxIXA83SnqVIhJDE//qJIe8yysaDamtI+4GPmpmp49zRzO5I9CG
 zquiKn24eLE0xcVp5C5gdkklPadIxMzezRf0r/TcbVFdez484gmBoR0bAv77dlhIoZVCNbxwZOa
 Y317Z4H8c
X-Google-Smtp-Source: AGHT+IF/3ZQNhA6SJyCOVGvkMQkaRh6xy/DhIHMW7CQCtqwDBliE6juoTwdeMWoP6OmGq7zcx62jDg==
X-Received: by 2002:adf:ec12:0:b0:368:2f01:3053 with SMTP id
 ffacd0b85a97d-373118eeea2mr1675629f8f.55.1724420985829; 
 Fri, 23 Aug 2024 06:49:45 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:45 -0700 (PDT)
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
Subject: [PATCH v9 17/37] net: move copy_filename() to new file
 net/net-common.c
Date: Fri, 23 Aug 2024 15:48:21 +0200
Message-Id: <fe9c08b3542792be0972664948d8e1c7af0d0f91.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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
index d9bc9df643f..32629aa80ce 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1684,18 +1684,6 @@ void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport, int sport,
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

