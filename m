Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB63DC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 20:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFDF8060C;
	Wed, 15 Jan 2025 21:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KOdUcZXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00BE80726; Wed, 15 Jan 2025 21:02:43 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5E580214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 21:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6f53c12adso8744785a.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971359; x=1737576159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAHpOE5URIRn1n+rCN71av/3CxlNpxEVzbjWRhOSMQ8=;
 b=KOdUcZXF4h6nuoaMQFX0scPHOJa4NXQFPIuCj2egb5dzHSDrtKmkn+pbKIX96bTgdL
 2Yt4DaNvHYAJeFbDrB9hta83B/XOLFRlt4lQLk0ckcty5S/ZbHGE4bJWa7/5ou7x3lsF
 5QAPy+79kbQhO6WLkE0UqGYl0fRUVNt8clvrzBFJ/BXmN0KoHluwT+U9llN8nnLRu/Sa
 JZgBqEF1dt7mWJEeG57RcxM2+NV5eYUYRieSbBnTijWJc/4Yma4UH/OAJwzUSLIgyCa2
 ikG1czJwGYPkBPlM8zE9jNUD64XCtB5xHTJaZtdzHbyJYuksCNFyBolbwG8aph48Cek+
 mjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971359; x=1737576159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAHpOE5URIRn1n+rCN71av/3CxlNpxEVzbjWRhOSMQ8=;
 b=m9dKZoezu8kTFAXJ9XwCQPiIekN8+Tn0LPI5fmL0/E+3R9ARziDScPxKcYN0wpV3Jz
 TSc7Z7lx2isUL8jZEZJub2iIrYM3m54VU/58o/xQv2dztBfZm78GYZokInAJQpj235P2
 1xvYmjEw1rz6FXnVngS/fylXlJkU/WvIIcjtw5mRRnXx961GusR7UUr+ZGZxmxYCQOs7
 TVmy8nFfkawWRHBL6YtqszKnTrYBGp7ppVQLOuiY+LAsYEW4bfOmabuZpSMzZzDeRlyd
 NmdY0lzFR/6DvGl3cj4QgrHCrdjiPjjV2Z7sD12M0of/qqXSa+NTRXWly1UNXYCZdlIX
 wSwA==
X-Gm-Message-State: AOJu0YyhcwtKEl+hg/Ogl0nOifpFTj9E9qqX9Zmq0G4JysUY7YKYj8Af
 3l2inURlbfcWDE69P8HubMyfDYp3/UBwZalInT3YCcrF4mLmVzoBvZBuGQdboq+DA+zC/5rViDz
 s/+g=
X-Gm-Gg: ASbGncub25boiET1ptXN0sRrwGtEdkE4Hnas8M4OfotB/izOjpOtm//Rx/DBA6J2oFq
 yPzW0gfG67EA2P/fSvvE4bEI2m6+yoH0xV6MPoHRGet9XSgU/kEW4aHaFYWgD1Jawyq8vn/YoDF
 wHnj4AoqctvU3vFk9NDbLeKMnN6KaTy4XM1mDljutREGTBQfrs3fGTpmebj8sqWX7+2bt35Dnij
 9RkopJ6QvwCx1rxxuY+47nk7X26f56ydP+zTWLEZy8l4fCq4GTIod+m1l61FWzysvl86eh2PJbi
 K9pHchtDtyOCEAsmPLCIr9X+XjKh9Fva9Xj3fP53h/v6EVajDxe8wWQ=
X-Google-Smtp-Source: AGHT+IGYiCYXbqHHmqUNAVai27L/VxGrdk83L/NbWSdq6RCbFK5sJhJXC7OAzwvbfDSrrT2Z3In28A==
X-Received: by 2002:a05:6214:240f:b0:6d8:959b:c307 with SMTP id
 6a1803df08f44-6df9b1b4ff6mr570662276d6.10.1736971359489; 
 Wed, 15 Jan 2025 12:02:39 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade733e9sm68328686d6.82.2025.01.15.12.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 12:02:38 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 5/6] tpm: PCR allocate during PCR extend to disable the
 unsupported algorithms
Date: Wed, 15 Jan 2025 12:01:39 -0800
Message-Id: <20250115200144.951530-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115200144.951530-1-raymond.mao@linaro.org>
References: <20250115200144.951530-1-raymond.mao@linaro.org>
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

During PCR extend process, if any unsupported algorithms are active,
try to use PCR allocate to inactivate them.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/tpm-v2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 71abf070de..9781c288be 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -344,7 +344,10 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
 
 	if (!tpm2_check_active_banks(dev)) {
 		log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
-		return -EINVAL;
+
+		ret = tpm2_pcr_allocate(dev, 0);
+		if (ret)
+			return -EINVAL;
 	}
 	/*
 	 * Fill the command structure starting from the first buffer:
-- 
2.25.1

