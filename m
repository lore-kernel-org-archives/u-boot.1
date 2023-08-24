Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740B6C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB3F686430;
	Thu, 24 Aug 2023 15:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SoOwfbhr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A0586506; Thu, 24 Aug 2023 15:29:04 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E53C80750
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so881988466b.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692883741; x=1693488541;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GGOjMnuFKVkJLqeZinIzocYL6MjNYNtLkoH/ngRah+s=;
 b=SoOwfbhrB6k+BpMfLV2wXCvwria7EtaEZwXoVD9KH1/O3K9wGWlO57YhLoN7eryb7m
 KGPNO53BuzSNkbBYpqKDJShpkKjWzysM6uWGtQa2/W5miBYOjjaa8AZe1aBKSCu5P/Bt
 ri/IfSqxZlfpxA/lagT+oTg6tuBWhtbkhIhH1bRWizTJlAVu5T7JaySAfU4hllflLEkw
 CBuZmAw9RuQw8wk+8ebwMF85RW4r9vAgAMFzfoxS/U+Bl+HPCFJpP2TndoLYWJTN5Vd8
 l2m0stTdC128/Z4RNxf67If+pk1Yc299THGH9j+K/JsLhsWZhGfZHsMIIWjvDJDhJg0g
 HQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692883741; x=1693488541;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GGOjMnuFKVkJLqeZinIzocYL6MjNYNtLkoH/ngRah+s=;
 b=LNn8TWuRoj5sURDzLo1XL8dDJEqhx5VyMt7FlaVt8c2Bm8zGS6XQuvw8nucribfUpD
 DxKwuYnK0PhFwaRU3Ei4lQ9F6KVrBgRpdPtJKJqLSECZiNHcv08p+edC/k2vCdZY7Rzr
 Kj/Cygtov92Fbjw/8SjgzBurnFyRBqCl+gepyoC1otydS86h8HcEugIOUQjkFheIVTnS
 mWYZzbtrBQD7Qpb2vjLhzqehoYby3cDHg88GoUQC5ciAH0HokJid+40gV9e1e2/7/BXN
 jXuXb2ThBSOTFE0TgFdPV3WbXlKdcPGeTlPKiBRtTsqpV4LsnJ8eTCr6EHMtIaim6Aqa
 ekaA==
X-Gm-Message-State: AOJu0YyTl4IzPmdh+UgSwcAxdbpVjn8zptXiAvDBq/Pf6y4FhtjyWfNI
 GYNCbQJM+3Up7fCPQdK//Ck=
X-Google-Smtp-Source: AGHT+IELOOGUoaCICKG4h/HgtDJNpBas6jLOkjvN0U6HJdOTEIsWzsjYfTv5swt54DHAwvcPSvUz6w==
X-Received: by 2002:a17:907:2709:b0:9a1:eb67:c0ce with SMTP id
 w9-20020a170907270900b009a1eb67c0cemr3465535ejk.50.1692883741448; 
 Thu, 24 Aug 2023 06:29:01 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 rv6-20020a17090710c600b0099cc3c7ace2sm11112735ejb.140.2023.08.24.06.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 06:29:01 -0700 (PDT)
Message-ID: <409e34cc-f729-cb6d-1ee8-cbeb38c26d1c@gmail.com>
Date: Thu, 24 Aug 2023 15:29:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/3] dm: prepare rkmtd UCLASS
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de
References: <cbbaecb0-19fc-018d-df63-c5f265156024@gmail.com>
Content-Language: en-US
In-Reply-To: <cbbaecb0-19fc-018d-df63-c5f265156024@gmail.com>
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
---
 disk/part.c                | 4 ++++
 drivers/block/blk-uclass.c | 1 +
 include/dm/uclass-id.h     | 1 +
 3 files changed, 6 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 186ee965006e..a65f9df5dd29 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -170,6 +170,7 @@ void dev_print(struct blk_desc *dev_desc)
 	case UCLASS_PVBLOCK:
 	case UCLASS_HOST:
 	case UCLASS_BLKMAP:
+	case UCLASS_RKMTD:
 		printf ("Vendor: %s Rev: %s Prod: %s\n",
 			dev_desc->vendor,
 			dev_desc->revision,
@@ -303,6 +304,9 @@ static void print_part_header(const char *type, struct blk_desc *dev_desc)
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
index 614b975e25c2..6bad2719e729 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -34,6 +34,7 @@ static struct {
 	{ UCLASS_VIRTIO, "virtio" },
 	{ UCLASS_PVBLOCK, "pvblock" },
 	{ UCLASS_BLKMAP, "blkmap" },
+	{ UCLASS_RKMTD, "rkmtd" },
 };

 static enum uclass_id uclass_name_to_iftype(const char *uclass_idname)
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 307ad6931ca7..99a411429a2f 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -113,6 +113,7 @@ enum uclass_id {
 	UCLASS_REGULATOR,	/* Regulator device */
 	UCLASS_REMOTEPROC,	/* Remote Processor device */
 	UCLASS_RESET,		/* Reset controller device */
+	UCLASS_RKMTD,		/* Rockchip MTD device */
 	UCLASS_RNG,		/* Random Number Generator */
 	UCLASS_RTC,		/* Real time clock device */
 	UCLASS_SCMI_AGENT,	/* Interface with an SCMI server */
--
2.30.2

