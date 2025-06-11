Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA6DC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D67282C7C;
	Wed, 11 Jun 2025 14:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="dXOoCZPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563F582B20; Wed, 11 Jun 2025 13:51:37 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5708782BA7
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad88d77314bso1223654566b.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1749642694; x=1750247494; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BU6JrNS3Hw7sxFF4AW0dgm67VVbhfufAGh5Oqd3SNjU=;
 b=dXOoCZPOHTW7vFaPxK7L497qzvAVoh5dmoN4wd8rsIFRK23C5w6Mx8JRxxpuBaqzHz
 MuC9THk+OwoTm5x9g7Q1IqEnmPTktAAxmv29ueLWEXbJEgyNh4sHGOhtIIcAR0hRBXbl
 tfCdxDllUmo+9K63ieuTQpuaIieXhUNWt3A5qAVkyq6n+dQjW1XcvwA1CtEdXLWrcDSC
 uJXO2kCF1FFn5KbFmB8+RPsN+ZVHN3ZT2xfKrYQevmCOfk2x2JguB6lwKX1RStzX4DtE
 ut+DlYiRexSNGf54r/TbQkhmqYU4Sc80gYN5L5vSvHGPm4iaR3sNBPqWMDkYW5q3uzPy
 p7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749642694; x=1750247494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BU6JrNS3Hw7sxFF4AW0dgm67VVbhfufAGh5Oqd3SNjU=;
 b=kocJZQOc4ZHmjOrm9wVe55orTDSbGAMwtNP3Zlev5/k0ELRZtoa/EsKoUCj5rGX1Xc
 jXW3NN6jrNmUaZF1wn56rMYjCXwQ98HvR4yrCCrKBt/owNcDD+tV8JAJoUXBZqg403i0
 Eqb98Kj55oIGTRUq57RcWQCPL78k0BiPawNhaULzlFKhSyJ84GmSJ97CmKCasSfJZ3Q8
 RZDjhs8eCOEx9I6hDSJWPLu5lZ1BcDvYDvLKss3bHIgLdw1nRyOh7RQCK5Chkopdp8su
 WBrxnwWeWk2jE7p41XvCW1IAlr1+tSmf8D/m6Q6WUd86mGDGcOdGxrOR/KJB72itzv9h
 JXTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRogIwOmqyKur/NyY4ecK1gu8HiIsH8iw/q32melPrKqXowI9pe3Vb7u5pto54Q47ag6F3POI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8pzpUxrV9veyvzbnpP9kqqf5k7E+9B9+2zAFK9MGxhkI9I7Fr
 qFW2XSpt2bTY+lPzuNoVRu+35eUq2tAZ29ZvjZcr61YAZd7fMc2UkxIjdo9gfF3r3pg=
X-Gm-Gg: ASbGncsN1Qt/mNPDgIFW0fS435OVKmSYkkhSzU4cQytaDy4jpj4RTzjnqt5GH/3tOlP
 UpKMceWRzyl1sNC0XDdq31+jfm5bNXx4FKa/bsXeIg0KYzjmLieFhlM6Bs7DgzohyL1SaXI2RX+
 puGjX3fviFEfL1SVbgl983GvY9UMUc4OEnzO0OV8GFxXAdoNDhWXExNnQ/ls7W4qPlenKWdEvNW
 z8+9HjLRrW7+Yw2980UklPdSTZ5idBMgp+9JH/l83+34Ndgx2WQw9J+KK+5PUxmuDtaDMC/UlUv
 yKNMzh7qPp8Syk9juGUFKanvloIZfo3wprQ9M28437J+iUi2PGl0VKJo7rklo+aETcJbUKBx1LV
 uYlGUJw2A1Hq69xy4OG1dm+gC419KW9wv
X-Google-Smtp-Source: AGHT+IExxPtpTGtWv2gXKxYc9QYd2YdcsFJKV0CbiqKsS6nwTZHbcHAvOb4P5VY01ufEsWUfmTVnFw==
X-Received: by 2002:a17:907:1b1b:b0:ad2:4da6:f58c with SMTP id
 a640c23a62f3a-ade897ab542mr303609566b.46.1749642693663; 
 Wed, 11 Jun 2025 04:51:33 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1d75467fsm891666166b.14.2025.06.11.04.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 04:51:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Jun 2025 13:51:24 +0200
Subject: [PATCH 2/3] doc: board/qualcomm: Replace buildman build instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-qualcomm-doc-update-v1-2-5cf8cd94974d@fairphone.com>
References: <20250611-qualcomm-doc-update-v1-0-5cf8cd94974d@fairphone.com>
In-Reply-To: <20250611-qualcomm-doc-update-v1-0-5cf8cd94974d@fairphone.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749642691; l=1243;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=MkE7SjZKUL9CTDCG1ZtzpCOu741m8T+vqQiH13c5HhU=;
 b=QIN6NHTAit8XFM9RkP9Ax6A4zTz4abluCYZW7it3OkaTZm2QRq3HzDU0DMPhHMeElGGqFu5we
 fxHzy4qE1hPCsrQxx5nN2LHSjKoS+nkkIohT8zH2M41fuCRBXdbS5SS
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Jun 2025 14:37:25 +0200
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

This command does not work as described in this doc, so replace it with
a regular make with qcom_defconfig, as already used for other
defconfigs.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 doc/board/qualcomm/board.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index 64427ba5be793978f54dd51c2b24e55fcd78ea8f..23159f2091daa0def4cd005c9e413aed6de7d4a7 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -23,10 +23,7 @@ Installation
 ------------
 Build
 ^^^^^
-
-	$ ./tools/buildman/buildman -o .output qcom
-
-This will build ``.output/u-boot-nodtb.bin`` using the ``qcom_defconfig``.
+We will build ``u-boot-nodtb.bin`` from the u-boot source tree.
 
 Generate FIT image (optional)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -81,9 +78,10 @@ Steps:
 
 - Build u-boot
 
-As above::
+Use the following commands::
 
-	./tools/buildman/buildman -o .output qcom
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc)
 
 Or for db410c (and other boards not supported by the generic target)::
 

-- 
2.49.0

