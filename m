Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340DCC07E97
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 19:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC3AA87759;
	Tue, 28 Nov 2023 20:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X/NxtJ64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F0C187759; Tue, 28 Nov 2023 20:10:39 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2048A8776E
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 20:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40b4746ae51so19051695e9.2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 11:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701198634; x=1701803434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ofu0ZAm1ZzWGmYPlNN/W3cNC+DAOirmPYPc799aAufc=;
 b=X/NxtJ64xt/6NPyynyZks/RK7bthWxre+mUZFnx6syp0Yz97cCEWeCdOKkxwJ/5lM8
 FSo4effoANwZN/ZJS2Gy33/8q9Cobqo9olRyMbElb9B/pWxIqBHfgBaCIxBDDVRBFgHD
 Fk5FpappL1aQcKJpBQjl8kNSmF1M67608Weg9NJ09R6RMv956XXULsYsfa1MNN3Ee/VI
 SdhilZcYBD7UPrxaCUukWkQTRwuA/BuEVKWUx1FeS7GBUnJ122x/C4w5M27NJYuJEYv2
 DC6lKIFbefHbVMbk2zFhjYYtnZ8c1g8wdLGd1SNwGACNMRYRWa72DI891NOG7A657y9q
 0Hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701198634; x=1701803434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ofu0ZAm1ZzWGmYPlNN/W3cNC+DAOirmPYPc799aAufc=;
 b=Guj70qkb9gk9BKZ18IWSd7WVm0FOgYpDD3n14dUukK76PGaOe6VMdmTjMz91iZ1ANb
 D5+KNgyh/P7GILcVcHvT0OWdOY/Q+HxU7FYf8JQCgWn9R5PMIZQ4TsBVb0FPVrBq/e2u
 PyjzGldLT+/lfaWPM9WL3RT7kpAEM1FoqydCTZjZppWkR1zKmz6C5Efj81o6N87gYS87
 UWHyzEbvxQDTG9ym4QrS1zhTgR43As6afVOs0036k5bMzgsc7FGtbGIlLj7zanVO2tv5
 105PZeKJqIkm5lxeTdSJxOKY/kxRWEbxbq6PUMOJiFLXygcLACROgwBAvXq9bcfJ3879
 F90A==
X-Gm-Message-State: AOJu0Yy+OBCPGByYi6M0AejJyFhOVoY/dgSe+pg/z8HNU9guL/w8Mo+0
 32MBZAqorbnPTtibiIGR5J/WrQ==
X-Google-Smtp-Source: AGHT+IGTa1o1lzY3L489uy14Q7BHsmutsbeKEgkykoQZKhaHacZrBb10PYtjLk+6MFQiArG3RzSQdw==
X-Received: by 2002:adf:ffd0:0:b0:32f:7a65:da64 with SMTP id
 x16-20020adfffd0000000b0032f7a65da64mr11884637wrs.65.1701198634542; 
 Tue, 28 Nov 2023 11:10:34 -0800 (PST)
Received: from hades.. (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 cr6-20020a05600004e600b00332cc24a59bsm15653028wrb.109.2023.11.28.11.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 11:10:34 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: masahisa.kojima@linaro.org, ryosuke.saito@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2] efi_loader: Make DisconnectController follow the EFI spec
Date: Tue, 28 Nov 2023 21:10:31 +0200
Message-Id: <20231128191031.467222-1-ilias.apalodimas@linaro.org>
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
Apologies for the fast resend, but since Heinrich reviewed it and
we want it in 2024.01 resending
Changes since v1:
- return ret instead of (ret != EFI_SUCCESS ? ret : EFI_SUCCESS) which does the
  same thing...
- Add a comment about reconnecting all controllers
 lib/efi_loader/efi_boottime.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 0b7579cb5af1..ea711919630b 100644
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

@@ -1350,27 +1350,13 @@ static efi_status_t efi_disconnect_all_drivers
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
@@ -1409,6 +1395,13 @@ static efi_status_t efi_uninstall_protocol
 	r = efi_disconnect_all_drivers(handle, protocol, NULL);
 	if (r != EFI_SUCCESS) {
 		r = EFI_ACCESS_DENIED;
+		/*
+		 * This will reconnect all controllers of the handle, even ones
+		 * that were not connected before. This can be done better
+		 * but we are following the EDKII implementation on this for
+		 * now
+		 */
+		EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));
 		goto out;
 	}
 	/* Close protocol */
--
2.37.2

