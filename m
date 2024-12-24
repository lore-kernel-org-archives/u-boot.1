Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119E9E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3B6807A7;
	Tue, 24 Dec 2024 17:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O99Fc+qC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6617A807DE; Tue, 24 Dec 2024 17:01:45 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBBB801F5
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d8edad9932so35056616d6.0
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056102; x=1735660902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMB/fCH/nFRLbnvFwEAo1abjqNq75/1uJY+UdEeSwAM=;
 b=O99Fc+qCfAnSkwnZOl4QxpKHXcn/r17+OnWy9sYowtR18qNUQ3iM5oOT+MVbL8hs3g
 Vo/bD6Z6mgz7FXnQtTDtOzZwcvWZF6Y0xqnJ/huMeKzrWvOTsD8xYnHroz5lWC4+ExmJ
 10+PcflVVxmc34NvhC8N7549lRu+RJt2zH6tfD6wihYle0gSmaHj4vYmuI1aa4UooBBZ
 B/SLucI7Ruq8jkcYwCze0Ms+k13ag9zpp60Blu0PE+bdCs89CkxVWVqDzj9LXWJxMiNQ
 3l+g3RKGRCQ/JDlztlkVwJdq1VixW5F0e44PoBf1FlsXddUBA1t954+iHVbOspW3mosF
 yHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056102; x=1735660902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMB/fCH/nFRLbnvFwEAo1abjqNq75/1uJY+UdEeSwAM=;
 b=WaH1nn3Fwb9ZoiPCtMLosN8AQmqVaTf+44QuhTHzZdzISAy2sFAoDuCPgii2uh+n2p
 wmBv4vNN1p0wceUxlbTPagMQbe7qWV0YTIkRbilOs4kMJHuv9fXUUHtMMFD+qp79xQkW
 r/7NUETTN/X5X2Nm3elmjw1PGgqr7+NY19cM5RPSnRw6P+59Z96pxE1HYOcKxJMV69f6
 W7Q0Ie5yjt8adTGsudeus0kNI6oFuHAsF/xxzNF0JgIPsIdHJHZCIfbw6Eb3Gubfo6gZ
 td5G30lyEKzhcOohS8BuOUCbs2kesG8vNii4IDDDKrWkRvRgvjjoe7vDya+oXFiX+3Ts
 latA==
X-Gm-Message-State: AOJu0YwjmpD/xiokwsSnVXzRG7XOvfIwy1U5VGzLXRYF9LSHL7845wXD
 +d1Efw/0Q/K92UWPTHOWfu/b7sdEaAaai1X3ZL7aZCWsilTkM873lv2mw6e5NZzHzDu4ogh5Ism
 5
X-Gm-Gg: ASbGncsCXgu9v4hDPv9Hw++P47IwEUorOLgav1BSicD/RkdPtMWSCisXAGksUzwTl6C
 g+k2vw1+JoFpph5yZUZn/6TYATw+ChjUY6BmZkp30bkFQFUj27I63yZ87U7kiRq3l4nsLpRyDQS
 fHavzV9643q05Vzx/F27nPSVXS2I/qyYr65mnGQOFX1mir9bztLGrwBm8+G/Ns/AM/Phf1P2T0n
 /aveOE+kiK1QQDAkmJCLR1UP8MBdf2R9XRVrax82vYJpNySlUbpagJlnihERlwW4BueRbLQceZ6
 Vl/Mvr4VjgsmDiyIkk1aKA0eWwDBS8q01xC+PtJv0korYayD4D2Lu9w=
X-Google-Smtp-Source: AGHT+IEYkBQzBe2UjdD1w4Y04X/D9dVZEC4ioLHvIy6SMKUHBdyvWkguxZgkLxAZMyat4PY53E3rlA==
X-Received: by 2002:a05:6214:767:b0:6d8:96a6:ec22 with SMTP id
 6a1803df08f44-6dd2335741dmr305361346d6.23.1735056101803; 
 Tue, 24 Dec 2024 08:01:41 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:01:41 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 02/11] tpm: Rename tpm2_is_active_pcr()
Date: Tue, 24 Dec 2024 08:01:04 -0800
Message-Id: <20241224160118.675977-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224160118.675977-1-raymond.mao@linaro.org>
References: <20241224160118.675977-1-raymond.mao@linaro.org>
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

This function is checking for active PCR banks, so rename it
to something that's easier to read and closer to what the function
does.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 include/tpm-v2.h | 6 +++---
 lib/tpm-v2.c     | 4 ++--
 lib/tpm_tcg2.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 4fd19c52fd..8c43f4fd9b 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -740,12 +740,12 @@ u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo);
 bool tpm2_allow_extend(struct udevice *dev);
 
 /**
- * tpm2_is_active_pcr() - check the pcr_select. If at least one of the PCRs
- *			  supports the algorithm add it on the active ones
+ * tpm2_is_active_bank() - check the pcr_select. If at least one of the PCRs
+ *			   supports the algorithm add it on the active ones
  *
  * @selection: PCR selection structure
  * Return: True if the algorithm is active
  */
-bool tpm2_is_active_pcr(struct tpms_pcr_selection *selection);
+bool tpm2_is_active_bank(struct tpms_pcr_selection *selection);
 
 #endif /* __TPM_V2_H */
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index ad2b5ab0c3..cb636414de 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -847,7 +847,7 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 	return 0;
 }
 
-bool tpm2_is_active_pcr(struct tpms_pcr_selection *selection)
+bool tpm2_is_active_bank(struct tpms_pcr_selection *selection)
 {
 	int i;
 
@@ -907,7 +907,7 @@ bool tpm2_allow_extend(struct udevice *dev)
 		return false;
 
 	for (i = 0; i < pcrs.count; i++) {
-		if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
+		if (tpm2_is_active_bank(&pcrs.selection[i]) &&
 		    !tpm2_algorithm_to_len(pcrs.selection[i].hash))
 			return false;
 	}
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 7f868cc883..edbe5f3aaf 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -43,7 +43,7 @@ int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 
 		if (hash_mask) {
 			*supported_pcr |= hash_mask;
-			if (tpm2_is_active_pcr(&pcrs.selection[i]))
+			if (tpm2_is_active_bank(&pcrs.selection[i]))
 				*active_pcr |= hash_mask;
 		} else {
 			printf("%s: unknown algorithm %x\n", __func__,
-- 
2.25.1

