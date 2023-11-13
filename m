Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FBFC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 05:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E562886BAC;
	Mon, 13 Nov 2023 06:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="YGrKmcfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CECE686516; Mon, 13 Nov 2023 06:51:14 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC6CB86C8E
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 06:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=cogentembedded.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.yoush@cogentembedded.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50a6ff9881fso4224962e87.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1699854672;
 x=1700459472; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=khwC9WqWAupDcLyIIyEGRdS6GkTd5q+Ih5OZfcjj66U=;
 b=YGrKmcfuYWCtfyWxmFJ8qQctYw8NGRRUvYVJ+KUFL9xxGxWbYnNQL8jTx4np9Dd6US
 1ud+2jl3vQCJaf92PX6HhSo9zn7W1NbRrjC69t8U8XPaZcV9bWGHxlbbKTF5lSZePFDn
 aHaGHI4KWsz2x5nxuzarA+KtYbOLOhFnjuUG3ylrpi7kP9JoQXbHqzLZx9njietGo+Pe
 n+5CvkwqI6oiVjPyoVPpbL/B4n+SuLZq833xr7jJR5IO63g6sONN23Nl9ile+5TgiCUk
 OnEn/U+H21oDz1M4S85LoHaMA++NBc71Tam6sqb/+wzOCUDJ8QhNW1HijjtBjedJfWAV
 FCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699854672; x=1700459472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=khwC9WqWAupDcLyIIyEGRdS6GkTd5q+Ih5OZfcjj66U=;
 b=oO0YD4uXvVbF14gZ6x0f23J/ZztxMuFaCmdh44XhnfGECImjan8XDfRSXt1U3YRfLz
 8hNasQ7drdjyV+BXwJfZzXCWU1Y+SOiUgjo503NKA1K/OYYgjtaV/JxXDSi08Ee37tlg
 QSUbwpK3/z9ft1Z0XtPQYCQha77FupJEuVqrMjPcBZoezPrYRV2t4JfiY376c1I82+de
 NyIvBYMRLs0OveCshWigi/ISYw1YivjXYoeVSzrzS/FbDnu9g0mllXJpC5GEZobSMIYP
 5t6TF9vtct9Uz4hchC7AH8xKIOLouMQlIVGiVWeaXnxd+KaXiP2SiUWXxfaajJBEnaGd
 +41Q==
X-Gm-Message-State: AOJu0YzNTFEscwij8TcKf7vLQt6fAci0jRK4P99jlkegMJ6+rrkZ714H
 fLlnwtg2VqVYgCSaRxbKq4GQdXNggpqTbB2Hx5g=
X-Google-Smtp-Source: AGHT+IHJxQrNjehgKG3LqFigFvRwGrxOMuXT861KTEVKrNnmgJSNtqLpbVaxy0Fw2eshXglke1FX2w==
X-Received: by 2002:a05:6512:1044:b0:50a:760f:dd20 with SMTP id
 c4-20020a056512104400b0050a760fdd20mr4520195lfb.30.1699854671970; 
 Sun, 12 Nov 2023 21:51:11 -0800 (PST)
Received: from cobook.home ([91.147.103.9]) by smtp.gmail.com with ESMTPSA id
 x9-20020ac24889000000b004f85d80ca64sm833114lfc.221.2023.11.12.21.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 21:51:11 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de, Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] scsi: set dma direction to NONE for TEST UNIT READY
Date: Mon, 13 Nov 2023 11:51:02 +0600
Message-Id: <20231113055102.4041946-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.2
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

SCSI device scan code was executing TEST UNIT READY command without
explicitly setting dma direction in struct scsi_cmd to NONE, so command
was passed to driver with dma direction set to DMA_FROM_DEVICE,
inherited from older usage.

With WDC SDINDDH6-64G ufs device, that caused TEST UNIT READY to
return error.

Fix that, by explicitly setting dma direction to NONE for
TEST UNIT READY, and restoring it back DMA_FROM_DEVICE for the
following READ CAPACITY.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/scsi/scsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index b76aadb0653..1330482c167 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -374,6 +374,7 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
 	pccb->cmd[0] = SCSI_RD_CAPAC10;
 	pccb->cmd[1] = pccb->lun << 5;
 	pccb->cmdlen = 10;
+	pccb->dma_dir = DMA_FROM_DEVICE;
 	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
 
 	pccb->datalen = 8;
@@ -538,6 +539,7 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
 
 	for (count = 0; count < 3; count++) {
 		pccb->datalen = 0;
+		pccb->dma_dir = DMA_NONE;
 		scsi_setup_test_unit_ready(pccb);
 		err = scsi_exec(dev, pccb);
 		if (!err)
-- 
2.39.2

