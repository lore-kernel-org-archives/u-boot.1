Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F6A10AB82C
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 23:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A9883CD3;
	Fri, 27 Mar 2026 00:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YUcD5Sou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329EF80517; Fri, 27 Mar 2026 00:00:21 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9324880517
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 00:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40946982a78so579819fac.2
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774566016; x=1775170816;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zk78HjNRARjN1Xn+J+Baxg6z2+LXjBUnVyNpViSaCl8=;
 b=YUcD5SouR39J7it8CK/oSidDpIGGVYI4FNTsJkBc3jJBZcLPkc9qf8axZ7HQ1wb15W
 op80XltaRnygUL0EcV1DWbm3w/ELD++KtxbywRBC//WqsAv8QnOkZ1SGtSStmlW7SWEp
 6mAtqlHjh4Gst4p2XxHMk8sVlaqFRJm0J34ONWyOlgiH1Y5ZvqOpu3pfbg8hrn13SQOX
 CKYsSx1D9/hgl00Y9GZTUBRqXPuBQfe9drja1HyhxWsVSFdeYmFH6J7V9gICVFWlAdHV
 VSKBZo4Pz2lKijtBcsiza+WIowINMEfLpWQ5OhrfxGOwY23tsrBfTO1+za5wKxYLxUMC
 kd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774566016; x=1775170816;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zk78HjNRARjN1Xn+J+Baxg6z2+LXjBUnVyNpViSaCl8=;
 b=J/vGYNlXu/fM79C2OnbCHKiKAtp0L/+BCKEwVGYKeZj5l9TLxa2OkjZBHXukNWdp2K
 9M5Oz1XR8J1TnyRu8u28BDPcNb5JQQzBU0wNK6vPTQrcRG3Yc3D67+GLa9izorQbl6kY
 auZ+vhc6LnUs95Cdag8cmvhSE7THQDS3+l/kKMfXjexAa9IZOCgF9nalYaPWpnK1MEY3
 c6HM3/Oa0NQ3WMb+h+Cwznm7oX3LrR8mbRFBV7VySh0F0685+zYyzFViuuTD9xxHuJF+
 Wgf87V/3P/802Bbgi1wZS8uEhkDQEbXT6wCsHGvAy0/JS9OI8IjJyhKmJMBUcw8bQvdP
 alXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXter9dmgEL4KVrH14VO/dN2rpFalKaRaMJDVVkz70p9C6LYZcFBvavcMdsXYTX9UAryAabPh4=@lists.denx.de
X-Gm-Message-State: AOJu0YzINoF48l3KXosYvWGhaTkGvvm4sZBwXz7NLyobgHSiDyHfo+Io
 obYOkJhyJY4nBoiOvd2EQtbNtv4j0V84lMoqj/W/1gLj0G+M6NxsmID/Zvjn04LV+6I=
X-Gm-Gg: ATEYQzy95g6nKID/mxR7CU2cr0tRmZmjyPmVEo9axK4RvpZQxfnM+kaz36Uxshn8nXt
 PXLswY2evmvWFGUf/6eSa3pMrMj2ZcK0ZZ8p3f4Q04t31vnRMwbYV+raNxj5tXK1k78qZ9vkPiK
 WraR2zWSpdqZnwKIzOwzHMFBEM6VN9lzV86asstJyksZ8xJVQmAZZb8dwpyuUG73/kQAzGrCqWQ
 qchao9ijlnYgZH4/zrJd55T+LCpqo0C2BrZHPGKZ/rbbavaqf9GQCgJ0LXMaFBjG9BRCW44rOKO
 Uoju4WOhLfWsCNp67BwZ/7/23yj6O5uOsmfj/JvQxmO0pYdoDj+IcdG6LKbymX/o+QW4eTkpgbO
 EcPEh2IAam8rO3CSFCgYiEcdJTw5Ska1qxkeGE5xL9NDaNO4o4acYt2aGHyDTQVwdnwjw3eQeVP
 7tmeVsBEMWTDeQg2xgTtcAVgOCVdBD
X-Received: by 2002:a05:6870:524c:b0:40e:e931:e7ed with SMTP id
 586e51a60fabf-41cec357084mr68478fac.42.1774566015805; 
 Thu, 26 Mar 2026 16:00:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41ccb6b1d25sm2742836fac.16.2026.03.26.16.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:00:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/6] env: scsi: support SCSI env without partition UUID
Date: Thu, 26 Mar 2026 17:59:22 -0500
Message-Id: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB3QMSTgVcSFTSd1XMSQUSuId
 2/arh7f4v0XKGdhhb66IPMhKmssaOsK/DzFF6M8i4Eask1HFjkeqF4F5zemKW+oe0prWeeMscE
 ZCuSg3FPmIOcvPYx/6/5Y2G/fHtz3BwCmZ3p8AAAA
X-Change-ID: 20260326-env-scsi-hw-part-support-77446f742f27
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=XUKLuV16ypAcgf5qYl9FBJB+XQ37icgyxJgbc4FUUdo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxbpPE+WKsh4km+DgZzJkunK3l64LxPrU6jIbl
 BrMiHYiy5WJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacW6TxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aim0H+QElRgEguCaAIoDQ39jSLQ0Sdye+o2D0JfyOV/1
 VOsNWzJLnKEYVDrsiDKhlHMixw0jCPfK6jI3wggUklI07lVnz7WvA1L3ZT25/5XWsgYspjYBMZz
 us/fbK9RJrt/96h6vRuAnLj/2RPTs7VKGUBN5FlvEkv5K2gtXGBsLxKdjfS5+HgrISigHFObnmK
 K+49XmjbrjXkBXAvg88hKGFq1W1Cfp8QoOaTh9E4VuS7MZlrKAUQ7Z37WP2XFA2aIAKhHgBZPT+
 jBOyBjzoDL2imb+OJUDoKLOGOg4P2ZKkRf75XsWWnmIVtNt9N7MqqiMKgu6NGG++gBBQUl173Rp
 9CMg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

This is a series adding support for reading U-Boot env directly from
SCSI devices that do not have a partition table, similar to how we can
already do this for MMC devices.

The motivation behind this is that MediaTek's BSP is already using the
same disk images for both MMC and UFS devices, so we need to be able to
read the env from SCSI devices without requiring a partition UUID.

The series starts with cleaning up a few oddities we noticed in the
existing code. Then some refactoring so that the env code manages
calling scsi_scan() so that we don't have to duplicate that for the
new code path. Then finally, the last few patches add and document the
new functionality.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (6):
      env: scsi: rename ENV_SCSI_PART_UUID
      scsi: return ENODEV in scsi_get_blk_by_uuid()
      scsi: document return values of public functions
      scsi: move scsi_scan() call out of scsi_get_blk_by_uuid()
      env: scsi: add CONFIG_ENV_SCSI_HW_PARTITION
      env: scsi: document requirements for ENV_IS_IN_SCSI

 configs/qcom_qcs9100_defconfig |  2 +-
 drivers/scsi/scsi-uclass.c     |  8 +-------
 env/Kconfig                    | 30 +++++++++++++++++++++++++++++-
 env/scsi.c                     | 28 ++++++++++++++++++++++++----
 include/scsi.h                 |  5 +++++
 5 files changed, 60 insertions(+), 13 deletions(-)
---
base-commit: 80a4c49a4ab2ad06fa84a8b7bdf6e33b3b5101bf
change-id: 20260326-env-scsi-hw-part-support-77446f742f27

Best regards,
--  
David Lechner <dlechner@baylibre.com>

