Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51E8CE7B08
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 18:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E949E86E30;
	Thu, 28 Sep 2023 20:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GPPH1W9/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5480C86545; Thu, 28 Sep 2023 20:51:02 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5053F86E37
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 20:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3248e90f032so739119f8f.1
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695927060; x=1696531860; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WzFus2Qo0iLuH2VRW5G5HyL5WG2tBfATr4GMhZQiHEM=;
 b=GPPH1W9/xRY8PS01yuKkaNYfyAqOsWbKfgq3cy9x9tauF49Rk/k23dIoXi8yc3W8Ki
 qsuaN06aHXaa+8k0nM9TL0umniVZcM7D8xgW6zlU01t7KAUaRPxFA3MSSvOK08O5aw4g
 GQMAE3Z+Njw+uyeqIliFiCuME6k4Of0lXkXKIy0B0f7T6gDibMhczSFE+CtTWYBqtPwN
 zoEniHPMV4bwtkloCpYdAbTViLa5ys7WBANzQ++Vl2JmdEUYyTWWsVBvJ23DnQMqQnLX
 tL7Zs8auCMYqYU5yJNYIbKYo8H4i33T518hx0+MDrmjXFFd7MzcDyWmYd+17wvZJDZGE
 hNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695927060; x=1696531860;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WzFus2Qo0iLuH2VRW5G5HyL5WG2tBfATr4GMhZQiHEM=;
 b=fXHONZvqt9IQ1mq5xDjPuLgSesq/seGpFuJfBuD46sr+xq/vVH5Xpep2/kwlUK1Qod
 S0hxF1+H8wEg4yojruh+YgiRtMmJTX8poRfHyJoY/QOTX5EMrE7mgiv8FDE1G2Rkhxm+
 ANBQEpVsHf/NM4nCRzwyHsMZjhdOLQILFQQ0flkBN4Isi5gwU5xEO/mOlrX11t8wwQUa
 WgodXqtuwUiErhxWXaRRwXXZ8SZouu7Fmsz/rIRXUvriQyy+tsbPbEZtPAorZx1hmvKh
 uXNN/7Ewsx+a9TNDV7ZCTKP97R2Pi6yk5oWtejjv/GP6qru5YN2gsjU/olcQu/CRppKG
 yVtA==
X-Gm-Message-State: AOJu0Yxo4s9F+AH14pMZj5VG1V7V3ek3/Ea9qsXv1/rBvhBRaSX2Oo8C
 cHz62OoJcrhGKfJcz2nQhbc=
X-Google-Smtp-Source: AGHT+IGzwQlEj02/wT/1XgkqFXsPZP34WfPq6Gr14Nb2A96nFMqjDIyaHOAPgLAS8BxmHiRBhzRr0g==
X-Received: by 2002:a5d:4a0b:0:b0:321:62b0:7ad8 with SMTP id
 m11-20020a5d4a0b000000b0032162b07ad8mr2026051wrq.16.1695927059479; 
 Thu, 28 Sep 2023 11:50:59 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a5d4585000000b0031ad5470f89sm19933250wrq.18.2023.09.28.11.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 11:50:59 -0700 (PDT)
Message-ID: <c2acc0c6-0a8b-f4e1-7877-73fa5eef404b@gmail.com>
Date: Thu, 28 Sep 2023 20:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 2/3] dm: prepare rkmtd UCLASS
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <9dd66b67-e372-fcb9-ed38-7ad24d83edbb@gmail.com>
Content-Language: en-US
In-Reply-To: <9dd66b67-e372-fcb9-ed38-7ad24d83edbb@gmail.com>
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
2.39.2

