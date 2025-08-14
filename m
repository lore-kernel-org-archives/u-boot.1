Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43342CA0EE3
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 08:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7AC78309A;
	Thu, 14 Aug 2025 10:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Yo9J3Oa2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E51583734; Thu, 14 Aug 2025 10:44:24 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B92380548
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 10:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWEkG/PXaLsNEcaYrrzRCBrTP7RDmbEHvf97/e5BoWPeT8kKdCW28lV55b4WmU21BDeh89Hz7mbivjzRiA1W13K8vsB2SlTR6deUqDdCoHO0tgpekZiDU2qLRexZ5T2BbbdYS68SY8YXGYORIB+2sHLek0V6hH3gP9dnIYhTcLL1+sOzI0R+1E2MveMvRj07aAn42BsqI8O74QMgAQIA7ok4aP3uDTvpqooAzc9CZn5BN/SHeU832E7FSPlZaTXjCvRI+PTn+E2RrCoB9qBZpXwfTM/t4BacFm71oxGBy7OgggRpqPjQRL1h7TRxmh+h/Gjx/7smOLxgp2O0QKebbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+Tgx4YrEb6xpOLB2FF5fF00Pl5akbPFOxvTITlyKQ0=;
 b=Md75K3HXLk1myrDshgrAQcrvwMmekwzYifvdR1ijpZlUy4OM16CqfWHT09KwAiaKsZJhJNaelF8AoiBzL9sajlBW6TvnJqg6zpN9/YJRA4AwYPx1twfQz1trWsS7jCAbR/v0tAvA6CK+uqpdJUaUmt82KdVs3SEp56D6KZf7xoDJtiJYLoGE3PYb5bcJpiLRj2SjneN3bg7GfpUR8Wj8W9F0LN4xL1Mp83FjwSWPApLMXtckz5aBFa8umn4Wro6BSQbsY1HUuHHL8/9ZrK9pFgj5ZzFrr7jNO3PrWglCd5y8+lmgOJo8O3S/ekMNapdIRn9wOhnJqibcmDqdtO+IhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+Tgx4YrEb6xpOLB2FF5fF00Pl5akbPFOxvTITlyKQ0=;
 b=Yo9J3Oa2MxetJVByFZSGYdWiPmPlXkSUCPy51sjKMzNQbrbtQqRxpgCzZdcbUAOl7NCrCXBwTmS7AubcLlTq6OMBrKHsCJx7XYGPxKfglT08Z4UZ9JHsrE0s8FOdJpU25Cnnx9LGGNDrxxLORalDy8lM9VAqYRBS1NhWn+np37EWmACYtw0nBqKGgRDfCbSFRtB2UhTsH2REhGx1477AiCkb3qiIL8sWfM5IAv99BQsIf2+74F+Qe0DJkDaY5apC+5TeonqG84zLYNV+At0mzgLaIADRD0f4tYptiJkHnKxHaS9tdmLJhQ9QSk+Ztab2E5WE4ITQrih3A2wL9qkIFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:33e::16)
 by AM7PPF51497A851.EURP195.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::74c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 08:44:19 +0000
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::f79f:1750:8791:4336]) by DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::f79f:1750:8791:4336%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 08:44:19 +0000
Message-ID: <b1f83b3e-b5f5-4d7f-ac76-834ecfd6d5f9@phytec.de>
Date: Thu, 14 Aug 2025 11:44:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bootstd: Add implementation for bootmeth rauc
To: Martin Schwan <m.schwan@phytec.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de>
 <20250602-wip-bootmeth-rauc-v2-1-9d2384131486@phytec.de>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250602-wip-bootmeth-rauc-v2-1-9d2384131486@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0182.eurprd09.prod.outlook.com
 (2603:10a6:800:120::36) To DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33e::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P195MB1444:EE_|AM7PPF51497A851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f346d0c-6280-4801-99ca-08dddb0ec259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE1GOWF6UVR5a3R6RVYydTlqNVRhUitpeWpyUldQVVBDNUJmWVIzaE1tdG9U?=
 =?utf-8?B?M21HR2lMVlRheFAwcGl5cXA2RXREejJBT0E1Z1dkdVdkTEt4Snd4RmtFYktk?=
 =?utf-8?B?L3ZGTkxNd01kSitXbTk2bG5rak55cEJYWDliSHJBeFNxQUxSQkI5M0Vwa2dH?=
 =?utf-8?B?ZzYzTUs4RlNNTUhWYTJHWXNLVlJzRVNHODUwd0RWajBSTnZqdGhNNmNadDFC?=
 =?utf-8?B?RTZMdktkbjNCUDcvSlRWb3NOK3FyenUrUGF1T29CTGx0b1hsMHdDeU9jVlJl?=
 =?utf-8?B?eWNGcFpGTVN1anRHczZMMWRlcG8vR21BMjhOeFZkeC9BVEpQUThMVnA4amUy?=
 =?utf-8?B?OTl6WDBmRmh1K0dTWHFMZzNaSWZnNlhmZkkwT1VUZ0E0Ykdib09IUU1PajNu?=
 =?utf-8?B?b0xydklmQWVZTUZRUmtsbVBMSTNnb05KWG5QQ2IrdWhWTTBIYk1iZnVlNnNv?=
 =?utf-8?B?ZFNNVmFIbEc0eGIwZEpDN29ycUV0bWMxcUhFWW43U0xnNWVDSFNoQmlOUDNY?=
 =?utf-8?B?V0J1OWNvNE5xeTV0RUN2VnkvUFZoSjdwd1NHaUNaTEJqTXZMWFVkOElDQWt3?=
 =?utf-8?B?UWZkYWs0WGVGcWJHenJTQ2QweDVKUzFPdXdja0VFQnpuV3RSSHhRYlpYQ0k4?=
 =?utf-8?B?K1VuR3EvR05BUko4YkNjcUZldDJhUFpaZlRRYlVaTHhBczFRSGJHM01PTG92?=
 =?utf-8?B?ejd2clNBMllEY2VEeDI3ZlFGUzJjQTdkNTVBZ3cvSjVBRnBTZFU1bzB0YjBO?=
 =?utf-8?B?OXU0YmwvclFmVTVQVmthdmdVL2F3TnpId0xUd3BoUGtZWTdNcDl0clM3dDFS?=
 =?utf-8?B?NEVPMUZlTzFBQ2JWZTVIMmpteGxNSSswTkxXTHJoeld6NGt2U1piQVVQOGdL?=
 =?utf-8?B?RkhhV1JaSzJyb0plTkhmRHgwbmkrZGx1Z1h5bVdoVW5rU3Q4Z1NUUUZQY3BR?=
 =?utf-8?B?elZEcWlvTStPaWlaR0MycWVRTWp2Y3hLcUwwcmZwY2FvN1h0UGFKZ3k4bzV5?=
 =?utf-8?B?amdPTTBPMkpjWnJON3ZyVVF1cmhoai9tTkdpR0duUUFiajhwQmYrWXk0WmMy?=
 =?utf-8?B?dTVDTEpsREZjTWxWWEw2KzN1Z1dtRVVYaTdFeEVVUXZlQ0VHaW1yTXorRlhw?=
 =?utf-8?B?M0JwbFI2VjF2OUloTmY1UFpHLzNHMXJ1c0c0Y016TlFBcXN5SUxJeEpBOG1m?=
 =?utf-8?B?QmovTVFzWS9jSjRXUXB3Y3RnRXZ2SCtLbnlBOEVRVHk3Z2pBVUZyUFRQUXRh?=
 =?utf-8?B?Q0xaMjJ0WkVzVmRsdXZ1WUoxUW9FS2h3NzlPRGtRL2dtQVlIVm81NXM2azNF?=
 =?utf-8?B?WkZDakszMlBhVHJrVWo2dERZaWtHRk1Fc2FROVJvVXZ6RGlUYVlRNVRsdlB2?=
 =?utf-8?B?N2k2YkIveTcwbG96MzB2K0tZTGdmL1lOMEV0Vk1udi9pWjZ6eXdsSWFHeXJO?=
 =?utf-8?B?MVU0L3RnV0hTZGJUVWc5SkQrYWdjZGplcUdaRnExeG9mQlJXNGlsRS9maE5t?=
 =?utf-8?B?LzZVL0FSdWRWYmtqREpBcFl2R3V3ZkY5SmlvM3gvbGxmN2FsdHBSczRubFBj?=
 =?utf-8?B?U0NYVUZiekZja3pSYTN3SzhpSHB4SXZURHBPMkx1ekU2ZjNKeFMva3ZrOG5H?=
 =?utf-8?B?UFlhMFdBdDJCcnkzUmZXTlMyU2M1WlovMXlCVTJ2dHhkZ0JxS0g5NUN2cnFS?=
 =?utf-8?B?MitBN2hoUC9WSlJmSXkxYnBSdFpJeWRGK1J5ZW44bVN5K0Rpdjl1eVVjRjJI?=
 =?utf-8?B?VDZwQkNXcU1pTmVvMkxXam51M1hRbUp3SWdXN0E5amFTMmhsaTMwZ0p0SlIy?=
 =?utf-8?B?UHhnakJzaGYyYTFoK2JKVjB1eUZPd2tuaW50UkJ2L0VqYmoxdngwOUNqd2hO?=
 =?utf-8?B?V2xSQk55UEpWWXlYa3VjK05rOGxsak5xenVLbm9qZXpGeG12b1BhUHRiay9j?=
 =?utf-8?Q?doseZfxeMEM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1444.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHplODF2Nkk4dzVGcGgzSnU0d05iaHFGMUhOM216Q2s4Z05qWHBzV1E5MERm?=
 =?utf-8?B?bzl3RWRwRHR2cjdLSTVUMUY0TGkrK0NuTHhtcDFPZWk0clFVRDhqODQvNXRX?=
 =?utf-8?B?VG9HL0xWOTl0ZXQ5dGdTWWNBWnVHb1R1T09SakRibmRxNGpwNm1xdzhMdFNY?=
 =?utf-8?B?R3dnN3BmL3hJM3BZamsvbUZYa0lXTTdacFlvMDhjRllaMWxsOWFzMXdjTTBV?=
 =?utf-8?B?MEdodDNLLzYrSXBkMm5zWXNTQ1Zxazh3SDlnZDQvVTRlUkp2UGxaTm45UXVp?=
 =?utf-8?B?VWV5ZGlIMFhkSlI2ODVtS0piN2dLOUZ1QXhodlN2ZkdIN2ZGYzh3YkVmMlpz?=
 =?utf-8?B?b2lrZVN0VGtZMnF0SDYxL0x2UHZPa2J0bHV3Z2taVyt6RmVwMUZrR1A3ZkVQ?=
 =?utf-8?B?UWlQb3J0MzRLT091VXR0UERPWU5mQlNUMzBGdGxmZWR1UlRHc2FkZFJQOTNC?=
 =?utf-8?B?OFVWZUQvaUlQV0V4OHBhakllTU1HYVI5RC9JWk1xR09uWXlMalkwWDg3THdE?=
 =?utf-8?B?dXhEL3VRZVgwczRuS2ZuVEpBZDQ0VlhtUXM0Q2t6Y1ZRdTFJVlFZMzluc2Qy?=
 =?utf-8?B?R3NtREhHLy9HNnJwNnZoTXF4SzdqYW5NbDB0cUk5NWVSSFd2cHdLN2RFOEZl?=
 =?utf-8?B?SUVBQTlXZWRLU2ZWcEFrTlY0UGYydktpZXVPeXBtM2IvMm05MW02MUpNcmo4?=
 =?utf-8?B?Nk9NanRQTHpoY2Z3TTFRYjd2S1ZjT3ZXNjdtc3JMYmh0SXp0bU9pK29lbUdQ?=
 =?utf-8?B?b1ZqUXg0YktRanF3VDBuNjlhQXlLVUtSRlYxQlZTSWxTVlhmaTQzN3hOOGpm?=
 =?utf-8?B?a2dJaGp6aHI2SmJraVBtbWdJSXVxTnhpamdpd3Vid1NKeHB1Z0tGRms1SnM4?=
 =?utf-8?B?Vi96T1VjcUV2QWVXVTJnYkJoVEU3dFR3N1drVmdIM3g0Uk5SZHdRN3BjWmpO?=
 =?utf-8?B?MjhtekNrZkFYbzhyaGpZQlJETkIzN0xFbXVPbjBnMUpKS1B4MG14ZWgxenpD?=
 =?utf-8?B?OUYxdUFGbnBwQ3REbGV0c21SVVo1OXZNbEllWnFkLzZBZ0NRZjZYbGc3V2Qz?=
 =?utf-8?B?V05FOFo5ZmFOb1dFQ1lnaE1uTXNlbWppc3BiWHlGeEsyc2MybFRYR1FRQ1o0?=
 =?utf-8?B?SytMNHo0OEVDQjFaSWZYQ2tQNHEzU09nckZwUldadDM0RTh1alI2OWI2YWkx?=
 =?utf-8?B?QVgvQ0VCbmhHYmRWOWMzbUEvNU53bkh4TlQvNUludVpBS0NZellDVFhEeU9o?=
 =?utf-8?B?Y1RvbjV6T3M1L3Ewa1ArZVVnQ2FKa2FTcDdscGNDd2FkQmVGdjZsTzlpWW5O?=
 =?utf-8?B?aVdMeGhONDYwZW8ya25DRFRTZTd4U3padDU3anNJemo0SUtnQTNNNEtnSXQx?=
 =?utf-8?B?OWV3djdheGJ2QU52QXB2M3paNHUyVEFPcyt1aEVvM1ZtT0JZaHkySDgzdmZR?=
 =?utf-8?B?MnVZREJCV0VsRVlsTmlURVc2dHFmWklGZlRhV0o3ODRmOWxTdklvM2NTL3c0?=
 =?utf-8?B?bVdaRXBYaitRUzYrTmgwbnpmVnVNbzFOWnA3d001S2JEelBVbHdpUXpEYlNo?=
 =?utf-8?B?MVk3c3pnalhYd09OTXZNNy9qd2ZRS0FLcHlhZU4wVUl2czlGWGlRbVJ2QW5P?=
 =?utf-8?B?czFIcVpCb3RIWTdudHF4VzA1bDdDaGRRbjE0SXhHejRYSC9Tejl4c2lQTGJY?=
 =?utf-8?B?WjdHRnNjV2puNG5jNFNKK0kyTmdFMTIrRUZpa2UzaEExQVlRd3pDMmpvWEYr?=
 =?utf-8?B?QmpKZWNEQlpVNjBaT0NHVHJGY2Nma25FMEJ6SFZtZmZNR1V0SWdiQlI2Tysw?=
 =?utf-8?B?WG1BQ1M1L1hIYTdJakNsZGYxdzdGbTBmWGxsNElXSjB2QnZNamIyeExUenlO?=
 =?utf-8?B?Qllqb0ZkeTY5OUZFK3dUSXluTG5aQ1JkUmUvTXAyeHdFcDFIL3BGdWVDL1Ri?=
 =?utf-8?B?VlgyUHpKYWwzVUxtbjJHT0xDTGN1ZkdVUnZzcG9aTG0wNC9jOTlXbDNSV1pm?=
 =?utf-8?B?YkJlbFBMTjYvTTBadkZRY29sSlV0cXViWHJ6OWRFZzU2ckZ3UFFZZytrNVFk?=
 =?utf-8?B?c1dXMWhKNGdkdTR2Ny9DbHBxZWppQkN0SU85bzBkeXlTQXpZWkxMQlFxM2JY?=
 =?utf-8?Q?VtREulYbGzggHJLgo2h3s7rr7?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f346d0c-6280-4801-99ca-08dddb0ec259
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 08:44:19.5279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xAXUcU5duc3RYA8ToTfoZnm6/2tTQUxMBXcHkTqKH5JilphhmJvIfdBw/ItC7BuQux3+d1S755KgTDroLAI9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF51497A851
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

