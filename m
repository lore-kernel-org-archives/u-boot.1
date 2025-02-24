Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C06C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF78812D8;
	Tue, 25 Feb 2025 00:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O4YorbFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2EF812BC; Tue, 25 Feb 2025 00:08:14 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A4E481276
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-8559020a76aso128417939f.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438490; x=1741043290; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSg/DXKBD5KIuAkbnCFsTRrz1Wo9bZWIkK34ReNOXaM=;
 b=O4YorbFxkI610MZFlOXPo2ixlRgqHutLqWTy2Z5hrJWF3iBpSbAURKv3GQqpdJR7qz
 Kh5rYfZKw5eAPc74piekkxMtkwKNRqzmaltNUBTX8W0S7o3O0SBDUX+HomwN0b395Dqh
 nps15o80YT3uFu6Fm6aklVmMp7RRtiRmNMvg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438490; x=1741043290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSg/DXKBD5KIuAkbnCFsTRrz1Wo9bZWIkK34ReNOXaM=;
 b=nKe9p9IghoUy2acAOuUjsv4VHe1BxoASS0faWk6AKfZF/h3FvNsKtUqkj1mOf7fZF8
 WuP/1KFZAa8FKqPTTd2agLJxSxYbodCBsjcDUoA86hRTj20GCnbCF7sCoGC4kovcubZx
 sTXXsbwGoQB9Xk6nOYD2n6sop7MRxDDlbHNkGyKcjkihvhOC6aeynb1z82RJ8l0T2xoE
 nKv0dXG2pKgH59Pmz8LhWwVCLbMl3qXWip94Jw8q0w/AF4+YRqEEC49dJQic6N1x+8es
 8rwl3WQs2yTY8kdpwR37mYF3yD2LZip8YU69di1YctR8+P0zHB++43cl+nOAb2VLSWpR
 Xeyw==
X-Gm-Message-State: AOJu0YwblvtNeuk2bz4OPDRcSVJeieeFYHYI0zGipDTFGdobR2SSSOLI
 QM9KggTiOR47iVW/cFX7Pt231FE8TY2Ax0yXk8Spdtq0DXYV1shX5EDVqvufFXlsXE9yXJLEFHM
 =
X-Gm-Gg: ASbGncv+IRLFh8435/YJB0pBMmG8Pp6m9SPvkgjNcBowB1wjN2k6CeURm/6ejZMAQ+I
 ctmF06su4SpzLoWIvVnbjfcVcvbO408OeX4ISiGLm6oXHE267TM8UkPDJILlSO9ijHRpXpHGFas
 qhWEI32SvIBRPxPiCZID/UEgskdQsoEdz+6is31NZMTyHJ+UOspMPR/4reMRIG23FzPnyVJbB72
 n58n62lBPlbHKPjgTzYbeUr7s2vtOY98sCMoS7SnXIdk51u94xYW9/LzgaIXUk6y8q1DBtPAICE
 QtLgLPVEcFWpW/cy7O43N2EXnA/rRNDdGHd66O3ljotI2mXTe24MYP/Mjj3sfTQ=
X-Google-Smtp-Source: AGHT+IEtVkM2hdsjAt8/ZN/FCzkZEF2EdFkTg9qPvSrpwDt/cjBpjuNM2tuKdNyDtn7wFP/rIwYp5Q==
X-Received: by 2002:a05:6602:3402:b0:855:bd9c:7180 with SMTP id
 ca18e2360f4ac-8562039dd9bmr146842039f.9.1740438490615; 
 Mon, 24 Feb 2025 15:08:10 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 35/44] acpi: Mark struct acpi_rsdp as packed
Date: Mon, 24 Feb 2025 16:06:24 -0700
Message-ID: <20250224230640.2665206-36-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

At present the size of this struct is too large on 64-bit machines.
Annotate it with __packed to fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to mark struct acpi_rsdp as packed

 include/acpi/acpi_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index b8b1f1338c6..8ef19adc990 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -36,7 +36,7 @@ struct acpi_ctx;
  * RSDP (Root System Description Pointer)
  * Note: ACPI 1.0 didn't have length, xsdt_address, and ext_checksum
  */
-struct acpi_rsdp {
+struct __packed acpi_rsdp {
 	char signature[8];	/* RSDP signature */
 	u8 checksum;		/* Checksum of the first 20 bytes */
 	char oem_id[6];		/* OEM ID */
-- 
2.43.0

