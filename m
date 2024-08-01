Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273E9C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 19:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9AC88B56;
	Thu,  1 Aug 2024 21:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="o/SRRk3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D3E88B58; Thu,  1 Aug 2024 21:40:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08EBA88B50
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 21:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471DG9Zf006169;
 Thu, 1 Aug 2024 12:39:48 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40rb3nhpmg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 12:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNocfnyUKe9RybSp6tI4Q86GsO9Qq8GvnJZzg7Ma1c5HzOBNTOj6bdLHVQ8/PUoI9Y0/uuDfC4qnjkjplCbJ/ejAyyxuxQajMwhBV2fqn8GKFfPBuEES2Clt13LQfGWCc3d5krforD0/qtyllacAgofS7fRR7AI+1txcXTOr+YcT+S3ObZtSzYFQGZ7EDoohsV0U7xwEhual07oKVpaTBblJfGUTLgopN2g1iUHXfb79aKjTn8i9NTXu9SYpe9vd63TQ8trVfeTsefNj6F0JtLrv2eT/5QaHqILx5wa4Zzejq72gb64GuEQ8kdycyGbRMg/U79N3cE0KQpLAJW5Fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC3+gLhXb2zo8FhYrrVHC+t94UNJexlQ9S07T2xI7oY=;
 b=YQ6uzAhVjHd3W5XQkzgB39T6LVFSm7j++xp7vxS2X7wiWnrDX4IcQWChh090GJXHcBFlvxeEQPxfBYWKCjp+rTggTIlJQ1FCXQsIAm/3DZo63h/++G1pzA/jdqX6g6WjZuNEv+peR2kOP9YvYBTvAmlgE7lVoO570NNUKyyM+ASEitqzOhtEDUjiwoeG+v0AJct2OePXjgLSwRvJmDDqO5hfC2ifrwkxhppXqYw9cI928+a/DJWYj+cLa+LBfyLglUVlhm0ODlIkL9YG3ERooNEjnhscXt07y0hk5pXXT4AMeRIUiKjafayGzsSicUaumtdQCS6GF2QXV+EojNMlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC3+gLhXb2zo8FhYrrVHC+t94UNJexlQ9S07T2xI7oY=;
 b=o/SRRk3yubvO2Ej1aFROe/bBQZqzAPZr407z2vz3049fifGuhwy4JmNXxKGsZu23sABhZWl0SxFFSkC6AN6e25LrA/EUFO8xsjsacJpZGQ2/Ez0H3oRBxc+k5zmM5QblRAaRwawI8UNvMGtuNxgD/rEiM+OBDEHK0efzGyru9Jo=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by BL1PR18MB4264.namprd18.prod.outlook.com (2603:10b6:208:311::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 19:39:45 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c%6]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 19:39:45 +0000
Message-ID: <363c73bb-54cf-3800-bb31-9af83fbaf33d@marvell.com>
Date: Thu, 1 Aug 2024 12:39:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [EXTERNAL] Re: [PATCH 0/4] fs: ubifs: Fix crash and add safeguards
To: hs@denx.de, u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Hans de Goede <hdegoede@redhat.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Kyungmin Park <kmpark@infradead.org>
Cc: Alexey Romanov <avromanov@salutedevices.com>
References: <20240703101258.1670825-1-ada@thorsis.com>
 <8f3a7059-6330-f332-8e9f-729b853e001e@denx.de>
 <20240704-goes-grape-25a9f1d14c24@thorsis.com>
 <20240801-wham-entertain-15505d61f84b@thorsis.com>
 <e0c3e3e2-1c7f-e244-5b1d-0498b5771deb@denx.de>
