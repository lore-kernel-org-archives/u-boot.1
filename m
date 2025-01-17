Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A45CC02187
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D21E80713;
	Fri, 17 Jan 2025 02:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="cwwSs79b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB39680713; Fri, 17 Jan 2025 02:42:41 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A870580312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=df3WV55hqt24WTbYT0d8NcSA8i0xJbZRufEurjDolgqqJFFtYC6Eq0DAD/SpuUFaskJ/uX7CaQ8hygz9Z/UYzKSj85TMLXKBtVoZilCG1XLNbgnA6UjUVGQZIlWWMKmTYoryHHm/MOy+eW2mfU47/i//KcDMcnCB4E32Now8jnS3TV0CBJXSgMGsi82HjcO416OadGM3q5HcFhMq0uO1ri5dB5L5FkTPuNdtb5NfjugoIpqzfrMDH0q6JYRfGHmFql/JFWpun1KqpoaSkfQpp665GvjLcd39W3TDNRlYBHJTY7wCNyTgLZ/SPGh+8MEtbV2Of9EfoPTJ8G2g22vKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U87xUmK2ZlzwYrW/tL8JDjm6yvnuxPl7yhSCxcgyWpc=;
 b=mU2j+GMlwmA0tRiThxLYRv+VVOfPpY/79IuiDJ5QZmy1rbkdVmGjpS+/5WTuxiKGFqiCFOn4mh806ENrcW/EsSLhCEBO4dIkewz+rDQ20ngv7wFP7KmAk4XEuDoemKmJ8hzL396SIf+ds8DKCTipcFoHpGyWkVJJdRzfMggdRPFOCYMqaO5rYsx3O01YJJw6WgVN+i5BE36oOmB96E06MZbOQEQycB8QAwzt2E2sJLkY2sCRrIF26Bafy6MUhq9LRR8YGe2xKCTwCm0faRwK+KkrV+3EFT83mXmG8StSIIzBr/A2mg3cBSdgXQaYW0HKKQzxMDYaFS8VO6uy4mx99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U87xUmK2ZlzwYrW/tL8JDjm6yvnuxPl7yhSCxcgyWpc=;
 b=cwwSs79b+dNeoBfPcXGMChGGqJ6+/uhIverWxey+vuxOwLV8aqZcp1Rtp7a9W4SnUnYsUx2q704sAZcIahPz3lCxj43zKDm1PKFPu3oS+jFFLm7/QAtO06xzyX68CGxPqjiLb/MlskKGBxwYkGcBEoukt8po6oywsFacyjwaA6SAE2w0hfIKUZGYB2pB2NXyMn4BBMqX1aJR0U2BbNWfmSnM9BiqVzKFzlvRiDHsAbY6pBBwU1romBeUo1uxv3M2viwSkrOnQeG9mBEe1eyDJfeh+/9DdCcin1HfnonYjRifGPpAf57eCRIXyIDbVnemuG8uXbRmjLIxw8UCZD4ShA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB1809.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:5c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Fri, 17 Jan
 2025 01:42:38 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 01:42:38 +0000
Message-ID: <1c3f5c71-64f2-4252-9800-ee1a3d6ebf5d@phytec.de>
Date: Fri, 17 Jan 2025 08:42:33 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] configs: phycore_am64x_a53_defconfig: Fix GPIO
 controllers
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: d-gole@ti.com, n-francis@ti.com, mkorpershoek@baylibre.com,
 upstream@lists.phytec.de
References: <20250116112932.1983801-1-d.schultz@phytec.de>
 <20250116112932.1983801-2-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250116112932.1983801-2-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:820:c::12) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB1809:EE_
