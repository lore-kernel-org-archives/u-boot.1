Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A235C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 14:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55041828BC;
	Thu,  8 May 2025 16:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wZ+F5wck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E36F82905; Thu,  8 May 2025 16:55:12 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D9A828A2
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 16:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30ac24ede15so1488867a91.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746716108; x=1747320908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bCFi7yG8m8cfHefM6rF+6WPMs+9wn5blsSDvwPV5jDY=;
 b=wZ+F5wckOMGRL+Uh9MuqqGNDWx6Brb7zqLonw7NyNjLr34h3Zonp03uHWj013krb9Z
 IwKlZhShhbYDPHeKUDTdIvE4PMypv/0Vh3SAhwnvYIR4QW1dmI15U9fpbrFBLdKZVApS
 VTolvKCsdNYzKbbVD2NryrA6waqQR7L9eowDJzqRgCDP3vBi8P7QMhsXgSKimFI1ZVU/
 6J/ndXl+e9v3hY+Y7x9U3co2n4/FejOX6UcKP77ueM16ssVoNJdW1fLeuK/Un/C9nulq
 Grm84bOB6P8kG6/leaYQfr1x+TAs04c6VuFfhioAxfh8XrJTuElTgL/KPtSBdhlz0vRg
 UhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746716108; x=1747320908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bCFi7yG8m8cfHefM6rF+6WPMs+9wn5blsSDvwPV5jDY=;
 b=mvE099Zcc0xNKEO1fSXAG05yfq9UlP1giJCW7gVfRX1Am4WhGxx9mW1lIxRBwEr/pv
 S3Goqm8vYN5YAmf1HQpzyfhjnxJOQrvRVh01YCef62pLcDfEYZ0ZrkYCXqsI3RHSTz93
 iVSGz3KXuCqVHot+OoEDXUYILgYSc2w3AtaJj/cRVZ2Aqth+jRCUwCXqY4z1/rm/Aglq
 +e467v1r2NBXqcCTaSNbHHGTSnDNeVXsNOeN0MkfLLjQcKh6BoPy5MBUWuLse2poC56p
 n/DKYcDAp8pnEzedcwSk7lYjzThlaW4YIh/eyDKYqocyvB8WID5ujHdFJjCc2xENg3II
 yEFg==
X-Gm-Message-State: AOJu0Ywr2zuodj1ZdnvVctS2ydn1PEg31m+vQiDiT64tD3WqBYVAxCtq
 GiVlL/PPF3Joxfc8Bx/lfaUHJPs1LjTZRvO5+ZkplnLCovpcvQj67G3rhSwrjZnU06RGgXIe/vK
 kTcLo7bvw5ek3SY3ffM2GOD+UvUFnFEHIkmtc4Q==
X-Gm-Gg: ASbGncvRIAS9vMKoAUbmyb12Yau3zA3EODEHM7ltGCqEk/Nj5yDsTye8QRHky18NSZ0
 0BIzKao8Lq+GHuX27hu39Oezwoeg/YhbfEEokOrE6widxuhkRmGcwhDtMOf7SqmnD0Vacdxwrn5
 nL+lCpMBoqBVnBknQLhK4lmp4F
X-Google-Smtp-Source: AGHT+IHe0PWVeG/bue2If74jGfKj5FCmZbeVRYeJI+kKI7smCQbihY8/lwf2C2OsIaqWUdnH3gTzkIhLluNcVPkZSr4=
X-Received: by 2002:a17:90b:1d09:b0:2ff:7c2d:6ff3 with SMTP id
 98e67ed59e1d1-30aac257b1dmr12233321a91.35.1746716107461; Thu, 08 May 2025
 07:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250508141042.254447-1-raymond.mao@linaro.org>
 <39635794-E9FD-40D2-82B9-EC93F8D4734A@gmx.de>
In-Reply-To: <39635794-E9FD-40D2-82B9-EC93F8D4734A@gmx.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 8 May 2025 10:54:55 -0400
X-Gm-Features: ATxdqUHdkb5nUTeKRSwR4SLWNSG6NLzu73Su9x8aqe6AsPtnGrrkZi_MJq4_X1g
Message-ID: <CAEfUkUJgTH0TsdY9M0YcY_5RpVOUQLZ5BUGfPiz8p1RrRvJ+GA@mail.gmail.com>
Subject: Re: [PATCH v2] smbios: add support for type 9 system slot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>, 
 Baocheng Su <baocheng.su@siemens.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
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

Hi Heinrich,

On Thu, 8 May 2025 at 10:27, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 8. Mai 2025 16:10:33 MESZ schrieb Raymond Mao <raymond.mao@linaro.org>:
> >Implement SMBIOS Type 9 (System Slot).
> >SMBIOS library will look for a subnode "system-slot" under
> >"smbios" to construct the data of Type 9.
> >[1] is an example for the expected pattern of "system-slot".
> >
>
>
> The value of type 9 information comes with the information if a slot occupied.
>
> I can't see any code determining the actual usage. So what is the point of this patch?
>
It loads properties from smbios-sysinfo subnode system-slot if any
custom values exist, similarly as what we did for Type 1, 4, 7.
If no properties exist under the system-slot subnode, as a fallback
the library scans the entire device tree and converts the properties
as possible, which is the default approach as I leave the system-slot
node empty.
Many of the Type 9 properties are vendor-specific so I expect a vendor
to fill the system-slot subnode following the example in my commit
message, while the fallback can still provide the basic Type 9
information.

