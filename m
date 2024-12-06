Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC878E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 23:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6528A89124;
	Sat,  7 Dec 2024 00:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LrGD8Vbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58718961C; Sat,  7 Dec 2024 00:44:09 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A60089451
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 00:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa63dbda904so245150166b.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733528646; x=1734133446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HoTntMNmjiJVNs86f5Iz0dgprVn8XC+nDOZF6E3kCsY=;
 b=LrGD8Vbve4iNnKLzj4vLyOoa1fWOBzTb3FrrzSXvftmsnpaKMmahiosc7sj805YP3x
 kwbupm2V6WsuIFEsUdU0xfWUAFnnwGimszSkKOO3BtzS7B2mmSG6Ftf5EylKrTuglWdE
 nTryqENKaO27eumODUWq2pSGUVPvFM2Sg48LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733528646; x=1734133446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HoTntMNmjiJVNs86f5Iz0dgprVn8XC+nDOZF6E3kCsY=;
 b=jmEjLkYJC2msPBEEMxAxxBc2XTVVopqDp72NfAiLC7Hix7xaAx3X4u99/Dhz9l6fVA
 eH40nYyzn8RA8Mw94hSXfy74FPK6eIfxyKBJblc+Ej0+AHVY+n3Rea9JuOuQVib2TGwe
 JFMOh0p0QxCjgHUOhqEZRgufP6oWOQ2Vmx54pf5zi+bCRTuAWBTbVSUHMv51J4mJumaA
 YcemUVbXPF2ANQzWpY2mE0pU/dWsc8Rn+Hmjh7Lpehw3ZLXfiAj5U8O+QLTpPP7ShbMl
 UgJFpM8JGDDlUE9aSITri7EwwRJjbcTQlof4UY4TPFVVhc4UuOGKdzImWS0+xKnS3kns
 nj9Q==
X-Gm-Message-State: AOJu0YzKVZGgSQaji63oWgWDgHE+d6fExbFmX4MrqP1OS00MI68/rXug
 GNsuUynV+Duvl1gGtBVbrSC4gJODcj6/3OzDC8OwY5VOhsxj/EPrPaseFKbbk6drOZcD8J8BcIN
 3oJL4Pm/vK54FBZ6yHHQXcIaE5jYnQXf18clI
X-Gm-Gg: ASbGncsj5elHWkvqXccXrxJgGsvz6QyHFWcrFFyiR5CzkcovbLLj78zt5gRq4e/YqOS
 jzqTYWZmgcIVxFz8AdGgYvFvNE4pn2Ws1
X-Google-Smtp-Source: AGHT+IG1EAiwgyAhqFJadewnX3a2ZrNY7sYubeEMzMMDtCWv1Kqp/HqkxhDY2wJ5dyBdaHRhp8aAWrAc3GFtJDV+Cbk=
X-Received: by 2002:a17:906:2189:b0:aa6:143e:12a with SMTP id
 a640c23a62f3a-aa639fa4855mr434947266b.2.1733528645578; Fri, 06 Dec 2024
 15:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-4-raymond.mao@linaro.org>
 <CAFLszTjNB+JZZdKShy6JkR69E2WJE-g=OapC3oThPeT1jLS-zA@mail.gmail.com>
 <CAEfUkUJGLatGxwyHLzH87-0Sq9JLreyHVvEVkwZCxcfx8r1Hcg@mail.gmail.com>
 <CAFLszTgG9ec-gZe5hf+CQ3TczXV0QFADEAkN0za1+dbXANarNw@mail.gmail.com>
 <CAEfUkULF5CGhjDoZznOtSTv4PDn57nScCf379VMk23Vt1p154w@mail.gmail.com>
In-Reply-To: <CAEfUkULF5CGhjDoZznOtSTv4PDn57nScCf379VMk23Vt1p154w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 16:43:54 -0700
Message-ID: <CAFLszTjeb2pL+cytmkbnJyWAFxGGWO0yS9YA1rA6uEpV4Pgv+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] sysinfo: Add sysinfo driver and data structure for
 smbios
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Raymond,

