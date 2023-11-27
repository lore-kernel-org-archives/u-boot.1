Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82A8C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71E387745;
	Mon, 27 Nov 2023 14:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IK2/EWaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4CDC8773A; Mon, 27 Nov 2023 14:01:11 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605A287745
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so5608303e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090067; x=1701694867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJVPfysbVGWYii4Q2XUePovhqpLXz5HuYRoOvOFqCdw=;
 b=IK2/EWaLkGdPglr+RhMzpaJsEdvhFV4vzIvOxJetHckoY8PhHvmM1ssDs9K7XzF+Gn
 Ij7ecpB1a/g950jTEGDxYe0TKxQluU79b/j4por1bSgFTgLz6ebg/7a3eDclcv6ZZrhc
 O6LT4Uj4GmKiwFgYsNdz9lcCl5RaSU9Vyl/1rBbK7djMjOvdEv3qJzl0oyH3W13GxBG1
 fTYtD0aRR+CS2bCJrDSpm7Ff0HLSPiP/OMWxjNpzLk2ry0QzoEp6g7Rhs0eoq8foL17q
 PQVGY97Op0TGt/5rsJmxnfu/Tc7jYEFAPsWXquwBVcVr0vaWbBojzRS3BqDG1DrVzHN2
 3COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090067; x=1701694867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJVPfysbVGWYii4Q2XUePovhqpLXz5HuYRoOvOFqCdw=;
 b=mioqIixk/kNnwG+aO8WovN4ed3GYOtAi1C7bemGVxiNa9KJtiMgs2q2J4WjDtu7it9
 5aAjDphIajLZWCWjdQK/Esqti/Pnkx83BhKU+gFOT06OP5HQ+JLC0pRY+od6GPWlIWAL
 8SInuFuBZX0r5CrHc4m4zj9T9ijyStLRcukcrnlnTneE3W6xszAfyhHGlXogO/BvaHsZ
 oS8clmNRJ4qoTda+InBfhb8ehDBvWoC3hWkFJgUb30CN0PM1+kWBGocDQmm3JeLG+UyD
 BF7DoQ1d2zFfhbNeik2e0sW6qqeYKwq+YrYx6zxsitkIPT5za4jkBPNgDGsQ/J8oXi2c
 2jiA==
X-Gm-Message-State: AOJu0YwhPxUcfFxE9Z4Pe63oCvzAeBedWVlf3sRMZm3w0y3OHGU6QfjH
 gu/Tr3CdJgJ+JmvJXSTOzCiYDj/NTjEuyJ9KOyk3zA==
X-Google-Smtp-Source: AGHT+IE/1HQGKEvnD+xag6DPoWSDTEwOBOvQ66Wc2P3egfP+gCq52UY+Ls2QLBkc4O2/0H6mWb9oPg==
X-Received: by 2002:a19:ac4d:0:b0:507:b935:9f60 with SMTP id
 r13-20020a19ac4d000000b00507b9359f60mr7692491lfc.57.1701090067127; 
 Mon, 27 Nov 2023 05:01:07 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:06 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 25/43] configs/turris_omnia_defconfig set limit to 0xf6000
Date: Mon, 27 Nov 2023 18:57:08 +0600
Message-Id: <20231127125726.3735-26-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Increase allowed binary size to fit lwip code.
0xf0000 -> 0xf6000

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/turris_omnia_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 65d4a296e7..afcd4a1eb7 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -32,7 +32,7 @@ CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x00800000
 CONFIG_SYS_MEMTEST_END=0x00ffffff
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=983040
+CONFIG_BOARD_SIZE_LIMIT=1007616
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
-- 
2.30.2

