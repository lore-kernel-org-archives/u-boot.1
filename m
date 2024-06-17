Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1FFC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 085BA883FE;
	Mon, 17 Jun 2024 17:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g8ahekNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D8F883B6; Mon, 17 Jun 2024 17:33:51 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98670883E5
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42249a4f9e4so31532565e9.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718638429; x=1719243229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXawjeJXnycfE5xaoF+bqShNCUQW4mVfN0nOrxfadqA=;
 b=g8ahekNANrogvGnPQY+0abqitDmhowkI3VTyn75szdcQUJ7wk1Odgq2Y2RVQhYVGk9
 pKeghmL0bjHGo5yFb487rl4jNxBNSb2E8jkUOArDzIt+G+CPBQOqnQKX92+UuFNdPNeb
 P4W1R13Lzsgp8fcVXIgoczpL6wfsNrlwhwwCSFWfwh+y/0apEPPzZCtvjMf/SpAVziqb
 tcDJdHAN7yKoXmOOha0zJ4rQGkEakFIaVYGT6XmjhuGHAD729s+tmzLhlwmwS4ghL0OQ
 KJd8HFl6eS+Kz9l7sJ3YQQwYHw/H2OUxkQj4HLqmJn3Y5019JZ9zNrnKRlERFORI5xqm
 jjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638429; x=1719243229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXawjeJXnycfE5xaoF+bqShNCUQW4mVfN0nOrxfadqA=;
 b=uW1igr2FqXiL6YtS4CKJJPbiY25xwujtnk6W+yR2vmvxG51jH0ldApOAZinzdE9jd/
 Muf6uNfWQyWZhMaIEOdTCYB3hsZTlUgRbu80bCSsI2HlUl+ghToN/4EoJTzNeX7lzxgo
 Z2q6MGX+o2xvByxuvd51pA1sc5zYeadeGVxl9UjSDm//xte+1X4UEIXoUcjcpqzgxArX
 pNi/49VDAwN3/BKikO3V33Umm8nCw+SzpjYg8oHfXgNI2NOVOva2QBviKImQFCntoPsO
 eICf1gj9qguSq9L88ShYQ0wJgngMsUS1gKVY1XCzKYiybOKqr27ITP/lqSjl9WJNlyR1
 5fLw==
X-Gm-Message-State: AOJu0Yyridn7PDYiCWFsa5AC+y/NA+YCjlv6vqZne4Uu7a/BtzujoXZ8
 MdLStAD0jr2Wvkq6KX/HEbWzzYaatL9BY2JKQ0JXzxHD197h8wUgBOCFzDGZxMbGIV8yCSIXk/4
 dO3A=
X-Google-Smtp-Source: AGHT+IEpZQS6tSvHKG6LZBLxCy89Yle2SbwfVzoRJ1+8rV5nO9ru2b9BQTvQpLuzVh5s3L/CkOyK8A==
X-Received: by 2002:a05:600c:4f49:b0:423:57f:fc7a with SMTP id
 5b1f17b1804b1-423057ffe60mr105865755e9.32.1718638429050; 
 Mon, 17 Jun 2024 08:33:49 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6e75:be8f:56ae:2b5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm161350895e9.19.2024.06.17.08.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:33:48 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v4 11/14] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Mon, 17 Jun 2024 17:33:03 +0200
Message-Id: <5efac81d0108b65fbb286cb8739a8ed6c14978b3.1718638104.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
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

