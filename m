Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6E9C0218D
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 04:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9267801CF;
	Mon, 20 Jan 2025 05:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hP0yRmTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38CA805CD; Mon, 20 Jan 2025 03:00:05 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56E35801CF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 03:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=markto@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1489A2C0526;
 Mon, 20 Jan 2025 14:59:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1737338398;
 bh=WqwNM3zKDP+/LjMbMRg+ZlTZLHvEEvxRRoZX7603/0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hP0yRmTUaykQDjZlDTqXtcjQGx/4hJlo75qmXjduHvGGPMkDYpHE+8ax+GyJ/8CEK
 SSIzYCIiCnxynNoake9YUyECe0Dr6e4Mg361oUGmXS1Y6TY31RcB7CN22WlysZJsdz
 FvWBaC8CzE4AzJK80mz+abFb+KN6evivtoxPf2nn8Fmbpg2mbuLDITdBELZWUk0faI
 K10Nv47x7uKyT1FXAM7QM4xa0h0y/+VkHveFtn8yGPslDNJSteBeih2E/crO4660/v
 +HZDVMZUfE9YyUVnc7ETk8KcegcuURqc3E8JxFcSbj+auWpLm96bbLQyV+YVgsraIe
 yLzATRZd3gEXg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B678dae1a0000>; Mon, 20 Jan 2025 14:59:54 +1300
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.13])
 by pat.atlnz.lc (Postfix) with ESMTP id C387213ED5A;
 Mon, 20 Jan 2025 14:59:54 +1300 (NZDT)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
 id C0DC340692; Mon, 20 Jan 2025 14:59:54 +1300 (NZDT)
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
 Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 2/2] drivers: rtc: max313xx: Ensure correct date is read after
 setting
Date: Mon, 20 Jan 2025 14:59:41 +1300
Message-ID: <20250120015941.1849667-2-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120015941.1849667-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20250120015941.1849667-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678dae1a
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VdSt8ZQiCzkA:10 a=pGLkceISAAAA:8
 a=Jxd5qKfyCZB0xRE8Qc4A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Mailman-Approved-At: Mon, 20 Jan 2025 05:15:32 +0100
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

When setting the time on the MAX31343, the time is not updated
for one second, and reading the time in this interval will give
the old time. Wait one second after writing so that the date
command will show the correct time when setting the clock.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: Chris Packham <judge.packham@gmail.com>
---
 drivers/rtc/max313xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/max313xx.c b/drivers/rtc/max313xx.c
index ccfd6b6d0e2..2cb3f245041 100644
--- a/drivers/rtc/max313xx.c
+++ b/drivers/rtc/max313xx.c
@@ -307,6 +307,11 @@ static int max313xx_set_time(struct udevice *dev, co=
nst struct rtc_time *t)
 		if (ret)
 			return ret;
=20
+		break;
+	case ID_MAX31343:
+		/* Time is not updated for 1 second after writing */
+		/* Sleep here so the date command shows the new time */
+		mdelay(1000);
 		break;
 	default:
 		break;
--=20
2.48.1

