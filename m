Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5006606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bMjMaN6u;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tycyDSA/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1BA4808FC;
	Thu, 22 Oct 2026 08:08:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 296iofu3hqgv; Thu, 22 Oct 2026 08:08:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB96E80987
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792656531;
	b=L1B3PagX7eVsxq7Dxv4dRE4pvaN9RJq7qr1u4ArVjPpiLWJK9lngMLOFrK0fxo24aCKv
	 D1wTaBCoqfZS0Wof/kZUX4jBpTkNB7Zinum/P1nyyoV5EwYa0sJmc+vQbcqZEKB6Nvtdg
	 vmDILHXTEnWQwe+g+clcX0SOpwhPkcwMb1Eb6gesKrg4dFcGxkWDyLU9Fiwpxm5DoACaO
	 XWUdqleR+z7nRori0dAf7p0hCW+looR+PAZAsHlX+4CsPR+3/5KZIck8J1IdRG481+NXb
	 uRqR7oKD5Ln7mm4SQA3epn/ydAtgvzsbOUS/FZby4IymPo6V+G2M/ARaGl8xwuwidtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792656531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=49N00v3gGp6ACUo1hUQ7KmBhX2IDgdQ5HtauwaOlUGQ=;
	b=Good96f9jOcNqhH3nD7ulpLU7K1hvnMwnOwBJu0mBoUN8AARxKrnsPeaKl6e7GTdpWX1
	 dZgmeXKTF0ussrDILSW4TP6ZoOpqZlR+MzKggxogXFIodpLiswd1QlsSw29G6MZE/XNHx
	 e7TRmztTBBhk5x48Vrra89OqoGCw+XvnvWIxquWUULlLXJYLUyiKJ++I12Kk0ZnyoNT+X
	 jx/CTihOQe33/g+jX+bwwRb98X+PT2dBiRoG8alpw1KNzj1HhCjLVq6FMNpo5Oc989zss
	 VaLbI3kQHBscA86f+pB5Oo/uM/mTqYaMek+G12ulDNy0VN+uUrAfvjVQ8GGQga6t9zQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="tycyDSA/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792656530;
	bh=49N00v3gGp6ACUo1hUQ7KmBhX2IDgdQ5HtauwaOlUGQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bMjMaN6uDx36S0XAApk9SvD/6Z5i51f0zL3KiRg9CTxW6TXKrnNv0ulKiwLJ3HmKP
	 a9zw3yDS2TJPAIKm8YiJm/jV9vNL/09BkzGIrpJK6Bd1ULp+zOAVDhUTnRhNpPaRd0
	 sFa4nOY06rsulr7V134WMZJ/TWUUL9lkkTVfvyFxgTnMXlYBOWfDQch2IaI0+0p2/W
	 QK9Deq4fhrC9etA/LUz9BGymjTkjmQVwLHJ1Q+rK7jWEB3SmWU5RCLlpP9Kpyle7ey
	 SIr5yTK+1oBUfkE1PmOKmc7j2E+XqCOq4BkGrCwxM1/AM69zUe4oGeZ4+/wCVuuBed
	 03bfcHe3Ie/kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB96E80987;
	Thu, 22 Oct 2026 08:08:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF7A7769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C19E680849
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aIBb9kigxI1I for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:08:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 34D3A8085A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792656528;
 b=mBzVwt6dPGiVgBNx0VmUs21tefR5XfZ2Ej+lQgh/xSJ13RpQxF8aAWupguOKaOsAJNRI
 zfN7UzIFr17+LzTsdldLbQ+mFZJRDq/3y8oha0OUy/A0RQdEP6TwIBeiG2jUkVqNWUi0w
 z0yej+GoJJLndE8siyKNjecw6e8MWr3Ao9MeeT6MVjIKsjWIQ0NKtwB7GJYmqLA43nfz2
 OAfco4hYyaxQpnNQx3yST/L5Xzca1i1iIZ+26JQn90b2g8Vo2dhh4MqXsfHXU57OvlziS
 foaacbyktfLrRlI/CRqY7ZK7Hi0+W+2KCfaJpwhqYPMlZA+ThBOLcKingSZqZss3fyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792656528;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
 bh=49N00v3gGp6ACUo1hUQ7KmBhX2IDgdQ5HtauwaOlUGQ=;
 b=r4TO/mCIrMrcFWNRyofkIpPza5Vc5/nMK0oEMNibINN2RkJflrR32v6vM0Y8LIFL2pBT
 Yw/afArGi/KkVVbkBiUgXoH7+WHgA/7gvMtgo/lb6owaJ8zBwcLyhPxIvfBdyJMmO8bqR
 1903FgFPS4vct6nTNWZwJKRrCbZv/PwWpjjgf2Qyu73Y8g0xLjPt9LmHqbojfQoGKiTMO
 Rd5WgZEE0jZ5zs++ak6F/ZNO3Iv6cKP7XS3Rr5ksVJJoK4TD4AEjIDnqL9nseESdQRRLE
 IOL42fFiV7a4D5YnvC74d7JO51OYAArJr5AWWaH5oogF0ECKLU23B4WKTi7cNGrxinA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="tycyDSA/"; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=tycyDSA/
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34D3A8085A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:08:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 838F04E412A9;
 Thu, 22 Oct 2026 08:08:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4005E60360;
 Thu, 22 Oct 2026 08:08:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E877B10328D8B; 
 Thu, 22 Oct 2026 10:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792656523; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=49N00v3gGp6ACUo1hUQ7KmBhX2IDgdQ5HtauwaOlUGQ=;
 b=tycyDSA/CZpytc8N2WDePO34xGl94gdhPInc+ZW+m3PrQ/alBA77iEiDqxWE+bEENVwwsn
 6JvPV9Tl66eKFXV7Sx7vi2AKMp7F35XgRecMl0X0akd9uJa0DZpCPZypQu0fJf24CDvbmF
 Fvak8qBdTZs9xft9NoVGHyhNBGjAQxvQGBmIXTj9EVOjQnNczUcGrqOuUhXMqzYsoFz1Ld
 miOWkFsTmR4PYuF8Dg/ps7EuQYUGWcwCrgYp0LpILdEVLNN3gwpdgVTe4Zsj4ETn3FIUJr
 D1bngmJr4GVjHFCgPlxizghKU+G31DO9uapL7IgHMWmhue83KZpjscHizBHUxg==
