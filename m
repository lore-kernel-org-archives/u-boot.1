Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFA3C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59305806D8;
	Thu, 27 Mar 2025 16:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="E9WnVb/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECD58070C; Thu, 27 Mar 2025 16:43:10 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27AE805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/TsPkPipeVRc4YG1hySsA5ryJ8iWZZfnHWPsCu0bTaHwpAA4DlNshFC9N5TwyS1t7Fk+0KmJLnwTpBNbCDIU9HphmryZijpFjM7g+PGBsLtBx1JqRXRPU5wqv2AEM/ZYalakhkpC8p5zv/zwuZQyleMJygSbxG8T5rOeyERXNK/1Bo1YRF4aBR6jSdikJFbMmjzb77LOjIXFG9sSD5LrMKk+Swc0O5t4hWdAk/zeVgz4O3g+wb2Jg0iFKJ9TSAh5ym15H5em40EGEivlhOdZIQ9+LLoa/d+8ltS2b3zfsXSLIGcYVQahOgmxD5+j6Kp5VaAKV6fdZ+idb1hI6+Eig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRFQe/5z5zYx4xW4XIHZ72eERzWLLsMwc/fzC2wQdT4=;
 b=GFaD4Yl74MFz7n5PVilKpyr3NZhna+6YYiYit/e/XR25vilfBdNW0j4+njsD+uBNpzJLvDzGZreOZZV+4qemW3hP9wYp3BLz3Vy8uFkC7RWvPrbPyPr0KiIm4K6EviVfBHMtjfMKyE4IULC5ygdr8ao9IbTyEb3Db0CX0BYI/ecwPKLtPNQReIpt/iAoQb/mPEuxYAYCmnWcwV6hdc5yLSY5LrQnDFPzxoaNRb4BeN7iv7gAthrAhTk1EbzWYlTwEztp/XF3mQ1BQgJbnXHp8V47+Xf3xX5c5Tcj5nAVUI1LX/n/rXeoBYhQ3XEp84zTnTaTNQESEgL3sALh6d9k5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=arm.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRFQe/5z5zYx4xW4XIHZ72eERzWLLsMwc/fzC2wQdT4=;
 b=E9WnVb/OIevMX9qzY/ol+LnoWXxodEb2fS/ty1g+UiufoBWwLqujk6GOGyakBEMnXb2+nSvqgRqfifEgmbe9BchLSvyIAOa4XlVeD9XuGerNAA2lG+5sYT6zCNWvChpnjItUiGSzSLK8qsbkQMd/gV9de+cB1b3nbKTkSf735rSpTOjNLOiq8sR9M9M3KT1LZO1i1FU2i0jHCYi6K+9pd5AcBPAkbFx8i4M72qf5LjvzMGeYDQLFrxhZl5mC/jltt7mkSuCvP5opciZulwt1AJ/e/OuYwc1vJvULjU1KObjpSwpf24le2RkllCnntvoFq/zoJ8x9DbzpSrzsCmoRYQ==
