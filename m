Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461B4CD1299
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 13:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F31888281;
	Thu,  4 Apr 2024 15:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EknUSRcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47EF88274; Thu,  4 Apr 2024 15:20:04 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B3F88274
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 15:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-51581c51ee6so244277e87.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712236801; x=1712841601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8Es4I6W/ckZvI4pjafaxAdhh6VCVQz0Q/4qVZhLC9Y=;
 b=EknUSRcLY7F9mjty4Ux1Gxb0/Wzp/1dgZ6RcLoAcI2KkhfrJuJxfY6HhJ7vopEaD6h
 11Dl8Z/E9lcNjBU2l+V7MHcEhLDlpghiaZF0jzpncvP+Xwb3O2p9GJ5tdqomgRG5jwaJ
 Hj/rV4iL8fpZcaxewKVeDuYXaImTgT40najcF9IjtWygWy+ml6f43sn3YTsVB4Fdllm2
 pBmO7HP+3MRoCHWExs8BXEu1lFQnELj3m+vTPs+FONaARn7s5yuil7kGjFzUhoeD5LZU
 CaHtzt5sRP+kMGbttHZaUCl/ekxfsajX0fpgbSu9/+tqF/WlHXBElkgY7pdkyCuqo6uU
 L0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712236801; x=1712841601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8Es4I6W/ckZvI4pjafaxAdhh6VCVQz0Q/4qVZhLC9Y=;
 b=hb0aZZ8p2bNnQy3+BO4o7sXHGjNOTP++EKz1l/tP18cGG7mRaeqgjIMOZq3TOBCPQa
 z+rwlJ4L+KWt4EXTeujo4i0vaXz9hyrLenc0fk2CODWH7U/b0YK5H57Vuf5pPf4+RlJd
 M9tW8D/+NRO6lRhjbrEeHEaes2Z8h5o09s/zjZGORzpierdyf6vKP506PRFEn1TygEns
 rEIIPWsnTTvbFutXiQVyF3W55RS0pgYzqW3vzO2WhU5HvvSz2OjbUKo+1XdplapQ75rt
 1EdZaKT19IQsknsMW1dBnOTGV5SQR/kS6vbWzbsseSdydsLn6B8nwcZfzgaN+Azc8XTI
 42Pg==
X-Gm-Message-State: AOJu0YwynqeFEc56voDfG8w4OkzX+qn69IxBqed0F1DloPB59tNZalpR
 YayCOSaaxEpG7i8trlNV79vqoU9piXw1oeGHy4LQ/QbZgKTr5v2lxGwEGPSs1cMFsQ==
X-Google-Smtp-Source: AGHT+IEmHdEfigX4HO2gSCFAaACGZSiGxmJZIrb5Ojd4Pw/LnWYH6WqBNpxroQJDy9K/fmnIE1v1vg==
X-Received: by 2002:ac2:4c19:0:b0:513:c428:9daa with SMTP id
 t25-20020ac24c19000000b00513c4289daamr1572434lfq.0.1712236801140; 
 Thu, 04 Apr 2024 06:20:01 -0700 (PDT)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 m10-20020a05651202ea00b00515aa359f8fsm2304994lfq.225.2024.04.04.06.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 06:20:00 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, jens.wiklander@linaro.org,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 1/5] tee: optee: fix description in Kconfig
Date: Thu,  4 Apr 2024 15:19:47 +0200
Message-Id: <20240404131952.3252301-2-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
References: <20240404131952.3252301-1-igor.opaniuk@gmail.com>
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

