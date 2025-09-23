Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8BFCAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 06:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474BB80050;
	Tue, 23 Sep 2025 08:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hVz5m3tD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BABD1833ED; Tue, 23 Sep 2025 08:49:15 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F12B8004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 08:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71d6051afbfso42575587b3.2
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 23:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758610151; x=1759214951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tzf6hDAtM5qrr/bc6M/pMBup+tl8g/X6NmXn/tEK/jE=;
 b=hVz5m3tDfTd0cozIBwbDDorGMEA+suzHYzdW27rIa4Vp3kVMNQ5t8J4Bk0FfQbWZTc
 eNzj35Wh0boxMQ4re3E84T8uv7D0rBhswAvG1t5Qrg+aRuPOZbWbFPrgpYL3LDNYmH9R
 fZIrumQiEpN62rucH+u5ZrFgY5jHOmZKnbtk6/SRzzoK218c8rQXIPfalTlvwdLO0/Zs
 lwz+U6tqxi28y8pzBf4WnK4+KfdkAr6P5kshcf0hq23+QWPHn1q1T5vXJ8H+Rdp6mrL4
 CyZHHOIu0h/xXn9/T8STUQ/U6wIfWjzN8OFmApvg5CfnBhIzdBr/JjwmfwmmLB8WzY1q
 CXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758610151; x=1759214951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tzf6hDAtM5qrr/bc6M/pMBup+tl8g/X6NmXn/tEK/jE=;
 b=vbFmSdhHzXfJVcJ1Wcl+puIkseyTH2meYHpyndcyTjBmWnDrSFzepxwYZML6X6v9Al
 MTxXmTetP1e+39MaQOMY+uf4Er5a3FwEcNvHRfggk2colOIaZ3XFGv25SV1E7PoQv8iT
 VJooAoVwVOpSCxZkxuiEjXdbkTO0Tr9uDeE2GlxZlHOJLl8Nog2wr47njb3HjHm46r1T
 BaGnBYsZZ1RZ2mdtSzVEBd8PsGtn3CkSXTLFRew/zAnIieNvMbYa9Mg7/X7KpvLMbaZ7
 mw6FRUqnSurexf93LEEB8iLkfjAGHzZqKKpHTfymLzZgYUCv3yXyfXWrg9vv+Fz3q4+d
 btPQ==
X-Gm-Message-State: AOJu0YyHFp4gQWmbpiAcbB2mcYkSxREvm4Se6DKUef8K6uY31p9IzygZ
 Xnkbun0JskrAsGCvbPOYduzVSm/KACn6MdycouaLjBmA5UTciosGtFtYWQPIgx96t0ePUo0Kjzk
 Wr2WwrxIqqfple8q2G77VabcgJocYXw1mKVMicNJL+g==
X-Gm-Gg: ASbGncstS31STGKBcfTGKTM45yC2uHWf/A7VkTi9qtYRpFKiMxO5jpJlU4ybzUHU7zG
 uvXvIdmxK2ecGUoqbqDOa8P8j1ChW9rL2C5Oi77wtBtdQjZZbpLFdND6J8F/4bldc/9yxI3iupk
 QjXM0JycMi8b6+kYG2iFWObE48Upyshd9YbrrijetduaJZmi5Rnpp2UHTLperyU4b4TJjY7j7ps
 FAmdAE=
X-Google-Smtp-Source: AGHT+IGSWaukMdKBuUCIdKEj8WRLrNZQdiff0MvG29yayqBWOJYDIHXl41sggMROeRwhDNAjlxvhBz6TmvNKWOWyAm4=
X-Received: by 2002:a05:690c:6704:b0:74e:b54c:49f0 with SMTP id
 00721157ae682-758957ecb40mr12414267b3.19.1758610150930; Mon, 22 Sep 2025
 23:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250919205605.291108-1-raymond.mao@linaro.org>
 <20250919205605.291108-2-raymond.mao@linaro.org>
In-Reply-To: <20250919205605.291108-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Sep 2025 09:48:34 +0300
X-Gm-Features: AS18NWBK4RT5L1cRy37XhZt_3N3bH9ZqRUkM0Ua_0hMsOpIcAugYilBLYchPoeg
Message-ID: <CAC_iWjL0WO8-XMCkW86mwbqO10XYPS2Zjp+v_SebDV_pF+A8rA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] smbios: add support for dynamic generation of Type
 9 system slot tables
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Simon Glass <sjg@chromium.org>, 
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Peng Fan <peng.fan@nxp.com>, Samuel Holland <samuel.holland@sifive.com>
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

