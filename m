Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4978C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0226584AC0;
	Wed,  8 Jul 2026 14:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxUl3/6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C479584942; Wed,  8 Jul 2026 09:56:03 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A62B838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 09:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Jayaramudu.Desapogu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnn4qpc+8Ks4Aie7/2lf8/96soyMvo9L0j3VAx0BQITDVb9mmpk0ymPuZuLRh2QiNop22wkktTrIItCo955/r5ENLsqTWMBS7p0dKkKgAMie+0uhcDvNvi/FK6k2zd0ZAczDpPy5sjU8CvUOrhzk3Qjvii7FrZm3wEkzAXZt60sU699TlnjsPnRpqHbi7XsEC3vdjlMZGscPdUtY2y0UtOZlOqUY8/62WIjWjWyKnBpsvlnIAdjwsxZjPrq66v7aHDrVXMLxn50uaHZ0tpDL3v7qxTegdJK7fjCqNGQRk95vcpQw2my08+CjO+v9Zb+DqOD6XBhAwNV88yOITaREzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3RKfiPNz1I3JOh/sNWCn2JLJVZJlFfnRcEQYwSYpS8=;
 b=n++DjFt1mZjYg6+2UjEhZ/0JKl0EWTVmHx2TUOQia6g/NFuJklMgEL+HRp1At9ufO2/ci5mIN1i8UxNyN89tNqZida30N8LdhnQvS48BLBb8yD7f4h6jUUQT08WI/qL6E9sjtdmSTt1JRsaOwVXVenDyeg53ZjYmxvRblhCBYspzLKJAYyiqUWTiJaKkyUgfLnX2YSG/RgpimvAGaLLG+Yzp9hfELS7l2rZu6tU1/1uN7+FJ5W8u645KA3g5BsYlm+twywlfLVQ8hBZd0yRCYB82VbEg/lgRvrMLQN6HI5AuCZhdHV4cjdwXukq3gdoERqN9NsfNBMcHbjbrBrHUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3RKfiPNz1I3JOh/sNWCn2JLJVZJlFfnRcEQYwSYpS8=;
 b=zxUl3/6m7Mwkp1hE3OOltvJFoyTK4UyBlWxg38K2y3TRMIhK0Qc0RF/dWFll9gITWcvrjy61f4u1xcX3KsTgLNakOtqwpzRQzgK6C9QJWZjX0N4alnS/lF2tIKLijh6MUTJd9IKXjE2j9NAfmkk6kNkmdMaozgPPOJtfXdY3oZ8=
