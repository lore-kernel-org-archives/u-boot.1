Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A9D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70085895E4;
	Tue, 19 Nov 2024 14:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oM0SOiLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7590F895CA; Tue, 19 Nov 2024 14:19:37 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61BEF8954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a6be369d23so16448695ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022373; x=1732627173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLd///5s9m2Yr3jtwx8+2ZylhoBMyU0PGPHAv7HdFyE=;
 b=oM0SOiLfMUIouahMGH1P8iVMML+vATaxJzYCseWgjT2gejb0DpxV97Su8bIJ4xuDly
 T26k6I6l8phM3JEU/lcRUfe8Qs/BSePdigVJf5tmGTK5ygmJv9QQN3ayxjwqb3QhtFlE
 7KbmJ1VlZat0onIAfld1TJPWnFLqX/pjCKsac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022373; x=1732627173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLd///5s9m2Yr3jtwx8+2ZylhoBMyU0PGPHAv7HdFyE=;
 b=SXO2P+YQUSn31OjYBLUdSLmrS0+1BzOCqN98sVfrfdcq1E1F4FFcuuIQ3QLaCPRotK
 noUcKsA68/UystB9PKhy8Q+OLJbox/0jtOFyy/l5cygfK7QO+8a4yktyWp3CSGgxYBgs
 3FTDrgnOtEvtdAczDy7ho3x6aNYpEh8esqeO+mEQjz3uVmsm1jAVUcS1LNunIc9oDa/U
 5iT9xZXnOQWbD/wnDR9v9EAcdEWBDvMT6hCzCwmckSJNJYC/TIW+jUVmkS2pEWVRjYrn
 ruTwZI2ClX/UFlG4qvtJrq2lVVMjujbtEbekw2yKaogKGyZS9agwagExeESYM3X7H1Jy
 c1ww==
X-Gm-Message-State: AOJu0YztYbocajlpG9f+4dM0irDM7MH/4N3JtbYYYJ8Dx95mNc7On1ry
 Ux+s/otaJt7YMKAH/VmMlxPQl2CvaO8kV2q7SaW2tZBSBbJPUSkFA6e0YC0BrKMTObluGbfk4ak
 =
X-Google-Smtp-Source: AGHT+IGblG9H1SVodkEVHaRf4zPEFqZI1GTwEjliWMT1zZtpxdhXwEgRqybOygwkQr14c1LGwDRAQg==
X-Received: by 2002:a05:6e02:12e6:b0:3a7:7ee3:108d with SMTP id
 e9e14a558f8ab-3a77ee31438mr15145175ab.23.1732022373623; 
 Tue, 19 Nov 2024 05:19:33 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 16/39] net: Tidy up the comments to parse_args()
Date: Tue, 19 Nov 2024 06:18:21 -0700
Message-Id: <20241119131844.4078144-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

This function is a bit vague as to what it does. Expand the comment a
little, to specify which args are provided and which variables are
updated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/net.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index d3e566752d1..01332d57b98 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -311,9 +311,18 @@ static int parse_addr_size(char * const argv[])
 /**
  * parse_args() - parse command line arguments
  *
+ * Sets:
+ *
+ * - net_boot_file_name_explicit to true if a filename was specified
+ * - net_boot_file_name to that filename, if specified, else the value of the
+ *	'bootfile' environment variable
+ * - image_load_addr if a load address was provided
+ * - image_save_addr and image_save_size, if proto == TFTPPUT
+ *
  * @proto:	command prototype
- * @argc:	number of arguments
- * @argv:	command line arguments
+ * @argc:	number of arguments, include the command, which has already been
+ *		parsed
+ * @argv:	command line arguments, with argv[0] being the command
  * Return:	0 on success
  */
 static int parse_args(enum proto_t proto, int argc, char *const argv[])
-- 
2.34.1

