Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC54C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 18:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A264843B8;
	Wed,  6 Aug 2025 20:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ARbeix5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18C88439F; Wed,  6 Aug 2025 20:15:17 +0200 (CEST)
Received: from mail-io1-xd62.google.com (mail-io1-xd62.google.com
 [IPv6:2607:f8b0:4864:20::d62])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28D984371
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 20:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-io1-xd62.google.com with SMTP id
 ca18e2360f4ac-881585f2c41so1281939f.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1754504104; x=1755108904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K48iMll8O/SjqxzwCeBb40mm4T7HnjC79S23FpYsANc=;
 b=ARbeix5EWYoWv45rhIT6AldxmyMFMp0+cM+N6ATZSRaWla9TsbsNbXoNuYgaQUK+YJ
 c6+MBjHodLIJUtA62Nit4iGEfJs0Klxs+SJyXg/DavBav1hsH39Q9UNcYJh1KQJp5A3o
 uGKi9G+sy3Z/Wz46BirUz0zC7zmet4Tf1Es18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754504104; x=1755108904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K48iMll8O/SjqxzwCeBb40mm4T7HnjC79S23FpYsANc=;
 b=UY+WB6Kq8QUO5OIWEVWbzLJK3W27c8bwPTehllxS85xJ8V07dp4Cnbiq2y7siQ3vch
 i0rMnvvxTnLHHOQuyy4F8oquyDDlFVCCJ0GqgqrnkKEZ1XArsio4VsiL/VhWajL/paGS
 VBt+LVu/b2TEq2qdYXMr+qX5hRH5pvs/IeHhAA0RMOEr0wBYTfOjC0XCBsugDylxmvAm
 uUe9b8Z5FxXE8/iZjIuOz9z1PZkf1B5Eo6qLfDBmuC+F8zPKeDDVO4LXkl86zKVZ7Di+
 zIvA7b6OWXGN3jq1mAID4n12fUJGg4RW/7CdgydHxGCNewdT3VIYzek4WGNMfHM1eFw3
 D/rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsx4wbCtaKmb7Joe7znfpj298WuVj3rNYQ/oIpp0D9b+o6fl/FL8c5OXn+y/G4AUn3OqvZUm0=@lists.denx.de
X-Gm-Message-State: AOJu0YwlldTxejqZNMDKRgaRq9bZsh47DVcX5qjssvHvnx1COO/Ey1WO
 MTNTZ21F3sPodmvRpEYNyoIim7k4LdHkJN40Yrr4TMB/nSmYkwp8CJHVdTuVlSkvBAig8cW7bxP
 aAV58ffvj7vmunhMKpPCft2e/BUeVI2NJwA==
X-Gm-Gg: ASbGncvsi9IK/CKL2lheEL4OdVdBX1qCqFZmcx+aN2j0OnOydc59XyvTbLgDjXWCQAD
 pCaL4c8tRkE4Eb4bLY0ShRr6yGzwQ6BtF8DqLsXJsd5UevvME0AxxYUdr5BSIeBWj7qexwebQOm
 v00BLOK2fEs/trOKbkcpM5NAIHbIZu5euXmVylPkDDYq7Qly7mpMmVcshp49MedUMi/E0kFJ04S
 f3XOh4hXLV02qGbc09MknFGAzYqFy8xGeXn3xfYFpL6mtnqWY8YiwYib84VYvXCiM5uScK6aj6j
 tjhXlGwt0fCtqbsUZMGQAUeST00+rgjkBW9oF03LtcGs4xaI2WQJL1f2hXG43tUqj81W6qPXbHM
 vXSlZOy4yFfpgKA==
X-Google-Smtp-Source: AGHT+IGfBL2GdwEQZKvxvDJM6bmbaC8hP2xMNVW+XdRDQOAAS9304LN3Zxew+KCcp/OcuSeTe0CBkr8JVtZ1
X-Received: by 2002:a05:6e02:1d91:b0:3e3:d6e2:c536 with SMTP id
 e9e14a558f8ab-3e51b903714mr15965675ab.3.1754504104369; 
 Wed, 06 Aug 2025 11:15:04 -0700 (PDT)
Received: from bcacpedev-irv-2.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-50a7e17fbfasm434156173.50.2025.08.06.11.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 11:15:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: dregan@broadcom.com, dregan@mail.com,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 2/4] cmd: nand: more descriptive help info
Date: Wed,  6 Aug 2025 11:14:01 -0700
Message-ID: <20250806181450.2324488-3-dregan@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250806181450.2324488-1-dregan@broadcom.com>
References: <20250806181450.2324488-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Aug 2025 20:44:29 +0200
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

nand read/write raw change 'count' to 'pages' since count is ambiguous

Signed-off-by: david regan <dregan@broadcom.com>
---
 cmd/nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/nand.c b/cmd/nand.c
index e09e145bc2d8..cb2a61a2e57c 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -1026,8 +1026,8 @@ U_BOOT_LONGHELP(nand,
 	"nand write - addr off|partition size\n"
 	"    read/write 'size' bytes starting at offset 'off'\n"
 	"    to/from memory address 'addr', skipping bad blocks.\n"
-	"nand read.raw - addr off|partition [count]\n"
-	"nand write.raw[.noverify] - addr off|partition [count]\n"
+	"nand read.raw - addr off|partition [pages]\n"
+	"nand write.raw[.noverify] - addr off|partition [pages]\n"
 	"    Use read.raw/write.raw to avoid ECC and access the flash as-is.\n"
 #ifdef CONFIG_CMD_NAND_TRIMFFS
 	"nand write.trimffs - addr off|partition size\n"
-- 
2.43.5

