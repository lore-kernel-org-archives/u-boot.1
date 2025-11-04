Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334CDCCFA00
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 09:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F1483946;
	Tue,  4 Nov 2025 10:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kiJOjqDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5293183952; Tue,  4 Nov 2025 10:36:27 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C47383942
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 10:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNXy/fjKZWxLXXKySdYPcgS+8kJRK0l4htygAyaC+tQBhKoH9qxpv2i66qx6Bzbfm/smZTJtUuxnoAk1royUAXOK1YyZmMEv0cv4uxDQTPtGtotFjXGGTAjSMwvtHQhjDxbqOyyWXNIlZ26LuNKNn+cSNVWmzyJ5pWBcVS3zrkJ5Y7Kwb5e8bqyR1vxBN42FjEfNf3q5TZjCfoiu8KN42tAGie1vaYONeC2ZyCbuzxQkLg6pe1tJT09Jx3rzEIFLaz7laxKiphJEeeV3anqkY5g2ODyB9rUlW+L/VPUm5QbLy1VjpjBPfnS3dLONuKZDKwWVwzhZCKGXBASSIDZtKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGZIwly/JuKfscE2M2VdPNL8ZoLawuIFn1w8tec9FR0=;
 b=JSQVlaZ9k4aDeP/kYGm5zODeyJG8+MXq8clNO2g1nEcoSK8AW8JNRg7j4MuWSk6ojVMEEAUuS/bbdc7nRAdUPn18WBhiGGV/BhXfLhipi2u+8ll6qtWiq5PVNCzyeR0VDvwey63HI4/TwHe5n6TL7t/jt198L9VIMBCtqsky6C9Ctu5jBWlmyB7oNOqLEAKPRXO79UhOAwbHhGrsGA+ZmUMk8ydMaR4HtlmiD3oecf9Ki2rwrZ/H+7rCxayweURlBqzcMY70wRbw1oersno1i08A5xom7suoAzRZI8zFeAimfVE2nRsYDN+jlj7eJqwW8bfjGgr7uecCumdekxzDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGZIwly/JuKfscE2M2VdPNL8ZoLawuIFn1w8tec9FR0=;
 b=kiJOjqDoxSPcBsEoBkSubEK3ieKQX6NSrxj3s3/m7zSEPoFVWHS8tzWsyV1wKDhzEpz90X2RSEDnGesghTknNmN4Ee8DgbYfEKYEDoGh6AsAWpP4GQ1FoTLRvwVtluiMHwgD/fU+FNRuJngZIlktZY5eZvyYNd/TGE6yRJxKfNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10045.eurprd04.prod.outlook.com (2603:10a6:150:11a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 09:36:19 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 09:36:19 +0000
Message-ID: <e52a25b4-d5bd-443f-8647-a62ef356b19f@cherry.de>
Date: Tue, 4 Nov 2025 10:36:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cmd/part.c: implement "part name" subcommand
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20251020121100.1742812-1-ravi@prevas.dk>
 <20251020121100.1742812-3-ravi@prevas.dk>
 <fc2149cf-97ee-4ac4-ada3-c4797607a5ec@cherry.de> <87tszadf7t.fsf@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87tszadf7t.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10045:EE_
X-MS-Office365-Filtering-Correlation-Id: 00745eec-f03f-4f56-5315-08de1b859b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUVjVlkrb1h5aGFzdXBIVm1EaTVtSzdoWHdlSDd1MEpxbWdKc21vQXpTNWln?=
 =?utf-8?B?YzNzQklPUFMzQzVYUWlOaVc0RVl5YmY4VW9lcWxMNE9qTkpLUm1nUk43enFT?=
 =?utf-8?B?QVZsazB4TEdpZmYvQkp4bGd4bTlmVTFGVEdpWWZqVU1qOHBERzFjSDRmTm85?=
 =?utf-8?B?Q3pRMjlmbmRobzdPV2VUUi9qSGJIV2RvVS9EbWFYQVRSMDZKRWFQZkRFK2Nw?=
 =?utf-8?B?bGRiaFdoa0cvempMN3BKdjNWY2E1STNXQm5Ia0NjQzJmT2dQZUJIQ1E0S09i?=
 =?utf-8?B?UTV3WVRRU3FCR1ljYXJnT3JPVmFHL1EyTEM2eFlKMFVRazNZQ1UyRVVqZVkx?=
 =?utf-8?B?SGNHSnhsMkRmMGwrVGJoMkRrbkkwMEp4M09hMUNJbkVLMzJTclI1Lzg1Z1Fp?=
 =?utf-8?B?ZVM3YmVzNE03QVg4R1U3Rk02c2crOFl4NnMxUGhBMjg4VGN5alV3OGFMREdI?=
 =?utf-8?B?bEdZQTFaL0RFYlJCczcxNlkwSG80bVROWW5yRHR1ZG56TjVXalUxUWpYc2k1?=
 =?utf-8?B?eVJkeEpkSFhLWmsxbnNER1hKOVZreUI5ZyswN0YyU0xWemJtcytxZU8vNjV5?=
 =?utf-8?B?VlRFQ3kvNmVuSzJEWitGanlYZ2lBcUt4WmIyaGZLYTBEWWkwaEdTT3FQU2k4?=
 =?utf-8?B?SHJkTTlhMUtpck1PZStnc3p3eEJ0REg5QU9OVGNZcGpXaXNmQTg1UWYwYXFH?=
 =?utf-8?B?NUVjemlDVWZjbWlYeUF5T1hxSHg4ZUFEK0ZSU3pYSXpibEhKQmlneTJzT2hZ?=
 =?utf-8?B?Ym1nUU15a055dHNoeUQ4b2lkc0ZvYXhUNkJJSmtaR3Q1akNHU0hsVHpTVkdy?=
 =?utf-8?B?RVh2ZnVkYW1VVG1zTGFwYW15c05pTmM5bDJyT1B5TDlrYW5ra21mRU41UlA0?=
 =?utf-8?B?c2xxZ1hnV254L0xZbDIxRUZmMS9oMytrL2tldG9tQk5QR2xYM1FpdHVwY2J1?=
 =?utf-8?B?M3dCTW9zQVFhakRNUTJmWUwxdDFKZHFpWU9zby9UZHA4L2V1LzdPRmJuaGpS?=
 =?utf-8?B?azlIbnZaeHFJU1VId25NdVdZYkFUUWcvV2lQZS9xVG9NbWV2VWduVVQxVDVy?=
 =?utf-8?B?eTV5MWZXbGJ0akUvTFhITTZXSGZyaUtUa3paV3MrRXk2c25seCtCMWFwa09S?=
 =?utf-8?B?dE9JU2lMdnBpOU1RYlRXZDdSYnRmUFVEQUtkUElwMTNpaU1QV3JHZUVmUi9C?=
 =?utf-8?B?R0tNM1I5L1ZNdUNsQXVqQWtWVFY4djREbitxMlFXM0FOaWtDWTU1UlFzd1hu?=
 =?utf-8?B?dW9pWU5YUTN4bVBxZE1OTFZFaHh2ZG4xRmt4L3I5Y25Ta0JISTBmSVBaU1ZS?=
 =?utf-8?B?b1krWkd0OExhbU14WE1NU0ErMzBRZDBTekVMVkFqbzVtNzBzZW8zUmxvVjdB?=
 =?utf-8?B?MGJ0RDZJaFVoK0VCTzVGQmZ1ZE9lSFpmVDVPc3ROeFNmMFBIaGVwRDhoR2lp?=
 =?utf-8?B?RCttdVdORlgwQWVRVFByc3JBVEZVOS93NUNZNVVLWTBESURWMEprL3NZamlj?=
 =?utf-8?B?SXB3bDhCTkE1VHBsemFlQ0J6WE5Db3NqMUdDSTh3UVpDLy9EVWlqallJVkd4?=
 =?utf-8?B?bmhrTVAyZ2gwWE1XQ2VjSVdBNXVqTU82MHFPVkgweWlNUEw2WmxLNVpGTFl6?=
 =?utf-8?B?OGd2bkpoRFNpZlZ2cU96dW5KYVRwSFZtT3ZZeVUxVjBDc0ZEdmR2ZGxjbjcz?=
 =?utf-8?B?SWJtMTl3N2JoazFSWE5BYkJIdDUydzRWdENrV0R3cWlGYXBSQ1IzelhYeFVr?=
 =?utf-8?B?aW1ZN2R5bDlqaHZRUmhsSUtEMDZNWU0yYlBsejJLRWtuK2lTc056TEJoVHdS?=
 =?utf-8?B?UFRjZ2c2OFdwaUQ0cFpYZXhyZy9zSWtBTWxnUVJSR0xDalE5QklzVlRRNWhj?=
 =?utf-8?B?eHppSFg2Q1pRNHVTTTNzNmRSeEZIZFNUUzBqSEd4SUVjd2tyYUU3NDFyaE4r?=
 =?utf-8?Q?rV/sN5SjKFOR6cGDR4vXA/2XYBTAA86u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDdFUVlFcWZkQlJrSVkydnVzWW5nYWJsVG1GMVdtMm1yY0FiT09OT09SVXZ0?=
 =?utf-8?B?TWZaS1RBeHoyZ2YrMGlZTTBYU015VENsTVR2VGlONUVodmNUZTJGWldib0FX?=
 =?utf-8?B?NXI2ZzlXanpxalVXVXUzb29yRm80dHh4QWdJL2h4K3NXamZrRmNybGhORUtM?=
 =?utf-8?B?eW0xRStKS1NLRDg3eDBGd1R0NWRiSFNGNEgwK0xpTnNUZmQzSjliUDQ3NlBu?=
 =?utf-8?B?bVhZTEc1dGU2MTdmZENyaC9FdCtLemVjdlZOT244YzMwdGpKdStZcHg3dXcy?=
 =?utf-8?B?akg3TUtvU25kRkpLd2lmbmNGWklXcG1uaXNSM2JZWXN1MWlSYW5BZWg3SmNN?=
 =?utf-8?B?akRLaCtzK3F6dEhXdXJITmRzaS9MZzBremFidHFBZk96eHo2RVZIMFFBekp4?=
 =?utf-8?B?UjJBTXVUNWtYMzVzdFlmV01mU0RVQllBTFZGMWhqcDl1cDVaYWtGSG1CTDMz?=
 =?utf-8?B?ZWJpSFF0L1BQQ25zZGdKV2pMcHZmOHd6NWtYSlhyeUJsN2lPSXJBU2Z0THA1?=
 =?utf-8?B?WUh2UFplZm9aMWIwaDJmaFlEeXdraGRnNzg0RnkwLzg4OHV6andnOFBsQmdX?=
 =?utf-8?B?amNVeVQ0dFRxSFpkSGF2MDRTVzlYRzN3Um9YQUVHaFF4TmZmcjlHcDhzMUov?=
 =?utf-8?B?RWdZd3U5TXQ3VFVqRDduYlh5bU4xVjdVaURmU3lsaXBVTkpRenJrUUo3c09h?=
 =?utf-8?B?NS9XcWR0QVdGaFlJR3Z3UFh4UURIM3NkNHJyWGhrWUl3Y0ZkZHVrdER0OTdu?=
 =?utf-8?B?RmV4ZUcydXpXMVZUTDRNTTVNTDE3SjJvQ3FobGdIY1Roenpua3k2bDlSWSt1?=
 =?utf-8?B?azA5c1M1dzBzOHUrNENJZ3YxaGRjVVU3WG0xL3BiN3ZlcFVrN3Z6b29WWmNw?=
 =?utf-8?B?NHJEMEdGS1pEN0k5MnNqYTVNS3k2RTAvYnA2a2xsMXcxZFpPV21rUlJmK0xo?=
 =?utf-8?B?NG9EYWZjSnZjeno2SVpSZmxtYWdGQWVjbk5YQ3hjZ1ExUFQrckhJSFgvdDA2?=
 =?utf-8?B?cDIxNW5GNU1vc0NzRjFVNGZ6UWNKY3NGeGVHdGZ3TW8rWUZxMDRTMzNBd2Q1?=
 =?utf-8?B?bTNKdi83TExZR3o3Q2lZQ2xPb2IyNHJHK050QTk0VkZITFFQcERRTnhlVDNE?=
 =?utf-8?B?ZzNNZnNTZ2RJWjQzbHpLR3ZxVi9GeWVsUG1hSXcyaDh3VFZwSEd0aUJZQ2dR?=
 =?utf-8?B?RVpFYk9ENmo1cUJqNExuOFRyeDJ1YXdjU3FPZThYOHVid3d5L0lodVFLTldp?=
 =?utf-8?B?Zk9HN0ZzQ29ncjdZKyt2blBmT0RNZzNhKy9XcktZcnpRcDhVSVpjalhRYzZS?=
 =?utf-8?B?TmlXai9qcmgxalovNWM1b05RRHZsWnBpQnhrZXlLMHBvRFpTdXNRYmxmRVEr?=
 =?utf-8?B?UGlJaHpxQ3FSZEc3N1ljUWRUalJqSXdUZjBoZkw5VlJEYVVDN0VuaXIyTTEz?=
 =?utf-8?B?TGFhbStNdG8rTWkvRTF6RStDdnE5Nmw4RTk4T2lIRnlvNWkyV0R2RldNVDdw?=
 =?utf-8?B?d1dJZWZvQUU2VXFtQ205SWx1aHh4b1Y1cXliTXU4a1E3Y25nYkJVUXhsTG1a?=
 =?utf-8?B?VlN3ai8rU0ZyYUdDd09QLzNBdnczMzVMdzZGSTZuVTJkRzdrYTMxTTN4QTdi?=
 =?utf-8?B?a3M5ZW9VZTNQRTI3TFMySnNxZHA3WFp6KzZWWnpQSHFVSUZIUWRBT2YwTks0?=
 =?utf-8?B?aGJEa01JSjUyN1VqczNGNEhUQXNyaWViRXZmQ2JWa3UxZkdQbEx3bG9vaFM1?=
 =?utf-8?B?R2Q0bGVRZ0x6TlZ0a0R4YWEyd1pHMFlXSU9BMTFqYVRmdXdURVcyNGs0bFp6?=
 =?utf-8?B?WEgxbzBqaHBUS3FHYXJ6c1V0azR3bllhdDNJN3BIQkswT3Yxa004SWU0OGZC?=
 =?utf-8?B?NTlsSHVSUzRWVlo4cVNYeTZTUFd4eitDLzdiVkxuWVl4Y0tJVy85MlFNZmR3?=
 =?utf-8?B?MGd1aVY4RDhHOXJQZTZ6S21XaW8xc1pmbFVLSXUvQWVpZVVHL1hoM3pzVlRN?=
 =?utf-8?B?SlluWFZ1TGF5eUpwQU1ZWHNFcWV4SFpnRmw0Zkx0RVdKeU8yUzUxRFpsU2tk?=
 =?utf-8?B?K3RtSktxNDBIbEh1UnFCVHR0OUFicnhXeTE5QWtMMERFVXZQR01IcHErU1VQ?=
 =?utf-8?B?UFNweHpKTlBoV04vRFBHdEV1K0tBTzFxYUE4YmNFRW1JZE9xT0ttcnQwT2dS?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 00745eec-f03f-4f56-5315-08de1b859b78
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 09:36:19.5551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zymsr5O8pktL64n8FccLlDEH55eTDRVj3nunyW5wH/Rm8Fw7iSXhIq3JMMejrDM3hdz/4kHJ9dWxLafZgjUpKtnp8Y9+yY3JYmCX2ToeGMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10045
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

Hi Rasmus,

On 11/3/25 9:38 PM, Rasmus Villemoes wrote:
> On Mon, Nov 03 2025, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
>> Hi Rasmus,
>>
>> On 10/20/25 2:11 PM, Rasmus Villemoes wrote:
>>> This is a natural buddy to the existing "part number", allowing one to
>>> get the partition name for a given partition number.
>>>
>>
>> Acked-by: Quentin Schuloz <quentin.schulz@cherry.de>
>>
Can't even type my own (short) name without typo :(

>>
>> Reading the code, it seems the part command tries to auto-detect the
>> base of the part number as passed by the user, which isn't that usual
>> I believe in U-Boot (usually either forced hex or dec?), so maybe it's
>> worth mentioning in the docs.
> 
> Fun story: I started doing this because I have a legacy stand-alone app
> which is involved in the bootflow, and it communicates the partition to
> load the kernel from by setting an env variable via
> 
>    sprintf(buf, "%d", kernel_part);
>    env_set("kernel_part", buf);
> 
> and on the U-Boot side, that $kernel_part is/was used with various "read
> mmc ..." or "mmc read ..." commands. Guess how well that works when
> kernel_part ends up being >= 10 and the U-Boot commands unconditionally
> interprets the partition argument as hex...
> 
> So what I wanted to do on the U-Boot side is to translate that
> $kernel_part into a name ASAP and then use that name exclusively, and
> for that the sane semantics of the "part" command came in handy. Except
> it lacked the ability to do the translation.
> 
> As for the "[not] that usual", `git grep strto -- cmd/` says that the
> base argument can be 0, 10 or 16 depending on the phase of the moon -
> it's a constant source of pain to figure out how numeric arguments
> to commands will be interpreted.
> 

Yeah, and I vaguely remember being upset by the same lack of consistency 
for printing numbers.

I share the pain. But that's API so cannot change it without breaking 
stuff :/

Quentin
