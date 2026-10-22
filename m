Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135E606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aA/vJd7t;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aMxNeDC6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D46FC6079B;
	Thu, 22 Oct 2026 19:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1X-uXlpXLUjb; Thu, 22 Oct 2026 19:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 668F1606C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695757;
	b=SG/55ygpgdIiKI2X+WgzZWY6zzw4+dGiDZWO2YqudDqXYit4jlZ3thB4AcBn3vf7EfZa
	 bGTRv6HEhb7enXuzokoH6z96VluuIzkMRMNLjRcT0XPnDBxyLFRbEcdUybg8V8X1FQi8H
	 MoTauO6kqco7zQyXFP5f0qFy5Naz0JtA10H/lk2qY2F/MNopgCl9u79SY7Uh/eJeet9GS
	 e9a5odro/XlRAFgDWZJixqLTX9Ce0ue6XnJhdBXqSpWD8QYUKPYMQ+CltD+Wgh5eGNvpS
	 HcQiHKPp3IXwiLOKrPRDV3y5GbrxKRuKpjVVJ8mCKcCumLHRgOyxYwRmBLhvvvLe2mA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695757;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vSdJdx4UffVSHiioCOAzmiUVv3VbHBb1KdT2hnE7JPs=;
	b=h147emiHVY6nAp1VY2ZGI7UsaVx9iRStGJLatCeobKzSOgdjBho9Rky0eqdZbt1MKP8D
	 0yL8dceD07GPUyCXp38TZiVyreSwqTK5O6/+dK2ZMtnnVfT0WkehO6ZmN9OQlyN4lK9e0
	 TnjL2zFqJp/crF3PaFwEDzVs0V4hwpS7rK29C76hHrQHbl+whQI9/4Ukj7TWY2B3kVNjV
	 /d2VTMZ6TIY6L43BqC9pdYS3tN2vu9viaXfO0KpucWUauD6tKAuUtIBtTYtFOfROu94oy
	 yjhU14yC2Ml+WB3DV6fBFnvYm17C00lrde17x4mDtAF+4OgkwlkGgoiazXa3kY4RtIQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aMxNeDC6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695757;
	bh=vSdJdx4UffVSHiioCOAzmiUVv3VbHBb1KdT2hnE7JPs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aA/vJd7trW0jHXElPtZMR6mlKhosW6vlno6gL/6p6g+2LaktpMGpP9MGLeUF5EVwT
	 gfAAzocftXPjmkdzkQ0FbDEOgCm3uWtinrY2T0Gp9rgfS5Ed5msH5uYkrASzA1QSX9
	 XEYiz3kDa2cWVxXzBjs0ikL7LnuVvh1cPj3PzYVyB2m8Hv+wnxreBmDALC0MvEtIxq
	 srg5ViY4oaEX8vdVAtHbizkl4qwxgEmagkwKldeOaJCcxqxgePjUiX35B0tkUwmTnU
	 sNDXqXvKvMQV2Y48Jl78FuRnVbKL+qtlfRhaTv/O8nr3axy5a/s8nz36n1Lsz3rH9Y
	 5eObXWV5+6EdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 668F1606C4;
	Thu, 22 Oct 2026 19:02:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB33E3C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A125D6068B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PaPLQ8VU0u_9 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0AEAA606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695752;
 b=M34/2n3Cs0TjJ0WqOYlSmMZT4sHC4pTPIrGl/XvriunqfMKPT6pNMrZmOH6xMYtKFnC5
 isrPuPPG3NxYixDt5LO5aE/7dbt3GlOZwD3mF69E+JG032m/Chp9w8OJy5RoEvBxSIA6H
 BKzwdp4F32xAdnfqMmqFvkCnHaEmhmEvHf8UI3wNQ2jfc9f6SevgB7s7KbzdsweGuYEto
 RNjKABPNYGRmdu/SYHIpz4PMyQ+qxlD3myGiDABDkdMgtCIFHCxyp5f78AK12eWA2XkwB
 Wq9KLTGi+Rgp3uu4l3N7vc0owPPAMaQddSxemV9qHBgA4Us+mh6R8VXzY0roQOD5wfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695752;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=vSdJdx4UffVSHiioCOAzmiUVv3VbHBb1KdT2hnE7JPs=;
 b=Wv+sqRwWYojpGeCWEjTqAdvgB4wOStbG7io4ri76Zhe+NB6vhlAkUL8QzFHwc0v/b279
 Gn8KNqwxkFUOYS7COaCzKljr0DZg8YVsELQymR4XcLlDNm+KENk3bRFXmBQF/Ete4WM7O
 NAqnidXUaQUL5YS/J7CXzMSGTVu+KKBpi8e9nDPkoQ+0HrTB8Vmoz3RHuyHxwFw0z1dZT
 IZmk0BJ7VywClS4dFgM1AwpUlFYaX3QDwHJGInhHBVFQvUcSplbDO//Ql1IFupo7Hx7f9
 EEvegUySGZGK84u+f0eL44AgrGYNWg1hfRqs7K9+3PMRLoFglyLcpELvvtizwWum3sA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aMxNeDC6; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=aMxNeDC6
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AEAA606C4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:31 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so65319f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695750; x=1793300550;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vSdJdx4UffVSHiioCOAzmiUVv3VbHBb1KdT2hnE7JPs=;
 b=aMxNeDC6GWl2P66l094mPsm08uFojAicluzCafyXC1NhJvRiSQNj6/B6hyrAwxG3FS
 wXBUaIYxYW2x3T+sivrmlzDw3MwlTQutRc8w60nlaZjFar1q/LK9SPTTBNYXs6Ah2tw+
 tHJtOz860hN5Afx2e9MFXhx6miBIsHqQsnGM7bMBACvonLoHbRI6FVILxlUtjClpkuzh
 QkBEfv4xvbi8XhFVElwTEkz0oAxhX08P4pQ6WF5yO4PgJjtlLNqIfrvUJ7Mfxg1zsSpC
 nb05qeFUfuRoEJSrmoHBOsZY0m3UVMUXHHTBJzP35/smkm/TDVxebDDd3AOLMRNpgS75
 PuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695750; x=1793300550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vSdJdx4UffVSHiioCOAzmiUVv3VbHBb1KdT2hnE7JPs=;
 b=Pfb0JvZi+JPO/sNcWBB3bc0pTTtr2PFvHicuoycP+PCziAsygeH7eeT8hFQQKa0dsb
 /ochgOpUT4srJelrueyc2Vtky5MbtKNXTzjQV2y2GvHmiS6HmwZ+yea6+aNjDPR4IIzt
 bGXp2b9lsd1eKv6HF54SowcIbtumpwqL6BDjeENj39T8p6rWfSIGJ1BgehJ/hukae6e4
 Y+FXIfMFKeqphmf4vW+4xrTzE5gHTJJBM+w5V/erUVR2ybfbPs2yGH6zTqW5+IFcbSFu
 3CvywMRBjfvTpxHVgTxEll/3p0oULuJ9+b9PWcmib6fLIhV2FioWP5bGbhRUQyhKLka+
 xCLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLU0f5k2nSsp/T/BesI6CMg9tRe+KpdLBlSNkwQHaB4aqipnyHPaX0tlY5ZcZnnlWI1Baiqng=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK/pbMdw9/QHExBrK0ot4rUp7nEYE+c8wXlJX3OjYFgN6cYtCUX
 MTlAFpjWTwMDJHwtvinSBpBIX31ceZTYQzhBV7+hpDWUMB8FOYOvVr0v
