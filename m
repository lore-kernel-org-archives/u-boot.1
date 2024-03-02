Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BA8C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 22:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE08A87EA8;
	Sat,  2 Mar 2024 23:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q5xf+ohA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A654C87E96; Sat,  2 Mar 2024 23:01:18 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E3F87D37
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 23:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33db19538d0so555930f8f.1
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 14:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709416875; x=1710021675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrYpm3Mdloq0Imvrx+n4MXvSM5vtYi5gsMBr9D/7E4U=;
 b=Q5xf+ohAlSXCxwiShtEniG9fbb+yaegw1gyV5Af4kGoimhKLvY/8gsNf3YtduXR/GV
 l6EvPz2zL5h/C1D5VK+Po8kcvp28u/NxSb2NuZrzioSdaw0zOCupOqEqs8OvaKWEd2xE
 dIGmEBMuqBHM6AOAhXeoO7YwW8119sqg2xjfPjC1JuHTIx0uRtgZJL9CAG7glyTUS3hI
 WjUsIN0x2rqD+PbOuvFLPqi5RNC4iYamRP7k8DVxLGr1XA5cW3I2D+pXipOy5MyF7axf
 FvHTq2WhQMVHJu00sca71xk/WzvnNxrpKGrBbWL8ld59GDk7GIXs6m6pfa7tpWqi4Xsm
 W/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709416875; x=1710021675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrYpm3Mdloq0Imvrx+n4MXvSM5vtYi5gsMBr9D/7E4U=;
 b=Q7gvPOKnmi9YHfQ0+68/Nt0aYL9plNGVTxAdu36t0dKX1MN+fZ46y/DowKGxNFPrsn
 P5DnZaP+NiXXuad0pYCsPynJxdEhd1HoDJSGizqqx4SvgbtqPpxFqDnWmpjk+XXld1Vk
 Q+p76inZXAM4eH7jQDsn9NTDuv3eDCYmT9+1aYmKjjFx1RBWkwip04iFDslPGUGbWM7v
 L6otysSWGRk8Vo1lh5FUkk1zj9lGyj/D6vUTX1IZATKPqNloXQfWWfe2O1X5YKkgznYL
 6gn/W2y2SEp0CAzzeykMhFs3WPYp4RlTVwRih7tfvRKfwDCZZ37Pf734ds7YaPHa9nRq
 l9gw==
X-Gm-Message-State: AOJu0YxU8/6WAkbBn35+HQ3jqrNRpjCWK001ly3BE7rMqU2FeeQiNfJZ
 dCBAS7fCyTTZ5QYBnRdukqyzPYVk9sQgSvdPRF4FRu6FIW8c+pODtEt9AKBu
X-Google-Smtp-Source: AGHT+IGMGCZ6+6zP5HprSJkVZdRXHTdFqItMq4S/yQ0RpLbMQE7cUoaj2rhByA7+tiBe026DTtzHOw==
X-Received: by 2002:a5d:550c:0:b0:33e:1b4e:5a0d with SMTP id
 b12-20020a5d550c000000b0033e1b4e5a0dmr3787412wrv.6.1709416875077; 
 Sat, 02 Mar 2024 14:01:15 -0800 (PST)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 e13-20020a5d594d000000b0033e12b2e567sm7399471wri.35.2024.03.02.14.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 14:01:13 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/5] tee: optee: fix description in Kconfig
Date: Sat,  2 Mar 2024 23:01:04 +0100
Message-Id: <20240302220108.720637-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302220108.720637-1-igor.opaniuk@gmail.com>
References: <20240302220108.720637-1-igor.opaniuk@gmail.com>
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

Fix OPTEE_TA_AVB symbol description in Kconfig:
s/"write"rb"/"write_rb"/g

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Applied R-b tags

 drivers/tee/optee/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 9dc65b0501e..db0bcfa6f15 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -19,7 +19,7 @@ config OPTEE_TA_AVB
 	default y
 	help
 	  Enables support for the AVB Trusted Application (TA) in OP-TEE.
-	  The TA can support the "avb" subcommands "read_rb", "write"rb"
+	  The TA can support the "avb" subcommands "read_rb", "write_rb"
 	  and "is_unlocked".
 
 config OPTEE_TA_RPC_TEST
-- 
2.34.1

