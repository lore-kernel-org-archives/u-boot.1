Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16B5C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 12:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BACC846A4;
	Mon, 20 Jul 2026 14:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pknm8MfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20D383E76; Mon, 20 Jul 2026 10:29:42 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1064880517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C1BDA3F601
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784536180;
 bh=W8D1egvH13JqUlKZLJq3kWF0mFLWtzF3eo/wpM8FUXY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=pknm8MfMsXWldHaUYi2ywS0xl7W2jYtQDKhEZjioWLKJtoBlUplRN4vFDlS3Edk5I
 YogNVXT8z99kmFCJqtvDVxZKOTL5mKEIE/6gfpB/nKic/MJuGPcQM7vRpiQye2Xlpp
 ZYM61vQnb4RrQh1ItrTvIb7h/yRvp6glrKygN4bAVP1sabvLk856BN+4gGIA4szKZ6
 BMvMHVfo6g4bWpRnWoVOLMRhcJ0XVr7WeKrxZmCAhhYlLfmOnbm6Rt2X912bn2KWL2
 KeN0cC6RR6zuxRXA7gnEjijFQm7RJC+4NN/Ph5dj8L/wmpyb9sUmR6gIP8ZNHkPoCd
 UtPfZDBTid58geoqCZcEJWM6A1eQq7X2vZNV/Yw8DYcNDQf9ISCmakXHes1Xa3kdAX
 2k1DW3lIFsSQdM6TZMzNq75i5HqeOLU8AcGtnhahEICkG2rRh22ApX/xgHX6LGC7zl
 iIi/O85qt36EVEiBnYBKDUy5ijY6c7kFAnZN1/25pg6ddm1jN0SPFjCbVr4Fl8YMK9
 Yp8z29BbhLxN7Q3HP4JkBzicy9cg6ydHNePxMV6cq+ZDD9zQxfrdcgJUyjiEoqO0cL
 KnoopEImNa0zLqNv9i67kgrfjRm/lU4JeXLoMKu9jBYLIXOFk+MGeMZC7mhIaQmpdk
 hn3URaBUuisFGDUp/EW6If3g=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccbb61893fso207261325ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536179; x=1785140979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W8D1egvH13JqUlKZLJq3kWF0mFLWtzF3eo/wpM8FUXY=;
 b=WDTxBxAZ2brAlGpW0ws73W358J7bNo9jh0ut9AmWT8VoSDw20gqd1p72VeCqS4nFHB
 a+VSjUnRc3iCxfteMy8LtEjFA3fo/5BNDzrROMeatGE2aeBodFtX/19lLLtnpUPvGhst
 YGTC1GVrJjmqKOE4xEmyEwo7SvuLc1KPTn3xyohmYo8Lcgu5ixa0I0jbVX4S+KGDN+R3
 1TCQiBUCHbS1/zleZ+dSlVD4YQRsoX4nKGddQr4/J9a+WSYUDlZPiPq/IgvYxCRuGePw
 pkmrGwAHAaUknLHn34VFETaH3WPlarEtMFVKPlKrCxQmLkP1qaPzII4bXD6xhETD9fI8
 4ccA==
X-Gm-Message-State: AOJu0YyYsjCGil25zBPjOdKzg+AKH89pTjnG+CzQ3F7VTaKxg3LJ7+9y
 z84LJneLIWjXsBsF4MqGqCHTH0KANQAvSUYOL8uCqOI5gYd6dunQ3zRXfA1LoW+2faV1ePL4PV+
 NTxUPq3bYWPjgfPW934IWUyeHCLzCQApAhVTxJGrCYYwa63O1NPJATS4RA/T70WalWkxGVtNWfg
 DSWwU=
X-Gm-Gg: AfdE7ckvCax2v8DCdIj1IA1XwGptUbIFSW3ab/9x6Gn7zUDvyc26UpngtNjB5ZDxPQX
 YWjnTpjGoCupXFZPQOd3D75e1rW+82RfF2orFFXM84YvLnj7nVbVUFzmA8d2Gc01f1D9YELmUhJ
 FxclcejOO3IHNMUNTtpLK0kH3c2HENyFDUd7eYoOULwnvrzmzZZD9m/k8i3Z/k0SN5t769vdOPI
 aKhGiYXbdiE3bWWdUj1Xd5J6jB4UgvbAKgRc9GJJ4qQ/HH6HCpXn3PIfWd/JY6iqj/JGLCh2DrL
 3vE0P9tcteVi38BDfEFo6QEpX28zDhwarai3n/h0B2aHV28IoH1UTGeqpVokmeXwNwP4NUKRJWs
 JQP9XyKUVnruPBTVGGIiYUBBIifrOJNBueXsLMb6rAi1FPHVJedtIwfGV0l0vhyxGmOU=