Received: from LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 07:55:54 +0000
Received: from LV8PR12MB9360.namprd12.prod.outlook.com
 ([fe80::75a4:7817:3fe:f0b1]) by LV8PR12MB9360.namprd12.prod.outlook.com
 ([fe80::75a4:7817:3fe:f0b1%3]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 07:55:54 +0000
From: "Desapogu, Jayaramudu" <Jayaramudu.Desapogu@amd.com>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: RE: [PATCH] video: fix no display when serial console is disabled
Thread-Topic: [PATCH] video: fix no display when serial console is disabled
Thread-Index: AQHc810p2niv5I3TYkW3LFYonqZzDbZjda5w
Date: Wed, 8 Jul 2026 07:55:54 +0000
Message-ID: <LV8PR12MB93602C400E0DC621AAED473FE4FF2@LV8PR12MB9360.namprd12.prod.outlook.com>
References: <20260603132953.36042-1-jayaramudu.desapogu@amd.com>
In-Reply-To: <20260603132953.36042-1-jayaramudu.desapogu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-08T07:48:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR12MB9360:EE_|BY5PR12MB4179:EE_
x-ms-office365-filtering-correlation-id: fdeca86c-400c-4781-e920-08dedcc65668
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|6133799003|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: i1BNWFx+0I+GWiCzxhtMjnXQpoiN0mZru/g993x/C94GjG9SU6qmN5mAmF3q4z79m8X2iDCNDN7UAat6mYcSfo9zerF3r8pvhUTJjwBnUY4vb5L8wD9NcBFYPzkU6+Rd3SaVqU9MQkADUW2z5i4wLXxiprqbA74/2V1lbhQ2o5A8EfkfyEPXGKSBKL3nosV12pVsRlPb0+jwPu5ZzqiBsb3hcwsXSRzhgBWtuleso/Ja+YaTPrhPLO8OqslSnAvdKJzswOmuDgIjB/jefzfM9boNlymnW3rHIYp1R5v+Se2Q6011o+5QDolIbXdYVIeJtPCvw+EdL1ZZw+gKIlhU1FCeVYfkwU7Qtnrkzihi+WAXZ+m8b5yYDET7RiCpC6nlGw3MoOR5FwYAUlzR9bylKtsFOcBYn5EtgEdplwKgZL1Et8O8dBKFeCD3tKXU4aB4996q4cVGuVw40kTal11ACVWH6Ku0SpzQkX2xsmHvzraEjXWhTsVHL018JRMYOoUhz8FUq3JjRuvcVU6KaqKwdURnsWFkKUCXBHQfxNlBpB8NtdWA0GYaq1yijzX1TyjTIca8TzLr+kdVU1tEvclf+gLeXS/mU0c9Stl+117J5r730x2yG5k2tQBJjKqhfG4Ag/v6UIeZulYFwyGUL5AnQgDtYGl+RhxzTZl7AAkbULw+h9lJC5kfTACMdXZqIhwUNgV617nBGW1uXj/v/SJZcHl1nhSPjoyrLtII7+1btfY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9360.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?osgzy44MHDxgqdvzjWAntj9rK4fiQdY3HaFHg2wDBffjE3X+gp7DpRlvhYCb?=
 =?us-ascii?Q?E9o3h4/UKrstjiHORQUa4o/WRjpmHFokl7vw+sXxJkJ+TquNNkkF4vpeSmxC?=
 =?us-ascii?Q?cOi1EoJ64t3zeDsnEz1ZtsTmMNE7/qzf45d5ScTTns7vlcSIINfLg6DqHAZp?=
 =?us-ascii?Q?H3IXpZY4IA7J6hm+gj3qy74dWQqg+kKlecAF3hBx+Nrf8Rs2fRC5PaKSRdZM?=
 =?us-ascii?Q?8j7QXx6NEuuH5Ctz8pAGRdbId9ysQR7ICyHtLMurta2zJ8l2pW6XHdUcs0fK?=
 =?us-ascii?Q?3jEX2gojR3AD+LuqvbXYAimNInzVvxu46coN36hMr/OjFfqDtjZU1169Z3T9?=
 =?us-ascii?Q?9nUJ+1y2mAt8RW4L3vSN/jql7qVbprD0ZK1cnkwU3eUWF01PQL7QcGfB5F7p?=
 =?us-ascii?Q?XJ3AouyDDoqaM6GJZaPc3NkNMdhFEsSfUopKw15yNGrBFYAyuMYFhxx6kYH7?=
 =?us-ascii?Q?323OAYcnTZMEKwh4bZ5oPXu4EQ5fCDCtNyOh6c2hqHu7ZfN0kYqO0ZHZXhFM?=
 =?us-ascii?Q?eWw1qCrkMtQ/baf0gCz2k/R/60ZNUfc0ynFIjMMWk3mQJCFCrZjT7yx2sPY9?=
 =?us-ascii?Q?0PrzFQJkz8kX6jrQCSPv4rdK1dry//Au0K3ZPeIdE5Vze1cXodroNXsLuQwU?=
 =?us-ascii?Q?jTmQJWQvLl/Oj44twF5aZv6P4dPkmrvUfP601QaZGgURrMGoAPSFTiGVknN1?=
 =?us-ascii?Q?S0tGzGqDyySdDSOkc9nPMC+WwYH5hWnaH5Bar8JlBulaUWfxYbX6g0u92D0F?=
 =?us-ascii?Q?XjOcumHI64RvmtggG9eEVRvluObnICO+u9qt5keTVXOFyVT6WanChLRXk77P?=
 =?us-ascii?Q?iC9l/l8/Ex/a9nHu/AIWe4rfrMshIw9TUMu9UsCaIMMup61AEoZXA8nbmzWx?=
 =?us-ascii?Q?wJwazzbPc3dYP4QyontUKkK2hIzyMZsQR4EiqxCIaj7COmAzEyelAOI2WtYL?=
 =?us-ascii?Q?ok9hA8okbk9Ivxywi0KPO/RTIrf3r+gMDYXeRWTALTHdUdqfUHoHeJkAuTBk?=
 =?us-ascii?Q?UK7g0yRypr6ZLlvl0NtLBHn7RXdePxrKsWhuZ4WlBotoQE0G8udWC5YX6Wqu?=
 =?us-ascii?Q?nUSTl7hqfMqUX6ejZunyjs9tZ2gFRvcv89PGJCkz2aua1apxdChdvmp5Bsf3?=
 =?us-ascii?Q?f34wDRQI3qyLJ56eKA82rMMwB+JZITGge+ATzoJzfJiVyKOyfvPFZCdvY28K?=
 =?us-ascii?Q?eMcCfLP87nSfRMJAX8psvjU+grb+2BPavTyLHS115XgYQakphisi2XKoHjmJ?=
 =?us-ascii?Q?xwPC2HR0CJN/XuLBV68uYWcmJd9Z5l+935EflhQOBUlWYcYnhEHKUQfPBUIk?=
 =?us-ascii?Q?5NKXT3doiD+FkOnFoV7T0zRM8s4OCQKUgvFkRXIby+8tMa8vAzPffjdrS+4H?=
 =?us-ascii?Q?fB1CB5dUDHKS64LAJq7qiMAfN+P/foUQVnExTCNn/cNfeVOxSxCZ6/YZgx2L?=
 =?us-ascii?Q?k4O3YV/XaRJpDdRj3YqDPhsrGfs0ulrdqul5LGtIHE4BshJhXBjh6HM1OSu3?=
 =?us-ascii?Q?+12fnysxnzphPjdw8o0MRDEHFpelKEHMuU6lUduaZsXk8UWKceFHPUUjJFwh?=
 =?us-ascii?Q?he6vrgjPw0796ttKNS9Rq68uSe4cEzSPxf7JonyGAH64wf278kshmzkyrzK6?=
 =?us-ascii?Q?CtLwKnlRMJcGPGZr2Oc8P0qYq72MnfVulZkr6s2H8DZRwBnYP2TTA4iihstG?=
 =?us-ascii?Q?g1kaMRvDPHcK0/0QaTaDDEgJpQ4JlYWF+4UeJ4oZNPYiDXoG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9360.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeca86c-400c-4781-e920-08dedcc65668
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 07:55:54.4472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDGQhMMp53d54rVNHcfjtkAAwsMrnIm2aWVitNGRUnWgimKRUKkgtaYyfhVGYBO7yIfCRYz/fxswUW7V8zTaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

AMD General

Hi ,

Gentle ping for this patch.

Could someone please take a look when time permits?

Thanks,
Jayaram

-----Original Message-----
From: Desapogu, Jayaramudu <Jayaramudu.Desapogu@amd.com>
Sent: Wednesday, June 3, 2026 7:00 PM
To: sjg@chromium.org
Cc: u-boot@lists.denx.de; Desapogu, Jayaramudu <Jayaramudu.Desapogu@amd.com=
>
Subject: [PATCH] video: fix no display when serial console is disabled

When the serial console is disabled in coreboot configuration, no display o=
utput is observed during boot.

This happens because DBG2 (Debug Port 2 table) configuration is required fo=
r proper UART initialization and affects the video initialization path.

Fix this by ensuring DBG2 is correctly configured as a 16550-compatible UAR=
T, allowing video initialization to proceed independently of serial console=
 settings.

Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
---
 include/acpi/acpi_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h index 48=
95366a618..3517698ff3e 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -667,7 +667,7 @@ struct __packed acpi_dmar {

 /* Subtypes for port_subtype field */

-#define ACPI_DBG2_16550_COMPATIBLE     0x0000
+#define ACPI_DBG2_16550_COMPATIBLE     0x0012
 #define ACPI_DBG2_16550_SUBSET         0x0001
 #define ACPI_DBG2_ARM_PL011            0x0003
 #define ACPI_DBG2_ARM_SBSA_32BIT       0x000D
--
2.25.1

