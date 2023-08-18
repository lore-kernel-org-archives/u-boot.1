Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDF5C7112B
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 06:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B98886C4B;
	Fri, 18 Aug 2023 08:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zo2IKl4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B72D86C4D; Fri, 18 Aug 2023 08:51:34 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC3E86C43
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 08:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fe2de785e7so777843e87.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 23:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692341491; x=1692946291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5rmIv8nF2PaAr2k6j9kcFUuJ2rymv/QEwCL6xVvnonA=;
 b=zo2IKl4yPgwGFSKrgK9YvqExdrfPirgmgpWH9Qqq4IJFWmhQGnIeh5IywwhL2EHrZL
 B2AbvlCctCwE9x0HVRicJ82Xh4dD3+tCjncf7U68Mg72VUDbzVlXO8fLjzyqFq1J7Ttd
 cjzQ2OBM4oQ+saJL8dvILUvArZuX1T1I2747bXcjNdXd5juvDv705rbQhIpLYixUt4Fw
 yW3hs2l1I7+JLS1bOhrV5ggLyEAiANYd6mwVno8N39cN3/Q02ponWqGv8OC0ZB7NPBLY
 jga87hWM7IN2Wwww8z+3IgEqcB8pFuEkzoZpT9uxoPodaqYN2KvOKjWtxac08+TeOWQV
 alVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692341491; x=1692946291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5rmIv8nF2PaAr2k6j9kcFUuJ2rymv/QEwCL6xVvnonA=;
 b=ad1ejaDJnEwnrM3Ja3pYmW7qeWs9QGCT0Ms528Fx/4smeKVC6/lnfT8vojCld9zHYH
 ll7L3fx8SBTWQz22Aolhy6MXnDEglNbxB2k20YOrca0MrJsDJZHUp9GJSwhJORioagts
 2XK2koNe/51TBlX65E4I/GfnX0Iv42dNq2JrbqS0nXCrK6mCAZLPyZC5YzS4xCpc/KXi
 NzqsXjuB72ld3ns66Zx8DYabea0sRpXDdM4CaS/ruDvBHmq6amGcFFkwpPZcPpF3hMOi
 EiMCGwyTrkNPhua2bEL/nA4TteMc22QQc8p6VfoJdbNdr3GQ5Z+ofYo+ubb/+eq/s9dZ
 pYgg==
X-Gm-Message-State: AOJu0YxUSSSzyQ7ukgZW2NQPl6befyRRAoNv1Tl+7hlS79vUm/ccQb4X
 5AB6QgZS3vtoiQkk4ffa/9kRtRoYXbQLSzXOFsSlTCuooQL09Zf5b9Y=
X-Google-Smtp-Source: AGHT+IEUjkxlJaMjMuSgn3jB2iDEapsgx6o4n2qrwg47h0jDEupeSlWH7hLFdUzLVKbUPA7SNtEdMiqecOCM+fcFY0E=
X-Received: by 2002:a05:6512:3f08:b0:4fb:7626:31a8 with SMTP id
 y8-20020a0565123f0800b004fb762631a8mr1234993lfa.27.1692341490649; Thu, 17 Aug
 2023 23:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230818002706.853550-1-sjg@chromium.org>
 <20230818002706.853550-15-sjg@chromium.org>
 <DC7E1FFE-0327-425D-A9E9-D8C22188F93A@gmx.de>
In-Reply-To: <DC7E1FFE-0327-425D-A9E9-D8C22188F93A@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Aug 2023 09:50:54 +0300
Message-ID: <CAC_iWjJvi7R+0HyhUkQzukkf-=BcSHK-TWUVdiTkj59hNE+X9w@mail.gmail.com>
Subject: Re: [PATCH v2 14/20] efi: x86: Use the installed SMBIOS tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>
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

On Fri, 18 Aug 2023 at 04:19, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 18. August 2023 02:26:53 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >U-Boot sets up the SMBIOS tables during startup. Rather than creating a
> >new set, install the existing ones. Rely on the ACPI table's memory-map
> >record to cover the tables.
> >
> >Tidy up the installation-condition code while we are here.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> >Changes in v2:
> >- Add new patch

In the ACPI changes, the makefile and code changes are in a single
patch which makes more sense.  Can you squash #15 in this one as well?

Thanks
/Ilias

> >
> > lib/efi_loader/efi_setup.c  | 10 +++++-----
> > lib/efi_loader/efi_smbios.c | 37 +++++++------------------------------
> > 2 files changed, 12 insertions(+), 35 deletions(-)
> >
> >diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> >index ad719afd6328..e6de685e8795 100644
> >--- a/lib/efi_loader/efi_setup.c
> >+++ b/lib/efi_loader/efi_setup.c
> >@@ -326,11 +326,11 @@ efi_status_t efi_init_obj_list(void)
> >               if (ret != EFI_SUCCESS)
> >                       goto out;
> >       }
> >-#ifdef CONFIG_GENERATE_SMBIOS_TABLE
> >-      ret = efi_smbios_register();
> >-      if (ret != EFI_SUCCESS)
> >-              goto out;
> >-#endif
> >+      if (IS_ENABLED(CONFIG_SMBIOS)) {
> >+              ret = efi_smbios_register();
> >+              if (ret != EFI_SUCCESS)
> >+                      goto out;
> >+      }
> >       ret = efi_watchdog_register();
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> >diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> >index 306c0bc54f90..0e6454a8fe0b 100644
> >--- a/lib/efi_loader/efi_smbios.c
> >+++ b/lib/efi_loader/efi_smbios.c
> >@@ -20,36 +20,13 @@
> >  */
> > efi_status_t efi_smbios_register(void)
> > {
> >-      /* Map within the low 32 bits, to allow for 32bit SMBIOS tables */
> >-      u64 dmi_addr = U32_MAX;
> >-      efi_status_t ret;
> >-      void *dmi;
> >+      ulong addr;
> >
> >-      /* Reserve 4kiB page for SMBIOS */
> >-      ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
> >-                               EFI_RUNTIME_SERVICES_DATA, 1, &dmi_addr);
> >+      /* space for all tables is marked in efi_acpi_register() */
> >+      addr = gd->arch.smbios_start;
> >+      printf("EFI using SMBIOS tables at %lx\n", addr);
>
> This is should be log_debug() as typically only developers will ever need this address.
>
> Best regards
>
> Heinrich
>
>
> >
> >-      if (ret != EFI_SUCCESS) {
> >-              /* Could not find space in lowmem, use highmem instead */
> >-              ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> >-                                       EFI_RUNTIME_SERVICES_DATA, 1,
> >-                                       &dmi_addr);
> >-
> >-              if (ret != EFI_SUCCESS)
> >-                      return ret;
> >-      }
> >-
> >-      /*
> >-       * Generate SMBIOS tables - we know that efi_allocate_pages() returns
> >-       * a 4k-aligned address, so it is safe to assume that
> >-       * write_smbios_table() will write the table at that address.
> >-       */
> >-      assert(!(dmi_addr & 0xf));
> >-      dmi = (void *)(uintptr_t)dmi_addr;
> >-      if (write_smbios_table(map_to_sysmem(dmi)))
> >-              /* Install SMBIOS information as configuration table */
> >-              return efi_install_configuration_table(&smbios_guid, dmi);
> >-      efi_free_pages(dmi_addr, 1);
> >-      log_err("Cannot create SMBIOS table\n");
> >-      return EFI_SUCCESS;
> >+      /* Install SMBIOS information as configuration table */
> >+      return efi_install_configuration_table(&smbios_guid,
> >+                                             map_sysmem(addr, 0));
> > }
