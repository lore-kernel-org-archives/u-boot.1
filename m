Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA98C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 14:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E05382905;
	Thu,  8 May 2025 16:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G5dD4j1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB3F8294C; Thu,  8 May 2025 16:27:30 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EB98828BC
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 16:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746714445; x=1747319245; i=xypron.glpk@gmx.de;
 bh=z47QuzWiXYv2nPakv0dJUALoYkT6MUR4hnLuEhjNFB0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=G5dD4j1y4KLuMB17N4cNHrATBAukwHM7u/9LsR0qkQSgid18yl2ZxIGsdJwWJYrT
 nbTauY0TTB4gncbIi87OPJRT7HbfjJD8F6afgsXgbFeOB+K7j9mGz/P/pC8KRdfMf
 nc1GQXqVlN4ID2mRkmFtHKWULSfG9GLD6WRThLQ0J4pfvhq4ZeBR/HXN0YbHH6/g0
 qP7eAgc3CwZO5c67Jx9ZpwKZWDKAvpldcK2NxRv1RgHJtw7e47AM6Etg5l/9MfnRO
 LpUAwzq6uQhxcREP5DP5FUpiqBHyJPiveVI5QiTFyX0z77g2nb/lV9+etKgJGsPwv
 aQY4PYAWGijiZhiWAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([213.157.19.150]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mxm3Q-1uwa5y3iog-00wfep; Thu, 08
 May 2025 16:27:25 +0200
Date: Thu, 08 May 2025 16:27:21 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Baocheng Su <baocheng.su@siemens.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2] smbios: add support for type 9 system slot
User-Agent: Thunderbird for Android
In-Reply-To: <20250508141042.254447-1-raymond.mao@linaro.org>
References: <20250508141042.254447-1-raymond.mao@linaro.org>
Message-ID: <39635794-E9FD-40D2-82B9-EC93F8D4734A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u3SIYNLu+W7JDsBH4T/0fa+nVuAZ/CP1yTlVTxSKYbvaF5GI953
 ml/Gg2hO4SbfVBF1AYt8/bNSugyA0yz3cYPUbWd3BvCrXWzXivh8iK5YlrZmIyKKB2+m+Nw
 aihqMJPpDitTkHLVApTrVT9eqDwQDh7c3mVtihwwBjjU2db6BacsQ4LqtYRmFUQQwXe0Bv/
 wwFuvR+oO/z3/vPlhhYRA==
UI-OutboundReport: notjunk:1;M01:P0:uZ61th3u7Tc=;grc05X82C/Vo8iM7MrX99qqwHbG
 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
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

Am 8=2E Mai 2025 16:10:33 MESZ schrieb Raymond Mao <raymond=2Emao@linaro=2E=
org>:
>Implement SMBIOS Type 9 (System Slot)=2E
>SMBIOS library will look for a subnode "system-slot" under
>"smbios" to construct the data of Type 9=2E
>[1] is an example for the expected pattern of "system-slot"=2E
>


The value of type 9 information comes with the information if a slot occup=
ied=2E

I can't see any code determining the actual usage=2E So what is the point =
of this patch?

Best regards=20

Heinrich


