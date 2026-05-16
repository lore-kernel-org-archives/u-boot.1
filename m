Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79000CD4851
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 03:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF0C8483A;
	Sun, 17 May 2026 05:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="Lt7SsEZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4540584674; Sat, 16 May 2026 23:11:37 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31853845E3
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 23:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4Zl8oyaFmCh6orRcX0zg6/N4XgA1LrAHinzx2bGsY1WZ3Xnu2JDrDOWMu3Jpr9BooMD47mwLwAWTxg2elBSOxZdCtstkP1JRfXBlub4pXCysBdspqAGG/9qwDvtMN7/o1p0cMdsxfZaMAV8o90MbMmPJJXtf3qUubHQzbLYI4G5ABMJGHQ+rNaLrkVOlwTtTEElTE3TdtRmjMMJ0oynd68rpSM5znJBTkygRaQDAg9Ahn5xCIb7FXniUHEEJE5v1tFaQUlk7JcUpuLKGK472teOdPypHEtPTDe2iKgPHVl6d96+BkhU5ooFO5d6+BBI8cBa39n+nQvTYF1fJma7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpmzfFmrcOAdVXY+JnqeW5xAWHKPLFo2XF3dhOxrrZ0=;
 b=vDyigbFMVItP2wf+x72K+bKxifD5vGx6iATc48fXxCVqMrT/D2L26Vr0RkEdAg9GdRQ0GEnCHXaxFJaDrwWXxPGXN8XkbYplkqHs8GWpkLFcxMsXPtI6hwGSdJT4KObCAE6frS7Tm9oQZySWtO5q+z48oSeqKfNnJy5JEeWiF7brwQ0+5mkeQvnL87sbiZON//6uGvIUmIHdL5RKfExqzPugNPGJbegYIBed9lEb+keA57FWGbWiH2atO3mHCmlsySxEynbmwbhKoQvwiBGY3l2YgsaPI/gj0d2a7fzvb3PNPQw1jf9F71oDVFgnyJ5af1+xtBDPlI5CYNGKobAIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpmzfFmrcOAdVXY+JnqeW5xAWHKPLFo2XF3dhOxrrZ0=;
 b=Lt7SsEZvRhd1jvwF4SwC6JsSA59rbrvcDPfaVuYk3LVM1hiLb4xf8z+tdMbIUqACezX/SY6U2kjS8L0KeoKMvlGY5i0kZf6fZQVKg9sijvB1dXoAyCtVvquHOhekyr59Gmfu4asLoPJi97qyh94rAoBeqfj+GqIREIL5wL9ouqffEhOmcx1u35mDP8U/uWqE+D7c1eBgltZQTBCBcSPdzkGwD86cwrQOmlUsXTsJ6K3bYF9mpTvzd4n3NqqBPThhAJQzuAv9FfC89UwdsmgZZSGABHLgir6Yxf7kIaBBCNe22j+I9uHvRF7qpCW2t/KyOG3wHFXgYEgPkXAjHnatfw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DU4P194MB2280.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:55f::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.21; Sat, 16 May 2026 21:11:33 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0025.020; Sat, 16 May 2026
 21:11:33 +0000
