Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC98C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7438F84AB7;
	Fri,  3 Jul 2026 14:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Em3TfA3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1855A84A27; Fri,  3 Jul 2026 14:35:34 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B7F849F3
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 14:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-39b14a7e53aso5086921fa.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783082131; x=1783686931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eFj2L/otFA5Kiz/DkkZ0peWQbVlheawVZyyXg+ZRJGM=;
 b=Em3TfA3arKtYobVrXq0ucQjKVQmoQeVOEoqYNMWh6tvrfp1ThAb4qMZez9PB27KJTm
 BJeepPHeGU0t023m0LEuUHt8A4slgWMya5aznVXXr/oMiBz9geyLT/G/C7EHHUGDofqp
 hnrZevZ825UxuxR+QPEXcpIl48oOU9ZI5QPGfk8H39Qd1A5aCql5G9ossGBts8G5ApxP
 oTV+8AwE4jYHqfsvfp71i0RRxquMeup+qBH+vQrHb2LQ2Znt6ZOKT26+Q64PZB66OUkK
 wzp+IZs2wIdCANOZDsy0JzMp3LcxD2dKx7qDlNXxn6k1Ed24u59BeM5j7fohCas06rPH
 PGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783082131; x=1783686931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eFj2L/otFA5Kiz/DkkZ0peWQbVlheawVZyyXg+ZRJGM=;
 b=VWV/VLEy7+McnHqJAq9AYY/exutlXA2sJX1ciePSpAF7IwZvSBvJVl/Se4plMoPOtH
 jWlHWXad8/olyk9pSp2PJTBl8ypCMJIessbCB3pEfNpL2vUGUAZ2XOs7BrQDe3+sSW7I
 yEtSKPHkcpL526W5uX556N0D2ANC0VxAStEcrOMVcpP9zuZzM06T27BMxi78EKuNEbWb
 ShuB2r9lEYCTs6cXFQeWjlNnYVgg9j9kfoctIPTwELkWf8YDzR91R8t8kC6ZtXGV/l5E
 yKxW46GzxNho2ARfdtFF++jXlIGEcwy5axrwlD+pGVxsa9cNW95xDNKK6M95HcBVmpOa
 gFbA==
X-Gm-Message-State: AOJu0YwAnFPpli2G0iha1/aFwvGYZUYyVM0+DJFrcW69egtWLV1thvSo
 EJWWqlqM5HlIzNE4c7+oIhETfauMLSIoiUAOygWWup9IwpvM4hLteVfcdRUsAiOk+hE3yngA
X-Gm-Gg: AfdE7ckRGcQQw3RnEelVnDSizLabImOUCaaOTeYTyZiaXkQgCuVKic2gRqB0XmGmfWk
 +Gp8onLRrQgzYsCMHZkpN4w0ecV5P/H+f29uNgPaVEf0LMqGNnYalWuHnSKgNYpO9xee+CfHl7i
 UUZWsACuEGEkQqi9aIqEpFlJ6yI2q5kSaaID3vxUVjbHRegIhp7BIjQ9vuPk/aK3M0qpz5bR7IX
 3pKBsa7imvugBApFN1+TfeVRzmEws+tgV+JAqm9Cht9cX0GOF2ltp+0me7ekCEkox02YWh8nV1r
 pad4yvgugiuDsGpq4C3TOxoAUm/+Iqe5zXrqx5ZJJk6XEcLIzNQtw52yFsckjzwFvuioxToriLD
 s6TaktYaCiZ5huTNYq6eF5dAzqQDoh+FQAi0g2STFfF5N8C2+a4Lw09KdqVRJIHzRIclog31MYg
 MIueTL/Kpw7vWCDzYo3nee0JZkUUkd4Yaa+4i1pLwd6MqwOKXyCVhKFBYR
X-Received: by 2002:a05:6512:3f13:b0:5ae:c425:c82e with SMTP id
 2adb3069b0e04-5aec67ab1d4mr3151369e87.22.1783082130727; 
 Fri, 03 Jul 2026 05:35:30 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13c8d0esm452996e87.84.2026.07.03.05.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 05:35:30 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, fberder@outlook.fr, ian.ray@gehealthcare.com,
 Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] ge: common: vpd_reader: fix errloc array size in verify_bch()
Date: Fri,  3 Jul 2026 15:35:29 +0300
Message-ID: <20260703123529.1145120-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 14:59:42 +0200
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

errloc stores bit positions of errors returned by decode_bch().
The maximum number of correctable errors is ecc_bits, so errloc
must have ecc_bits entries.  The array was allocated with data_length
entries instead, which is the number of EEPROM data bytes -- orders
of magnitude larger than needed and incorrect.

Fixes: b418dfe16e62 ("board: ge: make VPD code common")
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 board/ge/common/vpd_reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ge/common/vpd_reader.c b/board/ge/common/vpd_reader.c
index 2422db38013..b3f9e96615d 100644
--- a/board/ge/common/vpd_reader.c
+++ b/board/ge/common/vpd_reader.c
@@ -66,7 +66,7 @@ static int verify_bch(int ecc_bits, unsigned int prim_poly, u8 *data,
 		return -1;
 	}
 
-	unsigned int *errloc = (unsigned int *)calloc(data_length,
+	unsigned int *errloc = (unsigned int *)calloc(ecc_bits,
 						      sizeof(unsigned int));
 	int errors = decode_bch(bch, data, data_length, ecc, NULL, NULL,
 				errloc);
-- 
2.51.1

