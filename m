Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753B9D6ACDC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 10:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB9C383C54;
	Thu, 18 Dec 2025 11:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dn9StWb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE1283D07; Thu, 18 Dec 2025 11:11:23 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E4483BA1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mH4M04r7PX7c6TeTZXle6X80P9iiNy9OK4/t5IGEU4oEwjqXiNsFO9/I/YBEjiN/5vvcfBShP84USE6UbxWZ9OvpvzKMkVwUjI8fLe75LBJ1Kp7ByiJcSZAh0i1U++MBD6xhzDTiXEaPJ9b0RmieVDCyNpOcZ/Bjre9NaLpBniD8rkdSScxJZ7XIPiIhpZUmQ80i+ClOs9oRpveiPc26zdL3fKwoqFqN5+CqVsSmWNZb6lZCJqQwhRvA6APVKnNzEmz98FHq5KqMNOUtnIC2B3c3JkyvhmimiGmsmlqKt9AgQdE+7+qP3ydwzglCJmCW4gpY1w+Ty0iAtW4fiolvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbmHOtMg1k33r/TrQwGfd+w1rnAj6r0y0s+G4ZnyeIs=;
 b=D9a0bEMqYkkClYvXUD6NzSUx6DFjoC64+5R0yul2DG3SpHbIqdVKuVGHavS/MXpKqRXsficg5g42DJykQINnYNykEooPRbNZbFq39LF8Txy6dltIruEsqKIgRKbzIH1kFRwMLmpGx9Go1eWIyMK7DFoxsLbUJMw+b4cSkty7LGB8Jgb04D35FDh1s/ZYF7gOxd2L4CUaEsQoLVx9Zz3/ascYTa61jJ1G+M563X7bVYRjRVWLFEbwOCeG9McqNvEzmuvw1tyldy9K5bjapsDsYgwJMqYA5akjt5fEJB7hW8ga1Dz9Myzp10kIxV1QLHEGXzVmONuuC+dmlrlqXgBq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbmHOtMg1k33r/TrQwGfd+w1rnAj6r0y0s+G4ZnyeIs=;
 b=dn9StWb4T2KFi0aCf3tdcV6YEjkkTGZp4Bp3hjvX4nnDigeSOh9kuI/5jZQbX4HyybtCcsciuUHgBaKzhaWms/WcFMPzxJbQZx+UsUu41mP10nLqBYWRZxUSlTe3Rvo4X7DoqCjXaTVS6hAj/BFJuJOLGTYVpmSiGyVF64y0TqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS1PR04MB9478.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 10:11:14 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 10:11:14 +0000
