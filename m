Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C21CCA0EE4
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 23:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AFD38331D;
	Mon, 18 Aug 2025 01:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="F8qnsx3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 975FF831B4; Mon, 18 Aug 2025 00:32:51 +0200 (CEST)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3202383164
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 00:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benho@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A44932C0330;
 Mon, 18 Aug 2025 10:32:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1755469960;
 bh=tEJlSMntU1M4xdjXcBsyr8+7hpbmetaYGqD/FN0ll/4=;
 h=From:To:Cc:Subject:Date:From;
 b=F8qnsx3e9bKQH9acwgZt1tObI4jp4xtVYMDyEbEFYwkoIBGDHLkn34BUYbOtq1uEu
 +QWErmE5jgWDcqTpCEnF3JbP/qg33cIlMRMJHxccg/pb4LimoNiOwlEjmI2wDEGtBD
 Es99PuqzC0Tjv/IO8POXVxzH3yJr7005ZO0QaRwz662+W4y1tVnUuoBsR+A+iduBHj
 AKGgcmaO6AU3u/y2Z3eIiUBo5/QRJw6cYHjO3GuaDoG8cNB8g+W2ytOGg/ZEj0yK4x
 1dydZs9MaL8gqSz/jvLs/Zd04HG62IVoJWURrAQHHyefEO7FO3sh20U7MJODQpcgK9
 NctJQSMKCTOYA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B68a258880000>; Mon, 18 Aug 2025 10:32:40 +1200
Received: from benho-dl.ws.atlnz.lc (benho-dl.ws.atlnz.lc [10.33.12.24])
 by pat.atlnz.lc (Postfix) with ESMTP id 7863C13ED5A;
 Mon, 18 Aug 2025 10:32:40 +1200 (NZST)
Received: by benho-dl.ws.atlnz.lc (Postfix, from userid 1884)
 id 71C8D12018F; Mon, 18 Aug 2025 10:32:40 +1200 (NZST)
From: Ben Hoelker <ben.hoelker@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ben Hoelker <ben.hoelker@alliedtelesis.co.nz>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Bruce Adams <bruce.adams@alliedtelesis.co.nz>,
 Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] drivers: rtc: max313xx: Add delay after setting date
Date: Mon, 18 Aug 2025 10:30:00 +1200
Message-ID: <20250818102959.1.I51da487efb143e03f6609e584f452e5aae1c9e9a@changeid>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=68a25888
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=2OwXVqhp2XgA:10 a=WrH3PWzr7MIHkpZmSIgA:9
 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Mailman-Approved-At: Mon, 18 Aug 2025 01:09:31 +0200
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

The MAX31331 was not correctly updating the seconds when
setting the time and would return the seconds previously set.

Like the MAX31343, a delay needs to be added after setting the
time. Wait one second after writing so that the date command shows the
correct time.

Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Bruce Adams <bruce.adams@alliedtelesis.co.nz>
Signed-off-by: Ben Hoelker <ben.hoelker@alliedtelesis.co.nz>
---

 drivers/rtc/max313xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/max313xx.c b/drivers/rtc/max313xx.c
index 2cb3f245041..f0d38b10c97 100644
--- a/drivers/rtc/max313xx.c
+++ b/drivers/rtc/max313xx.c
@@ -308,6 +308,7 @@ static int max313xx_set_time(struct udevice *dev, con=
st struct rtc_time *t)
 			return ret;
=20
 		break;
+	case ID_MAX31331:
 	case ID_MAX31343:
 		/* Time is not updated for 1 second after writing */
 		/* Sleep here so the date command shows the new time */
--=20
2.50.1

base-commit: 0c558bbad9e7581808b358091d1fd979f860e8ac
branch: master