Content-Language: en-US
From: Ravi Minnikanti <rminnikanti@marvell.com>
In-Reply-To: <e0c3e3e2-1c7f-e244-5b1d-0498b5771deb@denx.de>
X-ClientProxiedBy: BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40)
 To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|BL1PR18MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 7039e9c2-cb5b-4803-41e1-08dcb261b213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2lNMy9VNWFVZEpxOWdRMGEvQjFkMlVpaVdhczFqc3htT0dZUDZiTHZFUW9a?=
 =?utf-8?B?d2djL3JzemFDdWtDeSs0RnFla3hXaVNCWFR0R1ZISVlONXNxQlgvNXpDY0RQ?=
 =?utf-8?B?bTI0Z2xXS0gxTWJaNzVaOG5wMTJxdlhxeWp4aDhlOXl0Qld6UzJUMy9JbEVO?=
 =?utf-8?B?MmJ1R1NYQ0lyblI1eE1rd1lBNXA3TXZlZnpya0FyNi9SVDJCZjFlNVVKMHdk?=
 =?utf-8?B?T0U5K1M1Z3RzSTdTdytZYWY4WlpETzdnZmtFZWJYSTRORVhWcnp0aUl3Z0Np?=
 =?utf-8?B?SWlOcWpxcTNaMHlRUWk1VmJ1ZlBEYzhvbEtqS2h0T0t2SHdVeng4RXNHR0M4?=
 =?utf-8?B?OVFnYW1FdmlKdjA1S1kwcHptVjVLZk94QnVKTUR2Z3ZBUkxHSy9sdGFVdGU1?=
 =?utf-8?B?emJaenB3Y2piTnNhMkVPV3BPVTk1R0R5TzkxaXVOVlFHUU51d2p0R3IxVlpu?=
 =?utf-8?B?dHBHOFhzcklxRVRlaEdEd001Qmo2SlB1NXRJRmp0b2dqajRXc3A4STBrb2Vn?=
 =?utf-8?B?cTY3MHpyOEMvK0Vxd2tRMGJ5akdSRGZxc0F2QkljYVNFRlRpVTE1UVBHRzhx?=
 =?utf-8?B?ZnFTaDQ1bnp0UXRMaWZlUWlTbE1pcklXcTY5MFdOU2x3K1ExbG9vV0J5aUUr?=
 =?utf-8?B?bGw3Ym10T1I1TkZLK0FadXEwazBRbi9VWEpDb1Jvd00zeEt6eW5NVXMxRjNM?=
 =?utf-8?B?aHpPeWFDVnBaZDE3em10STlUelRYQTBBdHVlYTZUV3hVYmFIM1JlQlNDUXNX?=
 =?utf-8?B?V2pwcjdHN2ppelBseVJ2eTJ6RzBINllzem9SRmdQbDZWaG5OMEJpQ0x2cm5w?=
 =?utf-8?B?K2Y1eTZ6bVFBYzg4Z21CUTUzMmRSQ3BqZG5RUUtOMVV3azczY1pBbFNtL2h4?=
 =?utf-8?B?aHJsbkpPc2VPT3lvZGNjT3JmYnBtMjhydHBCNS9JclVDbUVkam4zT29EYVR1?=
 =?utf-8?B?ZExaa0hzdUZXVTU0VkdIMDNMb2JOeXplNlpqaHllZE1LbVlZZ0pGdFNtUGh3?=
 =?utf-8?B?RGVDckRUdDN0TlB4amdHVHFHRUhCWS83QTN1VUVKdy9jd0xmNmovUlZYSDRY?=
 =?utf-8?B?STR4NXRMZjAwMXlmTUYwbXJxVXcrUzlVK2Y0YzUyWktnQXdmclNqd1dVRXI3?=
 =?utf-8?B?Sk9vVXBZaFdBODNoUmlkQy9WcElBNnlDZEJqQXhmRld4Ukx2b3BsTVJJVUhm?=
 =?utf-8?B?ZytQUGVsTUI1R2JXNzFOMnNpejFqbVFOaHJQd0tDOXRmcTRxeHRscEZMRXlr?=
 =?utf-8?B?LzhLUk51dVpIamZ2NW5CZGtjOHU3NVYxSXVENG9TZ09rSWM5ZWw0N25RM0Ns?=
 =?utf-8?B?dXBLQnpPdW1LcUpNcEZGUVZnQk52U1ZQV1RvMXFwRzk2cjFTSG5DOVhUMGdv?=
 =?utf-8?B?OE5mdlJOWE9hT1lnekJHSklsR1pVcnE0UTFXOFFKWkYzUGdMbEk5cytDSVM0?=
 =?utf-8?B?cW53eU0wVjF1L0pXVi94alphdGxYUkxOaHNvQVBBNWw3ME4xckVmcDZDTkRS?=
 =?utf-8?B?N2ROdDhEc3ltYVBzYmp4ZDdBa0trMzlIYUNrMEVWbjNERDZ4L0g4SzI3MzNY?=
 =?utf-8?B?TnJLbWI4SVlvazNkLzlmeTcvM0hjNXcyNy9LRVJNMVQvbVQ3R3E3SUR1ZVVC?=
 =?utf-8?B?cFRuempmeEZ0VitwR29LK1U2ellDTEpXUVNBMno0cnZGU0tUcGRiYStTM3hJ?=
 =?utf-8?B?ZXBYN3krMXJ3VldEc3dxckY2WmExL2I1VCtKNU9rRC93VGo5RFdSMmNrQkFv?=
 =?utf-8?Q?CiQn4412+bwi5BjA9I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzNMcGcwSkl1WTlaVElCTXpzNGtjdXZTdWpWNzBWZE5jY0ZCRHo0WVl1T0Z2?=
 =?utf-8?B?cUt4YnN4R3pRYnhvYjJ6M1RqQ2dCb3dPMnpXRk5DMUJUZytGeDV6RHUvT3Zp?=
 =?utf-8?B?TEpvdHRUa3E2OGwxWG9kM0FRZ1BKUEdHUkNvYXp4WUxxbVl2SDh2Q3VZbVB4?=
 =?utf-8?B?YTRabzZ4aEdyQllsRnBRM3ZPS2hRcmw2Y1Y3dnAwQ3VEY2Y4MUhrM01pSDZH?=
 =?utf-8?B?UUd5T1F4c05kRVlUZUJFRTRhMlZxdHZHU2l0cDJuYlJMUWNtTHdKYUhtbWV3?=
 =?utf-8?B?ZEk1VTZYL21xeUdycDhtYmdJM0lkMC9BRWdsb25aUm11c0FDZE15SGo1QUxC?=
 =?utf-8?B?RjVRL0c5blp6Tzk2UmxNbjF3b0xOb0NQbE82L1dhQjBSTnZhZXkrdE15QTFZ?=
 =?utf-8?B?Y3QwMUpOMWdubWpVRnRad3l0UGlDblMvdzRaZEJkKzlTNHVNaWdJclhyR0ZN?=
 =?utf-8?B?VmZGVkg4eGVDeW9XdjI1amRNSGRlWDE1T3RwOG53a2NNRUlTRkJGbXNWNFBF?=
 =?utf-8?B?clowczYxbS9rV3RQMjJJNHNvbm45Z0ZuL3h1MkhSL1J5djNaNGJzMnppYmhZ?=
 =?utf-8?B?Y2dpWis4TlhGSW9YV3d3aDlaTC84OG9hL0ROSVZ3TzhJS1laT2RUTjEvQ1RS?=
 =?utf-8?B?WHdGN2YyMVBZUjNVQnZXdEVaRlUwMG4vVTdaNlNDRzR2NmNZYk00aDdXWG4x?=
 =?utf-8?B?dG0wZjE5RStmN1JPdHNiVC9aakFSc0hxRnNvRVBreE5TNE16UDZIVnZrWEIr?=
 =?utf-8?B?RGUyRnJDK1NNNlA0MUdEQWUxTnVqM3FZbzJlNzU5RXJOTmhNbXQvMU02NFAx?=
 =?utf-8?B?dFBkdkdyOFlOUUVDb2NsMUlVL0Naak10MlpyQkZDUDRIOVMzUWxwT1k3Ynov?=
 =?utf-8?B?b1NTYXpEaGMyNUE0RlNtaFBXRk1UT0FIeThKcUtUZW5McXlTQVVBZ1VNN0Rm?=
 =?utf-8?B?NVdpZEZhODVjeWZZTUV1WFQyMGNoQ2xNVTJIVWJPMHdlTy9nYzd0WTRwN3JY?=
 =?utf-8?B?NnQrbFFVUVg3NkR6WUd3Z2d5empVQ0ovR2hEZkVHa2Y4bGFHR3JxUS96L2Fh?=
 =?utf-8?B?a25jMXBpczE5ZXJPZlV1QTc3OUpQaDFmMDlMZ3BzdkNEZ0tvQTZjR1B3dWt0?=
 =?utf-8?B?T3dISlVCZHJTMzY0YWVsc3hodWs0aVRiV0s5am8zMVVSOVpwNVhtSVBTblJG?=
 =?utf-8?B?Mnp5eTg5YlRTVFhMQjNMR1dJMVVFZzVzT1krQUhSQzg1RnBtTlJoNWFicThM?=
 =?utf-8?B?MVNWZVZUa3BFeG4wQ3VlcW9PckxzUTdvS29jV0NTdnRFT3RMWkdGNW5jRGlj?=
 =?utf-8?B?NVlkSXNYRmJpeUlwQVZGTTRuT1BjeUtlOHFuY09uZkd4OVNacThQTTY5ODc1?=
 =?utf-8?B?Y2JkL1k2SUN5SlNPdFVQRlFFSzFoUmtsVmI5RGdPbXQ5SUhmbmhqV0NGNTlR?=
 =?utf-8?B?aGFKOTFOWXp4UnNjSHpPeE50amNldTNXbGJweGZqU3ZybStSaU5XYzZ5SUx4?=
 =?utf-8?B?TUtMM3JIVmMvVUd4YVpVRnBJNWZCSnBIUVB4Z2w3bDJ2bWJpaktYaHZzS2xT?=
 =?utf-8?B?dFlCc2RoMGdGU1RueTBQZGNKS0dGTW9Heko0STZXTmpsY2lyakFhZnNGVHdq?=
 =?utf-8?B?cnpwSkd1MWRRSVdkYjh4U2NyZG5qUFpRMUNzVnJIa3ZvcE9LZnV3MW5OQXBC?=
 =?utf-8?B?TEVBOWdkOThDZnQ1QkdNekNDL1JXakdOV2lwNytYcld0OGFQVk00RFdHOVR5?=
 =?utf-8?B?MUNCTTJlcGZOZ05BT3dFK29XcTc1YTBKZE5pVU04eFlPc00ydjU3V3h3QkV0?=
 =?utf-8?B?VUFNSTNFQXdDaEZvdStqU3dPTkllZEk2U2NuK24vR3hJWGVZdFpwdDdqb1pr?=
 =?utf-8?B?SjhneWpzUjZ1cGI1RW5oemk5S21pNlJpbi9jNmdQWjFNWkxFTWQwSkk4RVI1?=
 =?utf-8?B?OXI1MmdyWXJGU2toZWhTOEEwZ3NGeml3RXpSZHZYUk9YM2pGWHhCR28xN2NT?=
 =?utf-8?B?Y2JrL3kxOStsUWxkYUdDRTRYNTZQMTFnZERxNU9qZE10SWdGbmdTaUd1cnU2?=
 =?utf-8?B?bFd6d0JYYU5KOHdjYkhzTXdJeUV5L0RSVkdwdXErb1duakVnWlBQTGp5TmZP?=
 =?utf-8?B?SmNaYU9mTnp0SjlHRjRyUmxvL08xVzZKNGQxcnpPSGZOYUV4Y3EycE5BWCtJ?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7039e9c2-cb5b-4803-41e1-08dcb261b213
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 19:39:45.0228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MlwhsI49QnAOJft5+ybZ+1XnZglGYUA2wTVFM2z9hdJePpE412EhbnMZiwjY9k/gVJBoD/DL61QsRFBfMJx+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4264
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: jTWzBdtmi8MIO1VUtJXv-6wM74IkdraP
X-Proofpoint-GUID: jTWzBdtmi8MIO1VUtJXv-6wM74IkdraP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
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