Received: from DU7P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::26)
 by AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 15:43:04 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::20) by DU7P190CA0008.outlook.office365.com
 (2603:10a6:10:550::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Thu,
 27 Mar 2025 15:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 15:43:03 +0000
Received: from MRWPR03CU001.outbound.protection.outlook.com (40.93.69.31) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Thu, 27 Mar 2025 15:43:03 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 15:43:01 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 15:43:00 +0000
Message-ID: <9b60fd10-306a-4fc7-ad85-88a696f01b94@topic.nl>
Date: Thu, 27 Mar 2025 16:43:00 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] topic: zynqmp: Remove zynqmp-xilinx-xdp platform
To: Andre Przywara <andre.przywara@arm.com>
CC: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Paul Alvin
 <alvin.paulp@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.68f99027-b22f-4bd9-9418-ab6179f4cea2@emailsignatures365.codetwo.com>
 <20250326161534.183270-1-mike.looijmans@topic.nl>
 <d986be35-bfbb-4f11-98dd-19bbec102d5e@amd.com>
 <20250327110517.538d29d0@donnerap.manchester.arm.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20250327110517.538d29d0@donnerap.manchester.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::15) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|AM8PR04MB7939:EE_|DU6PEPF0000B61F:EE_|AM7PR04MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ba4914-bc29-45c6-85fb-08dd6d461038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?MjVvU0dTVHlhMkM0TXBJb21WVnNZVFQ4Uld2alJvZXUyZ1lTTUZVdDRBWUMw?=
 =?utf-8?B?UnptZUVDN2JXS2xiV1VMTXkzNVdxejRxOUdLZG0vZDB4aDduaHIvaDNsZUR5?=
 =?utf-8?B?ekZwQSt3aUpDL3VEU3ZYbzJQMHBsYlZnOXlUcDN2UU1BSmxHQ29wemRlMU1h?=
 =?utf-8?B?TkxRZDBlZDNEL3Rob2NnRjN2eXl2b1hhaGwyZ09mOFhxYXAxNzBXUXRPNGI2?=
 =?utf-8?B?WEpwM0NkbmN0aHhwZitraVJVM2h2NU9ueEZ1ZHpFdkRBNHZVNnVoRjhZcnpC?=
 =?utf-8?B?d3RrbnhPb1hKUkF5S0tjZ1NSdEFnZGlKbStTbHIxYWkrYVZ1SlljaDRDMHYy?=
 =?utf-8?B?MEprWmdvdS9MR29TZEtuay9lZE92LzNzT3RZWnlzeW9jQkFlZ1R3VExpUk4x?=
 =?utf-8?B?V1RVakpNd2NENDVxdS9rL3FPS21nMzZPWHJ2QmFab0lreDNEYWZibVJlWVRr?=
 =?utf-8?B?RnZVbCs4cGFCekxYSFQ0aS84YmVpVkV4T0lqVmNyL0QzRUV0aTRrcXg3emZZ?=
 =?utf-8?B?UEFrNTVkUjlPcmZsY3EyK2tEY2R2VzlSU2p6QUI2Z3N1Z055TzI1TnExZ2Fz?=
 =?utf-8?B?cUIrWmJpU0o1OE8vOXdkMnl1cmlEeFNidHYyV1ZoQnllN1lXcXdTNFlOdk9j?=
 =?utf-8?B?ZlpFWW1FUFJxdHUrSG5UVU55U04yT2dLWEthMG1WbnVURkEzc0FaUktOV2RF?=
 =?utf-8?B?cUk4aHVabGMvc3hnaTZxK0wrSk5jelBha09WSEEzdExDcXo4aldBSEZGQUVu?=
 =?utf-8?B?Vi83cmZ6aTRuc2JyOENxck9RUFhXMGhRcjNCWXRKcFpnSEp3Z0ZuNGU0bFV2?=
 =?utf-8?B?QlArck8xd01tNU1xdGd4Zks4WWkrM0theUU0amFjZ2wzZXZySVJCZmdKNi93?=
 =?utf-8?B?a0VKNmxnWkh3YklCbGhwUmtyZzFmam8wS3dPSDV0bFhmQW4rSHA5Qmw3VTFN?=
 =?utf-8?B?UTBmWnhaQ2FmNkgrU2lQbzM1UG1LbzdLVTJOQWJ0YmZiM2MzOEkwWmtvWXMv?=
 =?utf-8?B?eWxja2lUMmh3N2VDQmVYNXpzK0poUCt4bVVOdmFRYzZZdnlGdXp4cEtzbXFs?=
 =?utf-8?B?MGZIMUUvcGFhMVg2cmN2TXUxc2swM1RnMTJzb2JUejY0bFFxcnl4L0t0N2s1?=
 =?utf-8?B?ZHQ0V003MFFrTEZIYXdxeG5vME1kNEl4RWV1eFBvYUE4OEZ5b1hGaTRoVm54?=
 =?utf-8?B?VzhoQUo0MW9ReXFEMzg2UGJtQ3NDem1GblZJM0ZrZDZmTEtVVnF1QjRRVFM1?=
 =?utf-8?B?Z08xMS9Ca3YydFcwWjF1R3dhaEMzclUydWI1SG50MXI0VENROXRheHpPNkdk?=
 =?utf-8?B?SWdjWnB3MFQxY1o5c0xJWCtmNGFkZ0JEVHpObTB4eFJWYUdiQ1NqZEpJV1JT?=
 =?utf-8?B?aWJpa2VhYjQ1MjJXblFVckRxTGFxSUpjeXlqY1FsU3NYWmVuOWsyM1lUK0NT?=
 =?utf-8?B?Zy8xTEJZSW05NmNZQVUzSHAyVG8zVUlFSFFQMWV0NVZFWXBVS0F1M1JPMXdv?=
 =?utf-8?B?VXhtcGtRdFR3NkJYMEw4V2lCOUZGRHQrTmhtbjZPTGJFYzJjVG9pTVBoekFC?=
 =?utf-8?B?SkNmNFViWGdBWnlNcEdIdCsrcGVCazFoUHFzZFN1YlJhNnZ3dlZxMUt5c05u?=
 =?utf-8?B?VWpXTzQ1Vm5WRzdkd3V3NlFXeVZqUHpualJueWc0VlFxRnJkSFNUNVpXa0hv?=
 =?utf-8?B?RVlOT3ZYMDlBTW0wMVB0VlphQkxRK0hUN0MyK0x6L3VRdm14elh1dnZGVStO?=
 =?utf-8?B?K1JoeG1pNUNERHN5VzR3ak1CaSt5dUxvT21Pd2ZlMTI3R0pDS2pSMWRpdS8r?=
 =?utf-8?B?N0dlbU9hZnlRZkRFWXFKSzRKWlhpYUN3WDB0UnNmMzQreDdmUG1ZUFNOL0xm?=
 =?utf-8?Q?jUQQ7XkjwiMN7?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939
