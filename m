Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DEAC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F0AA60C10;
	Thu, 17 Sep 2026 17:20:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kk4hFiuFr9FK; Thu, 17 Sep 2026 17:20:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7C9FA60BFF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665619;
	b=glkVFuFf4VSTRwD2YOZcbkEUzFUnC3RTJt1af0EBPaKiyxycEEa6pw5q6cNeP1G4FvPp
	 pmUIkV3TPL+F1/S0i0a18AX4/B23VbhW13RAILQDW68Fwc9ENfGY8tT4TbcDfVqwb1BSv
	 Rola5qO2QMhJTTE+MhoyMyEfCWm/8hiP0yM81hAY37I5+ehP3E2l2H7Cdm+LAXaOxykYF
	 eISlUF2hARZyZJ5Tq1cMnGQgtnKT1ASNb7B3g1T0gTuKg6Q+3nP8bYVoHCC9yN+AvDhBQ
	 LU8dMRTd4O6xO+UzG+oCb0S/DJIsj57Qv0Ud5GcefDvRkHlFr1Pn8oyowVbynkGrXdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665619;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tAx/mNmRiLHDmXUrm6YovXhWc7kOhJ9oLqTXGJnhgo0=;
	b=d+FA8o2Sc6Ahk0RZxQ4CHH8EgKYwTs+CVoOfmeuzyT82jVNKnId6D82d3wvpQ/vy8hZd
	 rrSTzHEC4VaMbI6RvTwu3UsR1usDUGldP2NjvpsKf02ebwPTSKIiPH9X1t+5B40BLuBJX
	 hjjK+aOy+LUNYZFYuSrPxDaWhNcD9VkvKOT9aCiGKXOwBsSj6Kb4RNQTX4k5f7NuUPnV9
	 j4nDmGQl3wRGTw2CJJCluFkLhcXYLQxndzBwxBbbKoPFthIHEVR/8HGiS2AYwFnzoYyih
	 WA1dULmHNCJfFvYDIMLoltnMZwvQcr4bFdZlL1wm8JDceIuHBTMZOZpvUcJZGRO4RQQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665619;
	bh=tAx/mNmRiLHDmXUrm6YovXhWc7kOhJ9oLqTXGJnhgo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xl4qz2b4sDtkpKrXJeheujdm0TYv88EHMpOmam1pgYQm3tCF49JXbvfNxstyC9wep
	 WRnUL6qL0nweCeTtVwj+ZdNQj5rSQox86Mn7/Wz60Py03hNveYFSZjcROfrSrpCVac
	 txNj4blp3zHgrcqhWgIV7HNZMqgOubYBUD2LmG80cF7d2cXpBmLSHOKeJlKNnS+A8N
	 sE4+NAlDXz1dVN/Hf8LGEYArGnukQ+g175TwZylYcKS/pcLQL2+J/ugVHEtNBtxl/g
	 sA5UmID/O4jPcJ1ZVTjEqn/ohpg6wwohnr0Hx8dydNX/aDlGUvi3DYO2K5Jdi8r4Tu
	 evNghbu7RILmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C9FA60BFF;
	Thu, 17 Sep 2026 17:20:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D4302422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA7ED40427
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oKFG2RVdDi4c for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E78FF40378
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665556;
 b=MoQOTzkdfTSlu9t07OB/Uk/ZfTnFRfwkEih1KX+FB8wOgS/xlbNhN/OsD//C1lZuTnIl
 6lyAbmfOTLzfq2R7G98tGiPJwLzbfJeIGYOHudixG8XZ6sZOqTrUbxYThfpds+mix8Mh9
 FFHfd5C+v0njuc74DxQjR1j+IA+iN4gZ3Y5qKhitgSoRaaOPTF60hwVJBuvQCMjyUG14N
 7hSaenk1sbrR7wIJdAK2xDLhTRt7jSNeG1z4zqQJHmKVoaEgzO0bTeIgAtISrKhv3LLs1
 Mjs/0fbtWMplzy/c8F0sK9rrDVn9fHA9+FpkhdQdBPgsvUZWjUTrRZr2MR1bhkMuB/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665556;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=tAx/mNmRiLHDmXUrm6YovXhWc7kOhJ9oLqTXGJnhgo0=;
 b=QlAKuTo+9giaagyq75BxStrfrtMzcXk0sbWFT4XTx14aECWItZl5BmD5eQ56TcoMXtjh
 mSnqy+kQBLNZKwk655VZokP4lD1NdEpREDaZA6g8lBjfvCabPgFcp0x4qvYUWOtF5aHf5
 M626pl+E6VhNFEIug90zOqniRJwyWaKtmsMIVby4AMQmFY94OJyWNOPk+XHLCnbFIzSpD
 Lx8R98sx8Efn+4i0MHZft3cX94cFEJKand3nBTiYEaox5gXN0h6SwSeyQGiz2K0dzVE0I
 XOfpRBAKgGra7Rx/4XlPJgvuEAD3uSFcFBTInClsEnwWELcwgPqj9s+GWZtzlC5AsuQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=fDRbxfiq; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=fDRbxfiq
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id E78FF40378
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B98C1F02;
 Thu, 17 Sep 2026 10:19:11 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C46D3F7B4;
 Thu, 17 Sep 2026 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665554; bh=klrxbLaT9z9eHSWL1oy0lmxgWOKGlobF7qSK5042/eI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fDRbxfiqlZQ6B5woVmI6Pt4hzoP68d6WjlkZCjbkNXHILLzqiGXehrmuZ3co+Az3G
 yedPuXDk1ED/iUomsWL6hzEGgrwsVN9wblC8OiX7mnT0sLnWhAe0vsRdgir1Y+dSOL
 s964PVtAPY+9tT1GO9fs0pdQthGPyRVOa2QajyQc=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Subject: [PATCH v6 22/24] fwu_arm_psa: corstone1000: Notify SE Proxy SP on
 ExitBootServices()
