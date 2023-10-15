Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFE1CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 22:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B6186BE0;
	Mon, 16 Oct 2023 00:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="On5Tb9bg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE558692B; Mon, 16 Oct 2023 00:33:19 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F7586AE9
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 00:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b95622c620so680301766b.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697409166; x=1698013966; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5Xgm6nyt0SC0nGF1LiYJaxPwMuub2nN0P/uAew4uR5Y=;
 b=On5Tb9bgNJ2NI/5r0KpEfmQSZk5pQlwhqt+KPdU4bmKy21BNgkLhApng4b/BRO8h/K
 whtGUxTY052BeR2vxjfsKZ8jto2O33gW201vqLrKNNLsIiC/OTLbE8E7cRCqGAufZR7R
 uZDroxT9hQIoEAPZzZo4svgbUwxUry+q4JNcuh0RcTurNATkTH4qL1HAhS0YqqpJ/edU
 bhxRKC81q77sV5MF5xMgYmw4+TJjuKGAO8dTTgXZrm04qObBVVPW1CG7v3VSi0xukGW5
 ngTycS/drX7KmzJGZ8AfqSzJoW36lCAVzaV5QiWdtse4D6WpKPXTA/h2BJ8Pd/Y+4JQz
 k9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697409166; x=1698013966;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Xgm6nyt0SC0nGF1LiYJaxPwMuub2nN0P/uAew4uR5Y=;
 b=Ee4juLRIkbfdi9ePlL9l/yq2SuL3UzusKRAmFpAzMb0k5oA8JKGF2ElPeKPk/uCEaR
 dmAMux4/uKS0IEFFkDPQXGMlkyzcceMa/jZzkwKUN1piR2BbnF78ou2XROWe5HMb1EBM
 MsL87UXhqxZKP3/0c/GRfotNrgHwuIYiZz6zfS0iZbLrcWWOMN+6DRzr/mWeq59t597z
 XpJuJxRPzFtY7O+cMq24bGB3rQEQtdGWytycWqU3bh5tNBApyqzzOJK1Y0m0YGatkd9K
 rBK9tooIvucrKkzA70x1sd//jMaYQWK3MSwNn+Oxfr5c+cY8w911jcOujBybxA3nhW/p
 sRvw==
X-Gm-Message-State: AOJu0YzBgF8f6aTBK+2+gSTNOT+nOSHFuopDnEzhf278IJ56skYzR8U2
 ZGAofthEqHubmt/A+gwxksg=
X-Google-Smtp-Source: AGHT+IH5XjeZmU3sXnI2fLDoT0Pyw4VT6T0g0JcJdGDue8iUrXVjzud8BWB82QjmAq/sT/gUMS7X7g==
X-Received: by 2002:a17:906:1bb2:b0:9b9:a1dd:5105 with SMTP id
 r18-20020a1709061bb200b009b9a1dd5105mr24327626ejg.50.1697409165796; 
 Sun, 15 Oct 2023 15:32:45 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 jx17-20020a170907761100b009ad875d12d7sm2821342ejc.210.2023.10.15.15.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 15:32:45 -0700 (PDT)
Message-ID: <abd6a9d8-7e38-a48a-b298-08f19444b5fe@gmail.com>
Date: Mon, 16 Oct 2023 00:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 2/8] rockchip: dm: prepare rkmtd UCLASS
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Language: en-US
In-Reply-To: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Prepare a rkmtd UCLASS in use for writing Rockchip boot blocks
in combination with existing userspace tools and rockusb command.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 disk/part.c                | 4 ++++
 drivers/block/blk-uclass.c | 1 +
 include/dm/uclass-id.h     | 1 +
 3 files changed, 6 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 85244b09f359..36b88205eca7 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -197,6 +197,7 @@ void dev_print(struct blk_desc *desc)
 	case UCLASS_PVBLOCK:
 	case UCLASS_HOST:
 	case UCLASS_BLKMAP:
+	case UCLASS_RKMTD:
 		printf ("Vendor: %s Rev: %s Prod: %s\n",
 			desc->vendor,
 			desc->revision,
@@ -330,6 +331,9 @@ static void print_part_header(const char *type, struct blk_desc *desc)
 	case UCLASS_PVBLOCK:
 		puts("PV BLOCK");
 		break;
+	case UCLASS_RKMTD:
+		puts("RKMTD");
+		break;
 	case UCLASS_VIRTIO:
 		puts("VirtIO");
 		break;
diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index f126547cc7e6..30ad5bbb0024 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -36,6 +36,7 @@ static struct {
 	{ UCLASS_VIRTIO, "virtio" },
 	{ UCLASS_PVBLOCK, "pvblock" },
 	{ UCLASS_BLKMAP, "blkmap" },
+	{ UCLASS_RKMTD, "rkmtd" },
 };

 static enum uclass_id uclass_name_to_iftype(const char *uclass_idname)
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 0432c95c9edc..2fc672df0a3a 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -120,6 +120,7 @@ enum uclass_id {
 	UCLASS_REGULATOR,	/* Regulator device */
 	UCLASS_REMOTEPROC,	/* Remote Processor device */
 	UCLASS_RESET,		/* Reset controller device */
+	UCLASS_RKMTD,		/* Rockchip MTD device */
 	UCLASS_RNG,		/* Random Number Generator */
 	UCLASS_RTC,		/* Real time clock device */
 	UCLASS_SCMI_AGENT,	/* Interface with an SCMI server */
--
2.39.2

