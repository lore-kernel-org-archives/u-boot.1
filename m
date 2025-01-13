Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9452C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 14:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D2F5801CF;
	Mon, 13 Jan 2025 15:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B82Hmjxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89064801CF; Mon, 13 Jan 2025 15:44:10 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE09A80141
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 15:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ef748105deso5512640a91.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 06:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736779446; x=1737384246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FVRFZAaNKzN7HvUNP/tpIfzp7I4BQ8ICjUp7opipKGo=;
 b=B82HmjxcwW2LnKq88/90IiOcgH3wRU/thiinCX1pg71RX13ceiVqcZ+2/NdBD2kTDY
 5tJwmTyGFxsMD7CNaXB8LiHKfA1kB+a3YebQism5iUqlMhOJjhS4S+qi2BcGdpYutvWt
 dwm+JRRU/NHoGsaAvI1YiNgmxmMU4nYMlcc03LnQqV+2xpyvd4dlslZt+zO+6IgraD1k
 OFVkm49XWOKMGNV0UlQ6oEtKIkreYWRWVpWPMh/pj26jKbUzsrJ/mxzaIlevu2fdCj+y
 +UI3fmGg1LUrIX1ngNvOgk+fsBQ2AwJmYwOCAjVt4Kxag1iDYmQQC93of/TgcndFoURu
 u6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736779446; x=1737384246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FVRFZAaNKzN7HvUNP/tpIfzp7I4BQ8ICjUp7opipKGo=;
 b=xSOAQkB59hvKMAJpCtEkG2g6mtmGZf2ZlOuQIIJLpwg4d0OqF2RhJyxO7bwFxqp030
 hGxgwqfPtruT/DbakbuikHafbiwPjBQUoycMWxYk2GwcK1GvRj+g/tlv5F4YYDMWmnbA
 cOkBjA9utTlQ0XTkcK4TD0RyYDnxh2EnNfYHuv5vh1zYrQD0k8ne7AFxGToeRUWQHf2a
 HxViSYpBS4m8cQxk6/YMKeBeS8RVQG2iMhHwIVkbgcT1m+F5sp+6mewuyzU9etDNnYLq
 rYDqGjpES6W1DFpWc/BtSPuVPjWcAT8sz12pEHPV+frRcuw4A0ZELH/EBk8YDMbAAQMv
 e3GA==
X-Gm-Message-State: AOJu0Yw2C5r2r0evtV48x0OYRWNCSoiHTMLF1lxR44afzPou9fSmWoex
 4sL9E0FtMfYKuVc1aavI0mwcyYSEWVJ/0nU8muoECTXC7PgU2StlgusDR0QqrO1YncYsuv8mmxg
 nScctVflLNqSIrF0BZeha5DAiXHHQz9uZcb1lVA==
X-Gm-Gg: ASbGncvHU3bRhXQLseqX/WtbvSt7Oal8qjL73qfdFCkJa3scLRM6yBMX2g5FZJX2J0V
 7n0MMfbmuU4VcsPAAB5IjA1eNNT5JRxDadc1WUNQbbxmso5t5Z1bc3FXcYwCmPnPg6UxIuw==
X-Google-Smtp-Source: AGHT+IHyAjksfIjDqCm/D/rp9BqUjeaVzLTsg8lA86jLDN+N5BCIBes1V2XNk8H0sFhQRcMFe5GyoJpxVVy3iNfcB64=
X-Received: by 2002:a17:90b:3f90:b0:2f6:f107:faf8 with SMTP id
 98e67ed59e1d1-2f6f107fe30mr2249309a91.24.1736779446278; Mon, 13 Jan 2025
 06:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20250110215640.892539-1-raymond.mao@linaro.org>
 <20250110215640.892539-3-raymond.mao@linaro.org>
 <C7D7CE8A-CA02-4093-BA34-DC990717D32C@gmx.de>
In-Reply-To: <C7D7CE8A-CA02-4093-BA34-DC990717D32C@gmx.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 13 Jan 2025 09:43:56 -0500
X-Gm-Features: AbW1kvZBUfycQZY1U9eULrOrmSS1FX9qv43g3XSsy3bXqqySM_d7JI38hCnCpOg
Message-ID: <CAEfUkUKpiHrgbUye8TaQ2_+HT1++1i_n65bmbSnq0_R0oygLLw@mail.gmail.com>
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

