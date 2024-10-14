Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2265DD18138
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 17:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76CB588A1C;
	Mon, 14 Oct 2024 19:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="buGrh+VW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1262A80245; Mon, 14 Oct 2024 19:57:20 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFAE488D72
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 19:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7e9fd82f1a5so2893261a12.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728928635; x=1729533435; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ky5X0oRrHxzDGLxVxAYiyMB3YbSjpybKYzujP7pAAHQ=;
 b=buGrh+VWalU8m8ABtsVBqNPAPngKkfaOhqH7XM5ddw5azOu8yyXtL6Drka/AonhZT/
 5Ws4+sGuvSJ35hZSVrJRmTaR6r6gnYKCzrwaqx2FoGCgn9i+6SLEd8+DOCmLwML/ePt8
 oAXl4zFrAA4jC6kvqmLYDMBU9JteI8Tgswqomt+rIknlmaLjLaYA7s2rK4QPaCh4Qumd
 nbI54dcGQ56PSuxykSym4WvukW9LEdmZel2QgUyf5osjUiUNVir9YEb1Aw5KUpuqlrwn
 0w7g+1qBopFNEGFxWP2MVvLerjO2agqrXb3XXJC6uL/umzee2n+kCyxtAOdOXXKu21jI
 6zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728928635; x=1729533435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ky5X0oRrHxzDGLxVxAYiyMB3YbSjpybKYzujP7pAAHQ=;
 b=PX56e4lprijh7nH6QSj60CX8NAjprjRS9CCevpUyzx4jNmGly/FGmMtESVa6g/LgXA
 rxbtRT1Iw2DvzenYZ8sswccY6kgWhBpVbqfMbIn+p70txRKRsTuWx7wvGqjuI5SDrXhd
 EI5Z9KzwXnIRj6E+0xqNsDV4RBvcLFivApr9cu9fWGw3eSZltRUQFYXVEo9lf1Po6Yt8
 ip6FCHFEq6CgGHk6JKu2buJCwowlbz92SR519IyeHJu4zgzMoZAqS5ISVn50Ic7xE/b5
 TM5M7plhxnCasblmVOBbfbkdEdMqif1d9kR0o4agZ4ryhhbjjcMvizghH73goPjl3pS3
 by3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwTnaxfheKSvqILYhcBkRqZTtao+odE6bqLs3DmnCyRYdarUh9/WivqUsu7OzoBYcQOeIAqP8=@lists.denx.de
X-Gm-Message-State: AOJu0YxuDdymdPGoNDTOYAzHg97YoRBw1mzijY3nHTgfKOetyLoTPNz9
 lJgJb6Of4xT5dcTlrh0Uel1Fh+609YfV/FdEECwIDK+tRcDAdhNrqgQUnz0w8ZkASlHysF3JGJE
 55qGwPyu0VQSFDKv8c+f3YyYKR07lLpbJIFjl5KwJ0Zkxv17w
X-Google-Smtp-Source: AGHT+IGJCmgXhmieYnQRXEUtCDkAk3FX9+WVmcak5+iEzXRvcOwa5/BaSD6bgbsGpcFwCTXJ0YZUcsETOM7i10rhppo=
X-Received: by 2002:a17:90b:1810:b0:2e2:b281:536e with SMTP id
 98e67ed59e1d1-2e3152c825bmr11111094a91.15.1728928635161; Mon, 14 Oct 2024
 10:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-8-sjg@chromium.org>
 <18910B7B-B3C3-4C4E-B2DC-5398F480E075@gmx.de>
 <20241012014242.GJ14210@bill-the-cat>
In-Reply-To: <20241012014242.GJ14210@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 14 Oct 2024 20:56:38 +0300
Message-ID: <CAC_iWjL-FBHXATbSZHmcYw-ZKj0zZNwSGN02kuMJ6x6Lp8F1qw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] cmd: Update the meminfo command to show the memory
 map
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi all,


