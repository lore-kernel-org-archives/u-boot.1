Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34BFC5472D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 17:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62B1788981;
	Mon, 26 Aug 2024 19:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HHAgVduE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D83E88AFA; Mon, 26 Aug 2024 19:59:09 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB488884CA
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 19:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e13e11b23faso4593353276.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724695144; x=1725299944; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=529j67Q71h7Ky0+abzyuPCXB9woNGceBurH4kWAEX9s=;
 b=HHAgVduEaqYmnaEiCTeEKZ46bsKgGip0VkQ3hKLBwhQh5jNvQ4mG3k7GyOreKJv1PS
 7WHHNvwwFUy2aDfi99YLZfrjvV9zi3hcbktMY8oenMHGzcT6NiP/TcA53hEQ5S+5FYb0
 2N2447ab08bFzdBPqQiSmPk8GHT/dhf0cfAic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724695144; x=1725299944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=529j67Q71h7Ky0+abzyuPCXB9woNGceBurH4kWAEX9s=;
 b=vsQ1EXIWmwTIX35cN/1oqMq1j3UyCe0f8zN8okatcNSfXaJWKfM+6igaH3mITqEaec
 qi60niIiUmtDxrtazmaVU1Z/Mhcg670DWQZgedib9ZnfM4F/h22VZO/OWtqO1Q2VCruY
 Hs/HbdmoV5mHN7xO/OWJaKs5XtUg4UcYWVOyMmQ+YxfDl3+FW0Gj82T6klvvdPCfYUop
 RiXgfOKSD4fekKpFLBlmseNhrGoI+scbHWHGGOzsNaRCjpDDDOEBGzVzBbrZN4lL1Ne1
 k9dWIFUv3jcMdqUyToZ8JdoBG6EIYj4T/bzgRjjZVYBnsNEjMSFsaD79UF2c6F1Lyb4F
 4yhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDZc1xvOxc4YbzLG4mbv1+4Ad/QcrvRAIjOUbQpHjOpkNCWzPn+zzYIGQ0ss6CaKH4AaCSaTc=@lists.denx.de
X-Gm-Message-State: AOJu0YyIq9dsVgOVoWzSOTSEIOOI2F0mM4lZFSd1F15FglhAvduP9x6f
 /jz7DUkqidELybRUzQB5ErwfOVkrwJd2D+7AAG24GEsSBACncVKTkvU2sXc2rviIwgEfKiLtYCj
 BAKT+jbAJ29ujrFQRUvZCKjdC4Tqa4h6umJX/
X-Google-Smtp-Source: AGHT+IEzg0pCmXEhAiSVzJenIxvxRoBeEImwl57syP+K8o9YDErFoFy5MV7OZqbHDYYl2LFsUeTSYcA3NITsfzElH38=
X-Received: by 2002:a05:6902:2412:b0:e0b:b85b:b8c3 with SMTP id
 3f1490d57ef6-e17a864f362mr11933890276.39.1724695144551; Mon, 26 Aug 2024
 10:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
In-Reply-To: <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Aug 2024 11:58:54 -0600
Message-ID: <CAFLszTg8gM53pcbHGj-LoA9GDSU-X294_q6ZRnP_QjYFppG0sw@mail.gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Stefan Roese <sr@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>, 
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
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

Hi Caleb,

On Mon, 19 Aug 2024 at 17:03, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> > As a general comment, this is adding a load of code which is used by a
> > lot of platforms. As more and more aarch64 platforms are created, this
> > data grows. Why not use the devicetree for this hardware information?
> > That is what it is for.
>
> This data does not belong in devicetree, the various system registers
> exist to describe this information... Putting it in DT would be
> duplicating it.

I am not wanting to duplicate info which can be read from system registers.

>
> Using DT for this would additionally require having bindings accepted
> upstream and for all SoCs to add them. To what end?

To get the correct information in there. How are boards supposed to
add SMBIOS info? Do we end up creating a whole infra in U-Boot just
for the driver to read it out? It just doesn't make any sense to me...

Let's put hardware info in the DT where it belongs.

>
> That being said, it would maybe be good to know what the size diff is
> with this series before getting into the weeds.
>
> >
> > Some of the information detected makes sense, such as cache setup, but
> > some of it seems like an approximation, or is missing, but suggests it
> > is authoritative.
>
> Could you give some examples?

Here is an excerpt from the patch, you can see various things which
are incorrect or too general.

      .sys.manufacturer = "arm",
+       .sys.prod_name = "arm",
+       .sys.version = "armv8",
+       .sys.sn = "Not Specified",
+       .sys.wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN,
+       .sys.sku_num = "Not Specified",
+       .sys.family = "arm",
+
+       /* Baseboard (or Module) Information */
+       .board.manufacturer = "arm",
+       .board.prod_name = "arm",
+       .board.version = "armv8",
+       .board.sn = "Not Specified",
+       .board.asset_tag = "Not Specified",
+       .board.feature.fields.hosting_board = 1, /* host board */
+       .board.chassis_locat = "Not Specified",
+       .board.type = SMBIOS_BOARD_MOTHERBOARD,
+
+       /* System Enclosure or Chassis Information */
+       .chassis.manufacturer = "arm",
+       .chassis.version = "armv8",
+       .chassis.sn = "Not Specified",
+       .chassis.asset_tag = "Not Specified",
+       .chassis.chassis_type = SMBIOS_ENCLOSURE_DESKTOP,
+       .chassis.bootup_state = SMBIOS_STATE_SAFE,
+       .chassis.power_supply_state = SMBIOS_STATE_SAFE,
+       .chassis.thermal_state = SMBIOS_STATE_SAFE,
+       .chassis.security_status = SMBIOS_SECURITY_NONE,
+       .chassis.oem_defined = SMBIOS_ENCLOSURE_OEM_UND,
+       .chassis.height = SMBIOS_ENCLOSURE_HEIGHT_UND,
+       .chassis.number_of_power_cords = SMBIOS_POWCORD_NUM_UND,
+       .chassis.element_count = ARRAY_SIZE(contained_elements),
+       .chassis.element_record_length = sizeof(contained_elements[0]),
+       .chassis.elements = &contained_elements[0],
+       .chassis.elements_size = sizeof(contained_elements),
+       .chassis.sku_num = "Not Specified",

Regards,
Simon
