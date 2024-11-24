Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7938DD75E5D
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D122899BF;
	Sun, 24 Nov 2024 21:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZwwxkIdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1DD896BB; Sun, 24 Nov 2024 21:27:41 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE3B89812
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa5366d3b47so159659066b.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480059; x=1733084859; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BUiPXKDK9YoTJrG3p5ijnusGnV83eQAGGVjIEnS3214=;
 b=ZwwxkIdtlJTGSe4uYKq+Mf0TId335lZevUJFAge8enl5At7BmT9TyBQz6LuMZIKTLZ
 I27mqRI0Fj0ln8bXPZbTf6HU+WVmILriXdEXkese9QcPHg85OBOwuwPJT0ZsqITSaJFG
 F0WZIK/LOV7obACkr0Abnz5ikG16ElSk9Il9QXhHMUwj2xTORFZdXwgL8AckJCv+TmEQ
 LE+FK45gOPD4iueYcuoGyUZzvRs35zi+lctrETYJf0BiOVlxgcTEUQvNdTnZMxFhknRr
 1AfY35t6Y9jCNu6LFPsPmrPb6OfuUGqXyVTV8nR579fNrxUFESjhj4lSRpEdNUN0tZAo
 un9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480059; x=1733084859;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUiPXKDK9YoTJrG3p5ijnusGnV83eQAGGVjIEnS3214=;
 b=g+aYdsuweF2xTLZQt5+rWNezDGdvxfPc7MJwYRk4+FYTc5xta27MUfUcG7/pbyoRyU
 kXoPw9WE64OFhYyeDYvRr/jH5UbkbEX1R5smw/3qWaWBsARZAgsNEnqHDXWvEq8Tlsfx
 koLfXCPk6+yAyCvcckTqKxfBFEAMkqZAZ40UcOHcpOZgN7+kVNgeFGQLgbIYd3wjJ+IL
 GwrH7+TvTlwvMmReiPR+581GNa9awIGlb6SUfRloY92yO3vkbaPFiPMEiQR9TfX1YpDG
 ByDEcd+K2VTyTgnrgqM5SyhZMNhWlQdDKIpWfHg0BMhgCMH+G01aFYGzrGMU5xZc9hra
 nAHw==
X-Gm-Message-State: AOJu0YzHNEGzqG0NRZYXoDY7vvog3RcJppQIOynUfEKjFQ0niQmOAwyk
 3EwMpZ2zr7DHjmOyLnhLgM4sm0Ori+l0q9nJdX01c9+J3dcLg3GYiqjOe74x5fw=
X-Gm-Gg: ASbGnct7efz88D0Zy0aS80h19Jh0B5YbQYysLkrFRHU5f1doHHl9Ys9JbFDTQQXapfY
 ipr6nv9/xe0toIik0g2S4F66GH/TwdnxTavLgEGs8NHAnHakF0mpv8Qa9yUnrhmW7FXi9aP26Ae
 PRb7wnFFroucqUexBhofNXU2r5h0YIGeuXXNBxZNXYMxRRacqWWwTl9w+7IdwT1A4pc73hrlyo8
 viIx967Rv4fwAjhxoTktx8Z42ndO1UuZDeQbbEVt9b/PpnLM3zssHtRfsRDAZP1aIf/
X-Google-Smtp-Source: AGHT+IEK6hImm1gpDWw5GCeu4RFJpEmNsCR4qx46X+zkKrJ6mmd0kVaLdO95sYruSWwRdc6Ayr+ZVw==
X-Received: by 2002:a17:907:7854:b0:a9a:6bc2:c0a3 with SMTP id
 a640c23a62f3a-aa50990b2c0mr905056466b.7.1732480058958; 
 Sun, 24 Nov 2024 12:27:38 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:38 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:27:01 +0100
Subject: [PATCH RFC 05/14] efi: stub: add additional types of memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-5-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KzexS3NkiLi6IZ5rQRehRZxDo6WqSeW5w7WZKu8hW5Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHqP1V3+edTDrz+2Rdrm0bOuzyG03ZCOUdY3vBOce5
 5zlJ7+uo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExE9g0jw55Mr09Hbu8rrGm8
 2VSZ5uDvsyRIUCLXIPZSmkrcOvYp+gz/1I9eOc0ott+v/3TRj4WfBPV+vL/zaFPHZ7+D0Us7n96
 /swgA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

U-Boot itself might be mapped as LOADER_CODE, there's also no reason not
to make additional pages accessible to the OS. This fixes an issue where
U-Boot can't run EFI apps because it gets relocated somewhere outside of
its own memory map.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 lib/efi/efi_info.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/efi/efi_info.c b/lib/efi/efi_info.c
index 3fa594b34b42..3754c913b54d 100644
--- a/lib/efi/efi_info.c
+++ b/lib/efi/efi_info.c
@@ -120,8 +120,28 @@ int of_populate_from_efi(struct device_node *root)
 
 	return ret;
 }
 
+static bool efi_mem_type_is_usable(u32 type)
+{
+	switch (type) {
+	case EFI_CONVENTIONAL_MEMORY:
+	case EFI_LOADER_DATA:
+	case EFI_LOADER_CODE:
+	case EFI_BOOT_SERVICES_CODE:
+		return true;
+	case EFI_RESERVED_MEMORY_TYPE:
+	case EFI_UNUSABLE_MEMORY:
+	case EFI_UNACCEPTED_MEMORY_TYPE:
+	case EFI_RUNTIME_SERVICES_DATA:
+	case EFI_MMAP_IO:
+	case EFI_MMAP_IO_PORT:
+	case EFI_PERSISTENT_MEMORY_TYPE:
+	default:
+		return false;
+	}
+}
+
 int dram_init_banksize_from_efi(void)
 {
 	struct efi_mem_desc *desc, *end;
 	struct efi_entry_memmap *map;
@@ -142,10 +162,9 @@ int dram_init_banksize_from_efi(void)
 		/*
 		 * We only use conventional memory and ignore
 		 * anything less than 1MB.
 		 */
-		if (desc->type != EFI_CONVENTIONAL_MEMORY ||
-		    (desc->num_pages << EFI_PAGE_SHIFT) < 1 << 20)
+		if (!efi_mem_type_is_usable(desc->type) || (desc->num_pages << EFI_PAGE_SHIFT) < 1 << 20)
 			continue;
 		gd->bd->bi_dram[num_banks].start = desc->physical_start;
 		gd->bd->bi_dram[num_banks].size = desc->num_pages <<
 			EFI_PAGE_SHIFT;

-- 
2.47.0

