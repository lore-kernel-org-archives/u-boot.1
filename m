Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A46606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i9wjREay;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dGFFlca7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8E8D4066F;
	Sun, 25 Oct 2026 04:47:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dqFDDf2tuLyM; Sun, 25 Oct 2026 04:47:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AEA95406A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792903646;
	b=c49dJlGZ0wpbQSRQAqqUypoeybAUBdJqCvy+9mMcTmlcWXvXTkV08JS/ebx+6dHWaA14
	 I2Bql50Oc4f82+VmDp21/ATm71wV4EFfj042FO4tHzxAAHwYnHGYBZLpVgcsjrPpwphUG
	 zYPJjMagOhOoYEAvBNpBALOVrL8XZ+nQJKqs/+XfPDfwLlSMzbLIPyWi5QUT9aSUCg7rw
	 HZ15waUI3r9cX+kUiipbzA6mnDsYCrM5P7RhLAC67RamLqsNJRGJsVYr34+TdSZz0DWmM
	 TytY7fsypv2Z9zzV/mPS3zMkLxzwC0TXVX7ffbiEoEnvhyvqXOX1vJVd8yZz6jCxJkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792903646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VdBQdydboG8rAyvNGjiis1vBtBi2woqxahN/aIco9jE=;
	b=SaF23d43SQEnkMoY9tgbGwv5xF840fTP+emRC3qY2YYYzmMsUodJrNAhzv4UbIHlxwQP
	 uf8v/4tCgrnoNssuLv88GfAboZhxiCS1JK79GMRT5+AmCOZ7aqp9fJvrMvV5oCgPn+603
	 chguBWguqFcMUfvef5opMMDAyAu1PBm8Anr7DOBrdHG5nyjkOmYHoXp0vu1N8Y58HAzY4
	 CqP3290Q0L9UoPD3II0AMExTTAUtUO56/qThMO7AN1eABkN/E3JCdMfo6FLfZPPAbeG1q
	 9Qd1EmGi7ZIzbLaZtazLeO5FZ145/LYs+Bl3rsNkWx95K3xsrlEdIZtfa8ynegh6UAg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792903646;
	bh=VdBQdydboG8rAyvNGjiis1vBtBi2woqxahN/aIco9jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9wjREayQMiGbDksfFstIglCg/H3QC9cOk0DjPFlr4qStHy/UQGX+YyDTRKw/HvA9
	 aFHURPhFujdogadWGw6fLY67dC47F7+xvCqvJ4ySfaIA1FqXgPHfF5PPavpJEr86o3
	 Rbq6+oS5EqelppnvilVjuMFuHB30zKOs4WZnMrtPbMx2t3FqAZrEeJRUGvTeTiptZh
	 pDT9qLbfFlpdr7EsityddhGIJZYTJuOmlMWeP1SP4hyNTXAAo6j3iqtNTXWJlf+dKx
	 KAbfvg/VO8ZMlSx67/GaXWDWy9pbS7BzIhwx+YxiW0m62KUMvVCWr10xmmE+6o2Aob
	 uGbVbXn9TLjBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEA95406A3;
	Sun, 25 Oct 2026 04:47:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BE5503C4
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC19560603
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vVmVz7OiC7_U for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 02:00:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 122AF60615
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792893629;
 b=GnaE2ncEX7SiUVpYS/YVfntqHKKmOVYlucfu97jCvD8OeYtfWtgDqD6g/mC9SZnOWhuv
 /yG5v//N87+MAzPkGiGuWgqU2Ey2boZNYfm4iC2wBTcpTf/TxmTDl+rLBF8d2ZLLj51d5
 FojWRG78kpyPmUvflshh8VXkckbTykILLFZfM0iLoazuIFE4ZmNIrUG3FtIwylJWYBqeQ
 akIczuRc/qD/EGItfxD/LAnQzOms7FMdlGJT9GU/JJMC7G+oJ+evddrLK792gT7FVAata
 wMAkMYpWGN9bgkMpwHws/wi8eASqwLXLBSmvrZpURQWgIDKOa6RG6OjmFEqCIwCAVpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792893629;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VdBQdydboG8rAyvNGjiis1vBtBi2woqxahN/aIco9jE=;
 b=W8RnWk6i/LyM6ceqCsNYor3LdRANx96udMKSVFCrbSAfKvYHL+Uc0MBxEh3sqadjrNiI
 ailRdWjBa2s8eu65TuCEzBgB6j03CHBJBhJAq9hV2X8h6H73wRw2yiZRrZ3kAzvEA7vVw
 WrKm2lxDYcxN5tJueMfNupa7seoh2/DCa1EtgOU6t+sZTWD2d6so5hZoyWKStW6OG40jv
 NYD+E+tv7kpG5luSC/pQkIBJkprc1EZop8C24IcY9ZkILpsJIlrv11KZQQ+0DQ3GdCWS+
 8MGOoKFcQ+ICF0mc7I6ut3LqMbNvNrDY/moxPA+RkS8jDVxnmsKhyrsxVAWKdUzeO8A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dGFFlca7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dGFFlca7
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 122AF60615
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:28 +0000 (UTC)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5eafa528803so707490e0c.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792893627; x=1793498427;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VdBQdydboG8rAyvNGjiis1vBtBi2woqxahN/aIco9jE=;
 b=dGFFlca7uUZPiqObEQhp0LDM85o6A4b8IS7QZSGrCuWANQUea0RFd6Tg1TrIk+cjn7
 I1WI4n4mGYXadGeHLa6POcKfKcaFzTBWvVacCWiXrtFGd6VlVE+243jp+LLkeHp5g0mQ
 QS1LW5niyY2o9puAfTXM5H0IIbUAapyvltTxgUjhWd9mZGWqFg/DUOGq3W7mI4GDZ0B7
 Is5CUAMi62iYPirH3bGJV3Cta5oqsxoN9R8CPd5LTelS78cC9m8e9IPkYHRKZ5Kzb/oI
 RVUY1WlwDazNAnQGjBXzOfOQ0zKGAkBrrArzHNUh13BfPUShFrUJZEbbt0Z9873bqmph
 cvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792893627; x=1793498427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VdBQdydboG8rAyvNGjiis1vBtBi2woqxahN/aIco9jE=;
 b=H9PJCUIeQ6c0HYxsmv6wjV17u/FAC77Sbos8IcI2qet27Y2p6lczAi1XMHNkfKOnUE
 Zxf2FkINjk+vdVSsR3wEnaMlrPkdGt7mPISXLk1fkSaEQnyG1uaT1IjdJ/L1hUPyUb+z
 4FNnXaAXoLEE87lj/lD8Jb/oUFNROfO7KL8PySz/6ns4774MiFnWcQfaT80GN1afbXEF
 bALsM4aCPERMiiF78xbdAP2bMQ4nHrfHT9baGEDDL80vvMPBe79/1wPZSuZ4HrzNl5HD
 5Yns2/eT+kmTV1025Sf199NWw7ndTFNyI7vgQM+mAlfqKAK7afPd/GLoMXagcheIgel0
 PLow==
