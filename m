Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0901C52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5769A88D68;
	Wed,  7 Aug 2024 19:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pcB30qdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B8A88D53; Wed,  7 Aug 2024 19:13:24 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED96188D46
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-36ba3b06186so37188f8f.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050802; x=1723655602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQUv/HNCuMRxpKPtwooUf712RMBAKG5Q2VDiw47vrAI=;
 b=pcB30qdt9R4akdE+I/aBeTJ/2kK9xZRTfEv6FtWQVdO2yupksTsXbRrWioWeepn8vg
 xOOfbsjh8Vw6IOi3vuet0w0qqqMwTp/X6cJT+ig/K222ILZS1vEarvZvw/4nyEg96aS+
 0vYw1LxH2SU+Z2G08UBEYFcsFBjagPcgy466A8P09J0lZcmwWcRLlj+44VqltGWtrGe9
 stdP6mH1oppNA/r4WA0/SHcQxo4YOKAAwZJ1/n3WiFbLVoZR2+rSpQ/Dp8i64jJJWxX5
 0R4AcpLSw+V8pdzE1lDoNvjGQ6Y6nJCiWwGhd5vM9AsG7FzT09+92AfTT22sn+YbQfVN
 mmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050802; x=1723655602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQUv/HNCuMRxpKPtwooUf712RMBAKG5Q2VDiw47vrAI=;
 b=tDP/UvhwLPm8SWO6TI7mgcTTarFT7bmyn1T5yFDOY+LJgpMpffi4eUapvLvM9O1CJe
 8okRHyVBT64i0BmKq0JHYkMnrmAPH5MvFSJEuXPXNu5r/1DkWQhkAYbm8zG4k3sQT5ZV
 LpB6H8rRN1nXkFCm/jobHiA0zvppJxZ2eeSNDrV192HDTCdr2w+n1TDlWiLThYws//pl
 O70eHtSLtYVurXLQ0vt4CEpMI65Ki/jTmKl3qi9NjiSmS7QEqY0Vb+klegL5jJHimFIX
 8+1WqHvvGN7Sy3LL5eyvCx9eZ/Vdz8jrc8WbSRcgLYb5MsG+UbCDPnfP3XfboR3OKcEs
 8wAw==
X-Gm-Message-State: AOJu0YxedOhCEX+NQhnu1f2C719Xgy09IvRZQPcloOw4Hj1CZST9ChtN
 QxMKGTqmakLmgWL4fC1JVeUDF/jxW0Bp/BXfZObkjc7Ryz/LjwjkTJIRG0MZ2r6lHYxF5+Rg++d
 1WCAPOlxq
X-Google-Smtp-Source: AGHT+IFdpYgrZaHg+Lk2k0q7uE9ch6tWkMZlOAbQixF/imgLbRFSFtf6HK+hpAbgiP6uVdtgl6DLtg==
X-Received: by 2002:adf:c003:0:b0:368:3ee5:e3e1 with SMTP id
 ffacd0b85a97d-36bbc0c6b40mr10704376f8f.7.1723050802182; 
 Wed, 07 Aug 2024 10:13:22 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:13:21 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v8 17/23] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Wed,  7 Aug 2024 19:12:01 +0200
Message-Id: <df9accbf0ddf634f8de0418156a95a9a00d1bbb8.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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
index 437ac4e8630..472e5c42b08 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -151,7 +151,7 @@ static int bdinfo_print_all(struct bd_info *bd)
 	bdinfo_print_num_l("relocaddr", gd->relocaddr);
 	bdinfo_print_num_l("reloc off", gd->reloc_off);
 	printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
-	if (IS_ENABLED(CONFIG_CMD_NET))
+	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
 		print_eth();
 	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
 	bdinfo_print_num_l("new_fdt", (ulong)map_to_sysmem(gd->new_fdt));
@@ -197,7 +197,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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

