Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7259FE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B3E18036D;
	Tue,  7 Jan 2025 14:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="CXtiwp3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F74580613; Tue,  7 Jan 2025 05:39:01 +0100 (CET)
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com
 [216.71.131.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 224A7805F5
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 05:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=09510ca3a=alexey.karyakin@uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
 t=1736224736; x=1767760736;
 h=message-id:date:to:cc:from:subject:
 content-transfer-encoding:mime-version;
 bh=4HKIkwU/K13EAi5YX7EdmEsKSiBNaMMAN0BMetZPFBg=;
 b=CXtiwp3Q1Rx88B5qK0OMDwCYY1hjpzc/C/fJ9SRcHq6W3oThle9DUQzY
 NmPIfaI4BEDf+9co9heEC3irm/gJetrOYg46kdS2BqdMRG74+8nlCq5j/
 WQHqThtN3aa0sD3swwUpYREmVqk02z2ft4X5bDKKSi/Ugqa3EepziVD3Q k=;
X-CSE-ConnectionGUID: UFYyjnU7SMyFe6vRph5Jsw==
X-CSE-MsgGUID: DyE0+Gh/RECWfk5uisnKJA==
X-Talos-CUID: 9a23:7o7Ax24SO3/r4ElTaNssyWAlC8IjTyLm6Wb+LhGmM35pFZ+OVgrF
X-Talos-MUID: 9a23:bK8KDgTKMuDliIqPRXTAlRw6d+hopJ6DI38DksgbutKCFg5ZbmI=
Received: from mail-canadacentralazlp17010002.outbound.protection.outlook.com
 (HELO YT3PR01CU008.outbound.protection.outlook.com) ([40.93.18.2])
 by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2025 23:38:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4HhwAWMk96GfpZeK8rtwOOvwCDnQw4uEux2V+dG8v+tJzRn3Kj0xDzbN1DZc9K6j+tLguyDX8rTNUC7jX9cSDx2nHaQ63FLbptRZe16c8yTsR3a7u/mXMZD50nALNvGbMZqfdZzRpyDXgQdC2HWYQ8KoYJxOAZpSokgdA0KZo8WiblN2ySav3p9V9pU8fnNicSHnbhCl4nolTLaUGZ+M4lw21Jc807pfKYETZx0rDJ1L3vyUEUYJdACTAOUT1n5yyX29GGn5GDRz7OdwDfvjbgadVCiRxQmFZtqhNru7boQAV3hcGNku2oMQwmLY0VE/RU/1JYHFAdheKDj+FF4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrVBD0PvNb5iLAw6qqBV10ezGKJ7uT9bXvE+9C8/kKI=;
 b=dJNCA1OfGpp7vRte5hALE6bgc3en7twZOpaHq8MDN0lND6RnbyM3/AiZeJOJ2gmUYrGvFLQ3FRgXx7p/myzJTKxfcXiVCf/VpRD050G+avvKOYiGBAqt1Xp+U1i6bVm9Sp62QuilWaGghfYQjz6Ku5wAYllz5l1ouS0BL7kCgw9krbv8RqVN6+Og0LNBx4XHMfsSCZ9oNfpYV22ossHYaWzpSgz2/oU+qNvNs3Zo5NfOL2j70pYWh7qRu/Hb2edlX4A44puMVY2l0XGBzHwhIxjsdnvgxwPcXGPP8BlH/nwvmj+31n50G651VvjtP7W0XOm8wKqIBFkbzN+z1Df+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YT2PPFBCF6325C7.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::47c)
 by YQBPR0101MB5638.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:39::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 04:38:52 +0000
