Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1676D5E37B
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 08:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37AF18888F;
	Sun, 10 Nov 2024 09:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bCFGgTBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFCAE8898B; Sun, 10 Nov 2024 09:32:21 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAADE87E30
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 09:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a99f646ff1bso538420566b.2
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 00:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731227539; x=1731832339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8PP/afT4t8Z4V0qEyMkUnErtkCf5VAhOBrltgBATK0=;
 b=bCFGgTBYlitbGXYq5FlA8ub7KMDztQE2LN0yw6f9GFwdgOi5jYUV+5TIbOe04BrV6I
 rs2vn5L7YwXET68aP/rSvR7sZFBA4RmBWcvxsak/u+y9bjxe2mgr8pBWC1h3+yQSwizP
 K+4sgD7dGOoUgy2vFFFJLY0TY/Tj25TAKg6gf3X5zp5vE8msqL2ZwwxPea9VaqH4nqbf
 aooUtdOIIaosUs9UIaXu4QWnGKHjf1e1x/uSJ6GFNQ9Us4Xaz4dnVuKcX4Yqixp0qam+
 YmYctHgd0Pjt9x6IIjqOcwzofiHjO+HxnOP4NBgVWRXbYHwt5LeBcdfl318mtEOZqTxp
 8ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731227539; x=1731832339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8PP/afT4t8Z4V0qEyMkUnErtkCf5VAhOBrltgBATK0=;
 b=kK2pbk9mBqFTbvteEbZ4KKvuIfv9f+49Uk1aDqzFLp/4gbdVR27GO8YW0SGOiQVI4m
 gDLg+NW1qoIieM2joiMWh4CdHp8SfNnwGy1q0Zk2QNRomBqvLNCOH4qFCcD0eDB0yqaF
 RFxdlf1LWe4u5KGM0f8/my+A2huN7If2COc8N6biesDLb8kZCicvtzolD53nCqVfJNxD
 brB1Tgmk4yvDSD1O/EmNd+dopQjrO1sWjtPpoPOoknzatJx3Ryd5QCHoaANfChuztSAn
 T1CgIt7TmRu+KAZR4qPodBUHH6uZo0uGBkqr9CcOMqWOqpbqFU9fdjTfe/NJgywAqTva
 UQvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeYOywyemVsUmU0uktt2HpNbiLWJizLEOY25X/Sj9jxAy/Y1gI3qlPg+6xs4Bl4SWNLwdBIZ4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywn21Hoxn1KSMs/j8VhY78WkmGO9y42GKaDGP7od5qfE9B2VkPM
 jvE5K3/wjPY+h4FS0+SxBYPjpj3K2hpoUpk2yAQHRN7nkQvVjLQIXfLyZVxevOs=
X-Google-Smtp-Source: AGHT+IEdAuuxXjzHcIvnFWLNdOmyrfRKJKBKyXkxnvWR+b8xGBG67EFDjyCikW1DjNXYL3pgGPJL1Q==
X-Received: by 2002:a17:907:2688:b0:a9e:b610:409c with SMTP id
 a640c23a62f3a-a9eefff12e8mr755204766b.48.1731227539348; 
 Sun, 10 Nov 2024 00:32:19 -0800 (PST)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a17b3csm451909166b.19.2024.11.10.00.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 00:32:17 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org
Cc: Anton.Antonov@arm.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v3 5/6] configs: Enable https for wget on qemu arm64
Date: Sun, 10 Nov 2024 10:28:41 +0200
Message-ID: <20241110083017.367565-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
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

QEMU already has an lwip variant of a defconfig. That defconfig
is also configured with mbedTLS by default. So let's enable the
remaining config options to enable wget for https:// as well
and test that codepath in the CI

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index d3d8ef16e668..754c770c33fc 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -7,3 +7,4 @@ CONFIG_NET_LWIP=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y
+CONFIG_WGET_HTTPS=y
-- 
2.43.0

