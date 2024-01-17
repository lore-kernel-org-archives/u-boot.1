Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A2AC47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 16:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C9BE87ABE;
	Wed, 17 Jan 2024 17:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jhaw4RPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A618798C; Wed, 17 Jan 2024 17:47:04 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A1186EF1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 17:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E53E63F272
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705510020;
 bh=Ost3tRHKwOCc3qh8rKlTOstWCdwvox+2ji+qfa12qzc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jhaw4RPeCjMNzmXrCPEtcJpLzKv0I3LoPqW8AvhwzrTZVDlxopPgEym66VBQRNiiS
 GAwwNxeGithJw1pO8p5JtWOvwj48K8x4iSdxbVWxFZJY1lLID8aYv0h/EraOKA7O9K
 Dz07ST7WuouvgKti5kKW5hEczKiVc9FLqVsLVgeTgpUbKfOtNbmW7kBFkcgInG231w
 EFDXWev9BXSE/X860E+F2UjuZFgoSWTwEvTT7jr7hkCHf7rOf1Sjp3sR++/121S+cn
 RrEPc/5MMX1D/M5bQRx+S0EvEMT4WVGshFo96AVM9CLpDER27J3uypxqwWkbftFrv/
 AjuRMKIcHV9Tw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e46bceed8so79340005e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705510020; x=1706114820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ost3tRHKwOCc3qh8rKlTOstWCdwvox+2ji+qfa12qzc=;
 b=AV3HEm64071CbU41Sip6roPwgyvMpZfbvXf1G+FWlOxLE/ydJZkZJd+R6h8zAoL9bq
 TFYjn0K5dYT8Kmi99t5X9CwlnWMCbPos2EnA6ejWtB2Hh7j6HjlabM9oEXiBmTRf7AWg
 vFYATg0+BlC8NcB/vsEtRQ3s36p1cy13AWkG40GK2ZoW/qjv5llMo93Q6kyU+/JDw6EB
 CjHmGiH57ukYPZDSbaEWc6KvppGK9D/3evoB4+VBWcpYnJMRqhlMzabXZ+pOyzKJFr9e
 +9CXI7jxOOLdO4q04Vao///rodwsPDk8Dv8q7GULejXnI0DHAGkAV2dzS8+0A7v/AndM
 95fg==
X-Gm-Message-State: AOJu0YwPuWBHxShJqROmoYffiEqOpW9BiyFb2e8Mb+bFavGRG/W+v9PG
 CI2eWpR8PnmYdYcpLla4XBRRnBRTIMYflDgzc3K54bx6Mq55g4+3hMWr5hpkBikvotn5WDuJXKK
 sSc72xANcA5l80Dx9BJN12oIJNeOpFVnvJKmFCw==
X-Received: by 2002:a05:600c:4b27:b0:40e:5cb5:916c with SMTP id
 i39-20020a05600c4b2700b0040e5cb5916cmr5061267wmp.129.1705510019835; 
 Wed, 17 Jan 2024 08:46:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiSYU/+Y6QRaWplkNwKuTAK2s1LMeZ1tNoxYdz6mp5LJp69CbXHW9sMY2GCmb2jNzJJgtfvg==
X-Received: by 2002:a05:600c:4b27:b0:40e:5cb5:916c with SMTP id
 i39-20020a05600c4b2700b0040e5cb5916cmr5061260wmp.129.1705510019531; 
 Wed, 17 Jan 2024 08:46:59 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 y3-20020adfe6c3000000b003373ef060d5sm2042467wrm.113.2024.01.17.08.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 08:46:59 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>
Cc: Leo <ycliang@andestech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: sbi: add support for Debug Trigger Extension
Date: Wed, 17 Jan 2024 17:46:52 +0100
Message-ID: <20240117164652.118184-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Detect and show if the SBI implements the Debug Trigger Extension.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 cmd/riscv/sbi.c              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index bf4c9af6220..d1113f3d703 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -33,6 +33,7 @@ enum sbi_ext_id {
 	SBI_EXT_CPPC = 0x43505043,
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_DBTR = 0x44425452,
 };
 
 enum sbi_ext_base_fid {
diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index 940d9bc1681..9daf0e247ad 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -53,6 +53,7 @@ static struct sbi_ext extensions[] = {
 	{ SBI_EXT_CPPC,			      "Collaborative Processor Performance Control Extension" },
 	{ SBI_EXT_NACL,			      "Nested Acceleration Extension" },
 	{ SBI_EXT_STA,			      "Steal-time Accounting Extension" },
+	{ SBI_EXT_DBTR,			      "Debug Trigger Extension" },
 };
 
 static int do_sbi(struct cmd_tbl *cmdtp, int flag, int argc,
-- 
2.43.0

