Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EA4CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71FD0848B3;
	Tue, 26 May 2026 15:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UkZER6FH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27EC084881; Tue, 26 May 2026 15:10:20 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1125A84873
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-69d79fc48d2so3198700eaf.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779801017; x=1780405817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSn/RL2VP3zL6XvEQihgu6a0Jkr12sOYgwokO+LRsWg=;
 b=UkZER6FHOL1ghDpM5RhhjRrdaZ3vXmhi7XBelOgSMdODKjCYVXIdPXFTPntKzuLZKO
 3uDvYuXEUf/TbV3rBJ13nRzM17hta9SVcy+blKrh4V+DiY3pt4rJ+RGPmVoTMmDCKGIk
 NPnvZc5EKmmfI7QiT5H6jlRZZkKrpeFuugbdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801017; x=1780405817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lSn/RL2VP3zL6XvEQihgu6a0Jkr12sOYgwokO+LRsWg=;
 b=Epk053+fE3oiIcuFGumspuJcN5xC++jKB6uaUS4kPk+MZdSQk2iPGOOnLOnf5qaYkE
 RJzuh8okq5/H1b1tC27J0+DYihnAdNj2EtBw6pcWFp4+9NrnKc/DFbrAhPwDfjAgM5EA
 Xv9bVRQsqkQl9maYRPn0JpCYVwnttZzlBOQZLdV96lJ8hOcoaVnUyyrC6wzYY/gzovhx
 ARkQAkBeNSkaBDca16zXIfedZBHIeoq2/KFN0oqL9IIfUNWJumbiL7DLJBAA3dq0TKsp
 tefiROxIvBjXnpRCau1jg+Hd+cb/KqTdQkxAuaLboYV8kFObXa31FL5hWnyXMhLJdV+y
 vbIg==
X-Gm-Message-State: AOJu0YwiUvIYaDe0sRhRz1oX8WIv5+hzcVgOsaU+DmD3J0+WlErSkPQ5
 0G5tqtUepYqz5DCdZgmy2/2CGWKdWYBSNk02K5nBcAldfWQHDN/fvISTcQQwKvQ5YiUlqPdWdBT
 eEgQJzCjojCE=
X-Gm-Gg: Acq92OHzx3QtLuV99UDJvKS2GCIPZkPpaNXTZfVtVRnrNQtexF6FqqM9ge1WAXJLBoe
 OYYhDNjJBonZLcVpFDxIy7JrXL1kIqn2GhrDpVuC0xGcgcUEDmJf2XOQ9AxcXIvSbLtCfiq8tmF
 oP57hg/hh/f1hSisxTbCazRJRSHMksR1gMJZDf7sMic8Xn0ogMZ9hC5FuvJwE9jhhnHEZ27KpJt
 kmMwKUGIO3fId04zJnLftQm1teLZ0FGHk0jATLi/y9q75M/L3raHJ+znTH6qT3xtFUA161rM7bY
 aS9j4ZtVz38BmSAr4QjSl4K9kRTYg/pYew7nFxPZ0TFT6OrmIg/WCsCvDQdLVCuLFitlAwF8m3I
 okAmydWsQSRYWZf9gdndIrcFf/pdEt0eRi5rXjSrI5qFQyUyTNeec8TJf7TvM28Qkui1c7wxtAu
 qsw8thsujZMLq8j06TmA==
X-Received: by 2002:a05:6820:8186:b0:696:25d4:1e62 with SMTP id
 006d021491bc7-69d7ead4e83mr9377751eaf.2.1779801016773; 
 Tue, 26 May 2026 06:10:16 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aafca2sm6974601eaf.15.2026.05.26.06.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:10:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH 7/9] x86: boot: Correct display of kernel version
Date: Tue, 26 May 2026 07:09:13 -0600
Message-ID: <20260526130931.2103552-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526130931.2103552-1-sjg@chromium.org>
References: <20260526130931.2103552-1-sjg@chromium.org>
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

The address of the bzImage is not recorded in the bootflow, so we cannot
actually locate the version at present. Handle this case, to avoid
showing invalid data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/zimage.c | 13 ++++++++-----
 cmd/bootflow.c        |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 3b8960cfbc4..3e1d6f44239 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -549,7 +549,6 @@ void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
 		 bool show_cmdline)
 {
 	struct setup_header *hdr;
-	const char *version;
 
 	printf("Setup located at %p:\n\n", base_ptr);
 	print_num64("ACPI RSDP addr", base_ptr->acpi_rsdp_addr);
@@ -576,10 +575,14 @@ void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
 	print_num("Real mode switch", hdr->realmode_swtch);
 	print_num("Start sys seg", hdr->start_sys_seg);
 	print_num("Kernel version", hdr->kernel_version);
-	version = zimage_get_kernel_version(base_ptr,
-					    (void *)bmi->bzimage_addr);
-	if (version)
-		printf("   @%p: %s\n", version, version);
+	if (bmi->bzimage_addr) {
+		const char *version;
+
+		version = zimage_get_kernel_version(base_ptr,
+						    (void *)bmi->bzimage_addr);
+		if (version)
+			printf("   @%p: %s\n", version, version);
+	}
 	print_num("Type of loader", hdr->type_of_loader);
 	show_loader(hdr);
 	print_num("Load flags", hdr->loadflags);
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index b79421496d6..b76daf9cc0d 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -401,6 +401,8 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		struct bootm_info bmi;
 
 		bootm_init(&bmi);
+		/* we don't know this at present */
+		bootm_x86_set(&bmi, bzimage_addr, 0);
 		zimage_dump(&bmi, bflow->x86_setup, false);
 
 		return 0;
-- 
2.43.0

