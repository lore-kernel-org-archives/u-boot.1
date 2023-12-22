Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D97C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 17:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21A5F86E7E;
	Fri, 22 Dec 2023 18:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CGIMLhNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E13686FF7; Fri, 22 Dec 2023 18:54:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7AD380245
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 18:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703267655; x=1703872455; i=xypron.glpk@gmx.de;
 bh=wk6v0gEC4vIE5kdeftz6Suv7VPb6ZFlgnWVXFSogc0Y=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=CGIMLhNgLHytmQpH3E56uvoI2nF7+6MJVflb9UNjLGZdtvcSsPrpoHNg4JgWG8lk
 U+hQld+qgP7EWQwv2gO2Z4dYeeD2LnCKvATGJbc4rJWo3xmrOTFtLv81TT696KtTO
 jbEiCVrD39Qw50q12FvPysG726KmjQ9EG/S11aX+zFOTZXbAnDf5sVfptmfDCcWih
 kAxcUfW0h4jTvMURB/QolVlD6z4wzkRJXRISoKj3k8kZIwmImpQGeDiD0kdz6QzQ3
 cu4YLBtCfS3CL4Ux0F+Mo+zxDVqwAFzUKTTqBJ+S/PZn7TT/5yGRSCzDOd5abhXf6
 9kHay9vXJS1U7lyCuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1qtY4B1h8W-00nf9g; Fri, 22
 Dec 2023 18:54:15 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] lib: smbios: remove redundant next_header()
Date: Fri, 22 Dec 2023 18:54:03 +0100
Message-ID: <20231222175403.46629-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ei+r/yyaAi7OUJ+/4QUeAVm/K5H8MzYrwv6Hvk1JmEZZIZ9vLYp
 O5V3JJmODSyHFwnO3rDVpXcNHu3KatbRH0EbCwT9wFTtzSn56fO3/LkPjd0OJ4akZ+mxTpm
 1gtapiRjmc3J3P5np9hxSsXB7FTRx2D5f5Z1xYwNfu5c6Biz2VquHN4zqMvjnq6j3POYgSi
 5Gz1QE8AaEAzJubNcrAtw==
UI-OutboundReport: notjunk:1;M01:P0:zmAsKXijCH8=;Ms9zKFKaHoR+W81RJY9r0EOj1HN
 OwFd/iUG//USSj9PS/yqIbJM54CkSgd/2TwZOPUzvvBKd1KpxvMSGjqZclT8JjVCV9oPS9oh5
 2cHkpfDqbzgbqp/GyPuszz5+ERmfYsyhW0nVsa3zx/cu1NMu6XxG6BR+pSEwpjG/KDGZ9MhX+
 aSx5GPE7HhIkWnlXc7Rq0Fw4kdP5ckJQijA2mqsnHP2+Y6BNFuMLBKeGkZ+OHppeyadokRpbr
 L5fU9Lhb8tLFAp8uqG+gUi/RqsOCIod9DqpaogzoU25rvrAUfaJoNlr91FVu5Zzl3BmoDX5sq
 VlEVNRhGTEfGsgz1ElXfK7QX77wtzyE1Psq9zD/UuqMlF5UlmV61bVAIMzTo2GKm2vsSHxtaE
 Os2ag3HKUdPXPaGwAuPCIfqDrPiEnzIf0516B8OAXUN2qDiuBsVQfA9vpU4mE1T4hBYjDEg5A
 TqHtKAjKJp9FG73iiDrhxiG6hVi6JSiEzWB3BUtJLSswgFayt1SUFLCuD3w7Vjy/9gZhZp2xq
 3WDmNR2VqnUWesC8tzb+NgUaZg5gm42Jku4gNcqhDjDK7obA+cNqSYaUaUhvL89FvAYb3XYkK
 OmZWA2b0BMyBtL25krl3pQkfQ3SJOFB/gXTFgBxFUcu4+z6AGgqFPhWSCEwQhgslDcMZ6Xc34
 M09teBAQmrVQLRcud+VoAreY8qGhVuz0BmUXrgrEWwKQnU6qYjHp465m21iWcSyU+AzoVCIdK
 VgYimny3AzDXrHIc2eb+j293Nfm9eLzK9mRc5kmJxHMSSuTBzlAmA24/lzCkYiE1iwh78A26F
 gaMNns9kN58lJco1yjIywxzkoyUOnVJF43YVHdrByoe/1C7TQ90KbYaJEAcS8p6JtvKVvXXpL
 w23pjNsi0l61D6ghExIYvJTb/pwgkAYCeta63YZSfZrd0zEryi9Vwd7G7TJ0q7NbJ8MWNHbkN
 oaKmmReIMvXAQAQyPObLuOKjw9s=
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

next_header() and get_next_header() only differ in how the const attribute
is used. One function taking a const parameter and returning a non-const i=
s
good enough.

Fixes: 3d49ee8510d3 ("efi_loader: add SMBIOS table measurement")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 lib/smbios-parser.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
index b578c30840..f4de350e6e 100644
=2D-- a/lib/smbios-parser.c
+++ b/lib/smbios-parser.c
@@ -50,14 +50,7 @@ static u8 *find_next_header(u8 *pos)
 	return pos;
 }

-static struct smbios_header *get_next_header(struct smbios_header *curr)
-{
-	u8 *pos =3D ((u8 *)curr) + curr->length;
-
-	return (struct smbios_header *)find_next_header(pos);
-}
-
-static const struct smbios_header *next_header(const struct smbios_header=
 *curr)
+static struct smbios_header *get_next_header(const struct smbios_header *=
curr)
 {
 	u8 *pos =3D ((u8 *)curr) + curr->length;

@@ -73,7 +66,7 @@ const struct smbios_header *smbios_header(const struct s=
mbios_entry *entry, int
 		if (header->type =3D=3D type)
 			return header;

-		header =3D next_header(header);
+		header =3D get_next_header(header);
 	}

 	return NULL;
=2D-
2.43.0

