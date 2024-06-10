Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836BFC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 06:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A26918848F;
	Mon, 10 Jun 2024 08:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sn16VVMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D823884A4; Mon, 10 Jun 2024 08:46:00 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618B88826E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57a677d3d79so9314512a12.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 23:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718001958; x=1718606758; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VRaUdjBv27tRnvPXj9GASsl58urriiW1wsCMfClc0Yo=;
 b=sn16VVMbqBxcsaIHH81zAH80bEyR3du37GxY12A5uZCwwbGAyC3b6HZMsrCdcAMzba
 s6Xblwi6YqzE2Kq/qTDv6VVtpkUEwO33qKYQ4Ke6mj1ZmNunF8GbY7Mv1xlpNt8PBibJ
 g6HD4VoZo1+KUCLDI5CUQuKK1pjZCOT/YxQ5yFCYgms7GfWfYSXPnPplHbxqjQ73zsfz
 Minx5G4uCKx5Mv1knJXWKDMcrSazy0lroCNejqOe6yA7MJ5IcHbDohnnbtzQotX74ZT3
 PvxzBsQsQfjR7hZyqfhUGN9DEKw3J38YC+QAakRURM1+7BR97OlRFn4G1RPOcm5YybYU
 rNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718001958; x=1718606758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VRaUdjBv27tRnvPXj9GASsl58urriiW1wsCMfClc0Yo=;
 b=UBRabCn4WYkihXhWI6CVGdYEr40DCpne/qGGZckUgYuRhOMIgRYdNAQq2Hw34s3Au9
 KllYWCPetTkcp0ZXtiHCY6CfgDv01EdEnXy6rRkrEuH3tJhkNq68vQzClB45XuWfV/mg
 OHd3IvAwtRPrDtQ2Ovda6jmMXhhsLn+dEjHVOdR3YkJG7LwZ2pBVvBMVj3/68Nq9va1f
 B2w5xyGNY6PqVIxjeuM9ny9qKo/x7Fm/ai5G5+1DTVShOW831JRHbKVSHHwYR2gbJN08
 2EcwW/qWXAfIHFmM+EHjlY7t9XcVBJxy1Z0dpAtg6pbuF+vQQjrw+W5Q8AHt6SYeBPPC
 w80A==
X-Gm-Message-State: AOJu0YyHhaUI249sPARVvLqO5ciwqqtbKLF5ZQihSbVxg7hP8HW43TWT
 X596W7cj2tjgpbHmHfKSFDrnI3w7Pqipd5zoJn8a4yChoujLohP/HbL4lnlWGw69wWq/l0Ge2zX
 tSvvgMv+xPNvkyzpeMNfbNBu2rQqvjlYly++iEg==
X-Google-Smtp-Source: AGHT+IGnJQSCMCu3UytNO5T6p80MQWc+aO5r+2KJcj0JezzkCFgEkVBdGuwFIPXghKGSL6TmeBzjLQJcYuacsO886ak=
X-Received: by 2002:a50:9550:0:b0:57c:57af:6e88 with SMTP id
 4fb4d7f45d1cf-57c57af70a9mr6287834a12.9.1718001957790; Sun, 09 Jun 2024
 23:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-32-sughosh.ganu@linaro.org>
 <D859DD98-73B6-4E7D-BE36-5442845F3FE9@gmx.de>
In-Reply-To: <D859DD98-73B6-4E7D-BE36-5442845F3FE9@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 10 Jun 2024 12:15:46 +0530
Message-ID: <CADg8p95MmfYdinwqqKHL6SN0+OsATQ-+zd7CVOn8X6P5bUT-ow@mail.gmail.com>
Subject: Re: [RFC PATCH 31/31] temp: cmd: efi: add a command to dump EFI
 memory map
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 8 Jun 2024 at 09:03, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 7. Juni 2024 20:52:40 MESZ schrieb Sughosh Ganu <sughosh.ganu@linaro.org>:
> >Add a command to dump the EFI memory map.
>
> What are you missing in 'efidebug memmap'?

Nothing. I wasn't aware of this sub-command. Thanks for pointing it out.

-sughosh