X-Gm-Gg: AYBFou2yC6P7Z7vfENa7EZsGCLQKN2yWGvl9Id56faWNcMP4s+Hj7+Ub0LQr2FS3WmS
 /2WHbRR3xnnU8uM1uJq0w3IGWtkYbmw6dnbc0g7yDMer2g0NSFQEFpsYvbPHSsgtOtc+unh9TJl
 3hBPLNcjIfS5ENVzPxBjT782hC1se7d7JAAi0xFgpGVkfnMczLNdl8F13Wsk48HGxxdcTWaAtfa
 FPyNFypOZn/AVnKe5JZXxFbElZfiiRKAFprIPRxBbKv6IHInO/XSRj6TCUV7ooCoCMwce6Y2Du0
 SP/qYPZFcDsOF0QOp9qRSq6YmzyO1cJPaJL/XJ9SoGHO19LZVN7DMtX+MXnY0xdiXZlzGy4NigD
 gyhzjjvozlKW7Q/NdiaFbBy2UWwCl/SWNS3xnOz7oReMgI1S7M6xZfcsT7Np2LT+ZlVRq7cq2gy
 rU2gPcwepRNJTDV3L2AAB9PMqc/6z2dznDZFT0BzcG7fy58I30R9IYeMvy3s4usYvwNXCeeuLGL
 iL0jVD2ZD1Ak+Bnsv7JdZu0ump53t6BGO0ho5BGA42qXH7qCNEq8giL+NuHKODm/3o17oCAkCgh
 C0dRwu8T/sbuzrUmkoKOQoc235HFFKhbherlzNTiFFtDAVz4YOs0EBIwD2mK
