Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA45C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 18:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5267A88890;
	Tue, 23 Jul 2024 20:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jBgr4ADN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C1AB88886; Tue, 23 Jul 2024 20:14:52 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96AE78876D
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 20:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5c669a0b5d1so3491877eaf.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721758481; x=1722363281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRsO6VmWB1lCczjG4aRpiPgyxqRccJBmQzQdXC0BsdQ=;
 b=jBgr4ADNJ2gQbaj3V/gcAwhz/773evRACX9CBpDf4LSI7ICqoJm5FmtzSCb2+/2qEv
 H1wIOCyzYpho/+a7VvQYJneDtKLKzKrnV8t8XrvrFyZACNrCKjekI8YsgbyhPuImlOtc
 HjjCMhnYYMo9hGg93K5rxHNUzt0K9QgbDwvIaI0RW+pUb3vmZHIqhqSYy9bPfOEGFoiK
 tmkMtMSHf5bpbPfQiFMZ5uPDQSEdZJ7wxhoYnEb9CI3vIBIvwmfYHyuqbCtYdhqGE5k6
 ZHLmRVgs3RmJJ89kaMECL0endwAuRoU0JAlUsahPOsMPs3IL+hUV1SkwHdEC8YyGx/UE
 AYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758481; x=1722363281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRsO6VmWB1lCczjG4aRpiPgyxqRccJBmQzQdXC0BsdQ=;
 b=OLBTtaNdicZvrvUKRcHdqVPOMSOLL0kNyQ9NuGP5cIKcVmqTX1vnIulvgFOZuk+PQt
 +NHJAZvEWB/UXbsRDadcAihqaK+Yu2DdZfR/HNIXroOfjrQkHidM6xlJT6tVOJDjGqZq
 OXE+x8N78fkxDAoFA1qNBMmeM8PzBmRzZG9OZYbHba7ZMRYKKLmWargvH3nZOiCncx/k
 eTSUap1Yd4ooxOWTsSSQqCMtXfro3kHZMz3lYB0kV930ybRUxqB1K8hYz1kT9iGo0H3c
 tBKSOgBhhUlHwiYzTMsgXCofY2RfHkZ4EtEWBytWmoDJolHwaSlc4srIvrkZv8dj/8yb
 9jfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGzBcqlyv2+9qfPlvciV8i4XQNTZn1msYHKC5KREg6OB9TevC9ZJyGRl7qUSP0JDnx9S9YGbooNxmVOYF7bnbkPyMosQ==
X-Gm-Message-State: AOJu0YyFOpoZ69L5QVVRyC7/7QKca7VvvQjVFvGIoqhBmiVSTmz6GVE4
 o+LC8F7Gfki87zt1VFIJCe8aQU5WXTk5MGYlMXxK8ft5sxG4Tf0xHz2VH4bCFlM=
X-Google-Smtp-Source: AGHT+IEvhSA/PBzqtpBrn2Ps5fRhE84AArJ88BATzBuFF/AeZ9rGmUJN+OuZhSC8D3OVcsQe39n4LA==
X-Received: by 2002:a05:6820:2014:b0:5b9:e7db:1cf8 with SMTP id
 006d021491bc7-5d564f82ed7mr15422484eaf.4.1721758481314; 
 Tue, 23 Jul 2024 11:14:41 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d59f048948sm2285eaf.30.2024.07.23.11.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:14:41 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 1/5] board: samsung: e850-96: Add default partitions
Date: Tue, 23 Jul 2024 13:14:35 -0500
Message-Id: <20240723181439.7089-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723181439.7089-1-semen.protsenko@linaro.org>
References: <20240723181439.7089-1-semen.protsenko@linaro.org>
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

Add an environment file for E850-96 board with default eMMC partition
list. It follows the Samsung's partition list used for Android-Q on
Exynos850 devices. It was verified on E850-96 board with:

    => gpt verify mmc 0 "$partitions"
   Verify GPT: success!

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 board/samsung/e850-96/e850-96.env | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 board/samsung/e850-96/e850-96.env

diff --git a/board/samsung/e850-96/e850-96.env b/board/samsung/e850-96/e850-96.env
new file mode 100644
index 000000000000..f36f90be9509
--- /dev/null
+++ b/board/samsung/e850-96/e850-96.env
@@ -0,0 +1,26 @@
+partitions=
+	uuid_disk=${uuid_gpt_disk};
+	name=efs,start=512K,size=20M,uuid=${uuid_gpt_efs};
+	name=env,size=16K,uuid=${uuid_gpt_env};
+	name=kernel,size=30M,uuid=${uuid_gpt_kernel};
+	name=ramdisk,size=26M,uuid=${uuid_gpt_ramdisk};
+	name=dtbo,size=1M,uuid=${uuid_gpt_dtbo};
+	name=ldfw,size=4016K,uuid=${uuid_gpt_ldfw};
+	name=keystorage,size=8K,uuid=${uuid_gpt_keystorage};
+	name=tzsw,size=1M,uuid=${uuid_gpt_tzsw};
+	name=harx,size=2M,uuid=${uuid_gpt_harx};
+	name=harx_rkp,size=2M,uuid=${uuid_gpt_harx_rkp};
+	name=logo,size=40M,uuid=${uuid_gpt_logo};
+	name=super,size=3600M,uuid=${uuid_gpt_super};
+	name=cache,size=300M,uuid=${uuid_gpt_cache};
+	name=modem,size=100M,uuid=${uuid_gpt_modem};
+	name=boot,size=100M,uuid=${uuid_gpt_boot};
+	name=persist,size=30M,uuid=${uuid_gpt_persist};
+	name=recovery,size=40M,uuid=${uuid_gpt_recovery};
+	name=misc,size=40M,uuid=${uuid_gpt_misc};
+	name=mnv,size=20M,uuid=${uuid_gpt_mnv};
+	name=frp,size=512K,uuid=${uuid_gpt_frp};
+	name=vbmeta,size=64K,uuid=${uuid_gpt_vbmeta};
+	name=metadata,size=16M,uuid=${uuid_gpt_metadata};
+	name=dtb,size=1M,uuid=${uuid_gpt_dtb};
+	name=userdata,size=-,uuid=${uuid_gpt_userdata}
-- 
2.39.2

