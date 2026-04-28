Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9949FFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA0E084255;
	Tue, 28 Apr 2026 10:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="DCl9SqlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C093184255; Tue, 28 Apr 2026 10:13:59 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F0D803C6
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDHLPfUj/7hF041Wd1C8ua/DZm8pe49FQN6b7r9QtcohdV0nsUW5+CBjuDXZfC4iC4BGHEKO0ejjSpe7J9KOBf25j2x3Z6WgFnLspiYs8X2GAHuFj5ev26smDu/VC6yixxFlg5QWJmtLYOUmlX2L2wYD50gL6uoNvQqyqkJmIGb9dRFPqicmFVAegvBIWWm+ztFSaLdMKDaep2ro21Mov7qXKOfDNosmHx7yafQLBljKrZVRkrc8ffAUppUO2tIiCp+Tx020UnOBlW925AiSCqEd8FblT+TGnDN3mxraFPScmW1bg+wajXy+4D4QO+NWN2d8Alqs4IUzrVfIx6Pc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpa/LTRK+AsC/nBwlnm8gqY+j9Rj7ujba9x1owotANc=;
 b=HWO9GB86kuPIesr8KmoNdWsVat3UPKCFJyO/oPYePP7Nh1Ru/wMuEmmNBSnyn9jAR4roHymKBeRWyLantvmGJCDMGt138ease+AAXonZ/ihZ+FN4qM1VrQ6KTy0C16sK00B+9jRiJ19m5emecLwH62dvjzTKf+Y6S02ZC4iRhhYF9w6KUK/tIAM+f1gi522X3h7kgqW9bitSaYXRuJsXZrSkJDlOQjFif7cToFolmoSDxE4NK7UtyiZyDZEgPfhM3MdSETniifQsS3XVe98HFSQQMaQeIgPBK5QnxeHae0lDoxQDApdHYVlMDEkGlD8C5TQm+XX9hbOHRfQikItsZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpa/LTRK+AsC/nBwlnm8gqY+j9Rj7ujba9x1owotANc=;
 b=DCl9SqlNQRetgac+N/ZG+8OYv7H9Lx9rOptS2J45fbezgNMhDX+LQ/UIyMzugCnK5xtmviO+k/OXjjNmr1BY0HFQkgw0sTUOnq1yHtzhVGi44gDFWPwrk6zDRme+36hwwKAWec4QIH0hMnOdaYCltsXyD4fE959Zv+18UPZkUAq7uaU88hzKV0VTwW6hPqLbftOCcrrm88LWBOELQq+KJpNH7vFEx+bwGt1EyGQM0aEU/NvHkkJpRlPEvvr/xMrXV/Vp1K8H+Vdw2W/xuD8Qig9KB/OMyp5mNB79RcNkgRE5zCxU1v5YjgB7fyxgpm1Gankp5+/V+/jaRq61+ntdYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by AM7PR10MB3891.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:178::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.25; Tue, 28 Apr
 2026 08:13:54 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 08:13:54 +0000
Message-ID: <e2580067-f952-49bf-a9c0-a67bdbe449a2@siemens.com>
Date: Tue, 28 Apr 2026 10:13:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iminfo: also verify signatures
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Frank Wunderlich <frank-w@public-files.de>,
 James Hilliard <james.hilliard1@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
