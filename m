Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015CCC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288AE80C6F;
	Sun,  9 Feb 2025 17:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHOTuxJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D74FF80885; Sun,  9 Feb 2025 16:46:28 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D78EA80821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5450475df04so1268730e87.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739115986; x=1739720786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TlWJFprAomO8hvyA3PlnjG+fPyULQVe2r3teLuRyFy8=;
 b=mHOTuxJqPDMpXim7/vLE7ODpBJzEO1CwTnSG3Uqj+m5dBFhU5z3u+IkL4RsP/FpDD9
 MD5H8KTZ0eTLt9snd+akttdxDKe3HBZAo0cy0Z6Sf/tp0ApNDky9wvus7XFvfCLy6h0T
 Ny2ImkzvxeBcRL9P6EOu2VSmAT3L6EE3qKOPWhUNxTcI9u9FFn4k4hlcK5QCEN5Q4Q6s
 NGP9YVvOCyRlxSJjh9+0oHjVJfWQln/0ibcLFkPh47jA60oBnrqqlt8Pw+A8JD0P22bd
 3oB9tfWzh0d8wA8rgELrdl6a5gY7vN0mGrc4yUhOTrC/c59AfdMfit+t0sxf4hImKMO4
 5xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739115986; x=1739720786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TlWJFprAomO8hvyA3PlnjG+fPyULQVe2r3teLuRyFy8=;
 b=vQOJtzfhK8cIFmZfJvUt9aybaHYI8SyfCl0GsSqkeh7ukwRj5FYo2nJGoDjBnPN4Or
 fz69Cc5QFy09UN3vTnGvhcAwSPE9EEUl4S3KjPEWlQpzQ25Cipjxcvwb9YWGHtMoKlVY
 /xMqqDx5d+bApvwEQJOPlWFUxhZpG4Nk5Pdd4lNhu+WaJ3LFanL25ZmzLzL8db7EuR0z
 MZmB8joSDUB+sjxVqgPmX61Nl7TywBSpONfau/eyGfIAE/zpzAoiHBEFMAKMlF1Paeb6
 3fKINyND+FGbpu/e3k9w/jnRfC/FHqh7R7YBD2ZfsuyDeIJ9LI/ixpobPrqtJhAcDs60
 mU/w==
X-Gm-Message-State: AOJu0YwMq5VyulalaOk1Tw/op+xUNNUerNZlOOeG677f0I+xrCN6+k0H
 FC739gnI79kzb3ugiujhTiYzTlucfgsA1uv6Qrks5py0EJ4jrZyXSiDssrm7
X-Gm-Gg: ASbGncvxvjmE9Qa8BQRuONXjZWwgcfPRl01y+e7keEV8furTUN+Tfbtfy4Vopw5vRAk
 7WZ4Sl4sUQ2b6+pCqs6c4C3EoDSetjAzzM5Wn/cq5e82jU6M9V2Ec69D+lXjVDkCcGlkPZvAIIN
 IlGlUuBa13HPXFerdgCeqhaRBfpIgIAHTd1j3TPhSfPWwLwq9+/bjEyKwnMJS5Twv0dkSkplIgB
 Lxu6cMJ8L3RyknEWewHdpApxmzKGgLRODaLQ34mX23t/h2gvJy13zJdnwUT2Fgps2SeRgxUOLkg
 pUddM7f9at8JUdSvdM3skiI=
X-Google-Smtp-Source: AGHT+IGDTG9HhkA9u7KN6X4dko0LM0LwtAJhlVjc3mZqJEDSXlPfTVwmRUs3AtX7khuETk54g9UZVg==
X-Received: by 2002:a05:6512:2034:b0:544:1156:a9d with SMTP id
 2adb3069b0e04-54414a9d20cmr2582959e87.22.1739115985465; 
 Sun, 09 Feb 2025 07:46:25 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-544105590adsm1017140e87.53.2025.02.09.07.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 07:46:24 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: Fix potential null-deref with result of strtok_r
Date: Sun,  9 Feb 2025 18:46:21 +0300
Message-Id: <20250209154621.714878-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 09 Feb 2025 17:33:22 +0100
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

Return value of a function 'strtok_r' is dereferenced at kwbimage.c:1655 
without checking for NULL, but it is usually checked for this function.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/kwbimage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/kwbimage.c b/tools/kwbimage.c
index d1cbced28f..3dcf5ba66b 100644
--- a/tools/kwbimage.c
+++ b/tools/kwbimage.c
@@ -1653,6 +1653,12 @@ static int image_create_config_parse_oneline(char *line,
 	char *unknown_msg = "Ignoring unknown line '%s'\n";
 
 	keyword = strtok_r(line, delimiters, &saveptr);
+
+	if (!keyword) {
+		fprintf(stderr, "Parameter missing in line '%s'\n", line);
+		return -1;
+	}
+
 	keyword_id = recognize_keyword(keyword);
 
 	if (!keyword_id) {
-- 
2.34.1

