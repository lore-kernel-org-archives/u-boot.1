Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCBCC83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 14:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55F2831B4;
	Mon, 21 Jul 2025 16:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ebmv2oVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CA4831D5; Mon, 21 Jul 2025 16:17:11 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E9983164
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 16:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdTvH7BARb05Riu2IzPclQprdTX2xZNb9TSmFLkb7nJwGoxnJlA6Fh0nmSDCSMhh3gHSTP8GuF8OMGbcx/d7mwwc0m8jPHi2zZjte5zSzKmDsRZQpEdme+o7FMib5Zdmy8ViywR4BUJV6E1IXfIznkIkWp27QKzlX8JvPMTwdkXSQ1OmlcvX2mmh7tG6npq8EW8TI8jFUmmJqyLt3NBw3lI+Ie11UWUHoY92iFKBVVbQvDTADIsdtUb8X1sQFpbYtxXZO2WXp3RCRj6Eg9KFHpgMcubNBsLLNCTQooSvFIyRz5otPvYZ0kw1LAqBKYsvvC05sfSp7f1Gn9C33TpqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmz5m7kUv+ufu7xsDjSRCQlxnkBpxgBblwO8LEie7O0=;
 b=U7++tXXSoPnPkyJj1orviMptu9CKpK/EuEA7ZI6jZE6wv+hSlr3QJq7a5B6pwIoprtExgUJ2Zs3A9NRk/Htl/sTRcV63JZSXNpP3ItPXpCqfoJQf7w8n+TeQXjrLidoi5mJ8+B7MxBUYI4P/efOH61Pi/JteXAvGIeXIV5/1R4TPUFtm7SeNyzW5dg8iQEsOuoHMei3FUicCeeCufRvoJnNWj28MQvDty6SOkmIo0p4oQH3RIArqG5GTQXGKQF06L7QGD07YxCZBOjNVPiLHZjdJfUjOJ8WdnMmQVP3a20L7CODOXaqjHLMEOh8u23QOuhYJXXQ/CKE9lZAFvtGh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmz5m7kUv+ufu7xsDjSRCQlxnkBpxgBblwO8LEie7O0=;
 b=ebmv2oVwhxIHLLVSf0CkOCPRS+hwEW3dlfQHkcUUR5BGME/SagD7gHxwlEWnoupxMTJvDdSAqns8+7ch4EnWP08Zz1sBZIpjHMroXtrfFDRHNeTU6m17YjiBxMU3u0hmH4nMqSuKYHAY6mf9jJfoV5eEmlbAFmGZsB5QMdRagJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 21 Jul
 2025 14:17:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 14:17:03 +0000