Message-ID: <BESP194MB2805F515E21C1E89E869D33EDA052@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 16 May 2026 23:11:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: cedit: Check ofnode_read_prop return value
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <BESP194MB28052CF65AFFB806C625EE84DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <CAFLszTjuy1N2huOeFVLEiH53EZ5mDU4ko5WiCMM_4mjkQMgNJA@mail.gmail.com>
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
In-Reply-To: <CAFLszTjuy1N2huOeFVLEiH53EZ5mDU4ko5WiCMM_4mjkQMgNJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0187.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::19) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <bff4ef55-a01a-4870-94c8-fef2d44c1265@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DU4P194MB2280:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac9493a-aaa2-4f87-2458-08deb38fb54a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|55001999006|24021099003|37011999003|51005399006|12121999013|23021999003|41001999006|8060799015|6090799003|5072599009|19110799012|15080799012|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0lZN052UlEyWUlQRmlqSllwR1NoL1NiUEpnQmRSTG9hejlEaktxMmEvT0NU?=
 =?utf-8?B?L1p5b25RZVNkK0xRanJJaWdCQ01nSjJ1Vms5SU1mb0pZWEkwbWovbjlaR0ph?=
 =?utf-8?B?UEYxQzJkcFkyQ1RqRzNDL3FEdC96MkJERVFzM3VTNjBRdXhjc2M0WkVTOGRE?=
 =?utf-8?B?QWUwdXNqWnpPRGZDQmZ5akxtakJVUUd4dHkwQlFoVUE3VnhjWDlxSkI4cWh5?=
 =?utf-8?B?cWFndHM1QWZuVVB3WnNsWkRzSnVMUE55TEFQa2Z6ZkhWeDhlSnNpUERtSkhq?=
 =?utf-8?B?SjMwQ3lRSzl3QXFOcTB1ZElTTGdsVGZJekJLRGR4Sm94MHNQUnViYzJhQ1BC?=
 =?utf-8?B?dnJNQ1VnYXZSY1ZYV2d3WVdDWVhRNGdxYWxqektWdFdWbXJ6UVVZd3IwUlBF?=
 =?utf-8?B?cmlNb1M4QUFGMzE0U2FGR2hjUnl1ZDNCOTQySmpGNnhrT3g5ZUxkQzg3dWU4?=
 =?utf-8?B?ZXp0OEtjRmFqRTJBM2s1K0N0NkNuTXloSXl0cWNNTTc5a0hDbkhJYStyRjFu?=
 =?utf-8?B?VzdZdVE3bjFZRUxma1JvUFY0eDZSQllRM3Y1bEtwOS9PK2VLanZjdFk3OUdy?=
 =?utf-8?B?Q3RNVFVmbnpFUVowaFQwWlpJU0Q4QjlMTHZDaEZGR25Yazc4NTAyQ0tNQ2V2?=
 =?utf-8?B?eElqYm5PMVZnOE84bGtGc3JSeXlBQ3crT3dXVFBCNDh4VFQ5LzdjUy80ZWwr?=
 =?utf-8?B?a3VsbzVxZi9YaGFNQkZnbXBkbzFYdTVuQ2FQTTF1bGZjTFFKSkNMV1VWcjkr?=
 =?utf-8?B?UFNOeDh5dDZvczIvQ0dEQjFkRzhCeElzRk9xWnNCcmNWb1pWNnp5VnRheTg1?=
 =?utf-8?B?M040MFFkd0VlZ2FlTkZLVnJnUER1clB0YzRFUkU4Ym1kTVdEMTV3WXJDMG9M?=
 =?utf-8?B?MGJZNjN4QU5FVGN3K2dzYTN1Z2NVOFk3S3R6Zk02L1JOcHp2SEVMYWYvZjEr?=
 =?utf-8?B?aGxSNlBSMk91d2lEWE1qbjRjZjFmK1pyMDhaK2ZGRXU3SW41Rlh4Q0VIekh5?=
 =?utf-8?B?aEs0TEVLV1JHRW5JV2U3QmVta0tKcTJDTkdwN0xUR3podkt2NmVtVU1FRXdW?=
 =?utf-8?B?Q1BoQ1E1M0Z6WmlZVmgrbWMyRTdqdGZsNzNMbUt3cldicWN6bVdSdVRtYjIw?=
 =?utf-8?B?K3dCUk8wSGFUYnZCNDRnd04vejZPendqUTdQRHpvazhyQXdZc2ZJcVh1ZkdF?=
 =?utf-8?B?MFlrTDJrTzIvQnhacW1UWGRJcU5FRzZWN3RSN0hHTUljUEJxazIvSWhZTzZa?=
 =?utf-8?B?cm1NdTdCSVU2RVJ0T2ovYzF6YVk1ZTlKUHlYVXJma2JyL0hBcENQZXBiMldQ?=
 =?utf-8?B?SGJwSnI0QXcrRVZsTTRMVU1mRUg4YXZJYm1vOE8xeXJ1ajQ0VXlqTWFhK0U1?=
 =?utf-8?B?ZFhyN1ZwK2I3eFhmNis0WU16Q09GZWZPdGVkcktwK0JLTWFQUjA0d2h1UVlz?=
 =?utf-8?B?YzNLVm1qWVpZRzFDamdQc3FnY3J5ZnhCY3haTi9XVnpleG11SzdQRUJSNlBl?=
 =?utf-8?Q?xeGk+0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUROenptb040YlBsUzNWSzdhTElCbEZ1a3Q5UTE5YzBZNzJva1JWenFjVnR1?=
 =?utf-8?B?alFMVzhwRndnRE5vUWZUVDdzUnplREUwWm1WRG5GSVV2VHlrRnRaRTV4WVQ4?=
 =?utf-8?B?UXMzZjZ5WHU4aTVQOStjUTE4NERyZlc4U2JxZjVMLzE5emh3NGZ0c2NJc2ow?=
 =?utf-8?B?R1h4VEJBZzZyeXB2ajFOYUF3UEJ2V1pRaVduaSswVU1FRk1wWTF2Um5uZHo0?=
 =?utf-8?B?QWVCTktsRStPRFpFUG9aS1Y2WmVLRnZ5WVBqby9SR0szOGRIRjZsRW43MkM1?=
 =?utf-8?B?L0VSa09YUlh4bjVHU3FjZXdTUTJvbjF1RzVlY0c2OHRiaHd6ZjZHL1RKUXhQ?=
 =?utf-8?B?bG9ZSDJ3dXV2UHJqK1JWWkphbGJ6djd2Sno4SXRiK2V6Mjc4NHduQks2RFRI?=
 =?utf-8?B?MkZWd3NmYVdkczRQRWdHcVJGbmxxdmdYQ3V2YlJCS3l3Mk96c0E4eGduTEJq?=
 =?utf-8?B?L0ZkR2FodWNJYzdaTXNUamNzblQ5c1U5QS96dnczdU9BRkhTcXl5SVducTRT?=
 =?utf-8?B?MEd0bHNEVGgzaER1U3JEa0ZFRUdMNTN5T25mMStab1hjVzFCUjRIR3JiVkUz?=
 =?utf-8?B?b2lHTXU3NWUrd29tMWNoZnBBN1VZMjlxcjZ6ZzNSZEhXNW9UOWFtK2xYcHpQ?=
 =?utf-8?B?VkNub1JjZ1JOTXo3RjN4T0xPR2lidUpCY1l6ZUZpMW9QSitIUkRYN0tVeFJB?=
 =?utf-8?B?bHhxeElOK3FvUDI0RndZYWwzQmdob3ZlWW1uQVF1SlU0NTJmdWgzaHdoY2tI?=
 =?utf-8?B?ZXJEZnlvblZTMkhUSmxQSXZKaGlMenJNVmxJREhZNTZVOVVYNWhENXJaNHNx?=
 =?utf-8?B?R3dCTkhhcSsrZWhvYmh3VXhaUG94engvb0EyL0JIOUUzVk5BVk9sWG1UUGRl?=
 =?utf-8?B?NzlXWWpIcURZekFCYUFQQ0hMMjZOY2pMV29EUzVSQzQ2U2pBazJYNmFSNVVT?=
 =?utf-8?B?WENMaVRwcUtRemFxd0VNNVZhaU1nRFVuQ2pBS1paRHBWdHROZmdOUmpCUXhk?=
 =?utf-8?B?cjRnV2M1NlIrMkdwb3UrUEkyOFBIaXEzMUVzTldiY2xKMC9lcGN5aUlKc2Yz?=
 =?utf-8?B?ZjZ1RHU0RDlFcUNYbkplZWYxSjA0ZnBEUklJWEJkbDRuMlpWNUsrNWl4NUo3?=
 =?utf-8?B?NUljUmRpNWRZZ2xvT0hTWnc1NkxQQXY1Z3VlTWhUR1ozb0lrQk03UzhoLzF2?=
 =?utf-8?B?SHhlNG45SVRWT0pUMlgxR2pjRFdwUVNadWNwS08wRGhTUDhZODQ2dnA5U2cx?=
 =?utf-8?B?OENjMlRQNEVmaFRtVXpOSC9FUWJmQ1VpaHRwYWlwZmRlcW55QTcyV21WZVdm?=
 =?utf-8?B?MjRXaXhyazdWLy9RMmJoTVkySmJaMkFndGRob0ZMS1cxcDF1VWNlMTN2Wngr?=
 =?utf-8?B?UzFGUXppVXVvV0hCRS8xYktrQmw5SVVGcVI0Y3paSGlUZE90NEdMUnUrSEd3?=
 =?utf-8?B?dGRSeis2ZGc3ZnJRczJkSU9pc0pNOTlrdW91emtETGlleDhwM0l5TGpmT0hY?=
 =?utf-8?B?QzhkTVNHcEdOUDhZQXcxSWMyRGJRUDlzQ3dWQ0pjS0RuQmlOZHFCZml0Y3NL?=
 =?utf-8?B?ODZQdGgxWWVIK3JUcFpvc1kwdlUydjJDdDhXVjZFYjAxMTJ3TGVkbFBEOGFP?=
 =?utf-8?B?N2U5enQyNWZUa2QwdEV6N2xiNmMvS0drcHlLZEJsZ2FMOHNPVUVveFk2ZTBE?=
 =?utf-8?B?dWtsYTFkTlFydXZBaTRCUDVNV3U2Vm00eFMxWnQ1R0dTbmlLR1grRmtQc1N1?=
 =?utf-8?B?TXVLVmVOMWFaWjlpdlhVSm9UZ1VmbVJxQk0xWHdiSHI1NkhkZ3dOWXNkMVZk?=
 =?utf-8?Q?kKGM7tqZvH/yG2PxCv/TUmN8C0jhJADmmAk58=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac9493a-aaa2-4f87-2458-08deb38fb54a
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 21:11:33.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P194MB2280
X-Mailman-Approved-At: Sun, 17 May 2026 05:15:41 +0200
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

