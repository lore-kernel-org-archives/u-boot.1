Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B91C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCD887535;
	Sat, 18 Nov 2023 22:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mEcL4Pwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B87298713D; Sat, 18 Nov 2023 22:06:22 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 740BB874CA
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7b017766ac8so109218639f.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341569; x=1700946369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cf1IJrxOvjmu7NKiRL/6yMUVf/OWk7evRe58B33B3yE=;
 b=mEcL4Pwq/Ywa8hOGm72TwotvvJ4e59GVKtdY14jHQlEL0S9ITN//sh5P++fPwsZ/Nh
 0mIkApevXOvrxUEvNA+odhsid1KzJANHaoSkyFtQmkvvuY0wDRKK+sSRn5HYsyQxgsvs
 /K+2gbOdjaHojm5Q8hf1ZqFtKjudag71asstM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341569; x=1700946369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cf1IJrxOvjmu7NKiRL/6yMUVf/OWk7evRe58B33B3yE=;
 b=pnkqMKJOOKpTDjLq6lTMRKNZTyTZ66khHu1wTQhuYNzpo+XZdFJiP3ediVNc9SGQO2
 w3RdAOt9iAtHvIbj9QJt5He9m8msK4LjytHiIKb53GyAxcJlbPROvvsbhuPXWR/N9ERR
 aMgngi9BTdkW7y+UY0xIX+cDYcvSPnok0+wGK8AwU1JJz+cyqCJ2bswG8f1mKj1us2j9
 iwpi7e7hIpSFVTnkDwIFKtxhZjfSLabzWhjcVVFAO5kAMW/7Ee+hHz4VmymBSkGQdlZU
 9DH+vyGRzGpJIKix7y9SW+WDdJy87DEOn2RGS7XLEWx+YxCKCeP5A3Ty043soVjPzqoj
 suoA==
X-Gm-Message-State: AOJu0Yx3cUWCYX5ZbNGhanLxFgboiJBvMx0l12jr0TAS48uaZrYqdqAJ
 oepxXPoEx2u+3FR7PNiHYdM8ITSfRgF9is93tzsUeQ==
X-Google-Smtp-Source: AGHT+IGiTh6awt+K0u+H/xeU0jLyZXISDXp486GeSluNxjwB94XvKTiIKeW9qWue6BNp/UVkQCCdMg==
X-Received: by 2002:a05:6602:17c5:b0:790:cb89:44eb with SMTP id
 z5-20020a05660217c500b00790cb8944ebmr3029910iox.1.1700341569135; 
 Sat, 18 Nov 2023 13:06:09 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 15/32] bootstage: Drop BOOTSTAGE_ID_FIT_KERNEL_INFO
Date: Sat, 18 Nov 2023 14:05:03 -0700
Message-ID: <20231118210547.577026-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

This is a misnomer since we don't necessarily know that the image is a
FIT. Use the existing BOOTSTAGE_ID_CHECK_IMAGETYPE instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c        | 2 +-
 include/bootstage.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index a23c791a9e15..9bd93f5dee7a 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -233,7 +233,7 @@ static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
 #endif
 	default:
 		printf("Wrong Image Format for %s command\n", cmd_name);
-		bootstage_error(BOOTSTAGE_ID_FIT_KERNEL_INFO);
+		bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
 		return -EBADF;
 	}
 
diff --git a/include/bootstage.h b/include/bootstage.h
index affb0e5c6a6a..59a76d0f0c40 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -147,7 +147,6 @@ enum bootstage_id {
 
 	BOOTSTAGE_ID_FIT_CONFIG = 110,
 	BOOTSTAGE_ID_FIT_TYPE,
-	BOOTSTAGE_ID_FIT_KERNEL_INFO,
 
 	BOOTSTAGE_ID_FIT_COMPRESSION,
 	BOOTSTAGE_ID_FIT_OS,
-- 
2.43.0.rc0.421.g78406f8d94-goog

