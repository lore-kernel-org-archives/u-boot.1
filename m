Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C02BD2D8EF
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 10:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5794883FDE;
	Tue, 27 Jan 2026 11:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="R3GcIT7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3E583FDF; Tue, 27 Jan 2026 11:30:15 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CE183FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 11:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9CJFKhBC6RYO6YBeRvd+6BoIOPMbpR1HM87U4neiujeacLyNu3gDbFTP//sAZ7mZNUALpEI1eypMqJoCsbIuUPVKffsAMK8lm7SQQE9sOBTE3faGbVJKvkmKdQN1fpl0sAKltHpqG9rNtoyDCMnLYmhaJ3qsfAPq0wekijlyQTAaST4M8xu+9izq7ed/k9kjNqUm+Gr+wym0tgEDlRAOgbs/x94TFQb3vq0+d13j4vzcA8L/rZMjOjJTyYekhb3HF4opsMkJizhV9hPn/pECtUhJb6jfOuqM1SqxqqVAxxRHYL/G3kZMy3p1UzFuGDCrNraIXM0IYYVjK8+J6RVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CbfPo+2Y4N1HKyP95ktKi2JVjnndo6yZvQohBptgvI=;
 b=AgpUxKdoiQC2zRHye4zfY4q41ldznrm1np8qpnKHsrvXAiznGWWjbgD2otAk3xa3KDKoRmvaGDM0C243eRKatOO4sNWsJKaNLYYb3xtFX27z8OtwkhqFwlOv4GLWxvn8xw7boAoVGXcF+yPz+recUEeo9hXnCLkkMpBgssP8SWDexpHhc+9lCOMSJeHtqNfD+wZas1t3sC+IPyu/e+ABd1CRdN6v/3XeWz+yvyrQCLWvjz6wOb2WZJ1nh1Fyg3hfHiSUFeJLhF1OmSI16gyM/Orm5mCKC+gZHKE+8V2YIGMy2ttRE6EWyfgfRCccrT2aJdL5udXFN7FzMJrr0sqqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CbfPo+2Y4N1HKyP95ktKi2JVjnndo6yZvQohBptgvI=;
 b=R3GcIT7pyw9hie+Na47BsyaZqnZEp7Ue6N+TRWEkD5Q1a0p2r+mpNVzmcx+0C7D94MQyeSz1mcLOABc6Skhy97o9IWbTgKxtEzFNzUeN0ikoXV9RpDaMZFQUcN0bVnidyMxU3V4gK0KxrKUlaBtL5z/TMZNGhQ6vEUZKkPndwPntM8lJd4fzyaGOM1jbxkt0HzTrEsDirlG2PFPSEYe5gRE23b39oFXBX2/VBHEK/ELS65H/+/WQH9R6KEV83Ab5d7mv4LIv7DhLg0PxPzqYmAeWUBAEgqpn5KybRaOcFa/mFTbcgxmqaEGcXiJKG6i6JJ1GPYnmisz3GU/HJYBLpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by IA3PR03MB7715.namprd03.prod.outlook.com (2603:10b6:208:512::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 10:30:09 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 10:30:09 +0000
Message-ID: <13ab5e37-2ea9-4273-aaad-ec711a6c8ebd@altera.com>
Date: Tue, 27 Jan 2026 18:30:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Add CoreCourse socfpga Board AC501
To: Brian Sune <briansune@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>
References: <20260106011325.4634-1-briansune@gmail.com>
 <20260106011325.4634-2-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260106011325.4634-2-briansune@gmail.com>
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|IA3PR03MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7c65b3-dccf-4e45-297c-08de5d8f0b65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTRLdEZWWndIQTR5TGZrTUJ1ZmVKWlF5Tk5TcmFDS0JtMEc0OWRFR0gybXJ4?=
 =?utf-8?B?eEFZcGtTNjJ1SG1vWlpGdHhqSWZaZDl5TTBtZld5MmFlSTdrOTE5TUNjRlM4?=
 =?utf-8?B?ZzVYZm1lZjdtYUFpcXJEcGhxRUlrd1dtNUR1QTE5bFFNTXBQSkxnUTZDdkFO?=
 =?utf-8?B?OWpEbjFjNXF3VTRjSzRHVW5MTnhQKzhxY2tldEovR0w4Y1JmL0E1UUE3d0Jj?=
 =?utf-8?B?SExGbGRBVktZQ05vbkRSaEtnSkFlMVBObVYzTzhnVEVKa0VYK3NPWllhVEg0?=
 =?utf-8?B?Ty83WmdqazF5WGprUCtuZnpCQnQrQkZzRTljbGtOdnhvNnJnUWdyK3Z1RXBl?=
 =?utf-8?B?SzlFdmlzcTM0WGQ5dk1YT3dOL29HNkJPRVJoSENwcVZTL2lTVFplekVadEpy?=
 =?utf-8?B?ZDh4OFBGVWlpZ2Q0cE1ubVRsbG5kQjB4MHJVeEpvc3MybGpoWklBQm1zSkg0?=
 =?utf-8?B?Y3o1VHZjMW1TdCsyTk9PSFlxTzFobzVrRGErb0czWEo3dG1BL1Z5ZGw5YUFr?=
 =?utf-8?B?Z1lwenRRZTNBQ0FTWFU2NVpHSC9ZUjVURzJsYTl4aWNIUWcxMTUzS1NzcFdS?=
 =?utf-8?B?U2JvYUtNNFpaS21QUWdJMzVrL2RyejVrekROWk13NHgrRzROcW9SdHQyY01w?=
 =?utf-8?B?ODNrcE96aVFSTmtiUEx4c1lUcVBIL0VIY0U1cndOV2FtVmZFNTVjQWU1Z2dm?=
 =?utf-8?B?STM5bHRZMnZIVkJ4emNaQXBIZlZTY1d1QlVmdW5mYUpEc21Xb0VSZDFaM2NZ?=
 =?utf-8?B?YWROS1NBR3B1MFZUNHlxbXdSRnA3Unl2NTZvUzBjU3o3RTVmaDlib1RRWmlz?=
 =?utf-8?B?OVF6elpXeGdvVE1TOTRGaDd0RE5KMmFEUlBmcmJ5U29ibjhMZmZheU9wd3Np?=
 =?utf-8?B?Uk1uRkw0L3d4OVduUVR3UXI0aU54RE1yTDAyVUtaWU50T1Q1ZUdpNTRtSld0?=
 =?utf-8?B?WHpXODRVYkxLV1BqRythUmVzNlRvRGJBSlBvMzR1SEFWYjlIQW53RlRTZVdk?=
 =?utf-8?B?Q0pBamprWmo2K2R6NDFTV1pIcmdpekVFQWxNM2N0Tit2VjB0dzQyZ2NxNUhz?=
 =?utf-8?B?OWY5SmNWNzhScnFqckxUTU5yUTFrVWRqamdiWUhYSjY3WUlzVjdYY0lFUkJJ?=
 =?utf-8?B?WjFGNGJBTmlpTW1WQ3dsUjBkMHpNeEtiWlljOENGK3NoVnBRS3JSYWJLaDVS?=
 =?utf-8?B?L2ExZEhsTkVNZFNuelBTeG5MclZlaTlWb1VzdmdkQ1IybXI5T0JjTUVLckw5?=
 =?utf-8?B?dFhoL1hEQlpmaWZFN0dRQnBoNVMwdU9nZ25naGlGOGhaakpaUXg0bE1Iak11?=
 =?utf-8?B?MmlxaTQwc3RNbEZBaFFkdHBTd3pGbGRQZHRBY1FBcGRIUTc1R2JIYzlNZ3l3?=
 =?utf-8?B?NFRjdXErbldWVEFMOXdTNjRCcjluY1lOVFdjOElUTEZraTlkdDZqRHd5SmQy?=
 =?utf-8?B?NXg3MXhtQUwvNjBvZ3dmdm8reTZNdENrSTcxM3RpWDU4Zi9BclAzcWFkSXlK?=
 =?utf-8?B?dzhXK0N0cG1VRFhwOU9aeVMrOEZkZTVjNWgvQzBZUWhueXlWSUxrS0Y0dXlE?=
 =?utf-8?B?UjZBSEp6aFFSTWhPNThlYlRteVlrY0FqdEhCMk5jVi9KSC9Dd0NNNG9Vc04w?=
 =?utf-8?B?TUp6cHkyUFpSTDFZT1YvSW9VQlZua1d0OGlrSnB6cCtDZFY5N1dYOXkyMlZ2?=
 =?utf-8?B?b1lrWWhWc1JpVVRyMXZEU2FsYWZOVm1kenR6REpaK3NFRzZhd3VQRFpmSC93?=
 =?utf-8?B?NHZwTU9QdTNsQ25Sa0hCRE5tc0V3YWtmNFl3dHp4YWZOWVRZblhoQk95clFy?=
 =?utf-8?B?UmJycERDbkRDZVg4bU4rWWhydnhSaGpseWN6UUtHV2p4TkRNMVY3VWkxT1kx?=
 =?utf-8?B?alVPcDZiWFV4ZjJaTEd5Uy9VS04xMHpjTWZnWVYvdDROYXhRTUdZdjUwaXlt?=
 =?utf-8?B?SlliaUh0THp6RS9RSnNsa0VVNE40NXlHNWNtUUc3cTYvUll0YUZzVnhVaUVY?=
 =?utf-8?B?M3RCMldaSXdkeW1JeVRUUlFybnJENDhYRFdTUzV5dHAvelJZZ3RxSForcTJh?=
 =?utf-8?Q?mvDCfa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2s4a0xDUHFhSnNVbEwzOGZHTE16M1RkWkcvazIwL3JvWVlZSk9JMHRBaGU5?=
 =?utf-8?B?UUZCakpHYmw3WWxDYVFZc1pGclVHS0RoL2tKTlFNb0EvTDk0blJqZERqZGRF?=
 =?utf-8?B?b3pKYitJamptNGkraGNmKzRKWkczVVdYbjlGSWViMGRXZ0toMmNxRkNLcURv?=
 =?utf-8?B?aEs3N21obXkydThnRGFMY3d4cXFPNk5CandseS93d2lSWDlLaU8vNzRlUXg5?=
 =?utf-8?B?N29aUVNuNGZxd3daRjk1K1VkTUc5VjZ5UTFBVUE2ZUhKcDM2WktBemZ2K0t6?=
 =?utf-8?B?NGsxYUorYjhzVzF5akxGZXQ3aVdrNTBDLy9TSzdHTFB1eU1vUWx1RUNZMVho?=
 =?utf-8?B?OUIzQ0ZMM3RrdStNcWhEYXRnZ205bUh6aUtxdnFoeW5vTTd3N1dmVzhsbkxS?=
 =?utf-8?B?bmw5M29ObzIva25CQUtIaEIwc0dER0l5YWwwOHAzL0tsYWFySVRIRjU0a2lU?=
 =?utf-8?B?SnkzTG5mdFUvWDBST1htODlNNGY3TFlCd3JYSXlwbjdPTWd6elk1UXNkMUtE?=
 =?utf-8?B?elE0SXNDZHRDSCtwSXNiYWNqRCtQZ2hCT2ZYYUFrRklZZitiRjQ3NWVLL0xY?=
 =?utf-8?B?NGhtcTZGcGV1K3E1YVA1T1BNdlZRUDZjWmZLUzYxanR5cFdDN0hldG5vS3Ry?=
 =?utf-8?B?VytuWTcrdHplNW1YZG9mdklyVU5xNURCRExkdHpIVVB6TVNuRXluOUMxWnNU?=
 =?utf-8?B?amh5NWdwNWIxNjkwSzZ4OWRkcUFyMlhMdUZJTnN6VzFXQ2duRTcweVVTTG0r?=
 =?utf-8?B?Nks1VjhLWTc4Qy94SHdOV2NWOXdzdzFKSHdUcGtSbzdOOG1rdGJlS094SzRB?=
 =?utf-8?B?UVVvQUpldnlXNzBRdFhPMTVFVlN6endrSHdBZEo5KzRuR0l4YXM5VU03K0s3?=
 =?utf-8?B?U2tIdmYxN2hwOVd3TGNvbjV0T0tiVXkwblVNMEszdnYydmZnZk9YVU1WUzhN?=
 =?utf-8?B?TFpha2pxcDV1b0dBc2pQdXN4dzZKNTlJVUIyd2dlcS9GSStWcjlPMGRTVmxl?=
 =?utf-8?B?d2VHTWxFbTNaSHlmUVpjSlgySlA0L2xXdDJUa00vU2ZYTEhxVURibU5WdFVN?=
 =?utf-8?B?SDEwZWI1dUJzR0pkTDRLblRkRDJHbXl0aVU5em9oYjJSM3N4SnhSdXBob2Zp?=
 =?utf-8?B?bDU1QlNkT1M0TDgyT0hqempuQnhVcWlNTmNuQk5GczdXazlpNGZORjVxQmtL?=
 =?utf-8?B?aUYwV1Y2VVNwQXJ6UzFxR2RsVzh3VUNMN0tCcWpPc3Zyc1IwMmgxd0dub3ZW?=
 =?utf-8?B?eUUzbW9kNG54NWFRV2xPUTJaaWxVOEdkNVlqdDdpTzVxSHJhNXc2M1o1N2No?=
 =?utf-8?B?WXJQYUkxUFV3QzNrYklWYzltZ0FmZXU3UjNpaHJicVpHWVhVbHpmU3RPRHlI?=
 =?utf-8?B?Y2czb3prUi9nZkpibWZhajdxb3E5eDAzRHEzT002SHFiVHdpSGFwbmtDYzM3?=
 =?utf-8?B?djhlVW13Nlh6dGt4a2x4WlJWZjZFWFdsTkZ1MEhxZyt5Z29sNzVnSWJqNmJT?=
 =?utf-8?B?cE51YlBRb281SXJGdTFyUFJ1ZnRMeEgyeDZuOWptSHArWDNWc1MySG0ydktZ?=
 =?utf-8?B?ZlhTWThIZmZJNHU4VkFkVHI1djJqaStVOThaSmVCbmt2bDhrRVUvdGR0THVP?=
 =?utf-8?B?d2I1bGZ6ZzROVDgySVE4RWJGNXJsNWN1dldsaWYydUJBbkNpdlI5aHZPNTBY?=
 =?utf-8?B?THVCaEV5RjBlY3cvSFI3Zy9QZHFyaThPRkJsYTdUTHhWb2JTOWw0RmFPN3VO?=
 =?utf-8?B?WTg3anFMVktSM0hvTSt2Ukx6VGczMXhWcXFHVFZ2ek5CdHlub0syd0VvT2xa?=
 =?utf-8?B?bFZ0NW1LSE44Zi9LM1ZEZGFvajhpTVg2TnpONXJBeFF3U092SlkxaVF3b0Fq?=
 =?utf-8?B?R3ZTMGd3a1RndzRJdXpaSmw0QXNpcVZKSnpVeE41anlwYVRZM0tvYU0weWdE?=
 =?utf-8?B?ZVYzdXhvRHRqblkrbHYrY0FWMHc4NDhXM2lKOGZnM092cjhpNW9XMGhPdGIy?=
 =?utf-8?B?dC9sWHlMcUdZKzNESHZaaGdNTGRlNFh3bEVSRUh1L0dlZVp5cDhJN3REWmI0?=
 =?utf-8?B?L21tU1A1bStzbjE3ZW5oWEEyczdTV3ZxMWNhVnJPeDIwUURRZlEyMHdZQkw5?=
 =?utf-8?B?YlFxZ3pmbTR1S1p3TGkyTlB4UDN3bm4vclpybUthUm94VGN3aTJDT0hUd1lt?=
 =?utf-8?B?UVBDczdRZFovSHU2Szk3dHhaMWE5OXFZNENEVENzZ2EzeHZJWmUrRlFqSEZn?=
 =?utf-8?B?bndQK25zUlNaTEFJUGR1cFhyUkdNMlA5eHJEelhrZFlmSDM0U3lQSXlwU0cv?=
 =?utf-8?B?NjhIQ0tIbVJhSlR6MXVZb1BGMmo0WmpSM1NDclBjcUJvWWR5dUt5Vksvc0d1?=
 =?utf-8?Q?Sasqx9Xyh2vDWDo8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7c65b3-dccf-4e45-297c-08de5d8f0b65
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 10:30:08.7952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUg+3UsWRc6Vyw/nolYDnoHnHhyWIEs1u7Vag4jttI+93X7VoCtZDNsHt1t4nQGdOf28+GKSMzdpFw4WfkajOz7XCLTV9xy9KwgfqIrAhhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7715
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Brian,

On 6/1/2026 9:13 am, Brian Sune wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> CoreCourse Altera GEN5 Cyclone V board
> do support different size and formfactor.
> Now introducing AC501 C5 to mainstream u-boot
> This is a UBGA-484 based board with basic
> feature. More info on [1]
>
> [1]https://corecourse.cn/forum.php?mod=viewthread&tid=27704&highlight=AC501
>
> Signed-off-by: Brian Sune<briansune@gmail.com>
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   arch/arm/dts/socfpga_cyclone5_ac501soc.dts    |  86 +++
>   .../dts/socfpga_cyclone_ac501soc-u-boot.dtsi  |  44 ++
>   arch/arm/mach-socfpga/Kconfig                 |   7 +
>   board/corecourse/ac501soc/MAINTAINERS         |   6 +
>   board/corecourse/ac501soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
>   board/corecourse/ac501soc/qts/pinmux_config.h | 222 ++++++
>   board/corecourse/ac501soc/qts/pll_config.h    |  86 +++
>   board/corecourse/ac501soc/qts/sdram_config.h  | 349 +++++++++
>   configs/socfpga_ac501soc_defconfig            |  85 +++
>   include/configs/socfpga_ac501soc.h            |  16 +
>   11 files changed, 1566 insertions(+)
>   create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc.dts
>   create mode 100644 arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi
>   create mode 100644 board/corecourse/ac501soc/MAINTAINERS
>   create mode 100644 board/corecourse/ac501soc/qts/iocsr_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/pinmux_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/pll_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/sdram_config.h
>   create mode 100644 configs/socfpga_ac501soc_defconfig
>   create mode 100644 include/configs/socfpga_ac501soc.h
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 3cd762977cb..2210b44f9bf 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -469,6 +469,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=                               \
>          socfpga_cyclone5_socrates.dtb                   \
>          socfpga_cyclone5_sr1500.dtb                     \
>          socfpga_cyclone5_vining_fpga.dtb                \
> +       socfpga_cyclone5_ac501soc.dtb                   \
>          socfpga_n5x_socdk.dtb                           \
>          socfpga_stratix10_socdk.dtb
>
> diff --git a/arch/arm/dts/socfpga_cyclone5_ac501soc.dts b/arch/arm/dts/socfpga_cyclone5_ac501soc.dts
> new file mode 100644
> index 00000000000..2c11e2088e3
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_cyclone5_ac501soc.dts
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2025, Brian Sune
> + *
> + * based on socfpga_cyclone5_socdk.dts
> + */
> +
> +#include "socfpga_cyclone5.dtsi"
> +#include "socfpga-common-u-boot.dtsi"


Remove #include "socfpga-common-u-boot.dtsi" from socfpga_cyclone5_ac501soc.dts;
it’s already included via socfpga_cyclone_ac501soc-u-boot.dtsi.


> +
> +/ {
> +       model = "CoreCourse AC501SoC";
> +       compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200";
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       aliases {
> +               ethernet0 = &gmac1;
> +               udc0 = &usb1;
> +       };
> +
> +       memory {
> +               name = "memory";
> +               device_type = "memory";
> +               reg = <0x0 0x40000000>; /* 1GB */
> +       };
> +};
> +
> +&gmac1 {
> +       status = "okay";
> +       phy-mode = "rgmii";
> +
> +       rxd0-skew-ps = <420>;
> +       rxd1-skew-ps = <420>;
> +       rxd2-skew-ps = <420>;
> +       rxd3-skew-ps = <420>;
> +       txen-skew-ps = <0>;
> +       txc-skew-ps = <1860>;
> +       rxdv-skew-ps = <420>;
> +       rxc-skew-ps = <1680>;
> +};
> +
> +&gpio0 {
> +       status = "okay";
> +};
> +
> +&gpio1 {
> +       status = "okay";
> +};
> +
> +&gpio2 {
> +       status = "okay";
> +};
> +
> +&porta {
> +       bank-name = "porta";
> +};
> +
> +&portb {
> +       bank-name = "portb";
> +};
> +
> +&portc {
> +       bank-name = "portc";
> +};


Avoid duplicating nodes between DTS and -u-boot.dtsi (e.g., GPIO bank-name).

Keep board-common settings in the DTS; U-Boot–specific settings belong 
in -u-boot.dtsi


> +
> +&mmc0 {
> +       status = "okay";
> +       bootph-all;
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> +
> +&uart0 {
> +       clock-frequency = <100000000>;
> +       bootph-all;
> +};
> +
> +&watchdog0 {
> +       status = "disabled"; +}; diff --git a/arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi 
> b/arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi new file mode 
> 100644 index 00000000000..8d2caf69dd1 --- /dev/null +++ 
> b/arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi @@ -0,0 +1,44 @@ 
> +// SPDX-License-Identifier: GPL-2.0+ +/* + * U-Boot additions + * + * 
> Copyright Altera Corporation (C) 2015 + * Copyright (c) 2018 Simon 
> Goldschmidt + */ + +#include "socfpga-common-u-boot.dtsi"
> +
> +/{
> +       aliases {
> +               udc0 = &usb1;
> +       };
> +};
> +
> +&watchdog0 {
> +       status = "disabled";
> +};
> +
> +&mmc {
> +       bootph-all;
> +};
> +
> +&uart0 {
> +       clock-frequency = <100000000>;
> +       bootph-all;
> +};
> +
> +&uart1 {
> +       clock-frequency = <100000000>;
> +};
> +
> +&porta {
> +       bank-name = "porta";
> +};
> +
> +&portb {
> +       bank-name = "portb";
> +};
> +
> +&portc {
> +       bank-name = "portc";
> +};
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index f2e959b5662..1a0fcd64296 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -239,6 +239,10 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
>          bool "Terasic SoCkit (Cyclone V)"
>          select TARGET_SOCFPGA_CYCLONE5
>
> +config TARGET_SOCFPGA_CORECOURSE_AC501SOC
> +       bool "CoreCourse AC501SoC (Cyclone V)"
> +       select TARGET_SOCFPGA_CYCLONE5
> +
>   endchoice
>
>   config SYS_BOARD
> @@ -263,6 +267,7 @@ config SYS_BOARD
>          default "sr1500" if TARGET_SOCFPGA_SR1500
>          default "stratix10-socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
>          default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
> +       default "ac501soc" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
>
>   config SYS_VENDOR
>          default "intel" if TARGET_SOCFPGA_AGILEX7M_SOCDK
> @@ -284,6 +289,7 @@ config SYS_VENDOR
>          default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_NANO
>          default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_STANDARD
>          default "terasic" if TARGET_SOCFPGA_TERASIC_SOCKIT
> +       default "corecourse" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
>
>   config SYS_SOC
>          default "socfpga"
> @@ -310,5 +316,6 @@ config SYS_CONFIG_NAME
>          default "socfpga_sr1500" if TARGET_SOCFPGA_SR1500
>          default "socfpga_stratix10_socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
>          default "socfpga_vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
> +       default "socfpga_ac501soc" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
>
>   endif
> diff --git a/board/corecourse/ac501soc/MAINTAINERS b/board/corecourse/ac501soc/MAINTAINERS
> new file mode 100644
> index 00000000000..e0479c9921d
> --- /dev/null
> +++ b/board/corecourse/ac501soc/MAINTAINERS
> @@ -0,0 +1,6 @@
> +SOCFPGA BOARD
> +M:     Brian Sune<briansune@gmail.com>
> +S:     Maintained
> +F:     board/corecource/ac501soc/


Typo: fix path F: board/corecource/ac501soc/ → board/corecourse/ac501soc/


> +F:     include/configs/socfpga_ac501soc.h
> +F:     configs/socfpga_ac501soc_defconfig

[...]


> diff --git a/include/configs/socfpga_ac501soc.h b/include/configs/socfpga_ac501soc.h
> new file mode 100644
> index 00000000000..1da5c866220
> --- /dev/null
> +++ b/include/configs/socfpga_ac501soc.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2025 Brian Sune<briansune@gmail.com>
> + */
> +#ifndef __CONFIG_CORESOURCE_AC501SOC_H__
> +#define __CONFIG_CORESOURCE_AC501SOC_H__
> +
> +#include <asm/arch/base_addr_ac5.h>
> +
> +/* Memory configurations */
> +#define PHYS_SDRAM_1_SIZE              0x40000000      /* 1GiB */


PHYS_SDRAM_1_SIZE is legacy and not used by drivers.

Memory size should come from DT (/memory node) rather than a hard-coded 
define.

Thanks.

Best regards,

Tien Fong
