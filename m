Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE3AC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 16:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE82986BAC;
	Sat, 18 Nov 2023 17:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bedrocksystems.com header.i=@bedrocksystems.com header.b="QSKj1vt4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9603786BF7; Sat, 18 Nov 2023 17:41:53 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 328D286AB3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 17:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry@bedrocksystems.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6c431b91b2aso2765335b3a.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 08:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bedrocksystems.com; s=google; t=1700325706; x=1700930506; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iU4t1zBvAl07M7i62a2UxshdDsSxeltA3hn3+9XrfvQ=;
 b=QSKj1vt4n1ggg61AOk1LhHMYf9HUDKaj9PiGtejBO6Cno+R/gZYrYYaxogwOsjWDWC
 SEanQE0t6WaatdVdkCUJm35izSaFEsMBXucK23t6alFEYTn0btGieC9HOrwI2S2DIjMX
 y4BOBWoUClcbAMBH44GWj+t8kbTuOHO8lFpceR5xgZjlRt05wea2KqiCgxjXrnThlhRy
 X71fx6uN7EFrnhKvz++M8a1+sswJ6ULPEZxfDiJJ3zHLFKoJYKntqhi5C65GTsQgClBi
 dXOCeCCe3HTLdqGUqv/pj19sJUQ/djz5/AZG85J0J9BCZa84AQ1c8hoPQnKWrqhMbfRA
 Zqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700325706; x=1700930506;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iU4t1zBvAl07M7i62a2UxshdDsSxeltA3hn3+9XrfvQ=;
 b=dMiX+gRLspQu4s9NzWyaEt8M3jwNbRxynQYIskh3i8Ls6XSBQMvcgYj6tgcKL+DiKf
 b0FgYG2bLQIuii2bxDOKmSpGiVFPHiMOi8Tn4jM8CX3v0znxOss7JNuhURJKZ+TQokxl
 13deeY3hmWz5xh9C8WdAtCi9qCTwDkgsaLpxqeokZMbCuqQGubgeaoUHdWznPKSdRW43
 S2Ts/oKa/oQsTYrvM7C451m3zOd8EnekPQJx4rxDXiRAhsGcrMhGr3CtuIA1+imkZDHC
 N7z2LjVwPK8rSvGPBH4pZcJ5ehHBZ0Q+gqk93GCp/oj2Fc7ExSVFidEA17eCFqA5hgZz
 V6yg==
X-Gm-Message-State: AOJu0YwxC6X6DvV0a5GkwQOT+V/97ScUdQeOdbZ6A90jk8R2ar4vgFGG
 qbdi4AmKkOPNaCyzro1l+VRyNPXoS3hN/hx1QIh5pNvOvyhAm5VAZJTe0Q==
X-Google-Smtp-Source: AGHT+IE6ZLd9hQhoGoktGkt7zaSflRtFet1CzwrHH1nKdKvVmaAANL9P2AF6nD12xrgI8J80W7PIT8ZV5JY9NtZ5a0k=
X-Received: by 2002:a05:6a20:2d09:b0:186:7eaf:7176 with SMTP id
 g9-20020a056a202d0900b001867eaf7176mr3014274pzl.59.1700325706097; Sat, 18 Nov
 2023 08:41:46 -0800 (PST)
MIME-Version: 1.0
From: Dmitry Malkin <dmitry@bedrocksystems.com>
Date: Sat, 18 Nov 2023 17:41:34 +0100
Message-ID: <CAKRNjQ3iYXO5b3NBBwsuyCeZoexfRyA+CCNxKRMNR_EfJiCVPw@mail.gmail.com>
Subject: [RFC PATCH 0/2] rpi5: initial support
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 18 Nov 2023 17:42:48 +0100
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

I was not able to boot rpi5 with the latest master. I run into
dram_init() error:
> DRAM:  mbox: Timeout waiting for response
> bcm2835: Could not query ARM memory size

Apparently there is a new peripheral layout and ARMC MBOX has a
different offset within.

Turns out there is a compatible node "brcm,bcm2835-mbox" for all RPIs
(bcm238x/bcm271x).

After fixing this I got to the point where mmu_setup() was hanging
(looks like it was due to incorrect mapping). So I've added a
definition of first gigabyte of RAM and SOC range for bcm2712 into
rpi.c.

With those two patches and rpi_arm64_defconfig (with disabled
CONFIG_VIDEO_BCM2835) I'm able to get a working u-boot prompt (over
serial). FDT comes from firmware (EEPROM).

These patches are based on v2024.01-rc2 and tested with RPI5 8GB.

Known issues:
* CONFIG_VIDEO_BCM2835 doesn't work.
* MBOX get board revision (0x10002) doesn't work (the response status
is 0x8000_0001).


Dmitry Malkin (2):
  rpi5: add alternative way to get MBOX address via FDT node
  rpi5: add initial memory map for bcm2712

 arch/arm/mach-bcm283x/include/mach/base.h |  1 +
 arch/arm/mach-bcm283x/include/mach/mbox.h |  4 ++--
 arch/arm/mach-bcm283x/init.c              | 29 ++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.40.1
