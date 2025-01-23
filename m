Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F40C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55ACB807CD;
	Thu, 23 Jan 2025 23:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XOnmkbvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EABE780087; Thu, 23 Jan 2025 23:07:48 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD71803B5
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71fbb0d035dso757746a34.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 14:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737670064; x=1738274864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1C6lIQAuRGV+2U4SJqarGMlGXoIcsOLs0ZGJw0I6Dn0=;
 b=XOnmkbvGCr5jev+ThmkVAR9WQHFqKMCjZ+9X4SMgctuD3fNZCZV/mUsSKta5XszFWW
 XigMklASz3YvhOBljeFZAy1BnbxpTQWRujLB9vjurr8c2VlioDkXCUixUHLqJHm34e49
 1dgvqI7PGNfzZkYp+08bFY/qQTaO3+BSjjF9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737670064; x=1738274864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1C6lIQAuRGV+2U4SJqarGMlGXoIcsOLs0ZGJw0I6Dn0=;
 b=IpqIzcq58xTtuDpQ9zZnY39I5t6XPwCV9JeI982JT9tdO8a/Lzf3vt/lXqNU94CLdF
 xgEwzNN1xgM+6hmc2ZTzyEipa4dkMgQjoDayO4xgXitSxojMUZWp7hNJUuDqImTLpnk+
 JzvKc3VLN8ZpUHWFzQDv7vltvHgecj5qZZfEamv/MlEvx5ICokmX2bNy1oBeQoi2gLWD
 cvQPvm6Lg0+4NbWU1gS4HojTH1Fm7caf9R80ElUz5Ca1KVlnbEe63h7wAwB6MFEbuTlk
 iJKZxqi81XctaVnmwfy18GDHxDz6eeEhfAbINRJu+HV8tr5JXpY4sD2yCqbCZnM19sAh
 elog==
X-Gm-Message-State: AOJu0YzVlDqUrElTRxWzKR4pybUdlz040pF8XhwpmCa1YGCjMop1kz27
 rLOazgRGkejsTTzjYF9SUw+sifCO3pzugSlDEtERTHtoE7tQjEK4hFoRuz2OPjxLe6XAXfPKj3M
 =
X-Gm-Gg: ASbGncuJ+VW0+ZL+43erGZYQNZUaxVz0e+zViT9cryHSpLZsYtVDXQdX+KoIeiapktG
 W5knJ92un929xLcQARFYyvoUvhkiDhSYtbmso9Mb2vrkY4N1NDZK4Vp78J6MmPEfvhimr9/DvuC
 0KWY371/v/VE8UMkm740M2n4EHF67AzAYIqICVamyF2DzyZ/89poHAqRrv1ByzgvfAdwBKlwuvF
 O4vtXjbC3gdGoENTDODBGpF4aMaBnDaz5EAk+OWEuDT4d8DYpq7YO6PbSjks2mMK3ArxP4Pb5tN
 jLM+In4osTwNhoOjAH4RzBxEJ6F8WbWhOqjRctBYqA==
X-Google-Smtp-Source: AGHT+IF7qj3Zwst57NbZD8HBYwVDVQH8OlD2QoPkJaA1LlexyDGh0RK+98X2QPUAF9tr2nJAGpcvUA==
X-Received: by 2002:a05:6830:3c0e:b0:71d:f762:7f97 with SMTP id
 46e09a7af769-7249dafb615mr16364100a34.17.1737670064643; 
 Thu, 23 Jan 2025 14:07:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-724ecda47bbsm143136a34.2.2025.01.23.14.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 14:07:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v5 5/5] bootmeth_efi: Support PXE booting
Date: Thu, 23 Jan 2025 15:07:24 -0700
Message-ID: <20250123220726.412396-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123220726.412396-1-sjg@chromium.org>
References: <20250123220726.412396-1-sjg@chromium.org>
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

Finish off the implementation so it is possible to boot an EFI app over
a network.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to support PXE booting
- Rebase on Tom's tree (i.e. without the pointers/addresses series)
  https://patchwork.ozlabs.org/project/uboot/list/?series=436241

 boot/bootmeth_efi.c          | 15 +--------------
 lib/efi_loader/efi_bootbin.c |  5 ++++-
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index b745ba8bd4b..0c9b4c3d59d 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -210,6 +210,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (size <= 0)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
+	bflow->buf = map_sysmem(addr, size);
 
 	/* bootfile should be setup by dhcp */
 	bootfile_name = env_get("bootfile");
@@ -219,10 +220,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!bflow->fname)
 		return log_msg_ret("fi0", -ENOMEM);
 
-	/* do the hideous EFI hack */
-	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
-			bflow->size);
-
 	/* read the DT file also */
 	fdt_addr_str = env_get("fdt_addr_r");
 	if (!fdt_addr_str)
@@ -296,16 +293,6 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 		if (bflow->flags & ~BOOTFLOWF_USE_BUILTIN_FDT)
 			fdt = bflow->fdt_addr;
 
-	} else {
-		/*
-		 * This doesn't actually work for network devices:
-		 *
-		 * do_bootefi_image() No UEFI binary known at 0x02080000
-		 *
-		 * But this is the same behaviour for distro boot, so it can be
-		 * fixed here.
-		 */
-		fdt = env_get_hex("fdt_addr_r", 0);
 	}
 
 	if (efi_bootflow_run(bflow))
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index efc2ca36c0f..f015d7946b4 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -302,6 +302,9 @@ static const char *calc_dev_name(struct bootflow *bflow)
 	media_dev = dev_get_parent(bflow->dev);
 
 	if (!bflow->blk) {
+		if (device_get_uclass_id(media_dev) == UCLASS_ETH)
+			return "Net";
+
 		log_err("Cannot boot EFI app on media '%s'\n",
 			dev_get_uclass_name(media_dev));
 
@@ -342,7 +345,7 @@ efi_status_t efi_bootflow_run(struct bootflow *bflow)
 	ret = calculate_paths(dev_name, devnum_str, bflow->fname, &device,
 			      &image);
 	if (ret)
-		return ret;
+		return EFI_UNSUPPORTED;
 
 	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
 		log_debug("Booting with built-in fdt\n");
-- 
2.43.0

