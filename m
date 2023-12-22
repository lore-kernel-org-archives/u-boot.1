Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1080CC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 18:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0271486E7E;
	Fri, 22 Dec 2023 19:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YUaZqRVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0471871DA; Fri, 22 Dec 2023 19:13:20 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14ECD81EC8
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 19:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703268797; x=1703873597; i=xypron.glpk@gmx.de;
 bh=t+Hw99GpbOaH+IqfjOh1J9m6jBli/YFy+9lUpSmkRSA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=YUaZqRVFIXy7aeEwZL6QhK/WLynLQ5WVSR3qYAgZdGs+13KSF/LxwjOTHwG423/s
 2fH3o6oBJGlCY6UQNs1eH652vVn9k3ZFj9nu+5OKfYzWWPa1p0tj8w6elpa4+74ef
 qZEROHhBxTiQ+6qylD+5kTvLMH5mSSvR70HSOjuMd3qIbJ3JA+2kgiocO5tSOR64A
 p610gHiS14orsPfaXknNBRIPr+HjBs0poiFy4H/FeAn0nNp6UPnlPDFTm0NH5rl85
 7StNLje8r6JPcOTLm1c2CUmgKvXbbcZ8GPBgIQ/SuPDWzfJyi2EE5s9ka+8uSwL0C
 4mvnKOGAoEDZGCImIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel3t-1qg29o0QwH-00alfP; Fri, 22
 Dec 2023 19:13:17 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] lib: smbios: verify_checksum() is duplicate
Date: Fri, 22 Dec 2023 19:12:50 +0100
Message-ID: <20231222181250.49764-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W7ySwvHTUe3RA6JqpzhJvX0abshU/lpLRZkQl9vpCQvl3e268tC
 eFdKT4y3PZ5FtQQCweeyVZRLCmHz+yAHX5M3hrhdmoFmcVTx3asvHkxGTdhu8btbvE0jRFa
 FE1HPT16XWmA2H2a43Z5MlTi7dGgELu5Lnoe8irISQCRHy0bbr1f3YJAzfhnyAe2IYVUU2I
 +6eck1SG6Mj2KKcLyKWVQ==
UI-OutboundReport: notjunk:1;M01:P0:/qaiXziFlzQ=;7c4uSDyJQsoikg+xhb5oi9hs6LF
 QsrIPqWHBcYk53+vRsi70eWUralvvm60/54f8eIjrL1hnbNJ8wfWE0Dclk/D2U2eeo4Dr81Ji
 KKRM7qfECc6fdN8rc6Vh3RbarOecHaiI2rcd1b/SBObZh5QzNBbJ0kneA6E5gbLCmAqOvsCn+
 /EQrXl9KYazOfcGTsBlWKIYwQVaqUjIYTNeMgHHWDMylWos8rvEjQ5c1tmYqzs06QJa6tq/Q2
 2qbxSYO+EfB7DUwQQusXc8YqvtAHjCxik36GtzqUTkOv5uY2wWxGS0XsAdgh+kl9mwaw2RQtt
 yRYlkaSNUxzzZJFvSFzteZSlA9tCtGLE/1lCPiaXcTLOyt5pxetDm0deDG0MR9JNKhYLcY4aY
 iYV0j4K8aD8UHsNZdUX6Ej7Lovk+RsifYFFIlIpO/Cndb3HFFgR/AzrDX9h15oF6fg2uFzkEt
 41ji9UkWbLV91HJRG2+x0UuvTNYByppRpPogCbHPdTVZv8Nb3EMM0FhKvhClWTzj9fw1/V9CP
 fVMdOPiDrTT4Y0O5aFlCi1r0V+fCq1YAuh0CTHuzvEMOnFukiM7JOIJ9T6380w5A/PLHH8eUF
 ZNIwAAjvxKB8Ulz/Nf64iLztNHItPkjT3LJKx4ycQr3o5RtxOesXuKknXPYz55zsJsfOmyBxq
 McAr4RWPjNIXmjAad8kvsugNBcDmwBiWzLAR3Zv46w2Ysgo2JpjXRTRET0+ys9GgaacQAji5c
 PMD9WV2ceyxmcWs7zFVn8HYHdvHE0xNv8YC2qapTxHgtAgy+mFPa0OOOsnBr63PwQ21MYM4Bg
 Je5fohks9a+89jHNiczXdUxOlS86vrLxqchzx9s5kTWJFp4nHc9124B2V9MG484Rj8IExggHF
 PV4B39s8AIPbtl0jEUL+OmzS+qpoWF5V9AWNB+ZRtd4N5RyesmRXhz1M+aSWz+IdBOxlYcjFt
 gX5EHw==
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

The function verify_checksum() duplicates what table_compute_checksum()
does. Replace it.

Fixes: 415eab0655a8 ("smbios: add parsing API")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 lib/smbios-parser.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
index f4de350e6e..a29a06398d 100644
=2D-- a/lib/smbios-parser.c
+++ b/lib/smbios-parser.c
@@ -5,23 +5,9 @@

 #define LOG_CATEGORY	LOGC_BOOT

+#include <tables_csum.h>
 #include <smbios.h>

-static inline int verify_checksum(const struct smbios_entry *e)
-{
-	/*
-	 * Checksums for SMBIOS tables are calculated to have a value, so that
-	 * the sum over all bytes yields zero (using unsigned 8 bit arithmetic).
-	 */
-	u8 *byte =3D (u8 *)e;
-	u8 sum =3D 0;
-
-	for (int i =3D 0; i < e->length; i++)
-		sum +=3D byte[i];
-
-	return sum;
-}
-
 const struct smbios_entry *smbios_entry(u64 address, u32 size)
 {
 	const struct smbios_entry *entry =3D (struct smbios_entry *)(uintptr_t)a=
ddress;
@@ -32,7 +18,7 @@ const struct smbios_entry *smbios_entry(u64 address, u32=
 size)
 	if (memcmp(entry->anchor, "_SM_", 4))
 		return NULL;

-	if (verify_checksum(entry))
+	if (table_compute_checksum(entry, entry->length))
 		return NULL;

 	return entry;
=2D-
2.43.0

