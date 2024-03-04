Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA39C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B66A87D7F;
	Mon,  4 Mar 2024 18:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DAneO3tm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26B986F67; Mon,  4 Mar 2024 18:45:07 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD3A875FA
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412bf22b6a4so2458955e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574304; x=1710179104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8Es4I6W/ckZvI4pjafaxAdhh6VCVQz0Q/4qVZhLC9Y=;
 b=DAneO3tmy1OM79PIVBDzNJ1zRFxlw2f6unY/EYMBEz5zgCRGwG3SwZQPijK2ytiDeH
 hG//cXNHawf2GnGUCJ+65MuMYkcx/laKtA6qJdxmfF4ah3F0/rn5nN1Wm5pOZ8aiidRd
 b31rkk4hXXCqpN7HybaP5Ibb1VrV1FVxv8TOV3JtgaY0whYtf1xprZxBlphFpKUhGvDS
 N+1Hv7o7MuRAAoXb85V8PIq/k45o+hmhQ4BZLBh1Way1QjwRGkn9DzplPxPRCB066LBf
 1VUg3WSweWfqi6qPuqFfspcm/c8+V58nkdbwdSzLs/bn30ct/bycBQpZiWmckJ6egnHe
 BRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574304; x=1710179104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8Es4I6W/ckZvI4pjafaxAdhh6VCVQz0Q/4qVZhLC9Y=;
 b=CAkpKLfTAW1nzcoHhDFStN+i/yZfchmm03HMBnMZRV+LreZ0gwYEeEFVoHROf0cEH1
 3wOXfB+aMXmwkUgoK72zXd+oYAhaQU1Gi0M5RYVxOputEfu4Q4oSSdCDb0QqWUz4Xg5t
 Z/+8okf1tfEb1lZonNSTQFO5gAOYk2UvWf2zPDyevujQTTXaNvKYNsfKwAlkt4dIx5e9
 DZ1OyaP6wkR+WTErs4uDL2qXd82oA8H5KncEP06zzGvAZybdx5LPGhMP/ERo+oz7AnVT
 vGUsK4VJFIOCGhylqJkhAJbhWUuschyGTPCPjSxb1N/c84/miImmtaRt6Qrk2NWjaxn5
 4FPw==
X-Gm-Message-State: AOJu0Yy8oEF6Fk6epurmoowrEvbuwmarYSBrLu8IgeZbLDwBBNA/JxJh
 ZOKaSf8qgwQJgPEWlTNMOMxuW+oFpKge/ht8pJPTvT3/FrotdXg8EPGH2C5VAxM=
X-Google-Smtp-Source: AGHT+IFgHrmQVFCPOOJhN6w1TvFHPhd9A//Ep/T+zeDuL6+ng6qkExcB3eg3wH19QS/z6tsM1IilpQ==
X-Received: by 2002:a05:600c:1c12:b0:412:5670:ef62 with SMTP id
 j18-20020a05600c1c1200b004125670ef62mr7547594wms.1.1709574304345; 
 Mon, 04 Mar 2024 09:45:04 -0800 (PST)
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 bn20-20020a056000061400b0033e43756d11sm1913245wrb.85.2024.03.04.09.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:45:03 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/6] tee: optee: fix description in Kconfig
Date: Mon,  4 Mar 2024 18:44:49 +0100
Message-Id: <20240304174454.1484507-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
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

(no changes since v2)

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

