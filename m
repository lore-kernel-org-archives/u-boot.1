Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D993BCD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20696846D0;
	Fri, 15 May 2026 16:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WYroD4Jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBA9846DD; Fri, 15 May 2026 16:38:13 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24771846C3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bcda7765d64so185818866b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855890; cv=none;
 d=google.com; s=arc-20240605;
 b=Ob/+PVabMU/CTmLdTPpgbycBeiJ6caCr42Myyxk4fbSeNCorjSlbz0YB8gKfR7niOS
 SJNryuMAue7Gkk06QY/265t/FD3VOxAv+OtMM7Wisp0azxofYFCNRVuyWTdcvKiBvyvY
 nfmcuTK/MrlhRU/DWgBtYgP0fl7vXHXnsGmhYTdMRKVMh6pAaGutMM/gUqkmkOYIRrgi
 sSBp+3nc1BZVTp8vBE1RevxsqcEsW6aahgNO73tYmqB3G34OiU7y04YwTEHo4dr/rIAv
 aOP2L4lYTFcnkUNEcIomlfFmx5ThfSbKRnN6x+A9cDr8lIQTrjOBB0LcqbclQPXf4x4D
 m0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9z1d+1yXhD6mOHYBVDTiUgYP+yQ5wTcqmuS2Mq3gXaA=;
 fh=EgEaKoyj9GIYoCxR5RKZisAYTPTHHD6ICPgThe3agig=;
 b=HWYlKHQYy8D4rTRAyCNv4qvEFVqVSDi7gVphV1QWLl1Qs2hcQYL5eUv4JEPYwxPl1f
 1C7bJaBUZo4mHhRLz9Co4QiSdbh4rIwbhSu8ViOejTu3b99rqQUM571AOv+HCpxKuCSE
 F/URH+hGOgb9XiQzdIy1afwv4HyMbi1Ll26unDRIhLL96HDfnClAB7DtcojTey+N7CS2
 kpYK8DwLTAVU+vqAI4f4L0eveJb3Lt+bkr9VvB0mUzdtRE3ncZfGorEqsrTP4fPVNqbF
 Uc6Xq5a+aKsY7c7rLdcsbvkrwXgOFGoJGKD2acYTnn4Gc7xhWYe6RxrTSZ5a9LbbxgPo
 9TTA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778855890; x=1779460690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9z1d+1yXhD6mOHYBVDTiUgYP+yQ5wTcqmuS2Mq3gXaA=;
 b=WYroD4JwMtLMvGI5d+H2Kn5cEbeoJHB4eg1MS/la0kkjaWTqp5cjs4mLFHe+VbeO1u
 BgaBgMwlH7O/wJXPAkvQL1hwMmAczauzzlH1ZPAIl1LIegWV87iEYb2jFtBn6A8cryiJ
 F4HIEhPhzOai8d8vRF38X2aUk4oNariLoojLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855890; x=1779460690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9z1d+1yXhD6mOHYBVDTiUgYP+yQ5wTcqmuS2Mq3gXaA=;
 b=i8MOCzuLmBKGKGST3MJc3Tr9g1rLq43JJbuiMwQ3SQfUcNQg4Xhb0zmFe+SykDW/qi
 R+zPuPY3guD5Lkgv13JE4osuc5/SaWo92hbooLsPpBjIBncaq9VKp4R/uFuwG+7iBMiD
 OhYZr13+R0i4saDGUujDh6qz+mfoFcbzMi4MEEsLi8rUP3rgWqrqdVD/SZe6hL2+w0e1
 KFWPZIB0tRtJlqYrDzhVKTB6kKhbleo0kHcoFJqoIsVxwJIufKRxU3404Hgjz/+3KTZR
 E/9n0kDiYtLrTG4AjUShBc4PRJqNqxEA8ITHPOLSJVQuKL2srgsbGFneXLJBca7o7wOT
 ac1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7Yl1CahahHrfP77olJ8/WSRh6TEcxJGwHRKIEbVV+ZzIJrd7d9bbLvDARh5CK3N9D48JoQNE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb4vbsv+W+TmrCDJlKLbdoZ3Ovrfacqw7sI9MJk7D6YxIIqTe6
 QKuAWw8XGW5jLayvWwxoLsN6fZDd3iGJ+NWHSGI930/GFbyX1VI0e9Lbh6ooWAirrIDZQjtOlDC
 BafkIZMZ3CJ9gfUVlndidFZ2xailZnYPWNVGfiRgi
