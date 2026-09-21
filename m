Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D48C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 13:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B7ED60716;
	Mon, 21 Sep 2026 13:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ldk7cy36clnv; Mon, 21 Sep 2026 13:12:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A16946060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789996362;
	b=lb2oLQbOtvwxm/5edFtnMo7nQpNYFNbdfSZcc2oJ9SU60Py0x+8QNMtXQwovNHJ3NF6h
	 bI/2tRGov54Rxd87bKPQAjejnoXpTbbIOmV0SJmG2iqIv9e6KxUc/Bb6G4wJliE3AYp3K
	 faSKdMed52Y5EP9fSHU03zh+JVBq7wM3Cxw8skKH+P5VMYlh1xDWzlMrOgdZfnfper192
	 9sHDvp/+pHwH/0TIMOkGWSeVzNUKEGAAbJsWv3o4NCBGZbJ9KvLMt5izKJHMUrfqHpaIX
	 Sz0a8IIVIAvTvXvptiGlkam0IAIrdM+E9hedi7sumdM+nyEg3lPVu+69lhuUV+qgTpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789996362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wKclwLizOW73J3+Nm3Dcx5OwMapEJQsvgnIedV39ZIg=;
	b=hM56xxiBbAIwWZLi7nrasJHKYDLbHjD9jmEB3UwHC9mlssMDKY8YyCnpaFceQ+yPaUEl
	 jGELLztQttn1n7g4vwsR/i/iwV3060w5r0Im8YF2m2CDE/Hty3RQ6L+sA13a54iPFsrdI
	 z7BvWuQNPHRwi93npwEqllnd5pruFmSp6w2KTFNQ/L7f8n2xD7Rpz5U3ZOhewzPqjEW2s
	 5Or82c4SFu7c2auf/NWdDUxvQABfgo/9VCgU9VfasmlOeMh4C8L7qQ8Ix/HcVXLuxkoCM
	 h+naHsoV3LZRaNT9ksVJpLNssUzRk6sLVM/1Af/5YW2OcpJT+ZThoir53pEXiF1IgMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789996362;
	bh=wKclwLizOW73J3+Nm3Dcx5OwMapEJQsvgnIedV39ZIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=03Vcz0bvxzhN6uNTYYAQxlSiqraTn+q5XKjEJOCBG26sIWqc23nryu10rE4tsMGc9
	 fCt1j+B8BHF5nZeizqqO1J2txiHDt/wuC4Of0OTwgFslJPoHED/0sCZuEVO9f8/HCc
	 5n1adct2zCgItGz+3GPBvYVK2nOYxT4/OARWvLoftNyxP/uP+l0XbrcFnElkYhYpzj
	 niZr4iNguhywRF5Hc+0Va9fs8C/a5UkbRV0fPSmBIPrEMO6CRXvvT1J1P3hzEMcfoP
	 ZM9N9GkkKa5E4TNqtBt/JVzA7wyly5PNvnaVe7mM/w+1lOEUgLr/eMwG1qbIuom3IS
	 L5fsHXGk2IYvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A16946060D;
	Mon, 21 Sep 2026 13:12:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F2BBBFEA
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D549B40143
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6a-6sty8cf2 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 13:12:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A87DB40129
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789996353;
 b=iI1FH8fmh6Oie5H2HcmxouXZyTToRCKsCw9HhyMecq3ECMZhwM+kEYxivXPUEipw9Rx5
 w4qSD3Mq8uZwDXsipPcMLDBHLSUd2gZ3FRecA8TMhBRUZP7L2g3VzkHXRde4WLwU3V12l
 HGSC0tyZCKcz+XigBOANlnVFDetXHSQQ2IWoP3p1ao7BQsEy0WMCzLGLQECIE4G7vPhYV
 WbUkoUoNYKfuD2L1CQg97IFFWZCXfyE3lrBIqcbsnn7vgY4O6eb9V3tL6a3HlMElwS89U
 b5On9EzpnnTfUccv9Z7R6aamBnJ27sN7g5NFbhcP3cSdPyYgqgrWqGLYS2LkhbWyypQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789996353;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=wKclwLizOW73J3+Nm3Dcx5OwMapEJQsvgnIedV39ZIg=;
 b=JCrBWxvxRwzq3PZt7A8aduAsa+uOu6fg8u0lyc/N+ZG89RQsji1GC8/8wkeczgkWPxbE
 rw89OmknsTn7AWAOIqT8EeyyNJ/EhnytZ+JdNN3uJySxzkgxddyGql344TwxjidE+SFuu
 enEKsxO3vWfUUVxlfHFzSyyTVV3GsPCS1GoXM6zSg176FUFeyuOZNKPfCDovVk0/XdDZs
 oTXqxAXx9BxbDQhn0V/3sHN6ozhiBe1yXjEgvt+nOMI1ATSacooBZeWLWECNS+MzK7pED
 qGk5hYYW0LC2bCQ5qt3NmtC+wKnzFC2WSSs0GADq6INvHNPayizVHPoJ6Wzj+78AAvQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="J+c/keZL"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=J+c/keZL
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A87DB40129
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 465731D13;
 Mon, 21 Sep 2026 06:12:28 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.125.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C5393F86F;
 Mon, 21 Sep 2026 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789996351; bh=QA7KfvWxedobfUEtPBzdpzpMrBhnRuwgHBq7x+4nMnc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=J+c/keZL0fjB/T/UuBq4UodxcltUoDZjmO4hY9RhfMuR5cZqrjOmIJ+jLKwiy/yC+
 IEJkqwg8zBtNEvjgVJB/qTqCrHVAnRC6zAxjoTB3HCL5shRR/1FTN33xINFAXteouI
 PFU/sOwvBjvLuk7k1fIqx2M+syp2pTB9V+EWao/M=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Mon, 21 Sep 2026 15:12:17 +0200
