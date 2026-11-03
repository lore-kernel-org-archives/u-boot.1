Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55004606D806
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UP8HqI3+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WeGRy4oc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0673606C2;
	Tue,  3 Nov 2026 18:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcE1CtjScB_V; Tue,  3 Nov 2026 18:08:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2CBE4606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793729309;
	b=ONZyjvTk3E4ZdyXv2Z14lVjO1ejLs2yW1lcurOS3KIbkmOG2+IjyBSuL8S/3hZokGzks
	 b/7oGD0boG2qlCrsFop3g7ldtKniTq+Z4YD5774V3J/tQFBe/O/aDd+G/cm6KjQ/uh5xA
	 gQLjU2oZFii2CwXKFQPyZEu7PWlHUi4uFrJ60WJ1hfDKyDXRdxfROg1uanZJm63KuYS3V
	 qbNxNzDsM7azZq4AEBhx33ba6Fwobzu7k5zFKWCJD8UjwPW5ie7g9wshuY5uu+UdKfHuS
	 02Jjanp71qMNNNM4699dG6PlslXrYHKsq5yW198xFc2pL21W+t5I7H2mImDDbCzDWHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793729309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0orCgaPy6iQy3ltQBQQcyh0CW9EPxXdJ56nqnfDEH+0=;
	b=XiEBkWaKNYgwSiIYzt/Mh4r4Re1uwCeMequOmxLgNl/cTX5Y1TAGxS5zJF7Hxy5ouiP3
	 /8SQZLZtiuzobfPA+HmieGmWs+IzHT9NeHxEzFTBIFBaIotJOiEiZAOgQOu8uZPpJ5E4e
	 d6lTUXep5I0X5RTjhtyXoWk4A4mu4zzQu4IdbX/cuEyiPMdMfvQ3WvLbMYpp5Xa7C0AFd
	 TXVt7FG/8ZWaXonJu3nhAoylVS7Jn3ysAXMgYYRQ1BYSYFt54ZC3t0BBpaKkM3gGtYR0f
	 shdhsSm9+E8wsEWquR9QktIcyiX7vUxUnv2k10ZrND2z/zaf9EnbqOHSNgTkr/QyFHQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793729309;
	bh=0orCgaPy6iQy3ltQBQQcyh0CW9EPxXdJ56nqnfDEH+0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UP8HqI3+mkfzndyPAp/ivm3jWAKOQr1K/xE4gu2ardTBrKIZ5Z9xYlQ1V3EMAd9xn
	 96mmXU66nGWOjoIYhp5haMogOpVUD1lMfXFrm4c3Wex7lxUZOmdOnSgP0soGsf37CB
	 Ax0dA0RZ5iG4lGvkiw0Sz8PSt+vG451kh72W+FUZhVLy2pBDrytVEggOjie6m5ogBW
	 VV096nEkuRPo7NfrhA+0c+O31jAuwKxedgb/3kBh3kX3h4Ws5nddz8N4EWVKqkrvjH
	 6gTEE5+HrqH+JHd7kIOWWQMBxGd+6yDCjQzggHBFO81ydcQvVfNJMmE3qBVeTMRz8I
	 Nt9PaMtru6Lxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CBE4606A0;
	Tue,  3 Nov 2026 18:08:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CFB52AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79FFA4009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TgAqBYFeZ9qT for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 18:01:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BEF0540062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::829"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793728880;
 b=qizE1TeatRaGt+6shFmJAJZHO0zi2Sa0L1yGmdBKyikVOjvDxGmyfeKJt13bKh3oRySl
 EQmw0NHXNErtufIl0olzdhu0/6PY1AukFznzciID+fsJbU+wcaQjqD+GU89ctgpeIOdkE
 PwAfndiLqxfjRUrc2myDqSdcvA6jGZTRRsGg57yGjHNbD0KILaW3dWX4pDRxq7fNe4DXC
 soNCDMARSmMzER+L8HaUUogpkk256aiyyKBmSE/EDRV7TTxZ7JCbnX3y01RBxOriSRkks
 aZAISyqVShJrXqLl1WTfU3YslIgtvsS5dHgdTW+PKB3Ohb0G6kIRtXpgM1LBkeZWCdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793728880;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=0orCgaPy6iQy3ltQBQQcyh0CW9EPxXdJ56nqnfDEH+0=;
 b=pdsd3dRhYKmLF/8rRJMtL4SVifK25MBiEEA5CwtxD2Az3jq9G9fIFEA01+8N2hVRgjQC
 Dt5YQGQtBQatse/JJesL48ZZvHTiE8jVEL++BhbrGxPU4bVpZYAMBUUMYSyXDgfMzmRrK
 J1CYU5v+GoAhckPM7D+2TD4zSdcjaSWYQwES+crp7ODoF2R5r6wvoz6es40EVEZKCC9T8
 nJaHvKJnemFplKyu6vnrjnEWnuMIV/d3iolYQ/iWyG2Tc2pm9YsRcoQupqvCN3pS7D9cj
 Ae0Jm+HcBq7zCHHnQkB4ltaBgP3OgY8we1QHcGfYyWlP3KnrGapiD0XqUievPMFEf7Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WeGRy4oc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::829"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WeGRy4oc
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BEF0540062
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:01:19 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-54465f79af8so33474251cf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 10:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793728878; x=1794333678;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0orCgaPy6iQy3ltQBQQcyh0CW9EPxXdJ56nqnfDEH+0=;
 b=WeGRy4ocIWlapMbrCG2SiWM/xEkeRJnclfqgDpahXbV4On2jhygnMORMlOYlV3R/Rs
 lLDVkK+pIrzQENPkHrhyp/6vHhlTBUnX76O0+QnNCGAngXtkQfVUr1cLoRB/nsx9Pq16
 UAfwZTE04yu85ZfH/IupHhsQvgkV31PvFmeUZKFolM7hNVT9Y+t2dQRWtGO3n7vJqvS8
 L7ruBZg7cllQsp+O45AfL7PVGSMQOwiF9CGIpsWx/nLWoIwRa5Ac+R4BdWMZPfwF5VIQ
 GnhFZdOJwCdxovpYJgCGTyK7iNQJ8MRDAcNpkLq93CdoLjmlqqo5drivEQm1sk8Nhi1f
 Ymeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793728878; x=1794333678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0orCgaPy6iQy3ltQBQQcyh0CW9EPxXdJ56nqnfDEH+0=;
 b=nZpfR3n38iOj0mcD/k1liUx/ozLLICUy9/5hjSQNu34bUzYpeMB9fPXRo8B6fxUIrq
 gr8Rp7vYoA42dcvqtLjgBs1j3HDT8eq58HRm7np8dlg3OifEOaebzYh0DVUZSoIOKxNt
 lYaTmEHgYHEmwu75GINinEJvdj2tFPSqAdQZdamOtE2QWFvKWfuILfKiYwjKR6Jap3vh
 qyVp490+BZYlhal+eSjQjQL0FV80bPKeHX8mLEeZ/RzIXT0ytDUaZAng2UcdjlzcMD+s
 cVGJFxWNURhr2SCBtUGx9d9MDVOtVdiwDZ0lFE/2Vy+C1xYkI4zJwX/jN/rLV55NE2/i
 VvVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwq9XQNC5jHWvrgppw45zSf3aCQpYQaPZVAz023VNlOuLitjiMdw/qZwsvEqtcKZoCDce1RC4k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+/h7o8rIZnM9iAZDBoaxCxlmQlo9tjO8h+htPKBLKHC6cCihO0
 VRxwtjVqYWKp5Uod4pAB+gnviq7t2pmLOop/ulOxjvL20PLOBasRVayf
