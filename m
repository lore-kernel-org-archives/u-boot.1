Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB22C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0000819B1;
	Wed, 19 Mar 2025 13:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x6QSex0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC3F981A04; Wed, 19 Mar 2025 13:35:44 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E146F8193A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Twn2mz8Jstqqap3JFxGXaIGeozR90QM05ibvZOmUDbTSB5SAtf9j3iQpHHPWYybqFJMChdewkJh3ibw6sPVh4MDBWTobfI4JcmjJ6q8uD4/reeGVE+93nqh5Gq3DG4RcKOvDEsUECdQ3VSJvV+Ylj3VRPDI+exqKFhYGDbX93Pv75vZpny5hop9wtYdPE+2QxmZXO81pTXdeewY/C6e7gvIExTXu7/EYmDHKVerXIE0Wtpce3ZLYPWOzwJUd1LdtoyD4mGnHZpDKa+qOYikccuN+GedekdXFevUTPdgVLEOw/EwjsxevDqlQuOpq0OUpmNyyaygjX7evC9VZcYMi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlN3SrK2i6P4ujbtVyCwdPbX2GQ71A3cXZkW/S1M9Us=;
 b=jAGxZuMvBckCYfbvKjArA/PkplTnDhf8B5zeQ/2yNB2QxBrDGhcXQ4zYTLXo6NMs3rrn7Lp9AAeficIq5XOd+kQXnMlTvi9IAqVt6J9vQwgvx7tOD7UKc0D8Id+IEMKEHUWlX4QKC+5oNlMhe2aakWG3ucYrmsBg5PfMVsKw0I4VJ7iPmTMKp9o2/wqpIXQHU/NKau/HXurMTd/Rou0qsycIG3zyf04hxV2r9IT03M64zEIsYH879ab22fBMDdM3rxCW0Vxvs4gRRDgXBtA3+sxNlZ4pHY1vxW7vD4DFUdvS1zaqDTTa/0JXyG0EJSHU2S4yZ/nThhUCmNdZwuL3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlN3SrK2i6P4ujbtVyCwdPbX2GQ71A3cXZkW/S1M9Us=;
 b=x6QSex0uc4eaco3i3+B6TFwYfOELs+hIr0pf1tSMt6U79fU07e8Xu6v32Cwsmpp0l92gF0LXSh25FQteysRd8pSwvZnK1y2OtVX6Gk6yiLhzwBsFr5cj5jnyEb7ePb4alP3Tc7lXKMGpzVz9ez8eh1/AkG+6vU1EJoDn855iukc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 12:35:35 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:35:35 +0000
Message-ID: <67ead22c-b74d-48c2-bc4e-3e52669a8a7e@amd.com>
Date: Wed, 19 Mar 2025 13:35:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence_ospi: Add device reset via OSPI controller
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com,
 marex@denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, u-kumar1@ti.com,
 trini@konsulko.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com, p-mantena@ti.com,
 git@amd.com
