Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1066CD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDFF3845E3;
	Tue, 12 May 2026 19:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="lxRiCgKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D04845E3; Tue, 12 May 2026 19:40:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7310F84099
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F886168F;
 Tue, 12 May 2026 10:40:50 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.18.174])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71B493F85F;
 Tue, 12 May 2026 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778607655; bh=eFtv+9an/gSTmCxs+eriFgiHojmvBNG0F3J8X6Ha8nM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lxRiCgKptAfm/lMwa65Eg0rJASkA3QRxGcS1GD2RBH9FrTIsktRQa24ordFnNtSds
 5IWGzAASrh4ghDpwhb9P7kp1jEGQmA8fq5TqlEimex3WQhi/40sxKbCT+Y/x/Fjttg
 CYxe0Ffu4acEJhH0fJOOsHhhgrN2K2gcWVQcLEJo=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Tue, 12 May 2026 19:40:33 +0200
Subject: [PATCH 1/2] efi_loader: fix hii keyboard layout pointer
 computation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260512-layout-pointer-v1-1-c0981e907274@arm.com>
References: <20260512-layout-pointer-v1-0-c0981e907274@arm.com>
In-Reply-To: <20260512-layout-pointer-v1-0-c0981e907274@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.14.3
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

The EFI_HII_KEYBOARD_LAYOUT field `layout_length' is expressed in bytes,
but we add it to the `layout' pointer with (scaled) pointer arithmetic.
When adding an HII keyboard package with multiple keyboard layouts, this
results in only the first layout being added correctly; fix it.

Fixes: 8d3b77e36e10 ("efi: hii: add keyboard layout package support")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
---
 lib/efi_loader/efi_hii.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
index 330d7c5830b..7bf51ad43d1 100644
--- a/lib/efi_loader/efi_hii.c
+++ b/lib/efi_loader/efi_hii.c
@@ -324,7 +324,8 @@ add_keyboard_package(struct efi_hii_packagelist *hii,
 		list_add_tail(&layout_data->link_sys,
 			      &efi_keyboard_layout_list);
 
-		layout += layout_length;
+		layout = (struct efi_hii_keyboard_layout *)
+			 ((uintptr_t)layout + layout_length);
 	}
 
 	list_add_tail(&package_data->link, &hii->keyboard_packages);

-- 
2.53.0