From: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Subject: [PATCH] Introduce Synaptics SL2619 SoC and RDK board support
Date: Thu, 22 Oct 2026 10:08:22 +0200
Message-Id: <20261022-sl2619_base-v1-0-ef20cc43d78b@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbE2WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNT3eIcIMMyPimxOFXXyCwpNTHVOM3cMjlRCaijoCg1LbMCbFp0LIR
 fXJqUlZpcAjJCqbYWAKhEWMJvAAAA
X-Change-ID: 20261005-sl2619_base-26beae3f79ca
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Terry Zhou <terryzhou05@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marex@nabladev.com>, Siu Ming Tong <smtong@axiado.com>, 
 Johan Jonker <jbx6244@gmail.com>, Chris Packham <judge.packham@gmail.com>, 
 Adam Ford <aford173@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.16.1-dev-53874
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit adds initial support for the Synaptics SL2619 SoC, part of
the Astra SL2610 product line.

The bindings and DTS have been sent on the LKML by Jisheng Zhang:
https://lore.kernel.org/lkml/20260929061417.20733-1-jszhang@kernel.org/
But not merged yet.

For this early support, we have:
- DRAM declaration
- CPU reset via PSCI
- Generic ARMv8 core timer
- UART

Note: checkpatch complains "WARNING: Use the livetree API" in file
arch/arm/mach-synaptics/cpu.c
But there's no livetree equivalent for fdtdec_setup_mem_size_base() and
fdtdec_setup_memory_banksize()

---
Richard Genoud (Synaptics) (1):
      arm: synaptics: add SL2619 SoC and RDK board support

 MAINTAINERS                                      |  11 ++
 arch/arm/Kconfig                                 |  12 ++
 arch/arm/Makefile                                |   1 +
 arch/arm/dts/sl2619-rdk-u-boot.dtsi              |   5 +
 arch/arm/mach-synaptics/Kconfig                  |  36 +++++
 arch/arm/mach-synaptics/Makefile                 |   5 +
 arch/arm/mach-synaptics/cpu.c                    |  45 ++++++
 board/synaptics/sl2619/Kconfig                   |   9 ++
 board/synaptics/sl2619/Makefile                  |   5 +
 board/synaptics/sl2619/sl2619.c                  |  73 ++++++++++
 configs/synaptics_sl2619_defconfig               |  54 +++++++
 doc/board/index.rst                              |   1 +
 doc/board/synaptics/img/sl2610_boot_sequence.svg | 178 +++++++++++++++++++++++
 doc/board/synaptics/index.rst                    |   9 ++
 doc/board/synaptics/sl2619.rst                   | 100 +++++++++++++
 include/configs/synaptics_sl2619.h               |  14 ++
 16 files changed, 558 insertions(+)
---
base-commit: 544c9882c257ffd773b2ca46dff0d4174a7241d9
change-id: 20261005-sl2619_base-26beae3f79ca

Best regards,
--  
Richard Genoud (Synaptics) <richard.genoud@bootlin.com>

