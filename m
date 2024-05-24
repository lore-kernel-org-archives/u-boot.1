Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5860C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D15E8888E6;
	Fri, 24 May 2024 18:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cYWdbN5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72AEC888CF; Fri, 24 May 2024 18:22:27 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFAC8888B7
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-354de3c5c61so2671792f8f.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716567743; x=1717172543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXawjeJXnycfE5xaoF+bqShNCUQW4mVfN0nOrxfadqA=;
 b=cYWdbN5ttX7nvcNP0rFVKwNUWKweEwVkq/hq6RdQj8kpK7sHAFKY8ct7k9Y4JGGAw0
 zAXUBcZChaGRTkkw1LHWzQSTKA8cyNHP9/h9f1956HPY0IWdNrTEaZjr+hKCdXfhL+kK
 L8wGHd8Dr/SBb695FiA7cRIySuOftBm5nIL3uRNmxDQLggkxGmJJzQuj7T0v0IE3bRj+
 ky8sAoQG+lq8HVL0/9hpCagE3krHqoOEnDpkRL2aiKCBU4CFQm2sS83WbI+ePOppJUxN
 ijr0xULvNk+cbvrF4PrLzaCABlLgZ2jKk6MIfLvdMob1/4HSVj5RNKlWhhK3avR5Gd4n
 khqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567743; x=1717172543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXawjeJXnycfE5xaoF+bqShNCUQW4mVfN0nOrxfadqA=;
 b=gzzjLQaeDKDWc21i3/VFW06ftcQjv3aMaaP0ZSc4KaxUJyWm8wGD1gz5yMB08t9ubX
 7P6S+Jdt0L63Oz4ihHhaYu61pVYei2Yk/df0Pz36aeM/gxKPqUupU84MVPRlONAyHwyR
 9NyEO+o4sI1sVYPeIvA1uqs6bJndWqSNzfkTfZbnanG3DSP0/+3EQdZLRbcwS59hQfbA
 weu2s+JUDIhUTzyocFLmFLvurZ9DGsEUf4OXbFm2DVGcelMssZerVAO3Kj/ncydoNghY
 X7o63+gn2bcDQJqL+3/JWpz5X23FlIE4/Qpb8F6AQZR3d9Yq8DqCVj47nEMgiM9+QFaR
 CXqA==
X-Gm-Message-State: AOJu0Yz1gbneJkY4PRNpA9y42iBH49DCcAqjAPLmdqUhG4KNkJYQ/2Y6
 rQI9s4QB+MxKKGvW0BXZiUiTpUZ3LTHojao6T0c4rM5JvuVnRWcc7OkUcGbPUWCYqOw93k/0DJZ
 rIXEvxl+a
X-Google-Smtp-Source: AGHT+IFfZLwgWaVbtfHq15MCvCXyRyGPNJl4hm0uHrNq15q66C2AIKQ9PQNX2a+3g2xfXUom70vuYA==
X-Received: by 2002:adf:f4ce:0:b0:355:2db:a0e with SMTP id
 ffacd0b85a97d-35526c19221mr1779655f8f.13.1716567743318; 
 Fri, 24 May 2024 09:22:23 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:80fe:af01:c137:b43b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c918csm1928465f8f.77.2024.05.24.09.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:22:23 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 10/14] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Fri, 24 May 2024 18:20:04 +0200
Message-Id: <acbfb912eec32a0103ce3435427b45df9feae6b2.1716566960.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
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

