Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F285C79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 15:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62CF640BFF;
	Fri,  4 Sep 2026 15:01:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pP3TDj19GEYd; Fri,  4 Sep 2026 15:01:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3779F40C06
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788534116;
	b=Q/ZBxqnOAVngiinypzTTwwn489+KEbEtgjhCc+x5u1icmsaGyZ0ahDSuDTD+Lw+WgCS5
	 Wa/QtHugs9ItqQhgkUfw9OVVxUdbfN59Znnu00/hOHofZhFkouWaMxh4WeL1hI89sUbgS
	 56TYaBWkpqtQiVj9rR2kS2GV6TVL60MEU21Jk3it1E8Nems937NCi8+S6wVCeuKlgMhEW
	 r/65ecTS9fTzjXrEnePdN/lgDIaUAsUJDbP1H4H5wnO3hMU64Q1JMhbrqeixmUQn/bOT3
	 GgQ/p+ZEK5G5L0P9dIDD81gEcgdKjK1kOG5rzkyp8VS4M4RzhPevuuUUD4o90pteQCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788534116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tvueqePEcIZyc4fOJ01oE4JYWAthv+tQRdMJp3rlK08=;
	b=mA4GBvPIomyxR1pQ/TRDHIjx99GXKOYio0m0zJaNaKl3P/ngoImJpXbN1/aaOzjj87p+
	 NfR+zn+OKGxi48Qc7U8aRw6S/qPD5M4dUVZPih0AALm9QBXE4yeSpYlr/6h+22lDDGQKt
	 WcL6Wu4qbPeJv6x4QmAph28cntIHKQK9Rbtl8lTEzHRz7sIeG1EqpGOnhKaLcCLUpmn6a
	 +jrcihQyFtE+HP3CjD+ie3Ooim3aRkhTaGDo8TgR/Hun/dEPUsIFZ2IbhPHG0k72BcWlD
	 gwv6uf2cMwnJ0M16QNYKgx/ZAtr/7OhugQgaWXa1m+eAQttBW40+wGiXbXYBHL70ITQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788534116;
	bh=tvueqePEcIZyc4fOJ01oE4JYWAthv+tQRdMJp3rlK08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MuYz0V3gwAbwuoy9r/w+5KDkGHjeIIJGNL+oRvRwGjBp/4iKuk+LpWS5ApK3xVtdZ
	 Yc/PoFK2cGWV+rvnib2/5aAkS4NYc1FjoSBS2+p/PrxWDLBC2zaJfNjvsTbIuTlkc3
	 pV7dRoKOCATexFDn5Y0SP0EFy7oH5c+dJ8IqtsmzZ53N5gysUJI0rJI00t26kt/BVr
	 9NbS2FAfdbq3fEA5Gr+S48aDu0uhDS5En9Q/bLRIcFRDC/5Ftq86a6Qwn4SIa69ZHV
	 vp3xbh6AhMySa6K/Z10Weo5THnzLqutgV5wiM+Hct3YO1i4drSvSok4nSaFyOR5R1u
	 M9GExx5ezWDPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3779F40C06;
	Fri,  4 Sep 2026 15:01:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AD0F3DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10DB3811B6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LSLV5GeTDChq for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 15:01:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D527781155
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788534113;
 b=UdEJWuCzxSAJVT9DA+0XJ/oxj0TMJaxR7Z+MjwmxVbw06Ohla+gD4w0y9q0c7E/AipEZ
 /Henn4cJGJwzpyIU52WcPIj/Q8iy85z2KJRtgqoR5xLruGth1uxT3s+1jEUm1G1iC0DTV
 WoNZxa4wNraJnYflP30ELjQKDK1KYmbHFq4XkmtR1y4dX5PWuPMhGgbAmes2jt21tfvX/
 kMLU5zeRq1NSea7/pVmdr3bkMeH2cWT2eZE29GZPdzRQo6MzmPyyjqcUZBfhIMba9jfMD
 OuVUsn13i/FSbtD5hDmw5cbh+xDtH1nrxh+6FmF6qeRB+YIqUckuSC9ColLSzNyd/KA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788534113;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=tvueqePEcIZyc4fOJ01oE4JYWAthv+tQRdMJp3rlK08=;
 b=n+8ocaMeX52eWsucGXOd8h+yPAyQxPgbetIIzNvKjkbcenax0w+qy945zcN+QCU84woG
 w30e4Bt87kBwAznuurIedpyQ+LGSSMhkEQhrElCQxdglXQ9aWUIBZq2ANVc7NhBNOU5Oq
 mVVK/UEovIS3jtOq3DZ8V9mAqD2lgDzLz6gfGkZoFoSuGTxLHBCYjT1uY26lJd3yS2Wyu
 62GKSvfBgjz9F+AJdxx2DUxnBXUJHnhYi5s/v6XYtorvzDMxokKEhSrH0kLJP3xIp1M33
 Y81GvNdTTcIgYu3Zav4tmV/KSBddJgfhqR0ChODJJZ4yjWyjavJtAaf8DvHTexmCrtg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=sk4F0Gxg; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=sk4F0Gxg
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id D527781155
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56773153B;
 Fri,  4 Sep 2026 08:01:47 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.49.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6A73F673;
 Fri,  4 Sep 2026 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1788534111; bh=jFe5q3qfoow+tV1lVLsYnLCpRDvNzaoKQw7GdxIheFg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=sk4F0GxgjYNOLKNvcLT8jp0AbvJzAK0kzp6SZYkn7AUG1uok1W6E9mdu8bH78ie+E
 Szb15R320UXscjwgl5qKaVzvgXBWqUNXHzHcV0NjSi/dX4ElFj+dNy6iDB1c6CD87m
 alIvoFyIhAlBEctFNT7mh/VS/O8Hak9rkxZ9pNNo=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 04 Sep 2026 17:01:37 +0200