X-Received: by 2002:a17:903:2986:b0:2ce:b7b7:30e3 with SMTP id
 d9443c01a7336-2cf348575cbmr155192355ad.17.1784536179225; 
 Mon, 20 Jul 2026 01:29:39 -0700 (PDT)
X-Received: by 2002:a17:903:2986:b0:2ce:b7b7:30e3 with SMTP id
 d9443c01a7336-2cf348575cbmr155192075ad.17.1784536178824; 
 Mon, 20 Jul 2026 01:29:38 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34713fe1sm52975265ad.55.2026.07.20.01.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:29:38 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] cmd: nvedit_efi: use efi_auth_var_get_guid() for the
 default GUID
Date: Mon, 20 Jul 2026 08:29:13 +0000
Message-ID: <20260720082917.2162-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720082917.2162-1-aristo.chen@canonical.com>
References: <20260714094902.438079-1-aristo.chen@canonical.com>
 <20260720082917.2162-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 14:28:29 +0200
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

do_env_set_efi() hand rolls the mapping from well known variable names
to their default vendor GUID and has already drifted from the canonical
name_type[] table in efi_var_common.c: it does not know "dbr", so
"env set -e dbr" operates on the variable under EFI_GLOBAL_VARIABLE_GUID
instead of the image security database GUID, silently creating a
variable that nothing will ever consume.

Convert the variable name to UTF-16 before selecting the GUID and let
efi_auth_var_get_guid() do the lookup. That function knows all
authenticated variables including "dbr" and falls back to
EFI_GLOBAL_VARIABLE_GUID for any other name, so behaviour is unchanged
for "db", "dbx", "dbt" and non-authenticated variables. Future
additions to the table now apply to the shell command automatically.

Since the conversion now happens before the value parsing loop, free
the UTF-16 name at the common exit label so the error path there does
not leak it.

Also drop the unmap_sysmem() call right after efi_set_variable_int():
the common exit path already unmaps the value for the -i case and frees
it otherwise, so the value was unmapped twice. On sandbox the second
call triggers a spurious "Address not mapped" warning for addresses
that get a tagged mapping.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
Changes in v2:
- no code changes, collected Reviewed-by tag

 cmd/nvedit_efi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/cmd/nvedit_efi.c b/cmd/nvedit_efi.c
index 3a36f94775b..f38802e4f4d 100644
--- a/cmd/nvedit_efi.c
+++ b/cmd/nvedit_efi.c
@@ -448,13 +448,14 @@ int do_env_set_efi(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_USAGE;
 
 	var_name = argv[0];
-	if (default_guid) {
-		if (!strcmp(var_name, "db") || !strcmp(var_name, "dbx") ||
-		    !strcmp(var_name, "dbt"))
-			guid = efi_guid_image_security_database;
-		else
-			guid = efi_global_variable_guid;
+	var_name16 = efi_convert_string(var_name);
+	if (!var_name16) {
+		printf("## Out of memory\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
 	}
+	if (default_guid)
+		guid = *efi_auth_var_get_guid(var_name16);
 
 	if (verbose) {
 		printf("GUID: %pUl (%pUs)\n", &guid, &guid);
@@ -479,16 +480,8 @@ int do_env_set_efi(struct cmd_tbl *cmdtp, int flag, int argc,
 			       16, 1, value, size, true);
 	}
 
-	var_name16 = efi_convert_string(var_name);
-	if (!var_name16) {
-		printf("## Out of memory\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
 	ret = efi_set_variable_int(var_name16, &guid, attributes, size, value,
 				   true);
-	free(var_name16);
-	unmap_sysmem(value);
 	if (ret == EFI_SUCCESS) {
 		ret = CMD_RET_SUCCESS;
 	} else {
@@ -518,6 +511,7 @@ int do_env_set_efi(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = CMD_RET_FAILURE;
 	}
 out:
+	free(var_name16);
 	if (value_on_memory)
 		unmap_sysmem(value);
 	else
-- 
2.43.0

