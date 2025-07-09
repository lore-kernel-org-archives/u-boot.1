Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C39C83F10
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 22:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C36483621;
	Thu, 10 Jul 2025 00:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g1IqLRkU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF51835C0; Thu, 10 Jul 2025 00:29:35 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D91A1835AE
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 00:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-60d6303a11eso224495eaf.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752100171; x=1752704971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQR5rtbyhv3CRLiLTzmNfogo60gdt7u5pE4PWngr+88=;
 b=g1IqLRkU7DjrOMuQ9b1VGakmYCF8dIN3n9F31001d+dmoezQhJ7Vn3jFMHH0VfRXUE
 w8ShHCUj1B1BGzYH/lUdQ39HweJZ7JB0IBqLwmFUDpe3YF+jGHyj3360KxiLi2X0CNL/
 VkIxgghi9UlWRuC0PQ41B9PMLmtzf+wLqGVnn9MYN8sTzM2h+IB2k2yxHF5XC9mz5/Vw
 +4PMLkH3XmsiQJqdsVMrwGP+SO4Tp3x4qflUMwAlL95mGWX/gl6Uqb6xPcfOAH9Cj26u
 lf0LbX2I6yHW0ELVfvM9Zo4b/JwHweR+jVb/iNjVGd+1dFNIiT0SQ0EVRv/5WPvHUeVe
 MREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752100171; x=1752704971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQR5rtbyhv3CRLiLTzmNfogo60gdt7u5pE4PWngr+88=;
 b=hT/og9FFaBPNtUfE2fXWpy7p8Zcu/MPoFKlXRJh/R26gq5tnH1VnrT3Wz8Fvu2KSDW
 fuRsGbmyqQjRiVJmBIgmux06qlmN+bRMUtL0QNUJX8F75I+OQ7sJSlyGAlpj/BVu+S8S
 Rg9CM1vTSmS87o1BPJKrP2I0N0WFNJgksHk3r+hiaUMDgcz57gJg5I4fSnsHUBQIJ/nP
 m61jrerkT0pQMsl+GaG2VyMCio5eiRvDdzo95EMlY23dFTxC69hU2fJNJ8lNg0WE98ri
 auC5ngJs48lDVcASU01UmP35uLRhcVWaZ0ZPMZBeUwYIEvPrgr62V0+Qa51PN03Ocfeu
 ZpTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWDSpQc/l788y75O5cjgKk/+cx1091GkkCQi4r0gCS0Lf0ouZvCWqaWjmVqXqDoYuF0aDCgAA=@lists.denx.de
X-Gm-Message-State: AOJu0YxvvVZqOmsW0uNKzinGeXVmUnzFDQQuSZkYx6HyxsVUSpCR8kmv
 maKIHMYsjtXRJJK/F9cX/pc4UEpqnClQtYWc9Fuxl3HH1CA06/zvmBuHNPvS6+WkcLI=
X-Gm-Gg: ASbGncvAyZcwV80kMy6Sq1RebDMH0kdAjLZv4i3puzhJ5uj/6+rOCPJjHVOLZcb1txH
 jxt55GvGR0SPwKgA0Pg1xX8dAsqoOkOduSSbptEv+vvPStLvL9UwtExfuDQGUl5y2xiGaRxtnNp
 XxdIQqDnW+F7Nc+OOaYB5rt7ABfqyzR4xbKypmKvbYTbfYudsf1h06l3uDa8KrHQwdki7eFbJ0m
 /SJ1E/kWNwl3laoni0A7c1c3ecDPM2ylf19ktMjeCk9kupxCksIhKAgTjbBo2WpSVLrJ42Mrvwj
 /0cYnVS20rYO9f2k2e5T/DJbu2HQe214INhI2zv2o4psrhMBfJ8O5SuB0255sNZlf0KcbdrS
X-Google-Smtp-Source: AGHT+IFv+tcCnfL8tbhuKArU3uKYdI9KN5ojQxjzG6tQSMTCu0vEzRFcxuEj0QjjCtvhGbGG4+SAvA==
X-Received: by 2002:a05:6808:319a:b0:40a:52e5:37d3 with SMTP id
 5614622812f47-412ba687230mr3294342b6e.3.1752100171483; 
 Wed, 09 Jul 2025 15:29:31 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414196c7484sm3109b6e.15.2025.07.09.15.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 15:29:31 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 5/9] board: samsung: e850-96: Add Android partitions
