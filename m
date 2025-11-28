Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30544CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 13:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C697184550;
	Fri, 28 Nov 2025 14:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IBML1yuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4501484565; Fri, 28 Nov 2025 14:18:11 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BB3C8455B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 14:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgqOLrT9X9QCq9Zfv3ekVz9YS7y+I/0BGCZ6YNBPO8qWyu9bt+V2du2C4WiNYhN1Hr8WME0bBf7YMA8NSQ8M9FzGGvFQmgtRfgMFXKk/AyhFD3CnB5+hbP5oRH/2OYVPy4MEPOpIdkAARh41IzNcc/fU+NssYAvztghVshPukkEiM7exqJbj/1wVYDlcB6tLxqJHRTUvGvtMdIijIfDa+3STLy2B18GrTi9uJqY9z2+xMrmKZhYvw9Bu4fWjlqM1D3ALWGqnwVWlvYFzd1wc6kNbBzVOMy1TSm9sOu91XZTmSzXIMJkpd0X66lftUpAtUh5BLqHBaYvQnBJsRNCOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+QEmddqvHWVedPnX9YetU6Z7qm27aH9C2ckkbdi18I=;
 b=BmlFpz3mEBrfGMS4Jq2ia0AnerBrBGvZY/Eoccbs/fvNLQvA6KLuhR1jaB/Hvq0jY/O+mpnH6nxTHkeFke+dbDYSC/u0s5RaoanUFE9ti13oM4P8KouFROXvti+f6+aF8eFSrGzYa4BXet/xh+zA6WXKIjzEpKyLbCS5iT9jhIz+JY4SIXOjYk98sEc9JA8w9wYn+moXEUjdwJ4caQ54j/IiPvvMk6DdSgoReh878lge+NJUyDRyDdbHYSDJoxewLVnd8pFT2BdpL6g/f0IOIGQl9t4GL2oQOQ3BFYyEOIgMxicNJStW9P7BQ0agbqbM43BcFXbeLOJB+4B+JZYxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+QEmddqvHWVedPnX9YetU6Z7qm27aH9C2ckkbdi18I=;
 b=IBML1yuSclUQkV2+lhdZlX3F5xcPbJDrwmqAdgp0Yz4cpr1ZpkIARgMmNbm+8kQXuCXojX73edXR4k9s9cLpnCi0B9fMJcqLHeD3eYAZp4eWHFUVUCgFobL3bQdEbXRvaLczJNWXSTmvaksWixEQNdOUdZ3dplzs+/w2uHxhszTj5k1w2WTexe263YzXsN4k9Dy49Yvo4NsKRE3BY/TClO1MY0DHq9Fw6QzJ1kCvJquZEQ5voeea6/PENDvCB79YJWL3J0YCD0HrPRtVhUSSmcYrrtffXOl0G1eiGimr7zrr3UhiUZgcvwHcMZlLNi3alW4s5/7yro+lmzJ7G5pmMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PA2PR04MB10188.eurprd04.prod.outlook.com (2603:10a6:102:406::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 13:18:06 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 13:18:06 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 28 Nov 2025 21:16:36 +0800
Subject: [PATCH v1 4/4] imx8ulp: dst: Enable USB controller at 0x29920000
 in host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-usb2-v1-4-25ec5ac127ff@nxp.com>
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
In-Reply-To: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9636:EE_|PA2PR04MB10188:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2d623e-8c70-4fe2-0777-08de2e809165
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlNROGMrUE1xM2tTcEFwTTNOUHdaYjFFUDkvZmc5NDFKYStzRUhVaHlZUk53?=
 =?utf-8?B?S0twdUx1ckJ4RjJpV2ZNd2gyVFZkWW5KcnZEQXFmYTdmRHdRQlpscFE3MzlP?=
 =?utf-8?B?cVRBY3BCRXNnZDg4bDFGejgxREx5LzlaSkkwRCsyWFBvckRxZnZGMXVWMWdi?=
 =?utf-8?B?TFBmOGgvZU1RbDB2RjF4bFVESVUwYWwzLytQMHpLSDlzaWZ3YnBCcTVwZ2s4?=
 =?utf-8?B?aDFZTXZ2WXp0VDFGWThWTWFYbzVZR0J6QWRrczlGVUlQSFFuUEpPV1QySHVn?=
 =?utf-8?B?a01NNCt2TGx4KzBSTkVkcFAwc3hVL1JEb2ZEVng1NlYrRm5IWGk2VEJtMFRB?=
 =?utf-8?B?TitzT0Z3R3BSSHNvTTlsc1ZndytIU1VWUUZaMFBTMUdxODBuVnE0ZUdNRmZK?=
 =?utf-8?B?OFlNd0NpYVN5WnNQaUZIQ29leVA5UlB2SFlCMTdHQUtQUVpyVVJOM0VWWWpE?=
 =?utf-8?B?eCtiRUhscnVlUHNXMnVRNUtIQ2pDWnBPNEZSTEgzWUNudWo2RUx2NjFhQ2RU?=
 =?utf-8?B?SEtkTmNsdmtyODRkUHpvekhMTFdaa3ZnTnptVldScVdQcy9KM1BNeFVYSmo3?=
 =?utf-8?B?WVdyQi90WVNsY1NnSHBkY2lKYzJiSjA5aVNieG8raUhFcTVXeDFGMGQ5bHVp?=
 =?utf-8?B?cEgxalBRb0xiVDBwWnRnYy9Zd0VudnBuLzJMd2JZQmFhd3dCZkwzUmRKQkVk?=
 =?utf-8?B?ZWdaN0MwWXNYZkpLZ1Jlb0drU3piK1BMaWdoaE5pcmN5VUJWNlU2MlF4SE9U?=
 =?utf-8?B?c00wbXVVOGk0bWNuQTBSNDFLMThmNEVjY09jT2QybjJmemUzSDkyNHRWeVB6?=
 =?utf-8?B?TElQaVBHaXV2dUFoR25uU240eXBuL3dYNzFTNjFOTXBIbkhlQVpadjYwMGhN?=
 =?utf-8?B?UVgzZEZDNFNGLzZSZXoyOUluaEdjMkhBYkFLMDIrVHgzbnAvZ3l1VHg2UTAy?=
 =?utf-8?B?VlZ6b2JaSDByRmVrMDVQQXpERCtiVHRGR0R2eGhBeFNZZVZIdEQrcmZiRkF3?=
 =?utf-8?B?NTRvNVZOb2RjTzlGSTVyWVROZ0RJdjViK2hIdUV2Wi94a0tYQjk2MS9vZndT?=
 =?utf-8?B?U3lzM0hjRG9VdHpqeGZTVHhwbHltdlloeGFDUCtrRVVwbVNONVp5WVV2eWVj?=
 =?utf-8?B?Slc2aVVTYUljU3g4ZFd6VmlzTTU4MDNramhaT01Ld25VMHhGWEM2NXFVYkRn?=
 =?utf-8?B?bG5sbnpLLzVELzkyYVdGTmd2UTJNZlFOQmpOSVhlanBWdXhlcEkwT3J3S3lT?=
 =?utf-8?B?dzltc2RwcGFoVktySkw0cmZhZFdEYXAwa3VZVDU0N2xXdUgxUnRzTUpMblZy?=
 =?utf-8?B?Y1hCbGZBeFR1eUpXVHRvaG0xQndXQjdrb2xWbVlJMmlmZU5OUXExZ2xXcVly?=
 =?utf-8?B?OWpzR0VST0hDS3JBM1VTOExYV0lQK1ptS0pLcXJQdWo1ejdKYm00UXF1MmdB?=
 =?utf-8?B?ZzRxeE8vZGUwUXdZYXJaUmk3Wk1DTjFaYkFSc0VVWFVDOGFrOGhWVWpRWmtQ?=
 =?utf-8?B?b2lMK2xxNlJXZFc1SkovajA3OUxSSnlhSEFBVlEybHNZTlU0L3RYQ09UdXcy?=
 =?utf-8?B?TlN6NHFFazlaaHQ5ekpsZ2VWWlFiZlAralc1K2cwUTBFOFg2VlU4YkZDL0Q4?=
 =?utf-8?B?d0ZFbE1jTHE4SkUrbzJxTlpQZTQ1SWRLMzBxRmM4QWFhVGdmNExNRGx0ZzNP?=
 =?utf-8?B?REtVUFBxWVBHMERaR2taOFd5M2NkTmxnSVQrUmREYnpwRWVkcllTK1Z2TElQ?=
 =?utf-8?B?Qnp3RFlpcGtOVXpwNTQ5dUEwQnZEVFNUalFRNWhkZU53MFM1d1FsVW1aQ1Vv?=
 =?utf-8?B?WnJWdGVkaWhmN0tiQ1M2a3Fmd3ZQTUprSjkrNGxka2Q3dGNWeEczYUIvd1Fn?=
 =?utf-8?B?eGZBNXZaeFB3cERhakRuK2pJTkNkK0FIaTlkSC9SMlRvMlhMRjljTHNEYUZ3?=
 =?utf-8?B?WXdsNFVWSTZVbHYzbFVqMjcrNzZaUmlaZ01OSk5Iem9RWE41WXdwVmJxME5t?=
 =?utf-8?B?bXpZbGM1Z0hJMGhoYTQ3cktMc3A1OXJ0MHV5Q3hIRUlxanRHcm1Zc0c4NEMz?=
 =?utf-8?Q?YnSPNq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS9SMC90eFZwUGJVR1JPQjA5QmFPSWNlQmVOTGpEN2xsSi95dmZjWjJMS3Qw?=
 =?utf-8?B?UzE1OTZPS1hwS1R6dUhYcWVUSTB1THowUmlnektlcG9SSFVYdHRTaXBlZkly?=
 =?utf-8?B?UFJJWS95eXVQdlRuZUVObFB3SC8rc09aMnROTkNTVHNWYVJ6c0J1aHNWaXgr?=
 =?utf-8?B?TktJWmFDY0twTHFpb0JmVm9idTBxMjdFOGpHRVFWek5UaTNCTGpCWWxINUJ3?=
 =?utf-8?B?Qk05YWxYNDFxZUVrNDRpclV2R1huQXpkdk9HUWhJMU51dllhNzREd3hGbDhG?=
 =?utf-8?B?M3ZvOWxacThFUWkxS21GRWE0SUFLS2VvcFNxZWJqQTJuN0tnY29wWUtMakVM?=
 =?utf-8?B?M3JvYWVlVWdzd0gwUzJMSkw2N2dwKytzTHB4aThUQ1BDZ3lOdXdOV3JBeTRB?=
 =?utf-8?B?ZUNpRDYybDAzT1NBbVN2ZFYvK0lRRTVldkQ5UWcwSkNOM0lNR0dSQnNMaGtT?=
 =?utf-8?B?Z0dUQ2hkdmNyYXBKc1MrZHYwWm1GVXRGYi9LWnh6cXhDTlhWUlNHMGR1czZS?=
 =?utf-8?B?b1R3MGltNmtzTkg3WUhEY3phcENnRWdzOGpaNjRWRTk4VWdLeGljM2NKcDFH?=
 =?utf-8?B?YkY1bmhBYll5MGlzK3BEOGtIbk1STTRBa2lJYXpKQTREN2EvM0VxemttcGFa?=
 =?utf-8?B?ZG5PSVdtRkpuQ1doRGtiSG1meW82RC9RVFlVS1dKZ0VvUlRZY0djb3VJYXRG?=
 =?utf-8?B?L1RVbmV6YjZUU3NEWXZkNmJMZk9BQTNTYUtUZVh6eGRBM3J5QWExaUp2aUw3?=
 =?utf-8?B?RnNMdWhUQWRyUkRJT1AzZFJHMFovZVdPK1Z0VFhNc25SaitOamlVRDEzbTFl?=
 =?utf-8?B?L083R1d4TUxWajVYQWI4RTJvc2ZWOE42RHN4UDZ3Y2RiSytTakNoanVCZ3Jn?=
 =?utf-8?B?RTBpNGlveWV6c2YwT0JEVldSRTV1WU1VWFl0eEgwS2xGR0FMSEFDUGtidVhp?=
 =?utf-8?B?N1ArZjhFVWNEODErQURhMGhNNHNWNlNQSEF2ZnZsRlRsaEk0ZWI1bHVOV2No?=
 =?utf-8?B?UFgxZWR2aTU3Ums5MjBNOFRBWGNLd2V0blBjYmxEazlpeithWHJsRGR6SXM3?=
 =?utf-8?B?ZjhkejlERmZhdjczSmt3eC8zMytOMEtsM1FiUUN1NzhvMkladmRvNDJUbXl0?=
 =?utf-8?B?RDROdG8yUWdGalE1aXFWYWpjSjV0dXVieGRaSkxHUlF2VWpPOExwc0YzRWwv?=
 =?utf-8?B?NDVPVDBNMG1WMnVYMS9XTkxncWdkU2FhN0VjZFZsOTdxV20zbkdhMDdYdjNE?=
 =?utf-8?B?SnZTelZDU1BtaWlZUTM2T3NHNXpqL1BPRndGcVlHWEY3RmFrNFl5MVpjbEFL?=
 =?utf-8?B?Y0dxN09TTGwreHpzNi9nODRxQVBWR2ttNkI1dExGOEYrSk01cGUyMUlzR2l6?=
 =?utf-8?B?RHcxZkVmL2NOMHFNamx4M2FocGxUbWxpYlFKRGlmWXFCMk9uK3pIZEZjNDBR?=
 =?utf-8?B?Q0YyL1VYNG1HbXE1VnpEZEV4WWFZOUZGaFpveTF6MVpSYUorblN6RFB5S2JI?=
 =?utf-8?B?VGcxK2Q3bGZJRUlqaGRUYkhJbnRFVzMzVFlxZzdHdEE3T0FLTnE2YVdxRTFm?=
 =?utf-8?B?RHJhaWhBSGgzOEZXeTRZL3FaM2xNY2xNTi9nUGo3VDF3M3VlTWJtcDFiSTBC?=
 =?utf-8?B?WnJjdkJzUzdZZTJ3aUZ5ekhUSWNLM1d5cjhOMTZnZmxKS1RZU2lBT0YwWVBN?=
 =?utf-8?B?VjB0emVvaEJpWHUydGc3TU5TVlhsRnZBWjRhcEZrWFFEZHp2NVdnaGpZclY1?=
 =?utf-8?B?czAvTTJTQVhpOExHNXhFMHZPTGRWSno0SnladWRXbnczZGF5dytza2JxK0k5?=
 =?utf-8?B?Nnk3Um1maHkxc0xBYjFyRU1wbDQybzF4SXdST1RhZjVmaHNpVTRJdEd0VmtH?=
 =?utf-8?B?Q3lJTnVtN0lrbnBWQXdKVkwzUUVSSGlMSUw3Mk9pOThvT1RhMWVRblBOSjFF?=
 =?utf-8?B?Mnl5dUY2d0FrNHNDQkFyenhNRDQ1SVZUM2pwK1dOQzRoM1YzTWFHdlloeVpO?=
 =?utf-8?B?UENFaXNBekR0MUh4cE1mTk9ucDZKblRRK1dUcW9yaVVQUkJWYSsySERLTmg2?=
 =?utf-8?B?NzdxSkNieE8yREtnQUJveVMvTTYyejlocjdBOVpPMWovbXYxOEZHb3pydVpK?=
 =?utf-8?Q?FFwO1yOlemLakT67u7L2x5P2T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2d623e-8c70-4fe2-0777-08de2e809165
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 13:18:06.6589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abEiHEfBsnxeHb8BrcXJZtohDMo/kgLbqJU5FCy+6zxr+mqOeq+Rb8bQAhug0cOy7ld/lyoz0/xBBoMFVroBpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10188
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

From: Alice Guo <alice.guo@nxp.com>

Update the i.MX8ULP EVK device tree files and defconfig to enable the
second USB controller (base address 0x29920000) on i.MX8ULP EVK in host
mode.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi |  4 ++++
 arch/arm/dts/imx8ulp-evk.dts         | 27 +++++++++++++++++++++++++++
 arch/arm/dts/imx8ulp.dtsi            | 30 ++++++++++++++++++++++++++++++
 configs/imx8ulp_evk_defconfig        |  3 +++
 4 files changed, 64 insertions(+)

diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 2782dc7dd75..e35886c9e96 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -38,6 +38,10 @@
 	bootph-all;
 };
 
