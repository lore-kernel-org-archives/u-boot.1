Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64A1C52D6F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 16:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4963B88C11;
	Fri,  2 Aug 2024 18:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gMKeZ8dw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B067B88BDA; Fri,  2 Aug 2024 18:28:33 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C71C188B63
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 18:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so20522205e9.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616111; x=1723220911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQUv/HNCuMRxpKPtwooUf712RMBAKG5Q2VDiw47vrAI=;
 b=gMKeZ8dwKTtKRB/nsx388SsTRyrGKr2B53HENrhGK/t/fTTXqn9IrriJ0SZGI2L3w8
 bvKNzVTpVPnM3pcRLLk46vBxnT/AUhbNBlUQCVrgfhMktIflmcImwthkjupjs9pRxw9c
 CUTuwXSftS+igrYlSiQwfXXlgdO51sKBexG/JOH0+oxze3MjvZBVRu9fJV/JgXYPTDmi
 +yUfcezWwy70NvDhELzhwv4E6vQuet2nLaDdGYdY9KpLAd1plg5axZcCXjppEfMDHoaY
 qRz6frDGD1tOJM0QuEHwErr5tuoUUHNr6gK313UY95bATepuTeMIb/cW7L2FCz6OhTJs
 Sppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616111; x=1723220911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQUv/HNCuMRxpKPtwooUf712RMBAKG5Q2VDiw47vrAI=;
 b=dEBbmQI0LlfAP9TtPw5hoNR8DQwRqZjsrBl73A/uNG/hjwvXuyN6KsBNGT+XFWg2mo
 awP+0rC4WL8JRT4zS3TSBawXdK4T3iBK29AjF6NxHxeAFYqmeiJJMaUGuu5H69ok75hY
 mUbaFkm2gIuZOPSzL9y0DSI3NVUdmcu7XysG/cqVo7z8HJTxPePCh7dGj4yDbdd2zgrA
 cjIntCZOlkC5/NBD+Y/dc3Dy5D2JDYPQ2TEBuwrjRTIR7G+mEE08BxeXcHIve6+DLf8G
 U0qszKcAmqveAZ7GWOkekjKdxrsUubmlDiBtFz8NepmDFKQ60fBHT9dQdoCMolGeP89C
 035A==
X-Gm-Message-State: AOJu0Yxf9Kndzf2L2COfZCRUpqs761qqW0rYg2FCkSNfI/URQEL5h/nS
 elD/dfeHJCgdFM9o1YXhnJNbsv4BP3r7XqfTtmZUo7E5Rp8cXC+tgKrcfRJun/U3EQMiYBiVeo/
 ag9FKBtnD
X-Google-Smtp-Source: AGHT+IGULtdaC+0WeSnLut4Sru/T+UYgnN1Y4W/OsgbjUIi+hrG2Hv+tFrIfWyiXk0HIsSw/497YtQ==
X-Received: by 2002:a05:600c:1d10:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-428e6985de7mr35886765e9.4.1722616110609; 
 Fri, 02 Aug 2024 09:28:30 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm2297783f8f.42.2024.08.02.09.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:28:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 15/20] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Fri,  2 Aug 2024 18:26:42 +0200
Message-Id: <a6bcddf36485dd09c6af270a15d4dffcb8d181d0.1722615735.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
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

