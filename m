Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8AECD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 04:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC0DB846B4;
	Tue,  5 May 2026 06:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="yDaFCFGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC259846DB; Tue,  5 May 2026 06:26:39 +0200 (CEST)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10DAB84669
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 06:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronand@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AFA8D2C025D;
 Tue,  5 May 2026 16:26:30 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1777955190;
 bh=YPiUGewfrbsbmTGEo7zNx55Xiquxddm306K1B/bJsoU=;
 h=From:To:Cc:Subject:Date:From;
 b=yDaFCFGSFYqKYuRE+JnIasynTJs16YAi3nau3O7I6sMSQ1SMguubM1/vI/H+e1CU+
 p6FP/ktMb1YA15dsTRpp20yU6gYKn7CCP7PEtcP9RVQN6TsLJVPlxQQrEmMiNg9DWR
 fKhCcIhn8LHsCVHgvgISxXe9FkK1L8lR70IWRRwOVO8vRzHxUYpbu38vhHdwcJsTrH
 hT9RDqBdiXYxb7cjDZnC+PBMKhJc0t1LzHTIumBXsx1PY6Ou2jIdSYnVSMgieob6ga
 Tf8vrIzUKARNudw0OH6t2i88Ct1mCQN3FwVzPw/qdNNGQDqPzNj3N1DVkJUH1DUMM9
 zlAfVc3wazfiA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B69f971760000>; Tue, 05 May 2026 16:26:30 +1200
Received: from ronand-dl.ws.atlnz.lc (ronand-dl.ws.atlnz.lc [10.33.12.18])
 by pat.atlnz.lc (Postfix) with ESMTP id 83C0513ED0C;
 Tue,  5 May 2026 16:26:30 +1200 (NZST)
Received: by ronand-dl.ws.atlnz.lc (Postfix, from userid 1930)
 id 7D66584004F; Tue,  5 May 2026 16:26:30 +1200 (NZST)
From: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
To: u-boot@lists.denx.de
Cc: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] rtc: ds1307: Handle oscillator stop flag set on ds1339 chip
Date: Tue,  5 May 2026 16:25:31 +1200
Message-ID: <20260505042530.2965678-2-ronan.dalton@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=FPe4xPos c=1 sm=1 tr=0 ts=69f97176
 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=NGcC8JguVDcA:10 a=k-42gJp3AAAA:8
 a=cm27Pg_UAAAA:8 a=m8ToADvmAAAA:8 a=g6lymH9UxfwadTNmj18A:9 a=3ZKOabzyN94A:10
 a=uCSXFHLys93vLW5PjgO_:22 a=kCrBFHLFDAq2jDEeoMj9:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
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

Currently the oscillator stop flag (OSF) bit is never checked or cleared
on the DS1339 RTC chip.

On getting the time from the RTC, check if the OSF bit is set, log a
warning, and clear the flag. This matches the behavior of the DS1337
chip.

Note that the `date` command always reads from the RTC even when
setting or resetting the date, so the OSF flag is cleared in those cases
as well.

Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/rtc/ds1307.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/ds1307.c b/drivers/rtc/ds1307.c
index 34d8f8c5276..4176ab3701e 100644
--- a/drivers/rtc/ds1307.c
+++ b/drivers/rtc/ds1307.c
@@ -116,9 +116,9 @@ static int ds1307_rtc_get(struct udevice *dev, struct=
 rtc_time *tm)
 	if (ret < 0)
 		return ret;
=20
-	if (type =3D=3D ds_1337 || type =3D=3D ds_1340) {
-		uint reg =3D (type =3D=3D ds_1337) ? DS1337_STAT_REG_ADDR :
-					       DS1340_STAT_REG_ADDR;
+	if (type =3D=3D ds_1337 || type =3D=3D ds_1339 || type =3D=3D ds_1340) =
{
+		uint reg =3D (type =3D=3D ds_1340) ? DS1340_STAT_REG_ADDR :
+					       DS1337_STAT_REG_ADDR;
 		int status =3D dm_i2c_reg_read(dev, reg);
=20
 		if (status >=3D 0 && (status & RTC_STAT_BIT_OSF)) {
--=20
2.53.0

