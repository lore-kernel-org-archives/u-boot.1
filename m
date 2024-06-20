Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C069C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 08:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AFFC88496;
	Thu, 20 Jun 2024 10:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2zq5I20C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F65B88378; Thu, 20 Jun 2024 10:55:18 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4C987C68
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 10:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTX+ulLZoqeYfK9qemh1JJ5EBqjvaiP5++oDq0RVyIwD4FlY5iSNs1ab3ECUoMiwg1xQ/IVyjdHeMKRpJF/fN6m3NMghWX8Z/S6SRgPAfNPpuEU7+X5wZ3wjM2rjYcbRA8RmMt8Zi7hDG5yT/tgn1PZ6nDTS/dbZRT+kIcio7FmRxCgIgqVLtEzL7H2qqy0YgHeoLq6FGQaX8NCa1qOArpkL8ZAw+p7YevTNqtWbd2iilKFRFxgqGRD8m9kIinFNIbM49JeTUOxydVBsCmBz7OOuPg/iIkwA3xMJsLGjmHjBLg//AIi9/cYsaWfQtIs/ZvgLql+l/mXOqjCUSZW7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrTkR3SY8amRGUaLd9l0Q5t/WQVNnh8KW9wdMKSf/AI=;
 b=ScA6QgvNjk80EHITcrLQmzDvzfAYJCvFMwGZsrbm8HuxyMqq9kwR5sFbL820buHxVoch2PnP22Eij7+fT8WTrDJkI9jyjPrjUIdJWrqNPps0YgfD0bj/Mqd2SGBNFtSjizHLXXWnR46Y8llZc146iM4E1bax26VTZGRzgsOnJ2beKfDmDst6vvhtrOo0TZjDEekxdrAcp8r311oyEqfoka4HUwvyarETnFkFYYDtRIBRdnqXJjuxVBIr+9bfjiXizUg8saXDL4ncw9RtfW6fG/zerg7K+csrN4Qcy/7qKjnVji/PdEorns/mtyZfNIAT6C4Y7fwnre9Fj1q+XkXmFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrTkR3SY8amRGUaLd9l0Q5t/WQVNnh8KW9wdMKSf/AI=;
 b=2zq5I20CvVrLSJ9A7CZMVB1PYnJiHfY/pdfRheG1M1mz/juBGG1E5gDYtzlFT5fJpsiVcCZm7nBFgIFGasaYU8Eqqyqdrx9ixlxXMoAmbNub3pCuXZfpJpncfn/J2bUrj7QWkIBiFmeRI1iHSskDkSBogbj7lr9Dce3itpF2dho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 08:55:11 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 08:55:11 +0000