On Fri, 19 Sept 2025 at 23:56, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> This commit introduces support for generating SMBIOS Type 9 (System Slot)
> tables using a hybrid approach:
>
> 1. Explicit Device Tree definitions:
>    If the 'smbios' node contains a 'system-slot' subnode, its child nodes
>    will be interpreted as individual slot definitions.
>    - Each child represents a slot (e.g., isa, pcmcia, etc.).
>    - Properties follow the SMBIOS specification using lowercase
>      hyphen-separated names such as 'slot-type', 'slot-id',
>      'segment-group-number', 'bus-number', 'slot-information', etc.
>    - This approach allows full customization of each system slot and is
>      especially suitable for platforms with well-defined slot topology.
>
> 2. Automatic detection fallback:
>    If no 'system-slot' subnode is found under the 'smbios' node, the code
>    will scan the entire device tree for any node whose 'device_type'
>    matches known slot-related types ("pci", "isa", "pcmcia", etc.).
>    - When a match is found, default values or heuristics are applied to
>      populate the System Slot table.
>    - This mode is useful for platforms that lack explicit SMBIOS nodes
>      but still expose slot topology via standard DT conventions.
>
> Together, two approaches ensure that SMBIOS Type 9 entries are available
> whether explicitly described or automatically derived.

This overall looks reasonable to me to enable more types in SMBIOS. It
also follows the logic we have on looking for a system-slot first and
then have the DT as a fallbacl.

Can anyone that's more familiar with the DT probing libraries, take a
look at that part?