References: <20260427150409.400914-1-ludwig.nussel@siemens.com>
 <20260427150409.400914-2-ludwig.nussel@siemens.com>
 <8dc3d041-cafb-4022-833b-64ee9c950d7e@cherry.de>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <8dc3d041-cafb-4022-833b-64ee9c950d7e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::17) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|AM7PR10MB3891:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d424384-8b80-4f62-32fa-08dea4fe1695
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: S8O/MV3GvRPGH+nj2OwMV3ymTTem4pjRb4BQ28QMaalxVgvH9Cjk1AugvNYHdQ+xXCTOuTCW6hAMU4ACoXSD84RPj0iNmZPq5dGZFcDjRZUadULNZbv8R2+rUyidUoNFASOu+F1j21O3PQXpv3l+7Usx5Nox01pNfF8FxRsiFLyfZZZcFqqPmOkDf8GAPlo89iiyWbbVe0hSkVQxG2MCeiu1YprVbgIkwnwcKtYjwOZfvn0A33lPVleVwHAqeXGU9MwfrOs9tO3AX7YC+/nD6pysqTBTO/s2SGalzcLKrwSjP1Kn+1LSUXEpdDNK4VUrwsYRdDVhSeUsb9MLKm7blG7sT7nYs+WOIBN4/hoy3LhPwFKpY5bBuoywj84vUvWmUB7kF6OFNMwApZfayTRPYgsYjSt3rvyiy51x0LGsmxD0w0v/MKI2qj2Nw8nmon8Va2NbwZD5WqRFNcR7HmM/E1yHzXoEOoZV3gmadvWSpLE3UulQ4I0tPX+gCuJ+3KcezYnD5ZJtB2MSoLkRNJGOeIPBiGEy6o+5NW1YEdxeAHhnWp1/Nkd5wE4ILVoD2jnWt7vTRt8yZPWVKLfsGJdw+5hJoSpBp/w0iuwUP9rU2nKH2SQEcC02BDPPe0fpgbXtw0J4ysColJ+6Q0AgQR0ecQw8VqTUv1JG6ImpMatbcn/GDdwUnbEEEt2WooNmYVQs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXBPNFZKakpxaDRXdEpCTWdDbUx5d24yK01Oalo1d1NxU1ZFUVhUSkhlQnZ1?=
 =?utf-8?B?bzErZzljeVRIemM2WFdsbnoraEJRRUR3UDRYNjZRR1pLRTFMVllWMGZmaHRF?=
 =?utf-8?B?c0NURHplTFN6WThGYzFqWkI0VHJHWHhuSEU0MXh1cmZQaDFNbjdhTUFyakd1?=
 =?utf-8?B?S05ISkFHZUtxcW1YL3JWMjNSeXE0K3JrclNOMEtqbE1jMTdWMDZNYWlFQVRI?=
 =?utf-8?B?MHNMT1M0ZHBqQkNPakV3OURFV2VZRUY4UjFQcHZPek02WHFxcXZMTGdaZ1pm?=
 =?utf-8?B?UlpwTGc4OU9kellVRGJYNG9HUlBSWlJIbisveHA1RVBrMWNtWStTTjlLYkJj?=
 =?utf-8?B?RDNGM0o5Z3RndnV2ckpCZ2t2VGpReG8xZCt5eWluSmRCYXpjWmt3bVhLa0M0?=
 =?utf-8?B?dlFlRFJYVVJXVjZDanYvUkY5cmNFZUxBRC9ZQUhTMUlLMUdjb0hORUZCMVha?=
 =?utf-8?B?RE4wWEFEbklkWGVJODNiRTc1UytCNWUvSUQ2aERaOGZ4bUcyR05BaFRkUVJk?=
 =?utf-8?B?SjhmMVBNTVF1TDJiU3JTQWtnS290U3I4ejJSMTlvc1dVUWN6am8rMC9aOTE0?=
 =?utf-8?B?TWpYTksxa3JNWXhaME5FcE5ZcHI0SFNETmFrUjNRbC9zYk50SEoxcU8xMXgr?=
 =?utf-8?B?VzBJcFU5SUNNYW40RmEwYWVJbHAwcG1IZXdnaVM5ZS9weEJzK3pZbkxIZVkr?=
 =?utf-8?B?NlVjbkI2emNQSk5lTDJyb1FHMVRTQjh1V3NBbnZaTnJDNGUvR00rVURKbTF2?=
 =?utf-8?B?MFBDVzEySUNXdG1JNDNKQzZPUVZIa0lsa2FmZU1mWlRBbzhHdXFtU0pPb1Q1?=
 =?utf-8?B?NDRPdEpiaTNScGVDcTRKTXNQNVlkcHhvY01oWHo3SjdrTTRaYjVDdFRMQ3Bv?=
 =?utf-8?B?RmtLWnNGbmYwaE1Tenk0bGxUaHpTaXltVUdVa0s4VHNSWXVHeWNVcGc3VzFx?=
 =?utf-8?B?R0RqdnJBem1Na2pqMGxpTU8xRU9vbWFOc0VnYVBOM2xOZldmaDRzWHJRRkF4?=
 =?utf-8?B?azNFSytNV1d4L2tLc2pzcGtVaUV1ZnNKblNMK0R4Y0duVlFNVWp0MGdEMWZL?=
 =?utf-8?B?bmFSVk9JRmZQNjJpQXJTMkZUTjFBbEw3cGZIU3ZuMkxqSXdYWVoxanA3UWgy?=
 =?utf-8?B?TDU1NHZuUzZxWmNMdDhHNVZ1NVI0QUlCeWFYclVJMTJmZDJObWdRNEN1bWJC?=
 =?utf-8?B?bXZEaWQwYkp3M2dsN2o4VllGQ2ptVUdwOTg2czJISlVjLzM1TThTWHFIeE9j?=
 =?utf-8?B?OUtMc09wa0NhZWcwK0JkbTZEd04xL0Fyd29aMFdKa3NscmszdlpLU2lnN1kx?=
 =?utf-8?B?YllBZWxIUVVDSjVxNnFodUhZZEpyY3VIaW1UWlBDVFBtanFRSFg4R2NWY2wv?=
 =?utf-8?B?RVhCazk5dmdKOGFLRU5NZktBQ0RocnFMZ1NKSkdJVUFpeVgzRndTa2Faek4y?=
 =?utf-8?B?am9mTzIwN3MrSlNVWjI0SkFPZldjVTJvMWlTamRWcnhnVk41M3Jjc3lEb0lw?=
 =?utf-8?B?OVd2ZmNMQ0Y3ZFA3ZEdldHpXMmFBZGtFZTU2MnRhdkcydy9Pak1XN1BMNjc1?=
 =?utf-8?B?V3Z0aTBBOXVjbHE3REc1TFBUc0FTVHJ4TU1aQ3VyMWl5ZzZZaFVsckg0UXlw?=
 =?utf-8?B?eGxyaG53eXg4dzNQQ1d4aVVaK2tDQk1SWllRU2s4aEZWMm9taVdnWk9KYjho?=
 =?utf-8?B?N0c4LzdSRWZldFBIL3FLTERpSnYvUzAvbzF1cUFIejhlYlN3QXBYd21HNTFp?=
 =?utf-8?B?U2lESVU4L0R1OXRYQkxNN3UvTkgrQkpDMWdQanhrUCtZWDVyNEFCN2xkcWJN?=
 =?utf-8?B?VGNtR2lMQWxpY1JxbGx3QVliVmorMHEyMmtDNU5hQm5XOW9XZSt4UkxUUlhs?=
 =?utf-8?B?d3I5c2MyL28vSkZHSndEMlRnWkFvOHVhdzlpZGczWmVEWGVPams4Q3JPSFVa?=
 =?utf-8?B?QVU1Q0lmdzJMaHJJL0NQb1ZNS2E4NDVHTlo2eWxLckNrWDdUbjFtY0NtQ2k3?=
 =?utf-8?B?cm1ZWlhrSmxKaFQwNVFzOVFHWkkwVjh4bkRkaElDb0NMQVhJN0p0SnhVTGVw?=
 =?utf-8?B?YThDalBhUFIwN2hFb3luNHR2aklVTEYxSVQ5bng0ME02ZmZaclhmcktaS3dY?=
 =?utf-8?B?dy9IeUx1R2E2ZVFscWZiMW9IdEN1U3pFbWw5NVdOdG5IVVlOcVl5NEZQY1NF?=
 =?utf-8?B?dUVZTnFia2JxbHNLSk5tbzBuNnIxTXVoV1QydW9yU2R2S0NjR3dxMjRkMkth?=
 =?utf-8?B?VVR0Smx2WHVwMWdRci9vVTF2YjhkTUp0Z0VsQ2wzWkxZL1NWc2U0SmwxeGVK?=
 =?utf-8?B?NHJlZmVWMmtCSjdCQklFOVN5S2ZRVHVvUnl5SXJvbmIwalpwbGVielpSc2Zr?=
 =?utf-8?Q?a9ro/zjDzYhxKmik=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d424384-8b80-4f62-32fa-08dea4fe1695
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:13:54.1976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZnOdNx32XJo9RmUx1Du3HKbVrr3Lq5gtf33qBqgFi+2BQL9tDX4RWpCQaZm9LxQKUhp7EdCK8Jarhq8HDDoXJCRvXEfo1g9l3aSXkET8jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3891
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

