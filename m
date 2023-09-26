Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F75E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E98F86E8F;
	Tue, 26 Sep 2023 16:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mSvg4eQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0F4F86E5D; Tue, 26 Sep 2023 16:16:18 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A9A386E77
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79f9f5135f8so257317839f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737766; x=1696342566; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6stHRscRPRJ7N+UFeU5CR9uw8NiwzFqsfoCayVE2Ugs=;
 b=mSvg4eQoCGOWLird8FtoZpUwmXgU8S6SZqY+lng3I07qf9PP+knQSe/fwm/+1E6HX0
 E/npXV3jrf0TO1ase3Tss4SqNXRvPzd81nFMshNo1435n2TwZqo8SwxG4WWRIe8hLiOZ
 ZWLos4vlgRnpeOYsUiRoRqGJUyRNJRRNid6hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737766; x=1696342566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6stHRscRPRJ7N+UFeU5CR9uw8NiwzFqsfoCayVE2Ugs=;
 b=e55QFNPSw4iiQYdiGRd8bhN8PVT133W49EUF17i4INDZrGmEoQSOvt4k0ARxkaSIlA
 036Y0/Jztd1vZj2qVOQ6KVeRNJCUFcAwvPj4jOMvERuzmaHTtCXs9NqCaqBRYb/7RCtM
 iO2tNEVnuj7oYoRPlF1ea0den1DHSxwmbtVdn6Ha9p96tPJUKO0X70HcQtRpM+uQ/dER
 BJD08Lg9JzAdturnthwsQKed5Ko/QqpPt70AcdBYcHiKXix2Sw3t27WvqYcPFiEIQhMM
 1rsy/7fARm44LPH4VTEMRT10sihAFK1cZsZaoR7niq7ED9va3a2Gb4OyYFuu/pxdH+6h
 oxwA==
X-Gm-Message-State: AOJu0YwsAP9++FXPpmy6Zd1yp/PjxdWXZWOc+VHT2G3JROuLeHDpiFnQ
 DBNSl1dr0Jc2cwoZhdNllYM4VezgbPD971E/2CI=
X-Google-Smtp-Source: AGHT+IFJmWrR8yZbo+NcXUGwoLRcY/+doBjIp5PYdxMz7Z3QXrdBQ99NAXjvJAYJaeCiMwEiSTecDQ==
X-Received: by 2002:a5e:d907:0:b0:791:1e87:b47e with SMTP id
 n7-20020a5ed907000000b007911e87b47emr10054393iop.15.1695737765863; 
 Tue, 26 Sep 2023 07:16:05 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:16:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 43/44] dm: core: Tweak device_is_on_pci_bus() for code size
Date: Tue, 26 Sep 2023 08:14:57 -0600
Message-ID: <20230926141514.2101787-44-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

This function cannot return true if PCI is not enabled, since no PCI
devices will have been bound. Add a check for this to reduce code size
where it is used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to tweak device_is_on_pci_bus() for code size

 include/dm/device.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dm/device.h b/include/dm/device.h
index e54cb6bca415..add67f9ec06f 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -1005,7 +1005,8 @@ int dev_enable_by_path(const char *path);
  */
 static inline bool device_is_on_pci_bus(const struct udevice *dev)
 {
-	return dev->parent && device_get_uclass_id(dev->parent) == UCLASS_PCI;
+	return CONFIG_IS_ENABLED(PCI) && dev->parent &&
+		device_get_uclass_id(dev->parent) == UCLASS_PCI;
 }
 
 /**
-- 
2.42.0.515.g380fc7ccd1-goog

