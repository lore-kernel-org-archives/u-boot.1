Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB87C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 15:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834458758C;
	Tue, 28 Nov 2023 16:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S5338156";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37118870D2; Tue, 28 Nov 2023 16:45:16 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C00A870D2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 16:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b399a6529so25295775e9.1
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 07:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701186313; x=1701791113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HymwbPe2bft+ghh00VEorziNbD/acRLxYSQ0TW3O8EI=;
 b=S53381567ZixegvIZihsF4T11aiy4vO9iTDzWlgxLZ8hVmeWyS/UQQ3IcIKYHjXLu9
 NO/vnQ4gvkQcxolMEX48ASBRp8nKvndz7p9SyC6YuJjiKSGb+xF2WfxtElE1fD1DvWpj
 xWAeTDgswOYInJkUC1d5Y2HmjrNBCjG8EHHMUQ+Agr5P4Z7+XjLIIXRPDbsrwsMEkTQI
 lKoZRyy86AzlWnwJyxatFn3ChwokuTl4LqNl9NEXaj4hRTpJyFGnBqTkpxpBSrsloG6/
 /eBZlK4LSK9o8WvArneq39/PCAAY5PU5ex2BPDuWztbV2MQPL+SlBJEyiLdvghF4DSC8
 S6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701186313; x=1701791113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HymwbPe2bft+ghh00VEorziNbD/acRLxYSQ0TW3O8EI=;
 b=gW1M9Eicb90wmMURXqIgMlvrZew8oKvg+/UXfj1YsE96Er+RxK4bz6GcWTzwsEdjYt
 gXJbrgrcayLhWnUdtB1ZL+fONWN/eIwP97zELX3otzDLLsVEl24yk//9l3odk1AQBf7n
 GU3Vxtl6q0O0ClNPBJ4GJxfn1BP9q9bB2+GiRp2exn48LeAZCua+0G1+WhKWh+OZK780
 QVRA0Zf3+1qOQXXjnWgsIVy5ZyYWk6fjFUHdsO/78RQS0IETLkPNRbHUG6dmSYiuCAtB
 9eHQY7Ki21lwbDszxfknGekH+9huTOUM35vLziNICcEtOlnv5BKdfA2s7kavCg164JxD
 UJPA==
X-Gm-Message-State: AOJu0Yyt6CoaUjBIaNvKVdLQOF05NeCgcPhgmjCb4kfCyqoMYHSnPdY+
 JlqBppULETHIEZLB42LtSrg4Fg==
X-Google-Smtp-Source: AGHT+IFWP9vL645MkLXUEGBiqVt0o9bskR8/TvfQJnUu2Lbnp8aI9F+XopixWHjGlV+Ol8K4wYWxkQ==
X-Received: by 2002:a05:600c:138d:b0:40b:2afd:1a9 with SMTP id
 u13-20020a05600c138d00b0040b2afd01a9mr16292903wmf.15.1701186312690; 
 Tue, 28 Nov 2023 07:45:12 -0800 (PST)
Received: from hades.. (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c4fd300b0040b45356b72sm8474824wmq.33.2023.11.28.07.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 07:45:12 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: masahisa.kojima@linaro.org, ryosuke.saito@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Make DisconnectController follow the EFI spec
Date: Tue, 28 Nov 2023 17:45:07 +0200
Message-Id: <20231128154508.465171-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
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

commit 239d59a65e20 ("efi_loader: reconnect drivers on failure")
tried to fix the UninstallProtocol interface which must reconnect
any controllers it disconnected by calling ConnectController()
in case of failure. However, the reconnect functionality was wired in
efi_disconnect_all_drivers() instead of efi_uninstall_protocol().

As a result some SCT tests started failing.
Specifically, BBTestOpenProtocolInterfaceTest333CheckPoint3() test
 - Calls ConnectController for DriverImageHandle1
 - Calls DisconnectController for DriverImageHandle1 which will
   disconnect everything apart from TestProtocol4. That will remain
   open on purpose.
 - Calls ConnectController for DriverImageHandle2. TestProtocol4
   which was explicitly preserved was installed wth BY_DRIVER attributes.
   The new protocol will call DisconnectController since its attributes
   are BY_DRIVER|EXCLUSIVE, but TestProtocol4 will not be removed. The
   test expects EFI_ACCESS_DENIED which works fine.

   The problem is that DisconnectController, will eventually call
   EFI_DRIVER_BINDING_PROTOCOL.Stop(). But on the aforementioned test
   this will call CloseProtocol -- the binding protocol is defined in
   'DBindingDriver3.c' and the .Stop function uses CloseProtocol.
   If that close protocol call fails with EFI_NOT_FOUND, the current code
   will try to mistakenly reconnect all drivers and the subsequent tests
   that rely on the device being disconnected will fail.

Move the reconnection in efi_uninstall_protocol() were it belongs.

Fixes: commit 239d59a65e20 ("efi_loader: reconnect drivers on failure")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Heinrich this is critical. Although it doesn't break anything on our normal
use cases it does break the ACS testing for SystemReady-IR and I prefer
landing it in -master before the 2024.01 release

 lib/efi_loader/efi_boottime.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 0b7579cb5af1..370eaee8ce1a 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -1339,7 +1339,7 @@ static efi_status_t efi_disconnect_all_drivers
 				 const efi_guid_t *protocol,
 				 efi_handle_t child_handle)
 {
-	efi_uintn_t number_of_drivers, tmp;
+	efi_uintn_t number_of_drivers;
 	efi_handle_t *driver_handle_buffer;
 	efi_status_t r, ret;

@@ -1350,31 +1350,17 @@ static efi_status_t efi_disconnect_all_drivers
 	if (!number_of_drivers)
 		return EFI_SUCCESS;

-	tmp = number_of_drivers;
 	while (number_of_drivers) {
-		ret = EFI_CALL(efi_disconnect_controller(
+		r = EFI_CALL(efi_disconnect_controller(
 				handle,
 				driver_handle_buffer[--number_of_drivers],
 				child_handle));
-		if (ret != EFI_SUCCESS)
-			goto reconnect;
-	}
-
-	free(driver_handle_buffer);
-	return ret;
-
-reconnect:
-	/* Reconnect all disconnected drivers */
-	for (; number_of_drivers < tmp; number_of_drivers++) {
-		r = EFI_CALL(efi_connect_controller(handle,
-						    &driver_handle_buffer[number_of_drivers],
-						    NULL, true));
 		if (r != EFI_SUCCESS)
-			EFI_PRINT("Failed to reconnect controller\n");
+			ret = r;
 	}

 	free(driver_handle_buffer);
-	return ret;
+	return (ret != EFI_SUCCESS ? ret : EFI_SUCCESS);
 }

 /**
@@ -1409,6 +1395,7 @@ static efi_status_t efi_uninstall_protocol
 	r = efi_disconnect_all_drivers(handle, protocol, NULL);
 	if (r != EFI_SUCCESS) {
 		r = EFI_ACCESS_DENIED;
+		EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));
 		goto out;
 	}
 	/* Close protocol */
--
2.37.2