References: <20250311041317.2992862-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250311041317.2992862-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: e41b3baa-3ab7-44f7-a80c-08dd66e28bfe
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amg1eUJCZkVyNmw1dytnb2lpVVZqcmRpaUFhQ1M3OXFFNUNJWHpJY2JIeGg1?=
 =?utf-8?B?UzFlK1pWeEM3N0FFREtRdUpQVW1INmV6Z3ExRlFqMk96REk5MkRoc05BVW1T?=
 =?utf-8?B?R2RnRFdSajQyeFd3eU9ISWJFYWJaTThTVEw3TC9nRXY4VXQwVEszbFpWV1NN?=
 =?utf-8?B?ZHBCSmdxTGtyaUtYTVVXdUQzcDR1TVc5U0E5OVltbjRZSk56L01UWEFmM3dK?=
 =?utf-8?B?elh2NnBlbDNldFo4S01lRnhYNHJTUDBkOWFOZmlFb0o2c2tVcEdEK2trY2kv?=
 =?utf-8?B?U1kvOUdWY01MZGxIekNsL3NvMmNRS3h3WFE5bXNtOGpXUkNlMm9YNDlCanlx?=
 =?utf-8?B?NlBUdCs4d25YYmJEcGFWVWNoRkx4dzZEb0VKQWNaM000a2RoYzlDMmw4d0xU?=
 =?utf-8?B?NFNvcnQ4SS9Fa3Znd0lmbFNZTGFMdEE1RWdlZm9WQ0l4OEtycGNBbDM1SGNi?=
 =?utf-8?B?MkhobnVmVDhENTlnUlRVNU4zUXdxbnhYYTdXWCsxMzEralVBTFVGZFlYZ1Qy?=
 =?utf-8?B?cVJCTzROQnNFVEtIZ3p5RVFKTldpQkx1aWdpYi8yYmo2RHVla0ZCUWpFbURk?=
 =?utf-8?B?clgwMTZCdEdVVCtlSUp2VEVCK29rdnZFbC83WGdWNVp3bE9mT3RLWHpySStk?=
 =?utf-8?B?bHpydXBXeG9xeUZnUEY5OU05emoySWZXMFZ6OVVGWHZmOWpycG1QcWFDNlpN?=
 =?utf-8?B?L0NseERPVnFaY2NHaldYb1JhaVRWRHVzb1BPSk9jeGRaWkVBZ2MvNE5Cd2x4?=
 =?utf-8?B?OFJDLzRtNDJVa2dQWU5QbEdnUFBrb0U3dVlwTnlRNUVPdUtXVXU1TkVCTWFo?=
 =?utf-8?B?L2tRS01WeVZBY2VXb2E1SVNzdDB0QmgvamJrNnpKTGFDK2lpNVJacUNsM0lX?=
 =?utf-8?B?NjFGM2Nkb3R1WnVheU9yUlBTVzRnRlE4QjlLa2JwSXo4aWFSUjY5YUU0d2lv?=
 =?utf-8?B?Vm1RdnN3UldlKzNRZDdCOENieitkVmNlc1k0OUtwUCszSGxGSmFySmh0dFVl?=
 =?utf-8?B?dFBtM0pwanIyVGVGaHBSbjFkZGZ6bDk3U1V5WEt6cDB4SWw1WDE1V2Z3ODk5?=
 =?utf-8?B?SVRwUmNkUExJbDlLQ0pIa0ZWVWdpSnIzTzl5QmdkSFdRanpwRkt4RGRCaEla?=
 =?utf-8?B?dURoMENWWkRjakYrT2orTkxsV0MzYXZ6QWMzQ2t5VU41SVpyNmhEblZjdytI?=
 =?utf-8?B?NFREaDNlVEFEdlI0SDgrOWtLVDNDbGZCaTg1ay96a0ljR2F2U2hPNm1KWU5s?=
 =?utf-8?B?dG9YdXpubG1DMDlMbzV0bFRJK1pZZ1hVYXdESFdLaDkzanZ0QkM0SXVQaGxZ?=
 =?utf-8?B?ZzFBU2hibkRQRHh4QmNNUlNlRHdGSHFtSDhNa081c2R6NjZ1bXYrRlYvRU51?=
 =?utf-8?B?Sm9CallXMnRRcVBDN1VTSVdDNk9KNjRNZVQvTGU0WmY3dS9GK0h2dHZNVEFX?=
 =?utf-8?B?R3lxQkE4WHlwZ0d0ZjA5dUVBZS9QOVlGYTM1RFYrU1N5bkVJQmtiS3Fnc2Va?=
 =?utf-8?B?V3FTYmhxeURUVStvdUlEMVpFYUF6blA2VWRRS0o1SVhBZnA2TXNTRnpBNDR6?=
 =?utf-8?B?T1NkL2lPTkxURW9qbzFZRWxmd0ZaQmMzOHdtV21WZDgveHBvejBzNWxXNGZ6?=
 =?utf-8?B?RHZobXBtSFAwVXh3NmJkd0htczB3ZFFzU0lJVEI0V3Uyc2RCV21FQThpelZs?=
 =?utf-8?B?dTBCMElhZVAzaTZJM3dvY3p6MVkyZ3BkME5LcnM2OFJKN0dSd0xJSjFIa3Nh?=
 =?utf-8?B?MWUyQ3lPc1VWTHlEenJwSUU4WFRoSVUweURrb2RCRkpKQ0c2K3dwMWhKZWw1?=
 =?utf-8?B?UEgrWWtsT0pURGpMMCtkZEVYZUZObm5YZ0J6czhPaDYrNTFnMmdrbXE3SkY1?=
 =?utf-8?Q?6+NoVIVFNc5Sj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVRWdmI0ZGZJLzZkR0t2dnFCZFk4N0J3a0NaMFNPNjI1VlBmWGN3NzdoQzdC?=
 =?utf-8?B?Wk5ScDRYRDRQZjBIM3lsV3RFNEN1aTJkUnN3RTdQZnd4dTNXZXozdkNaaWhZ?=
 =?utf-8?B?S0dpNkJodmF4STE5Ry9hWTNoMjVRNXNCOFIrL0hpcFhmY2RLeUlGMU5vYlJu?=
 =?utf-8?B?Y1JYTG5yV25jeVRiVDJ3d2pFWDZ3aG1telhsc3hoUTJhWWZwazAzcXF0dG9F?=
 =?utf-8?B?UFJPMjVJUFJ4VGVzNERTenpybVZIV3FIWitFTmFiVUc0OHEvTnI2ZWxMYllO?=
 =?utf-8?B?YVRYTEsza3NrUGE1QlBzOWFHN2dZY0hOSTNoKzQ2M0dLVEk1QnozVitaYkpG?=
 =?utf-8?B?R05vUzJNamdwM0xLUWwxSWl3dUFma0NhNmF2SWluRG0wY251SElZK1kzcGJ4?=
 =?utf-8?B?WnZTTzI5RW9ma0xvYlhXTzRPeUpaenpuM3huSzFtSlVjZTkzR2xUd2FTeGN0?=
 =?utf-8?B?MUdSTXNuN3EzVnJrQi9FK1pWWURLZWxTWS9Zc1RzenNrc3dBMy9IVG9pdUh1?=
 =?utf-8?B?V2Q0UFp5RDZpaVI4bEZMVjFoS0ExM0RtQnVOODlJVEhaVUcxejg3SU9zb3E3?=
 =?utf-8?B?dXZNQmxaQ2Y3RDBYSFMxUHlhZEQ2WnVtQ2d5TklVU0RNbWw3eUg0Ni93TGk0?=
 =?utf-8?B?NkdyRWpGNDJGakVtVTUvN09ZOEFqOU9ZQUM4dDd1RklYeDIvcEVxMUdlemRk?=
 =?utf-8?B?eTV4WkI2THA4dFBGbzI4NzQxTHZGbWlBQzAza2o5WU1uaGFEcHczbVpuSkNu?=
 =?utf-8?B?WDE2aVU2bmpoN0hreVNObWhIcktsdE02NktocmVKUDVpK0FvciswRXBxOGtY?=
 =?utf-8?B?SXZIK2I4OGlOMGNjU05zQW9Hdmo1cnF6cE56cWhJeGdsNTJVNHhwalYybFpF?=
 =?utf-8?B?aGsrTUFXVG1ZM1FxclltSDk3dHQzemJpZS9EL2ExaTI4VU1xcnRlbTFMSnY2?=
 =?utf-8?B?UFA4Wll5Y2JTUFAwNTZwSjVrUGcyWXVnYzhUSzJoTEJxM2RpUDlOdG0rMWtk?=
 =?utf-8?B?dWRyNVE1UzJFejRRRDFSTjVZelJJemdLYWxUamwxVndxR1JMSGxOQkxRcjJX?=
 =?utf-8?B?NWF1aDk1R0l6bHdCWURNMitsRmN0WDRJeHdlM3V2QUVNSmIxRjNXZlRWYnhp?=
 =?utf-8?B?M2NCQUZLVHRwckYyMm4vOGxzM3M2eTBucTAxUElnUTgzVG5WaHhSdk0rNCto?=
 =?utf-8?B?dXloMmp2Ky9sL1AyT2FTS1NRa0J4Zm83V2RnTEJtVUhqd3ZKa3VDWWc0ZEJ5?=
 =?utf-8?B?cXBhRDZVcUZCSHZROWRHU0tNRGVudndJU0pYam5jMmpTVVdSVTBFYXNucURO?=
 =?utf-8?B?MElXai93M3p3aksxYllxUnE0NEg0RngyQWZWUExkTGczRkVDVGZIQ0JXMVhl?=
 =?utf-8?B?ZmExNUlUVk56N3EwL2VlMVF1aUNDamF6d2dPYVd6WlAvSmFBSzRKcE96NFh1?=
 =?utf-8?B?dnlrOGF2QVhmTTFCbEpGa2dhcEFwelVkZlp1VlZRMmhieWg0d05rbFZVMjJo?=
 =?utf-8?B?TmFncDFwZWJ2ZVNDT0FUMGhQZlFCeVdIWU9GRldrQ1cyOEwvV0NUd01vUnVQ?=
 =?utf-8?B?cGxZRWZtV0lBMFM5YVBGZjAyUlpPQ1IyL1Y1TkNUTDI1bWVSa3IyanhuWGNz?=
 =?utf-8?B?N2lpM0ZETDFJNUc4cEFJbS9iZVdmVXJJY0ZVQWVTNlRIbm1NUE5TZXlib0tn?=
 =?utf-8?B?bjhrSDdIN1RHRHo0RWFLU0ltQnBTbnZxcGlQclhXWVlPY1pCRmdEYjVjcity?=
 =?utf-8?B?UDRBeWJXaDd2R3M3WnBDMXZpRmhrNjU4aWtwRlA3a3lhczFSVytBa29iV2Ft?=
 =?utf-8?B?SGZwUjNtYWVSeDZPNElVVkk3TGEyK0MvYS9FVEhuZzdZT2lEbVBlRjYrMERQ?=
 =?utf-8?B?c2V3OUprNEY4Yy90R0x0WjhOa0JzcG5iZHV1WUNJSGFhU3B0eWRHRlJtcHRJ?=
 =?utf-8?B?UEJSYS8yb2FBbCtieWtQTGMzOWJIU1Jib09oOTdOaEx2Q3BmREg5L1AxWlRp?=
 =?utf-8?B?LytTc3V3aDB5SWtJb05wZk9UbXRsK1lkb2oxTWREM0NSRkdlQWNUT0M4dEFB?=
 =?utf-8?B?MjdFQSt4ZEkydnQwcnlWeVBIajNmVG1uOGdPQndzenhCZXFoTURDaS9qYzJV?=
 =?utf-8?Q?Ull9qO1q+LsELUaIk0RJFrnzp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41b3baa-3ab7-44f7-a80c-08dd66e28bfe
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:35:35.5113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaJFNPrFWypKjxhIJhwCpRyFjIqPHrLd1dCWCNkmaxOiHjY79pWEUvTQzwQ5+DzE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
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



