Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D73C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 23:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 549C5887E8;
	Sat, 13 Jul 2024 01:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="juwgbRXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291C0887BB; Sat, 13 Jul 2024 01:43:12 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AA4887B4
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 01:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7044bda722fso1471478a34.2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720827786; x=1721432586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxc26+l1p/vXRDNYXTVgXSedOEPQbWCEP4SqowQJFTo=;
 b=juwgbRXA7Nf7FZudr/tld2z1Jj/Y56f12MCwsJLMjdQHOSR66cuspT/tiSXjhSw7c9
 A1ez867PJTG3OzJa5Oc6dD6nsl41D9fRZOGMy7zDQFXa3yrl/8ZFJCdy4yvd8sbZwTKn
 mJh/2IMdYxr7nbED8EkShErGZMfWHxkWh8FPCtUs2pPh3EhHyvp1jmjyv8nK9w1iQeJK
 9DO86Ku/YVV9v/QinbKTDqUanyj8T3E+suHhvhLLK6DIhQEIzCTIPJo+6dB3pnvm06zT
 TfNIMMf5s7rnO10Xrje0Us+ttZqpITihm4Ip6hWnVCtGsDlExdoRVU18Oc633T4YkaAg
 iEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720827786; x=1721432586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxc26+l1p/vXRDNYXTVgXSedOEPQbWCEP4SqowQJFTo=;
 b=BQJk/OI3zI2RabzFM8dr9YB1c5KZ73gHMelH8LlXQD0dL0vTRwyBJHjFPtG/iE8SCC
 p3JvCvWRWM7kk3pmlXtnLmP1C1esc1AIVkG9Xrx71eWn4cEjV8fhA5gCesaZxsewHpIj
 hUOErpV7wuzEDUOgQoKi/BZzMzT4IJZtp+Me07u3i0QZP+3ME0kuE5dd9UDzO+TCF7fh
 DJHIXzZrNXmNlX7dgcnqiwaM9ST1Np+xXZQvLV9k5gIcB7S/Ys68tBpEjMKVOFblftN7
 NQKRJoEL53ZeWCmHZh9A3yT1dwn8fcerxrB1J8lkH26A8zvvTwqzUXmQnyjysQp5Gfqt
 mvpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0kZKKZSGx6JaCXqoyAEVolPFBZ0Cpo6l3aMbdgHUYr6yCuzKykgG1QvVP/XcPtuw2eNbiDhJXlkqfQDWkITCseHuwNA==
X-Gm-Message-State: AOJu0YyV789OYrdadYRAxpktFjKeB6+V4NMBn3DnIyBVAayjliFbCOsi
 spHo597IFDS5XbQoCys2PrX+09E6S467XdfBJaNHvuaHpTmK78wVKiAcU9cL18U=
X-Google-Smtp-Source: AGHT+IHksqlaPxAp/8R8Kh6FeQIxkHI5BRW2+d1JGWumt6dkPGQWG6S+eyymLN0Eajrxg8lzicmUMQ==
X-Received: by 2002:a9d:7402:0:b0:703:79c6:a9bb with SMTP id
 46e09a7af769-70379c6ad60mr11553854a34.7.1720827786032; 
 Fri, 12 Jul 2024 16:43:06 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0c63dcasm37179a34.22.2024.07.12.16.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 16:43:05 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
Subject: [PATCH 1/5] board: samsung: e850-96: Add default partitions
Date: Fri, 12 Jul 2024 18:43:00 -0500
Message-Id: <20240712234304.9675-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712234304.9675-1-semen.protsenko@linaro.org>
References: <20240712234304.9675-1-semen.protsenko@linaro.org>
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

