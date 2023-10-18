Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C144BCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA6986FA6;
	Wed, 18 Oct 2023 16:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKUkJ39Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEFA86B05; Wed, 18 Oct 2023 16:00:47 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5194F86FAF
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso1117925566b.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697637642; x=1698242442; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5Xgm6nyt0SC0nGF1LiYJaxPwMuub2nN0P/uAew4uR5Y=;
 b=DKUkJ39QaRcWqcFH+RD6omBOfvjTWItPEg7g1IGT4/csk7XbtuLXuO9ijijPJexprr
 Ku+MDgad7lXtbVewjPs5GmDZWQ/hRMf68VKF/J4YaIACjF/kqHnq1r+/es8SeDpQsDCB
 8S/poLejSeW4jNDoyYuGERj+XoFr8gH6zqVo6GY7YTgwwNrVgPvI0ul2Hipu4Nblpkdn
 89UK1ryHp4QssdcB5DU+n2v/wxHWOh6+QyM9lDf07CQYyQ3p2E6jVQOtqIPLT2L09LUi
 WBJ38sJ+aGV+QNnQefYBSRTP5U6EN9XCHrEuBV8/yiZGaMzM3E5m9bIfE/2TIRhFZFX3
 /Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637642; x=1698242442;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Xgm6nyt0SC0nGF1LiYJaxPwMuub2nN0P/uAew4uR5Y=;
 b=rGQRvLOLbae1QBJkNh2zO8w6o+UYv7E9/hfaH0YB9oZLVm8JGruWFjr7NtC77T+yaj
 1YOpiDTHlnQZePbbBKMQjtSn7GFyxL7zgik1fpMJ7V6ndlAz3HjUgujesPxxDovrjLCs
 VO++xfAA5VpJaJ/vqEdaBCGkNe2+un8mTIDIbkQi0fdF4hW9/5QUzzXSZjAsJ4+zPHt6
 Tvbh+cxblL52zfXiTBTWLcdDVBXWNBBa39M0nguFpw9pwEmUtijmYjbWdplYi2VNbTs+
 fK5xtqNFkKpMTsRerdj62GEQqEE3bSfP2l6etjXagz+fGKXCzOnqHhltdMCGBQKKuVyB
 gtLA==
X-Gm-Message-State: AOJu0Yy4Hvrw0Ll24KWPZeUWZp0nPZrhdyQ3BrHqbvpLk/bgTFyxLGsd
 fPCFST3yKDbmsVaSnYC2KLM=
X-Google-Smtp-Source: AGHT+IEJdSySPNmPBeHXcSXoKAbR24KkbyCYiOO6Nh22ExAVRddFfetz4oHdxwHKEzPRC8Cd/0+/Eg==
X-Received: by 2002:a17:906:fe05:b0:9c5:7a7:3752 with SMTP id
 wy5-20020a170906fe0500b009c507a73752mr4714965ejb.26.1697637642217; 
 Wed, 18 Oct 2023 07:00:42 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a170906190e00b0099b7276235esm1712815eje.93.2023.10.18.07.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 07:00:41 -0700 (PDT)
Message-ID: <f0a3eb7e-b0fa-33da-c155-f26b48d4fcaa@gmail.com>
Date: Wed, 18 Oct 2023 16:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 2/8] rockchip: dm: prepare rkmtd UCLASS
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 marex@denx.de, u-boot@lists.denx.de
References: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Language: en-US
In-Reply-To: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
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

