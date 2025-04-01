Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A12C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C91AF81FC8;
	Tue,  1 Apr 2025 14:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XRecJF9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0B381EDD; Tue,  1 Apr 2025 14:42:37 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F0CB81EDD
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 14:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1+GzNQTL0ztaMqvKLIfSmzaIOOhtNmoBOl9lqbeFr8xiUQMMlKyD1oL+oT6anPF5bN7Gxe3VDoiszVTgjAHdquBntdF1W3cGM7zJlZNr14H3N79mQGRYHxEYMnAwax2nPZX2s8vP9LHEQCdomA3ow2Tu1Fd3bIIrSbgtEeVsTDeLoLXhZuEJyvnyC+ZaLFKxagVZ7NQ4FB4Gpi8Xt88DmxNNMgyw94lu65ls0+bx/ULWwNYIrCeUbVdWVq1ZGOmLsz0GET7mHd//jvIs06kHyd1sEeSZXgGeWbRVIySfeh9DSd0IIp4xnBnc2fRrFdoflduSp1Rtt2D5c7nks1IdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tktnxHHOfRBmqqj69Wklpnf0nxueobO+hG7rXg8aqSk=;
 b=QrwgwrFFqj/KpgHFC1sdZ5HnQibd5Cn+/5Eys1a2ejDg7NhMAR/qNixYnX9iqwEa7soH/kFLYwil94oO13gyZ5YsPTuCqroNpMS7QlMlcnmZZjtIQiCCE4Kx8TxfO64eZmTx/QWJ/HsmWEEPGXEXU6gFC5y3MhUuH50OzqCZMh6A4nkt1NPF2Ysvj/7reZ5XCDXfug00bo1rPifi091Kp1ChAuhJ8BcIwrD1TNRkNSu1DAHPZhTneYy6bkFr8OKPlXmvuufMpYU6jpuQp0QdRgedDi0xbc/RQHwUnWFRqzU7MKzaUd8Ni6Q2othTo3NBNcAcrxZqE8tEEZqziayaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tktnxHHOfRBmqqj69Wklpnf0nxueobO+hG7rXg8aqSk=;
 b=XRecJF9Fn7JjovaHoflqFtET0+CdPdjcDwaKVBBQSbm/nRmkA4UWq+UCvhn560LrmMyEEvG/SjVr3wmSLv5r+RO5f5gAi/hQiyz7kbIIIPB3dPLAcLPVaPUvV18vaZnv29s4Ccf6X0b9K7+deG1jFG2vPtTs5JOC9kWXzcwtB2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 12:42:33 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.052; Tue, 1 Apr 2025
 12:42:33 +0000
Message-ID: <8f9ded9b-11f8-4347-bd09-01d36183065d@cherry.de>
Date: Tue, 1 Apr 2025 14:42:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc: build: docker: Use code-block for syntax
 highlighting
