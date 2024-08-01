Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6EDC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 17:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF0088B59;
	Thu,  1 Aug 2024 19:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O/pburtk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E5E88B1D; Thu,  1 Aug 2024 19:37:00 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825E788B1F
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 19:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81f8f0198beso300717739f.1
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722533817; x=1723138617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLINnhhnMF9AS7Tfy24IhfD7lexQOK85xT1EW9izAfo=;
 b=O/pburtku27PbJPmnk8hLvSeAhCsbCtoyt1gM7Mb7uwwbzs1v5bB5uxO0Jtu/gDBAC
 BomIsf3hiy6M1FvL09f21UqWFw6f2Dmufyt788su9dXZlR2U8V4EJ/2XJooBe79nqFqh
 Bg7mvCU2k5+H9QQ0E5JkrpfJPU0pRcWavxcTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722533817; x=1723138617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLINnhhnMF9AS7Tfy24IhfD7lexQOK85xT1EW9izAfo=;
 b=c38ge2mv0ByLZQlr7xMq28/jxZi4GdnPP9DODJtIT/7J0mmjlua1ixvK68F0iFyJHF
 hBiedcKrW67AEZLXuMCdQl60XaSSf212G2juNCdBVNQq1I0SHuMU7owkZyD4fxvpafPf
 a+DyGEblp9PuUcDqsEBROP8K5SCe+hDEZESOKfF4vuAzfX9sjtGTtXIpXOkNF3duX0de
 v4gBBzGoOpXA7AU87WFZ0Dsb+ZKNShjTpo8QfrjZ1Rp53wdeFs8mNxJAt6dM69DyenXs
 rtMYbDlXuHiygjWbYjYFHalnIEhR/GTRHuuW4hDBiMCLLjZ7kdGqWaf06DQpTUKFEToq
 190Q==
X-Gm-Message-State: AOJu0YxCRPD5bu4GxWuQF54aoJw5+4yHYVfzEuRzW8QxtPo8SzvZ8tc4
 F5vm8rTblHAcwoR3VTUTli4Q9hWJP1ddQwa4+zXzLzvIDXSehwv/9z4h0GiAhC02KsOFyTGG/nc
 =
X-Google-Smtp-Source: AGHT+IGvOpmYeYlAZdbpZ20sDxjRXLBQJEdqxTEkO5Fb6jhrKUFHTIicEirsISjO6kNAXvk0mBP7kQ==
X-Received: by 2002:a05:6602:2b01:b0:80c:a711:51d7 with SMTP id
 ca18e2360f4ac-81fd4375efamr137481439f.9.1722533817062; 
 Thu, 01 Aug 2024 10:36:57 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d6987f30sm27671173.6.2024.08.01.10.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 10:36:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/3] efi: Show the location of the bounce buffer
Date: Thu,  1 Aug 2024 11:36:37 -0600
Message-Id: <20240801173637.1071068-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801173637.1071068-1-sjg@chromium.org>
References: <20240801173637.1071068-1-sjg@chromium.org>
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

The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is not
clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
lx2162aqds_tfa_SECURE_BOOT and the like) use it.

This feature uses EFI page allocation to create a 64MB buffer 'in space'
without any knowledge of where boards intend to load their images. This
may result in image corruption or other problems.

For example, if the feature is enabled on qemu_arm64 it puts the EFI
bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
1088MB. The kernel is probably smaller than 27MB but the buffer does
overlap the ramdisk.

The solution is probably to use BOUNCE_BUFFER instead, with the EFI
version being dropped. For now, show the address of the EFI bounce
buffer so people have a better chance to detect the problem.

Note: I avoided converting this #ifdef to use IS_ENABLED() since I hope
that the feature may be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Drop patch 'Show more information in efi index'
- Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
- Add the word 'warning', use log_warning() and show the end address
- Reorder patches a little

 lib/efi_loader/efi_bootbin.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 5bb0fdcf75d..9779dc09b5e 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -211,6 +211,15 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
 		return -1;
 	}
 
+#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
+	/*
+	 * Add a warning about this buffer, since it may conflict with other
+	 * things
+	 */
+	log_warning("Warning: EFI bounce buffer %p-%p\n", efi_bounce_buffer,
+		    efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
+#endif
+
 	ret = efi_install_fdt(fdt);
 	if (ret != EFI_SUCCESS)
 		return ret;
-- 
2.34.1

