Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823A6C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49D626071F;
	Mon, 14 Sep 2026 14:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oi-Umkxy_5pW; Mon, 14 Sep 2026 14:17:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 69542606F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395473;
	b=nhLqJls19GPtavOJay9aUz7RSSUi8G2kxyZP+Y8wlr/yhC6OynZSgWuAXpSJ1ov+cd9B
	 ROGau8sSstsi8vmJVwjiW+B6k3ny40+bcA6V0KOfe1ZaHS+QZNYFfFHaCnNKP17EYeEHV
	 NzpBcgcc0c+lcOctifBtTY+GEC17xAufLB38Km1knq0gl5NCukBbImU3CdC5O4j/LAlbu
	 22C8cp/+zG12S2+2Iym3jucKWCOz28sz5xa4Zec3t43jH7sZPCwntSphPNB/+OJ01zW9l
	 ncwZl6ZEHqX679ZbdQfDhNHPkFJZebLU8/hnu0KEd8KGnhNTEps2YZ533NMXVwBLstg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395473;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B2KvpLcPEfMItyZZGHDs27j8tFtH0bLIJ8EXTj5LPOA=;
	b=F7EmkEkkhJemX3gCCxfTxrKl2mhrUADZx1y72whwWy/ESmRqbkQ6Ju3uQSlzBczyc9kh
	 ygUYYi1eAf79KtszZtk8ymWLWB9/zBUROqwbv7LpRye9iF1+5h6sIQ4IXFMcE1kU2Sio1
	 PRL79a+XFMR2ca1KKdYSae3Lirf+xJGjdbmj6cvkmk9R//WVgPnVQ67kA7Jo+3Estt57g
	 vlyNDqtK+MUpCqrmkhST+R3WoxPcUtcVh6HCwVWrWZbhMYx5DbWT+kkH7RDKARAYnqPuS
	 2XGtE5S0YGHJ1IN4lDGhcl7rMboNMD79aIopLX0KJ/LnfhOh5sW3Q5dXzXnl6nRuBoA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395473;
	bh=B2KvpLcPEfMItyZZGHDs27j8tFtH0bLIJ8EXTj5LPOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G44m5eZHFm4+mCbTemy3f6lOopHyReVEyLZ7dmwecOf5nHQIy+GgAtvi5bqlmxahP
	 XRZ+d5dygCHDxShzk1ucY6NBwH0NcZRuhnCAWfkWrUpubgymiSPoypDy2eBdJY8hDj
	 /QxHPCT9kj2zKhS6dBgZYo+AEdH5icpiBeDZHZePMxiRcgWr7D3jYFi8BFEQ8eHlmh
	 KYK6+EcqAyocBzuzsU2UIwbg2KW8lbsogVyntYDuuDmXoJswXKOkFDz0dzi9nr3gTc
	 GSDY8qc2OOdsRFM6QIts0WcnjWATpTdT7O6Z0+bgoHmmrbdoC9q5TXBQ5dXqqyrBs0
	 gKbdxnBfbJ3XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69542606F6;
	Mon, 14 Sep 2026 14:17:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 601DF493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 456834062C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 13-n2q91qLX5 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7FA814052C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=YcpDY62ty6wmdgy1OqmbYH+WJCJt8rBz1WmIYgApGanebmtGFlV9p6s/bdpx60jEDLHn
 vFu6naHgDtTZJ3KxOgJqY6Cb5WFy6OWCWvg1HldmOXoFLYSAipnmdcKXFaanQNIxGYQiQ
 aaoUmMA4lg5GabWzReRbXPyzl4G7k9qWwceQakWW1RDQYN0c3gR54GFuldwIfjOekWHks
 RBmJPXKYZDDELLfCj3APoprI/pPJHvYCQkBm1vyfIVuWaVyyFoKRubocmbCocqrhqL1To
 63uLpKH81Hg3urUueSLwDkJRp/tQ8Z83m+nlxiWeyLKBkj+gUtsdDm0fGspi+fLFLZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=B2KvpLcPEfMItyZZGHDs27j8tFtH0bLIJ8EXTj5LPOA=;
 b=hrjRjlVGSD1VhmZjdDilY5ZZGap6GZczUEZnI7euROeXacsAOBbY7Jn2qWzZbrpnLhUa
 q9vevk0ssjsQ8OL9kByNwMOTx3JiIkRAtMOgbDDWbRs352Qcih07UsobV7mAKFoOOm7bn
 +U+m/VVEU0mx8Byn/NBu1QCuPsHVlbT6uRziovIBXoilwbMbis91ZUWyr34xae8RNK0s/
 XbxoL/edJwDlNTE+cgiCFKI0oj38nP/EsTdjd8FtR1q2SMznvbDAKG1HacA+VWEPGxgK9
 iU3HofGWfBwxPX22vMbShyQClpeaQMCdIXj2TbRJgJ1ImyyebSLk1ykvnAb6rwEMqsw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=CYfVYkC2; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=CYfVYkC2
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FA814052C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 165871D70;
 Mon, 14 Sep 2026 04:01:39 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CD4E3F86F;
 Mon, 14 Sep 2026 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383702; bh=XeMEIjhXkzkvvcGPhJFXH6MXfKAEIN1DRmLaD59zsdU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CYfVYkC2+fBP+WSU9oJMt6k0t/pzkKqOrPmMtRsfHEB/HcMfM1L+nJy85gIOdDada
 IFFnomb11VrZiNS1YhZ4D1tF+10ZwMJo1Aa9Gh7gD7PNunE+Jz/OiCJdHvdJXjtPOy
 VKsdJzyB+7kdT20XHUeoo9QcytPUVAM8IwDdP/QI=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 09/22] efi_loader: make MM transport selection runtime-safe
