Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDD7D44C60
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F93982BF2;
	Thu, 15 Jan 2026 15:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZvKaEH1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0296B83015; Thu, 15 Jan 2026 15:57:42 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05ED680077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPIWNvSsdAQkuEQHYec5o9rEmTAzqu58X5w/6Pn82gDbE15Uivtq8nGnjaErsw75AjeQ6tOP1uyWX1kce0/hu3XZGpQImSLhyaN/a0QkJ7ymbwKN8bBhfBHUsASy2mLCVyAYRJ7KPgw9hbG7LcgNIEFtg2Z5Z16nhBuuBMlm9kcjsFqe7638dgv5odZgphpaLNQR0i65sUisuxdkJni92oqqwR9DvvsPoRhw7YTQvKvW/6sXPNYfacqPCo540cQWamH7kJlbGMiewjp9ZKQNjwhYqkbevK2GYQeABrHqSqNpMJUMmYJZ9wcY26t+XaQR+Ah8SlQMt9pVTpQgOetDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP+qb1kW9vGP+KVwXAFtOdSQMOeII+21V2yeDFzWCrA=;
 b=gRAxHWVevTXarSDkFU7cdRg4zQbTyCcUDC16VauEVlDOa3QMkNv4zMrR6CHsRrK1lb1orTzTbc4K0crzKEOX4N3yN9LqM8mRzCN7+fNZ4I0x9PWlIYlLHO5BS/KNqS49JgCSfu6RcuL5WHWkRpGzzdZwjivCAVsLIBX0OS05ElveK0dXnhiriDdARkCLl6E3xhyLrQAHGUNDBJFSE1CS442KopipLxFVEvYEVoTqR449T/xeI9HGy8UKW6eatZCXifmbalSOVI0xIQYaqxFIialTj/00CX5VDUCzcSIdKPnyWMzw0VuWglZVCRKYlIeeUs3smxZkFLk3SvRUdaQhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP+qb1kW9vGP+KVwXAFtOdSQMOeII+21V2yeDFzWCrA=;
 b=ZvKaEH1obSIkVnez9t/LuyrpbZBke7DGFa8UDNsmyFLuJeDPr/fYVX8F/lYaBvJ+bhvoLwfz5hEKlnGcMzFMS0OroKyujPrfmAukhs+80XsolSJYFjRStwQE+Ld9uVM8zW/B02EzK1QLdZvI79rkVoNxAMQFvZ2yuHUDuuSLW34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB8PR04MB7098.eurprd04.prod.outlook.com (2603:10a6:10:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 14:57:38 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 14:57:38 +0000
Message-ID: <973ffe5e-e962-493e-8a22-6ef09a1475f4@cherry.de>
Date: Thu, 15 Jan 2026 15:57:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add FriendlyElec NanoPi Zero2
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
References: <20260110205337.1242457-1-jonas@kwiboo.se>
 <af311e0b-e9df-47b0-9313-93186ca0c14e@cherry.de>
 <7d77e501-2347-4f1e-af36-c82a47dbf126@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7d77e501-2347-4f1e-af36-c82a47dbf126@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB8PR04MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: b582234f-d388-4104-3631-08de54466c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STFFVXhoMDBadG9CY0twYXIvNjNsTE1Ec1YvbDdkZXc5YWhxN0tnYXovQlFo?=
 =?utf-8?B?L1VPRDVmek5VQjY0VThvTDV6em10VUhjYUhqMXZLSXo5VWpKMFkzb2xYU3or?=
 =?utf-8?B?cHpISVp2Wm5RQklOZW1sOCtNOVRhbkpFNHZhMVV3SWJkb0ZKcEQ0WE5rRyty?=
 =?utf-8?B?UGo4bmxVMEFiOWpSWjlVQkRRS1NQSzNNWFJYYi9EUm5MYlEzMUZDMDI1cWJ5?=
 =?utf-8?B?a2h3dzNMU1BHWVV3eTJmbjBheUlWYXlwb2NjQ2JlN05CWXI0RWQ4RnJ0UU5Q?=
 =?utf-8?B?ZnFBWGJ1L25rT3FJeU5CYlQ0N09BN1p4T3oyLzdaOTQ4UTVkSGJWUzNQNE1k?=
 =?utf-8?B?a3BCV2hyRloxN0RONkxSbGduTXBrQWM0Vy9aZ04yRm93OW1Ndnprc0h4Ympl?=
 =?utf-8?B?WGNGZWNKMVdrZE9IK2srRmRxd0JGV3ZMMFIzY0gwMGJERExSZjFLOWZ3U1JI?=
 =?utf-8?B?L29NVzBscnFTNWpHNU9JeU12VWRlK1ZVWEJPNHVxbUV0WXFRSU1lTXR3TGJt?=
 =?utf-8?B?bHJzK2o4Yi85Rzk4UmxpYVUzRG1UVTNkT2tkRGJoeSt5dGVnVndrNE1TblFn?=
 =?utf-8?B?UlJqdW9TN2s2QVlwVXRzQTdoeDJZVlgrVzhIVVFWRXlucmY4U2JmSnZRS0k4?=
 =?utf-8?B?cFJZdW9kWUVXdTRRdEpQcDFnb2ZiV0N0M1dhWnNYTzdMeXRWbEdoQ3hmVDAx?=
 =?utf-8?B?Y25RUlhUSnczUm1xTm45R3g3MXNzQlhWSjFwSC9OdDFSVUFWaUQyeWEvY0F2?=
 =?utf-8?B?bzNhSjJ0NlBhYzd1OGNKRVZCcWVVU2hyTDJNVFJoZ0Y5bDkvUmtaZEY3K01w?=
 =?utf-8?B?bjZQWW9lWU8vcHhmRE9ZT1hjZFBvbytuN01pMVhYN09TekErYVEvRWsrOWY1?=
 =?utf-8?B?Q09Bbit4VVZGc1VHVDFPbERabkYrUmNSWVMvUnRiM2creTF3QnhjSzlKQzNU?=
 =?utf-8?B?V0NUZUUwUFdzQjlHcW1wQXhiZDNHMnYvSkg1SFVyVG42QjY3Yy80bURGcndl?=
 =?utf-8?B?SDVVYjVHdWR0VWhUbGpIcHRVaUljSElqNFM0akRramxrV2FDSTZvN21pSTZH?=
 =?utf-8?B?bXVJTUdTeUoyS0ZVazliNTFQSkZ6cStMOXYxNGEwMFAyMnBWVmtwYVk3VVFR?=
 =?utf-8?B?aUYrZVByR1UzVE9jTkN3UWNqVHhwUnkvU2lMU0xSOFg5SEcvQ3lmRjA0Rk95?=
 =?utf-8?B?M3Z2bzNucjBpV3ZyTnA4bzBGZ3ZCUmJCRFk1eEZmaFBBMVFDMVgxYTkrN2xq?=
 =?utf-8?B?NzQzRXE0U0hDU3p3QndUNkNhdkNhekV6K1BRczRnZlpjOTV0WmZ2eHlPeFpL?=
 =?utf-8?B?ZExWRDZsRUhuaDduNVpHczhaQVNZQjcrS1l1SU1PVFU1R2w1ZHNNa2tISWZ5?=
 =?utf-8?B?YitsM21QRzRPSFc0c2pxZGNMSzRMZXNnOXA2MmxleGdFSW5KTUtHVnR2Y3lH?=
 =?utf-8?B?WTJVTE5JMG51K3YybEM2Z0RhQmE0K3IxK2xMb2U0aVBkMXorNFZLdmNwSWVp?=
 =?utf-8?B?bFB2dEFwZGI4VmI5UzFEbldIOWx0c2JZS0F2cXB0bytBcVZ0V256TTgwY29s?=
 =?utf-8?B?WXlvbmk0ZFJ4aTRnOHN6bVlzRnMvdHJrYkVIZWJHU0pFeW9lRi8rUmwyY0xN?=
 =?utf-8?B?VVBSSE4zZHdSZXhOQVFuZUJmTnNXWE1aNGE3Y3dTVHk3R3YrQzU4eUVlMVFw?=
 =?utf-8?B?S2JQbERGYm04OWZsL3Q3akh6T0J5WFdLK0w3VkprQmZuNkpZMXhJdWw3NUdr?=
 =?utf-8?B?eVJwaW5pcklrZDJRZW5xUkFWYzlBQjZjQ0Y5Q041ZmUrMGpWd2dITmJvQjVL?=
 =?utf-8?B?UElxbUI0VmtTb2dYaTQ5SjVwOXhjempmS0tQWjQ5dUdRRWhockNKT1k0Y1c3?=
 =?utf-8?B?Ynd3ZkI0QXJTV3hpSmpyQVQ3QlVqN1NFQ2JKbkt4c3hsWFo1MnhBVVkrNm4y?=
 =?utf-8?B?L3dOU1U2aDNra3V0T05lUGkzQUpwZUpMam1MeStxRW1aYzFLWGkvV1Jqblps?=
 =?utf-8?B?OVpSY1BkMFc0Y0pwbWdhUFVRS3R1U0VyS2dCd3ZTMUxLYjBDWmdXRGlxbzRI?=
 =?utf-8?B?N0VDc2grc0ppSmlWaGRMZ04vZUwreVlwQnpZbjJiWFFQZ1FzaWVNUFZXOEhl?=
 =?utf-8?Q?78Cc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2xRVllWcW5sVkN6b3Nud21KdUFKcXMxVGozK3h6QmphRG5DVlJGWk9wWnln?=
 =?utf-8?B?S01lZERvZXVIRDU0czNyM1BIbUZ6UzN2SUh2R0xvUHBqbWwwOUoycGEySFNB?=
 =?utf-8?B?UTlPZXdKMkE1S0JnMEJTbVh0aFVLZGNPblEyOHdyeCtNMFF3cmlhTVJ6Rmdr?=
 =?utf-8?B?NDBRdDBZOW5YL1o3WmFGQTlRbXFDK28vV2NvQ2oxSW10K0dSM0EweDBNZk9a?=
 =?utf-8?B?WDR2WUJGMkt1Vjl4cGx4dEZDNlhXMURKb0pEOUxBZjJhVlZHdmtGeVBtQjNB?=
 =?utf-8?B?SVRGWXNIZHhVSUhBWi9xY3pNRDRTV0xuVFVCMzViUHJOVHdRaEFhbHVTYk9F?=
 =?utf-8?B?MWxKWHdEbTU0OWNvdGN2WWJhYVVPaUNHSnQyejJWNnFYSjY2bTVGeklmV3VQ?=
 =?utf-8?B?YmZseXQ3RUNIYko2aUx2ZXNEUTNnZ3F5ZEpHTWN2c3lRME04VWJSNDBwQm9E?=
 =?utf-8?B?V3VFQ3NGS2ltZGVTakFCSCtQWkkvNzdVNnE2OW5acU5scjJJRFo4UWZMUC9p?=
 =?utf-8?B?YXVTWU5qUy9LUy94UkgrUjdocUFuc2MzMkNwUGdVZjVGTlhUcU5vQW1WNktO?=
 =?utf-8?B?am5Vc3ZHc1BoN2tOc3RzMFQ0aWpvdHpKMmtqWW91YjU3NmVURmFUWEp0aXhT?=
 =?utf-8?B?WDM2YzRJem9Pekd0Rk40MWYxVDVaaDk1TmhRZy9yL3hVN3dRYVplUzZYa2cv?=
 =?utf-8?B?RXl3YnlMdUNITXlmYTNab0NSR24vYWhYSExzNzVzeXhOMW5kSk5vZXFMTXdT?=
 =?utf-8?B?T0ZyUWFhV2d0cVBYNTBxYzNkUFhWcWVYazcxc3A3d0h2a1hlQ3lSTURJMW54?=
 =?utf-8?B?S3I2NkNreTM2WmVuTW1xdWpQNm50N1ZxYUluWS9ucVRmbjN3TVZNZEwwUkR5?=
 =?utf-8?B?VERKM3pPZWNIenFEQWJYelh3ZXZYNjdWQnY1SlZnOGtyd3lQM2FVQnRZUG83?=
 =?utf-8?B?cWRNTlgvVUdYZWRlLzFHTDM3NlhFbmVIVmgxTWdRUktDejc2b2J2WDRRYzkw?=
 =?utf-8?B?amhFOGRhZi9xcVAvbUlXTU5lTnVmWjBxYzVkWjhXVGpaYkhsZ204aGxwa0Ju?=
 =?utf-8?B?a0cwY3ZyZFVrNGFiWGt1MG1jNXJSWS9mSHBEeGZ0OFdLNGIxZGk2a2syN2JL?=
 =?utf-8?B?VVE1L0R0YUFQSStuTWovaXpQdGUraGFjWGJsMDVqYjMxdFVnYnpBU0I5dUJ5?=
 =?utf-8?B?enlEYVgvNDJsaGJUcFdyaDBSRWxkcnNzZlFTUzY2MEZxQWtvb2lsVHBqcWNZ?=
 =?utf-8?B?amlPZXpRTVdxQTNicHdvVTMwWHFuaXllNnNDTlJrMmFaWC9GRTAxckdvclFU?=
 =?utf-8?B?ZEZyeDRMVnhCQzBCL2RDL1JyQjdFVTNXS0hUWUoyTUxHNnJNU08wdjdPQTAy?=
 =?utf-8?B?MkpNeWdNamgzM0J3R2I2bW9XaHZkemhOZCs1RWZJTEtXMEtDVnVBb3JYZkxQ?=
 =?utf-8?B?Ny9adHFBWDVGLzBBY1pENjBEU1N2K3RjbDZ4MFRWZ2hSK3hKRWV5bk1wKzJW?=
 =?utf-8?B?ZnE1V1d4V2NZSDJoRHVGbVc4SWxEdWYxbjVOVS9KMWtWNHZxTThoa2x3VVN3?=
 =?utf-8?B?MGZtckw2VS9id1JYVlhSU0JqbTZ6ZlVSbGEwMXdKeXcyWUtRNGZ4OEttZzRk?=
 =?utf-8?B?OWRjU2J4em9reHV4MHpTNDkwWkhSc3U5YmMvMTFoSWIzV2Y0cXpHR1VhdkYy?=
 =?utf-8?B?RFFIamY4V2trS1pwODVmSUVseFk2eFNiYVdJb1hGMzkvVVpaYS92K0d2d09z?=
 =?utf-8?B?MWdEWWJwT3NHMy9jTzlXWUlGY052Z3lOMFpJcFlFT2d6SVkzK3lhL2xRcmRO?=
 =?utf-8?B?VVJnbThBTGV0anFhT2VTYUlncnk3MC9vR2FTQXRlaFVJTlY5djdpSTdwUjFm?=
 =?utf-8?B?L2RBL1JwK1BIbTM5NlltVnZ1NEZzRW81K1NSb05nYlpJTXRYVTladE1PK3F1?=
 =?utf-8?B?MG1rSU5XODJQNjExNXNPMlZQM05uV2dHZzg3VWQxQkJ0VDdrVjgrNXVrdG5V?=
 =?utf-8?B?Q25PemNKY3dmMkhna3NvTktxektnTVBmWStPWEN5bklQemJxZ3p1M0J3dWdq?=
 =?utf-8?B?UHRZc3FOYUdDT2U1TFZQVFpoWmNzMUUybmlRcWZJZk9HQzlDSzNidFEwNFBY?=
 =?utf-8?B?YWI4WTVyNG04Q1hYRlJRN09QWmo5MHpORFpxbTlETkhsZGZhZHZGTnV0MDc1?=
 =?utf-8?B?MndHK3NKZFFqV2R1S1lRU0srU1hZQXlXYUVuRGNtdExwbjJxemdxZXRsM0tu?=
 =?utf-8?B?Nzcwanl6TWJ0cW5ITzhXYnVhVkJ0NnZtZ1lLVUd6N1VXZnBlYVhrd0d3RCtP?=
 =?utf-8?B?aUpSZWdnOC9jYU44WkNuWXJ6ZEo3UHZFMkhod0JDZ2ZyeTZNQ3c2UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b582234f-d388-4104-3631-08de54466c94
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:57:38.0181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNTS5l4yJfN/lYCP9/mhqNEliPul0/TrxlIfiB6D1gN1UhVz4h3j4/QVEhewJ592qNL4fna/sqBWgaOOXlN2+PoKB8TssjsE/T6ndIp6gnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7098
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

Hi Jonas,

On 1/15/26 2:35 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 1/15/2026 1:24 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/10/26 9:53 PM, Jonas Karlman wrote:
>>> The NanoPi Zero2 is a small single board computer developed by
>>> FriendlyElec, based on the Rockchip RK3528A SoC.
>>>
>>> Add support for the FriendlyElec NanoPi Zero2 board.
>>>
>>> Features tested on a FriendlyElec NanoPi Zero2 2407:
>>> - SD-card boot
>>> - eMMC boot
>>> - Ethernet
>>> - USB host
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 11 ++++
>>>    arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 ++
>>>    configs/nanopi-zero2-rk3528_defconfig        | 64 ++++++++++++++++++++
>>>    doc/board/rockchip/rockchip.rst              |  1 +
>>>    4 files changed, 82 insertions(+)
>>>    create mode 100644 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
>>>    create mode 100644 configs/nanopi-zero2-rk3528_defconfig
>>>
>>> diff --git a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
>>> new file mode 100644
>>> index 000000000000..3e2fbd81da17
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
>>> @@ -0,0 +1,11 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +
>>> +#include "rk3528-u-boot.dtsi"
>>> +
>>> +&vdd_arm {
>>> +	regulator-init-microvolt = <953000>;
>>> +};
>>> +
>>> +&vdd_logic {
>>> +	regulator-init-microvolt = <900000>;
>>> +};
>>
>> Why? We need an explanation here to know if and when we can get rid of
>> those additions. Why aren't those in the Linux kernel tree?
> 
> All prior regulator-init-microvolt props was purged from Linux DTs some
> time ago [1], instead of adding a dt-binding for this prop :/
> 
> After that change we now need to keep track of any initial microvolt
> that should be set by U-Boot in -u-boot.dtsi files.
> 
> If I remember correctly these regulators may have been initialized with
> too low or high voltage out of reset, and this ensure stable operation.
> 

That seems odd to me. Why could it reach U-Boot (where the regulator 
driver would then enable the regulator at voltage init-microvolt) if the 
regulator was initialized too low/high out of reset? Especially for 
vdd_arm, the CPU supply.

I'm not sure we'll be able to convince the DT binding people to add this 
property though, it all seems like a problem related to devfreq not 
being handled in U-Boot that could be resolved by configuring the 
clock-tree + regulator-tree properly appropriately I guess (which is 
easier said than done :) ).

We already have plenty of boards with that property (including some I 
maintain... news to me :) ), one more won't hurt us, so

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