X-Received: by 2002:a05:6000:2289:b0:48e:932:af01 with SMTP id
 ffacd0b85a97d-48e264b569dmr11536854f8f.31.1792695749291; 
 Thu, 22 Oct 2026 12:02:29 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 03/16] airoha: add support for Airoha AN7583 SoC
Date: Thu, 22 Oct 2026 21:01:45 +0200
Message-ID: <20261022190206.666950-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for Airoha AN7583 SoC. This adds the Kconfig and Makefile
entry for the SoC, DTSI and initial config for it. Also add the code for
CPU and RAM initialization. Everything is mostly based on AN7581 that
share lots of common piece.

Acked-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583-evb.dts          |  67 +++++
 arch/arm/dts/an7583.dtsi             | 390 +++++++++++++++++++++++++++
 arch/arm/mach-airoha/Kconfig         |  14 +
 arch/arm/mach-airoha/Makefile        |   1 +
 arch/arm/mach-airoha/an7583/Makefile |   3 +
 arch/arm/mach-airoha/an7583/init.c   |  66 +++++
 board/airoha/an7583/MAINTAINERS      |   5 +
 board/airoha/an7583/Makefile         |   3 +
 board/airoha/an7583/an7583_rfb.c     |  16 ++
 configs/an7583_evb_defconfig         |  79 ++++++
 include/configs/an7583.h             |  19 ++
 11 files changed, 663 insertions(+)
 create mode 100644 arch/arm/dts/an7583-evb.dts
 create mode 100644 arch/arm/dts/an7583.dtsi
 create mode 100644 arch/arm/mach-airoha/an7583/Makefile
 create mode 100644 arch/arm/mach-airoha/an7583/init.c
 create mode 100644 board/airoha/an7583/MAINTAINERS
 create mode 100644 board/airoha/an7583/Makefile
 create mode 100644 board/airoha/an7583/an7583_rfb.c
 create mode 100644 configs/an7583_evb_defconfig
 create mode 100644 include/configs/an7583.h

