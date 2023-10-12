Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C82CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 20:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D45886D80;
	Thu, 12 Oct 2023 22:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LlyrCykK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 370AD86D41; Thu, 12 Oct 2023 22:52:03 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D6A86D3F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 22:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso1926840a12.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697143875; x=1697748675; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5Xgm6nyt0SC0nGF1LiYJaxPwMuub2nN0P/uAew4uR5Y=;
 b=LlyrCykKoSE4VVIiDKbH0KhzQUyKlFMxvGB6uHBBf5PDSvheCwHCSRC8+/GWJh+9gE
 tlaXqevVWhQU21n5y4Hl+/LN0YQOumPvBZKhd4puak6S0wyTeZcNDB0vp4cx7nU4HkK0
 Lv72UlLfTIKX68lBblkU5vtjXnPa/O5ENfpwOhYwAl9jkgEaSnAuQPLBIXbh+HuDmZTA
 NLPT7nYLKuITbkTDpyM/9EfgAqay8t8UdIcMvoor52FRMKVHhiZGN31YhxWRB6rZuXNV
 Yx2SGlV/mOCQIeuMLcoX5ZdDTQKB6uys01Y/lJQCPtywbXT6EKorXr9H5qKCwXNv/kNH
 ieFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697143875; x=1697748675;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Xgm6nyt0SC0nGF1LiYJaxPwMuub2nN0P/uAew4uR5Y=;
 b=rsTEHd/yeh00l/FcY/4q96Q2zk8a0Oo0XbUU1aOu0OSzQ8QplMdqmOyRwViULDHq+w
 Ucbua7mzlc0wCI2DHTuai5rYEgFgOq4ziihoo1dS5ZyjDORQAbNCZRQmpPvxgMZHCs7+
 YW183LirSA4K8NG5mvNDaqBWMuJywqMYTxVfkAcvOJ31rSbUfn1O/vtUhQN5uXlPo5dJ
 RGADtnEiX8ckz8GsxXwK8+YzHKgND81YnY+sRwYJTN1Cse3fpNbXUn20MSTDleZyu9Xa
 J/qOCQzSdWxuOiU/yDgJ51bnWkw0uOaZ27QGgy25i3ENuTJ79Kp5RoDzP+iVVLT8W4Cj
 BpSg==
X-Gm-Message-State: AOJu0Yzk4Cx615YsYBXfquZhTOdttZBpmR5O+ak8a1DbWTHs2ts0zqNY
 7ptbbj1t+tRMFphZLOWBWcs=
X-Google-Smtp-Source: AGHT+IFS2fQfyrPj4Gb6sEKEFY+VNMX0F0zftspX+X0WDg77dHKqLp+dXpU2F7Zf02cSdhZlxesRmA==
X-Received: by 2002:a17:907:75e2:b0:9ba:14a3:7218 with SMTP id
 jz2-20020a17090775e200b009ba14a37218mr10899347ejc.25.1697143874814; 
 Thu, 12 Oct 2023 13:51:14 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 ks8-20020a170906f84800b0099b6becb107sm11621439ejb.95.2023.10.12.13.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 13:51:14 -0700 (PDT)
Message-ID: <94255fe4-ee9d-2e31-1bfa-d6270ebcd104@gmail.com>
Date: Thu, 12 Oct 2023 22:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 2/7] rockchip: dm: prepare rkmtd UCLASS
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
Content-Language: en-US
In-Reply-To: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
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

