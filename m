Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44A8CC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 03:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65AA6608FA;
	Thu, 15 Oct 2026 03:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iypsg5Lx-gQT; Thu, 15 Oct 2026 03:15:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8002D60898
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792034127;
	b=jkwNJ+aJisdlxgiHMKwEPUNLgZ61tMZ9y3KscDu1eYtzlOwUmhggcvKIXprw/MKMKoS7
	 N2aji5OIqCpn3eEWd6mfb/R03L6Nj7iln5gO5B3dG5ThFfZA658iH2wXCC96VWC7UAZpw
	 XEnN/GpTH+xtobGhWz/7o2qBRWza0d7bjYaPzQDImZKZmFPzlVxJmT1/rR0AKSYUGKAgH
	 hY7daWjduQf1iizxJcLUXbv5SBIqpVKHnn9FLDS2A3mADsVMcG+D/SrV5QTB14Zqs8TTa
	 rl/FJHJc8KkzmWKkFVT1AoPwvmQ4sgwIZGO7bR20uOciTjk+h/vs37Yt2idzVMgCFfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792034127;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6L+myM5jjftwKnR2hMHsLT4aU2bdeA4LH/vHToHL5xI=;
	b=Bixx4gDRyLScG8kvpRZl+pDfqz1wlO5qVv2cFDnA2SbXS+1/WRb4X4sVXyWZnXdg5CQ5
	 DvYKP6j2k44h/kyMA00UxSGUzDRhq+4IrP1kNPAI9hgizWo51dvyG4DeiPE+jBfjrzsoc
	 loMbQ62FO4OjZ2tHSe4JIJ5vYLJywygaKABdAHTFBz3fkyqoEGywNWWJzZWV+CJiCYvPZ
	 V1PJe8nq3Ea8T0hBFeUuoR9q+l/E7JbDZkLdyrbIORBBBZzJ4PSI2J6Ysp93Q5v5owyRF
	 tdWTlMGjbZ76BZ82DSDqwZz/EX+lpZhvMGAv/RQHvBZaX9sT/BvnZykJ3cfZhW+GWMQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792034127;
	bh=6L+myM5jjftwKnR2hMHsLT4aU2bdeA4LH/vHToHL5xI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UzfJEhjIr9oAPT+7ZITm6h7/wqLKJytAUW+cJX1dWR//3RzsMTGCIJMxd1zJBsaCb
	 Ardu0w/GIBQMvBQHsQUUntUWj63ZODyvMZFBL6VLZssAtyxeVhGTPqPK9wJScKCGCl
	 bP+vtbiEYLNsyXaZW3kR6H8OGLFwqm5f9gNpSGfy5QTwIQW77UWTj99c8Gu5CzDgQI
	 Ck8OfgTn5nVdovDK0b2ola7RdF8qjy6WsW9V2Nqx7oR2SypXZ1ZcSL2jhHOV0qeL8C
	 MVghqil+7sndnWxoYpVQwwbx+PY5JRhh931EJ3sciPKxt+68KJp1L1jShfHKwQ/ECQ
	 d6LpE8CVWZrfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8002D60898;
	Thu, 15 Oct 2026 03:15:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A109E4D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C49C407DA
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:15:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7zRD1EqEKPz for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 03:15:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9B83407D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792034125;
 b=eOXJshk8JFsgIstper9KS7bfljaNa4zQzhIAQ416t7g1CW0H2EaHBoytUd8KHRtrW5AZ
 jV8LPu/Nru6YctcFjnM7eR+TkILwNOq6AqiTvtMtYIFcFYXHqcLEWkI+HKe4YywhzsBz7
 DquG+MaTXqLu7H55aPM+IQg4SmXwydkXCTWJdt6mnQC1u5gUNATE20KWNoK/lf8Ifnp3j
 nz3BUK9Ma2IRSP7kiXZ1/2ud3JgG1q7dVAf/o9D2AdDP1BxsigsWp4DLTKhvYWY4Gc0cY
 PAs8MlWTXwun+4B9qWn4ZDGyZcwdAKFq1rRBVCZv86h5MLF3gMFQBcA2MbScDlniMRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792034125;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=6L+myM5jjftwKnR2hMHsLT4aU2bdeA4LH/vHToHL5xI=;
 b=px2r/CHgYPT48W2KdYeE/6sQ+DOs+7AprEomDaqTJA+as5iEvwgMu3i/jqOoxlAubQKz
 1FxHz+d3HioipgsdLeh3x5L/UA5p+7Y9j2YSVxqrNGXEp/0BHirKHJMxF3AWMp0zzoinJ
 X8UqFXuPQX3h9euoS/3wa4nq+B5dKqFK0sWUDO+3CV+JYr2szX1iGnozrY1IlynZzZg1C
 EP4rHa+4Uiqn9uM5xor326f22ZG6kxB8GloMqLuI039GsTIlRui30BKnudmOUxt8WYITW
 L2nV4Xb3xa1QPDXi5EGPk2WZk9/RwZhw5aAK1UWMGWJkp+McUGkfs0Yjrc/KAPrtrGA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="W7ZfJ/cg"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=semen.protsenko@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=W7ZfJ/cg
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9B83407D4
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:15:24 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-8249c775215so2477679a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792034123; x=1792638923;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6L+myM5jjftwKnR2hMHsLT4aU2bdeA4LH/vHToHL5xI=;
 b=W7ZfJ/cgSc1Crh9laDWsIUwe4gR1wz+qn7yy6CUREitwoRcmuzt7r/k+ue4MDGKxbm
 DBq5DsVF8xObb4U/oKP8vVStcWsFgaqWfZhu60DFUQFaNxEatQ23kglnoy4heDxVUvDJ
 MEOHqrU2WmCbSgKVFhSx64ZmYT6SSXeh0AAp+nLx4//uCcr5eUShO7ASRmA6sJ+OHAYx
 GoJRAmU4pu2QCSY9nPUOkx8sfXdVk/vwPNlfkyWecoTfVyhp4tZ4YRZBrRMU7yea+mmi
 t0be27r27uMDcWSsiVuXpsgKuuuwS/ABRqfimqCfcNfB54AhjjF62qm2fwyLSdmZI4vj
 pWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034123; x=1792638923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6L+myM5jjftwKnR2hMHsLT4aU2bdeA4LH/vHToHL5xI=;
 b=jk0wO/g/qRHZg15QBOK9FnC4Ld/ZGP3th/IOlwDtcWcKUWVTdofGFmfTemLr2vJceD
 hSY5D6RQK/w+aZYqWHXBo4Q6I60Rmh7fAcB67+RzLjRca/sni7WM9VdJR3nSfyQDA7Gm
 PSvGqEUHnFjbt9g193tdU7fgcxUG9P9yovlGKPN1B7fP+5sv/rlDezXWuYXirCm6lDRY
 +1dPHmz1+Aba3ZRh/FLZh1IYvemcwsgWE4bdPdL7n/hNde7/obYzgzv8TZSKL6/zgBIE
 aKHw8AeMwYJdy1t5vHphaKv2LJtwuR1Lo/OSfjKVj+10y+ySTL+ny/lVfokS9M2X6SqF
 4rXg==
