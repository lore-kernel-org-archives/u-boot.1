Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09834C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 10:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D836C88001;
	Mon, 15 Apr 2024 12:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="DOt+IQWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4770987F41; Mon, 15 Apr 2024 12:50:34 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65CDA87E75
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 12:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e477db7fbso4736517a12.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713178232; x=1713783032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUfTMbl0LjqontagSOvcgd7vdw1VrycrvuPWWQvSFSo=;
 b=DOt+IQWPQRpsPyHrd8JQKP596CngWFhuJdBW1eDF6LaM27rAG8LtzocIeb9SCPbSmD
 IDCXMwkVn6NQGFCni31J++kYppOM2P0j51HQ+PiGESE6cBawDVJtK6nfNukCPR2xGVRu
 sSj6LI2h/56G9+z8T8+8sZm6WEw5u6ICh901LfOtwqS6QUDqyyaM3XJEOmFzHU6k9uFv
 DRyQzV/cuXKEtVmBDwmrwBPMAMKRsxZ1sLE4XpUpgjD09c8HJ1OlKe7UJf60REBHTA8U
 3GwagU23xvvDCe3hNJT2ROodQDCNAOWaHWkJnzaQPptoQRiHaZ2mhKbuQ61dJgTRQOyD
 SRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713178232; x=1713783032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUfTMbl0LjqontagSOvcgd7vdw1VrycrvuPWWQvSFSo=;
 b=QWUbfYZUYywMZ3EjIUyrFrUy/jpwakjV2g/LvI6IKmVEcwQw9usJcSZgJCVrhuwNFS
 w9voiYjEBgoeYWkxSq37w7fhGTtQ2RDmIHGsXt+mKAvK1KvbGBsVhRIzNu68129QgX7J
 5NW+3FtkQuVqfuXDNP4Nng6yrEVi1G+KU1uMLqwnXMMKRl7nYX2oeIlJ4Mbak4448bhQ
 ZvXVbgevGMt13NXszNbXBjvBKHmC/rM1B4c7RS7kpvLJxNJGHROXgC+yFEGZKBB5YQm/
 hmeqzLAOtbEoApz3pc8qfhituPX3XLeiyEDH0hOBrkO6hBRpKTJsXPBJKLqfN+mhEEku
 uA6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy+zP+VfU1qPd3uxI0IKifw0fkX9LVH9WbhULl9fOpWUptw2ziaON6ElO+ZCxs7Yw9xFT+kFyIbNewm69ewx5HzYUIqg==
X-Gm-Message-State: AOJu0Yy326Kuw1UejcBLdC5xvmjPqvki6EW4m4CjTCCoo5J2mjLK6kpb
 eV75lmek3qZn2d+ZEQqSfkLEyAPRTzrBFLIeTthLgAW271FJ2riRKWzvPUIkor0=
X-Google-Smtp-Source: AGHT+IELMGtHHOZ0l9QUUXVxz931YJVOSAkmCS0iwDaZZw0zLti52OK+tGcaUMifOiogNHwZbcUcXw==
X-Received: by 2002:a17:907:985:b0:a52:2d35:5e28 with SMTP id
 bf5-20020a170907098500b00a522d355e28mr7017570ejc.57.1713178231741; 
 Mon, 15 Apr 2024 03:50:31 -0700 (PDT)
Received: from fedora.. (cpe-188-129-44-155.dynamic.amis.hr. [188.129.44.155])
 by smtp.googlemail.com with ESMTPSA id
 ox2-20020a170907100200b00a522bef9f06sm4745378ejb.181.2024.04.15.03.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 03:50:31 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, sjg@chromium.org, bmeng.cn@gmail.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/3] serial: msm_serial: remove .clk_rate from debug UART
Date: Mon, 15 Apr 2024 12:49:26 +0200
Message-ID: <20240415105028.432404-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415105028.432404-1-robert.marko@sartura.hr>
References: <20240415105028.432404-1-robert.marko@sartura.hr>
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

MSM serial in DEBUG UART mode is trying to set .clk_rate, but the
msm_serial_data structure does not have such property at all, so lets
remove it as otherwise it will fail compiling.

Fixes: 90023bdfe979 ("serial: msm: add debug UART")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/serial/serial_msm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index ac4280c6c4..8044d38518 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -242,7 +242,6 @@ U_BOOT_DRIVER(serial_msm) = {
 
 static struct msm_serial_data init_serial_data = {
 	.base = CONFIG_VAL(DEBUG_UART_BASE),
-	.clk_rate = 7372800,
 };
 
 #include <debug_uart.h>
-- 
2.44.0

