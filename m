Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B41C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CAF188354;
	Tue, 18 Jun 2024 16:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W6zPnCSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AB9188365; Tue, 18 Jun 2024 16:18:57 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE1B88315
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5b96a78639aso2213472eaf.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718720334; x=1719325134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7/ljBTKVBkJc69pQUofLCg1eq11QW/ZCdFB+3nhtYOQ=;
 b=W6zPnCSfKds7wAAk+9fbVTnc3pIXESAzIifCvcMPxsfQLtK3v6aMmPwt+tSq1aCQmj
 7EIk+wMgLX4t8OAKFKiM2M034kO2Tzs0aovqlGDka2AQ6giAV8Ny8FXLm8K8BxMlR9vN
 6LeJsVT0hxRJWXL3GvTGNrwpjZ71jZjx3a8wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720334; x=1719325134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/ljBTKVBkJc69pQUofLCg1eq11QW/ZCdFB+3nhtYOQ=;
 b=YzZ2Gqvq8JFXr1gkiw6WEtp65o7BhyllS7dL/kL5XpT0BKCcL9JIq4+9sFu94BBR1J
 PS1hdG4P0MeLuVKELymmtDV/qqAmHrLi/Nz+kkATqMkWT1LOi69SDhgZUEKS9K6w4773
 yIzdc3AAO7pdFEijBixSdhyX7i9FMRW3joIl+3SqeIOInd1NVfSU6E5L2aPAS9uxi5VA
 uOm5j0stDnFYLWDNZy0t9mEQopqI4T0WPDJ8WxiCPZDJOfGd6SIHw7UCPmPuWvjeiVIT
 wIUhNr2YFbC9zOAeV298hJVTdYCaIH1dgwaxqRa/I5/2Hkx7wc0qWgWDamVpR3fp8QO9
 O6jg==
X-Gm-Message-State: AOJu0YzIjsA9BHUCjIJWDoL/yF+vx8v9N1fxQzkIPaot0RJXgOnMRNhD
 ZDYEuoralPvWH1mhMJNiLswcPoyUEXQtypbRRCRMgGMcTaY6eV+Zva8VyTCLRgBsDCF0V6hIxPQ
 U0E5Lxg==
X-Google-Smtp-Source: AGHT+IEOUhTk9BHkz7RuNgA4J7mEOjxVdDmX0G6bADPj7qDc2ZfyH3XS3nXNvmqVyccNxh3OrD1Kow==
X-Received: by 2002:a05:6871:293:b0:254:9ec6:c8cd with SMTP id
 586e51a60fabf-258428535admr14703830fac.7.1718720333813; 
 Tue, 18 Jun 2024 07:18:53 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b1b0bd9sm1844183a34.27.2024.06.18.07.18.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:18:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/5] Azure: Spell out the "everything" job
Date: Tue, 18 Jun 2024 08:18:49 -0600
Message-Id: <20240618141851.3303112-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618141851.3303112-1-trini@konsulko.com>
References: <20240618141851.3303112-1-trini@konsulko.com>
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

In order to get the list of boards that will be done in a "dry run"
build we need to have something listed and not just an exclude list.
Populate the job with all architecture directories except arm and
powerpc.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 6d3bdcee8aac..2c2d0809cab1 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -18,7 +18,7 @@ variables:
   powerpc: "powerpc"
   arm_catch_all: "arm -x aarch64,am33xx,at91,bcm,ls1,kirkwood,mvebu,omap,rk,siemens,mx,sunxi,technexion,toradex"
   aarch64_catch_all: "aarch64 -x amlogic,bcm,engicam,imx,ls1,ls2,lx216,mvebu,rk,siemens,sunxi,toradex"
-  everything_but_arm_and_powerpc: "-x arm,powerpc"
+  everything_but_arm_and_powerpc: "arc m68k microblaze mips nios2 riscv sandbox sh x86 xtensa -x arm,powerpc"
 
 stages:
 - stage: testsuites
-- 
2.34.1