>If "system-slot" node does not exist, or any of its properties
>are missing, as a fallback, SMBIOS library will try to get the
>values by scanning the device tree=2E
>
>SMBIOS Type 9 support is under GENERATE_SMBIOS_TABLE_VERBOSE to
>avoid increasing rom size for those platforms which only require
>basic SMBIOS support=2E
>
>[1] Example of a "system-slot" node which contains two slots:
>    system-slot {
>        isa {
>            socket-design =3D "";
>            slot-type =3D <SMBIOS_SYSSLOT_TYPE_ISA>;
>            slot-data-bus-width =3D
>            <SMBIOS_SYSSLOT_WIDTH_16BIT>;
>            current-usage =3D <SMBIOS_SYSSLOT_USAGE_NA>;
>            slot-length =3D <SMBIOS_SYSSLOT_LENG_SHORT>;
>            slot-id =3D <0>;
>            slot-characteristics-1 =3D <(SMBIOS_SYSSLOT_CHAR_5V |
>                                       SMBIOS_SYSSLOT_CHAR_3_3V)>;
>            slot-characteristics-2 =3D <SMBIOS_SYSSLOT_CHAR_ASYNCRM>;
>            segment-group-number =3D <0>;
>            bus-number =3D <0x80>;
>            device-function-number =3D <0x10>;
>            data-bus-width =3D <0>;
>            peer-grouping-count =3D <0>;
>            slot-information =3D <0>;
>            slot-physical-width =3D <0>;
>            slot-characteristics-1 =3D <(SMBIOS_SYSSLOT_CHAR_5V |
>                                       SMBIOS_SYSSLOT_CHAR_3_3V)>;
>            slot-characteristics-2 =3D <SMBIOS_SYSSLOT_CHAR_ASYNCRM>;
>            segment-group-number =3D <0>;
>            bus-number =3D <0x80>;
>            device-function-number =3D <0x10>;
>            data-bus-width =3D <0>;
>            peer-grouping-count =3D <0>;
>            slot-information =3D <0>;
>            slot-physical-width =3D <0>;
>            slot-pitch =3D <0>;
>            slot-height =3D <0>;
>        };
>        pcmcia {
>            socket-design =3D "";
>            slot-type =3D <SMBIOS_SYSSLOT_TYPE_PCMCIA>;
>            slot-data-bus-width =3D <SMBIOS_SYSSLOT_WIDTH_32BIT>;
>            current-usage =3D <SMBIOS_SYSSLOT_USAGE_AVAILABLE>;
>            slot-length =3D <SMBIOS_SYSSLOT_LENG_SHORT>;
>            slot-id =3D <1>;
>            slot-characteristics-1 =3D <(SMBIOS_SYSSLOT_CHAR_5V |
>                                       SMBIOS_SYSSLOT_CHAR_3_3V)>;
>            slot-characteristics-2 =3D <SMBIOS_SYSSLOT_CHAR_ASYNCRM>;
>            segment-group-number =3D <1>;
>            bus-number =3D <0xa0>;
>            device-function-number =3D <0x40>;
>            data-bus-width =3D <0>;
>            peer-grouping-count =3D <0>;
>            slot-information =3D <0>;
>            slot-physical-width =3D <0>;
>            slot-pitch =3D <0>;
>            slot-height =3D <0>;
>        };
>    };
>
>Signed-off-by: Raymond Mao <raymond=2Emao@linaro=2Eorg>
>---
>Changes in v2:
>- Reuse sysinfo_to_dt and convert_sysinfo_to_dt() for mapping SMBIOS prop=
erties to DT=2E
>
> arch/arm/dts/smbios_generic=2Edtsi |   3 +
> cmd/smbios=2Ec                     | 114 +++++++++++++
> include/smbios=2Eh                 |  45 ++++++
> include/smbios_def=2Eh             |  89 +++++++++++
> lib/smbios=2Ec                     | 267 ++++++++++++++++++++++++++++++-
> 5 files changed, 515 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm/dts/smbios_generic=2Edtsi b/arch/arm/dts/smbios_gen=
eric=2Edtsi
>index fc168317c9e=2E=2E4463dade217 100644
>--- a/arch/arm/dts/smbios_generic=2Edtsi
>+++ b/arch/arm/dts/smbios_generic=2Edtsi
>@@ -77,6 +77,9 @@
> 						   SMBIOS_CACHE_OP_WB)>;
> 				};
> 			};
>+
>+			system-slot {
>+			};
> 		};
> 	};
> };
>diff --git a/cmd/smbios=2Ec b/cmd/smbios=2Ec
>index 562dd7959be=2E=2E127e89ca914 100644
>--- a/cmd/smbios=2Ec
>+++ b/cmd/smbios=2Ec
>@@ -119,6 +119,55 @@ static const struct str_lookup_table associativity_s=
trings[] =3D {
>=20
> };
>=20
>+static const struct str_lookup_table slot_type_strings[] =3D {
>+	{ SMBIOS_SYSSLOT_TYPE_OTHER,		"Other" },
>+	{ SMBIOS_SYSSLOT_TYPE_UNKNOWN,		"Unknown" },
>+	{ SMBIOS_SYSSLOT_TYPE_ISA,		"ISA" },
>+	{ SMBIOS_SYSSLOT_TYPE_PCI,		"PCI" },
>+	{ SMBIOS_SYSSLOT_TYPE_PCMCIA,		"PC Card (PCMCIA)" },
>+	{ SMBIOS_SYSSLOT_TYPE_PCIE,		"PCI Express" },
>+	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN2,		"PCI Express Gen 2" },
>+	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN3,		"PCI Express Gen 3" },
>+	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16,	"PCI Express Gen 3 x16" },
>+	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN4,		"PCI Express Gen 4" },
>+	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8,	"PCI Express Gen 4 x8" },
>+	{ SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16,	"PCI Express Gen 4 x16" },
>+};
>+
>+static const struct str_lookup_table slot_bus_width_strings[] =3D {
>+	{ SMBIOS_SYSSLOT_WIDTH_OTHER,	"Other" },
>+	{ SMBIOS_SYSSLOT_WIDTH_UNKNOWN,	"Unknown" },
>+	{ SMBIOS_SYSSLOT_WIDTH_8BIT,	"8 bit" },
>+	{ SMBIOS_SYSSLOT_WIDTH_16BIT,	"16 bit" },
>+	{ SMBIOS_SYSSLOT_WIDTH_32BIT,	"32 bit" },
>+	{ SMBIOS_SYSSLOT_WIDTH_64BIT,	"64 bit" },
>+	{ SMBIOS_SYSSLOT_WIDTH_128BIT,	"128 bit " },
>+	{ SMBIOS_SYSSLOT_WIDTH_1X,	"1x or x1" },
>+	{ SMBIOS_SYSSLOT_WIDTH_2X,	"2x or x2" },
>+	{ SMBIOS_SYSSLOT_WIDTH_4X,	"4x or x4" },
>+	{ SMBIOS_SYSSLOT_WIDTH_8X,	"8x or x8" },
>+	{ SMBIOS_SYSSLOT_WIDTH_12X,	"12x or x12" },
>+	{ SMBIOS_SYSSLOT_WIDTH_16X,	"16x or x16" },
>+	{ SMBIOS_SYSSLOT_WIDTH_32X,	"32x or x32" },
>+};
>+
>+static const struct str_lookup_table slot_usage_strings[] =3D {
>+	{ SMBIOS_SYSSLOT_USAGE_OTHER,		"Other" },
>+	{ SMBIOS_SYSSLOT_USAGE_UNKNOWN,		"Unknown" },
>+	{ SMBIOS_SYSSLOT_USAGE_AVAILABLE,	"Available" },
>+	{ SMBIOS_SYSSLOT_USAGE_INUSE,		"In use" },
>+	{ SMBIOS_SYSSLOT_USAGE_NA,		"Unavailable" },
>+};
>+
>+static const struct str_lookup_table slot_length_strings[] =3D {
>+	{ SMBIOS_SYSSLOT_LENG_OTHER,	"Other" },
>+	{ SMBIOS_SYSSLOT_LENG_UNKNOWN,	"Unknown" },
>+	{ SMBIOS_SYSSLOT_LENG_SHORT,	"Short Length" },
>+	{ SMBIOS_SYSSLOT_LENG_LONG,	"Long Length" },
>+	{ SMBIOS_SYSSLOT_LENG_2_5INDRV,	"2=2E5 inch drive form factor" },
>+	{ SMBIOS_SYSSLOT_LENG_3_5INDRV,	"3=2E5 inch drive form factor" },
>+};
>+
> /**
>  * smbios_get_string() - get SMBIOS string from table
>  *
>@@ -403,6 +452,68 @@ static void smbios_print_type7(struct smbios_type7 *=
table)
> 	printf("\tInstalled Cache Size 2: 0x%08x\n", table->inst_size2=2Edata);
> }
>=20
>+static void smbios_print_type9(struct smbios_type9 *table)
>+{
>+	int i;
>+	u8 *addr =3D (u8 *)table +
>+		   offsetof(struct smbios_type9, slot_information);
>+
>+	printf("System Slots:\n");
>+	smbios_print_str("Socket Designation", table,
>+			 table->socket_design);
>+	smbios_print_lookup_str(slot_type_strings,
>+				table->slot_type,
>+				ARRAY_SIZE(slot_type_strings),
>+				"Slot Type");
>+	smbios_print_lookup_str(slot_bus_width_strings,
>+				table->slot_data_bus_width,
>+				ARRAY_SIZE(slot_bus_width_strings),
>+				"Slot Data Bus Width");
>+	smbios_print_lookup_str(slot_usage_strings,
>+				table->current_usage,
>+				ARRAY_SIZE(slot_usage_strings),
>+				"Current Usage");
>+	smbios_print_lookup_str(slot_length_strings,
>+				table->slot_length,
>+				ARRAY_SIZE(slot_length_strings),
>+				"Slot Length");
>+	printf("\tSlot ID: 0x%04x\n", table->slot_id);
>+	printf("\tSlot Characteristics 1: 0x%04x\n",
>+	       table->slot_characteristics_1);
>+	printf("\tSlot Characteristics 2: 0x%04x\n",
>+	       table->slot_characteristics_2);
>+	printf("\tSegment Group Number (Base): 0x%04x\n",
>+	       table->segment_group_number);
>+	printf("\tBus Number (Base): 0x%04x\n", table->bus_number);
>+	printf("\tDevice/Function Number (Base): 0x%04x\n",
>+	       table->device_function_number=2Edata);
>+	printf("\tData Bus Width (Base): 0x%04x\n",
>+	       table->electrical_bus_width);
>+	printf("\tPeer (S/B/D/F/Width) grouping count: 0x%04x\n",
>+	       table->peer_grouping_count);
>+	printf("\tPeer (S/B/D/F/Width) groups:\n");
>+	for (i =3D 0; i < table->peer_grouping_count; i++) {
>+		printf("\t\tPeer group[%03d]:\n", i);
>+		if (CONFIG_IS_ENABLED(HEXDUMP))
>+			print_hex_dump("\t\t", DUMP_PREFIX_OFFSET, 16, 1, addr,
>+				       SMBIOS_TYPE9_PGROUP_SIZE, false);
>+		addr +=3D SMBIOS_TYPE9_PGROUP_SIZE;
>+	}
>+	printf("\n");
>+
>+	/* table->slot_information */
>+	printf("\tSlot Information: 0x%04x\n", *addr);
>+	/* table->slot_physical_width */
>+	addr +=3D sizeof(table->slot_information);
>+	printf("\tSlot Physical Width: 0x%04x\n", *addr);
>+	/* table->slot_pitch */
>+	addr +=3D sizeof(table->slot_physical_width);
>+	printf("\tSlot Pitch: 0x%04x\n", *(u16 *)addr);
>+	/* table->slot_height */
>+	addr +=3D sizeof(table->slot_pitch);
>+	printf("\tSlot Height: 0x%04x\n", *addr);
>+}
>+
> static void smbios_print_type127(struct smbios_type127 *table)
> {
> 	printf("End Of Table\n");
>@@ -482,6 +593,9 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag,=
 int argc,
> 		case SMBIOS_CACHE_INFORMATION:
> 			smbios_print_type7((struct smbios_type7 *)pos);
> 			break;
>+		case SMBIOS_SYSTEM_SLOTS:
>+			smbios_print_type9((struct smbios_type9 *)pos);
>+			break;
> 		case SMBIOS_END_OF_TABLE:
> 			smbios_print_type127((struct smbios_type127 *)pos);
> 			break;
>diff --git a/include/smbios=2Eh b/include/smbios=2Eh
>index b5fed57aba2=2E=2Ed885285ea41 100644
>--- a/include/smbios=2Eh
>+++ b/include/smbios=2Eh
>@@ -264,6 +264,51 @@ struct __packed smbios_type7 {
> 	char eos[SMBIOS_STRUCT_EOS_BYTES];
> };
>=20
>+#define SMBIOS_TYPE9_PGROUP_SIZE 5
>+
>+struct pci_attr_lookup_table {
>+	const char *str;
>+	u8 slot_type;
>+	u8 data_bus_width;
>+	u8 slot_length;
>+	u8 chara1;
>+	u8 chara2;
>+};
>+
>+union dev_func_num {
>+	struct {
>+		u8 dev_num:5;
>+		u8 func_num:3;
>+	} fields;
>+	u8 data;
>+};
>+
>+struct __packed smbios_type9 {
>+	struct smbios_header hdr;
>+	u8 socket_design;
>+	u8 slot_type;
>+	u8 slot_data_bus_width;
>+	u8 current_usage;
>+	u8 slot_length;
>+	u16 slot_id;
>+	u8 slot_characteristics_1;
>+	u8 slot_characteristics_2;
>+	u16 segment_group_number;
>+	u8 bus_number;
>+	union dev_func_num device_function_number;
>+	u8 electrical_bus_width;
>+	u8 peer_grouping_count;
>+	/*
>+	 * Dynamic bytes will be inserted here to store peer_groups=2E
>+	 * length is equal to 'peer_grouping_count' * 5
>+	 */
>+	u8 slot_information;
>+	u8 slot_physical_width;
>+	u16 slot_pitch;
>+	u8 slot_height;
>+	char eos[SMBIOS_STRUCT_EOS_BYTES];
>+};
>+
> struct __packed smbios_type32 {
> 	u8 type;
> 	u8 length;
>diff --git a/include/smbios_def=2Eh b/include/smbios_def=2Eh
>index 81c5781217f=2E=2Eef9cb02ed25 100644
>--- a/include/smbios_def=2Eh
>+++ b/include/smbios_def=2Eh
>@@ -191,4 +191,93 @@
> #define SMBIOS_CACHE_ASSOC_64WAY	13
> #define SMBIOS_CACHE_ASSOC_20WAY	14
>=20
>+/*
>+ * System Slot
>+ */
>+
>+/* Slot Type */
>+#define SMBIOS_SYSSLOT_TYPE_OTHER	1
>+#define SMBIOS_SYSSLOT_TYPE_UNKNOWN	2
>+#define SMBIOS_SYSSLOT_TYPE_ISA		3	/* ISA */
>+#define SMBIOS_SYSSLOT_TYPE_PCI		6	/* PCI */
>+#define SMBIOS_SYSSLOT_TYPE_PCMCIA	7	/* PCMCIA */
>+#define SMBIOS_SYSSLOT_TYPE_PCIE	0xa5	/* PCI Express */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEX1	0xa6	/* PCI Express x1 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEX2	0xa7	/* PCI Express x2 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEX4	0xa8	/* PCI Express x4 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEX8	0xa9	/* PCI Express x8 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEX16	0xaa	/* PCI Express x16 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2	0xab	/* PCI Express Gen 2 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X1	0xac	/* PCI Express Gen 2 x1 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X2	0xad	/* PCI Express Gen 2 x2 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X4	0xae	/* PCI Express Gen 2 x4 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X8	0xaf	/* PCI Express Gen 2 x8 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN2X16	0xb0	/* PCI Express Gen 2 x16 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3	0xb1	/* PCI Express Gen 3 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X1	0xb2	/* PCI Express Gen 3 x1 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X2	0xb3	/* PCI Express Gen 3 x2 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X4	0xb4	/* PCI Express Gen 3 x4 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X8	0xb5	/* PCI Express Gen 3 x8 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16	0xb6	/* PCI Express Gen 3 x16 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4	0xb8	/* PCI Express Gen 4 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X1	0xb9	/* PCI Express Gen 4 x1 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X2	0xba	/* PCI Express Gen 4 x2 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X4	0xbb	/* PCI Express Gen 4 x4 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8	0xbc	/* PCI Express Gen 4 x8 */
>+#define SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16	0xbd	/* PCI Express Gen 4 x16 */
>+
>+/* Slot Data Bus Width */
>+#define SMBIOS_SYSSLOT_WIDTH_OTHER	1
>+#define SMBIOS_SYSSLOT_WIDTH_UNKNOWN	2
>+#define SMBIOS_SYSSLOT_WIDTH_8BIT	3
>+#define SMBIOS_SYSSLOT_WIDTH_16BIT	4
>+#define SMBIOS_SYSSLOT_WIDTH_32BIT	5
>+#define SMBIOS_SYSSLOT_WIDTH_64BIT	6
>+#define SMBIOS_SYSSLOT_WIDTH_128BIT	7
>+#define SMBIOS_SYSSLOT_WIDTH_1X		8
>+#define SMBIOS_SYSSLOT_WIDTH_2X		9
>+#define SMBIOS_SYSSLOT_WIDTH_4X		10
>+#define SMBIOS_SYSSLOT_WIDTH_8X		11
>+#define SMBIOS_SYSSLOT_WIDTH_12X	12
>+#define SMBIOS_SYSSLOT_WIDTH_16X	13
>+#define SMBIOS_SYSSLOT_WIDTH_32X	14
>+
>+/* Current Usage */
>+#define SMBIOS_SYSSLOT_USAGE_OTHER	1
>+#define SMBIOS_SYSSLOT_USAGE_UNKNOWN	2
>+#define SMBIOS_SYSSLOT_USAGE_AVAILABLE	3
>+#define SMBIOS_SYSSLOT_USAGE_INUSE	4
>+#define SMBIOS_SYSSLOT_USAGE_NA		5
>+
>+/* Slot Length */
>+#define SMBIOS_SYSSLOT_LENG_OTHER	1
>+#define SMBIOS_SYSSLOT_LENG_UNKNOWN	2
>+#define SMBIOS_SYSSLOT_LENG_SHORT	3
>+#define SMBIOS_SYSSLOT_LENG_LONG	4
>+#define SMBIOS_SYSSLOT_LENG_2_5INDRV	5
>+#define SMBIOS_SYSSLOT_LENG_3_5INDRV	6
>+
>+/*  Slot Characteristics 1 */
>+#define SMBIOS_SYSSLOT_CHAR_UND		1 /* BIT(0) */
>+#define SMBIOS_SYSSLOT_CHAR_5V		2 /* BIT(1) */
>+#define SMBIOS_SYSSLOT_CHAR_3_3V	4 /* BIT(2) */
>+#define SMBIOS_SYSSLOT_CHAR_SHARED	8 /* BIT(3) */
>+#define SMBIOS_SYSSLOT_CHAR_PCCARD16	16 /* BIT(4) */
>+#define SMBIOS_SYSSLOT_CHAR_PCCARDBUS	32 /* BIT(5) */
>+#define SMBIOS_SYSSLOT_CHAR_PCCARDZV	64 /* BIT(6) */
>+#define SMBIOS_SYSSLOT_CHAR_PCCARDMRR	0x80 /* BIT(7) */
>+
>+/* Slot Characteristics 2 */
>+#define SMBIOS_SYSSLOT_CHAR_PCIPME	1 /* BIT(0) */
>+#define SMBIOS_SYSSLOT_CHAR_HOTPLUG	2 /* BIT(1) */
>+#define SMBIOS_SYSSLOT_CHAR_PCISMB	4 /* BIT(2) */
>+#define SMBIOS_SYSSLOT_CHAR_PCIBIF	8 /* BIT(3) */
>+#define SMBIOS_SYSSLOT_CHAR_ASYNCRM	16 /* BIT(4) */
>+#define SMBIOS_SYSSLOT_CHAR_FBCXL1	32 /* BIT(5) */
>+#define SMBIOS_SYSSLOT_CHAR_FBCXL2	64 /* BIT(6) */
>+#define SMBIOS_SYSSLOT_CHAR_FBCXL3	0x80 /* BIT(7) */
>+
>+/* Slot segment group number */
>+#define SMBIOS_SYSSLOT_SGGNUM_UND	0
>+
> #endif /* _SMBIOS_DEF_H_ */
>diff --git a/lib/smbios=2Ec b/lib/smbios=2Ec
>index 7c9701a57f9=2E=2E55350d00067 100644
>--- a/lib/smbios=2Ec
>+++ b/lib/smbios=2Ec
>@@ -66,11 +66,47 @@ struct map_sysinfo {
>=20
> static const struct map_sysinfo sysinfo_to_dt[] =3D {
> 	{ =2Esi_node =3D "system", =2Esi_str =3D "product", =2Edt_str =3D "mode=
l", 2 },
>-	{ =2Esi_node =3D "system", =2Esi_str =3D "manufacturer", =2Edt_str =3D =
"compatible", 1 },
>-	{ =2Esi_node =3D "baseboard", =2Esi_str =3D "product", =2Edt_str =3D "m=
odel", 2 },
>-	{ =2Esi_node =3D "baseboard", =2Esi_str =3D "manufacturer", =2Edt_str =
=3D "compatible", 1 },
>+	{ =2Esi_node =3D "system", =2Esi_str =3D "manufacturer",
>+	  =2Edt_str =3D "compatible", 1 },
>+	{ =2Esi_node =3D "baseboard", =2Esi_str =3D "product",
>+	  =2Edt_str =3D "model", 2 },
>+	{ =2Esi_node =3D "baseboard", =2Esi_str =3D "manufacturer",
>+	  =2Edt_str =3D "compatible", 1 },
>+	{ =2Esi_node =3D "system-slot", =2Esi_str =3D "slot-type",
>+	  =2Edt_str =3D "device_type", 0},
>+	{ =2Esi_node =3D "system-slot", =2Esi_str =3D "segment-group-number",
>+	  =2Edt_str =3D "linux,pci-domain", 0},
> };
>=20
>+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
>+static const struct pci_attr_lookup_table pci_attr[] =3D {
>+	{ "pci-host-ecam-generic", SMBIOS_SYSSLOT_TYPE_PCIE,
>+	  SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
>+	  SMBIOS_SYSSLOT_CHAR_3_3V, SMBIOS_SYSSLOT_CHAR_PCIPME },
>+	{ "pci-host-cam-generic", SMBIOS_SYSSLOT_TYPE_PCI,
>+	  SMBIOS_SYSSLOT_WIDTH_32BIT, SMBIOS_SYSSLOT_LENG_SHORT,
>+	  SMBIOS_SYSSLOT_CHAR_5V | SMBIOS_SYSSLOT_CHAR_3_3V,
>+	  SMBIOS_SYSSLOT_CHAR_PCIPME },
>+	{ "pci-host-thunder-ecam", SMBIOS_SYSSLOT_TYPE_PCIEGEN3,
>+	  SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
>+	  SMBIOS_SYSSLOT_CHAR_3_3V,
>+	  SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
>+	{ "pci-host-octeontx-ecam", SMBIOS_SYSSLOT_TYPE_PCIEGEN3X16,
>+	  SMBIOS_SYSSLOT_WIDTH_16X, SMBIOS_SYSSLOT_LENG_LONG,
>+	  SMBIOS_SYSSLOT_CHAR_3_3V,
>+	  SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
>+	{ "pci-host-thunder-pem", SMBIOS_SYSSLOT_TYPE_PCIEGEN4X8,
>+	  SMBIOS_SYSSLOT_WIDTH_8X, SMBIOS_SYSSLOT_LENG_LONG,
>+	  SMBIOS_SYSSLOT_CHAR_3_3V,
>+	  SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG },
>+	{ "pci-host-octeontx2-pem", SMBIOS_SYSSLOT_TYPE_PCIEGEN4X16,
>+	  SMBIOS_SYSSLOT_WIDTH_16X, SMBIOS_SYSSLOT_LENG_LONG,
>+	  SMBIOS_SYSSLOT_CHAR_3_3V,
>+	  SMBIOS_SYSSLOT_CHAR_PCIPME | SMBIOS_SYSSLOT_CHAR_HOTPLUG |
>+	  SMBIOS_SYSSLOT_CHAR_PCIBIF },
>+};
>+#endif
>+
> /**
>  * struct smbios_ctx - context for writing SMBIOS tables
>  *
>@@ -222,6 +258,7 @@ static int smbios_get_val_si(struct smbios_ctx * __ma=
ybe_unused ctx,
> {
> #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
> 	int val;
>+	const struct map_sysinfo *nprop;
>=20
> 	if (!ctx->dev)
> 		return val_def;
>@@ -240,6 +277,11 @@ static int smbios_get_val_si(struct smbios_ctx * __m=
aybe_unused ctx,
> 	 */
> 	if (!ofnode_read_u32(ofnode_root(), prop, &val))
> 		return val;
>+
>+	/* If the node is still missing, try with the mapping values */
>+	nprop =3D convert_sysinfo_to_dt(ctx->subnode_name, prop);
>+	if (!ofnode_read_u32(ofnode_root(), nprop->dt_str, &val))
>+		return val;
> #endif
> 	return val_def;
> }
>@@ -856,6 +898,222 @@ static int smbios_write_type7(ulong *current, int h=
andle,
> 	return len;
> }
>=20
>+static void smbios_lookup_pci_attr(struct smbios_ctx *ctx,
>+				   struct smbios_type9 *t)
>+{
>+	const char *compatible;
>+	u32 addr_cells, size_cells, total_cells;
>+	const fdt32_t *reg;
>+	int reglen;
>+	int i;
>+
>+	/* default attributes */
>+	t->slot_type =3D SMBIOS_SYSSLOT_TYPE_PCI;
>+	t->slot_data_bus_width =3D SMBIOS_SYSSLOT_WIDTH_UNKNOWN;
>+	t->slot_characteristics_1 =3D SMBIOS_SYSSLOT_CHAR_UND;
>+	t->current_usage =3D SMBIOS_SYSSLOT_USAGE_UNKNOWN;
>+	t->slot_length =3D SMBIOS_SYSSLOT_LENG_UNKNOWN;
>+	t->segment_group_number =3D smbios_get_val_si(ctx, "segment-group-numbe=
r",
>+						    SYSID_NONE,
>+						    SMBIOS_SYSSLOT_SGGNUM_UND);
>+
>+	/*
>+	 * Get #address-cells and #size-cells dynamically
>+	 * Default 3 for #address-cells and 2 for #size-cells
>+	 */
>+	addr_cells =3D ofnode_read_u32_default(ctx->node, "#address-cells", 3);
>+	size_cells =3D ofnode_read_u32_default(ctx->node, "#size-cells", 2);
>+	total_cells =3D addr_cells + size_cells;
>+
>+	/* Read property 'reg' from the node */
>+	reg =3D ofnode_read_prop(ctx->node, "reg", &reglen);
>+	if (reg && reglen > addr_cells * sizeof(*reg)) {
>+		/* First address-cell: Bus Number */
>+		if (addr_cells >=3D 1)
>+			t->bus_number =3D fdt32_to_cpu(reg[0]);
>+		/* Second address-cell: Device/Function */
>+		if (addr_cells >=3D 2)
>+			t->device_function_number=2Edata =3D fdt32_to_cpu(reg[1]);
>+		/*
>+		 * Third address-cell 'Register Offset' and the following
>+		 * size-cell bytes are not useful for SMBIOS type 9, just
>+		 * ignore them=2E
>+		 */
>+		/*
>+		 * As neither PCI IRQ Routing Table ($PIRQ) nor FDT
>+		 * property to represent a Slot ID, try to derive a
>+		 * Slot ID programmatically=2E
>+		 */
>+		t->slot_id =3D t->device_function_number=2Efields=2Edev_num |
>+			     (t->bus_number << 5);
>+	}
>+
>+	/* Read 'compatible' property */
>+	compatible =3D ofnode_read_string(ctx->node, "compatible");
>+	if (!compatible)
>+		return;
>+
>+	for (i =3D 0; i < ARRAY_SIZE(pci_attr); i++) {
>+		if (strstr(compatible, pci_attr[i]=2Estr)) {
>+			t->slot_type =3D pci_attr[i]=2Eslot_type;
>+			t->slot_data_bus_width =3D pci_attr[i]=2Edata_bus_width;
>+			t->slot_length =3D pci_attr[i]=2Eslot_length;
>+			t->slot_characteristics_1 =3D pci_attr[i]=2Echara1;
>+			t->slot_characteristics_2 =3D pci_attr[i]=2Echara2;
>+			/* mark it as in-use arbitrarily */
>+			t->current_usage =3D SMBIOS_SYSSLOT_USAGE_INUSE;
>+			return;
>+		}
>+	}
>+}
>+
>+static void smbios_write_type9_fields(struct smbios_ctx *ctx,
>+				      struct smbios_type9 *t)
>+{
>+	t->slot_type =3D smbios_get_val_si(ctx, "slot-type", SYSID_NONE,
>+					 SMBIOS_SYSSLOT_TYPE_UNKNOWN);
>+	t->slot_data_bus_width =3D
>+		smbios_get_val_si(ctx, "data-bus-width",
>+				  SYSID_NONE, SMBIOS_SYSSLOT_WIDTH_UNKNOWN);
>+	t->current_usage =3D smbios_get_val_si(ctx, "current-usage", SYSID_NONE=
,
>+					     SMBIOS_SYSSLOT_USAGE_UNKNOWN);
>+	t->slot_length =3D smbios_get_val_si(ctx, "slot-length", SYSID_NONE,
>+					   SMBIOS_SYSSLOT_LENG_UNKNOWN);
>+	t->slot_id =3D smbios_get_val_si(ctx, "slot-id", SYSID_NONE, 0);
>+	t->slot_characteristics_1 =3D
>+		smbios_get_val_si(ctx, "slot-characteristics-1", SYSID_NONE,
>+				  SMBIOS_SYSSLOT_CHAR_UND);
>+	t->slot_characteristics_2 =3D smbios_get_val_si(ctx,
>+						      "slot-characteristics-2",
>+						      SYSID_NONE, 0);
>+	t->segment_group_number =3D smbios_get_val_si(ctx, "segment-group-numbe=
r",
>+						    SYSID_NONE, 0);
>+	t->bus_number =3D smbios_get_val_si(ctx, "bus-number", SYSID_NONE, 0);
>+	t->device_function_number=2Edata =3D
>+		smbios_get_val_si(ctx, "device-function-number", SYSID_NONE, 0);
>+}
>+
>+static int smbios_write_type9_1slot(ulong *current, int handle,
>+				    struct smbios_ctx *ctx, u8 devtype)
>+{
>+	struct smbios_type9 *t;
>+	int len =3D sizeof(*t);
>+	u8 pgroups_cnt;
>+	u8 *eos_addr;
>+	size_t pgroups_size;
>+	void *wp;
>+
>+	pgroups_cnt =3D smbios_get_val_si(ctx, "peer-grouping-count",
>+					SYSID_NONE, 0);
>+	pgroups_size =3D pgroups_cnt * SMBIOS_TYPE9_PGROUP_SIZE;
>+
>+	/*
>+	 * reserve the space for the dynamic bytes of peer_groups=2E
>+	 * TODO:
>+	 * peer_groups =3D <peer_grouping_count> * SMBIOS_TYPE9_PGROUP_SIZE
>+	 */
>+	len +=3D pgroups_size;
>+
>+	t =3D map_sysmem(*current, len);
>+	memset(t, 0, len);
>+
>+	fill_smbios_header(t, SMBIOS_SYSTEM_SLOTS, len, handle);
>+
>+	/* eos is at the end of the structure */
>+	eos_addr =3D (u8 *)t + len - sizeof(t->eos);
>+	smbios_set_eos(ctx, eos_addr);
>+
>+	/* Write the general fields */
>+	t->peer_grouping_count =3D pgroups_cnt;
>+	t->socket_design =3D smbios_add_prop_si(ctx, "socket-design", SYSID_NON=
E,
>+					      NULL);
>+	t->electrical_bus_width =3D smbios_get_val_si(ctx, "data-bus-width",
>+						    SYSID_NONE, 0);
>+
>+	/* skip the reserved peer groups and write the following fields from eo=
s */
>+	/* t->slot_height */
>+	wp =3D eos_addr - sizeof(t->slot_height);
>+	*((u8 *)wp) =3D smbios_get_val_si(ctx, "slot-height", SYSID_NONE, 0);
>+	/* t->slot_pitch */
>+	wp -=3D sizeof(t->slot_pitch);
>+	*((u16 *)wp) =3D smbios_get_val_si(ctx, "slot-pitch", SYSID_NONE, 0);
>+	/* t->slot_physical_width */
>+	wp -=3D sizeof(t->slot_physical_width);
>+	*((u8 *)wp) =3D smbios_get_val_si(ctx, "slot-physical-width", SYSID_NON=
E, 0);
>+	/* t->slot_information */
>+	wp -=3D sizeof(t->slot_information);
>+	*((u8 *)wp) =3D smbios_get_val_si(ctx, "slot-information", SYSID_NONE, =
0);
>+
>+	/* For PCI, some fields can be extracted from FDT node */
>+	if (devtype =3D=3D SMBIOS_SYSSLOT_TYPE_PCI)
>+		/* Populate PCI attributes from existing PCI properties */
>+		smbios_lookup_pci_attr(ctx, t);
>+	else if (devtype =3D=3D SMBIOS_SYSSLOT_TYPE_UNKNOWN) {
>+		/* Properties that expected in smbios subnode 'system-slot' */
>+		smbios_write_type9_fields(ctx, t);
>+	}
>+	len =3D t->hdr=2Elength + smbios_string_table_len(ctx);
>+	*current +=3D len;
>+	unmap_sysmem(t);
>+
>+	return len;
>+}
>+
>+static int smbios_write_type9(ulong *current, int handle,
>+			      struct smbios_ctx *ctx)
>+{
>+	int len =3D 0;
>+	struct smbios_ctx ctx_bak;
>+	ofnode child;
>+	const struct map_sysinfo *prop;
>+
>+	/* TODO: Get system slot information via pci subsystem */
>+	if (!IS_ENABLED(CONFIG_OF_CONTROL))
>+		return 0;	/* Error, return 0-length */
>+
>+	memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
>+
>+	/* write the properties if any subnode exists under 'system-slot' */
>+	for (child =3D ofnode_first_subnode(ctx->node); ofnode_valid(child);
>+	     child =3D ofnode_next_subnode(child)) {
>+		ctx->node =3D child;
>+		len +=3D smbios_write_type9_1slot(current, handle++, ctx,
>+						SMBIOS_SYSSLOT_TYPE_UNKNOWN);
>+		memcpy(ctx, &ctx_bak, sizeof(*ctx));
>+	}
>+
>+	if (len)
>+		return len;
>+
>+	/* if no subnode of 'system-slot', try scan the entire FDT */
>+	prop =3D convert_sysinfo_to_dt(ctx->subnode_name, "slot-type");
>+	for (child =3D ofnode_first_subnode(ofnode_root()); ofnode_valid(child)=
;
>+	     child =3D ofnode_next_subnode(child)) {
>+		const char *dev_type_str;
>+		u8 dev_type =3D SMBIOS_SYSSLOT_TYPE_UNKNOWN;
>+
>+		dev_type_str =3D ofnode_read_string(child, prop->dt_str);
>+		if (!dev_type_str)
>+			continue;
>+
>+		if (!strcmp(dev_type_str, "pci"))
>+			dev_type =3D SMBIOS_SYSSLOT_TYPE_PCI;
>+		else if (!strcmp(dev_type_str, "isa"))
>+			dev_type =3D SMBIOS_SYSSLOT_TYPE_ISA;
>+		else if (!strcmp(dev_type_str, "pcmcia"))
>+			dev_type =3D SMBIOS_SYSSLOT_TYPE_PCMCIA;
>+		else
>+			continue;
>+
>+		ctx->node =3D child;
>+		len +=3D smbios_write_type9_1slot(current, handle++, ctx,
>+						dev_type);
>+		memcpy(ctx, &ctx_bak, sizeof(*ctx));
>+	}
>+
>+	return len;
>+}
>+
> #endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
>=20
> static int smbios_write_type32(ulong *current, int handle,
>@@ -902,6 +1160,9 @@ static struct smbios_write_method smbios_write_funcs=
[] =3D {
> 	{ smbios_write_type7, "cache", },
> #endif
> 	{ smbios_write_type4, "processor"},
>+#if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
>+	{ smbios_write_type9, "system-slot"},
>+#endif
> 	{ smbios_write_type32, },
> 	{ smbios_write_type127 },
> };