Regards,
Raymond

> Best regards
>
> Heinrich
>
>
> >If "system-slot" node does not exist, or any of its properties
> >are missing, as a fallback, SMBIOS library will try to get the
> >values by scanning the device tree.
> >
> >SMBIOS Type 9 support is under GENERATE_SMBIOS_TABLE_VERBOSE to
> >avoid increasing rom size for those platforms which only require
> >basic SMBIOS support.
> >
> >[1] Example of a "system-slot" node which contains two slots:
> >    system-slot {
> >        isa {
> >            socket-design = "";
> >            slot-type = <SMBIOS_SYSSLOT_TYPE_ISA>;
> >            slot-data-bus-width =
> >            <SMBIOS_SYSSLOT_WIDTH_16BIT>;
> >            current-usage = <SMBIOS_SYSSLOT_USAGE_NA>;
> >            slot-length = <SMBIOS_SYSSLOT_LENG_SHORT>;
> >            slot-id = <0>;
> >            slot-characteristics-1 = <(SMBIOS_SYSSLOT_CHAR_5V |
> >                                       SMBIOS_SYSSLOT_CHAR_3_3V)>;
> >            slot-characteristics-2 = <SMBIOS_SYSSLOT_CHAR_ASYNCRM>;
> >            segment-group-number = <0>;
> >            bus-number = <0x80>;
> >            device-function-number = <0x10>;
> >            data-bus-width = <0>;
> >            peer-grouping-count = <0>;
> >            slot-information = <0>;
> >            slot-physical-width = <0>;
> >            slot-characteristics-1 = <(SMBIOS_SYSSLOT_CHAR_5V |
> >                                       SMBIOS_SYSSLOT_CHAR_3_3V)>;
> >            slot-characteristics-2 = <SMBIOS_SYSSLOT_CHAR_ASYNCRM>;
> >            segment-group-number = <0>;
> >            bus-number = <0x80>;
> >            device-function-number = <0x10>;
> >            data-bus-width = <0>;
> >            peer-grouping-count = <0>;
> >            slot-information = <0>;
> >            slot-physical-width = <0>;
> >            slot-pitch = <0>;
> >            slot-height = <0>;
> >        };
> >        pcmcia {
> >            socket-design = "";
> >            slot-type = <SMBIOS_SYSSLOT_TYPE_PCMCIA>;
> >            slot-data-bus-width = <SMBIOS_SYSSLOT_WIDTH_32BIT>;
> >            current-usage = <SMBIOS_SYSSLOT_USAGE_AVAILABLE>;
> >            slot-length = <SMBIOS_SYSSLOT_LENG_SHORT>;
> >            slot-id = <1>;
> >            slot-characteristics-1 = <(SMBIOS_SYSSLOT_CHAR_5V |
> >                                       SMBIOS_SYSSLOT_CHAR_3_3V)>;
> >            slot-characteristics-2 = <SMBIOS_SYSSLOT_CHAR_ASYNCRM>;
> >            segment-group-number = <1>;
> >            bus-number = <0xa0>;
> >            device-function-number = <0x40>;
> >            data-bus-width = <0>;
> >            peer-grouping-count = <0>;
> >            slot-information = <0>;
> >            slot-physical-width = <0>;
> >            slot-pitch = <0>;
> >            slot-height = <0>;
> >        };
> >    };
> >
> >Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >---
> >Changes in v2:
> >- Reuse sysinfo_to_dt and convert_sysinfo_to_dt() for mapping SMBIOS properties to DT.
> >
> > arch/arm/dts/smbios_generic.dtsi |   3 +
> > cmd/smbios.c                     | 114 +++++++++++++
> > include/smbios.h                 |  45 ++++++
> > include/smbios_def.h             |  89 +++++++++++
> > lib/smbios.c                     | 267 ++++++++++++++++++++++++++++++-
> > 5 files changed, 515 insertions(+), 3 deletions(-)
> >
> >diff --git a/arch/arm/dts/smbios_generic.dtsi b/arch/arm/dts/smbios_generic.dtsi
> >index fc168317c9e..4463dade217 100644
> >--- a/arch/arm/dts/smbios_generic.dtsi
> >+++ b/arch/arm/dts/smbios_generic.dtsi
> >@@ -77,6 +77,9 @@
> >                                                  SMBIOS_CACHE_OP_WB)>;
> >                               };
> >                       };
> >+
> >+                      system-slot {
> >+                      };
> >               };
> >       };
> > };
> >diff --git a/cmd/smbios.c b/cmd/smbios.c
> >index 562dd7959be..127e89ca914 100644
> >--- a/cmd/smbios.c
> >+++ b/cmd/smbios.c
> >@@ -119,6 +119,55 @@ static const struct str_lookup_table associativity_strings[] = {
> >
> > };
> >
> >+static const struct str_lookup_table slot_type_strings[] = {
> >+      { SMBIOS_SYSSLOT_TYPE_OTHER,            "Other" },
> >+      { SMBIOS_SYSSLOT_TYPE_UNKNOWN,          "Unknown" },
> >+      { SMBIOS_SYSSLOT_TYPE_ISA,              "ISA" },
> >+      { SMBIOS_SYSSLOT_TYPE_PCI,              "PCI" },
> >+      { SMBIOS_SYSSLOT_TYPE_PCMCIA,           "PC Card (PCMCIA)" },
> >+      { SMBIOS_SYSSLOT_TYPE_PCIE,             "PCI Express" },
> >+      { SMBIOS_SYSSLOT_TYPE_PCIEGEN2,         "PCI Express Gen 2" },
> >+      { SMBIOS_SYSSLOT_TYPE_PCIEGEN3,         "PCI Express Gen 3" },
> >+      { SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16,      "PCI Express Gen 3 x16" },
> >+      { SMBIOS_SYSSLOT_TYPE_PCIEGEN4,         "PCI Express Gen 4" },
> >+      { SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8,       "PCI Express Gen 4 x8" },
> >+      { SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16,      "PCI Express Gen 4 x16" },
> >+};
> >+
> >+static const struct str_lookup_table slot_bus_width_strings[] = {
> >+      { SMBIOS_SYSSLOT_WIDTH_OTHER,   "Other" },
> >+      { SMBIOS_SYSSLOT_WIDTH_UNKNOWN, "Unknown" },
> >+      { SMBIOS_SYSSLOT_WIDTH_8BIT,    "8 bit" },
> >+      { SMBIOS_SYSSLOT_WIDTH_16BIT,   "16 bit" },
> >+      { SMBIOS_SYSSLOT_WIDTH_32BIT,   "32 bit" },
> >+      { SMBIOS_SYSSLOT_WIDTH_64BIT,   "64 bit" },
> >+      { SMBIOS_SYSSLOT_WIDTH_128BIT,  "128 bit " },
> >+      { SMBIOS_SYSSLOT_WIDTH_1X,      "1x or x1" },
> >+      { SMBIOS_SYSSLOT_WIDTH_2X,      "2x or x2" },
> >+      { SMBIOS_SYSSLOT_WIDTH_4X,      "4x or x4" },
> >+      { SMBIOS_SYSSLOT_WIDTH_8X,      "8x or x8" },
> >+      { SMBIOS_SYSSLOT_WIDTH_12X,     "12x or x12" },
> >+      { SMBIOS_SYSSLOT_WIDTH_16X,     "16x or x16" },
> >+      { SMBIOS_SYSSLOT_WIDTH_32X,     "32x or x32" },
> >+};
> >+
> >+static const struct str_lookup_table slot_usage_strings[] = {
> >+      { SMBIOS_SYSSLOT_USAGE_OTHER,           "Other" },
> >+      { SMBIOS_SYSSLOT_USAGE_UNKNOWN,         "Unknown" },
> >+      { SMBIOS_SYSSLOT_USAGE_AVAILABLE,       "Available" },
> >+      { SMBIOS_SYSSLOT_USAGE_INUSE,           "In use" },
> >+      { SMBIOS_SYSSLOT_USAGE_NA,              "Unavailable" },
> >+};
> >+
> >+static const struct str_lookup_table slot_length_strings[] = {
> >+      { SMBIOS_SYSSLOT_LENG_OTHER,    "Other" },
> >+      { SMBIOS_SYSSLOT_LENG_UNKNOWN,  "Unknown" },
> >+      { SMBIOS_SYSSLOT_LENG_SHORT,    "Short Length" },
> >+      { SMBIOS_SYSSLOT_LENG_LONG,     "Long Length" },
> >+      { SMBIOS_SYSSLOT_LENG_2_5INDRV, "2.5 inch drive form factor" },
> >+      { SMBIOS_SYSSLOT_LENG_3_5INDRV, "3.5 inch drive form factor" },
> >+};
> >+
> > /**
> >  * smbios_get_string() - get SMBIOS string from table
> >  *
> >@@ -403,6 +452,68 @@ static void smbios_print_type7(struct smbios_type7 *table)
> >       printf("\tInstalled Cache Size 2: 0x%08x\n", table->inst_size2.data);
> > }
> >
> >+static void smbios_print_type9(struct smbios_type9 *table)
> >+{
> >+      int i;
> >+      u8 *addr = (u8 *)table +
> >+                 offsetof(struct smbios_type9, slot_information);
> >+
> >+      printf("System Slots:\n");
> >+      smbios_print_str("Socket Designation", table,
> >+                       table->socket_design);
> >+      smbios_print_lookup_str(slot_type_strings,
> >+                              table->slot_type,
> >+                              ARRAY_SIZE(slot_type_strings),
> >+                              "Slot Type");
> >+      smbios_print_lookup_str(slot_bus_width_strings,
> >+                              table->slot_data_bus_width,
> >+                              ARRAY_SIZE(slot_bus_width_strings),
> >+                              "Slot Data Bus Width");
> >+      smbios_print_lookup_str(slot_usage_strings,
> >+                              table->current_usage,
> >+                              ARRAY_SIZE(slot_usage_strings),
> >+                              "Current Usage");
> >+      smbios_print_lookup_str(slot_length_strings,
> >+                              table->slot_length,
> >+                              ARRAY_SIZE(slot_length_strings),
> >+                              "Slot Length");
> >+      printf("\tSlot ID: 0x%04x\n", table->slot_id);
> >+      printf("\tSlot Characteristics 1: 0x%04x\n",
> >+             table->slot_characteristics_1);
> >+      printf("\tSlot Characteristics 2: 0x%04x\n",
> >+             table->slot_characteristics_2);
> >+      printf("\tSegment Group Number (Base): 0x%04x\n",
> >+             table->segment_group_number);
> >+      printf("\tBus Number (Base): 0x%04x\n", table->bus_number);
> >+      printf("\tDevice/Function Number (Base): 0x%04x\n",
> >+             table->device_function_number.data);
> >+      printf("\tData Bus Width (Base): 0x%04x\n",
> >+             table->electrical_bus_width);
> >+      printf("\tPeer (S/B/D/F/Width) grouping count: 0x%04x\n",
> >+             table->peer_grouping_count);
> >+      printf("\tPeer (S/B/D/F/Width) groups:\n");
> >+      for (i = 0; i < table->peer_grouping_count; i++) {
> >+              printf("\t\tPeer group[%03d]:\n", i);
> >+              if (CONFIG_IS_ENABLED(HEXDUMP))
> >+                      print_hex_dump("\t\t", DUMP_PREFIX_OFFSET, 16, 1, addr,
> >+                                     SMBIOS_TYPE9_PGROUP_SIZE, false);
> >+              addr += SMBIOS_TYPE9_PGROUP_SIZE;
> >+      }
> >+      printf("\n");
> >+
> >+      /* table->slot_information */
> >+      printf("\tSlot Information: 0x%04x\n", *addr);
> >+      /* table->slot_physical_width */
> >+      addr += sizeof(table->slot_information);
> >+      printf("\tSlot Physical Width: 0x%04x\n", *addr);
> >+      /* table->slot_pitch */
> >+      addr += sizeof(table->slot_physical_width);
> >+      printf("\tSlot Pitch: 0x%04x\n", *(u16 *)addr);
> >+      /* table->slot_height */
> >+      addr += sizeof(table->slot_pitch);
> >+      printf("\tSlot Height: 0x%04x\n", *addr);
> >+}
> >+
> > static void smbios_print_type127(struct smbios_type127 *table)
> > {
> >       printf("End Of Table\n");
> >@@ -482,6 +593,9 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag, int argc,
> >               case SMBIOS_CACHE_INFORMATION:
> >                       smbios_print_type7((struct smbios_type7 *)pos);
> >                       break;
> >+              case SMBIOS_SYSTEM_SLOTS:
> >+                      smbios_print_type9((struct smbios_type9 *)pos);
> >+                      break;
> >               case SMBIOS_END_OF_TABLE:
> >                       smbios_print_type127((struct smbios_type127 *)pos);
> >                       break;
> >diff --git a/include/smbios.h b/include/smbios.h
> >index b5fed57aba2..d885285ea41 100644
> >--- a/include/smbios.h
> >+++ b/include/smbios.h
> >@@ -264,6 +264,51 @@ struct __packed smbios_type7 {
> >       char eos[SMBIOS_STRUCT_EOS_BYTES];
> > };
> >
> >+#define SMBIOS_TYPE9_PGROUP_SIZE 5
> >+
> >+struct pci_attr_lookup_table {
> >+      const char *str;
> >+      u8 slot_type;
> >+      u8 data_bus_width;
> >+      u8 slot_length;
> >+      u8 chara1;
> >+      u8 chara2;
> >+};
> >+
> >+union dev_func_num {
> >+      struct {
> >+              u8 dev_num:5;
> >+              u8 func_num:3;
> >+      } fields;
> >+      u8 data;
> >+};
> >+
> >+struct __packed smbios_type9 {
> >+      struct smbios_header hdr;
> >+      u8 socket_design;
> >+      u8 slot_type;
> >+      u8 slot_data_bus_width;
> >+      u8 current_usage;
> >+      u8 slot_length;
> >+      u16 slot_id;
> >+      u8 slot_characteristics_1;
> >+      u8 slot_characteristics_2;
> >+      u16 segment_group_number;
> >+      u8 bus_number;
> >+      union dev_func_num device_function_number;
> >+      u8 electrical_bus_width;
> >+      u8 peer_grouping_count;
> >+      /*
> >+       * Dynamic bytes will be inserted here to store peer_groups.
> >+       * length is equal to 'peer_grouping_count' * 5
> >+       */
> >+      u8 slot_information;
> >+      u8 slot_physical_width;
> >+      u16 slot_pitch;
> >+      u8 slot_height;
> >+      char eos[SMBIOS_STRUCT_EOS_BYTES];
> >+};
> >+
> > struct __packed smbios_type32 {
> >       u8 type;
> >       u8 length;
> >diff --git a/include/smbios_def.h b/include/smbios_def.h
> >index 81c5781217f..ef9cb02ed25 100644
> >--- a/include/smbios_def.h
> >+++ b/include/smbios_def.h
> >@@ -191,4 +191,93 @@
> > #define SMBIOS_CACHE_ASSOC_64WAY      13
> > #define SMBIOS_CACHE_ASSOC_20WAY      14
> >
> >+/*
> >+ * System Slot
> >+ */
> >+
> >+/* Slot Type */
> >+#define SMBIOS_SYSSLOT_TYPE_OTHER     1
> >+#define SMBIOS_SYSSLOT_TYPE_UNKNOWN   2
> >+#define SMBIOS_SYSSLOT_TYPE_ISA               3       /* ISA */
> >+#define SMBIOS_SYSSLOT_TYPE_PCI               6       /* PCI */
> >+#define SMBIOS_SYSSLOT_TYPE_PCMCIA    7       /* PCMCIA */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIE      0xa5    /* PCI Express */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEX1    0xa6    /* PCI Express x1 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEX2    0xa7    /* PCI Express x2 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEX4    0xa8    /* PCI Express x4 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEX8    0xa9    /* PCI Express x8 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEX16   0xaa    /* PCI Express x16 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2  0xab    /* PCI Express Gen 2 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X1        0xac    /* PCI Express Gen 2 x1 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X2        0xad    /* PCI Express Gen 2 x2 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X4        0xae    /* PCI Express Gen 2 x4 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X8        0xaf    /* PCI Express Gen 2 x8 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X16       0xb0    /* PCI Express Gen 2 x16 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3  0xb1    /* PCI Express Gen 3 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X1        0xb2    /* PCI Express Gen 3 x1 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X2        0xb3    /* PCI Express Gen 3 x2 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X4        0xb4    /* PCI Express Gen 3 x4 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X8        0xb5    /* PCI Express Gen 3 x8 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16       0xb6    /* PCI Express Gen 3 x16 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4  0xb8    /* PCI Express Gen 4 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X1        0xb9    /* PCI Express Gen 4 x1 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X2        0xba    /* PCI Express Gen 4 x2 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X4        0xbb    /* PCI Express Gen 4 x4 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8        0xbc    /* PCI Express Gen 4 x8 */
> >+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16       0xbd    /* PCI Express Gen 4 x16 */
> >+
> >+/* Slot Data Bus Width */
> >+#define SMBIOS_SYSSLOT_WIDTH_OTHER    1
> >+#define SMBIOS_SYSSLOT_WIDTH_UNKNOWN  2
> >+#define SMBIOS_SYSSLOT_WIDTH_8BIT     3
> >+#define SMBIOS_SYSSLOT_WIDTH_16BIT    4
> >+#define SMBIOS_SYSSLOT_WIDTH_32BIT    5
> >+#define SMBIOS_SYSSLOT_WIDTH_64BIT    6
> >+#define SMBIOS_SYSSLOT_WIDTH_128BIT   7
> >+#define SMBIOS_SYSSLOT_WIDTH_1X               8
> >+#define SMBIOS_SYSSLOT_WIDTH_2X               9
> >+#define SMBIOS_SYSSLOT_WIDTH_4X               10
> >+#define SMBIOS_SYSSLOT_WIDTH_8X               11
> >+#define SMBIOS_SYSSLOT_WIDTH_12X      12
> >+#define SMBIOS_SYSSLOT_WIDTH_16X      13
> >+#define SMBIOS_SYSSLOT_WIDTH_32X      14
> >+
> >+/* Current Usage */
> >+#define SMBIOS_SYSSLOT_USAGE_OTHER    1
> >+#define SMBIOS_SYSSLOT_USAGE_UNKNOWN  2
> >+#define SMBIOS_SYSSLOT_USAGE_AVAILABLE        3
> >+#define SMBIOS_SYSSLOT_USAGE_INUSE    4
> >+#define SMBIOS_SYSSLOT_USAGE_NA               5
> >+
> >+/* Slot Length */
> >+#define SMBIOS_SYSSLOT_LENG_OTHER     1
> >+#define SMBIOS_SYSSLOT_LENG_UNKNOWN   2
> >+#define SMBIOS_SYSSLOT_LENG_SHORT     3
> >+#define SMBIOS_SYSSLOT_LENG_LONG      4
> >+#define SMBIOS_SYSSLOT_LENG_2_5INDRV  5
> >+#define SMBIOS_SYSSLOT_LENG_3_5INDRV  6
> >+
> >+/*  Slot Characteristics 1 */
> >+#define SMBIOS_SYSSLOT_CHAR_UND               1 /* BIT(0) */
> >+#define SMBIOS_SYSSLOT_CHAR_5V                2 /* BIT(1) */
> >+#define SMBIOS_SYSSLOT_CHAR_3_3V      4 /* BIT(2) */
> >+#define SMBIOS_SYSSLOT_CHAR_SHARED    8 /* BIT(3) */
> >+#define SMBIOS_SYSSLOT_CHAR_PCCARD16  16 /* BIT(4) */
> >+#define SMBIOS_SYSSLOT_CHAR_PCCARDBUS 32 /* BIT(5) */
> >+#define SMBIOS_SYSSLOT_CHAR_PCCARDZV  64 /* BIT(6) */
> >+#define SMBIOS_SYSSLOT_CHAR_PCCARDMRR 0x80 /* BIT(7) */
> >+
> >+/* Slot Characteristics 2 */
> >+#define SMBIOS_SYSSLOT_CHAR_PCIPME    1 /* BIT(0) */
> >+#define SMBIOS_SYSSLOT_CHAR_HOTPLUG   2 /* BIT(1) */
> >+#define SMBIOS_SYSSLOT_CHAR_PCISMB    4 /* BIT(2) */
> >+#define SMBIOS_SYSSLOT_CHAR_PCIBIF    8 /* BIT(3) */
> >+#define SMBIOS_SYSSLOT_CHAR_ASYNCRM   16 /* BIT(4) */
> >+#define SMBIOS_SYSSLOT_CHAR_FBCXL1    32 /* BIT(5) */
> >+#define SMBIOS_SYSSLOT_CHAR_FBCXL2    64 /* BIT(6) */
> >+#define SMBIOS_SYSSLOT_CHAR_FBCXL3    0x80 /* BIT(7) */
> >+
> >+/* Slot segment group number */
> >+#define SMBIOS_SYSSLOT_SGGNUM_UND     0
> >+
> > #endif /* _SMBIOS_DEF_H_ */
> >diff --git a/lib/smbios.c b/lib/smbios.c
> >index 7c9701a57f9..55350d00067 100644
> >--- a/lib/smbios.c
> >+++ b/lib/smbios.c
> >@@ -66,11 +66,47 @@ struct map_sysinfo {
> >
> > static const struct map_sysinfo sysinfo_to_dt[] = {
> >       { .si_node = "system", .si_str = "product", .dt_str = "model", 2 },
> >-      { .si_node = "system", .si_str = "manufacturer", .dt_str = "compatible", 1 },
> >-      { .si_node = "baseboard", .si_str = "product", .dt_str = "model", 2 },
> >-      { .si_node = "baseboard", .si_str = "manufacturer", .dt_str = "compatible", 1 },
> >+      { .si_node = "system", .si_str = "manufacturer",
> >+        .dt_str = "compatible", 1 },
> >+      { .si_node = "baseboard", .si_str = "product",
> >+        .dt_str = "model", 2 },
> >+      { .si_node = "baseboard", .si_str = "manufacturer",
> >+        .dt_str = "compatible", 1 },
> >+      { .si_node = "system-slot", .si_str = "slot-type",
> >+        .dt_str = "device_type", 0},
> >+      { .si_node = "system-slot", .si_str = "segment-group-number",
> >+        .dt_str = "linux,pci-domain", 0},
> > };
> >
> >+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
> >+static const struct pci_attr_lookup_table pci_attr[] = {
> >+      { "pci-host-ecam-generic", SMBIOS_SYSSLOT_TYPE_PCIE,
> >+        SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
> >+        SMBIOS_SYSSLOT_CHAR_3_3V, SMBIOS_SYSSLOT_CHAR_PCIPME },
> >+      { "pci-host-cam-generic", SMBIOS_SYSSLOT_TYPE_PCI,
> >+        SMBIOS_SYSSLOT_WIDTH_32BIT, SMBIOS_SYSSLOT_LENG_SHORT,
> >+        SMBIOS_SYSSLOT_CHAR_5V | SMBIOS_SYSSLOT_CHAR_3_3V,
> >+        SMBIOS_SYSSLOT_CHAR_PCIPME },
> >+      { "pci-host-thunder-ecam", SMBIOS_SYSSLOT_TYPE_PCIEGEN3,
> >+        SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
> >+        SMBIOS_SYSSLOT_CHAR_3_3V,
> >+        SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
> >+      { "pci-host-octeontx-ecam", SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16,
> >+        SMBIOS_SYSSLOT_WIDTH_16X, SMBIOS_SYSSLOT_LENG_LONG,
> >+        SMBIOS_SYSSLOT_CHAR_3_3V,
> >+        SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
> >+      { "pci-host-thunder-pem", SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8,
> >+        SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
> >+        SMBIOS_SYSSLOT_CHAR_3_3V,
> >+        SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
> >+      { "pci-host-octeontx2-pem", SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16,
> >+        SMBIOS_SYSSLOT_WIDTH_16X, SMBIOS_SYSSLOT_LENG_LONG,
> >+        SMBIOS_SYSSLOT_CHAR_3_3V,
> >+        SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG |
> >+        SMBIOS_SYSSLOT_CHAR_PCIBIF },
> >+};
> >+#endif
> >+
> > /**
> >  * struct smbios_ctx - context for writing SMBIOS tables
> >  *
> >@@ -222,6 +258,7 @@ static int smbios_get_val_si(struct smbios_ctx * __maybe_unused ctx,
> > {
> > #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
> >       int val;
> >+      const struct map_sysinfo *nprop;
> >
> >       if (!ctx->dev)
> >               return val_def;
> >@@ -240,6 +277,11 @@ static int smbios_get_val_si(struct smbios_ctx * __maybe_unused ctx,
> >        */
> >       if (!ofnode_read_u32(ofnode_root(), prop, &val))
> >               return val;
> >+
> >+      /* If the node is still missing, try with the mapping values */
> >+      nprop = convert_sysinfo_to_dt(ctx->subnode_name, prop);
> >+      if (!ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
> >+              return val;
> > #endif
> >       return val_def;
> > }
> >@@ -856,6 +898,222 @@ static int smbios_write_type7(ulong *current, int handle,
> >       return len;
> > }
> >
> >+static void smbios_lookup_pci_attr(struct smbios_ctx *ctx,
> >+                                 struct smbios_type9 *t)
> >+{
> >+      const char *compatible;
> >+      u32 addr_cells, size_cells, total_cells;
> >+      const fdt32_t *reg;
> >+      int reglen;
> >+      int i;
> >+
> >+      /* default attributes */
> >+      t->slot_type = SMBIOS_SYSSLOT_TYPE_PCI;
> >+      t->slot_data_bus_width = SMBIOS_SYSSLOT_WIDTH_UNKNOWN;
> >+      t->slot_characteristics_1 = SMBIOS_SYSSLOT_CHAR_UND;
> >+      t->current_usage = SMBIOS_SYSSLOT_USAGE_UNKNOWN;
> >+      t->slot_length = SMBIOS_SYSSLOT_LENG_UNKNOWN;
> >+      t->segment_group_number = smbios_get_val_si(ctx, "segment-group-number",
> >+                                                  SYSID_NONE,
> >+                                                  SMBIOS_SYSSLOT_SGGNUM_UND);
> >+
> >+      /*
> >+       * Get #address-cells and #size-cells dynamically
> >+       * Default 3 for #address-cells and 2 for #size-cells
> >+       */
> >+      addr_cells = ofnode_read_u32_default(ctx->node, "#address-cells", 3);
> >+      size_cells = ofnode_read_u32_default(ctx->node, "#size-cells", 2);
> >+      total_cells = addr_cells + size_cells;
> >+
> >+      /* Read property 'reg' from the node */
> >+      reg = ofnode_read_prop(ctx->node, "reg", &reglen);
> >+      if (reg && reglen > addr_cells * sizeof(*reg)) {
> >+              /* First address-cell: Bus Number */
> >+              if (addr_cells >= 1)
> >+                      t->bus_number = fdt32_to_cpu(reg[0]);
> >+              /* Second address-cell: Device/Function */
> >+              if (addr_cells >= 2)
> >+                      t->device_function_number.data = fdt32_to_cpu(reg[1]);
> >+              /*
> >+               * Third address-cell 'Register Offset' and the following
> >+               * size-cell bytes are not useful for SMBIOS type 9, just
> >+               * ignore them.
> >+               */
> >+              /*
> >+               * As neither PCI IRQ Routing Table ($PIRQ) nor FDT
> >+               * property to represent a Slot ID, try to derive a
> >+               * Slot ID programmatically.
> >+               */
> >+              t->slot_id = t->device_function_number.fields.dev_num |
> >+                           (t->bus_number << 5);
> >+      }
> >+
> >+      /* Read 'compatible' property */
> >+      compatible = ofnode_read_string(ctx->node, "compatible");
> >+      if (!compatible)
> >+              return;
> >+
> >+      for (i = 0; i < ARRAY_SIZE(pci_attr); i++) {
> >+              if (strstr(compatible, pci_attr[i].str)) {
> >+                      t->slot_type = pci_attr[i].slot_type;
> >+                      t->slot_data_bus_width = pci_attr[i].data_bus_width;
> >+                      t->slot_length = pci_attr[i].slot_length;
> >+                      t->slot_characteristics_1 = pci_attr[i].chara1;
> >+                      t->slot_characteristics_2 = pci_attr[i].chara2;
> >+                      /* mark it as in-use arbitrarily */
> >+                      t->current_usage = SMBIOS_SYSSLOT_USAGE_INUSE;
> >+                      return;
> >+              }
> >+      }
> >+}
> >+
> >+static void smbios_write_type9_fields(struct smbios_ctx *ctx,
> >+                                    struct smbios_type9 *t)
> >+{
> >+      t->slot_type = smbios_get_val_si(ctx, "slot-type", SYSID_NONE,
> >+                                       SMBIOS_SYSSLOT_TYPE_UNKNOWN);
> >+      t->slot_data_bus_width =
> >+              smbios_get_val_si(ctx, "data-bus-width",
> >+                                SYSID_NONE, SMBIOS_SYSSLOT_WIDTH_UNKNOWN);
> >+      t->current_usage = smbios_get_val_si(ctx, "current-usage", SYSID_NONE,
> >+                                           SMBIOS_SYSSLOT_USAGE_UNKNOWN);
> >+      t->slot_length = smbios_get_val_si(ctx, "slot-length", SYSID_NONE,
> >+                                         SMBIOS_SYSSLOT_LENG_UNKNOWN);
> >+      t->slot_id = smbios_get_val_si(ctx, "slot-id", SYSID_NONE, 0);
> >+      t->slot_characteristics_1 =
> >+              smbios_get_val_si(ctx, "slot-characteristics-1", SYSID_NONE,
> >+                                SMBIOS_SYSSLOT_CHAR_UND);
> >+      t->slot_characteristics_2 = smbios_get_val_si(ctx,
> >+                                                    "slot-characteristics-2",
> >+                                                    SYSID_NONE, 0);
> >+      t->segment_group_number = smbios_get_val_si(ctx, "segment-group-number",
> >+                                                  SYSID_NONE, 0);
> >+      t->bus_number = smbios_get_val_si(ctx, "bus-number", SYSID_NONE, 0);
> >+      t->device_function_number.data =
> >+              smbios_get_val_si(ctx, "device-function-number", SYSID_NONE, 0);
> >+}
> >+
> >+static int smbios_write_type9_1slot(ulong *current, int handle,
> >+                                  struct smbios_ctx *ctx, u8 devtype)
> >+{
> >+      struct smbios_type9 *t;
> >+      int len = sizeof(*t);
> >+      u8 pgroups_cnt;
> >+      u8 *eos_addr;
> >+      size_t pgroups_size;
> >+      void *wp;
> >+
> >+      pgroups_cnt = smbios_get_val_si(ctx, "peer-grouping-count",
> >+                                      SYSID_NONE, 0);
> >+      pgroups_size = pgroups_cnt * SMBIOS_TYPE9_PGROUP_SIZE;
> >+
> >+      /*
> >+       * reserve the space for the dynamic bytes of peer_groups.
> >+       * TODO:
> >+       * peer_groups = <peer_grouping_count> * SMBIOS_TYPE9_PGROUP_SIZE
> >+       */
> >+      len += pgroups_size;
> >+
> >+      t = map_sysmem(*current, len);
> >+      memset(t, 0, len);
> >+
> >+      fill_smbios_header(t, SMBIOS_SYSTEM_SLOTS, len, handle);
> >+
> >+      /* eos is at the end of the structure */
> >+      eos_addr = (u8 *)t + len - sizeof(t->eos);
> >+      smbios_set_eos(ctx, eos_addr);
> >+
> >+      /* Write the general fields */
> >+      t->peer_grouping_count = pgroups_cnt;
> >+      t->socket_design = smbios_add_prop_si(ctx, "socket-design", SYSID_NONE,
> >+                                            NULL);
> >+      t->electrical_bus_width = smbios_get_val_si(ctx, "data-bus-width",
> >+                                                  SYSID_NONE, 0);
> >+
> >+      /* skip the reserved peer groups and write the following fields from eos */
> >+      /* t->slot_height */
> >+      wp = eos_addr - sizeof(t->slot_height);
> >+      *((u8 *)wp) = smbios_get_val_si(ctx, "slot-height", SYSID_NONE, 0);
> >+      /* t->slot_pitch */
> >+      wp -= sizeof(t->slot_pitch);
> >+      *((u16 *)wp) = smbios_get_val_si(ctx, "slot-pitch", SYSID_NONE, 0);
> >+      /* t->slot_physical_width */
> >+      wp -= sizeof(t->slot_physical_width);
> >+      *((u8 *)wp) = smbios_get_val_si(ctx, "slot-physical-width", SYSID_NONE, 0);
> >+      /* t->slot_information */
> >+      wp -= sizeof(t->slot_information);
> >+      *((u8 *)wp) = smbios_get_val_si(ctx, "slot-information", SYSID_NONE, 0);
> >+
> >+      /* For PCI, some fields can be extracted from FDT node */
> >+      if (devtype == SMBIOS_SYSSLOT_TYPE_PCI)
> >+              /* Populate PCI attributes from existing PCI properties */
> >+              smbios_lookup_pci_attr(ctx, t);
> >+      else if (devtype == SMBIOS_SYSSLOT_TYPE_UNKNOWN) {
> >+              /* Properties that expected in smbios subnode 'system-slot' */
> >+              smbios_write_type9_fields(ctx, t);
> >+      }
> >+      len = t->hdr.length + smbios_string_table_len(ctx);
> >+      *current += len;
> >+      unmap_sysmem(t);
> >+
> >+      return len;
> >+}
> >+
> >+static int smbios_write_type9(ulong *current, int handle,
> >+                            struct smbios_ctx *ctx)
> >+{
> >+      int len = 0;
> >+      struct smbios_ctx ctx_bak;
> >+      ofnode child;
> >+      const struct map_sysinfo *prop;
> >+
> >+      /* TODO: Get system slot information via pci subsystem */
> >+      if (!IS_ENABLED(CONFIG_OF_CONTROL))
> >+              return 0;       /* Error, return 0-length */
> >+
> >+      memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
> >+
> >+      /* write the properties if any subnode exists under 'system-slot' */
> >+      for (child = ofnode_first_subnode(ctx->node); ofnode_valid(child);
> >+           child = ofnode_next_subnode(child)) {
> >+              ctx->node = child;
> >+              len += smbios_write_type9_1slot(current, handle++, ctx,
> >+                                              SMBIOS_SYSSLOT_TYPE_UNKNOWN);
> >+              memcpy(ctx, &ctx_bak, sizeof(*ctx));
> >+      }
> >+
> >+      if (len)
> >+              return len;
> >+
> >+      /* if no subnode of 'system-slot', try scan the entire FDT */
> >+      prop = convert_sysinfo_to_dt(ctx->subnode_name, "slot-type");
> >+      for (child = ofnode_first_subnode(ofnode_root()); ofnode_valid(child);
> >+           child = ofnode_next_subnode(child)) {
> >+              const char *dev_type_str;
> >+              u8 dev_type = SMBIOS_SYSSLOT_TYPE_UNKNOWN;
> >+
> >+              dev_type_str = ofnode_read_string(child, prop->dt_str);
> >+              if (!dev_type_str)
> >+                      continue;
> >+
> >+              if (!strcmp(dev_type_str, "pci"))
> >+                      dev_type = SMBIOS_SYSSLOT_TYPE_PCI;
> >+              else if (!strcmp(dev_type_str, "isa"))
> >+                      dev_type = SMBIOS_SYSSLOT_TYPE_ISA;
> >+              else if (!strcmp(dev_type_str, "pcmcia"))
> >+                      dev_type = SMBIOS_SYSSLOT_TYPE_PCMCIA;
> >+              else
> >+                      continue;
> >+
> >+              ctx->node = child;
> >+              len += smbios_write_type9_1slot(current, handle++, ctx,
> >+                                              dev_type);
> >+              memcpy(ctx, &ctx_bak, sizeof(*ctx));
> >+      }
> >+
> >+      return len;
> >+}
> >+
> > #endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
> >
> > static int smbios_write_type32(ulong *current, int handle,
> >@@ -902,6 +1160,9 @@ static struct smbios_write_method smbios_write_funcs[] = {
> >       { smbios_write_type7, "cache", },
> > #endif
> >       { smbios_write_type4, "processor"},
> >+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
> >+      { smbios_write_type9, "system-slot"},
> >+#endif
> >       { smbios_write_type32, },
> >       { smbios_write_type127 },
> > };
>
