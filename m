Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E759CCEDDA3
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6D288FA4;
	Wed,  9 Oct 2024 16:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mZeD7lyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E8689020; Wed,  9 Oct 2024 16:50:40 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF65D88EDD
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42e7b7bef42so61768935e9.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728485437; x=1729090237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9X+r8Q8NFzSd6Hb1M2hwnGKuGR3j9GDjlrMCZXXI9M=;
 b=mZeD7lypTXrC7Os5TncfPgAakWu01vTPhkqpfsNVumGE1e5y1sbHVfHewhHavd45D0
 +sDWDGI8qqKXRNB543RQp07RMwmDLZCqeNcG0hpFQ7XyLFFX1yRzfsH15WQyqR6KcCfL
 EkcZPJv64mbvGM+YnPsk0XclNPZ/cwotXHI9Lv3SRUsdMb/JzNQcuAeZXC2C/oVyqUpb
 okBJJAFWtG9rv59RITCzUzrvEjvzlH4AE8AFlSArMN4GTDJWef06pVytaeHxGHi7Sez+
 s7TJ2ML+aU7jCYzEY+ogzEWzaIxgg31HVoBt/m9MLu+EfzJx6wwn0Bk9yVSDRh00cyu1
 Bjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728485437; x=1729090237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9X+r8Q8NFzSd6Hb1M2hwnGKuGR3j9GDjlrMCZXXI9M=;
 b=D/Bg755WmIj7PA2j69QTzzssFwc+obf/Yy0Ksjlmd4f543Qm2FQ6ddh4vfSW3k8QXR
 6gV/qbF8bZKOd73jm6FdjvMInkQFJ/nFeX7H7xNeNpVI302FAGifr2J6+k+83Sawzf7x
 CQtwhaCDINM8hLkA+DZNQ4C8aCO6HWcFPA9GOz4kOaTbOU1Jhnq2qLyjjIUv3zR4L14x
 fNeza8uJl4OxHIfqSvDnQnrsScYfgqIpGyUO3VxUbEluj1YqZs9wvD6zLiOex6PeOq8z
 VZpcU/ybx99zj9E5DISn4kN9jWyXGGRe0xKBu8ga5oTBvyN6qezC0lV1+pJ9BTvGo1U3
 3Slg==
X-Gm-Message-State: AOJu0YyOlERiP5nNEWwcmbn8/YTWyOqpv6chnXPCpwlMF5V95IFomxHU
 69OZgd2qUpdIrYWxsSu9QyxI4cQLqpypRoW0EjCKfD1QwwdOHjuoR/2BGK9INldlF4qFN65MvG2
 OaH3BD5+o
X-Google-Smtp-Source: AGHT+IFVXp90FNONbxEJmy7nTKc0emAiF8ufb83Z/au1OrdcLcIgpV0615CAxlPi2rdLwAczF6VW8Q==
X-Received: by 2002:a05:6000:1fa3:b0:37d:476e:f110 with SMTP id
 ffacd0b85a97d-37d476ef231mr272368f8f.34.1728485437140; 
 Wed, 09 Oct 2024 07:50:37 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691b5ddsm10700957f8f.47.2024.10.09.07.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:50:36 -0700 (PDT)
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
Subject: [PATCH v12 16/21] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Wed,  9 Oct 2024 16:49:57 +0200
Message-Id: <fe592e1fdaed478ced3c4d5397cd352863b0f543.1728482473.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
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