>
> Best regards
>
> Heinrich
>
> >
> >Not for committing.
> >
> >Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >---
> > cmd/Makefile                |  1 +
> > cmd/efi_map_dump.c          | 28 ++++++++++++++++++++++++++++
> > include/efi_loader.h        |  2 ++
> > lib/efi_loader/efi_memory.c | 32 ++++++++++++++++++++++++++++++++
> > 4 files changed, 63 insertions(+)
> > create mode 100644 cmd/efi_map_dump.c
> >
> >diff --git a/cmd/Makefile b/cmd/Makefile
> >index 35fcc4af5a..315046def6 100644
> >--- a/cmd/Makefile
> >+++ b/cmd/Makefile
> >@@ -11,6 +11,7 @@ obj-y += help.o
> > obj-y += panic.o
> > obj-y += version.o
> > obj-y += efi_memory.o
> >+obj-y += efi_map_dump.o
> >
> > # command
> > obj-$(CONFIG_CMD_ARMFFA) += armffa.o
> >diff --git a/cmd/efi_map_dump.c b/cmd/efi_map_dump.c
> >new file mode 100644
> >index 0000000000..f2a5932767
> >--- /dev/null
> >+++ b/cmd/efi_map_dump.c
> >@@ -0,0 +1,28 @@
> >+// SPDX-License-Identifier: GPL-2.0+
> >+/*
> >+ *  Allocate and Free EFI memory
> >+ *
> >+ *  Copyright (c) 2024 Linaro Limited
> >+ */
> >+
> >+#include <command.h>
> >+#include <efi_loader.h>
> >+
> >+static int do_efi_map_dump(struct cmd_tbl *cmdtp, int flag, int argc,
> >+                         char *const argv[])
> >+{
> >+//    printf("%s: argc => %d\n", __func__, argc);
> >+
> >+      if (argc != 1)
> >+              return CMD_RET_USAGE;
> >+
> >+      dump_efi_memory_map();
> >+
> >+      return CMD_RET_SUCCESS;
> >+}
> >+
> >+U_BOOT_CMD(
> >+      efi_map_dump, 1, 0, do_efi_map_dump,
> >+      "Dump the EFI memory map",
> >+      ""
> >+);
> >diff --git a/include/efi_loader.h b/include/efi_loader.h
> >index 9600941aa3..40f894f182 100644
> >--- a/include/efi_loader.h
> >+++ b/include/efi_loader.h
> >@@ -791,6 +791,8 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
> >                               uint32_t *descriptor_version);
> > /* Adds a range into the EFI memory map */
> > efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
> >+/* Dump the contents of the EFI memory map */
> >+void dump_efi_memory_map(void);
> > /* Adds a conventional range into the EFI memory map */
> > efi_status_t efi_add_conventional_memory_map(u64 ram_start, u64 ram_end,
> >                                            u64 ram_top);
> >diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> >index 93244161b0..7ab1b86140 100644
> >--- a/lib/efi_loader/efi_memory.c
> >+++ b/lib/efi_loader/efi_memory.c
> >@@ -47,6 +47,8 @@ static LIST_HEAD(efi_mem);
> > void *efi_bounce_buffer;
> > #endif
> >
> >+static uint64_t desc_get_end(struct efi_mem_desc *desc);
> >+
> > /**
> >  * struct efi_pool_allocation - memory block allocated from pool
> >  *
> >@@ -118,6 +120,36 @@ static int lmb_mem_map_update_sync(void *ctx, struct event *event)
> > EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
> > #endif /* MEM_MAP_UPDATE_NOTIFY */
> >
> >+static void dump_efi_mem_desc(struct efi_mem_desc *desc)
> >+{
> >+      u64 end;
> >+
> >+      end = desc_get_end(desc);
> >+
> >+      printf("-----------------------------------\n");
> >+      printf("Memory Range   [0x%llx - 0x%llx]\n",
> >+             desc->physical_start, end);
> >+      printf("Num Pages      [0x%llx]\n", desc->num_pages);
> >+      printf("Memory Type    [0x%x]\n", desc->type);
> >+      printf("Attribute      [0x%llx]\n", desc->attribute);
> >+      printf("-----------------------------------\n");
> >+}
> >+
> >+void dump_efi_memory_map(void)
> >+{
> >+      struct list_head *lhandle;
> >+
> >+      list_for_each(lhandle, &efi_mem) {
> >+              struct efi_mem_list *lmem;
> >+              struct efi_mem_desc *desc;
> >+
> >+              lmem = list_entry(lhandle, struct efi_mem_list, link);
> >+              desc = &lmem->desc;
> >+
> >+              dump_efi_mem_desc(desc);
> >+      }
> >+}
> >+
> > /**
> >  * checksum() - calculate checksum for memory allocated from pool
> >  *
