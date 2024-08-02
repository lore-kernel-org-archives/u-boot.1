Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B99C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E91B88BF0;
	Fri,  2 Aug 2024 15:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KqcPakdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930EE88BEF; Fri,  2 Aug 2024 15:15:12 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9898388BE9
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36bb2047bf4so988001f8f.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604508; x=1723209308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQUv/HNCuMRxpKPtwooUf712RMBAKG5Q2VDiw47vrAI=;
 b=KqcPakdGDtIPBxAgNStZFG37z832tVLAatgrNbT762s6zQbz2EXTFyX6QVBQNLcWRz
 ggJITWEkR/DLfr3I3tTbn13RyE82nwbR7CFGWh4AhlkRlEwpj6REqK2Z1Zw6eohIi17/
 GIb3nkrXy1FDhqepo02QN1eCe40gxmu1M4Us7h3TdnbTWhLlmB62VY1bzwS9eGqoFwjN
 elXxF3iUOgjBYlAd1ftTL2rG7bksg2OBW89z3712aatNKA1NwACb2n0mDkNcprcQugtJ
 /SQWDWeYcarHyEqrPl2ElVizXQu4gPyx0vzrgZ14WnC8cVXcFF8a/ZLsvNh85NLoibFY
 GAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604508; x=1723209308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQUv/HNCuMRxpKPtwooUf712RMBAKG5Q2VDiw47vrAI=;
 b=ICiKwgfrq9eO9Z4ue91JBdrpj02HxVOsPsN7gdBKzBtmhokEzEsDc9lEkS6I1I3IMf
 M1K1DVAwJQBBnXNW3kF1QU8298vF22auErpA26/Rj5sro5zOiwvjkpzsOllYBy7/bjsa
 4C+aiUK0sWpHx56OeyszvV8xCHo81uwesc1kf5xbcZ7XyeFJzkwlxxW2VxKzzrUJ02GW
 aX4+61FruCVz5lFU15+KWkq4wBotYEWcLB1Om2fw5ZVimGtBpzfaJP/Up3p7tibYZOgC
 iBOG/wSHuJeRguCpTfskOXz0S0nKRln2z4q37wWt5bXcsUqY2gyg9kKbln8AImnQmTxc
 ckow==
X-Gm-Message-State: AOJu0Ywqj0DvrtsZKSbTQe+J1fwCAEKO10goU0yVuVhb6NYfbHoI10YR
 OSEWzX0eDM55llk0G9kv5rSc4FQ3TLyO6ZXdosmmtKZnFKQdLX1LEMGJIXFI+vxBHALT3NftnU/
 Q/Owy1ZvK
X-Google-Smtp-Source: AGHT+IFjxrQ1iMounNgrSjz5OktnW5h7Qs0USRwTeZEpoXG8OUFHDanMVsY+APSttHtkQ2ueWHaU9Q==
X-Received: by 2002:a05:6000:12c3:b0:367:96aa:af79 with SMTP id
 ffacd0b85a97d-36bbc194ee2mr2304136f8f.58.1722604507807; 
 Fri, 02 Aug 2024 06:15:07 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:15:07 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 15/20] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Fri,  2 Aug 2024 15:14:02 +0200
Message-Id: <7e5baca6e6781a6677e5f6b6cd4c11fc5792207b.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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

