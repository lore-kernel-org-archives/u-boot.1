Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC12C5B56A
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 17:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C268381098;
	Tue, 11 Aug 2026 17:20:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6TTfXrHbwMaf; Tue, 11 Aug 2026 17:20:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C81F680FAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786468823;
	bh=Fb3hg1RFoxjQ6BPaGfa2VO7JDy8p/Vm48PtMrZ1DIKg=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BLhZvY6+PfZ8Xfb+j5z6n7WEEi+yj5O0vhUnyOiEN+v4bivRg2/umJrGY1xdLie9K
	 VjZ6u2GL6FscM5JC5GRuduZS7xleu51GzBbNdMvvoH6unb2JYFgc4gDq8IXtgSW6KN
	 5X3fyVAYLtwtLnnlmv/551y+w32Niaq8PXpippo0Sl8hzYPda/mGFX0kzHL5HflTKI
	 S7MRTDKNDCmXqZHJkPlEU9JzhF0ApLM0cOh22N06M8euNAaC4u8aZ1eldBhgM8ZElg
	 Lwc4NZLSURI+TZec4k8DKDP6KQfuU3TCgwyGSpUkOnUQJioYoR76bxNgiLmqH0plyC
	 if81DEbc/b2rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C81F680FAB;
	Tue, 11 Aug 2026 17:20:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4653049B
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4453C40086
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xsagesIKQddq for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 16:00:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6FA1D40074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FA1D40074
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6FA1D40074
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:05 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B5E0F3F640
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:02 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d04908139bso988675ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786464001; x=1787068801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fb3hg1RFoxjQ6BPaGfa2VO7JDy8p/Vm48PtMrZ1DIKg=;
 b=kE68LwwvhNnA1tLlTYaI0vWMNmsXfBBAG3i4tsbv30TCQQrGvAI51hUGShQ2Lj0JIA
 AoAAGgYNhcceW7IRXcCBSzfFvARgLp1+WypTQPeFuibFowvLgaCv9WREx2M0pFsm3yZW
 EQ+qynnExotsFqUyi0KhgXd7lRFd68qKVOW9pwJ1dMTO8N3eUcWhmxWPfFG1fwBEjMRT
 HYCKYb4nAzNZywsHPd/faCrIcnMfsaPJZNmlDVJyRcqVBoX6NHArB6Yk6J+DDSXOU02d
 sjbK86iPiZTaHZ3W+hFIko5NlEg98+5XhFPqQAIDoLkeQ5aEFj6aWh5utL2/jy6t7B1V
 wE3A==
X-Gm-Message-State: AOJu0YwzU3JRAvCCQsIWsD64gLF1KP+D16hatinI6wfchU6FUt5T+WXr
 zxc67U9nSMSKtyQKlhSvxy/z/dW21Dkjn8y/D8+ceAOG5Tlttg7Y1JRq3wP/Cz5pO42nO9Vxb66
 glB2ctTXfTiM65B+9J+MdAylNIkmfrZTuvRH1iLxJ+1vc5VMNt1m92RncpGXqHG6XokqOITU8jb
 e5Jy6m/kVxKbvEx9P+vQ==
X-Gm-Gg: AR+sD11ecyJzkRIhwMRO6rJ7mT4dGHBqiT6ShzC/+GZ779wD7anfV4QaY8jDomacSGJ
 e0V5MPkUM+vWwTEWy7H+NgLXVGI3MwcsHVUE4nezEVrMWKxQb8d/Ekcx/d8y7c1FzVbNztUZhnx
 Q7RKbNBF2BXfUx3SH9QuUQY7DnSDvAwklBzCR/R5MIwbcRvl/3zqMet71f6vubxNf9Gny1WNH7d
 Cuuo7zWw2eFouykFcDBXNJbvbCB/aBSDqh6rbduUWlZAY5cvV5Rm2x5SVxOiw5rHy018fhmIiY3
 OjWruxUoA5VQJk6pPExQcy9U/wtCvlrBk4TvLCEOsn1/KGKQpPEMx9H+Ht7lpQ06xrLBDB7rJVz
 6z/y6bhyI3WFHyTqpNURq04vRNzVg3owjGqG3okFncHWLKDm1