On 4/27/26 18:19, Quentin Schulz wrote:
> On 4/27/26 5:03 PM, Ludwig Nussel wrote:
>> The iminfo command already verifies hashes of images. This change also
>> verifies signatures of configurations if enabled.
>>
>> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>> ---
>>
>>   boot/image-fit.c | 36 ++++++++++++++++++++++++++++++++++++
>>   cmd/bootm.c      |  7 +++++++
>>   include/image.h  |  1 +
>>   3 files changed, 44 insertions(+)
>>
>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>> index 2d2709aa5b1..b2c6db79edb 100644
>> --- a/boot/image-fit.c
>> +++ b/boot/image-fit.c
>> @@ -1512,6 +1512,42 @@ int fit_all_image_verify(const void *fit)
>>       return 1;
>>   }
>> +int fit_all_configurations_verify(const void *fit)
>> +{
> 
> Please document this function. It's clearly surprising to me that the 
> function successfully return if at least one conf node could be verified.

Right. Will add documentation. The function actually succeeds if all 
configurations have at least one valid signature according to 
fit_config_verify_required_keys().
  > Please indent like we have for fit image node verification, with 3
> leading spaces.
> 
>> +        ret = fit_config_verify(fit, noffset);
>> +        if (ret) {
>> +            r = ret;
>> +            continue;
>> +        }
>> +        /* at least one correct config */
>> +        if (r == -ENOENT)
> 
> Where is this ENOENT originating from, it's not obvious to me.

r is initialized with -ENOENT. As long as it has this setting there was 
no failed signature.

>> +            r = 0;
> 
> This will be overwritten if the last checked config is a fail, so it 
> isn't "at least one correct config".
> 
>> +        puts("OK\n");
>> +    }
>> +
>> +    return r;
> 
> Please stay consistent with fit_all_image_verify which returns 0 if not 
> all images are valid, otherwise 1. Here the logic is inverted and allow 
> for partial verification. The former is an issue, the latter *could* be 
> fine if we document it well.

Right, U-Boot in general seems to mix styles. I made this consistent 
with fit_config_verify() which it uses.

>> +}
>> +
>>   static int fit_image_uncipher(const void *fit, int image_noffset,
>>                     void **data, size_t *size)
>>   {
>> diff --git a/cmd/bootm.c b/cmd/bootm.c
>> index ca7cec91fad..2faa9648c46 100644
>> --- a/cmd/bootm.c
>> +++ b/cmd/bootm.c
>> @@ -335,6 +335,13 @@ static int image_info(ulong addr)
>>               return 1;
>>           }
>> +        if (CONFIG_IS_ENABLED(FIT_SIGNATURE) &&
>> +            fit_all_configurations_verify(hdr) != 0) {
>> +            puts("Signature verification failed!\n");
>> +            unmap_sysmem(hdr);
>> +            return 1;
>> +        }
>> +
> 
> After patch 4/4, I believe this will now fail if you have a FIT image 
> with only image signatures and no conf signatures (which is valid!).

Indeed. If the image signing is still a thing to support, would it make 
sense to introduce an option to enforce config signatures?

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
