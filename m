Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E6AEC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051D686ACC;
	Thu,  7 Sep 2023 17:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lWQECVnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CAFB86A7B; Thu,  7 Sep 2023 17:59:46 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F1F686A7D
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34e25ad38cbso4705205ab.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102380; x=1694707180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wa8zTccRvHCzKytOqq/6zuYeGX/X+GHliY8eBPBMEeM=;
 b=lWQECVnKwhC1pTapVhxYsvDKRZTFtBipR9icWuOeUBg5we1dLZTgFOPRQFd3fMYQnP
 j4/rW8S8ShzznpAPVF4LvRs9UFVABQ7nU8TWuTjHBl0peLYLDbiaCitcyJ/I/0n1GyP2
 qPH5o4l4SofUkFI4UbNZIkd0TgbX69yBB7HMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102380; x=1694707180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wa8zTccRvHCzKytOqq/6zuYeGX/X+GHliY8eBPBMEeM=;
 b=eLAGwHCBMUMOjn68/IXt1towhLytFnbvhMaKCrLcP+cLEG599JuEXNCyIU7JLVlARG
 eTbVN4mxPG8ivCrmOODBLRqqGqehcoE+Z52FF9P2HUQEzoSS9ZWIMUyZuhmwnLEG5Z1+
 QEXRkNjr387O3YNlTS4XsMPEzpoOiRwLsSG+JPC1GB0GLGd2R5JkvXpIMl0PaUTiCCDF
 5zXp7KIB9pfHI+s5L3JS7A58M1p8NVYnyOMwWjsjHSqSnOCBODEObJSHRMTOdFDyPKe8
 mze0M42mo21CkPKqDMH6Ggr9AmRzcVywbmcANL+zTP9YebtIpA/TUqLdJ1m/BBTTBUf4
 BwWg==
X-Gm-Message-State: AOJu0YwQUnrJGSM13LWQbsf9eiEBwbuwuNuhXnoMSEMrUCPggNHhAwkc
 Gceq0rZVl4hU07TEwlLA0cTC6d5vWVXqFEMbzWQ=
X-Google-Smtp-Source: AGHT+IEQzXcx21eDUQjo8Ex1vnK5hF8PFVfMlHMtefeFLpbQf6hxhL0SXUyrK+pRpVUc17SzEfavLQ==
X-Received: by 2002:a92:c7c6:0:b0:348:6736:6605 with SMTP id
 g6-20020a92c7c6000000b0034867366605mr130859ilk.9.1694102380229; 
 Thu, 07 Sep 2023 08:59:40 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 01/22] lib: rational: Move the Kconfigs into the correct
 place
Date: Thu,  7 Sep 2023 09:59:06 -0600
Message-ID: <20230907155933.48511-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

These should not be part of the 'system tables' menu. Move them outside
on their own.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 7d0f3fbb93c ("lib: rational: copy the rational fraction lib...")
---

(no changes since v1)

 lib/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 42e559ad0b51..9addcfab3734 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -989,6 +989,8 @@ config GENERATE_SMBIOS_TABLE
 	  See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
 	  the devicetree.
 
+endmenu
+
 config LIB_RATIONAL
 	bool "enable continued fraction calculation routines"
 
@@ -996,8 +998,6 @@ config SPL_LIB_RATIONAL
 	bool "enable continued fraction calculation routines for SPL"
 	depends on SPL
 
-endmenu
-
 config ASN1_COMPILER
 	bool
 	help
-- 
2.42.0.283.g2d96d420d3-goog

