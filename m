Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB0BC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 09:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE31881AD;
	Mon, 13 May 2024 11:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="VOJ6Zkkn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A3588815E; Mon, 13 May 2024 11:45:08 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6442881AD
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 11:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSSS//qhf7gmHAATxMTR3cuY4Fz6yK5XaGz66nU3mmGVJzzerkLdjIyafrAUDJifuCQjakcW1lqhOWnM6foYcBdzwtFjkGYA5AWZ3Wp8+9/9s4vKRn+b2VpZYrFrY6lOx3o4s3WiPsSRMG9I9RJVkZ8XzocCho7Yj0Ao0EARIf2hIXl4PIEuzFpT0A4AjlDxEQDOiNysuenatEH4nsytLqkr3WDx7f8AGrT0GFW9hJXwkXa/pd1B+OhINrSi2x0wmoYpgBxrdoORZRSjAGB5S3jaMs4H1R76ITqcqWCFydYK1+hkZ/mRlZzjpEfICtiog5b6TbQYN5mP6vVnZBtHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+It1l2zB746KiYF/cmtPK0rm5CzdShrAF2xRbeL+L0=;
 b=Up36eI70Tq1Zg+/XZqbL0tVJR88TkhKTDUReE+knk6YRpJsDr/b+g42N8hdpwMCjhIT3rd4ISM05N+LVt97QYgLQ4j5a6/NmoDEit2rcjga1CzK6TRdUJvV4hSKFPW/5N2DF7+gwqSz3C2DCpNe5LfUYQPzptIjN1rLXdIJvu0qLICOic4wT9uJuXQC7mFpfV9XN81l9Onu+VSZxvhe/zRjAXHdB0ZqR6FD6lw1ASJiINA6KQMyeIoWEJF/YVap7PGlMylF0oP2aUhsSuzWHRCCjNZyc+zubW94bov/4enLuSineEmhFm3rK2l9N716KpfXm7r/LkjIRhvHNGwXsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+It1l2zB746KiYF/cmtPK0rm5CzdShrAF2xRbeL+L0=;
 b=VOJ6ZkknT8nO1PeIMnghYXXRBQWHcBhl6XIswmSzOZc8yWGQlAlJJhhKsejFo1OSFfUU8+OLlv6Zy28rCzvr3w5yvQLufFpHygb7Zbc1qWQlguJ4pHUa7U67NPFrgVfiNVrEQS/Q7s4c5yqkwBsBHu9kB3XjrQmNagMfQe2UOLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GVXPR10MB5934.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:45:02 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 09:45:02 +0000
Message-ID: <0060272e-7086-4dd9-8935-e915f6831387@prevas.dk>
Date: Mon, 13 May 2024 11:45:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: default to zero if int/hex symbol lacks default
 property