Date: Mon, 14 Sep 2026 12:00:53 +0100
Message-Id: <20260914110106.1974894-10-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

Track when ExitBootServices() has been called and make the MM transport
selection helper callable from EFI runtime code.

At runtime, select the FF-A transport only when FF-A runtime mode is
enabled. Otherwise keep using the OP-TEE MM communication path so builds
without CONFIG_ARM_FFA_RT_MODE do not lose their existing runtime
backend.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v4:

Ilias:

- Keep OP-TEE as the runtime fallback without FF-A RT mode

v2:

Ilias, Simon:

- Rename runtime-phase tracking to efi_at_runtime()
---
 lib/efi_loader/efi_variable_tee.c | 44 +++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index bc15795e94f..50a98a1dd0a 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -58,12 +58,28 @@ extern struct efi_var_file __efi_runtime_data *efi_var_buf;
 static efi_uintn_t max_buffer_size;	/* comm + var + func + data */
 static efi_uintn_t max_payload_size;	/* func + data */
 static const u16 __efi_runtime_rodata pk[] = u"PK";
+static bool __efi_runtime_data ebs_called;
 
 struct mm_connection {
 	struct udevice *tee;
 	u32 session;
 };
 
+/**
+ * efi_at_runtime() - Indicate whether the system is in the UEFI runtime phase
+ *
+ * This helper returns whether the firmware has transitioned into the
+ * UEFI runtime phase, meaning that ExitBootServices() has been invoked.
+ *
+ * Return:
+ *   true  - The system is operating in UEFI runtime mode.
+ *   false - The system is still in the boot services phase.
+ */
+static bool __efi_runtime efi_at_runtime(void)
+{
+	return ebs_called;
+}
+
 /**
  * get_connection() - Retrieve OP-TEE session for a specific UUID.
  *
@@ -399,27 +415,30 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
 /**
  * get_mm_comms() - detect the available MM transport
  *
- * Make sure the FF-A bus is probed successfully
- * which means FF-A communication with secure world works and ready
- * for use.
+ * Make sure the FF-A bus is probed successfully during the boot phase,
+ * which means FF-A communication with secure world works and is ready for
+ * use. During the runtime phase, use FF-A only when FF-A runtime mode is
+ * enabled; otherwise keep using OP-TEE comms.
  *
- * If FF-A bus is not ready, use OPTEE comms.
+ * If FF-A bus is not ready at boot, use OP-TEE comms.
  *
- * Return:
- *
- * MM_COMMS_FFA or MM_COMMS_OPTEE
+ * Return: MM_COMMS_FFA or MM_COMMS_OPTEE
  */
-static enum mm_comms_select get_mm_comms(void)
+static enum mm_comms_select __efi_runtime get_mm_comms(void)
 {
 	struct udevice *dev;
 	int ret;
 
-	ret = uclass_first_device_err(UCLASS_FFA, &dev);
-	if (ret) {
-		log_debug("EFI: Cannot find FF-A bus device, trying Optee comms\n");
+	if (efi_at_runtime()) {
+		if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE))
+			return MM_COMMS_FFA;
 		return MM_COMMS_OPTEE;
 	}
 
+	ret = uclass_first_device_err(UCLASS_FFA, &dev);
+	if (ret)
+		return MM_COMMS_OPTEE;
+
 	return MM_COMMS_FFA;
 }
 #endif
@@ -1018,6 +1037,9 @@ void efi_variables_boot_exit_notify(void)
 			efi_get_next_variable_name_runtime;
 	efi_runtime_services.set_variable = efi_set_variable_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
+
+	/* Record that ExitBootServices() has been called */
+	ebs_called = true;
 }
 
 /**
-- 
2.34.1