Received: from YT2PPFBCF6325C7.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ab7c:189:d6b9:f604]) by YT2PPFBCF6325C7.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ab7c:189:d6b9:f604%6]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 04:38:52 +0000
Message-ID: <865391d7-154a-4382-83fe-999b0c1236d4@uwaterloo.ca>
Date: Mon, 6 Jan 2025 22:38:48 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
From: Alexey Karyakin <a2karyak@uwaterloo.ca>
Subject: [PATCH] clk: sophgo: Use clock ID translation for cv1800b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0050.namprd05.prod.outlook.com
 (2603:10b6:803:41::27) To YT2PPFBCF6325C7.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::47c)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PPFBCF6325C7:EE_|YQBPR0101MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 0193a30c-bf47-4473-1ea1-08dd2ed52f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUxLdWUxY2VjN2RTbUtkVUFKWEl6Zk9NbWc2MDMvSmZuRno0MVBKNTFYR0pC?=
 =?utf-8?B?d09VWDRGU0VhdEkzMzhQNkkzWkhNdjlSbUdpSkt0ZFBhYnlObjdRMCtCenBD?=
 =?utf-8?B?NFR1VVFlNDNwSzk4alhDY2hJVmhjWmhuWld4SFdHYnJMUDRBRVdoVHRmWGI3?=
 =?utf-8?B?VXo3a0UxQSt4VXBwejNkRDBtdHVUQ2duVGMzVGRqV3NqekRKd3Rkd1VvSVZB?=
 =?utf-8?B?VXp0eUUrRFpkQndKNmQvVU9yb1NUNHlYSHR0dFBNVlhBakFRNE82SGsrTUlt?=
 =?utf-8?B?SXIwZmJ4Wk9ySm5idm56bElGZE11OHVnZWVWOGlaWHdCeFBCcUVwU1pydk9k?=
 =?utf-8?B?cndvYTJOMFByZlRwaDlDejQ0KzV1ZlcvNFBCb0pSNnVQRnVTSFZDa3JCODBV?=
 =?utf-8?B?UTNmQnh1NGFQQlhTZUF2ZHc3RjNpZ1ZzNTg4OXllMkwzZGF1VnRlRE81M3pG?=
 =?utf-8?B?bGFaRE5mTGRvSjJ5OXV3dDlLSm4zdXlkMFB4NjdqMlpROURLYnZXNDVrQ29J?=
 =?utf-8?B?bkJZcWNOK0hWOVBuaG9RMVBrSFF6S0RrUjUvNDBnTGdyeHZya3ZzVk10Ky9Q?=
 =?utf-8?B?cWJQTTE1M2FLMnhTOG9GY1hqZnl4dEMrdDJTTzFoZkVxVis0c3ptTlFub2pP?=
 =?utf-8?B?bGR2TDFJQzEzYklRbXdjWHhXUEFhYTJNYWF5MTRBMmIvOVJvbTJRR2VUZG0x?=
 =?utf-8?B?cFhPRjd5djRuOFV0a1ViaGZYNThXcEltUXhpeTRJelNFYUloUmNkMXA2a1hT?=
 =?utf-8?B?Z1QzbjM4TGNjWDg5TUR4MXRNNlNJL3VzRS9xVDN5SUlPTFpPdkRXc0RxbEt5?=
 =?utf-8?B?c2NZL09FMDdsblkwTTE0bHFTdjFSRWI3S2lmUTI3aGR2elhsMXFnK3ZBd3BC?=
 =?utf-8?B?M2lLY1kyNE9aNHo3T0FSV1lHc2tqV3NpcFlmVVNHRXpjbTFHblUycmhYM1M1?=
 =?utf-8?B?Z0J6VUZDSzZtd2hES2x5eW8vWFM1aENJY3NPeCttUE01QkNlSzAyY2RobUlY?=
 =?utf-8?B?K0tzVHd0cTB6ZUNXVmFRMGV0Y0plRGhLZnBIdm9PdU9NZTNVUHpkZ3BtRlhl?=
 =?utf-8?B?a0RHbkVqREo0NDhVeEI2WkxzbklWNFpXeTZTVUt6bXllci9XbkgxY2xmSmtL?=
 =?utf-8?B?aERYdm5BME1QYlJQeCs3ZTFqNnhBVHZUV2txeGhLcWxweFpIcmdUeldWYmVG?=
 =?utf-8?B?NXIwMUpaeU9sMi9IS0xySlFMSC9iQTIyUEVIaXZKUGJuRUJnOGFHSnVZUVpT?=
 =?utf-8?B?a0x0NDIrZEtFeFAzaDYxeTNuNkl5THhrWEMwMFFzd3N5S3A4K29JYXJEODZH?=
 =?utf-8?B?dVRyTksxZ1FFWG95R3k3cGZ6OGZUcDNZRkFkWGlBZGwzQURRc0pUWjZoR2lT?=
 =?utf-8?B?cHNydWhOT1BtNVhtcmNCdC9KU3I4L0hPdmJrVWc5QS9ycFdaMzlUbk9zZWdD?=
 =?utf-8?B?UnFyUnVUb1lZK3RoSEp4RG10cXJyUUhpNGs0ZURkd3V1eTBZNlBIZUtwd2NB?=
 =?utf-8?B?b0prRm9yMDZLdEt0dkxKNjJweXpQc0RQTG15cTVYY2o2dlB5NGZsQXlKK3NO?=
 =?utf-8?B?Q0I3WTlzTTMyNW9qMUYwbUo2bi9COGsrZEhMSkQ2QUhOK0lCbi9GR3p6Lzl5?=
 =?utf-8?B?ZVZmT09RR0wxYmtZTkw0VGFyTndXL1JSOGI3cWJNWWM3enFsRndDdHpReXVE?=
 =?utf-8?B?bkJsMlpDelZ4TU5ROEFQbzlQdllpWTVuZm1jSzB1bnJlZklkbkcxVzVTdmZt?=
 =?utf-8?B?ZnlRMk5Oc3lXekRHcDhhbkVrcHdQR0JQdmk3VzFXa3dRbWo2b2NmR0NQalNN?=
 =?utf-8?B?T3dVc1h5UUZ1K3lOMVUzNVNGZ05FQm5nNDhDUk1PeFhXY1VjSGM0THg2ekk1?=
 =?utf-8?Q?01Jll+CCS644c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PPFBCF6325C7.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnVqR3dnMWNpTkIwM3hKMXF0VSt0M1lxdm1yZTl1VzRPYjRaemd5MU42WGdP?=
 =?utf-8?B?YXNTUVJVMVZlcnVyS2Vhb0h4bDRDZUJHTmQyUU1uSmt4aEpZUkdwcnd6cjlu?=
 =?utf-8?B?OHc3UlVMM1RDZmhXRTFuOXdERThrV0dsaFhvWE1QRFlienBPVkI4eUpuY2JW?=
 =?utf-8?B?ZEN1WU1kcnVTbGROVk94c1B6MjN2WnlTMzdSTm1uTW5kRzFpZEZBSVhpY0Fi?=
 =?utf-8?B?TG0zQ21rSTJGUE5rRmdHZVFwa2RSZUZuOWY5d1BxQzFJVnA4Yi94ZHNtWE43?=
 =?utf-8?B?aHJHelJ1M01ENnJ3SVJmRVlkOGxnNG4zSnBZYVFhNDBRTXdEOE84Q2tUblI0?=
 =?utf-8?B?NlRXNmtwcjRqYlNjK3dXR08xVVlqSkFHSjdLamhFTk9tMThsUmVPRm9XdmJ0?=
 =?utf-8?B?S1ozcDlncm9VUytSYUd6TzdaZXVpR0lTalhlRGd4eElPRUVCVXBGSkJLRHVj?=
 =?utf-8?B?SGN4Q0laQSs1OTJoUno4QmlmUXZqVVBQN1dsNkZiRHcybitlVjZ2Qm5lRXZo?=
 =?utf-8?B?aXZKOGRBTWY5WFlLRmtFM3lYSVMzam5PNXhtNkQ3MEFxVHRYZnhzZUxRTW5C?=
 =?utf-8?B?by9CY2c2ZDVZSFhlay9jOWhBTGhCVkZHa0Zwd3Z6WllOb0lhYWNrSjByRXho?=
 =?utf-8?B?Wldqc1lMT0lXVWluNVRlU1pjbHpFN1E5dkUvekJSTU9wYm9ncG9vVXFYQWNn?=
 =?utf-8?B?YjNXb0pLaEdSbnZmVmpGTlNibDJSZmlrSDFxTThaZ2diVnFXQkpKdDJSS1d2?=
 =?utf-8?B?RXFjYTZHeThOVlN2KzkwVHFtU0VWUG82MC9HSmhnWGNOenhmcnRRTjlFeEFL?=
 =?utf-8?B?L21nVWRabkRuWWxoUnFOelhEem1iR1NQOXJTV2srd1ZtbkNDdWw3eXM4cUdV?=
 =?utf-8?B?V2duS3pzWWVxdisyMmhQT2lnYnhqSElZc3UzSGhYMU1qMklXckM5VGtrOU5T?=
 =?utf-8?B?a2xwSm9reVdVcGhhWk5SajRGbi9oSzVxb2hmY0QremgwL1RTOVNXcXg3TkpD?=
 =?utf-8?B?SFR2d0N6YnU3YU1kc0NuUXhCeUsxNzhpUFptV211NFlHeG0zSEowa2dXTzgy?=
 =?utf-8?B?NmJaYlRHbElLMWRtY21FeFhsSDBUczBuMzJjbTRWSUtlSjJWNnBKQkR2UHlo?=
 =?utf-8?B?MjNxUTNwTlkxbU9EYXFqTVY4R0dTWW5waEVUcksvWnpCMWFpTEJyc01ldWRQ?=
 =?utf-8?B?bjBrUjRwZ3RGd1pNWVF4ZktIQVdnMmFTZDgzM2lDQ014VXVBS2t4YUlaUUZt?=
 =?utf-8?B?NWlEaUtJWkVpUVlSNzZVaWdDM2FIY2hnTjZGamVaYWtKb2c0c1FPNERRd1la?=
 =?utf-8?B?VFV5LzN2bndaVnhMaEhJSDhoaEJtK014THkrQmlaSUgwTmxaWk5QNnRIcVhD?=
 =?utf-8?B?aVIrMFJhbTNiOStoWERHQXJ6ZEVWbmNzRWpBZkEvcVhVZTVUbFNsNUllVFBW?=
 =?utf-8?B?a1pDM2UyNGlnVjBvQXNyanJMbWNrZDZnTXc4bXhGT1k2dk9JTGpyVk9Uemll?=
 =?utf-8?B?aGRQQWlibHV6RWorUTRFMVU2QlNJR2psV3h5ZUFlakd6eE0zem1rSUVYSkRo?=
 =?utf-8?B?QTg2ZmhjRW56Vjl5bHRPWDVWSGZCaXpIeXZWamErbk1kUElrbWVaQkxPZkhF?=
 =?utf-8?B?UGIwczVRMFpybUYyTU5aSjNqakQ5WEtaU2h2RkNNM0I2MUJUR2J6ZExoUGZk?=
 =?utf-8?B?QXlzcUs2NTFlSFZBaTdWVlZmM0txN012RlhJZkIycTBzMFRxakpnZURYUGlU?=
 =?utf-8?B?dlU5bERzZFIzbWFQdy94MlpZWGxNc3JKVXNDNDhsVWRoM2JXdTVuT2hWMFl5?=
 =?utf-8?B?NUtqL2t4ZlpzNHF3NDhpUDEwb3MyQ0lJMXRSSFFhdmZ6cWpRSWdOV0JjSmZx?=
 =?utf-8?B?cVdiMi9DSHVjTG1SeHVkamJuS2wyYldLRGgwMGJvNG9TbjlSQmI3aUMvUnh1?=
 =?utf-8?B?RXJnWlpBdE84N0tKRm02b1BLeE1OU2N0bk5Nem5WdldLNU5LckxXUjZtaTBH?=
 =?utf-8?B?V2NnM29QeDZiQVpVYU8vWWJKY2hUWmZiWWZaUGl2MjNSOGYyL0hxRENRWHlp?=
 =?utf-8?B?WkJNMzZsTTlBZng1YnJ4RDd3SjJOcmFXaVJVdWFiK3VoVUdIWkQ0dFpJQ1J5?=
 =?utf-8?Q?R63j+PIHmgO2DPYbeEEkr6+NV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2Ub9q9QP6ctGnb6l7gYCD56ohMiVnTNIlq2MFNVZhlveOaCO0hmUmI54OtmMVEP4VdssQCg5wcKzYWysHPxFjbVEdqS1yHEz4GrGCvDx+E2RmpgO+S3i0OJXJIMcWFjHqYVSSId89kFQwpgy0+Lsgwb5VHPJ18yNIkOVEusn2e2P4R4sHaoK/hiEavMTYIGjs1pb6M4/3N+Bawy1A/j6oiTfqNqyFguj9Q0OM0q1mvS+S7SVxSB0uOUgg44WDTFlDtUFSni8d7mlJubq7+HqiuvB2PKo0xyk4f4YFWd8AB+yKbHZQirrKeB0Se4yAqJ4PZUOefh4plO9gKnBzPtJ5KkztzFC7eWbNPjmCDZTX9mvMO4Tgy4KxVc3+flqEtjPrTGcQV4ZMb9nHna7eikochfQIPgOYkj2SP4C3N6V/9Nu4RkEQv3+2Pw59WYH/L5LqhUryWPNQV54ZjT08Hls1fRocwbjH7bnCWHqiv3i1w/I1ZwtNQmt0U6AW+e8f1TUj3jSl+O9yuY83ogfdGAWXs7N0QStiE0lewH0psFsSNJtBF4Kuk7X1wqb/jrkweBL++2D2dYxXwlXo0kwxnR0/J4J0IsDJJfim16ZGBItNSW6mpFuiAsmymbt6bSQGXQ/
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 0193a30c-bf47-4473-1ea1-08dd2ed52f9b
X-MS-Exchange-CrossTenant-AuthSource: YT2PPFBCF6325C7.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 04:38:51.9558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qe99bEzuhy8fhMwuAZ8aaIs6GjToEYYwx0l7Kr/pYw4AnNilcB1QeINF12Z7xVbb6JGVwwmRQsFk22ydO0HOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5638
X-Mailman-Approved-At: Tue, 07 Jan 2025 14:15:01 +0100
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