To: Yoann Congal <yoann.congal@smile.fr>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Masahiro Yamada <masahiroy@kernel.org>
References: <20240505135353.1507200-1-yoann.congal@smile.fr>
 <20240506174332.GN2568172@bill-the-cat>
 <d7c4aee3-47f3-401e-a66c-642ec5995ad1@smile.fr>
 <20240507172359.GX2568172@bill-the-cat>
 <36f1b695-5974-4c49-b5a7-43655588a994@prevas.dk>
 <7192141a-248b-44cd-8030-3e1a3b30b6ca@smile.fr>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <7192141a-248b-44cd-8030-3e1a3b30b6ca@smile.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GVXPR10MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a8c88b-8bbf-4562-dbdb-08dc73315c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDZOZE9pSHJvMER6cy9xNWhuRXVKV095ZTdHV1hTYnF6Ymk3UjMwWWkvRlYr?=
 =?utf-8?B?b01zT3ZIRTZwNUpSOEFKTHo4ZThjVEI2VUFvajZPRzVwNGk2QllyNldxUzNa?=
 =?utf-8?B?a3RBUm8vbHNKMFRzeklBaGI2OHdzSWIreFVHMzRQZktZLzhHd010aU1CRGhD?=
 =?utf-8?B?N043OVVnRGtsVXMzWkFsSUNwYUNUTWI3ZFRlcUZJSTZxcmVEMndRL2tVZmNM?=
 =?utf-8?B?UllqdGhNbnNCUlRUcjZ3RTBNYVVoZjNldEQzRFNuY1o3czVYcnpsWEhaMG9J?=
 =?utf-8?B?aG81cW5DQWx1SHVrZjlTRkJsWm9lOXFZQjJ6eGdIWERRSXp6ZUJjSkNyL0wz?=
 =?utf-8?B?c3N5OFE4MTgxQlZwR3JJbC9yNjBaZ0V0ZkNQWitkOG9Mc21vak5GOVZEWVV5?=
 =?utf-8?B?TmgvbU5wbzdscktuTitoZDBiRDRmNjhOSW55YnY3YVl3VENZSlBWbGZjMk1v?=
 =?utf-8?B?QU9WdThzNk5ZQjh6UGJGMEpIalp3b3Z0WEI1eG92dE9BeUo2R21lSm9mSFRs?=
 =?utf-8?B?MTNZS1R2TGU3UDRvOXFFakZmT2s4NEljRitTbDZtWGdDVlp2UWZHN1YwZVAw?=
 =?utf-8?B?U2hyVTByTHJHMk1YS3hUdWdDR1BDaDBubm9kMFlTVHVwT2JWVXNMSWgyNXdY?=
 =?utf-8?B?RjRqMkN2QTEwcU5ScGtCOG40WGlzRzdoQTdqbzBocnZVbmd2K29wcGJaOURk?=
 =?utf-8?B?eGpZVjVHTW91eXRBMDlnOFdEMGxpWnNCdGNZQ20xRklVYjNJOVJOT1B3bHNx?=
 =?utf-8?B?ZDd3RklSUHpQb1phQXMxNnF1K0svUE1ZejQvejlTaEg3VGplajloTDYzdU5a?=
 =?utf-8?B?bHNObVhUbTFNUUtPRTFYTWhjZkhjak1rRmJOSm0xVkk4Nkc5by9UczRCK1gz?=
 =?utf-8?B?cXBSUmVLL3BRa0RZdUN2MGJ2WkxxWkFGSFptOFZHVTQwdHQ0bk8zWjdFRGR2?=
 =?utf-8?B?QnJXeENNekhicXdvNEorKzBmaVROWjNnYTJSY0dXMWprODNoWmtmYWR4Tmp4?=
 =?utf-8?B?a09maEdoRHp2Z2pDM0d5YVBXTC9vVVNlVTRoV1R3cGprQTdNQTNBNVBocUty?=
 =?utf-8?B?SVNWOUE2cUMyRnpvUysrV0lQRHZtOTk0aXQvaFNHRS9wVHdhU1JHWUt5ZWI0?=
 =?utf-8?B?SGw4dlhoSXhZR2c3bk9FWUw2UEl0QkFvbWwrbjdpQmNVRG9xdWt6YkJQWDlF?=
 =?utf-8?B?WkQ0QU84Z3djdVMwTXpmZEQ2M0tFZXpJay9zQWJ0VXBIVE54MFpFRG1CN3pG?=
 =?utf-8?B?MDBmVUVrNHVUSUpCZG0xUkxXTy9UY1BDNllwblM2NUU4OTNSd3pXbG5FL3pF?=
 =?utf-8?B?d1dKRFFYS2ZOYlF2OFBOQUdVa3BSTHppU1pva0UreDJwNlM4Rm9pYjdzTXVC?=
 =?utf-8?B?VVhYa1dVTDVlc1dRM3dDV0JXTHcxS3FqeEFLYzdLZzh6L2FoYTczUE1RbXVw?=
 =?utf-8?B?anA0Q3NxMjdRQnZlcnR3cnhXZHljSDFpQnZRRFgvS1kvcHQvUHVMN0MwRjA0?=
 =?utf-8?B?RVQyTTMydnlpK3RVUzNtbjJDUm54ZzI2VzlqODFUZEFRZGV5VG5UTlVHdCs3?=
 =?utf-8?B?TFJCc1J2eENNaFVPdUo5ZGZMSWFVVFdPYkIxRGhDTFhyQWNPUWswTUJNVVZn?=
 =?utf-8?Q?hseOM2UeAeyuzY1oea3pSBwTNOl23M0uehsK99PlVy3g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGdycWRGRG9VdGp5TDlxVEVJZnV6eGNJTWNuMkNaM1hjcnhFeXJlRndhbXgy?=
 =?utf-8?B?ZTBUTmpRK2x1UjQ2V1FGM0ZqcVhYWFRTT3AxcDlyQnpQUjdKNi9IUUhIYjkx?=
 =?utf-8?B?SkpibDVtVjYyWTkrNUNsTytLanVaVlhTTEw3d20raFFyN3A1TlQ4UGxHaFcz?=
 =?utf-8?B?ZEc2TE15TW9JRThXdWtuRmp1NlRWdW1QaE1Sd3ozalo0Nm1lWlVManFFenNJ?=
 =?utf-8?B?U0FvdlkxbWlHZStlZ1QvaXZ0UWI5NGx5VXc1a054bmo4MG5KWDVCMHZOakto?=
 =?utf-8?B?VC9lT0JOMDRHZmpnUkQrL2RPMW52Q01ES2lQQUFjVnl6TlVDZWJUQ28wM3pk?=
 =?utf-8?B?MVBMUjlHNWxLVnFRbytybnpIYzVHQnEvS0kxbnhCNkUxMlRpbXFYZHhiNFU4?=
 =?utf-8?B?RklRaFJJUTJ3T2dpWitwRHphK0p1M21Bbm1Ta2RJcnNJemVQMlhyVnh5K1Br?=
 =?utf-8?B?YU4wNVluT0lzY3hveWRhOGp3Z0JYcnVFeVp2Z25PQTBoSXZQY0VIc2VkQWFR?=
 =?utf-8?B?TmxFSmQ4b2h1bnJQclRmcnByREd2WCtTdUtYWk1VSXI4dS9WN0tGajdQUEpJ?=
 =?utf-8?B?RmNlZ3JaSnBQQ2dMYWJUdlZwV3JBV0ZVQklNWEI3aTloV1JjdVF0TU5EUlJr?=
 =?utf-8?B?ZTZ2eCtJMkNzOGVjWEFSK3g3aXV6Qk0rbG1TWEZHMjdveXFENDc3OExOVEdr?=
 =?utf-8?B?WG9UTnYxSkZFNThwSkRodUpkeHNWWi9wNUpra2Y5U3g0Q0tUOUlBUFpHNkxh?=
 =?utf-8?B?UDZ3bERvSXlvZjdtdjBVajhlUjRPclRhYWpiM215N3V6VThQNFo0d3pJSGdZ?=
 =?utf-8?B?NFozQlRtYlJIYkxDK2xtNmoydWE0M1JVZVpoZTlwRzhYcGJOQ2d2bHlacFVw?=
 =?utf-8?B?TFFzRlF3ZzFkMkJoS1ZsQ2xQdElYRlFZRWQ1ek1ZMzd6czNyKzIyTjBCRUty?=
 =?utf-8?B?ZHBMTjBhaUtUZFA0YkF0aXRIbjdHSlpvR1QxNVc3Y25HOGxnd3A5MzFlZFFw?=
 =?utf-8?B?d2hFZkZ6YzZuZndhTE8wdUI3eTdRWVhxMXlDWEdkcC9waTVIVmZXNUQ4ZGt5?=
 =?utf-8?B?SXdpZlIzcG5FZFV2SFFNYWRKdU1RRXU0MWhxOGxzWHJ3MDhFK3ROcmRHTmZI?=
 =?utf-8?B?bHN6bVpTRzlIZ3RlSjBid3FGbVdCVm9jMGRaa2pwZGVaM0hzMUFCTjNpSVNV?=
 =?utf-8?B?c1FSWGlXTjRUdHhSbHVBaDdGczA4QW82ZEd0MndJZVMvNy82eCtaZDQ4dFFF?=
 =?utf-8?B?bExmZnVWSnZmczFkVDh1T29DeDcxY3Z3MWxVbDVnaEd1UHE1NUU1NTJUOXky?=
 =?utf-8?B?aExyK0x0b0RBTWhZNFRmdUgwTGF0alNQbmdTUGYxd0FDdUhRcWt6dFc5RzZP?=
 =?utf-8?B?RVk0bU9YeStYU3BmUDVrK2FNdktUTWpJZ2RCZytuYXkrZUExQnlRZzh6QzNI?=
 =?utf-8?B?VkYrMis1ZmxERHZRT01vNm9sUkYyczhRM0FZS3RzTjB3bTlUbWpQblcrcXZ3?=
 =?utf-8?B?ZmpUcVNGTURMcllBRUZ0MUMzNFRpUWZQOVFtT2V2d1FlYVh3aDRaYzd3YlpB?=
 =?utf-8?B?NlREKys2UFV6QXpDQU9VUDA4c2ZnWTVPNzlJWW1aS2JOWGx3cDFOSlBXSEV2?=
 =?utf-8?B?cjd4ZG1PdzJyd2pzNkdhSmJva2hTQklsUDZ4M2VaRmxMMDF5ZGdZQmtITE85?=
 =?utf-8?B?Zi9lZDlWUWoyZUNuVlJ4LzBZSWRReE5jVHBmbFJrcUdQb2dBK01RQW8yTzlp?=
 =?utf-8?B?aGpjUDJMMnplVXMva2hxcnZpUVc0bHJWQjI0ejN1Sm5rRko3ZVVBajNES2FW?=
 =?utf-8?B?d1J6bTRoYkRlNERwdVlwdWlGWU8zeUxVYklFUit6cWVSZUdCQWFFSzZqRHlp?=
 =?utf-8?B?b0FhdTY2N0NoV2UyeENUQmo0eDk3RzAyUVJhYUwzeDhJRHBwY2E3WTlVV20v?=
 =?utf-8?B?T3lqZjByV2FUSC9vQXBUWDRHYVJRTG5MUGJqejZENDhQMUo3dkRsQ2RCbjVr?=
 =?utf-8?B?NWVaL1hxMmRRQ2hsTzdOSms5ckJNbHd5dmlOclByMnNXdDB6WmJXZEROWGg3?=
 =?utf-8?B?NVZiTUx4ZFhGZGdDWTd0bVI4bkc5VmZiTUg4Rms2RWgxRlhSd1dYRjB3WEZG?=
 =?utf-8?B?bHgyRllLR0FmTnl6UkRLTjJvZVo3WUhXTFJhR1g4SmJGNjArd0JOYlNmWWhr?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a8c88b-8bbf-4562-dbdb-08dc73315c6c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:45:02.2284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+UQnHKvJ65My79yPv006optQD2iZ298FBnwK2wW1YjVY/9nEQ0YOBPSPOBs/Ioxh17SwQ3/qtdzsReGNRduX1PemGUHVCEOPQxYO67nzIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5934
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