X-CodeTwo-MessageID: fce00158-e7a1-41ed-9fce-53ace97ad8c0.20250327154303@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 18fd8d6f-47e3-4e30-f135-08dd6d460e0a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|14060799003|35042699022|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0M1T204NTJ0bFQyL3JPcHVQaWwrQ2JTU2VNSlFuZmFtOEpzbHJkbWhhcGZm?=
 =?utf-8?B?YVlOYUd3MnYzZFd3b0QzVXA2OUprWEtPZWRJSk13SGxVU3REK1oxTzM1SzNT?=
 =?utf-8?B?TXhpMmRXbDYvcGtza3g4RWptTkFNZ051ZmVjZVFBenhDTGtnQjVYOTloZm81?=
 =?utf-8?B?OUVNbDdpZU1Fa3dkajhhUml0a0t1SHlQSGxoWHRpK1Nxa20rakdiL1lYK1Ja?=
 =?utf-8?B?bHJNV2FNNmYwVmdRSU9sY2tKSXF4YjVyNy9QZ1BRSHFIV2lOZEIwZjhCTmMr?=
 =?utf-8?B?Z1dQT1l0ZXE1dXpNY3drcW9FNnpWang4UmMwczA1ODBXRjZ1S1Z4VENraDQv?=
 =?utf-8?B?cWRmQVNjVkI0cTF6bzI0UEhHbmg4TXZ3Yzl5UXhGUnBUclVwR3NXVmEycFhS?=
 =?utf-8?B?SnR1MktCWkN3czg3N1VxYW9YYVNwVXg3VnJ0K0dKdXhJVURzdjB3TUtKMnlk?=
 =?utf-8?B?ejc2US8wblhvMzM4SmNYWFFKNDR4MEJjckVVc3ArWXpHeEErak5QdzhMTXhk?=
 =?utf-8?B?cjNaRmt6enZxZGdBU3NlNjNtak1aZzU3VmorT29MdllVZGU0ZllQRjJzWE9i?=
 =?utf-8?B?M0JncFlGSUNKUFg4WWJ0NjMvdnJablIyanN6N2xQNWpYNEFZSmpCNGlvWkNr?=
 =?utf-8?B?a2hhS0dLaENTMmc4eFlUb1BoRTdRT1BIeDdFUUJRQVROZFo3M01OQlNjTmtz?=
 =?utf-8?B?U3RTc0NQdHZTWGVHM2NmcEN6djQ4cnM5LzFhcFJLSGZZSjJBemdjd2FVdUl2?=
 =?utf-8?B?VktWM3Y3L21QckNLL1oyZHYrb3BQUE9TbDMrZ3FQbXlseXV2dEFUWXNqWnNy?=
 =?utf-8?B?S0VId2xNd1JqNDdmT2NUSjZpU1hUcTN0citwY3RpUjRGbTdJanlmSDNtMzBK?=
 =?utf-8?B?R3BZVThrcmJ1Rkd6NzdqLzBOYVVTR1ZuMCtFRllFZWE5bkRyNnFYbGtrRnJL?=
 =?utf-8?B?aWhXb0RlNXQzazlZWit1ZllQRnVDa2JjT3NLN01CUUQ4amR4VHBCOG1NeVZV?=
 =?utf-8?B?UWdJbU1hQ2M5SFJHV0p3anJla000MnBlM2I0WWVibFN2YWFtLzdqaXNZdDdi?=
 =?utf-8?B?TkswQ05pT3hQTXNUSFI2NGM3cmV2TUc4bDNWbzZ0c1NkOEhqd0dsU2RVaTBi?=
 =?utf-8?B?bDI4SXZBK1ZtdnNWUjBYR2EvR1J2aDkrYm9uMWN6dXRPMVAwajVGY0N0OE1r?=
 =?utf-8?B?WDBYZ3NaMFRzSDJGS0QwamVYSGNYSzBkRUx6QSt4MnAzUmxZTmVvWUdac3hW?=
 =?utf-8?B?MWFTVlFqcjBTR1liWjlSLy9LeStRMXBmMzhaMzNwT2s4L2tYUlY3SElsejlv?=
 =?utf-8?B?WnBvV0xIaXVwYS8vUUc1UUxqZGlKeEorZm1Wc3ZkYkREWnl6a0VDL29meFpq?=
 =?utf-8?B?NXV5Q29KdlcwNHdFVDNpVTdPSW1tcGV2WnFBanlPRnlKVkRVVXRpMk9jOHJq?=
 =?utf-8?B?MXlPUE1kSldPVDZrZXhaSXNtWWFvZUN6bEplODlnVGg5eGFZR1U0a0RuVmhj?=
 =?utf-8?B?OUFqYlJUYVpXZzZwdTkvdU03dDJwKytyc2VBM25sMnRTMUk0c2VXMnlYVEZw?=
 =?utf-8?B?LzZkcFBsUUdiQ05oem1MMUxYUFZTaTV2M2FVUWswSmdvR0NtSTdrZmMzTG15?=
 =?utf-8?B?SnpCb081QVQveTlYVGxwcEh2UEpmYzYxSTdmWXdNWGlsVE1rRy9xc3ZzQVN5?=
 =?utf-8?B?N2FZMEgzdENtekdoSkx5b2wvU2NoVnoreVVGd054YnRNN1FvOEtBbWE2MCs3?=
 =?utf-8?B?TGJucEJoUlNZSkFwVEorc3lBdjRvNmtsRVdnMHBuT3ZhaVRNSXZGZFBOU0Jt?=
 =?utf-8?B?alFUQ2psTjZmeFV4cU52elpxV1phQ0gzSzU4NllWTE02UUIzeFMvcG1FUEF3?=
 =?utf-8?B?Z0N2VW8wMGR0bC9Da3ExUXJOVFVtbTV0QVNYQkJvM2dVWWJhQmMwZHZDZDNR?=
 =?utf-8?Q?Ruq9jQezRZ0=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(14060799003)(35042699022)(82310400026)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 15:43:03.9850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ba4914-bc29-45c6-85fb-08dd6d461038
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6821
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

