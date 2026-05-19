Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96795CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 15:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C340C8487F;
	Tue, 19 May 2026 17:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tlr7CxEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C51BA848A9; Tue, 19 May 2026 17:21:12 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A23478488A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso1867001a34.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779204069; x=1779808869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63DDmHJejidxUFdOfIq6uN2xZcmKfECMaj7t1Dew+EA=;
 b=Tlr7CxEz7Z2t607iXIp0DuWhdSPEKASTNf5pSkFwOSpby9GDc0+vpfwDigsxrfy22m
 kWHthTsxMrl/IdxvRvVjwrEMhIpgi29+mSeJH+64M01Jf5f/bU369BdcWVpLMClXVg1o
 5Vj7py/GlvM2v+J3BFRPzrCUf85SfE9aXm6bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204069; x=1779808869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=63DDmHJejidxUFdOfIq6uN2xZcmKfECMaj7t1Dew+EA=;
 b=FNfiCMdJLsrPG359k7aI+BIPZhzYDevfDo07h9CxlILcnQwk5dP0EQma3rU/UDzOHn
 EZjt0MwjQSTwKUL3tcrF430sxrrDY2pxQwJVI+o8BadE9OYOpx3WTYEYFTEyiyHOZYHT
 DvZLWP45+sbkod9fzpfROFFRWLIMWiNCoCYpgmsjD3pXazaSPRqo14xNlrkISwScgzy8
 JdPHcS2pny1A2S20VuY3mwhKJBrprJkyzkkqrz6yr5JuBQtO3jvzMjDUWHwhHB+4siid
 7x8Mie5McLXZUgwopbeZ1AtxjRTUpvzl41jiCfnMdBRTqtH4GjQ9HaLfBXbDpbuyuNte
 vO6Q==
X-Gm-Message-State: AOJu0YzvqqsmqwkRNymmExtJV439vMP5LG1/HKtR+aGt7LLKdrkYvOr2
 Clyq0L7XmHoszJdNkH5hZtviT0I8QYLsjazu817VI196L58nJGxQYTsfh9W+vPu+i+3O5DAi43H
 D5mLqh9JmIWax
X-Gm-Gg: Acq92OFpFvYX4bmlVkwgMhspbepTtXVU+Zn9iXrR09OzmLYmdgVBfrdvPElqzdgLVOY
 pnfbBJOEAS3zWGsBSivriTJN+O2MlZUBGZwnLDSePly3NloDDrNWo9wKxMiGRy/6npINxmZ/cc6
 U1yE3lzqE0WBWtVDlU9xUBgDuded2/MgRhYAOq15q4SRr3Q636hwUwAtaQnim0YyVrDRxLA9a1e
 6Md8ziCpB5ZuwOQuMYKDEOEJoQ8IoUHfRO3Huy+IpooPFsX4dL2LBIbTBfDwJpoYqMN9xGC172Y
 xyVjp8MpAqtIAg+pNBaB1q2LHYw+FY7+yCazrkeLaeJWcHT0K5KV0mhg4bedUBbrCfpoZ3JsNBg
 lBSr9kXqgSPDn0m3CLTtakeIOH5f8Suxk/rl1m3+7aML3cdIpoCIX5OTGCdJB9hG852D05aLERr
 qgHPWFoVrJDEBhk+7JRKxxPyG8pV4mg5dr37GFAAYR3tQ2WVzJ5AXpLZuTKI0ilSmDHWtQ9Q9+6
 bSK7EcV2XaY4NZqUqqOciyi062Y552suqA933yJoPUG47BFtlvjFbjwbi3J+cMKjE5o9MhCPQ4=
X-Received: by 2002:a05:6820:138c:b0:694:6d72:9fca with SMTP id
 006d021491bc7-69c942aeedcmr12495974eaf.7.1779204068746; 
 Tue, 19 May 2026 08:21:08 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a9576cdb2sm7170167fac.16.2026.05.19.08.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:21:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 4/5] scsi: Drop empty bootdev_ops structure
Date: Tue, 19 May 2026 09:18:19 -0600
Message-ID: <20260519152101.716714-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519152101.716714-1-trini@konsulko.com>
References: <20260519152101.716714-1-trini@konsulko.com>
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

We don't need to provide an empty struct here now that the caller can
handle this being empty.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/scsi/scsi_bootdev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/scsi_bootdev.c b/drivers/scsi/scsi_bootdev.c
index 28e4612f337c..541b021b732c 100644
--- a/drivers/scsi/scsi_bootdev.c
+++ b/drivers/scsi/scsi_bootdev.c
@@ -37,9 +37,6 @@ static int scsi_bootdev_hunt(struct bootdev_hunter *info, bool show)
 	return 0;
 }
 
-struct bootdev_ops scsi_bootdev_ops = {
-};
-
 static const struct udevice_id scsi_bootdev_ids[] = {
 	{ .compatible = "u-boot,bootdev-scsi" },
 	{ }
@@ -48,7 +45,6 @@ static const struct udevice_id scsi_bootdev_ids[] = {
 U_BOOT_DRIVER(scsi_bootdev) = {
 	.name		= "scsi_bootdev",
 	.id		= UCLASS_BOOTDEV,
-	.ops		= &scsi_bootdev_ops,
 	.bind		= scsi_bootdev_bind,
 	.of_match	= scsi_bootdev_ids,
 };
-- 
2.43.0

