Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4DFE95A63
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 15:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D0E086AB9;
	Sat,  7 Oct 2023 17:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EV7r4GMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2159D86B8E; Sat,  7 Oct 2023 17:56:00 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12172868BB
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 17:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benwolsieffer@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-41819a68143so20598241cf.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696694156; x=1697298956; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0Sh/gjTYVK0pT2Od1XT7Z6Y9xiHG3h0L3HrsgjeC3GU=;
 b=EV7r4GMntUra5f2/n9rLXXkS6XaHAZeJfsui6abuKCPNiL/sDigjwWqG98S0iGyXvT
 LsbgVlLqvboLioAS2OryMzJdEjVdEO5Hp+UEqiXTii30R5q6/+7E7Vepzd9VEiolNh1h
 2MDXfmEHnhmNhv6wLHrMJtYPMxJeb7Sqn5jGjlgeM4BEZRX5i7ecD7iCMcMxSN0yz5Dz
 hGDm9Ubpj6xHPVUep3Krq7x6wRMG1BjeAy1k35YIaWXyaSP4PqY3/GJSUbIbi/y/7+r7
 uNmd6hLy6fajeBp83nV92nNbxidcHEBjB8cMGElNcbpyVCr67y3BoDFliDXAHilvycoV
 7BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696694156; x=1697298956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Sh/gjTYVK0pT2Od1XT7Z6Y9xiHG3h0L3HrsgjeC3GU=;
 b=ufMBe9e1K6fn44SXW8gMZb24rvNVpDV7JXpuQ2RplZJXK86HZOvD81KPq8zUKKrTMl
 F/ZKcjVO15DM7chtwsL5goKyPYcZScnjK6aeKVeNjIvEVyZidpwdOTtobPDGY8kpDHeZ
 fVPNCH3T1tgS0oLF67DoyZ5d7K+UKs/LFKEmQAXwZBxwHJAH+jGz1tcAF7Vu5E04pmU2
 33mW8ZJbaAWFqvV/yHxevxRvwQUELw6eNcXL1Spqop+TtWXIphlptWA5VBsPb7URgXgN
 6AbIn5Xk5U+94KyFXqlNp2QyN2OLvhHkIO5qG6DfDZDujILY8ZPGiO7WZ7FuGWuDhi3l
 HYPA==
X-Gm-Message-State: AOJu0YyPPo5xQaO66U9tQ2szPvXjlsFjx1oBYxX8HNbRlPCdEzuUSZJO
 pY2fjzHyGcDkfPQD6gthu0l860e4gGo=
X-Google-Smtp-Source: AGHT+IEbAsl2cKh2buIykEikjEtQPipi8i/xg4MPhzEXTR3olxlmg+aWF+rbXny7BxPKlwjNCD8c+w==
X-Received: by 2002:a05:622a:246:b0:415:14bb:5632 with SMTP id
 c6-20020a05622a024600b0041514bb5632mr11242282qtx.28.1696694156440; 
 Sat, 07 Oct 2023 08:55:56 -0700 (PDT)
Received: from Dell-Inspiron-15.. ([2601:18c:8002:3d40:7920:e10c:26cf:ff86])
 by smtp.gmail.com with ESMTPSA id
 kb4-20020a05622a448400b00415268abe26sm2154298qtb.8.2023.10.07.08.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 08:55:55 -0700 (PDT)
From: Ben Wolsieffer <benwolsieffer@gmail.com>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ben Wolsieffer <benwolsieffer@gmail.com>
Subject: [PATCH] arm: rpi: explicitly enumerate mmc boot targets
Date: Sat,  7 Oct 2023 11:55:35 -0400
Message-ID: <20231007155535.1699567-1-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Using the unqualified "mmc" boot target causes the Raspberry Pi 4 to
fail to boot. c771e5b explains this approach as follows:

> We don't need to specify the mmc devices individually, since they are
> used in order from 0 to 2, and standard boot uses that order anyway.

In practice, U-Boot first attempts to boot from the unconnected mmc1
interface, and, when this fails, moves on to attempt the USB and network
boot targets rather than trying mmc0.

This patch explicitly enumerates the mmc interfaces, causing each to be
attempted in turn. This matches what is done on other boards, and allows
the system to boot successfully.

Fixes: c771e5b8c2 ("arm: rpi: Switch to standard boot")
Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
---
 board/raspberrypi/rpi/rpi.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285ed..02210b97b5 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -74,4 +74,4 @@ pxefile_addr_r=0x02500000
 fdt_addr_r=0x02600000
 ramdisk_addr_r=0x02700000
 
-boot_targets=mmc usb pxe dhcp
+boot_targets=mmc0 mmc1 mmc2 usb pxe dhcp
-- 
2.42.0

