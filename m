Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C417BFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC65843A4;
	Sat, 25 Apr 2026 18:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fGpoPasD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C7E84394; Sat, 25 Apr 2026 18:07:21 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF0C84353
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
Received: from PA1PR04MB10987.eurprd04.prod.outlook.com
 (2603:10a6:102:486::14) by AS8PR04MB7896.eurprd04.prod.outlook.com
 (2603:10a6:20b:2a2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Sat, 25 Apr
 2026 07:00:38 +0000
Received: from VI0PR04MB10493.eurprd04.prod.outlook.com
 (2603:10a6:800:21c::14) by PA1PR04MB10987.eurprd04.prod.outlook.com
 (2603:10a6:102:486::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 19:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmjgvYlY6jqW5JTP+V0fY+D4lwKZCUzqUuDWNUSCstOnns7ItWiwKqw1z1fd6Ul0nG8mEGofWMkVq3stNIDbyyzAdwIQF8m+DFDrcgMiBt5aa5LwoEfk5gFaPum7Jwpy+XTx3p7ycA03NGCx28jYJ6ukSaJ2EJbol2oL1C+qhJ92i8ohS3X9A9EMDhyvXpWFwk8W4pxPVQC9gWXidr46l45tMR15FwO2qUdOVjUUsglW1vsHYNYac53ig+qdKqB+a5NoxE9CMLq004+VY68Dli0dhAOD1RShCcnMZyL02jvUwdJM5dtgj4F4J9qHifGTtv2E1fHqyZ5ngtldAE3b6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFP8Z94eCTOWWJUaGzlmLjPPTSE3F5tubYwN3Cm44Bk=;
 b=KhyuKoNFoC3Dk7xMvOjUwWedGkYB2uAeONsfTsXbNlmma5LcEVs1cDy6RxgxHaPDvxoAL8NnIOwTHroAaYqPicAHzPGGlWn0+FE/pWBn4zqBGL2EYBUyFpSXGp7DRm0PXSP73UnZoYYhcvZz9M5j3GL/OYIFUS2YvSLgqbpEcr8JTeBoG13PAZpi4WN3wQV1OrDsmfOE8MvPBJoNpTWg1VlWJEDvHr4UPt6UNZKxM9z7sBKjoej8Xc+prEGH79dd3yhLfx/zse+ZQrzWvtyvnsJ2ijBz5wvOQT1eBSMyJrGA3c2sRo39s0eUwBbgcNxJBtqok/b4/Wqp47VqZkVmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFP8Z94eCTOWWJUaGzlmLjPPTSE3F5tubYwN3Cm44Bk=;
 b=fGpoPasDlJhuBW2LJ3LBkM7UBB60dfN89cXhGFlCMAQ9epe3HnCjdsV9GMVjhLpiLOJO0zc/P0KTgN6hV9yiUqP0JtoW6iMuC729I1lW2TZ3Xm/6kD/DPJ+BrzZLSKdnu/4klCyjQZep0AcsH1g4t4fVbpVi+NaKt0R65JUQeLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB10493.eurprd04.prod.outlook.com (2603:10a6:800:21c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 17:52:55 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.017; Fri, 24 Apr 2026
 17:52:55 +0000
Message-ID: <4f97bccf-bc6a-4576-8b29-1e8681f0f0a6@cherry.de>
Date: Fri, 24 Apr 2026 19:52:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] binman: Flesh out the softhsm2-util bintool docstring
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
References: <20260421231126.597390-1-sjg@chromium.org>
 <20260421231126.597390-4-sjg@chromium.org>
 <22dacc9a-103f-4b54-8f65-ba1227be2114@cherry.de>
Content-Language: en-US
In-Reply-To: <22dacc9a-103f-4b54-8f65-ba1227be2114@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI4PEPF00000161.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::86e) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB10493:EE_|PA1PR04MB10987:EE_|AS8PR04MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 39907b95-b4fe-41a2-8060-08dea22a5077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: BA/gmrkA+OYr7/mnzmvc9XeM0EsuKHjCMV3CcVX3Yf0tuhWY64RO2SyINxo6CwGUsiYhX0fSY3pyjzew3JjN36sRyTDm9jpeaTebuPaBrIwj9tLuNDFpRcSdaIHY/GV4uHHPqkA8Gip0VOvw3MXuBmWmNh/FJM/o9MTgvA+dgss40/EVBUIpvQRRe9tvLlsrVaOpmhkeJLiRS+j7awX3pnvLewAEZsSE0jSlktFAPVY8TFmV3PHOUHgjmqEL2EPkhr6D9TIc9jWPlfRGvNMonQsIcTm4H1dObggie2TLe8K2tJN1a6IGNT4gShBoGktQKU3Unbhdl+3Fl4ik/wtuT7ptZyi6eeFtCaVXyqEZM81zbuw6Rgo3Ixh2pSqvK2JZgGzyPFrKdLDWh5LIAsasaKKHqOVrqDMxb/4SIBcageI1EoKRufnyH3Sgb2i+A03mIxOfl5Dh9qSPvDxKL2ljCZ3E3eTbbYwwBObg/4N0WZkNYK9KSJO91X6E36c5E0bbp63BsCkEiuQ7u7eNEDur6chYcRfy+qZ/k2XNfm8owB5GuwHSTce6OZa5bSY7dE7DskxfONsSwhZoDuF+T7FC/zmeXMqO0OcpsK/WPeVIZdmqQETGyuqUTK93t9L+lNbmFoqrJRaYDt6mrP9DKpYwOXWwztLEhITjp4ipSo7zxEZDQ08Zu4StBlLMnGdM8nzipIUCi2kwMQEHe8Cw1MY397/05XoezUq6FHUe/ESnVmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJITE5TUk0rNFlKN1pDYy9UeGpUODd3clY4VEdQKzIxWlBTejA3NnV2WEY0?=
 =?utf-8?B?cm1BWkFMWUNURUpqTjdYVE8xbitUd2t4WE1XSHFOUERzUnRURlJiNzBUZXJm?=
 =?utf-8?B?ZUJ2VEJna0N0b2xKbnlmY0N4Y09xQkJtVHlOVWwwMmhMdm9xa1Q4TVZNdW9n?=
 =?utf-8?B?TnpPNklFcGRWbFNRNTF3SFJ3dkRDQmtIVUN4Q0dTZDNMK3R2RTlocGx2NXdn?=
 =?utf-8?B?M2dhMDhHVGJ2clpqOWpnb2xQc3RZeVhlNHdMZy9WOEJON1NWV0lodThtVHZo?=
 =?utf-8?B?bjZQQXR2WDBJZmJtQmdjc1pkbjhOOXZoQm9mb3VobEcyYyszQm9DM2c2R2tD?=
 =?utf-8?B?WmI5WjlJUXZHMHdBYTFJTlZpV1BRY2UyczFjK016TmRpYVNEMEs5Q1RDcWFF?=
 =?utf-8?B?bDM0bDRwalUzNGE3OEpveitwS3BLU2pISldUbmo1VVVaM2EzM3YyQXpLdTd6?=
 =?utf-8?B?QUgra0FIeVRNY3hNdWpqbnJsOEpwTTR1Tks5dDNWdFczVGNSN2o4V0gxOHQ5?=
 =?utf-8?B?Uy9PQUxvM0JVSGFpOXo5dDhtZko4L2RUdjdJWGVXMkdPZHJFWlcwYU9WYWhq?=
 =?utf-8?B?TVUrODhQR1c0ZVJzQUFBTWZ6alA2M0VESjFYRGxjaHU5RnVTU2htNDdldXNK?=
 =?utf-8?B?SkZMS2pHU0tHT1M1aE1pYkZ1MHpRaUNDWGpjT283R2tOUjVTMUVudy9Kd0dM?=
 =?utf-8?B?eE05RDVvVTI3aVBCT01XUUY4eXQzeDUzaXYxTUVHbzkxeW1xY01RYjNvMGZm?=
 =?utf-8?B?N3U2Z2U1TnAwWWZEQm40U0srUDFWb3RKd2lyM2x4YVVZRGJGU2pwMnpFbzhq?=
 =?utf-8?B?U243QWxVVFNFK3gyMjJzNkpicG1zeGtyYzVGVTVHZHEwblRYaGlZRUJNaVNN?=
 =?utf-8?B?QzdVeW1BYWZJU1RNbDYrZENJZFBDVU5QeWltT3diZ0NQM2kyN1dOSTZtemdt?=
 =?utf-8?B?NWE0b3pESVJmQTdFdjZiMDMyZWx0aythYmZVaTg4ZHRKNDE4ZEkvUGhnZFlG?=
 =?utf-8?B?ajZxNmVCdlZUdlVpWkpOcWdMT0d6Y2ljd01FSG4vaHY0TmwwRzNZZnQ0c3ln?=
 =?utf-8?B?a0RwM3NYcHpWeHA5S3dBTGtrbmZlQ0llMEorNHBxak5Ha25yVkkrOTJHb21R?=
 =?utf-8?B?blF2SzFHN2ZPdVRjY1ZOVVk2N3B6dzE4Q3RDWEpQWm9KK2pWVGcrdmViWG12?=
 =?utf-8?B?T2U5QTQ5MzRIV09FRzFPa1I0czhKb1krUC9JaCtNZFRkTG4yZlprYnVEUFNI?=
 =?utf-8?B?WGRrV2tpWkFsZnErMk16RmlDbmVETnBvUjV1U2pCRVVlQ0l3aGl4b3hOOHMr?=
 =?utf-8?B?eGhDclZJWVJuUEpYSzdYbUdMWTQ4bHRtU2k5ZHVxTXJrbkhkSjY3YXRRU25y?=
 =?utf-8?B?OUtQMytlUlZYdXZhUW95L3BkRnFxUEZEMGlwN09COUt1NCtvUXRrT2srclRI?=
 =?utf-8?B?TXBkM0VpYTJjaHFhMUZpNDRQenlMNlpMZVJCYVFlZkNEMjUvWUxUSlJvYXlQ?=
 =?utf-8?B?UE9LRmhCNXFKMXpuNUxmckNyTUc2TEp5eW9zZ2RRWHlHWks4TE85VkVHQitO?=
 =?utf-8?B?eFJSWE9vOXR1M0prTktJZWxnQjJBbUN2QmFGL2pJWWNnRkoyTUtwc1lSWjM3?=
 =?utf-8?B?d2hrV3VCbC8yRWVXbEZTUjQvaVF0NE8yVk1WZ3R5OXFWMnR1QyszcG5SRlIv?=
 =?utf-8?B?eFJNSmx1bFU4UkMrallsdzhVemI5VUd1bS9uQjZha2IvblUwN1ByMDh0eEVs?=
 =?utf-8?B?VUd4Z3VvWVB5bE02NGY4T3NnbnA3S3RQUTAyZEZISVpkdjBtRm96aG1talNz?=
 =?utf-8?B?L1JpRGZhVk1CdlJranRXVGlTQXZJNzNvM3BERHlCQUtycXBONDVyczc5cEtR?=
 =?utf-8?B?T2t0cDFjSW5OZVEvTzFzK2tSSW5UZlVUNEgvdG9nOEdrSW84YnBOeEgwSUU0?=
 =?utf-8?B?ZzdvMmszdjVneDJPMUZRc2VQdllmQVhtdGUrQzQ2MkhhUkZBYzVyWmQ5ZWty?=
 =?utf-8?B?ME1HUHdsZUl3NDU1K2lRSmlJSVlVQjZuNHdmMWNEZkpueHhYZlo1ZmVVVDdM?=
 =?utf-8?B?cDZlMnE2c3k3bUh2dm1RZEtyd3Jpdkk3ckFYNXV1a1BvQ1l4YmQ2OUxkQSt2?=
 =?utf-8?B?WTVaYmcyUVFpSUNOMkk3dXM0Mm11ckRubTNxZll3Rk9HMVJBdkZHd3ZDaFp6?=
 =?utf-8?B?dXcwN1dWOUpFTC8rODFuZ2VRakJTK25LOG1zdm5mU29VOFFzM2xyVzd6SUpM?=
 =?utf-8?B?SndlYXM4RzZPZWI5SlVCb2UrMkVuRnRtZTgyTUpxWFIzTGVzbDJzNkdvL08w?=
 =?utf-8?B?OHYwMjRQcjVPV0RyMTVPRDcvSEpNL0RpcGMycXR3cDllSkthUHBLS2p5YndZ?=
 =?utf-8?Q?TzHfvWTVakCW7g+nOeb566PA96n32qTbHRJwl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39907b95-b4fe-41a2-8060-08dea22a5077
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:52:55.6666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqW8OYyp87GQn54QYW+Fb20SmiO5FZKzsQ8JqTv/PDOOyB/MZHk/ghBpO/ax1toYdNLfDSX4Dk1Ww01K5xhbTFYFfgz9FJaXALUu0QqzdyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10493
X-OriginatorOrg: cherry.de
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

On 4/24/26 7:50 PM, Quentin Schulz wrote:
> Hi Simon,
> 
> On 4/22/26 1:11 AM, Simon Glass wrote:
>> The Sphinx-generated bintools.rst currently produces an empty section
>> for this bintool, since its class docstring is only a single line and
>> so the body under the heading is blank.
>>
>> Extend the docstring with a short description of what softhsm2-util
>> does and how binman uses it, so the generated documentation has useful
>> content.
>>
> 
> Welllllllll... Binman currently doesn't use it for anything but checking 
> if the tool is installed on the system and if not downloads it. I've 
> basically abused this to check that softhsm2-util is available on the 
> system, but I'm not using the bintool to run commands.
> 
> I'm now wondering why, because I guess we could replace 
> tools.run('softhsm2-util', args) with softhsm2_util.run(args)...
> 
> And the same for pkcs11-tool I guess?
> 
>> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>>   tools/binman/btool/softhsm2_util.py | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/binman/btool/softhsm2_util.py b/tools/binman/btool/ 
>> softhsm2_util.py
>> index 869221d841d..e79584da11d 100644
>> --- a/tools/binman/btool/softhsm2_util.py
>> +++ b/tools/binman/btool/softhsm2_util.py
>> @@ -7,7 +7,16 @@ from binman import bintool
>>   class Bintoolsofthsm2_util(bintool.Bintool):
>> -    """SoftHSMv2 -- support tool for libsofthsm2"""
>> +    """SoftHSMv2 -- support tool for libsofthsm2
>> +
>> +    This bintool supports running `softhsm2-util`, the command-line 
>> utility
>> +    shipped with SoftHSMv2 (a software implementation of a PKCS#11 
>> token).
>> +    Binman uses it to initialise a token so that keys can be imported 
>> and used
>> +    to sign FIT images or capsules via the PKCS#11 interface, without 
>> requiring
>> +    real hardware.
>> +
> 
> Yeah I don't know, this is all transparent to binman really. You 
> configure the FIT via DT to use pkcs11 and binman will simply call 
> mkimage with that which in turn will call openssl which in turn will 
> call softhsm2 engine (see tools/binman/test/fit/openssl.conf). So it can 
> be used for anything, and binman really doesn't care about this bintool 
> except for its own unit tests signing FIT images with a pkcs11 engine.
> 
> I would remove the last sentence. Maybe we should tell the user to use 
> this bintool only to check whether the package is installed but that the 
> actual signature/token setup is expected to be done outside of binman?
> 

and I didn't read the other two patches before sending the previous 
mail, but it applies to those two other bintools as well.

> Cheers,
> Quentin