To: Leonard Anderweit <l.anderweit@phytec.de>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, upstream@lists.phytec.de
References: <20250401122811.14806-1-l.anderweit@phytec.de>
 <20250401122811.14806-2-l.anderweit@phytec.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250401122811.14806-2-l.anderweit@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7546db-5374-44dd-90a9-08dd711aac68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXBYamk0RWxGS0tjbHd3UnU4OUMvN1lyZTRJSXMxYmlLUkRvSk00M29GK3pX?=
 =?utf-8?B?OWRQYTZXdlF2L3RhNWtFNEhjM0xmYXVweUo5N09yb3FUTFY4anhWV2FaRTlu?=
 =?utf-8?B?MnVVbjhHbzlwTC82QStlV0dBYXp6UFQ1ZFdWbTFpbDA0bXBCOEF2ajd2ZFVH?=
 =?utf-8?B?c0Npa1Ayazd1ZmtJOTdxUU1ONTlaVkNocHpLR0hzR204cXNNY2dLYXFXVGxn?=
 =?utf-8?B?UlE1NXZvWEhvbkFzMkd4R0pwWE03bnNMeU9sQjFLWDQ3eW0zeGIvRnJmbXBD?=
 =?utf-8?B?Rnpma2RlRkRlcUtyMDZCM1p1UEIzRTdYUkxkRklCRHVIWXUraEJBcXlpMDgr?=
 =?utf-8?B?MDcvaCtySDE3VGhSblV1YTUybEc1UlNNWmVYNlI1Sk0zZFVKTm9JZlV0ZVZn?=
 =?utf-8?B?ZkpMNGhIaThXbkdQVE55RnFnQWRxWDlEenQ1MEVKU0dhUnVoV3orWVowd1R2?=
 =?utf-8?B?dFdWK25MOXpBQmhYRDhTU05Gb2pLcGVEd0R3ZnZEOEtXNEtXd3k2ZGxBcEFq?=
 =?utf-8?B?bVZqZEVDdU1IUWlwZE5PQ0ZQaG9GeFUzTnBoVHp0M3BrVC9DU3ZWV25QZFJh?=
 =?utf-8?B?aEo0U0dRWU0vQTdvTEtxVTJOYUNxQjVNRnRZN1ZjY3JkVmx1aUNyTnlEcE42?=
 =?utf-8?B?aUxsaTdGWG15bjloV1J0NUhBZ3BqSTljblJxVDJvSi9DYko0SkFyQlN1em5X?=
 =?utf-8?B?eHVVem5nMWVYZlVySXRVbVlUYTN2ZU5MTFlja0s3cXFzTUpuaU9CSVdRMXds?=
 =?utf-8?B?Z1g2TXYvUlI0MjBuTG13R0c3TjMzeDRNM1VzTWxGL1hMQ0FQdWtERXZXV01X?=
 =?utf-8?B?dkk3WCtRTUYrY2hEVmVtbHY4L3JMTHB6Q1ViWWRMOFJHdURUcUMrVlNHQ3hY?=
 =?utf-8?B?MGpKaDJaTzJ3ekpONStlY1EwZms2QWJtK1BGNWZkNzNoWGZySFJVQldvT3ds?=
 =?utf-8?B?VjlJdzdhNDMxRWVVbStkeElReW9CQUhsUktHTEJVKzJLVUtRbTBCSTdFalda?=
 =?utf-8?B?a0xrVkhsV1dsemc4TnJEUHU4VCtXajdaVEx6WWRKc1BBT3NhbEVpQ3ozYmJm?=
 =?utf-8?B?b2pGSXB3WUptakdVRGZxdEpDYlRFMEszV1ZWamJOcHl1T1FLdWt2UEtNTCtN?=
 =?utf-8?B?T1l4T01FQUVBdFVieDBjSTZSS1RycFRmK2puK2hXdDQ1dVZ2WWR1U1E3RTRQ?=
 =?utf-8?B?bmViV1luYUs3VDJ1NFc1QkR2VnMydW5teEl2aldtcmRKVmo5ZlNJNFRBYVJw?=
 =?utf-8?B?V0Q2ZXVibEZHbC9Zdm0xeTFkR2lpYjA5U2ZDeFlEeE9vNENBTUJRd3RQQVFS?=
 =?utf-8?B?eFJSTEFEUUNnbVNLWlB3T1NDeEVwdUVMQ2RzYyt3Smlub0JBemN1dkRCVmI0?=
 =?utf-8?B?OFAwTFJpMXZodEMxa0UwMCthMDRmb1hhb3lsOGkzbi8rTmNxa0ZFY25pdHp5?=
 =?utf-8?B?bjA3cVNOUDZ0UjZYU3NlN3N1TE5JMGhQYk1FVGUvSlo5eWMvTTMxeXRybGp3?=
 =?utf-8?B?dWtrL3JoT2xmdmRid25PbHd6OS82M1p6aXdtTXNuTi8wSCt3V0wvMFBjcDhX?=
 =?utf-8?B?TURKd21EZmFBcEJwT1U4Vnp1bzQ2S09LdnAzOTRUdk9XeEtxbzhxMURUbTZs?=
 =?utf-8?B?VTRVdDhlSHowRjdaalF0R2I5WHRrWlRMUitGSzBEcEtIa0p2UXBoZnFCSklV?=
 =?utf-8?B?UkJvNUljcHFhWUhYaVZJUU1qYXVsWWh4ZHNuWkM4OHZZZ0xYSnI4dE9yRFlZ?=
 =?utf-8?B?aDkxdmRvRGk2bUY4d05ScnVXU291RkRoZE5BaDE0TWRJaHI5cGRiQjNwVGNu?=
 =?utf-8?B?aDhRUVh1c3MwUnk3aEVKeUFFSS9lUmY4bVpoQ3Nha3JGWXMzV0pRSldwZVZk?=
 =?utf-8?Q?UnNEJy1TTN/lF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ovZlpBK0I1QUhtb2hHNjlYSU5XeWVHWDIxUld0N21vMTB3NyszQjQ4VFZZ?=
 =?utf-8?B?SlN1dVhPZ3IrVmxvdjJnYnVxYlE1d25IRVc2WnJIOUtVd1lsTU5uRWk4dFZ4?=
 =?utf-8?B?UUJPR1VTSStqUENyL0pGck1QOU9zSTJ6STdES1dmbWNIczZ5Q0IxWWtWNlVP?=
 =?utf-8?B?cnRXMmtJbUp6dTRMd0tSTkxoR1owajZQVm1UL0ZyOURYTXZhZmRhU2VxdjJT?=
 =?utf-8?B?eTlBSTVQNnl1cDNXL0lobmM0eXI2NGI3VDBRanN4NW9MMDUrVVc1alNtSHRT?=
 =?utf-8?B?a2IwMFpUUi9RRDVwTGZxdzQwYTZrOFVZOWx6VEM1TnpkK245a2ErUXlVbG51?=
 =?utf-8?B?M0hWbkpmZ1JtQ3hwWXQzQ3ZPdXJTYm9nRmhmVjVIMUFKS0I1bmc1WDZheUF3?=
 =?utf-8?B?R3NQRHJoSkVYQWw3WURxZXJORTMrZ2cyWEtMSWVHMWh0VTdJZ2RMVWJhZWRY?=
 =?utf-8?B?ODE1eGlua0Rxc05lZnZmakd5Y0QxREpZZi9BdXVJUzN4eWw1ejFEeFZjNm1C?=
 =?utf-8?B?dWhYRXVqZDVVcGxyY3FDcEpLQ3lGK3U2UHZyTThPMm5jUmQ0K1pKNGpUQnJL?=
 =?utf-8?B?Y3ZtMjFjN2lNRjVQaTNuQjRrbXgrWWRsSUhCQ0t6S3ZkbDRUT0xqYW1xN2x3?=
 =?utf-8?B?TlZmTVM3UWlQVHBVdXcyamdHVmcvejZtTE5EUWs1WGxuOXFVR2JTREE3Q1lG?=
 =?utf-8?B?NTM4RnhtM0FvYnpPdXpvQk1sbGhJZDdKVEt2WkNxSmFlQmdqcXNjQTVzRFUw?=
 =?utf-8?B?b2UwOUhueUNMaTNJNkVRdDJJWkRTbWxDTlc2aTVLZyt2dEVBcG10VVZ5M29a?=
 =?utf-8?B?RG54RVFzY1Y4WEVicklmZThSZVhyVTVVQ0dpbTRER2xYM3FTQzE1aVZJWWtZ?=
 =?utf-8?B?bjl2Q0F2U3h4Y3FTSmJ1NFJtUjBnSWE3dXBjeHo5Q0ZaSUFpejVNVFpzYnh6?=
 =?utf-8?B?N3Z0dFBhMndHQ1hMTnZCQWpHcHBmTFV2M3hyQ0FnY1drZ3lZQ1lickRtRk5H?=
 =?utf-8?B?YlorbEZVd0dXUVpxdEw2eGc0Vml5YUNCZWl1SjBOVC9JQS9pR2NPa04yRkxm?=
 =?utf-8?B?REVjSUpFb3BtdGJsajU0UStjUnBlc0VvbHU4Rm1BWCtSTEx4bEF1ckRrenNk?=
 =?utf-8?B?TEpualEwejZMOGorRi8vb0Vac09jRlU4NDZtVTVPNm9vTldqZjkyNUExYU01?=
 =?utf-8?B?TVg4U0NpbzJRRmxLa2dmNTYzTXh6S2N6Y0grcUFubzM1L2Nvc09aMWVGTVFh?=
 =?utf-8?B?eXRiWTRjRHJnN3ZOMEFISU9QK3R1bDBQbnp6d21HMHRmMzJmYmR5WFg4c3N0?=
 =?utf-8?B?aGlVOU05ditmbTFOamR5Vm1qUGlreTZaQTFZNzRTbXBPMGs4aWQ5VGxTcnRD?=
 =?utf-8?B?YjJURFlnVUNqR3VhWmd5TU1xUk5KUktVeWFlUG1IL3hwY2h1eVg4eHdwcUZj?=
 =?utf-8?B?NTVucjA3Q3ZsZjROZFVRMFA4K01MR1lzZHZsTVQ1Nktxb05uTnM5M0pXZGxU?=
 =?utf-8?B?RWQ4SEFzQUtmV3pOOFFMZ1NTSi92Rks1YXJJL3RTT1ZlODBJUGttUmxjTHRS?=
 =?utf-8?B?cjh3VCtybGhzeDVUL09KdUNCKzExMVZQMGMvbWc3Ym9sbFVuWU1hcHRZQm9S?=
 =?utf-8?B?alRpUTdXYktDbWpXMlYwVU1GTlJiRm9wYlRZYUp5S1BkTmJpcmJJb1FFRGVR?=
 =?utf-8?B?NjUyd2VIU1pTaUs3VmhsQkJBMXJZeHNkdHVXZTVWS0Zac2xLRHBWZldJdGJu?=
 =?utf-8?B?QnhpTXVFNER3SmNSMVBQSlRqTGUveTVXWlI4eFRtcnFSVzROSENhd2R2Yi91?=
 =?utf-8?B?ZFM3c1FDbEdJUmxqTVdUbjZNVlYxbFNSa1M4aUFBNGNnMFRyN3JOT1ZlVExV?=
 =?utf-8?B?d1I2MlJmZUVQSi9ySHAyN3VlUXZjOWhoTVVOOFp0dHVvaFd1enMrV29HTXFR?=
 =?utf-8?B?N0kyWUIrM0MrbVBpVUp6T2V5RSsxS2Uxb3ZlaVFlY1J0Q0w4cVg2ckhYdnVj?=
 =?utf-8?B?OFhMMUxiN3lOK0Q2VkorRmZiVmtsOW5odXFnWk9XdUYzSGRES3o2YWVnM0ZS?=
 =?utf-8?B?VlJmSDJ4SUUycnhXbnY1VktoSEdoQmFSc0ludzFiM3JleUVkdXROYjNPTWYx?=
 =?utf-8?B?bXVQa0FrUWJmdGZjTkJxejN3WWNUU0FXdXMySXJTWEJSZjE4UW9EajJZTWFE?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7546db-5374-44dd-90a9-08dd711aac68
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 12:42:33.3628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhZJ3MpEkyreRqYNU7nzpp1te0hNb6PdyTV7i8Pb9rZzYwJTN2/1w+MtkN9J/gkEgj5Qcw4h9L5bxEo3OFrTiONGMw8lDoPX66ihITLk3Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070
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

Hi Leonard,

On 4/1/25 2:28 PM, Leonard Anderweit wrote:
> Use ..code-block:: syntax highlighting instead of :: so all bash
> commands use the same syntax highlighting.
> 
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