The internal clock IDs are shifted by 3 accommodate the "osc" and

"bypass" clocks, which IDs are not included in the Linux device tree.

Currently, the `.of_xlate` function is not implemented as the conversion

is handled by custom versions of the clk_ops functions. Unfortunately,

this does work when clocks are looked by using the device tree API

such as `clk_get_by_index`. As a result, devices pick up wrong clocks.

The problem manifests itself when intializing the ethernet controller:

Net: Enable clock-controller@3002000 failed

failed to enable clock 0

No ethernet found.

This patch adds the `.of_xlate` function and replaces all the custom

functions with the standard ones.

Tested on milk-v duo board.

Signed-off-by: Alexey Karyakin <a2karyak@uwaterloo.ca>

---

drivers/clk/sophgo/clk-cv1800b.c | 70 ++++++++------------------------

1 file changed, 17 insertions(+), 53 deletions(-)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c 
b/drivers/clk/sophgo/clk-cv1800b.c

index d946ea57a46..eab57b18b13 100644

--- a/drivers/clk/sophgo/clk-cv1800b.c

+++ b/drivers/clk/sophgo/clk-cv1800b.c

@@ -678,65 +678,29 @@ static int cv1800b_clk_probe(struct udevice *dev)

return cv1800b_register_clk(dev);

}

