Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B50D33986
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 15:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62835841F9;
	Fri,  5 Dec 2025 16:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VLZAxS6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE3984213; Fri,  5 Dec 2025 16:49:18 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F1284047
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 16:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+UQ9xGwdh3dEiTHJjmkeT5GY4XRAWrEP8LqskFXyyxPMq5vJTT7Xs0rnsJFUE1OkTq0N96RfoJkv9q2am8jOpHBiIwZQW1NFWQ5jkB5P7W+NDAT4O8EtLBKN7rXSXR++XMXBzYeZw1lpIyCiboJLtPHLVAMNdYsQ6iafcpS+OmV4hJiMozXTibEc/pFQ0+sifaXO/Ce3EJhzoLcsAQaAGfvhnE8Dsm2H3VRXyFuDk89ld3h+kxqo2HnEGhoCaUBb10oDlVdnr367Lb1FR3FVTYLxtXHzQNP+CEnBj54h5cNKWdLj6zHKiahv2u+bjvUCG1UYgONgfLDVFz7GXoQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UREjKv3nwjwz/REWABirdQao368F8goBuqfSh3703uY=;
 b=aFUVgG/LS5L1kqgD+jpfOJNOsgQCy8nPO5SZHf8e6BC9XAuorbk/lhtYbnWleTbh3MXOPU66WXaa5UIzB42gdjxn9LSov2RBu32BHVcKN3OG0ZgGKp4GJmp+OLTKpEtkCSa705mN83aDsulQxprZEieOi2tV9QYJ0e0MM62huS2++3sbMFE1Uwr7Kab0NMP5HcflmSMkEETa0obWHY51J896elEqIRNCZ8RHz6cl5vAqDVRQBs0zMgW76xg83irrwWUT/sqZIMC8M49aBJXe7kt78OwfQBEyO0ZWy7DRw4xd245OrbWXbAFCBSVgH5TeAq9Lup/xbKnTG410m3CyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UREjKv3nwjwz/REWABirdQao368F8goBuqfSh3703uY=;
 b=VLZAxS6uyINK3IEagwz/pW/uoYxqMILwra42+9qBCSUlr+v4bLNxvLUDxYe164P6DuiDq4LwKbG5nhZ3kH0oweFUOBB6rTnIgOdnAwLUHn85n16ZzPdcC7isI3HJw8UJu3nJe+Gn/GGoTfZJwxDSBSb25kfGSBWjbGJ22GTijcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7409.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 15:49:14 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 15:49:14 +0000