Date: Thu, 17 Sep 2026 18:18:08 +0100
Message-ID: <20260917171810.4122899-23-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:43 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Implement the notification in fwu_notify_exit_boot_services()

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
---
 board/armltd/corstone1000/corstone1000.c | 57 ++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/board/armltd/corstone1000/corstone1000.c b/board/armltd/corstone1000/corstone1000.c
index 084c9bfff63..92257f25651 100644
--- a/board/armltd/corstone1000/corstone1000.c
+++ b/board/armltd/corstone1000/corstone1000.c
@@ -5,6 +5,7 @@
  * Rui Miguel Silva <rui.silva@linaro.org>
  */
 
+#include <arm_ffa.h>
 #include <blk.h>
 #include <cpu_func.h>
 #include <dm.h>
@@ -20,12 +21,29 @@
 #include <dm/platform_data/serial_pl01x.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
+#include <linux/bitfield.h>
 #include <stdlib.h>
 
 #define CORSTONE1000_KERNEL_PARTS 2
 #define CORSTONE1000_KERNEL_PRIMARY "kernel_primary"
 #define CORSTONE1000_KERNEL_SECONDARY "kernel_secondary"
 
+/* The SE Proxy partition ID*/
+#define CORSTONE1000_SEPROXY_PART_ID (0x8002)
+
+/* Update service ID provided by  the SE Proxy SP*/
+#define CORSTONE1000_SEPROXY_UPDATE_SVC_ID (0x4)
+#define PREP_SEPROXY_SVC_ID_MASK GENMASK(31, 16)
+#define PREP_SEPROXY_SVC_ID(x)  (FIELD_PREP(PREP_SEPROXY_SVC_ID_MASK, (x)))
+
+/* Notification event used with SE Proxy SP */
+#define CORSTONE1000_UBOOT_EFI_STARTED_EVT (0x3)
+#define PREP_SEPROXY_EVT_MASK GENMASK(15, 0)
+#define PREP_SEPROXY_EVT(x) (FIELD_PREP(PREP_SEPROXY_EVT_MASK, (x)))
+
+/* Signal that there is no shared memory used when notifying SE Proxy SP */
+#define FFA_MEM_HANDLE_INVALID (0xffffffff)
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 
 /* The total number of upgradable images including the start and end dummy payloads */
@@ -296,6 +314,45 @@ static void corstone1000_setup_kernel_env(void)
 	}
 }
 
+/**
+ * fwu_notify_exit_boot_services() - ExitBootServices event handler
+ * Notify SE Proxy SP when reaching ExitBootServices().
+ *
+ * Return: EFI_SUCCESS on success. Otherwise, failure
+ */
+efi_status_t fwu_notify_exit_boot_services(void)
+{
+	efi_status_t efi_ret = EFI_SUCCESS;
+	int ffa_ret;
+	struct ffa_send_direct_data msg = {0};
+	struct udevice *dev;
+
+	ffa_ret = uclass_first_device_err(UCLASS_FFA, &dev);
+	if (ffa_ret) {
+		log_err("Cannot find FF-A bus device, err (%d)\n", ffa_ret);
+		efi_ret = EFI_DEVICE_ERROR;
+		goto out;
+	}
+
+	msg.data0 = PREP_SEPROXY_SVC_ID(CORSTONE1000_SEPROXY_UPDATE_SVC_ID) |
+					PREP_SEPROXY_EVT(CORSTONE1000_UBOOT_EFI_STARTED_EVT);
+
+	msg.data1 = FFA_MEM_HANDLE_INVALID;
+	msg.data2 = FFA_MEM_HANDLE_INVALID;
+
+	ffa_ret = ffa_sync_send_receive(dev, CORSTONE1000_SEPROXY_PART_ID, &msg, 0);
+	if (ffa_ret) {
+		log_err("Cannot notify SE Proxy SP, err (%d)\n", ffa_ret);
+		efi_ret = EFI_NO_RESPONSE;
+		goto out;
+	}
+
+	log_debug("SE Proxy SP notified\n");
+
+out:
+	return efi_ret;
+}
+
 /**
  * fwu_read_mdata() - Wrapper around fwu_mdata_ops.read_mdata()
  *
-- 
2.43.0

