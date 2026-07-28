Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D348C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E95A5810DD;
	Wed, 29 Jul 2026 04:56:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWFQgocbNq0f; Wed, 29 Jul 2026 04:56:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1495D810BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300961;
	bh=10ysklgIiQL4TAOJI8FZtJxZUKTiNgcZOJ/tOHl50NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jf2nxzILcCHBxr1bb4axcPgm3FUvbTrAG9/tV1NNZJ1q0zA0q63DiYOb6H3bR1hzi
	 0x2PNr8t85JSz+YkklElySnJIJfWogaZ1sPEgRl1M6DqUev8inoq9/DAIP607cBvJC
	 aTQdd/FIMpB0ouyBjxadm+XckEYjPDFz2/5Gj39kNLGMKkTzoV1ULzRibP5EjQQre9
	 6sguInwfnWwPWLKDHCTAbz+wBUdIA19kg3AtAw0UIsvbmM7H2eiLcyJ8OxxHveXK/C
	 MgSFxP5ONmCiwzUkjgpk9bI9BsQZlHDFJ92tdg1DrbSosTaFjPPfcfPXUAV88JTE6L
	 mClzLHkvCw6zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1495D810BF;
	Wed, 29 Jul 2026 04:56:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1606626C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F038A608DE
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:33:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SlWhbVKBuf_F for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 19:33:42 +0000 (UTC)
X-Greylist: delayed 9424 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 28 Jul 2026 19:33:41 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EFAD960703
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFAD960703
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=23.83.223.168;
 helo=slateblue.cherry.relay.mailchannels.net;
 envelope-from=smoser@brickies.net; receiver=<UNKNOWN> 
