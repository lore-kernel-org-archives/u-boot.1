Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4F2C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 12:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF54E8186D;
	Mon, 24 Mar 2025 13:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dyIT64oo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 311B88197D; Mon, 24 Mar 2025 13:33:18 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2DA3817EC
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 13:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwpKjSl2AmxlZFautlJQ7B5AdyKjkhQ1fY/Rqn2y3y7PMABMnFlwVBH2cwstrmwzkwhZVwWlBOVZJQbP+uoeMxEGaH1h8t1fDRkI43RppWS3bVMTHtWe4eJw5tVDXR0cUKQLcnHijWphb69TZxpX6i55ntaxTg67+cUncRnPK/CwJqbJNBGJZKqc2VuCHgmuUgwDRxvXSGmv3ZUO9AJbEk4t0T+mpwfSwce0wlJTZlDKov6Soa5XhSLojnOAGgb4Y7JMp9TOf7Gf9qIL0NjFBJuFjXt3H5R8/uB16ks9hr3HBf+w2ZckAtoYIVOrS86fp+IcrtDy01bVX95xq1QmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LAgKTXwYwlf+CBvCMDtJJz9b0AKs5OGzwlmM6I46yQ=;
 b=CRuG/sM7BHCgmn4Bvdc79LfOKZPoOkqqn/4HHn7TG3D/xALC23TslTW5JkM1IVbI70OIL36aD/e7mAHRTUVs3w9aCWKOpgtASYWb6U5heo2JQOrYIMPnSQ4nIF0hoFlSgklH0grhxlI+KLPZWS80qT7tzZ5V2TfeEByx1mFbCBGa8oJMwEKr4Ivw2hmP2ZjWHfR+XPsk0+IHvs0AgzU6JzGPUJN5COM/+E9hb5TkFaYtKECR3SkUdu3TS4Ibn+JMCxw3z4HkN6mCGI9+6Sw1+lU+dlu9weGbTTwehILQZF68D5GsgLZ3wVnOm6MiRdu3hSoMDdAXpzS0102bEXfFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LAgKTXwYwlf+CBvCMDtJJz9b0AKs5OGzwlmM6I46yQ=;
 b=dyIT64oo+H1MQmpb3+MkvniTM4r7IHJYbVLe5o+Z1hnT1VE7MrEtRwhHe3xOS/5wqJ5NxFLeDnER0u5fsWxAmbd7NzxHhpCCpN0dZROgwyRBDex6RRwupsPh1CCu+HzTFHwzMf2P8wUtUzMMv/NI+2xEzqlF/ATv+1QD4PDSk0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 12:33:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 12:33:11 +0000
