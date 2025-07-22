Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BC9C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 07:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEE6382F6F;
	Tue, 22 Jul 2025 09:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="R+iNUwQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED494830B4; Tue, 22 Jul 2025 09:26:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B874882E26
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 09:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbjYgZJqlRXWtJkto6QT9KIO5hALukFxl2JjUIdzJBwDecn8lIywOPoTDIk+ExlcUc42eUMiJpFNabvZaN5Db1apJAt7kVPeiYu+C+q7P5e/Qx+8FqcWkC5toWsuk/efoJYyZr0IyqYsOh4lr2RU9XRNJZ9ExoyFIF6ny6R3GsJMmLSpL1GiKO5R3av9dX8Vi5qycyp9aISfxoXvAabFOxfcVvk4JpmFSChX9LfRGaKAB28+POArwH+VG08DoqJB5+OwfqucnSgBTmjh6Pdgz0mnUqvIicGuiXA4AxoHLQ2YRy1TwecBs3E1koa30h4p5s5bllwpaKSTDAr/2dvL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rx3xl5eBHMyR8IGVDUyAlf0R6i7uOrcECtgUsKyUUI=;
 b=RMqFeXUe6SgzgzhO1uAHuDmnlWQdCMDaRvMbEdLwZXxlHGGo7ENi4laQPd1l573yBjaqlaTBBQUFSD7iSZx/Ub2mdDO/FGNbJTa8yX7jQd2qUlJaa5/+3jM0m4+Dcg7F17a1uJO/jaceh8RSA2x70gSV/PtqJ+fIC79Sopp1kZ5L1gwsTU//oE7miHKWWj617CHIAWBSr4wXYdpEBWMdyBvrh2s7DA5mD0/4snn5/4J2PBv4MMMj4uMeiDrrOnWhS8QNeK3OHu24xRZGzs2H6QzmLrn1xFMLMTCgpA/c4ezmQQ7Zi4l4ECvmtMk9k4DBYcFQw2io2AAAlm2bSxznRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rx3xl5eBHMyR8IGVDUyAlf0R6i7uOrcECtgUsKyUUI=;
 b=R+iNUwQUfLFVuySUimXKFrbu8GqY9r+02UzSadLQSNMcgu+38u1Z5vZYYreei9OA85VhDU9SSnXk/3CX2tT+tXxyXA6kP+mu17y/AwYVdA5cQM8w0xhHL/hNKxfMTJmUO3c75jaPqNYEJiiF5OooSyPeY2dHVnPkBQ9iq1cvHSO/F3RKHzwYxS61ptpL1wrGuuFWhr6X5IeM/Ioxr2g8gdasvz0FrsVXSeI2U9RIOOwSDQDLp86ZFWMkexCsSEoMvpee2827ExOvGYwXPQGDfrwKRCfMiNzeFTX95PpQUAcR0t2sT/JE+7ffV/MVYDHGe0gLPuuKbEXmXeo2yxPzMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM0PR10MB3314.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:181::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:26:27 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 07:26:27 +0000
Message-ID: <ef633109-6f01-4d45-8d72-1f04a9051629@kontron.de>
Date: Tue, 22 Jul 2025 09:26:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] imx: power-domain: Enable refcounting on imx8mp
From: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel.holland@sifive.com>,
 Neha Malcom Francis <n-francis@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
 <20250425-ge-ian-display-support-v1-2-8a7a0fe75023@bootlin.com>
 <0a2c9ba5-a0fa-4cd7-9e29-0874cf085f2c@kontron.de>