Message-ID: <2653b1c3-78ab-4120-9366-62b7d4a3ea82@cherry.de>
Date: Thu, 18 Dec 2025 11:11:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cmd: bdinfo: provide long help with all options
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251217-b4-bdinfo-doc-v1-0-83bf7fdb1691@cherry.de>
 <20251217-b4-bdinfo-doc-v1-1-83bf7fdb1691@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251217-b4-bdinfo-doc-v1-1-83bf7fdb1691@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS1PR04MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 1251563e-c646-4dda-b8fc-08de3e1dc6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmV4R3dPWmxOVFRidjRHZmRRQWk4Mzh3VnBFczlZOHRicFhKVEpPcFdvb09o?=
 =?utf-8?B?VGtxSVFtRkFjcnV6R1NUWXJkNmxCekNzVHhRR1FjSlIyNFVUbm1RZytHS01R?=
 =?utf-8?B?RmMrTitXNTZpQlJoQ3E5TVFzVkQxMkJyUThNb203WS8zMGxuZjV4bENLY0Nz?=
 =?utf-8?B?NDRlWWNjYkJhTXVyNFo0c25VWXFpbyt1SWo4MHB5RnZqNFhISnlLV1Blak56?=
 =?utf-8?B?anE2S0psSUpNVnB1RWFaQjBtSUtnK21aWnBqZU43d2hnaVJQWEM3djlFZzZn?=
 =?utf-8?B?MHJMSzFRaWhwM1RQR1NYMGZFMUwySWxxcTQvdmZ0VU1iQ1VnYm9nRzBUYkZt?=
 =?utf-8?B?S2VpZ1VNU3F4aVlRNEFhR0NOSlhYTmZIUUtCVTdwM3Vya1pIV1Y5L2hoVW03?=
 =?utf-8?B?VTBsL2lGTnJONHpOTEJDZ1BwTFgycVZMRHNiREk2cVQrOXI3aUNJQkNXOTNy?=
 =?utf-8?B?U2Q1N1Vjdy9Nc0ZvSGV3c25WWE9MY1F1WXlvWnZQVGt0c2N0b3ZnSkNQOHBH?=
 =?utf-8?B?bVhQZnVqQitrSSszeThUY3NIYzVYMUZFL3p1a0VQekl6S3RmUEhlRFZRWS91?=
 =?utf-8?B?N3lmTGhJa0VhZWRtVUNGdWIwY2RpeVNmeXdMYlE4MXExNnpZaXo5b0kzRWYv?=
 =?utf-8?B?SlJXekJiYW9pWk9JREJMV2tNSjdndGRBRklEeitqYW5BTlZDMjBpQUtRcFlQ?=
 =?utf-8?B?bXVzakVVd0E3TTB5SWxHWWlUZ2JsZlZUdjRQeGt4UzN2WXJmQ0U4ZVVKYk83?=
 =?utf-8?B?dEh0MTVaRUJ2MW1EUUN1Z1h4eW92TzZ3ZkNiWSt4YTBxYnp4b3BIQjhlNzdz?=
 =?utf-8?B?UXhnZmVNMzY3QVZsYzM3UE10VDBRRUNFdWgzaktjWjhIQUI1aVFFbElhbWpN?=
 =?utf-8?B?dlA1b093c2VPb1NaVUJ0d0Fjc0l5V3ZQOVpoSXIxWjdjeGhnOE1nQW02aFUz?=
 =?utf-8?B?WEFFbldWbitlaVd4ZTVnUm5iSGR6ZVpzalR4dHRhQ3EyZG93SG5iK1dpOWI0?=
 =?utf-8?B?U0xOVHg3b3pITUIrZ1Q1UEk1bEVJYmVob1dnbDRiZ0FNZVA1eHMrZDlWcEd6?=
 =?utf-8?B?MGJWd0xPOGVHOXIrREoyYTQ0aVhUU1orYTZiUzNudmltMWUvYXdNeHljVU0v?=
 =?utf-8?B?RmVkamN4dDFjT2xhVFVHTjRpRGFJV2ZiTUhvc3NOYjRBSjdSL0F2UFZBZURi?=
 =?utf-8?B?d3c2UmtMYWdCcU1pZGlVbGlQL2M3WHZ3dm1SakczWU5xdUY0ekdCYzlWZWd3?=
 =?utf-8?B?M2JKL2RXYlJsMHI3WTJ5ZG5OY3d0dUh5WHFFTXlFMnJ3U1kycVFacSt3TEt3?=
 =?utf-8?B?RTB2ZEpxbmJiR2NPMGROaWRTbmhPMFJtS1B4c3pHRVZyMnMwU3JYaHpOdDRG?=
 =?utf-8?B?dUlWNVMvNkR6T0hJc2EzMm1XcDJwakdTOUJCOFJIM1BMM2lTOWdUc2F3YUI4?=
 =?utf-8?B?Sk1PTGFGMzFKZ0tCSUpTSmdQV1YwNjJGSlVoQlIybjFWb1JsMEsydDJsV0M1?=
 =?utf-8?B?SU52N1RBQm51VXI2U0FiL3RUdmF2UFBHRnNubkhnS1hManlialMrelJCd3JC?=
 =?utf-8?B?TUF6OWJkUU9yQ2JMY0RnK2hiWDlXaFRwcmZzNG43MnlNcmxCNDR6ekxyUUFU?=
 =?utf-8?B?YlptSlh0eUFkTHpGWE05M2pINStOd2paditLVmk1eUJIN2hVNXYvNmtScU1W?=
 =?utf-8?B?amZPd2liNzBIbGl5Y1ZMVDZGUy9QeTYzWm1mTTJFUkpIQjYwbkVYYlpoWVNk?=
 =?utf-8?B?TkIvR1RyNElKek54bkNwa3d5b2RYNCtNQms2WjJGTXZxMGhNZzJMMERzR25O?=
 =?utf-8?B?UkNSd050cFZReU1CcUpjcHhma1VDaWRia3RtVGZCWjFaYkxsem10anIrVGFa?=
 =?utf-8?B?Y3lMNXRtZU8zTTFCd3g4RkJzMVp2QVU5MW1jd3lIbTQ0V05SNVE3SmdqTlRj?=
 =?utf-8?Q?N7FQvFN5/4d/ALtXUNEcbZsMGSPROZWd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZFSERYcGRJZVhXMEJOdXVkbnZHR2FKN2IvUW0wNzFja2ZsS3l3OUZwRXBM?=
 =?utf-8?B?YnFxYW92WWlYS3VuTFgxdmM4VDZDNmRUYUZtcWVXVHBrU3lYZEE2RG42Wjk3?=
 =?utf-8?B?WFRmV04yQm8yMHpEVHk1OGtpMDZRVk5XalhuR2tlWDVoNXY3WEthZ2dmZEFP?=
 =?utf-8?B?aG9PQUhxbEJ2ZWJIZHVPOWZzYUtCRit0QUNjdkpWaWIzTjdzSzN5MG1tMnFY?=
 =?utf-8?B?UzBOQzNwamVGaHBCUE5EalJHVElZMFBDYjNMOGtRQVdrNWRvak1ybVFxYzBF?=
 =?utf-8?B?M3lVcmJER2ptU2NZZ1BpU2ZHT2VGTjN0ekZwYUxJUWtnb3RzR25VSWpFeTNP?=
 =?utf-8?B?cytPUldqODBvVWRQSmFhZ3lZVkwrZHlaYnByaFhkYTIvMERadlp2MGtCWU5S?=
 =?utf-8?B?akxDRDdpZ2ZKemtDNVVMSWx6MksvajhWeGpMcmd2TFIzZ0pWRVJqWEhsdUdP?=
 =?utf-8?B?K3lMVjlzSTBnMEk3Z3pqTW9kT3RTQmdxeEd6NExSQlFjNDU0Zld6T0NpL00v?=
 =?utf-8?B?S0poV1FWZGovUmNKUk14bFhCU2xicHZoNWdRb1ZVWTdNVGFZR1dhZ3pUWEVv?=
 =?utf-8?B?SVR0cmU4Yko1OVhzNHRNdERwQ2wzekpTbTRKaEtUYkRJcndnNjAweGlWWUQ5?=
 =?utf-8?B?Vm1vQjU0V3RzR3BzUGE5R01WV2o5NGNRTDk4aWV0c2JST05MMGQxYWdiT3Fs?=
 =?utf-8?B?eWIyb2dQU1ZjNnY0YVdKWUpMZlpFYTRpRE5rTUMzWjY1WWhmUzJNSTJMSmRm?=
 =?utf-8?B?T0E0c1lpMmJkNlBuQWZ5dThtMlVWbjdjWmVISkNPRmR5a2xiUUQ0QnhJQ0pP?=
 =?utf-8?B?dDErZ2JaMGxBVWRlb01laFc1WFFHdlpDeUVmZ1NSVG1aT01nNVRPSUxRYUhl?=
 =?utf-8?B?R08vQ20zNE13d0E5QU12WXROeXdFdzF0TG1LTkZybzh3b1EraWNmT0lkdUtR?=
 =?utf-8?B?d1Q1UWlaMUxVZVZXVllZdzFJei9MNG96SGl3d2xiZTlYZTBJeWFUUC9xeWE1?=
 =?utf-8?B?L3BhaHdLajFsR3dFdVRJNW5xZVd1NjBDQWV3c29OaXMzbm1JSDQwWVllcXZC?=
 =?utf-8?B?aHV4N3duTmRTaFU3UG1IZStDMjN4aHhERmVwTmpNckY1VGRzaUxRcjl3NkxH?=
 =?utf-8?B?Ym1SaGFQbnVtVmRvQXUrQXhMSjBNb1RualE1TEh2Yk5QMVdmNys1OGg0WUJG?=
 =?utf-8?B?K2VVaEJGMUljRFFKeUJreDZ3eDh1emxZMlVEYUo3NmpaczZlMURreEVzcDhN?=
 =?utf-8?B?cXhIVXNYbitNRVllTHJzU0NVUWFQT09xRHBpQ3lQKzlmYjY3NXAzWStrT2tO?=
 =?utf-8?B?YWo0U3p1K1FwTWx5YTAwWWVJSHE0RE1LTnFIZTVGMk5acTRpWXQySGNsTFFr?=
 =?utf-8?B?bC85elJIOU56ZUpVNHAxQkxHWHJyVEhqUUVNSytDN3hDdjM5QUlJZElzKzI1?=
 =?utf-8?B?MkNPTjcyS3ZTbkdsSytzUjZYVVArdmFmMFF2YUFkemNoMWtoTFJOenhRckJp?=
 =?utf-8?B?WHlaL3phV3VKWHNJNm1Xc2QxcEx1QWUvY3p4MFc3aTZkT0tNM0FHVHQ1c0FO?=
 =?utf-8?B?UWE2azRTM3BvVUIyU3N1Q3ZTQ3FvdTNCNklFL05XeXFtWDBsYW9CNlNHRFBw?=
 =?utf-8?B?NTA3eDh2Qm91U011TWhsQjRucWhOZkdzVUxDaC9FSVZ5Mkx4SXlvQUxINHQx?=
 =?utf-8?B?ZUJFVjZ4U2w3TVpuSnFMNlBhUDBDVjhlUlRXUUs4QmVGSEN1dWpId2dabng2?=
 =?utf-8?B?ZTlXNU5wU3A5R3dQRkVVTnFrREFtV09FZDUyb3V0eUMzZzJNSU9oQk5TZVlT?=
 =?utf-8?B?b3FJVjMzZkE3VFdrVzlKZnR3UmFwRXhuOUU3dHRqaXhRWWNYVktIbEs4MXlr?=
 =?utf-8?B?TmFYcEtFUjA1Y1k1TE5UUVVtVTF5T0J0SFVEL1BWTHNOOTNRN0taWXFCU0tv?=
 =?utf-8?B?WXJwT1FmK1hsQlBSemI3SFpuazg1YWVMTTZJZE85UXk3aXpIZVlpMTV0SDg3?=
 =?utf-8?B?WGovZ0dkcytaM0hJaXJQckQ0Yi95dmV6RDNsYTdwcGVrdTlyTXRkUFNMTkUx?=
 =?utf-8?B?blMrc0FDN0cyc2UzR1FTSW9ycGJQbTRXUnJ4QTJQc25ZQ0lIakE0SzZhRXJ0?=
 =?utf-8?B?VXhIYWxueHFnRTEwaUhaakppelREckNsUmd2cWgrbVZwRGFDQ2hzVkR4UWJL?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1251563e-c646-4dda-b8fc-08de3e1dc6b1
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 10:11:14.3402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/xl3BJxWl7GAYt6l5HD+EsOjvJ0/C9YhRIYuhkj7bjyntzytj0HVh1BHio6FeQFziSLCqt7rbQwk6PlmGN5XNLOLRYBIXUgM60/m3/Xa8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9478
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

Hi all,

On 12/17/25 5:23 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Document the bdinfo -a, -e and -m options in the long help, but only
> when they can be used. The string concatenation is a bit odd with two
> newlines, but it does render properly once in U-Boot CLI.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

This now fails the unit test in test/cmd/bdinfo.c wrt help text content, 
working on a fix and will send a v2 later today.

Cheers,
Quentin
