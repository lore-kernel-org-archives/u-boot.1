Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88200C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C245D87B2A;
	Thu, 26 Oct 2023 07:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xm2zPg85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A65F87B24; Thu, 26 Oct 2023 07:31:48 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE68187B24
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6bcbfecf314so118441b3a.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298302; x=1698903102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1xnsDhYxoGq8Q7UUWBB8Cvz7zbisEXPmyyhu/S5S0E=;
 b=Xm2zPg85WSbfHiYc68b/h4SqPGdnWUrMnJEXybgpTf/xxaObOzH1yF1KvQzwV5PWo8
 QcKSNqJRSEBkpnSDngfZw+r7oGJ85vBEucBsvSE4kFOr0oSZlNbty7YSqYGlDCdljmxv
 hW9FKiMye2ypWvCiDcGZ5k2lL2P0zrO4azXplTXw9QfY1noD5kisLD4NjLt0uFEVBMZO
 T6eCL46JI2wMvoMbcDHIVblyTS+AqA6ur/Zo4fM3qE+lZIDQrEgLHofxleYOjWuXPw4F
 jzys78/BmTbWq/tG3gR3DBsIaU8STvsOfCSpK9e/9ZBijUIj7NT3rMLrxn4SXSQxh+CG
 v0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298302; x=1698903102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1xnsDhYxoGq8Q7UUWBB8Cvz7zbisEXPmyyhu/S5S0E=;
 b=lv+baN1Rm0cHC57lwMzZjDNSU0MR3HuWdEEWN7bN2qYorMs3Hxwxsls59eaUM6AwLh
 /x2QanDamW4IHjWD7vDgGgWtSpzyeUEnmgozemN+uV+qYg9s7CdMYGPRV/za+sKWb65b
 SQeeABEOvbR/2w3P5QzaQnjVTnmY0/bZHWLAbJLjO2fGCotz2bUT2yrdA2WlTh0XpYoA
 Ltx33gC4HsHxterTdHs+RiQW2pBCj1zMgE1xaeQlK/jPO4XSmbfdwjOS+Z7cA+1HO+/V
 zMGeJ2PcSQWBfPnbGFwcZFiHlaDLfTnhetMDg0BN4MeVq22hfzzR2F/RGB3hQBUW3GGq
 8+NA==
X-Gm-Message-State: AOJu0Ywuj/Exx5WgNC4a/SORXrAeiaC1h+v9CuZooECin7xSx6Z5I8w0
 Lk9/duK/IEurWEK6hD7G0oF75g==
X-Google-Smtp-Source: AGHT+IE84dt8Y3zEDdcyhw08iipwTfh1Fr2LUrgYF4Kr8V2PSX6lFwLaOhB/HIBSyh5pNsH/ZnphOw==
X-Received: by 2002:a05:6a20:a10c:b0:15d:f804:6907 with SMTP id
 q12-20020a056a20a10c00b0015df8046907mr21131824pzk.0.1698298302260; 
 Wed, 25 Oct 2023 22:31:42 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:41 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 10/13] net: tftp: remove explicit efi configuration dependency
Date: Thu, 26 Oct 2023 14:30:49 +0900
Message-Id: <20231026053052.622453-11-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026053052.622453-1-takahiro.akashi@linaro.org>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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

Now it is clear that the feature actually depends on efi interfaces,
not "bootefi" command. efi_set_bootdev() will automatically be nullified
if necessary efi component is disabled.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 net/tftp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index 88e71e67de35..2e335413492b 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -302,12 +302,10 @@ static void tftp_complete(void)
 			time_start * 1000, "/s");
 	}
 	puts("\ndone\n");
-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
-		if (!tftp_put_active)
-			efi_set_bootdev("Net", "", tftp_filename,
-					map_sysmem(tftp_load_addr, 0),
-					net_boot_file_size);
-	}
+	if (!tftp_put_active)
+		efi_set_bootdev("Net", "", tftp_filename,
+				map_sysmem(tftp_load_addr, 0),
+				net_boot_file_size);
 	net_set_state(NETLOOP_SUCCESS);
 }
 
-- 
2.34.1