On Fri, 6 Dec 2024 at 08:54, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 6 Dec 2024 at 10:31, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Thu, 5 Dec 2024 at 10:28, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Hi Simon,
>> >
>> > On Mon, 28 Oct 2024 at 13:04, Simon Glass <sjg@chromium.org> wrote:
>> >>
>> >> Hi Raymond,
>> >>
>> >> On Tue, 22 Oct 2024 at 22:06, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >> >
>> >> > Add sysinfo driver to retrieve smbios information (Type 4 and 7).
>> >> > So that the smbios library can use it for getting values from the
>> >> > hardware platform instead of device tree.
>> >> >
>> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> >> > ---
>> >> > Changes in v2
>> >> > - Move the changes to smbios.c instead of creating new file.
>> >> > - Move the headfile to include dir.
>> >> > - Combine with #6(v1) patch.
>> >> > - Clean-up the private data structures.
>> >> > - Clean-up the operations of the strings and common values.
>> >> >
>> >> >  drivers/sysinfo/smbios.c | 228 +++++++++++++++++++++++++++++++++++++++
>> >> >  include/smbios.h         |  60 +++++++++++
>> >> >  include/smbios_plat.h    |  79 ++++++++++++++
>> >> >  include/sysinfo.h        |  95 +++++++++++++++-
>> >> >  4 files changed, 461 insertions(+), 1 deletion(-)
>> >> >  create mode 100644 include/smbios_plat.h
>> >> >
>> >> > diff --git a/drivers/sysinfo/smbios.c b/drivers/sysinfo/smbios.c
>> >> > index a7ac8e3f072..3980845b3ba 100644
>> >> > --- a/drivers/sysinfo/smbios.c
>> >> > +++ b/drivers/sysinfo/smbios.c
>> >> > @@ -5,14 +5,240 @@
>> >> >   */
>> >> >
>> >> >  #include <dm.h>
>> >> > +#include <smbios_plat.h>
>> >> >  #include <sysinfo.h>
>> >> >
>> >> > +/* platform information storage */
>> >> > +struct processor_info processor_info;
>> >> > +struct cache_info cache_info[SYSINFO_CACHE_LVL_MAX];
>> >> > +struct sysinfo_plat sysinfo_smbios_p = {
>> >> > +       /* Processor Information */
>> >> > +       .processor = &processor_info,
>> >> > +       /* Cache Information */
>> >> > +       .cache = &cache_info[0],
>> >> > +};
>> >> > +
>> >> > +/* structure for smbios private data storage */
>> >> > +struct sysinfo_plat_priv {
>> >> > +       struct processor_info *t4;
>> >> > +       struct smbios_type7 t7[SYSINFO_CACHE_LVL_MAX];
>> >> > +       u16 cache_handles[SYSINFO_CACHE_LVL_MAX];
>> >> > +       u8 cache_level;
>> >> > +};
>> >> > +
>> >> > +static void smbios_cache_info_dump(struct smbios_type7 *cache_info)
>> >> > +{
>> >> > +       log_debug("SMBIOS Type 7 (Cache Information):\n");
>> >> > +       log_debug("Cache Configuration: 0x%04x\n", cache_info->config.data);
>> >> > +       log_debug("Maximum Cache Size: %u KB\n", cache_info->max_size.data);
>> >> > +       log_debug("Installed Size: %u KB\n", cache_info->inst_size.data);
>> >> > +       log_debug("Supported SRAM Type: 0x%04x\n",
>> >>
>> >> %#04x
>> >>
>> >> > +                 cache_info->supp_sram_type.data);
>> >> > +       log_debug("Current SRAM Type: 0x%04x\n",
>> >> > +                 cache_info->curr_sram_type.data);
>> >> > +       log_debug("Cache Speed: %u\n", cache_info->speed);
>> >> > +       log_debug("Error Correction Type: %u\n", cache_info->err_corr_type);
>> >> > +       log_debug("System Cache Type: %u\n", cache_info->sys_cache_type);
>> >> > +       log_debug("Associativity: %u\n", cache_info->associativity);
>> >> > +       log_debug("Maximum Cache Size 2: %u KB\n", cache_info->max_size2.data);
>> >> > +       log_debug("Installed Cache Size 2: %u KB\n",
>> >> > +                 cache_info->inst_size2.data);
>> >> > +}
>> >> > +
>> >> > +/* weak function for the platforms not yet supported */
>> >> > +__weak int sysinfo_get_cache_info(u8 level, struct cache_info *cache_info)
>> >> > +{
>> >> > +       return -ENOSYS;
>> >> > +}
>> >> > +
>> >> > +__weak int sysinfo_get_processor_info(struct processor_info *pinfo)
>> >> > +{
>> >> > +       return -ENOSYS;
>> >> > +}
>> >> > +
>> >> > +void sysinfo_cache_info_default(struct cache_info *ci)
>> >> > +{
>> >> > +       memset(ci, 0, sizeof(*ci));
>> >> > +       ci->config.data = SMBIOS_CACHE_LOCATE_UNKNOWN | SMBIOS_CACHE_OP_UND;
>> >> > +       ci->supp_sram_type.fields.unknown = 1;
>> >> > +       ci->curr_sram_type.fields.unknown = 1;
>> >> > +       ci->speed = SMBIOS_CACHE_SPEED_UNKNOWN;
>> >> > +       ci->err_corr_type = SMBIOS_CACHE_ERRCORR_UNKNOWN;
>> >> > +       ci->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN;
>> >> > +}
>> >> > +
>> >> > +static int sysinfo_plat_detect(struct udevice *dev)
>> >> > +{
>> >> > +       return 0;
>> >> > +}
>> >> > +
>> >> > +static int sysinfo_plat_get_str(struct udevice *dev, int id,
>> >> > +                               size_t size, char *val)
>> >> > +{
>> >> > +       struct sysinfo_plat_priv *priv = dev_get_priv(dev);
>> >> > +       const char *str = NULL;
>> >> > +
>> >> > +       switch (id) {
>> >> > +       case SYSINFO_ID_SMBIOS_PROCESSOR_MANUFACT:
>> >>
>> >> These are getting too long.
>> >>
>> >> How about SYSINFOSM_PROC_MANUF ?
>> >>
>> >> We can use SYSINFOSM as short for SYSINFO_ID_SMBIOS
>> >>
>> >> > +               str = priv->t4->manufacturer;
>> >> > +               break;
>> >> > +       default:
>> >> > +               break;
>> >> > +       }
>> >> > +
>> >> > +       if (!str)
>> >> > +               return -ENOSYS;
>> >> > +
>> >> > +       strlcpy(val, str, size);
>> >> > +
>> >> > +       return 0;
>> >> > +}
>> >> > +
>> >> > +static int sysinfo_plat_get_int(struct udevice *dev, int id, int *val)
>> >> > +{
>> >> > +       struct sysinfo_plat_priv *priv = dev_get_priv(dev);
>> >> > +       u8 i;
>> >> > +
>> >> > +       if (id >= SYSINFO_ID_SMBIOS_CACHE_INFO_START &&
>> >> > +           id <= SYSINFO_ID_SMBIOS_CACHE_INFO_END) {
>> >> > +               /* For smbios type 7 */
>> >> > +               for (i = 0; i < priv->cache_level; i++) {
>> >> > +                       switch (id - i) {
>> >> > +                       case SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE:
>> >> > +                               *val = priv->t7[i].max_size.data;
>> >> > +                               return 0;
>> >> > +                       case SYSINFO_ID_SMBIOS_CACHE_INST_SIZE:
>> >> > +                               *val = priv->t7[i].inst_size.data;
>> >> > +                               return 0;
>> >> > +                       case SYSINFO_ID_SMBIOS_CACHE_SCACHE_TYPE:
>> >> > +                               *val = priv->t7[i].sys_cache_type;
>> >> > +                               return 0;
>> >> > +                       case SYSINFO_ID_SMBIOS_CACHE_ASSOC:
>> >> > +                               *val = priv->t7[i].associativity;
>> >> > +                               return 0;
>> >> > +                       case SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE2:
>> >> > +                               *val = priv->t7[i].max_size2.data;
>> >> > +                               return 0;
>> >> > +                       case SYSINFO_ID_SMBIOS_CACHE_INST_SIZE2:
>> >> > +                               *val = priv->t7[i].inst_size2.data;
>> >> > +                               return 0;
>> >> > +                       default:
>> >> > +                               break;
>> >> > +                       }
>> >> > +               }
>> >> > +               return -ENOSYS;
>> >> > +       }
>> >> > +
>> >> > +       switch (id) {
>> >> > +       case SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT:
>> >> > +               *val = priv->t4->core_count;
>> >> > +               break;
>> >> > +       case SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN:
>> >> > +               *val = priv->t4->core_enabled;
>> >> > +               break;
>> >> > +       case SYSINFO_ID_SMBIOS_PROCESSOR_CHARA:
>> >> > +               *val = priv->t4->characteristics;
>> >> > +               break;
>> >> > +       case SYSINFO_ID_SMBIOS_CACHE_LEVEL:
>> >> > +               if (!priv->cache_level) /* No cache detected */
>> >> > +                       return -ENOSYS;
>> >> > +               *val = priv->cache_level - 1;
>> >> > +               break;
>> >> > +       default:
>> >> > +               return -ENOSYS;
>> >> > +       }
>> >> > +
>> >> > +       return 0;
>> >> > +}
>> >> > +
>> >> > +static int sysinfo_plat_get_data(struct udevice *dev, int id, uchar **buf,
>> >>
>> >> How about void **, so we don't need to cast below?
>> >>
>> >> > +                                size_t *size)
>> >> > +{
>> >> > +       struct sysinfo_plat_priv *priv = dev_get_priv(dev);
>> >> > +
>> >> > +       switch (id) {
>> >> > +       case SYSINFO_ID_SMBIOS_PROCESSOR_ID:
>> >> > +               *buf = (uchar *)priv->t4->id;
>> >> > +               *size = sizeof(priv->t4->id);
>> >> > +               break;
>> >> > +       case SYSINFO_ID_SMBIOS_CACHE_HANDLE:
>> >> > +               *buf = (uchar *)(&priv->cache_handles[0]);
>> >>
>> >> Isn't that the same as:
>> >>
>> >>     *buf = (uchar *)&priv->cache_handles;
>> >>
>> >> > +               *size = sizeof(priv->cache_handles);
>> >> > +               break;
>> >> > +       default:
>> >> > +               return -EOPNOTSUPP;
>> >> > +       }
>> >> > +       return 0;
>> >> > +}
>> >> > +
>> >> > +static int sysinfo_plat_probe(struct udevice *dev)
>> >> > +{
>> >> > +       struct sysinfo_plat_priv *priv = dev_get_priv(dev);
>> >> > +       struct sysinfo_plat *plat = &sysinfo_smbios_p;
>> >> > +       u8 level;
>> >> > +
>> >> > +       if (!sysinfo_get_processor_info(plat->processor))
>> >> > +               priv->t4 = plat->processor;
>> >> > +
>> >> > +       for (level = 0; level < SYSINFO_CACHE_LVL_MAX; level++) {
>> >> > +               struct cache_info *pcache = plat->cache + level;
>> >> > +
>> >> > +               if (sysinfo_get_cache_info(level, pcache))
>> >> > +                       break; /* no more levels */
>> >> > +
>> >> > +               /*
>> >> > +                * Fill in the SMBIOS type 7 structure,
>> >> > +                * skip the header members (type, length, handle),
>> >> > +                * and the ones in DT smbios node.
>> >> > +                */
>> >> > +               priv->t7[level].sys_cache_type = pcache->cache_type;
>> >> > +               priv->t7[level].associativity = pcache->associativity;
>> >> > +
>> >> > +               if (pcache->max_size > SMBIOS_CACHE_SIZE_EXT_KB) {
>> >> > +                       priv->t7[level].max_size.data = 0xFFFF;
>> >> > +                       priv->t7[level].max_size2.fields.size =
>> >> > +                               pcache->max_size / 64;
>> >> > +                       priv->t7[level].max_size2.fields.granu =
>> >> > +                               SMBIOS_CACHE_GRANU_64K;
>> >> > +               } else {
>> >> > +                       priv->t7[level].max_size.fields.size = pcache->max_size;
>> >> > +                       priv->t7[level].max_size.fields.granu =
>> >> > +                               SMBIOS_CACHE_GRANU_1K;
>> >> > +                       priv->t7[level].max_size2.data = 0;
>> >> > +               }
>> >> > +               if (pcache->inst_size > SMBIOS_CACHE_SIZE_EXT_KB) {
>> >> > +                       priv->t7[level].inst_size.data = 0xFFFF;
>> >> > +                       priv->t7[level].inst_size2.fields.size =
>> >> > +                               pcache->inst_size / 64;
>> >> > +                       priv->t7[level].inst_size2.fields.granu =
>> >> > +                               SMBIOS_CACHE_GRANU_64K;
>> >> > +               } else {
>> >> > +                       priv->t7[level].inst_size.fields.size =
>> >> > +                               pcache->inst_size;
>> >> > +                       priv->t7[level].inst_size.fields.granu =
>> >> > +                               SMBIOS_CACHE_GRANU_1K;
>> >> > +                       priv->t7[level].inst_size2.data = 0;
>> >> > +               }
>> >> > +               smbios_cache_info_dump(&priv->t7[level]);
>> >> > +       }
>> >> > +       if (!level) /* no cache detected */
>> >> > +               return -ENOSYS;
>> >> > +
>> >> > +       priv->cache_level = level;
>> >> > +
>> >> > +       return 0;
>> >> > +}
>> >> > +
>> >> >  static const struct udevice_id sysinfo_smbios_ids[] = {
>> >> >         { .compatible = "u-boot,sysinfo-smbios" },
>> >> >         { /* sentinel */ }
>> >> >  };
>> >> >
>> >> >  static const struct sysinfo_ops sysinfo_smbios_ops = {
>> >> > +       .detect = sysinfo_plat_detect,
>> >> > +       .get_str = sysinfo_plat_get_str,
>> >> > +       .get_int = sysinfo_plat_get_int,
>> >> > +       .get_data = sysinfo_plat_get_data,
>> >> >  };
>> >> >
>> >> >  U_BOOT_DRIVER(sysinfo_smbios) = {
>> >> > @@ -20,4 +246,6 @@ U_BOOT_DRIVER(sysinfo_smbios) = {
>> >> >         .id             = UCLASS_SYSINFO,
>> >> >         .of_match       = sysinfo_smbios_ids,
>> >> >         .ops            = &sysinfo_smbios_ops,
>> >> > +       .priv_auto      = sizeof(struct sysinfo_plat_priv),
>> >> > +       .probe          = sysinfo_plat_probe,
>> >> >  };
>> >> > diff --git a/include/smbios.h b/include/smbios.h
>> >> > index 78fd14d881b..cb4b3e08b3a 100644
>> >> > --- a/include/smbios.h
>> >> > +++ b/include/smbios.h
>> >> > @@ -187,6 +187,66 @@ struct __packed smbios_type4 {
>> >> >         char eos[SMBIOS_STRUCT_EOS_BYTES];
>> >> >  };
>> >> >
>> >> > +union cache_config {
>> >> > +       struct {
>> >> > +               u16 level:3;
>> >> > +               u16 bsocketed:1;
>> >> > +               u16 rsvd0:1;
>> >> > +               u16 locate:2;
>> >> > +               u16 benabled:1;
>> >> > +               u16 opmode:2;
>> >> > +               u16 rsvd1:6;
>> >> > +       } fields;
>> >> > +       u16 data;
>> >> > +};
>> >> > +
>> >> > +union cache_size_word {
>> >> > +       struct {
>> >> > +               u16 size:15;
>> >> > +               u16 granu:1;
>> >> > +       } fields;
>> >> > +       u16 data;
>> >> > +};
>> >> > +
>> >> > +union cache_size_dword {
>> >> > +       struct {
>> >> > +               u32 size:31;
>> >> > +               u32 granu:1;
>> >> > +       } fields;
>> >> > +       u32 data;
>> >> > +};
>> >> > +
>> >> > +union cache_sram_type {
>> >> > +       struct {
>> >> > +               u16 other:1;
>> >> > +               u16 unknown:1;
>> >> > +               u16 nonburst:1;
>> >> > +               u16 burst:1;
>> >> > +               u16 plburst:1;
>> >> > +               u16 sync:1;
>> >> > +               u16 async:1;
>> >> > +               u16 rsvd:9;
>> >> > +       } fields;
>> >> > +       u16 data;
>> >> > +};
>> >> > +
>> >> > +struct __packed smbios_type7 {
>> >> > +       struct smbios_header hdr;
>> >> > +       u8 socket_design;
>> >> > +       union cache_config config;
>> >> > +       union cache_size_word max_size;
>> >> > +       union cache_size_word inst_size;
>> >> > +       union cache_sram_type supp_sram_type;
>> >> > +       union cache_sram_type curr_sram_type;
>> >> > +       u8 speed;
>> >> > +       u8 err_corr_type;
>> >> > +       u8 sys_cache_type;
>> >> > +       u8 associativity;
>> >> > +       union cache_size_dword max_size2;
>> >> > +       union cache_size_dword inst_size2;
>> >> > +       char eos[SMBIOS_STRUCT_EOS_BYTES];
>> >> > +};
>> >> > +
>> >> >  struct __packed smbios_type32 {
>> >> >         u8 type;
>> >> >         u8 length;
>> >> > diff --git a/include/smbios_plat.h b/include/smbios_plat.h
>> >> > new file mode 100644
>> >> > index 00000000000..70089d5a2ba
>> >> > --- /dev/null
>> >> > +++ b/include/smbios_plat.h
>> >> > @@ -0,0 +1,79 @@
>> >> > +/* SPDX-License-Identifier: GPL-2.0+ */
>> >> > +/*
>> >> > + * Copyright (c) 2024 Linaro Limited
>> >> > + * Author: Raymond Mao <raymond.mao@linaro.org>
>> >> > + */
>> >> > +#ifndef __SMBIOS_PLAT_H
>> >> > +#define __SMBIOS_PLAT_H
>> >> > +
>> >> > +#include <smbios.h>
>> >> > +
>> >> > +struct cache_info {
>> >> > +       union cache_config config;
>> >> > +       union cache_sram_type supp_sram_type;
>> >> > +       union cache_sram_type curr_sram_type;
>> >> > +       u32 line_size;
>> >> > +       u32 associativity;
>> >> > +       u32 max_size;
>> >> > +       u32 inst_size;
>> >> > +       u8 cache_type;
>> >> > +       u8 speed;
>> >> > +       u8 err_corr_type;
>> >> > +       char *socket_design;
>> >> > +};
>> >> > +
>> >> > +struct processor_info {
>> >> > +       u32 id[2];
>> >> > +       u16 ext_clock;
>> >> > +       u16 max_speed;
>> >> > +       u16 curr_speed;
>> >> > +       u16 characteristics;
>> >> > +       u16 family2;
>> >> > +       u16 core_count2;
>> >> > +       u16 core_enabled2;
>> >> > +       u16 thread_count2;
>> >> > +       u16 thread_enabled;
>> >> > +       u8 type;
>> >> > +       u8 family;
>> >> > +       u8 voltage;
>> >> > +       u8 status;
>> >> > +       u8 upgrade;
>> >> > +       u8 core_count;
>> >> > +       u8 core_enabled;
>> >> > +       u8 thread_count;
>> >> > +       char *socket_design;
>> >> > +       char *manufacturer;
>> >> > +       char *version;
>> >> > +       char *sn;
>> >> > +       char *asset_tag;
>> >> > +       char *pn;
>> >> > +};
>> >> > +
>> >> > +struct sysinfo_plat {
>> >> > +       struct processor_info *processor;
>> >> > +       struct cache_info *cache;
>> >> > +       /* add other sysinfo structure here */
>> >> > +};
>> >> > +
>> >> > +#if defined CONFIG_SYSINFO_SMBIOS
>> >> > +int sysinfo_get_cache_info(u8 level, struct cache_info *cache_info);
>> >> > +void sysinfo_cache_info_default(struct cache_info *ci);
>> >> > +int sysinfo_get_processor_info(struct processor_info *pinfo);
>> >> > +#else
>> >> > +static inline int sysinfo_get_cache_info(u8 level,
>> >> > +                                        struct cache_info *cache_info)
>> >> > +{
>> >> > +       return -ENOSYS;
>> >> > +}
>> >> > +
>> >> > +static inline void sysinfo_cache_info_default(struct cache_info *ci)
>> >> > +{
>> >> > +}
>> >> > +
>> >> > +static inline int sysinfo_get_processor_info(struct processor_info *pinfo)
>> >> > +{
>> >> > +       return -ENOSYS;
>> >> > +}
>> >> > +#endif
>> >> > +
>> >> > +#endif /* __SMBIOS_PLAT_H */
>> >> > diff --git a/include/sysinfo.h b/include/sysinfo.h
>> >> > index 17b2b9c7111..cb08a691270 100644
>> >> > --- a/include/sysinfo.h
>> >> > +++ b/include/sysinfo.h
>> >> > @@ -11,6 +11,8 @@
>> >> >
>> >> >  struct udevice;
>> >> >
>> >> > +#define SYSINFO_CACHE_LVL_MAX 3
>> >> > +
>> >> >  /*
>> >> >   * This uclass encapsulates hardware methods to gather information about a
>> >> >   * sysinfo or a specific device such as hard-wired GPIOs on GPIO expanders,
>> >> > @@ -42,18 +44,109 @@ struct udevice;
>> >> >  enum sysinfo_id {
>> >> >         SYSINFO_ID_NONE,
>> >> >
>> >> > -       /* For SMBIOS tables */
>> >> > +       /* BIOS Information (Type 0) */
>> >> > +       SYSINFO_ID_SMBIOS_BIOS_VENDOR,
>> >> > +       SYSINFO_ID_SMBIOS_BIOS_VER,
>> >> > +       SYSINFO_ID_SMBIOS_BIOS_REL_DATE,
>> >> > +
>> >> > +       /* System Information (Type 1) */
>> >> >         SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
>> >> >         SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT,
>> >> >         SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
>> >> >         SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
>> >> > +       SYSINFO_ID_SMBIOS_SYSTEM_WAKEUP,
>> >> >         SYSINFO_ID_SMBIOS_SYSTEM_SKU,
>> >> >         SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
>> >> > +
>> >> > +       /* Baseboard (or Module) Information (Type 2) */
>> >> >         SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
>> >> >         SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
>> >> >         SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
>> >> >         SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
>> >> >         SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
>> >> > +       SYSINFO_ID_SMBIOS_BASEBOARD_FEATURE,
>> >> > +       SYSINFO_ID_SMBIOS_BASEBOARD_CHASSIS_LOCAT,
>> >> > +       SYSINFO_ID_SMBIOS_BASEBOARD_TYPE,
>> >> > +       SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_NUM,
>> >> > +       SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_HANDLE,
>> >> > +
>> >> > +       /* System Enclosure or Chassis (Type 3) */
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_MANUFACTURER,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_VERSION,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_SERIAL,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_ASSET_TAG,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_TYPE,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_BOOTUP,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_POW,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_THERMAL,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_SECURITY,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_OEM,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_HEIGHT,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_POWCORE_NUM,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_CNT,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_LEN,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENTS,
>> >> > +       SYSINFO_ID_SMBIOS_ENCLOSURE_SKU,
>> >> > +
>> >> > +       /* Processor Information (Type 4) */
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_SOCKET,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_TYPE,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_MANUFACT,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_ID,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_VERSION,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_VOLTAGE,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_EXT_CLOCK,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_MAX_SPEED,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_CUR_SPEED,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_STATUS,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_UPGRADE,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_SN,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_ASSET_TAG,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_PN,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_CHARA,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_FAMILY,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_FAMILY2,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT2,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN2,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT2,
>> >> > +       SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_EN,
>> >> > +
>> >> > +       /*
>> >> > +        * Cache Information (Type 7)
>> >> > +        * Each of the id should reserve space for up to
>> >> > +        * SYSINFO_CACHE_LVL_MAX levels of cache
>> >> > +        */
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_LEVEL,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_HANDLE,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_INFO_START,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_SOCKET = SYSINFO_ID_SMBIOS_CACHE_INFO_START,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_CONFIG =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_SOCKET + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_CONFIG + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_INST_SIZE =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_SUPSRAM_TYPE =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_INST_SIZE + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_CURSRAM_TYPE =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_SUPSRAM_TYPE + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_SPEED =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_CURSRAM_TYPE + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_ERRCOR_TYPE =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_SPEED + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_SCACHE_TYPE =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_ERRCOR_TYPE + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_ASSOC =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_SCACHE_TYPE + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE2 =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_ASSOC + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_INST_SIZE2 =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_MAX_SIZE2 + SYSINFO_CACHE_LVL_MAX,
>> >> > +       SYSINFO_ID_SMBIOS_CACHE_INFO_END =
>> >> > +               SYSINFO_ID_SMBIOS_CACHE_INST_SIZE2 + SYSINFO_CACHE_LVL_MAX - 1,
>> >> >
>> >>
>> >> This seems to be allocating sequential values for each cache? Instead, we should add a 'seq' parameter to get_data()
>> >>
>> > Sorry for not responding to this comment, actually I would prefer to use get_str or get_val as it allows
>> > to check whether values from sysinfo driver are missing and fallback to the value from dt node one by one.
>>
>> Yes that is good...I had assumed this was just data, rather than string/int.
>>
>> My main point is that we need an indexed lookup, where on SYSINFO_ID
>> can be used to lookup up multiple values, with an index, since the
>> scheme in this patch is a little unwieldy.
>>
> I understand what you are concerned about.
> Using a unique id for one value allows each field to independently fallback to the value from the dt node.
> For the scenario of cache information, the values from each level should be independently retrieved from
> either sysinfo driver or dt node.
> But if we group the values from multiple levels using the same id, we lose the independence.
> The only disadvantage here is some of the SYSINFO_IDs are reserved in an implicit manner which is a
> trade-off.

Could you give an example of what the DT node looks like?

Do we expect to put the cache info in a DT node...I wonder if it might
be OK to not allow that?

But if we need it, the proper DT way would be to have a list, e.g.

level0 {
    associativity = ...
    max-size = ...
};
level1 {
    associativity = ...
    max-size = ...
}

Would that work?

Regards,
Simon