X-Gm-Message-State: AFq9FYLhrs05w5o3zqJurO9rHkEyxnzdXSvHJ5D7yof4aFlT4YXgP6Rn
 LYKND5vjRA69jMTJ93AK1kM5GmKvDTRdBZTh64mHfa3ya7D/6m4ZFXNlphBUYP//
X-Gm-Gg: AYBFou3ZX5VF5S2vZGao++Fbyq94ryhtFZBXsTSX7hay5KiOpTY6Qe87W/C/569gQS9
 zoIs5HhgmPaHuB5AW+uth//S7yQDFdJf1W5ziH+Lh20uUoEO/Qqh/U4i7fyHPB5uAAsVKsmevzw
 fswtqsPuj5Udf6RMEU2jQ6T+6OGyuX/JnPX2IL6Uh7V9F6FanZB7RWPdPu+Rsrj5ZKoyRf5lFre
 2w5YzyWYT8dnKkygIN0M+pLMpN7xvJLIm/+ZxEGp4tbmAtmAESTZUEurxOX49AJlpuqdYIXcavF
 U03toHJ8rvfZs2jpoiIJ/GbjF9rBF2Ggm98KPoRJfpyVSCSJUzjXThAPTd1x3MPn9MukSs9AQ5a
 f8iCOZaOYwEj0WRUt76xyrFl9lA/9+VTKYutAbyJRiFFHB+j20OCwhssFpKicw2pRMkIO3+dAY+
 SQ6WL4QY8jRO4aW2nqu86NOIkMY5gBhWoAaqp1FO6499CmIhu7gjQQxp2B+6WmssxhqCdit5tNd
 NqpsUyDy2hqwtXz9tECwrBKQVIKPbRgrh7tCOsKL+9zvMtDzeOjmJfj6vJil6uQvxQk828M3IU/
 EOYKOAhL5i8oYcRtG5ZApKUPJ5g=
X-Received: by 2002:a05:6102:578c:b0:7c3:8150:83e7 with SMTP id
 ada2fe7eead31-7ce5ccdd92fmr722032137.9.1792893627068; 
 Sat, 24 Oct 2026 19:00:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:1eb0:a0:15ff:76c:632f:8ae8:6a5c])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5e2baf56sm3485070137.11.2026.10.24.19.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 19:00:26 -0700 (PDT)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alison Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/6] configs: ls1021aiot_sdcard: Reserve 1 MiB for U-Boot in
 the SPL memory map
Date: Sat, 24 Oct 2026 23:00:09 -0300
Message-ID: <64aa14e2db0472120fa3a6ace2e326ccd0d548ac.1792893601.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
References: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 04:47:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As more features were added, U-Boot for the LS1021A-IoT board grew
beyond the 512 KiB that CONFIG_SYS_MONITOR_LEN reserves for it:
u-boot.bin for ls1021aiot_sdcard_defconfig is 604 KiB on v2026.07. The
SPL malloc pool starts right after that space, at 0x82080000, so loading
U-Boot to 0x82000000 overwrites the pool, including the struct mmc used
for the load, and the SPL takes a data abort after "Trying to boot from
MMC1".

Reserve 1 MiB for U-Boot and start the SPL malloc pool right after it,
at 0x82100000, as the LS1021A-TWR and LS1021A-TSN boards do. The same
adjustment was made for the LS1021A-QDS board in commit 7ee52af455c2
("ls102xa: Adjust some macros for SD boot on LS1021A QDS board") and for
the LS1021A-TWR board in commit 9b6639fa85bd ("LS1021ATWR: Modify u-boot
size for sd secure boot").

Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alison Wang <alison.wang@nxp.com>
---
 configs/ls1021aiot_sdcard_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index 25c5e5fffa9..0cee61568e6 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -13,7 +13,7 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ls1021a-iot-duart"
-CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x1001d000
@@ -47,7 +47,7 @@ CONFIG_SPL_PAD_TO=0x1c000
 CONFIG_SPL_FSL_PBL=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x82080000
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x82100000
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0xe8
 CONFIG_SPL_ENV_SUPPORT=y
-- 
2.43.0