Message-ID: <de961532-3565-49f1-b205-556684105a11@cherry.de>
Date: Mon, 24 Mar 2025 13:33:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] env: Rename SYS_REDUNDAND_ENVIRONMENT to
 ENV_REDUNDAND_ENVIRONMENT
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250322215624.18994-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df4412c-2824-4bbc-342a-08dd6ad009ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE9CMlRQZzBhM0d4bHhPS3dpeGhGZ09vMjlBSmk0eU9LYi9qa2Q0dUdET0Rj?=
 =?utf-8?B?NE9wRGVCVjhnMGg2ZFhvNEZaUGR4K1RucTAyMkVGOVV5Y3dKbnNjUXlTbHVu?=
 =?utf-8?B?RGpsTk5FOHZaZG50b0ZwOGplWjAzRWZPUXkwb3NFdTZ6MzdlL0w3KythYlEw?=
 =?utf-8?B?WWdWZEd4NCswa3B0VXFZbWR3YzMwRFBBbUZUSEFnbDFpZXhvWkZ0c3hKeTZU?=
 =?utf-8?B?eXgyUFhDYzRhczZkYVF3VS9DZVJjN0NDTGdLWjg5VERuWGlFQkFzLzA3c2xo?=
 =?utf-8?B?NXgwamM3NlBzTkt0MDdNSVZwNHdDL0ZuSHlGbHc0NEkzS2I1UHAwa1k3VkRF?=
 =?utf-8?B?UU1VYVZPdWxDTFlWcklhcjVqdVhiNUcreWlkd3hZd2pNZzMzNC9LZGU5UVBv?=
 =?utf-8?B?UG9FMVRqSDBjZGxDcXN4VUNSV1h6dDZCSzVrY1ExWCtXOXFKc2Q3ZkFDMlhT?=
 =?utf-8?B?QitNbWJ1RzZOeHdvRjM4bGxINVhpVFYyaFozVjZSMGNJQlRML3FvNXRaRS9Z?=
 =?utf-8?B?T2Z6bS9ZZmt4S1VVWlc3a0RMTGFybVdVSUFjamNwMnUyTnBPVmU4OFNWVzA1?=
 =?utf-8?B?bXhja3l5c0tqdm9KZUhRRWpNczZuVG9lWnhFUTJPcjExeEw0MUNoN01wQnFH?=
 =?utf-8?B?RjgwMTRsV3BZR2RzaG5PQUcvWVdsTFBhUGZTZW9XbVlkTFlpMmN2M0E0UXhB?=
 =?utf-8?B?Q2VuN1BvSFF3OW12RFEwT2cwZEhyMEcwdXQ2b09qczB1ZWxXRGJraStmdzlO?=
 =?utf-8?B?TitaZmxUZjJGZDBocVoreDlhY2ltbTZYTU1pV1d6RjZrUUN6RVdseVhPdi9w?=
 =?utf-8?B?eW15eHZ1MmVFdnJZNkFKZUkxWDBQbnpIZEtUT2ljWXlxbkNFTng5cGcxR1lM?=
 =?utf-8?B?ODFudEg3SHN6TFd5dGIwaDFQaWdGdyszdmJqRHFmQmRLVVNRTVRQNEdXcmJm?=
 =?utf-8?B?aDdDTEdtcTczdlB2VTA1K1g5Q0xKVTUxb0JESVJENXZ3UnFDS2xPR0xhZ2Jj?=
 =?utf-8?B?Yyt1bDdid2lKQUFpd2FROEF6Y2FKR2pMVEhTcGJJR3krY3pFYnJRckpSQkpQ?=
 =?utf-8?B?UzZ6Y2JObDJZUW1nby9MRHZqT1RhWUpBM0pGMWtYSGJxUXFhdXREdGx1ZG9m?=
 =?utf-8?B?UkRiR0ZQOTVpUnpQVDFwSlZURVU4RXJ1aUtjRzNmS1RUQ1RUbjduY0o2WUZy?=
 =?utf-8?B?V3MrMVQ1Q0FwNlNlZFRac1J1TTNwclBkTjUyRGp5Y0RDNmI0czRkUUN0czUw?=
 =?utf-8?B?c001VjVlS1c0UHhSREU2QzJsMHdhN1g0bC94NEpWYkhZdWtrTXd1WWNMbkp0?=
 =?utf-8?B?clJYZkF2eFltakZDTUZ2VTYvdlBjRGhQQ3h6eHUraVJ2bXBnVEZIUGJZekxW?=
 =?utf-8?B?dHJZWlMrVnBJbVFCUHJUMVArS0tqK2hBTTFHZ3owWGVIZ3p4bDE2WDdWNkdz?=
 =?utf-8?B?OVlycDlkNy9yak5aUVR5YzNRaG5kaWRHZ2xvY1FlMWQzOU9meEh5Ui92R0pQ?=
 =?utf-8?B?T2xXeGlPZG04bStOYVc4dFZFOVhvV1d6ZVlMNlRBRG5pclVEK2c2N3gybEEv?=
 =?utf-8?B?WWN0SGNPdVovSUV6ZGFBNU16NkJlMEkrRWdGOS9QOVVRYm5aN1pmOGpQSjNn?=
 =?utf-8?B?Q1FkaFdQQUFEdTA0elFPSENZdUlYNGdpMnhBeWwzL1JrQmwrYmlmc0R4RmlV?=
 =?utf-8?B?UU1QM3RwamYwYWQrMlFjaXVFbzgrVlFaNm04OHcrU2I3QjdaTDV1cVJsc3c2?=
 =?utf-8?B?NmR6REw2Y0VQMEo3Z3ExM01BMDZTM29VSTRkN0pLdVRVUHArWW54U3Eva3Y2?=
 =?utf-8?B?SlAvMEtqNG9UU1poc21KWUZYd2F2SUhCY3VlekRCWXJSa1NEOCtwZGRYWlJ2?=
 =?utf-8?Q?7Thv5YeoGkV4h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFU5aDdNNHNmTWNqMWFJRVdXd0JLSU5KbUxRVmpNL25EYlIwOFFJSUhrSXIz?=
 =?utf-8?B?MmlDVmFwYWlvNEsrb2dBZ05aWDNjZXFxL3l0MXl4VkRuUVdVS3dacVI4M1Uy?=
 =?utf-8?B?ODVTQWNDTHhGM1liSDR3ODVKcGJHaWVqaytFVVZrRWUwemJsQ0xCT09FM0R4?=
 =?utf-8?B?Y2l4NTZvdW5yR2pQa2MzVEhvT2dkSVUrMHh6YkdMNE53MmNJV05XVUZWNXBX?=
 =?utf-8?B?d1VnQSt1UFpkT2sxaSt1N2p1aUtNY3BFNFRZN2lldUVEczZIdUpjZklsZUZq?=
 =?utf-8?B?eUZlS3J2KzN1c3I4WCs1YmJ1cnAxY3ZFZk1MVVF4aHB5cnVYT3JBUWpUUzFQ?=
 =?utf-8?B?dEdTejlkTE1BRUNzazZqRTBVS04xbWpYajBSV3VBa0NiVnlSUENkNS9xWko4?=
 =?utf-8?B?VjZEcG12eFNCMm5JK1dLaC9YOG1IZzdEelptU0lEZG40ZFZlTktXSXNlQi9F?=
 =?utf-8?B?S3dJZzhPVnUrek56b1dvQ3NFWUdjclBkM1h0bllmYmVuQ1V6WGYyTmlndDk5?=
 =?utf-8?B?alUzd0EvbmI4TTNqNnZ0bm5DSWlLVHY1TE5tT284TCt1TnFBT0swN2xJYm5C?=
 =?utf-8?B?TGVueVJFeTFoUkxrU2V5S0ptaCtEQ0pwMTdmMmxHcSsvaDZ3dldKREFWVEUr?=
 =?utf-8?B?MW5KSENJMUtyVnRpbkJaUG94allGQWQ3YWZJQVFsQmJnckxmQ2VOeTJPaFJL?=
 =?utf-8?B?alEyMmcwWFV4emhKN2hidURWODJoZXVNNHlqQWpRS2lSak5rYW1OWWp1NXVk?=
 =?utf-8?B?UlZ0MWtkQldzTWcyL25weUQxZlFwN1FSNXNCNG5iTnhDdzVWRWswclE2ZC83?=
 =?utf-8?B?d0k1RDJ2bEhwREVjUCsvNVZMOFdBdG5LYnM3Z2wwT2Q4ZVVaeXJYcXFjdWg0?=
 =?utf-8?B?dlBkenJsZXBGSnRPdWtLbE9KdkRta1QvYzIzaEVFbkRBRUFVd0lTZjQrRDBW?=
 =?utf-8?B?R2RubUhiZ2M0NW1FZDJoZmhoZFZYYU9DNU1hOGFXVXBuektUQmQxZzh1Q3Y4?=
 =?utf-8?B?Z09jWUJNR3RFT3Q1NVc0Ny8wSEVVaGhuMW9XYXJiQmZXd3dxU2ZFWklaU2xx?=
 =?utf-8?B?SXRRKzNPVUQzQzA2dktSOU5NMzE2R1VsM3RpUHlEanp3QVFOOGVqUWZPRUlF?=
 =?utf-8?B?eUMzbU9rRXFsNnZ0WUFNc3V5NHpaZEo2akpCbjBXWjNqeENlWlg1QThzaklo?=
 =?utf-8?B?bzdkSGhUb0IyNUo3a1daUE5sNUlsMGpRbzM2dmF1RVJBbDVpQWpZU1IraXBI?=
 =?utf-8?B?RnFzUDR0a2U4NWg3aTVUTENDeWJlRUVnMG1ub2N1Wm15YnNNbHV6em9nT1JP?=
 =?utf-8?B?VjRKM0o1dllLUlN4OTA2VmttdW4zbEE3Uk43SCtMSXR3Rzd1Y3JvRDlqbUEz?=
 =?utf-8?B?OGhYNGUrdjNoZm1lcGJsR0VDOXZ5T2Z2QXplTitaRFdleVltMzBYZTVvdjgy?=
 =?utf-8?B?dnpjQ095UDloZi9oUlFSU2pyTmtEbndxOEh1QjdlTkQvbC9jTUVxOXAzcUxl?=
 =?utf-8?B?TklITkxFRWhRN2c1dUt4RUJ2YlJuWkFLdHJhWEFkdXNHS0VKR3c5RGxpVitr?=
 =?utf-8?B?QTZlenAyYWRnTzA0a3BmdVM5dGZnaS9MLzRMTWVhUURPV3IzR1VXeStTYmRk?=
 =?utf-8?B?MWtqQ2R0VkkrdUhpV29Id0VCWTZHNkNtZE0vbXFLdFpCZklqY2szMC9hL0dh?=
 =?utf-8?B?RXozQ1lIZEEyN3JHeW9MUG92WC9EL0VLbjB1NTd5cVZvSzcrR3EycmVmVTI0?=
 =?utf-8?B?VCtFRDZUUWFlMkdiRmVvVlVkQklmTjkvaGNLQXhPQzB5bmI1KzJlU0RmNnEz?=
 =?utf-8?B?WWpTbU1tVDlpeG9VOW9YNWFUNGt6T3BOU2gxbzVxZnpoamNJSFh4SzZ5cWN3?=
 =?utf-8?B?Z1EwdUNoRCtSZUI5OGNFYWYyRXRZSUtMVEVyeWxySTdpQklJWDhybmxuTTdq?=
 =?utf-8?B?NWhvWjBqd2J1K2xvODRuY0VtdldPeksyV21YdWRoM0QvNTlkdUNlY3FCWTI0?=
 =?utf-8?B?K2RWQWlDU1NaeSsxR0FFdVUyeW05WDBFQ1BQYmNteWRicDV0NEJOcVVMQkp5?=
 =?utf-8?B?MVpLaUlJSU5Fc0NBOWtkb21sK21ueXlaUk92dFpPSTFxYm5veWtKQ1Q3ODVr?=
 =?utf-8?B?SFVMdU1NdkFaT2tjRE94alU4NjcvVzcrdU0wSGpMcGdvaGRNQk92TzV2TDRC?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df4412c-2824-4bbc-342a-08dd6ad009ea
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 12:33:10.9995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miCch76qkV8YL6sEzK88SiIcvzHkWvegXoBwHi5NYtqI2rs07vwXODkJtLO35U23PKelc2ohwo6B4qUqWpfRCJ+PUS1le1lJ9/r3MHTDQEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991
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

Hi Marek,

On 3/22/25 10:55 PM, Marek Vasut wrote:
> Rename the variable and add ENV_ prefix, so that all configuration
> options which are related to environment would have an CONFIG_ENV_
> prefix. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
[...]
> diff --git a/env/Kconfig b/env/Kconfig
> index a177a354c8b..9ef45a7e3fe 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -463,7 +463,7 @@ config ENV_IS_IN_UBI
>   	  the environment in.  This will enable redundant environments in UBI.
>   	  It is assumed that both volumes are in the same MTD partition.
>   
> -config SYS_REDUNDAND_ENVIRONMENT
> +config ENV_REDUNDAND_ENVIRONMENT

Do either of the following:

1) fix typo: s/REDUNDAND/REDUNDANT/
2) shorten name to be consistent with other symbols and avoid 
"env[...]environment" redundancy: config ENV_REDUND

Cheers,
Quentin
