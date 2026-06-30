Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14267C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2692E84ACD;
	Tue, 30 Jun 2026 14:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XM/d0qpL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE9A84A4F; Tue, 30 Jun 2026 08:56:23 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EFC084979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhmhhT5xOXrV5dWCvhXriHz2JAyvVwk/BkZEijoA1mRkDMB0Fg8G3g21BeEwGj0hL0S8afbbtF7iqKKelXj5fok4t6UT3AGFIbSmBZMDh3GwxXWgXb2GbL6ItEC+SMa7+exmAGK3uUBLiJK5fGuVQESE+4bV7HSIvjFJ8PVXfhYRBPzX5K28HdftK6XXMHPXXs63bTcNMAI+oV9ytg30q+mi6XHcaiZ7Sbs/yqtL7QyiN1O1PYNb/Rak1FLr97uwHLIV7NRZTukXwwpUbf2lFUKR1paK3JpbdtmiRCZeRPX2bk77ffZW4xJV4JqLwhiyuZ9kuIcZRni6zyP/t/dGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0WpDvHzqjaqatMBOwVFVW3gdZdPK01jADvb455+p+w=;
 b=VbYmwdOPnpF1ydrVAM1+jqo+6pAAosFmmsN/oyaJtVe9KEbKFx/2oTgEG1JSMjtOPFaxKbdfkErD1O98CiBOUbYw2nvCSsjS5ih4Mt2B2nkTtPeYW96CLYuZV+5MRzKi/crLm5Qw8YPBXnAZiNF41/bWrveSEarMLwh7dUQoezXTMoPLvaSP879GwgyrzOKvNYOWEmqCsP9M3zoQEJQIWsYMlaw0AziWfzYRJhmictcFt5dX4Ac3ZcI6rN1LOn0bQDHF5i6waYDHPl20GHq/W5NTea7xAsbyLWZOZk1HU/VFqgVE2uMLemnS7eWD7M6+cgVtMM3nvE4FNXlHgEjgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0WpDvHzqjaqatMBOwVFVW3gdZdPK01jADvb455+p+w=;
 b=XM/d0qpL4qnVJdPT/jV1Ga/CpMLm/a1T4A/XXbTqdQ5zsXF29KEdLPz/3RNE1HTz/S9It5XXt8ujrQK0eecswc6pJ9r/pzWUN24VOYj0jJZ4MLGPa1/7M56k5xe5SgFdEfaAyfRrQzIQnKCbLjMTR89EehTuyaiqYoyl2oSl8gFJr5UjmXajQDQGauRF02bPbPoDV+BN3tG77dByPnt3uAxvcRm/BjzuMDccjUVMvOVNO2pDNSszxZQ3D5KY2WijjWo7XTmspdSwjhmlIB/nLrXazUJf1b/D39hhtjAqAkFE2i86pc/2OJCARj2VQaGgyltbhuZVDmzaOdSR0iZGEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MN2PR03MB5085.namprd03.prod.outlook.com (2603:10b6:208:1ab::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:56:18 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:56:18 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Fabio Estevam <festevam@gmail.com>, E Shattow <e@freeshell.de>,
 briansune <briansune@gmail.com>
Subject: [PATCH 3/8] misc: socfpga: Add RSU driver-model anchor device
Date: Tue, 30 Jun 2026 14:55:19 +0800
Message-Id: <20260630065524.27680-4-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260630065524.27680-1-dinesh.maniyam@altera.com>
References: <20260630065524.27680-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MN2PR03MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1439fe-cdd6-4fb7-9c6b-08ded674af9d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|11063799006|6133799003|22082099003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info: iRPfBufAjyL1yd/gaTeVM1fAw1dtuO/MR0gUiUu3yWhGSeqXfx+mAlxU0bCybmkq1MlN/OsrQ9cYHiGhQrP0Kg7IKuQfkBSZTVRqIZQ8tnLhW/FfXn+VTzOgkCXWpAQ87RlzutwlN2qSwB4AOGSJCbldB8vgB13STuBesrNhTQ+iqZHVx8nRhYJHymiBFUl8kIcXNd7Qx9wKQTJCyPfM2qOKcnYp744qdmhUrLh7d3JF+LZy7NDxg/+36iUPmgP2RSDcOkJpxa5f2UdUPYO18u9ufPhC+WI7e4xNxDoL/GiGkIXNEYDqsTBzj6Y2dIugY0AuKLyYcP4yuC7C9IAoNRdUC5uvQYf3blIGqEHhsbu0md2T7/CkMBCl3+p0kdITYP9OWk+I0xgygOoPwV0RpCya3osyrZ0HUZZMef7Ehkj53cPDj+PMrsvz1C0eIgto23IC0rSubp/jOm8VGUSgwPrUv2ravE0wBR77WWoIbsJacXB0U71UchTheTZHRkHRIqscPd6K+lQms7rqy27ngS8o71nqM7+2utv1iq9ZeBPKgZRSGzIy4+UjSLSgI7oNWIiqU+fCy+8Z9ENUNuvw2CtG2hDIOx9m+vsQGojlR3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(11063799006)(6133799003)(22082099003)(56012099006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bENGY2M1bzg2Z2Fudyt5Vjg4SWJzWU9Zd1AzNnNjYjJhTHNYbDRrM2NJSXl5?=
 =?utf-8?B?MTVkVjhlOE9uYjAxc2JjM2hqY3BvM1ZIY3FESGxyRTE2ZWwrdDNlN2Nwc2JZ?=
 =?utf-8?B?WDZBSkJSRUI4a2lJZmo5WFRRbWZlYkNtdHR2RDVrcDV6QTFrV1crdkcvUWJT?=
 =?utf-8?B?cDNPYStiY2JhN0R4bkZ4UVJGTGdXK0xsUEQ1RVhrM055ekJQWmtjRlFYckRZ?=
 =?utf-8?B?Zmd1VGcybXZHUGpiK2ErS3BzcU1DV2RrU1R3RU11RXJlMW5YUWorQWl3UVFU?=
 =?utf-8?B?VUMwdEgzeCtFZHEvVjhmKzNmQkFkMlJzSEFCMmNvT0haeGpBbkJJZHR4UHFE?=
 =?utf-8?B?NFUyRnZQNktGczBlZ2J4enZrcWxTVTJlMnhuWXdobE5ubTdIcm9oMFZvcEIv?=
 =?utf-8?B?RmpRaEhEdXZ1c0dlYWNZYlN3QWNGcVpIcW0zRFg4YUVTU2VjdGwyTUlZZlRB?=
 =?utf-8?B?eS9UeTZ1QXhCeHc2Ulkram5sdGt2RnF6bGkwRE5yWXl6bFdDZjBZQm03MnFn?=
 =?utf-8?B?emQ5bHFYYXRVWkVEZzFqQ3c0aS8wWXlCV0ZrUWxaSDVac1dGbFo1S2VHUkYr?=
 =?utf-8?B?dUdZS2V2ODczeC9xWVVQSEhldWFXS25GN1ZZdFc5Tmg4UnlXUWtlM242N3RS?=
 =?utf-8?B?OCtHWjNDUFhFQkZjVkhEY0piMlRLMjNzSUFkNmVVSStwSVRVMHhPVDhZVkph?=
 =?utf-8?B?enpPYXVFaTVGNDlxMitvd1dxS0hWYkk5RTNONjZiRTU2WFg4VUNhVit1T2pW?=
 =?utf-8?B?cERwWktTK0w5aER4QUxZMk5PZWpCOFV4dVdlV213K1hKNC8yU0VGMjdsWVZt?=
 =?utf-8?B?MVVqMTBzMkpBSGhnSmdaMVR4TW10YzlRM3VCMjZnTit0RzZtRTRFcWUwRUR4?=
 =?utf-8?B?SVFOdDdYcUZaeUpTZHROSVpwZ3VwdmpUdmtQSlZ0djQ5V2hhbkhYWFljNlVq?=
 =?utf-8?B?UVNqeFFPU1NTa1BmSlpxeGpZNW00KzdBVlY0R2pybFV4emJvaitSYjc1dEdS?=
 =?utf-8?B?WkZQeG9aT2ZaY1Q5V1pPTFNiSnFUZ3RiZ2ZaMVhFSzh0NzN3d29uU3pYbElm?=
 =?utf-8?B?V3hOYkxSbUQrTmdYNDZxMmZVa3dGSVM5S1ZnS3hsY0V2Tlk0WWRISWJlWEZC?=
 =?utf-8?B?WU9UYU0zdjdTRmg5S1pBSnIxZUZQNm9zcnJOWTBVclM1UUFTNkE0VVR1TXlV?=
 =?utf-8?B?cVQvYU9ieWlRdmF5NXdQZ0Z0OWFzVllEQjdZL1dYTWwyUEpoaFdlY1BSQ2F2?=
 =?utf-8?B?Q1ZLS3lsVmZCWmZaa042UEIzSnRxM1BETHJLZVJIOTBtc2pBQ3VWalhHMjhW?=
 =?utf-8?B?MUxZNG5JZVJHUFcvc3pZSXB4N0V4clBWZEoxdEQ4dXBZajBMdTRWbHBjN01o?=
 =?utf-8?B?VkcyMzBpV2ZVSFgvQVZxNnVwcVhOalNXS1BEa0hoeStvVkxMeGgxbXpYTGwr?=
 =?utf-8?B?UDhVZmtaMDNkb0NROHgzMGRodk5CWUJRSHprQ0VoaVZyaVh1MWEyS3QyTXBW?=
 =?utf-8?B?Zk5YLytiNWhjbEZqRnAwcU8xdXlJZ3VuWXhnTzdjeWJCQmhDYnQvdTRBc0Zt?=
 =?utf-8?B?ejRFdTYxakJJZGx4ZnNzOVB4YVRyb2FSSmh1bmF6ekpadUZEZjk0dytwWDdG?=
 =?utf-8?B?WFV5bUVaWVJpeTBOankyTzZCMzltSmxLdllFSzFDcUNCM1VrdmtPdzB2U2pa?=
 =?utf-8?B?dFRURVh5cmxLV0dtSzNKait2WEhncTd1RG0rQnYzMkk3cTRJakFjMFU5TmRz?=
 =?utf-8?B?b1RmWFUvQkV6WHNNb0NxK2didExxczMxZWorNGVTRzk3WTAyb2l3bDRKamhh?=
 =?utf-8?B?NEY4T3MyTU1vVDluUDVNMzRPbDFreWo0TmFHRHhDWnlrZHgrcTN4MmFPdEFO?=
 =?utf-8?B?Y1FIUFdMSUdyblg4dHdsR0YxK0U4T0tObWlHYTdzWjdxdHNSWG5BOUdDQ2lT?=
 =?utf-8?B?SXVqTDAwazVvOGx1MGRlUzhETjNObytPdzcwZTkvR3dkTXZQRkUxY0hwdTVi?=
 =?utf-8?B?ZUVaUU9Rbm8xcDJMNEtFMm41R0ZZK0xOTmg3TkFSL0ZOcjFlUjRsVWRBRk9k?=
 =?utf-8?B?Z3JNRUR4dDBmSDVYNzVJQWEwSEEwZ0FRVGo1RGFQamRYbGwzTkN0ODF5d1U4?=
 =?utf-8?B?cGRLRnEyMkxrVUNiMUlIM05DNU9kUVNPaTlOUGtUdmRqNkV2Z3NudU0zWXYw?=
 =?utf-8?B?S2ZTRnFzR2dyOTJjRmhMOFhWZjhnSzZBclNoNHZqbDFGTzRoR2QweUdqUVlX?=
 =?utf-8?B?b05NRVV0K3lLZG5ZL0hBTE1rUHk4Y1pLR1E2TzVGcjZvMDhGWUx3ZkdlSkV6?=
 =?utf-8?B?eFlkTnVWUHdoUzNXdVd5YVRMbU1CdUl2TjcvSGdpZURaVVRDMUw3NGNsMlcx?=
 =?utf-8?Q?z2+TlssEtoG5RfCE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1439fe-cdd6-4fb7-9c6b-08ded674af9d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:56:18.6623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlD/1Hic3yTtpgd7MD4nIYAnlekE6HE5Evc1d0vhPipr+JXh2W7COcKNCunyWIU9yiN+uOpS2N9Z6AYqqb8UF/olO9UzGxJEmPBmXj0ESWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5085
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:28 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add a UCLASS_MISC driver bound to the "altr,socfpga-rsu" compatible.
The RSU command layer stores its active low-level session on this
device's private data, so the session state lives on a driver-model
device rather than in a file-scope variable.

The anchor has no MMIO and no flash-controller coupling of its own; the
QSPI flash requirement is enforced by CMD_SOCFPGA_RSU, the only consumer
of the device. Add the binding document and the devicetree node in
socfpga_soc64_u-boot.dtsi, and the SOCFPGA_RSU_DM Kconfig symbol
(default y, selected together with the command).

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga_soc64_u-boot.dtsi        |  5 +++
 .../misc/altr,socfpga-rsu.yaml                | 41 +++++++++++++++++++
 drivers/misc/Kconfig                          | 16 ++++++++
 drivers/misc/Makefile                         |  1 +
 drivers/misc/socfpga_rsu.c                    | 30 ++++++++++++++
 5 files changed, 93 insertions(+)
 create mode 100644 doc/device-tree-bindings/misc/altr,socfpga-rsu.yaml
 create mode 100644 drivers/misc/socfpga_rsu.c

diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
index ce5b37ef547..5ec3c0662e3 100644
--- a/arch/arm/dts/socfpga_soc64_u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
@@ -7,6 +7,11 @@
 
 / {
 	soc@0 {
+		socfpga-rsu {
+			compatible = "altr,socfpga-rsu";
+			bootph-all;
+		};
+
 		socfpga-system-mgr-firewall {
 			compatible = "intel,socfpga-dtreg";
 			#address-cells = <1>;
diff --git a/doc/device-tree-bindings/misc/altr,socfpga-rsu.yaml b/doc/device-tree-bindings/misc/altr,socfpga-rsu.yaml
new file mode 100644
index 00000000000..7b6ea87a8bc
--- /dev/null
+++ b/doc/device-tree-bindings/misc/altr,socfpga-rsu.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+title: Altera SoC FPGA Remote System Update (U-Boot anchor)
+
+description: |
+  Devicetree node used by U-Boot as a driver-model anchor for Remote
+  System Update (RSU) on Altera Stratix 10 / Agilex family SoCs.
+
+  RSU is implemented in firmware (SDM mailbox) and SPI NOR (Cadence
+  QSPI); this node has no MMIO. When CONFIG_SOCFPGA_RSU_DM is enabled,
+  U-Boot binds a UCLASS_MISC driver to this compatible and stores the
+  active RSU low-level session on the device private data.
+
+maintainers:
+  - Tien Fong Chee <tien.fong.chee@altera.com>
+  - Dinesh Maniyam <dinesh.maniyam@altera.com>
+
+properties:
+  compatible:
+    const: altr,socfpga-rsu
+
+  bootph-all:
+    description:
+      Bind the anchor at every U-Boot phase that uses RSU (SPL, U-Boot
+      proper).
+    type: boolean
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        socfpga-rsu {
+            compatible = "altr,socfpga-rsu";
+            bootph-all;
+        };
+    };
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ea785793d18..42bd08e038d 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -66,6 +66,22 @@ config ALTERA_SYSID
 	  Select this to enable a sysid for Altera devices. Please find
 	  details on the "Embedded Peripherals IP User Guide" of Altera.
 
+config SOCFPGA_RSU_DM
+	bool "Altera SoC FPGA RSU driver-model anchor device"
+	depends on MISC
+	depends on OF_CONTROL
+	depends on CMD_SOCFPGA_RSU
+	default y
+	help
+	  Expose RSU as a devicetree-bound UCLASS_MISC device
+	  (altr,socfpga-rsu). The RSU command layer stores its active
+	  low-level session on this device; ensure the altr,socfpga-rsu
+	  node is present in the U-Boot DTS.
+
+	  This anchor driver has no MMIO and no flash-controller coupling
+	  of its own; the QSPI flash requirement is enforced by
+	  CMD_SOCFPGA_RSU (the only consumer of this device).
+
 config ATSHA204A
 	bool "Support for Atmel ATSHA204A module"
 	select BITREVERSE
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..1d26cf58284 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_SANDBOX) += spltest_sandbox.o
 endif
 endif
 obj-$(CONFIG_ALTERA_SYSID) += altera_sysid.o
+obj-$(CONFIG_SOCFPGA_RSU_DM) += socfpga_rsu.o
 obj-$(CONFIG_ATSHA204A) += atsha204a-i2c.o
 obj-$(CONFIG_CBMEM_CONSOLE) += cbmem_console.o
 obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
diff --git a/drivers/misc/socfpga_rsu.c b/drivers/misc/socfpga_rsu.c
new file mode 100644
index 00000000000..6e7d7ffc072
--- /dev/null
+++ b/drivers/misc/socfpga_rsu.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ *
+ * SoC FPGA Remote System Update — driver model binding (UCLASS_MISC).
+ */
+
+#include <dm.h>
+#include <asm/arch/socfpga_rsu_dm.h>
+
+static int socfpga_rsu_probe(struct udevice *dev)
+{
+	struct socfpga_rsu_priv *priv = dev_get_priv(dev);
+
+	priv->ll = NULL;
+	return 0;
+}
+
+static const struct udevice_id socfpga_rsu_ids[] = {
+	{ .compatible = "altr,socfpga-rsu" },
+	{ }
+};
+
+U_BOOT_DRIVER(socfpga_rsu) = {
+	.name		= "socfpga_rsu",
+	.id		= UCLASS_MISC,
+	.of_match	= socfpga_rsu_ids,
+	.probe		= socfpga_rsu_probe,
+	.priv_auto	= sizeof(struct socfpga_rsu_priv),
+};
-- 
2.43.7

