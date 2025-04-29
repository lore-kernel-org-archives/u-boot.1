Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59175C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C387F8283E;
	Tue, 29 Apr 2025 15:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IRGWkMqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79534828C2; Tue, 29 Apr 2025 15:28:41 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B6982145
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inoiAfNYlERbuYPGHkR0vMUj2wHmVAt6c49bQog99iqHRp4DjqN4k/3I8D8qQeWs/KLuFgMrjdmdzfUYBmaIp1IlMgzqMKgzRCbE4N5hrIkh6sU3YJ7iSAzt4KBc5NXHOr7C9vsQCWp65k9zp572V+dZfYdMGR/zkOWxzNftu1RpzpA5EYd3p6VsNjPbCahUh7DD/TqqIHnozdiFTNO/d8KybzbATgAFmiliNshK9MgoIenmjiuVhiULHzFTF8AL/XedsHjXsPX6gdOWsRbOCcaYQcjZ6HUhZjHu/jZG018IFwyBjWzJEFfUraLG8ligLPVBJ+pTOpAXK/X9OWNRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lteNu5WNaqGhEq+venqxmfhj9HDfR9OUb14ntCGBMQI=;
 b=o+8Q994bcBQO0o3ap5t0UaX4aMRQu/RXYRCMakObALU6xv5eXI2RzYXjTwaMUwUwvdUY9tCG37G4Ihd5Fxzx/9PBRG2x1Q0kRlm9v/UJc1D4BjuMXqkEovkSTKyzchtU4GqFNJmwXbG1z1FWuuB/BoY1sFCQw9HEr1ISNkybNXlDroOwdWhHUl9/VC3/lao6Km0EVeRnmassMcSktiP6AIdPd5GdCUqiPouYBF+iOSQGK7/ilcv1+v/ZSmGbsrmHCqB5kbrQ6tg09zVbQKnGiR9Kzrb+Yvy851NMvGc5XbmJHjdB4etM8g1Jd7QQj/SCA1uRDpMxah0ngt/1UzTSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lteNu5WNaqGhEq+venqxmfhj9HDfR9OUb14ntCGBMQI=;
 b=IRGWkMqEDdqJLLTW4g35f0oaw7/R4yVpOYFb9nAMbjFRIWQh5eUACsm8XbgLChpjWd3aVboyqUujCYMn5hKEB390wfRKHFfG3wXaEDcyYcpzLCjI0rGt+jx4Db4UeiBZaFOHHDXvTT+2g0yiom074GyGHSX9FqX7dSwdrVoPuXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9595.eurprd04.prod.outlook.com (2603:10a6:102:23d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 13:28:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 13:28:36 +0000
Message-ID: <016f585f-fd30-4604-8676-c7cabd9e40a1@cherry.de>
Date: Tue, 29 Apr 2025 15:28:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools: Update the license specifiers
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250429131515.244061-1-sjg@chromium.org>
 <20250429131515.244061-2-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250429131515.244061-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: b328c798-b426-45bf-8fb1-08dd8721beeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVEwL2N1YXp2S2Q1VlhOWDVLY1NVT1Ntc0ZzTTVYOTBSZEhBeHJybHNialV2?=
 =?utf-8?B?RGhJMnhoMThvaXlQSUxYYytwbW5vYStKQWhxeGZUajduaXBZMkgxd0hVQlBI?=
 =?utf-8?B?TGFyM2dWb2VleFFoc3pwaFNOUzdPQ1pOZC9PQlE2K0dxOERET0RKYi9pdTdn?=
 =?utf-8?B?dDBBZWk5eDVnM2l0RGdoZm84OGhIZmxBOEN4SUdjS1JwNjNqN1VQbVV2TzZF?=
 =?utf-8?B?L1RPRTFSaTJtNURZR1pmOWtaeVpzMm5JaDVZa3NCRWRMRFJoakg5aFZrZC8v?=
 =?utf-8?B?ZjQ3MVVCbjJtcXhXVFg0d3ltKzIvVnpHL3IvR3dnVGNlbExkSDA4NkJiMkRF?=
 =?utf-8?B?WjRoWEZ5ZVBIV2lnK3JlQ1RBa0I5b052L0ZSN1M1cmVLdnRLRHdNMEl1NEJl?=
 =?utf-8?B?VEtYRmVMOW9kK1Rhcjh5aWNCSXZLODczQktjN3VFWmI1ejF4MDRFZCtubW53?=
 =?utf-8?B?Sm1oa2dyWFI2K0tWTE9RYWhaelpxSnN6SXM2QVYwWTJxWDRWMjd4aTZ2YWg5?=
 =?utf-8?B?RkRDTHFPQm5Td0c3OE0xZzBrY3k1ZW8wQllIOXlMWTJWeGluOEdySjYrckZx?=
 =?utf-8?B?d2JIYnNBR3hiT29DdHEwQy9VK0xjSzcrRFRQamR1L3NlcXFncGVoOVJxMHNC?=
 =?utf-8?B?WmxnL3RsUVhUMDJRTVYvUU5GWHpYUWs2Nkt0aG1hd2JTa0YvdlRBd1VtS2Fx?=
 =?utf-8?B?eFo0ZkM3azg1L081S3M4TWl2OUdKMXp3NmJGYWkza0N4dElDN3BaeVMyVmhQ?=
 =?utf-8?B?N2Uybk9vNjJXNStLbll0Z2pSaWNPNW5lR25GaFYvcFZQSGxpU1BsSzZoYzBw?=
 =?utf-8?B?d2dLMVJIcGd5ek1UV3M5MlFCNGc0R0kyZE9TclBiRUpTNXN1NzVlUjcrcmdx?=
 =?utf-8?B?cHNMeTVBMW16Vnl0ZE1sN3ROR3pNWXlFUXRCMHp0YzZKWS9tSlphTk1KeDla?=
 =?utf-8?B?NWszTEZRTGdLVWNsTVQrQlBxei8vdmhvVWFwc2ZPTVBsN0l0ZkRCT20vbVV2?=
 =?utf-8?B?NWJmaUdZZXFIMFU5VTlWWSs1a0VQa013RmpnWitSZDBpZ1NWT0tUMi9KVytt?=
 =?utf-8?B?Mm1reXptdHFCaW5HNU1pYlBRZWx6akVmMS9nd3A3bFNDenBRbmJqaCsxcklr?=
 =?utf-8?B?YWcrV3c0UUVoY3ZXSTRhRDZPZkYrQlJ5Y0RCZEhoQkJCMU9HUHBETEpqQzEv?=
 =?utf-8?B?OVBnWGZnMkJCOHhFS2xFSzg4SW9VcEFQSWlkM2RkQVRUdGhtd0lVU2hlV3Rs?=
 =?utf-8?B?VzZmd2VEMWVDZnZrc3JqcXJ2cE1PZ0VlcFZVYkJlYmw5QVZha2UvNm1ncjN0?=
 =?utf-8?B?ZG9YbEN1Y0J5b3N3emZFZlFaMXM4UHMybERVMlhla1RTK3lHa09YTCtidGt5?=
 =?utf-8?B?cTR1QTlrSWVDcjZlaEF4TGNNdTlCd05seHFwM25PT0pnUU12Z3QyZWNVYUw3?=
 =?utf-8?B?L1FCNWtST3F0cjdLNG50eXhZR0Q3NmJidUdQaWFBbFZGdDhBTjRBL0JIMUgw?=
 =?utf-8?B?bktUY0IzYzlFMGVmanJtSFZDS1Q1NkNxa1FhM0VaWDJ2dGVzZW1TYkYwUmJu?=
 =?utf-8?B?a3pIU1c1Nkg0YS9GeFJpdWdvVE40TzJ2Z1pubVNTWHVNUTJBZVRLVzYwOHBj?=
 =?utf-8?B?SmtRekI1NkhodjkyOXlyeGdURlB6YXpJbVVFcmdqZHNMaGIwdmdoMGU4T3NV?=
 =?utf-8?B?bUtzQ0tJTlBCRUtEN29SVEQ1Qkg3cFRXUWt0VVBmQVl4aXF1WUMzOU9rVFQ5?=
 =?utf-8?B?ZTZhTzNJVFoyM2xnakkzOVdTWnRwSmc3aUQxK3cwT2pkS3lTakxVQzgwT3du?=
 =?utf-8?B?VkZQTFZBaWhldzFsMXpDc3BPYTMramhHOGFIdzB3T01ac0R4bHpnOHVITldG?=
 =?utf-8?B?QzZ6bjlSdTJvdG9Nb2RSTlIvMkdQYjlPdkVIaXpqSitDaXYyYzhRNENQckF2?=
 =?utf-8?Q?jpVW6D7RDME=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG8wSWkvZ0x5VzFDTWtDTlN0UXhGVWhCbS9JVG1hWEJ5VnNsQnVtekdONTQ5?=
 =?utf-8?B?K2VtS0dFdERKQ1UvZHlyNXVDaXpERVcyUnE3QlN0MkViK2lUcXpJc2kxd2Jp?=
 =?utf-8?B?MXp1WXFxVU0zZ2FUYUZFaGxVRTVHMzBqMGI4Wm5qdy9lR05tYzdKUVM5aDhk?=
 =?utf-8?B?dis0S3lQNk5WQ2RCbHQrc0I5L3YyZXVwVGxrODZtOC9hNXlKUE5ZZ2cwYlFx?=
 =?utf-8?B?STB6K1BWNmJ6K2N0V3RMREJ0NFcxalpmWnBUTXZQN1F5OHRkcVNNOWh3MHpO?=
 =?utf-8?B?QkpvZklxLysvQmltcldCY2dCMmVmQzJuUVpDcjZxQXFDcWhJN1ozV3RJRUFz?=
 =?utf-8?B?Y3JxQ1NTRWl3S3I4aXlOUWp4NndRVXhmS3BJUHN0SmUrUlRnWDdPZGtqbk1j?=
 =?utf-8?B?NGF4TTUwSDFxNGhKNFhycm5YV1owR0VkSFBkWUsvQk5UZTgyZjlkNWFkY3Bi?=
 =?utf-8?B?NUpWTm0rRE9pTHd2bEh2ZXZZcWp5QVYvSVZxM3VyQnJkSURLcDhnNDlhM3Y1?=
 =?utf-8?B?VWhnbjhRN3d6M09LSzF2ZW1DcGV1OWJnNXpJZnlwUS9YTFBJTmJINXg0cVlp?=
 =?utf-8?B?ZFFKd3lhdFcxbGFZTG5qcEphTC9pTHUrMEJiOVcyU1ZEWVVhaFhJRXE5UllT?=
 =?utf-8?B?YnFCSFJjUWJ2L3FZdFdOOU0rWTJqZ3RlbzU1djFHeU5oSkM2R2x6eGEraUI2?=
 =?utf-8?B?UzhsbUNBQ1lrNDZtbUg3OS9oakdsQ1dtV254aG1BeFFUYTFOZ0wrc2Z3c3VB?=
 =?utf-8?B?c0FVUWFmbndsd2cxNjRJQ0NoZ3ZjMlM2TGVVVStKc0V0S2Y2MCsraFdzVjB4?=
 =?utf-8?B?eXo2RlQxN2hqT0VDVTZmTTNpYUFTOHdYUjVENW9RZTY4TEh2ZThUMzZFTW03?=
 =?utf-8?B?YUw4WVRpZE5lWnRBUXNRRCtLK3RFMWp4SXNheUFhUFNkcVRtQXNXUElxS0ZX?=
 =?utf-8?B?S3RJS2lTQ2ZqQXRramRJY21URHpac3o2M1ZYRjU5eTErRlMzbjRzbCtnRG5T?=
 =?utf-8?B?QnBMcXF6OE4xWm5Jdk1mcStnbEllNDNyRTVsaFF0WUZpMTVjNTI0REgzVEFB?=
 =?utf-8?B?MUV5Q2VNeTI2Uk53ME4rL2tVMC9vQ2xzUS9LWUI1Rk0zYUNlZHRZckd1b1Qx?=
 =?utf-8?B?aVFodHJQK0FCTnFsS1NnYmN4MS8zcytSaHNaK0daL1QyNElPZ01vMWdQaFNP?=
 =?utf-8?B?b2tIRXRUTTYrbDRDT3VndUhHZmRNZSszdUtscndZZU05NDVZaHhrcm8yYWpw?=
 =?utf-8?B?RGN6aXVzWlZBZmRBUG4xNUxOYUpyN3NhQ3VScWY4TGNiZzhzZW9zWDB4SEdx?=
 =?utf-8?B?M1Z5UUJ2NGhrc2t3V09xV1RNcDl1ejRaT2VFQWFCMFEzUm1OVFh1WFFHQXh0?=
 =?utf-8?B?ZS84RlU5em5yZEhYWlBEMm16R2MzUkNJNVRtY09iY1ZSd1F1cU94MTE1WnF5?=
 =?utf-8?B?TVRLaXlCU2N6aFQzeEdBTi9ZODhvS0xWcERaRjMrRitYTENBUkpsaTE4Ly8r?=
 =?utf-8?B?ZkJtQnE5T3hkUHBPLytWTmN3ajdEeEIwUXltL0RtMGRkMVdzeVkzTDhveUp6?=
 =?utf-8?B?ckw0dXRSN1BSM3laNUlvZ0NjczVDQTE2ZkgyczhWUDZYMlJ4SEd0bFkvbjZo?=
 =?utf-8?B?SFdTREI2bWhncUZ4L0JKakpKQ2pNUFpvd3FHVWpMaUIrbnRYTmkzVFNpVHNx?=
 =?utf-8?B?d1U0WGtPT3hWREtjVzc4Zy8zQk1JelIxK2JNK1dJRmlqbEU2MGE0QzBZKzJ1?=
 =?utf-8?B?d1krZWYwR3U4TGp5RzZHRHhLQTZIem1ZdmVEUEtEaUYxYlRVQ1YvVmN6ZkJS?=
 =?utf-8?B?SnN3TCtCY2RHM1YvZ1hxcjBEekx4Yy9aY3J6S3VUZUdUTzBxbG5JYnFRQ0Z3?=
 =?utf-8?B?ZFk2bWdBWnh2WmVVWHlnV1NobVBGN1FNK0lnU0NWTzkrYWJqTmR5SkR0Wito?=
 =?utf-8?B?QVV4QW9VT0hUem55bDBOdkRrRWpMeExJMDRxM3VQbS9SS0p4TGVsbng4ZEV5?=
 =?utf-8?B?ZTdZYTJITzZqNHNPOExZT093ZDRxeUN0TU9sVmhpZlV2bElET1g2cW5tSkxV?=
 =?utf-8?B?RFN5ME1pT3NFSnRMMUtRMXg1YVAyTW5YN0RCelIyaWoreWdvTGVzVzdVbG8w?=
 =?utf-8?B?L1p6Z05yUnFXd0E0MldWelJON2NjTVNJaVpxSExoNUx2Q0cyclRQOS9iWUs2?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b328c798-b426-45bf-8fb1-08dd8721beeb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:28:36.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+sbqw9B2OI/kg90wE26Jro3wgcO+8iwHvjc0BQbzaUTv1RDo++fg6NF+ZeNA0zj3y/5hcM2t/yWjy5dynTzkDp3ZypHO7e9gMttojgG3+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9595
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

On 4/29/25 3:15 PM, Simon Glass wrote:
> Recent versions of Python complain about the license being in the

I believe this isn't related to Python but rather setuptools.

setuptools 77.0.3 and later support PEP-639 which recommends to ditch 
the License :: classifier for a license property.

The issue is that this license property also changed in PEP-639, with 
something that isn't compatible with pre-PEP-639.

Therefore we need to bump the minimum requirement for the setuptools 
dependency in the various pyproject.toml to 77.0.3 or later.

I'm also wondering if we don't need to add a license-files property 
(also PEP-639) to comply with the GPL-2.0-or-later which requires to 
provide a copy of the license.

Cheers,
Quentin
