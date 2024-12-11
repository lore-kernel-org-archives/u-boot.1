Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8055FE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E642A801F5;
	Thu, 12 Dec 2024 14:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=rwahl@gmx.de header.b="kVqGCSHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31022801E7; Wed, 11 Dec 2024 21:52:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA96280087
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 21:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rwahl@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733950329; x=1734555129; i=rwahl@gmx.de;
 bh=hD+cxhuHtytBFh8YeNXMzjUd5LnFTtZDIf5nrZFhwrg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=kVqGCSHHwFkCqxi9e6VV9cTpAAqwLAffEZryrxnWjlc+VwLE/eGGDDVy26RoSXoB
 AOqAeUkGVbAnLm1ymm0wzm9EQ8ApMtY82R9j0JhhtG4hkVKFIylxsDJDELNAtEROB
 kS6G2Ov01V+y+YCdIR7psdXQoc8wE06vEt8ZmyUBUe274lV/G2Mho6zEN2nEZvCV1
 sD7T1EiL9y3WSkp/oq+e9R6kqYyYh1YrbLq09u02RVXZgtbZdViuD4Qw6GgCb3LDy
 56jOe1XUKN4093J009S6TKDivF3CfoEi8zPOaM/hK1XZePmPUjB8iTX7vZVE8Lf+Z
 ShSItGcJmds4fyKC5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.157.89]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfUe-1tS2Bl3Laq-0028IS; Wed, 11
 Dec 2024 21:52:09 +0100
From: Ronald Wahl <rwahl@gmx.de>
To: u-boot@lists.denx.de
Cc: Ronald Wahl <ronald.wahl@legrand.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: Fix potential timer value truncation
Date: Wed, 11 Dec 2024 21:52:00 +0100
Message-ID: <20241211205200.16207-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AkQMMoVIXRro1vB/rHiZiKJLv7jEvi0kzlJOV0JXf8NshX9KdTt
 sgHlCfLOS4/RjBeqLObh+CKaIm7aiQy6/ORaj0yDLtO0n0N/N/uOATdmVJFtnvN44E0L9xN
 MZPU/k5s2bHNCULxSy2fBt5iy5Tr86mN0EbhQrTuvStBmTLnwYtw/wtZd3xQJe2jmUAU1S6
 n7SrCZ6I2aa/pBpXYJaSg==
UI-OutboundReport: notjunk:1;M01:P0:clcvgi0k3Xc=;2T2GFK+9wBhVuajMg5br0XdFJM+
 oFNSlvvBt017oJ54Rq55XXRYb0a4b/YeccootfeAnhzAtkESLsYJBJG2uPe6ZOyPu+/5F5AX8
 j/kjfRU8T6DL8pvlGaZqgkfS69KTHNK5FbEDAl16pTrnl2sKhcKoGTyea6Ey7UWCUCEpYGUiN
 +mxqS0rslnajw+Oi9G90hmQQNWZHMM91B/aDTwnQXDf8NkbeJ+PgPdH223390clLM/Ua4zajW
 NpYRR/NoMab6medbfs7k+AU41lhs/8j7E9rt0fiVc4jDMbUyTMAUaOYCni0TOw2Jd4MP7dcIv
 cQfYkmRelWK6Uu/AeaX9NKupviN+owzbugmaIEd/36bYADxj2kltbrmaYN0eWljTKLG3pD2VO
 FURL4tJvIGcr7V0Oldx45Z3gX1FdlJ8NmZriICnfXHXcXCq8M3GbjqnkczWUaMllgXmH9iy4t
 dD4iI7lfl15V1Fc/ymVZhBspvmBjLK+fiGGCO48pHziQPqZCz3lXhmB14xdQSl9S+kwzFjqau
 PtjY70bBNluC0odgPAKH14viANBentv2tDaamnOjla/7kN8Y2hWAiEk8Uht+PanFIf05JgTeO
 3iaSm3qjvE1IZwEk3c1yXbaN3o8US4wilTz+jhLEZyn4vMMhDsq4TuqNH5V0SWFeKido8yjZc
 nn3L7ihQmZuag07qeWmJpif9zbS0R7tA3+tV/cZh9cxygFfT1acAdl874a598AlyefwxzQQQ2
 fmGZGPn5HgIzvrYaVRFxcoG2kBGa2XEIJc1HmstwWSpLqpWIQvoIxpqSVedEYXXlTPt1l0pxn
 vI4ScIJcb+rgulWTMLtqUTz1SKm4AOyOgChGGcR7ry43APKdTKRpjSWNYsj8JPTm+xxLkhjzn
 yQDkNWSZa6mkU0ntKnp9UqcSeBST2Y1x4+bIVMjoykR9wVNfTeYdla6wqKj+QTK8M6/auuMLp
 MFBsYR7VahNkT1xhR84mhAR4i5EcaA+gx5DoQtUIutTuzCkzOarLN1JZm1sK3xxQ73tL1VAF1
 cQxISwMGoOqE4cGDbCEJQJwvjtkuHnhwJFDdpN2rtuywHZcz2jdNWkhu2h8j1b7S8RFu1QKUe
 vgFqjsGlw=
X-Mailman-Approved-At: Thu, 12 Dec 2024 14:14:07 +0100
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

From: Ronald Wahl <ronald.wahl@legrand.com>

On 64bit systems the timer value might be truncated to a 32bit value
causing malfunctions. For example on ARM the timer might start from 0
again only after a cold reset. The 32bit overflow occurs after a bit
more than 49 days (1000 Hz counter) so booting after that time may lead
to a surprise because the board might become stuck requiring a cold
reset.

Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
=2D--
 drivers/mmc/mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index efe98354a0..799586891a 100644
=2D-- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -750,7 +750,7 @@ static int mmc_send_op_cond(struct mmc *mmc)
 {
 	int err, i;
 	int timeout =3D 1000;
-	uint start;
+	ulong start;

 	/* Some cards seem to need this */
 	mmc_go_idle(mmc);
@@ -844,7 +844,8 @@ int mmc_send_ext_csd(struct mmc *mmc, u8 *ext_csd)
 static int __mmc_switch(struct mmc *mmc, u8 set, u8 index, u8 value,
 			bool send_status)
 {
-	unsigned int status, start;
+	ulong start;
+	unsigned int status;
 	struct mmc_cmd cmd;
 	int timeout_ms =3D DEFAULT_CMD6_TIMEOUT_MS;
 	bool is_part_switch =3D (set =3D=3D EXT_CSD_CMD_SET_NORMAL) &&
=2D-
2.47.1

