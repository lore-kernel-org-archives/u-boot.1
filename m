Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD500D10C11
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7ED0890F8;
	Mon, 28 Oct 2024 13:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L8p7efVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE5F8916B; Mon, 28 Oct 2024 13:48:44 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A7E890BB
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c9454f3bfaso5019137a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119719; x=1730724519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUiTJtjqMXIq9jpetlZI/rgVPq4fWekFjsdgZ1J+nDI=;
 b=L8p7efVN9MqxUdBPNfGMd0XVmkosMRN0qL6VhXWAIwthA2RAScDGDHMJeWykbYWSVE
 0k5kJSKyHBPtP4yz0sBqqeRfGMBwhPIxJeHgHyFMGtwtldBjCcVRpAkXZWqo9XehKx68
 WLiXS7V9vMAJBapORXKrlg11deYUhaE2tDFac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119719; x=1730724519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUiTJtjqMXIq9jpetlZI/rgVPq4fWekFjsdgZ1J+nDI=;
 b=bb+Nd45us4moqPnwT6lzY/3GQGdXb4fZiy5TmqKBHBJBUdNvmLuUohExOKKruA1AKE
 2wtnBU8zIH/p3bizaCW0JLV1CV85tDOlvSxF5JZ8NmqxWD8RxoAuYmkXwTsTyfr/7+eo
 +tCWI529NDdDhneZ2HFMoZ2IbjGFLoNRRF3WBVZpGk74aMo6sWt/dL33B4jHk/hi66F6
 uTe3Qy9tx07mx9U/L56XQujc9SJtnbke4KknTFvtY1fBEjLusSkTsmrE20QMRhfzooHA
 oBa/ubpDNWJch9gA4SZrpXoWc20UYPAyTAcoQG7d12wxBbQaGtxLgcaFDiyUMBPFAAJV
 iNyQ==
X-Gm-Message-State: AOJu0YxKbgAerLCBM15+h7eFvvlBv05R22pborK5B7T1oHSy/y+BiHBq
 Bo1S5RuiT77HOWsc4gaSR5GJQfvcqF1MUWTFKyOa62x5sB5og3qnh1C+AfCww1T98/89IU+ysDl
 PBg==
X-Google-Smtp-Source: AGHT+IFKX3X8EIEXsRqfGWZUGMabcW1Vt3gQ36+e/XOKKrp6FPPAiNoRwsay96MB1cDyfk1jWFVdBQ==
X-Received: by 2002:a17:907:94cb:b0:a9a:33c:f6e1 with SMTP id
 a640c23a62f3a-a9de5c9f681mr768289866b.5.1730119718801; 
 Mon, 28 Oct 2024 05:48:38 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 09/15] efi_loader: Fix free in ..._media_device_boot_option()
Date: Mon, 28 Oct 2024 13:48:00 +0100
Message-ID: <20241028124815.47262-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

Freeing a NULL pointer is an error in EFI, so check the pointer first,
before freeing it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_bootmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a3aa2b8d1b9..431a38704e9 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1180,7 +1180,8 @@ out:
 			free(opt[i].lo);
 	}
 	free(opt);
-	efi_free_pool(handles);
+	if (handles)
+		efi_free_pool(handles);
 
 	if (ret == EFI_NOT_FOUND)
 		return EFI_SUCCESS;
-- 
2.43.0