X-MS-Office365-Filtering-Correlation-Id: 1604a1c7-8c4b-48da-776b-08dd3698395f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmF4WnpWWlltbTdlVnUyWmZsdnJNemtqSjl0dFJMN0hNSGp6Umpwc3dtdk92?=
 =?utf-8?B?bFBLUGMwbko2SHN6UnBISlZQSmIrOW1QcENSNDZsSWZXRlI0UWxtM3E5OXdU?=
 =?utf-8?B?dmlUL0xVMjh1Z2lBdXZwbmhzc2VGYXVKMml5ODdEUG1MWmtwLzMzZzNYRG1S?=
 =?utf-8?B?YkJLM3hoTlNMN294Mk9YRWcwWUduV2NGVXNzcVAzNVVvTWZnWmVsUDlWaGUz?=
 =?utf-8?B?SEZJY2JBbHVHZ2piMkhSclM2bWdCSmxDZmNra2xIM3llbUdkeXVkZkoyb1BG?=
 =?utf-8?B?dzRmRG9aNUEwY09iRUh2Q2tEVS9kT3BXMVF3QmNteFRCUUVKT21EcGxkRDZT?=
 =?utf-8?B?NTBTemV0azFkTWM0cThFU0M2N1JROUlsQlJaTVJFbWhwRnJ3S01Ib0ZGc3JB?=
 =?utf-8?B?MHo3dklEcnMzSFlCbVZPVzJOWS9xQncya09LV3B6RVorRXZPczB4aTNobmp5?=
 =?utf-8?B?T1A3SFNOcjNWOEp1Q2x5MWhTQUZNMmlEVklXM1JxaEVwZWQzeHMyaU1hZ1VN?=
 =?utf-8?B?dVN0U3k5bFhHbE5UTldlcld6K0wrdG9xN3F6U3krLzNmdkxpRE5RWDJHL29P?=
 =?utf-8?B?VC82bzNHTXhSakJoS0IvVExjRGNzb3dBT1o5Kzd5UFJ1U282UzdRTGtMZElV?=
 =?utf-8?B?SGI4M0tTb3BaTGVyVDdBQU16K2lwNE4xS1VVaXlEbVl3alJUcFc3MkJKVC9x?=
 =?utf-8?B?bVRzdEl0SmtKdUJtSGRYQUk4czR3YW9OMjVmbk9YMGMvaWw3OEtsTU9EblBr?=
 =?utf-8?B?aHhXOExHZzRnODlTZDhiekNiMTlGZVFwdUNwN2pFd21McEoxTEd1NGduUGRi?=
 =?utf-8?B?WlJGTzgyNzMzUng1Q3o5a0NkVklVNUhxV2dreFBTRmVDQTY2b05OT3pUZU9o?=
 =?utf-8?B?Vmh1TTVEL0FhUVFRSktQRkJ6S0Jjdi9MQUFDbGxlaFZJKzRkY3p5a0xPcm9F?=
 =?utf-8?B?UDhNRys1dEFaVm8vOEtubFdLWEZFUUtDZ1BqMlViYmY5UnpzZjZxak9Xckxx?=
 =?utf-8?B?MDVld1l4Uzd6Wm5YNld5YnpCUkpvVlg5K0NKVGZxNTlJUHl2QlNWY09ub1pD?=
 =?utf-8?B?M3phbkJESHBhYURKUVRXL2VwWHo5MGZQaDRzNDM1VUVYUnZDaWk0YlhHbGp5?=
 =?utf-8?B?ZzZpdExta3VYak9lbmE2YkV5dzNMeVdxWnRHTzZxQ0dyWkErZStmbXp3c3dv?=
 =?utf-8?B?allBY0NwYllHMTBIdkI3OWZqb2E3ZHlFWWluelVqcHNUVkZ6UFhFbnBuUEY2?=
 =?utf-8?B?dzZTWmVjaFdpQXRhRHlDN0IwSDdDd3hGejFiT0pKcjFOdVFPMEtqK0loaldh?=
 =?utf-8?B?SXljZmZTL1c3YWgxSFhZNzZ5Q0RuUGZ6czY1NHduOVQzb2JvZTVsOHdjZ0RZ?=
 =?utf-8?B?WGlpSFZzMHNDdGF3UW0xYnF4bC9MU3R0eXNvd1JEcEQ0bzdzMHR3SXZVQ1ZZ?=
 =?utf-8?B?Z0cwaDd3emozcGExQ2VTSFo0TStOVm5yNlJwdjZuZ2JwbFNrT2txY3RyeFdR?=
 =?utf-8?B?RlpWeWtoVnJrcmwzVTN2elZISVlqWk5GQTd5WXpUY3pISVFNYlJwdmhuYTVJ?=
 =?utf-8?B?T0Vid3ZqTDRSL3VKekJLQ2F6K1ZUUi9MM1BmTlR3b1ZaRjE0d2NRTCtXNlph?=
 =?utf-8?B?T0dkNDBzR2c0NUt5UHR0OHUwQXdZY1VhaEdvbWxxb0JXRDV0MGhpZjR6dklk?=
 =?utf-8?B?R0xMUk9ZUm1JRXh6TDZRb0wvSTJ1WUZyeUUwQ2Q2Q2FpTUhIZjJqaS9VSkVw?=
 =?utf-8?B?NjNKamJWVlFDMXVxeGpzNHhEQVg2bENzbzcvSU5HT0x3dU5ZcjE5MzVzWDZi?=
 =?utf-8?B?V1FENHlqWExxdEhsYlNFSHJidXpSTzVhZWhvUnJFWG82YkowNm8xSmZ0Rlpo?=
 =?utf-8?Q?DCcJuVKmwaNhB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU1BTkJXMmxaR2lNOTUyajMwaWV1OFczdmtkVXZwQk9wc3Q0WUhSSGRlaXlF?=
 =?utf-8?B?bFJhWmYxdUVtQ1ppdUdvajV5NWhlYkdqRHdYdmpUTkEydU5NUzBzY1NPNldK?=
 =?utf-8?B?Y29kTkI4QmtLanpsVjYzK2cxV0NHaEd3bDdZTmc1NGdHVG5GTlQxUTFwekhk?=
 =?utf-8?B?WXpCaUlzNmZzWEdqT3JSNTV4M1VWNkIwWUtpVkV0a0hBaEdFZTIvaVREZTJF?=
 =?utf-8?B?blRNNkNqRDZuNWdpSnh0NzcwVzAyTWl6Tk5RNkE4ZHVQUHZ1UWdRaDJnbTlx?=
 =?utf-8?B?YWZDUG9wSDMvYmRyTmduSnY5Z09oZmt3cFp1NkUzT3FxajEzclhtSUxUVUVr?=
 =?utf-8?B?OUV3WEM0RHYzMEp6SGNuSi9DL1NYdFNIdk5qekl0dUNmeUhQZ0M1VWRONVl4?=
 =?utf-8?B?QmFhSXM5TXNldWszM2dncXZoSldiTSsvNTBLbkR3b0Q3QlZSNm5Xb2RiREU5?=
 =?utf-8?B?dFlWOUFRWW5BbUV2VEdhdDVnWFFYeEJCUWx4RzYzaDNoeXo4dWR2STJpU3Vj?=
 =?utf-8?B?dGRwcUdub1hOemZWMVd0blNrS1R1SS9pTW5KNVlKNnBsVUdYeEx0QVRtQjVP?=
 =?utf-8?B?bXptOGNGZURLV1ZMTEhTeCtHSHl2TTcwYUxxaWFDaWNhalFTajc5d3RzQ3BH?=
 =?utf-8?B?NzJreDQ1TzNpcXRLWXpOTDdrWWcxTi82ald4ZnRJbmtZWEM2bmVyRlZ6Qjht?=
 =?utf-8?B?c3RLYSs5cU9uN0hsSG1VcmxqNVMxdWg1RjZMVmxhZFhnckVCQmZNTFBkWU9N?=
 =?utf-8?B?NU92UFVFcjJFa1pHQktwSU5lRC9YYVpGalZjQUw3eE1YZVNyTTdVS1NBUEIv?=
 =?utf-8?B?ODk1bXR6M3RZNUJXakdrdjdVYTZseUN2UEdNdjIvRXlxbnVIaHpOVkpNcytz?=
 =?utf-8?B?Rm5RNldCVXo1U2dsQ0dQUDdENktGdnBtZlFWckNFWXpud25PYy9hVDMzWlVY?=
 =?utf-8?B?L0ZyODEwbVBiUy9hUFdsSzBzc2ZQdlFTUnJHQjNyKzlQdEdyUkJRN0pmVmRt?=
 =?utf-8?B?elVxekZHdmJmZE9rMjVkV01jbWVscjdONTRYUy9tZTdleDlMMHpDaHBjb0ta?=
 =?utf-8?B?NVR1UEZOL0REUFZCRlFkSHB5ZDhkTklrT0ZDQ0IwMDhnWHZqTjNtQnhYZ1dm?=
 =?utf-8?B?dWh4RGs2eEFHN1NBbzZVdGZTQko3WTdCWjVzVEJIcGlrVkpORXZRaTZubWwr?=
 =?utf-8?B?dDYrd1BWa3RRdks1WGxqNHlzcXFQZEZPenJqLzdkYWR2MmR0ZDNrUjgxVDIy?=
 =?utf-8?B?R0xTMnlRLzByYm53T0dQKy9uMFlHbTAwN3R0azR6YmtTT1RMWFhObit3MXdr?=
 =?utf-8?B?RThjamFyclZmTHNkWEk1dG92cUlyT3BOa3hVazZ1cTJ2SGx5NnhEQkEzK0pa?=
 =?utf-8?B?eFZ0amdZbGhnb1I3Um5qSDJLeFlRd2ZEbUpuVm5sUXJ2NDk5a1JpMnFZbWpM?=
 =?utf-8?B?N25mZzVRSlc1QVBic2NFZmdvdC9OQSs5VThaY1UyQU1ieXl1ZzZiWDFVZXpN?=
 =?utf-8?B?cmh6QVBxWlBmY21ZbU43cjE3cUdGZkE1bGVtcnZ3UWM4ajBVZGtoSkRBTmgv?=
 =?utf-8?B?M0JFeVd5bkpOc2hBV1g2U1VCekh3ZWJFaldhWFNxdTdpZFdFMDhwK3Q1clNs?=
 =?utf-8?B?TWZ1cm5RdmZ6VmdQRWEzcXAxalhFdDF3SkZDQ1VzVmR6YW4wYzNSc0RRVEhw?=
 =?utf-8?B?MlNSa2VNVkxzTEdkcjZUVC9wYjZ0ZXk0bXNtV2lrY2pVUThJRUhlajV0ZU5L?=
 =?utf-8?B?YW5SVGIvaXZYeEk0QldZaGwyejVPL1ROaktJeml5ZS9MWnhjRDRLb1dxblNt?=
 =?utf-8?B?TEZxRmorVS9QVFJ3V1prR2xNMEc5UFpoV2JHY2tJQWJHaFJrdGR3S0NTeUJL?=
 =?utf-8?B?ZUNRdnRtemh1akp0VjcvWURHejBsQUg4V25XWHNVMHM0UW13QmFtSWZvZFJ1?=
 =?utf-8?B?R2F1eHhma1JHaG92b2FQeE1nU25QY2FNN1d4QVU5bmJuT0U4V3JEajYwL3Fs?=
 =?utf-8?B?cjlVd090ZVZCNEhma0lNbEc2WHphTkdRNlRpT1R5SHVYa0dFN2tnNitGMHdR?=
 =?utf-8?B?Z1hEc3dydEVsRzJKdlpLUjRtWXlkYjhrUTNFSWc1NDdCQkROZEF0SXNObzAv?=
 =?utf-8?Q?KUlEU5L2MlMXfCTINUMbVJLQX?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1604a1c7-8c4b-48da-776b-08dd3698395f
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 01:42:38.4654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfsyeFdtPyhjM+F98iiC677+GTYLbS+ywcQCPKdjc99JLN0MrwKnnpvMdEnXF5ihkakPvHZFTtx2bukxPtiXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1809
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

Am 16.01.25 um 18:29 schrieb Daniel Schultz:
> The phyBOARD-Electra does not include a PCA953x I2C GPIO multiplexer.
> Remove this configuration as it is a remnant from another
> defconfig, and enable CONFIG_DA8XX_GPIO for the DA8XX DaVinci GPIO
> controller instead.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   configs/phycore_am64x_a53_defconfig | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
> index bc450004722..4b9dcceda45 100644
> --- a/configs/phycore_am64x_a53_defconfig
> +++ b/configs/phycore_am64x_a53_defconfig
> @@ -112,11 +112,9 @@ CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
>   CONFIG_DMA_CHANNELS=y
>   CONFIG_TI_K3_NAVSS_UDMA=y
>   CONFIG_TI_SCI_PROTOCOL=y
> -CONFIG_DM_PCA953X=y
> -CONFIG_SPL_DM_PCA953X=y
> +CONFIG_DA8XX_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
> -CONFIG_DM_I2C_GPIO=y
>   CONFIG_SYS_I2C_OMAP24XX=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_K3_SEC_PROXY=y

