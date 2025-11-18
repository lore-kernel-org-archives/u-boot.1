Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6705CEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8945583F50;
	Tue, 18 Nov 2025 19:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fiKGPbB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B623983F5C; Tue, 18 Nov 2025 19:04:13 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 994DA83EEF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45033024e59so2641728b6e.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489050; x=1764093850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4jtudXHUYc7XJBnpI/XWOTOxOr0Q2smHBDUL3bo/iag=;
 b=fiKGPbB1oDhq/3/AxrtNuTufhY1JXr4E0WfUSk+gte3v/bYx4RPSgnXblqy1dxWfjp
 66lp5oostN1EBTWYViDq4KgZoTonoifb166SaqRuYQDb93KRAV7KiY8pERQeSTaHzuDW
 vZ3ELFsb48UUCBnk8lk5sIve3ODRIAGTGrXwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489050; x=1764093850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4jtudXHUYc7XJBnpI/XWOTOxOr0Q2smHBDUL3bo/iag=;
 b=ZxMLOIlEFzmjpTJo+Fm+EOuAVWe0IMlYkeG8DlztO/q203pKeZdtCQUYuU0Gdb7oda
 9ceWHAOZpTqze9fL635XEcMiHXPvTlUJvvdPrXVTuWYkZM27Xrtvjz7BQfn772luvVre
 UBtljkHA+rFf4eammj9GqWCa3CK5psoT75bB75bzvcOo78K2FozOWjn5Qlat4nzdybq6
 FWW5lBd/NgnvBdpWa9DuvqUJk3NLV2py/cupNQiLIcfiSAyZXlmqIB/+/ppxq7gE61o+
 3JhVAEnD4YBUpq0cCsrYQzXAO31/m/FU4yTvyhLdkI+QXp6OQBbKlP8au/N5gBhSvzHb
 /QeQ==
X-Gm-Message-State: AOJu0Yx+Fc34+HsJ0NpYNw4HfvncUOH2uaH5Xi6rzkgbaeN/mjvYgH5X
 zt5wfumA0/2dXqKpCApJA00OSqH0kzOnO0Uw4hEbueD8GbnceLUcq/B/ZMsH0Gx3HWTdN8G5G2h
 HTReT6DAbqw==
X-Gm-Gg: ASbGncusA7yr0ipLAeDLY19+7fCmrF35DRyZCeSqV3tRznL9USD3bZr2B0WCQfru2OU
 qYpecgB1N7DLVgafaOvGcHr08lhAHlmoqBS2cIJO7M7x8g9roBI0ipzSePCJAqW4Sy6HXAt+EdG
 KLEE1Epj4lKSTZHH1fgzYIinmT74T6syG91uzetyH72hVwANcsrq58ypOzcxr18mvd+SsEd+VXV
 SRpkDxmXPeu9z5rFoSjNSt5zusfEn3es6ePsmIfYvzQ2zSITH4IWpNXh1jPngBxvyYqu6YD/0n/
 MUXTgxDZPPmySE0nUq1SrwCmhP/AHpmSfALuwiWtzhvtp1s+h/p+bBzpxvjisaVNYjDTFYYjW96
 zZ19+Cj8lVgV3BmPWuMc3ggWMTALRUmnQnMlrLyUr07dt9Ba2eVcheTJcVZu4RsZS/PS8rTQdjp
 lK2zHrpzmDgLNMNQpaG7wRCYB83AFmmxt7kkNKHBBuS9ELVTOrxHoOEnrwNa07sQw=
X-Google-Smtp-Source: AGHT+IEOrHfzVc13pBKu+lINnTnVzhMzv9tbGBJJlt5j40BfVLR3eH87Wrwl5I/1PLZXj48pMtLOyQ==
X-Received: by 2002:a05:6808:5288:b0:450:e36:999f with SMTP id
 5614622812f47-450974a27d4mr8750805b6e.21.1763489050202; 
 Tue, 18 Nov 2025 10:04:10 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450a5f5e1a9sm3327677b6e.12.2025.11.18.10.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mx6sabre: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:08 -0600
Message-ID: <20251118180408.591167-1-trini@konsulko.com>
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

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
---
 include/configs/mx6sabre_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx6sabre_common.h b/include/configs/mx6sabre_common.h
index c8e5757d0bb5..ef2848b71f33 100644
--- a/include/configs/mx6sabre_common.h
+++ b/include/configs/mx6sabre_common.h
@@ -47,7 +47,6 @@
 	"dfu_alt_info_spl=spl raw 0x400\0" \
 	"dfu_alt_info_img=u-boot raw 0x10000\0" \
 	"dfu_alt_info=spl raw 0x400\0" \
-	"fdt_high=0xffffffff\0"	  \
 	"initrd_high=0xffffffff\0" \
 	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"mmcdev=" __stringify(CONFIG_ENV_MMC_DEVICE_INDEX) "\0" \
-- 
2.43.0