On 13/05/2024 11.03, Yoann Congal wrote:
> 
> 
> Le 13/05/2024 à 10:28, Rasmus Villemoes a écrit :
>> On 07/05/2024 19.23, Tom Rini wrote:
>>> On Tue, May 07, 2024 at 09:17:46AM +0200, Yoann Congal wrote:

>>>> But, my more general use case is the Yocto dev trying to change the U-Boot (or any kconfig based software) config and accidentally trigger this.
>>>> In Yocto, what they will see is a do_configure task taking a very long time but they won't see the looping logs the detect the problem (This is caught later by filing the RAM and the build process is killed by OOM, or the disk run out of space filed multi-GB log files).
>>>>
>>>> I'm sadly aware that defining a default value for this kind of config (fixed addresses) is not really sensible but the build time infinite loop is not good either.
>>>
>>> Exactly, but to me it's worse to cover up the build issue and introduce
>>> a runtime issue instead. Something builds but then crashes at run time
>>> is worse to me than builds fail / get stuck. Using your example,
>>> CMD_PSTORE_MEM_ADDR depends on CMD_PSTORE and so if someone enables
>>> CMD_PSTORE in a config fragment but doesn't define the address, the
>>> build should not complete. Using 0x0 means that oops, now it fails to
>>> work and might not be obvious why either.
>>
>> I agree with Tom. Yes, we've also hit those yocto failures with a
>> multi-GB do_configure log file, and that's pretty annoying when one just
>> starts a build cooking over night and then the next day one's laptop has
>> a filled disk. So clearly there is/was a problem to solve.
>>
>> However, blindly adding a "default default" of 0 is not the right thing
>> to do. It seems much better that, when there's no configured default and
>> kconfig gets EOF when asking the user for input (as in the 'make
>> oldconfig < /dev/null' case), kconfig should exit with an error
>> explicitly saying "no value given for CONFIG_XYZ which also doesn't have
>> a default value". That stops the build, and leaves precisely an
>> indication what the problem is. Then the developer must either provide a
>> value for CONFIG_XYZ in the fragments, or send a patch to add a
>> reasonable default when that is at all possible (not so for e.g. PSTORE).
> 
> 
> Agreed, that was the spirit of my first attempt at a fix[0] which was then made broader[1] and finally rejected from "-next" because it triggered a build failure[2].
> 
> I still think my first approach (exit with an error instead of starting the infinite loop) was the right one (at least for U-Boot). The problem is that this approach was rejected by the Linux kconfig maintainer (Masahiro Yamada CC'd). I'm willing to clean it up for U-boot but this would diverge from linux kconfig... Is that acceptable?
> 
> [0]: https://lore.kernel.org/all/20231031111647.111093-1-yoann.congal@smile.fr/
> [1]: https://lore.kernel.org/all/20231104222715.3967791-1-yoann.congal@smile.fr/
> [2]: https://lore.kernel.org/all/20231107210004.GA2065849@dev-arch.thelio-3990X/

Thanks for the pointers to the previous discussions. I see that we
arrived at more or less the same patch in at least one of your versions.

Masahiro, can you reconsider that "default default". Even if "most
int/hex items" in linux usually have a default, one could still hit
cases where they don't (usually some arch/soc/board specific physical
address, e.g. for an early console, but naturally a bootloader is more
prone to have those kinds of kconfig options). And if it really is not a
problem for linux itself, the "default default" is a no-op for linux,
but does cause unwanted behaviour for downstream users of kconfig.

In
https://lore.kernel.org/lkml/CAK7LNAS8a=8n9r7kQrLTPpKwqXG1d1sd0WjJ8PQhOXHXxnSyNQ@mail.gmail.com/,
which was a reply to a patch almost identical to the one I arrived at,
you said

  It is strange (and consistent) to bail out only for particular types.

[assume you meant inconsistent], but AFAICT, bool/tristate values always
have (and always have had) a default, so this isn't really inconsistent
as the bail out is only applicable to int/hex types (and maybe string?
dunno if they default default to "").

Rasmus

