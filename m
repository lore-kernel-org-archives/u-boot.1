Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25981C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 08:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3468871F;
	Fri, 12 Jul 2024 10:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AC48874E; Fri, 12 Jul 2024 10:25:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20538885F5
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 10:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id EE0A461966A1;
 Fri, 12 Jul 2024 10:24:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id EwflJr8v1w8L; Fri, 12 Jul 2024 10:24:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id A765C61966A3;
 Fri, 12 Jul 2024 10:24:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id JIvGgrQsGQSu; Fri, 12 Jul 2024 10:24:58 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 6480C61966A1;
 Fri, 12 Jul 2024 10:24:58 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, sjg@chromium.org,
 christian.taedcke@weidmueller.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH] fat: fat2rtc: Sanitize timestamps
Date: Fri, 12 Jul 2024 10:24:54 +0200
Message-Id: <20240712082454.8752-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Make sure that tm_mday and tm_mon are within the expected
range. Upper layers such as rtc_calc_weekday() will use
them as lookup keys for arrays and this can cause out of
bounds memory accesses.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/fat/fat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 2dd9d4e72d..f9096e8932 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -1253,8 +1253,9 @@ out:
  */
 static void __maybe_unused fat2rtc(u16 date, u16 time, struct rtc_time *=
tm)
 {
-	tm->tm_mday =3D date & 0x1f;
-	tm->tm_mon =3D (date & 0x1e0) >> 5;
+	tm->tm_mday =3D max(1, date & 0x1f);
+	tm->tm_mon =3D clamp((date & 0x1e0) >> 5, 1, 12);
+
 	tm->tm_year =3D (date >> 9) + 1980;
=20
 	tm->tm_sec =3D (time & 0x1f) << 1;
--=20
2.35.3

