Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CBBEBFD30
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 10:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91550839DF;
	Mon, 13 Apr 2026 12:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kf7j4+a2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C499483DC9; Mon, 13 Apr 2026 12:48:38 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013F9839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 12:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ranquet.guillaume@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82cd70febc7so2846654b3a.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 03:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776077314; cv=none;
 d=google.com; s=arc-20240605;
 b=BM7d0nOuTkI2GtDdLO9booEPXWMEQPlxHu6iG/nFYyBvIOILUxb1mvyxBwTKSqACm2
 3M547HXQZykEj1UBvXaF7/Dw0HaoZRLmIibWVGkzT25RQc/vU1zkM2LJ1C1qpSuwX1+y
 MlCJP6Sm3ChKnw52TyqvTjkVuusjLsLuMt8yqcrPP1EYY/xTRukQtbo1AIwSA8ctH+kP
 Ih8UzJQuW0R6kbRDm9hS24gRkxJwb3dY27VUD9eLUfwD5F4XZCyKryVupd/uvVw91vnk
 nHT9DdR2ZbLm9CSDHa0hX0mwo+J6/mlg9PREwqoDzpNcB3L1MB6Oa8Ra+dJm7XU5BSfW
 LHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
 :user-agent:from:dkim-signature;
 bh=6BOLccOblBcQwnTlL2NiHow+pyERSqq3TFN4QSycc3s=;
 fh=hDjB4ghDwlr9gcMCB/70x7M9q1CtfdzNZAslHteNuM0=;
 b=RtrZF26ZZwShOItuE90jtMuE9zUuENYhY+mICu6aNG+QPT+F471IPrjx89ubQ5aWPC
 R2FavvNVq00bulHBSg4Mgx4WKS/rYGfd/tBe9FfCVXkJys2TZIshnKI1S9b7AP+yNjo2
 EdE9PqGfmaqJyVl71JzRDGas0V6LOC+aL5+2fOAqAwkXC1ytFZDZPXPfFmz0Or6NwqdZ
 mszVwtBWsFanTXwMqQ2A22NCxc4Ll21afm8HLHW7B5jphBnqUPgiAuz4mMvn5FE4+1gu
 ohya50qs1KLxuKIlnn8bEWt39lajbGx3ZMNuhoHp33mD5JyaRQIWR5TvgF4sMTDSgeaM
 qhRQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776077314; x=1776682114; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
 :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6BOLccOblBcQwnTlL2NiHow+pyERSqq3TFN4QSycc3s=;
 b=kf7j4+a2ifGrEFVMlnW8bkWT9B1eBpPOnMBcIyVdH1aZTZhxkq9MvXv4VVZfPryYUH
 0eml6X8BgVWPHakzH6Zn4uf3dEHF9soSspxy2nuUEZ4HTqYBSXhzJrOtjNlmIVqejwfv
 eGDbDRaYAXUrLicLgR5H7oSHZZuFgbGoVraiiwyNTRndoDH7zZUXSeURoVj4AscQDlSS
 qNSbe66zatx5S79mn1XVVQMVaN2moc2LMdbPDek96Y76xUe8lVrPby+UeFmupzQSVjhD
 yUpbI9mLOA/GW4XW75kYpknXKZIxy04eWuv/alwaKSpGLobYL1HGcvj2Dm5UEJ5knxH9
 8+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776077314; x=1776682114;
 h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
 :user-agent:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BOLccOblBcQwnTlL2NiHow+pyERSqq3TFN4QSycc3s=;
 b=CF3kTcLUI5dqwiaqYtNZp+6JQP432Ao5ZoHuR1tx1geBwpRwyBmjpJx8y5igBMAIOA
 mN7zPMxDImJgB84OwkZQTCXJ8TF20suTdw23gLGCHn/B8Kf03kfkZeHvhhAq5zAhypr0
 wzJs4WN3qgVT2+irP+IPpc9atr6gqJX+Rl0gLAT0/9JYFPFlKy6GVNP6tgHdn2Hq4dxW
 BmXvEct66RRx62v9Ar7B5HWJIJ3umhzzxZiA8y1tlkqtuwxGlGquW095V0l0126Tj0KE
 sw4suFxLhnZ3a2mp8FMuEurCN2b96A/3BNzkk5qPhHNk05uU/lNwc4wY1elDvSns6GaR
 bkPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YsxU13sE8QIjIo5H7gojKriRBsQW/yK/+aW7qmM/8+7pKjK6RYD9tAlDhtpGiarhIzicIAuA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0Cw23U+Ag+ABUfL/xY4zwfBcIHBj0ss27gUfmOgxj0DCxNlp4
 igydX9CzrbpNynhzCpKxv6Nxlz/xHQHgeOsl55jyhwXOr+kdtUts6U8WgAwkoMyn7+VpUNrF4g2
 ynbl2WCLwotNZdiEZoEzdAnvtw1ESlOk=