On 3/11/25 05:13, Venkatesh Yadav Abbarapu wrote:
> Add support for flash device reset via OSPI controller
> instead of using GPIO, as OSPI IP has device reset
> feature on Versal Gen2 platform. Also add compatible
> string for Versal Gen2 platform.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Fixed the compilation issue for phycore_am62ax_a53_defconfig.
> ---
>   drivers/spi/cadence_ospi_versal.c | 19 +++++++++++++++++++
>   drivers/spi/cadence_qspi.c        |  9 +++++++++
>   drivers/spi/cadence_qspi.h        |  3 +++
>   3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
> index 816916de16d..fbeb0c6a85c 100644
> --- a/drivers/spi/cadence_ospi_versal.c
> +++ b/drivers/spi/cadence_ospi_versal.c
> @@ -204,3 +204,22 @@ void cadence_qspi_apb_enable_linear_mode(bool enable)
>   			       ~VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
>   	}
>   }
> +
> +int cadence_device_reset(struct udevice *bus)
> +{
> +	struct cadence_spi_priv *priv = dev_get_priv(bus);
> +	u32 reg;
> +
> +	reg = readl(priv->regbase + CQSPI_REG_CONFIG);
> +	reg |= CQSPI_REG_CONFIG_RESET_CFG_FLD_MASK;
> +	writel(reg, priv->regbase + CQSPI_REG_CONFIG);
> +
> +	writel(reg & ~CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + CQSPI_REG_CONFIG);
> +	udelay(5);
> +	writel(reg | CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + CQSPI_REG_CONFIG);
> +	udelay(150);
> +	writel(reg & ~CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + CQSPI_REG_CONFIG);
> +	udelay(1200);
> +
> +	return 0;
> +}
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 623904ecdad..a78c00db4ff 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -33,6 +33,11 @@ __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   	return 0;
>   }
>   
> +__weak int cadence_device_reset(struct udevice *dev)
> +{
> +	return 0;
> +}
> +
>   __weak int cadence_qspi_flash_reset(struct udevice *dev)
>   {
>   	return 0;
> @@ -251,6 +256,9 @@ static int cadence_spi_probe(struct udevice *bus)
>   
>   	priv->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC, priv->ref_clk_hz);
>   
> +	if (device_is_compatible(bus, "amd,versal2-ospi"))
> +		return cadence_device_reset(bus);
> +
>   	/* Reset ospi flash device */
>   	return cadence_qspi_flash_reset(bus);
>   
> @@ -452,6 +460,7 @@ static const struct dm_spi_ops cadence_spi_ops = {
>   static const struct udevice_id cadence_spi_ids[] = {
>   	{ .compatible = "cdns,qspi-nor" },
>   	{ .compatible = "ti,am654-ospi" },
> +	{ .compatible = "amd,versal2-ospi" },
>   	{ }
>   };
>   
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 1f9125cd239..731b6527cf3 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -45,6 +45,8 @@
>   #define CQSPI_REG_CONFIG_CLK_POL                BIT(1)
>   #define CQSPI_REG_CONFIG_CLK_PHA                BIT(2)
>   #define CQSPI_REG_CONFIG_PHY_ENABLE_MASK        BIT(3)
> +#define CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK	BIT(5)
> +#define CQSPI_REG_CONFIG_RESET_CFG_FLD_MASK	BIT(6)
>   #define CQSPI_REG_CONFIG_DIRECT                 BIT(7)
>   #define CQSPI_REG_CONFIG_DECODE                 BIT(9)
>   #define CQSPI_REG_CONFIG_ENBL_DMA               BIT(15)
> @@ -310,5 +312,6 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
>   int cadence_qspi_flash_reset(struct udevice *dev);
>   ofnode cadence_qspi_get_subnode(struct udevice *dev);
>   void cadence_qspi_apb_enable_linear_mode(bool enable);
> +int cadence_device_reset(struct udevice *dev);
>   
>   #endif /* __CADENCE_QSPI_H__ */

Applied.
M
