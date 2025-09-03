Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C37CA1012
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 22:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 004378360D;
	Thu,  4 Sep 2025 00:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pKpJcAfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8389683655; Thu,  4 Sep 2025 00:09:50 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F5A383621
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 00:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-54492cc6eb1so244938e0c.2
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756937387; x=1757542187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EafLMbEkLM/zahQku3M0Wk0FyM36qwWWXx5zP0f9ySM=;
 b=pKpJcAfntNV5acmAK5h/KgYSAJlTHTxUkKHB5rU0jlOf8dSpmmLq8C7M/oih60sH1Z
 45Y24Yg3QjtjyxHxeTZuKKUkfHkjZOD45iNK5ngkUJ7twRjjVNoXKUS7IxBrMcI22WNX
 RxKmUCGd169rMaFd/lc3K1VB6HPBsNGgIpFhrgI02R1hWhTs+0mEt3ZjJYAiB5ASKxei
 22Mg0P4VvwoHSmNCHZ78CTT/8+MRUXz7PrkCR8EwW8MATvo2PsqQbOeEJSiuw4zdbKoP
 IH686Qc0vUTiPuvydZmLO+ngkeW+XqFWtzQWMoOQM0v3l5p0TVxxdmujUxpYjKgxTXwZ
 00cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756937387; x=1757542187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EafLMbEkLM/zahQku3M0Wk0FyM36qwWWXx5zP0f9ySM=;
 b=Cjc9OmjsFmWMEitMS7ndY4VfBgTTdO/HDZp19Gw/dXGzDqZ/hMrAUp75dEtAssgk/A
 KdjTmZbesgVDIOgSK7if5tzIG0wb7cAzH/bMvSnJOxqosNgtH5LsOgU0VWHwYmDxj7Vv
 Q2ULmekoKXQmYutWVYOZ2/dO9zG2hiS3FuKWiVdN5yEBTNhTRmBC0IlwS6gEObSpeJul
 XJrINcUuIJTmdgeJg+P+e1hYmqNbmK96avzNjqhuJTE1Xz3Rbp+Y2sIGA7VQGtgS6NSO
 HzezhliByTocjXxQEzLbbmULgs9sLjc4J6+0325nlLNd5nejSBBVfLUBWf/XIDdySm8T
 G6Kw==
X-Gm-Message-State: AOJu0YxzRB3gXrGORxkuEUlG6yyvsLGE2yvc8OPDAW9/zq7CH3c4WpPI
 zkZJIZuutd9m7JKich0D1Ht3QoBHW+sW8ntZgG15kEk8swJ7L74Gdx0jaHsh8mM6jRQ3Bn6j/W5
 vXHDh
X-Gm-Gg: ASbGncsIOWkAbIk0zZE5oMLnQL1Yln+pq57RDOYBTbYmew8jl4WRpoZN6AUW6XAr11x
 b9gb3Pqw+85z8OSaLuEv04FMD9hYRerAVTfvMAi+YiRLpfCR9YdDHYQWLncCElohT/KxRuYkyQC
 PU5fZFUkxBzES5O6tg/cfVgAMOPtidgDPKgh9hriMOJF1r13d/brXFKsyqCcUAbYOsVmxYY1Kkx
 4dZmtCN9akcONZ3h5UrrkbWwN4Gh7p99OROR5fy3KUG7DAoUxc59HGuEtFUiCd38vin1xlQvNI8
 7f4Fvrzs2CsTwb3MBuiD5TJP8tQntk5iZ5eEzheS0hbDQYlZDuAvGIhg9tqiF7hAYx3u9+5km+K
 pYPBEopJstuhkS6DZA6Amn5Ru6nRDOke1yu8GxQRuAQTqf/5jSA9excJQgtr/NOTtXlQvwg==
X-Google-Smtp-Source: AGHT+IGZIFVRo8qqnSIKy+Ro6Kj5pWeIGgPXNba9CiOdrIcdol5/KPjGCEC7X2Gq/AKWp2aJ87M6Ig==
X-Received: by 2002:a05:6122:1acd:b0:539:4e00:dba0 with SMTP id
 71dfb90a1353d-544a015c5dbmr6687615e0c.4.1756937387030; 
 Wed, 03 Sep 2025 15:09:47 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544912c7125sm7474211e0c.5.2025.09.03.15.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 15:09:46 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/4] tools: zynqmp_psu_init_minimize.sh: Switch to
 clang-format
Date: Wed,  3 Sep 2025 16:09:39 -0600
Message-ID: <20250903220942.473282-3-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903220942.473282-1-javier.tia@linaro.org>
References: <20250903220942.473282-1-javier.tia@linaro.org>
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

Replace the use of scripts/Lindent with clang-format in
zynqmp_psu_init_minimize.sh. This change is made to align with the rest
of the codebase that uses clang-format for code formatting. This ensures
consistency across all scripts in terms of code style and formatting.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 tools/zynqmp_psu_init_minimize.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/zynqmp_psu_init_minimize.sh b/tools/zynqmp_psu_init_minimize.sh
index 5c8b73703bf..f8b729ebc97 100755
--- a/tools/zynqmp_psu_init_minimize.sh
+++ b/tools/zynqmp_psu_init_minimize.sh
@@ -82,7 +82,7 @@ for i in $FUNCS_TO_REMOVE; do
 sed -i "/$i/,/^}$/d" ${OUT}
 done
 
-scripts/Lindent ${OUT}
+clang-format -i -style=file ${OUT}
 
 # Prepend 'static' to internal functions
 sed -i 's/^.*data(void)$/static &/g' ${OUT}
-- 
2.51.0