X-Gm-Gg: AeBDievJJEZK3vI1J8DRVyF88Yg+DhvK6T4Hrvc0xKQj+yXtd3fos4RDftnv9HljBDQ
 FgNRi6gvZQkWrk9H0BXi8dzXBQulk+ZfViHftw3KaP8ev78mnChppVJr9HhTZTR+hujUeI/YFss
 jO3qPtd6Jtmate5Lf3zRRm12hPMOdJQ/o62ujds/eC/c6YbsCMReHXD7c8Talc4oq/XGp0ylLvo
 HCbHSfdUTz7uhLBU69QbO3a1PPLFrKkymcluyyQgkFYRcliSKVmFylPBQH6qCLYKEs7mguRzam9
 gACLKQ==
X-Received: by 2002:a05:6a00:26cc:b0:82f:2243:e448 with SMTP id
 d2e1a72fcca58-82f2243e6d1mr5913145b3a.3.1776077314366; Mon, 13 Apr 2026
 03:48:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Apr 2026 03:48:32 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Apr 2026 03:48:32 -0700
From: Guillaume Ranquet <ranquet.guillaume@gmail.com>
User-Agent: meli/0.8.13
References: <20260403-cmdline-v2-1-83e22c82f02f@missingno.tech>
 <4D95B3CE-66CD-45E0-9DB8-2CDD45622920@gmx.de>
 <CAFLszThvYf0=ebaGqprxy7unbVomC+tu-5uQM2auEZeiNCZpmA@mail.gmail.com>
In-Reply-To: <CAFLszThvYf0=ebaGqprxy7unbVomC+tu-5uQM2auEZeiNCZpmA@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 13 Apr 2026 03:48:32 -0700
X-Gm-Features: AQROBzBTNDCdvjBq1it5kb7xGrFZbrO8_Nw-5YZMiz3KQxwDh7nnyjxDk4RNbVM
Message-ID: <CAD+NunbVCgmyUdfd4WX+i8iZZ4FZy5bwBRdrvsH4B6us9gqwfQ@mail.gmail.com>
Subject: Re: [PATCH v2] arch/x86/lib: implement cmdline configuration property
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Sun, 12 Apr 2026 13:37, Simon Glass <sjg@chromium.org> wrote:
>Hi,
>
>On Sat, 11 Apr 2026 at 05:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>
>> Am 3. April 2026 16:28:23 MESZ schrieb Guillaume Ranquet <ranquet.guillaume@gmail.com>:
>> >Implement the cmdline configuration property as described in the spec
>> >[1]
>>
>>
>> I can't see in the spec that the command line property is x86 specific. Why would you try to implement it in arch/x86?
>>
>
>This is a little tricky though. It could perhaps be handled in
>bootm_process_cmdline_env() by setting bootargs. Both legacy bootm and
>bootstd (via the on_bootargs callback) would then pick it up without
>any arch-specific code. But I haven't tried it. Commands like
>'bootflow cmdline set' need to continue to operate as now.
>
>Regards,
>Simon
>

Indeed, I've looked at implementing this in a generic way but it
requires a bit of massaging to get things working.

I was also under the impression that no one in their right mind would
use the command line property if they had access to a device tree?

Tell me if you think I should propose a generic implementation?

Thx,
Guillaume.