X-Gm-Gg: AYBFou0Hna3S1BG9yIdQZd0+PawFd0R5bEyCrQhhl0qBMc0lV8h2gzk2xQg/0jfn7+E
 +KDgWEKnjYcSPrY8MAfsyqseRCZseif25d61zWwdivM3+Z7qOA4UX5R2UzXXlSeesAmQ96rAcwM
 hK+2SmHx9Uae83Y0tTuNCAVIjx2E73TWABA+M6c4/3nvICmE3hSCOZ6gWbDLLHUKUi9yCNu52/f
 SSTnlGGJyzBZ6JjxGnMz6LTFob3x4y2PFoSJIxht9BGUqDFnQzso0ZuF1TdD0O0rFZfX4+OQmBI
 kd4imunGe7UHA+Zz1dfFMBS+nIH1RBlcLKoU3lFVZ5LPZVrIqCirRiSoKbSOockrwqUx2ctRYL7
 eqtcHX+H3U664FxVmbB+TrTpY1UHLcldWTfbFaP1ZZeiDoBJvrH9kHDrgbeTD7fJ/QBuxXR7RyV
 nFwPmBl+jpYklUg0dGizTP1ImS09jQva6nnqoBf12pPFAQiYoitQvqScbVXYULfLeMqGa0SWH2Q
 DSEJqMIaDTvTZrCo81E4FzFouQKYWzoPgShXgLD5T/96U69lxCPCre/LnKNSNFrIgPWppnFnd0N
 l9u9357tCJ4fV/3DsgG64xIO2QtCDUzkqQjL2UVGaK7AN+cy70r0