Hi Heiko, Alexander,

On 7/31/24 23:54, Heiko Schocher wrote:
> Hello Alexander, On 01.=E2=80=8A08.=E2=80=8A24 08:=E2=80=8A50, Alexander =
Dahl wrote: > Hei, > > Am Thu,=20
> Jul 04, 2024 at 10:=E2=80=8A18:=E2=80=8A55AM +0200 schrieb Alexander Dahl=
: >> Hello Heiko, >> >>=20
> Am Thu, Jul 04, 2024 at 06:=E2=80=8A28:=E2=80=8A31AM +0200 schrieb Heiko =
Schocher:=E2=80=8A
>=20
>=20
> Hello Alexander,
>=20
> On 01.08.24 08:50, Alexander Dahl wrote:
>> Hei,
>>=20
>> Am Thu, Jul 04, 2024 at 10:18:55AM +0200 schrieb Alexander Dahl:
>>> Hello Heiko,
>>>
>>> Am Thu, Jul 04, 2024 at 06:28:31AM +0200 schrieb Heiko Schocher:
>>>> Hello Alexander,
>>>>
>>>> On 03.07.24 12:12, Alexander Dahl wrote:
>>>>> Hei hei,
>>>>>
>>>>> filesystem handling is different in U-Boot and beyond that UBI/UBIFS =
is
>>>>> different from other filesystems in U-Boot.  There's UBI and UBIFS co=
de
>>>>> ported from Linux (quite old already now, maybe someone wants to upda=
te
>>>>> that?), and there's "glue code" or "wrapper code" to interface with
>>>>> U-Boot scripts, commands, and filesystem handling.  The fixes and
>>>>> improvements in this patch series are for this U-Boot specific glue
>>>>> code.
>>>>
>>>> Yes, the linux base is very old ... patches are welcome!
>>>
>>> The last sync was back in 2015 from linux v4.2, there were 800+
>>> changes to ubi/ubifs in Linux since then. :-/
>>>
>>>> And for me it is not that easy, as I do not have a hardware with
>>>> current mainline U-Boot running on it... I want to update a hardware
>>>> I have to current mainline, but I had no time yet for it...
>>>
>>> Besides the custom hardware here, I used Microchip SAM9X60-Curiosity
>>> lately, which is coming with a raw NAND flash and can boot from it.
>>>
>>>>
>>>>> I'm no filesystem expert, but after days of debugging I'm quite sure =
the
>>>>> bug is in U-Boot since UBIFS support was added in 2009, and it was
>>>>> repeated in 2015 when generic filesystem support for UBIFS was added.
>>>>> So please review carefully!
>>>>
>>>> Which bug?
>>>
>>> The memory leak and double free fixed with patch 1 of the series.
>>>
>>>>
>>>>> The crashes were not easily reproducible, only with boards using the =
old
>>>>> distroboot _and_ a boot script inspired by (but not equal to) the one
>>>>> proposed by RAUC [1], which basically boils down to:
>>>>>
>>>>>     ubifsmount ubi0:boot (from distroboot)
>>>>>     test -e (from distroboot)
>>>>>     ubifsmount ubi0:rootfs1 (this time from the boot script,
>>>>>                              triggering a ubifs_umount)
>>>>
>>>> So, you have a special sequence you execute to trigger the bug, good!
>>>>
>>>> In special 2 ubifsmount in a row... may not often needed for booting!
>>>> (I ask me, why that is needed? Boottime is not good than...)
>>>
>>> Using distroboot with a script here.  The script is in a separate UBI
>>> volume ubi0:boot, kernel is loaded from ubi0:rootfs1 or ubi0:rootfs2
>>> however.  So there is 'ubifsmount ubi0:boot' from distroboot and in the
>>> script found, loaded, and run there is 'ubifsmount ubi0:rootfs1' (or
>>> rootfs2) later.  ubifsmount calls ubifsumount internally if some
>>> volume is mounted already.
>>>
>>>>
>>>> BTW: Is this really a good bootcmd in [1] as on *every* boot your
>>>>       Environment is saved? This is not good for lifetime of your
>>>>       storage device ... why not using bootcounter?
>>>
>>> Well, I was not aware of bootcounter, but I had a look and the actual
>>> counter must be stored somewhere.  Possible are:
>>>
>>> - pmic =E2=86=92 has no storage possibility on my board
>>> - rtc =E2=86=92 soc internal only, volatile in the end (if battery is e=
mpty)
>>> - i2c eeprom =E2=86=92 missing
>>> - spi flash =E2=86=92 missing
>>> - filesystem =E2=86=92 ends up on the flash
>>> - nvmem =E2=86=92 no other nvmems present
>>> - syscon or some cpu register or sram =E2=86=92 volatile
>>>
>>> So none of these are possible in my case, I only have a raw NAND as
>>> storage and thus I have to use U-Boot env, which is stored in UBI here
>>> btw to not stress the flash too much.
>>>
>>> I could investigate if it would be possible to let RAUC use the
>>> U-Boot bootcounter infrastructure, but currently RAUC depends on
>>> U-Boot environment variables for tracking boot attempts.
>>>
>>> btw: documentation of bootcount is sparse, I only found the very short
>>> 'doc/README.bootcount' and it's not even migrated to recent U-Boot
>>> sphinx based docs. ;-)
>>>
>>> But from what I understood the concept is the same, U-Boot counts
>>> something and Linux userspace has to reset it.  The counter must be
>>> stored somewhere, for example in U-Boot env if no other storage is
>>> possible.
>>>
>>>>
>>>>> Crashes can be triggered more easily, if patch order is changed and
>>>>> patch 2 (resetting pointers to NULL after free) comes first, or if pa=
tch
>>>>> 2 is applied on its own only.
>>>>
>>>> Hmm...
>>>>
>>>>> The fix is in the first patch, and on my boards I see no crashes
>>>>> anymore.  I also tested all kinds of combinations of calling `ubi par=
t`,
>>>>> `ubi detach`, `ubifsmount`, `ubifsumount`, `ubifsls`, `ubifsload`, `l=
s`,
>>>>> `load`, `size`, and `test -e` and got no crashes anymore after the fi=
x.
>>>>
>>>> That sounds good! Hmm.. test -e has nothing to do with ubi/ubifs I thi=
nk.
>>>
>>> Oh it has, 'test -e' calls file_exists() which calls fs_exists() which
>>> ends up calling ubifs_exists() which is one of the functions causing
>>> an immediate memory leak, see patch 1.
>>>
>>>> On what hardware do you test? Is it in mainline?
>>>
>>> Tested on custom hardware, but I'm confident it should be reproducible
>>> on any board using ubifs, especially after applying patch 2 resetting
>>> pointers of freed memory to NULL.  This should trigger the bug with
>>> the simple sequence already described:
>>>
>>>    > ubifsmount ubi0:anyvolume
>>>    > ls ubi ubi0:anyvolume / # (or load, or test -e, or size)
>>>    > ubifsumount
>>>
>>> ubifsumount will call ubifs_umount() which calls
>>> ubi_close_volume(c->ubi), that pointer is either invalid leading to a
>>> double free inside of ubi_close_volume() and it will crash only in
>>> certain conditions or the pointer is NULL after applying patch 2 of
>>> the series, then ubi_close_volume() crashes right away with a NULL
>>> pointer exception.
>>>
>>> Note: without patch 2 it very much depends on the sequence of
>>> commands, but after the first ubi_close_volume() triggered by
>>> ls/load/size/exists the pointer in ubifs_sb is invalid, but accessed la=
ter
>>> by the second ubi_close_volume() triggered by ubifs_umount().  If you
>>> do something in between those using the freed memory by something else
>>> again, the second ubi_close_volume() access might get corrupted data
>>> or access things outside of RAM.  Patch 2 redirects this on a clean
>>> NULL pointer exception you can easily trigger.
>>>
>>> In my case I got a pointer variable actually containing a string
>>> "ng.." aka 0x2e2e676e which looked suspiciously similar to a valid
>>> pointer on the platform somewhere in RAM between 0x20000000 and
>>> 0x28000000 so it took me two days to realize it's not a pointer. ;-)
>>>
>>>>
>>>>> The three additional patches (2 to 4) are more or less safeguards and
>>>>> improvements for the future, and come from me trying and my debugging
>>>>> code done on the way, more or less optional, but I think nice to have.
>>>>
>>>> I will look at them .. but give me some time, as I am in holidays the
>>>> next 2 weeks ... Hmm.. and it would be good to get some Tested-by
>>>> from people with hardware...
>>>
>>> Take your time, no need to work in holidays.  Would appreciate a
>>> Tested-by by anyone else though, maybe some of the raw NAND folks?
>>=20
>> Well, apparently nobody had a look in the month of July, I add the raw
>> NAND maintainers in Cc, maybe I should have done in the first place.
>>=20
>> Would be happy if someone could have a look at the fix, maybe read the
>> patches first before the discussion? ;-)
>=20
> I asked Ravi and Alexey (added to cc) if they have time to look it they
> can reproduce the issue and test your patches...
>=20
> bye,
> Heiko

