Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF5C54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 09:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DAEC87FE9;
	Sat, 16 Mar 2024 10:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PRNLBGz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 651EB879F3; Sat, 16 Mar 2024 10:37:08 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00CE987EEC
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 10:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8049F44875; 
 Sat, 16 Mar 2024 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1710581820;
 bh=qBmkRpagYe/0CU3LxuRIWjMRWatDkPQd51RYMgeGrxs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=PRNLBGz3KopgRjFkckd1ne4BfilHBwMdLvUQv4vQ00RMhwVzuvxk4BkQmSo3NSw7T
 CQqYGCJK6wVWEAR/hi+dVQPOZKuUZAiCJUPW+WnXB/brkBtrprbkJ1pFlX0Coedt2G
 1N0NqONOfITvxaKtY0SSvoSowbac2xK6jA2PxKgXpGSMYryGkhyckMVCFDpqJuacl1
 87xPxtldLgxahw/Fmifb7p/kJm4KlB5chSv24eT3YrBcjKdS/SN1MRiAqGYaUb5aMe
 RXt87jQjesP20KsX5JXQkU/YLtru/Mml/Xi4XAegkAZVxKIBDtAGEL5AnS1vlX0t00
 hQ+CklFUZUsMQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] cmd: bootefi: error handling bootefi selftest
Date: Sat, 16 Mar 2024 10:36:44 +0100
Message-ID: <20240316093644.54869-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240316093644.54869-1-heinrich.schuchardt@canonical.com>
References: <20240316093644.54869-1-heinrich.schuchardt@canonical.com>
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

If bootefi selftest is executed and a problem with the device-tree
installation occurs, efi_install_fdt() writes sensible error messages.
It never returns EFI_INVALID_PARAMETER. It neither makes sense to check
for EFI_INVALID_PARAMETER nor to show the usage help for the bootefi
command in this case.

Fixes: 296faf4f7ef1 ("cmd: bootefi: re-organize do_bootefi()")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/bootefi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index b509440cde0..578dbb19a7e 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -171,9 +171,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 
 		ret = efi_install_fdt(fdt);
-		if (ret == EFI_INVALID_PARAMETER)
-			return CMD_RET_USAGE;
-		else if (ret != EFI_SUCCESS)
+		if (ret != EFI_SUCCESS)
 			return CMD_RET_FAILURE;
 
 		return do_efi_selftest();
-- 
2.43.0