Content-Language: en-US, de-DE
In-Reply-To: <0a2c9ba5-a0fa-4cd7-9e29-0874cf085f2c@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM0PR10MB3314:EE_
X-MS-Office365-Filtering-Correlation-Id: b1add81a-ebd3-41f6-cd76-08ddc8f111d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU9nZHdaSkxCQWZFRW5tZnlUKzdvWkNzNldaTy81RWcvRW1ldnBVR2M3U3pL?=
 =?utf-8?B?RDNhZUhXQ2JSNXRSSFNNYmgyV0pqV1VzU2lOMTBINkNGR2FoWmFXUG1PYXVi?=
 =?utf-8?B?ZzJqc2k2Q2VyNDIxVHBVNnZLaHV2MWlyNnVWK1BYT214K3hLb3NXMVFDOFhl?=
 =?utf-8?B?MXcxV0JSSm52ZDcyU0ZleWdlK0xqektpd2tpVG95TTFkSzZjcmNjb0hLbzZk?=
 =?utf-8?B?TkVTR1ZMQ1BZUkFZNFpzV0pBN2RxT2xKUUFuYkRYekd2U3duWlFIc2NVZmtC?=
 =?utf-8?B?VU5MSWFMbDJuVTByc0w2SjE5cEt6T2N5NWV6ZENYbzVXd1A3SmhNV2sraHp1?=
 =?utf-8?B?cEkvS2gvWHc3cVl6ejFXeFRUd2IvRGZJa3JYOWNNSVoxY0JyanVtbTNBS1Ja?=
 =?utf-8?B?NEozQm9OcHBYTzRIZXNTNDE4eHB5RTZuQ3IzcmtmSFlWeGJFcXJzMzZ1RlFR?=
 =?utf-8?B?Skp1OEpTVUs5Q0trbFp5SGZScUJVZ3JTdlhrN2FuRFlWbjE1c0xWcHRHeXB0?=
 =?utf-8?B?WjJuNkpMTnV0eFJENHdHOGZueXNYeVF4eDZNaXF2UENtQUNzSDQvNEp3YXlL?=
 =?utf-8?B?WlFuamJmN2Y4aVRrbjRubFZLWFFwMldvSk9QUlBuU09obmdXdkFMYjhQTXhQ?=
 =?utf-8?B?b1lBZkRHWUFCRlljODY1UzZVd0dndzJBUEduVERjVm92L2ZHWXBFWW1Eak0y?=
 =?utf-8?B?eW9UVnhPSjhnR3V3aUMyS2MvNU9QTE9GbWFiS1haTmcrK0ZBTWNsbFFydWNV?=
 =?utf-8?B?NElVbytQYnhvVkN5QWo1ZTFZbTg5aWNISURDSzZrenhQaHlqb3BKb1MwVFBk?=
 =?utf-8?B?NVRKU0pIQVlTdFVFWmFEc2F3bjJZL3BsS1NrMmFKYVlSSjJLL0hKTFJwNENu?=
 =?utf-8?B?aGd3ZXdMVTFrdW1aWE1STEE3NXpldVBDcll2dnRMdlk2WGZtL2JudGg3MTBp?=
 =?utf-8?B?TW41YXljaDErM1lPelRYWlUxeGlXM3NOUGhwVmVMVm9qSnVhbDBzaWRaY1pa?=
 =?utf-8?B?SDN4UWQwVlVXRklIZnMveVUxSGtEZ0pMdmp0a2I0djlrL0Nhb3E5ZzlwbTBk?=
 =?utf-8?B?L1c4WWV3RlR1bXh3eHRTbVBKNEpkdml5dFNLaEdkNzlWclZjMmxoNkNxVHVD?=
 =?utf-8?B?c1dHVFdkSDlYT2xKY1NmNHdEYlFPRyt6TjhwQlRrTm5BYlA0VmV0WTh3RUpK?=
 =?utf-8?B?aGFaZUI5eUNKUTZibVFwN3pyYVRFQzI0WTFwcTh6VEtUSUVNRms2allkMUFF?=
 =?utf-8?B?eG04ckx2ejExMDJ6MXRPRjBQcFZpT05jU3pwUjZKTkRORVRHS2tMMHdSdlJP?=
 =?utf-8?B?WXhoZkVJZmRMNzM0M2ppU29oSjB1eEdiMDV3WGRkck5yQ1JCQ053c0VNYjBI?=
 =?utf-8?B?czlnTmVHT3d5R2V4dk10a1pHb1NpU29ESHFQNjY2anF5Y0tBU2tpWmR0anBr?=
 =?utf-8?B?SlRZMVBTSjF4UDltbUtxbXlGZ05CNXc5NEt3T09uTmVSdU04c0tuU2JvamxO?=
 =?utf-8?B?OVJPNlVJVUY5bEp5MXJHUkI5UkRZWFFoS3daVzhrM3R2WkRiak90eWtEWFlq?=
 =?utf-8?B?M01EYTVLeTNDTVdTeE9BczFCS0RWcUZQMEZTczlwMDI4ZHlwRWxCN3QveU1i?=
 =?utf-8?B?N3pIQkNnd1ZmSDNpY2xVekVvd0h2OXo1cEVhanVXS1N1dnZ2QzlVL3dTaE9T?=
 =?utf-8?B?Mm9HWVl6SUNYcU05cGtwQ0ZwR0xYR2x1aWxoQ1UrUTlCMmt4VTR6cjNwS0hj?=
 =?utf-8?B?dFVEV3ZSWVZaYnpzYmlyTlJ2OXAxRkRRRE9iNkVlMlpJWGVDUXlreE5URVVn?=
 =?utf-8?B?MXNWZEZBMHI0U3daZTRtYldZUnpmUGlJU1ZqSzJJUUo0U0IyWC9vSGJmTVk0?=
 =?utf-8?B?VHdjV0VrdldkS0RaNHd2MHJEaTVEVm94YUc0VzZ2TUtBeDJwSnRtdTd2MDAx?=
 =?utf-8?Q?g8GoDmYkUrQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDdqL2ZZNTdVYm1UK3ptcEttckMzU1VwWlAxUkkrRldwb0VQZ2cyMDc4WjNu?=
 =?utf-8?B?MTN6aFNHcmUyQ0lJc1BYRFBXcW1CSGR1N0dEaVZVbmhuZnhYWEZpYzRPeUV0?=
 =?utf-8?B?aHdtQ1M3c3R2aGhCTEJwNWpJNWEyOWQzaUMyY0tHS09WYmN4RnR3SnJNZzBx?=
 =?utf-8?B?YzVjcnJJOXZVUGpKSVNIa3RqRksrcnFqS0JpNHc3VmVSN1o4b2VJM1h3TVRj?=
 =?utf-8?B?RVA3KzYyekpQZktNQlJNeHVKdjhYOGVTSE9veHR3QUEwcmZiQ3FVWi9XT0pi?=
 =?utf-8?B?RTFsZ2kwd0ZwR1BteVRCUUlGQ25WOW1rTXNsWE5oZ3gzK2JlcEdualdHL2ZX?=
 =?utf-8?B?dTNIYVJtdEFwcHBRN1Y0eklHMGdnRS9sSmhDU3dabWtJQyswVlByRmFvNEw5?=
 =?utf-8?B?aHFUa214K0RaeVl0Y1g1ZXhZNlV3ZlR6M1pRaVBQZ25iV0JJRm9WZ2YzVG15?=
 =?utf-8?B?RGpyVEpVbW1GSDZvWld1U2ZxRHp4S1VXMkp2dG5QbTdoUVN0eGtEdXFGNnpJ?=
 =?utf-8?B?M0pLUDhjNjZleUQyeXJQdFRvRDFFejhlbkU2cEhpbzVMQklkK1lsUGJBM0ds?=
 =?utf-8?B?bTUrVnlEVG9RUUV2bFFOZ29MdktTa0t1Si9BVkRTWGV0ZncwZDlNdlowcWtz?=
 =?utf-8?B?T2czZFJPZ3RwQytoY3ZCdHc4SmRjajI4N1BMOUNIMm1nbHJYY2NxcHFkNkwx?=
 =?utf-8?B?Ym1SVzMrako3eGgvWFI0Z1BjRkJIaHZvbUQyb2dKUlJuZExXVXBHK0drSTN1?=
 =?utf-8?B?MmJTM3VYQ1UwQ1F0c0ZiRnhwbTVRTTBRcWNqM1NUKysxVjBYenZGR2tQVWhs?=
 =?utf-8?B?S1AzSE5GNUxEVlE3WjFRanYvb1Q0bnRuNXhIWW05TnEyYmxrcFVlRmJJVnoy?=
 =?utf-8?B?VTQvOWJtZE9QNTI2WllzK3B4TUFCeWhFRXVHQ1N2YkNXWWRtelkvN2xvdE9O?=
 =?utf-8?B?R0p4cUttTHV1TmpVR0xXaVJBRytiQVJINDd4cjVKVXFZdTRhQ2NNWmx4amVk?=
 =?utf-8?B?dExtOVl0QVVDMDhUeVpFd2NsaVVLdXpNZk5uanV4MFJTZXBYck00YTRXSzdw?=
 =?utf-8?B?dTkvWEtVYU10UVN6Q3NsbThWQTdFRFlLU1VJUnoySzJuOTZrT1ViMkZrN0xQ?=
 =?utf-8?B?Y2Y5bFZIbEMvQ0R1aWV2bUdJVVV5QURBNGx4d28yQmRyaEFVMTZHTFRCY1JB?=
 =?utf-8?B?bFdqME90Y0RzNWtlRURhVG15eURPQXNhS1kvNTI1Tm1rT21LZEdCMGxvL1gz?=
 =?utf-8?B?cmdWUDFRR3UvdURCclJ2ZWxJZm1TYmlvR3hiMmt6cW54TGlxVWRva004ZjM1?=
 =?utf-8?B?Y1BPK2FZU0dsWDJ6b2dwNkJrOExGekRaZVhCSFozMzdydGNoYVBiK3Q3blpG?=
 =?utf-8?B?K0hFeCtmdzVxak81b2ZsYWNiaWd1VVl6dFNkNGkyUmVXcEZ2YjdFYy9GeHFz?=
 =?utf-8?B?engyZ0lJTmVFRWhKVmZMUWhkYlEzbGdhSkw3cndlcWJlRkh2bEpRMi9Wa0Jh?=
 =?utf-8?B?MTRESnlDaGQ5OVF2dkxlTEpwNzFtSHBwVkVKUlI5YjFRTVBtZXhhellRd2FO?=
 =?utf-8?B?OXR0RXRsMmxlalVLSEJ5TytUS1hHbkVMYzNnRkhJb010U1lINHljN3pZWDA3?=
 =?utf-8?B?bHg3WlhsSEE5WjRsbWNNMFAvbHlldER3akkxT3o4YXFoMWFaMGRMODYyS1BY?=
 =?utf-8?B?WXpXbGpVaGtVVnh5RnVQQnB6aW9YTWNnRzc1YzN5KzBLVEREeHZnMjlrNmsx?=
 =?utf-8?B?VXl1R1RyVm9mYzlqVnQrQW0wYVE3QU5YTlBUcEVQelJGYWNYSnRqdjVubm1W?=
 =?utf-8?B?b3EzMU1pQWJzWFQ4c09aN2VDQmc3UlpVQ2VBbzRQVU95aHphSFFuUHNCY0Fo?=
 =?utf-8?B?bDlUNGhuVmJVbGJ5RGpjNXprbWo2NHkzbnM0ZjZGa0ZHQmhQR0ZFK3h2Yzlj?=
 =?utf-8?B?L1BqQzl2RXEzVXBrSzhKR0tyb2FYem5ERFNwT21OM0UrSHp4WkNHR1VOQzFP?=
 =?utf-8?B?RFlDWlJLc1YxcmNBTU9ibHRtU21NVWZzc3lmMkJsVmhHT082WWtoTVM1OTBG?=
 =?utf-8?B?ZWQ3Z3Yxdi9acTNsZW5COWNkd0I5c3ZRQ203MFRlall4ZTV2bzdJMWk3WTIr?=
 =?utf-8?B?ZVY4aXZtV3Y1UTY5VU1MRE1NZTBmcU50ZDlHWG9pb1FlUGk5VEgzOHlBVmE3?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b1add81a-ebd3-41f6-cd76-08ddc8f111d6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:26:27.1122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzjhha3EHcYq1V9fRLQBAELSa86VQSUtNDGY5yX/Z0DcjW0verx4bGe0XRQbRQ3uRBqIeliYRY26yk/9VAj9QT2E93V4CtMYboEDRP2gMDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3314
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