X-Forwarded-Encrypted: i=1;
 AKwUvByjTlbgMXwf150MKyifB/pUWGLkQAmmJohwZIm+Z6rFx0CcA+YnUevaZBMKC/1FgH/ZlE15NOI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIU5sw0Bm9iKz+BP3NznTspcmPOw2LnAxyt1z0ya00fJ44c1NRc
 F1cgkpHLl4/vDMGR2/NpbqttylwK5IVxBytonLwCrc0c3MBoDWTh0b/XScRhEF+3PBGUHzTT7Su
 OaafZPsA=
X-Gm-Gg: AYBFou2wZ4M7aFaa83RzeViOVl6V1E+lb75GE4wDmt606Re1sJdh0vEyAqFrvfkvGqu
 oJ62tFExRErwpJco3AveJmg9rDFDV32rESD0FDx2b1OHtwXEiawE0ZA7zSw/grreTq2EHDJdLAA
 Ts182KFEFvyeh5aLXj1KUKXA4Cd/ysG4O5nKaHWR2alVl2wZrbiRBJjRG6+I3JBEe+uBa/d/0/I
 oIdNVmKnm74E/gUO5hn0Mdlx2LNAYzZ302NcqRKwdIxdm1eNxDvt9pLI8OtlusXku2YbWH5pmK1
 u5xqMM47NCENo9GVf7wvSCTMeTLNAy0ynu+1+NgSN9P989/dfZuDDDaw53oPM7aFzV5UTQPzr/L
 Nr8/WNxw/98rQZ5vWUbbdcJx4bMs6nuMjvxl04XRxR5TzwjhS86Sp/wvL9U7I6PmEupr1i/Hfna
 eYANK9N9ATSwoGgxMh0GKxastHhQF7y7QyAk2KXVbpq7oO4yKFK0eone0gFlVI7eq49EDtahKiw
 ca5cCgtqEUZHNzFYw==
X-Received: by 2002:a05:6830:4c16:b0:7f4:eaa0:1d14 with SMTP id
 46e09a7af769-8309610ba27mr17255424a34.9.1792034123206; 
 Wed, 14 Oct 2026 20:15:23 -0700 (PDT)
Received: from localhost ([2605:a601:1514:4f00:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-830383cd670sm15742641a34.6.2026.10.14.20.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:15:22 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH] configs: e850-96: Enable poweroff command
Date: Wed, 14 Oct 2026 22:15:20 -0500
Message-ID: <20261015031520.32254-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Now that 'poweroff' node is available in exynos850.dtsi, 'poweroff'
command can be enabled. Although it only turns the SoC off, it still can
be useful for testing purposes and experiments with power consumption.
The corresponding Linux kernel commit [1] mentions that overall board
current consumption goes from ~60 mA down to few mA after issuing
poweroff command.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47d4dc90181c8ffa9ebcbd058e312873a46aeaca

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 8f9659ce050c..0c7e66f12bf0 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -29,6 +29,7 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -62,6 +63,7 @@ CONFIG_SOC_SAMSUNG=y
 CONFIG_EXYNOS_PMU=y
 CONFIG_EXYNOS_USI=y
 CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_SYSCON=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y

base-commit: 65a7532545336e4b73e049a69436e255da7df961
prerequisite-patch-id: 5647f11cf16e2b7c4f705be54a74aaf4b8a2b74e
-- 
2.47.3

