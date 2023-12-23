Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19E9C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 01:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD76D869F7;
	Sat, 23 Dec 2023 02:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Jgwt6TrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50094871CE; Sat, 23 Dec 2023 02:17:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B1EA8646E
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 02:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703294259; x=1703899059; i=xypron.glpk@gmx.de;
 bh=fIvdugPPYSt4tc4P1EeBsPEbmDhWVZoEo26UMkrDgTs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Jgwt6TrY0AilYKYBPryFfvdOUZWSO5mtaz4gOj4PvUZ83VxdlKGisQjPqt9CLBFn
 E9V0/ErLts/LGyAj2XbJnX6K/76uAsh6D8+yDPaTNt4Z1yE8gaewQ/myFmttU+XQq
 rFVnsvXVhtY7QuwOmQxLUfN4vFHxZ9/MiQ73VvpuAiQ8RZsKOmXRsXN4bqc/yiToQ
 7PmH/2EHAZMj/LJ/54Jiwzo6BIO03U16rohhrDkeJBoyahPq1yzry0hDbnidvkMu3
 SBcPqr8F4EBdDucsPlIuq7OmCfrYPgw3VC2/h5iqn3lFXCb/h5VNtuCGIvQ+/hXax
 YqV0E4pGDWL87Qkkjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwbz-1rS5yk1UFN-00BOSI; Sat, 23
 Dec 2023 02:17:39 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 1/1] lib: smbios: remove redundant next_header()
Date: Sat, 23 Dec 2023 02:17:33 +0100
Message-ID: <20231223011734.248809-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bFAdzbNyGtnOAqMB00Fmo33JqPkSlFErzJxxU5i4Ddgkfs/tmaD
 sgA1MuEq/Ri7nvDl7LeB8QOiRUcsiEhmP0wFf2y0D4TBr8O61Fd8Nyn7Cnv8LoFdwoywSeV
 8LMF7KZ3l1/wQzgqXwdbOk8BRFF23GxARFFLMfYyTt6rqaPN/lLzFzhJ/uSf+IfR68quTek
 pzKqrXdETgOwv6CiEAHXg==
UI-OutboundReport: notjunk:1;M01:P0:CnrocuSjmXk=;E4ZLJJjYp1C9huSj7Q4xuxhr253
 5gQuk/nj5JTafASU01LMbLPi8MEPimKrx/Kq1GIUcQr6F44p1H79kBQ+T51uDfnRtdH38TeX7
 /Vtw8X59qxEHm5Yp6XlvT0lBcyIEnMJzQk+x4WkWDIEzYhvAFLQidzAcJZcr/30hq4CptdIgz
 0wyKxV9STRUl1B1xEAS1IS6OMxH0otP4DNbOnzJgWkHOy1BiVvZ5VjO1gWrSibGZpm73YjRwF
 d46YkdfWk3hItm6HyIX+qGVlO+Hhr/LYrLVagjtwd+ae0aoinJEbH80FJtTCSxDwYqwqK7dc8
 LexDMrBKSUtzUdlJnG7GlikI3k8bN7exE+Buw62FIpFzhBs1nKgQNpa3Tp9altOWs13IT9qs7
 aJvGGoxTJwkhsi5TTOQge/kSWk5YOUZeiVrJVhOUmIPH/3RflB5OqKwIRwZpzmW1orUXGoZn9
 ApKWNvK4L9reTAmXbzPDVNIvPoxFjrVmWdPoG+eBwR/Y0I5tvxXEsHEg+j25ek0dORIrZ+Iwb
 0uqByNOxMlYJ5r7Jd0hHm9ivXdMDXafW3aqLbMedUOKAVM5NLGetVubQeEV5S0DoE6yybueBm
 fw1sy8fh5kPJ1/+Cx56b1Dd9bv7Sr5xSId4Z+c0iSv2DouPsCGhqX8rW+NRR08qqTVn9F1W2F
 qikH/k/3pi7N/0splMyV6cMzpA1tKicRP4R201TqcY4Egx82qeu2cSQqVI1N73K5QHW1k5/zA
 SdZG9ZTH3H/09cLDXhk3eGwz/690cFWmcKjzsntniEXvUNb+r56l1KiK4+spu61JglmWJZDYU
 WlvH3GZ4NR9a8oG0Mj8cMuh+1qo0ySo4Oen4a+qmPaBHfzJfHCKUWNhPkzsP60BgWIRQjU+EL
 h2OiQUTvmbzLu3ctpxJ/0V9V6fSoUwtp938kmomPjaydiPaSuzusawQlAtChFs6R57y0gyEbr
 +sRxpARixTlUwDnNZT24tL6f2V0=
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

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
=2D--
v2:
	remove Fixes tag as the code redundancy is not an actual bug
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

