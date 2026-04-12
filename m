Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674F5E937E1
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E706183DC9;
	Sun, 12 Apr 2026 13:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OzH599/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A58840D8; Sun, 12 Apr 2026 13:37:28 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4414583B99
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9910707d82so423839866b.1
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775993846; cv=none;
 d=google.com; s=arc-20240605;
 b=U4HLgADf+K+tCJSJJHdd8ItxvDupkhZqWRWM2Me6GRkLnKh8AaUNaeXUt+0l9FG58+
 pwOnG2SwLGUYSZP07Yqs+VoihZ9OrDyVJ0EiEdaN1ru+yBeaIh4KeTWbepp0++zr8TSL
 ScbNMasQBDwwxrn2JKwG2CC42/d4kEpTwxBfQH2ZpSzNV7XSZKizaJvcWunI6u6hWpIB
 ZXRtPUCdVDr1iml9bNJOQZbPg6Dc6lj6cSLa1O4X4yrH5dnzfBSxRVizRTqO7A4sxZL4
 7FbQjxxgz92yoIQqYGQ3blhzWgC8wqfMZ6wm/ZAdnnlchzzDbO20o3N9QZrs5se/vV3C
 Xc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q1SWamc/dfyOuT6ue9M7k6LAkqOJJ+WXY6i3nOYSL0A=;
 fh=1QWv9c0VdcZbjdC+GzwZ6uFXyuublcUEjxaMxpChJ9Y=;
 b=A+TUR7esbCp80LbmsBVShpiPKj7HAjiNU+ALlJLSSSaPkC79ANeNzDJve5orKubfud
 2GhSL3B0ncuC4/6kmvwU0IFL3o2U2Sx3R9lZ5OCtXLTH9OHSso2Lir19DoZnQPa/XBwk
 RSeYLXVBAHFtHVkEc+paE8WsOWvP1WWQL5VIhZWBAJuKWfGxuYHeatolnO89cvoPmtQV
 eiMqzfgRhDwjiecvPwJtHYH/V2QHijQNNIf3EPSTT5U6G+pzWl0sK0kZDai+4K+Phi17
 d2CCAZ6bkXb3ENIP6RtJHJFd0c/9rotDtN6ra4zcZLG3P7P2J1G/MRWEQ/51JpwYKfH3
 bQ4g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993846; x=1776598646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q1SWamc/dfyOuT6ue9M7k6LAkqOJJ+WXY6i3nOYSL0A=;
 b=OzH599/6SN6Ttzb8/hGHBssHWVT3kvwxQzEjhflCyPBcy8NwTuWHNcE8vtoY+GDjTK
 Wo+Q6j3l9Ld0GSg2Myqkxk640PhAqvB6CAYwjGb5yYPFhxNDwFRbgLnrDYjFFFyrnhLR
 dPhhE1YAK1mDBoKlnC+ousW8x+FpmrOBIGBMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993846; x=1776598646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1SWamc/dfyOuT6ue9M7k6LAkqOJJ+WXY6i3nOYSL0A=;
 b=rC+ZvstWN8pBu1ASNcSrXc6b8z4lPvCO2efZFUH1ScG/Kk7/AFWzoFC/ORkq/PDfQn
 W5Cr44uZ68X4771ZzPHdHzJzJ4I9mQ7DRVXl31OC+2ulTRzSntixZQM6gdXZKl/jYopc
 CMQbcUewxykztv1l9Wi/Org5bYMoOrmYdRJ7JGsHK4kvWcUSoKwqkw1PuHaJj2STdQxe
 8KYqrfaI19JWK6/8Isdmfn25OsYjvVG2e1kLvO2aJzjCWlfMhZpPooA/EYEwMS41GcxP
 fw9KUKgebYgPoX52AwExGphS9gVyrwxPJl/2A/F0E2zDHUJfMI1n8iR4rUYBVGMOQn+h
 /cAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqcPHB1Y0AMr9dTettvQRIZjag1wX4iTcc8wa17Hj3R4uFO0mDJOu1Ttvom13ZOgP+LY6s0I8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0ka7y2QZA9bdQf9p2bteZs+2LxETaOOcNAzg9uBkWFFUh7PWI
 aPANRGaLiUBn/bJR3q9cLyEX32WAZs/+gxeVuLm38Q4Cldhoi3NNqm+W4SMMeflxkn/IUXk/5tu
 RFcF0X/rLvykZWxmsRBBCuk2/8SCqAoKxITezwO8R