Message-ID: <060d4b36-e47c-4275-a890-ef5e58d83366@amd.com>
Date: Thu, 20 Jun 2024 10:54:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] use fdt_kaslrseed function to de-duplicate code
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240618210609.1744727-1-tharvey@gateworks.com>
 <20240618210609.1744727-4-tharvey@gateworks.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240618210609.1744727-4-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0083.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::36) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deaaa64-011b-4412-1883-08dc9106b18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3lMS3A3d2Fma2hkdk4yZjlhTk5NcnZNZG9QVTM1STkwTUlyU3ZxVTBUQWY3?=
 =?utf-8?B?OFlQTlFoVkptYTVYVFFxeVNVeElBam5Lb0pENjV5MjdBblBSSUVFR3J5LytD?=
 =?utf-8?B?VDFwMlh5SEg0Yi82SlpKdGNhTWY5UFk1NXFQTWN6NVZDczc2Ulg2c2lTaHlL?=
 =?utf-8?B?RFY0SytFMm9tdjZKb2E3RytPYy80L0xoSWV1SVlIRUdJZ0Jmd3VwZjArRWdz?=
 =?utf-8?B?RnQ4WVFEbTBVT0VjUkNLQmFLblhqcStJK1pITEVxSE9wODYzYTZwWWR6N3JW?=
 =?utf-8?B?cmNqeWg0MC8wUWlHNjhVOXJGc0h2OERUWUJ1czF5RGNSdHFRN0IvbmxOeEk5?=
 =?utf-8?B?SERlbXZvSWp5c0ZNc2ZCOHhxNkE3NUE5Mnd5WTJzc2tpNW8zM1VDYVJsL0tZ?=
 =?utf-8?B?MG5CbHdsSnY4RDc1RjZHczgxWmRaWmY4L3RrelhrQTcxdDc4ei9HTDdRSjBK?=
 =?utf-8?B?cnp1d2t4dTVmRVluWjFWbzJVRTR1QnFEUllWMlV3Mm5mc3ZNQzl6WXVyU3pL?=
 =?utf-8?B?VDNMb2JlaGdGR1VHYk9NUldEVStWYUpUQURHVVhZWjYxTmNRYTVMcE9rQmhq?=
 =?utf-8?B?ZjdsWWJRdDZaWmNEZnM3cXQzeUQ5VXhIdDhjTEpsV3VTenZsQjYzUnZCNElj?=
 =?utf-8?B?a0MrUHRPSkdLZU9iZ20vYXhwdmZhTWZacmlDVFZyaTFQSkxhZDVuNG9mMGs3?=
 =?utf-8?B?TGk1SUFHSmNabDYva1UxMldqaHpoWUFjVEVzOVZraDlBUjE4VUluL3orOXgx?=
 =?utf-8?B?Mkk5Y08xQnlSQ1RIVzV2cnZHcEJjTzZzMXdGL0tDRVVHQWxOaFJ1M1J1alRQ?=
 =?utf-8?B?THp2NVFwRCs5VkRGSmdKRklINC9ueHVlM2twT3ZTRUNjZEdST1Y2bFNyRE43?=
 =?utf-8?B?cUVpdnRscUlYOXVpQkhqeWhCUVVQemhSenJDL0UyU3hVSVBDSTg3ZTg5d3Q0?=
 =?utf-8?B?bmlPem85NEoyQTN3SzBZbEhVZHJ0clh1cGdvKzRCU2RqcmhQZjh6dXFmYVIw?=
 =?utf-8?B?aE92Yk0ySWRrUWJmWnFDWlBhTVRUdDhGUmw5WFJLYy9ad25GZTBqOGlWVkN0?=
 =?utf-8?B?VnVrUmxFZHFUYlJDWnVIMWdrcStzVXhKU25IYzdPZ0JTc3JHeXl4NCtmdnlN?=
 =?utf-8?B?M1M3Y28rWmpIUmhxYWNLazl2eGZTWkFydzJSYUNOVXlVRVJsWHMwbldWWk4r?=
 =?utf-8?B?blo2QnhXTEQ0cXYycnVGb0F3MDY2ZjlkNmRycVZzZXpGeVdCWGxGMi9USmVI?=
 =?utf-8?B?aGg2VnVWekN4QzdkbVZsVUhmek1yeXdaMm12QWwrNlRvdzlQVnFXWDE2Uno0?=
 =?utf-8?B?Smw3bHpQN0Y5MTB4VCtsY3d5Y3VFOFBKNFJPQXVvUS9pdVhOT3FOSDVkOC9v?=
 =?utf-8?B?WThLMGtDcEwzVmlQSDg2dVI1bEZyYnpnZjFBYjVqUHk0d2ZUZTNZVUZ6RE4w?=
 =?utf-8?B?Zk9NeTVqaTJnQjRNNzFXRkRWemp6TU5Bc3BxenhRWVNOT0wxY2Z5YjBaRCtq?=
 =?utf-8?B?MGJwby9ZNlptZ29RdGNROXNzWUhYdGY5aEVwd0o5SWVMcy9LOUY4cGswWTBw?=
 =?utf-8?B?NEJoTkpKQnVkeldveHdhcGd1ZmRnT2lldFhsamtzTHNMREUzb1FKVkdLNEN0?=
 =?utf-8?B?cWcwQ1RKd3hrSXp1OWFWSnB3c09hWHdVVEZpeGxGeU90ZTN0Smd4aFZVa0xZ?=
 =?utf-8?B?ZlphaDBEVGFmUE9WK1AzLzdydUR1dkpBd0RaM2didEVWRk1yT0ErM2dtYzdy?=
 =?utf-8?Q?XPEeUM+ejpSv4kPQwz3lVhoghIAFD+nnNkcnSr0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(7416011)(1800799021)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MElMNWhxOW03SlorWlYrSHNsWGpDcFluejBxR3FDUTczMlFNbTJ4TzBFV3pV?=
 =?utf-8?B?dGRpT2RDSE8wVTBQL2dVWW1TdzAzQ20zaVNDdUI3c1dvbkFXZlpTMlFvTERL?=
 =?utf-8?B?bC9lNmdwWUI5ajQxWkJmVGxmejlpUWdTTCtudThQZ1dlbGJXRnBBbE9uWmp2?=
 =?utf-8?B?eVR0N1ZpVDAra1h2WDdjZkI5WUhFNlRwTVl4Sy8wUDhsNmJYdHI4OFovSEtv?=
 =?utf-8?B?dUE5M1Y4R2JQaG81TzRpNXNGWUVhQjA4TlRuNjc3eVhXQ01MQlFFTi9xRTRJ?=
 =?utf-8?B?Y3BodGlKS0hxcDI4SkNkSUhCTzhURlgzOWErMkIwa1BWNThyc0ppZXpwUStk?=
 =?utf-8?B?MWZJK1lmUmF0aWZwWE5ESnQ2VEdkZWFUQnBTNm9hMnNlVTNSOWIyZXRicDlZ?=
 =?utf-8?B?UkdMR0oyc2tvSXNKYTRQWlVNMWlqdkM2bG5HK0xrWWNnNW1OSWlkb2xOMElr?=
 =?utf-8?B?dWtDSUgzOXhQN052aEM0UTdQR250Qmc5Y1J0Y0tzeUw0VU55ZHNvNkczUzFm?=
 =?utf-8?B?d2ZTZ20rdkdDRW11UTBsRk95akdzZktVc0JQZ053NXRVVk1Zd3VydTduZFNs?=
 =?utf-8?B?SmIxVHhHVnM4aEFqN1RHQ0ZZUmlZT3NYYWtpcGVkWXo2b0FPS25IUVpzaDFX?=
 =?utf-8?B?VjduRzU2dWlJeVRzU2tOL2dvMHdLOXN6dUVpV0U1Rk1kdVo2R2lJN2pXalNr?=
 =?utf-8?B?bS9wOXJlUkVKWjVna1lZSXdraWZwWDBkaTRMVVM1dmQvNjZWTDBVY25rYUh0?=
 =?utf-8?B?TTl1anpITEVtWWlDVWV1Wlk1cFpDdEJhNEhKSDdTbDBISGZoajhsang0Kyti?=
 =?utf-8?B?Z0JpZ1I0em03SVhROFU4V1VGaDd2NmRoQ2kxNnVQWFB6ZmdsK01xWk12VXBW?=
 =?utf-8?B?anp2VCtmR2FSdnJBZlIvdkRRRmJUTndkSFZhT3FUd1h1SnV4SHRjekdxdUlF?=
 =?utf-8?B?UnRnVnhmS1FsN3EyekJnb1VzN1hqbmo5RFpzbHkydTZBK044K2ZPK0d3dVdx?=
 =?utf-8?B?VVFyWnI3YTFHeStockkyUFBjenIrdW50SmoyYldUc1dZNGZydS83TjNVNUg5?=
 =?utf-8?B?ajMvNEx5cnN6ak1lWjhGazNlUFlpYjZ4eGhEU3RwSmw3eHZNYzdxeFEweitr?=
 =?utf-8?B?ZUxPa1k1WkV0R3J0TkVYYTJJUVlKM25ib2hQZm9lUDRQdTVIbVBEeUd0ek55?=
 =?utf-8?B?aUN2djJlaGY3M3ZXbGVZUkhoeUJPQ0EwTkRDeTZqVVNzRzFlcEtST2tYaTZx?=
 =?utf-8?B?MHB1bGZtQ1dVcllyMUw4TWxrTExkTDloNVNwYkV4ay9jMzd2bkpWTlhrT0tm?=
 =?utf-8?B?dnRtWC9jZjY1OEV3Tnh5Y0ZUTVZPRVdXbFYyUGEyR2xmMmI1aTVOcytzaExR?=
 =?utf-8?B?Wk9kQXM2elNYOGpZU24zV3BRa0tZWkNHK3lubTdFK3FVZE5pUERtT09zT094?=
 =?utf-8?B?U1pScGZyS0M3ZnlBRjhZbXpQc1ZzblF4MzJHbnN1VlR5UDB5YkMyMThNOVZO?=
 =?utf-8?B?aE80NkQwK294VzN2VUptMTRYTDdkQzMvNnBFRE9XY1MyRTc3cWFwZEVjSkhW?=
 =?utf-8?B?bStrdHV3NFQ3TS9vaHpXelBUUGh0ZFJVSXBUTVJtSmVnSjAvZWVvTC9DbjRN?=
 =?utf-8?B?d3N3RWNuRnRsZWx4NHl4dFFsaFNENWV5T2FKTGRFZ1dSZ2k1cEFVTmRDRkta?=
 =?utf-8?B?aElXdUZrbXVkSUVJOENZeE1GTnJlVjRPTGIyQmluR0NRZ2ROM1pYZ2tOU3RF?=
 =?utf-8?B?UW1KcU5zYTNmeUgrM09LblZ3cUJYNWJYUkJpcVl0RjlEYmtqOTVGajFQa2VR?=
 =?utf-8?B?ejNSNElJNmpGRlJwOEU3dnNTTVNXbThRYm9VYUdLOGJPb2svcm44SXppS2Q3?=
 =?utf-8?B?TGpUY2FJbUtRNWUxRC9yVEFDK3pZM2RXTGpPT0NDZHdKZVcxZG5uSzBsbGVK?=
 =?utf-8?B?SWlpTStFZmdmcCt6UENZcnc2Y2tzU0N5NW9FNG9NaG56K09iVDhvUVVhLzVi?=
 =?utf-8?B?OWNzMnV5blNWZDlZY3dxNTZDenFTTDhtdGhmVGk0MFQ1VllvenFvdUljTEVj?=
 =?utf-8?B?bWppTncxWlpreHdrWmtmSG10NVJ2a2NHMzRtK2g0cE9YclVoMmVoMlZDcHQ3?=
 =?utf-8?Q?bu1WTQlHTm6fDC9GSpx3tgpUe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deaaa64-011b-4412-1883-08dc9106b18b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 08:55:11.5041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FABhS76hNI+JinSw3/OnDL1mthX4IfZbPn3getgRFxeqwzo13VhADM4aD46h26Df
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
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