On 27-03-2025 12:05, Andre Przywara wrote:
> On Thu, 27 Mar 2025 10:00:50 +0100
> Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Mike,
>
> I don't have this board, so don't really care, but was wondering:
>
>> On 3/26/25 17:15, Mike Looijmans wrote:
>>> The "xdp" board went out of production years ago,
> I have the feeling that this is true for many boards in the U-Boot tree,
> pretty surely for like 80-90% of the Allwinner (sunxi) boards.
> So is there any particular reason other than lack of professional capacit=
y
> for "official" maintenance to remove support? Because the removed code
> doesn't look like it would need a lot of hand holding, in fact it shares =
a
> lot with other ZynqMP boards that are still maintained. And I guess there
> might still be users out there who would benefit from general U-Boot fixe=
s
> and improvements.

Very few XDP boards were produced. I'd be surprised if there are 10=20
boards remaining in the world, and that's including the one Michal has...

>>> remove the remnants
>>> from the U-boot codebase as there is no point in maintaining them.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> ---
>>>
>>>    arch/arm/dts/Makefile                         |    1 -
>>>    .../zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts  |  117 --
>>>    .../psu_init_gpl.c                            | 1030 ---------------=
--
>>>    configs/xilinx_zynqmp_virt_defconfig          |    2 +-
>>>    4 files changed, 1 insertion(+), 1149 deletions(-)
>>>    delete mode 100644 arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1=
.dts
>>>    delete mode 100644 board/xilinx/zynqmp/zynqmp-topic-miamimp-xilinx-x=
dp-v1r1/psu_init_gpl.c
>> I still have this board and happy to continue to maintain it.
>>
>> Cheers,
>> Michal


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



