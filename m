Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E093C48291
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 14:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05BDE877BB;
	Fri,  2 Feb 2024 15:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="T9tIv5nq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB12B87873; Fri,  2 Feb 2024 15:13:05 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A46A587252
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 15:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8CEDA3F829
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706883182;
 bh=02b1L0K+oYk2Fo6D88lwEEXevB330iYaLK6OUZMV2AE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=T9tIv5nqZHsfRvhJNludd//ftthCSmPCIkvJqi50l3gPwdyLTOtq6dkkEwcdK5e6d
 dyiq3WFNfOxgHaNHjed29GyxpW0jkIRO6GfwjD6uoRhrKj596QXibGi+om/NLr7rb4
 AAn4QiyumvYYjyoeDBvy7nFLt1aUaOMBUnUeMZYiguM243T61SmwlbIjFZCjd2yabq
 apGXLYqW3EnXy5grpoxrFwTKAvTJFkZAv/23WsYmGv9kvM0rmm8qU8fBs03IyoIx38
 KG6IlofqfDn/tXehIhH4bn2dmVZ/fQt63HiWB9V4giBhc4i0y7un95lY8IuF35yOoK
 VmpZSft4mSavg==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a35860bff34so198096266b.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 06:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706883182; x=1707487982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=02b1L0K+oYk2Fo6D88lwEEXevB330iYaLK6OUZMV2AE=;
 b=EdUQlbjb1ZTnaETZ5KsjGWlhQ7SgWV+ArMSdbz+Dm57DMP1VqX04PsAPW3zntRyEEQ
 l23xhU69aSv9h3PdnqATrHN41ojORWzeIBdqfaqUldXZasUcYD8mxKTkOsgruLRh5ERH
 RMhlbRHQWNy1ftJS3VPVTjgDlEjbuIX6W4yGTQKKs/RlQ398IY5HfJrL0xuxdd691+qY
 N4up0NPHIxBTGTV7win24VaJ1paHnpxCiu2Z7ce6dLUPxBQ2ztvQbBkBjhvEhKMO1JLi
 7caV6iOi1D/HOA/k59qPzKE45Y2tfPm420raoaB6YG1MGLb+JFMmg+bknIUE8Zs3vHFv
 NZuQ==
X-Gm-Message-State: AOJu0YxbHjo6lmFZzmMjONMiUDa7gsDD3f/8tyXlVxj21FWjCMJVKwOu
 +CcxRDbH22/cIc59IxBCifRVJaD2MsEOgFONbj7N8BYKfrXFHVbRVDkCg3ipgygF6x/2jpcvQKE
 b3j/SSYyyo6o9BhyC4GK985NG7Y25fVzSEeRxlCWddVr8QGaC6D96GUJHnkm/muEsz0g=
X-Received: by 2002:a17:906:19b:b0:a36:fd11:984 with SMTP id
 27-20020a170906019b00b00a36fd110984mr1753246ejb.5.1706883182228; 
 Fri, 02 Feb 2024 06:13:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcvZf8NBddpPtDBQKMklhHlG+IGejpZR2G9oI+cFZ0E0s+lQYvQQfCNLJhU2k/YSz3kAlsiA==
X-Received: by 2002:a17:906:19b:b0:a36:fd11:984 with SMTP id
 27-20020a170906019b00b00a36fd110984mr1753233ejb.5.1706883181871; 
 Fri, 02 Feb 2024 06:13:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUGUJMmtE842w+VQoVFkSKgf5e7hEhC/phBGKWShRiy0dpCLMbl03NG2iXNRHldoz+Fu10OsoHAnZvPvGw2MQmFbP5AJlpmdNhY4p0Erhk9AbZrazynrnEcCqIYkKyJghk34UHL7KOw
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 wn7-20020a170907068700b00a2e9f198cffsm912901ejb.72.2024.02.02.06.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 06:13:01 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: simplify error message in
 efi_disk_create_raw()
Date: Fri,  2 Feb 2024 15:12:52 +0100
Message-ID: <20240202141252.62378-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The error message

    Adding disk for usb_mass_storage.lun0 failed (err=-9223372036854775788/0x8000000000000014)

provides a decimal and a hexadecimal notation of the EFI status code
EFI_ALREADY_STARTED which is defined as (EFI_ERROR_MASK | 20).
The decimal output does not convey the value 20 clearly.

With the patch we write

    Adding block device usb_mass_storage.lun0 failed, r = 20

similar to other EFI error messages.

Fixes: 952018117ab4 ("dm: sandbox: Switch over to using the new host uclass")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_disk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index b1739d99201..2fefd05fbdc 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -574,7 +574,8 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
 			log_notice("Disk %s not ready\n", dev->name);
 			ret = -EBUSY;
 		} else {
-			log_err("Adding disk for %s failed (err=%ld/%#lx)\n", dev->name, ret, ret);
+			log_err("Adding block device %s failed, r = %lu\n",
+				dev->name, ret & ~EFI_ERROR_MASK);
 			ret = -ENOENT;
 		}
 
-- 
2.43.0

