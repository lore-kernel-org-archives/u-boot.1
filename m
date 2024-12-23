Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0656E7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD67C80711;
	Mon, 23 Dec 2024 15:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TDDgTL09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A796F806D4; Mon, 23 Dec 2024 15:48:12 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D958073F
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6e4d38185so345522485a.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965289; x=1735570089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sjv0G7m7DKrqwz/Yw3WQTPDxOB+R90hxSTRlMzp80A=;
 b=TDDgTL09IA3pNSu58092CABh+Wie4YOiU6QqVZg6UDQim/zDkc+bMJMhyQf0OzgkJc
 vRQ0q2T+oZKJfyPZrVLUK96MpOneT5Uu3tMdCbykW02I/WNJnkZLeqVIaXWkYzwPxrsU
 U+afuZQH9FYCJ4+qtj5PyQwd843W30tQMULn3GPEAu95lACQXlciLqBOgo2gdBJrDonF
 INURFMKtf7snTXpRTKw6x+sf1bQY/WwmR/wFtNRZTpHJGMq3ABTndpY72CMnQC0lwujP
 AeYnWePmVyqKAPOyWfeA1pbq9SkHeOLT3BIQUij4lTXoZgIbMaB43wJ1XuojmxZ74Ca/
 VP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965289; x=1735570089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sjv0G7m7DKrqwz/Yw3WQTPDxOB+R90hxSTRlMzp80A=;
 b=VahJROYB/HF2B/jb9Dmnfe27NghdmvOY1vzU7Nd5/MBp0ZYztvCA5tRcVKdL5TrBs+
 HibXEbtVVAbkStZysNBorlkwqWrQK4XBy8KtH/tlWmTef4OdjoHNCAwEppsP12sDsGip
 G4/m94cD7AmB/rcM09OnPp4PNEHrpK2cM9HL302hdDefPXvazP2MglnljyZF2namKUzN
 h30o3ClP8hNpxs2908t8we4kMfUkOIS8TuBcmhMxFrhKlLwLaGgV+5Nb1nIFGnNTWX08
 tkD94+M052lXLNsYxu+grCnnQKzzwcC3IDmevLMiCbSUwRxyUzWvHqntAAv5oh0MWlO9
 pnMw==
X-Gm-Message-State: AOJu0Yz4M2ilngZY6FosYKXa5H4syTI+DzP1s2avWbOuiyltiYVdSE1w
 FE/lEFh1VPh4Pp8nvHycQ/AYOcdofwLeT1gv47SSB5P4m5b+vpX+zMfjo2T7hd/Im84KMqtQlPK
 W
X-Gm-Gg: ASbGnctyVEgPVTmKMaJK/tlswckmBAd6U2Sz7PcnIArICpD3rwAAXwX6Ff6M3Ikpuhl
 +9lvtsFWa5o9zLJ5uypd5oTnSmHUOGw9tr3pdHmMtltgjBymy1Mum+M3fVkq/wV5Pfyv6iVCf2+
 JmazMElHSVcDT9k+ez1FLLZGm6P/jty0Vrc8zvN1CArZyjTD+pMATqHKpEIT4NeUfeda/ybCjLA
 9gi9gXAhU/FdnUWiRyImm5/qT345iVsUQvUDOBibjbsWjYMoZVeQlMB3QOO19+Z/r7GP8QUeHU2
 JMBplVXnyoRrU2/Ci+fuYCYCqo8lCNWJ+YnEvJEgLcFyQVuqQhnO0/I=
X-Google-Smtp-Source: AGHT+IFQ7889t+4XVa2ERMDyISvEKXqmHl70FqgG68i+pbvuugsTla/R8P48djb2MfOzyx2fwbfNnQ==
X-Received: by 2002:a05:6214:dac:b0:6d8:9124:8799 with SMTP id
 6a1803df08f44-6dd2331f006mr244819506d6.5.1734965289187; 
 Mon, 23 Dec 2024 06:48:09 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:48:08 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 03/11] tpm: Rename tpm2_allow_extend()
Date: Mon, 23 Dec 2024 06:47:25 -0800
Message-Id: <20241223144737.554992-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241223144737.554992-1-raymond.mao@linaro.org>
References: <20241223144737.554992-1-raymond.mao@linaro.org>
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

When that function was introduced we were only using it to check if
extending a PCR was allowed, so the name made sense. A few patches ago
we used that function to reason about the EventLog creation and general
usage of PCRs , so let's rename it to something more generic that makes
more sense in all contexts.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/tpm-v2.h | 5 +++--
 lib/tpm-v2.c     | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 8c43f4fd9b..87b2c614ad 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -732,12 +732,13 @@ u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo);
  */
 
 /**
- * tpm2_allow_extend() - Check if extending PCRs is allowed and safe
+ * tpm2_check_active_banks() - Check if the active PCR banks are supported by
+ *                             our configuration
  *
  * @dev: TPM device
  * Return: true if allowed
  */
-bool tpm2_allow_extend(struct udevice *dev);
+bool tpm2_check_active_banks(struct udevice *dev);
 
 /**
  * tpm2_is_active_bank() - check the pcr_select. If at least one of the PCRs
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index cb636414de..0edb0aa90c 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -197,7 +197,7 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
 	if (!digest)
 		return -EINVAL;
 
-	if (!tpm2_allow_extend(dev)) {
+	if (!tpm2_check_active_banks(dev)) {
 		log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
 		return -EINVAL;
 	}
@@ -896,7 +896,7 @@ u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo)
 	return 0;
 }
 
-bool tpm2_allow_extend(struct udevice *dev)
+bool tpm2_check_active_banks(struct udevice *dev)
 {
 	struct tpml_pcr_selection pcrs;
 	size_t i;
-- 
2.25.1

