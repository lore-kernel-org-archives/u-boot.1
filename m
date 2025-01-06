Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55C2E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB1480703;
	Mon,  6 Jan 2025 15:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nona2uR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6722806ED; Mon,  6 Jan 2025 15:34:05 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3EB806FF
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a77980fe3aso57897155ab.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174040; x=1736778840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGf7aEpTY5QZ+tNo88RnLXIjSDmAYSmqzmUC7zsOGZo=;
 b=nona2uR/DzkJDfE8qK465GehYLVjbifEcfTBJVn5BlNsFtFZvbaGkCHC6HImCU5/6e
 W3Ejhu7jSgjy+iqKd5jje1f7+J6IIqe48q/V7hnzSSjDwYtfy5CQohNhIBYB+KjgQqk9
 zZ9kvQTbW3v/KT6TWfLOE2ZMNMExdWMiq1/3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174040; x=1736778840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGf7aEpTY5QZ+tNo88RnLXIjSDmAYSmqzmUC7zsOGZo=;
 b=YxL1UFByWc/4ZahnDNCyVhI/7RrSy7GX+AUss1DFWfVJnsdRvNoiRHpRvyLa5xKHlh
 iM9sE/Au4Kjv60xLqDK7JIgiY/XuBh/l0n39K/4mM7p16yKx7dIucKxeHSMG+9pIuqpz
 y3Y+67Daelq//8qv3bgSe2lh1665T9RgWI16tis1ewIHflGYV+sGmBlGVEF5MFWnTzbt
 QSUQmKeygnwghNOgiJm3CSLnoDSQcsTAgBYSNIa+4QRu3HXDXyrrA4OuvroiR8aSQOaP
 CE+Ir5LszO4Gfi/8TCEpLjagf12rSSGoJSV+4jlSMORU9A5pBwAdi6Orc/hnGbeLuX1I
 VX7g==
X-Gm-Message-State: AOJu0Yw7wE1c4JmaFxJNchcigcjAuXUIjUowJGIxnvyylbNTgj2zSdSg
 mRyaxOJN8ucL/zDycnRTMsKpK2XEX4s5u9h+v8D8Uy+1+9aGqh/1mL0vD30SWs4olb59i9LQQzI
 =
X-Gm-Gg: ASbGncvVazyc2NHscp2Ly1MCRxqEeZs2fXoAm/9F5peEMmTQ8dzUlDXGfvTjJnLedXN
 kTGAzKlLnsBCVGw/xqYlBnYm5OlrHGR8z8DGN3d9LCdQ0qUuhDUnHmoytI9wVZom4DNa6lGoiLx
 Egr7Bqns+3pHftVVqetOM7HgSEtFwYOZHkJcIIE1iwFWnHwUqV8Z/qY5bz+QaJnUJ0JLkq4GdK2
 vq/WMByGUpzP9+/QeC8JCXpngSln7I0y94J/lff41RSXuKFL4Mi8cuJVO0uY3aFpPqYNxz9nH8N
 cPniORjyEZ8Xg9GKbg==
X-Google-Smtp-Source: AGHT+IFtX0ewnJf4p9ZsiywARrvzVJK/9z/23GtuXQ9XY1CI2Hpl0PYcIdsUuFp8+TsECt7OW8hwYA==
X-Received: by 2002:a05:6e02:198c:b0:3a7:a58b:557e with SMTP id
 e9e14a558f8ab-3c302627786mr464456135ab.12.1736174040481; 
 Mon, 06 Jan 2025 06:34:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 29/33] x86: Align the SMBIOS table to a 4K boundary
Date: Mon,  6 Jan 2025 07:32:25 -0700
Message-Id: <20250106143229.3023771-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

This isn't strictly needed, but with UPL we use the reserved-memory
nodes to indicate where the SMBIOS table is. Tianocore requires 4KB
alignment on these regions, so it is easier to adjust the alignment
to match.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use 4K instead of 4KB

 arch/x86/lib/tables.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 9e4f21ae5ad..44fe80c5224 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -63,7 +63,11 @@ static struct table_info table_list[] = {
 	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, SZ_64K, SZ_4K},
 #endif
 #ifdef CONFIG_GENERATE_SMBIOS_TABLE
-	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, SZ_4K, SZ_256},
+	/*
+	 * align this to a 4K boundary, since UPL adds a reserved-memory node
+	 * for it
+	 */
+	{ "smbios", write_smbios_table, BLOBLISTT_SMBIOS_TABLES, SZ_4K, SZ_4K},
 #endif
 };
 
-- 
2.34.1