Thanks
/Ilias
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2:
> - Reuse sysinfo_to_dt and convert_sysinfo_to_dt() for mapping SMBIOS properties to DT.
> Changes in v3:
> - Update subject and commit message.
> - Abstract helper functions and add callback for writing subnodes.
>
>  arch/arm/dts/smbios_generic.dtsi |   3 +
>  cmd/smbios.c                     | 114 ++++++++++++
>  include/smbios.h                 |  45 +++++
>  include/smbios_def.h             |  89 +++++++++
>  lib/smbios.c                     | 301 ++++++++++++++++++++++++++++++-
>  5 files changed, 549 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/smbios_generic.dtsi b/arch/arm/dts/smbios_generic.dtsi
> index fc168317c9e..4463dade217 100644
> --- a/arch/arm/dts/smbios_generic.dtsi
> +++ b/arch/arm/dts/smbios_generic.dtsi
> @@ -77,6 +77,9 @@
>                                                    SMBIOS_CACHE_OP_WB)>;
>                                 };
>                         };
> +
> +                       system-slot {
> +                       };
>                 };
>         };
>  };
> diff --git a/cmd/smbios.c b/cmd/smbios.c
> index ed419f19028..f9b62e66229 100644
> --- a/cmd/smbios.c
> +++ b/cmd/smbios.c
> @@ -119,6 +119,55 @@ static const struct str_lookup_table associativity_strings[] = {
>
>  };
>
> +static const struct str_lookup_table slot_type_strings[] = {
> +       { SMBIOS_SYSSLOT_TYPE_OTHER,            "Other" },
> +       { SMBIOS_SYSSLOT_TYPE_UNKNOWN,          "Unknown" },
> +       { SMBIOS_SYSSLOT_TYPE_ISA,              "ISA" },
> +       { SMBIOS_SYSSLOT_TYPE_PCI,              "PCI" },
> +       { SMBIOS_SYSSLOT_TYPE_PCMCIA,           "PC Card (PCMCIA)" },
> +       { SMBIOS_SYSSLOT_TYPE_PCIE,             "PCI Express" },
> +       { SMBIOS_SYSSLOT_TYPE_PCIEGEN2,         "PCI Express Gen 2" },
> +       { SMBIOS_SYSSLOT_TYPE_PCIEGEN3,         "PCI Express Gen 3" },
> +       { SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16,      "PCI Express Gen 3 x16" },
> +       { SMBIOS_SYSSLOT_TYPE_PCIEGEN4,         "PCI Express Gen 4" },
> +       { SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8,       "PCI Express Gen 4 x8" },
> +       { SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16,      "PCI Express Gen 4 x16" },
> +};
> +
> +static const struct str_lookup_table slot_bus_width_strings[] = {
> +       { SMBIOS_SYSSLOT_WIDTH_OTHER,   "Other" },
> +       { SMBIOS_SYSSLOT_WIDTH_UNKNOWN, "Unknown" },
> +       { SMBIOS_SYSSLOT_WIDTH_8BIT,    "8 bit" },
> +       { SMBIOS_SYSSLOT_WIDTH_16BIT,   "16 bit" },
> +       { SMBIOS_SYSSLOT_WIDTH_32BIT,   "32 bit" },
> +       { SMBIOS_SYSSLOT_WIDTH_64BIT,   "64 bit" },
> +       { SMBIOS_SYSSLOT_WIDTH_128BIT,  "128 bit " },
> +       { SMBIOS_SYSSLOT_WIDTH_1X,      "1x or x1" },
> +       { SMBIOS_SYSSLOT_WIDTH_2X,      "2x or x2" },
> +       { SMBIOS_SYSSLOT_WIDTH_4X,      "4x or x4" },
> +       { SMBIOS_SYSSLOT_WIDTH_8X,      "8x or x8" },
> +       { SMBIOS_SYSSLOT_WIDTH_12X,     "12x or x12" },
> +       { SMBIOS_SYSSLOT_WIDTH_16X,     "16x or x16" },
> +       { SMBIOS_SYSSLOT_WIDTH_32X,     "32x or x32" },
> +};
> +
> +static const struct str_lookup_table slot_usage_strings[] = {
> +       { SMBIOS_SYSSLOT_USAGE_OTHER,           "Other" },
> +       { SMBIOS_SYSSLOT_USAGE_UNKNOWN,         "Unknown" },
> +       { SMBIOS_SYSSLOT_USAGE_AVAILABLE,       "Available" },
> +       { SMBIOS_SYSSLOT_USAGE_INUSE,           "In use" },
> +       { SMBIOS_SYSSLOT_USAGE_NA,              "Unavailable" },
> +};
> +
> +static const struct str_lookup_table slot_length_strings[] = {
> +       { SMBIOS_SYSSLOT_LENG_OTHER,    "Other" },
> +       { SMBIOS_SYSSLOT_LENG_UNKNOWN,  "Unknown" },
> +       { SMBIOS_SYSSLOT_LENG_SHORT,    "Short Length" },
> +       { SMBIOS_SYSSLOT_LENG_LONG,     "Long Length" },
> +       { SMBIOS_SYSSLOT_LENG_2_5INDRV, "2.5 inch drive form factor" },
> +       { SMBIOS_SYSSLOT_LENG_3_5INDRV, "3.5 inch drive form factor" },
> +};
> +
>  /**
>   * smbios_get_string() - get SMBIOS string from table
>   *
> @@ -403,6 +452,68 @@ static void smbios_print_type7(struct smbios_type7 *table)
>         printf("\tInstalled Cache Size 2: 0x%08x\n", table->inst_size2.data);
>  }
>
> +static void smbios_print_type9(struct smbios_type9 *table)
> +{
> +       int i;
> +       u8 *addr = (u8 *)table +
> +                  offsetof(struct smbios_type9, slot_information);
> +
> +       printf("System Slots:\n");
> +       smbios_print_str("Socket Designation", table,
> +                        table->socket_design);
> +       smbios_print_lookup_str(slot_type_strings,
> +                               table->slot_type,
> +                               ARRAY_SIZE(slot_type_strings),
> +                               "Slot Type");
> +       smbios_print_lookup_str(slot_bus_width_strings,
> +                               table->slot_data_bus_width,
> +                               ARRAY_SIZE(slot_bus_width_strings),
> +                               "Slot Data Bus Width");
> +       smbios_print_lookup_str(slot_usage_strings,
> +                               table->current_usage,
> +                               ARRAY_SIZE(slot_usage_strings),
> +                               "Current Usage");
> +       smbios_print_lookup_str(slot_length_strings,
> +                               table->slot_length,
> +                               ARRAY_SIZE(slot_length_strings),
> +                               "Slot Length");
> +       printf("\tSlot ID: 0x%04x\n", table->slot_id);
> +       printf("\tSlot Characteristics 1: 0x%04x\n",
> +              table->slot_characteristics_1);
> +       printf("\tSlot Characteristics 2: 0x%04x\n",
> +              table->slot_characteristics_2);
> +       printf("\tSegment Group Number (Base): 0x%04x\n",
> +              table->segment_group_number);
> +       printf("\tBus Number (Base): 0x%04x\n", table->bus_number);
> +       printf("\tDevice/Function Number (Base): 0x%04x\n",
> +              table->device_function_number.data);
> +       printf("\tData Bus Width (Base): 0x%04x\n",
> +              table->electrical_bus_width);
> +       printf("\tPeer (S/B/D/F/Width) grouping count: 0x%04x\n",
> +              table->peer_grouping_count);
> +       printf("\tPeer (S/B/D/F/Width) groups:\n");
> +       for (i = 0; i < table->peer_grouping_count; i++) {
> +               printf("\t\tPeer group[%03d]:\n", i);
> +               if (CONFIG_IS_ENABLED(HEXDUMP))
> +                       print_hex_dump("\t\t", DUMP_PREFIX_OFFSET, 16, 1, addr,
> +                                      SMBIOS_TYPE9_PGROUP_SIZE, false);
> +               addr += SMBIOS_TYPE9_PGROUP_SIZE;
> +       }
> +       printf("\n");
> +
> +       /* table->slot_information */
> +       printf("\tSlot Information: 0x%04x\n", *addr);
> +       /* table->slot_physical_width */
> +       addr += sizeof(table->slot_information);
> +       printf("\tSlot Physical Width: 0x%04x\n", *addr);
> +       /* table->slot_pitch */
> +       addr += sizeof(table->slot_physical_width);
> +       printf("\tSlot Pitch: 0x%04x\n", *(u16 *)addr);
> +       /* table->slot_height */
> +       addr += sizeof(table->slot_pitch);
> +       printf("\tSlot Height: 0x%04x\n", *addr);
> +}
> +
>  static void smbios_print_type127(struct smbios_type127 *table)
>  {
>         printf("End Of Table\n");
> @@ -482,6 +593,9 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
>                 case SMBIOS_CACHE_INFORMATION:
>                         smbios_print_type7((struct smbios_type7 *)pos);
>                         break;
> +               case SMBIOS_SYSTEM_SLOTS:
> +                       smbios_print_type9((struct smbios_type9 *)pos);
> +                       break;
>                 case SMBIOS_END_OF_TABLE:
>                         smbios_print_type127((struct smbios_type127 *)pos);
>                         break;
> diff --git a/include/smbios.h b/include/smbios.h
> index b5fed57aba2..d885285ea41 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -264,6 +264,51 @@ struct __packed smbios_type7 {
>         char eos[SMBIOS_STRUCT_EOS_BYTES];
>  };
>
> +#define SMBIOS_TYPE9_PGROUP_SIZE 5
> +
> +struct pci_attr_lookup_table {
> +       const char *str;
> +       u8 slot_type;
> +       u8 data_bus_width;
> +       u8 slot_length;
> +       u8 chara1;
> +       u8 chara2;
> +};
> +
> +union dev_func_num {
> +       struct {
> +               u8 dev_num:5;
> +               u8 func_num:3;
> +       } fields;
> +       u8 data;
> +};
> +
> +struct __packed smbios_type9 {
> +       struct smbios_header hdr;
> +       u8 socket_design;
> +       u8 slot_type;
> +       u8 slot_data_bus_width;
> +       u8 current_usage;
> +       u8 slot_length;
> +       u16 slot_id;
> +       u8 slot_characteristics_1;
> +       u8 slot_characteristics_2;
> +       u16 segment_group_number;
> +       u8 bus_number;
> +       union dev_func_num device_function_number;
> +       u8 electrical_bus_width;
> +       u8 peer_grouping_count;
> +       /*
> +        * Dynamic bytes will be inserted here to store peer_groups.
> +        * length is equal to 'peer_grouping_count' * 5
> +        */
> +       u8 slot_information;
> +       u8 slot_physical_width;
> +       u16 slot_pitch;
> +       u8 slot_height;
> +       char eos[SMBIOS_STRUCT_EOS_BYTES];
> +};
> +
>  struct __packed smbios_type32 {
>         u8 type;
>         u8 length;
> diff --git a/include/smbios_def.h b/include/smbios_def.h
> index 81c5781217f..ef9cb02ed25 100644
> --- a/include/smbios_def.h
> +++ b/include/smbios_def.h
> @@ -191,4 +191,93 @@
>  #define SMBIOS_CACHE_ASSOC_64WAY       13
>  #define SMBIOS_CACHE_ASSOC_20WAY       14
>
> +/*
> + * System Slot
> + */
> +
> +/* Slot Type */
> +#define SMBIOS_SYSSLOT_TYPE_OTHER      1
> +#define SMBIOS_SYSSLOT_TYPE_UNKNOWN    2
> +#define SMBIOS_SYSSLOT_TYPE_ISA                3       /* ISA */
> +#define SMBIOS_SYSSLOT_TYPE_PCI                6       /* PCI */
> +#define SMBIOS_SYSSLOT_TYPE_PCMCIA     7       /* PCMCIA */
> +#define SMBIOS_SYSSLOT_TYPE_PCIE       0xa5    /* PCI Express */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEX1     0xa6    /* PCI Express x1 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEX2     0xa7    /* PCI Express x2 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEX4     0xa8    /* PCI Express x4 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEX8     0xa9    /* PCI Express x8 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEX16    0xaa    /* PCI Express x16 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2   0xab    /* PCI Express Gen 2 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X1 0xac    /* PCI Express Gen 2 x1 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X2 0xad    /* PCI Express Gen 2 x2 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X4 0xae    /* PCI Express Gen 2 x4 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X8 0xaf    /* PCI Express Gen 2 x8 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X16        0xb0    /* PCI Express Gen 2 x16 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3   0xb1    /* PCI Express Gen 3 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X1 0xb2    /* PCI Express Gen 3 x1 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X2 0xb3    /* PCI Express Gen 3 x2 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X4 0xb4    /* PCI Express Gen 3 x4 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X8 0xb5    /* PCI Express Gen 3 x8 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16        0xb6    /* PCI Express Gen 3 x16 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4   0xb8    /* PCI Express Gen 4 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X1 0xb9    /* PCI Express Gen 4 x1 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X2 0xba    /* PCI Express Gen 4 x2 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X4 0xbb    /* PCI Express Gen 4 x4 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8 0xbc    /* PCI Express Gen 4 x8 */
> +#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16        0xbd    /* PCI Express Gen 4 x16 */
> +
> +/* Slot Data Bus Width */
> +#define SMBIOS_SYSSLOT_WIDTH_OTHER     1
> +#define SMBIOS_SYSSLOT_WIDTH_UNKNOWN   2
> +#define SMBIOS_SYSSLOT_WIDTH_8BIT      3
> +#define SMBIOS_SYSSLOT_WIDTH_16BIT     4
> +#define SMBIOS_SYSSLOT_WIDTH_32BIT     5
> +#define SMBIOS_SYSSLOT_WIDTH_64BIT     6
> +#define SMBIOS_SYSSLOT_WIDTH_128BIT    7
> +#define SMBIOS_SYSSLOT_WIDTH_1X                8
> +#define SMBIOS_SYSSLOT_WIDTH_2X                9
> +#define SMBIOS_SYSSLOT_WIDTH_4X                10
> +#define SMBIOS_SYSSLOT_WIDTH_8X                11
> +#define SMBIOS_SYSSLOT_WIDTH_12X       12
> +#define SMBIOS_SYSSLOT_WIDTH_16X       13
> +#define SMBIOS_SYSSLOT_WIDTH_32X       14
> +
> +/* Current Usage */
> +#define SMBIOS_SYSSLOT_USAGE_OTHER     1
> +#define SMBIOS_SYSSLOT_USAGE_UNKNOWN   2
> +#define SMBIOS_SYSSLOT_USAGE_AVAILABLE 3
> +#define SMBIOS_SYSSLOT_USAGE_INUSE     4
> +#define SMBIOS_SYSSLOT_USAGE_NA                5
> +
> +/* Slot Length */
> +#define SMBIOS_SYSSLOT_LENG_OTHER      1
> +#define SMBIOS_SYSSLOT_LENG_UNKNOWN    2
> +#define SMBIOS_SYSSLOT_LENG_SHORT      3
> +#define SMBIOS_SYSSLOT_LENG_LONG       4
> +#define SMBIOS_SYSSLOT_LENG_2_5INDRV   5
> +#define SMBIOS_SYSSLOT_LENG_3_5INDRV   6
> +
> +/*  Slot Characteristics 1 */
> +#define SMBIOS_SYSSLOT_CHAR_UND                1 /* BIT(0) */
> +#define SMBIOS_SYSSLOT_CHAR_5V         2 /* BIT(1) */
> +#define SMBIOS_SYSSLOT_CHAR_3_3V       4 /* BIT(2) */
> +#define SMBIOS_SYSSLOT_CHAR_SHARED     8 /* BIT(3) */
> +#define SMBIOS_SYSSLOT_CHAR_PCCARD16   16 /* BIT(4) */
> +#define SMBIOS_SYSSLOT_CHAR_PCCARDBUS  32 /* BIT(5) */
> +#define SMBIOS_SYSSLOT_CHAR_PCCARDZV   64 /* BIT(6) */
> +#define SMBIOS_SYSSLOT_CHAR_PCCARDMRR  0x80 /* BIT(7) */
> +
> +/* Slot Characteristics 2 */
> +#define SMBIOS_SYSSLOT_CHAR_PCIPME     1 /* BIT(0) */
> +#define SMBIOS_SYSSLOT_CHAR_HOTPLUG    2 /* BIT(1) */
> +#define SMBIOS_SYSSLOT_CHAR_PCISMB     4 /* BIT(2) */
> +#define SMBIOS_SYSSLOT_CHAR_PCIBIF     8 /* BIT(3) */
> +#define SMBIOS_SYSSLOT_CHAR_ASYNCRM    16 /* BIT(4) */
> +#define SMBIOS_SYSSLOT_CHAR_FBCXL1     32 /* BIT(5) */
> +#define SMBIOS_SYSSLOT_CHAR_FBCXL2     64 /* BIT(6) */
> +#define SMBIOS_SYSSLOT_CHAR_FBCXL3     0x80 /* BIT(7) */
> +
> +/* Slot segment group number */
> +#define SMBIOS_SYSSLOT_SGGNUM_UND      0
> +
>  #endif /* _SMBIOS_DEF_H_ */
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 85508c06547..caeb309294d 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -66,11 +66,47 @@ struct map_sysinfo {
>
>  static const struct map_sysinfo sysinfo_to_dt[] = {
>         { .si_node = "system", .si_str = "product", .dt_str = "model", 2 },
> -       { .si_node = "system", .si_str = "manufacturer", .dt_str = "compatible", 1 },
> -       { .si_node = "baseboard", .si_str = "product", .dt_str = "model", 2 },
> -       { .si_node = "baseboard", .si_str = "manufacturer", .dt_str = "compatible", 1 },
> +       { .si_node = "system", .si_str = "manufacturer",
> +         .dt_str = "compatible", 1 },
> +       { .si_node = "baseboard", .si_str = "product",
> +         .dt_str = "model", 2 },
> +       { .si_node = "baseboard", .si_str = "manufacturer",
> +         .dt_str = "compatible", 1 },
> +       { .si_node = "system-slot", .si_str = "slot-type",
> +         .dt_str = "device_type", 0},
> +       { .si_node = "system-slot", .si_str = "segment-group-number",
> +         .dt_str = "linux,pci-domain", 0},
>  };
>
> +#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
> +static const struct pci_attr_lookup_table pci_attr[] = {
> +       { "pci-host-ecam-generic", SMBIOS_SYSSLOT_TYPE_PCIE,
> +         SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
> +         SMBIOS_SYSSLOT_CHAR_3_3V, SMBIOS_SYSSLOT_CHAR_PCIPME },
> +       { "pci-host-cam-generic", SMBIOS_SYSSLOT_TYPE_PCI,
> +         SMBIOS_SYSSLOT_WIDTH_32BIT, SMBIOS_SYSSLOT_LENG_SHORT,
> +         SMBIOS_SYSSLOT_CHAR_5V | SMBIOS_SYSSLOT_CHAR_3_3V,
> +         SMBIOS_SYSSLOT_CHAR_PCIPME },
> +       { "pci-host-thunder-ecam", SMBIOS_SYSSLOT_TYPE_PCIEGEN3,
> +         SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
> +         SMBIOS_SYSSLOT_CHAR_3_3V,
> +         SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
> +       { "pci-host-octeontx-ecam", SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16,
> +         SMBIOS_SYSSLOT_WIDTH_16X, SMBIOS_SYSSLOT_LENG_LONG,
> +         SMBIOS_SYSSLOT_CHAR_3_3V,
> +         SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
> +       { "pci-host-thunder-pem", SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8,
> +         SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
> +         SMBIOS_SYSSLOT_CHAR_3_3V,
> +         SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
> +       { "pci-host-octeontx2-pem", SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16,
> +         SMBIOS_SYSSLOT_WIDTH_16X, SMBIOS_SYSSLOT_LENG_LONG,
> +         SMBIOS_SYSSLOT_CHAR_3_3V,
> +         SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG |
> +         SMBIOS_SYSSLOT_CHAR_PCIBIF },
> +};
> +#endif
> +
>  /**
>   * struct smbios_ctx - context for writing SMBIOS tables
>   *
> @@ -95,6 +131,10 @@ struct smbios_ctx {
>         char *last_str;
>  };
>
> +typedef int (*smbios_write_subnode)(ulong *current, int handle,
> +                                  struct smbios_ctx *ctx, int idx,
> +                                  int type);
> +
>  /**
>   * Function prototype to write a specific type of SMBIOS structure
>   *
> @@ -222,6 +262,7 @@ static int smbios_get_val_si(struct smbios_ctx * __maybe_unused ctx,
>  {
>  #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
>         int val;
> +       const struct map_sysinfo *nprop;
>
>         if (!ctx->dev)
>                 return val_def;
> @@ -240,6 +281,11 @@ static int smbios_get_val_si(struct smbios_ctx * __maybe_unused ctx,
>          */
>         if (!ofnode_read_u32(ofnode_root(), prop, &val))
>                 return val;
> +
> +       /* If the node is still missing, try with the mapping values */
> +       nprop = convert_sysinfo_to_dt(ctx->subnode_name, prop);
> +       if (!ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
> +               return val;
>  #endif
>         return val_def;
>  }
> @@ -859,6 +905,252 @@ static int smbios_write_type7(ulong *current, int *handle,
>         return len;
>  }
>
> +static int smbios_scan_subnodes(ulong *current, struct smbios_ctx *ctx,
> +                               int *handle, smbios_write_subnode cb, int type)
> +{
> +       ofnode child;
> +       int i;
> +       int hdl_base = *handle;
> +       int len = 0;
> +       struct smbios_ctx ctx_bak;
> +
> +       memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
> +
> +       for (i = 0, child = ofnode_first_subnode(ctx->node);
> +            ofnode_valid(child); child = ofnode_next_subnode(child), i++) {
> +               ctx->node = child;
> +               *handle = hdl_base + i;
> +               len += cb(current, *handle, ctx, i, type);
> +               memcpy(ctx, &ctx_bak, sizeof(*ctx));
> +       }
> +
> +       return len;
> +}
> +
> +static void smbios_lookup_pci_attr(struct smbios_ctx *ctx,
> +                                  struct smbios_type9 *t)
> +{
> +       const char *compatible;
> +       u32 addr_cells, size_cells, total_cells;
> +       const fdt32_t *reg;
> +       int reglen;
> +       int i;
> +
> +       /* default attributes */
> +       t->slot_type = SMBIOS_SYSSLOT_TYPE_PCI;
> +       t->slot_data_bus_width = SMBIOS_SYSSLOT_WIDTH_UNKNOWN;
> +       t->slot_characteristics_1 = SMBIOS_SYSSLOT_CHAR_UND;
> +       t->current_usage = SMBIOS_SYSSLOT_USAGE_UNKNOWN;
> +       t->slot_length = SMBIOS_SYSSLOT_LENG_UNKNOWN;
> +       t->segment_group_number = smbios_get_val_si(ctx, "segment-group-number",
> +                                                   SYSID_NONE,
> +                                                   SMBIOS_SYSSLOT_SGGNUM_UND);
> +
> +       /*
> +        * Get #address-cells and #size-cells dynamically
> +        * Default 3 for #address-cells and 2 for #size-cells
> +        */
> +       addr_cells = ofnode_read_u32_default(ctx->node, "#address-cells", 3);
> +       size_cells = ofnode_read_u32_default(ctx->node, "#size-cells", 2);
> +       total_cells = addr_cells + size_cells;
> +
> +       /* Read property 'reg' from the node */
> +       reg = ofnode_read_prop(ctx->node, "reg", &reglen);
> +       if (reg && reglen > addr_cells * sizeof(*reg)) {
> +               /* First address-cell: Bus Number */
> +               if (addr_cells >= 1)
> +                       t->bus_number = fdt32_to_cpu(reg[0]);
> +               /* Second address-cell: Device/Function */
> +               if (addr_cells >= 2)
> +                       t->device_function_number.data = fdt32_to_cpu(reg[1]);
> +               /*
> +                * Third address-cell 'Register Offset' and the following
> +                * size-cell bytes are not useful for SMBIOS type 9, just
> +                * ignore them.
> +                */
> +               /*
> +                * As neither PCI IRQ Routing Table ($PIRQ) nor FDT
> +                * property to represent a Slot ID, try to derive a
> +                * Slot ID programmatically.
> +                */
> +               t->slot_id = t->device_function_number.fields.dev_num |
> +                            (t->bus_number << 5);
> +       }
> +
> +       /* Read 'compatible' property */
> +       compatible = ofnode_read_string(ctx->node, "compatible");
> +       if (!compatible)
> +               return;
> +
> +       for (i = 0; i < ARRAY_SIZE(pci_attr); i++) {
> +               if (strstr(compatible, pci_attr[i].str)) {
> +                       t->slot_type = pci_attr[i].slot_type;
> +                       t->slot_data_bus_width = pci_attr[i].data_bus_width;
> +                       t->slot_length = pci_attr[i].slot_length;
> +                       t->slot_characteristics_1 = pci_attr[i].chara1;
> +                       t->slot_characteristics_2 = pci_attr[i].chara2;
> +                       /* mark it as in-use arbitrarily */
> +                       t->current_usage = SMBIOS_SYSSLOT_USAGE_INUSE;
> +                       return;
> +               }
> +       }
> +}
> +
> +static void smbios_write_type9_fields(struct smbios_ctx *ctx,
> +                                     struct smbios_type9 *t)
> +{
> +       t->slot_type = smbios_get_val_si(ctx, "slot-type", SYSID_NONE,
> +                                        SMBIOS_SYSSLOT_TYPE_UNKNOWN);
> +       t->slot_data_bus_width =
> +               smbios_get_val_si(ctx, "data-bus-width",
> +                                 SYSID_NONE, SMBIOS_SYSSLOT_WIDTH_UNKNOWN);
> +       t->current_usage = smbios_get_val_si(ctx, "current-usage", SYSID_NONE,
> +                                            SMBIOS_SYSSLOT_USAGE_UNKNOWN);
> +       t->slot_length = smbios_get_val_si(ctx, "slot-length", SYSID_NONE,
> +                                          SMBIOS_SYSSLOT_LENG_UNKNOWN);
> +       t->slot_id = smbios_get_val_si(ctx, "slot-id", SYSID_NONE, 0);
> +       t->slot_characteristics_1 =
> +               smbios_get_val_si(ctx, "slot-characteristics-1", SYSID_NONE,
> +                                 SMBIOS_SYSSLOT_CHAR_UND);
> +       t->slot_characteristics_2 = smbios_get_val_si(ctx,
> +                                                     "slot-characteristics-2",
> +                                                     SYSID_NONE, 0);
> +       t->segment_group_number = smbios_get_val_si(ctx, "segment-group-number",
> +                                                   SYSID_NONE, 0);
> +       t->bus_number = smbios_get_val_si(ctx, "bus-number", SYSID_NONE, 0);
> +       t->device_function_number.data =
> +               smbios_get_val_si(ctx, "device-function-number", SYSID_NONE, 0);
> +}
> +
> +static int smbios_write_type9_1slot(ulong *current, int handle,
> +                                   struct smbios_ctx *ctx,
> +                                   int __maybe_unused idx, int devtype)
> +{
> +       struct smbios_type9 *t;
> +       int len = sizeof(*t);
> +       u8 pgroups_cnt;
> +       u8 *eos_addr;
> +       size_t pgroups_size;
> +       void *wp;
> +
> +       pgroups_cnt = smbios_get_val_si(ctx, "peer-grouping-count",
> +                                       SYSID_NONE, 0);
> +       pgroups_size = pgroups_cnt * SMBIOS_TYPE9_PGROUP_SIZE;
> +
> +       /*
> +        * reserve the space for the dynamic bytes of peer_groups.
> +        * TODO:
> +        * peer_groups = <peer_grouping_count> * SMBIOS_TYPE9_PGROUP_SIZE
> +        */
> +       len += pgroups_size;
> +
> +       t = map_sysmem(*current, len);
> +       memset(t, 0, len);
> +
> +       fill_smbios_header(t, SMBIOS_SYSTEM_SLOTS, len, handle);
> +
> +       /* eos is at the end of the structure */
> +       eos_addr = (u8 *)t + len - sizeof(t->eos);
> +       smbios_set_eos(ctx, eos_addr);
> +
> +       /* Write the general fields */
> +       t->peer_grouping_count = pgroups_cnt;
> +       t->socket_design = smbios_add_prop_si(ctx, "socket-design", SYSID_NONE,
> +                                             NULL);
> +       t->electrical_bus_width = smbios_get_val_si(ctx, "data-bus-width",
> +                                                   SYSID_NONE, 0);
> +
> +       /* skip the reserved peer groups and write the following fields from eos */
> +       /* t->slot_height */
> +       wp = eos_addr - sizeof(t->slot_height);
> +       *((u8 *)wp) = smbios_get_val_si(ctx, "slot-height", SYSID_NONE, 0);
> +       /* t->slot_pitch */
> +       wp -= sizeof(t->slot_pitch);
> +       *((u16 *)wp) = smbios_get_val_si(ctx, "slot-pitch", SYSID_NONE, 0);
> +       /* t->slot_physical_width */
> +       wp -= sizeof(t->slot_physical_width);
> +       *((u8 *)wp) = smbios_get_val_si(ctx, "slot-physical-width", SYSID_NONE, 0);
> +       /* t->slot_information */
> +       wp -= sizeof(t->slot_information);
> +       *((u8 *)wp) = smbios_get_val_si(ctx, "slot-information", SYSID_NONE, 0);
> +
> +       /* For PCI, some fields can be extracted from FDT node */
> +       if (devtype == SMBIOS_SYSSLOT_TYPE_PCI)
> +               /* Populate PCI attributes from existing PCI properties */
> +               smbios_lookup_pci_attr(ctx, t);
> +       else if (devtype == SMBIOS_SYSSLOT_TYPE_UNKNOWN) {
> +               /* Properties that expected in smbios subnode 'system-slot' */
> +               smbios_write_type9_fields(ctx, t);
> +       }
> +       len = t->hdr.length + smbios_string_table_len(ctx);
> +       *current += len;
> +       unmap_sysmem(t);
> +
> +       return len;
> +}
> +
> +static int smbios_scan_slot_type(ulong *current, int *handle,
> +                                struct smbios_ctx *ctx)
> +{
> +       int i = 0;
> +       struct smbios_ctx ctx_bak;
> +       ofnode child;
> +       const struct map_sysinfo *prop;
> +       int hdl_base = *handle;
> +       int len = 0;
> +
> +       memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
> +       prop = convert_sysinfo_to_dt(ctx->subnode_name, "slot-type");
> +       for (child = ofnode_first_subnode(ofnode_root()); ofnode_valid(child);
> +            child = ofnode_next_subnode(child)) {
> +               const char *dev_type_str;
> +               u8 dev_type = SMBIOS_SYSSLOT_TYPE_UNKNOWN;
> +
> +               dev_type_str = ofnode_read_string(child, prop->dt_str);
> +               if (!dev_type_str)
> +                       continue;
> +
> +               if (!strcmp(dev_type_str, "pci"))
> +                       dev_type = SMBIOS_SYSSLOT_TYPE_PCI;
> +               else if (!strcmp(dev_type_str, "isa"))
> +                       dev_type = SMBIOS_SYSSLOT_TYPE_ISA;
> +               else if (!strcmp(dev_type_str, "pcmcia"))
> +                       dev_type = SMBIOS_SYSSLOT_TYPE_PCMCIA;
> +               else
> +                       continue;
> +
> +               *handle = hdl_base + i;
> +               ctx->node = child;
> +               len += smbios_write_type9_1slot(current, *handle, ctx, 0,
> +                                               dev_type);
> +               memcpy(ctx, &ctx_bak, sizeof(*ctx));
> +               i++;
> +       }
> +
> +       return len;
> +}
> +
> +static int smbios_write_type9(ulong *current, int *handle,
> +                             struct smbios_ctx *ctx)
> +{
> +       int len;
> +
> +       /* TODO: Get system slot information via pci subsystem */
> +       if (!IS_ENABLED(CONFIG_OF_CONTROL))
> +               return 0;       /* Error, return 0-length */
> +
> +       len = smbios_scan_subnodes(current, ctx, handle,
> +                                  smbios_write_type9_1slot,
> +                                  SMBIOS_SYSSLOT_TYPE_UNKNOWN);
> +       if (len)
> +               return len;
> +
> +       /* if no subnode under 'system-slot', try scan the entire FDT */
> +       len = smbios_scan_slot_type(current, handle, ctx);
> +
> +       return len;
> +}
> +
>  #endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
>
>  static int smbios_write_type32(ulong *current, int *handle,
> @@ -905,6 +1197,9 @@ static struct smbios_write_method smbios_write_funcs[] = {
>         { smbios_write_type7, "cache", },
>  #endif
>         { smbios_write_type4, "processor"},
> +#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
> +       { smbios_write_type9, "system-slot"},
> +#endif
>         { smbios_write_type32, },
>         { smbios_write_type127 },
>  };
> --
> 2.25.1
>