Hi Tom,

On 6/2/25 2:31 PM, Martin Schwan wrote:
> Add a bootmeth driver which supports booting A/B system with RAUC as
> their update client.
> 
> Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> ---
>   boot/Kconfig         |  51 ++++++
>   boot/Makefile        |   1 +
>   boot/bootmeth_rauc.c | 432 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 484 insertions(+)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 30eb5b328d7ad8a73a2e84812dd7853b66039164..a610cf9faf99cd5480f94dcac89c3401cca394ae 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -855,6 +855,57 @@ config EXPO
>   	  The expo can be presented in graphics form using a vidconsole, or in
>   	  text form on a serial console.
>   
> +config BOOTMETH_RAUC
> +	bool "Bootdev support for RAUC A/B systems"
> +	default y if BOOTSTD_FULL

I noticed that the merge 009d7722ffd7 ("Merge patch series "bootstd: New 
bootmeth for RAUC A/B systems"") deleted the above line.

Was it on purpose?

Regards,
Wadim

> +	depends on CMDLINE
> +	select BOOTMETH_GLOBAL
> +	select HUSH_PARSER
> +	help
> +	  Enables support for booting RAUC A/B systems from MMC devices. This
> +	  makes the bootdevs look for a 'boot.scr.uimg' or 'boot.scr' in the
> +	  respective boot partitions, describing how to boot the distro.
> +
> +if BOOTMETH_RAUC
> +
> +config BOOTMETH_RAUC_BOOT_ORDER
> +	string "RAUC boot order"
> +	default "A B"
> +	help
> +	  Sets the default boot order. This must be list of space-separated
> +	  strings naming the individual boot slots. Each entry in this string
> +	  should correspond to an existing slot on the target's flash device.
> +
> +config BOOTMETH_RAUC_PARTITIONS
> +	string "RAUC boot and root partitions indexes"
> +	default "1,2 3,4"
> +	help
> +	  Sets the partition indexes of boot and root slots. This must be a list
> +	  of comma-separated pair values, which in turn are separated by spaces.
> +	  The first value in pair is for the boot partition and second for the
> +	  root partition.
> +
> +config BOOTMETH_RAUC_DEFAULT_TRIES
> +	int "RAUC slot default tries"
> +	default 3
> +	help
> +	  Sets how many times a slot should be tried booting, before considering
> +	  it to be bad.
> +
> +config BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES
> +	bool "Reset slot tries when all RAUC slots have zero tries left"
> +	default y
> +	help
> +	  When all slots have zero tries left or no valid slot was found, reset
> +	  to the default boot order set by BOOTMETH_RAUC_BOOT_ORDER and set the
> +	  slot tries to their default value specified by
> +	  BOOTMETH_RAUC_DEFAULT_TRIES.
> +
> +	  This prevents a system from remaining in an unbootable state, after
> +	  all slot tries were decremented to zero.
> +
> +endif # BOOTMETH_RAUC
> +
>   config BOOTMETH_SANDBOX
>   	def_bool y
>   	depends on SANDBOX
> diff --git a/boot/Makefile b/boot/Makefile
> index 71dafaefa76bca7896741dd896829575bd9e8f10..46f27e71856c598a866424cb93ee01444ea6a19a 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
> +obj-$(CONFIG_$(PHASE_)BOOTMETH_RAUC) += bootmeth_rauc.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
>   obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4d48d643c0a727d5ebd5f3514c173f0dd824b7cd
> --- /dev/null
> +++ b/boot/bootmeth_rauc.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootmethod for distro boot with RAUC
> + *
> + * Copyright 2025 PHYTEC Messtechnik GmbH
> + * Written by Martin Schwan <m.schwan@phytec.de>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <blk.h>
> +#include <bootflow.h>
> +#include <bootmeth.h>
> +#include <bootstd.h>
> +#include <dm.h>
> +#include <env.h>
> +#include <fs.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <string.h>
> +#include <asm/cache.h>
> +
> +/* Length of env var "BOOT_*_LEFT" */
> +#define BOOT_LEFT_LEN	(5 + 32 + 5)
> +
> +static const char * const script_names[] = { "boot.scr", "boot.scr.uimg", NULL };
> +
> +/**
> + * struct distro_rauc_slot - Slot information
> + *
> + * A slot describes the unit of a bootable system consisting of one or multiple
> + * partitions. This usually includes a root filesystem, kernel and potentially other
> + * files, like device trees and boot scripts for that particular distribution.
> + *
> + * @name	The slot name
> + * @boot_part	The boot partition number on disk
> + * @root_part	The root partition number on disk
> + */
> +struct distro_rauc_slot {
> +	char *name;
> +	int boot_part;
> +	int root_part;
> +};
> +
> +/**
> + * struct distro_rauc_priv - Private data
> + *
> + * @slots	All slots of the device in default order
> + * @boot_order	String of the current boot order containing the active slot names
> + */
> +struct distro_rauc_priv {
> +	struct distro_rauc_slot **slots;
> +};
> +
> +static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
> +					 const char *slot_name)
> +{
> +	int i;
> +
> +	for (i = 0; priv->slots[i]->name; i++) {
> +		if (!strcmp(priv->slots[i]->name, slot_name))
> +			return priv->slots[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
> +{
> +	/*
> +	 * This distro only works on whole MMC devices, as multiple partitions
> +	 * are needed for an A/B system.
> +	 */
> +	if (bootflow_iter_check_mmc(iter))
> +		return log_msg_ret("mmc", -EOPNOTSUPP);
> +	if (iter->part)
> +		return log_msg_ret("part", -EOPNOTSUPP);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_scan_boot_part(struct bootflow *bflow)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	char *boot_order;
> +	const char **boot_order_list;
> +	bool exists;
> +	int ret;
> +	int i;
> +	int j;
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +
> +	priv = bflow->bootmeth_priv;
> +	if (!priv || !priv->slots)
> +		return log_msg_ret("priv", -EINVAL);
> +
> +	boot_order = env_get("BOOT_ORDER");
> +	boot_order_list = str_to_list(boot_order);
> +	for (i = 0; boot_order_list[i]; i++) {
> +		exists = false;
> +		for (j = 0; script_names[j]; j++) {
> +			const struct distro_rauc_slot *slot;
> +
> +			slot = get_slot(priv, boot_order_list[i]);
> +			if (!slot)
> +				return log_msg_ret("env", -ENOENT);
> +			ret = fs_set_blk_dev_with_part(desc, slot->boot_part);
> +			if (ret)
> +				return log_msg_ret("blk", ret);
> +			exists |= fs_exists(script_names[j]);
> +		}
> +		if (!exists)
> +			return log_msg_ret("fs", -ENOENT);
> +	}
> +	str_free_list(boot_order_list);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> +{
> +	struct distro_rauc_priv *priv;
> +	int ret;
> +	char *slot;
> +	int i;
> +	char *partitions;
> +	char *boot_order;
> +	const char *default_boot_order;
> +	const char **default_boot_order_list;
> +	char *boot_order_copy;
> +	char boot_left[BOOT_LEFT_LEN];
> +	char *parts;
> +
> +	/* Get RAUC variables or set their default values */
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order) {
> +		log_debug("BOOT_ORDER did not exist yet, setting default value\n");
> +		if (env_set("BOOT_ORDER", CONFIG_BOOTMETH_RAUC_BOOT_ORDER))
> +			return log_msg_ret("env", -EPERM);
> +		boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
> +	}
> +	default_boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
> +	default_boot_order_list = str_to_list(default_boot_order);
> +	for (i = 0; default_boot_order_list[i]; i++) {
> +		sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
> +		if (!env_get(boot_left)) {
> +			log_debug("%s did not exist yet, setting default value\n",
> +				  boot_left);
> +			if (!env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES))
> +				return log_msg_ret("env", -EPERM);
> +		}
> +	}
> +	str_free_list(default_boot_order_list);
> +
> +	priv = calloc(1, sizeof(struct distro_rauc_priv));
> +	if (!priv)
> +		return log_msg_ret("buf", -ENOMEM);
> +	priv->slots = calloc(1, sizeof(struct distro_rauc_slot));
> +
> +	/* Copy default boot_order, so we can leave the original unmodified */
> +	boot_order_copy = strdup(default_boot_order);
> +	partitions = strdup(CONFIG_BOOTMETH_RAUC_PARTITIONS);
> +
> +	for (i = 1;
> +	     (parts = strsep(&partitions, " ")) &&
> +	     (slot = strsep(&boot_order_copy, " "));
> +	     i++) {
> +		struct distro_rauc_slot *s;
> +
> +		s = calloc(1, sizeof(struct distro_rauc_slot));
> +		s->name = strdup(slot);
> +		s->boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
> +		s->root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
> +		priv->slots = realloc(priv->slots, (i + 1) *
> +				      sizeof(struct distro_rauc_slot));
> +		priv->slots[i - 1] = s;
> +		priv->slots[i]->name = NULL;
> +	}
> +
> +	bflow->bootmeth_priv = priv;
> +
> +	ret = distro_rauc_scan_boot_part(bflow);
> +	if (ret < 0) {
> +		for (i = 0; priv->slots[i]->name; i++) {
> +			free(priv->slots[i]->name);
> +			free(priv->slots[i]);
> +		}
> +		free(priv);
> +		free(boot_order_copy);
> +		bflow->bootmeth_priv = NULL;
> +		return ret;
> +	}
> +
> +	bflow->state = BOOTFLOWST_READY;
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_read_file(struct udevice *dev, struct bootflow *bflow,
> +				 const char *file_path, ulong addr,
> +				 enum bootflow_img_t type, ulong *sizep)
> +{
> +	/*
> +	 * Reading individual files is not supported since we only operate on
> +	 * whole MMC devices (because we require multiple partitions).
> +	 */
> +	return log_msg_ret("Unsupported", -ENOSYS);
> +}
> +
> +static int distro_rauc_load_boot_script(struct bootflow *bflow,
> +					const struct distro_rauc_slot *slot)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	struct udevice *bootstd;
> +	const char *const *prefixes;
> +	int ret;
> +	int i;
> +	int j;
> +
> +	ret = uclass_first_device_err(UCLASS_BOOTSTD, &bootstd);
> +	if (ret)
> +		return log_msg_ret("std", ret);
> +	prefixes = bootstd_get_prefixes(bootstd);
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +	priv = bflow->bootmeth_priv;
> +	if (!priv || !priv->slots)
> +		return log_msg_ret("priv", -EINVAL);
> +
> +	bflow->part = slot->boot_part;
> +	if (!bflow->part)
> +		return log_msg_ret("part", -ENOENT);
> +
> +	ret = bootmeth_setup_fs(bflow, desc);
> +	if (ret)
> +		return log_msg_ret("set", ret);
> +
> +	for (i = 0; prefixes[i] && bflow->state != BOOTFLOWST_FILE; i++) {
> +		for (j = 0; script_names[j] && bflow->state != BOOTFLOWST_FILE; j++) {
> +			if (!bootmeth_try_file(bflow, desc, prefixes[i], script_names[j])) {
> +				log_debug("Found file '%s%s' in %s.part_%x\n",
> +					  prefixes[i], script_names[j],
> +					  bflow->dev->name, bflow->part);
> +				bflow->subdir = strdup(prefixes[i]);
> +			}
> +		}
> +	}
> +	if (bflow->state != BOOTFLOWST_FILE)
> +		return log_msg_ret("file", -ENOENT);
> +
> +	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
> +				  (enum bootflow_img_t)IH_TYPE_SCRIPT);
> +	if (ret)
> +		return log_msg_ret("read", ret);
> +
> +	return 0;
> +}
> +
> +static int find_active_slot(char **slot_name, ulong *slot_tries)
> +{
> +	ulong tries;
> +	char boot_left[BOOT_LEFT_LEN];
> +	char *boot_order;
> +	const char **boot_order_list;
> +	bool slot_found = false;
> +	int ret;
> +	int i;
> +
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order)
> +		return log_msg_ret("env", -ENOENT);
> +	boot_order_list = str_to_list(boot_order);
> +	for (i = 0; boot_order_list[i] && !slot_found; i++) {
> +		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
> +		tries = env_get_ulong(boot_left, 10, ULONG_MAX);
> +		if (tries == ULONG_MAX)
> +			return log_msg_ret("env", -ENOENT);
> +
> +		if (tries) {
> +			ret = env_set_ulong(boot_left, tries - 1);
> +			if (ret)
> +				return log_msg_ret("env", ret);
> +			*slot_name = strdup(boot_order_list[i]);
> +			*slot_tries = tries;
> +			slot_found = true;
> +		}
> +	}
> +	str_free_list(boot_order_list);
> +
> +	if (!slot_found) {
> +		if (IS_ENABLED(CONFIG_BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES)) {
> +			log_warning("WARNING: No valid slot found\n");
> +			log_info("INFO: Resetting boot order and all slot tries\n");
> +			boot_order_list = str_to_list(CONFIG_BOOTMETH_RAUC_BOOT_ORDER);
> +			for (i = 0; boot_order_list[i]; i++) {
> +				sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
> +				ret = env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
> +				if (ret)
> +					return log_msg_ret("env", ret);
> +			}
> +			str_free_list(boot_order_list);
> +			ret = env_save();
> +			if (ret)
> +				return log_msg_ret("env", ret);
> +			do_reset(NULL, 0, 0, NULL);
> +		}
> +		log_err("ERROR: No valid slot found\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	const struct distro_rauc_slot *slot;
> +	char *boot_order;
> +	const char **boot_order_list;
> +	char *active_slot;
> +	ulong active_slot_tries;
> +	char raucargs[64];
> +	char boot_left[BOOT_LEFT_LEN];
> +	ulong addr;
> +	int ret = 0;
> +	int i;
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +	if (desc->uclass_id != UCLASS_MMC)
> +		return log_msg_ret("blk", -EINVAL);
> +	priv = bflow->bootmeth_priv;
> +
> +	/* Device info variables */
> +	ret = env_set("devtype", blk_get_devtype(bflow->blk));
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	ret = env_set_hex("devnum", desc->devnum);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Find active, valid slot */
> +	ret = find_active_slot(&active_slot, &active_slot_tries);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Kernel command line arguments */
> +	sprintf(raucargs, "rauc.slot=%s", active_slot);
> +	ret = env_set("raucargs", raucargs);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Active slot info */
> +	slot = get_slot(priv, active_slot);
> +	if (!slot)
> +		return log_msg_ret("env", -ENOENT);
> +	ret = env_set_hex("distro_bootpart", slot->boot_part);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +	ret = env_set_hex("distro_rootpart", slot->root_part);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +	ret = env_save();
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Load distro boot script */
> +	ret = distro_rauc_load_boot_script(bflow, slot);
> +	if (ret)
> +		return log_msg_ret("load", ret);
> +
> +	log_info("INFO: Booting slot %s, %lu of %d tries left\n",
> +		 active_slot, active_slot_tries, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
> +
> +	log_debug("devtype: %s\n", env_get("devtype"));
> +	log_debug("devnum: %s\n", env_get("devnum"));
> +	log_debug("distro_bootpart: %s\n", env_get("distro_bootpart"));
> +	log_debug("distro_rootpart: %s\n", env_get("distro_rootpart"));
> +	log_debug("raucargs: %s\n", env_get("raucargs"));
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order)
> +		return log_msg_ret("env", -EPERM);
> +	log_debug("BOOT_ORDER: %s\n", boot_order);
> +	boot_order_list = str_to_list(boot_order);
> +	for (i = 0; boot_order_list[i]; i++) {
> +		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
> +		log_debug("%s: %s\n", boot_left, env_get(boot_left));
> +	}
> +	str_free_list(boot_order_list);
> +
> +	/* Run distro boot script */
> +	addr = map_to_sysmem(bflow->buf);
> +	ret = cmd_source_script(addr, NULL, NULL);
> +	if (ret)
> +		return log_msg_ret("boot", ret);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_bootmeth_bind(struct udevice *dev)
> +{
> +	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
> +
> +	plat->desc = "RAUC distro boot from MMC";
> +	plat->flags = BOOTMETHF_GLOBAL;
> +
> +	return 0;
> +}
> +
> +static struct bootmeth_ops distro_rauc_bootmeth_ops = {
> +	.check		= distro_rauc_check,
> +	.read_bootflow	= distro_rauc_read_bootflow,
> +	.read_file	= distro_rauc_read_file,
> +	.boot		= distro_rauc_boot,
> +};
> +
> +static const struct udevice_id distro_rauc_bootmeth_ids[] = {
> +	{ .compatible = "u-boot,distro-rauc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(bootmeth_rauc) = {
> +	.name		= "bootmeth_rauc",
> +	.id		= UCLASS_BOOTMETH,
> +	.of_match	= distro_rauc_bootmeth_ids,
> +	.ops		= &distro_rauc_bootmeth_ops,
> +	.bind		= distro_rauc_bootmeth_bind,
> +};
> 

