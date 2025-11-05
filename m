Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4D7CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 10:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9D383A5E;
	Wed,  5 Nov 2025 11:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="T0oxgdzW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14AB683A61; Wed,  5 Nov 2025 11:52:02 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEDAB83A3D
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 11:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuYgJh+8HEa/B+9bisJGLPSVnkjlo/zW+u28l766+/DmcRHIdFrIhlqv0c0N1/a6sbLJeKFOnDwK58f03U+QRGpAmRg8rHoM9n+i49Le9mBod4/yan62FKR20cj09vjMlzFl9DvpEvAJdEsLZYeCEqubsqKFNeTbIyY1m5GUhrMLI9YeX5HrGnw1GPs+alZA3/asWiYnAnoJy8K+tmghh5Kdh+DTu27jKLA3Pm7D/6gtU0w6n2i/Og4eW9QZQQ2+kufSHos6mefcupPGw/lIgnRxf2Cl9jWhmCIMkXs+HOGVxu9YlG4x4+RCidiDFthK7OztnPMoRPU3+z/bpkcZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa4pnYeEdhpYV1en9ebqeGoFMc7hbfD7XL68Yf8j1Uc=;
 b=CrcpEUHXphB9Pz09As8hI1JGelC4eu4G42emegEbp3jyr7ZOfsfH4XfmioGrE91/dp9aWhKAn/B0EvL8P0bWdZwxOsaEh7UBA5OtCzE3l1rRCfcuurCR/SfYpyIB3JIP19xToyBuM3cVSFc/ENwIlaQn9rIMWxrr5+Muh4Dy4Z1VDJSD3zygCi/58UaZQFSJVBoLmCbEA5rfDkQ4n6anMqvJ1ladjZ4Y+YekLfKwBrSDeS3PneBpRkJ6ZK6teQQhDE0BL9Nn2mCvW1gG4iaKvqge4LtGFyTIApgU9hxfXpG0Qt7Pk0+Ev70a3EVk1+2Is9tVQGElwawiopBwP3qcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa4pnYeEdhpYV1en9ebqeGoFMc7hbfD7XL68Yf8j1Uc=;
 b=T0oxgdzWPkFZYWadNjubuEaF+HJgOZPehjOW+mExCsIbieCNSlPj0ot4LZdDgrb3xYo9PzzfmGjOTq3hEHWLU2Ti8teURQwnVecAS6DU0VPjcUq0+xxSitxH+0Jq0OGB0MzVmhOoRWVG1qPnt4sdazfrj05zn+ifXKD4AYFh4Tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by FRWPR04MB11282.eurprd04.prod.outlook.com (2603:10a6:d10:19e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 10:51:57 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 10:51:57 +0000
Message-ID: <ba8f8288-ea18-4c40-a518-712c1414e841@cherry.de>
Date: Wed, 5 Nov 2025 11:51:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: Add support for out-of-tree config fragment and
 defconfig
To: Neha Malcom Francis <n-francis@ti.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org
Cc: bb@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com, gehariprasath@ti.com,
 ziyao@disroot.org
References: <20251105102316.1713954-1-n-francis@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251105102316.1713954-1-n-francis@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0333.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::29) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|FRWPR04MB11282:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3509cd-98b5-4601-598e-08de1c5956e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2RCVlNGbi9PQUxVblNGMVhlUCtNSmNaQ2dxYm9LU3ZQZDN0ekZ1NzM3SUFO?=
 =?utf-8?B?U2g1c0hzSTVqRzVkYjltejVuTjFjRyt1am9WY0k3NCsxcUQ0VThtQzdVWDAw?=
 =?utf-8?B?MXVyUTdkTjV1Zy9LeXNSN1NxcmdPQjF0MkRJOS9RZlZreFp1Uy93UERsUHNy?=
 =?utf-8?B?N3gzbi9vM3V0VmJmdGFVWDRsWXlUcHV1emFVd0JialBSWnFEQmU3dFNhNWFa?=
 =?utf-8?B?Rzk3Y2UzMkVieDNXRU1PMEZ4MEFmZElDa3hOTWdCSnBkMnIzT0JCbVh2UE16?=
 =?utf-8?B?V0lYT0tjemZET0pzQmoxRHpreEsza1VRSitlaktSVEU4SC9aME1uejROK1RX?=
 =?utf-8?B?WTZFenZGYUtIQmdaeHZrNU00bXFxUDV4REU1MWZqaHdlazVKblNuR1FXR2ZH?=
 =?utf-8?B?TFhDaE1yd0c5YktoVGM5amNOUlZlNUxwUDNQTlRWMnMySjRoV3BWZHA4cGpD?=
 =?utf-8?B?UXFLWkhVaHoyb2ZKOWt6Ull4OU1VT3F4NGJoWU1GQ3UrNmhwUzZSVmswbnhS?=
 =?utf-8?B?ZDNBbzVVaDFjbzB4V0Z0ZFUyNXVDOWdZK0RSOVZlYWNFQlJLeGt5Z21ZTWdo?=
 =?utf-8?B?UXZobnRBSWd4by9GcVRLOXdiUk80L2o0ekZ6M3o5bWV3clJtaXUybFhpYis1?=
 =?utf-8?B?UlZCWkJOTFpxUFZZT01CNGhaRVRBZHU2U0V3TnFCTEtBUTZHMEtWNi9nbEZR?=
 =?utf-8?B?aGw1dEZWRzNrdVRRUVFTdkRYMlc1MVFzUmRYVU96UThmK3VkeXV2SWJDZmlG?=
 =?utf-8?B?U21iMURjK1E0S2dQZ2dmdHJ6TmJDUW9nU2IvVy96dy81bUJENC82ZDlQQmEw?=
 =?utf-8?B?NUU4RWlSVmQ5ZGh0VTdOcTZMNE1MbnRrbTJXMGFLZTJ0cmk4UjhJWWV4UzF0?=
 =?utf-8?B?NUZQbnFxQmtqZG5UYmtleWhMSjBuSXU4b01WSERPWUtiVWRHT2U5R1VzVi9G?=
 =?utf-8?B?Ui85Z3prSCs4bVVYUzZ4L2Q4cGxLRHBuSlpEYVlRTGYvVmN6dkU5SEVhRDhX?=
 =?utf-8?B?TmVSSVA1WThleGdWRzIxTUx1YmhjMUIwcU4zcmdkT0tVWEhvWE4rbjdScWFZ?=
 =?utf-8?B?U3FyNmRJUGFrMDlmOEc1K3JNMjhRcU1VV3hRT24yMG1LbzR0Y3h5UkgxYkwy?=
 =?utf-8?B?ZzJCR0hMbFhEcVQzOCtTeDVva1UzQkVIVnpPemZBVWRNNVF0K0dIdks0S3ln?=
 =?utf-8?B?cXVwaS9uMU4vbXBXWWgvQmlRenZ4N1p6SGF2enhySmNpL0NhZ21LOVN5QjBa?=
 =?utf-8?B?RlU2NGVPR3UwM2FJRGRNTWJGTkhPVEpPb2lOUGZvcUhEdHZpeGc3aWZxS2Q1?=
 =?utf-8?B?M3lUSXJZbG1NcjB1ZlM4OWxKNDlydlUwSWNXWVN6N3FETjJRSDBtcGtlZG5p?=
 =?utf-8?B?YUxMWlRGMGZXOWgyZTArYStkeUhtRkdJWkpHWGt2QUdVRERDaWEvdDNMWWJy?=
 =?utf-8?B?N2xEN1ArVkZxaW1SMFM0NWlHSzI5ZXRjUkZ6MzgrcytzbW9KSmloQXdLb3Va?=
 =?utf-8?B?ME1VK1ZxY0U2K2hVLzVwYStsc1hMaElCMDhDQWw0M2tySG5obVRkTU5wSXRO?=
 =?utf-8?B?amg3ZGJzQ1ZCcGVUanh6bUlQeG9LbGVmRXdibTJxc1J6S1MzQnhxNUdoWE0z?=
 =?utf-8?B?Y2RSdDJkb0VmREFVWnJFU2oyZ2tobXBjakxCTVJpdTNkMmZINGJRczlJUGc4?=
 =?utf-8?B?YkI2UlRudExmdDVqbDIvbk40YTNUbmhlMUI5a1VTdzBOR3NoSHBaR3BwcFgy?=
 =?utf-8?B?Qk5DYWVjZ0dsZEpmZkNRTWx1MUlLbnY5UFdXcjNIWGFGRHA5S1V4NGxGVWFR?=
 =?utf-8?B?V1NCUzJML2NTc21hbWllVERJMTdNeVRrMkIwSEF6akt0V0dKNnJpRkU4YnBH?=
 =?utf-8?B?TFhHaDh1KythWUNYNzNtWjZiVmkzQTRyUGhDY1lrVUkzUWQxQ1cwRVpDQW5J?=
 =?utf-8?Q?h0Xw6rLFeMv1YftjAkz9X/6q40tdKsI0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1hDUGJVaXVZRTdjSGxpM01DVzJ1SDlJaTNhY3FndDFNblN4ZXVoY3RLSnVG?=
 =?utf-8?B?enRvVkdJS0tBN0kySnNBNVN0SGo3MzhONmVScDVqUVM4VmFlc0tzMFlWYnV3?=
 =?utf-8?B?WnpFTWFnMHoyZ0UyQk1FbGpaQkZSVzc2NnFqY3RPV0lWTmlSYXgyN1FJU09p?=
 =?utf-8?B?bm1ualVOa2JpWFVyQ0V5S0kwOGxBL3FDMFVjTkh0Ukc1QXBDRXdpZFc1c3VZ?=
 =?utf-8?B?WjNoOFdyazZQVUVGYm5zTzhCTFBmSUNTR2U4RkoxOE55eXVXeEswZkQ0Qkl1?=
 =?utf-8?B?K3l1eU9jRW5sK1BwV3Rla1M2NjJhVC96NzBlWVR2MkJIT3ZON2E0dGVXWUFB?=
 =?utf-8?B?MjN1QTJiZXlDUXlraGxHTUFkRVh3QWNNaFpKUCtPTmhZeHVjV1Z3QkxkTW4z?=
 =?utf-8?B?LzdSSzBlb0dXQVlBYUFUZFdybk93aG1IRkpLNFRpY0pacWxrOE9vdk5Bd1NO?=
 =?utf-8?B?dS9EL2hkVW1qb0NzZTRuOWRJM0NYWnd5UUhnUmZ3SmE1WVFzdVZCSTBCa2ow?=
 =?utf-8?B?TUtvVXN1d1dpOHAxOE8rTTNubithdlN1VTF3NlRIa0JZcEdYKzdlVjJHejk5?=
 =?utf-8?B?ZE51VXhhVno1ZHBDNnF1bXJPZGFDWjArLzdsWFZVSUxQWGl5RVozMXVwYTMw?=
 =?utf-8?B?RFFyUC9NZ1ZSZk8xbmMxMTBVUngyQWRJbEVMb09POFdMZzNVb2g0cjJwampw?=
 =?utf-8?B?L1AzSXp2eWF4YVFlTkg5bFYrMGlpVC93empVUG0yTDFkRlFZYjBlYWVVeGFp?=
 =?utf-8?B?dTc2Y0pmb3N4M0k5NlkzYnJHb3VZM09UaU11dkRqbzhOTnM2Sys0NmpnQXRQ?=
 =?utf-8?B?cFR6SGJmajZXRS8rSmpYb1IvWldrUk4zUk1HeFJGU0E5SmFBODVMOXhJM3pQ?=
 =?utf-8?B?NjNBcWUxM245ZFQ5RGp5Mmg2MUVyL2hVQ3pqSzdkeDV1aEtkV2U4VFIyRDRv?=
 =?utf-8?B?Q2JZYlJHaFR0azZtd0ZxVk96bFBPaVUwSmV1S3ZNRDBnUXBFT0djT0thNlpq?=
 =?utf-8?B?QkVOUFI1YzdKazR2RnIyQVYrZ1ZDTnM5TTVST2lncVZndU4vNTM0aHVYT21y?=
 =?utf-8?B?amNRS1hnUFpaSXo5Z01ESHZJSnRScUd3SW8rMHlJME83cHdqL1laVk5mbjRj?=
 =?utf-8?B?alhpMVY2dGpma3hMYWJUTEVKcHBVM0dhNENDTXNJaXhIT1hIUUI5VEJYRWhE?=
 =?utf-8?B?UUJtYkRxQ1hGdjd2NHY5SjB6MEI5VExKUGgxSWZSZWlrd0ZHb0FaZWI2bnlQ?=
 =?utf-8?B?ZzZsRjFwc0N1S1AvYlVKNGtza25memFXKzRYeWZ6eC9pcnU2ZjV5ekI1aXFq?=
 =?utf-8?B?NFRxUUhEYkQ3YXU4UVY0SUFiZ2NuMzRxS0tuYWp4SlFiWEcycForR2I2dHMx?=
 =?utf-8?B?dlNua2NiWmMxN1VhWUkrRjBjb3pmOEhxemdjTFI2SzNBOE5HeHNoTGRlcGpv?=
 =?utf-8?B?MnFMTzY4TkhtUjNFMGRWdFZDNU4wVXUrV0FCWUxCVXJ2L0NaNytDTlhWUE1l?=
 =?utf-8?B?NU1aMzFUTnVoN08zZEFOV0lydDduUy82NnowbzhvR3I3Z09JMTBYK01wdGRR?=
 =?utf-8?B?Q0FYOCtsV1JtYW1waEdqNGxWOTh0YUg4WlFPQy9aNVJ0ZHh1RUhyaGpGWVFk?=
 =?utf-8?B?QlJuOGt4Z1BZckI1TkZ0aTJodEVKVVZEelFXNXFvVFMxMkhpRG5nM2NZOHB4?=
 =?utf-8?B?cEhkd3NxWkpjbEhYemlhU0RieWp5YTgzaUpNNStHZzg1SjVva2lDa3NkQmpz?=
 =?utf-8?B?V3lWWlJYZnpBQjlndFJFK2t6YUdJb3RhODBZeks3NVh2SHpuSXdSWmV6Vk5K?=
 =?utf-8?B?aHllMmJlSEJaQTROcVBDVFFKMkxjTnUxSGV5WjlYRlpYZmxsTWFnZERsbm91?=
 =?utf-8?B?NHJzUy9qWWJkL2xVeHN6OGtyOFFEQXJjOXRwU1hTOE9QMWl1MDg2dUNsQjFQ?=
 =?utf-8?B?YjkzMEhQcXdWNG91NGVoRTE1YzFOMEVGMk91dzM0OTEvVGVUa3c0bkg3MTl2?=
 =?utf-8?B?SkpWcm1QZ0xzSWFJRHNLQS81TkU2SE80Z2hDWW5TQXYxbjJ6azVNamxkMWNj?=
 =?utf-8?B?eU5kT09QSlcrcnNrUmhVZTZONkQ2TCtFK1ByK05OSiszTTBpOXJpK2srM2J6?=
 =?utf-8?B?Mmp1aGV2azVHWi9reldqc3BuL3E2aEtxeXMzUlJaRmpiQXJITVRoajJRV1hl?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3509cd-98b5-4601-598e-08de1c5956e9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:51:57.7289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPO/9XfvSgfz84bNEAm6z5xqXQ6nuvh7BYqi/s0Ux4iS1cA1vZIGqjBmyFviOuBhZd2TbcV/dToM2qePZRoXLa+mRQYXMoBxmX8a1cWJBWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11282
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

