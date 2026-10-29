Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A587E606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UPlEpGwm;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OK2A9AJA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80602407A3;
	Thu, 29 Oct 2026 13:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E6igGQJy-ald; Thu, 29 Oct 2026 13:48:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D509E4075F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793281684;
	b=VhRmCBOg8AyQBaCd7g3/om8+OuxMjUZhGNOsgb6G7DkRrzc4hPNJrsrIwIjcD8YAGt+B
	 CpfW8Td9aq+5FofkWfciQZZuk1cLOPn6+/1UAfJKJA3R3y1uzmwupTyDR5F0O8S8Xh7R+
	 maZh8XktKgDkiwi5MbciCZcJc7sgv3wXPLrsq1I7AL0dVqJbAY6pAmcdH1q25ksi4bUk2
	 LvdxTuw+ALL8wdi8UEaoEpjX/T/4GPJzLOFg+Vz9R40TsOqivCPnGeKZre9+Puayouv8e
	 cjLGWCWzIkAodlccW6YJETSf1KlSgpDYoJ0SlaJepdKS0KPjjuL3EqzCP4MO7MqG0mw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793281684;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s5L1mnw8N5QLkMxy5BW6gh1fLGyDf5FyezDcr3Fg13U=;
	b=rcrV49OeT2OFwO1S5XxA8Q5U+jDiaWnItk59vFiSUUrZKq+xQg2sZ8WSaU7VC9JFazMV
	 Y4tc/uEnPkDoGep4DgMFMhbYjiMDMHNHCS9yB53YfH1qU7P2mRpdNm2lYa+lz5geKG6eD
	 wCbhClNlGc9A+gDJf5vGRum4pLtTnGYW/EAANRzM5EzcPldWgzfIgkZh1PIy2eVbnDYzG
	 yzJFpM4VaYW0jq8bfKLJpR9Ng1qfMHQ7zUry3mh0TzFHDyHriToYpmaD9m0UwxUMzcVgp
	 k6RLTRtg7CXAFsEiOuwS3dKTa/zi9jDPpUiZ2X51dzJPfweC4IITaXLlDjv8BTZWHlg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793281684;
	bh=s5L1mnw8N5QLkMxy5BW6gh1fLGyDf5FyezDcr3Fg13U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UPlEpGwmhF0NxilfF9xxiMsM4qKnExnf/d2PjcTnnOBaXVY1zwWVJzqPVz52pALvj
	 v1zjJOk40JfT+IbJd+PfNzp9dFBSf9IcDWAK840rsWDsMFr0Af+Bz2jZx6WOpXodyI
	 WwAP4CNMHujP1oEKdwge+xj2wt0hCoZdu0+1+mcZ4w9Gh1MjEzPld338tx0+6TkWtg
	 zEUlOvUGbjUvf2rmVj7XO4mKCaiuiACS4XYiHvUk5lEiMv/W5oEUJr1V+f3r/v/wKE
	 wJbgDDwQhUT+nacUrSGw0VhQsMkC28y0xV8/c1eSC+p3DLwV05Rs6A9N5WgI5kqeFr
	 Xpd2/UbQ6Bz4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D509E4075F;
	Thu, 29 Oct 2026 13:48:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CCAA972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22EEA40318
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDtE_s3uIozE for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 13:48:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 84E9D40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793281681;
 b=VI1GqQDnUvly+P9f5l1p6j3yZHqYEGS28PLjJkGwvSItz7OSG+zWQM9ubli/TLUXsFCa
 JtMK38iAA5IA9Ei1wSpvB6FibTjVXVSO07rBDf0kQ/aZX1Yx3DG/JXc+gW8ZEBcI2M6lC
 IztK1GTQvS3QD0CS3uL4marzD2SPZ+pUfD/Dyz05lksvCf6S6J1x2i7gbBrvpmgWGnon3
 2/w9TIoT8b2V+G/by7ciGNZ+cfkXsXjlElxoXVz+FdIvPMUdXVDmwlN81c2mh93lAIwJx
 wpClnXZaXUvDYC0SCdZESh6GcXkSheTel4omFEMpX89X0WZvwd2QBdDlb7DDTXmCieQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793281681;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=s5L1mnw8N5QLkMxy5BW6gh1fLGyDf5FyezDcr3Fg13U=;
 b=ayRPxVH5sv6W0cBtM5NsaRSA7rXYoAjpYBA03XYjeYnvd7kFnzQv516hxFYB+cqwhG8I
 fIRJ5awVbfKcXKr/9wEs2odvN3C6aopeZ6rfKK5Ia3TaIIqxLUGtQEjAr7P0mUs/3Z3yQ
 2bg6VHTXCmArHaGwKP2ZCKUEdIezXfod7Cbf0fMad1QsjgcDE7HM5WzQOQfozCZn4nbaN
 4GKKWPMgPEyIpkXhZv3ljjwmKkAtlt5nx1U52Kjwjc2un3jGaOM3sLC8axIfgbobsMSwi
 TaMqGPO6x3dZjJqjABJHE6uvoBoc+3/c46FWlpfQE1ATxnaLTzWtoKh3RI9PDClzVDw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OK2A9AJA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=OK2A9AJA
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84E9D40024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:48:01 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-35c76e9614aso3030253eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281680; x=1793886480;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s5L1mnw8N5QLkMxy5BW6gh1fLGyDf5FyezDcr3Fg13U=;
 b=OK2A9AJAbJNFNx+lhXAfHvO9OUEqRhDQjW7NbatJsOlJ9KqlMk2BH5SHQ1mXweXOGN
 0scLazbSjocoP1cLQMOXJ1lXAOiB29FstZ4XTFsRclPoO1C/vhTzlyT3vVKx82IAGpIH
 wNBpVuKFqrk2tuIK6zgiD8q18LEhtYNGrfHGIU4EPNFijomj5dS1ZBjnFAiHu8Zw/6NI
 Xun6t0qJPp7Nfa5ZC9xVn3R2ZeOLkffaVP/xHW3tx6zB+IAM8oAiyHILcnzsktwlcepa
 R2XamHIdeYNG7hTUoi2ssk1zagI2EIIOJmxaTYLIB+/Y5/XgD4fJviSbFyfFUyw8ZT1b
 cjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281680; x=1793886480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s5L1mnw8N5QLkMxy5BW6gh1fLGyDf5FyezDcr3Fg13U=;
 b=E1CnT/c+aNVI24JPm5pjFOQIXXn6Q+W8vuTC+wNGdrTeBAUEjWKEpQCe3dbb7dTT4M
 Rqk/oFvi8SsSQI76zoDw3Bw9HN9xgxfT2xCJSUzKmT17H506nap220g0uC0/z0EdQW3F
 CNIADJMQ4ukvEsgftKmJEIzyKQCUaESUw+60mds/m1VemRCMeEPTpiVfxIXzRt2XAHf8
 GgYA+RBz3kqPRIvgwlRB0yeVZYlrGt1Db7r45VDuQ93rO0JLUBcp4kYWFNk9zzEzuWVL
 6Ag9RyGxNPi2EWN5MH3wcgQWbtqq3v5YKn8x4j77XWTwff/lGKMMi99Q3HdUvxCS/TJm
 FzEA==