Am 21.07.25 um 18:01 schrieb Frieder Schrempf:
> Hi Miquel,
> 
> Am 25.04.25 um 08:49 schrieb Miquel Raynal:
>> Prevent enabling/disabling multiple times the same power domain to avoid
>> breakages due to the same power domains being referenced several times
>> by different device nodes.
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> I've stumbled upon some issue that seems to be related to this patch. I
> saw you already had to bother with other breakages of existing
> boards/platforms in the previous implementation. Unfortunately it looks
> like this still causes some kind of regression in my case.
> 
> I'm working with an i.MX8MM board (kontron-sl-mx8mm_defconfig) and I see
> a crash as soon as I do "usb start" and then "usb stop" (log for the
> latter see below).
> 
> As soon as I revert this patch everything starts to work fine again. Do
> you have any suggestions? The power-domains involved here are pgc_otg1
> and pgc_hsiomix defined in imx8mm.dtsi.
> 
> Thanks
> Frieder
> 
> 
> => usb stop
> stopping USB..
> Sending event 6/(unknown) to spy 'efi_disk del'
> Sending event 6/(unknown) to spy 'efi_disk del'
> Looking for power-domain@0
> Looking for power-domain@0
>       - checking gpc@303a0000
>       - checking power-domain@0
>    - result for power-domain@0: power-domain@0 (ret=0)
>    - result for power-domain@0: power-domain@0 (ret=0)
> "Synchronous Abort" handler, esr 0x96000005, far 0x4ebacdc50
> elr: 0000000040249c94 lr : 0000000040249c6c (reloc)
> elr: 00000000fff4ec94 lr : 00000000fff4ec6c
> x0 : 0000000000000001 x1 : 00000000fbf22750
> x2 : 00000003efbab500 x3 : 00000000fffcdfb0
> x4 : 0000000000000020 x5 : 0000000000000020
> x6 : 00000000fbeea10f x7 : 00000000fbeea3d7
> x8 : 00000000fffffffe x9 : 00000000fbeea1ec
> x10: 00000000fbeea280 x11: 00000000ffffffd8
> x12: 00000000fbeeb1b0 x13: 00000000fbeeb1b0
> x14: 0000000000000002 x15: 0000000000000000
> x16: 00000000fff4edc4 x17: 0000000000000000
> x18: 00000000fbef4db0 x19: 00000004ebacdc50
> x20: 00000000fbeeace8 x21: 00000000fbf21ad0
> x22: 0000000000000000 x23: 0000000000000001
> x24: 0000000000000000 x25: 00000000fbf28f10
> x26: 0000000000000000 x27: 00000000fbf2ad40
> x28: 00000000fbf2ada0 x29: 00000000fbeeac70
> 
> Code: f9400693 d37ef662 ab130833 54000140 (b8626820)
> Resetting CPU ...
> 
> 

