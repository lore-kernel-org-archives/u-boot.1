Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E704C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6A08844E;
	Thu,  6 Jun 2024 15:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pKMkIDGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4AF88453; Thu,  6 Jun 2024 15:37:16 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A0C88459
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-421578c546eso10236375e9.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681033; x=1718285833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXawjeJXnycfE5xaoF+bqShNCUQW4mVfN0nOrxfadqA=;
 b=pKMkIDGGcW5NSFV8OgvokY7vTrcD7VWNmqJQXJ65fv6ZGWLLTjyy9HRQX17NlvBuJj
 p82qyaCUUp18ojtFlx0w/0eD8v7usa+BKMx6vQQBKHxK6y6jS/t84w8idAMW2VfMw3IR
 7+fe0HwN9Ggg2cMBBtV6Cuj8pEa+OopwELkYoWMDTNRm2hXrinw7VefsvGsH094yH2Ap
 NrLo+lrkllEdJtpZDME4GmkoCpzDt9aaK1cyPfuS2gEOKK+0tZToeQuKAR0OpUrRGmNN
 bK6At+RKrNOrAJDZaoCjMe6BMSKERydwivIqFKeGk7U20aHBSNcOZlQmdsktdRIYe4AR
 ssEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681033; x=1718285833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXawjeJXnycfE5xaoF+bqShNCUQW4mVfN0nOrxfadqA=;
 b=icctEPhj8VBhovJiJhkp9ecZa+UzXgHJjkVEkisB4LuLgE6XM6KNyTgWHDJTME5oLj
 U9jgrFiUK+D3+AeEu4d2QuFZeZMi0rww42iqLfggybDVXjE/lMeH4FDJFMvIQhjSRGOE
 7ZwTNn3P5chTREgWYl9xGXL6DRRNoxwrsMJcoWHTgZQvqKT+CPVKakp/2CzPZ1bk24+M
 AzygBN3Fp26oeMqRpAnJLpkbLFOhl/RfuUR1eeuy1BGHgdDbN6qmWeot34Y8gRNYaeUC
 +JRdNvxuAYh7SRkNhmOEaHpqWCKujIBO/ZElUJhlSXXHRRbTcrHUG/RD3jmrzaUoJ7lF
 4msQ==
X-Gm-Message-State: AOJu0YzW5wW0JulRDBZpI1oKyAkirw6wiZHus5qqe9j19oSchbQeILfI
 bAskjTYwZlWjybL8xzXx4JmK6ZVQkG2emQ8Z4XILYNh2LAVo/l9bAKxnv8VEi3wdOlz7UmLrK6t
 /xppJfywk
X-Google-Smtp-Source: AGHT+IEMPQZ5Zfe9tootcQYD3KR3uZ9WPLRulbCO+2RAP29pHNN9n8CTtCKfqRRHCdwOQmv1POs6vg==
X-Received: by 2002:a05:600c:3795:b0:41b:e416:43d3 with SMTP id
 5b1f17b1804b1-421563595a6mr48594185e9.35.1717681033049; 
 Thu, 06 Jun 2024 06:37:13 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:37:12 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 09/12] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Thu,  6 Jun 2024 15:36:04 +0200
Message-Id: <58b4c5fe6618c18789d0839938aa0f4a265b97e1.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 cmd/bdinfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 79106caeec2..690fb894bf6 100644
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