-static int cv1800b_clk_enable(struct clk *clk)

+static int cv1800b_clk_of_xlate(struct clk *clk,

+ struct ofnode_phandle_args *args)

{

- struct clk *c;

- int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);

-

- if (err)

- return err;

- return clk_enable(c);

-}

-

-static int cv1800b_clk_disable(struct clk *clk)

-{

- struct clk *c;

- int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);

-

- if (err)

- return err;

- return clk_disable(c);

-}

-

-static ulong cv1800b_clk_get_rate(struct clk *clk)

-{

- struct clk *c;

- int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);

-

- if (err)

- return err;

- return clk_get_rate(c);

-}

-

-static ulong cv1800b_clk_set_rate(struct clk *clk, ulong rate)

-{

- struct clk *c;

- int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);

+ if (args->args_count > 1) {

+ debug("Invalid args_count: %d\n", args->args_count);

+ return -EINVAL;

+ }

- if (err)

- return err;

- return clk_set_rate(c, rate);

-}

+ if (args->args_count)

+ clk->id = CV1800B_CLK_ID_TRANSFORM(args->args[0]);

+ else

+ clk->id = 0;

-static int cv1800b_clk_set_parent(struct clk *clk, struct clk *parent)

-{

- struct clk *c, *p;

- int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);

-

- if (err)

- return err;

- err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(parent->id), &p);

- if (err)

- return err;

- return clk_set_parent(c, p);

+ return 0;

}

const struct clk_ops cv1800b_clk_ops = {

- .enable = cv1800b_clk_enable,

- .disable = cv1800b_clk_disable,

- .get_rate = cv1800b_clk_get_rate,

- .set_rate = cv1800b_clk_set_rate,

- .set_parent = cv1800b_clk_set_parent,

+ .enable = ccf_clk_enable,

+ .disable = ccf_clk_disable,

+ .get_rate = ccf_clk_get_rate,

+ .set_rate = ccf_clk_set_rate,

+ .set_parent = ccf_clk_set_parent,

+ .of_xlate = cv1800b_clk_of_xlate,

};

static const struct udevice_id cv1800b_clk_of_match[] = {

-- 

2.30.2

