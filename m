Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03EAD1813D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7CD890F2;
	Mon, 14 Oct 2024 21:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OTDOoZ9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2268A89148; Mon, 14 Oct 2024 21:13:39 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84AEC890D5
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7afc5e480dbso343478985a.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728933215; x=1729538015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+HiwAbZpNosbaYLz2TTNgjqBSkGIpxwSkCDk8qddInw=;
 b=OTDOoZ9T434eDhPpXa00cZZw26T9kfiF7FEdOuwVCCIA3vZOutTf3XMJSXyZTzHnef
 M8VToomFsU+B/RmS/Hj0uQ/QdhHOoIenT3v9tcOTWhtufWWmguExxiMkW1UZvjZHRNbs
 cux6yJLWMbJXN0L7ENb0ZEkc7GvurkHk4oFbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728933215; x=1729538015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+HiwAbZpNosbaYLz2TTNgjqBSkGIpxwSkCDk8qddInw=;
 b=nkqjrjf/JMBA1DBJmLsBY8isuqDJxPm/sw/TlCIvRutTzSfMNgReNddfrlUxZLdeuY
 MglTO03zhrzCMk7iLW2QnWkWpcZ0G3qSma/u1143NO5bOC6Ql8x/sy6v4eCKSel2QqxU
 i5wAfGGyn5GiJGp+SlKHhYmz7KyEiRYxIxcrMf3Potd96H+7EyfTKDxwbweEXWJtbTJM
 +GiyPxDrdWr2a52I5g6ZrIhmtU+w7DWhfpYyfQsYFJ/dmfk16HmcxVsRHsUwoOTlA2Sw
 zSfpuLqBwzHeKEvMclE8/cGe18RBEe8N7IBgEBKRxpQ6NpP72oDT7u7G+heB803XYUiU
 9oDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe+/dR7B6WYFDenGEhHFbrEbONML+pGtY0rxfHVKfYtR2VHaHuS/SaXpGOA9Xya8lbemN8P3U=@lists.denx.de
X-Gm-Message-State: AOJu0YxgrRPh6RiXVZhgOeNW934nlGZKxrPh2cwvt2Hp6fMRPEWlf0ke
 MflyBB9u4Le+qs9TZdmHTx7XFm71DKPVD5V4l+N8EiNz5ZmwPajkEDgMiA3Y5Qs7Lkl9X4OjeqS
 LT1GcxacShbap2cYlWMRxeYSVJXc5B4w2zuAI
X-Google-Smtp-Source: AGHT+IEIzrxTJ3jHBt1qJGRC7LHfXxUwA0U7fb024MDVrsD8zd2wIhdmDHu3HKHzs7RmHvYQArkO9RKwqmiBIUse/VA=
X-Received: by 2002:a05:6214:3d8d:b0:6cb:f744:e3f1 with SMTP id
 6a1803df08f44-6cbf744e729mr122989136d6.4.1728933215442; Mon, 14 Oct 2024
 12:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-8-sjg@chromium.org>
 <18910B7B-B3C3-4C4E-B2DC-5398F480E075@gmx.de>
 <20241012014242.GJ14210@bill-the-cat>
 <CAC_iWjL-FBHXATbSZHmcYw-ZKj0zZNwSGN02kuMJ6x6Lp8F1qw@mail.gmail.com>
In-Reply-To: <CAC_iWjL-FBHXATbSZHmcYw-ZKj0zZNwSGN02kuMJ6x6Lp8F1qw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 13:13:24 -0600
Message-ID: <CAFLszTgHejJBkuhMHw-P1Rr-=i0zJSD6+FcUL5mE0ZuQMQMQ7w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] cmd: Update the meminfo command to show the memory
 map
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Ilias,

