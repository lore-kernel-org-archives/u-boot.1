Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051F6D7976B
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 13:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46BD9843D1;
	Sat, 31 Jan 2026 14:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="Rh5flhOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B10845AB; Sat, 31 Jan 2026 12:29:08 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE6184564
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 12:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKjbfkloTU3iRv/p4gNGaJ9T7BaukwAyF7ERcavUAc90uv1SoEBImPH2wM9ez3uyTUgQFdmldQK+Brph8B6e9Ycwe8HM0qZaErZUWxkyl+E4d1Zd7gw66bRjyE+yU1KSbQK+YiMRy5aUyO3fSA2WTbajiZ8gaa3B2BH3zyjTflP3bedbh7gk94uJaq9m5B6TI3W/8e/fO8gLAf+lb00p2Tdl7UF+rZpjiRBNV91nFoz1ArJWDOa3LgTztDiBXONDGpuCyVFLf++7+BiLgN+htwqijM4GhA61nd+xOKqpEkDJzhJ9/GTDYLgrGYK+L7nhSgqrh8fvo2J7hmQ1BkRRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DljcSM4lqqBMomXvK2bQK+aI1AizRpVVoHwaE9rZZg=;
 b=Qokc2iDRI2I09/7w/JTCrO3di9dCKeATh6q41B5XLCYcV4ZVRmXMebCcRNFoFaSFf74EQVSBbxbwJ6/I3XwfqP2VTu4MjTmvg+oxsEPxu9hrnyjmg8h5ucJhnrTdmwGI+YMYkj0mCcBjlPZEhKOg937Z53KM2qcdT1mVBrsfNsF/jxvfhmUxyEbaVG+eGF2IUhOJggQV5EDUOf89/hEkeBoDsbMYbKDRKGN4P+zkufMa1s5/wFw+RXlW3KfFgndZJyqoel+9CdKU0cOfRhX1N51NUUpAo5Odk17rVRjzjFozvGiI2BCtm8me9iH44eAVJyv/DKsbB6lAC5vef5lflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DljcSM4lqqBMomXvK2bQK+aI1AizRpVVoHwaE9rZZg=;
 b=Rh5flhOxS+Wof5BGM0QOkvQVlf9w84nbDZHSfXxl1P3gfS8/6Ino8QJK04WXry2WMQdPmMn9BFGrTmR1Hrtagy5EybpPxsu74ihSssmZTDZf+OXlbe/63keEfR4IyZ5xJ5MMXDphlPPv2+RDGhby3zbWehxzeZoaw+wNVKsha8GQ1n5fAiFmxcnqf9csWDhMtLxQcbzz5t4B44AqqhqiVsqhtuF34GMazKHZmujMtabmhRn3IEO1PUQAs9RAXdGbZUOvh91/Egcik8lrxicCZ0qA3b4wwImsHfpth4Ux7OHtyiNVP68FYDl8tPDigFTj02HTtoezWPRnhb+DL2ePgA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 GV1P194MB1810.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:52::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.10; Sat, 31 Jan 2026 11:29:04 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%7]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 11:29:04 +0000
