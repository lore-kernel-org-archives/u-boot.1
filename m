Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DC6D1AD3B
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8858A89013;
	Wed, 16 Oct 2024 12:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sl1tX3jQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D391089041; Wed, 16 Oct 2024 12:05:12 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A300189035
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43117ed8adbso72469765e9.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729073109; x=1729677909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9X+r8Q8NFzSd6Hb1M2hwnGKuGR3j9GDjlrMCZXXI9M=;
 b=Sl1tX3jQYu3v5IRD2n0DEM6B+My6rdVygHnxlARTHySiusaLyauI9E8dRBQETfrfNf
 nIFPX6sDuJNdExCI3bGBuhKxTsg8nE3Q7itGvZ3YQXS/YWkvIFs0sC9xcycWJVd0QAZi
 RgkFWqamfFCp+qDqMjeLXQigHbTdAaw0uS2EZHfPkp4/IOdc5EPQrvDniHUc/j9iMT3n
 se2jWEgo+6r0hJnqCUdB6Ak8SCpNorVw96bdc6z6Akye+7Nfe08QwUvaHvimW1EP/6/W
 0nd+sWem/6EyS3TGsCMBqlb6XYqzGsqJgWKMXZMlYJFZQlUaMg2mnZRrCdKty1m2uljp
 F4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073109; x=1729677909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9X+r8Q8NFzSd6Hb1M2hwnGKuGR3j9GDjlrMCZXXI9M=;
 b=YCs5z95LZprzjkyIAQW2pZ7nIZiEcxY+FYjQ0aZml+yZ3iDUPZ6+DJAfpYxGYTsJWU
 WGj7qUOVDvs5DmVJFKV9SRXhtUHwsTZtnGWBvt9RSCwwQ3HaBBUnWiH0A/DUscnOZ18s
 1vjh+1wQtseLFQG03twBrzzNLED/Dlozg4LlptUrEL3L6EsnjVVS7ggu2IpeSLP1osRl
 Jc/4gtbTqoKf1Sd+TXyD58qxL/7lThixGnP0OvcE/9+2a/Y41cF5aCKV5l0izY/YV8CW
 tGhn2uxvJMv8spDJKCkg21H5u1sAOrPkaV6fCn/FUtcP108TjTU9KXQukIYz3JgnY+au
 o7TQ==
X-Gm-Message-State: AOJu0YyPeRfoJtZbptcXs8ZYJo++BnG+aH5d6FWqCPIT9xOOoD6iQ8Ue
 +lGkG/pzGb5HME6egtX5RKxpLP3vZY/xcZ/iZXfhgVYxPlESsaMj/u8lrLSelqVCFCcAue5onHG
 x48y3OG8T
X-Google-Smtp-Source: AGHT+IErARqLkO2f4+0YOhotE1bKNNNE7bAl9X/1TZUrYEcg+MCxWjbaZWU7ZXKtGg4hqKL7F6e7Rw==
X-Received: by 2002:a05:600c:4f4f:b0:431:518a:6826 with SMTP id
 5b1f17b1804b1-431518a6994mr12682345e9.19.1729073108885; 
 Wed, 16 Oct 2024 03:05:08 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm44634515e9.22.2024.10.16.03.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:05:08 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v13 16/21] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Wed, 16 Oct 2024 12:04:10 +0200
Message-Id: <190ec5f585a987b350b62ef9a89b68cf942b54a1.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
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
index f6e534dd5bb..4c0e2adabc3 100644
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
 	if (IS_ENABLED(CONFIG_VIDEO))
@@ -192,7 +192,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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