diff --git a/arch/arm/dts/an7583-evb.dts b/arch/arm/dts/an7583-evb.dts
new file mode 100644
index 000000000000..d02cd194e8a3
--- /dev/null
+++ b/arch/arm/dts/an7583-evb.dts
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/dts-v1/;
+
+/* Bootloader installs ATF here */
+/memreserve/ 0x80000000 0x200000;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "an7583.dtsi"
+
+/ {
+	model = "Airoha AN7583 Evaluation Board";
+	compatible = "airoha,an7583-evb", "airoha,an7583", "airoha,en7583";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlycon";
+		stdout-path = "serial0:115200n8";
+		linux,usable-memory-range = <0x0 0x80200000 0x0 0x1fe00000>;
+	};
+
+	/* When running as a first-stage bootloader this isn't filled in automatically */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+};
+
+&an7583_pinctrl {
+	pcie0_rst_pins: pcie0-rst-pins {
+		conf {
+			pins = "pcie_reset0";
+			drive-open-drain = <1>;
+		};
+	};
+
+	pcie1_rst_pins: pcie1-rst-pins {
+		conf {
+			pins = "pcie_reset1";
+			drive-open-drain = <1>;
+		};
+	};
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_rst_pins>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_rst_pins>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&snfi {
+	status = "okay";
+};
diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
new file mode 100644
index 000000000000..dd7bf49dbbc3
--- /dev/null
+++ b/arch/arm/dts/an7583.dtsi
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/clock/an7583-clk.h>
+#include <dt-bindings/reset/airoha,an7583-reset.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		atf-reserved-memory@80000000 {
+			no-map;
+			reg = <0x0 0x80000000 0x0 0x40000>;
+		};
+
+		npu-binary@84000000 {
+			no-map;
+			reg = <0x0 0x84000000 0x0 0xa00000>;
+		};
+
+		npu-flag@84b0000 {
+			no-map;
+			reg = <0x0 0x84b00000 0x0 0x100000>;
+		};
+
+		npu-pkt@85000000 {
+			no-map;
+			reg = <0x0 0x85000000 0x0 0x1a00000>;
+		};
+
+		npu-phyaddr@86b00000 {
+			no-map;
+			reg = <0x0 0x86b00000 0x0 0x100000>;
+		};
+
+		npu-rxdesc@86d00000 {
+			no-map;
+			reg = <0x0 0x86d00000 0x0 0x100000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-level = <2>;
+			cache-unified;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@9000000 {
+			compatible = "arm,gic-v3";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0x09000000 0x0 0x20000>,
+			      <0x0 0x09080000 0x0 0x80000>,
+			      <0x0 0x09400000 0x0 0x2000>,
+			      <0x0 0x09500000 0x0 0x2000>,
+			      <0x0 0x09600000 0x0 0x20000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+
+		syscon@1fa20000 {
+			compatible = "airoha,en7581-chip-scu", "syscon";
+			reg = <0x0 0x1fa20000 0x0 0x388>;
+		};
+
+		syscon@1fbe3400 {
+			compatible = "airoha,en7581-pbus-csr", "syscon";
+			reg = <0x0 0x1fbe3400 0x0 0xff>;
+		};
+
+		scuclk: system-controller@1fb00000 {
+			compatible = "airoha,an7583-scu", "simple-mfd";
+			reg = <0x0 0x1fb00000 0x0 0x970>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			mdio_0: mdio-bus@c8 {
+				compatible = "airoha,an7583-mdio";
+				reg = <0xc8>;
+
+				clocks = <&scuclk AN7583_CLK_MDIO0>;
+				resets = <&scuclk AN7583_MDIO0>;
+			};
+
+			mdio_1: mdio-bus@cc {
+				compatible = "airoha,an7583-mdio";
+				reg = <0xcc>;
+
+				clocks = <&scuclk AN7583_CLK_MDIO1>;
+				resets = <&scuclk AN7583_MDIO1>;
+			};
+		};
+
+		system-controller@1fbf0200 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0x1fbf0200 0x0 0xc0>;
+
+			an7583_pinctrl: pinctrl {
+				compatible = "airoha,an7583-pinctrl";
+
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
+
+		i2cclock: i2cclock@0 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+
+			/* 20 MHz */
+			clock-frequency = <20000000>;
+		};
+
+		i2c0: i2c0@1fbf8000 {
+			compatible = "mediatek,mt7621-i2c";
+			reg = <0x0 0x1fbf8000 0x0 0x100>;
+
+			clocks = <&i2cclock>;
+
+			/* 100 kHz */
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disable";
+		};
+
+		i2c1: i2c1@1fbf8100 {
+			compatible = "mediatek,mt7621-i2c";
+			reg = <0x0 0x1fbf8100 0x0 0x100>;
+
+			clocks = <&i2cclock>;
+
+			/* 100 kHz */
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disable";
+		};
+
+		snfi: spi@1fa10000 {
+			compatible = "airoha,en7581-snand";
+			reg = <0x0 0x1fa10000 0x0 0x140>,
+			      <0x0 0x1fa11000 0x0 0x600>;
+
+			clocks = <&scuclk EN7523_CLK_SPI>;
+			clock-names = "spi";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			spi_nand: nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				spi-tx-bus-width = <1>;
+				spi-rx-bus-width = <2>;
+			};
+		};
+
+		uart1: serial@1fbf0000 {
+			compatible = "ns16550";
+			reg = <0x0 0x1fbf0000 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <1843200>;
+			bootph-all;
+		};
+
+		uart2: serial@1fbf0300 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0300 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		hsuart3: serial@1fbe1000 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbe1000 0x0 0x40>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		uart4: serial@1fbf0600 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0600 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		uart5: serial@1fbf0700 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0700 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		pciephy: phy@1fa5a000 {
+			compatible = "airoha,en7581-pcie-phy";
+			reg = <0x0 0x1fa5a000 0x0 0xfff>,
+			      <0x0 0x1fa5b000 0x0 0xfff>,
+			      <0x0 0x1fa5c000 0x0 0xfff>,
+			      <0x0 0x1fc10044 0x0 0x4>,
+			      <0x0 0x1fc30044 0x0 0x4>,
+			      <0x0 0x1fc15030 0x0 0x104>;
+			reg-names = "csr-2l", "pma0", "pma1",
+				    "p0-xr-dtime", "p1-xr-dtime",
+				    "rx-aeq";
+			#phy-cells = <0>;
+		};
+
+		pcie0: pcie@1fc00000 {
+			compatible = "airoha,an7583-pcie";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			reg = <0x0 0x1fc20000 0x0 0x1670>;
+			reg-names = "pcie-mac";
+
+			clocks = <&scuclk EN7523_CLK_PCIE>;
+			clock-names = "sys-ck";
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+
+			ranges = <0x02000000 0 0x20000000 0x0 0x20000000 0 0x4000000>;
+
+			resets = <&scuclk AN7583_PCIE0_RST>,
+				 <&scuclk AN7583_PCIE1_RST>;
+			reset-names = "phy-lane0", "phy-lane1";
+
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+
+			status = "disabled";
+
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@1fc20000 {
+			compatible = "airoha,an7583-pcie";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			reg = <0x0 0x1fa92000 0x0 0x1670>;
+			reg-names = "pcie-mac";
+
+			clocks = <&scuclk EN7523_CLK_PCIE>;
+			clock-names = "sys-ck";
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+
+			ranges = <0x02000000 0 0x24000000 0x0 0x24000000 0 0x4000000>;
+
+			resets = <&scuclk AN7583_PCIE0_RST>,
+				 <&scuclk AN7583_PCIE1_RST>;
+			reset-names = "phy-lane0", "phy-lane1";
+
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+
+			status = "disabled";
+
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
index 4b0374001d0c..72cd14542086 100644
--- a/arch/arm/mach-airoha/Kconfig
+++ b/arch/arm/mach-airoha/Kconfig
@@ -29,19 +29,33 @@ config TARGET_AN7581
 	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
 	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
 
+config TARGET_AN7583
+	bool "Airoha AN7583 SoC"
+	select ARM64
+	help
+	  The Airoha AN7583 is a ARM-based SoC with a quad-core Cortex-A7
+	  including NEON and GPU, Mali-450 graphics, several DDR3 options,
+	  crypto engine, built-in Wi-Fi / Bluetooth combo chip, JPEG decoder,
+	  video interfaces supporting HDMI and MIPI, and video codec support.
+	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
+	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
+
 endchoice
 
 config SYS_SOC
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 config SYS_BOARD
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 config SYS_CONFIG_NAME
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 endif
 
diff --git a/arch/arm/mach-airoha/Makefile b/arch/arm/mach-airoha/Makefile
index 91395b8a8503..51d82ea3e217 100644
--- a/arch/arm/mach-airoha/Makefile
+++ b/arch/arm/mach-airoha/Makefile
@@ -4,3 +4,4 @@ obj-y	+= cpu.o
 
 obj-$(CONFIG_TARGET_EN7523) += en7523/
 obj-$(CONFIG_TARGET_AN7581) += an7581/
+obj-$(CONFIG_TARGET_AN7583) += an7583/
diff --git a/arch/arm/mach-airoha/an7583/Makefile b/arch/arm/mach-airoha/an7583/Makefile
new file mode 100644
index 000000000000..886ab7e4eb9f
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
diff --git a/arch/arm/mach-airoha/an7583/init.c b/arch/arm/mach-airoha/an7583/init.c
new file mode 100644
index 000000000000..18c5e101367a
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/init.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fdtdec.h>
+#include <init.h>
+#include <linux/sizes.h>
+#include <sysreset.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Airoha AN7583\n");
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	gd->dram[0].start = gd->ram_base;
+	gd->dram[0].size = get_effective_memsize();
+
+	if (gd->ram_size > SZ_2G) {
+		gd->dram[1].start = gd->ram_base + SZ_2G;
+		gd->dram[1].size = gd->ram_size - SZ_2G;
+	}
+
+	return 0;
+}
+
+void reset_cpu(void)
+{
+	psci_system_reset();
+}
+
+static struct mm_region an7583_mem_map[] = {
+	{
+		/* DDR, 32-bit area */
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		/* DDR, 64-bit area */
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = SZ_4G + SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+	}
+};
+struct mm_region *mem_map = an7583_mem_map;
diff --git a/board/airoha/an7583/MAINTAINERS b/board/airoha/an7583/MAINTAINERS
new file mode 100644
index 000000000000..baa5228a57eb
--- /dev/null
+++ b/board/airoha/an7583/MAINTAINERS
@@ -0,0 +1,5 @@
+AN7583
+M:	Christian Marangi <ansuelsmth@gmail.com>
+S:	Maintained
+N:	airoha
+N:	an7583
diff --git a/board/airoha/an7583/Makefile b/board/airoha/an7583/Makefile
new file mode 100644
index 000000000000..d582684d1f7f
--- /dev/null
+++ b/board/airoha/an7583/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y	+= an7583_rfb.o
diff --git a/board/airoha/an7583/an7583_rfb.c b/board/airoha/an7583/an7583_rfb.c
new file mode 100644
index 000000000000..aa73679d929e
--- /dev/null
+++ b/board/airoha/an7583/an7583_rfb.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	return 0;
+}
diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
new file mode 100644
index 000000000000..16466be51b27
--- /dev/null
+++ b/configs/an7583_evb_defconfig
@@ -0,0 +1,79 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AIROHA=y
+CONFIG_TARGET_AN7583=y
+CONFIG_TEXT_BASE=0x81E00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x7c000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="an7583-evb"
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_BUILD_TARGET="u-boot.bin"
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
+CONFIG_DEFAULT_FDT_FILE="an7583-evb"
+CONFIG_SYS_PBSIZE=1049
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_SYS_MAXARGS=8
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_BIND=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_LOG=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_DMA=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_AIROHA_ETH=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AIROHA_AN7583=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_RAM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_AIROHA_SNFI_SPI=y
+CONFIG_SHA512=y
diff --git a/include/configs/an7583.h b/include/configs/an7583.h
new file mode 100644
index 000000000000..c865afea1a2a
--- /dev/null
+++ b/include/configs/an7583.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration for Airoha AN7583
+ */
+
+#ifndef __AN7583_H
+#define __AN7583_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+#define CFG_SYS_INIT_RAM_ADDR           CONFIG_TEXT_BASE
+#define CFG_SYS_INIT_RAM_SIZE           SZ_2M
+
+/* DRAM */
+#define CFG_SYS_SDRAM_BASE		0x80000000
+
+#endif
-- 
2.55.0