Date: Wed,  9 Jul 2025 17:29:22 -0500
Message-Id: <20250709222926.24671-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709222926.24671-1-semen.protsenko@linaro.org>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
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

Matches downstream Android-Q partition table created by flashing the
modified gpt.img [1], with added ESP partition (EFI System Partition).
It's an A/B slotted Android partition table, so it's possible to boot
Android from this table using Android GBL EFI app. Tested using
AOSP/main images for E850-96 with booting via GBL app.

[1] https://gitlab.com/Linaro/96boards/e850-96/tools/gpt/-/blob/master/gpt_layout_uboot_q_ab

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.env | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/board/samsung/e850-96/e850-96.env b/board/samsung/e850-96/e850-96.env
index c76ea6acdc35..aed7a71046d0 100644
--- a/board/samsung/e850-96/e850-96.env
+++ b/board/samsung/e850-96/e850-96.env
@@ -22,3 +22,34 @@ dfu_alt_info=
 
 partitions=name=esp,start=512K,size=128M,bootable,type=system;
 partitions+=name=rootfs,size=-,bootable,type=linux
+
+partitions_android=name=esp,start=512K,size=128M,bootable,type=system;
+partitions_android+=name=efs,size=20M,uuid=${uuid_gpt_efs};
+partitions_android+=name=env,size=16K,uuid=${uuid_gpt_env};
+partitions_android+=name=kernel,size=30M,uuid=${uuid_gpt_kernel};
+partitions_android+=name=ramdisk,size=26M,uuid=${uuid_gpt_ramdisk};
+partitions_android+=name=dtbo_a,size=1M,uuid=${uuid_gpt_dtbo};
+partitions_android+=name=dtbo_b,size=1M,uuid=${uuid_gpt_dtbo};
+partitions_android+=name=ldfw,size=4016K,uuid=${uuid_gpt_ldfw};
+partitions_android+=name=keystorage,size=8K,uuid=${uuid_gpt_keystorage};
+partitions_android+=name=tzsw,size=1M,uuid=${uuid_gpt_tzsw};
+partitions_android+=name=harx,size=2M,uuid=${uuid_gpt_harx};
+partitions_android+=name=harx_rkp,size=2M,uuid=${uuid_gpt_harx_rkp};
+partitions_android+=name=logo,size=40M,uuid=${uuid_gpt_logo};
+partitions_android+=name=super,size=3600M,uuid=${uuid_gpt_super};
+partitions_android+=name=cache,size=300M,uuid=${uuid_gpt_cache};
+partitions_android+=name=modem,size=100M,uuid=${uuid_gpt_modem};
+partitions_android+=name=boot_a,size=100M,uuid=${uuid_gpt_boot};
+partitions_android+=name=boot_b,size=100M,uuid=${uuid_gpt_boot};
+partitions_android+=name=persist,size=30M,uuid=${uuid_gpt_persist};
+partitions_android+=name=recovery_a,size=40M,uuid=${uuid_gpt_recovery};
+partitions_android+=name=recovery_b,size=40M,uuid=${uuid_gpt_recovery};
+partitions_android+=name=misc,size=40M,uuid=${uuid_gpt_misc};
+partitions_android+=name=mnv,size=20M,uuid=${uuid_gpt_mnv};
+partitions_android+=name=frp,size=512K,uuid=${uuid_gpt_frp};
+partitions_android+=name=vbmeta_a,size=64K,uuid=${uuid_gpt_vbmeta};
+partitions_android+=name=vbmeta_b,size=64K,uuid=${uuid_gpt_vbmeta};
+partitions_android+=name=metadata,size=16M,uuid=${uuid_gpt_metadata};
+partitions_android+=name=dtb_a,size=1M,uuid=${uuid_gpt_dtb};
+partitions_android+=name=dtb_b,size=1M,uuid=${uuid_gpt_dtb};
+partitions_android+=name=userdata,size=-,uuid=${uuid_gpt_userdata}
-- 
2.39.5

