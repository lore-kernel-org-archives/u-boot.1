Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDA1C0218D
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 04:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216AD805E9;
	Mon, 20 Jan 2025 05:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="HjdED+9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F6D801CF; Mon, 20 Jan 2025 03:00:06 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C645580085
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 02:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=markto@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CDF1C2C0452;
 Mon, 20 Jan 2025 14:59:54 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1737338394;
 bh=+wbVzB8JH7nYJrdnuZ0BLaoD+oV+i8Tjq4Xf+X7oMwA=;
 h=From:To:Cc:Subject:Date:From;
 b=HjdED+9+tPnWC+OAMCJa/CKOlvTuL3TdP2M3rPkn1hWSYNhytpa8YD51ITeqoABpg
 y651ppT2p+6/WHFwjxodi25PHVbqZyAAt7D9VsNtSrBjW0VaLp4PU2kfNPp2xvETO1
 flJuqn8VvlhRyXF5VSEIn8gaHGTy3yBfILNNiq0h6csIIveLTKngLk04xFpuD3bBFa
 TBZAhHm8E8rMSIVtEuz7b0jjT0HpUzYuZKD5mXn0bSToQVuDxPtNu6/8DheGjBN2gY
 IkgdMI1FhUBZDdC33rOzBc6+2KXNe6Oz0xBA8OsP3HTGT0mycPfuxQ5gqzJO4/9xEM
 P+rmQq5H8XKOQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B678dae180000>; Mon, 20 Jan 2025 14:59:52 +1300
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.13])
 by pat.atlnz.lc (Postfix) with ESMTP id 99E3213ED5A;
 Mon, 20 Jan 2025 14:59:52 +1300 (NZDT)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
 id 95BB340692; Mon, 20 Jan 2025 14:59:52 +1300 (NZDT)
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
 Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 1/2] drivers: rtc: max313xx: Fix setting years 2100-2199
Date: Mon, 20 Jan 2025 14:59:40 +1300
Message-ID: <20250120015941.1849667-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678dae19
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VdSt8ZQiCzkA:10 a=pGLkceISAAAA:8
 a=KrAw7-y3ozQjNz5qqmQA:9 a=3ZKOabzyN94A:10
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

An invalid calculation made setting years 2100-2199 impossible.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: Chris Packham <judge.packham@gmail.com>
---
 drivers/rtc/max313xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/max313xx.c b/drivers/rtc/max313xx.c
index 60400235dd0..ccfd6b6d0e2 100644
--- a/drivers/rtc/max313xx.c
+++ b/drivers/rtc/max313xx.c
@@ -285,7 +285,7 @@ static int max313xx_set_time(struct udevice *dev, con=
st struct rtc_time *t)
 	regs[5] =3D bin2bcd(t->tm_mon);
 	regs[6] =3D bin2bcd((t->tm_year - 2000) % 100);
=20
-	if ((t->tm_year - 2000) >=3D 200)
+	if (t->tm_year >=3D 2100)
 		regs[5] |=3D FIELD_PREP(MAX313XX_MONTH_CENTURY, 1);
=20
 	ret =3D dm_i2c_write(dev, rtc->chip->sec_reg, regs, 7);
--=20
2.48.1

