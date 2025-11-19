Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D627CF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1926E83FF4;
	Wed, 19 Nov 2025 15:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dq1nyZNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50AB183FFE; Wed, 19 Nov 2025 15:55:43 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E78883FBC
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-65763315216so926264eaf.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564140; x=1764168940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mdIpwuoIxGP67OCcWXqcks7HG4+ExKoT5IzEceg+AvU=;
 b=Dq1nyZNHEm2/KiIZCkT5PQk4oSIOhpQeNU/0jRDsc2J7BnSFsD2b+N/UnmejISOBfE
 k6rACYD6wGRYI+7ddsBVrKiDCHs6n+3pGwLOkRRB5Povo7UVIIjRYz1wN7qIvHDttiQu
 qWFnvGIGwsuyRG/pHpDUj+SrUrQhm6z+nZemk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564140; x=1764168940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdIpwuoIxGP67OCcWXqcks7HG4+ExKoT5IzEceg+AvU=;
 b=mphO5j51YF2x3uthzH6eSnHscECokkOPPV+eqn9WlCVXXuniEyQ5BWCFUPg02VaOHM
 ZGvU8ImphkyqYt1KatDJabil9P7H/zZPEcP0SPhYnRnwhERt8wXwuH5SZGNEQ5AB6ZWV
 jR7KsWetuk22LV83vH2WW1Rl7BELQe1nuwarchaz+NXVv50tNTVkJEMFHAP0YhTHMENJ
 VKXUvk8uvpSDxXKSnsCYQqC1gATeMJWK/jJk3NS8tO0c3lXVm8cTvR1Jvnd2aEdV+kMC
 iaXtkP6JL27Ao9SEY65bZ9EtqFuMED+asBmVHyx9PJBTVKojS0m4k0HDwU5qw4jXxvV7
 DWvQ==
X-Gm-Message-State: AOJu0YySfsXJyqBOPTJGNFyCWPf7+5wu4C0C1Dzo/HCN1uihpw3fL6s+
 LpKbmCtvjEmO3E6G7nGRSNkObEFczhP71OdAQfImER/RiW7DrHqgWFPfMlc3MfGkRQjMZYcX1MG
 4yMlHTMDQCw==
X-Gm-Gg: ASbGnctLT2dWBh8d4OqKjuZQJHL0awNo/09M61ScOnwMmt/DfoQeYxZdkJlY697tOaI
 m5hsFQ9tP23ttU0wsZ6zeC7kmJgEws+xnQVTRQ7aT6dlXEBHIHMM86tQmoL5gaK3mCPbWxRIPl5
 doaXy5pOuY4Y3wBG0g4HJDHmbVukICtxiiezkiqBykhNWpZQdyktpRJMDCunTejuGx+0yfYmfMh
 QBrJf4ft4e9Ul1TtFmbp1+kIXYek1YCOYn13IB4H9W5l6aGdnxvNSznWL43P6RMcIwyb2M9PnDT
 KgRwtK8kp48G7sKO0B10EgPHelV6utXIZeuhmUbp5HJrTvrFppefmxn2Y0WYq7kmtLi2oY+/V6o
 hPtCoJ25eft8paE8+T7VdbodjF3M/kgCrlEpazXm1cIXVWIgOMG4bCNIraoxBaf4Ecw6KvjxEiX
 DNKpDWM0iEvyHBexmwfy3/WTaVkws+R1TNs0R0HHGGCZdbdbvo/57OZ024H23fHy4=
X-Google-Smtp-Source: AGHT+IEzPIdyCI/q/AR8Nav2rXte/o7bZpWDUVIvcpDPrgAHEGXFSR6Vtqyy8o4q/oWqHaLesLZrOg==
X-Received: by 2002:a4a:edcd:0:b0:657:5cc3:f38 with SMTP id
 006d021491bc7-6575cc313acmr3296152eaf.0.1763564139903; 
 Wed, 19 Nov 2025 06:55:39 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65748180aedsm3854697eaf.0.2025.11.19.06.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH] socfpga_vining_fpga: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:38 -0600
Message-ID: <20251119145538.843430-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 include/configs/socfpga_vining_fpga.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/socfpga_vining_fpga.h b/include/configs/socfpga_vining_fpga.h
index 4bb15cf46293..ad13f1345b01 100644
--- a/include/configs/socfpga_vining_fpga.h
+++ b/include/configs/socfpga_vining_fpga.h
@@ -40,7 +40,6 @@
 	"hostname=vining_fpga\0"					\
 	"kernel_addr_r=0x10000000\0"					\
 	"fdt_addr_r=0x20000000\0"					\
-	"fdt_high=0xffffffff\0"						\
 	"initrd_high=0xffffffff\0"					\
 	"dfu_alt_info=qspi0 sf 0:0;qspi1 sf 0:1\0"			\
 	"mtdparts_0_16m=ff705000.spi.0:" /* 16MiB+128MiB SF config */	\
-- 
2.43.0