>> Best regards
>>
>> Heirich
>>
>> >
>> >[1]: https://fitspec.osfw.foundation/#id10
>> >
>> >Signed-off-by: Guillaume Ranquet <granquet@missingno.tech>
>> >---
>> >Changes in v2:
>> >- EDITME: describe what is new in this series revision.
>> >- EDITME: use bulletpoints and terse descriptions.
>> >- Link to v1: https://lore.kernel.org/r/20260401-cmdline-v1-1-c56577f82960@missingno.tech
>> >---
>> > arch/x86/include/asm/zimage.h |  2 +-
>> > arch/x86/lib/bootm.c          | 10 +++++++++-
>> > arch/x86/lib/zimage.c         |  6 +++---
>> > boot/image-fit.c              | 30 +++++++++++++++++++++++++++++-
>> > include/image.h               |  3 +++
>> > 5 files changed, 45 insertions(+), 6 deletions(-)
>> >
>> >diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
>> >index 8b5426051701c8266395afd9232eb1ff30d38304..ee0114a227a2b067a3a3126d7d80ab0cc89cea6e 100644
>> >--- a/arch/x86/include/asm/zimage.h
>> >+++ b/arch/x86/include/asm/zimage.h
>> >@@ -132,7 +132,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
>> >  * Return: 0 (always)
>> >  */
>> > int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
>> >-               ulong initrd_addr, ulong initrd_size, ulong cmdline_force);
>> >+               ulong initrd_addr, ulong initrd_size, const char *cmdline_force);
>> >
>> > /**
>> >  * zboot_start() - Prepare to boot a zimage
>> >diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
>> >index cde4fbf35574a267b856a668659ece7e0a36367f..e029cc1ff18bd53eb873c0e56fd9d3b0a331b4c2 100644
>> >--- a/arch/x86/lib/bootm.c
>> >+++ b/arch/x86/lib/bootm.c
>> >@@ -61,6 +61,7 @@ int arch_fixup_memory_node(void *blob)
>> > static int boot_prep_linux(struct bootm_headers *images)
>> > {
>> >       char *cmd_line_dest = NULL;
>> >+      const char *cmd_line_override = NULL;
>> >       struct legacy_img_hdr *hdr;
>> >       int is_zimage = 0;
>> >       void *data = NULL;
>> >@@ -99,6 +100,13 @@ static int boot_prep_linux(struct bootm_headers *images)
>> >                       puts("Can't get image data/size!\n");
>> >                       goto error;
>> >               }
>> >+
>> >+              ret = fit_image_get_cmdline(images->fit_hdr_os,
>> >+                                          images->fit_noffset_cfg,
>> >+                                          &cmd_line_override);
>> >+              if (ret)
>> >+                      debug("unable to retrieve cmdline for zimage\n");
>> >+
>> >               is_zimage = 1;
>> > #endif
>> >       }
>> >@@ -125,7 +133,7 @@ static int boot_prep_linux(struct bootm_headers *images)
>> >       printf("Setup at %#08lx\n", images->ep);
>> >       ret = setup_zimage((void *)images->ep, cmd_line_dest,
>> >                       0, images->rd_start,
>> >-                      images->rd_end - images->rd_start, 0);
>> >+                      images->rd_end - images->rd_start, cmd_line_override);
>> >
>> >       if (ret) {
>> >               printf("## Setting up boot parameters failed ...\n");
>> >diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
>> >index a5f2231aa523356de93368338b5fd249b8abad6e..af7ee8dbcf3e8f402cb0c76767b8a587f205ad5d 100644
>> >--- a/arch/x86/lib/zimage.c
>> >+++ b/arch/x86/lib/zimage.c
>> >@@ -276,7 +276,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
>> > }
>> >
>> > int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
>> >-               ulong initrd_addr, ulong initrd_size, ulong cmdline_force)
>> >+               ulong initrd_addr, ulong initrd_size, const char *cmdline_force)
>> > {
>> >       struct setup_header *hdr = &setup_base->hdr;
>> >       int bootproto = get_boot_protocol(hdr, false);
>> >@@ -333,7 +333,7 @@ int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
>> >
>> >               /* build command line at COMMAND_LINE_OFFSET */
>> >               if (cmdline_force)
>> >-                      strcpy(cmd_line, (char *)cmdline_force);
>> >+                      strcpy(cmd_line, cmdline_force);
>> >               else
>> >                       build_command_line(cmd_line, auto_boot);
>> >               if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
>> >@@ -404,7 +404,7 @@ int zboot_setup(void)
>> >
>> >       ret = setup_zimage(base_ptr, (char *)base_ptr + COMMAND_LINE_OFFSET,
>> >                          0, state.initrd_addr, state.initrd_size,
>> >-                         (ulong)state.cmdline);
>> >+                         state.cmdline);
>> >       if (ret)
>> >               return -EINVAL;
>> >
>> >diff --git a/boot/image-fit.c b/boot/image-fit.c
>> >index e7c7212195f4a291e26ed6d3440a1b42274dacab..1790af4a8e5a9c7d11f7dee5f67226071f8f057e 100644
>> >--- a/boot/image-fit.c
>> >+++ b/boot/image-fit.c
>> >@@ -1096,6 +1096,32 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
>> >       return ret;
>> > }
>> >
>> >+/**
>> >+ * fit_image_get_cmdline - get image configuration command line
>> >+ * @fit: pointer to the FIT format image header
>> >+ * @cfg_noffset: configuration node offset
>> >+ * @cmdline: double pointer to char, will hold pointer to the cmdline
>> >+ *
>> >+ * fit_image_get_cmdline() gets the cmdline from the configuration node.
>> >+ * If the property is found its data start address is returned to the caller.
>> >+ *
>> >+ * returns:
>> >+ *     0, on success
>> >+ *     -1, on failure
>> >+ */
>> >+int fit_image_get_cmdline(const void *fit, int noffset, const char **cmdline)
>> >+{
>> >+      int len;
>> >+
>> >+      *cmdline = (const char *)fdt_getprop(fit, noffset, FIT_CMDLINE_PROP, &len);
>> >+      if (!*cmdline) {
>> >+              fit_get_debug(fit, noffset, FIT_CMDLINE_PROP, len);
>> >+              return -1;
>> >+      }
>> >+
>> >+      return 0;
>> >+}
>> >+
>> > /**
>> >  * fit_image_hash_get_algo - get hash algorithm name
>> >  * @fit: pointer to the FIT format image header
>> >@@ -2136,8 +2162,10 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>> >               fit_base_uname_config = fdt_get_name(fit, cfg_noffset, NULL);
>> >               printf("   Using '%s' configuration\n", fit_base_uname_config);
>> >               /* Remember this config */
>> >-              if (image_type == IH_TYPE_KERNEL)
>> >+              if (image_type == IH_TYPE_KERNEL) {
>> >                       images->fit_uname_cfg = fit_base_uname_config;
>> >+                      images->fit_noffset_cfg = cfg_noffset;
>> >+              }
>> >
>> >               if (FIT_IMAGE_ENABLE_VERIFY && images->verify) {
>> >                       puts("   Verifying Hash Integrity ... ");
>> >diff --git a/include/image.h b/include/image.h
>> >index 34efac6056dd29307df359dce21e4f94d5fcbf2d..9916e67168e3a4f5412fc26d318af32047c239e2 100644
>> >--- a/include/image.h
>> >+++ b/include/image.h
>> >@@ -365,6 +365,7 @@ struct bootm_headers {
>> >        * format, even for SPL, this extra data size seems worth it.
>> >        */
>> >       const char      *fit_uname_cfg; /* configuration node unit name */
>> >+      int             fit_noffset_cfg;        /* configuration node offset */
>> >
>> >       void            *fit_hdr_os;    /* os FIT image header */
>> >       const char      *fit_uname_os;  /* os subimage node unit name */
>> >@@ -1108,6 +1109,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
>> > #define FIT_TFA_BL31_PROP     "tfa-bl31"
>> > #define FIT_TEE_PROP          "tee"
>> > #define FIT_COMPAT_PROP               "compatible"
>> >+#define FIT_CMDLINE_PROP      "cmdline"
>> >
>> > #define FIT_MAX_HASH_LEN      HASH_MAX_DIGEST_SIZE
>> >
>> >@@ -1259,6 +1261,7 @@ int fit_get_data_node(const void *fit, const char *image_uname,
>> > int fit_get_data_conf_prop(const void *fit, const char *prop_name,
>> >                          const void **data, size_t *size);
>> >
>> >+int fit_image_get_cmdline(const void *fit, int noffset, const char **cmdline);
>> > int fit_image_hash_get_algo(const void *fit, int noffset, const char **algo);
>> > int fit_image_hash_get_value(const void *fit, int noffset, uint8_t **value,
>> >                               int *value_len);
>> >
>> >---
>> >base-commit: 98cf83d81617f489d7ff7bf78d33e693e2799254
>> >change-id: 20260401-cmdline-ab954a4e8828
>> >
>> >Best regards,
>>
