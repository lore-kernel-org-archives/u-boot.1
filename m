Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E962AC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6285C80761;
	Fri, 17 Jan 2025 00:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HUxYtqin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2B38075F; Fri, 17 Jan 2025 00:01:45 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4185780780
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5f31b3db5ecso714573eaf.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068502; x=1737673302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeB+2S7QIgs0sbUOEKaMH1NI6p3bQT/kxzrpVGwCzD0=;
 b=HUxYtqinKrmc293zeOTzjxV84psCSizI+m77AtXb/ypNiXu6vRNWiVaioo3nmtvnZa
 H1UeEVESWLtI2K1OKPetF7obPOY5v8chKkqP6Ua18pISDE1IgF6CF5B67JRRxOrGqV4u
 rE2xCQJ+8STpyqmGKufW2R0DyZKI2+9BH4BmDyP/1RPzagaNOviui1kVAu/oP4S1bPzV
 oDXkoQe7yaWIsTlS75EV8+iO1vdk8C9jbsIjXmiXqs+DQzzMquA62zSmTgMIRCtpw9Q+
 BtNcZ9bwb9RA5eKnzRaohrn7oHyz+NZIYRdl/wEVgvTx4a/sOvyy3t3WlxqElgwFk5I0
 njXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068502; x=1737673302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PeB+2S7QIgs0sbUOEKaMH1NI6p3bQT/kxzrpVGwCzD0=;
 b=UejoE0rklEpvyct5si19Pk53Ns4TkY9MyiKkPjERpSGd1AFficTT42OPXy/Sjf2Zy3
 G3WVil8Mb4Yy+BVOb2o+U0J/8zKJ4/A5lKQWaca/wGKhtCFOKd/iWJ1Mwdixtlupkpe9
 O265sDZIzVjGiju4ICUVPn3aqYK4ig5Sy9UP70wcpyaa+WvIZxhsFxfnUd4xmJ/7JzpF
 vJdK9opYzfPzYAfjSiYucru1Y4VTAPfnD1xq/Iju5r4wxQBjP2bHw/OjBXiiyC490OKU
 j9CySGUw8o/OmaRjg7U8RK4WZgD75EufwrjxOGnNUsYW2GG47/R4iRwF9ymtNhx+RQLf
 o4rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7rTHAlxn3A7okcCGz3SJN0ea5KcRDR10tgWRFa+x32K1tcAG7VE87E3j7fsBTdIfw8UrubjQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwxCFcZM2uqxErd9no4hXAW5zUrj8CouEnP5an77+tUtc2PmkPD
 gnK767TSl8Nvd65o26x+3BX6NwElmJCzJQ4dHG2ph8unrcAtmeQNCk80kP85IWY=
X-Gm-Gg: ASbGnctzxWs3SSEpZkpyrnFansNW/kpgUsZX9LtTgQJEOiHGO/MUOyi9f0WAuEiKZle
 ilqtpjgrTDoHzToMgycQ1JkPt6Km5WlFE6zwKStjfgoo7i4jY+1AMhh/OMfNRmnOntI4HyR1m8Z
 589A/HNoVaIj5CDI1ATe4w2f9mIOfIKIsK2BAVpDwB9JCQYk41f40lXjP54nZ/vSoQEXhWKOCfX
 g2QhJ4Rtmno6xx9b3mVeZHo+BmPuNY4B/GGEFl4BjaJ0nHzvX5hEyR9+zCgvx0QDOc=
X-Google-Smtp-Source: AGHT+IHE0iEQrsgys88jhmb8EpKyNQjWOepXnOT/OdKw5ctE1AIVSeEhVsPgitUpN9U2iFxeYDtDbg==
X-Received: by 2002:a05:6820:206:b0:5f6:4ce2:fa4f with SMTP id
 006d021491bc7-5fa38884e18mr391976eaf.4.1737068502085; 
 Thu, 16 Jan 2025 15:01:42 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fa3605d9a2sm380578eaf.38.2025.01.16.15.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:01:40 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 7/7] board: samsung: e850-96: Provide bootstd default env