Subject: [PATCH 1/5] efi_loader: adjust EBBR 2.1 ECPT entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-conform-v1-1-475b2947631a@arm.com>
References: <20260904-conform-v1-0-475b2947631a@arm.com>
In-Reply-To: <20260904-conform-v1-0-475b2947631a@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3488;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=jFe5q3qfoow+tV1lVLsYnLCpRDvNzaoKQw7GdxIheFg=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqmt1aHtZI1JP+a3z1PmK/ieiKWQyUdpQIhR1lA
 RVmQ8pAovWJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaprdWgAKCRDLSfhWdqMG
 lMTAB/4mYnH6FDyOeNqFVdyxnq1zQ1b59ojeS61oRYzcmE4eTBSG4eKzT1cYPn2ZX2fqKu0NmVM
 Le8ei7Q/Twx96NB+iLXz/mk8qVBxKhPvN2loVb4viamK8S9D04VGbXLVBTglGRoU3qQigbjQtzC
 js9R/I20EZ6ReetcEp572ioukIVoVIAm18DWPzkUIPSRlEpXsLaPR84CqEqL0WN7VNVyH63EcYz
 NaanpaOtUa2v9ugCpjzcsJRlBDsOvwGU6C/kIaUFLeUiETjCiK51Mu6VrDzuW5misABtJO0elHW
 j3PAOIr2iZ1kXtIKd4VX2gDtciWR+9DphcwJQ3WIuDDLt7yL
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

Adjust the EBBR 2.1 conformance profile ECPT entry configuration, and
prepare to add more:
- Introduce the HAVE_EFI_EBBR_2_1 non-visible configuration symbol to
  compute the actual system conformance status with the dependencies.
  This will make it easier to add more versions with a chain of
  dependencies, while avoiding a chain of nested submenus.
- Adjust version 2.1 dependencies to better match the specification.
  Relax the dependency on the boot manager, which was introduced in
  version 2.3, and make the list of required UEFI protocols and services
  more complete.
- Reword the EFI_EBBR_2_1_CONFORMANCE configuration entry title and help
  text, mostly to separate "EBBR" from "v2.1" and to attenuate the
  redundant "table" mention.

We do the following additional configurations dependencies
approximations:

      Configuration symbol  Used to approximate
  ------------------------  ------------------------------------
  EFI_HAVE_CAPSULE_SUPPORT  Firmware update is performed in-band
                    DM_RTC  An RTC is present

While at it, refine the ECPT help text to attenuate the redundant
"table" mention there as well.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_loader/Kconfig | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4cb13ae7c8a..40380876959 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -557,23 +557,41 @@ config EFI_ESRT
 	help
 	  Enabling this option creates the ESRT UEFI system table.
 
+config HAVE_EFI_EBBR_2_1
+	bool
+	depends on EFI_LOADER_HII
+	depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
+	depends on EFI_RNG_PROTOCOL || !DM_RNG
+	depends on EFI_UNICODE_COLLATION_PROTOCOL2
+	depends on BOOTMETH_EFILOADER
+	depends on !EFI_VARIABLE_NO_STORE
+	depends on BOOTM_EFI
+	depends on EFI_BINARY_EXEC
+	depends on EFI_DEVICE_PATH_TO_TEXT
+	depends on EFI_DEVICE_PATH_UTIL
+	depends on EFI_GET_TIME || !DM_RTC
+	depends on EFI_PARTITION
+	depends on EFI_SET_TIME || !DM_RTC
+	depends on EFI_UNICODE_CAPITALIZATION
+	depends on EFI_ESRT || !EFI_HAVE_CAPSULE_SUPPORT
+	depends on EFI_RUNTIME_UPDATE_CAPSULE || !EFI_HAVE_CAPSULE_SUPPORT
+	depends on EFI_CAPSULE_FIRMWARE || !EFI_HAVE_CAPSULE_SUPPORT
+	default y
+
 config EFI_ECPT
 	bool "Enable the UEFI ECPT generation"
 	default y
 	help
-	  Enabling this option created the ECPT UEFI table.
+	  Enabling this option creates the EFI Conformance Profiles Table
+	  (ECPT).
 
 config EFI_EBBR_2_1_CONFORMANCE
-	bool "Add the EBBRv2.1 conformance entry to the ECPT table"
-	depends on BOOTMETH_EFI_BOOTMGR
-	depends on EFI_ECPT
-	depends on EFI_LOADER_HII
-	depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
-	depends on EFI_RNG_PROTOCOL || !DM_RNG
-	depends on EFI_UNICODE_COLLATION_PROTOCOL2
+	bool "Add the EBBR v2.1 conformance entry to the ECPT"
+	depends on EFI_ECPT && HAVE_EFI_EBBR_2_1
 	default y
 	help
-	  Enabling this option adds the EBBRv2.1 conformance entry to the ECPT UEFI table.
+	  Enabling this option adds the Embedded Base Boot Requirements (EBBR)
+	  v2.1 conformance entry to the ECPT.
 
 config EFI_CONSOLE_DISABLE_ANSI
 	bool "Disable ANSI escape sequence queries for console size"

-- 
2.53.0