Message-ID: <58d20e4a-6b5e-4217-a95a-0643a37d1a09@amd.com>
Date: Mon, 21 Jul 2025 16:16:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/24] fwu_arm_psa: Add ESRT support
To: abdellatif.elkhlifi@arm.com, u-boot@lists.denx.de
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Casey Connolly <casey.connolly@linaro.org>
References: <20250721111816.62340-1-abdellatif.elkhlifi@arm.com>
 <20250721111816.62340-18-abdellatif.elkhlifi@arm.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250721111816.62340-18-abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0215.eurprd08.prod.outlook.com
 (2603:10a6:802:15::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0aacc5-60d7-4637-470e-08ddc86143ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym1wdURjUE8wWjdoQkxOOU9rdjlJUCtaVGpZbHBWV0hxVndVSWdXdEVLd2pD?=
 =?utf-8?B?VDQ4L2Vla2pBaWRpTzEwVjNMbUxQak1aWWthVy9jZ3ErTTBBSVkyWmQ3a2s0?=
 =?utf-8?B?dURqemdHSTUzUXhVOGV1eVh1eEZNckcyQUNnWGZEU0M0c2dvN3kwSERtRGNX?=
 =?utf-8?B?eTdYWmcyU3V0eTN3ZDROazQvNCtqa2lUTkpDcVdEZktTaWYrY0EvVUVQajJR?=
 =?utf-8?B?dHRyTE0zSURsNE03Y081cE9XV1d4R0hvdUlHWGJDUDU5cW9VUHBJd1JpR2dk?=
 =?utf-8?B?WmNuWmJ5UHJSR1hDMUFpYjFoWVd2bUxiUDRIaXhKVFRSSU1aMmRwY1NXTS9s?=
 =?utf-8?B?NjZpVmlVZW1EalNqb2ZyU0cvTXlwUTI2YnMxNXNFQXNvUFRnSVJUcVZEWWti?=
 =?utf-8?B?bVZFU3B6a09idDNGZzBqT3F2ZXFXVnM1a092L2tuSGhMWDFMelFsZm5FTFdk?=
 =?utf-8?B?ckVCRmcrTkora0JwbGxKZldWQTFEY1ByTEhmTWFZd1Q5a2swbTFVelNJOEJi?=
 =?utf-8?B?bU82M29tcHg0MXJGekwwSXhkOStWcXgxTHlZQWlGUk5hNTIwclpVYXVsUGxC?=
 =?utf-8?B?V2xUWXFMQjhxSHpKdXpNYXcvc0FBd2tHUkNwMWdPUHcySzlFQ0tiekR5YjlF?=
 =?utf-8?B?VHNCa29INWEzYWc2dG1Gd0FLK3A5ZTlaRmp0dGtha0Zxd25tVmlwai80ZmE5?=
 =?utf-8?B?b0RSQlA4SWdXeHdWMWtRbHo4YTRSTi83L1FpcGpDbCtibzB5aklXcVpsODBQ?=
 =?utf-8?B?UHZvdExXaGpzSUtHQ2dDM2tUMUJweXhwdEREZ0NPa0psWnRIY0dtWlJvT2ow?=
 =?utf-8?B?M09neDFEVWs1QXRvUUpGNkNpWDZhNC9laFhGbDdFT25xb3IwOFIvYk1SUjdq?=
 =?utf-8?B?NG43U29naTU2di9ETDhwdldGT2xqMDFHSDRQcUtoaWtNK2JiOTJYcHV4RXVq?=
 =?utf-8?B?ZmN5dFRLWkFVM3g3Zk9kWnZnQ2NtdEhISHVEZUlPeUlIVXFnWmFob0R6V0Rz?=
 =?utf-8?B?OTRVMGw1TnVFcFFrR05ERmRXb3JCek9IVkZRLyt3NWxGOERiSTdQNDNYZjJT?=
 =?utf-8?B?QXFmcWljZmJqZ2FweHArdW1JQk1HaVZSN3V1ZnFhalRGcGZsMXA4aTlNRmIz?=
 =?utf-8?B?ZTBtMVRUcmExQnJvYStUcTlnSEdwWmFwRGlnWWRnQlpldUgyU0tpM294WkQ2?=
 =?utf-8?B?TllFSnVYVDB4Y2xaTHo5MUZMdkw1bzJxUzhhT3FacG54dXY1UnE5d0VEcVJO?=
 =?utf-8?B?NGpUVWpJS3B0RlVIaTlnVEg4YitUa2hCOHNnK1A3ZlkvZjB0MnV4VHJrRFB2?=
 =?utf-8?B?N043anRYS1FSNkkwbzQ4cll3OXAzMVh2MmpqN0gvenVlakowQzRaOHJjcGFy?=
 =?utf-8?B?dDRTQk5mSm1ldHdRNi8ya1JqSld6NEY3QS8wbkpDL01udm5pOHMzMmIvRVRk?=
 =?utf-8?B?bHpXdlJuMmV6NHNJY3h0RkdSODZwS1g1NzAzY3dqb0NnaXROdisveU1FM3R1?=
 =?utf-8?B?djlLQnpUbnFGcDN2SVpKbmhVV2lHT2o2OTRIUmZZVk1aM0o2UVJkeWFRbWE3?=
 =?utf-8?B?RURUUkJtWGhtWUtSUGp4dzV5Q3hVUHIrZCtWVHlGSzZxc1V2NS9PQU5OeXh4?=
 =?utf-8?B?QUdNOGJ2aFVPc2ZEeHl6UnJ5b3dQOHpML0RFSlhSeUN4TVpDZ3loNnZ2L0lR?=
 =?utf-8?B?QTBkQUxic1IvYmZQeHRhTGdOenFQUE9yYnFLWU9odW5CMVN1MEEzbStsak9n?=
 =?utf-8?B?WlI1dWJSNjFNbmwyWHM0UXYySVM4UitJMjJ1eDVXNkhWajNEbE56bCtpNkYz?=
 =?utf-8?B?Zy9WNnZwNEFJTEp6ZVpEc0oyNXZsOTNyL1pTTUE1Wi9LT1FFK1FrV3ZaSVV5?=
 =?utf-8?B?MEN3eWdRYzFHVHBUdXRmc0IzVFVQMFJZQThURXZOMTd0bEhicmhTVzg3K1h0?=
 =?utf-8?Q?BjBLAyPY4Q8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkpJeFBCWldJU1dXODRVYmhqb1F0czNKRmVoQjRLZkFXdTYwdFREd09DRzdL?=
 =?utf-8?B?WHFzNHVYQ0lZaE5TZHBSTTZmeXFlaTRORGVXa2xvaTJxMUZBcmZHL2Vldk91?=
 =?utf-8?B?UFF1YSs4ZnJhdXY5RXVIcVVraGR0ODZPZVdiRXhTTjQzaDlSUlNuWnZXcFg0?=
 =?utf-8?B?R0xHN1hnVEFxajd1Ny9zME1EYXkzQjgzVkVVNS92U1BHL1g2ZHh4TVl2UTc1?=
 =?utf-8?B?K3RWWW9NVi9YTnpUSzNTMUZBS055YlBZQlZ1SUoxRmRRaGZtUEF2KzNvSmFL?=
 =?utf-8?B?cVoxYVNiVnU0VHlpUHJ6V0puTXZKLzZ0QzZveDBBTzlpTjNaZVdhaWVKK2hB?=
 =?utf-8?B?aTZtUXdKOE0wRnYxMVlXTjd4VGdKT0ZHUUlCRUtGVjNGSWpPektZeUVpT2dC?=
 =?utf-8?B?Ymp3cUl6RysySWdhNzFWTGdMUHhsQjRKa2Y5YzRMaUp1YnNsQU1KTVFVRGpk?=
 =?utf-8?B?ejc5ZEIyVEpIaHhKSTMvUTNtTUlXWHhtY2ZmRnU5YnZlZVJrb0xIQ2pOemNJ?=
 =?utf-8?B?SkJoQnpXZ3NaRDV6RmNuZ1lueXdwRFZHUy9rbDVjdzd2eXlMWG5EZHlzYy9G?=
 =?utf-8?B?THBkdDdvenhJZENyVG9oQ0lXVXdSVHpZVjk2TEZDTW9lUlJkYm9xZ3dCMTR3?=
 =?utf-8?B?RkVHNlNNRzgwTjVGOVR2VUMyOS9mRks4ZStsMW5OdVJ6ZEowZ3FUMnpueGNV?=
 =?utf-8?B?TmozNjVQMC80bENFK1VqRm9keHRqeVl3cEVpdGhKODIwS0lXd1QrNWFMVGpV?=
 =?utf-8?B?UkRJaXdDcUN3R0N4dGY1cTJlaS9NeW1wMUdPaHhLelp2MFdYbmtoYWpuVTFN?=
 =?utf-8?B?U3lqZFhRamVHOEZtSXlsT1ZONVBCd3ljbUpFQkFsT2t4cGVkZlZkOVAyKzRD?=
 =?utf-8?B?RGZWQUlhbmdtalh6eC9VUlhjSFA0NXFjekhCb25MZElycEhyY3p2cjg1ZnJr?=
 =?utf-8?B?V3ZYcG52QnhSK1d4QTJXd0xrc01xT3lXRW1BeGZ2cDRoSHVUOEQyYjN0aVFF?=
 =?utf-8?B?TWNoYVNTSjA4NVlzbFVnRXFTa2NSR0lNd0daQ3dhMXdsWm9BMWVEMDEwRFY1?=
 =?utf-8?B?U2lHU2ZiZDZqQ29xUUl0eFJWTHRkVlRWd3NiZGJPL05tQTk1R1dFeDczcGdl?=
 =?utf-8?B?UXR5UkhOcFF3cDVrSUJTN0lFU0pWbk9HbXZBazRNbFhnT2VYR1BjUWIwc3Fy?=
 =?utf-8?B?MithcUNyL2VySWZoTm1rcnlEd0J2S2NGUCtvcHpQTitlOEJMQTBFclhteFNy?=
 =?utf-8?B?eEc5ZnNEbWhhMGRKcGJxTWNVbzRWcklHeElmSDFKZWxLb0VWSWVYSzBIckFP?=
 =?utf-8?B?OGs4eFF3VVRHcFY4WlBHa21NL1J3c0FRTjF3akxmenFSUy9ucDltVTlaWkpQ?=
 =?utf-8?B?dk1xcUxORDFhaXdwRjdNK3AxdzhDYUIxQVFlUE1vZWQ4WnpONDhIeU9zQUhG?=
 =?utf-8?B?VUY0cFl6QmRIakcwTGZDV2dMVzEvVmFKTEgrS0hYekV4b290aWhlYjVZZVhS?=
 =?utf-8?B?Snd5SkwycXhGTm5hUzR1Y1ljTGttZmw4NFI4SGJOL01OSW9PbjlMVzg5VDlR?=
 =?utf-8?B?Q2JTWnNzOFRvN1N4QzR3cmdTSHliVGw3ZEZMOFdsVmFsNlJ0ZFY4dzlPb1dq?=
 =?utf-8?B?UTRhdFVGUjdUcHVmVUtTUWNUMGhLZnU2Qk5SS2cvTVBzSytTU3dBd29DcURM?=
 =?utf-8?B?V2JZYnc1SVBMeFVZTTFyMXFrcXdLT3hTVGJSWUIwY1hDZm5KejRNVjNQdks5?=
 =?utf-8?B?YmxIeHVRSjNIcFJEZlZkbkNEejEyMk1qME9jdGF6LytNMFFtQmVYYm1WYkRz?=
 =?utf-8?B?Tk10SWxhZklMVTJ1dlRmczRhYTZyaXRoenE1MldWYWQxMEovV09xRU44eDkr?=
 =?utf-8?B?dVliWUpqNEpEVUZ3dFMzTkFPZFF6dkNVbmxvR3BFbzBOanllK0dtOHZLMnRN?=
 =?utf-8?B?Z3poRloyVlFZSzVhVFNVaHZOSHcvdEM5SmJNdENvMHlTZnFZeHR1S3lxbFNF?=
 =?utf-8?B?cWJaRWFzRDJVUGYyVHBWblB1M3FMWHRDTjJnUHVCNm94bnB3bUJseXNPUnh6?=
 =?utf-8?B?RFdoQmVTbUl0QzhIWHkzNXlxcWJqaDRRT1U1dGsvMyt4Y3E1czJaWFREZnVN?=
 =?utf-8?Q?HsLrrhMJxQBh5yBiSQWLPFbDQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0aacc5-60d7-4637-470e-08ddc86143ed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 14:17:03.6877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlV2Elqrdfee7nUaYP06B7JGEz9TMQZKRjWpLfE7QZnKAZTf+bxDFOWbQocEsLT0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
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



On 7/21/25 13:18, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> 
> Read ESRT data from Secure world in GetImageInfo()
> 
> Use FWU_READ_STREAM ABI to read ESRT data from Secure world.
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> 
> ---
> 
> Changelog of changes:
> ===========================
> 
> v2:
> 
> * As suggested by Michal: Add /** for marking kernel-doc format
> 
> v1:
> 
> * Read ESRT data from Secure world in GetImageInfo()
> 
>   include/fwu_arm_psa.h         |  13 ++++
>   lib/fwu_updates/fwu_arm_psa.c | 116 +++++++++++++++++++++++++++++++---
>   2 files changed, 119 insertions(+), 10 deletions(-)
> 
> diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
> index 6400cf44d1b..38fb9bde165 100644
> --- a/include/fwu_arm_psa.h
> +++ b/include/fwu_arm_psa.h
> @@ -16,6 +16,9 @@
>   
>   #define DEFAULT_HW_INSTANCE		(1)
>   
> +/* The minimum supported ESRT version */
> +#define EFI_SYSTEM_RESOURCE_TABLE_FIRMWARE_RESOURCE_VERSION		(1)
> +
>   /* Default values of the ESRT fields which are not supported at this stage */
>   #define PACKAGE_VERSION_NOT_SUP		(0xffffffff)
>   #define LAST_ATTEMPT_NOT_SUP		(0)
> @@ -355,6 +358,16 @@ struct __packed fwu_image_directory {
>   	struct fwu_image_info_entry entries[FWU_DIRECTORY_IMAGE_ENTRIES_COUNT];
>   };
>   
> +/**
> + * struct fwu_esrt_data_wrapper - Wrapper for the ESRT data
> + * @data: The ESRT data read from secure world
> + * @entries: The ESRT entries
> + */
> +struct __packed fwu_esrt_data_wrapper {
> +	struct efi_system_resource_table  data;

double space

> +	struct efi_system_resource_entry entries[CONFIG_FWU_NUM_IMAGES_PER_BANK];
> +};
> +
>   /**
>    * fwu_agent_init() - Setup the FWU agent
>    *
> diff --git a/lib/fwu_updates/fwu_arm_psa.c b/lib/fwu_updates/fwu_arm_psa.c
> index 40746eee6ce..7297e724569 100644
> --- a/lib/fwu_updates/fwu_arm_psa.c
> +++ b/lib/fwu_updates/fwu_arm_psa.c
> @@ -27,6 +27,7 @@ static u8 g_fwu_version_minor;
>   static bool g_fwu_initialized;
>   struct fwu_image_directory g_fwu_cached_directory;
>   efi_guid_t g_update_guid[CONFIG_FWU_NUM_IMAGES_PER_BANK];
> +struct fwu_esrt_data_wrapper g_esrt_data;
>   
>   /* Error mapping declarations */
>   
> @@ -898,6 +899,100 @@ close_handle:
>   	return ret;
>   }
>   
> +/**
> + * fwu_esrt_sanity_check() - Verify ESRT data
> + *
> + * Make sure the ESRT data matches the directory data.
> + *
> + * Return:
> + *
> + * 0 on success
> + */

Please run
./scripts/kernel-doc -man -v 1>/dev/null lib/fwu_updates/fwu_arm_psa.c

and fix issues created by new added code.

And obviously here you are returning more then just 0.


M