X-Gm-Gg: AeBDieu/yKGifBU2rXzSJ4YIytqbfCXn9X2z6M5qcjoqWHOwvyY09UFA/JgBXtfeYks
 aqT0Tx2rf+cxUSfCKJXSR+srfM0UcUmeeeCcLqVeFlcNKDNEbjhVjfrlBWIybkmgBMDHB0PP5mZ
 rwkN7/RzHytl1a0AbTPsSVQv5QKQk06k95Cm6oXIQffolIoKZIU0r7cyrKdLjbc1jJ3s0Bxmy81
 T3d6efnPPRJX3WK7nmd9m7hDuRgILH36PjN/b9tCyG0Ysfenc/2lYxAQtC5SFQsrU8MRrxZoSmP
 gwhRZQ==
X-Received: by 2002:a17:907:e11a:b0:b93:5385:327e with SMTP id
 a640c23a62f3a-b9d727a08cdmr337575466b.21.1775993845636; Sun, 12 Apr 2026
 04:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260403-cmdline-v2-1-83e22c82f02f@missingno.tech>
 <4D95B3CE-66CD-45E0-9DB8-2CDD45622920@gmx.de>
In-Reply-To: <4D95B3CE-66CD-45E0-9DB8-2CDD45622920@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Apr 2026 05:37:13 -0600
X-Gm-Features: AQROBzCU1bZM0h0NJfbbLV-DXZMbZv4jixAAg-dXrjVwj7HKoS7d7-e5Yhzk7So
Message-ID: <CAFLszThvYf0=ebaGqprxy7unbVomC+tu-5uQM2auEZeiNCZpmA@mail.gmail.com>
Subject: Re: [PATCH v2] arch/x86/lib: implement cmdline configuration property
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Guillaume Ranquet <ranquet.guillaume@gmail.com>, u-boot@lists.denx.de, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jeremy Compostella <jeremy.compostella@intel.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Guillaume Ranquet <granquet@missingno.tech>
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

Hi,

On Sat, 11 Apr 2026 at 05:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 3. April 2026 16:28:23 MESZ schrieb Guillaume Ranquet <ranquet.guillaume@gmail.com>:
> >Implement the cmdline configuration property as described in the spec
> >[1]
>
>
> I can't see in the spec that the command line property is x86 specific. Why would you try to implement it in arch/x86?
>

This is a little tricky though. It could perhaps be handled in
bootm_process_cmdline_env() by setting bootargs. Both legacy bootm and
bootstd (via the on_bootargs callback) would then pick it up without
any arch-specific code. But I haven't tried it. Commands like
'bootflow cmdline set' need to continue to operate as now.

Regards,
Simon

