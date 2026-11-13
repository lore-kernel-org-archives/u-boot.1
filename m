Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC27606A333
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=isPrL2ww;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=gAL/Tmmf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BC838193E;
	Fri, 13 Nov 2026 19:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rlOOh1tOYtYl; Fri, 13 Nov 2026 19:43:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BC68A81987
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794599032;
	b=N1hKlirJfJdp4yMqlhcpYcn2mliSwUNHaoccj1LEN/kooSryI8+ia1SyuP8pSQi3YPNW
	 jYDO2O0k4q7LJ4/2jvJkGIPN2XGCFdgzylllB3eQmtnuw9cephEbc4seLonXfSI6pQxDA
	 Y6HaiCwY0P8Piy2AibjnlFWz3yjZ/87nDQtk4VowMs6D4AumZ4hdprFLNy0HC8l9NaFmG
	 TkU87wM5mXafdk98heF7WJIvFFXSnCvpzZDoUcb0zArqd+/YckGRSVglsl598flK3Nqu4
	 pbt8fUnEu2ujt0GUJH1+d6JW8fZWDeFYAZvUKw5oOIQXP6nbBYxciWNmrp23Muqs8Yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794599032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wTyHROZGsoHgUDh30UHB1USY1mIEyZy2vSK8M6gw6IY=;
	b=hfEqroHYr2/uqV8vk+/dtypb+tauiFCF2TrfLEzLqmdCRtolUdCbHEVR11I/rPE2TX+f
	 mGXQC2tp24uEZc/WEGsNlJXi9d4Z7AkkCia2/EjA2XMl7SoMzp3udokGJbWv7CjS9Mol8
	 mwW7J3NB+BIRXy++a1/AP+86da3rFf2fYmUUxLpt9ni3rFDs8tQA/MZo2WEn5VZG0Fq8x
	 QbInNhaV9Gs3OuWCV42k42JS80y2aJsiA8iBmvAgS/rYtqyKJY6KUxTRhz4cHCsFYF0N9
	 vhHKo2z633qgUmQJ0H2cZ5+zLkX170b8EU68ZgQMvDknXtyscyuA7RWULsU9vMgVAyQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="gAL/Tmmf";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794599032;
	bh=wTyHROZGsoHgUDh30UHB1USY1mIEyZy2vSK8M6gw6IY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=isPrL2wwSIOlGl3kvh41GUfxxOqLMQBk61RAuVQ6Mib01HzCmtVgCR4PXSGVpe2wd
	 bw0+MV6ID4ds1ZZWGtrdn/fZJK8AVvrnFJD/FWBKApaMmDjaLxEvIX3ZDIP6JR7Jez
	 YiODW0tAPjF0GtWNMX7HJHZQP6IG1oAMLZAu4QD7QGnkmikz0j3CuGWx2PgMVrcOX8
	 kCdZ6IggTFRp+DPbTU3nOTrf+4mdKKlrtoTSgoqdM9Ns902ukbJtcN/ROytKdpw3Y+
	 uuzUwOyQNtsZIi2RNy30dkrGdo2XoQfsLEmwwJdcH4zlianBsYZYPpF2+0tATZ6vHQ
	 s9eFenCLbojeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC68A81987;
	Fri, 13 Nov 2026 19:43:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB2951A6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEA7B81A30
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fnH71hel_ObU for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 19:43:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 567A3818D7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7708869e7=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=gAL/Tmmf
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 567A3818D7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794599020; x=1826135020;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=IzenCDeMep6rejFF6XTzwroY6AnzMcL2pVkFxZLHE9A=;
 b=gAL/Tmmfve3ND8MEfK6j6bSuQ51o6O+njSeS1bBKjgmCZF8ozZI9g6mI
 0e811K3tW7Qcsp60avz2tLq8NUkjZ0QOAeeN/imykc/8ME48uM9EHPAM9
 uici7e816W33tM3SPn/R+oGoPoGOMQLK/JavqYXCj4VMNCF8T7NkyWDSn
 kamflhKTUibcjAEbDlM9odmFFofspUZ6Ex343QzrNmOKlrO0exDNrvH7R
 0KiBjz11SpZGv52wrcqczzKZXIPk+9Gkt0//y2nrNCv37mKL73D9XbyEj
 xj/28LSwVw2e2kRjmU5ZxtSH39sTAXVC31EZc8RD2jIz4nGpHE6yOAn3A A==;
X-CSE-ConnectionGUID: 6OtYIRk7RseJcYhOLVtpjg==
X-CSE-MsgGUID: w0AkoeJJROOjkDDVnUQ7IA==
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="297899979"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2026 12:43:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 12:43:38 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 12:43:36 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 13 Nov 2026 14:43:02 -0500
Subject: [PATCH v5 8/8] configs: qemu-riscv[32|64]_defconfig: add RPMI configs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-rpmi_v4-v5-8-6787318ad186@microchip.com>
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
In-Reply-To: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Yao Zi
 <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>, Subrahmanya Lingappa
 <subrahmanya.lingappa@oss.qualcomm.com>, Charles Perry
 <charles.perry@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the RPMI shared memory transport and RPMI clocks to QEMU's
M-Mode defconfig for 32 and 64 bits.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v5: none
Changes in v4:
 - Add this patch
---
 configs/qemu-riscv32_defconfig | 3 +++
 configs/qemu-riscv64_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/configs/qemu-riscv32_defconfig b/configs/qemu-riscv32_defconfig
index e16a0c6e2090..9992215dcd9d 100644
--- a/configs/qemu-riscv32_defconfig
+++ b/configs/qemu-riscv32_defconfig
@@ -16,6 +16,9 @@ CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_CLK_RPMI=y
+CONFIG_RPMI_FIRMWARE=y
+CONFIG_RPMI_SHMEM=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
index 1103a3dd081e..1d9212115e8c 100644
--- a/configs/qemu-riscv64_defconfig
+++ b/configs/qemu-riscv64_defconfig
@@ -16,6 +16,9 @@ CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_CLK_RPMI=y
+CONFIG_RPMI_FIRMWARE=y
+CONFIG_RPMI_SHMEM=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2

-- 
2.53.0

