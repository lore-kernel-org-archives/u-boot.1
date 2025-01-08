Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2792E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E098006D;
	Wed,  8 Jan 2025 15:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cuxT2rPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B959805FB; Wed,  8 Jan 2025 15:38:56 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D75438001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso8444598f8f.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736347133; x=1736951933;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6yIFlcUsUwEhd8pSecynq0FWG33PursOspCkjX4Piss=;
 b=cuxT2rPvBQM37BnjWkew8J7TUI0+T3l6tQlbKEDOJC4ObC80UT0ajZS08cVuzYGiHp
 RQ5oGsQutzXht69Tzf/I4t7UmwZsWSduWXcql+1vggF/vnRlfOh8m4PkqegRuHQjmgiX
 TA2ahfe61Wt/Xx0O5mLDMV65PcjU2A0jroyiRdjYCoe/v118IVGY7xPHixeb2mDc4TRJ
 MTgcgbJ/9HhoZuR1cVwdQ61wOyB+kMvB1wHlZNJimNZrBANbmQvS5hT1Cj9qWZo33Xam
 u1Py4ltjGoHaFOnVikHDaIP04EM3JzrPrc4y/7PzOMT9d6RYcKcNHCxl/o+QavBAOMig
 CrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736347133; x=1736951933;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6yIFlcUsUwEhd8pSecynq0FWG33PursOspCkjX4Piss=;
 b=tGBzl7FcKL22+wqrfOlBOeBekCRRqLmkuVfbO/mct+s9nyxIoiycM7l2lm1i2k9BFB
 fzISoDn+ll1ABfCmIlOOQWFiqXo0BMdgbmbfR6zEsK4SMW9Nxv6wUe9vC+PPBdl4Qq/m
 mlOBrLk5Kfc6m1dI7wSudR/X4fL5ueqR1vrq2W818O3Qoy9YJuNLkRnclaoja8gXexkV
 cL6RlKZqLPIhcrjXRcQFos59wFqyc4OE7cWzmWf0yeAJSn+b1RxiNDfapORkxkbu9G4g
 Sp4tpiozX6c65OOfSMku7TQOemuiuWUygj42nXlCkgK4XBlRjlabGoqJmkUEZmD5GoRQ
 9pQg==
X-Gm-Message-State: AOJu0YzIMb+Q3AhL74Q7A4z0e1x59DsEFAh7CxKQ3J4U2RjvvWa6xPXr
 65ExbAarfeubqIdXQA4y9k5rt/vyQL7bido7o6oxRVN1xsoGB/i5JuApJl5ZiD8=
X-Gm-Gg: ASbGncu6n/aC4qQ93f9JMHKeZH0/u8rnKpnyzKmk9e1esFGTXeDIQEeTcIqZdMtOYI1
 0q+0i9OIayCHgBwqug2kCaDyaVvtDly5YM5pvfNMwz9vb5LMTK0yKqd9mnNs+53u9XzCSlcJLfD
 1EjBpxO2sDpCreg9TCwd/bGS3U+ZoiaI7Ry2PrbCPzSY0+QlM4JuF7ahLgLUu4xBcU340OlpwYq
 DH5b90GJn0KHeyo1vYx1AE8apMgtf+HzQJpBefgOMP1rHBct+95RQiPiY7KEToC2k+H/s+/
X-Google-Smtp-Source: AGHT+IHsRICrZVmTHVeMdGSqiwQh8M2gBVE3ftXR4j1qWNzE3xiQ8huIJd25sGvngjB51M+lvZXvKA==
X-Received: by 2002:a05:6000:4710:b0:38a:4dfb:49af with SMTP id
 ffacd0b85a97d-38a87318319mr3065563f8f.56.1736347133293; 
 Wed, 08 Jan 2025 06:38:53 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e3e779sm22796565e9.43.2025.01.08.06.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 06:38:52 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 0/2] bootstd: android: Allow booting with AVB failures
 when unlocked
Date: Wed, 08 Jan 2025 15:38:40 +0100
Message-Id: <20250108-avb-disable-verif-v2-0-ba7d3b0d5b6a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPCNfmcC/32NQQqDMBBFryKz7pRJWlG76j2KiyRO6oBVSUqoS
 O7e1AOUv3of3v87RA7CEW7VDoGTRFnmAvpUgRvN/GSUoTBo0jUpatEki4NEYyfGVFyPXdf4VpM
 rISjeGtjL59h89IVHie8lbMdFUr/231pSSEjUuUvdKGJ/vVuzTWIDn93ygj7n/AUahYewtQAAA
 A==
X-Change-ID: 20250108-avb-disable-verif-997f820c0c00
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.3-dev-86319
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

Android Verified Boot (AVB) [1] protects Android systems by providing a
root of trust in the vbmeta partition.

On unlocked devices, system developers might want to disable the root
of trust to reflash only some partitions.

This is officially supported in the Android bootflow [2] but is not
properly implemented in the Android bootmeth.
For development purposes

Add support for this in bootmeth_android.

This has been tested on AM62Px SK EVM with TI's Android 15 release [3]

[1] https://source.android.com/docs/security/features/verifiedboot/avb
[2] https://source.android.com/docs/security/features/verifiedboot/boot-flow#unlocked-devices
[3] https://software-dl.ti.com/processor-sdk-android/esd/AM62PX/10_01_00/docs/devices/AM62PX/android/Release_Specific_Release_Notes.html

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Changes in v2:
- Re-did patch 2/2 a bit: fixed booting without AVB failures
- Link to v1: https://lore.kernel.org/r/20250108-avb-disable-verif-v1-0-009c35710ef4@baylibre.com

---
Mattijs Korpershoek (2):
      bootstd: android: Add missing NULL in the avb partition list
      bootstd: android: Allow boot with AVB failures when unlocked

 boot/bootmeth_android.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)
---
base-commit: 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72
change-id: 20250108-avb-disable-verif-997f820c0c00

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