Date: Thu, 16 Jan 2025 17:01:30 -0600
Message-Id: <20250116230130.3337-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116230130.3337-1-semen.protsenko@linaro.org>
References: <20250116230130.3337-1-semen.protsenko@linaro.org>
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

Add default environment variables needed for Standard Boot enablement as
described in [1]. Also rework the eMMC partition table for Linux boot so
it only has two partitions:

  1. EFI System Partition (EFI vars, GRUB efi app, firmware files)
  2. rootfs partition (Debian rootfs, /boot, extlinux.conf, boot.scr)

Both partitions are made bootable so that 'bootflow' command can detect
all loader files (rootfs might contain extlinux.conf and boot.scr).

'ldfw' partition is removed too, as ldfw.bin can be loaded from ESP now
(from /EFI/firmware/ldfw.bin).

Android partitons will be added later, once Android boot is actually
enabled for E850-96.

Notes:
  - $kernel_comp_addr_r uses the same address (0x88000000) as LDFW
    buffer (in board/samsung/e850-96/fw.c), but that's fine, as LDFW
    will be copied to another RAM location (Secure World) by SMC
    command, so it's only used temporarily on startup
  - addition assignment (+=) operation is used for $partitions to avoid
    spaces added by newlines, so that $partitions can be used in the
    shell with no quotes

Now it's possible to successfully automatically boot Debian rootfs:

    => env default -f -a
    => env save
    => gpt write mmc 0 $partitions
    => reset

[1] doc/develop/bootstd/overview.rst

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.env | 37 +++++++++----------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.env b/board/samsung/e850-96/e850-96.env
index f36f90be9509..5ac76bcef027 100644
--- a/board/samsung/e850-96/e850-96.env
+++ b/board/samsung/e850-96/e850-96.env
@@ -1,26 +1,11 @@
-partitions=
-	uuid_disk=${uuid_gpt_disk};
-	name=efs,start=512K,size=20M,uuid=${uuid_gpt_efs};
-	name=env,size=16K,uuid=${uuid_gpt_env};
-	name=kernel,size=30M,uuid=${uuid_gpt_kernel};
-	name=ramdisk,size=26M,uuid=${uuid_gpt_ramdisk};
-	name=dtbo,size=1M,uuid=${uuid_gpt_dtbo};
-	name=ldfw,size=4016K,uuid=${uuid_gpt_ldfw};
-	name=keystorage,size=8K,uuid=${uuid_gpt_keystorage};
-	name=tzsw,size=1M,uuid=${uuid_gpt_tzsw};
-	name=harx,size=2M,uuid=${uuid_gpt_harx};
-	name=harx_rkp,size=2M,uuid=${uuid_gpt_harx_rkp};
-	name=logo,size=40M,uuid=${uuid_gpt_logo};
-	name=super,size=3600M,uuid=${uuid_gpt_super};
-	name=cache,size=300M,uuid=${uuid_gpt_cache};
-	name=modem,size=100M,uuid=${uuid_gpt_modem};
-	name=boot,size=100M,uuid=${uuid_gpt_boot};
-	name=persist,size=30M,uuid=${uuid_gpt_persist};
-	name=recovery,size=40M,uuid=${uuid_gpt_recovery};
-	name=misc,size=40M,uuid=${uuid_gpt_misc};
-	name=mnv,size=20M,uuid=${uuid_gpt_mnv};
-	name=frp,size=512K,uuid=${uuid_gpt_frp};
-	name=vbmeta,size=64K,uuid=${uuid_gpt_vbmeta};
-	name=metadata,size=16M,uuid=${uuid_gpt_metadata};
-	name=dtb,size=1M,uuid=${uuid_gpt_dtb};
-	name=userdata,size=-,uuid=${uuid_gpt_userdata}
+kernel_addr_r=0x80000000
+kernel_comp_addr_r=0x88000000
+kernel_comp_size=0x4000000
+fdt_addr_r=0x8c000000
+scriptaddr=0x8c100000
+pxefile_addr_r=0x8c200000
+ramdisk_addr_r=0x8c300000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+
+partitions=name=esp,start=512K,size=128M,bootable,type=system;
+partitions+=name=rootfs,size=-,bootable,type=linux
-- 
2.39.5

