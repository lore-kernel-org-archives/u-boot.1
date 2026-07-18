Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAADC4450A
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 21:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF929847AF;
	Sat, 18 Jul 2026 23:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B7F847AF; Sat, 18 Jul 2026 23:11:51 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94701846F8
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 23:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlCJz-000000000Hk-2quP; Sat, 18 Jul 2026 21:11:43 +0000
Date: Sat, 18 Jul 2026 22:11:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Gregor Herburger <gregor.herburger@linutronix.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: give SimpleTextInputEx its own WaitForKeyEx event
Message-ID: <141397f1be56cf730a3222263c091347fa4cda4e.1784408712.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The console input used a single wait event for both the
EFI_SIMPLE_TEXT_INPUT_PROTOCOL and the EFI_SIMPLE_TEXT_INPUT_EX_PROTOCOL
by aliasing wait_for_key_ex to wait_for_key. The UEFI specification
describes these as separate events, and a client that opens ConInEx and
drives WaitForKeyEx independently of the base protocol (the Windows Boot
Manager does this) can then desynchronise against the shared object and
never observe a keystroke, even though GRUB and systemd-boot, which lean
on the base wait event, work.

Create a distinct WaitForKeyEx event, and signal and clear both events
together when a key becomes available or is consumed, so every client
sees a consistent wait event regardless of which protocol it uses.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 lib/efi_loader/efi_console.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 8d076058280..2c8adfcb2d1 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -681,6 +681,7 @@ struct efi_cin_notify_function {
 static bool key_available;
 static struct efi_key_data next_key;
 static LIST_HEAD(cin_notify_functions);
+static struct efi_simple_text_input_ex_protocol efi_con_in_ex;
 
 /**
  * set_shift_mask() - set shift mask
@@ -937,6 +938,7 @@ static void efi_cin_check(void)
 
 	if (key_available) {
 		efi_signal_event(efi_con_in.wait_for_key);
+		efi_signal_event(efi_con_in_ex.wait_for_key_ex);
 		return;
 	}
 
@@ -949,8 +951,10 @@ static void efi_cin_check(void)
 			efi_cin_notify();
 
 			/* Queue the wait for key event */
-			if (key_available)
+			if (key_available) {
 				efi_signal_event(efi_con_in.wait_for_key);
+				efi_signal_event(efi_con_in_ex.wait_for_key_ex);
+			}
 		}
 	}
 }
@@ -1058,6 +1062,7 @@ static efi_status_t EFIAPI efi_cin_read_key_stroke_ex(
 	*key_data = next_key;
 	key_available = false;
 	efi_con_in.wait_for_key->is_signaled = false;
+	efi_con_in_ex.wait_for_key_ex->is_signaled = false;
 
 out:
 	return EFI_EXIT(ret);
@@ -1259,6 +1264,7 @@ static efi_status_t EFIAPI efi_cin_read_key_stroke
 	*key = next_key.key;
 	key_available = false;
 	efi_con_in.wait_for_key->is_signaled = false;
+	efi_con_in_ex.wait_for_key_ex->is_signaled = false;
 out:
 	return EFI_EXIT(ret);
 }
@@ -1351,7 +1357,12 @@ efi_status_t efi_console_register(void)
 		printf("ERROR: Failed to register WaitForKey event\n");
 		return r;
 	}
-	efi_con_in_ex.wait_for_key_ex = efi_con_in.wait_for_key;
+	r = efi_create_event(EVT_NOTIFY_WAIT, TPL_CALLBACK, efi_key_notify,
+			     NULL, NULL, &efi_con_in_ex.wait_for_key_ex);
+	if (r != EFI_SUCCESS) {
+		printf("ERROR: Failed to register WaitForKeyEx event\n");
+		return r;
+	}
 	r = efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
 			     efi_console_timer_notify, NULL, NULL,
 			     &console_timer_event);
-- 
2.55.0
