Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB62E784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 15:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD5383B07;
	Sun, 28 Dec 2025 16:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PJXoqQD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2504D83AAE; Sun, 28 Dec 2025 16:18:35 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383148392C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so9872285a12.2
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 07:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766935112; x=1767539912;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzJuXGQSStABSLVPgjHFs97hDaXLItw0yHVdWoWGDI0=;
 b=PJXoqQD35GzynCkbHRdnpXV8Qs4cOrV8LHmBq0qxb2gZHSaVYPg+vKdOL7lA2CUnbT
 b24esKEDXaVuRKTbfIgOarV0/antCgxeUVOGmjw8699Nk2MS0vqmzxTP93NbAEHWIRJj
 rpvg2AYt0rE4WGvL02xRfNQXUMXkmtC4D9PSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766935112; x=1767539912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YzJuXGQSStABSLVPgjHFs97hDaXLItw0yHVdWoWGDI0=;
 b=ggKi3zh0IgC+VroytcvFx0OkRPN3+Ogm40Bgchoa/4t4eMj15e5vr10S4dcb9d69iX
 uSHFXLJa3gZft0UdVU2tyWU+XjmCD05Tnm/A79vfbrOfA3OgkVWDwKTkhiFyrQ4yxvIk
 l3+BNmCBbjmGJB8M5sm4wEhBlDGl38RIvgtBbrKKROSdDb0Bz6RcrXDn0lar+3Wc5N1V
 znaIlX75L0fiRkhj3bRK3d4nBWhQsGTVLRbU6M9lXHn83/2BUz0gk1cBmN/yEa4aTqiC
 HBha/CGhexJklo786bkVmpFCQxGDsEvoCx9oW0QwoRhga1AqTJCZm+/If5UuaJHSUWbw
 g1rw==
X-Gm-Message-State: AOJu0Yx+Q+UdTjE9W/DF+8eJfCXmUeqpUhMcTY6KtpPhe5MzMiOUuHi8
 AF5XVH2dMVMviMiGYMXo9ksGmkxm9rAYujV15lMaMFiG2qp8YSEhRDj7za0Obc8MTgwuigS5cAW
 q5cQM
X-Gm-Gg: AY/fxX76zzfgOame02uNqK4+vfLAf0DPk5IC83Be5oxinSSBxD85kvxdXYv56Aj4umD
 gGAcFwWSIM/DnOeUUTno2Kv4/8lFMNLnrOYLy/GW4rqXR5eGKizvYKVL5quSPmRaFFO89vnHuxU
 MjwmCmxFm8nLW72u9lMDkCIBJPnUZNQAdXPskrpqnTFq52NvlP64jRC/3I2Bh0MH8Hx0pi4Rr46
 1+ZeiRj3mCeldvgxrb5BflmgK6t0ADEnvh1tOJBBormL6MPqVl3P7tPrVZZH3lmkiRTlk/l6k2Q
 Z6ZAb3b+Ym0QIU4Sq4yfQqhVCfwda00tFRUpRC0lwq3GtXn1rbFDtsKfXjyeuA+OL/1AJ/oMY3i
 deUeAPqy5ReGlUPNY/5aYuhhxRBv2bO87A/rBgEaMttAraFkPjI76r/IYzdIyqPHGoFEUtZfhkG
 q0YtpOOxjaBF1s3n9ITvKAf+HS06N+gkQeiF3/e6YKcofLH26TyGAi61CbxXr1K9/MsI4KASueI
 duUp4JwpGS1EINIwAcZM0Iilw7b4W4BkbBcKeXygMMsxmAiuW5qbCXK3SVllEkcx9DsebSOTpBa
 CrmVnhpq8KU=
X-Google-Smtp-Source: AGHT+IEiBDBMmaGyA055p3nOHJnDhGWB0kfZg0Vagza2fSCyJ/k0RdTwdQWDBFWnJsI8p+dw4e1i4Q==
X-Received: by 2002:a05:6402:d08:b0:640:7529:b8d3 with SMTP id
 4fb4d7f45d1cf-64b8eb73ab9mr22377742a12.9.1766935112424; 
 Sun, 28 Dec 2025 07:18:32 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494cd7sm28502224a12.16.2025.12.28.07.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 07:18:32 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] fwu: centralize bank state macros in fwu_mdata.h
Date: Sun, 28 Dec 2025 16:17:52 +0100
Message-ID: <20251228151824.25667-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
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

Move the bank state definitions to fwu_mdata.h so they live next to
the structures they describe and can be consistently reused by both
U-Boot code and mkfwumdata, avoiding duplication and reducing the
risk of mismatched constants.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 include/fwu.h       | 4 ----
 include/fwu_mdata.h | 4 ++++
 tools/mkfwumdata.c  | 5 +----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/fwu.h b/include/fwu.h
index e7bd1d492af1..c9549019601c 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -80,10 +80,6 @@ struct fwu_mdata_ops {
 
 #define FWU_IMAGE_ACCEPTED	0x1
 
-#define FWU_BANK_INVALID	(uint8_t)0xFF
-#define FWU_BANK_VALID		(uint8_t)0xFE
-#define FWU_BANK_ACCEPTED	(uint8_t)0xFC
-
 enum {
 	PRIMARY_PART = 1,
 	SECONDARY_PART,
diff --git a/include/fwu_mdata.h b/include/fwu_mdata.h
index d2521f39b42e..43b3487c4a23 100644
--- a/include/fwu_mdata.h
+++ b/include/fwu_mdata.h
@@ -9,6 +9,10 @@
 #include <linux/compiler_attributes.h>
 #include <efi.h>
 
+#define FWU_BANK_INVALID	(uint8_t)0xFF
+#define FWU_BANK_VALID		(uint8_t)0xFE
+#define FWU_BANK_ACCEPTED	(uint8_t)0xFC
+
 /**
  * struct fwu_image_bank_info - firmware image information
  * @image_guid: Guid value of the image in this bank
diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
index fbc2067bc12d..0d1697622e6a 100644
--- a/tools/mkfwumdata.c
+++ b/tools/mkfwumdata.c
@@ -33,9 +33,6 @@ typedef uint64_t u64;
 /* version 2 supports maximum of 4 banks */
 #define MAX_BANKS_V2			4
 
-#define BANK_INVALID			(u8)0xFF
-#define BANK_ACCEPTED			(u8)0xFC
-
 #include <fwu_mdata.h>
 
 static const char *opts_short = "b:i:a:p:v:V:gh";
@@ -297,7 +294,7 @@ static void fwu_fill_version_specific_mdata(struct fwu_mdata_object *mobj)
 
 	for (i = 0; i < MAX_BANKS_V2; i++)
 		mdata->bank_state[i] = i < mobj->banks ?
-			BANK_ACCEPTED : BANK_INVALID;
+			FWU_BANK_ACCEPTED : FWU_BANK_INVALID;
 
 	fw_desc = (struct fwu_fw_store_desc *)((u8 *)mdata + sizeof(*mdata));
 	fw_desc->num_banks = mobj->banks;
-- 
2.43.0

