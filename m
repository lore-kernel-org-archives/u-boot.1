Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72727C5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 14:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 883F860757;
	Wed, 19 Aug 2026 14:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ENih7T_IdqW; Wed, 19 Aug 2026 14:35:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787150149;
	bh=6orA6Kj9U8QZaI9tYYq9cEkAH764on1F+Yh+w9sy1GI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UP979jIT9eLeXni6oHp4MGgrWdwMwteiS2FBhypS5Fv2HeqbPkspmikC/DSaCNDEo
	 ohEcuSCrJOclhe9FJCpofQi8XN+6l7B7RcdFlCDhfCJZL1LsIC5oUZU+/EisZnZObj
	 KCMEnwyImaDgPjTNj7G4x5KslbrqvDx2+8nulcorZwzftZUFXpfYWlkHLATQLs2MAD
	 cmmyl2bLApggS5Ii+G3rLAFoGHZOlIZAVUVPPdl6yeQFr6+j8+rd0tJ6IptOv7gv/6
	 OuZr4aiAV8gXF23O4vawDRabKlZQJ+8k+H79yVGjiFfFrPMw5Ry0dqEoZkoQRG1dq6
	 w6pxa1HMYO49w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FDCF60718;
	Wed, 19 Aug 2026 14:35:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DCE3B1395
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE4654061F
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:35:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mtav9YyefDd2 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 14:35:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=G2xtB2rY
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACEF14061D
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:35:47 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so9648405e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787150145; x=1787754945;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6orA6Kj9U8QZaI9tYYq9cEkAH764on1F+Yh+w9sy1GI=;
 b=G2xtB2rYDk0FrSyjyK99OREOfuzKwQMAKhS4B9FaAgy3OueVjG4CNZ6ogJYcIm5+3v
 qO+z26Jyjzo1G4qYqKkffVFlD1EqmJ2rtrX6Pg/+NDR/Az3wUrIbwYF6cFeV3QIjwGuY
 +FEvBOlpWuBML7SpUuAPRrzq1j5g8ISx/F/VXk3eJenJ5ewEcBIeEYf03N2oaxAWZxqO
 iezxid4ZMTYIefX65f0pvogcOY3IEvHxWnKAdERU6Ixq8cguh+t8dQkBV1jL9pDaE09P
 QkMQsjGRoJogDMEiz/I2v0mqdIRJL9WL0PEQn06aTGaFOgS7EILKS2A6P5DbIEjFemgo
 r5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150145; x=1787754945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6orA6Kj9U8QZaI9tYYq9cEkAH764on1F+Yh+w9sy1GI=;
 b=qtY8GAbhYxnLA5rKoGK04jwNm7JWYQNPEx1nP2qSx/FPBeN5P800CwenBwlde0jTwr
 Y7w3womPUKVuqANVgRYiMSNQGaGFBhk9qQatbSyqck7gUcqRq1d7bpYGV7hulSLGb/wj
 BzDQHywwZ9mpXRB7Vzfqcm3gHG1xio09BYKCZcs0C2nSOYlgaFTC8ZPeMXStLKPWBF41
 8sA7jMyIJPqXfmA2MjwiC+cXAr0aP49Aq6+CZq1GRmoBLKz9TrwMV0hm2rHBb2mmDqJa
 h1KAxa518WrkA+krDIQH3AWBcmHmIsyRAR9Wut0lNlcKLTSe/2tfSodPZdSRw66c24lj
 VNvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWbUEnmaIeNQTxnEjmR5Xy4a1OKyFDYPFYynRXQLDks6R4G5r55SWGTq0RxVQrwiONv/pA+Xs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwDuW6zisLxwwVavuyLHcISQ2qobTVkVZS5naoyDA5dGnwPK1y2
 b5I4txVtE5TFa4QbsJSWzAJ3uYYYngVUPMz4TEP60wenL7fYZNeo6eZO
X-Gm-Gg: AR+sD130/LUwr88ijaftSY+SdhUE4hdammUzfNWzw+vg7SRud/5pY0OwtDsysHhtvjt
 1JsWf4zJeA8CrI8pj9lHAgP7DVDK5r/nI2HqPsZNsxJ0nifVrjd97LP8dTTPgibVbdnt9u53qZZ
 i+fqCO/7+VVxSDvH3PBb6soJtRuQZZsUlf7vwip+0miX1CVdYSVqbORbcoFXfskCQNXTZZd6DjS
 V9d138bUmqmtPF1IC912Wnar2yRAr4f4julpBNrJmbWMQdPS6swaHshLW039WiTuvFlEkmM7tOA
 IRb77uG148kEYOZflP0tt5/ZI5DC8oRWRTeJIgQa2hv2mSc3ciaEeQF5s2aC30NNZCr31LSbHLg
 0JZ8NPScr4oT+0WRNTQ5ZHFuy8QC2fYFGav9Tjp4PW3UNdUOhCkaVVLahi5JTna9rW536tc8rD7
 oMg5wqWzLxgsu/33HlEShUDtR3jZ6UvjeEarmr9sRfsYP6sVlzfxp1DUMLHszoi9gO2A==
X-Received: by 2002:a05:600c:6748:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-499aa1d0670mr112245825e9.9.1787150145369; 
 Wed, 19 Aug 2026 07:35:45 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499affa25acsm3811405e9.4.2026.08.19.07.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:35:44 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 0/2] vf610: make the USB host port usable
Date: Wed, 19 Aug 2026 16:35:41 +0200
Message-ID: <20260819143543.427396-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

With the ehci-vf fixes sent so far the controller comes up and
enumerates its root hub, but a device plugged into the host port of a
Colibri VF50 or VF61 carrier is still never found. Two things are
missing.

The driver ignores the vbus-supply of the port, so the regulator that
switches VBUS is never enabled. That is patch 2.

Enabling it is not enough, because the pin the regulator drives never
becomes an output. device_probe() reads the device tree into plat data
before it applies the pinctrl state, so the fixed regulator asks for its
GPIO first and the pinctrl state of the same device then rewrites the
pad. On most SoCs that is harmless, the direction is in the GPIO block,
but on Vybrid the output buffer enable is a bit of that pad. Patch 1
moves the call back below the pinctrl step, where it was until 2019.

I first fixed this in the Vybrid GPIO driver, by asserting the direction
again whenever a value is driven, and dropped that in favour of patch 1:
the driver side does not help a pin that is only ever driven at request
time, and the ordering is the actual defect.

Patch 2 applies on top of

  https://lore.kernel.org/u-boot/20260819093705.4143509-1-mehmet.fide@gmail.com/

Testing. test/py on sandbox, before and after patch 1: 11 failed, 414
passed, 210 skipped, 1 xfailed, 20 errors, the same failures both times,
all of them from tools and images missing in my environment.

On a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from NAND:
with both patches "usb start" finds a USB stick, its partition table and
blocks read back, and Linux still boots with Ethernet, SD card and USB
working.

Mehmet Fide (2):
  dm: core: read the device tree into plat data after pinctrl
  usb: ehci-vf: enable the vbus supply of the port

 drivers/core/device.c      |  8 ++++----
 drivers/usb/host/ehci-vf.c | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.54.0

