Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B497DC02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 18:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BEA4805DA;
	Mon, 13 Jan 2025 19:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y19ea/JT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883EC805E9; Mon, 13 Jan 2025 19:09:26 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD456801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 19:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so6928500a91.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 10:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736791762; x=1737396562; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aOBfrvZrlVaPxj28BNudBVmh/9ddRvC8jPKM7Zp2l6M=;
 b=Y19ea/JTlmXrHOwSl5O/JZw4h/P/jQjRYbOnxSdgVh+WMllVPR8Wc1z4NGEVWTtfWK
 obe5Y9ZVe6yXkPYLS1WGzU2Enk0QU7o1vYajsqK9tNkUPBs75ubcjrRmRKFnKzqYFL7Z
 gdKYq5dhbms0vu6sNJy8Q0qwOfXWCH8CFVGimTUpwg2IaxESzYJn72kIGKty7QflO3wC
 QfjPhWQXfQ5cN9V/Cp+QgHv3qlIzJfk6YRXLcaciIlmXefSUpBDSZS2NHNyLkF0tY/UQ
 jdcnS5txnJfQ2miHrbYNJgR8l5mt1F/7gHanMpOs31nB7p2u0TQgVcJkB2QlErtZfEC2
 GHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736791762; x=1737396562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aOBfrvZrlVaPxj28BNudBVmh/9ddRvC8jPKM7Zp2l6M=;
 b=WsSzHMd7duSbBpj2PUgkkAGgUTjwFMJ6L92TU1hJ0y44120OKciqXwofZv5Bu3G6lx
 Hg6MtSlHdocrMevPVmcgxjmU2DUTMUhjWpBn0g5a/H/jVmPBMzss27zW7dXixy6feUyD
 DAmOq23JhDftz54j/md5vV4hfRhstB+tvQjMpahQMnPiVcDGYP/czyLGe0vZx/zVRGr3
 KyeOAa4Yevd9L+z4ENUX9r+AFwRkO9P0Dan7DZKcbAUQE+JnYKqw2IDdgWNxG5xnhzLu
 totSd8TGs9LPMxN2OsFHdVMwjuwaORrRYBCn+5TBy8bv4MTZufnaR4QGmCvp/aMZZJHe
 q2eA==
X-Gm-Message-State: AOJu0YzzAX9LtiLqCa0dUwTbzh/cvwbhy8XNdbrnCFHJrh71VBaVGf4r
 vnX4fw2ZoYvOnV32LpJXG505NWOV1EKQB7SNuIE+4K4hbJApNzAiTQGKof5UjZPzGDsZB1G2QpW
 vmoJXQUt3Yf6VyG9A0mhodJrLDnGEVFUZsDNVow==
X-Gm-Gg: ASbGncuDemPEX0uqVK5w7DZIORusg52LO7pVLj9wrZIMi7lI/3ZsFRDKxU7Or/zp6ca
 ebmQvXj/vHJFEnViPsIHx26C3gelDwwSn4bFQ3pTnS1Ok6aOcTHOtvgRwVLSldpsvdwkFMw==
X-Google-Smtp-Source: AGHT+IE5YHRS0oKykrDfTgPK/P/FNoK7ziDjSoIHPWS8HCpIwAYN9khMPhCuvxlAvSznz/9banqmLSvcIrbxTqdAKJ4=
X-Received: by 2002:a17:90b:3d43:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-2f55833cf6amr23988112a91.5.1736791762103; Mon, 13 Jan 2025
 10:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20250110215640.892539-1-raymond.mao@linaro.org>
 <20250110215640.892539-3-raymond.mao@linaro.org>
 <C7D7CE8A-CA02-4093-BA34-DC990717D32C@gmx.de>
 <CAEfUkUKpiHrgbUye8TaQ2_+HT1++1i_n65bmbSnq0_R0oygLLw@mail.gmail.com>
 <6f9ee72c-ca8c-46ea-935f-9b5b697791c0@gmx.de>