Subject: [PATCH v2 1/5] efi_loader: adjust EBBR 2.1 ECPT entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-conform-v2-1-daeb00359af9@arm.com>
References: <20260921-conform-v2-0-daeb00359af9@arm.com>
In-Reply-To: <20260921-conform-v2-0-daeb00359af9@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3454;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=QA7KfvWxedobfUEtPBzdpzpMrBhnRuwgHBq7x+4nMnc=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqsS0810iVDtOkIyylcngxYsSjAhObX4eQwPH9X
 a0BnN0GvMOJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCarEtPAAKCRDLSfhWdqMG
 lAOSCACUYX6g4yVbw4OpfsUA8pUWXF0CC7ida2I/YCr0MQHhdK/3qhjjHqOVfhecpUkSUYF54kO
 EzgELNo7pnG9DjWJI0qId5tp9sHt++Le6fIKsPsnrPPbT0PwlkJ24XTsSxbKxE/1pc8hh47dI20
 xyv9XgZypJCNEln/bW+iuiYRrRhmdXTWo7d56GFr+3zB6RJshPXl+vT/ZmxID9AnyMKLFgjN59j
 Gw9dyoMyrERvnDNQigLzdiw7xvbbunmaQmdnCUKiobFlBtf00HJNQ0v4oIWJkz3BNs8qn1cfWFf
 hKU3TJIqeDd2PTQC7pauhty+4dQp+Hk6UEPJgD8ppMLfp6F7
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
 lib/efi_loader/Kconfig | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4cb13ae7c8a..aad8f860868 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -557,23 +557,40 @@ config EFI_ESRT
 	help
 	  Enabling this option creates the ESRT UEFI system table.
 
+config HAVE_EFI_EBBR_2_1
+	bool
+	depends on EFI_LOADER_HII
+	depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
+	depends on EFI_RNG_PROTOCOL || !DM_RNG
+	depends on EFI_UNICODE_COLLATION_PROTOCOL2
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