X-Gm-Gg: Acq92OG+w5CmCLsLA3fIjLx9pF9JSir2xTO9W/b/2A+9xD+hyBC7sZ8YPhPYJ6hypVs
 FeJp8Ao5JsjAqXCKrN13848LZDn2VLOujaoh3V+bjgD6FzXZ3OpfLI5Z27L+izQdmeWDNmCLmfO
 XHZ1DNWIos7LtXcxByP1gXDf6OIZX1+J7zWVHPa0MTkY+1Td8ZrEjZJ+EgdzraaxfQr93XInxbj
 1/ix/D2ZlnNGqqfYPSV5Kp0VXmhvfhKu+MhKkmSq44hiod+euZ/g4LfLft/JYmNCqaDkirk1yKa
 po+J7w==
X-Received: by 2002:a17:906:f590:b0:bd5:b27:c02e with SMTP id
 a640c23a62f3a-bd50b27c388mr298848966b.6.1778855890463; Fri, 15 May 2026
 07:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260513015606.591384-1-rs@ti.com>
 <20260513015606.591384-3-rs@ti.com>
 <CAFLszTg+rP=UirpTzUZcg+qo0M2gY7T=BRxPfH=PV+aDSvnjHQ@mail.gmail.com>
 <DIHTV2COJM6C.38XX35SDOM6Y@ti.com>
In-Reply-To: <DIHTV2COJM6C.38XX35SDOM6Y@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 08:37:57 -0600
X-Gm-Features: AVHnY4Jv-p4oAMq5sAmnkTzaUH2DyVC6JQuzc1TEuL1I9Y-dbOqwaouHxfjd8gM
Message-ID: <CAFLszTjAnpvAV=5h788CXHVwovwJQyz0vOHSmV7JbpF4wSUCHw@mail.gmail.com>
Subject: Re: [PATCHv7 2/3] test: boot: add a fdt reserved region check
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On Wed, 13 May 2026 at 14:22, Randolph Sapp <rs@ti.com> wrote:
>
> On Wed May 13, 2026 at 11:34 AM CDT, Simon Glass wrote:
> > Hi Randolph,
> >
> > On 2026-05-13T01:56:06, Randolph Sapp <rs@ti.com> wrote:
> >> test: boot: add a fdt reserved region check
> >>
> >> Add a image_fdt suite and a check for boot_fdt_add_mem_rsv_regions. This
> >> will ensure the user is properly informed of any reservation failures.
> >> It will also validate that reservations are cleaned up correctly when
> >> switching FDTs.
> >>
> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >>
> >> test/boot/Makefile          |  1 +
> >>  test/boot/image_fdt.c       | 53 +++++++++++++++++++++++++++++++++++++++++++++
> >>  test/cmd_ut.c               |  2 ++
> >>  test/py/tests/test_suite.py |  2 +-
> >>  4 files changed, 57 insertions(+), 1 deletion(-)
> >
> > Change log?
>
> No change log for a patch that didn't exist in the series previously.
>
> >> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> >> @@ -0,0 +1,53 @@
> >> +#include <fdt_support.h>
> >> +#include <asm/global_data.h>
> >> +#include <config.h>
> >> +#include <image.h>
> >> +#include <lmb.h>
> >> +#include <malloc.h>
> >> +#include <test/test.h>
> >> +#include <test/ut.h>
> >
> > Please sort these: config.h (if needed) first, then the plain
> > top-level headers alphabetically (fdt_support.h, image.h, lmb.h,
> > malloc.h), then asm/global_data.h, then test/*.
> >
> >> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> >> @@ -0,0 +1,53 @@
> >> +#define FDTDEC_MAX_SIZE (2 * 1024 * 1024)
> >> +
> >> +#define IMAGE_FDT_TEST(_name, _flags) UNIT_TEST(_name, _flags, image_fdt)
> >
> > FDTDEC_MAX_SIZE is never referenced - looks copied from
> > test/dm/fdtdec.c - please drop it.
> >
> >> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> >> @@ -0,0 +1,53 @@
> >> +     /* Loading a new device tree should be allowed */
> >> +     blob = malloc(fdt_sz);
> >> +     ut_assertok_ptr(blob);
> >> +     memcpy(blob, gd->fdt_blob, fdt_sz);
> >> +
> >> +     nodeoffset = fdt_path_offset(blob, '/reserved-memory');
> >> +     ut_assertok(fdt_del_node(blob, nodeoffset));
> >
> > If /reserved-memory is missing, fdt_path_offset() returns a negative
> > libfdt error and fdt_del_node() then fails with a confusing message.
> > Please ut_assert(nodeoffset >= 0) first.
> >
> > Also, blob is malloc()'d but never freed.
> >
> >> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> >> @@ -0,0 +1,53 @@
> >> +     boot_fdt_add_mem_rsv_regions(blob);
> >> +     ut_assert_console_end();
> >> +     boot_relocate_fdt((char **)&blob, &fdt_sz);
> >> +
> >> +     /* Reservation should not exist now */
> >> +     ut_asserteq(0, lmb_is_reserved_flags(start, LMB_NOMAP));
> >
> > What is the boot_relocate_fdt() call testing - could you add a
> > comment? The reservation at start is already gone after
> > boot_fdt_add_mem_rsv_regions(blob), so the final ut_asserteq() does
> > not depend on it. It also allocates from LMB for the relocated copy,
> > which then leaks. I'd drop it, or split it into a separate test with
> > its own assertions. The (char **)&blob cast is a hint that the call
> > doesn't belong here.
> >
> >> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> >> @@ -0,0 +1,53 @@
> >> +IMAGE_FDT_TEST(test_boot_fdt_add_mem_rsv_regions, UTF_LIVE_TREE | UTF_CONSOLE);
> >
> > Just to check: the test only touches gd->fdt_blob (the flat tree), so
> > why UTF_LIVE_TREE? If you want it to run regardless of OF_LIVE, drop
> > the flag (or use UTF_FLAT_TREE). If the intent was to avoid running
> > twice, please mention that in a comment.
> >
> > Regards,
> > Simon
>
> As far as I'm aware, UTF_LIVE_TREE is required for this test. I've tried using
> UTF_FLAT_TREE and no UTF.*TREE options and for some reason this restricts part
> of the parsing that's required for boot_fdt_add_mem_rsv_regions. Operations that
> should report errors simply do not without UTF_LIVE_TREE.