X-Gm-Message-State: AFq9FYJzBAot+OG9Rkshhtsxh5guIM8yAw8Ehe+q9wGH8OftIG3bU0Uy
 ZDxTdqn+xsydeGkF8/RgOZoYenA8+AOFRQi5krQ4WVqH4Rz0iPrFqoCdTwQfHQ==
X-Gm-Gg: AYBFou3skijwPX5SKKxSz7m4nSg6ooVhnyEDmie5Ah3o0EtTAu6aGijXfKPTR6Vn3JA
 BcFlN3GwcPzekDZoGfKQ0ArxKaLqR6NZ2oGhHwTvOxLL1bKN9qVV4yNpmhFRT5/unjL+faBYu8U
 P2zM49exlU1ToA8qW4IT43ib11kN96bQy0i++COJus7CG1D7mqaBKVhpJfAkF8uvByC5/GmynGu
 iGJ39Ip6MqH/fiUSrtSxxv2jvB0+t+u5Ved4Yr6GSbZNneWUN9eWoGFgd2QebHyoGVt3zlpsbOK
 QXvJtQpLdjSmASA/N7a2gxABfIYYFs00ysg2MvmwC8LEoFA8fq8pzn/kiuuJmOl/4rbI0315qsD
 dM85CUDn2XtyPnPw2c1vnHYq9C/1/WkxegcakfTPZH9rnQzFQAmUG4scvvORhxcrnkBiTOrsw4k
 R1+IYJDHrhvbGRL1hN5LbEM3tu8M4GA+mXhPf05A0Zkyd8Z29+fO3RKkAbpDRebFT/e3MuTxjNh
 aNtNEdn82b8E7nN3X0Ib/0G/hvVcFxqbEIeJQCFKngMbTHcuah7nI/ktKNdLOdoFD7FfZK25TZk
 bpEE644k+MxwtVVllHDSAePiHRyB+Q==
X-Received: by 2002:a05:7301:4b0e:b0:36a:373f:6e29 with SMTP id
 5a478bee46e88-36a373f783amr1812251eec.13.1793281680298; 
 Thu, 29 Oct 2026 06:48:00 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.182]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390a812sm18032339eec.14.2026.10.29.06.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:47:59 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: [PATCH v1 6/6] configs: spacemit_k1: Enable SPL GPIO and pinctrl
 support
Date: Thu, 29 Oct 2026 19:16:55 +0530
Message-ID: <20261029134705.3767-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029134705.3767-1-linux.amoon@gmail.com>
References: <20261029134705.3767-1-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable GPIO and pinctrl support in SPL for SpacemiT K1 boards
to support early board initialization and SD card boot.

Enable SPL MMC I/O voltage switching and configure the shared
K1 U-Boot device tree include for the supported boards.

Also enable MTD and SPI NOR partition support with the default
flash partition layout.

Configure a 2 MiB SPL simple malloc buffer for early allocations.
Enable regulator commands, SPL GPIO and pinctrl support, and
SPL MMC I/O voltage switching.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/spacemit_k1_defconfig | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 8ee9baa13b7..04b5ec4f700 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -3,10 +3,10 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1200000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-musepi-pro"
+CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_MMC=y
 CONFIG_SPL_STACK_R_ADDR=0xc00000
@@ -63,10 +63,12 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_EXT4=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_FAT=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
-CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
+CONFIG_DEVICE_TREE_INCLUDES="spacemit-k1-u-boot.dtsi"
+CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro spacemit/k1-milkv-jupiter"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
@@ -117,3 +119,15 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_STORAGE=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_SPACEMIT_GPIO=y
+CONFIG_SPL_PINCTRL_SPACEMIT_K1=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_CMD_MTD=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
+CONFIG_MTDPARTS_DEFAULT="spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)"
-- 
2.56.0

