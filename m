Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14643C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 09:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF5080FAA;
	Fri, 21 Feb 2025 10:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ait8KR0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7270680F67; Fri, 21 Feb 2025 10:59:20 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8934180F5C
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F01AF3F467
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740131948;
 bh=M9oLnLmLjmQr9OLq1s1JvbZsBqGgk7Hxj+Vo80PrJQc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Ait8KR0XRB+5MWjqLQO0VmlJ/r070dFSW6cMaKZMi9DCvtHjwNN9JmhTlPVx8uRqA
 N3KFFIz5QkQ3jaObspuUPU5mF/FQd4jYFclZ2IRdJCgcQo0BlF4wciV4hhp30SCHTH
 D94bv1l1AUXSoCLuZPQDsaVzRmixQSx9WbA2rmRdWQ5fFyrFmsSIBZyJY6u0xVswf2
 7umRuj0mYhZGLtDpv0vTMHOEnm6f35i6nrICVlpbyOfzBMvNeaocKWOKwXGeUsae0P
 uksqH1azm0nSBuuL5QE+QJikbtkjDqG7Jjd7r+9eLacy2zBfXknFrB72crKU6/zt8M
 BAoGBAhKOTqtA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f455a8fcaso1301961f8f.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 01:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740131945; x=1740736745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9oLnLmLjmQr9OLq1s1JvbZsBqGgk7Hxj+Vo80PrJQc=;
 b=QrTM7udkUueewB9Gc7EjIvQJXW3mzgAbmFCAfLGsGnVNgHyIOSZ3jA2jXbcdFd3MOU
 Erj+K3jm0Ee1vesbXEbAIKM0VH0abUPBOQNtLgElpNQIYGhfmwe/lMTtlMZrOvW0ioQa
 K4GjIAvUxABP9AemdF7btZkWcf8oZo/SUddpQTGzXuhqCyAbbOdYahFfpAwD5+BwEUeX
 bf5W/989iWg1v9cseAoHFpqTdHWRmNDwahQAXejeDZYr62Ib9SMWZOCU+OORDnbOumoU
 uaN+MTRtzHWj9t7nJnDnzIwCxSY6T/4dmxeH0HN1busKyo8Jzefl9y2OtSusCINqVoiH
 CfNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFgh7tr/PBJWxQ/nTcGBWwFU/AswxZLoePaEuEr0ZmjI9xU+GUTFjKJDNW4mKlAIwhYrZ769E=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/kSI7aopRQXW2NxcLWWYGI9nuUG3rMhoIrFnDkMiakGruysb2
 OmQsMk2eoNRVAHVT8TuGy8YtZBlzNl5LHnN59xgu9YdIBXkOxGQKVv7VSWUBbbe4BmUodaThcLn
 MyQ6kzAOtBHgol/HBMbLovC5OC3GOgGFr2U/NoJS12eIn/j4Xl2dm7IRA4QrruxkBkA4=
X-Gm-Gg: ASbGncvCEtEfQk2IwEBFgcATrTOhiGgBzUy7rSuhGv3I4pAYyAfzt/8QP2rmWyO1vMX
 0uLy3RRnhQv8uyWeeBzAu2C9m7PAnXh4WzgLtYRtTkyugXiaraSCqNSiTYGGuvaPkuT3lZowKvw
 yEtgzLz4mgg+nCROVEymTLQgFwQPcJiRC7WO0xFXOJBWBWQSYk82C5oOuwWLAE2J1cSIhF08tZl
 xd5njxypP94GkyS32Dl1BJeWXepXKN9/RcP++Yq3QbNJ4epitJgzr8Kr7orgliY+H5YMvNrbCnI
 OcGzqJlwDnaYd6rg5dEV54UxD5pZPV/p8MBFFXBS/6f7ALsInOFOS8kyA2VOFkyAtZYIpXVka+J
 YmULH/PXHqfb56aJicg==
X-Received: by 2002:a5d:6daa:0:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38f6e95d5famr2493479f8f.21.1740131944823; 
 Fri, 21 Feb 2025 01:59:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHF5r8se8TE1UNdU9BuRwCZbLwOwEAp3Ccn140F2aWtIob2r1ou5WweG7HMhDQ+ceCrn2tsg==
X-Received: by 2002:a5d:6daa:0:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38f6e95d5famr2493440f8f.21.1740131944476; 
 Fri, 21 Feb 2025 01:59:04 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f69b3ca41sm3287961f8f.27.2025.02.21.01.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 01:59:03 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, H Bell <dmoo_dv@protonmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/4] riscv: dts: no default configuration for MULTI_DTB_FIT
Date: Fri, 21 Feb 2025 10:58:54 +0100
Message-ID: <20250221095856.36530-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
References: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
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

JH7110 boards are currently the only use case for multi DTB FIT images
on RISC-V.

Booting JH7110 systems with a VisionFive 2 device-tree used to kind of
work without causing harm to the hardware. But there is no guarantee
that this will hold true in future. So we should not rely on it.

Before the current patch series booting failed on unsupported boards due
to the lack of a device-tree in the binman generated default configuration
when reaching main U-Boot.

By not setting a default configuration booting will now fail on
unsupported boards already in SPL. This allows SPL to
continue with the next boot source for a possible recovery.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	new patch
---
 arch/riscv/dts/binman.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 782ef037f7a..ceb916b74a7 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -93,7 +93,10 @@
 			};
 
 			configurations {
+
+#ifndef CONFIG_MULTI_DTB_FIT
 				default = "conf-1";
+#endif
 
 #if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
 				@conf-SEQ {
-- 
2.47.1