X-Received: by 2002:ac8:5d8f:0:b0:535:15a9:2514 with SMTP id
 d75a77b69052e-542b723bb06mr223627781cf.43.1793728877993; 
 Tue, 03 Nov 2026 10:01:17 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54b091c222asm2674711cf.0.2026.11.03.10.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:01:16 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] bootmenu: fix leak of entries for missing or inactive boot
 options
Date: Tue,  3 Nov 2026 13:00:30 -0500
Message-ID: <20261103180110.1025372-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 18:08:27 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

prepare_uefi_bootorder_entry() allocates a menu entry for each index in
BootOrder before it reads the Boot#### variable. The entry is only
linked into the menu if the variable exists and the boot option has
LOAD_OPTION_ACTIVE set, and bootmenu_destroy() only frees linked
entries. When the variable is missing or the option is inactive, the
entry is neither linked nor freed.

With CONFIG_CMD_BOOTEFI_BOOTMGR=y and CONFIG_CMD_EFICONFIG=y, each time
the menu is created with UEFI entries ('bootmenu -e' or
CONFIG_AUTOBOOT_MENU_SHOW), one entry is therefore leaked for every
such BootOrder index.

Allocate the entry only for an active boot option. If this allocation
fails, free load_option and bootorder before returning, as the error
path for the title buffer already does; bootorder used to be leaked
there.

Fixes: c606c0059f7f ("bootmenu: add UEFI boot entry into bootmenu")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Tested on sandbox_defconfig (LTO disabled for gdb) with Boot0001 active,
Boot0002 missing and Boot0003 inactive in BootOrder, running
'bootmenu -e' with bootmenu_delay=1 several times and reading
dlmallinfo().uordblks before each run. Without this patch each run used
128 bytes more heap than a control run with only Boot0001 in BootOrder,
which matches the two 48-byte entries; with it there is no difference.
The menu still lists only Boot0001.

 cmd/bootmenu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index b55f5579409..39fc16f8c27 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -304,10 +304,6 @@ static int prepare_uefi_bootorder_entry(struct bootmenu_data *menu,
 
 	num = size / sizeof(u16);
 	for (j = 0; j < num; j++) {
-		entry = malloc(sizeof(struct bootmenu_entry));
-		if (!entry)
-			return -ENOMEM;
-
 		efi_create_indexed_name(varname, sizeof(varname),
 					"Boot", bootorder[j]);
 		load_option = efi_get_var(varname, &efi_global_variable_guid, &size);
@@ -318,13 +314,18 @@ static int prepare_uefi_bootorder_entry(struct bootmenu_data *menu,
 		if (ret != EFI_SUCCESS) {
 			log_warning("Invalid load option for %ls\n", varname);
 			free(load_option);
-			free(entry);
 			continue;
 		}
 
 		if (lo.attributes & LOAD_OPTION_ACTIVE) {
 			char *buf;
 
+			entry = malloc(sizeof(struct bootmenu_entry));
+			if (!entry) {
+				free(load_option);
+				free(bootorder);
+				return -ENOMEM;
+			}
 			buf = calloc(1, utf16_utf8_strlen(lo.label) + 1);
 			if (!buf) {
 				free(load_option);
-- 
2.43.0