Message-ID: <4160a1c7-a9f2-4ab5-a151-b580681e805f@cherry.de>
Date: Fri, 5 Dec 2025 16:49:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update my email address
To: Linus Walleij <linusw@kernel.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, David Feng <fenghua@phytium.com.cn>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Liviu Dudau <liviu.dudau@foss.arm.com>
References: <20251205-linusw-kernel-org-v1-1-a36e342c4b97@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251205-linusw-kernel-org-v1-1-a36e342c4b97@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 448384e6-d288-4cd7-acb0-08de3415d70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGx0b3FwYVZuWjJZNGVYcXk0QjliejFQVzZmalhjVlFXL25LY0F6SDFjOEpv?=
 =?utf-8?B?UnpoeDdiUDh2dXNjNGNubGJoTTVONmk0VEVMc1VMNkpWdWpldHlVWWZOOEhn?=
 =?utf-8?B?YVBTT0VBdXRlSzk5L1NqZGJsK0ZoVkFVR2Z6RHFOdzVJRGliNDR5V1pMMG44?=
 =?utf-8?B?bHJKRWdOdE52QWsrOEZxdTZiUkwyVkh5WjB3My9XRThDc1BSL3dScHBZUCsx?=
 =?utf-8?B?ZUJiQ3ZKd0pFVXZuTTl2SUNQWDM4UEcrZ0liak1OK1YxOUJzTVREcnJJVTNR?=
 =?utf-8?B?ekFSMnptMEVXVGYyS0ltajVoM0EyRWJ3VVMwWElIWDEyR0dwZUNMUEx1ZTZh?=
 =?utf-8?B?a1dMZnZJQm52QjJyOGxvbEptVFlyMklLSDdWeUt1WkcrK0FGVjVuWHN0MjBD?=
 =?utf-8?B?NXFBQ0l4NHVvVXNjUTlMUVZhcUVlWHVMMDZwZlpUbjBMMFk4eExLQnBBQWpT?=
 =?utf-8?B?VTFUTjRrOFR5dUpzUkhSbUF0YmJRNmJ6V3AwNkd1TWVyUjRHVU5qMUltd0Vu?=
 =?utf-8?B?clQvSHNKTWVGV2dmYUNaRjc2Y3NaQ3diSmZ3UFo2QTU0NVRhZHUxZU1PSG9r?=
 =?utf-8?B?VCtjQW5CYmdMZXBSZHF6ZzI5RWpZa0F0WEI4WTJuRVI0dWJTaTJXYUlzZWVU?=
 =?utf-8?B?Yk56czhsWG50Vi83UlZlTlNwazVxQWRyK1RaTXlnUkR3WFlYa0JubEd3MExj?=
 =?utf-8?B?NDJLTWZpdVRDWjYzZTRZb3pYT2gwV1diVkxrYnpqeWhjdlV2YzR4MTlwQzBJ?=
 =?utf-8?B?dkVkM1VxK2JHT3pPcUE0aG9vSmRZWUlabjBBWVVuc1ROS3dTWjJKaGpyMWZl?=
 =?utf-8?B?ZlVEa2JxMTFneDhVT2RlWDg2cEJhNUlzOXd4L1lBeFBRcnh0V3JMZVdLYkxD?=
 =?utf-8?B?RjBwRVkxb21UTmRUUjgyWmRMY0lBMmt3Z1A4cldXQlNPRktxVmZJVHpQVVB1?=
 =?utf-8?B?ZzlSUzB4Qi9QMXhHMTFmZUExOExmU0h0c2RORWJXODJkL0J4VklPZEtJWkRU?=
 =?utf-8?B?eU5SRXcvY3BpcVZ2RW9RNml2YzRINnl5WTV6NGczSzBUeWQyVURGdFA0OC9I?=
 =?utf-8?B?d01ORXNPQytkUXZMcjBJSUV0cGd1WWs0SVBCZHJDUURNWWFqV2E2NFZyR2tt?=
 =?utf-8?B?VE40eXlIc05EMXQzQVlGSXZpZStXYzlVS1BxSGxYdkorQnhYNWgrL2REejY3?=
 =?utf-8?B?RXR2TUxRaXVDeEg4OHNrcHZBZWprRWlzdXMzVjBhN2JwOXdDd3VsZFRRc2lR?=
 =?utf-8?B?ZmJVVEU3TDFUM1R3YVRQNmU5M1o4NkNrdTUxSm9sNFdsZGp1MVM2L3ozOS9m?=
 =?utf-8?B?NGZFTmZ3R0EwSUNoUFZGM2JhSUQrSnIxUW9iQ1REUFZ3VmhpZ2VHRU83MW9E?=
 =?utf-8?B?eElUbnFTU0o0NFBSbU0wMU1nRU5reGE1a0hHbzcxa25nS3hRdG1ocWpZamxy?=
 =?utf-8?B?dGdNSnljUVZKR0RFd3Q0YjJtcm5ZRXFaT3loWTl2UDlONjNjNVR5KzFTaHdh?=
 =?utf-8?B?cit5elhrVkJMbnlKOXRDbkhMOUhETFg0c0p3dHZTYk44c2JSMmxYUzB6YTA4?=
 =?utf-8?B?cUZuNlBiN0poZzJLQXhxMTlaVGFJYWtrVlpxalBEK3crWjJ0eE4zRXBLKzRJ?=
 =?utf-8?B?ckZHd084bUhMczNtNFg4MER6eFM5TzBnZFhoUGFRUEljV1VCNC9MZVZOMGJW?=
 =?utf-8?B?K29VcGNTMEpyTkc2bnZXWFc3WTYwZXRyNDI2MVpBUWViSzZXYnlNVk55TWpl?=
 =?utf-8?B?c2xHUmlMQkljaTU1c0M1M3owbDFBRFd0czJvcWxmZE1XQU9IcWYyNTU4T3I1?=
 =?utf-8?B?UlpNVkRnSDFxeE1NdTNWenE5R1o5Y0tocTFWV3l1bk1XMHd2SlpVUGlET2Fs?=
 =?utf-8?B?eEJiY0ZBaEQyTmdCaEFRdlgwUnZMTGZZUC96bFVEWXZFanI1OEdzV3o5THpZ?=
 =?utf-8?Q?YADzbD7yhYfNeO92DxWRo0N5J6CextFl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0xvZE9xRHFyM05WeXVWODJjS1AvWHRkWEJvRWpxSHFmZjRTaWRCTW5TVzF5?=
 =?utf-8?B?OEYxVkgrcDNrdjJLbzZZNnZzWVV2Q2lpMjVqSlpNdld0c1FNNnI4OThiSHJn?=
 =?utf-8?B?WlNCdk9peXIzWGZmM250Qy9oM3JBdndlUlBOTGZSUVZjbHBPQjNSbTF4b1ZW?=
 =?utf-8?B?d0lENUI3cnErS1JWUlBnMGczTnZvSzhucHhzb0drSGJITmhDRWZXblljYmVh?=
 =?utf-8?B?U0lWTTI5MlVxNXlXQ3RvU29xcW1DeUFyL0lTZzcwd1JmSzFYVDBlSkM0RGVv?=
 =?utf-8?B?MEp1YTdnMk1sVER5RWtVTjB2RUdaRGJBalUvVmoxU3pzTDVNdU1aOEY3SkV4?=
 =?utf-8?B?c3pYZ1crVnI3Q3daSlQ0VnVRTk1iTjM0a1ZnZVF1MzlWMUpWemNBaUlyVTNM?=
 =?utf-8?B?dWgyNVdzNmhuSnZ6OEl1TCtYaVFRUlV3N1BDSnN6UEdUc1A1VTU3NTZmRkkr?=
 =?utf-8?B?NjVwOXVqeGZKWENjeE9wUlNHOG56SGZCZEtaOXVkeWkxd05xUWovQ1A5NjNx?=
 =?utf-8?B?SmdHQzB6UlhCUTI1UmxHSHhZNi9DVktZQVM5aGpZRGoyVjAwMzB6SFdZUDZs?=
 =?utf-8?B?d3ZjOTNYaTArQ1ZQOTFyZ3EyeER0ekptNWdmM0NPMWorSHdVczZFbE5SY01Y?=
 =?utf-8?B?WmluM3QyNitnVy95bVB0b3B3dzZhTGtZSU1aK1ZlcjExSXRoeVNhb2lwQzg3?=
 =?utf-8?B?cnNJdHpFL0dKYk9CZlBEUyswYmQvZHVhUjJsZTF4d004L1RQYy84TkxoOE9s?=
 =?utf-8?B?WTZrYSswVGd4bThxY0RMTjZMU0NZYzdEZE9raDd0L2ZDY2loWWF2NS9CRXUx?=
 =?utf-8?B?ZXArbHBZdWE2ZnhEb1NRSUJha245MFp3WWdUWXN6N3dRMEtnTE9hMGQraUJX?=
 =?utf-8?B?Z0p3SUViMDhXTWdHaDNtNTU2emgvSFV0bGo3OVp0aTVJZkR3S3ZCRTc3Y0tw?=
 =?utf-8?B?aHpmVVZkYVlubWpEY0g0TU9zZzlwU2p2QU1OWGMrM05aL29HUzZwS2IrdmFC?=
 =?utf-8?B?WnBiSzAyM2w0dVlTRy9wYTNuNGxrK1BDOVFTWWlYMU5UR2U1WGlCWTVBV3c0?=
 =?utf-8?B?dHB4VS94WjdUenV1eFlhOTIrSzBoSEpRTFYxQ01uaDh6dlJYK1l3RXlBVk9D?=
 =?utf-8?B?Rlg0YzJCVUhKSEJ3Z1cxQ2ZveTlCUTFFamVPQmhSd3RtMTUvb29vVkZQbHZB?=
 =?utf-8?B?RHNhdVpwWE1UZEhRN1ZHaUxUaUNoMy94VFhPYXpJaFpmWFVPempZczlWcWEr?=
 =?utf-8?B?T3NsU29RcjdJUFN1dlBNUWcwY2dyS3kyd3YwRm9TUVhLNTZ6UVRQbHFVOE5h?=
 =?utf-8?B?VDNkL25kdXMxUjdIZW0rVXNzb3lOMHNGT0pBZXRjSVdKMjhZdzczUEtJRUxt?=
 =?utf-8?B?OUpNdVNMODUyWU5rYURzdFB6cm0wVmwwSUxjNVE5WkdkYmdyc29TaTR1aFpw?=
 =?utf-8?B?OWRnajJzK1o0YXVHUnF2ekFuaGtwK3pnNG1lRmxacU4rampCUTF5cTNpMjZZ?=
 =?utf-8?B?ZUFINEkyYnArSmVCSXN5R1A2OTFlemkrVk1RVlBFcEd4R1REa3orakQzSnF3?=
 =?utf-8?B?T3dORTdDOVdPcm0wc2x4QmlMSnBVZDMreVlxNUZvM29uTGhleVBtb3h2SkNs?=
 =?utf-8?B?dzY3c2s2bmxyRk91Um9jSDc3ZTgvU0JLWFJkc3hLRDlVVUZnU3JPUTRZaDhz?=
 =?utf-8?B?ckdyVnhMZE1YMExyQkRBUzU3R1ZMNjAzVGJkckRWNWZvNDB4RFA5dTlVak9X?=
 =?utf-8?B?YmNhdFVrZWRoOFFXM1Q3NG1jMGNHQ085ZjJ0dDVjZEgzMVRkMHgzV2dNZ1ZG?=
 =?utf-8?B?cnlhUitJaWlLcUJobHlnNG5DUytZZUprZ1hGTVI3ZmcvdnUyL3p5RlZTd2R3?=
 =?utf-8?B?YjBKZkQyMGlTcUtpdmgyd2U3NlFSWUtwc1Z0VVN6amFweSsxcGdVdHhZbFhE?=
 =?utf-8?B?OStzeUFBbHdENDlZWWYybm5IdnQrcTc1V1lRdFlmWEdFOHFZMnkxcUFsSGlL?=
 =?utf-8?B?UERuei8vTjBUTUtQS0xjMkErWVVjTmVWU3N3LzZsVUpPcFJEM1JwREdWcUxl?=
 =?utf-8?B?WkhHRWVlZlhkZ05MZmVxNkRPU2FZcTEvaE85cnpaQVp6Qmc3bVNIVXQvR1Nl?=
 =?utf-8?B?b08rUzRRb1FNMmNXcGVOWGpyaTBOWmtCdmpxZFYxclFqNEJsQVhleC9hREZP?=
 =?utf-8?Q?n8rzZoz9SXfvGOxZ+vezhkY=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 448384e6-d288-4cd7-acb0-08de3415d70a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 15:49:14.1862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xazWRWTi80/hTRPiAQ2IESEGpA77aXdyxp11i8kKPqnBsZ1voD3mUi1cynwAl265j4UyuNaFBBn9C1YcvKmR9d4dvL4nY+m759hsm3Bovfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7409
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

Hi Linus,

On 12/5/25 2:53 PM, Linus Walleij wrote:
> [You don't often get email from linusw@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> I am moving over to using my email address at kernel.org.
> Change this in all the affected MAINTAINERS files.
> 

We also have a .mailmap, is this something you'd like to add a change to 
as well maybe?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
