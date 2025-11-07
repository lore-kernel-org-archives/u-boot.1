Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4003BCCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D76683E16;
	Fri,  7 Nov 2025 17:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="T1hUv2dK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE61E83BA1; Fri,  7 Nov 2025 16:02:36 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95EB083BA1
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 16:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477632b0621so5968485e9.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 07:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762527753; x=1763132553;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3shf76yvsK2RXbgLpV+4af3RYTbYhV+AXNdNJGFeSNg=;
 b=T1hUv2dK8A6k7g7v6KBqIrWwkozyuE545eldO9r5wkfvCBRnP7vQdcSjOR5Ilff/4F
 wcMquu/4Mr/aFm6lUE8pOX4MjPVVDIPpr2md5fpM3aLHev26X+8aKGb2w1y1YMkGBoFS
 yGF1SpaRx8RIy7RlUUSp4BK/I5CDPGs7cghHaAxd+INbRSrMrL31Ea6kDwKNyWchKgpX
 Bqvv34uMmyjs9b3mTrYgh1DsNP4gAWkXOhVC19opF/cI9LNO5J6AKGVHcuA9fxyRaeYk
 xzYsE7iO44Yx6cefkICgg2NUpF7bU2tNLt09NDfS/Ll/mI2rBmk+Chu0udL7TmOW58w+
 lf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527753; x=1763132553;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3shf76yvsK2RXbgLpV+4af3RYTbYhV+AXNdNJGFeSNg=;
 b=J2z12wOLUyIyiUJZsatai7Ew3nrZJr+6ba2Mg4RQiVrX2dlNTHZXt4xyYjCtcYKH24
 nfFL0WYBO6lnUGum3bgfNOA72DvqA1Z5dcqd+sOBhou1ScrUVPJ6khQAp8dhdyFF4298
 9aElWvlpGsUwGOf5FvaxX30M0oubgErDLpIa2qZ+dfVuTfiNiRBMrUsiHfSu8gGOPoZe
 M8KbppQs4IbO32+Q7akAWT6sQNYmKM7fVTzNmrlG4sfxZB4/WiPYHbkcLiTJNtzOj1Wi
 Spm/bBjnK4Pe70HOFvsMuKpt32npyJ9aXFD2yt9oRr05Aw7eW8KpjpR/SSyhIirrVbdz
 8Nlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoTkt67OjPxPKk361R/k5v1jr/DEvle2oh3mzd6H9i0FVHrzPsJy5+oK2prFRyA2PptGxG3j0=@lists.denx.de
X-Gm-Message-State: AOJu0YyYWikm2HM2woIdwmFqYoYw+2RiURpudiD56VTogQh0q7Ku6w6Q
 l2Nv5a3X4jXKKId6/r9HPGty1aICrV+PQPbXU+1XFdBs5Rw2QmYFpdmPLt8sgPTTHJk=
X-Gm-Gg: ASbGncv5YZPi6GsShEfG549n9kJG9V1rOkGVdsTLiO00RftyBE5QYi6vEsdLxg/wW5/
 Jb9gv3YffjII4duMLgo5Py4AAA8xii4sLEA2fk7+11TX50qTZ6AC1diDAcqlcSYwlXX/xartFbd
 k9H+cjorN59vSz8YMU5nCvqIRJql0fTJDcBDiEGuAJwn4XnCH44upkroy4eegmPTHiTHQKVW3N+
 1WE6U4b+ZqRRreOUyPG/sycqP6A9eWE3TJDCG0u5KITWWthROIA4WmOtmIHOVLWagpsnbWjuQye
 RajGlrblq49cYfQWBbXgEah+BkDyN3ez2em6IgzAkOysa4t3zNom/ns0q5RNNlcjypY0ibcTzqq
 HalV82WgQRRC1X/68V5tzRcZSJjKWnboSYihsdHGGxewXf2DPVAro4McxNTOr4DYvobkUS9cllM
 LjlCNNx3bjSA==
X-Google-Smtp-Source: AGHT+IGVNqzU24zbTLspI21T9J6xEFU1Tv7BYB0xCFKbuVoZ+3YrGNLIY9H19jIf6YUAV/ukH1IVxA==
X-Received: by 2002:a05:600c:4695:b0:477:fcb:2267 with SMTP id
 5b1f17b1804b1-4776bc86c41mr26853495e9.8.1762527752514; 
 Fri, 07 Nov 2025 07:02:32 -0800 (PST)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47763e15481sm42508845e9.3.2025.11.07.07.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:02:31 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
Subject: [PATCH v2 0/2] mtd: rawnand: atmel: Fix ECC error on SAM9
Date: Fri, 07 Nov 2025 16:02:22 +0100
Message-Id: <20251107-pmecc-v2-0-271e6aea3231@hifiphile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP4JDmkC/13MQQrCMBCF4auUWRvJpFVjV95DuojjxAzYpiRSl
 JK7G7t0+T8e3wqZk3CGvlkh8SJZ4lTD7Bqg4KYHK7nXBqPNAVEf1TwykXKt7ZAs0skaqN85sZf
 35lyH2kHyK6bPxi74W/+FBZVWDn1Lvmv1jc+XIF7mIE/eUxxhKKV8AcyN+K6eAAAA
X-Change-ID: 20251106-pmecc-a3841c81c782
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>, 
 Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Fri, 07 Nov 2025 17:57:52 +0100
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

NAND ECC error is observed on SAM9G25 after updating Linux from 3.16 to
6.6, due to PMECC setup time config was lost in the driver reworking.[1]

U-Boot is also affacted as it use the same driver, this patchset backport
the upstream fix.

Backported from Linux: f552a7c7e0a1 ("mtd: rawnand: atmel: set pmecc data
setup time")

Fixes: a490e1b7c017c ("nand: atmel: Add pmecc driver")

[1]: https://lore.kernel.org/all/c015bb20-6a57-4f63-8102-34b3d83e0f5b@microchip.com/

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
Changes in v2:
- Update cover letter and use 12 digit commit hash
- Remove unused timing_res_idx
- Link to v1: https://lore.kernel.org/r/20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com

---
Zixun LI (2):
      mtd: rawnand: atmel: set pmecc data setup time
      mtd: rawnand: atmel: atmel_pmecc_create: Remove unused code

 drivers/mtd/nand/raw/atmel/pmecc.c | 11 +++++++----
 drivers/mtd/nand/raw/atmel/pmecc.h |  1 -
 2 files changed, 7 insertions(+), 5 deletions(-)
---
base-commit: ddc916334a7a7e180b532dbb2cf1b778466d2b9b
change-id: 20251106-pmecc-a3841c81c782

Best regards,
-- 
Zixun LI <admin@hifiphile.com>