Received: from slateblue.cherry.relay.mailchannels.net
 (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EFAD960703
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:33:41 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@smoser.brickies.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id BE6A0381FAC;
 Tue, 28 Jul 2026 19:33:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com
 (100-110-255-77.trex-nlb.outbound.svc.cluster.local [100.110.255.77])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 855A738229E;
 Tue, 28 Jul 2026 19:33:39 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@smoser.brickies.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@smoser.brickies.net
X-MailChannels-Auth-Id: dreamhost
X-Robust-Glossy: 2c803ddf3351d761_1785267219623_2222264467
X-MC-Loop-Signature: 1785267219623:532643797
X-MC-Ingress-Time: 1785267219622
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.110.255.77 (trex/8.0.2); Tue, 28 Jul 2026 19:33:39 +0000
Received: from localhost (unknown [206.169.177.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: smtp@smoser.brickies.net)
 by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4h8lxv2FxWz1dq; 
 Tue, 28 Jul 2026 12:33:39 -0700 (PDT)
From: Scott Moser <smoser@brickies.net>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Scott Moser <smoser@brickies.net>
Subject: [PATCH v2] efi_loader: fix use of uninitialized guid in variable
 enumeration loops
Date: Tue, 28 Jul 2026 12:33:28 -0700
Message-ID: <20260728193328.865976-1-smoser@brickies.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728164948.821237-1-smoser@brickies.net>
References: <20260728164948.821237-1-smoser@brickies.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brickies.net; s=dreamhost; t=1785267219;
 bh=10ysklgIiQL4TAOJI8FZtJxZUKTiNgcZOJ/tOHl50NI=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=bo8LHfeeEe0BkaJ66W85JCa4M2ipNMnRBWGzFHRTH3KscSaRUwoPCSTxpsamqU1L7
 /vmpsj4MiJkX5FCgzvxlc9UOIaeUcksJNxLmRFTbnp3doRihoCmFNGsvBxXR2TRz5w
 qLUfePT+6W0CMaXK9lTi2DYVbNhqx5oMc7qtsbMG7r9P/fYoZEp5Yc+HqAkcDoQHIF
 KlXTB1oLxrCGwH19xWkPwTqLm6dajHoGRlNxpZQof0pP5rUrzmrJWsVj/Uu+zEMFFf
 IYl1n+HgdEqxSFkY+QNRDOobjptJbV+tbyMpWyR8/gR2NlRAhuI/HgGAT0N2bDiXYt
 RTpDDBmVmLPZw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=brickies.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=brickies.net header.i=@brickies.net header.a=rsa-sha256
 header.s=dreamhost header.b=bo8LHfee
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

efi_bootmgr_delete_invalid_boot_option(), eficonfig_show_boot_selection(),
and eficonfig_create_change_boot_order_entry() each enumerate all EFI
variables by repeatedly calling efi_next_variable_name() in a loop,
passing the same efi_guid_t as both input and output. GetNextVariableName()
needs the vendor GUID returned by the previous call, together with the
variable name it returned, to know where to resume.

In each of these loops the efi_guid_t was declared inside the loop body,
so a new instance comes into scope on every iteration. Relying on it to
still hold the previous iteration's value depends on the compiler reusing
the same stack slot across iterations, which is undefined behavior. With
a compiler that zero-initializes locals by default (e.g. clang, or gcc
configured with -ftrivial-auto-var-init=zero), the GUID is cleared on
every iteration, so the lookup of the variable name returned by the
previous call fails and efi_init_obj_list() aborts:

  Cannot initialize UEFI sub-system
  ** Booting bootflow ... with efi
  Boot failed (err=-22)

Move the efi_guid_t declarations out of the loops so the value written
by the previous efi_next_variable_name() call is preserved across
iterations.

Fixes: 140a8959d48f ("eficonfig: use efi_get_next_variable_name_int()")
Signed-off-by: Scott Moser <smoser@brickies.net>
---
Changes for v2:
- Drop the "= {}" initializer on the hoisted guid: per the UEFI spec,
  VendorGuid is ignored when VariableName is an empty string, which is
  the state var_name16 is in on the first call, so the initial value is
  never read and zero-initializing it only costs code size.

 cmd/eficonfig.c              | 4 ++--
 lib/efi_loader/efi_bootmgr.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index 4d060e3007c..d8e7ed6666a 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -1844,6 +1844,7 @@ static efi_status_t eficonfig_show_boot_selection(unsigned int *selected)
 	struct efimenu *efi_menu;
 	struct list_head *pos, *n;
 	struct eficonfig_entry *entry;
+	efi_guid_t guid;
 
 	efi_menu = calloc(1, sizeof(struct efimenu));
 	if (!efi_menu)
@@ -1872,7 +1873,6 @@ static efi_status_t eficonfig_show_boot_selection(unsigned int *selected)
 	var_name16[0] = 0;
 	for (;;) {
 		int index;
-		efi_guid_t guid;
 
 		ret = efi_next_variable_name(&buf_size, &var_name16, &guid);
 		if (ret == EFI_NOT_FOUND)
@@ -2245,6 +2245,7 @@ static efi_status_t eficonfig_create_change_boot_order_entry(struct efimenu *efi
 	u16 *var_name16 = NULL;
 	efi_uintn_t size, buf_size;
 	struct eficonfig_save_boot_order_data *save_data;
+	efi_guid_t guid;
 
 	/* list the load option in the order of BootOrder variable */
 	for (i = 0; i < num; i++) {
@@ -2265,7 +2266,6 @@ static efi_status_t eficonfig_create_change_boot_order_entry(struct efimenu *efi
 	var_name16[0] = 0;
 	for (;;) {
 		int index;
-		efi_guid_t guid;
 
 		if (efi_menu->count >= EFICONFIG_ENTRY_NUM_MAX - 2)
 			break;
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 8c9a9b5eb56..8938b214ceb 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -934,6 +934,7 @@ static efi_status_t efi_bootmgr_delete_invalid_boot_option(struct eficonfig_medi
 	efi_status_t ret = EFI_SUCCESS;
 	u16 *delete_index_list = NULL, *p;
 	efi_uintn_t buf_size;
+	efi_guid_t guid;
 
 	buf_size = 128;
 	var_name16 = malloc(buf_size);
@@ -943,7 +944,6 @@ static efi_status_t efi_bootmgr_delete_invalid_boot_option(struct eficonfig_medi
 	var_name16[0] = 0;
 	for (;;) {
 		int index;
-		efi_guid_t guid;
 		efi_uintn_t tmp;
 
 		ret = efi_next_variable_name(&buf_size, &var_name16, &guid);
-- 
2.55.0

