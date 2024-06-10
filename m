Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1B8C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 06:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2AB8844B;
	Mon, 10 Jun 2024 08:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CqESdTEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E798848F; Mon, 10 Jun 2024 08:44:29 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CD38826E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57c72d6d5f3so1612727a12.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718001866; x=1718606666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nNd8e2b06rJCtpM7ekZh2Y07CNjakDOrj89xIV6OniY=;
 b=CqESdTEAfu15ltMMeEZzg7Y4ve39zylhk8WuD5jT4x2ODn+f6uKxHbFF/+Rl4dQX/J
 k8KOk7jpscc8niVbWFdF43w2J1KR+sbdnBEACxCLbuUDmINPQn04fWUbzbZCLWZhuEH+
 aplJ7ADa6glKXJp7/pR67GnL4GQHjUR3f/PkpZbvFnhznw5A9fsYBd07rTZcYPcHIb7h
 v4lQl5abdhJyc5jym57eb1o182vKXJ/Ae+yrQ7FrSPpzhOju6e8pqwgdp3g/hODug+24
 2EyN3aFMo9G6LZDlgCKq0u9X3yC8GbD2dm8sGTUgS79/TGdbY7YEAJb+asFV/WZZzoba
 Vd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718001866; x=1718606666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nNd8e2b06rJCtpM7ekZh2Y07CNjakDOrj89xIV6OniY=;
 b=p00LfOLYMw0zkOQw31+bUCUxoc3DZ9nQsFxHFk62IN4jnCcnEJhbcPcyBKQwDKW6g0
 5+cCIMzTyo9tP4lIYbAiT65WCZ3ZTEcKxMuif5BlRuVnZs6qWvtG2CXcmMnGr+a4Y9i3
 +8nSgPfV+cYDQNT3tbYJQO7NCcMrl07zSy/OloeXSXX9M0BopCOUrUohaZYf6KR/FP8A
 tLorMN+dNvpXL/mR/TPuP8ejv7qCcqQKJl/QHZzOHAEh2PNmAKHpP3oMvSlDck4N2qqA
 E068+8PmOcLG5KHlyCfsTqHheWKZN9e25/SVN0ct7pHLZs+cnykR5oBW/r0eNXmn+nTF
 Mx0g==
X-Gm-Message-State: AOJu0YzuiUbKEMSPD0R2t6K0IPJrwwp+1nfwcP1d9ebI9L207vAEtK8k
 scSK4jMbd+Z41OE5wWoUpUVLjKYnftC1Z9LKNC2wcfhEnWBzmFQIgcLPUTeWyNv6FYiRZYcSaja
 pSYKQNx8Rb+o5SBiWGusZjIAIY3fzdUMlEaHFSA==
X-Google-Smtp-Source: AGHT+IGp1r4Z+esUq6Fh18qjGt3PaXvzQ+bj2cjDuAfNI8NX+2UDAuQges2ALFJxMfKTMnfCeBBrbgu1dLkpn3sVIgE=
X-Received: by 2002:a50:cdda:0:b0:57c:7ce3:6cd9 with SMTP id
 4fb4d7f45d1cf-57c7ce36e15mr1468055a12.23.1718001866428; Sun, 09 Jun 2024
 23:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-31-sughosh.ganu@linaro.org>
 <5BF273F8-08EB-44C9-9B59-1AAA924F4591@gmx.de>
In-Reply-To: <5BF273F8-08EB-44C9-9B59-1AAA924F4591@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 10 Jun 2024 12:14:14 +0530
Message-ID: <CADg8p966xzJiveKXDSs6-sGaiW1TRaRjL8GGfo3eoP0ieSAsjA@mail.gmail.com>
Subject: Re: [RFC PATCH 30/31] temp: cmd: efi_mem: add a command to test efi
 alloc/free
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

On Sat, 8 Jun 2024 at 09:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 7. Juni 2024 20:52:39 MESZ schrieb Sughosh Ganu <sughosh.ganu@linaro.org>:
> >Not for committing.
>
> Best put "DON'T MERGE" into the title to avoid mishaps in future versions.

Will do.

>
> In the final series we should have unit test covering all relevant aspects of the memory system.

Yes, that's the plan.

-sughosh