Message-ID: <BESP194MB280552FD0402A8303B1DA13EDA9CA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 31 Jan 2026 12:29:01 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] board: ge: common: vpd: Fix read_i2c_vpd return value
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0187.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::19) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <e83181db-95a5-4b21-8066-2226f921a023@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|GV1P194MB1810:EE_
X-MS-Office365-Filtering-Correlation-Id: c65f3264-4142-43de-fc04-08de60bbf015
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/BGdkfhW4kNpV343kQIjZo8U3ucu43GAWgjW9shPoRPNSfzwZSnrK1bfRSSBYz6h/45mNeRbORx7W6hVoke1tESl+dm/baYdiwBNz/nuwopIMTtIlL133Nu0KQPgnNRrQ5E9X58399OHdiXCsg2TOy8Tni6e5tN6KhTzBYeCU4VZUXcVLUwqXe9294HPPaTJXrmWOvPtAzt7PFt35ed5Z9UBECWQXSmh7nM7F4cqnutwOENpA777f8CPlov23c3aii/5kTexIu8p7eWZFtiPksihtbDYjRfYPxOGrNZCNowSvHVWI7XFwHt8mAH6dd9TF1uHXrqXRPyETrM5sBJ4nTLCu+pzyEDYx9ac3gZ2zox+/zl15P51vBRj/j+mK8zn/yPzYXPXii2wjer9y6bEG9GOvgUnj89o3Er0OxW8A3sOfDMaGF4jh7YCa+XERnUK+qArEyBLyaj56rLb+tWnmfQpq0hZD0wqMZLrG9TQTUlsj9w2PANauvcadIiqMKfgFhGsewhFBDObuHxd6MQ9hW5fJnH9+619r3quOmfL9m4HOpWECpdJam0r1uKZFgp2FBJgziHzUisDOjVrr/u8HLpegIQeu/IRgyJ+DocGFMm3azggygF8c0Q0ub8VFQajYqrLm8LJ0R9W/gXn7P18Kr5+vwaU9dg9KZ6lB/nwmKsvzIB2z5MOoWbNAJJ4JPzNPnAOu2+9YW+AKZKakTV/JkcmPq7dZBa+7KuJ8xY03XZg=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|461199028|5062599005|5072599009|23021999003|8060799015|41001999006|19110799012|51005399006|15080799012|3412199025|40105399003|440099028|13041999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTBQWUxwSkdTQllPVDZ6bU1ZK1dkZWNETE1UdmpyZzFzNU1LY2lZMjJXYTUw?=
 =?utf-8?B?ZjJyUlhlTGVkNWE0RlA1RnBML1RrbDdGcEd3dmtkcnE0TWp5OGo3bGJyMVJw?=
 =?utf-8?B?T3lkekV0RnQyeHRuQWtySVVmTDVHSXVhelBJUG4wdHU2MlJOdkpMTVVFOGo0?=
 =?utf-8?B?a2pPOVdYZHg1Q3YwVWtOczFkQmMwbm9yRUpBSjU1NzhncGtydDd5UnBwR3Vz?=
 =?utf-8?B?YzAxeUpXa2VMYTd4bVpxcnhLSndYRnNkc3FRS05tOUt1Rm9uYkNucXVyNkpm?=
 =?utf-8?B?UVVXSmF0Z0ZlTFREdzBlWFZ3cVMwc0lySzNqOEcyUzF3bk03OXhSNU5XYnBW?=
 =?utf-8?B?aVV6aE1CZ0JEeGtVU0t5Q0F2S2w2bG43Zmc4WjVBd0RwVDluTW8xYTFkRFls?=
 =?utf-8?B?NDAxL2pDbDhGS05PQkFGYmd0NDU2bGVhbWwvSmNZSG13RjdWYkZHT3ZVdEZU?=
 =?utf-8?B?a1VGN083bEgxRE5HS3RaMVEzekExN2RIRDdpKzVaMGVUUFAvYXpLaTNnSTJu?=
 =?utf-8?B?UlJDUGwxL0NQbmFlZkpCaUIvY0RPSlF2Um9JZEptSFcvUnMvUmZqQnRsQk9w?=
 =?utf-8?B?RU1wRHVaNWdidFY4MXl3OXdRcE9TK0JFWnIvQ0EyUitsdEUrU2h0dEdjT2Y0?=
 =?utf-8?B?V3FqQklaTlNIS0Z2NUxaMFJzd2NtaVZFajd1SERHSkRCMlBlM3RVbXZKU2Vm?=
 =?utf-8?B?TkdFdzROcnlQUitEOGF3ZEFQQVdoZVpwZk9ObngzeWdzUlp5ZmJwTjk5Rncw?=
 =?utf-8?B?RjZFeG03blYzYkNCMTlqWG1ZT1BLNm1vZkJ3SXRmTU41MmI1cXFTa1Z3Rjl2?=
 =?utf-8?B?Vks4WC9OYlc0WGkwSFVPS3RuNElHbmVaK281L2tkblplbXo5cER1b3l5Q0h2?=
 =?utf-8?B?TWdXUUNOVUl0eTF6R0ppTzZZanZaVTJ1c1JJVWNYV1krQTNZbTZYdUJ5KzB4?=
 =?utf-8?B?c0xiS2pNR1RielFsT1EwTlgrQUl2QnFNeWtKUzhNQ1lxMGV1NmpjUE95dTUv?=
 =?utf-8?B?OU52QkdXVm12SE1NS2RNaThSRWFuODVaMC9GSVoxRkxqaWVnUk8wVW1nRXBE?=
 =?utf-8?B?Ym9Cb2VxWmVGc3cxamtrRkx4cVhJclc2R2RSL2diT0JQd1ZzaTVkTE9HOHhQ?=
 =?utf-8?B?bHhLdlNjNW1zZ0MxWHJIZnorRmFNR0VwdnNnOHQ1RnIzWVZiOFZPbmgwd0pE?=
 =?utf-8?B?ZGJ0aHZMcWRoVG0vVVZoZFdCOUJXVkZSSlh5QXZ6TDd1Tk9lbVczREs0TXFE?=
 =?utf-8?B?N2dxMS80a0czeXBpbkkxVWlJQml5amtlanVtaFQvSFRsU3kvZjljZ3dzTVZh?=
 =?utf-8?B?U2o5SGoxckpvRC8xenMyS29IUGR1NjNxVDkxZTR0VGtKNE15cHdHUkFkSWRr?=
 =?utf-8?B?UHR4c3Q2YlEyNVJCdHhwSENMT3pZMlV2UVZTQ0dFQU82c0JQTWphZ2NwZlNq?=
 =?utf-8?B?Vk5VamtmcG9PUEtwbFpEVnlHWjB0aFJiTDRXRW44bzN5Y3JBMWcvU211S0Yw?=
 =?utf-8?B?MXFCMElhQ0MwVlJwOE16YmJzajkvUWpPMStTVlFkNTJJOXdMMTEwa05qMVNS?=
 =?utf-8?B?MXE4Zko5elVnRjY2RHB6UjBac2QybWZBaU1aMUNJV24vdHN1U3hIK3VCSXhH?=
 =?utf-8?B?ZGQ3MGp4RVRFSmQ3YkFmdlk5cmlpZXNXUXdrRnpLNWVDTE9jVS9BZXNMQXA0?=
 =?utf-8?B?NmNHazVQdFJGVVVQc0RpaitUektZZlliM1pjTURpSzRqd0hXcjF4dHFPRGdB?=
 =?utf-8?Q?qFOnzFEqUejBD6+i84=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzlUYzBoSVFSNFY0ZmJ0eGRoc1NzMVE3WDBpYVlGYm9hRlpEL3ZjN3RzNFFz?=
 =?utf-8?B?NXk1NklmRUhKZHJVMGZDaDJ0dDJuWVhGa0I4em1mcTQ2cDR4YllGUENhbXpN?=
 =?utf-8?B?cWpqR3RZTmNmNlFTOGVucHZtcXhUaXdYbDZadWw5V0tPRWZOV3gyQU9hdU5v?=
 =?utf-8?B?K0xpNjI0bGxrUVpMblBpM1VTeHpZN204ckszZ0Jjd20zKzNsSW9FMXBldks0?=
 =?utf-8?B?eUdXU3VLQWMvVDNrVG1EbHR5UnMxbXU2dkluUzE2T0N0azhHbEFhb2VmWEFq?=
 =?utf-8?B?NnZ2SzBVc00wd2hYTFg1UEVvbFlCK1VJK0RVbDZFdFZZRm9OUCtibTVDSjVJ?=
 =?utf-8?B?MUVGYVFUWU1NWk5rR1ZJRGkzZE1SS3JubC9ScmxqTGpxYUdCNjB3QnkvREZU?=
 =?utf-8?B?MDRxOGJVSjloSDFBQkRybncreFlkcXptSGJKaFZLNmtlUFdCMG5ha2pWYVFl?=
 =?utf-8?B?UGhNK0tGRmxKZGhoSFFYNG4zUWUrcEk0cWVEazgyQ1dKZWR6RGdxUUMrcUZK?=
 =?utf-8?B?Um15Q3RRS1lneHVqVTRybUZzUnAxSzFMRUgwOVZxdUY2WjBtUDN0UHh2R05W?=
 =?utf-8?B?emRGbWdhRDdwSVJFbVBsM1dlS0NvYjBIV2hjejZWOGxqNVIwMUdPTzdxaHBq?=
 =?utf-8?B?OFVCNWlia3MwSThjZzVQaXUzKzNOaUUvd2w1YUE1WmNqWGNFR3hUQ1FnSWtx?=
 =?utf-8?B?bTBOc0tNTDYxRWNKQTBjNklzZ2NaMWI2Ym1uc2ttRjlsWVdGRUFGd3VSMWRR?=
 =?utf-8?B?dUxhZU51S1FCOWs2VmFyQVJCdll2bmVPVjJHV0RUbTlERUNNY3d5MUFyMEFK?=
 =?utf-8?B?U21CcEwzNVlINmVRb2ZUWnB0NXZkZ3F6dzMvSXY1VHJpOHNpVTFmRGNsNFY2?=
 =?utf-8?B?Z1NaeEJ2eS93UjFEejRDVFNVK2lVNUcyT0tsRG1JcHRXVW53SzUrNVJ3VWhj?=
 =?utf-8?B?VGdSOWhPUU9ob0pMV1pSVFhFMUxUU3hRd3ZaVm5LTXoyTmlLRjBYRHh0YXZx?=
 =?utf-8?B?ZmdrTncxNUVOdmtDclNiMXU1eVdSTjRSSlNJQzF0emJ0LzBHajJ2TUdWaWU1?=
 =?utf-8?B?Nit3b2tjb0x2NWFTOWVUNy85OGdDOGhvbndaWTJxVmlHSHNNVVgxSmliTE9h?=
 =?utf-8?B?Ulc3OVpCb3kwYVpsdTFRWUV4N2ZPZ1M0SFlUWFFyUTRtYlVlend6bEw2S0Q4?=
 =?utf-8?B?N0FQeVFnaEVFL3RlSGYrbTVjUjQxS1YxSDhheXJ0ZHFoRFZTWFR4OFhoTmNp?=
 =?utf-8?B?UE9QSVhYVFl5OGxndVlZdjFUdXBCQ0FaQmNSM3loSEVxZVMzaXYxV0NaMFpL?=
 =?utf-8?B?MEhzK0NuSGxFbFB6NXN4S25paE5ZQTJCa1d4c1lCdkFlTGZkcDIrcUx2WmMz?=
 =?utf-8?B?ellBM2VlOGkrSE1RZVZGTlJ3elRaQlZhUXhpQ3pKZzdLa3E4RXdLalRpOTBl?=
 =?utf-8?B?K0tSUzRCb1ZTNmZIak90WTF2d1N1d3dDRkFjNFRUcTBIY0wybTl5RGQrY3A0?=
 =?utf-8?B?MWNZUjB0RFI2TWJMcjNmSlJyY3hnQm1VSWZrNitkWHpXd0NVZ1BoQ0RmaHRO?=
 =?utf-8?B?WmdPTWhSUU9yeWlyVytNU2t1L0ZWWDk0a3ZSTnRGKytZbjFzSzl5WnpMZ2hl?=
 =?utf-8?B?T1V6QWc0OUZVd3ZKRlhDS2hHR3VHb1o1YTJZWkpzOFlhU21OeXdRNHFhMGEw?=
 =?utf-8?B?TnhZRkFQSHZFUHpsVyswM0h2a1dQU3hjeTU4c0lhN09XdTdaUkhXSzU2MzNa?=
 =?utf-8?B?R0FmNE5kamlkdGF6SkhaSGxhTTNqRFpqTzduS1hXSDRUQTg0dmhpQ21leWti?=
 =?utf-8?B?Vy92TnRTTHNTa3VQdEVxTkx4MzdnVWhHNEduN0o2UVhqaUE4a25xdkFyY3l6?=
 =?utf-8?Q?hdR33vETa5VCr?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-e7640.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c65f3264-4142-43de-fc04-08de60bbf015
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 11:29:04.0147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P194MB1810
X-Mailman-Approved-At: Sat, 31 Jan 2026 14:41:19 +0100
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

If i2c_eeprom_size fails, the error value is stored in
variable size and not ret.
Also, this commit fixes printing the error value.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/ge/common/vpd_reader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/ge/common/vpd_reader.c b/board/ge/common/vpd_reader.c
index c28d2c03cfe..2422db38013 100644
--- a/board/ge/common/vpd_reader.c
+++ b/board/ge/common/vpd_reader.c
@@ -215,8 +215,8 @@ int read_i2c_vpd(struct vpd_cache *cache,
 
 	size = i2c_eeprom_size(dev);
 	if (size < 0) {
-		printf("Unable to get size of eeprom: %d\n", ret);
-		return ret;
+		printf("Unable to get size of eeprom: %d\n", size);
+		return size;
 	}
 
 	data = malloc(size);
-- 
2.43.0


