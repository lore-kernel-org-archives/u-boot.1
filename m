Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BCFE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 17:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 903F080050;
	Sun, 15 Dec 2024 18:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="fKRTjgle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545458005D; Sun, 15 Dec 2024 18:04:30 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2C78004F
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 18:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chf.fritz@googlemail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so2159885f8f.0
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 09:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1734282267; x=1734887067; darn=lists.denx.de; 
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to
 :reply-to:from:subject:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6kCkFq+KsK3nYZnDVg8+XQ2gZxm3R4KqwRrXkpsO1/s=;
 b=fKRTjgleNeUXlq3ibLk30gSzcUITQ9jXHxj2AGAIVGJMK1CCuheTtv2XuM+Pnh8iOg
 hP304EV1jedjqRNaG6c0tnOW0Emiivb8sJvpXOQWo0oWXfZjgoreZtrvZjR8gT0c6mbD
 jtEZJkFoPpCwLIuTVvT111itBwgCmBHRZnIHCY4NR1RPn2Rsw8fGDnZ0czFaG9uCqOib
 6S2MwwBE2i6v0/oDlLFbBF3MnEcD6l3Q59fW+xdC3WwoA+/WfsuGp9WsWy5cY+ZJvrM8
 lyE5yyfBK5Xb/DTm6IH2Ea9ZpSdPCYSMfJn541NirFTIpYem69LA1JNDwULhRj3bv1ZF
 0FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734282267; x=1734887067;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to
 :reply-to:from:subject:message-id:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kCkFq+KsK3nYZnDVg8+XQ2gZxm3R4KqwRrXkpsO1/s=;
 b=jIX7fWI70+zbPjG1KRm70/L4wCouvoaWr+pUWlomXqavP48R1hyp4NISBiC813Xtcb
 bzkW8xw5GV7KKG/V1uJ2hnUVP+uLs87xsIn+lvsHRgB3aQhctpTT1K69US2Zo3BgufjX
 Wv9gMT0ZHaddRjFQ0bVzVSlqNIL/7aeLPIcyZGXlSHd/eGYVbooQOy/IwadLSaCrEjul
 1z1mCbkKdZDXqRdgvFVdp46Y8o10pnxcTI7AeL68YIIzfJkjZAE7COmAZJ+7q5U0tAjt
 0zgpEAsX1y0stPzSE0P6Q0MRsti0lJF9+xFgE5Dql8/Tpg2JezYF8JeIghoWdY5uMYpG
 A8Rw==
X-Gm-Message-State: AOJu0Yyuk2i+RXLNRjAoqGk6mHlVk9AAg/TxeTKvto0/AHwbEeZcEmDk
 FCLDEV5AqoEQhZYSEoxGk0gu6Bwow8EYSgDjhRzB86nohD3VF/KNyoU3yg==
X-Gm-Gg: ASbGncuUjkMMJxTBaQdrGJIPJAJ71yHyforb+5qgUlPOMJy3zVvTrig3dXzDoY+nn8F
 /WorCGneCzOtwvtiVbXrSZlMnKYn6CB/AcsKeAkUNiUzBNyvUtHdaEzREs6RgSfkn/DnLjZBoU0
 XK81If9/d9fsw6w9ZpRsn42lqGJc9B7sh50PMYEn+hULb+HvOCuwqd2qfPUAhhB8gcVD0H4KBy8
 5cAj/jzxhwRdbGeIh480IFDmq7EZXZoY897bi94K//AYhFn7ebvIabS54nhXlH9DFxD8ng=
X-Google-Smtp-Source: AGHT+IHj3SqY4GQPdpbJzqo6LO8a8sIaMpbSld2jCZfNyDSrMkUt1AuG8BoPUx6bSI2ySu09E9QAgQ==
X-Received: by 2002:a5d:64ac:0:b0:386:37f8:451c with SMTP id
 ffacd0b85a97d-387887c24f0mr12993937f8f.1.1734282266679; 
 Sun, 15 Dec 2024 09:04:26 -0800 (PST)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4363601569csm59310595e9.4.2024.12.15.09.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 09:04:25 -0800 (PST)
Message-ID: <33e7b95383c1e5dd20f4cd2e30b88391a09e0858.camel@googlemail.com>
Subject: [PATCH] imx: hab: fix srktool -c usage by removing spaces
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot <u-boot@lists.denx.de>
Date: Sun, 15 Dec 2024 18:04:25 +0100
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
 doc/imx/habv4/introduction_habv4.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/doc/imx/habv4/introduction_habv4.txt b/doc/imx/habv4/introduct=
ion_habv4.txt
index 25711bbe95a..53c54b2a88f 100644
--- a/doc/imx/habv4/introduction_habv4.txt
+++ b/doc/imx/habv4/introduction_habv4.txt
@@ -240,16 +240,17 @@ root of trust is established and the HAB code can pro=
gress with the image
 authentication.
=20
 The srktool can be used for generating the SRK Table and its respective SR=
K
-Table Hash.
+Table Hash (certificate filenames must be separated by ',' with no spaces)=
.
=20
 - Generating SRK Table and SRK Hash in Linux 64-bit machines:
=20
+  $ CERTS=3D"SRK1_sha256_2048_65537_v3_ca_crt.pem"
+  $ CERTS=3D"$CERTS,SRK2_sha256_2048_65537_v3_ca_crt.pem"
+  $ CERTS=3D"$CERTS,SRK3_sha256_2048_65537_v3_ca_crt.pem"
+  $ CERTS=3D"$CERTS,SRK4_sha256_2048_65537_v3_ca_crt.pem"
+
   $ ../linux64/bin/srktool -h 4 -t SRK_1_2_3_4_table.bin -e \
-	SRK_1_2_3_4_fuse.bin -d sha256 -c \
-	SRK1_sha256_2048_65537_v3_ca_crt.pem,\
-	SRK2_sha256_2048_65537_v3_ca_crt.pem,\
-	SRK3_sha256_2048_65537_v3_ca_crt.pem,\
-	SRK4_sha256_2048_65537_v3_ca_crt.pem
+	SRK_1_2_3_4_fuse.bin -d sha256 -c "$CERTS"
=20
 The SRK_1_2_3_4_table.bin and SRK_1_2_3_4_fuse.bin files can be used in fu=
rther
 steps as explained in HAB guides available under doc/imx/habv4/guides/
--=20
2.39.5


