Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB291C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF3987ECE;
	Mon, 12 Feb 2024 14:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yMvHc9GC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A30987EBD; Mon, 12 Feb 2024 08:37:12 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA43487C80
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry.baryshkov@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cf206e4d56so39688451fa.3
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 23:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707723429; x=1708328229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YYzK2WBNMyfFeAQa2ns8DhDgZJmXnsGZWwxnrt+2OBU=;
 b=yMvHc9GCbpACKpAIKqeThR7MwSnRtNS7/bF7XOrOaq4PctCiFKZ5ky87fFlRjuTPIc
 6XhQt2e4kFpyab8wHZj9pxebRNIqIER0klP/zbIWiag/GCG74rVvao1H/ym1LbH8rqha
 i/iQTk0rWQjn+P42t+QjYFDLDSWkvpXLFxTW7Uw6aZLrMfPaawyBGoEvWLsl65uqRZjs
 jU8+wEt7nKusWYC2A8JAL0SGPdrDp7VqngH/wl+O/BnMRwavZMuwOMYGPFkqk45vr8cY
 uAaPaSwhoShORE3e6e92OhlTdvYk/UN7I0NJWmu7wpRoND29qvd3JRjRAQPq4dv1xkYp
 XLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707723429; x=1708328229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YYzK2WBNMyfFeAQa2ns8DhDgZJmXnsGZWwxnrt+2OBU=;
 b=sGGvBa8El7F0nXvsDbxm7PvAu4Z+2OCU8zojW84ilou+9EX+GbT/v6KdDNf8r6kHXt
 8hflrSHHk8WiYBGohQzyGTJLnzB05TUQEQ8V/LXEY2ASI4dBsNyUOkxe3G2XDzvKfvwv
 FwMRXMAGAGzGV4+JYXa9QNpCpXzYf4TwCUKe5tBguM4chjTaPvTkOgUKvl0A456cSXEc
 onN9Xs2LNOL7+hDCvsG6te9Ykz3y33z1a1O6WB24NItiHn4tnV53hqHcEp6upEaNsVh8
 ti0WvlFidaf7EZ2vl/zAh7FHtOaEDD3epxwBCpALAsVVgu9XTUXpjWxlvFSZhXFvuOrk
 GEfw==
X-Gm-Message-State: AOJu0YzntfhbSumRpUVa3w3jSq8K36X+C99aNdYpsBlYYsTItziLQrwO
 pV+75b+Xx8QlJRh1jR1DPzmnWePio40z3F023fVqRU+DJITt64et3KkcyKAGetnIMr7dABiErKp
 n
X-Google-Smtp-Source: AGHT+IE3u5+O6l7vo3B3EY94PHYZviQWrB0jkix/SL3SLGoQ1f6/NHjgvqTzcuIshA5SMi4g3tcgyw==
X-Received: by 2002:a2e:8216:0:b0:2d0:cce1:f0a8 with SMTP id
 w22-20020a2e8216000000b002d0cce1f0a8mr3621768ljg.1.1707723428853; 
 Sun, 11 Feb 2024 23:37:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVpmYGMEgTSrbDQIHY59sv4wF/AMJuWkTPI8wboNQWvbOaoSV0e1VsSke70gXc9/pwCwcgK/YcgjXBj1rmTvp2h4Bs=
Received: from umbar.unikie.fi ([192.130.178.91])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a05651c000a00b002d0cd6bfd62sm1310552lja.136.2024.02.11.23.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Feb 2024 23:37:08 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: u-boot@lists.denx.de,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH] virtio: fix get_config / set_config for legacy VirtIO targets
Date: Mon, 12 Feb 2024 09:37:08 +0200
Message-Id: <20240212073708.4161197-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Feb 2024 14:19:09 +0100
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

The functions virtio_pci_get_config() and virtio_pci_set_config() don't
take the offset into account when reading the config space. For example
this manifests when U-Boot tries to read the MAC address of the VirtIO
networking device. It reads 6 equa bytes instead of the proper addess.

Fix those functions by taking the offset in the config space into
account.

Fixes: 4135e10732a0 ("virtio: Add virtio over pci transport driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/virtio/virtio_pci_legacy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index cf5dfb17a94d..aa89604ae84d 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -107,7 +107,7 @@ static int virtio_pci_get_config(struct udevice *udev, unsigned int offset,
 	int i;
 
 	for (i = 0; i < len; i++)
-		ptr[i] = ioread8(ioaddr + i);
+		ptr[i] = ioread8(ioaddr + offset + i);
 
 	return 0;
 }
@@ -121,7 +121,7 @@ static int virtio_pci_set_config(struct udevice *udev, unsigned int offset,
 	int i;
 
 	for (i = 0; i < len; i++)
-		iowrite8(ptr[i], ioaddr + i);
+		iowrite8(ptr[i], ioaddr + offset + i);
 
 	return 0;
 }
-- 
2.39.2