> Best regards
>
> Heirich
>
> >
> >[1]: https://fitspec.osfw.foundation/#id10
> >
> >Signed-off-by: Guillaume Ranquet <granquet@missingno.tech>
> >---
> >Changes in v2:
> >- EDITME: describe what is new in this series revision.
> >- EDITME: use bulletpoints and terse descriptions.
> >- Link to v1: https://lore.kernel.org/r/20260401-cmdline-v1-1-c56577f82960@missingno.tech
> >---
> > arch/x86/include/asm/zimage.h |  2 +-
> > arch/x86/lib/bootm.c          | 10 +++++++++-
> > arch/x86/lib/zimage.c         |  6 +++---
> > boot/image-fit.c              | 30 +++++++++++++++++++++++++++++-
> > include/image.h               |  3 +++
> > 5 files changed, 45 insertions(+), 6 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
> >index 8b5426051701c8266395afd9232eb1ff30d38304..ee0114a227a2b067a3a3126d7d80ab0cc89cea6e 100644
> >--- a/arch/x86/include/asm/zimage.h
> >+++ b/arch/x86/include/asm/zimage.h
> >@@ -132,7 +132,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
> >  * Return: 0 (always)
> >  */
> > int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
> >-               ulong initrd_addr, ulong initrd_size, ulong cmdline_force);
> >+               ulong initrd_addr, ulong initrd_size, const char *cmdline_force);
> >
> > /**
> >  * zboot_start() - Prepare to boot a zimage
> >diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> >index cde4fbf35574a267b856a668659ece7e0a36367f..e029cc1ff18bd53eb873c0e56fd9d3b0a331b4c2 100644
> >--- a/arch/x86/lib/bootm.c
> >+++ b/arch/x86/lib/bootm.c
> >@@ -61,6 +61,7 @@ int arch_fixup_memory_node(void *blob)
> > static int boot_prep_linux(struct bootm_headers *images)
> > {
> >       char *cmd_line_dest = NULL;
> >+      const char *cmd_line_override = NULL;
> >       struct legacy_img_hdr *hdr;
> >       int is_zimage = 0;
> >       void *data = NULL;
> >@@ -99,6 +100,13 @@ static int boot_prep_linux(struct bootm_headers *images)
> >                       puts("Can't get image data/size!\n");
> >                       goto error;
> >               }
> >+
> >+              ret = fit_image_get_cmdline(images->fit_hdr_os,
> >+                                          images->fit_noffset_cfg,
> >+                                          &cmd_line_override);
> >+              if (ret)
> >+                      debug("unable to retrieve cmdline for zimage\n");
> >+
> >               is_zimage = 1;
> > #endif
> >       }
> >@@ -125,7 +133,7 @@ static int boot_prep_linux(struct bootm_headers *images)
> >       printf("Setup at %#08lx\n", images->ep);
> >       ret = setup_zimage((void *)images->ep, cmd_line_dest,
> >                       0, images->rd_start,
> >-                      images->rd_end - images->rd_start, 0);
> >+                      images->rd_end - images->rd_start, cmd_line_override);
> >
> >       if (ret) {
> >               printf("## Setting up boot parameters failed ...\n");
> >diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
> >index a5f2231aa523356de93368338b5fd249b8abad6e..af7ee8dbcf3e8f402cb0c76767b8a587f205ad5d 100644
> >--- a/arch/x86/lib/zimage.c
> >+++ b/arch/x86/lib/zimage.c
> >@@ -276,7 +276,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
> > }
> >
> > int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
> >-               ulong initrd_addr, ulong initrd_size, ulong cmdline_force)
> >+               ulong initrd_addr, ulong initrd_size, const char *cmdline_force)
> > {
> >       struct setup_header *hdr = &setup_base->hdr;
> >       int bootproto = get_boot_protocol(hdr, false);
> >@@ -333,7 +333,7 @@ int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
> >
> >               /* build command line at COMMAND_LINE_OFFSET */
> >               if (cmdline_force)
> >-                      strcpy(cmd_line, (char *)cmdline_force);
> >+                      strcpy(cmd_line, cmdline_force);
> >               else
> >                       build_command_line(cmd_line, auto_boot);
> >               if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
> >@@ -404,7 +404,7 @@ int zboot_setup(void)
> >
> >       ret = setup_zimage(base_ptr, (char *)base_ptr + COMMAND_LINE_OFFSET,
> >                          0, state.initrd_addr, state.initrd_size,
> >-                         (ulong)state.cmdline);
> >+                         state.cmdline);
> >       if (ret)
> >               return -EINVAL;
> >
> >diff --git a/boot/image-fit.c b/boot/image-fit.c
> >index e7c7212195f4a291e26ed6d3440a1b42274dacab..1790af4a8e5a9c7d11f7dee5f67226071f8f057e 100644
> >--- a/boot/image-fit.c
> >+++ b/boot/image-fit.c
> >@@ -1096,6 +1096,32 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
> >       return ret;
> > }
> >
> >+/**
> >+ * fit_image_get_cmdline - get image configuration command line
> >+ * @fit: pointer to the FIT format image header
> >+ * @cfg_noffset: configuration node offset
> >+ * @cmdline: double pointer to char, will hold pointer to the cmdline
> >+ *
> >+ * fit_image_get_cmdline() gets the cmdline from the configuration node.
> >+ * If the property is found its data start address is returned to the caller.
> >+ *
> >+ * returns:
> >+ *     0, on success
> >+ *     -1, on failure
> >+ */
> >+int fit_image_get_cmdline(const void *fit, int noffset, const char **cmdline)
> >+{
> >+      int len;
> >+
> >+      *cmdline = (const char *)fdt_getprop(fit, noffset, FIT_CMDLINE_PROP, &len);
> >+      if (!*cmdline) {
> >+              fit_get_debug(fit, noffset, FIT_CMDLINE_PROP, len);
> >+              return -1;
> >+      }
> >+
> >+      return 0;
> >+}
> >+
> > /**
> >  * fit_image_hash_get_algo - get hash algorithm name
> >  * @fit: pointer to the FIT format image header
> >@@ -2136,8 +2162,10 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
> >               fit_base_uname_config = fdt_get_name(fit, cfg_noffset, NULL);
> >               printf("   Using '%s' configuration\n", fit_base_uname_config);
> >               /* Remember this config */
> >-              if (image_type == IH_TYPE_KERNEL)
> >+              if (image_type == IH_TYPE_KERNEL) {
> >                       images->fit_uname_cfg = fit_base_uname_config;
> >+                      images->fit_noffset_cfg = cfg_noffset;
> >+              }
> >
> >               if (FIT_IMAGE_ENABLE_VERIFY && images->verify) {
> >                       puts("   Verifying Hash Integrity ... ");
> >diff --git a/include/image.h b/include/image.h
> >index 34efac6056dd29307df359dce21e4f94d5fcbf2d..9916e67168e3a4f5412fc26d318af32047c239e2 100644
> >--- a/include/image.h
> >+++ b/include/image.h
> >@@ -365,6 +365,7 @@ struct bootm_headers {
> >        * format, even for SPL, this extra data size seems worth it.
> >        */
> >       const char      *fit_uname_cfg; /* configuration node unit name */
> >+      int             fit_noffset_cfg;        /* configuration node offset */
> >
> >       void            *fit_hdr_os;    /* os FIT image header */
> >       const char      *fit_uname_os;  /* os subimage node unit name */
> >@@ -1108,6 +1109,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> > #define FIT_TFA_BL31_PROP     "tfa-bl31"
> > #define FIT_TEE_PROP          "tee"
> > #define FIT_COMPAT_PROP               "compatible"
> >+#define FIT_CMDLINE_PROP      "cmdline"
> >
> > #define FIT_MAX_HASH_LEN      HASH_MAX_DIGEST_SIZE
> >
> >@@ -1259,6 +1261,7 @@ int fit_get_data_node(const void *fit, const char *image_uname,
> > int fit_get_data_conf_prop(const void *fit, const char *prop_name,
> >                          const void **data, size_t *size);
> >
> >+int fit_image_get_cmdline(const void *fit, int noffset, const char **cmdline);
> > int fit_image_hash_get_algo(const void *fit, int noffset, const char **algo);
> > int fit_image_hash_get_value(const void *fit, int noffset, uint8_t **value,
> >                               int *value_len);
> >
> >---
> >base-commit: 98cf83d81617f489d7ff7bf78d33e693e2799254
> >change-id: 20260401-cmdline-ab954a4e8828
> >
> >Best regards,
>
