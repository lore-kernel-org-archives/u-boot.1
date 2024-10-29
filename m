Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CBDD3A66B
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E615B8912C;
	Tue, 29 Oct 2024 16:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WgM7HR0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31188917E; Tue, 29 Oct 2024 16:45:32 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C5088FA8
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso871721066b.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730216729; x=1730821529; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6tbA8fTzz7WU7+5XNgV1ER8GO34DdyAAgn50GUtMgU=;
 b=WgM7HR0rI/XlKUcG0IF0m6FRsTJxmwxEbFx85unxmqCkHVd9AcIbMNGjpnwA6Yzfi4
 nPKVa9TLwrSVJT3Xnjrmm+hKBl65L1IjuYsVVue8z7eaw8zLDytc5ij6CTbrwFGnd/lt
 xx58saJnn6DSnSlbzDQp7o5g4MlGi+n9KtCiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216729; x=1730821529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y6tbA8fTzz7WU7+5XNgV1ER8GO34DdyAAgn50GUtMgU=;
 b=u0DtjcBjl6AaV9BdI6ld4oWE6e7BLHg3V3Hfb0bLM9ehnqRuUTp53SD0WDEeHxbHoL
 SBwpkK0hkVGb2Cs0LtuKoBuTLbwLYiXXrZrMRUy9qL2DTrzenEMPF1xVcxUeJZ7PnNqv
 TjiiqKQcAQ4LRgzTHjIqcBtUHeVGF2ZZ6knS+cXLO5GfaxTLpjLTz3YdhnT5cAxNbGLw
 zCfrVHEY9yl0eZkg/Aq4ClQzvPuWIztl78UnjkOcqSo2CyUxyTIcEB+tlxVWcBayrwsQ
 PyLmu6AmAfjJPpOUF7rHkt375cSBMaNnWeVfmBV5b89JF9wEveqDu20oNoCaXyDTiDQz
 rqfA==
X-Gm-Message-State: AOJu0YyPX5ftdnoQ8V71/cW5o6LMbv54xUoVQN3fbAuDBzGx3TR39EIH
 3BbgDWFZ/B9rk99nMjOpFlQNi4vu0Ku4XWQKILNkYGNZYmSovKMf7m69Q1+IOGUF+RXsyjufIES
 ky9W9f/DLgZzzf6H17aScnkYYHmGBirst0LrK
X-Google-Smtp-Source: AGHT+IEjs+aczkCn8it0C67nlQeLtNXqrKDToCRf6joMufMbbb73nENclfIPPCaJ3tbDeJpI0+P7tEIbhyzs/v7ZjVE=
X-Received: by 2002:a17:907:7da2:b0:a9a:6752:ba80 with SMTP id
 a640c23a62f3a-a9de5d6e1dcmr1238064366b.5.1730216728875; Tue, 29 Oct 2024
 08:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-4-raymond.mao@linaro.org>
 <CAFLszTjNB+JZZdKShy6JkR69E2WJE-g=OapC3oThPeT1jLS-zA@mail.gmail.com>
 <CAEfUkUK2a_EixD6zGJfNbhpu1nd9LVxmtjh=ojf0Za9OBbLpGg@mail.gmail.com>
In-Reply-To: <CAEfUkUK2a_EixD6zGJfNbhpu1nd9LVxmtjh=ojf0Za9OBbLpGg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Oct 2024 16:45:14 +0100
Message-ID: <CAFLszTja00UwevuvE8s0+EszHFtnhtk-S6Lzs4WwG=eMEH1y7w@mail.gmail.com>
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

