Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FB2C021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D71CB80F0B;
	Sun, 16 Feb 2025 21:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LYC9SZHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BB180FF2; Sun, 16 Feb 2025 21:45:46 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A498E80FE4
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d18bf1c8faso9328595ab.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738741; x=1740343541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9CnhKJIJNPG3Oh+gl6VHPXVyfcL7caiYhRkx7Eg5Eo=;
 b=LYC9SZHhgm3dtPLys3rkezHsYG4J7yTLOseHAteXwg6or3bSlnHMbpKh+ukKUIA6Tc
 xswYmnGMGAVK4+6cjdE1XwBW9IVzDKoplar494BRvv8XZ+6K28yjfahtEHV5z6L/cAeT
 yggTOkw3PzNoocb9+0lDotzI5+KD2Lrjs0GVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738741; x=1740343541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y9CnhKJIJNPG3Oh+gl6VHPXVyfcL7caiYhRkx7Eg5Eo=;
 b=hVzazI9EPGWn27yL4ZR/AmC8onosJQk2wyRYAOacXYrfpwDoNlY9g4oale4Bw4nO2b
 r6VcY5LVumMA8bvQmSbQ7c/EC931k42yWQnaFVirKqLbdbKYKXRh3fn5t+HINBM6t0ip
 ewajYA7NWx0BRaUhGYmtCx3Fhp3to0JezfOhRY1p7ap3jy6PK3FLjMVpDR1w4UjlfFEL
 JQhpJQKnLnnBt2noncLoz7qlKQ2NBI3guIiYgXDHI2VD5aCJ7wvhAoQtISq5a0bSXR/q
 /KE1IiumOZSc+bKNHM4CxAPrF5JouwHep8gGaKWimBfTCSCgolNdRrCGON0A5EimlmZA
 laKw==
X-Gm-Message-State: AOJu0YyaQ2uRs/8k3wz6iWX8ChSNdQOHrpcNdwVe73DsAf4hVdwPpKxt
 vor5KYNzPoU1KWhnaxMKJ41yudWqqZM7F4Rbrx+NDyXby6Ls7lqkTyVqF7yUPF5zyx2piJPbbIo
 =
X-Gm-Gg: ASbGncu8NAtGPeGoExxO+c1ZdfBAqwFLVkd4zFbk4PN8WoUgUHetQc5P6O0r7Vb95+O
 3BP5cQ2ZIrwN6pKC/7kE0vsq1c2h2DdwLNaKw4IlTYTsmOaALef5aIhLzeh42AWnEqWYtrLOCwU
 TBNc8rI+XsEiZ4eCGwUcmzarhtaOre3K2Bpsn83KUE4Erjdz4R7If/ND3+BdGoLncVK8XYi/L+h
 hCJZX8ceo1epfUcobYanH4pcjhVvuYP9H/bHey+lATwxmkT3ZeZBz5fNkX6Vzfs2q59GLAfPiE9
 ZXPdwmOkLr3aLg9RUIYCc5LgYWer03acwkkCARXp1CG2CJ4rMw8f
X-Google-Smtp-Source: AGHT+IHNvP0IyN3Y8keb8DtBD9PIWALJ01FldhLsGPQQ+4zKLkvTYr2Jhmv0Jt8fzrSBJS9biElG6Q==
X-Received: by 2002:a92:c24d:0:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3d2807b1bf9mr61504935ab.1.1739738741232; 
 Sun, 16 Feb 2025 12:45:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 21/28] Add a 64-bit version of is_power_of_2()
Date: Sun, 16 Feb 2025 13:44:06 -0700
Message-ID: <20250216204421.3560012-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The existing function only works with ulong which is not enough on
32-bit x86 machines which need to set up MTRRs up to 4GB.

There doesn't seem to be a 64-bit version in Linux, so add one here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch with a 64-bit version of is_power_of_2()

 include/linux/log2.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index d4e32ecfc64..89097cdc694 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -52,6 +52,12 @@ bool is_power_of_2(unsigned long n)
 	return (n != 0 && ((n & (n - 1)) == 0));
 }
 
+static inline __attribute__((const))
+bool is_power_of_2_u64(u64 n)
+{
+	return (n != 0 && ((n & (n - 1)) == 0));
+}
+
 /**
  * __roundup_pow_of_two() - round up to nearest power of two
  * @n: value to round up
-- 
2.43.0