In-Reply-To: <6f9ee72c-ca8c-46ea-935f-9b5b697791c0@gmx.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 13 Jan 2025 13:09:12 -0500
X-Gm-Features: AbW1kvYAaWeu-_ffHTsqA29y66l1tA961hUV2Spg_lROTVRGlBOu6mgY2dOWmD8
Message-ID: <CAEfUkUK3HqYJO_nGiPpUW8MOwnBxLX-2jd+x_FS7v2FnaFLCzA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] tpm: get tpm event log from bloblist
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Levi Yun <yeoreum.yun@arm.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

On Mon, 13 Jan 2025 at 12:52, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 13.01.25 15:43, Raymond Mao wrote:
> > Hi Heinrich,
> >
> > On Fri, 10 Jan 2025 at 19:12, Heinrich Schuchardt <xypron.glpk@gmx.de
> > <mailto:xypron.glpk@gmx.de>> wrote:
> >
> >     Am 10. Januar 2025 22:56:35 MEZ schrieb Raymond Mao
> >     <raymond.mao@linaro.org <mailto:raymond.mao@linaro.org>>:
> >      >Get tpm event log from bloblist instead of FDT when bloblist is
> >      >enabled and valid from previous boot stage.
> >      >
> >      >As a fallback, when no event log from previous stage is observed
> >      >and no user buffer is passed, malloc a default buffer to initialize
> >      >the event log.
> >      >
> >      >Signed-off-by: Raymond Mao <raymond.mao@linaro.org
> >     <mailto:raymond.mao@linaro.org>>
> >      >---
> >      >Changes in v2
> >      >- Remove patch dependency.
> >      >- Remove the fallback to FDT when BLOBLIST is selected.
> >      >Changes in v3
> >      >- Malloc an 8KB buffer when user eventlog buffer does not exist.
> >      >Changes in v4
> >      >- Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.
> >      >
> >      > lib/tpm_tcg2.c | 55 ++++++++++++++++++++++++++++++++
> >     +-----------------
> >      > 1 file changed, 36 insertions(+), 19 deletions(-)
> >      >
> >      >diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> >      >index 7f868cc883..685699688b 100644
> >      >--- a/lib/tpm_tcg2.c
> >      >+++ b/lib/tpm_tcg2.c
> >      >@@ -5,6 +5,7 @@
> >      >
> >      > #include <dm.h>
> >      > #include <dm/of_access.h>
> >      >+#include <malloc.h>
> >      > #include <tpm_api.h>
> >      > #include <tpm-common.h>
> >      > #include <tpm-v2.h>
> >      >@@ -19,6 +20,7 @@
> >      > #include <linux/unaligned/generic.h>
> >      > #include <linux/unaligned/le_byteshift.h>
> >      > #include "tpm-utils.h"
> >      >+#include <bloblist.h>
> >      >
> >      > int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr,
> >     u32 *active_pcr,
> >      >                     u32 *pcr_banks)
> >      >@@ -607,15 +609,24 @@ int tcg2_log_prepare_buffer(struct udevice
> >     *dev, struct tcg2_event_log *elog,
> >      >               elog->found = log.found;
> >      >       }
> >      >
> >      >+      if (elog->found)
> >      >+              return 0;
> >      >+
> >      >       /*
> >      >-       * Initialize the log buffer if no log was discovered and
> >     the buffer is
> >      >-       * valid. User's can pass in their own buffer as a fallback
> >     if no
> >      >-       * memory region is found.
> >      >+       * Initialize the log buffer if no log was discovered.
> >      >+       * User can pass in their own buffer as a fallback if no
> >     memory region
> >      >+       * is found, else malloc a buffer if it does not exist.
> >      >        */
> >      >-      if (!elog->found && elog->log_size)
> >      >-              rc = tcg2_log_init(dev, elog);
> >      >+      if (!elog->log_size) {
> >      >+              elog->log = malloc(TPM2_EVENT_LOG_SIZE);
> >      >+              if (!elog->log)
> >      >+                      return -ENOMEM;
> >      >+
> >      >+              memset(elog->log, 0, TPM2_EVENT_LOG_SIZE);
> >      >+              elog->log_size = TPM2_EVENT_LOG_SIZE;
> >      >+      }
> >      >
> >      >-      return rc;
> >      >+      return tcg2_log_init(dev, elog);
> >      > }
> >      >
> >      > int tcg2_measurement_init(struct udevice **dev, struct
> >     tcg2_event_log *elog,
> >      >@@ -668,10 +679,19 @@ __weak int tcg2_platform_get_log(struct
> >     udevice *dev, void **addr, u32 *size)
> >      >       const __be32 *size_prop;
> >      >       int asize;
> >      >       int ssize;
> >      >+      struct ofnode_phandle_args args;
> >      >+      phys_addr_t a;
> >      >+      fdt_size_t s;
> >      >
> >      >       *addr = NULL;
> >      >       *size = 0;
> >      >
> >      >+      *addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
> >      >+      if (*addr && *size)
> >      >+              return 0;
> >      >+      else if (CONFIG_IS_ENABLED(BLOBLIST))
> >      >+              return -ENODEV;
> >      >+
> >
> >     You are querying the CONFIG value. Why call function
> >     bloblist_get_blob if blobs are not supported? Please, simply skip in
> >     this case.
> >
> > Actually BLOBLIST is not required to call bloblist_get_blob here since I
> > have added the inline function, but we need a kconfig to separate the
> > user's preference on "fallback to DT" or not.
> > BLOBLIST is not a perfect idea but a temporary solution before we have a
> > concrete idea to define one new kconfig for "blobs handoff from previous
> > boot stage is mandatory".
> > For more information, please see the previous discussion between me, Tom
> > and Simon in v1 of this patch.
>
> Why should we call the empty inline function, if we already check the
> CONFIG value?
>
>
By the inline function, we call bloblist_get_blob and we can get the result
regardless whether BLOBLIST is selected or not.
What I mean above is, "else if (CONFIG_IS_ENABLED(BLOBLIST))" is a
temporary solution before we solve it with a new kconfig for "handoff from
the previous boot stage is mandatory".
Finally it will be replaced by "else if (CONFIG_IS_ENABLED(<NEW_KCONFIG>))"
here, which is not directly related to BLOBLIST.
Aka, enabling BLOBLIST does not mean we force "handoff from the previous
boot stage using bloblist", since a bloblist can be generated natively
inside U-Boot instead of passing from a previous boot stage.

I can add a TODO comment into this line to address the potential confusions.

Regards,
Raymond


> >
> >
> >
> >      >       addr_prop = dev_read_prop(dev, "tpm_event_log_addr",
> &asize);
> >      >       if (!addr_prop)
> >      >               addr_prop = dev_read_prop(dev, "linux,sml-base",
> >     &asize);
> >      >@@ -686,22 +706,19 @@ __weak int tcg2_platform_get_log(struct
> >     udevice *dev, void **addr, u32 *size)
> >      >
> >      >               *addr = map_physmem(a, s, MAP_NOCACHE);
> >      >               *size = (u32)s;
> >      >-      } else {
> >      >-              struct ofnode_phandle_args args;
> >      >-              phys_addr_t a;
> >      >-              fdt_size_t s;
> >      >
> >      >-              if (dev_read_phandle_with_args(dev, "memory-
> >     region", NULL, 0,
> >      >-                                             0, &args))
> >      >-                      return -ENODEV;
> >      >+              return 0;
> >      >+      }
> >      >
> >      >-              a = ofnode_get_addr_size(args.node, "reg", &s);
> >      >-              if (a == FDT_ADDR_T_NONE)
> >      >-                      return -ENOMEM;
> >      >+      if (dev_read_phandle_with_args(dev, "memory-region", NULL,
> >     0, 0, &args))
> >      >+              return -ENODEV;
> >      >
> >      >-              *addr = map_physmem(a, s, MAP_NOCACHE);
> >      >-              *size = (u32)s;
> >      >-      }
> >      >+      a = ofnode_get_addr_size(args.node, "reg", &s);
> >      >+      if (a == FDT_ADDR_T_NONE)
> >      >+              return -ENOMEM;
> >      >+
> >      >+      *addr = map_physmem(a, s, MAP_NOCACHE);
> >      >+      *size = (u32)s;
> >      >
> >      >       return 0;
> >      > }
> >
>
>