On Sat, 12 Oct 2024 at 04:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 12, 2024 at 01:18:19AM +0200, Heinrich Schuchardt wrote:
> >
> >
> > Am 11. Oktober 2024 23:40:31 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > >U-Boot has a fairly rigid memory map which is normally not visible
> > >unless debugging is enabled in board_f.c
> > >
> > >Update the 'meminfo' command to show it. This command does not cover
> > >arch-specific pieces but gives a good overview of where things are.
> > >
> > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > >---
> > >
> > >Changes in v2:
> > >- Modify the existing 'meminfo' command instead
> > >
> > > cmd/meminfo.c             |  48 ++++++++++++++-
> > > doc/usage/cmd/meminfo.rst | 126 ++++++++++++++++++++++++++++++++++++++
> > > doc/usage/index.rst       |   1 +
> > > test/cmd/Makefile         |   3 +-
> > > test/cmd/meminfo.c        |  38 ++++++++++++
> > > 5 files changed, 214 insertions(+), 2 deletions(-)
> > > create mode 100644 doc/usage/cmd/meminfo.rst
> > > create mode 100644 test/cmd/meminfo.c
> > >
> > >diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> > >index bb9bcec2e3f..e9a635bf4bf 100644
> > >--- a/cmd/meminfo.c
> > >+++ b/cmd/meminfo.c
> > >@@ -4,18 +4,64 @@
> > >  * Written by Simon Glass <sjg@chromium.org>
> > >  */
> > >
> > >+#include <bloblist.h>
> > >+#include <bootstage.h>
> > > #include <command.h>
> > > #include <display_options.h>
> > >+#include <malloc.h>
> > >+#include <mapmem.h>
> > > #include <asm/global_data.h>
> > >
> > > DECLARE_GLOBAL_DATA_PTR;
> > >
> > >+static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
> > >+{
> > >+    ulong end = base + size;
> > >+
> > >+    printf("%-12s %8lx %8lx %8lx", name, base, size, end);
> > >+    if (*uptop)
> > >+            printf(" %8lx", *uptop - end);
> > >+    putc('\n');
> > >+    *uptop = base;
> > >+}
> > >+
> > > static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
> > >-                   char *const argv[])
> > >+                  char *const argv[])
> > > {
> > >+    ulong upto, stk_bot;
> > >+
> > >     puts("DRAM:  ");
> > >     print_size(gd->ram_size, "\n");
> > >
> > >+    printf("\n%-12s %8s %8s %8s %8s\n", "Region", "Base", "Size", "End",
> > >+           "Gap");
> > >+    printf("------------------------------------------------\n");
> > >+    upto = 0;
> > >+    if (IS_ENABLED(CONFIG_VIDEO))
> > >+            print_region("video", gd_video_bottom(),
> > >+                         gd_video_size(), &upto);
> > >+    if (IS_ENABLED(CONFIG_TRACE))
> > >+            print_region("trace", map_to_sysmem(gd_trace_buff()),
> > >+                         gd_trace_size(), &upto);
> > >+    print_region("code", gd->relocaddr, gd->mon_len, &upto);
> > >+    print_region("malloc", map_to_sysmem((void *)mem_malloc_start),
> > >+                 mem_malloc_end - mem_malloc_start, &upto);
> > >+    print_region("board_info", map_to_sysmem(gd->bd),
> > >+                 sizeof(struct bd_info), &upto);
> > >+    print_region("global_data", map_to_sysmem((void *)gd),
> > >+                 sizeof(struct global_data), &upto);
> > >+    print_region("devicetree", map_to_sysmem(gd->fdt_blob),
> > >+                 fdt_totalsize(gd->fdt_blob), &upto);
> > >+    if (IS_ENABLED(CONFIG_BOOTSTAGE))
> > >+            print_region("bootstage", map_to_sysmem(gd_bootstage()),
> > >+                         bootstage_get_size(false), &upto);
> > >+    if (IS_ENABLED(CONFIG_BLOBLIST))
> > >+            print_region("bloblist", map_to_sysmem(gd_bloblist()),
> > >+                         bloblist_get_total_size(), &upto);
> > >+    stk_bot = gd->start_addr_sp - CONFIG_STACK_SIZE;
> > >+    print_region("stack", stk_bot, CONFIG_STACK_SIZE, &upto);
> > >+    print_region("free", gd->ram_base, stk_bot, &upto);
> > >+
> > >     return 0;
> > > }
> > >
> > >diff --git a/doc/usage/cmd/meminfo.rst b/doc/usage/cmd/meminfo.rst
> > >new file mode 100644
> > >index 00000000000..c628119787e
> > >--- /dev/null
> > >+++ b/doc/usage/cmd/meminfo.rst
> > >@@ -0,0 +1,126 @@
> > >+.. SPDX-License-Identifier: GPL-2.0+:
> > >+
> > >+.. index::
> > >+   single: meminfo (command)
> > >+
> > >+meminfo command
> > >+===============
> > >+
> > >+Synopsis
> > >+--------
> > >+
> > >+::
> > >+
> > >+    meminfo
> > >+
> > >+Description
> > >+-----------
> > >+
> > >+The meminfo command shows the amount of memory, the layout of memory used by
> > >+U-Boot and the region which is free for use by images.
> >
> > The information offered by this command cannot be used for this purpose as it is incomplete.
> >
> > Memory allocated in LMB cannot be used to load images. And EFI in future will use LMB for allocations.
> >
> > The command should be changed to show LMB allocations.
>
> I agree, this need to include the lmb information as that's quite
> likely to be helpful to anyone wondering "well where can I place things
> then?" when denied being able to load an image somewhere.

I think we all agree, but since the LMB patches are not in place
should we wait to pull this? Or pull it since it's an improvement
anyway and retrifit the LMB and perhaps EFI regions once LMB is good
to merge?

Thanks
/Ilias
>
> --
> Tom