I dug into this. The flag isn't affecting parsing -
boot_fdt_add_mem_rsv_regions() uses libfdt directly on gd->fdt_blob,
so uts->of_live is invisible to it. What you're actually hitting is in
the test runner, ut_run_test_live_flat() in test/test-main.c:

/* live branch */
if (CONFIG_IS_ENABLED(OF_LIVE)) {
if (!(test->flags & UTF_FLAT_TREE)) {
uts->of_live = true;
ret = ut_run_test(...);
...

/* flat branch */
if ((!CONFIG_IS_ENABLED(OF_LIVE) ||
     (test->flags & UTF_SCAN_FDT)) &&
    !(test->flags & UTF_LIVE_TREE) &&
    ...

Sandbox has OF_LIVE=y. With UTF_FLAT_TREE alone:
 - live branch is skipped (UTF_FLAT_TREE set)
 - flat branch is skipped (OF_LIVE on, UTF_SCAN_FDT not set)

So the test body never runs, and the assertions never fire. That looks
like 'operations that should report errors simply do not' but really
the test just isn't being called.

I reproduced this on your series: with UTF_FLAT_TREE | UTF_CONSOLE the
runner prints 'Running 1 image_fdt tests' followed by 'Tests run: 1,
failures: 0' and never emits the per-test 'Test: ...' line.

The cleanest fix is to drop the tree flag entirely - just UTF_CONSOLE.
On sandbox (OF_LIVE=y) the runner will execute it once with
of_live=true and skip the second flat pass on its own, same observable
behaviour as UTF_LIVE_TREE. As a bonus, on a hypothetical !OF_LIVE
build it would still run via the flat branch, where UTF_LIVE_TREE
would silently skip it.

I also tried UTF_FLAT_TREE | UTF_SCAN_FDT for completeness - that
makes dm_extended_scan() fail with -EEXIST because devices are already
bound, so it's not a viable alternative:

scmi_bind_protocols() sandbox-scmi_agent scmi: Cannot have more than
one SCMI agent

This may be a bug in SCMI (e.g. it should use devicetree).

Regards,
Simon
