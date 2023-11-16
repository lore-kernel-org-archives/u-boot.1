Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EF4C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D752874D5;
	Thu, 16 Nov 2023 05:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NQIDU/4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013A1874C8; Thu, 16 Nov 2023 05:11:37 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3956874A0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7b017766ac8so12353339f.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107893; x=1700712693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cf1IJrxOvjmu7NKiRL/6yMUVf/OWk7evRe58B33B3yE=;
 b=NQIDU/4jGpeom7ahReKT4aNQ00OgtHG5R6SfY7FKMUut8pBvueYimyslYnI4lDrZps
 FKltlC0fTOCI2vFHmeFNSn2PEDLKi6R1ZEkPSXSAr/vwCVFxP4ouec8f+ukIvh0/nG8p
 7mxNPRDHmdk+NFMQolxbQ4LxgaBNOb7ZkFsFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107893; x=1700712693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cf1IJrxOvjmu7NKiRL/6yMUVf/OWk7evRe58B33B3yE=;
 b=w2A/UGF9dPImx5HcZsRcqNWfPMChqJcc1Q5S6yXgbFR7Eu6WazJE9p8gVEh2waKndZ
 Cw9gwm6Eb4Xyryd5rhJsTOtltZlFs6cKuQTVf/7PxrRGMfdaHAetbgrDpFuTO8+bbCuH
 +F7CKZCPeOH45eopw9qctM9cJE8HkDLSS1KaxImTD1EcufacwVg+VxKcTvfMdZuJsnIz
 vEgClVs6MV8D9t0rHOoaFT7alzgtl3oFPU4JEN/tsLTsZovXApmi9SQk7NR9PNSGbZBA
 2hlI/i+keLjQfj49i6FfSyqKklpHcRm/NHvr89dpPdi/Qc9Vy0YGsS4ODfGn6FKpm3GU
 R3Tg==
X-Gm-Message-State: AOJu0Yxz1S3UdW13m+aeRzbQv+rKEQxOpknvRBaVKnQqGbIk8RTfSl7G
 zSqbrFmyJMzjMeYvXWRnjOCe4OFsx7zqi89uaoz4+A==
X-Google-Smtp-Source: AGHT+IEB/SXS3mNTtv1QWn0tiG7OAkk8q5DxDkRUmtmhsJcfwTyZDAjhW6EW2VfpF5ZA4ivwbnpBuw==
X-Received: by 2002:a05:6602:2c90:b0:7a9:61fa:9605 with SMTP id
 i16-20020a0566022c9000b007a961fa9605mr21525657iow.5.1700107893373; 
 Wed, 15 Nov 2023 20:11:33 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 16/32] bootstage: Drop BOOTSTAGE_ID_FIT_KERNEL_INFO
Date: Wed, 15 Nov 2023 21:10:16 -0700
Message-ID: <20231116041043.362055-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

