Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B69CC43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 12:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61B884D20;
	Tue, 14 Jul 2026 14:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CdNYfHZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0504F84CE1; Tue, 14 Jul 2026 11:49:44 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B8D384C5E
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 11:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9C2C13F29C
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784022581;
 bh=aUfURzv0fxWSUk/PEvimJPLDRoGe0URhkhy06KRChaY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=CdNYfHZlb5t/19dOaDb8SEpu3lnevg2bQjR935ptl6mACzrf3me6XADaxdaK0YR/M
 nKQ+cRFwKFleYEFty94VHhbucLEme7KjE/BJRuQWnfcpnnZstiB3z6TFvP+v4Hs2Er
 5XuX9fRcoTofk2d3RkTUzln8zVdpYS+CnKXOv3+lBHA+Mv5Qhy0cYApbAuxgKJMLMB
 gEIfOTtbWCfPzD6rq1AmKxe51qgNv3MNIeJpFBUth1lqZV3p9mVWehoP0LN6OJbLFp
 j4HAztFVnyJGXCEjgHJ8X78S4ac56C3YqTJxpXFLV9gB8Mrca6woEArUo/jFULkPEQ
 UrPuDCfExa+iKOqUrF4JGg0qzZ9Z1miPTujOHS3TQ+7UF+Bkxknr66L2c/l2Yu0vq0
 7XWkXrnA9qDX4tWMbBeNkTkA/Kd973IpGZiyLEwijNGZrrrVm5YnfNxXyhYpCE3FTY
 Udcwv67/yib7xMZsgEdePo5BF5ogRiPOIZwX0BVOpFGDtsD5tBNxdvF7oFw4M8nFyR
 mZKjQTHaBENEzIpp26IR3Kx9z+pWMG3LTW1pSQKWaotIYj1NT8CKjTDPVg62lOViQw
 xmvMxAFqTr1rn3v+VA0OslOd1WXHfnLSrf8JOGB/Rp2Hkk6KrROoSFmu1/mOFjiBA2
 XTDz0zaUgh++4/1z/P4nzAvU=
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-caf5fa127d4so1283264a12.0
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 02:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022580; x=1784627380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aUfURzv0fxWSUk/PEvimJPLDRoGe0URhkhy06KRChaY=;
 b=RpkZTQfEDiFYujruhF2sufX8kIhW7BlS9uBBY4NXDO3OA0sbhV7qtVYpIuUNiqKfYy
 2Fali5qv+s2UPf7Y6RkjQr4Q2pYfyRWpJxqr40n5GcgI41JuNI+gPbAbVZFYndrsKpeS
 5JJQMTFHbwSNtrbYffAagpSUgcIUy2x0SUQ/Fqj2yQ1JnI2FuTAbfnH/RqW4wMEgmBDc
 7MMLZ1QU64HKhcT/1W1V7qsBWpolcVcYIhozrLgzN74bleaDzZw9VJjz3B/CX18KToFS
 WRQ8mspMgzBXn1QkjftnMqFUT7lZqu5zFBLXoVuCzY9XDIW3MFkHdOJ64uHnVglwblc5
 Wjrw==
X-Gm-Message-State: AOJu0YxGPktP0OCen0WusFdVscD3pJvZKgGiQA5QvyBsRT8S/SrAlKlg
 NToCEFjjXOfcymsgv+/kGqjf+4zXmdj84w8Pck+fpR78BHyQ4Z2DIXGkXYJwUkNAlDVxoQaRh52
 sMlhqTEiehnRrgeUwZsvrPDqvsvi4eJAx4XS6D9DBH3jUYpZ4VVpS8z3ti1sVgNZcADznCfO1IT
 cstUk=
X-Gm-Gg: AfdE7cnb8MppUwQ79zJBM8lLAFDOBJHbCh1AaVtJpqqxqMWmo7bqZfR7rEDSbaDgEq4
 z8kFCdCHPxmJ3x3z9+Jfw2Logx4lCIxgTQXu44IqbzJD69m3jEA4ppbnpi8pxjxy1AzuAtk9Kdw
 AMYPK34EA7Mq0mdan9fj3byJOgqOfcrc+aBgikdOlk7reuOqyvO+UoUjQ+NQkUdYx2uKXmUuWQm
 huygi5FRoNSe/bRgt8tyOAggxlX1XCFXwxxpQQ3qcOpWCPdxZnU0JqhFF4f5hMXn7GO+PKkNTNv
 gysdC2gunAUdWKspSXZfOsIR0dy9K/3mcygqehGgvwKqqbIVCXoNbsGtuqAgXHGUH6kKq/CpxEg
 y/Guld0L9+CvtBpG4OoanRTBsdqJTE2zWsV4YawQty3RYT1xWHGxofG75k6aGxMdGZRPt3kq6ug
 s1q4s7
X-Received: by 2002:a05:6a21:2d44:b0:3b5:6b5a:4f29 with SMTP id
 adf61e73a8af0-3c1102a1727mr12305771637.30.1784022580045; 
 Tue, 14 Jul 2026 02:49:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d44:b0:3b5:6b5a:4f29 with SMTP id
 adf61e73a8af0-3c1102a1727mr12305757637.30.1784022579751; 
 Tue, 14 Jul 2026 02:49:39 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3c1f77fsm9687752a12.32.2026.07.14.02.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:49:39 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/2] cmd: nvedit_efi: use efi_auth_var_get_guid() for the
 default GUID
Date: Tue, 14 Jul 2026 09:48:59 +0000
Message-ID: <20260714094902.438079-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714094902.438079-1-aristo.chen@canonical.com>
References: <20260714094902.438079-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jul 2026 14:51:05 +0200
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
---
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

