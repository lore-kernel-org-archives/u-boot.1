Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E022DE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 14:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BD7980104;
	Mon, 16 Dec 2024 15:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="g2rlnWXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6649580141; Mon, 16 Dec 2024 15:59:04 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A4728003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 15:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chf.fritz@googlemail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso18573695e9.0
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 06:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1734361142; x=1734965942; darn=lists.denx.de; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ab3LRCN37x6aYTplzbpJns8jZHpZnE8X7xQ2v4rNeSE=;
 b=g2rlnWXWYBoJREghwY5NQDL/Eq7OomqLSebWcB30RZa3exY9iGXTBv/UZhcVNuMhSQ
 mk8t1LBdV0TbyPXYaotFYZVYWjXIMG03x54K1OgVgfN6naN5ZNPVQuPm5h2OmFGYrZ2u
 tLnqiIYwz0lImkl/zUZku0g+gULyRv52ZK+IUtMo0N7pq+/8aGWsJalf3r+U/z84gB8Q
 +QGkZBsV0+Ifs9yekHPbQ7YSTxdyYUN+9p6HGOnPNBSznJeMVlAUOeLhLceCBLaH4zCK
 EIYefTh3T766lSwZDoNeB+6so1Pl1k0lX71D6a+Inbe+EDNsXbe0RtZaqVaNRBC2tuFd
 WCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734361142; x=1734965942;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:reply-to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ab3LRCN37x6aYTplzbpJns8jZHpZnE8X7xQ2v4rNeSE=;
 b=Cxc+BDw8X3ecEXV4ZOsvXTWLZlw/JBTsKHZluS6r1id8P4JgjArfwDKvzdNBYYhvgr
 9QWtMNhnCU5if4EeQfry3/MoQ/Ph/YsUwgiOGkps06g3ad//BlRdP+hUZRslnQjGgKOE
 iW8L+QOD5EMKZB0rBoX0EE2q7c1qN8OvEXTs42dx07EcE4S2aWhVCaANrqgGJn8c5/Ax
 spFJRv6tUtwEbbOK2LG9S7IDOUC/oYu8kKDmx94+uoa+wheOBYPXIDd8Jlc5VnvOKR2Z
 /Lop48jjpPYzdwZ8opFoVwg4zpFI14CMuUyB9kLjqufCJ9CgQ3Vbu2yeXLf4q66eC4yW
 GThQ==
X-Gm-Message-State: AOJu0YxyKhURbHCzZEZ/XIKAM1eDLXeTSnKNPdRVzubjr04SzFwuuNWB
 YbzUPZgW1+Vo5ag10sK3/HitUtThgu3UwOoVMUNqStnJ8ErvgRAu
X-Gm-Gg: ASbGncu3ZcemCyyivELHLCZmzqzmUlD3H/pbEsv8Q60FJezekhVw4Jffhf4hfnNIIzL
 7ma/oIHJT5bQYon3YSQQIn90Gv0hiLYpiZcUwSDF/vWOrmQNM5E7lMsToaP5OWtkDBSrNki/bse
 nXtrU2PTU4f7Z+vFe8oPj89e1Cku7sZOBs4ucmzvjlRENPNVmncuFq4G/GnghZ2waRY909hvDIF
 UROUodJTeoe9vH3ETTkQRHtX8aeygHJWN1b82n8zSK/ZQ9dX2KSSZ3Eb9ae8ElNS3G67+w=
X-Google-Smtp-Source: AGHT+IHR+KtZfInaej2NhpJ6oCve4b7gWK4vrCWPCM/1mul+ssfq6JFGKFRjU0cjurJmuFD1LuST6Q==
X-Received: by 2002:a05:600c:4589:b0:436:30e4:4590 with SMTP id
 5b1f17b1804b1-436476d20a9mr109305e9.32.1734361141431; 
 Mon, 16 Dec 2024 06:59:01 -0800 (PST)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625706c77sm141517295e9.34.2024.12.16.06.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:59:00 -0800 (PST)
Message-ID: <51e0a4c717b0fd8bcb9945483878c5c914d43892.camel@googlemail.com>
Subject: Re: [PATCH] imx: hab: fix srktool -c usage by removing spaces
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot <u-boot@lists.denx.de>
Date: Mon, 16 Dec 2024 15:59:00 +0100
In-Reply-To: <CAOMZO5CZ2cnAozFUnybUYWQUQ4CyvuDWWy6pbVq8SnbBe_RXdQ@mail.gmail.com>
References: <33e7b95383c1e5dd20f4cd2e30b88391a09e0858.camel@googlemail.com>
 <CAOMZO5BezDHXphjvX+Kat6rFq5zYC5yVucET2NzTHdFYnYTqXA@mail.gmail.com>
 <01420bb81265f69bbcd56dbe658fc0528d94e87f.camel@googlemail.com>
 <CAOMZO5CZ2cnAozFUnybUYWQUQ4CyvuDWWy6pbVq8SnbBe_RXdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
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
Reply-To: chf.fritz@googlemail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The srktool option -c does not allow spaces between certificate
filenames. Only commas (',') should separate the filenames. If spaces
are incorrectly included, srktool will not display an error or warning
message but will only process the first certificate in the list.

So adapt documentation accordingly.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 doc/imx/habv4/introduction_habv4.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/doc/imx/habv4/introduction_habv4.txt b/doc/imx/habv4/introduct=
ion_habv4.txt
index 25711bbe95a..a2f2d836911 100644
--- a/doc/imx/habv4/introduction_habv4.txt
+++ b/doc/imx/habv4/introduction_habv4.txt
@@ -240,16 +240,14 @@ root of trust is established and the HAB code can pro=
gress with the image
 authentication.
=20
 The srktool can be used for generating the SRK Table and its respective SR=
K
-Table Hash.
+Table Hash (certificate filenames must be separated by ',' without spaces)=
.
=20
 - Generating SRK Table and SRK Hash in Linux 64-bit machines:
=20
+  $ CA_CRT=3D"sha256_2048_65537_v3_ca_crt.pem"
   $ ../linux64/bin/srktool -h 4 -t SRK_1_2_3_4_table.bin -e \
 	SRK_1_2_3_4_fuse.bin -d sha256 -c \
-	SRK1_sha256_2048_65537_v3_ca_crt.pem,\
-	SRK2_sha256_2048_65537_v3_ca_crt.pem,\
-	SRK3_sha256_2048_65537_v3_ca_crt.pem,\
-	SRK4_sha256_2048_65537_v3_ca_crt.pem
+	SRK1_"$CA_CRT",SRK2_"$CA_CRT",SRK3_"$CA_CRT",SRK4_"$CA_CRT"
=20
 The SRK_1_2_3_4_table.bin and SRK_1_2_3_4_fuse.bin files can be used in fu=
rther
 steps as explained in HAB guides available under doc/imx/habv4/guides/
--=20
2.39.5


