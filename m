Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E33C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 932BA88881;
	Wed, 22 May 2024 18:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LeloNrb0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D76388892; Wed, 22 May 2024 18:04:45 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58E588867
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a61b70394c0so410043666b.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393883; x=1716998683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5h6/fCfcOJ/8ATVai0ueSc7L1Pl5c+WCtO8uMfxSYH4=;
 b=LeloNrb0nToMvs5W3VXQi26lVaXo+/fUJWOWfu9rim+82gktLJ6kzzX1ICAz0VP0EN
 i+1HF6Hzd58hxlny7JXm1LGDgQVEqluhssAn30jJNFT5JWXbtodORN/yW3NSua6zkd8c
 jVjp0u/34qwV3FbxNsosB48xa/+XSAHM/yPiNe8pJOiII7NH2wUmWt/NlvU25eDSC8Zt
 Ut6YM7GKyKdI62g9a/llP7p3Y5llTNm7oe8nvtJTb6L0k0AfefAcEkqhWmFtZx8xgRh5
 Xx7m8n7n3PbC8lfK2f6I9F4fT7u5TvheAV2rPKY+dsMqoX0emy6yHdCUs6CfFW0GZuRP
 cDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393883; x=1716998683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5h6/fCfcOJ/8ATVai0ueSc7L1Pl5c+WCtO8uMfxSYH4=;
 b=gKMXe4gW2o59p0B9sT1lQuN1Pxez8lyx+qjlxLqI60yR06Blrfj3M3YqbGK5jDUJO3
 aZ3xAoxruvEHcqEA0vAxiE9TUSdrGHlUH0Mcy/XCPI2cTPHutmfu8B+oBkHwH/noH8TV
 mGpDVTxfS6Kvqq2GoOb4pz+iD6Udk83dN83d9jJ/Vut0/Gi+AJ/BnHFWA6+HMUVxw0LI
 OdYjvmAL11DrCdLSOc9xCMGdlNEq1GIqrkB7qSqNyg8rg+VifbCrZQIh2hfxdlsmuNwt
 CXyvnGthfw7qWD2cjEJyJUPnNXkLlMS9QeoQswfzNJZXi/0enCHWVGesQHXXFOYgwxk3
 y9Ow==
X-Gm-Message-State: AOJu0Yx84zpV9wBrvvrHIDH35CBxHJKj7MX/pq6I8aOm92mkjd3jNzm+
 PKwWHfFFcC/w+Lbvy1dJ85/jF/Rmy8dvEnDX5rDXcRjl1yYBkjo+5AlzgfEVBNTavz3Y7XBUSu6
 2jaqLencm
X-Google-Smtp-Source: AGHT+IErKr3HP9NSaS2K13AoooEDRFdEtqKEY87bDO8zcsPbbnOa5TNqFp9jBBFQe4tvbAm0odqBBw==
X-Received: by 2002:a17:906:6415:b0:a5a:84c8:770b with SMTP id
 a640c23a62f3a-a622812f80fmr145968066b.36.1716393883061; 
 Wed, 22 May 2024 09:04:43 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:42 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH 11/15] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Wed, 22 May 2024 18:00:11 +0200
Message-Id: <c5bfc875954340d5dffb57c6bce0b4a9a99f6051.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
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

Support "bdinfo -e" when lwIP is selected.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/bdinfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 79106caeec..690fb894bf 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *bd)
 	bdinfo_print_num_l("relocaddr", gd->relocaddr);
 	bdinfo_print_num_l("reloc off", gd->reloc_off);
 	printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
-	if (IS_ENABLED(CONFIG_CMD_NET))
+	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
 		print_eth();
 	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
 	bdinfo_print_num_l("new_fdt", (ulong)map_to_sysmem(gd->new_fdt));
@@ -198,7 +198,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		case 'a':
 			return bdinfo_print_all(bd);
 		case 'e':
-			if (!IS_ENABLED(CONFIG_CMD_NET))
+			if (!IS_ENABLED(CONFIG_CMD_NET) &&
+			    !IS_ENABLED(CONFIG_CMD_NET_LWIP))
 				return CMD_RET_USAGE;
 			print_eth();
 			return CMD_RET_SUCCESS;
-- 
2.40.1

