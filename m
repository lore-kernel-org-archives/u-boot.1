Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC37606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=judiJWR3;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RR28z0I3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEC0F607C3;
	Tue, 27 Oct 2026 15:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l12j2XG5GBl7; Tue, 27 Oct 2026 15:43:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31985607C1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793115838;
	b=eoA+u6rPHe70hmIXa8GNw6g9z1U3b0XlHb/VEX/9PLev7SGvf5g27a2eOBzUPOx1tcLH
	 lKQ8aRaJCdI+pzJF2msTQHDiHohuHDQluJaskklz9G6INK3n9zJbYdpUyuAb+vAe9YBqJ
	 vwWbbzjerj7GdCP0JWgPBUxShKccP5HVLYpel20b7Mg4DSNb5mmbJwrAYlvXds29X7LSY
	 JNVr+havbsULUf3my+GLgpb15DaOfIbizBa2ahD7ssmbXiLGzE1K69PzAyVsH8lGl/n40
	 3YCrmBDCo4iMvb8Nl4V/fn5J6gsM+AQ4ZVwot8+l7NlKSys419X9vIFGd8fOm66yW8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115838;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FRT2wEYZY/rcV/NjJiMG/7LDB6KJfFdw3UyAsVu1SSQ=;
	b=d1wf764ogonM0C7bF3puAcBGtu9k23wgqCq8so7V++Sl1U5IkGXinWsHbsKXdA8yv1cY
	 lbp3qfeb9CCeV/29DVOrw75g9PM6c1SP3bpnskSMYHL4Fe3K+sBHno56yZEtpMgYWO4pN
	 G1VZsMLQAR784OSlZAfWf6poyu83ytsoO6YOWah+lnY9e0RAufcJSkme0CpngT7CPFb/U
	 lzsISDUuyCQy/cecQlviuTmSzUjkd7umZy3xIByqqN326RkyfQ5SeCFFmefMolR59oVBQ
	 xcLcjCaOtUgBecbojCNi51gvZjd824qDtMidHHYFPpsSA5agg2asYJSB52d2BsyaPpw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793115838;
	bh=FRT2wEYZY/rcV/NjJiMG/7LDB6KJfFdw3UyAsVu1SSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=judiJWR3vVtm77C0ydyNfPyLnkOU0VGR51KRcOBqRB4UDF+M/9W7bkmmth7NXNctR
	 j1smplxGM0zBzmhodqLaekrtpSLY7tfwZYDHwmkZSixzLfg/7SPOj7dGPZCY1OqSqx
	 oFYgtXMSZ6StUmhfWWCb+29MaEbTDvvWzLHbF5/Tj3Egd+RYOeJ1LBbGBYBlOX3Luo
	 IQFJRa6uWs3qobLH08Jp7QZMwiRUF4fxLvxHJwO1h6HTK50gxTTDJ9xw/JAzaTgcv5
	 XsD+F8fWOFhZXV+y+3PE93HiuHD0/jsJPlnR7o/TzB2+CFDNxdSsAVLbY2to+Te7Ww
	 isqtAevC40/Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31985607C1;
	Tue, 27 Oct 2026 15:43:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C2A94279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A663E402BD
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcIhvQfZzeU6 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 15:43:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1330D40184
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793115834;
 b=H5wkhOoqz3rt+DSornenECmrT6ZS4ZEXjvat9K/RwLR+QJE8+ZbaZw+EyM/N61RW/Unn
 z8i4WDV1/gBd/Bv7jYqMDrNXkK0HBGU7hllwJeh4dYUD5iUVCdqYb3flIdUh54amppgHz
 Fx7D6F7XZeFHH/59x3t8VECtKxUfJSiP5zLHmr2UpA9jzbY3uF2xjHFh56yrWuTRoIAvj
 CEvDnpdzuEAAHAGeP8LHa7rdyAtf7QRb3VSV+rOA6HPRHi8KiLh+00NSktkxTBakfyxer
 YvIZGndsz867QLtkE9IGk2E2zOZJyEEu8byVflPSYsOLLWTMv8dgF29VqGSNJ6Hvppw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793115834;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=FRT2wEYZY/rcV/NjJiMG/7LDB6KJfFdw3UyAsVu1SSQ=;
 b=LXojmMDoI3kl5msZ7uoePsXtRM+LYUUhd37v0qe+xIfFvxSUOdHmPeYPBiqsMLQ0LUvB
 QFUXWoE9APf9iXFROota7rDURnalOUzpqs10xtpg+b7J+MQt3PzYsSJzTbrU/0JISWeYa
 j+fsj4BF336ibdiJBdUQmR1W2XAAQB6btKJdyNESygzqwbmks+tREQN42tsCY4y5sDCwe
 +u3z3Pe+Uh+Vqys8bh4JxrDTriF8RrJrq5jRIOlHWy6ySXvFe2BVkSOKP3SAoV70vPGFc
 c+DtBkfNEl7qtYsiNC0ht5P9mKzMn6UMqSJ+G0TOHGblpjvnB2TQsKq4gZ5nksyGCBQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=RR28z0I3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RR28z0I3
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1330D40184
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:43:53 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8a60f90a924so16717b3a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793115833; x=1793720633;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FRT2wEYZY/rcV/NjJiMG/7LDB6KJfFdw3UyAsVu1SSQ=;
 b=RR28z0I3ZdYKz7Il4V+1SApxn5Wee9k387qwyyfUdMAMbMs8Gk3yg/O//O1fbNDee2
 a8Y+TSNsDRjjRutGGTGkNfXFkHRRE5JZI47wOt6BGzyEERKT1zrm0egrvKUo9kLoc48J
 TjeEZp8s/6D9qWSdBBPenNPOlCbZZRP4/jzLFmzKtH0/yMosjjKv3m63rPwjl4UWzhfy
 8wX0JXjKypFWFcWvHUjl32NmWDcFfplkZbTbISERosgoQ+lrsBZvdwO9wCTNfV2rxw0M
 IXTk+tpoFp4eyeSK+T5eFI1eaykHzVvdUiRG7i5+docPIqerSFdt6AZ12VeZoIQqgpXf
 5TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793115833; x=1793720633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FRT2wEYZY/rcV/NjJiMG/7LDB6KJfFdw3UyAsVu1SSQ=;
 b=ToGDnkYYNjogXCx+iYWZKnh6opOe2ulZS1lGHbKz8o5r89fnRIYHMDS5txRlMpKfgM
 Yi6/ZrOR+/8I6G6U66+MWaesJIC6oF/ktEp3TJZu/sX7kqcEWyxH9fZQ6CanGKg11CkI
 QY6VVUDTBYuc3qVasAvMkk3L1V1I2iy6Ol3eufBJA6iNFPl8rK0ctTiwmZHisPoutglx
 CmazFwmp4lYaFLWEi+Gp4tCuLOTanUjDXI4ItikO+CgYYzBEA13hncNn2qpRWDTIw35F
 gxGNrxcz6sQnatMrpNG7DDu13LBD2HoBRodVMAPuwETkdFWrnDgQTAeMQA3mv365LzTb
 HX1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBytY3QikOOMaIIBZ3YT0pUM9kxwjfT5n1o6ayEMK3krr+3j+LmeYUkh+ge73xnoHq09HKZ607M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIWBTWbDMnCZqf5YBTtB/OUqi8eo+ZZlCi1rPylvszCJ+EzrlSS
 JJfxLsSNylRgqKVm7h8H9DvIuntYeQqNPtj8fv5cHGPU9R9PYQyHHINr