+&usbotg2 {
+	compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx27-usb";
+};
+
 &usdhc0 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8ulp-evk.dts b/arch/arm/dts/imx8ulp-evk.dts
index 7aec1706382..fb28748ec17 100644
--- a/arch/arm/dts/imx8ulp-evk.dts
+++ b/arch/arm/dts/imx8ulp-evk.dts
@@ -44,6 +44,26 @@
 	status = "okay";
 };
 
+&usbotg2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_otgid2>;
+	pinctrl-1 = <&pinctrl_otgid2>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
+
+&usbmisc2 {
+	status = "okay";
+};
+
 &usdhc0 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc0>;
@@ -103,6 +123,13 @@
 		>;
 	};
 
+	pinctrl_otgid2: usb2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTD23__USB1_ID	0x10003
+			MX8ULP_PAD_PTF6__USB1_OC	0x10003
+		>;
+	};
+
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTD1__SDHC0_CMD	0x43
diff --git a/arch/arm/dts/imx8ulp.dtsi b/arch/arm/dts/imx8ulp.dtsi
index 06ce5f19aa8..54d5e1f8644 100644
--- a/arch/arm/dts/imx8ulp.dtsi
+++ b/arch/arm/dts/imx8ulp.dtsi
@@ -399,6 +399,36 @@
 				status = "disabled";
 			};
 
+			usbotg2: usb@29920000 {
+				compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb";
+				reg = <0x29920000 0x200>;
+				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB1>;
+				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
+				phys = <&usbphy2>;
+				fsl,usbmisc = <&usbmisc2 0>;
+				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x8>;
+				rx-burst-size-dword = <0x8>;
+				status = "disabled";
+			};
+
+			usbmisc2: usbmisc@29920200 {
+				compatible = "fsl,imx8ulp-usbmisc", "fsl,imx7ulp-usbmisc";
+				#index-cells = <1>;
+				reg = <0x29920200 0x200>;
+				status = "disabled";
+			};
+
+			usbphy2: usb-phy@29930000 {
+				compatible = "fsl,imx8ulp-usbphy", "fsl,imx7ulp-usbphy";
+				reg = <0x29930000 0x10000>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB1_PHY>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
 			fec: ethernet@29950000 {
 				compatible = "fsl,imx8ulp-fec", "fsl,imx6ul-fec", "fsl,imx6q-fec";
 				reg = <0x29950000 0x10000>;
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index e750b3d9ae0..11031c4d12c 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -54,6 +54,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_READ=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
@@ -92,4 +93,6 @@ CONFIG_FSL_LPUART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_NXP_FSPI=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

