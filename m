Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB67C282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 10:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39B7811B3;
	Mon,  3 Mar 2025 11:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p2uTeWvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90863811E0; Mon,  3 Mar 2025 11:37:36 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DF65810ED
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 11:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNOtjTsURKM0yXBQbMQLoXLozC9QRSnrKbgFxPAKFGZQztKQTb3cOWf3bdFDBqtYyygz3oXZeJ/lC/EUOzSrgOkSiL2mlseniA+SozHoi4N4BB6eAz91vYHWVYoTA12DmKVHCIaunyQGBRdo91lemO5VNaYd5EWlcizYYIuQ0kH50TIbJG8AKXIrnWIwU14b9jB3J6l8WXqoo5K3erG7VmKSWDmwXF1SVl8Azgd0oTRKC/hOBW8EPS+xuzpystN0BSfra0p87qnos+1G9JQ0iJPV5e0ryzshYepJsR+OPPxFHOM8JRupUkXgkyOxUgq2FdMMpkYzTllZecUCEGvg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PpYgXbyJZz5+66Nmpm/F7t7MieFE/Dxh7zqVN8ADNk=;
 b=daEkX4x2giVpoOLFDubyxT9qmgX0OTm0nDqArjfl6bpHS3SVpWAhfxHvbpKGLfn/DlijA5SvuKcopy7KWfMVkhwzio5uGTh5TkJ9ZwHhvagKjCr/ZSgU5Eg1J5trutAp6Zzu+XRoPiMOnsEPstMjm2msKKAmI4JdBjRi/eyhgURmcXLu54NN1EObCOViBme2fCQNSFpLlKPNcjvimXiw+zIGtTjFqo/xatT554Sgh9PRvvtKUthLiBl2baRGuXeXKm0MKlESwioiBVjaXCWFpb3jGcj1PyC18Zc7V/sloCfvsq1H1BswmtsPNsTFCPsFtfwkGkDoO72uy1gQdyw8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PpYgXbyJZz5+66Nmpm/F7t7MieFE/Dxh7zqVN8ADNk=;
 b=p2uTeWvWO9i6OToGW/jRREkm0wb5U6fAPUe99/DZRzi+JV2leU9xyrxrA2Mr3nGCNi/fcJJRhG8RPmmCmSrAC3hgiKDCJFstMiAz7bl1lvbzMhL+5FTdI2dNW8MeyS1YxIvjstMrd1LX+/v70NjlKtpY22CumNDrsAyDJEBtGLF5qhpoK/AVQDUEH7j2RylSbr8rSIV2qfQH4qaiGbdVy08p60sERQyuKoCawWctoYPWGAy+MtVpo1y8NFymkO3+o0rsWmrIQxEMykGneo6WSRfXLO6oV/3oZRbcOMqyF/OVcgkb6uRhZMjtR1UturcBEekw/Z/XZ44toKX8NxWm6A==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9406.eurprd04.prod.outlook.com (2603:10a6:20b:4da::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 10:37:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Mon, 3 Mar 2025
 10:37:31 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHY0IDEwLzIwXSBzY21pX3Byb3Rv?=
 =?utf-8?B?Y29sczogdXBkYXRlIHN0cnVjdCBzY21pX2Jhc2VfZGlzY292ZXJfbGlzdF9w?=
 =?utf-8?Q?rotocols=5Fout?=
Thread-Topic: [EXT] Re: [PATCH v4 10/20] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Thread-Index: AQHbZ1GM+79Tro6rhEmci0D0VedmurMmDJ+AgDtvWdA=
Date: Mon, 3 Mar 2025 10:37:31 +0000
Message-ID: <PAXPR04MB9644E421817CBBA159C9907BE2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-10-93b28a514dea@oss.nxp.com>
 <05ef8aa9-fc2c-44c4-905d-13cf81b35d9b@denx.de>
In-Reply-To: <05ef8aa9-fc2c-44c4-905d-13cf81b35d9b@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AS1PR04MB9406:EE_
x-ms-office365-filtering-correlation-id: aa11b191-7f6d-401d-f1ba-08dd5a3f671b
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZjNXaDgyK3RQL3ZGait4YzUzYWxCcGlZZWpYL3R5SVBZZ2FlNGpKaTlGTmxC?=
 =?utf-8?B?WUFVdzQwR1lpMW9Jd0FNWDR2TDhVZW5hNlhpUEdNUGI5SFFkQm9DelN1bGkw?=
 =?utf-8?B?R2pvQzFSUVJUVzlxenh3ckhqOW83UGxXMGx5VXViRWE5TjdiTDk3NmFkUEV5?=
 =?utf-8?B?YkwxL1F0YVRyQVNHckpMOGY0QXZvdlNIZU03cnVNRlFPZkFaN01QVDVOT1V0?=
 =?utf-8?B?MUFwWnFiOXR4azZzUGhCZExpa0trZnZjUVZTR3dLclQ5ZkNaQmc4RDd4NHpy?=
 =?utf-8?B?dUdpOG9LUXZ3Tk5QbGVWSWdXUjhRV0o5QlZVMGMzdlZUY1kxQkY0Rk9WRWty?=
 =?utf-8?B?WFZWVkQyV2xucUJZQzA3L3hUU3lhbC80eUNFaDZHZXlSajVzb1JCWmNHV3V3?=
 =?utf-8?B?Y3gyVkRTN0Z3N1NIUW1oUlNxTjE0Tkw2cnNpcmNDNE5WM3pZNXBERTVuSkI0?=
 =?utf-8?B?R3dIZWdVRlhtMEp6QnplUkpQb0paK3l3cTZVTStCR043aTk4K3JkUksrRWRM?=
 =?utf-8?B?eHU0MW92TnQ5S1FGaW4rY2xhb25nVVNyTHVjQW5mYXBQSHRWSk5lOGhzSi92?=
 =?utf-8?B?ZEg2OXNUU05saXJxcFM0TThjZ0RGYTNiMk5SNUFBMXRpYWlPYktxN054QjhV?=
 =?utf-8?B?dlhLS3d1blBvaE1HTGFJZ2Y5ZzBEb0dLNGdTYW1FMVJQN294QzVZUnVld2ZT?=
 =?utf-8?B?OXl0MXc5ZW9GMzNiSVZ1NmxmdnlWV1ZyeE5VYlBlbU1PMVdEbnMyekkrYXR3?=
 =?utf-8?B?QVBYdWdnd09XSldtdkRCM3Y2Qzh2UStWMWtZTndxOVZMblpMNUwrVG9JOWJX?=
 =?utf-8?B?YUFHUWUzdzlRaGtEelNtNlRSWHg3NTI5T0hRVjhPSFBIeUxMaWJaNEl3RW16?=
 =?utf-8?B?YlcxMjFRVm9tdyt2TDZBTXRpdHdhRTJZR3hoczBwN203SFFGdEFSVlBtdkxT?=
 =?utf-8?B?OXNockV4Q05wR29ZM2VkQk5saVRGZ2Q1OUdyYTllQ3hHY0taZUJnSWFEcHpT?=
 =?utf-8?B?WFpCYkcybE5mc2lvL0UyKzlvbXQwWURraWdDR1lHajlVVGwyaGdDcEZSUHFU?=
 =?utf-8?B?bkRSVVdRR1NKcFBzdW40cWNSMnRIbGV5R3VncEFIOUJGWTlPK1g4TkppRi9m?=
 =?utf-8?B?cncyNGwrWWh4eE9SRWNMZkFRdm94NlkzT1IxdUxJZDg2enp5OXl4VExCTWVY?=
 =?utf-8?B?dkRKMnJyM202ZFFmbFV0aHVFVGpCTDEvSnVDQXk4ME1WVUMxMEh6YUwrblJw?=
 =?utf-8?B?MlpSZVFzaHZIU1UwUVlmVHU4UXNxOEtRTktOUDlvYWFudXl3dVgwa000anlI?=
 =?utf-8?B?V2lLVnJhTjJhZkM3b3d6dkVRTFJrYWFiNFVoZGhaeExGbUh6REw5UEU2VHZQ?=
 =?utf-8?B?M25zL2tJSmJKQXV2dEdYL0Z4ckt6TkprVVlRUXIvV1kzUDF0REpUL1IyRkpG?=
 =?utf-8?B?MC96WU5ZUmQwOHBWZ01Xc0UxMnNFWjV2eGxqOUxzR0JOZHFpL0R3d3lwNkN2?=
 =?utf-8?B?R3lSSll3dG9mU3ZjU2crNHVlZXR2bVRQbWpUenpIbVV4LzdsZFdXR04rOHZO?=
 =?utf-8?B?cFZhK2h0ZGhsVjFoK0syNHRGMVJXOE1VSmRvMWNOQWhDcnlKUGxDcFhwQ253?=
 =?utf-8?B?MW91V1VERm4wN3VOMHdoUGJ2eS95R3dKVkFjT0U2SmlmeEhtZXduYm9lWE1T?=
 =?utf-8?B?QVAxVjZONlR4SFBoZVdTODNwMk9jVHc4dFpodEF3bFQvNzNoZVRoK1dVZUFH?=
 =?utf-8?B?R0kvREN3eUUrUm14bCtRVnhDWnFXdCtDMFRsNm0ycnFoa0NhVGRjaC9mc2NQ?=
 =?utf-8?B?ZTAxNEh3OUlJNURZUmppYXROQ0QweVo2UU5qNWpGV1d0RjQ2bTRwUkJYS1Bx?=
 =?utf-8?B?bVFBaVhJT1FjVzUrbjVuczVVRGtxM3lJUjZMa0JwU0FkUmJwZTdzTXF4ZzF6?=
 =?utf-8?B?eFMzRFNubmVLR2V4S3VYUjBpai9qdFBybDI3UTBVQ1BPU0E3WVFUUFBoMElt?=
 =?utf-8?B?LzNiMmFHZ09BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkZXR3JnNUVJV0kvR1YzcUZNTmFHZTlwOEh5SXZ5VjdDbUk1MEU2NVZIemZV?=
 =?utf-8?B?NVJBejEweWNGRjhXK0hvMGhLTzZRSzZaMWVPSFFvbDJ1cCsyRGp1STFubW1R?=
 =?utf-8?B?MWFqTXJ3NzR0VDBreWNJL1NnLzdWNFZCb1FHY3dqbGt1ck9yamg3Z0JMNGcw?=
 =?utf-8?B?M0lReGRqRmx5OFc2RFF1amVPYnp5L1hOeXRIdU9JNlltZHJvdENUUGsyQ2kz?=
 =?utf-8?B?VHZ1bHRpc0RzTS9CRm9uRGFSTm5BaXRrMGd3Q2UyOXlzdXgzN1M3aSs1RG1y?=
 =?utf-8?B?SytYeHpqMXlqWFNWK21oTUVzQWpwSHRXYXRseXUyQlVJTkNIWXFWM0M5WXdX?=
 =?utf-8?B?VGVLZWx0TDMxL202VVBUYi9zZzlxWEcwQmZMVk00Q09INm50Q3FkOERocEd3?=
 =?utf-8?B?Z0xkRWxqZE1jVU9tVkdCOE9XeWlIMit1TG1OQkdwcDFyZWpmS3VXS1RUcGxE?=
 =?utf-8?B?WWdBb2ZGV0VXcFlCdnJScURYMHVoSDZQaUNtbFU3ajRTOERxK1pJekc3Q2Ey?=
 =?utf-8?B?bjFFRVFNeFYzNUViYjlTbkxnZjRGakZDUTZJVDJJM0NpZkk5VW1EQUVrbGNW?=
 =?utf-8?B?MXpRTm1sYmh6RXN3NEZ2RXo4UVRXVGFJMHJWalNaN3NWcEtZeURpZytCeDVp?=
 =?utf-8?B?STI1Zko4VmxKajBOaTE4bDhUSkdKOGxFSXhkYWUzb3NISUtxT1lWbUk1R0Y1?=
 =?utf-8?B?bHc1Zmg5YjBRMXUxMGlVdEJSaXJuamN1V0pmNFN3bngyczFBV09nVjFvRlpZ?=
 =?utf-8?B?SVhLNFpnbVh4ek13NnFKZndTQm4wTnBHU05UVWlqRzFtY3d4M1JHcjNTR1Rj?=
 =?utf-8?B?WDF6c0RhVU5FTGx1cFBvSVBkZ09TQ2xIVmlvc1AwNU8xU3hDK3YvaDREWGhl?=
 =?utf-8?B?WU1FVlNoNHEyRzVxbUpUUzlqbFFOTldTeFB1b3VLUENZYmhSK1RybWZmTFE0?=
 =?utf-8?B?UkF0ZlM3K0RkVE9mbzZPRmdkVVo0NnZMdys4b1U1K3JIeENDVjM1TDFYUGFt?=
 =?utf-8?B?Mis0eVFpOTNhSWdYWCtIWXcxbWd0bC9UQmRIQWxKV0xENm1DQURua3BsQ1Ra?=
 =?utf-8?B?L2ZHSUlKdzhRR3BHVDNHS2xXRG9VVm51eTU3S093QjVhbkZWOEx4YzBSV3Bx?=
 =?utf-8?B?ZUZ4RGNQZ21HRktUMDRtQ1QyNE9obnBrV3M2anpXbkhVQXpWR1F4Z0FnMHpy?=
 =?utf-8?B?UWltOUg0YzFLODM2STdGeFg1N0Z1VWxTZmcvd2V0T3lyTGNlSERjTVV0SWFt?=
 =?utf-8?B?UFFmTm5PeC9uQ3NZOEUwamxocnZDZm5TcjQ1Uk1EeGgxUXo5N2dQSGJwNk9H?=
 =?utf-8?B?RHFaOVdIL1dJb3RGV0QyMkR3ekwyVkdaSFBzd0RGb2hxQ0JmcU01Q2piUGR4?=
 =?utf-8?B?RitGcXpWZkpPQzVqbU9paUpzV1A4SmVOeGo3VU4vVHh1Q0R5T1JMdVBJa3pn?=
 =?utf-8?B?RjlsdVQwZU54M2h2Umx0eXJkaHJpUGowZHQ4NlRvd1JmcVdjdkg3NUNkclUz?=
 =?utf-8?B?VmlXTFdDUWZndnpKOUQrZ0hjOFVYMHpNbXdDc0hjUzU2ZFAxTmdTVVMvWmpp?=
 =?utf-8?B?T0VHck9ycGl1U1Y0Zk96Q052b0JuQWJkTjJLR0hRT0lFayt0OExYTzhHZUwy?=
 =?utf-8?B?ZytldURDUlBmWnRIYWZHcldWZ05QcVVTMkhTU2R2RTVjZXZhRGdIZ1lITStw?=
 =?utf-8?B?SE5sSjN0eEUxTHM4dU9ZMVBXcnVzMkY0ZnNJZk9iampmdmRwOFFhQ1RsSnVo?=
 =?utf-8?B?dk1EcERhVmVkUENFcDRIMmt6WGhqV3ROYzQvd2c4ZVFFZzNQU1hhT0M0dk5G?=
 =?utf-8?B?QVp2bkU3Y3FwMFBtTGVOZ1U5TytmMW51ZzlDVzdhMTBSUmJwYkdxalFkTWJR?=
 =?utf-8?B?SmR2VkJPQWZneStkdWh1VDhHUTFHV3ozWlBrYVgyNEVpUVE0bm9HUFRuc2J2?=
 =?utf-8?B?YVkxTy9ZTFE1bEYzU0xCUUFrR0RQeW1WQVhRa2NuWGRiOTBQVnBhVW9WYU01?=
 =?utf-8?B?YzdUd2MvWk9vdUxVZmF5QlRYTDBHSjdwQWY5VnpIQkxCV0hYdUR0Q0FmNTVP?=
 =?utf-8?B?dG1zenFzc3pmdjdEYVppU09Kd3NJUzlNb3NlWXJVU0h0aVFiZ2Q0L0w3NDBM?=
 =?utf-8?Q?A/ZA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa11b191-7f6d-401d-f1ba-08dd5a3f671b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 10:37:31.5651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bL20ej3/tOZJChNReAiajuXSioD9aqJhrvqoi5Ca9ZJyZ0GN/ooz6iGUDQxSopRB1pPGqV2C7JFEhRYN9HXjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9406
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDHmnIgyNOaXpSAyMjozOA0KPiDmlLbk
u7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgVG9tIFJpbmkN
Cj4gPHRyaW5pQGtvbnN1bGtvLmNvbT47IFN0ZWZhbm8gQmFiaWMgPHNiYWJpY0BkZW54LmRlPjsg
RmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtdWJvb3QtaW14IDx1Ym9v
dC1pbXhAbnhwLmNvbT47IEx1a2Fzeg0KPiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT47IFNlYW4g
QW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29tPjsgU2ltb24NCj4gR2xhc3MgPHNqZ0BjaHJvbWl1
bS5vcmc+OyBBbHBlciBOZWJpIFlhc2FrIDxhbHBlcm5lYml5YXNha0BnbWFpbC5jb20+DQo+IOaK
hOmAgTogdS1ib290QGxpc3RzLmRlbnguZGU7IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxpY2Ug
R3VvDQo+IDxhbGljZS5ndW9AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiDkuLvp
opg6IFtFWFRdIFJlOiBbUEFUQ0ggdjQgMTAvMjBdIHNjbWlfcHJvdG9jb2xzOiB1cGRhdGUgc3Ry
dWN0DQo+IHNjbWlfYmFzZV9kaXNjb3Zlcl9saXN0X3Byb3RvY29sc19vdXQNCj4gDQo+IENhdXRp
b246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlj
a2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBv
cnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhpcw0KPiBlbWFpbCcgYnV0dG9uDQo+
IA0KPiANCj4gT24gMS8xNS8yNSAyOjI4IFBNLCBBbGljZSBHdW8gd3JvdGU6DQo+ID4gRnJvbTog
WWUgTGkgPHllLmxpQG54cC5jb20+DQo+ID4NCj4gPiBAcHJvdG9jb2xzIGlzIGFuIGFycmF5IG9m
IHByb3RvY29sIGlkZW50aWZpZXJzIHRoYXQgYXJlIGltcGxlbWVudGVkLA0KPiA+IGV4Y2x1ZGlu
ZyB0aGUgQmFzZSBwcm90b2NvbC4gVGhlIG51bWJlciBvZiBlbGVtZW50cyBvZiBAcHJvdG9jb2xz
IGlzDQo+ID4gc3BlY2lmaWVkIGJ5IGNhbGxlZS1zaWRlLiBDdXJyZW50bHksIHNldCBpdCB0byA0
IGlzIGVub3VnaCBmb3IgaS5NWDk1Lg0KPiBDYW4geW91IHBsZWFzZSB0cnkgc29tZXRoaW5nIGxp
a2UgdGhpcyBpbnN0ZWFkID8gVGhhdCBzaG91bGQgYmUNCj4gZnV0dXJlLXByb29mOg0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9iYXNlLmMgYi9kcml2ZXJzL2Zpcm13
YXJlL3NjbWkvYmFzZS5jIGluZGV4DQo+IGY0ZTM5NzRmZjViLi45MmQyNzhlZGZhZiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9zY21pL2Jhc2UuYw0KPiArKysgYi9kcml2ZXJzL2Zp
cm13YXJlL3NjbWkvYmFzZS5jDQo+IEBAIC0yNTgsMTcgKzI1OCwxNiBAQCBzdGF0aWMgaW50DQo+
IHNjbWlfYmFzZV9kaXNjb3Zlcl9pbXBsX3ZlcnNpb25faW50KHN0cnVjdCB1ZGV2aWNlICpkZXYs
DQo+ICAgc3RhdGljIGludCBzY21pX2Jhc2VfZGlzY292ZXJfbGlzdF9wcm90b2NvbHNfaW50KHN0
cnVjdCB1ZGV2aWNlICpkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1OCAqKnByb3RvY29scykNCj4gICB7DQo+IC0gICAgICAgc3RydWN0IHNj
bWlfYmFzZV9kaXNjb3Zlcl9saXN0X3Byb3RvY29sc19vdXQgb3V0Ow0KPiArICAgICAgIHN0cnVj
dCBzY21pX2Jhc2VfZGlzY292ZXJfbGlzdF9wcm90b2NvbHNfb3V0ICpvdXQ7DQo+ICAgICAgICAg
aW50IGN1cjsNCj4gICAgICAgICBzdHJ1Y3Qgc2NtaV9tc2cgbXNnID0gew0KPiAgICAgICAgICAg
ICAgICAgLnByb3RvY29sX2lkID0gU0NNSV9QUk9UT0NPTF9JRF9CQVNFLA0KPiAgICAgICAgICAg
ICAgICAgLm1lc3NhZ2VfaWQgPSBTQ01JX0JBU0VfRElTQ09WRVJfTElTVF9QUk9UT0NPTFMsDQo+
ICAgICAgICAgICAgICAgICAuaW5fbXNnID0gKHU4ICopJmN1ciwNCj4gICAgICAgICAgICAgICAg
IC5pbl9tc2dfc3ogPSBzaXplb2YoY3VyKSwNCj4gLSAgICAgICAgICAgICAgIC5vdXRfbXNnID0g
KHU4ICopJm91dCwNCj4gLSAgICAgICAgICAgICAgIC5vdXRfbXNnX3N6ID0gc2l6ZW9mKG91dCks
DQoNClRoZSBwb2ludGVyIGFuZCBieXRlIHNpemUgb2YgdGhlIGJ1ZmZlciB3aGVyZSB0aGUgcmVz
cG9uc2UgbWVzc2FnZSBpcyBzdG9yZWQgc2hvdWxkIGJlIHByb3ZpZGVkIGJlZm9yZSBzZW5kaW5n
IGEgQkFTRV9ESVNDT1ZFUl9MSVNUIFBST1RPQ09MUyBtZXNzYWdlLg0KDQpUaGVyZSBpcyBhIG1v
cmUgcmVhc29uYWJsZSB3YXkuIE51bWJlciBvZiBwcm90b2NvbHMgdGhhdCBhcmUgaW1wbGVtZW50
ZWQsIGV4Y2x1ZGluZyB0aGUgQmFzZSBwcm90b2NvbCwgY2FuIGJlIG9idGFpbmVkIGJ5IHNlbmRp
bmcgYSBQUk9UT0NPTF9BVFRSSUJVVEVTIG1lc3NhZ2UuIEJ1dCBub3cgdGhpcyBjb21tYW5kIGlz
IG5vdCBzdXBwb3J0ZWQgaW4gVS1Cb290LiBJbiB0aGlzIHBhdGNoLCBlYzg3MjdiN2UxICgiZmly
bXdhcmU6IHNjbWk6IGltcGxlbWVudCBTQ01JIGJhc2UgcHJvdG9jb2wiKSwgInUzMiBwcm90b2Nv
bHNbM107IiBpcyB1c2VkLiBTbywgSSB0aGluayBzZXR0aW5nIHRoZSBhcnJheSBvZiBwYWNrZWQg
U0NNSSBwcm90b2NvbCBJRCdzIHRvIGEgZml4ZWQgc2l6ZSBpcyBhY2NlcHRhYmxlLg0KDQpCZXN0
IFJlZ2FyZHMsDQpBbGljZSBHdW8NCg0KPiAgICAgICAgIH07DQo+ICAgICAgICAgdTMyIG51bV9h
Z2VudHMsIG51bV9wcm90b2NvbHM7DQo+ICsgICAgICAgaW50IHNpemU7DQo+ICAgICAgICAgdTgg
KmJ1ZjsNCj4gICAgICAgICBpbnQgaSwgcmV0Ow0KPiANCj4gQEAgLTI3NiwyOSArMjc1LDM0IEBA
IHN0YXRpYyBpbnQNCj4gc2NtaV9iYXNlX2Rpc2NvdmVyX2xpc3RfcHJvdG9jb2xzX2ludChzdHJ1
Y3QgdWRldmljZSAqZGV2LA0KPiAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gcmV0Ow0KPiANCj4gLSAgICAgICBidWYgPSBjYWxsb2Moc2l6ZW9mKHU4KSwgbnVtX3By
b3RvY29scyk7DQo+IC0gICAgICAgaWYgKCFidWYpDQo+ICsgICAgICAgc2l6ZSA9IHNpemVvZigq
b3V0KSArIHNpemVvZih1OCkgKiBudW1fcHJvdG9jb2xzOw0KPiArICAgICAgIG91dCA9IGNhbGxv
YygxLCBzaXplKTsNCj4gKyAgICAgICBpZiAoIW91dCkNCj4gICAgICAgICAgICAgICAgIHJldHVy
biAtRU5PTUVNOw0KPiANCj4gKyAgICAgICBtc2cub3V0X21zZyA9ICh1OCAqKW91dDsNCj4gKyAg
ICAgICBtc2cub3V0X21zZ19zeiA9IHNpemU7DQo+ICsgICAgICAgYnVmID0gKHU4ICopb3V0LT5w
cm90b2NvbHM7DQo+ICsNCj4gICAgICAgICBjdXIgPSAwOw0KPiAgICAgICAgIGRvIHsNCj4gICAg
ICAgICAgICAgICAgIHJldCA9IGRldm1fc2NtaV9wcm9jZXNzX21zZyhkZXYsICZtc2cpOw0KPiAg
ICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBl
cnI7DQo+IC0gICAgICAgICAgICAgICBpZiAob3V0LnN0YXR1cykgew0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICByZXQgPSBzY21pX3RvX2xpbnV4X2Vycm5vKG91dC5zdGF0dXMpOw0KPiArICAg
ICAgICAgICAgICAgaWYgKG91dC0+c3RhdHVzKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHJldCA9IHNjbWlfdG9fbGludXhfZXJybm8ob3V0LT5zdGF0dXMpOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIGVycjsNCj4gICAgICAgICAgICAgICAgIH0NCj4gDQo+IC0gICAgICAg
ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgb3V0Lm51bV9wcm90b2NvbHM7IGkrKywgY3VyKyspDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgIGJ1ZltjdXJdID0gb3V0LnByb3RvY29sc1tpIC8gNF0g
Pj4gKChpICUgNCkgKiA4KTsNCj4gKyAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBvdXQt
Pm51bV9wcm90b2NvbHM7IGkrKywgY3VyKyspDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJ1
ZltjdXJdID0gb3V0LT5wcm90b2NvbHNbaSAvIDRdID4+ICgoaSAlIDQpICoNCj4gKyA4KTsNCj4g
ICAgICAgICB9IHdoaWxlIChjdXIgPCBudW1fcHJvdG9jb2xzKTsNCj4gDQo+ICAgICAgICAgKnBy
b3RvY29scyA9IGJ1ZjsNCj4gDQo+ICAgICAgICAgcmV0dXJuIG51bV9wcm90b2NvbHM7DQo+ICAg
ZXJyOg0KPiAtICAgICAgIGZyZWUoYnVmKTsNCj4gKyAgICAgICBmcmVlKG91dCk7DQo+IA0KPiAg
ICAgICAgIHJldHVybiByZXQ7DQo+ICAgfQ0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zY21pX3By
b3RvY29scy5oIGIvaW5jbHVkZS9zY21pX3Byb3RvY29scy5oIGluZGV4DQo+IGE1MTIzNGVkYTVj
Li4yOWE3ZmQ4NWNjMCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9zY21pX3Byb3RvY29scy5oDQo+
ICsrKyBiL2luY2x1ZGUvc2NtaV9wcm90b2NvbHMuaA0KPiBAQCAtMTQ4LDcgKzE0OCw3IEBAIHN0
cnVjdCBzY21pX2Jhc2VfZGlzY292ZXJfaW1wbF92ZXJzaW9uX291dCB7DQo+ICAgc3RydWN0IHNj
bWlfYmFzZV9kaXNjb3Zlcl9saXN0X3Byb3RvY29sc19vdXQgew0KPiAgICAgICAgIHMzMiBzdGF0
dXM7DQo+ICAgICAgICAgdTMyIG51bV9wcm90b2NvbHM7DQo+IC0gICAgICAgdTMyIHByb3RvY29s
c1s0XTsNCj4gKyAgICAgICB1MzIgcHJvdG9jb2xzW107DQo+ICAgfTsNCj4gDQo+ICAgLyoqDQo=