Hi Neha Malcom Francis,

On 11/5/25 11:23 AM, Neha Malcom Francis wrote:
> Add support for fetching config fragments and defconfigs out-of-tree using
> CONFIG_FRAGMENT_PATH and CONFIG_DEFCONFIG_PATH respectively.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   scripts/kconfig/Makefile | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index f0f93c56bdb..051c801eadb 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -12,6 +12,13 @@ PHONY += xconfig gconfig menuconfig config localmodconfig localyesconfig \
>   #  Set SRCARCH to .. fake this Makefile.
>   SRCARCH := ..
>   
> +# If a config fragment file is kept in an out-of-tree path, add it to the list
> +# of paths to be searched within
> +CONFIG_FRAGMENT_PATH ?= $(srctree)/arch/$(SRCARCH)/configs
> +
> +# If a defconfig file is kept in an out-of-tree path, pick it from there
> +CONFIG_DEFCONFIG_PATH ?= $(srctree)/arch/$(SRCARCH)/configs
> +
>   ifdef KBUILD_KCONFIG
>   Kconfig := $(KBUILD_KCONFIG)
>   else
> @@ -93,7 +100,7 @@ endif
>   endif
>   
>   %_defconfig: $(obj)/conf
> -	$(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
> +	$(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(CONFIG_DEFCONFIG_PATH)/$@ -o generated_defconfig
>   	$(Q)sed -i -e 's/^[[:space:]]//' generated_defconfig
>   	$(Q)$< $(silent) --defconfig=generated_defconfig $(Kconfig)
>   
> @@ -103,6 +110,7 @@ endif
>   
>   configfiles=$(wildcard $(srctree)/kernel/configs/$@ \
>   		$(srctree)/arch/$(SRCARCH)/configs/$@ \
> +		$(CONFIG_FRAGMENT_PATH)/$@ \

We have the same path twice if using the default value now, did you mean 
to replace the line just before?

If one uses the same fragment name out-of-tree than in-tree, then the 
in-tree fragment and the out-of-tree fragment will both be applied I 
believe? Is this something we want? If we pass an OOT path, maybe we 
only want to use the OOT ones and not a mix? Additionally, because this 
OOT path is in the middle of in-tree paths, whether this fragment is 
applied first or last depends on the location of the in-tree fragment 
(if in-tree's in a board directory, then OOT applied first, otherwise 
second). Maybe we should rather have it last or first but not in the middle?

Should we have support for multiple paths for fragments? So that people 
can organise their out-of-tree directory of fragments with multiple 
sub-directories (e.g. per-arch or per-board)?

I would recommend NOT prefix your variables with CONFIG_ which is 
usually something reserved for Kconfig options, which isn't what they 
are here.

We probably also should document this new behavior somewhere in the docs.

Cheers,
Quentin