I tried to reproduce with CONFIG_SYS_MALLOC_LEN reduced to 1MB and
calling ubifsls in a loop, logic below:

ubi part ubi0:rootfs
ubifsmount ubi0:rootfs
setenv i 1
while test $i -le 200; do   =20
    ubifsls a/b/test.bin
    setexpr i $i + 1
    sleep 1
    echo "Loop count: $i"
done

It crashes with or without patch. With patch it takes 4,5 loops more to cra=
sh.

Log:
UBIFS error (ubi0:0 pid 0): ubifs_iget: failed to read inode 85, error -12
"Synchronous Abort" handler, esr 0x96000004


Thanks,
Ravi
>>=20
>> Greets
>> Alex
>>=20
>>>
>>> Greets
>>> Alex
>>>
>>>>
>>>> bye,
>>>> Heiko
>>>>>
>>>>> Greets
>>>>> Alex
>>>>>
>>>>> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com=
_rauc_rauc_blob_master_contrib_uboot.sh&d=3DDwIDaQ&c=3DnKjWec2b6R0mOyPaz7xt=
fQ&r=3D3apjoJolwzwH82pd_c1HzSLzzrwfu9x1lSm802edgOg&m=3Dlpy642UhqtTXHV0dd0xn=
OtQxkQSO5RC6FwcUbzt-FsNwd3QSXZsulfqC6dP9qV7G&s=3Dwbnw_T9_r6taMKIFqJ2-wtj9Zv=
02OD7mbIy-ZZFRjRE&e=3D  <https://urldefense.proofpoint.com/v2/url?u=3Dhttps=
-3A__github.com_rauc_rauc_blob_master_contrib_uboot.sh&d=3DDwIDaQ&c=3DnKjWe=
c2b6R0mOyPaz7xtfQ&r=3D3apjoJolwzwH82pd_c1HzSLzzrwfu9x1lSm802edgOg&m=3Dlpy64=
2UhqtTXHV0dd0xnOtQxkQSO5RC6FwcUbzt-FsNwd3QSXZsulfqC6dP9qV7G&s=3Dwbnw_T9_r6t=
aMKIFqJ2-wtj9Zv02OD7mbIy-ZZFRjRE&e=3D>
>>>>>
>>>>> Alexander Dahl (4):
>>>>>     fs: ubifs: Fix memleak and double free in u-boot wrapper functions
>>>>>     fs: ubifs: Set pointers to NULL after free
>>>>>     fs: ubifs: Make k(z)alloc/kfree symmetric
>>>>>     fs: ubifs: Add volume mounted check
>>>>>
>>>>>    fs/ubifs/super.c |  8 ++++++--
>>>>>    fs/ubifs/ubifs.c | 31 +++++++++++++++++++------------
>>>>>    2 files changed, 25 insertions(+), 14 deletions(-)
>>>>>
>>>>>
>>>>> base-commit: 65fbdab27224ee3943a89496b21862db83c34da2
>>>>>
>>>>
>>>> --=20
>>>> DENX Software Engineering GmbH,      Managing Director: Erika Unter
>>>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>>>> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
>=20
> --=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
>=20

