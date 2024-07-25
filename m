Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D34C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 762278851E;
	Thu, 25 Jul 2024 14:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k8IOfUNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FDCF88496; Thu, 25 Jul 2024 14:59:08 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8251488363
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42808071810so3537125e9.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912346; x=1722517146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQUv/HNCuMRxpKPtwooUf712RMBAKG5Q2VDiw47vrAI=;
 b=k8IOfUNIyBGQ4/gVEejywuB36558cwGAsWsVjvXNS4Li+XrmjmEbrAub+gQCVY6Lya
 JUU5cPBEWBFn6/iWap9K8Twp9nPNW0qj2SFCj23MeEjxp1TRr+fTluiwW2HQ7rWVbwUF
 mMG5Zt2GSQ2w4wKfWnU2x//kHpJGpir20hafYaiUwGV5ow+k0gfeK3b1zK9OVliWRYO2
 19MGeKqwK9+GXRMfy6r/wPz/mplQBwWUxu2FUN4NVeDF77GOK42mwpJiJXI+mgRN6wH4
 /DYi210mQ/BDuebRmVord24na96/CpuwXokrhEI8LyGGEeOWWD0pUbR3KcyMusNufrzv
 V3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912346; x=1722517146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQUv/HNCuMRxpKPtwooUf712RMBAKG5Q2VDiw47vrAI=;
 b=JZm0gCIEOQcGW7GFLSC+a3Ik5IaonH5e3PBiGTBc3+g2up0XjgG7z6L43QNbI2YFJM
 LtlhDUf3gt7FJhit1UVKQmU7Ut7iZ+FWPeX4YPsnLhyy2mMwH85VTNMVaFpuS4yPYomu
 77r6PFmnTDynsczVDGVk3e6Dlwq2JAg2DbcutuHjv3rJ8PZw1feDwjpzxZ50tK/0fFA4
 +VlrTvVi1WOpqhB/aEduOvtHT1aTFaPEHgT7ZvGNz0+D9Rtp1mvMexBzIKM0amrrFlHj
 nVFhzF/eoAPoywcTLQZEfxdWQs4nhznP3TBPBPqVN8MHpmwi5BKI3bscOW/RxlnKwQap
 cvZw==
X-Gm-Message-State: AOJu0Ywyxsy/ebKNpPBci+Pisdi35ufAJUb052OZfkgxlUn+Ltnm5QUh
 nAj44ES92FhdDijjkF9qNL2SPZ14GsMLBGfjrS8O3JuZKam3d2I7gLGwdPNZdto5pcztu4Iy/ZX
 AFpWyZQ==
X-Google-Smtp-Source: AGHT+IEL6K6zdh6JyLjrlYHlsS7rH6VOLisLaxS14S1k2+hPST89JNMghcFiN/MfbaA+MF9YnAObew==
X-Received: by 2002:a05:600c:5247:b0:426:62c5:4742 with SMTP id
 5b1f17b1804b1-42806b5ba16mr15922575e9.7.1721912344932; 
 Thu, 25 Jul 2024 05:59:04 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:59:04 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 15/20] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Thu, 25 Jul 2024 14:57:36 +0200
Message-Id: <f0b7999a15b8b2f2446ddea790d41778b2d4b55b.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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

