Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA4BC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C317888591;
	Sun, 23 Jun 2024 22:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KePWrxQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FBB87D07; Sun, 23 Jun 2024 22:30:51 +0200 (CEST)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F26088569
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-7eb75c0d0a7so127998539f.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174647; x=1719779447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+ashUbIN25qKsnBwZRuLHdB7K6Nj39S33p92ZbbXXA=;
 b=KePWrxQkHN0n0G7OEaaHX4L1Xjq01phWmZUcCtARlmTCkvXiSL1dK4nmjnq69Y4hqU
 f23o0ynkAVcx9EC139MkZCJIHclbpV+Rw/8vZKZiGg0r4TYwcLSOWx69YX1yyeIwu1DO
 HtOQgFTr/gBLOTgs5JdMFV3vqKkOBh+7LhZA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174647; x=1719779447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+ashUbIN25qKsnBwZRuLHdB7K6Nj39S33p92ZbbXXA=;
 b=dzFGpzLS5g76yEf/sP3+S4W2XL0YGXOV3c42YuPlV3wFxjl6+ttMAOBsOjk9qedjV3
 XYRjTRvVn925afyUsxbVSYyrbWYfktDHe5obSdTi1+9BT3euitIuhiARSjN1Jn5lEh2n
 TGfWRNwYdCGZxkZ5B0fMKC/ODB56GGU7RrkobqXvaNJtilNMia3gdXzmt+9cqMBe11bh
 xQ4MFZqhctOG3yE8aWKXo1Yu+SyE4TNxICgvaAvnb/W3lP6uifMgJvJc0Uy9Or0DXrEQ
 NmSpRANZjcouWpg/fxLPuaNoEAPTJWIIRRaP2n//LCAopMOiTGVzM+XrrPbJcs2oQUh8
 lGeg==
X-Gm-Message-State: AOJu0YyENFSj5B+ijIzTQv+dZFG69Uk0O8yn+H1DoixADertQ6Cr7S35
 tAKhS64/TQh/hKMR3Grt6DoR6GJVtvJQTeHJX6lT0OJJ4zT+LALjvcNFFhLL1iAVxXrdRbcBT3X
 s2VLj
X-Google-Smtp-Source: AGHT+IFxLuM2hvruVivlmICnMePxFQWXEQouYMwYrfPUwBB18VjJrizaWprQ7OpeLm499TP0zzSS2Q==
X-Received: by 2002:a05:6602:2ccc:b0:7eb:7351:8beb with SMTP id
 ca18e2360f4ac-7f3a4d5d227mr339301339f.0.1719174647272; 
 Sun, 23 Jun 2024 13:30:47 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 14/14] smbios: Correct error handling when writing tables
Date: Sun, 23 Jun 2024 14:30:33 -0600
Message-Id: <20240623203033.1566505-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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

Since write_smbios_table() returns an address, we cannot use it to
return and error number. Also, failing on sysinfo_detect() breaks
existing boards, e.g. chromebook_link

Correct this by logging and swallowing the error.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: a5a57562856 ("lib: smbios: Detect system properties via...")
---

(no changes since v1)

 lib/smbios.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index fb6eaf1d5ca..4126466e34a 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -5,6 +5,8 @@
  * Adapted from coreboot src/arch/x86/smbios.c
  */
 
+#define LOG_CATEGORY	LOGC_BOARD
+
 #include <dm.h>
 #include <env.h>
 #include <linux/stringify.h>
@@ -596,8 +598,12 @@ ulong write_smbios_table(ulong addr)
 
 			parent_node = dev_read_subnode(ctx.dev, "smbios");
 			ret = sysinfo_detect(ctx.dev);
-			if (ret)
-				return ret;
+
+			/*
+			 * ignore the error since many boards don't implement
+			 * this and we can still use the info in the devicetree
+			 */
+			ret = log_msg_ret("sys", ret);
 		}
 	} else {
 		ctx.dev = NULL;
-- 
2.34.1

