Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2F6C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 03:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3FFB8886D;
	Tue, 16 Jul 2024 05:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bMm1Af9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDDCD88700; Tue, 16 Jul 2024 05:17:16 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 899A08886D
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 05:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-703d5b29e06so2148044a34.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721099831; x=1721704631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+/EhGbF7uED+WrF93cqZtU6+YxK+nW3bD+OFywOHZ4=;
 b=bMm1Af9AlBMVVrxNbSD1Mh/jJRZT/NgZFn8B+T1TVWI4qDCdX1MdkiZDhSqstWuzU5
 mSFIQoz9JP9y7iVf0Ln7N1z3EVT2TUmza1n20GvrzUXI48OilVEXnLIPsWciHpBIRXzl
 Ty16DGC+9RtIwhWA+YQEgk0ahEd4hNTfbLVpoehZTz2HMlVu3hLA61FFZv9RHSvzp0rV
 kuwTBYRMGXNsuTmMH3ADu1gu/ZBfxSqaka6vUNdSKf6Lghi3ra102PpMLngyKPzdw8FK
 +ofl0LRDyBCazYj8dcwXn+3QHBkquUoVyitlZgFoQpxUi8BvJoCXjcITbXujUr2moN66
 9ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721099831; x=1721704631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+/EhGbF7uED+WrF93cqZtU6+YxK+nW3bD+OFywOHZ4=;
 b=VX6wkbEQ+zwSyznqdQN7ZbPAmDVXvQMqFLyQpCVBFrH5IBLvotAT0sApfKj0vmIUAZ
 TlT7+8VLHN/N/xe3j3Ti+25AACXJlH1qiKiVqCRRMLiHyqVTAz21zdJCLqDCcyxkb7jl
 i2Uk/BIp8PSoQ1TgEDZEMDtjoT5O3iQfnh3+W8J5Cuvgh6KgbGUirvXP4BSDjc7mmK+o
 rTka9zfcV0QXFQ/cuPFm1oDsjxM3sVpnq0kEdXVoniRlHJS1RvF4cz4BuAgK5oHW80kM
 PbZ6VKLf3QdMkHJFrb2SwUNAMc0Cl0Kl80+m9rIlz+/yJTpCl4KvzrEFqnqdXTgam2AU
 k+Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4YuEoMm0T2j0/lHZA2JgYDw8mAnC+LC9gWobCQCCm6B6xsccAwuulB9+T0ACPG2QgKOSQyByhSDTWCcJ1BCD6d0LoAg==
X-Gm-Message-State: AOJu0YwanTnDqpWCtO0IDGdsIDOmUVs67v3mJ4lLXDNOOcBLQbUoobxx
 horoRoBbrlWjnCh2t7gQi0mxpdz3ScKUpuIIlidnUYuQtkXr5ay4defJa1FEyV0=
X-Google-Smtp-Source: AGHT+IEegGPdc0eMtPBWTDv5EF3/UC66ybRYz6JjwGXhE9UR+E9Vgi/fqrwG2OJ8oaCH/Ht1BIsRFw==
X-Received: by 2002:a05:6870:8a28:b0:25c:bb8b:85bb with SMTP id
 586e51a60fabf-260bdd82c3fmr512184fac.18.1721099831135; 
 Mon, 15 Jul 2024 20:17:11 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d1f628sm1176585a34.67.2024.07.15.20.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 20:17:10 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 1/5] board: samsung: e850-96: Add default partitions
Date: Mon, 15 Jul 2024 22:17:05 -0500
Message-Id: <20240716031709.24943-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716031709.24943-1-semen.protsenko@linaro.org>
References: <20240716031709.24943-1-semen.protsenko@linaro.org>
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