On Mon, 14 Oct 2024 at 11:57, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi all,
>
>
> On Sat, 12 Oct 2024 at 04:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Oct 12, 2024 at 01:18:19AM +0200, Heinrich Schuchardt wrote:
> > >
> > >
> > > Am 11. Oktober 2024 23:40:31 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > >U-Boot has a fairly rigid memory map which is normally not visible
> > > >unless debugging is enabled in board_f.c
> > > >
> > > >Update the 'meminfo' command to show it. This command does not cover
> > > >arch-specific pieces but gives a good overview of where things are.
> > > >
> > > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >---
> > > >
> > > >Changes in v2:
> > > >- Modify the existing 'meminfo' command instead
> > > >
> > > > cmd/meminfo.c             |  48 ++++++++++++++-
> > > > doc/usage/cmd/meminfo.rst | 126 ++++++++++++++++++++++++++++++++++++++
> > > > doc/usage/index.rst       |   1 +
> > > > test/cmd/Makefile         |   3 +-
> > > > test/cmd/meminfo.c        |  38 ++++++++++++
> > > > 5 files changed, 214 insertions(+), 2 deletions(-)
> > > > create mode 100644 doc/usage/cmd/meminfo.rst
> > > > create mode 100644 test/cmd/meminfo.c
> > > >
> > > >diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> > > >index bb9bcec2e3f..e9a635bf4bf 100644
> > > >--- a/cmd/meminfo.c
> > > >+++ b/cmd/meminfo.c
> > > >@@ -4,18 +4,64 @@
> > > >  * Written by Simon Glass <sjg@chromium.org>
> > > >  */
> > > >
> > > >+#include <bloblist.h>
> > > >+#include <bootstage.h>
> > > > #include <command.h>
> > > > #include <display_options.h>
> > > >+#include <malloc.h>
> > > >+#include <mapmem.h>
> > > > #include <asm/global_data.h>
> > > >
> > > > DECLARE_GLOBAL_DATA_PTR;
> > > >
> > > >+static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
> > > >+{
> > > >+    ulong end = base + size;
> > > >+
> > > >+    printf("%-12s %8lx %8lx %8lx", name, base, size, end);
> > > >+    if (*uptop)
> > > >+            printf(" %8lx", *uptop - end);
> > > >+    putc('\n');
> > > >+    *uptop = base;
> > > >+}
> > > >+
> > > > static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
> > > >-                   char *const argv[])
> > > >+                  char *const argv[])
> > > > {
> > > >+    ulong upto, stk_bot;
> > > >+
> > > >     puts("DRAM:  ");
> > > >     print_size(gd->ram_size, "\n");
> > > >
> > > >+    printf("\n%-12s %8s %8s %8s %8s\n", "Region", "Base", "Size", "End",
> > > >+           "Gap");
> > > >+    printf("------------------------------------------------\n");
> > > >+    upto = 0;
> > > >+    if (IS_ENABLED(CONFIG_VIDEO))
> > > >+            print_region("video", gd_video_bottom(),
> > > >+                         gd_video_size(), &upto);
> > > >+    if (IS_ENABLED(CONFIG_TRACE))
> > > >+            print_region("trace", map_to_sysmem(gd_trace_buff()),
> > > >+                         gd_trace_size(), &upto);
> > > >+    print_region("code", gd->relocaddr, gd->mon_len, &upto);
> > > >+    print_region("malloc", map_to_sysmem((void *)mem_malloc_start),
> > > >+                 mem_malloc_end - mem_malloc_start, &upto);
> > > >+    print_region("board_info", map_to_sysmem(gd->bd),
> > > >+                 sizeof(struct bd_info), &upto);
> > > >+    print_region("global_data", map_to_sysmem((void *)gd),
> > > >+                 sizeof(struct global_data), &upto);
> > > >+    print_region("devicetree", map_to_sysmem(gd->fdt_blob),
> > > >+                 fdt_totalsize(gd->fdt_blob), &upto);
> > > >+    if (IS_ENABLED(CONFIG_BOOTSTAGE))
> > > >+            print_region("bootstage", map_to_sysmem(gd_bootstage()),
> > > >+                         bootstage_get_size(false), &upto);
> > > >+    if (IS_ENABLED(CONFIG_BLOBLIST))
> > > >+            print_region("bloblist", map_to_sysmem(gd_bloblist()),
> > > >+                         bloblist_get_total_size(), &upto);
> > > >+    stk_bot = gd->start_addr_sp - CONFIG_STACK_SIZE;
> > > >+    print_region("stack", stk_bot, CONFIG_STACK_SIZE, &upto);
> > > >+    print_region("free", gd->ram_base, stk_bot, &upto);
> > > >+
> > > >     return 0;
> > > > }
> > > >
> > > >diff --git a/doc/usage/cmd/meminfo.rst b/doc/usage/cmd/meminfo.rst
> > > >new file mode 100644
> > > >index 00000000000..c628119787e
> > > >--- /dev/null
> > > >+++ b/doc/usage/cmd/meminfo.rst
> > > >@@ -0,0 +1,126 @@
> > > >+.. SPDX-License-Identifier: GPL-2.0+:
> > > >+
> > > >+.. index::
> > > >+   single: meminfo (command)
> > > >+
> > > >+meminfo command
> > > >+===============
> > > >+
> > > >+Synopsis
> > > >+--------
> > > >+
> > > >+::
> > > >+
> > > >+    meminfo
> > > >+
> > > >+Description
> > > >+-----------
> > > >+
> > > >+The meminfo command shows the amount of memory, the layout of memory used by
> > > >+U-Boot and the region which is free for use by images.
> > >
> > > The information offered by this command cannot be used for this purpose as it is incomplete.
> > >
> > > Memory allocated in LMB cannot be used to load images. And EFI in future will use LMB for allocations.
> > >
> > > The command should be changed to show LMB allocations.
> >
> > I agree, this need to include the lmb information as that's quite
> > likely to be helpful to anyone wondering "well where can I place things
> > then?" when denied being able to load an image somewhere.
>
> I think we all agree, but since the LMB patches are not in place
> should we wait to pull this? Or pull it since it's an improvement
> anyway and retrifit the LMB and perhaps EFI regions once LMB is good
> to merge?

I think it can go in now.

But I will say that I am very-much in favour of a setup where the EFI
memory appears in the 'meminfo' table, but within the U-Boot area.

Showing lmb is kind-of useless since the areas don't have any names. I
am working on a series for that, but it might be a few days...

Regards,
Simon