FWIW, here is another log with only the debug output from
power-domain-uclass.c:

=> usb start
starting USB...
power_domain_get_by_index(dev=00000000fbefacd0,
power_domain=00000000fbeead28)
power_domain_get_by_index(dev=00000000fbef7450,
power_domain=00000000fbef74f0)
power_domain_get_by_index: dev_read_phandle_with_args failed: -2
power_domain_get_by_index(dev=00000000fbef7560,
power_domain=00000000fbef7600)
power_domain_get_by_index: dev_read_phandle_with_args failed: -2
Enable power domain power-domain@0.0: 0 -> 1 (todo)
power_domain_get_by_index(dev=00000000fbef58b0,
power_domain=00000000fbeeabf8)
power_domain_get_by_index(dev=00000000fbef7780,
power_domain=00000000fbef7820)
power_domain_get_by_index: dev_read_phandle_with_args failed: -2
Enable power domain power-domain@2.0: 0 -> 1 (todo)
power_domain_get_by_index(dev=00000000fbf239d0,
power_domain=00000000fbeea288)
Enable power domain power-domain@0.0: 1 -> 2 (EALREADY)
Bus usb@32e40000: 1 USB Device(s) found
=> <INTERRUPT>
=> usb stop
stopping USB..
power_domain_get_by_index(dev=00000000fbf239d0,
power_domain=00000000fbeeac88)
"Synchronous Abort" handler, esr 0x96000005, far 0x4ebaceb90

