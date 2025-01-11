Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2F4E77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF9B880763;
	Sat, 11 Jan 2025 01:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ocYcD4Rz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6A9806D6; Sat, 11 Jan 2025 01:01:50 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC37980763
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844dfe4b136so67407439f.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553706; x=1737158506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oVBX9bzTw0hUsUEwfSab0KuEBnmq4dvXBe3OkCVGTQ=;
 b=ocYcD4RzmzZkkPE2XT3v9CBXlrbBBzL+3FtaNhUvjpP8mZjOCzgeJFUeELKmnbeG9W
 2jSijAE/1hyk5jq91rorV9RVuL6EAm/dfzI9Okr0ElzoLDtzNiedGfzRl5iypXOKWsk2
 tLglRW0dKtkDMBVY3MW6YjDUOYysY1LPuAXxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553706; x=1737158506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/oVBX9bzTw0hUsUEwfSab0KuEBnmq4dvXBe3OkCVGTQ=;
 b=T1HHxInnYdkiLBrjy4kpBn0K4jvmBYmp+fEu3Jsh2AhsWk7+8Q6hxfbQkX1lq+LERw
 n3HS8fELlvMMxwfWrCneDtKT2846jcsubfAjHIvI3ol4AsT/qtCBfHJXxtJ/7c+6tX/j
 Noe1GmAxrHeY7ebVRolzZSPi44ee69mfeuw3I41wvluPvXEuszNZCN8MDiEarYwgfM43
 LAp7Lx8epUEpXrBTn1xou1g3xhNx+qk6ysYDMAoCbZ/cWwcIy5q3QnbDPPayyw6+BufE
 c64c+aowIpyzbabBgiwvQ1meEj6HqodXEMqHhN7kV+xlHNunx4JaICYWLh2RRXi3P1oj
 RXSw==
X-Gm-Message-State: AOJu0YwJE43rVn9bKC9eDvSraSTBG71eSBu6wfdjE1w/hNhtKdn5vXEY
 pPPN1E3wrBr9oJyRf4LO745OYqpnBGvv6GUilOR8LyEn7dSZbjKqf7NI6iqmls2M+4XYZOaeb6A
 =
X-Gm-Gg: ASbGncsDm7bDVA6H4Q6/5x3LDdGhUqqWbuqrG02WqWnwaBiN1BhtfzKPodkXy8iscKy
 9h6PZerDGXXpShnZSFrLWqZxddM6nqomdl1G49dSQXMrvhh0EH2zeobciWwuieW9B8eQMrVElNH
 5DfmMkKeupD+ak8P8vSWKkye0F5DLYOEK25hxvMPl9yCLmaJSZY2GH3ex4BVOLFYJ/n7k2X2UaV
 c1DTZumk+CwI9R55hMoA8m0ic+w9KjTaGkUl1Z5J6n5KA4jWQ/5XmhEKdXsJQLs0mRQouo37ayu
 nqCuGT/L1wXRM+C3ag==
X-Google-Smtp-Source: AGHT+IFVhVG6PyTePFilj27BcJqmxDzuftDjTPcwBxbGwHWOPd37pJe+U8MAoEJmmALIzDpBn7AKww==
X-Received: by 2002:a05:6602:3a04:b0:847:22a7:2412 with SMTP id
 ca18e2360f4ac-84ce00d41f0mr1157617539f.8.1736553706119; 
 Fri, 10 Jan 2025 16:01:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 25/30] x86: Align the SMBIOS table to a 4K boundary
Date: Fri, 10 Jan 2025 17:00:24 -0700
Message-Id: <20250111000029.245022-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

(no changes since v2)

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