On Mon, 28 Oct 2024 at 20:44, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 28 Oct 2024 at 13:04, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Tue, 22 Oct 2024 at 22:06, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Add sysinfo driver to retrieve smbios information (Type 4 and 7).
>> > So that the smbios library can use it for getting values from the
>> > hardware platform instead of device tree.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - Move the changes to smbios.c instead of creating new file.
>> > - Move the headfile to include dir.
>> > - Combine with #6(v1) patch.
>> > - Clean-up the private data structures.
>> > - Clean-up the operations of the strings and common values.
>> >
>> >  drivers/sysinfo/smbios.c | 228 +++++++++++++++++++++++++++++++++++++++
>> >  include/smbios.h         |  60 +++++++++++
>> >  include/smbios_plat.h    |  79 ++++++++++++++
>> >  include/sysinfo.h        |  95 +++++++++++++++-
>> >  4 files changed, 461 insertions(+), 1 deletion(-)
>> >  create mode 100644 include/smbios_plat.h
>> >
>> > diff --git a/drivers/sysinfo/smbios.c b/drivers/sysinfo/smbios.c
>> > index a7ac8e3f072..3980845b3ba 100644
>> > --- a/drivers/sysinfo/smbios.c
>> > +++ b/drivers/sysinfo/smbios.c
>> > @@ -5,14 +5,240 @@
>> >   */
>> >
>> >  #include <dm.h>
>> > +#include <smbios_plat.h>
>> >  #include <sysinfo.h>
>> >
>> > +/* platform information storage */
>> > +struct processor_info processor_info;
>> > +struct cache_info cache_info[SYSINFO_CACHE_LVL_MAX];
>> > +struct sysinfo_plat sysinfo_smbios_p = {
>> > +       /* Processor Information */
>> > +       .processor = &processor_info,
>> > +       /* Cache Information */
>> > +       .cache = &cache_info[0],
>> > +};
>> > +
>> > +/* structure for smbios private data storage */
>> > +struct sysinfo_plat_priv {
>> > +       struct processor_info *t4;
>> > +       struct smbios_type7 t7[SYSINFO_CACHE_LVL_MAX];
>> > +       u16 cache_handles[SYSINFO_CACHE_LVL_MAX];
>> > +       u8 cache_level;
>> > +};
>> > +
>> > +static void smbios_cache_info_dump(struct smbios_type7 *cache_info)
>> > +{
>> > +       log_debug("SMBIOS Type 7 (Cache Information):\n");
>> > +       log_debug("Cache Configuration: 0x%04x\n", cache_info->config.data);
>> > +       log_debug("Maximum Cache Size: %u KB\n", cache_info->max_size.data);
>> > +       log_debug("Installed Size: %u KB\n", cache_info->inst_size.data);
>> > +       log_debug("Supported SRAM Type: 0x%04x\n",
>>
>> %#04x
>>
>> > +                 cache_info->supp_sram_type.data);
>> > +       log_debug("Current SRAM Type: 0x%04x\n",
>> > +                 cache_info->curr_sram_type.data);
>> > +       log_debug("Cache Speed: %u\n", cache_info->speed);
>> > +       log_debug("Error Correction Type: %u\n", cache_info->err_corr_type);
>> > +       log_debug("System Cache Type: %u\n", cache_info->sys_cache_type);
>> > +       log_debug("Associativity: %u\n", cache_info->associativity);
>> > +       log_debug("Maximum Cache Size 2: %u KB\n", cache_info->max_size2.data);
>> > +       log_debug("Installed Cache Size 2: %u KB\n",
>> > +                 cache_info->inst_size2.data);
>> > +}
>> > +
>> > +/* weak function for the platforms not yet supported */
>> > +__weak int sysinfo_get_cache_info(u8 level, struct cache_info *cache_info)
>> > +{
>> > +       return -ENOSYS;
>> > +}
>> > +
>> > +__weak int sysinfo_get_processor_info(struct processor_info *pinfo)
>> > +{
>> > +       return -ENOSYS;
>> > +}
>> > +
>> > +void sysinfo_cache_info_default(struct cache_info *ci)
>> > +{
>> > +       memset(ci, 0, sizeof(*ci));
>> > +       ci->config.data = SMBIOS_CACHE_LOCATE_UNKNOWN | SMBIOS_CACHE_OP_UND;
>> > +       ci->supp_sram_type.fields.unknown = 1;
>> > +       ci->curr_sram_type.fields.unknown = 1;
>> > +       ci->speed = SMBIOS_CACHE_SPEED_UNKNOWN;
>> > +       ci->err_corr_type = SMBIOS_CACHE_ERRCORR_UNKNOWN;
>> > +       ci->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN;
>> > +}
>> > +
>> > +static int sysinfo_plat_detect(struct udevice *dev)
>> > +{
>> > +       return 0;
>> > +}
>> > +
>> > +static int sysinfo_plat_get_str(struct udevice *dev, int id,
>> > +                               size_t size, char *val)
>> > +{
>> > +       struct sysinfo_plat_priv *priv = dev_get_priv(dev);
>> > +       const char *str = NULL;
>> > +
>> > +       switch (id) {
>> > +       case SYSINFO_ID_SMBIOS_PROCESSOR_MANUFACT:
>>
>> These are getting too long.
>>
>> How about SYSINFOSM_PROC_MANUF ?
>>
>> We can use SYSINFOSM as short for SYSINFO_ID_SMBIOS
>>
> Other existing macros are starting from SYSINFO_ID_, so I guess something
> reasonable can be SYSINFO_ID_SMB_PROC_MANU.

That is certainly better. Perhaps SYSINFO_ID_ should become SYSID_...?

[..]

Regards,
Simon