On Fri, 10 Jan 2025 at 19:12, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> Am 10. Januar 2025 22:56:35 MEZ schrieb Raymond Mao <
> raymond.mao@linaro.org>:
> >Get tpm event log from bloblist instead of FDT when bloblist is
> >enabled and valid from previous boot stage.
> >
> >As a fallback, when no event log from previous stage is observed
> >and no user buffer is passed, malloc a default buffer to initialize
> >the event log.
> >
> >Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >---
> >Changes in v2
> >- Remove patch dependency.
> >- Remove the fallback to FDT when BLOBLIST is selected.
> >Changes in v3
> >- Malloc an 8KB buffer when user eventlog buffer does not exist.
> >Changes in v4
> >- Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.
> >
> > lib/tpm_tcg2.c | 55 +++++++++++++++++++++++++++++++++-----------------
> > 1 file changed, 36 insertions(+), 19 deletions(-)
> >
> >diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> >index 7f868cc883..685699688b 100644
> >--- a/lib/tpm_tcg2.c
> >+++ b/lib/tpm_tcg2.c
> >@@ -5,6 +5,7 @@
> >
> > #include <dm.h>
> > #include <dm/of_access.h>
> >+#include <malloc.h>
> > #include <tpm_api.h>
> > #include <tpm-common.h>
> > #include <tpm-v2.h>
> >@@ -19,6 +20,7 @@
> > #include <linux/unaligned/generic.h>
> > #include <linux/unaligned/le_byteshift.h>
> > #include "tpm-utils.h"
> >+#include <bloblist.h>
> >
> > int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32
> *active_pcr,
> >                     u32 *pcr_banks)
> >@@ -607,15 +609,24 @@ int tcg2_log_prepare_buffer(struct udevice *dev,
> struct tcg2_event_log *elog,
> >               elog->found = log.found;
> >       }
> >
> >+      if (elog->found)
> >+              return 0;
> >+
> >       /*
> >-       * Initialize the log buffer if no log was discovered and the
> buffer is
> >-       * valid. User's can pass in their own buffer as a fallback if no
> >-       * memory region is found.
> >+       * Initialize the log buffer if no log was discovered.
> >+       * User can pass in their own buffer as a fallback if no memory
> region
> >+       * is found, else malloc a buffer if it does not exist.
> >        */
> >-      if (!elog->found && elog->log_size)
> >-              rc = tcg2_log_init(dev, elog);
> >+      if (!elog->log_size) {
> >+              elog->log = malloc(TPM2_EVENT_LOG_SIZE);
> >+              if (!elog->log)
> >+                      return -ENOMEM;
> >+
> >+              memset(elog->log, 0, TPM2_EVENT_LOG_SIZE);
> >+              elog->log_size = TPM2_EVENT_LOG_SIZE;
> >+      }
> >
> >-      return rc;
> >+      return tcg2_log_init(dev, elog);
> > }
> >
> > int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log
> *elog,
> >@@ -668,10 +679,19 @@ __weak int tcg2_platform_get_log(struct udevice
> *dev, void **addr, u32 *size)
> >       const __be32 *size_prop;
> >       int asize;
> >       int ssize;
> >+      struct ofnode_phandle_args args;
> >+      phys_addr_t a;
> >+      fdt_size_t s;
> >
> >       *addr = NULL;
> >       *size = 0;
> >
> >+      *addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
> >+      if (*addr && *size)
> >+              return 0;
> >+      else if (CONFIG_IS_ENABLED(BLOBLIST))
> >+              return -ENODEV;
> >+
>
> You are querying the CONFIG value. Why call function bloblist_get_blob if
> blobs are not supported? Please, simply skip in this case.
>
> Actually BLOBLIST is not required to call bloblist_get_blob here since I
have added the inline function, but we need a kconfig to separate the
user's preference on "fallback to DT" or not.
BLOBLIST is not a perfect idea but a temporary solution before we have a
concrete idea to define one new kconfig for "blobs handoff from previous
boot stage is mandatory".
For more information, please see the previous discussion between me, Tom
and Simon in v1 of this patch.

Regards,
Raymond


>
> >       addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
> >       if (!addr_prop)
> >               addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
> >@@ -686,22 +706,19 @@ __weak int tcg2_platform_get_log(struct udevice
> *dev, void **addr, u32 *size)
> >
> >               *addr = map_physmem(a, s, MAP_NOCACHE);
> >               *size = (u32)s;
> >-      } else {
> >-              struct ofnode_phandle_args args;
> >-              phys_addr_t a;
> >-              fdt_size_t s;
> >
> >-              if (dev_read_phandle_with_args(dev, "memory-region", NULL,
> 0,
> >-                                             0, &args))
> >-                      return -ENODEV;
> >+              return 0;
> >+      }
> >
> >-              a = ofnode_get_addr_size(args.node, "reg", &s);
> >-              if (a == FDT_ADDR_T_NONE)
> >-                      return -ENOMEM;
> >+      if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0,
> &args))
> >+              return -ENODEV;
> >
> >-              *addr = map_physmem(a, s, MAP_NOCACHE);
> >-              *size = (u32)s;
> >-      }
> >+      a = ofnode_get_addr_size(args.node, "reg", &s);
> >+      if (a == FDT_ADDR_T_NONE)
> >+              return -ENOMEM;
> >+
> >+      *addr = map_physmem(a, s, MAP_NOCACHE);
> >+      *size = (u32)s;
> >
> >       return 0;
> > }
>
>