Hi Simon,

On 5/16/26 15:31, Simon Glass wrote:
> Hi Francois,
> 
> On 2026-05-15T20:57:47, Francois Berder <fberder@outlook.fr> wrote:
>> boot: cedit: Check ofnode_read_prop return value
>>
>> In h_read_settings, val variable could be NULL due to
>> ofnode_read_prop returning an error. This variable
>> would then be used as the src in strcpy.
>>
>> Add a NULL check after calling ofnode_read_prop.
>>
>> Signed-off-by: Francois Berder <fberder@outlook.fr>
>>
>> boot/cedit.c | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
>> diff --git a/boot/cedit.c b/boot/cedit.c
>> @@ -500,6 +500,8 @@ static int h_read_settings(struct scene_obj *obj, void *vpriv)
>>               tline = (struct scene_obj_textline *)obj;
>>
>>               val = ofnode_read_prop(node, obj->name, &len);
>> +             if (!val)
>> +                     return log_msg_ret('tline', -EINVAL);
>>               if (len >= tline->max_chars)
>>                       return log_msg_ret('str', -ENOSPC);
>>               strcpy(abuf_data(&tline->buf), val);
> 
> Good catch!
> 
> Please can you use -ENOENT rather than -EINVAL, as this is more
> consistent with the SCENEOBJT_MENU case a few lines below.


When I look at the way u-boot handles ofnode_read_prop returning NULL, I find that it always uses the EINVAL return code instead of ENOENT. Let me know if you still prefer that I change the error code to ENOENT.

Regards, 

Francois