On 6/18/24 23:06, Tim Harvey wrote:
> Use the fdt_kaslrseed function to deduplicate code doing the same thing.
> 
> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> but left in place in case boot scripts exist that rely on this command
> existing and returning success. An informational message is printed to
> alert users of this command that it is likely no longer needed.
> 
> Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> randomization and completely ignores the kaslr-seed for its own
> randomness needs (i.e the randomization of the physical placement of
> the kernel). It gets weeded out from the DTB that gets handed over via
> efi_install_fdt() as it would also mess up the measured boot DTB TPM
> measurements as well.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Akash Gajjar <gajjar04akash@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Devarsh Thakkar <devarsht@ti.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> ---
> v6:
>   - collected tags
> v5:
>   - fixed typo in commit message s/it's/its/
>   - use cmd_process_error per Michal's suggestion
> v4:
>   - add missing /n to notice in kaslrseed cmd
>   - combine ints in declaration
>   - remove unused vars from board/xilinx/common/board.c ft_board_setup
> v3:
>   - skip if CONFIG_MEASURED_BOOT
>   - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
>   - pass in rng index and bool to specify overwrite
>   - remove duplicate error strings printed outside of fdt_kaslrseed
>   - added note to commit log about how EFI STUB weeds out kalsr-seed
> v2:
>   - fix typo in commit msg
>   - use stack for seed to avoid unecessary malloc/free
>   - move to a library function and deduplicate code by using it
>     elsewhere
> ---
>   board/xilinx/common/board.c | 40 ------------------------------
>   boot/pxe_utils.c            | 34 +------------------------
>   cmd/kaslrseed.c             | 49 ++++++-------------------------------
>   3 files changed, 8 insertions(+), 115 deletions(-)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index b47d2d23f913..098738017bab 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -702,11 +702,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   #define MAX_RAND_SIZE 8
>   int ft_board_setup(void *blob, struct bd_info *bd)
>   {
> -	size_t n = MAX_RAND_SIZE;
> -	struct udevice *dev;
> -	u8 buf[MAX_RAND_SIZE];
> -	int nodeoffset, ret;
> -
>   	static const struct node_info nodes[] = {
>   		{ "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
>   	};
> @@ -714,41 +709,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
>   		fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
>   
> -	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -		debug("No RNG device\n");
> -		return 0;
> -	}
> -
> -	if (dm_rng_read(dev, buf, n)) {
> -		debug("Reading RNG failed\n");
> -		return 0;
> -	}
> -
> -	if (!blob) {
> -		debug("No FDT memory address configured. Please configure\n"
> -		      "the FDT address via \"fdt addr <address>\" command.\n"
> -		      "Aborting!\n");
> -		return 0;
> -	}
> -
> -	ret = fdt_check_header(blob);
> -	if (ret < 0) {
> -		debug("fdt_chosen: %s\n", fdt_strerror(ret));
> -		return ret;
> -	}
> -
> -	nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
> -	if (nodeoffset < 0) {
> -		debug("Reading chosen node failed\n");
> -		return nodeoffset;
> -	}
> -
> -	ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -	if (ret < 0) {
> -		debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> -		return ret;
> -	}
> -
>   	return 0;
>   }
>   #endif
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 5c1c962ff4c1..38ca9b81a42d 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -324,10 +324,6 @@ static void label_boot_kaslrseed(void)
>   #if CONFIG_IS_ENABLED(DM_RNG)
>   	ulong fdt_addr;
>   	struct fdt_header *working_fdt;
> -	size_t n = 0x8;
> -	struct udevice *dev;
> -	u64 *buf;
> -	int nodeoffset;
>   	int err;
>   
>   	/* Get the main fdt and map it */
> @@ -343,35 +339,7 @@ static void label_boot_kaslrseed(void)
>   	if (err <= 0)
>   		return;
>   
> -	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -		printf("No RNG device\n");
> -		return;
> -	}
> -
> -	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -	if (nodeoffset < 0) {
> -		printf("Reading chosen node failed\n");
> -		return;
> -	}
> -
> -	buf = malloc(n);
> -	if (!buf) {
> -		printf("Out of memory\n");
> -		return;
> -	}
> -
> -	if (dm_rng_read(dev, buf, n)) {
> -		printf("Reading RNG failed\n");
> -		goto err;
> -	}
> -
> -	err = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -	if (err < 0) {
> -		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
> -		goto err;
> -	}
> -err:
> -	free(buf);
> +	fdt_kaslrseed(working_fdt, true);
>   #endif
>   	return;
>   }
> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> index 9acb8e163863..645cab2e74fd 100644
> --- a/cmd/kaslrseed.c
> +++ b/cmd/kaslrseed.c
> @@ -16,56 +16,21 @@
>   
>   static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   {
> -	size_t n = 0x8;
> -	struct udevice *dev;
> -	u64 *buf;
> -	int nodeoffset;
> -	int ret = CMD_RET_SUCCESS;
> +	int err = CMD_RET_SUCCESS;
>   
> -	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -		printf("No RNG device\n");
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	buf = malloc(n);
> -	if (!buf) {
> -		printf("Out of memory\n");
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	if (dm_rng_read(dev, buf, n)) {
> -		printf("Reading RNG failed\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	printf("Notice: a /chosen/kaslr-seed is automatically added to the device-tree when booted via booti/bootm/bootz therefore using this command is likely no longer needed\n");
>   
>   	if (!working_fdt) {
>   		printf("No FDT memory address configured. Please configure\n"
>   		       "the FDT address via \"fdt addr <address>\" command.\n"
>   		       "Aborting!\n");
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	ret = fdt_check_header(working_fdt);
> -	if (ret < 0) {
> -		printf("fdt_chosen: %s\n", fdt_strerror(ret));
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -	if (nodeoffset < 0) {
> -		printf("Reading chosen node failed\n");
> -		return CMD_RET_FAILURE;
> +		err = CMD_RET_FAILURE;
> +	} else {
> +		if (fdt_kaslrseed(working_fdt, true) < 0)
> +			err = CMD_RET_FAILURE;
>   	}
>   
> -	ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -	if (ret < 0) {
> -		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	free(buf);
> -
> -	return ret;
> +	return cmd_process_error(cmdtp, err);
>   }
>   
>   U_BOOT_LONGHELP(kaslrseed,


Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