X-Received: by 2002:a17:902:e552:b0:2d0:401c:2ebb with SMTP id
 d9443c01a7336-2d32bf80c9emr20846075ad.4.1786464001149; 
 Tue, 11 Aug 2026 09:00:01 -0700 (PDT)
X-Received: by 2002:a17:902:e552:b0:2d0:401c:2ebb with SMTP id
 d9443c01a7336-2d32bf80c9emr20845735ad.4.1786464000609; 
 Tue, 11 Aug 2026 09:00:00 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3160f47easm10342485ad.64.2026.08.11.08.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:00:00 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/2] bootmeth: efi_mgr: Do not discard the EFI boot manager
 error
Date: Tue, 11 Aug 2026 15:40:56 +0000
Message-ID: <20260811155940.17698-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811155940.17698-1-aristo.chen@canonical.com>
References: <20260811155940.17698-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 11 Aug 2026 17:20:21 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786464002;
 bh=Fb3hg1RFoxjQ6BPaGfa2VO7JDy8p/Vm48PtMrZ1DIKg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=tTtUw3dF4LVg0QXpPIDskrwiUJhCQwCnhO7OGlhGA2P0emhpNZX9Gv/OljqWRhI40
 Mrg8aI9d/wpz9bHOXpk00FnatIC+zQEzTksLpMm/KAMwDvsX04nyLOON4uTYfHRKc+
 /Ipun1TFdWXdxUKXsEPXxQn2g4laNcT4rdCtdH9h4RJy1+0KWSA0jzGp5ik3iWgruy
 ZB5/9PEGurDonsG7iCz8pM8y8OAc7odi9TdSAjZjiXo9+i9JDSWzVJSvuN3JsucLtY
 KazawKhvtOWTBJFiSU2A1UZyOzINp/5UiQMXAIhNgqrUPhyfQBYI33Frtq9OFBgPpX
 Dhi0K8eIkWtMKIOiFYkvb4T1dXkQeY2oT1Oy7R0IVDhuntubLh1sOJjUnYo8nuRbns
 hdP8F5DFaVQ5hhtBPpt7nyDQW72+N/Cg4WChSGuRlyeb6GzG4NDF8nuJyYn2+FWQQr
 zUgNf/jQaxYfWXq/gkliWbvaFfDNO2fXLMGMtnmhXl8H6nep4PmaTeJnaRT9RKRppm
 NgVA91ms+xdcJRWoT09+LYVrhpLWIQZ8ejtkBuRwUV3iCiBYCoercWyzGyRcs+9VfS
 Y20297Tc2+BBTTzDMphSqUiQ1R8fgQfvIkQbdfq7slcMlS/9Gp96uUUbydVjRgQSEy
 7hjjmkV8UJ5R91Q856F76qnc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=tTtUw3dF
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

efi_mgr_boot() assigns the status returned by efi_bootmgr_run() to a
local variable and then returns 0. A zero return from a bootmeth's
boot() method means "should not get here", so bootflow_boot() reports
-EFAULT for every boot manager failure and the real cause (no boot
option loadable, load error, ...) is lost. The unused assignment also
trips -Wunused-but-set-variable on newer compilers.

Map the EFI status to an errno instead: EFI_NOT_FOUND (no BootOrder)
becomes -ENOENT and any other failure -EIO.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootmeth_efi_mgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index 6e70c36ad99..eb4d9a5b5a6 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -84,10 +84,13 @@ static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow,
 
 static int efi_mgr_boot(struct udevice *dev, struct bootflow *bflow)
 {
-	int ret;
+	efi_status_t ret;
 
 	/* Booting is handled by the 'bootefi bootmgr' command */
 	ret = efi_bootmgr_run(EFI_FDT_USE_INTERNAL);
+	if (ret != EFI_SUCCESS)
+		return log_msg_ret("mgr",
+				   ret == EFI_NOT_FOUND ? -ENOENT : -EIO);
 
 	return 0;
 }
-- 
2.43.0