>
> Best regards
>
> Heinrich
>
> >
> >Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >---
> > cmd/Makefile     |   1 +
> > cmd/efi_memory.c | 155 +++++++++++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 156 insertions(+)
> > create mode 100644 cmd/efi_memory.c
> >
> >diff --git a/cmd/Makefile b/cmd/Makefile
> >index 87133cc27a..35fcc4af5a 100644
> >--- a/cmd/Makefile
> >+++ b/cmd/Makefile
> >@@ -10,6 +10,7 @@ obj-$(CONFIG_CMD_BOOTM) += bootm.o
> > obj-y += help.o
> > obj-y += panic.o
> > obj-y += version.o
> >+obj-y += efi_memory.o
> >
> > # command
> > obj-$(CONFIG_CMD_ARMFFA) += armffa.o
> >diff --git a/cmd/efi_memory.c b/cmd/efi_memory.c
> >new file mode 100644
> >index 0000000000..52ddcb7146
> >--- /dev/null
> >+++ b/cmd/efi_memory.c
> >@@ -0,0 +1,155 @@
> >+// SPDX-License-Identifier: GPL-2.0+
> >+/*
> >+ *  Allocate and Free EFI memory
> >+ *
> >+ *  Copyright (c) 2024 Linaro Limited
> >+ */
> >+
> >+#include <command.h>
> >+#include <efi_loader.h>
> >+#include <lmb.h>
> >+#include <vsprintf.h>
> >+
> >+#include <linux/types.h>
> >+
> >+static int do_efi_mem_free(struct cmd_tbl *cmdtp, int flag, int argc,
> >+                         char * const argv[])
> >+{
> >+      uint64_t addr = 0, size = 0;
> >+      efi_uintn_t pages;
> >+      efi_status_t status;
> >+
> >+      if (argc != 3)
> >+              return CMD_RET_USAGE;
> >+
> >+      argc--; argv++;
> >+
> >+      size = simple_strtoul(argv[0], NULL, 16);
> >+      if (!size) {
> >+              printf("Enter valid size for free in Hex\n");
> >+              return CMD_RET_USAGE;
> >+      }
> >+
> >+
> >+      addr = simple_strtoul(argv[1], NULL, 16);
> >+      if (!addr) {
> >+              printf("Enter a valid address in Hex\n");
> >+              return CMD_RET_USAGE;
> >+      }
> >+
> >+      pages = efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
> >+
> >+      status = efi_free_pages(addr, pages);
> >+      if (status != EFI_SUCCESS) {
> >+              printf("Unable to free memory, error (%#lx)\n", status);
> >+              return CMD_RET_FAILURE;
> >+      }
> >+
> >+      return CMD_RET_SUCCESS;
> >+}
> >+
> >+static int do_efi_mem_alloc(struct cmd_tbl *cmdtp, int flag, int argc,
> >+                          char * const argv[])
> >+{
> >+      enum efi_allocate_type type;
> >+      uint64_t addr = 0, size = 0;
> >+      efi_uintn_t pages;
> >+      efi_status_t status;
> >+      bool max = false;
> >+
> >+      if (argc < 2)
> >+              return CMD_RET_USAGE;
> >+
> >+      argc--; argv++;
> >+
> >+      if (!strcmp("max", argv[0])) {
> >+              if (argc != 3)
> >+                      return CMD_RET_USAGE;
> >+
> >+              max = true;
> >+              argv++;
> >+              argc--;
> >+      }
> >+
> >+      size = simple_strtoul(argv[0], NULL, 16);
> >+      if (!size) {
> >+              printf("Enter valid size for allocation in Hex\n");
> >+              return CMD_RET_USAGE;
> >+      }
> >+
> >+      if (max || argc == 2) {
> >+              addr = simple_strtoul(argv[1], NULL, 16);
> >+              if (!addr) {
> >+                      printf("Enter a valid address in Hex\n");
> >+                      return CMD_RET_USAGE;
> >+              }
> >+      }
> >+
> >+      if (max)
> >+              type = EFI_ALLOCATE_MAX_ADDRESS;
> >+      else if (addr)
> >+              type = EFI_ALLOCATE_ADDRESS;
> >+      else
> >+              type = EFI_ALLOCATE_ANY_PAGES;
> >+
> >+      pages = efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
> >+      status = efi_allocate_pages(type, EFI_BOOT_SERVICES_DATA, pages,
> >+                                  &addr);
> >+      if (status != EFI_SUCCESS) {
> >+              printf("efi_allocate_pages failed %lx\n", status);
> >+              return CMD_RET_FAILURE;
> >+      } else {
> >+              printf("Address returned %#llx\n", addr);
> >+      }
> >+
> >+      return CMD_RET_SUCCESS;
> >+}
> >+
> >+static struct cmd_tbl cmd_efi_mem_sub[] = {
> >+      U_BOOT_CMD_MKENT(alloc, 3, 0, do_efi_mem_alloc,
> >+              "", ""),
> >+      U_BOOT_CMD_MKENT(free, 2, 0, do_efi_mem_free,
> >+              "", ""),
> >+};
> >+
> >+static int do_efi_mem(struct cmd_tbl *cmdtp, int flag, int argc,
> >+                    char *const argv[])
> >+{
> >+      struct cmd_tbl *cp;
> >+      efi_status_t r;
> >+
> >+      if (argc < 3)
> >+              return CMD_RET_USAGE;
> >+
> >+      argc--; argv++;
> >+
> >+      /* Initialize UEFI subsystem */
> >+      r = efi_init_obj_list();
> >+      if (r != EFI_SUCCESS) {
> >+              printf("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> >+                     r & ~EFI_ERROR_MASK);
> >+              return CMD_RET_FAILURE;
> >+      }
> >+
> >+      cp = find_cmd_tbl(argv[0], cmd_efi_mem_sub,
> >+                        ARRAY_SIZE(cmd_efi_mem_sub));
> >+      if (!cp)
> >+              return CMD_RET_USAGE;
> >+
> >+      return cp->cmd(cmdtp, flag, argc, argv);
> >+}
> >+
> >+U_BOOT_LONGHELP(efi_mem,
> >+      "Functions to allocate and free memory\n"
> >+      "\n"
> >+      "efi_mem alloc <size> [addr]\n"
> >+      "efi_mem alloc max <size> <max-addr>\n"
> >+      "efi_mem free <size> <addr>\n"
> >+      "\n"
> >+);
> >+
> >+U_BOOT_CMD(
> >+      efi_mem, CONFIG_SYS_MAXARGS, 0, do_efi_mem,
> >+      "Allocate and free EFI memory",
> >+      efi_mem_help_text
> >+);
