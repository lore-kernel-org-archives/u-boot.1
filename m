Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D560CE7AA3
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7545B88D25;
	Fri,  6 Sep 2024 14:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MDY4V54F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D866688D1C; Fri,  6 Sep 2024 14:35:19 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 027E088C5C
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42bb885f97eso16986985e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626117; x=1726230917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9X+r8Q8NFzSd6Hb1M2hwnGKuGR3j9GDjlrMCZXXI9M=;
 b=MDY4V54FS6ggxIyKloVtRDEKouQxYrCru4I1qdxhU4rUtii+bbJMRVCJFdx0SRdNAY
 SFUjLz5bvXKn0rA83lcfj48CfPBbDbCiAqF67pQlQgLrp/l7BUT52rjQ5sfLW+GasHmF
 jh0GZ7H11tL0vCJ0Urv1JrUGNYuoGkZ41hetipyDeiYt0RwtnNP2ByIWttnHMYkXQ5+Y
 LO1eMgJC1enT5zCcvUaabYYDaeI0UwQHJgBjd+TtNrSVuIqGZNMwZpkgoSGveWBHR+ff
 qTg+7XL8JPRqaTjyCKIVMw8KiRN4cDdUutHVs3siP+ioY9QQHnh15+VeLEoLm2izbfG4
 x7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626117; x=1726230917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9X+r8Q8NFzSd6Hb1M2hwnGKuGR3j9GDjlrMCZXXI9M=;
 b=Rm/Dr6UNkmgd+QK561uGqvQKL2QRflhOcvxPYngb2ReNUe9vzYzd1oDDzqOfkFN/k3
 kcW4jhvd+kieotgNlwQH/XsAB6lCfpzmhHBkqIDbkadc2h7sazS3WMQ2DBZAS/DPJBSU
 NbzgQL6tGaoCID7GbZaFHwfz66Z8DALiPQ7Johnsvlrpm6osGp8fRUVf360FM7FWn0vx
 t/Nrq7IkHiCpbxc1TNJNiBzLn3XVEuCA27srMhRZJXmNqZ9a/MU4q+fdwc6ZPVKZ8Dw1
 K/0BLYTwz4PqxN92gpqtB3RUWTOgiZ1HoqL0/EsBR32Mg4IjsYYC6Zc9W4JwZj3i/TXU
 ep7g==
X-Gm-Message-State: AOJu0YwjsWpgSCyJ+8o2YwcSHPvvr8M5HJT8EZEkXU3Ej3XNcym+mtN4
 GCNbE7gOUOcuROsWUZ4Yh72fFKrN6lfS6yilpSJEVcvaX79yioNA1LYT1iXY0Gfqw8sC633s1jf
 2BIDE/afN
X-Google-Smtp-Source: AGHT+IFy+kTJxBc/Kwntn4FD2NeGlCEVAMd2wKbiS8NAcGExyqQ4nv42R8hpEOj67hcKUhrCaCTdww==
X-Received: by 2002:a05:600c:4ed4:b0:42a:a92b:8e06 with SMTP id
 5b1f17b1804b1-42c95ac1815mr56629075e9.4.1725626117025; 
 Fri, 06 Sep 2024 05:35:17 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:16 -0700 (PDT)
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
Subject: [PATCH v10 15/25] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Fri,  6 Sep 2024 14:33:31 +0200
Message-Id: <3134ad279d4d0d7fbce820ef1d565f75d4990c23.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