X-Gm-Gg: AYBFou0J6oyAUDDo251s3sYhrZVulNNgRgyTP48ZhsWeA/D2tGtU8r4ZvFrsAmh5JJJ
 9/OHX4Wgoy9KOGU4Wgl2OYWZYVPnvlpbdhg4Cnrr6GsDoBcA68EbrCwtvGg49bn27NM5fVRZckE
 0ErJAKf+o6RA4AAhGdDHZX3Y6eAhnXMJIzw3jZI6WImaoOlJ256gUrPEYVos4sXAlocH20bP9f7
 Hw6GTlsuzih2oHLAGD/HiSq8HXOaTdAV0Aaqvnkk3CxbNPotex2/GkEhKBEetkjgbYqAS5nmuw2
 nZnoJ99uX/+uKTPs32R1MbdHD5nuGaMJCub8LC+imuXddgoCQIpVeQPdwJ8zDKKV/6x9jPVcln8
 3z0Qx+BcReCIw6rU0baRQO1IrfQxo8Q+mHwgBt+OPLaB1dDA4uGz28nyETenI7rAY8TMd0AKQfW
 rRlvi42Bg+ow4qsf6Sy/4Gh99F/22UU9k7Q39Sx69+uGWMOUVriN7vIy3UKtJRQphFfWLC5NNp0
 No47H25UpM8lx7ofMLq8bvVdVPCjjeNN1HAL6K6yBXVSsgnC51xXBzr3LKSOpbv3+MRhObds1Ce
 C3wTRkAZEn77vR0cjRTctBgUbNXgu1BoRqWGTDrp4eQxmQpzSM0tJkCeTR84gdW/+//6D+MGIQH
 bMb2uj5H52Vrwi80ccmT/M3tmuE2qfdYQJP4=
X-Received: by 2002:a05:6a00:a16:b0:869:9298:ba50 with SMTP id
 d2e1a72fcca58-8a3630d0a68mr7623853b3a.0.1793115833036; 
 Tue, 27 Oct 2026 08:43:53 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6a6cf7f6esm211685b3a.33.2026.10.27.08.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:43:52 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>
Cc: Tom Rini <trini@konsulko.com>, Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 1/2] configs: k1: enable GigaDevice SPI NOR flash support
Date: Tue, 27 Oct 2026 23:43:46 +0800
Message-ID: <20261027154347.1392094-2-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027154347.1392094-1-alan.tseng.cs@gmail.com>
References: <20261027154347.1392094-1-alan.tseng.cs@gmail.com>
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

The Milk-V Jupiter boots from a GigaDevice GD25Q64 SPI NOR flash, but
spacemit_k1_defconfig only enables the Winbond ID table, so neither the
SPL nor U-Boot proper can detect it:

  jedec_spi_nor flash@0: unrecognized JEDEC id bytes: c8, 40, 17

Enable SPI_FLASH_GIGADEVICE. With it, "sf probe" on a Jupiter reports:

  SF: Detected gd25q64 with page size 256 Bytes, erase size 4 KiB, total 8 MiB

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 configs/spacemit_k1_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 8ee9baa13..b8f777e89 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -88,6 +88,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SPACEMIT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_SPACEMIT=y
-- 
2.43.0

